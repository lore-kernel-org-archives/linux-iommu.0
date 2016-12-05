From: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] iommu/intel: disable DMAR for Q35 integrated gfx
Date: Mon, 5 Dec 2016 15:16:22 -0800
Message-ID: <CAGXu5jJZhqu_o+k0MOqG3XADV5xhQM9g=H3ZCMODRkCKyisUcw@mail.gmail.com>
References: <20161205215841.GA20819@beast>
	<1480975635.81411.4.camel@infradead.org>
	<CAGXu5j+QJZk9PghXdo=3Rp-noshG-GeSKxn+nuicqpRgFiiR5w@mail.gmail.com>
	<1480978052.28987.58.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1480978052.28987.58.camel-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jani Nikula <jani.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel.vetter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 5, 2016 at 2:47 PM, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org> wrote:
> On Mon, 2016-12-05 at 14:18 -0800, Kees Cook wrote:
>> Hm, I have no idea. :) What would I look for in the BIOS?
>
> For a start, what is the actual failure mode?

Based on initial testing (not that I've spent tons of time with it,
since I need that machine running): at graphics init, entire system
hangs. :P

>> I figured since g4 was busted, surely q35 was too, since it's even
>> older...
>
> Oh no, they all have different failures. Intel never actually *tested*
> their graphics hardware before shipping it, but IIRC it was only Q4x
> where we concluded the hardware was just too broken to live.

Wheee!

-Kees

-- 
Kees Cook
Nexus Security
