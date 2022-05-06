Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E0AC433EF
	for <iommu@archiver.kernel.org>; Fri,  6 May 2022 16:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 394ED4052D;
	Fri,  6 May 2022 16:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LIM1tPEJUh1d; Fri,  6 May 2022 16:07:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2343F40510;
	Fri,  6 May 2022 16:07:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F32E0C0039;
	Fri,  6 May 2022 16:07:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40B09C002D
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2000D40502
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D3w5HkClDKLY for <iommu@lists.linux-foundation.org>;
 Fri,  6 May 2022 16:07:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7601E40510
 for <iommu@lists.linux-foundation.org>; Fri,  6 May 2022 16:07:26 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B634C61EDF;
 Fri,  6 May 2022 16:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE0AC385BD;
 Fri,  6 May 2022 16:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651853245;
 bh=6X2hMLK9syCGnQ6i86SAh139iWBlukYJvCLaWxrJbQU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ridMCBYtJRjzkSwTQwWivatVkVagzfPJs9AJw64MuOZHRC2MkAFLMTg0mtjkOEI9W
 Gn08Kniaieg20voYvVhDxYYXck7gP4dke3d1EiGuSAWrGeB1lXhZfdS9R4Lm3WD9hO
 hi2W7CtP0QoiLvi+rxuTM/eBbuJAF2SQkDzKitZs1SDiwWRi/SQYqzHy1z+pv50arc
 v46rrqa5TaXsokEO+0XGRIb37M7Q7LlOm/7Qff8AX6gOENIwVmbgw35ynzOj+9aVEZ
 U0xhtv5sDZRHmaB6PRb2/Bc1FvDu6KTL2RfYbZAQjE6HGFuaumFohZhfOyl8d52W51
 71VqTtvx3yLiA==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Yang Yingliang <yangyingliang@huawei.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: check return value after calling
 platform_get_resource()
Date: Fri,  6 May 2022 17:07:06 +0100
Message-Id: <165185069794.2780907.13021484269981123590.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220425114525.2651143-1-yangyingliang@huawei.com>
References: <20220425114525.2651143-1-yangyingliang@huawei.com>
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

On Mon, 25 Apr 2022 19:45:25 +0800, Yang Yingliang wrote:
> It will cause null-ptr-deref if platform_get_resource() returns NULL,
> we need check the return value.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-v3: check return value after calling platform_get_resource()
      https://git.kernel.org/will/c/b131fa8c1d2a

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
