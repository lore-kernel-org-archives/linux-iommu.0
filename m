From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 2/3] arm64: Add IOMMU dma_ops
Date: Wed, 7 Oct 2015 17:36:24 +0100
Message-ID: <56154A08.6060207@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
	<80cb035144a2648a5d94eb1fec3336f17ad249f1.1443718557.git.robin.murphy@arm.com>
	<CAAhSdy2tpAfH+i=1axDkmRqZixsbVhd-_9VGvpyQ=5e06v=Kpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAAhSdy2tpAfH+i=1axDkmRqZixsbVhd-_9VGvpyQ=5e06v=Kpg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Anup Patel <anup-aa5cPYPs4nSSZfiimGR9Ow@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Anup Patel <anup.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 07/10/15 10:03, Anup Patel wrote:
[...]
>> +static bool do_iommu_attach(struct device *dev, const struct iommu_ops *ops,
>> +                          u64 dma_base, u64 size)
>> +{
>> +       struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +       /*
>> +        * Best case: The device is either part of a group which was
>> +        * already attached to a domain in a previous call, or it's
>> +        * been put in a default DMA domain by the IOMMU core.
>> +        */
>> +       if (!domain) {
>> +               /*
>> +                * Urgh. The IOMMU core isn't going to do default domains
>> +                * for non-PCI devices anyway, until it has some means of
>> +                * abstracting the entirely implementation-specific
>> +                * sideband data/SoC topology/unicorn dust that may or
>> +                * may not differentiate upstream masters.
>> +                * So until then, HORRIBLE HACKS!
>> +                */
>> +               domain = ops->domain_alloc(IOMMU_DOMAIN_DMA);
>> +               if (!domain)
>> +                       goto out_no_domain;
>> +
>> +               domain->ops = ops;
>> +               domain->type = IOMMU_DOMAIN_DMA | __IOMMU_DOMAIN_FAKE_DEFAULT;
>
> We require iommu_get_dma_cookie(domain) here. If we dont
> allocate iommu cookie then iommu_dma_init_domain() will fail.

The iova cookie is tightly coupled with the domain, so it really only 
makes sense for the IOMMU driver to deal with it as part of its 
domain_alloc/domain_free callbacks.

Doing that here was one of the nastier 'compatibility' hacks which I've 
now taken out; trying to make things work without modifying existing 
IOMMU drivers was just too impractical. Drivers which want to play are 
now required to support the IOMMU_DOMAIN_DMA type appropriately, but 
it's still only a minimal change, as per the example diff for the ARM 
SMMU driver below (big pile of further patches necessary to make said 
driver compatible in other respects notwithstanding).

Robin.

--->8---
@@ -29,6 +29,7 @@
  #define pr_fmt(fmt) "arm-smmu: " fmt

  #include <linux/delay.h>
+#include <linux/dma-iommu.h>
  #include <linux/dma-mapping.h>
  #include <linux/err.h>
  #include <linux/interrupt.h>
@@ -973,7 +974,7 @@ static struct iommu_domain 
*arm_smmu_domain_alloc(unsigned type)
  {
  	struct arm_smmu_domain *smmu_domain;

-	if (type != IOMMU_DOMAIN_UNMANAGED)
+	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
  		return NULL;
  	/*
  	 * Allocate the domain and initialise some of its data structures.
@@ -984,6 +985,12 @@ static struct iommu_domain 
*arm_smmu_domain_alloc(unsigned type)
  	if (!smmu_domain)
  		return NULL;

+	if (type == IOMMU_DOMAIN_DMA &&
+	    iommu_get_dma_cookie(&smmu_domain->domain)) {
+		kfree(smmu_domain);
+		return NULL;
+	}
+
  	mutex_init(&smmu_domain->init_mutex);
  	spin_lock_init(&smmu_domain->pgtbl_lock);

@@ -998,6 +1005,7 @@ static void arm_smmu_domain_free(struct 
iommu_domain *domain)
  	 * Free the domain resources. We assume that all devices have
  	 * already been detached.
  	 */
+	iommu_put_dma_cookie(domain);
  	arm_smmu_destroy_domain_context(domain);
  	kfree(smmu_domain);
  }
