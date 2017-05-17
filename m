From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] iommu/iova: Sort out rbtree limit_pfn handling
Date: Wed, 17 May 2017 16:07:06 +0200
Message-ID: <20170517140706.GD1912@8bytes.org>
References: <2f161f6406fd33ea979f6b128f36bb8ac9044d06.1494933782.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 16, 2017 at 12:26:48PM +0100, Robin Murphy wrote:
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

Applied, thanks.
