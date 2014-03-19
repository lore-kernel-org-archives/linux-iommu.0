From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 17/27] iommu/exynos: remove calls to Runtime PM API
	functions
Date: Wed, 19 Mar 2014 18:30:14 +0100
Message-ID: <5329D426.9020706@samsung.com>
References: <20140314140843.ba055f28dd7ed59c46088029@samsung.com>
	<5322FD14.5090602@samsung.com>
	<20140318185605.0380c8dfe6559c06183092e5@samsung.com>
	<532861BE.7020601@samsung.com>
	<20140319100304.5e26fa43ccdfc29178b058e1@samsung.com>
	<532997D7.6090608@samsung.com>
	<CANEJEGuYz28dGT+264CYtG+Tk6htOq=u-t4PWMtsij32X0vJFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <CANEJEGuYz28dGT+264CYtG+Tk6htOq=u-t4PWMtsij32X0vJFA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Grant,

On 19.03.2014 18:03, Grant Grundler wrote:
> On Wed, Mar 19, 2014 at 6:12 AM, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> ...
>> No. Proper Linux drivers must support deferred probing mechanism and there
>> should be no assumptions about probing orders. Using other initcall level
>> than module_initcall for particular drivers is strongly discouraged.
>
> That's true for "end-point" devices. It's not true for
> "infrastructure": Memory, CPU, DMA, Interrupt handling, etc. Those
> need to be in place before "normal" drivers get called. This SysMMU
> driver provides DMA services for "normal" device drivers. Or do I see
> that wrong?

Of course using an early initcall level would give you some kind of 
guarantees, but it wouldn't guarantee that someone couldn't lower 
initcall level for some MMU client driver and break the ordering anyway.

As I said, AFAIK the trend is to get rid of ordering by initcalls and 
make sure that drivers can handle missing dependencies properly, even 
for "services" such as DMA, GPIO, clocks and so on, which after all are 
provided by normal drivers like other.

>
> thanks,
> grant
>
> ps. I've written IOMMU support for four different IOMMUs on three
> operating systems (See drivers/parisc for two linux examples). But I
> still feel like I at best have 80% understanding of how this one is
> organized/works. Abstract descriptions and convoluted code have been
> handicapping me (and lack of time to dig further).

Well, this is one of my concerns with this driver. It isn't easy to read 
(and so review, maintain, extend and debug found issues).

Best regards,
Tomasz
