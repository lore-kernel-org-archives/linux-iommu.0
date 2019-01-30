From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v5 03/20] memory: mtk-smi: Use a general config_port interface
Date: Wed, 30 Jan 2019 10:27:52 -0800
Message-ID: <CAE=gft6AouN2DDzgF6d4f52n+mqiOyeeKg1=Og+=YxQsMoBnLw@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-4-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546314952-15990-4-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The config_port of mt2712 and mt8183 are the same. Use a general
> config_port interface instead.
>
> In addition, in mt2712, larb8 and larb9 are the bdpsys larbs which
> are not the normal larb, their register space are different from the
> normal one. thus, we can not call the general config_port. In mt8183,
> IPU0/1 and CCU connect with smi-common directly, they also are not
> the normal larb. Hence, we add a "larb_direct_to_common_mask" for these
> larbs which connect to smi-commmon directly.
>
> This is also a preparing patch for adding mt8183 SMI support.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
