Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC494C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7CC7640289;
	Tue, 14 Dec 2021 15:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W0XuH3xIjXNb; Tue, 14 Dec 2021 15:18:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 657924022F;
	Tue, 14 Dec 2021 15:18:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41AF8C002F;
	Tue, 14 Dec 2021 15:18:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94875C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7526A60BC9
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DTbVnw84ueiC for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:18:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A8CF160BC6
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2B6BDB81A73;
 Tue, 14 Dec 2021 15:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16C6C3460C;
 Tue, 14 Dec 2021 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639495114;
 bh=qLyDBf/yZu2sUd5XQDi3WQtlq6e8hakIqUYW8hv6gEQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m6Q8s2AclEXu0keGIgST108zGqrQoEZvIpEZoaTWn/FMkJjGKQrwNlaYBDo+8bO5W
 7eIf9xDgGwIBY3lIRoRKrzDKBJ34dK0u+rXlbuJcW2IFSn9ncc7feU1cIFXjN3ab87
 i76ZTfDR9FSHut40Zvq8fT8r9BgfSLQYqPfwRcxeoUIv8F0ad1PmvLCx52c2Cub/+e
 i6pILAQ3tGmua0HQrZOr3TOdm08dOjKv4+7Szyv8dq9uT3N9hdws28yMfH/L7AfP0L
 idy2L2NPaAek3b66fY7XMywUhxXmfKo7BskzHe1qwcvvomra31LIh+TXD1ITclaHFe
 yMiXgFpx6BYXw==
From: Will Deacon <will@kernel.org>
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops
Date: Tue, 14 Dec 2021 15:18:14 +0000
Message-Id: <163949306261.2865560.10724988553513582084.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
References: <20211204223301.100649-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
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

On Sat, 4 Dec 2021 23:33:01 +0100, Rikard Falkeborn wrote:
> The only usage of arm_smmu_mmu_notifier_ops is to assign its address to
> the ops field in the mmu_notifier struct, which is a pointer to const
> struct mmu_notifier_ops. Make it const to allow the compiler to put it
> in read-only memory.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: Constify arm_smmu_mmu_notifier_ops
      https://git.kernel.org/will/c/17d9a4b43b28

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
