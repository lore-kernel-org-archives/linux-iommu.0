From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2 4/6] soc: mediatek: Add SMI driver
Date: Thu, 21 May 2015 15:38:28 +0800
Message-ID: <1432193908.5092.14.camel@mhfsdcap03>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
	 <1431683009-18158-5-git-send-email-yong.wu@mediatek.com>
	 <CABuKBeJvh2PGi3i6O0uu-7ggdBzKMb3tPE_XKhT1i-+tkKc5gg@mail.gmail.com>
	 <1432188990.5092.12.camel@mhfsdcap03>
	 <CABuKBe+FmAzr_Cu=fUDwDHYzH4mW_2p4z1SYmp7+W=Tu-MLEuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABuKBe+FmAzr_Cu=fUDwDHYzH4mW_2p4z1SYmp7+W=Tu-MLEuA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream <srv_heupstream@mediatek.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, iommu@lists.linux-foundation.org, Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>, mitchelh@codeaurora.org, k.zhang@mediatek.com, youhua.li@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Thu, 2015-05-21 at 09:30 +0200, Matthias Brugger wrote:
> 2015-05-21 8:16 GMT+02:00 Yong Wu <yong.wu@mediatek.com>:
> > Hi Matthias,
> >      Thanks very much for your suggestion.
> >      Abort the smi clock name, Could you help check below.
> >      The others I will improve in next time.
> >
> > On Tue, 2015-05-19 at 13:14 +0200, Matthias Brugger wrote:
> >> 2015-05-15 11:43 GMT+02:00 Yong Wu <yong.wu@mediatek.com>:
> >> >     This patch add SMI(Smart Multimedia Interface) driver. This driver is
> >> > responsible to enable/disable iommu and control the clocks of each local arbiter.
> >> >
> > [snip]
> >> > +
> >> > +#define SMI_LARB_MMU_EN                (0xf00)
> >> > +#define F_SMI_MMU_EN(port)     (1 << (port))
> >> > +
> >> > +enum {
> >> > +       MTK_CLK_APB,
> >> > +       MTK_CLK_SMI,
> >> > +       MTK_CLK_MAX,
> >>
> >> Maybe add something like:
> >> MTK_CLK_FIRST = MTK_CLK_APB,
> >> to make the for loops better readable.
> >>
> > Then, Is it like this? :
> >  enum {
> >         MTK_CLK_FIRST = MTK_CLK_APB,
> >         MTK_CLK_SMI,
> >         MTK_CLK_MAX,
> >  }
> > or the CLK_SMI also need MTK_CLK_SECOND = MTK_CLK_SMI.
> 
> 
> something like:
> enum {
>          MTK_CLK_FIRST,
>          MTK_CLK_APB = MTK_CLK_FIRST,
>          MTK_CLK_SMI,
>          MTK_CLK_LAST,
> }
> 
> So you can rewrite the for loop:
> if (i = MTK_CLK_FIRST; i < MTK_CLK_LAST; i++)
Get it.
Thanks very much.
> 
> Regards,
> Matthias
> 
> >> > +};
> >> > +
> >> > +struct mtk_smi_common {
> >> > +       void __iomem            *base;
> >>
> >> That seems to be never used. Please delete it.
> >>
> >> > +       struct clk              *clk[MTK_CLK_MAX];
> >> > +};
> >> > +
> >> > +struct mtk_smi_larb {
> >> > +       void __iomem            *base;
> >> > +       spinlock_t              portlock; /* lock for config port */
> >> > +       struct clk              *clk[MTK_CLK_MAX];
> >> > +       struct device           *smi;
> >> > +};
> >> > +
> >> Thanks,
> >> Matthias
> >
> >
> 
> 
> 
