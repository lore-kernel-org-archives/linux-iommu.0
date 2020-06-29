Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BD1C433DF
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 21:52:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376FA206C3
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 21:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khSkOa1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376FA206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0EEE686BFF;
	Mon, 29 Jun 2020 21:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCfh_ZY1AjVd; Mon, 29 Jun 2020 21:52:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9AFA9854E5;
	Mon, 29 Jun 2020 21:52:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B6A8C07FF;
	Mon, 29 Jun 2020 21:52:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2DBEC016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 21:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 909B68851D
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 21:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cdG18bykQbcl for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 21:51:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0276888507
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 21:51:57 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id q17so8462009pfu.8
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 14:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RvMj5yET6zod7vEbQyQ+dyCF/KGdDXqpRazv7Nh0/qE=;
 b=khSkOa1iOR9sKq/l2Lwg2R+70F1qzc3rAWzT1DL81iYJKmfl0OXAKmLaQcEHYh75HD
 Dim7FCtnFG0m3Y7kmHUxgsykRsUHZT5JQ3g87aZYI4UDZCCTRHwPIe67iXeMWm5sEQfb
 S3DB34IC0Dv9F409Wj8gM0iG9PKhXAsgikpd3QtZ0pNSzZcG6ZPjeTArTudFcF1akU6m
 eYGILAK+dTr82RFhdBeh3NutZ5dWsG+VNNMJoyuEh2Ok8m/Rse1bW+zrHLKD0opEhiNz
 FdieyEh5ErWKSTF9nDD3gmex2heXZGcC2WmHB7o+O5FROMQJFQSgrf+aYMzwv6arrIWW
 yfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RvMj5yET6zod7vEbQyQ+dyCF/KGdDXqpRazv7Nh0/qE=;
 b=qWgg03WPzlZinEUbLz86QVoax7hDdcHHXP9BGFpCNT0VuceDvWWblL3DYgq4kit76H
 SluW+JI0km59g2NYiH4nd/DVDJLLyZpyjuy6/hxP3jB9wCbm8e32eJeV9R4eK+NjOJpZ
 asQs6Cnah0oOOqJCKKnrz5zmfgvvyMTzNkxjnpA962/NyvBN4yRmHVQa5q5yOLC+sB3k
 BVKfhp1f5/ifpJkpp8hs7HkRO+3SixZQRiz6mGk9aKiEHuHbWGAzH5zI4CiQGc5IsgFN
 bhfoOCpf7f9lgKXtTW4VI84CNKe7akZqSujTlmgEyBTye0UP1xKosJfJp/jLH9/fqGTi
 AT4Q==
X-Gm-Message-State: AOAM532SrujLsK0PFB+VFGxHR4nJSR40XI6/Eun8t95J3XEJBHFuP9Y3
 5WztAzTwjUPQ2mIwUtuOvo4=
X-Google-Smtp-Source: ABdhPJxC8Fgjn8RTlD0SKk0xsVZpbiGlo9R3VT7A5mIZwpCLggeB5EdfCEKblPcw3+omhGtZUjddyQ==
X-Received: by 2002:a63:f903:: with SMTP id h3mr12511677pgi.437.1593467517533; 
 Mon, 29 Jun 2020 14:51:57 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id p189sm542487pfb.217.2020.06.29.14.51.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 29 Jun 2020 14:51:57 -0700 (PDT)
Date: Mon, 29 Jun 2020 14:51:24 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v7 1/3] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Message-ID: <20200629215124.GD27967@Asurada-Nvidia>
References: <20200629022838.29628-1-vdumpa@nvidia.com>
 <20200629022838.29628-2-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200629022838.29628-2-vdumpa@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: snikam@nvidia.com, mperttunen@nvidia.com, bhuntsman@nvidia.com,
 will@kernel.org, linux-kernel@vger.kernel.org, praithatha@nvidia.com,
 talho@nvidia.com, iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

On Sun, Jun 28, 2020 at 07:28:36PM -0700, Krishna Reddy wrote:
> NVIDIA's Tegra194 SoC uses two ARM MMU-500s together to interleave
> IOVA accesses across them.
> Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
> string for Tegra194 SoC SMMU topology.
> 
> Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>

> +static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
> +			       unsigned int inst, int page)
> +{
> +	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
> +
> +	if (!nvidia_smmu->bases[0])
> +		nvidia_smmu->bases[0] = smmu->base;
> +
> +	return nvidia_smmu->bases[inst] + (page << smmu->pgshift);
> +}

Not critical -- just a nit: why not put the bases[0] in init()?

Everything else looks good to me:

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
