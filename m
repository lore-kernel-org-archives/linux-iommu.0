Return-Path: <SRS0=ta7q=7L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ABEC433E0
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 22:16:39 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF62020810
	for <iommu@archiver.kernel.org>; Fri, 29 May 2020 22:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyEydRMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF62020810
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6769875BC;
	Fri, 29 May 2020 22:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wdOhUoWcjmVT; Fri, 29 May 2020 22:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4EB6875B6;
	Fri, 29 May 2020 22:16:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8813FC088A;
	Fri, 29 May 2020 22:16:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 294A2C016F
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 22:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0C4D122610
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 22:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xjplyye-hHKD for <iommu@lists.linux-foundation.org>;
 Fri, 29 May 2020 22:16:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by silver.osuosl.org (Postfix) with ESMTPS id 96C09220EF
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 22:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590790592;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RyWRgA39MpCS4B1s1Q6dcjnQ39Nmyes8pkIQMz0S9CE=;
 b=HyEydRMZTLGrdMZrhync1yjF80RTDrg5tllQ8JcDCwKF5HM1gHuL3kxdX10bl+DQhabkyB
 EDrpC3oDmktZI9oHoT+zfWbnRFMzHocyzPSUi8rG5h98NqPmqzMk5OClHcNQUB2gyoJsoz
 lvtDt5pyQRDGMJtCC3WFSCxzW0AhSkg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-2bt8x7e4NIuAMDrBubhW_A-1; Fri, 29 May 2020 18:16:26 -0400
X-MC-Unique: 2bt8x7e4NIuAMDrBubhW_A-1
Received: by mail-qv1-f72.google.com with SMTP id s15so2313240qvo.6
 for <iommu@lists.linux-foundation.org>; Fri, 29 May 2020 15:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=RyWRgA39MpCS4B1s1Q6dcjnQ39Nmyes8pkIQMz0S9CE=;
 b=QzFLdS5ZEYKd0rEZe4tc6RFA3PCM86ZLG6TnNkuA1fsrQUtFZLZY4Tizt0hfNq+S1u
 2pv49KugsK2Xzck6J2N8qNUFw/lS6UyLGeJQjuZuRoq1ewNB7MtVgeo5Cp8g2i9rxYcn
 IXWP2wZEBwRBNAhZmE0/7fwRrHmWkwe4IeBn/QFZgslulTQJ++GSPdYygWsked+/if1u
 eUtHnJhq2DZctYFixkllAM6hm18BKZxNGz74xOb15WKbWH/BGFDLQsxctC7sALvukltU
 ktiabVgNS8SwsHr+H7oMU9S6fHKBoqfi7Ii4fRTp74SlHsRgEAU+JqJ2PdfIHCnfclZd
 LLFA==
X-Gm-Message-State: AOAM533Zfx3VZps6SzdffWi04jzwr4/ZDoW1zve8yUOzGjL3rWVBI8a6
 7+EpB4xqnZoSmJvqEzuLQg5vXJZ/zDPz5M0HXX0sPGpuHTfm1di6rTfGHrgPxpLLhX7vg2CB/NF
 gKqbgcadfmZV8HDr6q9wBVuw7GblaSw==
X-Received: by 2002:a37:6188:: with SMTP id v130mr4562285qkb.138.1590790585938; 
 Fri, 29 May 2020 15:16:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw51w0cnvYWh4WhXmhdM31BK730VJAQnizGJEPYNr8qH289FZOtd/33h3DF8AwAKbkwmoOGzg==
X-Received: by 2002:a37:6188:: with SMTP id v130mr4562246qkb.138.1590790585671; 
 Fri, 29 May 2020 15:16:25 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
 by smtp.gmail.com with ESMTPSA id w13sm8244813qkb.91.2020.05.29.15.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 15:16:24 -0700 (PDT)
