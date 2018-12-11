From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 00/18] MT8183 IOMMU SUPPORT
Date: Tue, 11 Dec 2018 10:52:06 +0100
Message-ID: <20181211095206.hj7bnddgv2hqvm4w@8bytes.org>
References: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1544258371-4600-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Wu <yong.wu@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, Will Deacon <will.deacon@arm.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Sat, Dec 08, 2018 at 04:39:13PM +0800, Yong Wu wrote:
> Arvind Yadav (1):
>   iommu/mediatek: Constify iommu_ops
> 
> Yong Wu (17):
>   dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
>   iommu/mediatek: Use a struct as the platform data
>   memory: mtk-smi: Use a general config_port interface
>   memory: mtk-smi: Use a struct for the platform data for smi-common
>   iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
>     helpers
>   iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
>   iommu/mediatek: Add bclk can be supported optionally
>   iommu/mediatek: Add larb-id remapped support
>   memory: mtk-smi: Add gals support
>   iommu/mediatek: Add mt8183 IOMMU support
>   iommu/mediatek: Add mmu1 support
>   memory: mtk-smi: Invoke pm runtime_callback to enable clocks
>   memory: mtk-smi: Add bus_sel for mt8183
>   iommu/mediatek: Fix VLD_PA_RANGE register backup when suspend
>   iommu/mediatek: Add shutdown callback
>   memory: mtk-smi: Get rid of need_larbid
>   iommu/mediatek: Switch to SPDX license identifier

If Matthias is okay with these patches, I'll queue them for v4.21.


Regards,

	Joerg
