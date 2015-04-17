From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: Error: DMA: Out of SW-IOMMU space [was: External USB drives
	become unresponsive after few hours.]
Date: Fri, 17 Apr 2015 16:06:24 -0400
Message-ID: <20150417200623.GA14442@l.oracle.com>
References: <Pine.LNX.4.44L0.1504161010370.1391-100000@iolanthe.rowland.org>
	<552FCD25.9060807@gmail.com>
	<CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew@mail.gmail.com>
	<20150416184252.GE7388@x230.dumpdata.com>
	<CAJ2095qW5rQ4VfCDmZQtgUp1FgGQrB1Q3DBSSKrWvvLo+B8OSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ2095qW5rQ4VfCDmZQtgUp1FgGQrB1Q3DBSSKrWvvLo+B8OSw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Apr 17, 2015 at 05:14:20PM +0200, Dorian Gray wrote:
> On 16 April 2015 at 20:42, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> > And easier way is to compile the kernel with CONFIG_DMA_API_DEBUG
> > and then load the attached module.
> >
> > That should tell you who and what else is holding on the buffers.
> 
> Ok, I have compiled 3.19.4 w/ CONFIG_DMA_API_DEBUG=y + the module you sent me.
> Now, I'm not sure if I've done it right - I waited until the error
> occured and then modprobe'd dump_dma.
> I have attached the kernel log, but it tells me not much, if anything...

The network driver is quite hungry for DMA. Did it do the same thing
in the earlier kernels?

Thanks.
> 
> Thanks again.
> Jake
