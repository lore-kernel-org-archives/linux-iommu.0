Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8581C433E5
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 09:03:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81B042080D
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 09:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2MQ1krqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81B042080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 546DA87E09;
	Mon, 20 Jul 2020 09:03:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BOQYcuSKJyMq; Mon, 20 Jul 2020 09:03:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C4B4187D9D;
	Mon, 20 Jul 2020 09:03:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6177C0894;
	Mon, 20 Jul 2020 09:03:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B1B5C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 09:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 619A28560E
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 09:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmu6piAZZXYD for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 09:03:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id EEF6C855F6
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 09:03:43 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AC263208E4;
 Mon, 20 Jul 2020 09:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595235823;
 bh=KcQt2EOigF1ebrTQ7hvGmXwS8Ro1HrFCMeZYHFhnS7o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2MQ1krqOi3hi5kU835rdrlryHLYqM1P79nmjhvl/68c5WzpyyCv+6MttAMk7f8ulC
 YeFKtEdgbAcBW1900hLCi6R7J7eTvWGEVT8fSsekUCI9pgNtzklh3LRlfN5Yzz1rlp
 QzmMdqjcenT2oFxV7+Mb/zf/kuE5sm2d2fy1q2pQ=
Date: Mon, 20 Jul 2020 10:03:38 +0100
From: Will Deacon <will@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Setup identity domain for boot
 mappings
Message-ID: <20200720090338.GB11189@willie-the-truck>
References: <20200717001619.325317-1-bjorn.andersson@linaro.org>
 <20200717001619.325317-6-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200717001619.325317-6-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Marek <jonathan@marek.ca>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Thierry Reding <thierry.reding@gmail.com>,
 John Stultz <john.stultz@linaro.org>, Robin Murphy <robin.murphy@arm.com>,
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

On Thu, Jul 16, 2020 at 05:16:19PM -0700, Bjorn Andersson wrote:
> With many Qualcomm platforms not having functional S2CR BYPASS a
> temporary IOMMU domain, without translation, needs to be allocated in
> order to allow these memory transactions.
> 
> Unfortunately the boot loader uses the first few context banks, so
> rather than overwriting a active bank the last context bank is used and
> streams are diverted here during initialization.
> 
> This also performs the readback of SMR registers for the Qualcomm
> platform, to trigger the mechanism.
> 
> This is based on prior work by Thierry Reding and Laurentiu Tudor.
> 
> Tested-by: John Stultz <john.stultz@linaro.org>
> Tested-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Rebased to avoid conflict
> - Picked up tested-by
> 
>  drivers/iommu/arm-smmu-qcom.c | 11 +++++
>  drivers/iommu/arm-smmu.c      | 79 +++++++++++++++++++++++++++++++++--

Perhaps the CB allocator callback can help to reduce the changes to the core
driver here. What do you think?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
