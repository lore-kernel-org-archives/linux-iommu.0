Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05AC433E0
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 06:50:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7741722AAF
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 06:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7741722AAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D0F31204B4;
	Tue, 12 Jan 2021 06:50:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nVaPne8U2acN; Tue, 12 Jan 2021 06:50:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0A3391FCB5;
	Tue, 12 Jan 2021 06:50:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED71BC0893;
	Tue, 12 Jan 2021 06:50:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AC0A2C013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 06:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A0A8C84469
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 06:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7VTS7DAbjHCn for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 06:50:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4B2F485ABF
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 06:50:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35D2712FC
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 22:50:41 -0800 (PST)
Received: from mail-pl1-f179.google.com (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23B8E3FA45
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 22:50:41 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id t6so907062plq.1
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 22:50:41 -0800 (PST)
X-Gm-Message-State: AOAM533uk6VChRF3VmvSRSS7rSiZsfSEHJaxcEG3wxtUHc+fov5xfn0Z
 HXvOQtxYoVS7gtLWD7sYPiZm4hjfdVYO8X2PfgM=
X-Google-Smtp-Source: ABdhPJxkM7Gy++KOxgg+Vg4KylRwV8QFQOGVeqrZZyEU2DDcq/JYCbjcYhWtGT34jkE/Co1DvCz6R7vLIIXujaJ2Oe4=
X-Received: by 2002:a17:902:ee0b:b029:dc:1aa4:1123 with SMTP id
 z11-20020a170902ee0bb02900dc1aa41123mr3819896plb.18.1610434240490; Mon, 11
 Jan 2021 22:50:40 -0800 (PST)
MIME-Version: 1.0
References: <1599734733-6431-1-git-send-email-yi.l.liu@intel.com>
 <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
In-Reply-To: <1599734733-6431-3-git-send-email-yi.l.liu@intel.com>
From: Vivek Gautam <vivek.gautam@arm.com>
Date: Tue, 12 Jan 2021 12:20:29 +0530
X-Gmail-Original-Message-ID: <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
Message-ID: <CAFp+6iFob_fy1cTgcEv0FOXBo70AEf3Z1UvXgPep62XXnLG9Gw@mail.gmail.com>
Subject: Re: [PATCH v7 02/16] iommu/smmu: Report empty domain nesting info
To: Liu Yi L <yi.l.liu@intel.com>
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 jasowang@redhat.com, stefanha@gmail.com, Will Deacon <will@kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 alex.williamson@redhat.com, hao.wu@intel.com,
 Robin Murphy <robin.murphy@arm.com>, jun.j.tian@intel.com
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


On Thu, Sep 10, 2020 at 4:13 PM Liu Yi L <yi.l.liu@intel.com> wrote:
>
> This patch is added as instead of returning a boolean for DOMAIN_ATTR_NESTING,
> iommu_domain_get_attr() should return an iommu_nesting_info handle. For
> now, return an empty nesting info struct for now as true nesting is not
> yet supported by the SMMUs.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
> v5 -> v6:
> *) add review-by from Eric Auger.
>
> v4 -> v5:
> *) address comments from Eric Auger.
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 29 +++++++++++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 29 +++++++++++++++++++++++++++--
>  2 files changed, 54 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 7196207..016e2e5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3019,6 +3019,32 @@ static struct iommu_group *arm_smmu_device_group(struct device *dev)
>         return group;
>  }
>
> +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain *smmu_domain,
> +                                       void *data)
> +{
> +       struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
> +       unsigned int size;
> +
> +       if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> +               return -ENODEV;
> +
> +       size = sizeof(struct iommu_nesting_info);
> +
> +       /*
> +        * if provided buffer size is smaller than expected, should
> +        * return 0 and also the expected buffer size to caller.
> +        */
> +       if (info->argsz < size) {
> +               info->argsz = size;
> +               return 0;
> +       }
> +
> +       /* report an empty iommu_nesting_info for now */
> +       memset(info, 0x0, size);
> +       info->argsz = size;
> +       return 0;
> +}
> +
>  static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>                                     enum iommu_attr attr, void *data)
>  {
> @@ -3028,8 +3054,7 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
>         case IOMMU_DOMAIN_UNMANAGED:
>                 switch (attr) {
>                 case DOMAIN_ATTR_NESTING:
> -                       *(int *)data = (smmu_domain->stage == ARM_SMMU_DOMAIN_NESTED);
> -                       return 0;
> +                       return arm_smmu_domain_nesting_info(smmu_domain, data);

Thanks for the patch.
This would unnecessarily overflow 'data' for any caller that's expecting only
an int data. Dump from one such issue that I was seeing when testing
this change along with local kvmtool changes is pasted below [1].

I could get around with the issue by adding another (iommu_attr) -
DOMAIN_ATTR_NESTING_INFO that returns (iommu_nesting_info).

Thanks & regards
Vivek

[1]--------------
[  811.756516] vfio-pci 0000:08:00.1: vfio_ecap_init: hiding ecap 0x1b@0x108
[  811.756516] Kernel panic - not syncing: stack-protector: Kernel
stack is corrupted in: vfio_pci_open+0x644/0x648
[  811.756516] CPU: 0 PID: 175 Comm: lkvm-cleanup-ne Not tainted
5.10.0-rc5-00096-gf015061e14cf #43
[  811.756516] Call trace:
[  811.756516]  dump_backtrace+0x0/0x1b0
[  811.756516]  show_stack+0x18/0x68
[  811.756516]  dump_stack+0xd8/0x134
[  811.756516]  panic+0x174/0x33c
[  811.756516]  __stack_chk_fail+0x3c/0x40
[  811.756516]  vfio_pci_open+0x644/0x648
[  811.756516]  vfio_group_fops_unl_ioctl+0x4bc/0x648
[  811.756516]  0x0
[  811.756516] SMP: stopping secondary CPUs
[  811.756597] Kernel Offset: disabled
[  811.756597] CPU features: 0x0040006,6a00aa38
[  811.756602] Memory Limit: none
[  811.768497] ---[ end Kernel panic - not syncing: stack-protector:
Kernel stack is corrupted in: vfio_pci_open+0x644/0x648 ]
-------------
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
