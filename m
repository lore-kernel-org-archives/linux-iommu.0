Return-Path: <SRS0=k4B3=A3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3F2C433E0
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 12:00:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1306120739
	for <iommu@archiver.kernel.org>; Thu, 16 Jul 2020 12:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKRz5oHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1306120739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE131899D8;
	Thu, 16 Jul 2020 12:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vGyRfjiwWBaO; Thu, 16 Jul 2020 12:00:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 42E71896D4;
	Thu, 16 Jul 2020 12:00:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26926C0893;
	Thu, 16 Jul 2020 12:00:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A17CC0733
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0617188E92
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:00:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cWis3pZCNYSq for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jul 2020 12:00:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 955D188E8F
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jul 2020 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F28D420760;
 Thu, 16 Jul 2020 12:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594900852;
 bh=wzG1kO8a1wB9j6Gomc3oh/l5KQknXb3VN9MC8crfe+M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vKRz5oHOJKLP/zkX6KfZVqNaI9BvlpFZ4QIskBlcNAHhZQvGap40sdFnQz2hID1t5
 mDSS7NWG61g+LLB8NBwLfEPHotSktRSD977MrJXCttAf01MADI22etKpe/Q64138Lj
 T9HYIfQrcIFCBf7NHyPZoRzjDzY9FsYwceZhanZM=
From: Will Deacon <will@kernel.org>
To: robh+dt@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 Tomasz Nowicki <tn@semihalf.com>, hannah@marvell.com,
 gregory.clement@bootlin.com
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
Date: Thu, 16 Jul 2020 13:00:43 +0100
Message-Id: <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715070649.18733-1-tn@semihalf.com>
References: <20200715070649.18733-1-tn@semihalf.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, nadavh@marvell.com,
 iommu@lists.linux-foundation.org, mw@semihalf.com, kernel-team@android.com,
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

On Wed, 15 Jul 2020 09:06:45 +0200, Tomasz Nowicki wrote:
> The series is meant to support SMMU for AP806 and a workaround
> for accessing ARM SMMU 64bit registers is the gist of it.
> 
> For the record, AP-806 can't access SMMU registers with 64bit width.
> This patches split the readq/writeq into two 32bit accesses instead
> and update DT bindings.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/3] iommu/arm-smmu: Call configuration impl hook before consuming features
      https://git.kernel.org/will/c/6a79a5a3842b
[2/3] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
      https://git.kernel.org/will/c/f2d9848aeb9f
[3/3] dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806 SMMU-500
      https://git.kernel.org/will/c/e85e84d19b9d

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
