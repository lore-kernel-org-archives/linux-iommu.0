From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 0/3] Rockchip IOMMU driver and devicetree bindings
Date: Thu, 23 Oct 2014 18:23 +0200
Message-ID: <2804227.ziAnEUAn0E@diego>
References: <1412158843-8115-1-git-send-email-djkurtz@chromium.org> <20141022152019.GK10074@8bytes.org> <CAGS+omB+si1J-gjyvyjJF0x=QBTyPyNKbqyV0QM=sKNo9zecDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGS+omB+si1J-gjyvyjJF0x=QBTyPyNKbqyV0QM=sKNo9zecDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Simon Xue <xxm@rock-chips.com>, Grant Grundler <grundler@chromium.org>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Am Freitag, 24. Oktober 2014, 00:11:06 schrieb Daniel Kurtz:
> On Wed, Oct 22, 2014 at 11:20 PM, Joerg Roedel <joro@8bytes.org> wrote:
> > On Wed, Oct 01, 2014 at 06:20:40PM +0800, Daniel Kurtz wrote:
> > > Add a driver and devicetree bindings for the IOMMU found in Rockchip
> > 
> > RK3288
> > 
> > > SoCs.
> > > 
> > > Daniel Kurtz (3):
> > >   iommu/rockchip: rk3288 iommu driver
> > >   dt-bindings: iommu: Add documentation for rockchip iommu
> > >   ARM: dts: rk3288: add VOP iommu nodes
> > >  
> > >  .../devicetree/bindings/iommu/rockchip,iommu.txt   |  26 +
> > >  arch/arm/boot/dts/rk3288.dtsi                      |  18 +
> > >  drivers/iommu/Kconfig                              |  11 +
> > >  drivers/iommu/Makefile                             |   1 +
> > >  drivers/iommu/rockchip-iommu.c                     | 924
> > 
> > +++++++++++++++++++++
> > 
> > >  5 files changed, 980 insertions(+)
> > >  create mode 100644
> > 
> > Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> > 
> > >  create mode 100644 drivers/iommu/rockchip-iommu.c
> > 
> > Please make sure you also get Acks for the DT bindings. With that and
> > the issue I mentioned in the other email fixed, I will apply these
> > patches?
> 
> Hi Joerg,
> 
> Thanks for your reviews.
> Can you help me get these DT bindings Acked?
> AFAICT, the DT maintainers are CC'ed on this patch, I'm not sure what else
> to do.

I think the generally accepted way is, to give the dt maintainers an 
appropriate amount of time [0] to complain and assume an implicit ack if no 
complaint arrives.

This is especially true, as the dt-binding for the iommu itself does not even 
introduce any new properties and simply uses widely established ones.


As a sidenote ... I'd like to take the dts changes in patch 3, once Joerg 
takes patches 1 and 2.


Heiko



[0] 3 weeks seems to be the most widely used timespan
