Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51458C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 12:21:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C5320786
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 12:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C5320786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2EDE98677F;
	Wed, 27 Jan 2021 12:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h1NnMvQNa393; Wed, 27 Jan 2021 12:21:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3EC6186508;
	Wed, 27 Jan 2021 12:21:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23C23C0FA7;
	Wed, 27 Jan 2021 12:21:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7273C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 12:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 981C52263C
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 12:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCnmKjOQfODl for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 12:21:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by silver.osuosl.org (Postfix) with ESMTPS id 3EF8021FA9
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 12:21:48 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id j18so1362783wmi.3
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 04:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gckU0hjkV6u+WLSZ0Uxc02xkrz2/Y5EjXOLVr1Tnw1E=;
 b=u3GdDuYLMDV6/Pdo/4WZ/zFMQGlrrDMrG4R/w2sxEnm6opHLA0IENoIS2qDjboWmdz
 FwP/c5vijE7Qvsm5jzeX7i25pnGUm4Fodj7hHjrhB0mPOMZMb+fFHpoElenOAOvmSY6D
 OUvVj64dJEF1DhmM1uKW3cTbJbuFCG+XzvhU3Z/VgyM/PL8MvTcI5bfIA3WXFzDuXzuk
 gD88FKfF653iBkFc2DK9TABVG2U0Wn6TH1oW375HSqNpEZc3444ByEQcryJD/TVQWg6g
 qAyNTZDVu8CThLNxdj1b6BntkFJyupLUEYlKLQjzwl4gRKCuXfFNPoBDVfkGVJfzPuz/
 wC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gckU0hjkV6u+WLSZ0Uxc02xkrz2/Y5EjXOLVr1Tnw1E=;
 b=CZKRQZSJL7eDYknHnF7aXtggpZxDVt0tlM33GlaTjr4Jbwloz0IQPPtBbLLxEvDz2s
 nEXEv/rMkVX+8JUOekkYJvUMAE+v4z2XcX9gNXOLXaTmRkIvpm4kA0o0BNv9/NgxDwHk
 tfqd2pn9VdY+Dmfj0bVzBqkppu6PkD2AyMuUo3Dn4IHdqwBrW63zhZ/0vkaf7xWpzgZN
 pN8aYyB9w8bgy/Wf4tf3gaZAPXI4L2hwx23M78BDpHjQaGmEaHwljp6pN5dHkAErqO1K
 2eui7x5oGGavDZYnmG1/Ek0QF3aR34Cyor6VGbeVEjd483YqzTgRbuyBL4KYQXrQ5NQX
 2oAw==
X-Gm-Message-State: AOAM531NKTdw4eqgnHFS4EnKKqAHTf8pQRCwrt6a2dcaiZWqkv6Z7gjM
 LJePvmnSZIzYNMEiKS4mEZzhtJpMiVNGSWq1m6Y=
X-Google-Smtp-Source: ABdhPJzEAjsgk+EvNIKpuStnVSuk214yNUyZEU6TEKorXzQOZMwZzUMCgqYEL7fTYmGJS0EvmBMPheoC9F+EzIPXMXE=
X-Received: by 2002:a1c:5456:: with SMTP id p22mr4015377wmi.81.1611750106575; 
 Wed, 27 Jan 2021 04:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20210121112349.421464-1-zhang.lyra@gmail.com>
 <20210121112349.421464-3-zhang.lyra@gmail.com>
 <a3f6a285-6eb3-3cd9-3571-9bf30034e080@arm.com>
In-Reply-To: <a3f6a285-6eb3-3cd9-3571-9bf30034e080@arm.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 27 Jan 2021 20:21:09 +0800
Message-ID: <CAAfSe-su3k+7oJRbC04cYvLUrmSsAD2h=DUE0B-gVAoad0nJgA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iommu: add Unisoc iommu basic driver
To: Robin Murphy <robin.murphy@arm.com>
Cc: DTML <devicetree@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Kevin Tang <kevin.tang@unisoc.com>, gavin.li@unisoc.com,
 Baolin Wang <baolin.wang7@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 22 Jan 2021 at 05:46, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-01-21 11:23, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > This patch only adds display iommu support, the driver was tested with sprd
