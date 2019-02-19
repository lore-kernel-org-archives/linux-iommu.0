From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 10/22] iommu/mediatek: Move reset_axi into plat_data
Date: Tue, 19 Feb 2019 15:30:43 -0800
Message-ID: <CAE=gft6urwBfjLPjF29UooMbZTVA5h7fLgEmtajsLi5zYoaVUg@mail.gmail.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-11-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550394300-17420-11-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Feb 17, 2019 at 1:08 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> In mt8173 and mt8183, 0x48 is REG_MMU_STANDARD_AXI_MODE while it is
> REG_MMU_CTRL in the other SoCs, and the bits meaning is completely
> different with the REG_MMU_STANDARD_AXI_MODE.
>
> This patch moves this property to plat_data, it's also a preparing
> patch for mt8183.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
