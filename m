From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v6 16/22] memory: mtk-smi: Add bus_sel for mt8183
Date: Tue, 19 Feb 2019 15:31:35 -0800
Message-ID: <CAE=gft4A=MEYUwwgj4RCT=8Vz_qxbmPo8uG3Mf-HJwC0Zn0-9g@mail.gmail.com>
References: <1550394300-17420-1-git-send-email-yong.wu@mediatek.com> <1550394300-17420-17-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550394300-17420-17-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com, Matthias Kaehlcke <mka@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Feb 17, 2019 at 1:09 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> There are 2 mmu cells in a M4U HW. we could adjust some larbs entering
> mmu0 or mmu1 to balance the bandwidth via the smi-common register
> SMI_BUS_SEL(0x220)(Each larb occupy 2 bits).
>
> In mt8183, For better performance, we switch larb1/2/5/7 to enter
> mmu1 while the others still keep enter mmu0.
>
> In mt8173 and mt2712, we don't get the performance issue,
> Keep its default value(0x0), that means all the larbs enter mmu0.
>
> Note: smi gen1(mt2701/mt7623) don't have this bus_sel.
>
> And, the base of smi-common is completely different with smi_ao_base
> of gen1, thus I add new variable for that.
>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
