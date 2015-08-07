From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 2/3] arm64: Add IOMMU dma_ops
Date: Fri, 07 Aug 2015 16:27:56 +0100
Message-ID: <55C4CE7C.7050205@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
	<8a5abd0a9929aae160ccb74d7a8d9c3698f61910.1438362603.git.robin.murphy@arm.com>
	<20150807085233.GV14980@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150807085233.GV14980-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/08/15 09:52, Joerg Roedel wrote:
> On Fri, Jul 31, 2015 at 06:18:28PM +0100, Robin Murphy wrote:
>> +/*
>> + * TODO: Right now __iommu_setup_dma_ops() gets called too early to do
>> + * everything it needs to - the device isn't yet fully created, and the
>> + * IOMMU driver hasn't seen it yet, so we need this delayed attachment
>> + * dance. Once IOMMU probe ordering is sorted to move the
>> + * arch_setup_dma_ops() call later, all the notifier bits below become
>> + * unnecessary, and will go away.
>> + */
>> +struct iommu_dma_notifier_data {
>> +	struct list_head list;
>> +	struct device *dev;
>> +	struct iommu_domain *dma_domain;
>> +};
>> +static LIST_HEAD(iommu_dma_masters);
>> +static DEFINE_MUTEX(iommu_dma_notifier_lock);
>
> Ugh, thats incredibly ugly. Why can't you do the setup work then the
> iommu driver sees the device? Just call the dma-api setup functions
> there (like the x86 iommu drivers do it too) and be done without any
> notifiers.

As per the comments, the issue here lies in the order in which the 
OF/driver core code currently calls things for platform devices: as it 
stands we can't attach the device to a domain in arch_setup_dma_ops() 
because it doesn't have a group, and we can't even add it to a group 
ourselves because it isn't fully created and doesn't exist in sysfs yet. 
The only reason arch/arm is currently getting away without this 
workaround is that the few IOMMU drivers there hooked up to the generic 
infrastructure don't actually mind that they get an attach_device from 
arch_setup_dma_ops() before they've even seen an add_device (largely 
because they don't care about groups).

Laurent's probe-deferral series largely solves these problems in the 
right place - adding identical boilerplate code to every IOMMU driver to 
do something they shouldn't have to know about (and don't necessarily 
have all the right information for) is exactly what we don't want to do. 
As discussed over on another thread, I'm planning to pick that series up 
and polish it off after this, but my top priority is getting the basic 
dma_ops functionality into arm64 that people need right now. I will be 
only too happy when I can submit the patch removing this notifier 
workaround ;)

>> +static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>> +				  const struct iommu_ops *ops)
>> +{
>> +	struct iommu_domain *domain;
>> +	int err;
>> +
>> +	if (!ops)
>> +		return;
>> +	/*
>> +	 * In a perfect world, everything happened in the right order up to
>> +	 * here, and the IOMMU core has already attached the device to an
>> +	 * appropriate default domain for us to set up...
>> +	 */
>> +	domain = iommu_get_domain_for_dev(dev);
>> +	if (!domain) {
>> +		/*
>> +		 * Urgh. Reliable default domains for platform devices can't
>> +		 * happen anyway without some sensible way of handling
>> +		 * non-trivial groups. So until then, HORRIBLE HACKS!
>> +		 */
>
> I don't get this, what is preventing to rely on default domains here?

No driver other than the AMD IOMMU has any support yet. Support for 
IOMMU_DOMAIN_DMA can easily be added to existing drivers based on patch 
1 of this series, but more generally it's not entirely clear how default 
domains are going to work beyond x86. On systems like Juno or Seattle 
with different sets of masters behind different IOMMU instances (with 
limited domain contexts each), the most sensible approach would be to 
have a single default domain per IOMMU (spanning domains across 
instances would need some hideous synchronisation logic for some 
implementations), but the current domain_alloc interface gives us no way 
to do that. On something like RK3288 with two different types of IOMMU 
on the platform "bus", it breaks down even further as there's no way to 
guarantee that iommu_domain_alloc() even gives you a domain from the 
right *driver* (hence bypassing it by going through ops directly here).

>
>> +		domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
>
> The IOMMU core should already tried to allocate an IOMMU_DOMAIN_DMA type
> domain. No need to try this again here.

Only for PCI devices, via iommu_group_get_for_pci_dev(). The code here, 
however, only runs for platform devices - ops will be always null for a 
PCI device since of_iommu_configure() will have bailed out (see the 
silly warning removed by my patch you picked up the other day). Once 
iommu_group_get_for_dev() supports platform devices, this too can go 
away. In the meantime if someone adds PCI support to 
of_iommu_configure() and IOMMU_DOMAIN_DMA support to their IOMMU driver, 
then we'll get a domain back from iommu_get_domain_for_dev() and just 
use that.

Robin.
