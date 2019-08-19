Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5517FC3A5A0
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 15:56:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C6822CED
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 15:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0ru+uzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C6822CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D654AE91;
	Mon, 19 Aug 2019 15:56:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 554D7E5B
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 15:56:41 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AAB7167F
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 15:56:39 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C5ED720651;
	Mon, 19 Aug 2019 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566230199;
	bh=NW13UGn4atnjhBa36FHx8LmvP4KUCqy2dMmq5Me4ML4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0ru+uzt089t5r6zCdDKQ3At2xD3MZhQwipAlmWfg5xbawFuVsvLO1kJSeipBK1zZ
	dM10SobE5hnX4sGfo+KetJRHOetiqltmyxP/2BfN8blEsNI1T8J/ldHWDJ2E8hUWNe
	nCTkGEnkXDzXlBzUf659t1/4rM81yyt2kp31P5DE=
Date: Mon, 19 Aug 2019 16:56:34 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 00/17] Arm SMMU refactoring
Message-ID: <20190819155634.xflkhxexzks3y7oa@willie-the-truck>
References: <cover.1565892337.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1565892337.git.robin.murphy@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
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

On Thu, Aug 15, 2019 at 07:37:20PM +0100, Robin Murphy wrote:
> v1 for context: https://patchwork.kernel.org/cover/11087347/
> 
> Here's a quick v2 attempting to address all the minor comments; I've
> tweaked a whole bunch of names, added some verbosity in macros and
> comments for clarity, and rejigged arm_smmu_impl_init() for a bit more
> structure. The (new) patches #1 and #2 are up front as conceptual fixes,
> although they're not actually critical - it turns out to be more of an
> embarrassment than a real problem in practice.

Thanks, I'll pick this up and send to Joerg later this week.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
