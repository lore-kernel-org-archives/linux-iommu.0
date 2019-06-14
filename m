Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F15C31E44
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 07:13:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DBB2133D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 07:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s1QW40cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DBB2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6323DEFA;
	Fri, 14 Jun 2019 07:13:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 01F37EF7
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 07:12:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AB8F7E5
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 07:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=iTqU4HCutRR3uOJUYQ45ZU7506Sl5CfUv5xpSiuoAIU=;
	b=s1QW40cdUPPbUO6WyXX5MasT2
	zpUzI0yFs1dQWyfV9pw8s8UglBzqG+hjlADCXiVES4YrjrDEhXQvqU3LokO6gSsZwbjRHmb+6ZyE1
	FuDxJYef6OyM+Hxt2LP7pNdGVoMXpMHIdsuXRR2OX42DSoYiurBP9/ocQAMN4Eta7uIzpXrzg9fmp
	Y6r0Be3/EI5gOKvt4DARL3XPteJl0Va8ohPC+ryF0kMr7AlVaHJTI5rRsCiDRjvakeLyezkJsw8fG
	3bMGg1n2z31C8vbZYnB2aHllCUjOCFyLrkeM3GqhFS7vfUhCcWJNuI/OTr0WLGQyWdFBmmlWt2b+L
	5rQEFqwrg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
	Linux)) id 1hbgOE-0000yO-1z; Fri, 14 Jun 2019 07:12:46 +0000
Date: Fri, 14 Jun 2019 00:12:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 01/10] iommu/exynos: convert to SPDX license tags
Message-ID: <20190614071245.GA2950@infradead.org>
References: <20190613162703.986-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613162703.986-1-tiny.windzz@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-samsung-soc@vger.kernel.org, heiko@sntech.de,
	linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, will.deacon@arm.com,
	agross@kernel.org, krzk@kernel.org, jonathanh@nvidia.com,
	david.brown@linaro.org, kgene@kernel.org,
	thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org
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

Thomas Gleixner is doing automated SPDX conversion that directly
got to Linux at the moment.  I'd avoid doing more manual ones for
now as it will just create conflicts.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
