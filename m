Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42199C433DB
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 18:56:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C745D23AC6
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 18:56:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C745D23AC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4E691873AE;
	Fri, 22 Jan 2021 18:56:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n7EOjF7dfelC; Fri, 22 Jan 2021 18:56:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A3C5873A8;
	Fri, 22 Jan 2021 18:56:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3379BC088B;
	Fri, 22 Jan 2021 18:56:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80094C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 18:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 65E53873A8
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 18:56:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R+s6f9Mp3hyv for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 18:56:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E95FE873A5
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 18:56:14 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6E0523AC1;
 Fri, 22 Jan 2021 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611341774;
 bh=qVSjQWO5A47y/Az4jMC7I8tgdvH/HRiymJ+sGYGCA9M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TzwrXEOJ7Psap4TeRPKnPyrVq0SU/3AP+JP9myar5d1ODv+SmqMnz7Hyg5laWBrzk
 8EJ1il121XUDjASUVpXFoBR+mDY1+xCDt9nOkT/AP5b809bJ0huhQVsQnvHmDTLmMN
 vkQegR8QZOiJ4ErjMwsM0bEM/p1Rq0xwZbD3vp69dSzuIk4sX4S7OFasfE4opxNJNL
 Hh9p9DgA7PDB7db/XQcK11T6jD5LVxzBunRJqY939ms/JfSSBFlh+hvZcadgNYIIK3
 C8FRpUAyeK8X9dPceZf9XWs3I+FuaFoV7JAb4AP2ISUUT0vWZ1ahiwtZWZDU/Gj0xJ
 wNnkp/jtfyHHA==
From: Will Deacon <will@kernel.org>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, robin.murphy@arm.com,
 joro@8bytes.org
Subject: Re: [PATCH v2 0/3] iommu/arm-smmu-v3: TLB invalidation for SVA
Date: Fri, 22 Jan 2021 18:56:09 +0000
Message-Id: <161133027280.1510517.883040182514210311.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122151054.2833521-1-jean-philippe@linaro.org>
References: <20210122151054.2833521-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, vivek.gautam@arm.com,
 catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, kernel-team@android.com,
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

On Fri, 22 Jan 2021 16:10:53 +0100, Jean-Philippe Brucker wrote:
> Since v1 [1]
> * Renamed arm_smmu_tlb_inv_range()
> * Removed unnecessary tlb_inv_command variable
> * Rebased onto for-joerg/arm-smmu/updates (oddly I didn't get any
>   conflict, I hope it will apply this time)
> 
> [1] https://lore.kernel.org/linux-iommu/20210122115257.2502526-1-jean-philippe@linaro.org/
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] iommu/arm-smmu-v3: Split arm_smmu_tlb_inv_range()
      https://git.kernel.org/will/c/eba8d2f8f803
[2/3] iommu/arm-smmu-v3: Make BTM optional for SVA
      https://git.kernel.org/will/c/51d113c3be09
[3/3] iommu/arm-smmu-v3: Add support for VHE
      https://git.kernel.org/will/c/9111aebf770d

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
