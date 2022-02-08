Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06269C433EF
	for <iommu@archiver.kernel.org>; Tue,  8 Feb 2022 16:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8D992400CB;
	Tue,  8 Feb 2022 16:22:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HNfJ-GMgWjBi; Tue,  8 Feb 2022 16:22:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 14010403B9;
	Tue,  8 Feb 2022 16:22:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DFC0DC001A;
	Tue,  8 Feb 2022 16:22:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DF37C000B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F14DB60EF5
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wAs_hXyZi34R for <iommu@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 16:22:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1E30606B0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Feb 2022 16:22:08 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0850B616D4;
 Tue,  8 Feb 2022 16:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3387DC340EC;
 Tue,  8 Feb 2022 16:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644337327;
 bh=sXbCfyUpCRgkdJeoXxIsdIqWpDpDr+h2fd3sTTQiBW4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GsZfWIC+pXBcJXMk1q3KUH8Cx12/BrNymYL16J79pzY/l8t0dHpJQL/WmXUSxeao5
 EgHCmZCmt/Yveslj2EZQb/widC6i9hc1RI50Jf2+Tj09CAJFsIZbUrwTWAOc2q9uKV
 bhug3/MFFJOS0bdREkpJTvY3aTtaP26U8NntYc4B+rK4e+qJJU/QC2RstCQx8BDqtM
 Vjj/LJ9qRWx949tzpqh0ZiDqEVPOsmkA4d3yw/xrk0MiVWah/ds56Zxgy9G2in5bri
 Os7SsQITtQ05pUQI+hIMvgDythuZ07dazEdGseH7fnYaOv7SEP5WvxwmzmeiAM8kbD
 sg6ZQPX4niNRw==
From: Will Deacon <will@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu: Add missing pm_runtime_disable() in
 qcom_iommu_device_probe
Date: Tue,  8 Feb 2022 16:21:53 +0000
Message-Id: <164433576813.932880.12030091721881106363.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220105101619.29108-1-linmq006@gmail.com>
References: <20220105101619.29108-1-linmq006@gmail.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On Wed, 5 Jan 2022 10:16:19 +0000, Miaoqian Lin wrote:
> If the probe fails, we should use pm_runtime_disable() to balance
> pm_runtime_enable().
> Add missing pm_runtime_disable() for error handling.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Add missing pm_runtime_disable() in qcom_iommu_device_probe
      https://git.kernel.org/will/c/93665e0275a2

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
