Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B8CC433F5
	for <iommu@archiver.kernel.org>; Fri, 11 Mar 2022 08:06:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1AFE840922;
	Fri, 11 Mar 2022 08:06:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3rEdZ2EQN48G; Fri, 11 Mar 2022 08:06:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AC96B408BD;
	Fri, 11 Mar 2022 08:06:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B659C0012;
	Fri, 11 Mar 2022 08:06:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0E46C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 08:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5BD48329A
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 08:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nrbNCIu3bjqs for <iommu@lists.linux-foundation.org>;
 Fri, 11 Mar 2022 08:06:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4BF0B82884
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 08:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646986004;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgP2Kr6cQT3iIV3nMtr5LhvA/+AXCJWjko3NF+tsE8k=;
 b=DLRH8UxfKSj5q3UDQ+QUgwG3SMwVPfRCE+Sj+GLhmvy3pBedQoIJCVQXawb60BYfrRwWKU
 AJiMlK+9US/+5sS9qjpuWH1Z+t9SHVSG4Q0smLPcL7OswpHvk/Od35nwH0pf4L2omwg1ZI
 ijssReeixFsLNGpWoKVeAtgXFnvNvj4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-8e27n9CFNYCAqr1XwNQYlQ-1; Fri, 11 Mar 2022 03:06:41 -0500
X-MC-Unique: 8e27n9CFNYCAqr1XwNQYlQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 l1-20020a1c2501000000b00389c7b9254cso2962473wml.1
 for <iommu@lists.linux-foundation.org>; Fri, 11 Mar 2022 00:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=vgP2Kr6cQT3iIV3nMtr5LhvA/+AXCJWjko3NF+tsE8k=;
 b=kbSDAIG8P0i+XGyKmzM100c+GTU2DnZ0vxdVB+HFyTlNdWrCQHONbASnmPeO1VlXf1
 T9NFkBspLPUC9xyAzPbIG+fNxoOVyTgkfMvBFGaPd9pMMY7r6hI3qkKlmeQz62esG3ga
 4l9eL7NwR8ZaqKxhWjcShNpcnDCPFpczdzel3nQ3tUTnRcVMyLGmGaH9rtn+a3+DARFD
 29Rr5pMDUVIculqVe0kPtJIOcyvC6d99wFZXjgB6FqEBxsnWyl7f96/FWLxUYo1c4BNp
 R+LA69lCpmxvc6ARE+LOqvPrFxtIgGybUh5hD26Bw6cyVZKKTv+dlUOK27ZgfxjQAIh3
 0l/g==
X-Gm-Message-State: AOAM533SebgtTwi7ok/H8cnTcH2grOKa28hpUAgk+XiDkaspEcYh6DKC
 LlxTxhfREC6HNhTXLfl8uSILd+Elxj0d6MTAsxwGmI0SEWI4FvdE/f+027R/wyG6kynSNKHuwfu
 gx7EZQggVZ4ShP5IYn2kqlVDqlDPKmA==
X-Received: by 2002:adf:ed0c:0:b0:1f0:63a5:36aa with SMTP id
 a12-20020adfed0c000000b001f063a536aamr6305557wro.588.1646986000398; 
 Fri, 11 Mar 2022 00:06:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2Vm6KkbbdN49P08cPdti6Bocnw762oiUUP6ZqnjAq5tnsFyAkAMa6xeqMtfYWEzcvFxaUkQ==
X-Received: by 2002:adf:ed0c:0:b0:1f0:63a5:36aa with SMTP id
 a12-20020adfed0c000000b001f063a536aamr6305537wro.588.1646986000119; 
 Fri, 11 Mar 2022 00:06:40 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 e20-20020adfa454000000b001f01a14dce8sm6107441wra.97.2022.03.11.00.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Mar 2022 00:06:39 -0800 (PST)
Subject: Re: [PATCH v8 00/11] ACPI/IORT: Support for IORT RMR node
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <0f9634c1-8401-7814-7783-c1c042e8fb42@redhat.com>
Date: Fri, 11 Mar 2022 09:06:37 +0100
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

I tested it on guest side for host MSI SW RESV region flat mapping
(using both the old single mapping layout and the now allowed multiple
RID ID mapping format) and this worked for me. Feel free to add my

Tested-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


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
