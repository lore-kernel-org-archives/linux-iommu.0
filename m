From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v5 18/20] iommu/mediatek: Fix VLD_PA_RANGE register backup
 when suspend
Date: Wed, 30 Jan 2019 11:11:59 -0800
Message-ID: <CAE=gft4xwk02tM9cgnLCZDpZgX3z9w8fjXfJxJ7HtzdOaCN7=g@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546314952-15990-19-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 8:00 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> The register VLD_PA_RNG(0x118) was forgot to backup while adding 4GB
> mode support for mt2712. this patch add it.
>
> Fixes: 30e2fccf9512 ("iommu/mediatek: Enlarge the validate PA range
> for 4GB mode")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
