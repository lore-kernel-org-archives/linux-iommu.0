Return-Path: <SRS0=+KRR=C3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F2C43465
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 09:07:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD2421D42
	for <iommu@archiver.kernel.org>; Fri, 18 Sep 2020 09:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD2421D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 22B1F877CF;
	Fri, 18 Sep 2020 09:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wKmagfS7kEuk; Fri, 18 Sep 2020 09:07:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 021DE876D6;
	Fri, 18 Sep 2020 09:07:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D52ADC0888;
	Fri, 18 Sep 2020 09:07:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B182C0051
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 60AC587668
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8YCptL6hMBOx for <iommu@lists.linux-foundation.org>;
 Fri, 18 Sep 2020 09:07:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD46387662
 for <iommu@lists.linux-foundation.org>; Fri, 18 Sep 2020 09:07:32 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 99E44396; Fri, 18 Sep 2020 11:07:30 +0200 (CEST)
Date: Fri, 18 Sep 2020 11:07:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [RESEND][PATCH 0/2] iommu/tegra-smmu: Fix TLB line for Tegra210
Message-ID: <20200918090728.GL31590@8bytes.org>
References: <20200917113155.13438-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200917113155.13438-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: krzk@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, jonathanh@nvidia.com
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

On Thu, Sep 17, 2020 at 04:31:53AM -0700, Nicolin Chen wrote:
> These two patches fix ACTIVE_TLB_LINES field setting in tegra-smmu
> driver for Tegra210 platforms.
> 
> This resend in series groups two previous seperate changes that're
> corelated, being pointed out by Thierry. Also adding his Acked-by.
> 
> Nicolin Chen (2):
>   iommu/tegra-smmu: Fix tlb_mask
>   memory: tegra: Correct num_tlb_lines for tegra210
> 
>  drivers/iommu/tegra-smmu.c      | 2 +-
>  drivers/memory/tegra/tegra210.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
