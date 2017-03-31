From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 0/3] IOVA allocation improvements for iommu-dma
Date: Fri, 31 Mar 2017 14:13:13 +0100
Message-ID: <10f9621a-41ca-bb3d-0e49-a2827022f608@arm.com>
References: <cover.1489581865.git.robin.murphy@arm.com>
	<20170331124051.GI8967@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170331124051.GI8967-5wv7dgnIgG8@public.gmane.org>
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
Cc: damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sunil.kovvuri-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 31/03/17 13:40, Will Deacon wrote:
> Hi Robin, Joerg,
> 
> On Wed, Mar 15, 2017 at 01:33:13PM +0000, Robin Murphy wrote:
>> Here's the first bit of lock contention removal to chew on - feedback
>> welcome! Note that for the current users of the io-pgtable framework,
>> this is most likely to simply push more contention onto the io-pgtable
>> lock, so may not show a great improvement alone. Will and I both have
>> rough proof-of-concept implementations of lock-free io-pgtable code
>> which we need to sit down and agree on at some point, hopefullt fairly
>> soon.
>>
>> I've taken the opportunity to do a bit of cleanup and refactoring
>> within the series to make the final state of the code nicer, but the
>> diffstat still turns out surprisingly reasonable in the end - it would
>> actually be negative but for the new comments!
>>
>> Magnus, Shimoda-san, the first two patches should be of interest as they
>> constitute the allocation rework I mentioned a while back[1] - if you
>> still need to implement that scary workaround, this should make it
>> simple to hook IPMMU-specific calls into the alloc and free paths, and
>> let the driver take care of the details internally.
> 
> What's the plan for merging this? Whilst we still have the iopgtable lock
> contention to resolve, this is a good incremental step towards improving
> our scalability and sits nicely alongside the SMMUv2 TLB improvements I
> just queued.

I was assuming this would go through the IOMMU tree if there were no
problems and the feedback was good, and that would seem to be the case.
I'm pleasantly surprised that this series doesn't even conflict at all
with my other iommu-dma changes already queued - I've just checked that
it still applies cleanly to the current iommu/next as-is.

Robin.

> 
> Thanks,
> 
> Will
> 
