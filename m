From: leizhen <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 9/9] iommu/arm-smmu: add support for non-pci devices
Date: Fri, 10 Jul 2015 08:34:31 +0800
Message-ID: <559F1317.70200@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
	<1436239822-14132-10-git-send-email-thunder.leizhen@huawei.com>
	<559D240F.2090002@arm.com> <559DD4B6.9000403@huawei.com>
	<559E6289.6060802@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <559E6289.6060802-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 2015/7/9 20:01, Robin Murphy wrote:
> On 09/07/15 02:56, leizhen wrote:
> [...]
>>>> @@ -1928,9 +1929,35 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
> [...]
>>>> +        for (i = 0; i < args->args_count; i++) {
>>>
>>> I'm dubious of the value of looping here - having n>1 #iommu-cells per phandle means that every platform device behind one SMMU must have the same number of stream IDs, or you still have to have
>>> repeated phandles for every device with some greater multiple of n stream IDs each, but ruling out any device with <n. I'm not sure how realistic that is, and whether there's any real benefit beyond
>>> saving a handful of bytes in the DTB.
>>
>> As you mentioned before, a master with two streamIDs can be written as below(This is also mentioned in Documentation\devicetree\bindings\iommu\iommu.txt):
>> #iommu-cells = <1>;
>> iommus = <&{/iommu} 23>, <&{/iommu} 24>;
>>
>> On my hardware platform, a master only have one streamID. But I tested two cases:
>> #iommu-cells = <1>;
>> 1. iommus = <&smmu0 good-sid>, <&smmu0 bad-sid>;
>> 2. iommus = <&smmu0 bad-sid>, <&smmu0 good-sid>;
>> All of these two cases worked well.
>>
>> Well, if each master contains two streamIDs(or more but equal), this for loop is needed.
> 
> My point is that args_count == #iommu-cells here. If you mandate #iommu-cells == 1 as per your example (which in my opinion *is* the right thing to do), then looping over something which is guaranteed
> to be a single item is pointless.
> 
> You'd only need the loop if args_count > 1, for example:
> 
>     #iommu-cells = <2>;
>     1: iommus = <&smmu0 sid1 sid2>;
>     2: iommus = <&smmu0 sid1 sid2>, <&smmu0 sid3 sid4>;
> 
> but then you'd be also stuck describing any device with an odd number of stream IDs on that SMMU:
> 
>     3: iommus = <&smmu0 sid1 what-do-I-put-here?>;
> 
> which is why I don't think it's worth trying to accommodate anything other than #iommu-cells == 1, and for that case you know you will only ever have to deal with args[0] in each of_xlate() call.

OK, I will consider it in v3.

> 
> Robin.
> 
> 
> .
> 
