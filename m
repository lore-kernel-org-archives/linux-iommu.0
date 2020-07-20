Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EC7C433E6
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 11:56:27 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509E520773
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 11:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgpMW2ZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509E520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E26B85E95;
	Mon, 20 Jul 2020 11:56:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q7HVAliT5dlm; Mon, 20 Jul 2020 11:56:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A112A85DD1;
	Mon, 20 Jul 2020 11:56:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85CD1C089F;
	Mon, 20 Jul 2020 11:56:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97A13C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 11:56:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 80FC7873DE
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 11:56:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uOh7+EZ+aCP4 for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 11:56:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 0E59D873DC
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 11:56:25 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4D1CC20773;
 Mon, 20 Jul 2020 11:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595246184;
 bh=/UaHuvv/N6zEnDH3a7uxqwhmtAhJjPRJyrmfudr9r4Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JgpMW2ZHb8ZkEKMlQlIKL2GYAEYHFnR2OPW2FX1bGSOOH5BPUbgD74/ljwX/cK7w1
 RAEeANkHk+VP9qURl4vMyo92BPscXjjMkJA/nemw/7LYmrOaUmV3zsewyLjKtoogmv
 xlUMv/7geCOuzDv5gmRJkjPmTpVmqwfChleN71U4=
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org, robh+dt@kernel.org, Krishna Reddy <vdumpa@nvidia.com>,
 robin.murphy@arm.com, jonathanh@nvidia.com, treding@nvidia.com
Subject: Re: [PATCH v11 0/5] NVIDIA ARM SMMU Implementation
Date: Mon, 20 Jul 2020 12:56:09 +0100
Message-Id: <159523385148.790143.14826100945729579786.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200718193457.30046-1-vdumpa@nvidia.com>
References: <20200718193457.30046-1-vdumpa@nvidia.com>
MIME-Version: 1.0
Cc: snikam@nvidia.com, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
 bhuntsman@nvidia.com, catalin.marinas@arm.com, yhsu@nvidia.com,
 praithatha@nvidia.com, talho@nvidia.com, iommu@lists.linux-foundation.org,
 nicolinc@nvidia.com, linux-tegra@vger.kernel.org, mperttunen@nvidia.com,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 bbiswas@nvidia.com
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

On Sat, 18 Jul 2020 12:34:52 -0700, Krishna Reddy wrote:
> Changes in v11:
> Addressed Rob comment on DT binding patch to set min/maxItems of reg property in else part.
> Rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates.
> 
> Changes in v10:
> Perform SMMU base ioremap before calling implementation init.
> Check for Global faults across both ARM MMU-500s during global interrupt.
> Check for context faults across all contexts of both ARM MMU-500s during context fault interrupt.
> Add new DT binding nvidia,smmu-500 for NVIDIA implementation.
> https://lkml.org/lkml/2020/7/8/57
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/5] iommu/arm-smmu: move TLB timeout and spin count macros
      https://git.kernel.org/will/c/cd8479cf0de9
[2/5] iommu/arm-smmu: ioremap smmu mmio region before implementation init
      https://git.kernel.org/will/c/6c019f4e697e
[3/5] iommu/arm-smmu: add NVIDIA implementation for ARM MMU-500 usage
      https://git.kernel.org/will/c/aab5a1c88276
[4/5] dt-bindings: arm-smmu: add binding for Tegra194 SMMU
      https://git.kernel.org/will/c/3d2deb0cdb69
[5/5] iommu/arm-smmu: Add global/context fault implementation hooks
      https://git.kernel.org/will/c/aa7ec73297df

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
