From: Daniel Kurtz <djkurtz@google.com>
Subject: Re: [PATCH v8 3/5] memory: mediatek: Add SMI driver
Date: Thu, 28 Jan 2016 20:34:54 +0800
Message-ID: <CAGS+omBroFU2no3iHKogOV9c_aAxULiYKKYDjTCmVgeJ-ryGHw@mail.gmail.com>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com> <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream <srv_heupstream@mediatek.com>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Paul Bolle <pebolle@tiscali.nl>, Arnd Bergmann <arnd@arndb.de>, mitchelh@cod
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 26, 2016 at 12:12 PM, Yong Wu <yong.wu@mediatek.com> wrote:
> This patch add SMI(Smart Multimedia Interface) driver. This driver
> is responsible to enable/disable iommu and control the power domain
> and clocks of each local arbiter.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
Tested-by: Daniel Kurtz <djkurtz@chromium.org>

Thanks!
