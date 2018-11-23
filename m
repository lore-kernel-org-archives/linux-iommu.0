From: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v3 00/15] MT8183 IOMMU SUPPORT
Date: Fri, 23 Nov 2018 10:55:10 +0800
Message-ID: <1542941710.15759.8.camel@mhfsdcap03>
References: <1542422142-30688-1-git-send-email-yong.wu@mediatek.com>
         <20181122125931.GC1586@8bytes.org> <20181122133526.GA13896@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122133526.GA13896@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tfiga@google.com>, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, arnd@arndb.de, yingjoe.chen@mediatek.com, youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>, Arvind Yadav <arvind.yadav.cs@gmail.com>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2018-11-22 at 13:35 +0000, Will Deacon wrote:
> On Thu, Nov 22, 2018 at 01:59:31PM +0100, Joerg Roedel wrote:
> > On Sat, Nov 17, 2018 at 10:35:27AM +0800, Yong Wu wrote:
> > > Yong Wu (14):
> > >   dt-bindings: mediatek: Add binding for mt8183 IOMMU and SMI
> > >   iommu/mediatek: Use a struct as the platform data
> > >   memory: mtk-smi: Use a general config_port interface
> > >   iommu/io-pgtable-arm-v7s: Add paddr_to_iopte and iopte_to_paddr
> > >     helpers
> > >   iommu/io-pgtable-arm-v7s: Extend MediaTek 4GB Mode
> > >   iommu/mediatek: Add mt8183 IOMMU support
> > >   iommu/mediatek: Add mmu1 support
> > >   memory: mtk-smi: Invoke pm runtime_callback to enable clocks
> > >   memory: mtk-smi: Use a struct for the platform data for smi-common
> > >   memory: mtk-smi: Add bus_sel for mt8183
> > >   iommu/mediatek: Add VLD_PA_RANGE register backup when suspend
> > >   iommu/mediatek: Add shutdown callback
> > >   memory: mtk-smi: Get rid of need_larbid
> > >   iommu/mediatek: Switch to SPDX license identifier
> > 
> > This should probably go through the IOMMU tree. For that I'd like to
> > have Acks (reviews are even better) for the io-pgtable parts from Robin
> > and for the memory parts from Matthias first.
> 
> Robin already reviewed the pgtable bits, I think.

Thanks Joerg/Will for your comment.

Hi Matthias,

  Could you help also have a look at this patchset? Especially for the
memory part. Thanks in advance.

> 
> Will
