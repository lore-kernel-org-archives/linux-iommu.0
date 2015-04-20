From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: Error: DMA: Out of SW-IOMMU space [was: External USB drives
	become unresponsive after few hours.]
Date: Mon, 20 Apr 2015 09:03:03 -0400
Message-ID: <20150420130303.GB9002@l.oracle.com>
References: <Pine.LNX.4.44L0.1504161010370.1391-100000@iolanthe.rowland.org>
	<552FCD25.9060807@gmail.com>
	<CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew@mail.gmail.com>
	<20150416184252.GE7388@x230.dumpdata.com>
	<CAJ2095qW5rQ4VfCDmZQtgUp1FgGQrB1Q3DBSSKrWvvLo+B8OSw@mail.gmail.com>
	<20150417200623.GA14442@l.oracle.com>
	<CAJ2095qSqTY3fDx5UCub9gkE_bPmX2jyHnuZrcsYtuaHOhSiQQ@mail.gmail.com>
	<CAJ2095pQGBP7LeH+c0UmSbUMk81SxxVfpUaUXkn90Thq+iH1Nw@mail.gmail.com>
	<CAJ2095rrd2ZR9mNJegBn1qO2-obod51GXL1bOJTtB+wH2MF+7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJ2095rrd2ZR9mNJegBn1qO2-obod51GXL1bOJTtB+wH2MF+7g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Sun, Apr 19, 2015 at 05:43:18PM +0200, Dorian Gray wrote:
> I think the case is closed.
> Now that I know it's not USB, but wireless driver, I looked through
> the new k3.19.5's changelog and saw this:
> 
> 
> commit b943e69d33fac1e5f6db57868e061096b0aae67a
> Author: Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>
> Date:   Sat Mar 21 15:16:05 2015 -0500
> 
>     rtlwifi: Fix IOMMU mapping leak in AP mode
> 
>     commit be0b5e635883678bfbc695889772fed545f3427d upstream.
> 
>     Transmission of an AP beacon does not call the TX interrupt service routine,
>     which usually does the cleanup. Instead, cleanup is handled in a tasklet
>     completion routine. Unfortunately, this routine has a serious bug
> in that it does
>     not release the DMA mapping before it frees the skb, thus one
> IOMMU mapping is
>     leaked for each beacon. The test system failed with no free IOMMU
> mapping slots
>     approximately one hour after hostapd was used to start an AP.
> 
>     This issue was reported and tested at
> https://github.com/lwfinger/rtlwifi_new/issues/30.
> 
>     Reported-and-tested-by: Kevin Mullican <kevin-soP9kbdFjidWk0Htik3J/w@public.gmane.org>
>     Cc: Kevin Mullican <kevin-soP9kbdFjidWk0Htik3J/w@public.gmane.org>
>     Signed-off-by: Shao Fu <shaofu-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>
>     Signed-off-by: Larry Finger <Larry.Finger-tQ5ms3gMjBLk1uMJSBkQmQ@public.gmane.org>
>     Signed-off-by: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>     Signed-off-by: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> 
> 
> Looks very related, especially because my wireless card is also always
> in AP mode, however I haven't been actually using it lately, so
> probably that's why I didn't notice anything related to it (and kept
> focused on USB), until I used dump_dma.
> 
> Well, due to my minimal knowledge regarding kernel's internals I can't
> be 100% sure that this was it, but so far 3.19.5 is working stable
> (uptime 6hrs and counting).

Sweet!
> 
> Thank you Konrad (and everyone else involved) for helping me out to
> pinpoint the actual culprit.

Sure thing. Happy to have been able to help!
> Jake
> 
> 
> On 18 April 2015 at 21:59, Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > On 18 April 2015 at 12:10, Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> On 17 April 2015 at 22:06, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> >>> On Fri, Apr 17, 2015 at 05:14:20PM +0200, Dorian Gray wrote:
> >>>> On 16 April 2015 at 20:42, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> >>>> > And easier way is to compile the kernel with CONFIG_DMA_API_DEBUG
> >>>> > and then load the attached module.
> >>>> >
> >>>> > That should tell you who and what else is holding on the buffers.
> >>>>
> >>>> Ok, I have compiled 3.19.4 w/ CONFIG_DMA_API_DEBUG=y + the module you sent me.
> >>>> Now, I'm not sure if I've done it right - I waited until the error
> >>>> occured and then modprobe'd dump_dma.
> >>>> I have attached the kernel log, but it tells me not much, if anything...
> >>>
> >>> The network driver is quite hungry for DMA. Did it do the same thing
> >>> in the earlier kernels?
> >>>
> >>> Thanks.
> >>>>
> >>>> Thanks again.
> >>>> Jake
> >>>
> >>>
> >>
> >> Yeah, you're right:
> >>
> >> # grep rtl8192se dump_dma_k3.19.4.log | wc -l
> >> 6789
> >> #
> >> # grep rtl8192se dump_dma_k3.17.8.log | wc -l
> >> 162
> >> #
> >>
> >> So, wlan driver would be the real culprit then..?
> >> I would have never thought...
> >>
> >> I guess I'm gonna test 3.19.4 once more (just to be sure) with
> >> rtl8192se removed and see what happens.
> >>
> >> Thanks!
> >> Jake
> >
> >
> > [update]
> >
> > Ok, 6 hours of uptime (3.19.4 + blacklisted rtl8192se) and everything
> > was fine...
> > However, I was checking periodically and noticed that 'radeon' also
> > tends to grow continuously over time, whereas ethernet driver sticks
> > to, more or less, the same range:
> >
> > # uname -r
> > 3.19.4
> > #
> > # grep -Eo 'radeon|r8169' L1.log | sort | uniq -c
> >      62 r8169
> >    4183 radeon
> > #
> > # grep -Eo 'radeon|r8169' L2.log | sort | uniq -c
> >      33 r8169
> >    5582 radeon
> > #
> > # grep -Eo 'radeon|r8169' L3.log | sort | uniq -c
> >      54 r8169
> >    7007 radeon
> > #
> > # grep -Eo 'radeon|r8169' L4.log | sort | uniq -c
> >      49 r8169
> >    7429 radeon
> > #
> > # grep -Eo 'radeon|r8169' L5.log | sort | uniq -c
> >      34 r8169
> >    9360 radeon
> > #
> >
> > It doesn't grow that much in 3.17.8:
> >
> > # uname -r
> > 3.17.8
> > #
> > # grep -Eo 'radeon|r8169|rtl8192se' L1.log | sort | uniq -c
> >     265 r8169
> >    1229 radeon
> >     142 rtl8192se
> > #
> > # grep -Eo 'radeon|r8169|rtl8192se' L2.log | sort | uniq -c
> >     187 r8169
> >    3159 radeon
> >     124 rtl8192se
> > #
> > # grep -Eo 'radeon|r8169|rtl8192se' L3.log | sort | uniq -c
> >      41 r8169
> >    1894 radeon
> >      39 rtl8192se
> > #
> > # grep -Eo 'radeon|r8169|rtl8192se' L4.log | sort | uniq -c
> >      64 r8169
> >    3370 radeon
> >      77 rtl8192se
> > #
> > # grep -Eo 'radeon|r8169|rtl8192se' L5.log | sort | uniq -c
> >      52 r8169
> >    2597 radeon
> >      49 rtl8192se
> > #
> >
> >
> > Btw, at some point (3.19.4) I encounetered this:
> > [21631.181909] DMA-API: debugging out of memory - disabling
> >
> > Jake
