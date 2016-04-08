From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dma/iommu: Add pgsize_bitmap confirmation in
	__iommu_dma_alloc_pages
Date: Fri, 8 Apr 2016 10:34:10 -0700
Message-ID: <CAD=FV=XbL6gbdmX62Q3QJQ6R-rC7cCd44RLPgK3kvhAC49BJjA@mail.gmail.com>
References: <1459146732-15620-1-git-send-email-yong.wu@mediatek.com>
	<20160329170238.GK6745@arm.com>
	<CAD=FV=XdZwg8usj3bjM6W=A0Yk1AFqKFRadpiS-LGLwxVNxp7A@mail.gmail.com>
	<20160408130733.GD23750@arm.com>
	<CAD=FV=VbekVUHW3=d0icSgUO1M-1cccwCAZ+s=YSzOtEveCQag@mail.gmail.com>
	<20160408173002.GJ23750@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160408173002.GJ23750-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Fri, Apr 8, 2016 at 10:30 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > Am I barking up the wrong tree?
>>
>> I don't think min_order can be negative.  Certainly we could enter the
>> loop with order == 0 and min_order == 0, though.
>
> ... and in that case, PageCompound will be false, and we'll call split_page
> which won't do anything, so we break out.
>
>>
>> Some examples:
>>
>> order = 0, min_order = 0
>> -> Want alloc_pages _without_ __GFP_NORETRY.  OK
>> -> If alloc_pages fails, return NULL.  OK
>> -> If alloc pages succeeds, don't need splitting since single page.  OK
>
> [...]
>
>> I think those are all right.  Did I mess up?  You could certainly
>> structure the loop in a different way but you need to make sure you
>> handle all of those cases.  If you have an alternate structure that
>> handles all those, let's consider it.
>
> Right, I don't think the code is broken, I just think the !order check is
> confusing and not needed.

Ah ha!  Got it.  I didn't dig into split_page() to see that it was a
no-op when "order == 0".  I just know that the old code didn't call
split_page() with order == 0 so I assumed that was wise to keep.  If
we don't need to keep that then agreed that the "if" test can simply
be removed.  :)

-Doug
