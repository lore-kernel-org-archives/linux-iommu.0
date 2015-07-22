From: "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 0/5] iommu/arm-smmu: add support for non-pci devices
Date: Wed, 22 Jul 2015 11:00:16 +0800
Message-ID: <55AF0740.3070508@huawei.com>
References: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
	<55AE1F2F.3090106@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <55AE1F2F.3090106-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 2015/7/21 18:30, Robin Murphy wrote:
> On 21/07/15 08:30, Zhen Lei wrote:
>> Changelog:
>> v2 -> v3:
>> 1. add support for pci device hotplug, which missed in patch v2.
>> 2. only support #iommu-cells = <1>, add corresponding description in arm,smmu-v3.txt.
>> 3. add function find_smmu_by_device which extracted from find_smmu_by_node, to resolve
>>     the problem mentioned by Robin Murphy in [PATCH v2 7/9].
>>     Additionally:
>>     +    platform_set_drvdata(pdev, smmu);       //Patch v2
>>     +    dev->archdata.iommu = smmu;             //Patch v3, dev = &pdev->dev
> 
> 
> I didn't give any Reviewed-by tags, much less to revised patches that I've not even looked at yet; please see section 13 of Documentation/SubmittingPatches for what the Reviewed-by tag means.

OK. I see that now. So that Reviewed-by tags should always be given by the reviewer.

I initially thought that "Reviewed-by" should be added for who had reviewed the patch.

> 
> Robin.
> 
>>
>> v1 -> v2:
>> update the implementation of patch 1/9 according to Will Deacon's suggestion.
>> update the comment of patch 3/9 and 4/9.
>> use arm_smmu_options to skip the execution of command CMD_PREFETCH_CONFIG, see patch 5/9.
>> patch 6/9 is base on Laurent's series, to support probe deferral.
>> patch 7/9 according to Robin Murphy's suggestion, remove global variable arm_smmu_devices, thanks.
>> patch 9/9 add support for a master with multiple stream IDs.
>>
>> Zhen Lei (5):
>>    iommu/arm-smmu: to support probe deferral
>>    iommu/arm-smmu: remove arm_smmu_devices
>>    iommu/arm-smmu: rename __arm_smmu_get_pci_sid
>>    iommu/arm-smmu: add support for non-pci devices
>>    iommu/arm-smmu: describe the limitation of #iommu-cells
>>
>>   .../devicetree/bindings/iommu/arm,smmu-v3.txt      |   6 +
>>   drivers/iommu/arm-smmu-v3.c                        | 209 ++++++++++++++++-----
>>   2 files changed, 163 insertions(+), 52 deletions(-)
>>
>> -- 
>> 1.8.0
>>
>>
> 
> 
> .
> 
