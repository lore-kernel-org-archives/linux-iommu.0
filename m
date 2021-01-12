Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E19C433E0
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 11:06:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D4992310D
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 11:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D4992310D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6186B204BA;
	Tue, 12 Jan 2021 11:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HJ72h6iTf+tE; Tue, 12 Jan 2021 11:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B49AF203E7;
	Tue, 12 Jan 2021 11:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FB7BC0893;
	Tue, 12 Jan 2021 11:06:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCBC4C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 11:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id CA56485816
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 11:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xLP7X8_mK0Nj for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 11:05:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9549684E15
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 11:05:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A450A1435
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 03:05:56 -0800 (PST)
Received: from mail-pl1-f180.google.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 958D73FA35
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 03:05:56 -0800 (PST)
Received: by mail-pl1-f180.google.com with SMTP id be12so1227903plb.4
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 03:05:56 -0800 (PST)
X-Gm-Message-State: AOAM530DrZ9D2n4MEac7J0UYSbNnGPWSB4s/2TY0Vgnl+YUmBK8feDUl
 mn12RqZ87Q2SSMvzrUk8VVtS31y4JeZ13IP0M9c=
X-Google-Smtp-Source: ABdhPJzsg6zT++OpgkFhHve/i+0GEamVqvPpEfMSkAHJGOtMcZmOT2hTATjzTkckorSJ3yItCQexaSYbcqy/caLFHkw=
X-Received: by 2002:a17:90a:f28f:: with SMTP id
 fs15mr4087906pjb.121.1610449555888; 
 Tue, 12 Jan 2021 03:05:55 -0800 (PST)
MIME-Version: 1.0
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
 <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
 <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB14356D5688CA7DC346AA32DBC3AA0@DM5PR11MB1435.namprd11.prod.outlook.com>
From: Vivek Gautam <vivek.gautam@arm.com>
Date: Tue, 12 Jan 2021 16:35:45 +0530
X-Gmail-Original-Message-ID: <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
Message-ID: <CAFp+6iEnh6Tce26F0RHYCrQfiHrkf-W3_tXpx+ysGiQz6AWpEw@mail.gmail.com>
Subject: Re: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, "Tian, Jun J" <jun.j.tian@intel.com>, "Wu,
 Hao" <hao.wu@intel.com>
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

Hi Yi,


On Tue, Jan 12, 2021 at 2:51 PM Liu, Yi L <yi.l.liu@intel.com> wrote:
>
> Hi Vivek,
>
> > From: Vivek Gautam <vivek.gautam@arm.com>
> > Sent: Tuesday, January 12, 2021 2:50 PM
> >
> > Hi Yi,
> >
> >
> > On Thu, Sep 10, 2020 at 4:13 PM Liu Yi L <yi.l.liu@intel.com> wrote:
> > >
> > > This patch is added as instead of returning a boolean for
> > DOMAIN_ATTR_NESTING,
> > > iommu_domain_get_attr() should return an iommu_nesting_info handle.
> > For
> > > now, return an empty nesting info struct for now as true nesting is not
> > > yet supported by the SMMUs.
> > >
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > > ---
> > > v5 -> v6:
> > > *) add review-by from Eric Auger.
> > >
> > > v4 -> v5:
> > > *) address comments from Eric Auger.
> > > ---
> > >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29
> > +++++++++++++++++++++++++++--
> > >  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 29
> > +++++++++++++++++++++++++++--
> > >  2 files changed, 54 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 7196207..016e2e5 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -3019,6 +3019,32 @@ static struct iommu_group
> > *arm_smmu_device_group(struct device *dev)
> > >         return group;
> > >  }
> > >
> > > +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> > *smmu_domain,
> > > +                                       void *data)
> > > +{
> > > +       struct iommu_nesting_info *info = (struct iommu_nesting_info
> > *)data;
> > > +       unsigned int size;
> > > +
> > > +       if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > > +               return -ENODEV;
> > > +
> > > +       size = sizeof(struct iommu_nesting_info);
> > > +
> > > +       /*
> > > +        * if provided buffer size is smaller than expected, should
> > > +        * return 0 and also the expected buffer size to caller.
> > > +        */
> > > +       if (info->argsz < size) {
> > > +               info->argsz = size;
> > > +               return 0;
> > > +       }
> > > +
> > > +       /* report an empty iommu_nesting_info for now */
> > > +       memset(info, 0x0, size);
> > > +       info->argsz = size;
> > > +       return 0;
> > > +}
> > > +
> > >  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
> > >                                     enum iommu_attr attr, void *data)
> > >  {
> > > @@ -3028,8 +3054,7 @@ static int arm_smmu_domain_get_attr(struct
> > iommu_domain *domain,
> > >         case IOMMU_DOMAIN_UNMANAGED:
> > >                 switch (attr) {
> > >                 case DOMAIN_ATTR_NESTING:
> > > -                       *(int *)data = (smmu_domain->stage ==
> > ARM_SMMU_DOMAIN_NESTED);
> > > -                       return 0;
> > > +                       return arm_smmu_domain_nesting_info(smmu_domain,
> > data);
> >
> > Thanks for the patch.
> > This would unnecessarily overflow 'data' for any caller that's expecting only
> > an int data. Dump from one such issue that I was seeing when testing
> > this change along with local kvmtool changes is pasted below [1].
> >
> > I could get around with the issue by adding another (iommu_attr) -
> > DOMAIN_ATTR_NESTING_INFO that returns (iommu_nesting_info).
>
> nice to hear from you. At first, we planned to have a separate iommu_attr
> for getting nesting_info. However, we considered there is no existing user
> which gets DOMAIN_ATTR_NESTING, so we decided to reuse it for iommu nesting
> info. Could you share me the code base you are using? If the error you
> encountered is due to this change, so there should be a place which gets
> DOMAIN_ATTR_NESTING.

I am currently working on top of Eric's tree for nested stage support [1].
My best guess was that the vfio_pci_dma_fault_init() method [2] that is
requesting DOMAIN_ATTR_NESTING causes stack overflow, and corruption.
That's when I added a new attribute.

I will soon publish my patches to the list for review. Let me know
your thoughts.

[1] https://github.com/eauger/linux/tree/5.10-rc4-2stage-v13
[2] https://github.com/eauger/linux/blob/5.10-rc4-2stage-v13/drivers/vfio/pci/vfio_pci.c#L494

Thanks
Vivek

>
> Regards,
> Yi Liu

[snip]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
