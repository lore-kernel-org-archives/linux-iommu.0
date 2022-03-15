Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B7DC433F5
	for <iommu@archiver.kernel.org>; Tue, 15 Mar 2022 17:53:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 157C5416DE;
	Tue, 15 Mar 2022 17:53:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Xb2IxXrE0Nt; Tue, 15 Mar 2022 17:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 01B7A416D0;
	Tue, 15 Mar 2022 17:53:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7FC2C0012;
	Tue, 15 Mar 2022 17:53:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA9F3C000B
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4BC0416D9
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:53:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OIYYGpSXMnmA for <iommu@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 17:53:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D9DB3416D0
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647366810;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yckfNRZbm4EhSd/3o0sHKLktNUAlNSpqA9x4v1UNDA=;
 b=WWPaPZU1ibj/jPAugVWt+irbTDrg4XHCJoSr2FpqWexmzCFWcqOzOGuk2YIIBGGhwvf8vi
 OwgmUMaT6lDbM0uvlIiWltEQlGWJpF2fwSBPd0wtvwSTcv/TJ4Rnp+jEDi9sVFF8asTnFD
 o5hwSEUA/R1x815P73dNMaSEuJJnxeI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-lXz1wBiHOU--VgdMoWykwQ-1; Tue, 15 Mar 2022 13:53:27 -0400
X-MC-Unique: lXz1wBiHOU--VgdMoWykwQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 c19-20020a05600c0ad300b00385bb3db625so1521839wmr.4
 for <iommu@lists.linux-foundation.org>; Tue, 15 Mar 2022 10:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=/yckfNRZbm4EhSd/3o0sHKLktNUAlNSpqA9x4v1UNDA=;
 b=o5UpsGU30Shuv4QieQTZeRZh3yeC26z/USAZ2jAg9tVy8JpLv5eozbStKLkmWQFhI+
 Eez/sOVloY7+pZS+vCZ8viNyWL/78TzTZXzdi7sguLOX1fVL6w2F71wkyn0k4azO2i3w
 We6lg2Pk1JDb7If+Jxi5yBESH6nj9JY556c5JQgtprC4uLY/az+XjzZ9BFXRYIUYw5zf
 o0o5dOo0ROM02xYjBR2B1OWrGvZvHNqaxLZA7RYYZvu83JRDkNjqiJ5xTotB+l3XvZjo
 nXnota4Yzg95lkRBnOQk6/KBhknjxqldIaboUfUxagD1GsFGrJK6MioXiEsLgKZmlifd
 GzWg==
X-Gm-Message-State: AOAM533sLn2oc31Id7B1FdVZAYMiGM2DOfi8r5jOMejeUL/3SGkCUq8W
 lkvER/ob66d+CpEX/iXMqdELPObZQTn4hEd94dUQwC3TG93gh7fxiBbnI/bIuNGgGMfZRK67gc5
 EQeKn+HqEsD+qiEAxsA5XrAlcm66qdw==
X-Received: by 2002:a05:600c:3c9d:b0:37f:a5c3:fccf with SMTP id
 bg29-20020a05600c3c9d00b0037fa5c3fccfmr4133678wmb.13.1647366806336; 
 Tue, 15 Mar 2022 10:53:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynGJfIupJwDxJtzzf700kKsr6SmaTl2v42mpNIvbie9DtlPp9iqXjPU7blEwcvfvRk4ylyCw==
