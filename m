From: Ray Jui via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH 0/8] io-pgtable lock removal
Date: Wed, 14 Jun 2017 17:40:30 -0700
Message-ID: <b7830be1-9a78-e29f-a29c-4798aaa28c0a@broadcom.com>
References: <cover.1496921366.git.robin.murphy@arm.com>
	<458ad41d-6679-eeca-3c0f-13ccb6c933b6@codeaurora.org>
Reply-To: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <458ad41d-6679-eeca-3c0f-13ccb6c933b6-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sunil.goutham-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

I have applied this patch series on top of v4.12-rc4, and ran various
Ethernet and NVMf target throughput tests on it.

To give you some background of my setup:

The system is a ARMv8 based system with 8 cores. It has various PCIe
root complexes that can be used to connect to PCIe endpoint devices
including NIC cards and NVMe SSDs.

I'm particularly interested in the performance of the PCIe root complex
that connects to the NIC card, and during my test, IOMMU is
enabled/disabled against that particular PCIe root complex. The root
complexes connected to NVMe SSDs remain unchanged (i.e., without IOMMU).

For the Ethernet throughput out of 50G link:

Note during the multiple TCP session test, each session will be spread
to different CPU cores for optimized performance

Without IOMMU:

TX TCP x1 - 29.7 Gbps
TX TCP x4 - 30.5 Gbps
TX TCP x8 - 28 Gbps

RX TCP x1 - 15 Gbps
RX TCP x4 - 33.7 Gbps
RX TCP x8 - 36 Gbps

With IOMMU, but without your latest patch:

TX TCP x1 - 15.2 Gbps
TX TCP x4 - 14.3 Gbps
TX TCP x8 - 13 Gbps

RX TCP x1 - 7.88 Gbps
RX TCP x4 - 13.2 Gbps
RX TCP x8 - 12.6 Gbps

With IOMMU and your latest patch:

TX TCP x1 - 21.4 Gbps
TX TCP x4 - 30.5 Gbps
TX TCP x8 - 21.3 Gbps

RX TCP x1 - 7.7 Gbps
RX TCP x4 - 20.1 Gbps
RX TCP x8 - 27.1 Gbps

With the NVMf target test with 4 SSDs, fio based test, random read, 4k,
8 jobs:

Without IOMMU:

IOPS = 1080K

With IOMMU, but without your latest patch:

IOPS = 520K

With IOMMU and your latest patch:

IOPS = 500K ~ 850K (a lot of variation observed during the same test run)

As you can see, performance has improved significantly with this patch
series! That is very impressive!

However, it is still off, compared to the test runs without the IOMMU.
I'm wondering if more improvement is expected.

In addition, a much larger throughput variation is observed in the tests
with these latest patches, when multiple CPUs are involved. I'm
wondering if that is caused by some remaining lock in the driver?

Also, in a few occasions, I observed the following message during the
test, when multiple cores are involved:

arm-smmu 64000000.mmu: TLB sync timed out -- SMMU may be deadlocked

Thanks,

Ray

On 6/9/17 12:28 PM, Nate Watterson wrote:
> Hi Robin,
> 
> On 6/8/2017 7:51 AM, Robin Murphy wrote:
>> Hi all,
>>
>> Here's the cleaned up nominally-final version of the patches everybody's
>> keen to see. #1 is just a non-critical thing-I-spotted-in-passing fix,
>> #2-#4 do some preparatory work (and bid farewell to everyone's least
>> favourite bit of code, hooray!), and #5-#8 do the dirty deed itself.
>>
>> The branch I've previously shared has been updated too:
>>
>>    git://linux-arm.org/linux-rm  iommu/pgtable
>>
>> All feedback welcome, as I'd really like to land this for 4.13.
>>
> 
> I tested the series on a QDF2400 development platform and see notable
> performance improvements particularly in workloads that make concurrent
> accesses to a single iommu_domain.
> 
>> Robin.
>>
>>
>> Robin Murphy (8):
>>    iommu/io-pgtable-arm-v7s: Check table PTEs more precisely
>>    iommu/io-pgtable-arm: Improve split_blk_unmap
>>    iommu/io-pgtable-arm-v7s: Refactor split_blk_unmap
>>    iommu/io-pgtable: Introduce explicit coherency
>>    iommu/io-pgtable-arm: Support lockless operation
>>    iommu/io-pgtable-arm-v7s: Support lockless operation
>>    iommu/arm-smmu: Remove io-pgtable spinlock
>>    iommu/arm-smmu-v3: Remove io-pgtable spinlock
>>
>>   drivers/iommu/arm-smmu-v3.c        |  36 ++-----
>>   drivers/iommu/arm-smmu.c           |  48 ++++------
>>   drivers/iommu/io-pgtable-arm-v7s.c | 173
>> +++++++++++++++++++++------------
>>   drivers/iommu/io-pgtable-arm.c     | 190
>> ++++++++++++++++++++++++-------------
>>   drivers/iommu/io-pgtable.h         |   6 ++
>>   5 files changed, 268 insertions(+), 185 deletions(-)
>>
> 
