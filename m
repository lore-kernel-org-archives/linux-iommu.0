From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [RESEND,3/3] iommu/dma: Plumb in the per-CPU IOVA caches
Date: Fri, 7 Apr 2017 03:22:24 -0400
Message-ID: <6af07882-d625-f73c-70d8-5fbe81ec04a2@codeaurora.org>
References: <fcb9121e608da4f62e21538f558710fbb12d4a69.1490971180.git.robin.murphy@arm.com>
	<alpine.DEB.2.20.1704061315040.4602@lazy>
	<c43b1f8f-02fd-978c-0dee-cc3f76a9924b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c43b1f8f-02fd-978c-0dee-cc3f76a9924b-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Manoj Iyer <manoj.iyer-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,
On 4/6/2017 2:56 PM, Robin Murphy wrote:
> On 06/04/17 19:15, Manoj Iyer wrote:
>> On Fri, 31 Mar 2017, Robin Murphy wrote:
>>
>>> With IOVA allocation suitably tidied up, we are finally free to opt in
>>> to the per-CPU caching mechanism. The caching alone can provide a modest
>>> improvement over walking the rbtree for weedier systems (iperf3 shows
>>> ~10% more ethernet throughput on an ARM Juno r1 constrained to a single
>>> 650MHz Cortex-A53), but the real gain will be in sidestepping the rbtree
>>> lock contention which larger ARM-based systems with lots of parallel I/O
>>> are starting to feel the pain of.
>>>

[...]

>>
>> This patch series helps to resolve the Ubuntu bug, where we see the
>> Ubuntu Zesty (4.10 based) kernel reporting multi cpu soft lockups on
>> QDF2400 SDP. https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1680549
>
> Wow, how many separate buffers does that driver have mapped at once to
> spend 22 seconds walking the rbtree for a single allocation!? I'd almost
> expect that to indicate a deadlock.
>
> I'm guessing you wouldn't have seen this on older kernels, since I
> assume that particular platform is booting via ACPI, so wouldn't have
> had the SMMU enabled without the IORT support which landed in 4.10.
>

Although this series does improve performance, the soft lockups seen
in the Ubuntu bug Manoj mentioned were actually because while the
the mlx5 interface was being brought up, a huge number of concurrent
calls to alloc_iova() were being made with limit_pfn != dma_32bit_pfn
so the optimized iova lookup was being bypassed.

Internally we worked around the issue by adding a set_dma_mask handler
that would call iommu_dma_init_domain() to adjust dma_32bit_pfn to
match the input mask.

https://source.codeaurora.org/quic/server/kernel/commit/arch/arm64/mm/dma-mapping.c?h=qserver-4.10&id=503b36fd3866cab216fc51a5a4015aaa99daf173

This worked well, however it clearly would not have played nice with
your dma-iommu PCI optimizations that force dma_limit to 32-bits so
it was never sent out. The application of the "PCI allocation
optimisations" patch is what actually remedied the cpu soft lockups
seen by Manoj.

Back to your question of how many buffers does the mlx5 driver have
mapped at once. It seems to scale linearly with core count. For
example, with 24-cores, after doing 'ifconfig eth<n> up', ~38k calls
to alloc_iova() have been made and the min iova is ~0xF600_0000. With
48-cores, those numbers jump to ~66k calls with min iova ~0xEF00_0000.

Things get really scary when you start using 64k pages. The number of
calls to alloc_iova() stays about the same which, when combined with
the reserved PCI windows, ends up consuming all of our 32-bit iovas
forcing us to once again call alloc_iova() but this time with a
limit_pfn != dma_32bit_pfn. This is actually how I stumbled upon
the alloc_iova() underflow bug that I posted about a bit earlier.

>> This patch series along with the following cherry-picks from Linus's tree
>> dddd632b072f iommu/dma: Implement PCI allocation optimisation
>> de84f5f049d9 iommu/dma: Stop getting dma_32bit_pfn wrong
>>
>> were applied to Ubuntu Zesty 4.10 kernel (Ubuntu-4.10.0-18.20) and
>> tested on a QDF2400 SDP.
>>
>> Tested-by: Manoj Iyer <manoj.iyer-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>
> Thanks,
> Robin.
>
>>
>>
>> --
>> ============================
>> Manoj Iyer
>> Ubuntu/Canonical
>> ARM Servers - Cloud
>> ============================
>
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
