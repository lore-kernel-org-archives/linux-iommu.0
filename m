From: Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 0/5] enhance DMA CMA on x86
Date: Tue, 30 Sep 2014 19:49:40 -0400
Message-ID: <542B4194.8070604@hurleysoftware.com>
References: <1397567329-3771-1-git-send-email-akinobu.mita@gmail.com>
	<5426CA0A.7000806@hurleysoftware.com>
	<CAC5umyhgs8---HZLa7_DOSbqW0uPbLgqTfBweScZSR9oWbG9xg@mail.gmail.com>
	<54294C0B.1060705@hurleysoftware.com>
	<CAC5umyjP4OscSC8igVLYPEm-6gqiXt9md46sLu77Vut5UiPb=g@mail.gmail.com>
	<542ABF77.1020402@hurleysoftware.com>
	<alpine.DEB.2.11.1410010131380.4455@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1410010131380.4455@nanos>
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
Cc: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Akinobu Mita <akinobu.mita-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 09/30/2014 07:45 PM, Thomas Gleixner wrote:
> On Tue, 30 Sep 2014, Peter Hurley wrote:
>> I read the UFS Unified Memory Extension v1.0 (JESD220-1) specification and
>> it is not clear to me that using DMA mapping is the right approach to
>> supporting UM, at least on x86.
>>
>> And without a mainline user, the merits of this approach are not evident.
>> I cannot even find a production x86 UFS controller, much less one that
>> supports UME.
>>
>> The only PCI UFS controller I could find (and that mainline supports) is
>> Samsung's x86 FPGA-based test unit for developing UFS devices in a x86 test
>> environment, and not a production x86 design.
> 
> And how is that relevant? That device exists and you have no reason to
> deny it to be supported just because you are not interested in it.
>  
>> Unless there's something else I've missed, I don't think these patches
>> belong in mainline.
> 
> You missed that there is no reason WHY such a device should not be
> supported in mainline.

Mainline already supports this card right now without these patches.

>> Samsung's own roadmap
>> (http://www.slideshare.net/linaroorg/next-gen-mobilestorageufs)
>> mentions nothing about bringing UFS to x86 designs.
> 
> And that's telling you what? 
> 
>    - That we should deny Samsung proper support for their obviously
>      x86 based test card
> 
>    - That we should ignore a JEDEC Standard which is obviously never
>      going to hit x86 land just because you decide it?
> 
> Your argumentation is just ass backwards. Linux wants to support the
> full zoo of hardware including this particular PCI card. Period.
> 
> Whether the proposed patchset is the correct solution to support it is
> a completely different question.

And there is currently no way to determine that because there is no
user in mainline that requires this support.

Which you would understand if you had read more carefully.

Regards,
Peter Hurley