X-Received: by 2002:a05:600c:3c9d:b0:37f:a5c3:fccf with SMTP id
 bg29-20020a05600c3c9d00b0037fa5c3fccfmr4133660wmb.13.1647366806070; 
 Tue, 15 Mar 2022 10:53:26 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a0560001ace00b00203da1fa749sm1637841wry.72.2022.03.15.10.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Mar 2022 10:53:25 -0700 (PDT)
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <640df5d4-e2f6-aa24-6b60-9cfaf3915060@redhat.com>
Date: Tue, 15 Mar 2022 18:53:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: robin.murphy@arm.com, jon@solid-run.com, linuxarm@huawei.com,
 steven.price@arm.com, guohanjun@huawei.com, yangyicong@huawei.com,
 Sami.Mujawar@arm.com, will@kernel.org, wanghuiqiang@huawei.com
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
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Shameer,
On 2/21/22 4:43 PM, Shameer Kolothum wrote:
> Hi,
>
> Since we now have an updated verion[0] of IORT spec(E.d) which
> addresses the memory attributes issues discussed here [1],
> this series now make use of it.
>
> The pull request for ACPICA E.d related changes are already
> raised and can be found here,
> https://github.com/acpica/acpica/pull/752
>
> v7 --> v8
>   - Patch #1 has temp definitions for RMR related changes till
>     the ACPICA header changes are part of kernel.
>   - No early parsing of RMR node info and is only parsed at the
>     time of use.
>   - Changes to the RMR get/put API format compared to the
>     previous version.
>   - Support for RMR descriptor shared by multiple stream IDs.
>
> Please take a look and let me know your thoughts.
>
> Thanks,
> Shameer
> [0] https://developer.arm.com/documentation/den0049/ed/
> [1] https://lore.kernel.org/linux-acpi/20210805160319.GB23085@lpieralisi/
>
> From old:
> We have faced issues with 3408iMR RAID controller cards which
> fail to boot when SMMU is enabled. This is because these
> controllers make use of host memory for various caching related
> purposes and when SMMU is enabled the iMR firmware fails to
> access these memory regions as there is no mapping for them.
> IORT RMR provides a way for UEFI to describe and report these
> memory regions so that the kernel can make a unity mapping for
> these in SMMU.
>
> Change History:
>
> v6 --> v7
>  -fix pointed out by Steve to the SMMUv2 SMR bypass install in patch #8.
>
> v5 --> v6
> - Addressed comments from Robin & Lorenzo.
>   : Moved iort_parse_rmr() to acpi_iort_init() from
>     iort_init_platform_devices().
>   : Removed use of struct iort_rmr_entry during the initial
>     parse. Using struct iommu_resv_region instead.
>   : Report RMR address alignment and overlap errors, but continue.
>   : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>   on Type of RMR region. Suggested by Jon N.
>
> v4 --> v5
>  -Added a fw_data union to struct iommu_resv_region and removed
>   struct iommu_rmr (Based on comments from Joerg/Robin).
>  -Added iommu_put_rmrs() to release mem.
>  -Thanks to Steve for verifying on SMMUv2, but not added the Tested-by
>   yet because of the above changes.
>
> v3 -->v4
> -Included the SMMUv2 SMR bypass install changes suggested by
>  Steve(patch #7)
> -As per Robin's comments, RMR reserve implementation is now
>  more generic  (patch #8) and dropped v3 patches 8 and 10.
> -Rebase to 5.13-rc1
>
> RFC v2 --> v3
>  -Dropped RFC tag as the ACPICA header changes are now ready to be
>   part of 5.13[0]. But this series still has a dependency on that patch.
>  -Added IORT E.b related changes(node flags, _DSM function 5 checks for
>   PCIe).
>  -Changed RMR to stream id mapping from M:N to M:1 as per the spec and
>   discussion here[1].
>  -Last two patches add support for SMMUv2(Thanks to Jon Nettleton!)
>
> Jon Nettleton (1):
>   iommu/arm-smmu: Get associated RMR info and install bypass SMR
>
> Shameer Kolothum (10):
>   ACPI/IORT: Add temporary RMR node flag definitions
>   iommu: Introduce a union to struct iommu_resv_region
>   ACPI/IORT: Add helper functions to parse RMR nodes
>   iommu/dma: Introduce generic helper to retrieve RMR info
>   ACPI/IORT: Add a helper to retrieve RMR memory regions
>   iommu/arm-smmu-v3: Introduce strtab init helper
>   iommu/arm-smmu-v3: Refactor arm_smmu_init_bypass_stes() to force
>     bypass
>   iommu/arm-smmu-v3: Get associated RMR info and install bypass STE
>   iommu/arm-smmu-v3: Reserve any RMR regions associated with a dev
>   iommu/arm-smmu: Reserve any RMR regions associated with a dev
fyi, the last 2 patches have conflicts with
[PATCH v4 9/9] iommu: Split struct iommu_ops
which was applied on core branch.

Thanks

Eric
>
>  drivers/acpi/arm64/iort.c                   | 305 ++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  91 ++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  65 ++++-
>  drivers/iommu/dma-iommu.c                   |  25 ++
>  include/linux/acpi_iort.h                   |  14 +
>  include/linux/dma-iommu.h                   |  14 +
>  include/linux/iommu.h                       |   9 +
>  7 files changed, 504 insertions(+), 19 deletions(-)
>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
