Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ADEC433E6
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:22:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8459123343
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8459123343
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 14953274AA;
	Thu,  7 Jan 2021 14:22:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L3VfApjVpPBA; Thu,  7 Jan 2021 14:22:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E23E6272E3;
	Thu,  7 Jan 2021 14:22:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBAA1C1DA7;
	Thu,  7 Jan 2021 14:22:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C42AC088B
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4999C2042D
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:22:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lS2+RQBB6iJM for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 14:22:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 2F6DB272E3
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:22:55 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 028F223355;
 Thu,  7 Jan 2021 14:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610029374;
 bh=oNLPJObW2d3YofpkNjkaRbAPG15OxVo1dNrFQ+tYOAk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vRO705TTCihW/nt+W1NTwTO30dWw+FCwmHKdGwCkUKgJIePLYAgeMuT7Z5ZzQ+IWn
 HAecnqHoHDkHHAr+gdxLjoRDxDrI9UJwRSs4s+MkMC5lT/KvTbJ2I2B0KXxFutYKYT
 bDPXEuPIvgn6uQy6hFIKM8cdCtaEgyJ2/UZC7/BPqCzHus/RwOSFAMDVuQ4JRBqpcq
 +zSrbG69307ZWYgkOvqm42COAzZIP2Jw19THIvwdobP2YJfXjDAuT0GQtHuyW8vPHT
 B2thw+fGL1JLK+qn+FJx+afc6yWSTv8I42k0BsZdte5J3ov0uO18kAZD/KmIJ4L+IY
 Ks0qTuF9ZtQYA==
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Initialize SCTLR of the bypass
 context
Date: Thu,  7 Jan 2021 14:22:47 +0000
Message-Id: <161002864635.3143366.6483038182849083276.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106005038.4152731-1-bjorn.andersson@linaro.org>
References: <20210106005038.4152731-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-arm-msm@vger.kernel.org, kernel-team@android.com,
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

On Tue, 5 Jan 2021 16:50:38 -0800, Bjorn Andersson wrote:
> On SM8150 it's occasionally observed that the boot hangs in between the
> writing of SMEs and context banks in arm_smmu_device_reset().
> 
> The problem seems to coincide with a display refresh happening after
> updating the stream mapping, but before clearing - and there by
> disabling translation - the context bank picked to emulate translation
> bypass.
> 
> [...]

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu/arm-smmu-qcom: Initialize SCTLR of the bypass context
      https://git.kernel.org/arm64/c/aded8c7c2b72

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
