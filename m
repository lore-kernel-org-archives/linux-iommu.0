Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37417C4338F
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:32:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A3A610FF
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 16:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3A3A610FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A58D683B20;
	Thu,  5 Aug 2021 16:32:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LR9ubNaSMHk2; Thu,  5 Aug 2021 16:32:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6109283AA7;
	Thu,  5 Aug 2021 16:32:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AB09C0010;
	Thu,  5 Aug 2021 16:32:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55182C000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:32:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4301640003
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=solid-run-com.20150623.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e2LTenACq3v6 for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 16:32:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BE9F9404B4
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 16:32:26 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id c25so10589173ejb.3
 for <iommu@lists.linux-foundation.org>; Thu, 05 Aug 2021 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solid-run-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZQCg6OI1PKRykWCoTFREjwe6qvftl+/s1qj9qRWwyWs=;
 b=yQz1nbjdvUX/NC0VNo5bOXvWG6OQQMtlTTRJHeQaXh4N3GNGJybnReORBTmvyg2Kxe
 xqQt9aK5vBbhZW/lfOqvYT+4TCISWd1BxMNbA1Rus+Ak979zB63Wpl6sVIvdmLytHZs2
 3ATNZXMm703d+ek8PWeokRc/FyGccA0Z1jtDENHkCPzxAO8JdE6RMQBhxHJAcnI8uZWW
 FXXVdOT2BJgrFnuZk0wMDdjeUiBp0uB8iYye/qvIW4H9R9/PwDyS4+zu4/aCMFBUX17n
 1rz4oqbmqG+BONTQgiyZoAn23DgYHSt509y9D0zZ5YM8wbucwklK31FjZUf6GXDm12QS
 kqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZQCg6OI1PKRykWCoTFREjwe6qvftl+/s1qj9qRWwyWs=;
 b=kCakP+UT393856VKrR8k547mOueQ4C5KEqmTG4n7TEF/fkAHapcNkBodw5EgVcaOwi
 D3UpxK8ayr2d8jrnrUXscTt7MT062jZfNGGMFwF98aDsTbVEKmxaLP7KJYnLoSUJqf7b
 jgm1TcwZD2s9CnlVX1UrerRRd1vxd8ln5ISp3h5VUOc83pflyxwMqLiYqWMzCHwFpVLg
 G1mtot8HXB4hBQGap6OcPK2oK4mCYMFFzKyHCTEfY3mw3kC4rCNBQxlo5eHFSJ0DU4nJ
 8A+iD1g3fnQPOgwjd75hvaZMPfxtGJC2gM16kmw3uKICRDyIGMS65oBfroKpb0Pu2C9x
 yAVQ==
X-Gm-Message-State: AOAM5323eJ4S1s3/HbzsztB7+Jg6QoO1qPsGTqS1J/wb87yvm/wx+SdW
 FdpL5sQPTURU4/rC6l6nGPdyUyVqXEWN3/tZurF73w==
X-Google-Smtp-Source: ABdhPJxb1qaMZTi4dyT6LMxLcXJPZSpel7n23A9sy9aHK/FcPT3m4u095ddlSk+SVEveBE+l8doNfLvgs5DkSu1zEA0=
X-Received: by 2002:a17:906:abc2:: with SMTP id
 kq2mr5764176ejb.342.1628181144845; 
 Thu, 05 Aug 2021 09:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <20210805160319.GB23085@lpieralisi>
In-Reply-To: <20210805160319.GB23085@lpieralisi>
From: Jon Nettleton <jon@solid-run.com>
Date: Thu, 5 Aug 2021 18:31:47 +0200
Message-ID: <CABdtJHuhpnASw8NQb7dRo42Z5NqOzvtvjoyndsJ2jd+Qvsq7vQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>, Linuxarm <linuxarm@huawei.com>,
 Steven Price <steven.price@arm.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 iommu@lists.linux-foundation.org, wanghuiqiang <wanghuiqiang@huawei.com>,
 Hanjun Guo <guohanjun@huawei.com>, yangyicong <yangyicong@huawei.com>,
 Sami Mujawar <Sami.Mujawar@arm.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Thu, Aug 5, 2021 at 6:03 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Aug 05, 2021 at 09:07:17AM +0100, Shameer Kolothum wrote:
