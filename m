From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 19/20] iommu/tegra: gart: Simplify clients-tracking
 code
Date: Mon, 24 Sep 2018 20:50:35 +0300
Message-ID: <aefb6b78-4923-0259-0f3a-2ce3b95ca456@gmail.com>
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-20-digetx@gmail.com> <20180924111047.GP21032@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924111047.GP21032@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 9/24/18 2:10 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:52AM +0300, Dmitry Osipenko wrote:
>> GART is a simple IOMMU provider that has single address space. There is
>> no need to setup global clients list and manage it for tracking of the
>> active domain, hence lot's of code could be safely removed and replaced
>> with a simpler alternative.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 157 +++++++++----------------------------
>>  1 file changed, 39 insertions(+), 118 deletions(-)
>>
>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 306e9644a676..7182445c3b76 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -19,7 +19,6 @@
>>  
>>  #include <linux/io.h>
>>  #include <linux/iommu.h>
>> -#include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>> @@ -42,30 +41,20 @@
>>  #define GART_PAGE_MASK						\
>>  	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
>>  
>> -struct gart_client {
>> -	struct device		*dev;
>> -	struct list_head	list;
>> -};
>> -
>>  struct gart_device {
>>  	void __iomem		*regs;
>>  	u32			*savedata;
>>  	u32			page_count;	/* total remappable size */
>>  	dma_addr_t		iovmm_base;	/* offset to vmm_area */
>>  	spinlock_t		pte_lock;	/* for pagetable */
>> -	struct list_head	client;
>> -	spinlock_t		client_lock;	/* for client list */
>> +	spinlock_t		dom_lock;	/* for active domain */
>> +	unsigned int		active_devices;	/* number of active devices */
>>  	struct iommu_domain	*active_domain;	/* current active domain */
>>  	struct device		*dev;
>>  
>>  	struct iommu_device	iommu;		/* IOMMU Core handle */
>>  };
>>  
>> -struct gart_domain {
>> -	struct iommu_domain domain;		/* generic domain handle */
>> -	struct gart_device *gart;		/* link to gart device   */
>> -};
>> -
>>  static struct gart_device *gart_handle; /* unique for a system */
>>  
>>  static bool gart_debug;
>> @@ -73,11 +62,6 @@ static bool gart_debug;
>>  #define GART_PTE(_pfn)						\
>>  	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
>>  
>> -static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
>> -{
>> -	return container_of(dom, struct gart_domain, domain);
>> -}
>> -
>>  /*
>>   * Any interaction between any block on PPSB and a block on APB or AHB
>>   * must have these read-back to ensure the APB/AHB bus transaction is
>> @@ -166,128 +150,69 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
>>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
>>  				 struct device *dev)
>>  {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>>  	struct gart_device *gart = gart_handle;
>> -	struct gart_client *client, *c;
>> -	int err = 0;
>> -
>> -	client = kzalloc(sizeof(*c), GFP_KERNEL);
>> -	if (!client)
>> -		return -ENOMEM;
>> -	client->dev = dev;
>> -
>> -	spin_lock(&gart->client_lock);
>> -	list_for_each_entry(c, &gart->client, list) {
>> -		if (c->dev == dev) {
>> -			dev_err(gart->dev, "GART: %s is already attached\n",
>> -				dev_name(dev));
>> -			err = -EINVAL;
>> -			goto fail;
>> -		}
>> -	}
>> -	if (gart->active_domain && gart->active_domain != domain) {
>> -		dev_err(gart->dev,
>> -			"GART: Only one domain can be active at a time\n");
>> -		err = -EINVAL;
>> -		goto fail;
>> -	}
>> -	gart->active_domain = domain;
>> -	gart_domain->gart = gart;
>> -	list_add(&client->list, &gart->client);
>> -	spin_unlock(&gart->client_lock);
>> -	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
>> -	return 0;
>> +	int ret = 0;
>>  
>> -fail:
>> -	kfree(client);
>> -	spin_unlock(&gart->client_lock);
>> -	return err;
>> -}
>> +	spin_lock(&gart->dom_lock);
>>  
>> -static void __gart_iommu_detach_dev(struct iommu_domain *domain,
>> -				    struct device *dev)
>> -{
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>> -	struct gart_client *c;
>> -
>> -	list_for_each_entry(c, &gart->client, list) {
>> -		if (c->dev == dev) {
>> -			list_del(&c->list);
>> -			kfree(c);
>> -			if (list_empty(&gart->client)) {
>> -				gart->active_domain = NULL;
>> -				gart_domain->gart = NULL;
>> -			}
>> -			dev_dbg(gart->dev, "GART: Detached %s\n",
>> -				dev_name(dev));
>> -			return;
>> -		}
>> +	if (gart->active_domain && gart->active_domain != domain) {
>> +		ret = -EBUSY;
> 
> This omits the error message and returns -EBUSY instead of -EINVAL. Was
> this intended? For what it's worth, I do agree with the changes, it's
> just that I think you could've made those in the earlier patch that
> introduced them.

The message isn't really needed and EBUSY seems fit better than EINVAL here.

> But this is all one series and the end result looks fine, so no need to
> be that picky.

Good, thanks.

>> +	} else if (dev->archdata.iommu != domain) {
>> +		dev->archdata.iommu = domain;
>> +		gart->active_domain = domain;
>> +		gart->active_devices++;
>>  	}
>>  
>> -	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
>> -		dev_name(dev));
>> +	spin_unlock(&gart->dom_lock);
>> +
>> +	return ret;
>>  }
>>  
>>  static void gart_iommu_detach_dev(struct iommu_domain *domain,
>>  				  struct device *dev)
>>  {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>> +	struct gart_device *gart = gart_handle;
>> +
>> +	spin_lock(&gart->dom_lock);
>>  
>> -	spin_lock(&gart->client_lock);
>> -	__gart_iommu_detach_dev(domain, dev);
>> -	spin_unlock(&gart->client_lock);
>> +	if (dev->archdata.iommu == domain) {
>> +		dev->archdata.iommu = NULL;
>> +
>> +		if (--gart->active_devices == 0)
>> +			gart->active_domain = NULL;
>> +	}
>> +
>> +	spin_unlock(&gart->dom_lock);
>>  }
>>  
>>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>>  {
>> -	struct gart_domain *gart_domain;
>> -	struct gart_device *gart;
>> +	struct gart_device *gart = gart_handle;
>> +	struct iommu_domain *domain;
>>  
>>  	if (type != IOMMU_DOMAIN_UNMANAGED)
>>  		return NULL;
>>  
>> -	gart = gart_handle;
>> -	if (!gart)
>> -		return NULL;
>> -
>> -	gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
>> -	if (!gart_domain)
>> -		return NULL;
>> -
>> -	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
>> -	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
>> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>> +	if (domain) {
>> +		domain->geometry.aperture_start = gart->iovmm_base;
>> +		domain->geometry.aperture_end = gart->iovmm_base +
>>  					gart->page_count * GART_PAGE_SIZE - 1;
>> -	gart_domain->domain.geometry.force_aperture = true;
>> +		domain->geometry.force_aperture = true;
>> +	}
>>  
>> -	return &gart_domain->domain;
>> +	return domain;
>>  }
>>  
>>  static void gart_iommu_domain_free(struct iommu_domain *domain)
>>  {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>> -
>> -	if (gart) {
>> -		spin_lock(&gart->client_lock);
>> -		if (!list_empty(&gart->client)) {
>> -			struct gart_client *c, *tmp;
>> -
>> -			list_for_each_entry_safe(c, tmp, &gart->client, list)
>> -				__gart_iommu_detach_dev(domain, c->dev);
>> -		}
>> -		spin_unlock(&gart->client_lock);
>> -	}
>> -
>> -	kfree(gart_domain);
>> +	kfree(domain);
>>  }
> 
> Doesn't this now make it possible to free a potentially active domain?

Yes, don't do it. I can add a WARN_ON() here, though I think IOMMU core
should be the one taking care about that.

>>  
>>  static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>>  			  phys_addr_t pa, size_t bytes, int prot)
>>  {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>> +	struct gart_device *gart = gart_handle;
> 
> Hmm... this now introduces more uses of the gart_handle that I hoped we
> could get rid of. I think we could still keep around struct gart_domain
> and just make sure it is unique. The small amounts of casting here seem
> mostly harmless to me, especially since they will be nops, so we end up
> with just one dereference to get at the struct gart_device. I think the
> benefits of not having this global variable around are worth the one
> dereference here.

What are the benefits? I don't see anything other than the pedantic oddity.

I've removed gart_domain in the end because it is an extra code (and
consumed resources) without any benefit. Let's keep that part as it is
now. I'll be happy to change that code if you'll explain why it is worth
it.
