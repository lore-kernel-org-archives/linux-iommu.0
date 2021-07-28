Return-Path: <SRS0=45t2=MU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC0C4338F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 14:01:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014DF60C3F
	for <iommu@archiver.kernel.org>; Wed, 28 Jul 2021 14:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 014DF60C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BC175400FA;
	Wed, 28 Jul 2021 14:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GjrgqzAD3jQR; Wed, 28 Jul 2021 14:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6177740015;
	Wed, 28 Jul 2021 14:01:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13E3FC001A;
	Wed, 28 Jul 2021 14:01:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95956C000E
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:01:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 83C294062D
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:01:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BVmKL72snN_z for <iommu@lists.linux-foundation.org>;
 Wed, 28 Jul 2021 14:01:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9545040626
 for <iommu@lists.linux-foundation.org>; Wed, 28 Jul 2021 14:01:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A326E600EF;
 Wed, 28 Jul 2021 14:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627480860;
 bh=sNNg1eBjaBERoOL+pNGqJG1GnXOiFtnWCHGA3ZA1guw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uSK3rYX334vCPmIzWf/THTX34yLnn8ni/QBiKG2wSaCIb8flS7V+h/B0eP4sytljM
 /dQCjspApub1KKi22poI11WUSYyfjIatH2hfq7qGrbqIBlbq4S7vAjAAhS+KS8TxV8
 5woiYW5ZUA5Il7RUYHhP1Ry/YyXRyBxz8Ox2BtJMlMkWsKjuc9kKYiDOiacib9sy0i
 aPfPMZkkYmDggAK37mahkCnICO1fDZeN0JaiIFzgSxGeXShgdXEF1DAYPxU22ln/Di
 kGzFe7xSqPBokwQ8jjNqfX2hYMIrPy1ah7XaTQx6UwViWPpfyLEfsPSfZ5MEsWr3Ps
 NAkXFU5X3exlg==
Date: Wed, 28 Jul 2021 17:00:53 +0300
From: Georgi Djakov <djakov@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCH 0/3] iommu/drm/msm: Allow non-coherent masters to use
 system cache
Message-ID: <20210728140052.GB22887@mms-0441>
References: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1610372717.git.saiprakash.ranjan@codeaurora.org>
Cc: isaacm@codeaurora.org, David Airlie <airlied@linux.ie>,
 Will Deacon <will@kernel.org>, Akhil P Oommen <akhilpo@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Sean Paul <sean@poorly.run>, Jordan Crouse <jcrouse@codeaurora.org>,
 Kristian H Kristensen <hoegsberg@google.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
 freedreno <freedreno@lists.freedesktop.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

On Mon, Jan 11, 2021 at 07:45:02PM +0530, Sai Prakash Ranjan wrote:
> commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag")
> removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
> the memory type setting required for the non-coherent masters to use
> system cache. Now that system cache support for GPU is added, we will
> need to set the right PTE attribute for GPU buffers to be sys cached.
> Without this, the system cache lines are not allocated for GPU.
> 
> So the patches in this series introduces a new prot flag IOMMU_LLC,
> renames IO_PGTABLE_QUIRK_ARM_OUTER_WBWA to IO_PGTABLE_QUIRK_PTW_LLC
> and makes GPU the user of this protection flag.

Hi Sai,

Thank you for the patchset! Are you planning to refresh it, as it does
not apply anymore?

Thanks,
Georgi

> 
> The series slightly depends on following 2 patches posted earlier and
> is based on msm-next branch:
>  * https://lore.kernel.org/patchwork/patch/1363008/
>  * https://lore.kernel.org/patchwork/patch/1363010/
> 
> Sai Prakash Ranjan (3):
>   iommu/io-pgtable: Rename last-level cache quirk to
>     IO_PGTABLE_QUIRK_PTW_LLC
>   iommu/io-pgtable-arm: Add IOMMU_LLC page protection flag
>   drm/msm: Use IOMMU_LLC page protection flag to map gpu buffers
> 
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 3 +++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
>  drivers/gpu/drm/msm/msm_iommu.c         | 3 +++
>  drivers/gpu/drm/msm/msm_mmu.h           | 4 ++++
>  drivers/iommu/io-pgtable-arm.c          | 9 ++++++---
>  include/linux/io-pgtable.h              | 6 +++---
>  include/linux/iommu.h                   | 6 ++++++
>  7 files changed, 26 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 00fd44a1a4700718d5d962432b55c09820f7e709
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
