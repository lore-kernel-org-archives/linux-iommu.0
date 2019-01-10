From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: amdgpu/TTM oopses since merging swiotlb_dma_ops into the
	dma_direct code
Date: Thu, 10 Jan 2019 12:05:58 -0500
Message-ID: <20190110170557.GD27546@char.us.oracle.com>
References: <61f8f660-005c-190c-c08f-b563de2eae18@daenzer.net>
	<20190110135741.GA9255@lst.de>
	<CAF=iVctGGs1OzHBg6MgpxrFbT_19T4YvH8muBZtsLJBDwGhrvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF=iVctGGs1OzHBg6MgpxrFbT_19T4YvH8muBZtsLJBDwGhrvQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sibren Vasse <sibren-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>
Cc: Sibren Vasse <freedesktop-DLwv2wemLo05ZU0pBKPMFg@public.gmane.org>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jan 10, 2019 at 04:26:43PM +0100, Sibren Vasse wrote:
> On Thu, 10 Jan 2019 at 14:57, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:
> >
> > On Thu, Jan 10, 2019 at 10:59:02AM +0100, Michel D=E4nzer wrote:
> > >
> > > Hi Christoph,
> > >
> > >
> > > https://bugs.freedesktop.org/109234 (please ignore comments #6-#9) was
> > > bisected to your commit 55897af63091 "dma-direct: merge swiotlb_dma_o=
ps
> > > into the dma_direct code". Any ideas?
> >
> > From the trace it looks like we git the case where swiotlb tries
> > to copy back data from a bounce buffer, but hits a dangling or NULL
> > pointer.  So a couple questions for the submitter:
> My apologies if I misunderstand something, this subject matter is new to =
me.
> =

> >
> >  - does the system have more than 4GB memory and thus use swiotlb?
> My system has 8GB memory. The other report on the bug tracker had 16GB.
> =

> >    (check /proc/meminfo, and if something SWIOTLB appears in dmesg)
> /proc/meminfo: https://ptpb.pw/4rxI
> Can I grep dmesg for a string?

Can you attach the 'dmesg'? =


> =

> >  - does the device this happens on have a DMA mask smaller than
> >    the available memory, that is should swiotlb be used here to start
> >    with?
> It's a MSI Radeon RX 570 Gaming X 4GB. The other report was a RX 580.
> lshw output: https://ptpb.pw/6s0H
> =

> =

> Regards,
> =

> Sibren
