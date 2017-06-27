From: Ray Jui via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 0/8] io-pgtable lock removal
Date: Tue, 27 Jun 2017 09:43:19 -0700
Message-ID: <e43ba1fe-696e-fabb-a800-52fadaa2fa93@broadcom.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
	<458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
	<b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
	<cdc1799b-f142-09ed-a7e5-d7fd2e70268f@arm.com>
Reply-To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cdc1799b-f142-09ed-a7e5-d7fd2e70268f-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On 6/20/17 6:37 AM, Robin Murphy wrote:
> On 15/06/17 01:40, Ray Jui wrote:
>> Hi Robin,
>>
>> I have applied this patch series on top of v4.12-rc4, and ran various
>> Ethernet and NVMf target throughput tests on it.
>>
>> To give you some background of my setup:
>>
>> The system is a ARMv8 based system with 8 cores. It has various PCIe
>> root complexes that can be used to connect to PCIe endpoint devices
>> including NIC cards and NVMe SSDs.
>>
>> I'm particularly interested in the performance of the PCIe root complex
>> that connects to the NIC card, and during my test, IOMMU is
>> enabled/disabled against that particular PCIe root complex. The root
>> complexes connected to NVMe SSDs remain unchanged (i.e., without IOMMU).
>>
>> For the Ethernet throughput out of 50G link:
>>
>> Note during the multiple TCP session test, each session will be spread
>> to different CPU cores for optimized performance
>>
>> Without IOMMU:
>>
>> TX TCP x1 - 29.7 Gbps
>> TX TCP x4 - 30.5 Gbps
>> TX TCP x8 - 28 Gbps
>>
>> RX TCP x1 - 15 Gbps
>> RX TCP x4 - 33.7 Gbps
>> RX TCP x8 - 36 Gbps
>>
>> With IOMMU, but without your latest patch:
>>
>> TX TCP x1 - 15.2 Gbps
>> TX TCP x4 - 14.3 Gbps
>> TX TCP x8 - 13 Gbps
>>
>> RX TCP x1 - 7.88 Gbps
>> RX TCP x4 - 13.2 Gbps
>> RX TCP x8 - 12.6 Gbps
>>
>> With IOMMU and your latest patch:
>>
>> TX TCP x1 - 21.4 Gbps
>> TX TCP x4 - 30.5 Gbps
>> TX TCP x8 - 21.3 Gbps
>>
>> RX TCP x1 - 7.7 Gbps
>> RX TCP x4 - 20.1 Gbps
>> RX TCP x8 - 27.1 Gbps
> 
> Cool, those seem more or less in line with expectations. Nate's
> currently cooking a patch to further reduce the overhead when unmapping
> multi-page buffers, which we believe should make up most of the rest of
> the difference.
> 

That's great to hear!

>> With the NVMf target test with 4 SSDs, fio based test, random read, 4k,
>> 8 jobs:
>>
>> Without IOMMU:
>>
>> IOPS = 1080K
>>
>> With IOMMU, but without your latest patch:
>>
>> IOPS = 520K
>>
>> With IOMMU and your latest patch:
>>
>> IOPS = 500K ~ 850K (a lot of variation observed during the same test run)
> 
> That does seem a bit off - are you able to try some perf profiling to
> get a better idea of where the overhead appears to be?
> 

I haven't had any time to look into this closer. But when I have a
chance, I will take a look (but that will not be anytime soon).

>> As you can see, performance has improved significantly with this patch
>> series! That is very impressive!
>>
>> However, it is still off, compared to the test runs without the IOMMU.
>> I'm wondering if more improvement is expected.
>>
>> In addition, a much larger throughput variation is observed in the tests
>> with these latest patches, when multiple CPUs are involved. I'm
>> wondering if that is caused by some remaining lock in the driver?
> 
> Assuming this is the platform with MMU-500, there shouldn't be any locks
> left, since that shouldn't have the hardware ATOS registers for
> iova_to_phys().
> 

Yes, this is with MMU-500.

>> Also, in a few occasions, I observed the following message during the
>> test, when multiple cores are involved:
>>
>> arm-smmu 64000000.mmu: TLB sync timed out -- SMMU may be deadlocked
> 
> That's particularly worrying, because it means we spent over a second
> waiting for something that normally shouldn't take more than a few
> hundred cycles. The only time I've ever actually seen that happen is if
> TLBSYNC is issued while a context fault is pending - on MMU-500 it seems
> that the sync just doesn't proceed until the fault is cleared - but that
> stemmed from interrupts not being wired up correctly (on FPGAs) such
> that we never saw the fault reported in the first place :/
> 
> Robin.
> 

Okay, note the above error is reproduced only when we have a lot of TCP
sessions spread across all 8 CPU cores. It's fairly easy to reproduce in
our system. But I haven't had any time to take a closer look.

I also saw that patchset v2 is out. Based on your reply to other people,
I assume I do not need to test v2 explicitly. If you think there's a
need for me to help test v2, don't hesitate to let me know.

Thanks,

Ray
