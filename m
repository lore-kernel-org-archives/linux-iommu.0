Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF72FC48BD1
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 16:16:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F32E61285
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 16:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F32E61285
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E0C940500;
	Fri, 11 Jun 2021 16:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r5dmQgMu-XA6; Fri, 11 Jun 2021 16:16:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C2F74023D;
	Fri, 11 Jun 2021 16:16:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 071B9C000D;
	Fri, 11 Jun 2021 16:16:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36075C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B80E4023D
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AR_jAvKI-kKQ for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 16:16:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5FE00404F7
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 16:16:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1683613FA;
 Fri, 11 Jun 2021 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623428163;
 bh=auQ7lw/e0XSmoS6xpReg018/FKMQ8EwKCFSeQiuUWoQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KTVLvfC5wHyuL8MhVMl+UVXyQrMMGTJzwnIWwk0kzi5gWS0ixsrrH78uNyUY6VmMy
 spu7nNvbGYuS41I3OZgArRUr6y/JOs3qh4XZJvuKC70/hhN71Nt/EzT74N3rlMrNRs
 UNVHT0t+TVPwT/YSmb5hYf6qf0/fg6W3D2WsqkRSITO268pLD/J93FWXE/woaDS4j2
 q5DAvA3dVkkUotTUAkOMFOFubiBUMnEZ0/4F0gQIWi3x+uZsFQBw47vJgqFhEZw9ib
 W1Q1ouwLLeWeZmHERHNH778q5RPHr9+FWucFdm0Fwr+Hs8pVEtOFldNcYOZD9mOKHG
 DZWIOJB+kkpoQ==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org, Nicolin Chen <nicoleotsuka@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Jordan Crouse <jordan@cosmicpenguin.net>,
 Robin Murphy <robin.murphy@arm.com>, Krishna Reddy <vdumpa@nvidia.com>,
 linux-kernel@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iommu/arm-smmu: Fix arm_smmu_device refcount leak when
 arm_smmu_rpm_get fails
Date: Fri, 11 Jun 2021 17:15:44 +0100
Message-Id: <162340794186.3698890.4788653563160979192.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623293672-17954-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1623293672-17954-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, Xin Tan <tanxin.ctf@gmail.com>,
 yuanxzhang@fudan.edu.cn, kernel-team@android.com,
 Will Deacon <will@kernel.org>
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

On Thu, 10 Jun 2021 10:54:29 +0800, Xiyu Yang wrote:
> arm_smmu_rpm_get() invokes pm_runtime_get_sync(), which increases the
> refcount of the "smmu" even though the return value is less than 0.
> 
> The reference counting issue happens in some error handling paths of
> arm_smmu_rpm_get() in its caller functions. When arm_smmu_rpm_get()
> fails, the caller functions forget to decrease the refcount of "smmu"
> increased by arm_smmu_rpm_get(), causing a refcount leak.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Fix arm_smmu_device refcount leak when arm_smmu_rpm_get fails
      https://git.kernel.org/will/c/1adf30f198c2

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
