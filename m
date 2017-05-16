From: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] iommu/iova: Sort out rbtree limit_pfn handling
Date: Tue, 16 May 2017 08:42:21 -0500 (CDT)
Message-ID: <1044909514.237785.1494942141432.JavaMail.zimbra@xes-inc.com>
References: <2f161f6406fd33ea979f6b128f36bb8ac9044d06.1494933782.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2f161f6406fd33ea979f6b128f36bb8ac9044d06.1494933782.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

----- Original Message -----
> From: "Robin Murphy" <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Sent: Tuesday, May 16, 2017 6:26:48 AM

> When walking the rbtree, the fact that iovad->start_pfn and limit_pfn
> are both inclusive limits creates an ambiguity once limit_pfn reaches
> the bottom of the address space and they overlap. Commit 5016bdb796b3
> ("iommu/iova: Fix underflow bug in __alloc_and_insert_iova_range") fixed
> the worst side-effect of this, that of underflow wraparound leading to
> bogus allocations, but the remaining fallout is that any attempt to
> allocate start_pfn itself erroneously fails.
> 
> The cleanest way to resolve the ambiguity is to simply make limit_pfn an
> exclusive limit when inside the guts of the rbtree. Since we're working
> with PFNs, representing one past the top of the address space is always
> possible without fear of overflow, and elsewhere it just makes life a
> little more straightforward.
> 
> Reported-by: Aaron Sierra <asierra-AQeFf1F/bRxBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> I've now run this through some more targeted testing, and I'm
> confident that it works as intended - Aaron, can you confirm if
> this satisfies your tests as well?

Robin,
Thanks for giving this issue some consideration. I can confirm that
your patch passes all of the test cases where I'd previously observed
allocation failures.

FWIW, my testing consists of defining a fixed limit_pfn (0xfffff) and
iterating over domains with start_pfn values of 0, then all powers-of-two
up to half of limit_pfn (0x80000).

For each domain, I set a fixed allocation unit size, calculate how many
allocations I expect to succeed, alloc and save iova structs until
allocation fails, then compare expected to actual. I do this for
allocation unit sizes of 1, 2, 4, 8, 50% of alloc-able range, and 100%
of alloc-able range.

-Aaron S.
