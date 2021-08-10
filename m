Return-Path: <SRS0=o4oj=NB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3EFC4338F
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 20:26:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2484061008
	for <iommu@archiver.kernel.org>; Tue, 10 Aug 2021 20:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2484061008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E5C996084F;
	Tue, 10 Aug 2021 20:26:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4ArGRWM3Zu3; Tue, 10 Aug 2021 20:26:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C18D960761;
	Tue, 10 Aug 2021 20:26:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD664C001A;
	Tue, 10 Aug 2021 20:26:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6CB5C000E
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:26:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C638360875
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pXbkO-oxW_pw for <iommu@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 20:26:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 252CC60888
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 20:26:06 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1C976101D;
 Tue, 10 Aug 2021 20:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628627165;
 bh=sZUZNisiNzjIpVajNcqlYYjOt5HpgpxjVbVXTN3qHlc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ElntkXnT18F1lB/MSxCigZ77LaGKeLlezXPLFWKIW5F4LuiDtJwgkSuUmHlgrmXos
 d5l9ZMqERKREsVdzNQNftjDbp2JnXNyiBmLwWMINgukaytFd24mcouuonNwbpp88wQ
 b9zG+wtSmUkm6vn23fniLH8JdcEwgrSQFQRUMKOPuC3xffccxR9ODS+Dohmcd/bX4T
 U2Mgqv+qJQEWSVUJAh0KxecKDtleD36YfXOwoaucAWfuilV1K5xAcWnr1LgbtbHdLb
 b06MFk4FCdmL42HpHA+mOLw7yWKIX+uNvSbc+J4zmko5lBfCdGG+coajJKY6Hf6JZh
 bPNxyQeAkwlPA==
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCHv2] iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to
 system pm callbacks
Date: Tue, 10 Aug 2021 21:25:55 +0100
Message-Id: <162860133458.2066705.4766353866731374871.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210810064808.32486-1-saiprakash.ranjan@codeaurora.org>
References: <20210810064808.32486-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Cc: Taniya Das <tdas@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel-team@android.com,
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

On Tue, 10 Aug 2021 12:18:08 +0530, Sai Prakash Ranjan wrote:
> Some clocks for SMMU can have parent as XO such as gpu_cc_hub_cx_int_clk
> of GPU SMMU in QTI SC7280 SoC and in order to enter deep sleep states in
> such cases, we would need to drop the XO clock vote in unprepare call and
> this unprepare callback for XO is in RPMh (Resource Power Manager-Hardened)
> clock driver which controls RPMh managed clock resources for new QTI SoCs.
> 
> Given we cannot have a sleeping calls such as clk_bulk_prepare() and
> clk_bulk_unprepare() in arm-smmu runtime pm callbacks since the iommu
> operations like map and unmap can be in atomic context and are in fast
> path, add this prepare and unprepare call to drop the XO vote only for
> system pm callbacks since it is not a fast path and we expect the system
> to enter deep sleep states with system pm as opposed to runtime pm.
> 
> [...]

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: Add clk_bulk_{prepare/unprepare} to system pm callbacks
      https://git.kernel.org/will/c/afefe67e0893

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
