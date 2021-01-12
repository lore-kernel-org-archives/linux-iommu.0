Return-Path: <SRS0=VgK/=GP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8877AC433DB
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 19:03:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189B123123
	for <iommu@archiver.kernel.org>; Tue, 12 Jan 2021 19:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189B123123
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 96ADF86027;
	Tue, 12 Jan 2021 19:03:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fKdM4moSWkYU; Tue, 12 Jan 2021 19:03:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2C25F848FA;
	Tue, 12 Jan 2021 19:03:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1376FC08A1;
	Tue, 12 Jan 2021 19:03:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FDCAC013A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 19:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 26677203C4
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 19:03:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T1tsOSJOBE5V for <iommu@lists.linux-foundation.org>;
 Tue, 12 Jan 2021 19:03:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 06B521FE49
 for <iommu@lists.linux-foundation.org>; Tue, 12 Jan 2021 19:03:29 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B93E230F9;
 Tue, 12 Jan 2021 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610478208;
 bh=arJYye6Gv+8BuVsZc+5AV+LIkT34tlazeQkU3YPaluM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DJx7vokyB5+qhEnSmUd0eR+wmyyCD0UMA411LAhNUBO5eknScs5nLleFxQ9uCG9OZ
 gsZ8SkoRr1t7DrFPG4dy756LV/FwGIKOjPCKFwSmmUbjWWjnl8xLcONV/tvActX/nY
 6M9bJGW7vLRwM+tjCs4wYFWhd4/roFfBc1he8QPr+r3qrRYilSJqWBcqqFBY4Dhsqn
 L5h84UpX57SC6H+tNiFO0x8Lwwxi0CLS5n7++OaIbDQcfXYhB3ESsz3PTxewbFWMRa
 pcXjsB3pdqMQIq+LZezGBVWU0xfaavcgDVAPUakFmjiXUZlJIjfsKoY4/2NpYiz1vx
 bEesUrjXb23MQ==
From: Will Deacon <will@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2] iommu: arm-smmu-qcom: Add sdm630/msm8998 compatibles
 for qcom quirks
Date: Tue, 12 Jan 2021 19:03:20 +0000
Message-Id: <161046656595.1107648.16027501350781316856.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210109165622.149777-1-konrad.dybcio@somainline.org>
References: <20210109165622.149777-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Cc: John Stultz <john.stultz@linaro.org>, Will Deacon <will@kernel.org>,
 catalin.marinas@arm.com, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
 angelogioacchino.delregno@somainline.org, marijn.suijten@somainline.org,
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

On Sat, 9 Jan 2021 17:56:21 +0100, Konrad Dybcio wrote:
> SDM630 and MSM8998 are among the SoCs that use Qualcomm's implementation
> of SMMUv2 which has already proven to be problematic over the years. Add
> their compatibles to the lookup list to prevent the platforms from being
> shut down by the hypervisor at MMU probe.

Applied to arm64 (for-next/iommu/fixes), thanks!

[1/1] iommu: arm-smmu-qcom: Add sdm630/msm8998 compatibles for qcom quirks
      https://git.kernel.org/arm64/c/b812834b5329

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
