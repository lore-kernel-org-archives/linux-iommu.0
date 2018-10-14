From: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] x86: enable swiotlb for > 4GiG ram on 32-bit kernels
Date: Sun, 14 Oct 2018 11:04:33 +0200
Message-ID: <20181014090433.GA28319@gmail.com>
References: <20181014075208.2715-1-hch@lst.de>
	<alpine.DEB.2.21.1810141012510.1438@nanos.tec.linutronix.de>
	<20181014081443.GA17889@lst.de>
	<alpine.DEB.2.21.1810141055440.1438@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810141055440.1438-ecDvlHI5BZPZikZi3RtOZ1XZhhPuCNm+@public.gmane.org>
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


* Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:

> On Sun, 14 Oct 2018, Christoph Hellwig wrote:
> 
> > On Sun, Oct 14, 2018 at 10:13:31AM +0200, Thomas Gleixner wrote:
> > > On Sun, 14 Oct 2018, Christoph Hellwig wrote:
> > > 
> > > > We already build the swiotlb code for 32b-t kernels with PAE support,
> > > > but the code to actually use swiotlb has only been enabled for 64-bit
> > > > kernel for an unknown reason.
> > > > 
> > > > Before Linux 4.18 we papers over this fact because the networking code,
> > > > the scsi layer and some random block drivers implenented their own
> > > > bounce buffering scheme.
> > > > 
> > > > Fixes: 21e07dba ("scsi: reduce use of block bounce buffers")
> 
> Please use the first 12 characters of the commit SHA for fixes tags in the
> future, as documented. No need to resend, I fixed it up for you and added a
> Cc: stable as well

For those who have their ~/.gitconfig's from ancient Git history, this can be done via:

	git config --global core.abbrev 12

Thanks,

	Ingo
