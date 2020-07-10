Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113A1C433E5
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 14:37:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC022206E2
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 14:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0e88udVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC022206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9D7FD89C1E;
	Fri, 10 Jul 2020 14:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fer5a6ixDwNE; Fri, 10 Jul 2020 14:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 57E2A89BD5;
	Fri, 10 Jul 2020 14:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FD93C077B;
	Fri, 10 Jul 2020 14:37:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06BCEC016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 14:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id E7C45204C4
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 14:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ByiomwpzbCQx for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 14:37:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 5E15B203B8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 14:37:56 +0000 (UTC)
Received: from willie-the-truck (unknown [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 990B4206E2;
 Fri, 10 Jul 2020 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1594391876;
 bh=8g8m8VJ9l5CJBIHP80qLd7TYwA04RcxWEXDKAmSDJFo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0e88udVe84K619h0RTRjVu0LwV3LPmZL1UbJ1n+j+/htQmPtaMjGUJNWydl/Q76/5
 2MFf+dTdXQ3YPR3lvtdODNoxv0f/PMX3K3q4CtBJhqfn/hzAC3eno8eSVvZgP72lKd
 oHDAHX9pxFCVDbNJPyeM95zUrrxFahH8+LpRgrNQ=
Date: Fri, 10 Jul 2020 15:37:40 +0100
From: Will Deacon <will@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Message-ID: <20200710143740.GA31036@willie-the-truck>
References: <20200703162548.19953-1-will@kernel.org>
 <20200710125831.GI27672@8bytes.org>
 <20200710130526.GA30578@willie-the-truck>
 <20200710141532.GK27672@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200710141532.GK27672@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Fri, Jul 10, 2020 at 04:15:32PM +0200, Joerg Roedel wrote:
> On Fri, Jul 10, 2020 at 02:05:27PM +0100, Will Deacon wrote:
> > Ah, I'd already got this queued for 5.9:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates
> > 
> > and I've queued a small number of patches on top of it now.
> > 
> > Are you planning to send it for 5.8? If so, I suspect I'll have to rebase.
> 
> No problem, nothing got pushed yet. I removed it from my branch and wait
> for your pull-request.

Great, thanks Joerg.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
