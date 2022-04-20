Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FA8C433EF
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 12:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BC9183FC5;
	Wed, 20 Apr 2022 12:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ey_2w43Fpqk1; Wed, 20 Apr 2022 12:31:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3F80483300;
	Wed, 20 Apr 2022 12:31:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1260EC0033;
	Wed, 20 Apr 2022 12:31:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5326C002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 12:31:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B334D404DD
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 12:31:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UQC4PvWqlw_c for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 12:31:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEE1E401AF
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 12:31:29 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A9636619A0;
 Wed, 20 Apr 2022 12:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34703C385A1;
 Wed, 20 Apr 2022 12:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650457888;
 bh=xFBxXROoKf7u+JAvuiZg1qFNSkoOxNBQ8DLIUz0UXt0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VvD6eMwnKgud8prkIqkDyIzKkAwnMUG4UDyyfYe5GozZoG+JQD9ZC+MWEawYLhELH
 0hs82Censkr6ZKriGuk5xCI8kZvqNjS2ShtpnewUZGs/rHnoy7JER51sXpcFOHyHJd
 4w+zU+Ph3yxGaGChG7V0qCp4ZV33CvLWCyxvRqHGJgCMa3G6ckchns1V8GDedi7lls
 x9z5xtoClxAUKqZt9X+vrgmAIL0TCf+Td8S1Xd/FyCAytoUxrZ4tVXTsZaH6oZw9SI
 L7UBS0eW7oRNR9gmS8JUdYIodtOY26V6MAWwBDUsh1SnJ6sjmEgj/wBJ4T44IezRCD
 6O7NfTrnHhCGg==
From: Will Deacon <will@kernel.org>
To: joro@8bytes.org, jgg@ziepe.ca, robin.murphy@arm.com,
 Nicolin Chen <nicolinc@nvidia.com>, jean-philippe@linaro.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix size calculation in
 arm_smmu_mm_invalidate_range()
Date: Wed, 20 Apr 2022 13:31:21 +0100
Message-Id: <165044753398.180787.4069543281631212706.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220419210158.21320-1-nicolinc@nvidia.com>
References: <20220419210158.21320-1-nicolinc@nvidia.com>
MIME-Version: 1.0
Cc: fenghua.yu@intel.com, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 iommu@lists.linux-foundation.org, rikard.falkeborn@gmail.com,
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

On Tue, 19 Apr 2022 14:01:58 -0700, Nicolin Chen wrote:
> The arm_smmu_mm_invalidate_range function is designed to be called
> by mm core for Shared Virtual Addressing purpose between IOMMU and
> CPU MMU. However, the ways of two subsystems defining their "end"
> addresses are slightly different. IOMMU defines its "end" address
> using the last address of an address range, while mm core defines
> that using the following address of an address range:
> 
> [...]

Applied to will (for-joerg/arm-smmu/fixes), thanks!

[1/1] iommu/arm-smmu-v3: Fix size calculation in arm_smmu_mm_invalidate_range()
      https://git.kernel.org/will/c/95d4782c34a6

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
