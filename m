Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A494C433FE
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0BE1540568;
	Tue, 14 Dec 2021 15:18:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5RyWaE2osk10; Tue, 14 Dec 2021 15:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E32240555;
	Tue, 14 Dec 2021 15:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79679C002F;
	Tue, 14 Dec 2021 15:18:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3C66C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B319240290
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A3fPIPz09wYe for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:18:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C61004022F
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:18:40 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 236DDB81A76;
 Tue, 14 Dec 2021 15:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9D8C3460A;
 Tue, 14 Dec 2021 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639495117;
 bh=xA4qErAYFfQZoMVAgqmgJanxkAG/Pa06aExW8DKib+g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YdAF4vm+BGbwsTBNyD1SZIwyVqUjVeVO51lj2mafBgIGLDN5Gt+cqE5gxxaI+AZ0A
 JKGOfQsR73R+3MzpwP0IKcA0ztSfXU03oUS+66zUeKSU4A/BFTjaHKXxH5BvHO/xBG
 m/Rh6zc67ghxl5e+1lm+JV5HTNA11O/ed+dONdV9EnEvcKK2AC9apEUf9g9BP8/L7E
 cfBBU9Jm0quW8ILPZaaCJVh2JJt4Kaa0r9PHUpSydBMvcUmW47hN+Q2S72HKZJ/KKx
 JHQplMxt/v/U7mGqO/W6eXnC5vred/UOIfkvQHBa/CDhrsacV05TM1GdkwcaXx4fmu
 g/V5wU0WWTgEA==
From: Will Deacon <will@kernel.org>
To: Rob Clark <robdclark@gmail.com>,
	iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Fix TTBR0 read
Date: Tue, 14 Dec 2021 15:18:15 +0000
Message-Id: <163949295159.2865133.14830318061014713865.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211108171724.470973-1-robdclark@gmail.com>
References: <20211108171724.470973-1-robdclark@gmail.com>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, freedreno@lists.freedesktop.org,
 Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 Robin Murphy <robin.murphy@arm.com>, dri-devel@lists.freedesktop.org,
 open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>,
 linux-arm-msm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>,
 kernel-team@android.com,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>
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

On Mon, 8 Nov 2021 09:17:23 -0800, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> It is a 64b register, lets not lose the upper bits.
> 
> 

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu/arm-smmu-qcom: Fix TTBR0 read
      https://git.kernel.org/will/c/c31112fbd407

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
