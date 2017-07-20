From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/5] iommu/arm-smmu-v3: put off the execution of TLBI* to
	reduce lock confliction
Date: Thu, 20 Jul 2017 15:07:05 -0400
Message-ID: <c1d85f28-c57b-4414-3504-16afb3a19ce0@codeaurora.org>
References: <1498484330-10840-1-git-send-email-thunder.leizhen@huawei.com>
	<1498484330-10840-2-git-send-email-thunder.leizhen@huawei.com>
	<20170628093207.GB11053@arm.com> <5954610F.9020807@huawei.com>
	<cd5b8ec5-f884-450c-df61-45d70bf40b10@huawei.com>
	<20170717222337.0000508f@huawei.com>
	<3cec10c5-82ca-2c54-dfdb-ac73b16e5bc6@codeaurora.org>
	<20170718172055.00006e84@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170718172055.00006e84-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xinwei Hu <huxinwei-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, zhouyoujun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Zefan Li <lizefan-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Tianhong Ding <dingtianhong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Leizhen (ThunderTown)" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jonathan,

[...]
>>>>>      
>>> Hi All,
>>>
>>> I'm a bit of late entry to this discussion.  Just been running some more
>>> detailed tests on our d05 boards and wanted to bring some more numbers to
>>> the discussion.
>>>
>>> All tests against 4.12 with the following additions:
>>> * Robin's series removing the io-pgtable spinlock (and a few recent fixes)
>>> * Cherry picked updates to the sas driver, merged prior to 4.13-rc1
>>> * An additional HNS (network card) bug fix that will be upstreamed shortly.
>>>
>>> I've broken the results down into this patch and this patch + the remainder
>>> of the set. As leizhen mentioned we got a nice little performance
>>> bump from Robin's series so that was applied first (as it's in mainline now)
>>>
>>> SAS tests were fio with noop scheduler, 4k block size and various io depths
>>> 1 process per disk.  Note this is probably a different setup to leizhen's
>>> original numbers.
>>>
>>> Precentages are off the performance seen with the smmu disabled.
>>> SAS
>>> 4.12 - none of this series.
>>> SMMU disabled
>>> read io-depth 32 -   384K IOPS (100%)
>>> read io-depth 2048 - 950K IOPS (100%)
>>> rw io-depth 32 -     166K IOPS (100%)
>>> rw io-depth 2048 -   340K IOPS (100%)
>>>
>>> SMMU enabled
>>> read io-depth 32 -   201K IOPS (52%)
>>> read io-depth 2048 - 306K IOPS (32%)
>>> rw io-depth 32 -     99K  IOPS (60%)
>>> rw io-depth 2048 -   150K IOPS (44%)
>>>
>>> Robin's recent series with fixes as seen on list (now merged)
>>> SMMU enabled.
>>> read io-depth 32 -   208K IOPS (54%)
>>> read io-depth 2048 - 335K IOPS (35%)
>>> rw io-depth 32 -     105K IOPS (63%)
>>> rw io-depth 2048 -   165K IOPS (49%)
>>>
>>> 4.12 + Robin's series + just this patch SMMU enabled
>>>
>>> (iommu/arm-smmu-v3: put of the execution of TLBI* to reduce lock conflict)
>>>
>>> read io-depth 32 -   225K IOPS (59%)
>>> read io-depth 2048 - 365K IOPS (38%)
>>> rw io-depth 32 -     110K IOPS (66%)
>>> rw io-depth 2048 -   179K IOPS (53%)
>>>
>>> 4.12 + Robin's series + Second part of this series
>>>
>>> (iommu/arm-smmu-v3: put of the execution of TLBI* to reduce lock conflict)
>>> (iommu: add a new member unmap_tlb_sync into struct iommu_ops)
>>> (iommu/arm-smmu-v3: add supprot for unmap an iova range with only on tlb sync)
>>> (iommu/arm-smmu: add support for unmap of a memory range with only one tlb sync)
>>>
>>> read io-depth 32 -    225K IOPS (59%)
>>> read io-depth 2048 -  833K IOPS (88%)
>>> rw io-depth 32 -      112K IOPS (67%)
>>> rw io-depth 2048 -    220K IOPS (65%)
>>>
>>> Robin's series gave us small gains across the board (3-5% recovered)
>>> relative to the no smmu performance (which we are taking as the ideal case)
>>>
>>> This first patch gets us back another 2-5% of the no smmu performance
>>>
>>> The next few patches get us very little advantage on the small io-depths
>>> but make a large difference to the larger io-depths - in particular the
>>> read IOPS which is over twice as fast as without the series.
>>>
>>> For HNS it seems that we are less dependent on the SMMU performance and
>>> can reach the non SMMU speed.
>>>
>>> Tests with
>>> iperf -t 30 -i 10 -c IPADDRESS -P 3 last 10 seconds taken to avoid any
>>> initial variability.
>>>
>>> The server end of the link was always running with smmu v3 disabled
>>> so as to act as a fast sink of the data. Some variation seen across
>>> repeat runs.
>>>
>>> Mainline v4.12 + network card fix
>>> NO SMMU
>>> 9.42 GBits/sec
>>>
>>> SMMU
>>> 4.36 GBits/sec (46%)
>>>
>>> Robin's io-pgtable spinlock series
>>>
>>> 6.68 to 7.34 (71% - 78% variation across runs)
>>>
>>> Just this patch SMMU enabled
>>>
>>> (iommu/arm-smmu-v3: put of the execution of TLBI* to reduce lock conflict)
>>>
>>> 7.96-8.8 GBits/sec (85% - 94%  some variation across runs)
>>>
>>> Full series
>>>
>>> (iommu/arm-smmu-v3: put of the execution of TLBI* to reduce lock conflict)
>>> (iommu: add a new member unmap_tlb_sync into struct iommu_ops)
>>> (iommu/arm-smmu-v3: add supprot for unmap an iova range with only on tlb sync)
>>> (iommu/arm-smmu: add support for unmap of a memory range with only one tlb sync)
>>>
>>> 9.42 GBits/Sec (100%)
>>>
>>> So HNS test shows a greater boost from Robin's series and this first patch.
>>> This is most likely because the HNS test is not putting as high a load on
>>> the SMMU and associated code as the SAS test.
>>>
>>> In both cases however, this shows that both parts of this patch
>>> series are beneficial.
>>>
>>> So on to the questions ;)
>>>
>>> Will, you mentioned that along with Robin and Nate you were working on
>>> a somewhat related strategy to improve the performance.  Any ETA on that?
>>
>> The strategy I was working on is basically equivalent to the second
>> part of the series. I will test your patches out sometime this week, and
>> I'll also try to have our performance team run it through their whole
>> suite.
> 
> Thanks, that's excellent.  Look forward to hearing how it goes.

I tested the patches with 4 NVME drives connected to a single SMMU and
the results seem to be inline with those you've reported.

FIO - 512k blocksize / io-depth 32 / 1 thread per drive
  Baseline 4.13-rc1 w/SMMU enabled: 25% of SMMU bypass performance
  Baseline + Patch 1              : 28%
  Baseline + Patches 2-5          : 86%
  Baseline + Complete series      : 100% [!!]

I saw performance improvements across all of the other FIO profiles I
tested, although not always as substantial as was seen in the 512k/32/1
case. The performance of some of the profiles, especially those with
many threads per drive, remains woeful (often below 20%), but hopefully
Robin's iova series will help improve that.

> 
> Particularly useful would be to know if there are particular performance tests
> that show up anything interesting that we might want to replicate.
> 
> Jonathan and Leizhen
>>
>>>
>>> As you might imagine, with the above numbers we are very keen to try and
>>> move forward with this as quickly as possible.
>>>
>>> If you want additional testing we would be happy to help.
>>>
>>> Thanks,
>>>
>>> Jonathan
[...]

-Nate

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
