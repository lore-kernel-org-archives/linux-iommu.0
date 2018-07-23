From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] nios2: use generic dma_noncoherent_ops
Date: Mon, 23 Jul 2018 10:27:17 +0200
Message-ID: <20180723082717.GA19548@lst.de>
References: <20180619070137.25841-1-hch@lst.de> <20180711153252.GA31946@lst.de>
	<1531979335.36945.0.camel@intel.com> <20180719122204.GA8606@lst.de>
	<1532334042.124578.1.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1532334042.124578.1.camel-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ley Foon Tan <ley.foon.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 23, 2018 at 04:20:42PM +0800, Ley Foon Tan wrote:
> On Thu, 2018-07-19 at 14:22 +0200, Christoph Hellwig wrote:
> > On Thu, Jul 19, 2018 at 01:48:55PM +0800, Ley Foon Tan wrote:
> > > =

> > > Do you have git repo for this series of patches?
> > This patch should apply without the need for any other patch
> > to Linus' latest tree, but I have a tree with all the conversions
> > here:
> > =

> > =A0=A0=A0=A0http://git.infradead.org/users/hch/misc.git/shortlog/refs/h=
eads/g
> > eneric-dma-noncoherent.3
> Hi
> =

> Compilation, system bootup and Ethernet are working fine with this
> patch.

Do you want to merge it through the nios tree or should I pick it up?
