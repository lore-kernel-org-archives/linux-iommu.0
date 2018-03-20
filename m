From: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Date: Tue, 20 Mar 2018 09:37:51 +0100
Message-ID: <20180320083751.nrpt64dsmpqbhzc6@gmail.com>
References: <20180319103826.12853-1-hch@lst.de>
	<20180319152737.GK1110@char.us.oracle.com>
	<20180319152840.GA28041@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180319152840.GA28041-jcswGhMUV9g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Muli Ben-Yehuda <mulix-BzGcCpaT2IbYtjvyW6yDsg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


* Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org> wrote:

> On Mon, Mar 19, 2018 at 11:27:37AM -0400, Konrad Rzeszutek Wilk wrote:
> > On Mon, Mar 19, 2018 at 11:38:12AM +0100, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > this series switches the x86 code the the dma-direct implementation
> > > for direct (non-iommu) dma and the generic swiotlb ops.  This includes
> > > getting rid of the special ops for the AMD memory encryption case and
> > > the STA2x11 SOC.  The generic implementations are based on the x86
> > > code, so they provide the same functionality.
> > 
> > I need to test this on my baremertal and Xen setup - and I lost your
> > git repo URL - any chance you mention point out to me so I can
> > kick of a build?
> 
> git://git.infradead.org/users/hch/misc.git dma-direct-x86

Btw., what's the upstreaming route for these patches?

While it's a multi-arch series it's all pretty x86-heavy as well so we can host it 
in -tip (in tip:core/dma or such), but feel free to handle it yourself as well:

  Reviewed-by: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks,

	Ingo
