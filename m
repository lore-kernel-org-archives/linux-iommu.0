Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90183C2BB55
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 11:48:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57718206E9
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 11:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SfpxavV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57718206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 257C58405F;
	Thu, 16 Apr 2020 11:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A2FggoUUJ+sF; Thu, 16 Apr 2020 11:48:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DFEB183C00;
	Thu, 16 Apr 2020 11:48:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8794C089E;
	Thu, 16 Apr 2020 11:48:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56F12C0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 11:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0ACCF21FA8
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 11:48:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LYxXNrKXLnKP for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 11:48:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by silver.osuosl.org (Postfix) with ESMTPS id CD8F320368
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 11:48:51 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200416114849euoutp02b38a19e4d8480a0a2b500f3a87b7c23e~GSmgFfQmf3088030880euoutp02G
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 11:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200416114849euoutp02b38a19e4d8480a0a2b500f3a87b7c23e~GSmgFfQmf3088030880euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1587037729;
 bh=LtJiapRZh1Ea64p7LdbSiBgjXuP3s8Uvyni6NX+lMbI=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=SfpxavV1P9cZ5c5nOEaxfLj3RP0aNc+JtZ78ozQRM6iQ8N5LhcGpunGHkJbVpbOcc
 cFP0TuQ0jDXD8WXLRECz/pQT8/mqxu4vrqfMMQebCW6zADsKklQwPTFV21OF0agVdu
 VlGyEqiRvBW+JFL5Zv2Nk0X68sk/DgU6ksOXm9QQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200416114848eucas1p22ab13090a3fe7b4992627149d2e5ac90~GSmfuxvu60903309033eucas1p28;
 Thu, 16 Apr 2020 11:48:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 8B.5A.60679.026489E5; Thu, 16
 Apr 2020 12:48:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200416114848eucas1p26436783dd625463955ec0d8fc9bb6e09~GSmfQuTS71105311053eucas1p2p;
 Thu, 16 Apr 2020 11:48:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200416114848eusmtrp2def4490817dd88b069636a889ccc2aa7~GSmfPshja1089610896eusmtrp2L;
 Thu, 16 Apr 2020 11:48:48 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-0c-5e9846205236
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.C0.07950.026489E5; Thu, 16
 Apr 2020 12:48:48 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200416114847eusmtip140b27105c59b66ea3210be2b8bb787db~GSmd8phLs0505005050eusmtip1R;
 Thu, 16 Apr 2020 11:48:46 +0000 (GMT)
Subject: Re: [PATCH v2 00/33] iommu: Move iommu_group setup to IOMMU core code
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Andy Gross <agross@kernel.org>, Bjorn Andersson
 <bjorn.andersson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob
 Clark <robdclark@gmail.com>, Heiko Stuebner <heiko@sntech.de>, Gerald
 Schaefer <gerald.schaefer@de.ibm.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <551c48b8-3268-6034-2dc6-cec3dbbec250@samsung.com>
