Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDBAC433E9
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:49:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C906023A5C
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C906023A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A77CA870E1;
	Fri, 22 Jan 2021 13:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QCn+v2VIzLIO; Fri, 22 Jan 2021 13:49:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5311B8701E;
	Fri, 22 Jan 2021 13:49:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FE82C08A1;
	Fri, 22 Jan 2021 13:49:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09294C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EDD118738F
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pVwm-ZqEc+Xv for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:49:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 94BB487396
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:49:47 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BB5223A56;
 Fri, 22 Jan 2021 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611323387;
 bh=SunCbNL4thbixbqDicq4yiLamp38pRmNRlL/3HAqsk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lk46HK/GrIT2Tqbb4rsxVgvFAOZ13xkVQe2JlPxXmufo1EC7vCIsS3D4UJahDbvjU
 t53MeaWONPrXofvDYvCD8kWznq1lUhvke7DpKq4jVqRLUoBMZjj6Y/3eOB6v02VSgK
 BrysGMDpezrrSTONUXkkYQ8iDmx5ApijCpSZiiCD0yEOsm8TuPwApntnY8Bdnq0kf7
 CeMnxKOCCzc6TdL9TaRfi0mNX8s332dJgQGjfJwSmoDw8sjsH3D5TQ1iatvz6qcK/q
 dS98DaRBtAmXPwfQ9C2GrK0Se31gAyAAN0qCAvr7udrGTsDNpWFYwSUBSQ+mMTzIN2
 g/eCH2+5EdCnQ==
From: Will Deacon <will@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add sm8350 compatible string
Date: Fri, 22 Jan 2021 13:49:34 +0000
Message-Id: <161132142879.229688.17163617235466107602.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210115090322.2287538-1-vkoul@kernel.org>
References: <20210115090322.2287538-1-vkoul@kernel.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-msm@vger.kernel.org, kernel-team@android.com,
 linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
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

On Fri, 15 Jan 2021 14:33:21 +0530, Vinod Koul wrote:
> Add compatible string for sm8350 iommu to documentation.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] dt-bindings: arm-smmu: Add sm8350 compatible string
      https://git.kernel.org/will/c/70b5b6a6daea
[2/2] iommu: arm-smmu-impl: Add SM8350 qcom iommu implementation
      https://git.kernel.org/will/c/d8498b1e4ecc

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
