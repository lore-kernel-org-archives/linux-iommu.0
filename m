From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 0/8] MT2712 IOMMU SUPPORT
Date: Tue, 22 Aug 2017 16:38:37 +0200
Message-ID: <20170822143836.ac3faa7wcwfjtvjc@8bytes.org>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, honghui.zhang@mediatek.com, k.zhang@mediatek.com, cloud.zhou@mediatek.com
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 21, 2017 at 07:00:13PM +0800, Yong Wu wrote:
> Yong Wu (8):
>   dt-bindings: mediatek: Add binding for mt2712 IOMMU and SMI
>   iommu/mediatek: Move MTK_M4U_TO_LARB/PORT into mtk_iommu.c
>   iommu/mediatek: Add mt2712 IOMMU support
>   iommu/mediatek: Merge 2 M4U HWs into one iommu domain
>   iommu/mediatek: Move pgtable allocation into domain_alloc
>   iommu/mediatek: Disable iommu clock when system suspend
>   iommu/mediatek: Enlarge the validate PA range for 4GB mode
>   memory: mtk-smi: Degrade SMI init to module_init

Applied patches 2-7. Patch 1 is something for Matthias.
