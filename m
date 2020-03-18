Return-Path: <SRS0=LxCT=5D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B74C4332E
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 20:50:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C09B20724
	for <iommu@archiver.kernel.org>; Wed, 18 Mar 2020 20:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoOE98Rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C09B20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id EAC96889F0;
	Wed, 18 Mar 2020 20:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CmKd2KmYIhpS; Wed, 18 Mar 2020 20:50:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6EF02889C0;
	Wed, 18 Mar 2020 20:50:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5612AC18DA;
	Wed, 18 Mar 2020 20:50:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9E9EEC013E
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 995AE20522
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:50:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1LKwupvP8Pe for <iommu@lists.linux-foundation.org>;
 Wed, 18 Mar 2020 20:50:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 3A26E20449
 for <iommu@lists.linux-foundation.org>; Wed, 18 Mar 2020 20:50:37 +0000 (UTC)
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 28DB320724;
 Wed, 18 Mar 2020 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584564637;
 bh=RpVUbrA6GLX6oxjlNmWztIMdXN6zWtDhebJqAHQf1+c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uoOE98RpOGBl59PNZvCx/Au9i4LC64YKNe98455ND4I6HWKEz9G1qqIvggonNnedD
 dLXXgSx4gMv0y4BeMSxxI8oJC1jrSz9UVH772yTbtO77WTZ8GQc0V8J6YsKI6Ej165
 xOes8VhTaE8+5snNexRj2elwnj8NYen9ITpA1eu4=
Date: Wed, 18 Mar 2020 20:50:30 +0000
From: Will Deacon <will@kernel.org>
To: Krishna Reddy <vdumpa@nvidia.com>
Subject: Re: [PATCH v4 0/6] Nvidia Arm SMMUv2 Implementation
Message-ID: <20200318205030.GA8094@willie-the-truck>
References: <1572480437-28449-1-git-send-email-vdumpa@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572480437-28449-1-git-send-email-vdumpa@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: snikam@nvidia.com, jtukkinen@nvidia.com, mperttunen@nvidia.com,
 linux-kernel@vger.kernel.org, praithatha@nvidia.com, talho@nvidia.com,
 iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, yhsu@nvidia.com, treding@nvidia.com,
 robin.murphy@arm.com, avanbrunt@nvidia.com,
 linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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

Hi Krishna,

On Wed, Oct 30, 2019 at 05:07:11PM -0700, Krishna Reddy wrote:
> Changes in v4:
> Rebased on top of https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/ for-joerg/arm-smmu/updates.
> Updated arm-smmu-nvidia.c to use the tlb_sync implementation hook.
> Dropped patch that updates arm_smmu_flush_ops for override as it is no longer necessary.
> 
> v3 - https://lkml.org/lkml/2019/10/18/1601
> v2 - https://lkml.org/lkml/2019/9/2/980
> v1 - https://lkml.org/lkml/2019/8/29/1588

Do you plan to repost this at some point?

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
