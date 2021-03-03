Return-Path: <SRS0=nNEG=IB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6626C433DB
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 06:22:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EACFE64EAE
	for <iommu@archiver.kernel.org>; Wed,  3 Mar 2021 06:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EACFE64EAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71D4B839B4;
	Wed,  3 Mar 2021 06:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fZpee_U8vh1l; Wed,  3 Mar 2021 06:22:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A8AB83883;
	Wed,  3 Mar 2021 06:22:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FD98C000A;
	Wed,  3 Mar 2021 06:22:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61D83C0001;
 Wed,  3 Mar 2021 06:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 47BA96FACA;
 Wed,  3 Mar 2021 06:22:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TTu6Wy5kTf7z; Wed,  3 Mar 2021 06:22:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id D95916F705;
 Wed,  3 Mar 2021 06:22:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDE6831B;
 Tue,  2 Mar 2021 22:22:37 -0800 (PST)
Received: from mail-pj1-f52.google.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A89073F766;
 Tue,  2 Mar 2021 22:22:37 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id c19so3511724pjq.3;
 Tue, 02 Mar 2021 22:22:37 -0800 (PST)
X-Gm-Message-State: AOAM533lqUU1KBwBpe/UIYJg0+5kHlw2CG3l3eAkbYnORRFtwK/M2yIe
 WOMcOfvAagPJU+Z0NDSsI/XzCNcuzz6xP6hiaCE=
X-Google-Smtp-Source: ABdhPJyjKH03+b8N29Pq6s8DcllmtesgUkkzNBnaIPi2WHDARS5YrTkldcfc+EwzrIjmynqJ/ZDKVuoA8lP2aAyQaPY=
X-Received: by 2002:a17:902:868a:b029:e3:e605:36d with SMTP id
 g10-20020a170902868ab02900e3e605036dmr1540492plo.31.1614752553056; Tue, 02
 Mar 2021 22:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20210212105859.8445-1-vivek.gautam@arm.com>
 <20210212105859.8445-3-vivek.gautam@arm.com>
 <0708b0b2-78f7-e55c-21a7-3c49eb5141df@redhat.com>
In-Reply-To: <0708b0b2-78f7-e55c-21a7-3c49eb5141df@redhat.com>
From: Vivek Gautam <vivek.gautam@arm.com>
Date: Wed, 3 Mar 2021 11:52:20 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEL1KDSro=KVMTatP+_YYKuHQ+esbLSEGSZEQeJhZ56bw@mail.gmail.com>
Message-ID: <CAFp+6iEL1KDSro=KVMTatP+_YYKuHQ+esbLSEGSZEQeJhZ56bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu: arm-smmu-v3: Report domain nesting info
 reuqired for stage1
To: Auger Eric <eric.auger@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, alex.williamson@redhat.com, mst@redhat.com,
 Will Deacon <will.deacon@arm.com>, open list <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

Hi Eric,

On Fri, Feb 12, 2021 at 11:44 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Vivek,
>
> On 2/12/21 11:58 AM, Vivek Gautam wrote:
> > Update nested domain information required for stage1 page table.
>
> s/reuqired/required in the commit title

Oh! my bad.

> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index c11dd3940583..728018921fae 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2555,6 +2555,7 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
> >                                       void *data)
> >  {
> >       struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
> > +     struct arm_smmu_device *smmu = smmu_domain->smmu;
> >       unsigned int size;
> >
> >       if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > @@ -2571,9 +2572,20 @@ static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
> >               return 0;
> >       }
> >
> > -     /* report an empty iommu_nesting_info for now */
> > -     memset(info, 0x0, size);
> > +     /* Update the nesting info as required for stage1 page tables */
> > +     info->addr_width = smmu->ias;
> > +     info->format = IOMMU_PASID_FORMAT_ARM_SMMU_V3;
> > +     info->features = IOMMU_NESTING_FEAT_BIND_PGTBL |
> I understood IOMMU_NESTING_FEAT_BIND_PGTBL advertises the requirement to
> bind tables per PASID, ie. passing iommu_gpasid_bind_data.
> In ARM case I guess you plan to use attach/detach_pasid_table API with
> iommu_pasid_table_config struct. So I understood we should add a new
> feature here.

Right, the idea is to let vfio know that we support pasid table binding, and
I thought we could use the same flag. But clearly that's not the case.
Will add a new feature.

> > +                      IOMMU_NESTING_FEAT_PAGE_RESP |
> > +                      IOMMU_NESTING_FEAT_CACHE_INVLD;
> > +     info->pasid_bits = smmu->ssid_bits;
> > +     info->vendor.smmuv3.asid_bits = smmu->asid_bits;
> > +     info->vendor.smmuv3.pgtbl_fmt = ARM_64_LPAE_S1;
> > +     memset(&info->padding, 0x0, 12);
> > +     memset(&info->vendor.smmuv3.padding, 0x0, 9);
> > +
> >       info->argsz = size;
> > +
> spurious new line

Sure, will remove it.

Best regards
Vivek

> >       return 0;
> >  }
> >
> >
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
