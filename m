From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v5 05/20] iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and
 iopte_to_paddr helpers
Date: Wed, 30 Jan 2019 10:28:30 -0800
Message-ID: <CAE=gft6KiXmP2Dm8ksnATUcy8Mhnfo8wL=SVpwGZrC0M1CoxpA@mail.gmail.com>
References: <1546314952-15990-1-git-send-email-yong.wu@mediatek.com> <1546314952-15990-6-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546314952-15990-6-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Dec 31, 2018 at 7:57 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Add two helper functions: paddr_to_iopte and iopte_to_paddr.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Evan Green <evgreen@chromium.org>