Date: Fri, 29 May 2020 15:16:23 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
Message-ID: <20200529221623.qc6twmpzryh7nkvb@cantor>
Mail-Followup-To: Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Rob Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20200414131542.25608-1-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue Apr 14 20, Joerg Roedel wrote:
>Hi,
>
>here is the second version of this patch-set. The first version with
>some more introductory text can be found here:
>
>	https://lore.kernel.org/lkml/20200407183742.4344-1-joro@8bytes.org/
>
>Changes v1->v2:
>
>	* Rebased to v5.7-rc1
>
>	* Re-wrote the arm-smmu changes as suggested by Robin Murphy
>
>	* Re-worked the Exynos patches to hopefully not break the
>	  driver anymore
>
>	* Fixed a missing mutex_unlock() reported by Marek Szyprowski,
>	  thanks for that.
>
>There is also a git-branch available with these patches applied:
>
>	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2
>
>Please review.
>
>Thanks,
>
>	Joerg
>
>Joerg Roedel (32):
>  iommu: Move default domain allocation to separate function
>  iommu/amd: Implement iommu_ops->def_domain_type call-back
>  iommu/vt-d: Wire up iommu_ops->def_domain_type
>  iommu/amd: Remove dma_mask check from check_device()
>  iommu/amd: Return -ENODEV in add_device when device is not handled by
>    IOMMU
>  iommu: Add probe_device() and remove_device() call-backs
>  iommu: Move default domain allocation to iommu_probe_device()
>  iommu: Keep a list of allocated groups in __iommu_probe_device()
>  iommu: Move new probe_device path to separate function
>  iommu: Split off default domain allocation from group assignment
>  iommu: Move iommu_group_create_direct_mappings() out of
>    iommu_group_add_device()
>  iommu: Export bus_iommu_probe() and make is safe for re-probing
>  iommu/amd: Remove dev_data->passthrough
>  iommu/amd: Convert to probe/release_device() call-backs
>  iommu/vt-d: Convert to probe/release_device() call-backs
>  iommu/arm-smmu: Convert to probe/release_device() call-backs
>  iommu/pamu: Convert to probe/release_device() call-backs
>  iommu/s390: Convert to probe/release_device() call-backs
>  iommu/virtio: Convert to probe/release_device() call-backs
>  iommu/msm: Convert to probe/release_device() call-backs
>  iommu/mediatek: Convert to probe/release_device() call-backs
>  iommu/mediatek-v1 Convert to probe/release_device() call-backs
>  iommu/qcom: Convert to probe/release_device() call-backs
>  iommu/rockchip: Convert to probe/release_device() call-backs
>  iommu/tegra: Convert to probe/release_device() call-backs
>  iommu/renesas: Convert to probe/release_device() call-backs
>  iommu/omap: Remove orphan_dev tracking
>  iommu/omap: Convert to probe/release_device() call-backs
>  iommu/exynos: Use first SYSMMU in controllers list for IOMMU core
>  iommu/exynos: Convert to probe/release_device() call-backs
>  iommu: Remove add_device()/remove_device() code-paths
>  iommu: Unexport iommu_group_get_for_dev()
>
>Sai Praneeth Prakhya (1):
>  iommu: Add def_domain_type() callback in iommu_ops
>
> drivers/iommu/amd_iommu.c       |  97 ++++----
> drivers/iommu/amd_iommu_types.h |   1 -
> drivers/iommu/arm-smmu-v3.c     |  38 +--
> drivers/iommu/arm-smmu.c        |  39 ++--
> drivers/iommu/exynos-iommu.c    |  24 +-
> drivers/iommu/fsl_pamu_domain.c |  22 +-
> drivers/iommu/intel-iommu.c     |  68 +-----
> drivers/iommu/iommu.c           | 393 +++++++++++++++++++++++++-------
> drivers/iommu/ipmmu-vmsa.c      |  60 ++---
> drivers/iommu/msm_iommu.c       |  34 +--
> drivers/iommu/mtk_iommu.c       |  24 +-
> drivers/iommu/mtk_iommu_v1.c    |  50 ++--
> drivers/iommu/omap-iommu.c      |  99 ++------
> drivers/iommu/qcom_iommu.c      |  24 +-
> drivers/iommu/rockchip-iommu.c  |  26 +--
> drivers/iommu/s390-iommu.c      |  22 +-
> drivers/iommu/tegra-gart.c      |  24 +-
> drivers/iommu/tegra-smmu.c      |  31 +--
> drivers/iommu/virtio-iommu.c    |  41 +---
> include/linux/iommu.h           |  21 +-
> 20 files changed, 533 insertions(+), 605 deletions(-)
>
>-- 
>2.17.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu
>

Hi Joerg,

With this patchset, I have an epyc system where if I boot with
iommu=nopt and force a dump I will see some io page faults for a nic
on the system. The vmcore is harvested and the system reboots. I
haven't reproduced it on other systems yet, but without the patchset I
don't see the io page faults during the kdump.

Regards,
Jerry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
