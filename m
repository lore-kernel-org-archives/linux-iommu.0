From: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 0/3] IOVA allocation improvements for iommu-dma
Date: Wed, 22 Mar 2017 13:43:16 -0400
Message-ID: <b665e8511ef524fce0c7cc00b7920cba@codeaurora.org>
References: <cover.1489581865.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1489581865.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 2017-03-15 09:33, Robin Murphy wrote:
> Hi all,
Hi Robin,
> 
> Here's the first bit of lock contention removal to chew on - feedback
> welcome! Note that for the current users of the io-pgtable framework,
> this is most likely to simply push more contention onto the io-pgtable
> lock, so may not show a great improvement alone. Will and I both have
> rough proof-of-concept implementations of lock-free io-pgtable code
> which we need to sit down and agree on at some point, hopefullt fairly
> soon.
> 
> I've taken the opportunity to do a bit of cleanup and refactoring
> within the series to make the final state of the code nicer, but the
> diffstat still turns out surprisingly reasonable in the end - it would
> actually be negative but for the new comments!
> 
> Magnus, Shimoda-san, the first two patches should be of interest as 
> they
> constitute the allocation rework I mentioned a while back[1] - if you
> still need to implement that scary workaround, this should make it
> simple to hook IPMMU-specific calls into the alloc and free paths, and
> let the driver take care of the details internally.

I've tested your patches on a QDF2400 platform and generally
see modest improvements in iperf/fio performance. As you
suspected would happen, contention has indeed moved to the
io-pgtable lock. I am looking forward to testing with the
lock-free io-pgtable implementation, however I suspect that
there will still be contention issues acquiring the (SMMUv3)
cmdq lock on the unmap path.

Reviewed/Tested-by: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> 
> Robin.
> 
> [1]:https://lists.linuxfoundation.org/pipermail/iommu/2017-January/020189.html
> 
> Robin Murphy (3):
>   iommu/dma: Convert to address-based allocation
>   iommu/dma: Clean up MSI IOVA allocation
>   iommu/dma: Plumb in the per-CPU IOVA caches
> 
>  drivers/iommu/dma-iommu.c | 176 
> ++++++++++++++++++++++++----------------------
>  1 file changed, 90 insertions(+), 86 deletions(-)

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux
Foundation Collaborative Project.
