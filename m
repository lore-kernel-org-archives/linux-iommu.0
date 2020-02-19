Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E707C3404D
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 10:56:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB26F2464E
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 10:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB26F2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B922B85E43;
	Wed, 19 Feb 2020 10:56:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6UVJgzSIAQge; Wed, 19 Feb 2020 10:56:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4532085C63;
	Wed, 19 Feb 2020 10:56:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2AECBC1D80;
	Wed, 19 Feb 2020 10:56:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32953C013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 10:56:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2464E87937
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 10:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5pqK2jmd-t16 for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 10:56:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6A95286A2E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 10:56:37 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 9D7A536A; Wed, 19 Feb 2020 11:56:35 +0100 (CET)
Date: Wed, 19 Feb 2020 11:56:34 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/qcom: Fix bogus detach logic
Message-ID: <20200219105634.GF1961@8bytes.org>
References: <be92829c6e5467634b109add002351e6cf9e18d2.1582049382.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <be92829c6e5467634b109add002351e6cf9e18d2.1582049382.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: stephan@gerhold.net, linux-arm-msm@vger.kernel.org,
 Naresh Kamboju <naresh.kamboju@linaro.org>, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, Brian Masney <masneyb@onstation.org>
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

On Tue, Feb 18, 2020 at 06:12:41PM +0000, Robin Murphy wrote:
> Currently, the implementation of qcom_iommu_domain_free() is guaranteed
> to do one of two things: WARN() and leak everything, or dereference NULL
> and crash. That alone is terrible, but in fact the whole idea of trying
> to track the liveness of a domain via the qcom_domain->iommu pointer as
> a sanity check is full of fundamentally flawed assumptions. Make things
> robust and actually functional by not trying to be quite so clever.
> 
> Reported-by: Brian Masney <masneyb@onstation.org>
> Tested-by: Brian Masney <masneyb@onstation.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/qcom_iommu.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
