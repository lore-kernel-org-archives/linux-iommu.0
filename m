Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D4EC4332F
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 16:07:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 60A974052E;
	Fri,  6 May 2022 16:07:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8F3PDyIMbgLV; Fri,  6 May 2022 16:07:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4BF1F40531;
	Fri,  6 May 2022 16:07:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 29533C0039;
	Fri,  6 May 2022 16:07:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B66FAC002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5A2160C27
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VjbVuTJKfCfP for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:07:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C8C7860D57
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:26 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 26DC3B8370C;
 Fri,  6 May 2022 16:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9ADC385AC;
 Fri,  6 May 2022 16:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651853243;
 bh=0P7/WGJCYHt435lwImIJcvUvwlWu+QHXkyE1lQQbags=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rKyJZZCmEzRQ4LARqny8I4XWojwmowD0nj/y5A2VC5LR/gplATsWWXhGKYnGBSRft
 kKfJRL3x24JUfZ+g142St1pIMb2msv8PFvo6B77rtWgtA1LHLynlOHPH0AlcY7cWfV
 IxVihBnan1xn6/8+nixYw5ENw4+0zAmY2QPfcHF8mzPq47SJ6OdedwZC5wcNL+1Kml
 uTb1ZEx/F1hYLeziEjfGxVMxJgDDkVrHrjrunQaxjFM+mV7sN6KV5Rx3oXGqJR7mkc
 s4SNDhvOi2ZhluJq4JLvkWL1I0Pi3qwyIt4ot8yWl1K9zuhH8xhODFTAyWUSJN306U
 ZrAjP8NTChY+A==
From: Will Deacon <will@kernel.org>
To: Yang Yingliang <yangyingliang@huawei.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu: fix possible null-ptr-deref in
 arm_smmu_device_probe()
Date: Fri,  6 May 2022 17:07:05 +0100
Message-Id: <165185066572.2780646.1953515178264833558.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220425114136.2649310-1-yangyingliang@huawei.com>
References: <20220425114136.2649310-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Cc: catalin.marinas@arm.com, kernel-team@android.com, robin.murphy@arm.com,
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

On Mon, 25 Apr 2022 19:41:36 +0800, Yang Yingliang wrote:
> It will cause null-ptr-deref when using 'res', if platform_get_resource()
> returns NULL, so move using 'res' after devm_ioremap_resource() that
> will check it to avoid null-ptr-deref.
> And use devm_platform_get_and_ioremap_resource() to simplify code.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu: fix possible null-ptr-deref in arm_smmu_device_probe()
      https://git.kernel.org/will/c/d9ed8af1dee3

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
