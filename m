Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033FEC31E45
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 19:35:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E132147A
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 19:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E132147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9584F158E;
	Thu, 13 Jun 2019 19:35:13 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CFBE7139A
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 19:35:11 +0000 (UTC)
X-Greylist: delayed 00:25:21 by SQLgrey-1.7.6
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9616676D
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 19:35:10 +0000 (UTC)
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32]
	helo=diego.localnet) by gloria.sntech.de with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
	(envelope-from <heiko@sntech.de>)
	id 1hbV6T-0000Sd-2L; Thu, 13 Jun 2019 21:09:41 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 09/10] iommu/rockchip: convert to SPDX license tags
Date: Thu, 13 Jun 2019 21:09:39 +0200
Message-ID: <1921640.M456AIj05J@diego>
In-Reply-To: <20190613162703.986-9-tiny.windzz@gmail.com>
References: <20190613162703.986-1-tiny.windzz@gmail.com>
	<20190613162703.986-9-tiny.windzz@gmail.com>
MIME-Version: 1.0
Cc: linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org, will.deacon@arm.com,
	agross@kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
	david.brown@linaro.org, kgene@kernel.org,
	thierry.reding@gmail.com, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org,
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Am Donnerstag, 13. Juni 2019, 18:27:02 CEST schrieb Yangtao Li:
> Updates license to use SPDX-License-Identifier.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Heiko Stuebner <heiko@sntech.de>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
