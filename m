Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164B8C433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 14:18:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE868619C7
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 14:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE868619C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82B71607D4;
	Tue, 30 Mar 2021 14:18:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ghan9YAhgefS; Tue, 30 Mar 2021 14:18:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74E0C607D5;
	Tue, 30 Mar 2021 14:18:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39C15C000B;
	Tue, 30 Mar 2021 14:18:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58D15C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 14:18:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54E5A401B9
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 14:18:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Pd5zUCDUfPDS for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 14:18:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8BCD440183
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 14:18:22 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF7A0619BD;
 Tue, 30 Mar 2021 14:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617113901;
 bh=mw2BoYMkk50gJnxLPZ/lx5JtGrVBdquDZ6wFytju0xI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H0K0xJ9tB7S3rrRfNPkCt7qTQzyqnxDg3OHYYHv9veLvRzjv3ssxI2ppOhj22qGEL
 7KA9YsakH5/CSxY3R4H+T/6iqCDs+znk7PcOwspePYvLgV+hiJVf+hT/3xBnB6EkVi
 J7daqdPKOqgMW0DiDtlqPgyHiN5I5tZMVI8HMzJ0tetT586OB1HmxVFHDgQWoQzcww
 nNrnB3YCViyvM4mLEmBqqu3Qe5w/zaQt95RHVJ29EIFbHSDeRi7YcDx5NoeMaIVPRx
 KiDQpYI38WEt36x6QlPWW7jLonQx7mODqrsvYpod2bRx+5EkTCaW64bN3mXZzyphLX
 vvKIf3hUbij0A==
From: Will Deacon <will@kernel.org>
To: chenxiang <chenxiang66@hisilicon.com>,
	robin.murphy@arm.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Add a check to avoid invalid iotlb
 sync
Date: Tue, 30 Mar 2021 15:18:16 +0100
Message-Id: <161711321215.292681.15928114582623786457.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1617109106-121844-1-git-send-email-chenxiang66@hisilicon.com>
References: <1617109106-121844-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
 kernel-team@android.com, linuxarm@openeuler.org, Will Deacon <will@kernel.org>
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

On Tue, 30 Mar 2021 20:58:26 +0800, chenxiang wrote:
> It may send a invalid tlb sync for smmuv3 if iotlb_gather is not valid
> (iotlb_gather->pgsize = 0). So add a check to avoid invalid iotlb sync
> for it.

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Add a check to avoid invalid iotlb sync
      https://git.kernel.org/will/c/6cc7e5a9c6b0

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
