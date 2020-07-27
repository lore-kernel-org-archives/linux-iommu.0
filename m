Return-Path: <SRS0=a8KZ=BG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEBAC433E4
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 06:26:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1607A2072E
	for <iommu@archiver.kernel.org>; Mon, 27 Jul 2020 06:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejdZFEQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1607A2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C1EE52036D;
	Mon, 27 Jul 2020 06:26:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7E-P7G4fxY9d; Mon, 27 Jul 2020 06:26:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C38120134;
	Mon, 27 Jul 2020 06:26:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CD7FC0050;
	Mon, 27 Jul 2020 06:26:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB946C004D
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C486A87134
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TMEJz1ATIxkb for <iommu@lists.linux-foundation.org>;
 Mon, 27 Jul 2020 06:26:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EF522870AD
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 06:26:54 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id c6so2022457pje.1
 for <iommu@lists.linux-foundation.org>; Sun, 26 Jul 2020 23:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=SvwHT3zjyXrrBuntHjIVAEV0M2NnXn0+m3b0NtDYJoE=;
 b=ejdZFEQvh05oUlpaaf9ORS5njhfQig6+GWZ5iAPvih6BwIK+yozIcqu5gDr5y2tL56
 ADgJc78zCBS2EW98C0yjIxuIsjhx09ehgqbbeHbAwoyMpOQVXTQH1nMrTOPbKRHgt8O9
 sEQlDf+2CMo4G6gOuRpnv5VESD2+VrOWa7LgfpsijoI1HeDvVons3C2Y9+dsPMLZ1Oz3
 Bdws0mCecBLhZm6sHQMYNW4/SJu9hk164lbUn1lN17jQ742Assa0ed2lVhx7uFglNVLw
 cZMgphZV/5Ax8e+K6npZ4GuvFErEUH7JIESgfsRAUz25GtLadeKzdGjt153zNVy4+pwE
 fIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SvwHT3zjyXrrBuntHjIVAEV0M2NnXn0+m3b0NtDYJoE=;
 b=IlEzjmRoY5JkT2S77oGZ00577YvqPF4wcfVSn3Ibvqswjd6btCHr28YmjXarmoZaky
 dAgz/T2SZhOr9k5T7jNxEwIKY9pCK/+YPE52GJzqbNwJceRQGorIIexrFe3tK3m0pBtC
 B0hAmhssx25LQTYrsEYfyfuoaG/CUBl5UzpFcgatC74l1PwWNWrIhhxbNjJpLCgDb5am
 mZes1uRBqde2OO9r/lLm1GkxwhvH3yTmbxUI17YaSDLBDmrIn59No/L+Pi61YCCfSRv4
 8IpKWs/SIHx+7g3wmMA8ghf3g7vE0y4fRtxdzRkT+Fcnp7gdStFE40KQ4JKH5+42VVtJ
 OjOg==
X-Gm-Message-State: AOAM533hJK/zcMQbB5gOaYaayjNgTh+WjJoSBrW8k3ojQi5OxJIlfV1G
 S692pz7dvW+NSLuYBgmb6+DOjA==
X-Google-Smtp-Source: ABdhPJxzOwp68yM0wuFfeb8opsYwXxFrJEEJC31OdMJvY+oua+KBvMHJty3QtAaz4JwNX0GSAm9idQ==
X-Received: by 2002:a17:902:aa82:: with SMTP id
 d2mr17236160plr.336.1595831214315; 
 Sun, 26 Jul 2020 23:26:54 -0700 (PDT)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id g23sm3090336pfo.95.2020.07.26.23.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2020 23:26:53 -0700 (PDT)
Date: Sun, 26 Jul 2020 23:27:03 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Jordan Crouse <jcrouse@codeaurora.org>
Subject: Re: [PATCH v10 04/13] iommu/arm-smmu-qcom: Add implementation for
 the adreno GPU SMMU
Message-ID: <20200727062703.GB3521288@ripper>
References: <20200720154047.3611092-1-jcrouse@codeaurora.org>
 <20200720154047.3611092-5-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200720154047.3611092-5-jcrouse@codeaurora.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
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

On Mon 20 Jul 08:40 PDT 2020, Jordan Crouse wrote:
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
[..]
> +static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
> +		struct device *dev, int start, int count)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +
> +	/*
> +	 * Assign context bank 0 to the GPU device so the GPU hardware can
> +	 * switch pagetables
> +	 */
> +	if (qcom_adreno_smmu_is_gpu_device(dev)) {
> +		if (start > 0 || test_bit(0, smmu->context_map))
> +			return -ENOSPC;
> +
> +		set_bit(0, smmu->context_map);
> +		return 0;
> +	}
> +
> +	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);

If we end up here before the GPU device shows up this is going to
steal the first context bank, causing the subsequent allocation for the
GPU to always fail.

As such I think it would be appropriate for you to adjust "start" to
never be 0 here. And I think it would be appropriate to write this
function as:

	if (gpu) {
		start = 0;
		count = 1;
	} else {
		if (start == 0)
			start = 1;
	}

	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);

Regards,
Bjorn
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
