From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2] iommu/io-pgtable-arm: Don't use dma_to_phys()
Date: Tue, 22 Sep 2015 17:23:16 +0100
Message-ID: <56018074.2010104@arm.com>
References: <59f4ebbf06e75a6176a366495211afd16d0048a3.1442507940.git.robin.murphy@arm.com>
	<1442566550.8145.156.camel@mhfsdcap03> <55FBEFBA.6000606@arm.com>
	<1442928308.17514.3.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1442928308.17514.3.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 22/09/15 14:25, Yong Wu wrote:
[...]
> About here:
>> @@ -629,6 +626,11 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg
> *cfg)
>>        if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
>>                return NULL;
>>   
>> +     if (cfg->iommu_dev->dma_pfn_offset) {
> 
> Do we need change to :
> 	if (!selftest_running && cfg->iommu_dev->dma_pfn_offset) {
> 
> cfg->iommu_dev will be null while self test.

Urgh, you're absolutely right. Must have been one of those days when I
had loads of noisy debug in there and turned the self-tests off :(

Will; since the branch hasn't gone anywhere yet, are you OK to take the below?

Robin.

----->8-----
From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Date: Tue, 22 Sep 2015 14:52:27 +0100
Subject: [PATCH] fixup! iommu/io-pgtable-arm: Don't use dma_to_phys()

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 1f08ce7..2ba2323 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -628,7 +628,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
        if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
                return NULL;
 
-       if (cfg->iommu_dev->dma_pfn_offset) {
+       if (!selftest_running && cfg->iommu_dev->dma_pfn_offset) {
                dev_err(cfg->iommu_dev, "Cannot accommodate DMA offset for IOMMU page tables\n");
                return NULL;
        }
