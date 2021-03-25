Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED5AC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 18:09:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9234E61A2B
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 18:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9234E61A2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CA3C606A2;
	Thu, 25 Mar 2021 18:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bxc1SiuKG3RR; Thu, 25 Mar 2021 18:09:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 36C0160B3B;
	Thu, 25 Mar 2021 18:09:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F01D3C000E;
	Thu, 25 Mar 2021 18:09:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5528C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:09:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF189848A3
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:09:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KLXj7BHkz1BU for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 18:09:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 100128489A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 18:09:34 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D9AA76044F;
 Thu, 25 Mar 2021 18:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616695772;
 bh=r8oiGX8PbZ7QTBwMmz9gonZogHqGaXWlVXCzwalFbJ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KvoY/FVCSoQpb89jqubMSpAK33j/6Ha7hMelMigvT0tY04aZi6TjLSpiA7DaOuuKr
 NZdrvFdfnHV0tqM3jD27YIGtNk8JL1unwIaEIMn1W6wp4++0ew+VFvlU63CSly2/SK
 PIuw0JbJ+7cwlvD7KWW3Pp6GqmwF9bfkk9RVurhpqOTjP3AUkN6bdEgtHdZ/nZUl1O
 fdOsHBGk58qI/8QHLEcYbl4BKGsMREf0W9LwelPRBbZgGnZRAPXxHbtNFaWgK3f010
 Mxmk6BCxibqswP1gPOYGfrax8o8c4qcoJc5Y70NSRCUbJIRdMY0hOFnF2Qmmy9w5l2
 2L1/OPbXpcxVg==
From: Will Deacon <will@kernel.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: arm-smmu: Add compatible for SC7280 SoC
Date: Thu, 25 Mar 2021 18:09:26 +0000
Message-Id: <161668482433.1639092.6431348459607978027.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615788144-29508-1-git-send-email-rnayak@codeaurora.org>
References: <1615788144-29508-1-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, kernel-team@android.com,
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

On Mon, 15 Mar 2021 11:32:24 +0530, Rajendra Nayak wrote:
> Add the SoC specific compatible for SC7280 implementing
> arm,mmu-500.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] dt-bindings: arm-smmu: Add compatible for SC7280 SoC
      https://git.kernel.org/will/c/a9aa2bb18ecb

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
