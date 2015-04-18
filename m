From: Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Error: DMA: Out of SW-IOMMU space [was: External USB drives
 become unresponsive after few hours.]
Date: Sat, 18 Apr 2015 21:59:40 +0200
Message-ID: <CAJ2095pQGBP7LeH+c0UmSbUMk81SxxVfpUaUXkn90Thq+iH1Nw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1504161010370.1391-100000@iolanthe.rowland.org>
	<552FCD25.9060807@gmail.com>
	<CAJ2095q3Gs=+e4ndKiD4EEX9LMh0Mjkv0nNOT=C-0aLD7tBDew@mail.gmail.com>
	<20150416184252.GE7388@x230.dumpdata.com>
	<CAJ2095qW5rQ4VfCDmZQtgUp1FgGQrB1Q3DBSSKrWvvLo+B8OSw@mail.gmail.com>
	<20150417200623.GA14442@l.oracle.com>
	<CAJ2095qSqTY3fDx5UCub9gkE_bPmX2jyHnuZrcsYtuaHOhSiQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJ2095qSqTY3fDx5UCub9gkE_bPmX2jyHnuZrcsYtuaHOhSiQQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Alexander Duyck <alexander.duyck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Suman Tripathi <stripathi-qTEPVZfXA3Y@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kernel development list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 18 April 2015 at 12:10, Dorian Gray <yourfavouritegod-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 17 April 2015 at 22:06, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>> On Fri, Apr 17, 2015 at 05:14:20PM +0200, Dorian Gray wrote:
>>> On 16 April 2015 at 20:42, Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
>>> > And easier way is to compile the kernel with CONFIG_DMA_API_DEBUG
>>> > and then load the attached module.
>>> >
>>> > That should tell you who and what else is holding on the buffers.
>>>
>>> Ok, I have compiled 3.19.4 w/ CONFIG_DMA_API_DEBUG=y + the module you sent me.
>>> Now, I'm not sure if I've done it right - I waited until the error
>>> occured and then modprobe'd dump_dma.
>>> I have attached the kernel log, but it tells me not much, if anything...
>>
>> The network driver is quite hungry for DMA. Did it do the same thing
>> in the earlier kernels?
>>
>> Thanks.
>>>
>>> Thanks again.
>>> Jake
>>
>>
>
> Yeah, you're right:
>
> # grep rtl8192se dump_dma_k3.19.4.log | wc -l
> 6789
> #
> # grep rtl8192se dump_dma_k3.17.8.log | wc -l
> 162
> #
>
> So, wlan driver would be the real culprit then..?
> I would have never thought...
>
> I guess I'm gonna test 3.19.4 once more (just to be sure) with
> rtl8192se removed and see what happens.
>
> Thanks!
> Jake


[update]

Ok, 6 hours of uptime (3.19.4 + blacklisted rtl8192se) and everything
was fine...
However, I was checking periodically and noticed that 'radeon' also
tends to grow continuously over time, whereas ethernet driver sticks
to, more or less, the same range:

# uname -r
3.19.4
#
# grep -Eo 'radeon|r8169' L1.log | sort | uniq -c
     62 r8169
   4183 radeon
#
# grep -Eo 'radeon|r8169' L2.log | sort | uniq -c
     33 r8169
   5582 radeon
#
# grep -Eo 'radeon|r8169' L3.log | sort | uniq -c
     54 r8169
   7007 radeon
#
# grep -Eo 'radeon|r8169' L4.log | sort | uniq -c
     49 r8169
   7429 radeon
#
# grep -Eo 'radeon|r8169' L5.log | sort | uniq -c
     34 r8169
   9360 radeon
#

It doesn't grow that much in 3.17.8:

# uname -r
3.17.8
#
# grep -Eo 'radeon|r8169|rtl8192se' L1.log | sort | uniq -c
    265 r8169
   1229 radeon
    142 rtl8192se
#
# grep -Eo 'radeon|r8169|rtl8192se' L2.log | sort | uniq -c
    187 r8169
   3159 radeon
    124 rtl8192se
#
# grep -Eo 'radeon|r8169|rtl8192se' L3.log | sort | uniq -c
     41 r8169
   1894 radeon
     39 rtl8192se
#
# grep -Eo 'radeon|r8169|rtl8192se' L4.log | sort | uniq -c
     64 r8169
   3370 radeon
     77 rtl8192se
#
# grep -Eo 'radeon|r8169|rtl8192se' L5.log | sort | uniq -c
     52 r8169
   2597 radeon
     49 rtl8192se
#


Btw, at some point (3.19.4) I encounetered this:
[21631.181909] DMA-API: debugging out of memory - disabling

Jake
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
