From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu: Support dynamic pgsize_bitmap
Date: Thu, 7 Apr 2016 15:24:30 +0200
Message-ID: <20160407132430.GE31146@8bytes.org>
References: <1459890090-16040-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459890090-16040-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Pratik Patel <pratikp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 05, 2016 at 02:01:29PM -0700, Mitchel Humpherys wrote:
> Currently we use a single pgsize_bitmap per IOMMU driver.  However, some
> IOMMU drivers might service different IOMMUs with different supported
> page sizes.  Some drivers might also want to restrict page sizes for
> different use cases.  Support these use cases by adding a
> .get_pgsize_bitmap function to the iommu_ops which can optionally be
> used by the driver to return a domain-specific pgsize_bitmap.

No, at least not this way. I said it before and I say it again: We are
not going to lift the iommu-api requirements in this undetectable way.

The iommu-api works with domains/groups and devices. The general
expectation is that every group can be part of every domain. I know that
this is not the case already with some drivers, but I am not going to
move the code further into the wrong direction.

The way I'd like to see that solved is:

	* Introduce per-group pgsize-bitmaps (group->pgsize_bmp)

	* Calculate a global pgsize-bitmap from all groups
	  pgsize-bitmaps

	* Also store a pgsize_bitmap in each domain on allocation

	* Modify iommu_domain_alloc to set domain->pgsize_bmp to the
	  global pgsize_bitmap

	* Introduce an iommu_group_alloc_domain(group) function which
	  allocates a new domain only for the given group. This function
	  sets domain->pgsize_bitmap to group->pgsize_bmp.

	* Note that now you can have multiple page-tables per domain,
	  one page-table for each required format.


Regards,

	Joerg
