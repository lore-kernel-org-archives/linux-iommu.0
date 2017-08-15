From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [pull] iommu: qcom_iommu for v4.14
Date: Tue, 15 Aug 2017 22:59:56 +0200
Message-ID: <20170815205956.GL30515@8bytes.org>
References: <CAF6AEGuNqQtJBhLAFu3NdUAjKJrVvR9WtHL-eCRN0H1Di6_4mQ@mail.gmail.com>
 <20170815154232.GB25618@8bytes.org>
 <CAF6AEGtxmJUOKZpqMZfYkgP6Bs7mbGAzEtC8on8TkjdTU5pcFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGtxmJUOKZpqMZfYkgP6Bs7mbGAzEtC8on8TkjdTU5pcFQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Sricharan R <sricharan@codeaurora.org>, Will Deacon <will.deacon@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 15, 2017 at 12:52:11PM -0400, Rob Clark wrote:
> On Tue, Aug 15, 2017 at 11:42 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > On Sun, Aug 13, 2017 at 10:27:36AM -0400, Rob Clark wrote:
> >> Hi Joerg,
> >>
> >> These patches have been on list for quite some time now.  The bindings
> >> have r-b from Rob Herring, and the patch touching arm-smmu has Will's
> >> a-b.  And all the review comments on the driver patches have been
> >> addressed (despite no one stepping up w/ a r-b tag).  Please consider
> >> merging this pull request for v4.14
> >
> > Okay, I applied it, not from this pull-request, but from your last
> > post. Some comments for the future below.
> 
> Thanks.  Patches from list are the same.
> 
> For future reference to you prefer to pick up patches from list?
> (Dave prefers pull req's for drm, but I guess the volume of patches
> for an iommu driver should be lower.)

For now please send any patch for the qcom iommu directly to me (and Cc
relevant ML) and then I take care of them. Can you also add a
MAINTAINERS entry for it?


Regards,

	Joerg