>
> [...]
>
> > +static void __init iort_node_get_rmr_info(struct acpi_iort_node *iort_node)
> > +{
> > +     struct acpi_iort_node *smmu;
> > +     struct acpi_iort_rmr *rmr;
> > +     struct acpi_iort_rmr_desc *rmr_desc;
> > +     u32 map_count = iort_node->mapping_count;
> > +     u32 sid;
> > +     int i;
> > +
> > +     if (!iort_node->mapping_offset || map_count != 1) {
> > +             pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
> > +                    iort_node);
> > +             return;
> > +     }
> > +
> > +     /* Retrieve associated smmu and stream id */
> > +     smmu = iort_node_get_id(iort_node, &sid, 0);
> > +     if (!smmu) {
> > +             pr_err(FW_BUG "Invalid SMMU reference, skipping RMR node %p\n",
> > +                    iort_node);
> > +             return;
> > +     }
> > +
> > +     /* Retrieve RMR data */
> > +     rmr = (struct acpi_iort_rmr *)iort_node->node_data;
> > +     if (!rmr->rmr_offset || !rmr->rmr_count) {
> > +             pr_err(FW_BUG "Invalid RMR descriptor array, skipping RMR node %p\n",
> > +                    iort_node);
> > +             return;
> > +     }
> > +
> > +     rmr_desc = ACPI_ADD_PTR(struct acpi_iort_rmr_desc, iort_node,
> > +                             rmr->rmr_offset);
> > +
> > +     iort_rmr_desc_check_overlap(rmr_desc, rmr->rmr_count);
> > +
> > +     for (i = 0; i < rmr->rmr_count; i++, rmr_desc++) {
> > +             struct iommu_resv_region *region;
> > +             enum iommu_resv_type type;
> > +             int prot = IOMMU_READ | IOMMU_WRITE;
> > +             u64 addr = rmr_desc->base_address, size = rmr_desc->length;
> > +
> > +             if (!IS_ALIGNED(addr, SZ_64K) || !IS_ALIGNED(size, SZ_64K)) {
> > +                     /* PAGE align base addr and size */
> > +                     addr &= PAGE_MASK;
> > +                     size = PAGE_ALIGN(size + offset_in_page(rmr_desc->base_address));
> > +
> > +                     pr_err(FW_BUG "RMR descriptor[0x%llx - 0x%llx] not aligned to 64K, continue with [0x%llx - 0x%llx]\n",
> > +                            rmr_desc->base_address,
> > +                            rmr_desc->base_address + rmr_desc->length - 1,
> > +                            addr, addr + size - 1);
> > +             }
> > +             if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> > +                     type = IOMMU_RESV_DIRECT_RELAXABLE;
> > +                     /*
> > +                      * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> > +                      * normally used for allocated system memory that is
> > +                      * then used for device specific reserved regions.
> > +                      */
> > +                     prot |= IOMMU_CACHE;
> > +             } else {
> > +                     type = IOMMU_RESV_DIRECT;
> > +                     /*
> > +                      * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> > +                      * for device memory like MSI doorbell.
> > +                      */
> > +                     prot |= IOMMU_MMIO;
> > +             }
>
> On the prot value assignment based on the remapping flag, I'd like to
> hear Robin/Joerg's opinion, I'd avoid being in a situation where
> "normally" this would work but then we have to quirk it.
>
> Is this a valid assumption _always_ ?

These assumptions were made based on the historic use cases I could
find reading the history.  There aren't many known examples "in the wild"
because so far we haven't had a mechanism other than quirks based
around device-tree implementations.

Ultimately I believe the proper solution will need to be another flag
in the RMR table that specifies the type of memory an RMR Node
describes, not just the base and length.

-Jon

>
> Thanks,
> Lorenzo
>
> > +
> > +             region = iommu_alloc_resv_region(addr, size, prot, type);
> > +             if (region) {
> > +                     region->fw_data.rmr.flags = rmr->flags;
> > +                     region->fw_data.rmr.sid = sid;
> > +                     region->fw_data.rmr.smmu = smmu;
> > +                     list_add_tail(&region->list, &iort_rmr_list);
> > +             }
> > +     }
> > +}
> > +
> > +static void __init iort_parse_rmr(void)
> > +{
> > +     struct acpi_iort_node *iort_node, *iort_end;
> > +     struct acpi_table_iort *iort;
> > +     int i;
> > +
> > +     if (iort_table->revision < 3)
> > +             return;
> > +
> > +     iort = (struct acpi_table_iort *)iort_table;
> > +
> > +     iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > +                              iort->node_offset);
> > +     iort_end = ACPI_ADD_PTR(struct acpi_iort_node, iort,
> > +                             iort_table->length);
> > +
> > +     for (i = 0; i < iort->node_count; i++) {
> > +             if (WARN_TAINT(iort_node >= iort_end, TAINT_FIRMWARE_WORKAROUND,
> > +                            "IORT node pointer overflows, bad table!\n"))
> > +                     return;
> > +
> > +             if (iort_node->type == ACPI_IORT_NODE_RMR)
> > +                     iort_node_get_rmr_info(iort_node);
> > +
> > +             iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
> > +                                      iort_node->length);
> > +     }
> > +}
> >
> >  static void __init iort_init_platform_devices(void)
> >  {
> > @@ -1636,6 +1767,7 @@ void __init acpi_iort_init(void)
> >       }
> >
> >       iort_init_platform_devices();
> > +     iort_parse_rmr();
> >  }
> >
> >  #ifdef CONFIG_ZONE_DMA
> > --
> > 2.17.1
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