> > dpu and image codec processor.
> >
> > The iommu support for others would be added once finished tests with those
> > devices, such as a few signal processors, including VSP(video),
> > GSP(graphic), ISP(image), and camera CPP, etc.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >   drivers/iommu/Kconfig      |  12 +
> >   drivers/iommu/Makefile     |   1 +
> >   drivers/iommu/sprd-iommu.c | 566 +++++++++++++++++++++++++++++++++++++
> >   3 files changed, 579 insertions(+)
> >   create mode 100644 drivers/iommu/sprd-iommu.c
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index 192ef8f61310..79af62c519ae 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -408,4 +408,16 @@ config VIRTIO_IOMMU
> >
> >         Say Y here if you intend to run this kernel as a guest.
> >
> > +config SPRD_IOMMU
> > +     tristate "Unisoc IOMMU Support"
> > +     depends on ARCH_SPRD || COMPILE_TEST
> > +     select IOMMU_API
> > +     help
> > +       Support for IOMMU on Unisoc's SoCs on which multi-media subsystems
> > +       need IOMMU, such as DPU, Image codec(jpeg) processor, and a few
> > +       signal processors, including VSP(video), GSP(graphic), ISP(image), and
> > +       CPP, etc.
> > +
> > +       Say Y here if you want multi-media functions.
> > +
> >   endif # IOMMU_SUPPORT
> > diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> > index 61bd30cd8369..5925b6af2123 100644
> > --- a/drivers/iommu/Makefile
> > +++ b/drivers/iommu/Makefile
> > @@ -28,3 +28,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
> >   obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
> >   obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
> >   obj-$(CONFIG_IOMMU_SVA_LIB) += iommu-sva-lib.o
> > +obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
> > diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
> > new file mode 100644
> > index 000000000000..44cde44017fa
> > --- /dev/null
> > +++ b/drivers/iommu/sprd-iommu.c
> > @@ -0,0 +1,566 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Unisoc IOMMU driver
> > + *
> > + * Copyright (C) 2020 Unisoc, Inc.
> > + * Author: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/device.h>
> > +#include <linux/dma-iommu.h>
>
> You need <linux/dma-mapping.h> since you're using the DMA API.
>
> > +#include <linux/errno.h>
> > +#include <linux/iommu.h>
> > +#include <linux/module.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/slab.h>
> > +
> > +/* SPRD IOMMU page is 4K size alignment */
> > +#define SPRD_IOMMU_PAGE_SHIFT        12
> > +#define SPRD_IOMMU_PAGE_SIZE SZ_4K
> > +
> > +#define SPRD_EX_CFG          0x0
> > +#define SPRD_IOMMU_VAOR_BYPASS       BIT(4)
> > +#define SPRD_IOMMU_GATE_EN   BIT(1)
> > +#define SPRD_IOMMU_EN                BIT(0)
> > +#define SPRD_EX_UPDATE               0x4
> > +#define SPRD_EX_FIRST_VPN    0x8
> > +#define SPRD_EX_VPN_RANGE    0xc
> > +#define SPRD_EX_FIRST_PPN    0x10
> > +#define SPRD_EX_DEFAULT_PPN  0x14
> > +
> > +#define SPRD_IOMMU_VERSION   0x0
> > +#define SPRD_VERSION_MASK    GENMASK(15, 8)
> > +#define SPRD_VERSION_SHIFT   0x8
> > +#define SPRD_VAU_CFG         0x4
> > +#define SPRD_VAU_UPDATE              0x8
> > +#define SPRD_VAU_AUTH_CFG    0xc
> > +#define SPRD_VAU_FIRST_PPN   0x10
> > +#define SPRD_VAU_DEFAULT_PPN_RD      0x14
> > +#define SPRD_VAU_DEFAULT_PPN_WR      0x18
> > +#define SPRD_VAU_FIRST_VPN   0x1c
> > +#define SPRD_VAU_VPN_RANGE   0x20
> > +
> > +enum sprd_iommu_version {
> > +     SPRD_IOMMU_EX,
> > +     SPRD_IOMMU_VAU,
> > +};
> > +
> > +struct sprd_iommu_match_data {
> > +     unsigned long reg_offset;
> > +};
> > +
> > +/*
> > + * struct sprd_iommu_device - high-level sprd iommu device representation,
> > + * including hardware information and configuration, also driver data, etc
> > + *
> > + * @mdata:   hardware configuration and information
> > + * @ver:     sprd iommu device version
> > + * @prot_page:       protect page base address, data would be written to here
> > + *           while translation fault
> > + * @base:    mapped base address for accessing registers
> > + * @dev:     pointer to basic device structure
> > + * @iommu:   IOMMU core representation
> > + * @group:   IOMMU group
> > + */
> > +struct sprd_iommu_device {
> > +     const struct sprd_iommu_match_data *mdata;
> > +     enum sprd_iommu_version ver;
> > +     u32                     *prot_page_va;
> > +     dma_addr_t              prot_page_pa;
> > +     void __iomem            *base;
> > +     struct device           *dev;
> > +     struct iommu_device     iommu;
> > +     struct iommu_group      *group;
> > +};
> > +
> > +struct sprd_iommu_domain {
> > +     spinlock_t              pgtlock; /* lock for page table */
> > +     struct iommu_domain     domain;
> > +     u32                     *pgt_va; /* page table virtual address base */
> > +     dma_addr_t              pgt_pa; /* page table physical address base */
> > +     struct sprd_iommu_device        *sdev;
> > +};
> > +
> > +static const struct iommu_ops sprd_iommu_ops;
> > +
> > +static struct sprd_iommu_domain *to_sprd_domain(struct iommu_domain *dom)
> > +{
> > +     return container_of(dom, struct sprd_iommu_domain, domain);
> > +}
> > +
> > +static inline void
> > +sprd_iommu_writel(struct sprd_iommu_device *sdev, unsigned int reg, u32 val)
> > +{
> > +     writel_relaxed(val, sdev->base + sdev->mdata->reg_offset + reg);
> > +}
> > +
> > +static inline u32
> > +sprd_iommu_readl(struct sprd_iommu_device *sdev, unsigned int reg)
> > +{
> > +     return readl_relaxed(sdev->base + sdev->mdata->reg_offset + reg);
> > +}
> > +
> > +static inline void
> > +sprd_iommu_update_bits(struct sprd_iommu_device *sdev, unsigned int reg,
> > +               u32 mask, u32 shift, u32 val)
> > +{
> > +     u32 t = sprd_iommu_readl(sdev, reg);
> > +
> > +     t = (t & (~(mask << shift))) | ((val & mask) << shift);
> > +     sprd_iommu_writel(sdev, reg, t);
> > +}
> > +
> > +static inline int
> > +sprd_iommu_get_version(struct sprd_iommu_device *sdev)
> > +{
> > +     int ver = (sprd_iommu_readl(sdev, SPRD_IOMMU_VERSION) &
> > +                SPRD_VERSION_MASK) >> SPRD_VERSION_SHIFT;
> > +
> > +     switch (ver) {
> > +     case SPRD_IOMMU_EX:
> > +     case SPRD_IOMMU_VAU:
> > +             return ver;
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static size_t
> > +sprd_iommu_pgt_size(struct iommu_domain *domain)
> > +{
> > +     return (size_t) (((domain->geometry.aperture_end -
> > +                        domain->geometry.aperture_start + 1) >>
> > +                       SPRD_IOMMU_PAGE_SHIFT) * 4);
>
> Nit: it's *reasonably* obvious, but "sizeof(u32)" might be more
> foolproof than just "4".
>
> Also the cast doesn't do anything that the implicit conversion in the
> return doesn't already.
>
> > +}
> > +
> > +static struct iommu_domain *sprd_iommu_domain_alloc(unsigned int domain_type)
> > +{
> > +     struct sprd_iommu_domain *dom;
> > +
> > +     if (domain_type != IOMMU_DOMAIN_DMA && domain_type != IOMMU_DOMAIN_UNMANAGED)
> > +             return NULL;
> > +
> > +     dom = kzalloc(sizeof(*dom), GFP_KERNEL);
> > +     if (!dom)
> > +             return NULL;
> > +
> > +     if (iommu_get_dma_cookie(&dom->domain)) {
> > +             kfree(dom);
> > +             return NULL;
> > +     }
> > +
> > +     spin_lock_init(&dom->pgtlock);
> > +
> > +     dom->domain.geometry.aperture_start = 0;
> > +     dom->domain.geometry.aperture_end = SZ_256M - 1;
> > +
> > +     return &dom->domain;
> > +}
> > +
> > +static void sprd_iommu_domain_free(struct iommu_domain *domain)
> > +{
> > +     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > +
>
> iommu_put_dma_cookie(domain);
>
> > +     kfree(dom);
> > +}
> > +
> > +static void sprd_iommu_first_vpn(struct sprd_iommu_domain *dom)
> > +{
> > +     struct sprd_iommu_device *sdev = dom->sdev;
> > +     u32 val;
> > +     unsigned int reg;
> > +
> > +     if (sdev->ver == SPRD_IOMMU_EX)
> > +             reg = SPRD_EX_FIRST_VPN;
> > +     else
> > +             reg = SPRD_VAU_FIRST_VPN;
> > +
> > +     val = dom->domain.geometry.aperture_start >> SPRD_IOMMU_PAGE_SHIFT;
> > +     sprd_iommu_writel(sdev, reg, val);
> > +}
> > +
> > +static void sprd_iommu_vpn_range(struct sprd_iommu_domain *dom)
> > +{
> > +     struct sprd_iommu_device *sdev = dom->sdev;
> > +     u32 val;
> > +     unsigned int reg;
> > +
> > +     if (sdev->ver == SPRD_IOMMU_EX)
> > +             reg = SPRD_EX_VPN_RANGE;
> > +     else
> > +             reg = SPRD_VAU_VPN_RANGE;
> > +
> > +     val = (dom->domain.geometry.aperture_end -
> > +            dom->domain.geometry.aperture_start) >> SPRD_IOMMU_PAGE_SHIFT;
> > +     sprd_iommu_writel(sdev, reg, val);
> > +}
> > +
> > +static void sprd_iommu_first_ppn(struct sprd_iommu_domain *dom)
> > +{
> > +     u32 val = dom->pgt_pa >> SPRD_IOMMU_PAGE_SHIFT;
> > +     struct sprd_iommu_device *sdev = dom->sdev;
> > +     unsigned int reg;
> > +
> > +     if (sdev->ver == SPRD_IOMMU_EX)
> > +             reg = SPRD_EX_FIRST_PPN;
> > +     else
> > +             reg = SPRD_VAU_FIRST_PPN;
> > +
> > +     sprd_iommu_writel(sdev, reg, val);
> > +}
> > +
> > +static void sprd_iommu_default_ppn(struct sprd_iommu_device *sdev)
> > +{
> > +     u32 val = sdev->prot_page_pa >> SPRD_IOMMU_PAGE_SHIFT;
> > +
> > +     if (sdev->ver == SPRD_IOMMU_EX) {
> > +             sprd_iommu_writel(sdev, SPRD_EX_DEFAULT_PPN, val);
> > +     } else if (sdev->ver == SPRD_IOMMU_VAU) {
> > +             sprd_iommu_writel(sdev, SPRD_VAU_DEFAULT_PPN_RD, val);
> > +             sprd_iommu_writel(sdev, SPRD_VAU_DEFAULT_PPN_WR, val);
> > +     }
> > +}
> > +
> > +static void sprd_iommu_hw_en(struct sprd_iommu_device *sdev, bool en)
> > +{
> > +     unsigned int reg_cfg;
> > +     u32 mask, val;
> > +
> > +     if (sdev->ver == SPRD_IOMMU_EX)
> > +             reg_cfg = SPRD_EX_CFG;
> > +     else
> > +             reg_cfg = SPRD_VAU_CFG;
> > +
> > +     /* enable mmu, clk gate, vaor bypass */
> > +     mask = SPRD_IOMMU_EN | SPRD_IOMMU_GATE_EN | SPRD_IOMMU_VAOR_BYPASS;
> > +     val = en ? mask : 0;
> > +     sprd_iommu_update_bits(sdev, reg_cfg, mask, 0, val);
> > +}
> > +
> > +static int sprd_iommu_attach_device(struct iommu_domain *domain,
> > +                                 struct device *dev)
> > +{
> > +     struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
> > +     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > +     size_t pgt_size = sprd_iommu_pgt_size(domain);
>
> If you're only supporting a single device per domain you should bail out
> here if dom->sdev is already set.
>
> > +     dom->pgt_va = dma_alloc_coherent(sdev->dev, pgt_size, &dom->pgt_pa, GFP_KERNEL);
> > +     if (!dom->pgt_va)
> > +             return -ENOMEM;
> > +
> > +     dom->sdev = sdev;
> > +
> > +     sprd_iommu_first_ppn(dom);
> > +     sprd_iommu_first_vpn(dom);
> > +     sprd_iommu_vpn_range(dom);
> > +     sprd_iommu_default_ppn(sdev);
> > +     sprd_iommu_hw_en(sdev, true);
> > +
> > +     return 0;
> > +}
> > +
> > +static void sprd_iommu_detach_device(struct iommu_domain *domain,
> > +                                          struct device *dev)
> > +{
> > +     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > +     struct sprd_iommu_device *sdev = dom->sdev;
> > +     size_t pgt_size = sprd_iommu_pgt_size(domain);
> > +
> > +     dma_free_coherent(sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
>
> sdev may be NULL here.
>
> > +     sprd_iommu_hw_en(sdev, false);
> > +     dom->sdev = NULL;
> > +}
> > +
> > +static int sprd_iommu_map(struct iommu_domain *domain, unsigned long iova,
> > +                       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
> > +{
> > +     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > +     const struct sprd_iommu_match_data *mdata;
> > +     unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
> > +     unsigned long flags;
> > +     unsigned int i;
> > +     u32 *pgt_base_iova;
> > +     u32 pabase = (u32)paddr;
> > +     int map_size = 0;
> > +     unsigned long start = domain->geometry.aperture_start;
> > +     unsigned long end = domain->geometry.aperture_end;
> > +
> > +     if (!dom->sdev) {
> > +             pr_err("No sprd_iommu_device attached to the domain\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     mdata = dom->sdev->mdata;
> > +     if (iova < start || (iova + size) > (end + 1)) {
> > +             dev_err(dom->sdev->dev, "(iova(0x%lx) + sixe(0x%lx)) are not in the range!\n",
>
> %zx for printing size_t.
>
> > +                     iova, size);
> > +             return -EINVAL;
> > +     }
> > +
> > +     pgt_base_iova = dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT);
> > +
> > +     spin_lock_irqsave(&dom->pgtlock, flags);
> > +     for (i = 0; i < page_num; i++) {
> > +             pgt_base_iova[i] = pabase >> SPRD_IOMMU_PAGE_SHIFT;
> > +             pabase += SPRD_IOMMU_PAGE_SIZE;
> > +             map_size += SPRD_IOMMU_PAGE_SIZE;
> > +     }
> > +     spin_unlock_irqrestore(&dom->pgtlock, flags);
> > +
> > +     return map_size == size ? 0 : -EEXIST;
>
> Clearly this can never fail.
>
> > +}
> > +
> > +static size_t sprd_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> > +                     size_t size, struct iommu_iotlb_gather *iotlb_gather)
> > +{
> > +     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > +     unsigned long flags;
> > +     u32 *pgt_base_iova;
> > +     unsigned int page_num = size >> SPRD_IOMMU_PAGE_SHIFT;
> > +     unsigned long start = domain->geometry.aperture_start;
> > +     unsigned long end = domain->geometry.aperture_end;
> > +
> > +     if (iova < start || (iova + size) > (end + 1))
> > +             return -EINVAL;
> > +
> > +     pgt_base_iova = dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT);
> > +
> > +     spin_lock_irqsave(&dom->pgtlock, flags);
> > +     memset(pgt_base_iova, 0, page_num * sizeof(u32));
> > +     spin_unlock_irqrestore(&dom->pgtlock, flags);
> > +
> > +     return 0;
> > +}
> > +
> > +static void sprd_iommu_sync_map(struct iommu_domain *domain)
> > +{
> > +     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > +     unsigned int reg;
> > +
> > +     if (dom->sdev->ver == SPRD_IOMMU_EX)
> > +             reg = SPRD_EX_UPDATE;
> > +     else
> > +             reg = SPRD_VAU_UPDATE;
> > +
> > +     /* clear iommu TLB buffer after page table updated */
> > +     sprd_iommu_writel(dom->sdev, reg, 0xffffffff);
> > +}
> > +
> > +static void sprd_iommu_sync(struct iommu_domain *domain,
> > +                              struct iommu_iotlb_gather *iotlb_gather)
> > +{
> > +     sprd_iommu_sync_map(domain);
> > +}
> > +
> > +static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
> > +                                        dma_addr_t iova)
> > +{
> > +     struct sprd_iommu_domain *dom = to_sprd_domain(domain);
> > +     unsigned long flags;
> > +     phys_addr_t pa;
> > +     unsigned long start = domain->geometry.aperture_start;
> > +     unsigned long end = domain->geometry.aperture_end;
> > +
> > +     if (iova < start || iova > end)
> > +             pr_err("iova (0x%llx) exceed the vpn range[0x%lx-0x%lx]!\n",
> > +                    iova, start, end);
> > +
> > +     spin_lock_irqsave(&dom->pgtlock, flags);
> > +     pa = *(dom->pgt_va + ((iova - start) >> SPRD_IOMMU_PAGE_SHIFT));
> > +     pa = pa << SPRD_IOMMU_PAGE_SHIFT;
> > +     spin_unlock_irqrestore(&dom->pgtlock, flags);
> > +
> > +     return pa;
>
> Don't forget to add back the offset - the input address isn't
> necessarily page-aligned (at least you don't have block mappings to
> worry about as well...)

Ok.

>
> > +}
> > +
> > +static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
> > +{
> > +     struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +     struct sprd_iommu_device *sdev;
> > +
> > +     if (!fwspec || fwspec->ops != &sprd_iommu_ops)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     sdev = dev_iommu_priv_get(dev);
> > +
> > +     return &sdev->iommu;
> > +}
> > +
> > +static void sprd_iommu_release_device(struct device *dev)
> > +{
> > +     struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> > +
> > +     if (!fwspec || fwspec->ops != &sprd_iommu_ops)
> > +             return;
> > +
> > +     iommu_fwspec_free(dev);
> > +}
> > +
> > +static struct iommu_group *sprd_iommu_device_group(struct device *dev)
> > +{
> > +     struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
> > +
> > +     if (!sdev)
> > +             return ERR_PTR(-ENODEV);
>
> No need for this check, since iommu_group_get_for_dev() can now only be
> called after you've already handled ->probe_device.
>
> > +
> > +     return iommu_group_ref_get(sdev->group);
> > +}
> > +
> > +static int sprd_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
> > +{
> > +     struct platform_device *pdev;
> > +
> > +     if (!dev_iommu_priv_get(dev)) {
> > +             pdev = of_find_device_by_node(args->np);
> > +             dev_iommu_priv_set(dev, platform_get_drvdata(pdev));
>
> You leak a reference on pdev->dev here.

Will fix it in the next version.

>
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +
> > +static const struct iommu_ops sprd_iommu_ops = {
> > +     .domain_alloc   = sprd_iommu_domain_alloc,
> > +     .domain_free    = sprd_iommu_domain_free,
> > +     .attach_dev     = sprd_iommu_attach_device,
> > +     .detach_dev     = sprd_iommu_detach_device,
> > +     .map            = sprd_iommu_map,
> > +     .unmap          = sprd_iommu_unmap,
> > +     .iotlb_sync_map = sprd_iommu_sync_map,
> > +     .iotlb_sync     = sprd_iommu_sync,
> > +     .iova_to_phys   = sprd_iommu_iova_to_phys,
> > +     .probe_device   = sprd_iommu_probe_device,
> > +     .release_device = sprd_iommu_release_device,
> > +     .device_group   = sprd_iommu_device_group,
> > +     .of_xlate       = sprd_iommu_of_xlate,
> > +     .pgsize_bitmap  = ~0UL << SPRD_IOMMU_PAGE_SHIFT,
> > +};
> > +
> > +static const struct sprd_iommu_match_data sprd_iommu_disp = {
> > +     .reg_offset = 0x800,
> > +};
> > +
> > +static const struct sprd_iommu_match_data sprd_iommu_jpg = {
> > +     .reg_offset = 0x300,
> > +};
>
> Shouldn't those just be part of the base address in the DT to begin
> with? The Rockchip IOMMUs, for example, are all over the place relative
> to the base of whichever media device they're embedded into, and they
> don't care.

I'm considering moving the iommu DT node under into the DT node of the
media device which uses this iommu.

>
> FWIW you can still accommodate your debugging trick without needing an
> excuse for per-instance compatibles in the DT - you could match known
> base addresses at probe to assign your desired IOVA ranges, or
> dynamically assign an IOVA range to each new instance and keep track of
> who got what in debugfs, or wait until probe_device/attach_device and
> inspect the client device itself to see who you belong to.

I considered letting the media devices set IOVA and range, I would
also set a default IOVA start address when allocating the iommu
domain.

>
> > +
> > +static const struct of_device_id sprd_iommu_of_match[] = {
> > +     { .compatible = "sprd,iommu-v1-disp",
> > +       .data = &sprd_iommu_disp },
> > +     { .compatible = "sprd,iommu-v1-jpg",
> > +       .data = &sprd_iommu_jpg },
> > +     { },
> > +};
> > +MODULE_DEVICE_TABLE(of, sprd_iommu_of_match);
> > +
> > +static int sprd_iommu_clk_enable(struct device *dev)
> > +{
> > +     struct clk *eb;
> > +
> > +     eb = of_clk_get(dev->of_node, 0);
> > +     if (IS_ERR_OR_NULL(eb))
> > +             return PTR_ERR(eb);
> > +
> > +     clk_prepare_enable(eb);
> > +
> > +     return 0;
> > +}
>
> Unless you plan to add significant complexity to this very soon, I don't
> think it really needs a separate helper. Also shouldn't you relinquish
> this clock on probe failure and remove?

I meant to do that since the clock is optional, I added comments in
probe(), I should add comments here.
Also I found I should use clk_get_optional() to get the clock reference.

>
> > +static int sprd_iommu_probe(struct platform_device *pdev)
> > +{
> > +     struct sprd_iommu_device *sdev;
> > +     struct device *dev = &pdev->dev;
> > +     int ret;
> > +
> > +     sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
> > +     if (!sdev)
> > +             return -ENOMEM;
> > +
> > +     sdev->base = devm_platform_ioremap_resource(pdev, 0);
> > +     sdev->mdata = device_get_match_data(dev);
> > +
> > +     sdev->prot_page_va = dma_alloc_coherent(dev, SPRD_IOMMU_PAGE_SIZE,
> > +                                             &sdev->prot_page_pa, GFP_KERNEL);
> > +     if (!sdev->prot_page_va)
> > +             return -ENOMEM;
> > +
> > +     platform_set_drvdata(pdev, sdev);
> > +     sdev->dev = dev;
> > +
> > +     /* All the client devices are in the same iommu-group */
> > +     sdev->group = iommu_group_alloc();
> > +     if (IS_ERR(sdev->group)) {
> > +             ret = PTR_ERR(sdev->group);
> > +             goto free_page;
> > +     }
> > +
> > +     ret = iommu_device_sysfs_add(&sdev->iommu, dev, NULL, dev_name(dev));
> > +     if (ret)
> > +             goto put_group;
> > +
> > +     iommu_device_set_ops(&sdev->iommu, &sprd_iommu_ops);
> > +     iommu_device_set_fwnode(&sdev->iommu, &dev->of_node->fwnode);
> > +
> > +     ret = iommu_device_register(&sdev->iommu);
> > +     if (ret)
> > +             goto remove_sysfs;
> > +
> > +     if (!iommu_present(&platform_bus_type))
> > +             bus_set_iommu(&platform_bus_type,  &sprd_iommu_ops);
>
> Nit: extra space after the comma.
>
> > +
> > +     /* access to some iommus are controlled by gate clock, others are not */
>
> The binding doesn't say you can have clocks...

Forgot to add clock property..

>
> > +     sprd_iommu_clk_enable(dev);
> > +
> > +     ret = sprd_iommu_get_version(sdev);
> > +     if (ret < 0) {
> > +             dev_err(dev, "iommu version(%d) is invalid.\n", ret);
> > +             goto unregister_iommu;
> > +     }
> > +     sdev->ver = ret;
> > +
> > +     return 0;
> > +
> > +unregister_iommu:
> > +     iommu_device_unregister(&sdev->iommu);
> > +remove_sysfs:
> > +     iommu_device_sysfs_remove(&sdev->iommu);
> > +put_group:
> > +     iommu_group_put(sdev->group);
> > +free_page:
> > +     dma_free_coherent(sdev->dev, SPRD_IOMMU_PAGE_SIZE, sdev->prot_page_va, sdev->prot_page_pa);
> > +     return ret;
> > +}
> > +
> > +static int sprd_iommu_remove(struct platform_device *pdev)
> > +{
> > +     struct sprd_iommu_device *sdev = platform_get_drvdata(pdev);
> > +
> > +     dma_free_coherent(sdev->dev, SPRD_IOMMU_PAGE_SIZE, sdev->prot_page_va, sdev->prot_page_pa);
>
> Just to confirm, does the sprd_iommu_hw_en(sdev, false) call from
> sprd_iommu_detach_device() effectively guarantee that no more accesses
> can be made to prot_page after that?

From what I understand, prot_page is used for the case that if the
virtual address is in the range of iova addresses, but not mapped to a
physical address, then prot_page was provided for accessing, that
would happen only if iommu is enabled.

Back to your question, prot_page wouldn't be accessed any more after
iommu being disabled by calling sprd_iommu_hw_en(sdev, false).

>
> > +     iommu_group_put(sdev->group);
> > +     sdev->group = NULL;
> > +
> > +     bus_set_iommu(&platform_bus_type, NULL);
> > +
> > +     platform_set_drvdata(pdev, NULL);
> > +     iommu_device_sysfs_remove(&sdev->iommu);
> > +     iommu_device_unregister(&sdev->iommu);
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver sprd_iommu_driver = {
> > +     .driver = {
> > +             .name           = "sprd-iommu",
> > +             .of_match_table = sprd_iommu_of_match,
>
> You probably want ".suppress_bind_attrs = true" as well.

Thanks for your comments, I will address them in the next version.

Chunyan

>
> Robin.
>
> > +
> > +     },
> > +     .probe  = sprd_iommu_probe,
> > +     .remove = sprd_iommu_remove,
> > +};
> > +module_platform_driver(sprd_iommu_driver);
> > +
> > +MODULE_DESCRIPTION("IOMMU driver for Unisoc SoCs");
> > +MODULE_ALIAS("platform:sprd-iommu");
> > +MODULE_LICENSE("GPL v2");
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
