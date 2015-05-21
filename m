From: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 4/6] soc: mediatek: Add SMI driver
Date: Thu, 21 May 2015 17:20:55 +0200
Message-ID: <CABuKBeJgmwtH4KjfxwPXgvO9Nwaz3o3ha7h99-VdtSNmQ80N5A@mail.gmail.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
	<1431683009-18158-5-git-send-email-yong.wu@mediatek.com>
	<CABuKBeJvh2PGi3i6O0uu-7ggdBzKMb3tPE_XKhT1i-+tkKc5gg@mail.gmail.com>
	<1432188990.5092.12.camel@mhfsdcap03>
	<CABuKBe+FmAzr_Cu=fUDwDHYzH4mW_2p4z1SYmp7+W=Tu-MLEuA@mail.gmail.com>
	<CAGS+omARc60i+8vO6V1ccnSnXkjAGNjMjRB1+5kg_EHrrS1NOw@mail.gmail.com>
	<1432219778.5092.44.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432219778.5092.44.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "open list:IOMMU DRIVERS" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

2015-05-21 16:49 GMT+02:00 Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
> On Thu, 2015-05-21 at 22:33 +0800, Daniel Kurtz wrote:
>> On Thu, May 21, 2015 at 3:30 PM, Matthias Brugger
>> <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > 2015-05-21 8:16 GMT+02:00 Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
>> >> Hi Matthias,
>> >>      Thanks very much for your suggestion.
>> >>      Abort the smi clock name, Could you help check below.
>> >>      The others I will improve in next time.
>> >>
>> >> On Tue, 2015-05-19 at 13:14 +0200, Matthias Brugger wrote:
>> >>> 2015-05-15 11:43 GMT+02:00 Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
>> >>> >     This patch add SMI(Smart Multimedia Interface) driver. This driver is
>> >>> > responsible to enable/disable iommu and control the clocks of each local arbiter.
>> >>> >
>> >> [snip]
>> >>> > +
>> >>> > +#define SMI_LARB_MMU_EN                (0xf00)
>> >>> > +#define F_SMI_MMU_EN(port)     (1 << (port))
>> >>> > +
>> >>> > +enum {
>> >>> > +       MTK_CLK_APB,
>> >>> > +       MTK_CLK_SMI,
>> >>> > +       MTK_CLK_MAX,
>> >>>
>> >>> Maybe add something like:
>> >>> MTK_CLK_FIRST = MTK_CLK_APB,
>> >>> to make the for loops better readable.
>> >>>
>> >> Then, Is it like this? :
>> >>  enum {
>> >>         MTK_CLK_FIRST = MTK_CLK_APB,
>> >>         MTK_CLK_SMI,
>> >>         MTK_CLK_MAX,
>> >>  }
>> >> or the CLK_SMI also need MTK_CLK_SECOND = MTK_CLK_SMI.
>> >
>> >
>> > something like:
>> > enum {
>> >          MTK_CLK_FIRST,
>> >          MTK_CLK_APB = MTK_CLK_FIRST,
>> >          MTK_CLK_SMI,
>> >          MTK_CLK_LAST,
>> > }
>> >
>> > So you can rewrite the for loop:
>> > if (i = MTK_CLK_FIRST; i < MTK_CLK_LAST; i++)
>>
>> Actually, do we ever plan to add more clks per smi node?
> No.
>> If not, perhaps the whole driver would be simpler if you just
>> explicitly handle the apb & smi clocks:
>>
>> struct mtk_smi_larb {
>>        void __iomem            *base;
>>        spinlock_t              portlock; /* lock for config port */
>>        struct device           *smi;
>>        struct clk              *clk_apb;
>>        struct clk              *clk_smi;
>> };
>>
>> And then all of the loops become just a pair of clock operations.
> Thanks. I will try this and compare whether it will add many lines.

If you don't plan to add more clocks in the future, then I think the
suggestion Dan made is the best one.

Regards,
Matthias
-- 
motzblog.wordpress.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
