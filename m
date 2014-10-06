From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/arm-smmu: add support for PCI master devices
Date: Mon, 6 Oct 2014 13:42:28 +0100
Message-ID: <20141006124228.GH12935@arm.com>
References: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
	<1404125530-17984-3-git-send-email-will.deacon@arm.com>
	<a9de518782874b5c8ddd366e6617b8de@BL2PR03MB468.namprd03.prod.outlook.com>
	<20140709132653.GM9485@arm.com>
	<1404915184.4256.160.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404915184.4256.160.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Wed, Jul 09, 2014 at 03:13:04PM +0100, Alex Williamson wrote:
> On Wed, 2014-07-09 at 14:26 +0100, Will Deacon wrote:
> > pci_find_dma_isolation_root doesn't exist in any of the trees I have. Alex,
> > is this queued anywhere and do I actually need it?
> 
> That function was in the v3 DMA alias series, in v4 it got replaced.
> iommu_group_get_for_pci_dev() is the common function for finding or
> creating a group for a device and pci_for_each_dma_alias() is the
> interface to walk each alias in a PCI topology.  The pci_ interface is
> in 3.16-rc and the iommu_ pieces are current in next via the iommu tree.
> 
> > The purpose of this code is to find the requester ID of a device as it
> > appears at the host controller. At this point, we can map it (via firmware
> > tables that are TBD) to a Stream ID for the SMMU. It looks to me like
> > pci_for_each_dma_alias walks over non-transparent PCI bridges correctly, so
> > the callback I provide just updates the alias until the walk has completed.
> 
> Yep, that's the intended usage.  There are cases in VT-d where it wants
> to add context entries for every alias and cases elsewhere that we just
> want the final alias.  pci_for_each_dma_alias() is meant to fit both use
> cases.  Thanks,

I'm looking at moving the arm-smmu driver over to using
iommu_group_get_for_dev, but I've hit a slight snag. Once I have the group,
I actually need to get hold of the alias for that group, since that will be
converted into a StreamID used to program the SMMU. I can do this by
open-coding my own version of iommu_group_get_for_pci_dev, but that's pretty
horrible.

What's the best way to get hold of the alias for a given group?

Cheers,

Will
