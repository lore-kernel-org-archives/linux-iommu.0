Return-Path: <SRS0=1PsK=4P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069ADC35E17
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 18:45:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74D020656
	for <iommu@archiver.kernel.org>; Thu, 27 Feb 2020 18:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CUnRpFuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74D020656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 97D198791F;
	Thu, 27 Feb 2020 18:45:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e-H1HqU7h1sg; Thu, 27 Feb 2020 18:45:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06A1487825;
	Thu, 27 Feb 2020 18:45:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD858C08A0;
	Thu, 27 Feb 2020 18:45:45 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0A51C0177
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B17DF8791F
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q4cacT1kcqaN for <iommu@lists.linux-foundation.org>;
 Thu, 27 Feb 2020 18:45:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9A4F587825
 for <iommu@lists.linux-foundation.org>; Thu, 27 Feb 2020 18:45:42 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1582829142; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=U/EDQ0pr75hfPnWX/OCbb8FxwwnZ09FdliYUIRis9EI=;
 b=CUnRpFuQyn28SJzfxhZG3EwXBVMBgj6S0jDgW3IkymFktuNG89bSK/lyqk14djRRAQIk4JPe
 5NdMpph6ra3EEQtEdvgNn1lJ86VQyvsTeVgoZD+UoSrC+NAqRTHy+XdjxfkFcZ4FAfNzU/us
 pIwIW8/HM0XbcNzQyZTz6vEUQvc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e580e55.7f4acd055068-smtp-out-n01;
 Thu, 27 Feb 2020 18:45:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 92985C447A6; Thu, 27 Feb 2020 18:45:41 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 83C15C433A2;
 Thu, 27 Feb 2020 18:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 83C15C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Thu, 27 Feb 2020 11:45:34 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: Re: [Freedreno] [PATCH v5 0/5] iommu/arm-smmu: Split pagetable
 support for arm-smmu-v2
Message-ID: <20200227184534.GA25772@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: iommu@lists.linux-foundation.org,
 Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Wen Yang <wen.yang99@zte.com.cn>,
 will@kernel.org, Joerg Roedel <joro@8bytes.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 linux-arm-kernel@lists.infradead.org,
 Wambui Karuga <wambui.karugax@gmail.com>,
 freedreno@lists.freedesktop.org, Fritz Koenig <frkoenig@google.com>,
 linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>,
 Allison Randal <allison@lohutok.net>,
 Enrico Weigelt <info@metux.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Douglas Anderson <dianders@chromium.org>,
 linux-kernel@vger.kernel.org, zhengbin <zhengbin13@huawei.com>,
 Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Drew Davenport <ddavenport@chromium.org>,
 Brian Masney <masneyb@onstation.org>, robin.murphy@arm.com,
 Georgi Djakov <georgi.djakov@linaro.org>
References: <1580248819-12644-1-git-send-email-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1580248819-12644-1-git-send-email-jcrouse@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, David Airlie <airlied@linux.ie>,
 dri-devel@lists.freedesktop.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, will@kernel.org,
 Jeykumar Sankaran <jsanka@codeaurora.org>, Sam Ravnborg <sam@ravnborg.org>,
 Wen Yang <wen.yang99@zte.com.cn>, Ben Dooks <ben.dooks@codethink.co.uk>,
 linux-arm-kernel@lists.infradead.org, Wambui Karuga <wambui.karugax@gmail.com>,
 Fritz Koenig <frkoenig@google.com>, linux-arm-msm@vger.kernel.org,
 Sharat Masetty <smasetty@codeaurora.org>, robin.murphy@arm.com,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>,
 Allison Randal <allison@lohutok.net>, Enrico Weigelt <info@metux.net>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org,
 zhengbin <zhengbin13@huawei.com>, Daniel Vetter <daniel@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Drew Davenport <ddavenport@chromium.org>, Brian Masney <masneyb@onstation.org>,
 freedreno@lists.freedesktop.org, Georgi Djakov <georgi.djakov@linaro.org>
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

On Tue, Jan 28, 2020 at 03:00:14PM -0700, Jordan Crouse wrote:
> This is another iteration for the split pagetable support based on the
> suggestions from Robin and Will [1].
> 
> Background: In order to support per-context pagetables the GPU needs to enable
> split tables so that we can store global buffers in the TTBR1 space leaving the
> GPU free to program the TTBR0 register with the address of a context specific
> pagetable.
> 
> If the DOMAIN_ATTR_SPLIT_TABLES attribute is set on the domain before attaching,
> the context bank assigned to the domain will be programmed to allow translations
> in the TTBR1 space. Translations in the TTBR0 region will be disallowed because,
> as Robin pointe out, having a un-programmed TTBR0 register is dangerous.
> 
> The driver can determine if TTBR1 was successfully programmed by querying
> DOMAIN_ATTR_SPLIT_TABLES after attaching. The domain geometry will also be
> updated to reflect the virtual address space for the TTBR1 range.
> 
> Upcoming changes will allow auxiliary domains to be attached to the device which
> will enable and program TTBR0.
> 
> This patchset is based on top of linux-next-20200127.

Quick ping for feedback so I can respin for (maybe?) 5.6.

Thanks,
Jordan

> Change log:
> 
> v4: Only program TTBR1 when split pagetables are requested. TTBR0 will be
> enabled later when an auxiliary domain is attached
> v3: Remove the implementation specific and make split pagetable support
> part of the generic configuration
> 
> [1] https://lists.linuxfoundation.org/pipermail/iommu/2020-January/041373.html
> 
> Jordan Crouse (5):
>   iommu: Add DOMAIN_ATTR_SPLIT_TABLES
>   iommu/arm-smmu: Add support for TTBR1
>   drm/msm: Attach the IOMMU device during initialization
>   drm/msm: Refactor address space initialization
>   drm/msm/a6xx: Support split pagetables
> 
>  drivers/gpu/drm/msm/adreno/a2xx_gpu.c    | 16 ++++++++++
>  drivers/gpu/drm/msm/adreno/a3xx_gpu.c    |  1 +
>  drivers/gpu/drm/msm/adreno/a4xx_gpu.c    |  1 +
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c    |  1 +
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c    | 51 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c  | 23 ++++++++++----
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h  |  8 +++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 18 ++++-------
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 18 +++++------
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c |  4 ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 18 +++++------
>  drivers/gpu/drm/msm/msm_drv.h            |  8 ++---
>  drivers/gpu/drm/msm/msm_gem_vma.c        | 36 ++++------------------
>  drivers/gpu/drm/msm/msm_gpu.c            | 49 ++----------------------------
>  drivers/gpu/drm/msm/msm_gpu.h            |  4 +--
>  drivers/gpu/drm/msm/msm_gpummu.c         |  6 ----
>  drivers/gpu/drm/msm/msm_iommu.c          | 18 ++++++-----
>  drivers/gpu/drm/msm/msm_mmu.h            |  1 -
>  drivers/iommu/arm-smmu.c                 | 48 +++++++++++++++++++++++++-----
>  drivers/iommu/arm-smmu.h                 | 22 ++++++++++----
>  include/linux/iommu.h                    |  2 ++
>  21 files changed, 198 insertions(+), 155 deletions(-)
> 
> -- 
> 2.7.4
> _______________________________________________
> Freedreno mailing list
> Freedreno@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
