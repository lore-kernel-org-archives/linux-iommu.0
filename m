From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 2/5] dt-bindings: mediatek: Add smi dts binding
Date: Tue, 26 Jan 2016 16:00:19 -0600
Message-ID: <20160126220019.GA23765@rob-hp-laptop>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-3-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453781562-23556-3-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, p.zabel@pengutronix.de, youhua.li@mediatek.com, kendrick.hsu@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Tue, Jan 26, 2016 at 12:12:39PM +0800, Yong Wu wrote:
> This patch add smi binding document and smi local arbiter header file.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../memory-controllers/mediatek,smi-common.txt     |  24 +++++
>  .../memory-controllers/mediatek,smi-larb.txt       |  25 +++++
>  include/dt-bindings/memory/mt8173-larb-port.h      | 111 +++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h

Acked-by: Rob Herring <robh@kernel.org>