Date: Thu, 16 Apr 2020 13:48:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414131542.25608-1-joro@8bytes.org>
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XaOZ2fW5HMVvlp0GRQVZhcTPjKyoOIQVHYhKrBa7WiSW7Kj
 lhVkbV1cV5NwTVtm0bSbpmkqlmiY1NKtVhahZLnuzsTZxS4ut5Plf8/7fL+H93nhYynFJSaM
 TdSm8DqtKknJBNIV9/rs08YvNm2YYdVHkeaOnzQpyypniK22iyZZRdkUqep8zxDv608BJL82
 mmRccQQQg7mAJpm5JVJyouMTRez2AZVV2yQlzuo8hjj1jxDpafdS5OR5PUVM9jsSktlrZsh+
 QyR5d/47Req6XQGkr9pCE2uThSGG1qj5oZyrziLhrlquIq7udT3DVZnbpFxZ4VSu9HImw7W2
 1DCc5f4KruziXi77uRVxx/RdDHerxUJxntKxsfL1gXPVfFJiGq+bPm9T4NbvPZV0cueEnQXv
 8iQZyBNmRDIW8GwoNJymjSiQVeBCBDUP8xhx6EVwz2hifJQCexAUH9s9mHjpLJGIkBWB3tT3
 F/qM4LZH4dMjcCw4zvZTPmgk/kZDfkO5f6BwpQS+Nr1BPorBM8HoNvrTcjwPbG3H/ZrGE8HV
 kTEQYNlROA5yWlaLSDDcP+OifbYMR8GzU+t8NoXHwS13HiXqEHjhOucvB9jFgje3SiK2XggV
 XYeQqEfAx8abUlGPAW/VYECP4FXzNak4HEXg3G/6m4iG1uYfjG8zhadAcfV00V4Amcfdfhtw
 EDx3B4slguBURQ4l2nI4fFAh0pPA3Hj939o6x2PqJFKah1xmHnKOecg55v978xF9GYXwqYIm
 gRdmafkdEYJKI6RqEyK2bNeUooHfa+tv7K1E1b821yPMIuVw+aYY0wZFgCpNSNfUI2Ap5Uh5
 UNSAJVer0nfxuu0bdalJvFCPRrO0MkQeWfAhToETVCn8Np5P5nWDrxJWFpaBlqEDb7qLDPPV
 0omlZ7Jr5qwrXrL8rSdtSvcq57C1i8rVX9vu2qJXdkesyYlL7my3hYZXLt1bNM7xpD94TU/z
 B2tFfGs6p1k9rTDu6Z5IY/yNlAvxk5MTr8Rc/1hQtm+3Vx1+4rfkiPSbUMJs+xK+0Y3Xygwy
 +4MLsQ3h2gZ3jGOHR0kLW1Uzp1I6QfUHpZO/gLkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUhTYRzGeXfOjmfS4ji/XiX8mHhR0HSb09c+LLuQI0gYQyFLa+lJK7fZ
 ziYZUSu9mKPyq0ynrBJLLS/MVdMpyiRKMTORLEOx3MrCHKG7KIxscwa7+/E8v+eFF/4kJujn
 RpJnVFpGo1KUColAfPzvq/ndMRlNBYnrE2HojWMdR5a6ZwQaH3bhqK6rAUP9P74RaGNxmYvu
 De9F+sdvuajK1Iaj6paeAFTjWMbQ5KSH6oYnAtC0rZVA05VTAK1+2sBQ7f1KDDVNDnFQtdtE
 oGtVUrR0/xeG7D+dXPTbZsZRx4SZQFVzsoMRtNNu5tDd5m5A2xdHCLrfNB9AWzp30b2Pqgl6
 bmaQoM1jR2hL+xW64UMHoG9UugjaOmPG6LXeqGx+nmifRq3TMjElala7X3hMjCQicSoSSZJS
 RWJpSv4eiUyYkLaviCk9U85oEtJOikp+rfbhZT9iL7QttXL0YC3SCHgkpJLgwnQPxwgCSQH1
 AMCvyxaur9gBxxr1WxwM/8wYCZ+0AmBnswPzFsHUYWh/+AR4ixBqHYftHwY2LYzq48DVhheb
 loAyAPj3e6yXCUoMjSvep3gkn0qD4/M3Nxmn4qHToff4JBlK5cOqqZ0+JQiONTtxb8yjZPB9
 /VFvjFHJ0Gz5jPk4GlpXWrc4HH503uXUAoHJb23ym5j8Jia/yT2APwIhjI5VFitZiYhVKFmd
 qlhUqFb2As/ZPH/5+2kfMLrkI4AigXAb/+SBpgIBV1HOVihHACQxYQh/u8wT8YsUFRcZjfqE
 RlfKsCNA5vlaHRYZWqj2HKFKe0IsE6egVHGKNEWajIThfANlPy6gihVa5hzDlDGa/zsOyYvU
 g5brVrTDVfGV/qI7dDuvKH8+fiEqYiDXFpr9OrvJmvVe3uEuD7rTUnJpNi19tswuz0nN2bC8
 G1L2R0d/mijkz6VLqbOLo39yTxska6EPVjtiDVfjglhbTafz1uVTe89nxv18OEoMLqMG13pW
 zeucRNSu6eJdzOh0yzPr3X1hjUKcLVGId2EaVvEPnvogHEwDAAA=
X-CMS-MailID: 20200416114848eucas1p26436783dd625463955ec0d8fc9bb6e09
X-Msg-Generator: CA
X-RootMTR: 20200414131600eucas1p16f1ff6aedb780eb795a770dc08e5dec5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200414131600eucas1p16f1ff6aedb780eb795a770dc08e5dec5
References: <CGME20200414131600eucas1p16f1ff6aedb780eb795a770dc08e5dec5@eucas1p1.samsung.com>
 <20200414131542.25608-1-joro@8bytes.org>
Cc: linux-s390@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org
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

Hi Joerg,

