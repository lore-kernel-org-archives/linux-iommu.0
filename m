Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09607C47082
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 11:43:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DCF6135A
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 11:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DCF6135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 96254402A0;
	Tue,  8 Jun 2021 11:43:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VGghfEy6N7yr; Tue,  8 Jun 2021 11:42:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 793B1402C8;
	Tue,  8 Jun 2021 11:42:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55DB0C000B;
	Tue,  8 Jun 2021 11:42:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F17C9C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D0B85402A0
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYH-2fAwfQXJ for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 11:42:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0161F402C8
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 11:42:52 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C325A61360;
 Tue,  8 Jun 2021 11:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623152572;
 bh=fGah1+p/pv2388oRBq6wxQPYcwlfBCFXSQHmKKgtJbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=A2h0RGsquAxhM5p1pqkyitd0GSbNPqdcCFY2sdVRH0rsrJ1U2bzL9bPEwwHXWfKe4
 x6wNauyM8MLjB4+kz9RKO2hZVgDUv5+J3HMuVyOUIZHE/gD7e6pdxZWA+Idm6cnUAk
 Nm+Aui2H3fvK1TK2frluOqPNPXdcAo1PxkTRSrG7eOPV82O2iQXm9vT2T3xBaohqfN
 yiwjlMtlx3a6q7OvjSmbF3oizJb1Urdiwx4bmqu4mR0fqKrW1/OTgrO7wlN/Ed1nld
 F3tYOmZdFFAzHRX1i/b9Wp5KnQw8rK0IDLEu4X9T2MNZ31dRQBRJdREWE8tsXx5+dr
 n7Kmb1hb8U9Ag==
From: Will Deacon <will@kernel.org>
To: Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH V2] iommu: arm-smmu-qcom: Add sm6125 compatible
Date: Tue,  8 Jun 2021 12:42:35 +0100
Message-Id: <162314671954.3707273.3414160134891891543.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210523212535.740979-1-martin.botka@somainline.org>
References: <20210523212535.740979-1-martin.botka@somainline.org>
MIME-Version: 1.0
Cc: Rob Clark <robdclark@chromium.org>, linux-kernel@vger.kernel.org,
 Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
 konrad.dybcio@somainline.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht,
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

On Sun, 23 May 2021 23:25:33 +0200, Martin Botka wrote:
> Add compatible for SM6125 SoC

Applied to will (for-joerg/arm-smmu/updates), thanks!

[1/1] iommu: arm-smmu-qcom: Add sm6125 compatible
      https://git.kernel.org/will/c/6321484d1c24

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
