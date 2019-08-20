Return-Path: <SRS0=xQF/=WQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316FFC3A59E
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 11:41:47 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07FE1216F4
	for <iommu@archiver.kernel.org>; Tue, 20 Aug 2019 11:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xguat+up"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FE1216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CA3CDE22;
	Tue, 20 Aug 2019 11:41:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 84340DB6
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 11:41:45 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0D92787
	for <iommu@lists.linux-foundation.org>;
	Tue, 20 Aug 2019 11:41:42 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 15248214DA;
	Tue, 20 Aug 2019 11:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566301301;
	bh=9s7o6zZ76OS1IthcMa/ST21tcXOvg2qDs/Oqx1JNOEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xguat+upvO10HWYhgpcqZGs+2SPzVe4fjrxWG8f2YYXGAEwB4HClaGD+CciZD2T9u
	hgnwhRV43ZQ3wF5j2tKuWaPBBfrOxI905uzBU/P6eVM37NnJxeaS6cT4GuN3rxchQa
	ccZCy1TtnUBy87qaM55lP3VpbHSx1Y8OAyfgcdAw=
Date: Tue, 20 Aug 2019 12:41:38 +0100
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/arm-smmu: Fix build issues
Message-ID: <20190820114137.biqykhexvxuemwku@willie-the-truck>
References: <909636ed9dfc702a7cb4806903e3e698ce9b29a6.1566301129.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <909636ed9dfc702a7cb4806903e3e698ce9b29a6.1566301129.git.robin.murphy@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On Tue, Aug 20, 2019 at 12:38:49PM +0100, Robin Murphy wrote:
> In a hurry to get things ready for merging, we missed that one more
> include needs moving to arm-smmu.h along with the register accessors
> to prevent 32-bit builds breaking, and some missing static specifiers
> made Sparse sad.

I already fixed the static stuff locally (and I think you missed
'calxeda_impl'), so I'll reword this and just take the missing include.

Thanks,

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