On 14.04.2020 15:15, Joerg Roedel wrote:
> here is the second version of this patch-set. The first version with
> some more introductory text can be found here:
>
> 	https://lore.kernel.org/lkml/20200407183742.4344-1-joro@8bytes.org/
>
> Changes v1->v2:
>
> 	* Rebased to v5.7-rc1
>
> 	* Re-wrote the arm-smmu changes as suggested by Robin Murphy
>
> 	* Re-worked the Exynos patches to hopefully not break the
> 	  driver anymore

Thanks for this rework. This version is much better. Works fine on 
various Exynos-based boards (ARM and ARM64).

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com> (for Exynos and 
core changes)

> 	* Fixed a missing mutex_unlock() reported by Marek Szyprowski,
> 	  thanks for that.
>
> There is also a git-branch available with these patches applied:
>
> 	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-probe-device-v2
>
> Please review.
>
> Thanks,
>
> 	Joerg
>
> Joerg Roedel (32):
>    iommu: Move default domain allocation to separate function
>    iommu/amd: Implement iommu_ops->def_domain_type call-back
>    iommu/vt-d: Wire up iommu_ops->def_domain_type
>    iommu/amd: Remove dma_mask check from check_device()
>    iommu/amd: Return -ENODEV in add_device when device is not handled by
>      IOMMU
>    iommu: Add probe_device() and remove_device() call-backs
>    iommu: Move default domain allocation to iommu_probe_device()
>    iommu: Keep a list of allocated groups in __iommu_probe_device()
>    iommu: Move new probe_device path to separate function
>    iommu: Split off default domain allocation from group assignment
>    iommu: Move iommu_group_create_direct_mappings() out of
>      iommu_group_add_device()
>    iommu: Export bus_iommu_probe() and make is safe for re-probing
>    iommu/amd: Remove dev_data->passthrough
>    iommu/amd: Convert to probe/release_device() call-backs
>    iommu/vt-d: Convert to probe/release_device() call-backs
>    iommu/arm-smmu: Convert to probe/release_device() call-backs
>    iommu/pamu: Convert to probe/release_device() call-backs
>    iommu/s390: Convert to probe/release_device() call-backs
>    iommu/virtio: Convert to probe/release_device() call-backs
>    iommu/msm: Convert to probe/release_device() call-backs
>    iommu/mediatek: Convert to probe/release_device() call-backs
>    iommu/mediatek-v1 Convert to probe/release_device() call-backs
>    iommu/qcom: Convert to probe/release_device() call-backs
>    iommu/rockchip: Convert to probe/release_device() call-backs
>    iommu/tegra: Convert to probe/release_device() call-backs
>    iommu/renesas: Convert to probe/release_device() call-backs
>    iommu/omap: Remove orphan_dev tracking
>    iommu/omap: Convert to probe/release_device() call-backs
>    iommu/exynos: Use first SYSMMU in controllers list for IOMMU core
>    iommu/exynos: Convert to probe/release_device() call-backs
>    iommu: Remove add_device()/remove_device() code-paths
>    iommu: Unexport iommu_group_get_for_dev()
>
> Sai Praneeth Prakhya (1):
>    iommu: Add def_domain_type() callback in iommu_ops
>
>   drivers/iommu/amd_iommu.c       |  97 ++++----
>   drivers/iommu/amd_iommu_types.h |   1 -
>   drivers/iommu/arm-smmu-v3.c     |  38 +--
>   drivers/iommu/arm-smmu.c        |  39 ++--
>   drivers/iommu/exynos-iommu.c    |  24 +-
>   drivers/iommu/fsl_pamu_domain.c |  22 +-
>   drivers/iommu/intel-iommu.c     |  68 +-----
>   drivers/iommu/iommu.c           | 393 +++++++++++++++++++++++++-------
>   drivers/iommu/ipmmu-vmsa.c      |  60 ++---
>   drivers/iommu/msm_iommu.c       |  34 +--
>   drivers/iommu/mtk_iommu.c       |  24 +-
>   drivers/iommu/mtk_iommu_v1.c    |  50 ++--
>   drivers/iommu/omap-iommu.c      |  99 ++------
>   drivers/iommu/qcom_iommu.c      |  24 +-
>   drivers/iommu/rockchip-iommu.c  |  26 +--
>   drivers/iommu/s390-iommu.c      |  22 +-
>   drivers/iommu/tegra-gart.c      |  24 +-
>   drivers/iommu/tegra-smmu.c      |  31 +--
>   drivers/iommu/virtio-iommu.c    |  41 +---
>   include/linux/iommu.h           |  21 +-
>   20 files changed, 533 insertions(+), 605 deletions(-)
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
