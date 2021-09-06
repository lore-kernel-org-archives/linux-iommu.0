Return-Path: <SRS0=Z7zF=N4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AC1C433F5
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 19:51:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D55106069E
	for <iommu@archiver.kernel.org>; Mon,  6 Sep 2021 19:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D55106069E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99ED76068C;
	Mon,  6 Sep 2021 19:51:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5oNIjLvp-DF; Mon,  6 Sep 2021 19:51:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6AC8C60873;
	Mon,  6 Sep 2021 19:51:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A011C001C;
	Mon,  6 Sep 2021 19:51:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA539C001B
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 19:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D52174029A
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 19:51:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MHX4HUbYibxJ for <iommu@lists.linux-foundation.org>;
 Mon,  6 Sep 2021 19:51:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 75574400C5
 for <iommu@lists.linux-foundation.org>; Mon,  6 Sep 2021 19:51:46 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id mf2so15282596ejb.9
 for <iommu@lists.linux-foundation.org>; Mon, 06 Sep 2021 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pYOIpfoLo1TtPOzly7mCruZDinHXZD4jqzh3rEOq7zU=;
 b=s3VQGvmRtztPI/5nkbWDZhH4pFe2TIABlDp9Z4ocjsCKX4PDE5lS0Xfw2D3tPHfE0K
 IRdlSlSYBRq3ksBcjj4FlA1WQgfp9k0TsJ/VPYDPK/9CrKI8Oivb9TrxVV9lhjqXRARK
 Z6UNm59nnYqVrlDeEcWV46FrlSEhEorZJIOZ9CrAhRqECaTzeMAxSwfxopz83GR7C4jE
 87yuKzScHDkbr42z4doa7OOaiRxeCFV16WoK5GLhM2yFM8wErVYhGp8IbbS64WuSE7Gj
 TB/pyQIvrHjVn2Q2+znoBB1ZKsSKEO1B/Ehwkwwafs9nQpWMkEBS8WD24g0+k+z6BTtj
 9SWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pYOIpfoLo1TtPOzly7mCruZDinHXZD4jqzh3rEOq7zU=;
 b=uKhtJEhNmBoqRmvDPbD7zBR/JKUVSy2eHADHrt+zwUnv/EXdSdMHxXC/ZzBF+ZfRi3
 87+Hu+fh9KuctXokbhExSUwNTqF+PYnsGbLrm3epFTBnmuPpp76I7L7W/2BHT1WcxmO7
 4lSExFro+FsB9WpnBpI1bw6dDchu3xbtEGUN7IkWazf/1CttPIMshkFSZEwnzFZOrcct
 AKOg4+sBlNoP+/K7mVi8a01NcBE+vpH9G0MUXzccO0ytYU7gFrv96hiOQrD3z6qfTnv9
 jKrt6h4e7/eE5Q9S7PT6jZ3lVaC01MdcWpTATQ6ZB97eLhf03j2qVGGEWnLaAqaqimAJ
 FW2A==
X-Gm-Message-State: AOAM530/XyZ3s+oKAJ+ESp26aWqMYuH7f8Uc1zU2PJxzxVmIHSkBZnYa
 YPukeXZx3fABnBUwoWhvSKiaNY2tal5E6A0a/oUnrw==
X-Google-Smtp-Source: ABdhPJzNmHxJtz1P9ezhqHwwF8nhs91bYyqdz6r0gtgvcPAfCo1su2ltyZrM7CQ2UDeayDx0mJOExFIsSv7h5nCpJjQ=
X-Received: by 2002:a17:906:d04f:: with SMTP id
 bo15mr15064287ejb.309.1630957904502; 
 Mon, 06 Sep 2021 12:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
 <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
In-Reply-To: <5d9bebdf-6eb5-49a0-2e8f-490df2d6754d@arm.com>
From: Jon Nettleton <jon@solid-run.com>
Date: Mon, 6 Sep 2021 21:51:07 +0200
Message-ID: <CABdtJHt-18TDHBFq1X89=qngUbopGoFnqjuXiBOPtZG58vy3sg@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To: Robin Murphy <robin.murphy@arm.com>
Cc: Linuxarm <linuxarm@huawei.com>, Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 wanghuiqiang <wanghuiqiang@huawei.com>, Hanjun Guo <guohanjun@huawei.com>,
 yangyicong <yangyicong@huawei.com>, Sami Mujawar <Sami.Mujawar@arm.com>,
 Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Mon, Sep 6, 2021 at 7:44 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-05 17:03, Lorenzo Pieralisi wrote:
