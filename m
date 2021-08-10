Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5080FC4320A
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 20:26:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEFF60F13
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 20:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAEFF60F13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B48ED40290;
	Tue, 10 Aug 2021 20:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6JhmwspiQKER; Tue, 10 Aug 2021 20:26:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ADFE540266;
	Tue, 10 Aug 2021 20:26:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83C62C001A;
	Tue, 10 Aug 2021 20:26:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BF76C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:26:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 740B4835A9
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:26:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tvMmZNi_z1q0 for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 20:26:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B216824DD
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:26:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 910E960F13;
 Tue, 10 Aug 2021 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628627163;
 bh=M/gnx8A37cYi/RDawoflYj+z3IDmvAjd8upAEDz9esk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OVyzkRR7dz1I8A71AVZ9lXDMwcNEDyYltsZvLNHAn5xLieb1pReRv8tfvyyQUtnlF
 4QRuZgxcF0uh6tHCwZVzksts4/YIbTqwgVZk3bFw1EwldWBCSUUucfTVxXxQz/4VQR
 7xCbkYhHydV4j0hP5zgKze1qJb8QS0CWXkXuTQZpLFwbwNvhVThq/NQAmFdci+Gh3h
 CIqjEcgam7ufabC88dgvI2UU55vTU/rp/jTI/mbM2Kw+5pINWfuX2crRXk+MAOHUg4
 diT3vHlTWh7zbsacTTJJsj/WUpclce2rfFgKa4hyMFe08BkXYr1CLf/PdBfI4Riq9T
 +vSnHZGuZJAHw==
From: Will Deacon <will@kernel.org>
To: robin.murphy@arm.com, vdumpa@nvidia.com, Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [Patch V3 0/2] iommu/arm-smmu: Fix races in iommu domain/group
 creation
Date: Tue, 10 Aug 2021 21:25:54 +0100
Message-Id: <162861955924.3590382.10228157894867875931.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
References: <1628570641-9127-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org
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

On Tue, 10 Aug 2021 10:13:59 +0530, Ashish Mhetre wrote:
> When two devices with same SID are getting probed concurrently through
> iommu_probe_device(), the iommu_group and iommu_domain are allocated more
> than once because they are not protected for concurrency. This is leading
> to context faults when one device is accessing IOVA from other device.
> Fix this by protecting iommu_domain and iommu_group creation with mutexes.
> 
> Changes in v3:
> * Updated commit messages.
> * Added Signed-off-by in patch 2.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/2] iommu: Fix race condition during default domain allocation
      https://git.kernel.org/will/c/211ff31b3d33
[2/2] iommu/arm-smmu: Fix race condition during iommu_group creation
      https://git.kernel.org/will/c/b1a1347912a7

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
