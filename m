From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/arm-smmu: Add initial driver support for ARM
	SMMUv3 devices
Date: Fri, 29 May 2015 08:43:37 +0200
Message-ID: <20150529064337.GN20611@8bytes.org>
References: <1431108046-9675-1-git-send-email-will.deacon@arm.com>
	<1431108046-9675-3-git-send-email-will.deacon@arm.com>
	<20150519152435.GL20611@8bytes.org>
	<20150520170926.GI11498@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150520170926.GI11498-5wv7dgnIgG8@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Will,

On Wed, May 20, 2015 at 06:09:26PM +0100, Will Deacon wrote:
> On Tue, May 19, 2015 at 04:24:35PM +0100, Joerg Roedel wrote:
> > > +	/* Page sizes */
> > > +	if (reg & IDR5_GRAN64K)
> > > +		pgsize_bitmap |= SZ_64K | SZ_512M;
> > > +	if (reg & IDR5_GRAN16K)
> > > +		pgsize_bitmap |= SZ_16K | SZ_32M;
> > > +	if (reg & IDR5_GRAN4K)
> > > +		pgsize_bitmap |= SZ_4K | SZ_2M | SZ_1G;
> > > +
> > > +	arm_smmu_ops.pgsize_bitmap &= pgsize_bitmap;
> > 
> > So this could effictivly lead to a zero pgsize_bitmap when there are
> > SMMUs in the system with support for different page sizes, no?
> 
> Indeed, if there is no common page size then we end up not being able to
> support any. I tried to resolve this by moving the bitmap out of the
> iommu_ops and into the iommu_domain, but you weren't fond of that idea ;)

Well, what you could do (and what I think the core should do at some
point) is to build the resulting page-size bitmap by taking the biggest
minimum page-size from all iommus and OR the page-size bigger than that
together. For a system with 3 SMMUs supporting all of the above
pgsize_bitmaps the resulting bitmap would look like this:

	SZ_64K | SZ_32M | SZ_2M | SZ_512M | SZ_1G;

With the biggest minimum page-size all of the bigger page-sizes can be
emulated.  But that is not necessary for this patch-set, just a
suggestion for future work.


	Joerg
