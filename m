From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
Date: Sun, 14 Oct 2018 10:14:43 +0200
Message-ID: <20181014081443.GA17889@lst.de>
References: <20181014075208.2715-1-hch@lst.de>
	<alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810141012510.1438-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tedheadster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Oct 14, 2018 at 10:13:31AM +0200, Thomas Gleixner wrote:
> On Sun, 14 Oct 2018, Christoph Hellwig wrote:
> 
> > We already build the swiotlb code for 32b-t kernels with PAE support,
> > but the code to actually use swiotlb has only been enabled for 64-bit
> > kernel for an unknown reason.
> > 
> > Before Linux 4.18 we papers over this fact because the networking code,
> > the scsi layer and some random block drivers implenented their own
> > bounce buffering scheme.
> > 
> > Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")
> > Fixes: ab74cfeb ("net: remove the PCI_DMA_BUS_IS_PHYS check in illegal_highdma")
> > Reported-by: tedheadster <tedheadster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > Tested-by: tedheadster <tedheadster-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> I'll add your SOB when picking this up :)

Thanks.  Here it is in writing:

Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
