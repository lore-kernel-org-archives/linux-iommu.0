From: Jerome Glisse <j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Fix amd_iommu_detect() (does not fix any
	issues).
Date: Tue, 27 Oct 2015 09:53:30 +0900
Message-ID: <20151027005329.GB3569@gmail.com>
References: <1441059183-9023-1-git-send-email-j.glisse@gmail.com>
	<20151026160717.GF5618@l.oracle.com>
	<20151027004747.GA3569@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151027004747.GA3569-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 27, 2015 at 09:47:48AM +0900, Jerome Glisse wrote:
> On Mon, Oct 26, 2015 at 12:07:17PM -0400, Konrad Rzeszutek Wilk wrote:
> > On Mon, Aug 31, 2015 at 06:13:03PM -0400, j.glisse-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> > > From: J=E9r=F4me Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > =

> > > Fix amd_iommu_detect() to return positive value on success, like
> > > intended, and not zero. This will not change anything in the end
> > > as AMD IOMMU disable swiotlb and properly associate itself with
> > =

> > Not sure how it disables SWIOTLB? The AMD Vi does not seem to
> > change 'swiotlb'. While 'gart_iommu_init' does. Did you mean
> > the AMD GART code?
> =

> So this is convoluted and painfull, each i look back at that it takes
> me time to figure out of thing happen. Basicly amd_iommu_init_dma_ops()
> will replace dma_ops to no_mmu unless passthrough, and when the AMD
> iommu associate itself with each device it will set the archdata.dma_ops
> again this unbind the default of swiotlb that is initialize before
> hw IOMMU.
> =

> > =

> > > devices even if detect() doesn't return a positive value.
> > =

> > Returning positive will mean that the pci_iommu_alloc will stop
> > processing _all_ other IOMMUs.
> >
> > While returning 0 will let it detect the other IOMMUs.
> =

> No see the IOMMU_FINISH_IF_DETECTED flags in pci_iommu_alloc().
> Which is not set for AMD hence my patch should not change anything
> it (AFAICT and from testing but i do not have all AMD hw the ever
> existed).
> =

> So i am just making the detect function do what the API doc says it
> should do. See line 72 to 80 of : arch/x86/include/asm/iommu_table.h
> =

> > =

> > Granted on an AMD machine there can be two 'IOMMU's - the GART
> > and the AMD Vi. The detection is always to call gart_iommu_hole_init
> > first, then amd_iommu_detect.
> > =

> > I presume if there was one more type on AMD we would run into trouble.
> =

> No because of IOMMU_FINISH_IF_DETECTED flag.
> =

> Hope this clarify thing this spagethi mix :)

Ok my bad amd actualy is using IOMMU_INIT_FINISH() so it finish before
trying other. Which make sense for AMD as AMD driver will call the gart
init gart_iommu_init() if it fails to initialize. If we ever end up with
a platform with multiple IOMMU beside AMD then we need to switch to the
IOMMU_INIT() instead of the finish one.

Cheers,
J=E9r=F4me
