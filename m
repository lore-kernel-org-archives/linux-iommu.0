From: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 6/8] iommu/arm-smmu: add support for non-pci devices
Date: Tue, 30 Jun 2015 16:51:23 +0800
Message-ID: <5592588B.9090706@huawei.com>
References: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
	<1435307584-9812-7-git-send-email-thunder.leizhen@huawei.com>
	<20150629172831.GL17474@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150629172831.GL17474-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2015/6/30 1:28, Will Deacon wrote:
> On Fri, Jun 26, 2015 at 09:33:02AM +0100, Zhen Lei wrote:
>> Now, we only support a master with only one stream id. It will cover most
>> hardware platforms and coding so easy.
>>
>> Please refer Documentation\devicetree\bindings\iommu\iommu.txt on how to
>> bind device tree.
> 
> Can you build this on top of Laurent's series, please?
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/343686.html

Sorry, I have a meeting for a long time. So my email writing was interrupted.

Because Laurent's series has not been upstreamed. So this patch can not work correctly
after patched Laurent's series. It should modified slightly as below:
Should I merge these two patches as one after Laurent's series, or send two times
(one before Laurent's series, and one after). What's your opinion?

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 2e09f10..c940522 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1953,7 +1953,7 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
        dev->archdata.of_smmu = args->np;
        dev->archdata.sid = args->args[0];

-   return 0;
+ return arm_smmu_add_device(dev);
 }

 static struct iommu_ops arm_smmu_ops = {
@@ -1966,7 +1966,6 @@ static struct iommu_ops arm_smmu_ops = {
        .map                    = arm_smmu_map,
        .unmap                  = arm_smmu_unmap,
        .iova_to_phys           = arm_smmu_iova_to_phys,
-   .add_device             = arm_smmu_add_device,
        .remove_device          = arm_smmu_remove_device,
        .domain_get_attr        = arm_smmu_domain_get_attr,
        .domain_set_attr        = arm_smmu_domain_set_attr,


> 
> Will
> 
> .
> 
