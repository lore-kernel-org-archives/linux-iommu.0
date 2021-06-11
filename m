Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC33C48BE0
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 10:45:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862E2613F3
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 10:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862E2613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C0DC4065E;
	Fri, 11 Jun 2021 10:45:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7sFjCGplXwrN; Fri, 11 Jun 2021 10:45:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 107C140655;
	Fri, 11 Jun 2021 10:45:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E309BC000D;
	Fri, 11 Jun 2021 10:45:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DBEDC000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:45:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C17D60698
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qk9j1jdI7CZe for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 10:45:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0DB160636
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 10:45:29 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF60C613F1;
 Fri, 11 Jun 2021 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623408329;
 bh=H7N82STuZf67I/B25zQwHnR1wGeHBVcwA153V8xgMsI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WBZx9meYLkVr5ydc7IymbBE1oQiQ1bbdKUe3MI5cqxiyStn7E8h3540mPdeFhQkWM
 AhitpJZgHzGLqcW6alsccgNdUuLlKD2G9xyUu13i9BSwVCAtH3eu0s/FsX5iCfUbT1
 rnmwpY/lYAajYmvDqpnZf9+gYo+kHeebSoN6RdYch7hQYHe700m95FmwO0HnN+yWWb
 IOZ1p/8/glLiUmlga1DXEVLyS3s64ns/3mTh2uwmYBte0T7WtphOj/x+uo4Q5HPdEI
 GA1BVDFmQzC/LCLmCGfZGPgu2Snd3vCaJ2HQ2ic1h44pLduLScxNFpcbBVm3+NjTkN
 6P+smXdy03jRw==
Date: Fri, 11 Jun 2021 11:45:24 +0100
From: Will Deacon <will@kernel.org>
To: Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
Message-ID: <20210611104524.GD15274@willie-the-truck>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
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

On Thu, Jun 10, 2021 at 09:46:53AM +0530, Ashish Mhetre wrote:
> Domain is getting created more than once during asynchronous multiple
> display heads(devices) probe. All the display heads share same SID and
> are expected to be in same domain. As iommu_alloc_default_domain() call
> is not protected, the group->default_domain and group->domain are ending
> up with different domains and leading to subsequent IOMMU faults.
> Fix this by protecting iommu_alloc_default_domain() call with group->mutex.

Can you provide some more information about exactly what the h/w
configuration is, and the callstack which exhibits the race, please?

> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 808ab70..2700500 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
>  	 * support default domains, so the return value is not yet
>  	 * checked.
>  	 */
> +	mutex_lock(&group->mutex);
>  	iommu_alloc_default_domain(group, dev);
> +	mutex_unlock(&group->mutex);

It feels wrong to serialise this for everybody just to cater for systems
with aliasing SIDs between devices.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
