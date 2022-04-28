Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBE4C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 02:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A6D940882;
	Thu, 28 Apr 2022 02:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kSfbk0Bkw6sh; Thu, 28 Apr 2022 02:02:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A6599404F9;
	Thu, 28 Apr 2022 02:02:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25085C0082;
	Thu, 28 Apr 2022 02:02:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 880CFC0032
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6FA9582438
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=sholland.org header.b="FzcqGCmK";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="LZzqWHfY"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bTLMil3PIN4B for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 01:10:47 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 844E882468
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 01:10:47 +0000 (UTC)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 5534B5C010B;
 Wed, 27 Apr 2022 21:04:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Wed, 27 Apr 2022 21:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1651107860; x=1651194260; bh=7k
 KZKeaIzmswO5xe/sMVvmN10M9qpUiXUxMfopwBhII=; b=FzcqGCmKSCcG1573ws
 wjrHZ9MgBOtt7+W3nlCZwNSbIvNB9iJgBz0Xw71GL//FMsajq+J5lJPUD/Iynl+h
 hW0vgX+42ZsPjIG/gWQnuTc2M3rWXN3GwxFfBSwq56Jft1QpxeeEhtsboM7s1UAU
 X/WfpXOQEDvZn3tnmJozIpJTiDmvRl3aq4br1AlXMrwX6H9geeWBLqQN7RDmXZmr
 aTTGzNHKb7lV+IGskzD4kNYnUJDmZ/M0QlwpJyTJqK6dPj1RPvFYHHR1fGga0Lj6
 wITbOUkxxwmsGES05YpEHgPzTv4BjfS2O18AdEEuGtk0XcKKDsQ38O+WPos/Jlnx
 jKwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1651107860; x=1651194260; bh=7kKZKeaIzmswO5xe/sMVvmN10M9qpUiXUxM
 fopwBhII=; b=LZzqWHfYD2Efj2hch/HZzY2OvSwjH1J+3lKdQ08JNew6snKaNh+
 5V66l6Mxn1bsYtau1gcZu70zX5rtW3VvFxvUEqzW69uVJ+p3T/ecKd+0gdnRmhjf
 ARUWeWI0nu4DgjI87rvqrvtqTY7RZA0wc9u34PU1n3qF0dMjPkuHfQ2zakoUWxWM
 GeJgfJwfhHaCkVIVFgTJU+lcIV2JnMRduBXwvFJfEQWTXXtjRiz5eEChAtYx2wJ8
 WRQAG4xnnE/vtEDthrO0lnZdfswjl3xwy/yDp8IC5GbPTpITGb8eNkakwcfsSYED
 WzE3IPZXkCLefZN2mpBX326hUGLOARqj5FQ==
X-ME-Sender: <xms:FOhpYryLbjZs5NNFdW38MfOrDz3CuY_wPdQ5ITkz-YhY-M_c9bXd_Q>
 <xme:FOhpYjSD4p-r5lhDu8Wf45NH1YZCkMOaTV8u4YCgBSGdAE1BzscWsj2SSr-jKNGKv
 5pmSFUXdwbEbNld4A>
X-ME-Received: <xmr:FOhpYlXtophLVL2t1r6XI4wDoUOD2yIbE65kLIWuU20R2xfC9FtFUb1gKLZa45SlonQCmPj2uj9vzzdfJmWpz2natVK8as1fC3JcPM0CID6mdLmP-9mqt93S97Dv1uR0ZIULAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudeigdegfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
 lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
 frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
 feeitdevteenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:FOhpYljX2COH74lmwoWE0UqfU8ajmbY6N2JjMmqobNnE0GKKekSBaQ>
 <xmx:FOhpYtCEMCbftEQes56J1ZWFDyTbUA4srfwCxDaCBcTA-rD_dlgnxw>
 <xmx:FOhpYuIIoiqLX_lD8F0mdIJQjXz8sA_iYcdRU2k_dP97nqO9unVQVw>
 <xmx:FOhpYnQsPWyDjWUqZu2pBEbDnLXlxe2Cb7h5dC56uRH4ogO4gmhuzw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Apr 2022 21:04:19 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux-foundation.org
Subject: [PATCH 3/5] iommu/sun50i: Ensure bypass is disabled
Date: Wed, 27 Apr 2022 20:03:58 -0500
Message-Id: <20220428010401.11323-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428010401.11323-1-samuel@sholland.org>
References: <20220428010401.11323-1-samuel@sholland.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 28 Apr 2022 02:02:11 +0000
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 Samuel Holland <samuel@sholland.org>, linux-kernel@vger.kernel.org,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Rob Herring <robh+dt@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Maxime Ripard <mripard@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-riscv@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
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

The H6 variant of the hardware disables bypass by default. The D1
variant of the hardware enables bypass for all masters by default.

Since the driver expects bypass to be disabled, ensure that is the case.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/iommu/sun50i-iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index ec07b60016d3..b9e644b93637 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -374,6 +374,8 @@ static int sun50i_iommu_enable(struct sun50i_iommu *iommu)
 
 	spin_lock_irqsave(&iommu->iommu_lock, flags);
 
+	iommu_write(iommu, IOMMU_BYPASS_REG, 0);
+
 	iommu_write(iommu, IOMMU_TTB_REG, sun50i_domain->dt_dma);
 	iommu_write(iommu, IOMMU_TLB_PREFETCH_REG,
 		    IOMMU_TLB_PREFETCH_MASTER_ENABLE(0) |
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
