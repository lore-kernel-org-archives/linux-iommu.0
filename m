Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE09C4743E
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 17:17:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E431D6136D
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 17:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E431D6136D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF27A4011B;
	Tue,  8 Jun 2021 17:16:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oY9NS_cKCLRs; Tue,  8 Jun 2021 17:16:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5682B400FC;
	Tue,  8 Jun 2021 17:16:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E00AC000D;
	Tue,  8 Jun 2021 17:16:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2D26C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 17:16:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B488A83BFF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 17:16:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iF5l8jWGQotY for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 17:16:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18CF383BF8
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 17:16:56 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3F7E61351;
 Tue,  8 Jun 2021 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623172615;
 bh=DaPFTt06ZX9vrnUdxgsyoxWQxOB00PNGVCYx24PpEGY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VK2XP8JOZiplEBMfE6qiNiXA3oNdqTFu374He9eycmhA/IWpRAegRF9Pj9zjPXqq+
 mMKtfN0gTk1J9XHTC/VoFQS3Scd1juZ/gjTpRoG46Eq8tfFH+JPX3FOczigR01GUqE
 Gtb06n3zf9naCHxEerD2PUvcisjN8QL+tGki3MYbc9ESvcAfbYUbwLNOHDgh7RpiQv
 2QwPF/pr/V7mqYbGEMUUjBxnByIBpi9NMF+mPoKGthxDC7ZZ+3WZLhzgcswWwsPpNW
 9c2O8dvR2ondNB1wwt4CPrxUwyULAKAZpDptWcAXVmQ5P+V7WfuOzGONDlwEMM+slZ
 2losHzMFS0IJQ==
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>, Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH] iommu/arm: Cleanup resources in case of probe error path
Date: Tue,  8 Jun 2021 18:16:47 +0100
Message-Id: <162317119382.2860700.13290595260136409197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608164559.204023-1-ameynarkhede03@gmail.com>
References: <20210608164559.204023-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jon Hunter <jonathanh@nvidia.com>, linux-arm-msm@vger.kernel.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, 8 Jun 2021 22:15:59 +0530, Amey Narkhede wrote:
> If device registration fails, remove sysfs attribute
> and if setting bus callbacks fails, unregister the device
> and cleanup the sysfs attribute.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm: Cleanup resources in case of probe error path
      https://git.kernel.org/will/c/249c9dc6aa0d

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