> > On Thu, Aug 05, 2021 at 09:07:17AM +0100, Shameer Kolothum wrote:
> >
> > [...]
> >
> >> +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
> >> +{
> >> +    struct acpi_iort_node *smmu;
> >> +    struct acpi_iort_rmr *rmr;
> >> +    struct acpi_iort_rmr_desc *rmr_desc;
> >> +    u32 map_count = iort_node->mapping_count;
> >> +    u32 sid;
> >> +    int i;
> >> +
> >> +    if (!iort_node->mapping_offset || map_count != 1) {
> >> +            pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> >> +                   iort_node);
> >> +            return;
> >> +    }
> >> +
> >> +    /* Retrieve associated smmu and stream id */
> >> +    smmu = iort_node_get_id(iort_node, &sid, 0);
> >> +    if (!smmu) {
> >> +            pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
> >> +                   iort_node);
> >> +            return;
> >> +    }
> >> +
> >> +    /* Retrieve RMR data */
> >> +    rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> >> +    if (!rmr->rmr_offset || !rmr->rmr_count) {
> >> +            pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
> >> +                   iort_node);
> >> +            return;
> >> +    }
> >> +
> >> +    rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> >> +                            rmr->rmr_offset);
> >> +
> >> +    iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> >> +
> >> +    for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> >> +            struct iommu_resv_region *region;
> >> +            enum iommu_resv_type type;
> >> +            int prot = IOMMU_READ | IOMMU_WRITE;
> >> +            u64 addr = rmr_desc->base_address, size = rmr_desc->length;
> >> +
> >> +            if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
> >> +                    /* PAGE align base addr and size */
> >> +                    addr &= PAGE_MASK;
> >> +                    size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
> >> +
> >> +                    pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
> >> +                           rmr_desc->base_address,
> >> +                           rmr_desc->base_address + rmr_desc->length - 1,
> >> +                           addr, addr + size - 1);
> >> +            }
> >> +            if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> >> +                    type = IOMMU_RESV_DIRECT_RELAXABLE;
> >> +                    /*
> >> +                     * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> >> +                     * normally used for allocated system memory that is
> >> +                     * then used for device specific reserved regions.
> >> +                     */
> >> +                    prot |= IOMMU_CACHE;
> >> +            } else {
> >> +                    type = IOMMU_RESV_DIRECT;
> >> +                    /*
> >> +                     * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> >> +                     * for device memory like MSI doorbell.
> >> +                     */
> >> +                    prot |= IOMMU_MMIO;
> >> +            }
> >
> > On the prot value assignment based on the remapping flag, I'd like to
> > hear Robin/Joerg's opinion, I'd avoid being in a situation where
> > "normally" this would work but then we have to quirk it.
> >
> > Is this a valid assumption _always_ ?
>
> No. Certainly applying IOMMU_CACHE without reference to the device's
> _CCA attribute or how CPUs may be accessing a shared buffer could lead
> to a loss of coherency. At worst, applying IOMMU_MMIO to a
> device-private buffer *could* cause the device to lose coherency with
> itself if the memory underlying the RMR may have allocated into system
> caches. Note that the expected use for non-remappable RMRs is the device
> holding some sort of long-lived private data in system RAM - the MSI
> doorbell trick is far more of a niche hack really.
>
> At the very least I think we need to refer to the device's memory access
> properties here.
>
> Jon, Laurentiu - how do RMRs correspond to the EFI memory map on your
> firmware? I'm starting to think that as long as the underlying memory is
> described appropriately there then we should be able to infer correct
> attributes from the EFI memory type and flags.

The devices are all cache coherent and marked as _CCA, 1.  The Memory
regions are in the virt table as ARM_MEMORY_REGION_ATTRIBUTE_DEVICE.

The current chicken and egg problem we have is that during the fsl-mc-bus
initialization we call

error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
                                              &mc_stream_id);

which gets deferred because the SMMU has not been initialized yet. Then we
initialize the RMR tables but there is no device reference there to be able to
query device properties, only the stream id.  After the IORT tables are parsed
and the SMMU is setup, on the second device probe we associate everything
based on the stream id and the fsl-mc-bus device is able to claim its 1-1 DMA
mappings.

cat /sys/kernel/iommu_groups/0/reserved_regions
0x0000000001000000 0x0000000010ffffff direct-relaxable
0x0000000008000000 0x00000000080fffff msi
0x000000080c000000 0x000000081bffffff direct-relaxable
0x0000001c00000000 0x0000001c001fffff direct-relaxable
0x0000002080000000 0x000000209fffffff direct-relaxable

-Jon

>
> Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
