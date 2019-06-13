Return-Path: <SRS0=dZmg=UM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62097C31E49
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:38:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452A52175B
	for <iommu@archiver.kernel.org>; Thu, 13 Jun 2019 16:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452A52175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2D1DDF79;
	Thu, 13 Jun 2019 16:38:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C6515F78
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:38:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 70421775
	for <iommu@lists.linux-foundation.org>;
	Thu, 13 Jun 2019 16:38:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE4B367;
	Thu, 13 Jun 2019 09:38:41 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
	[10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD1933F694;
	Thu, 13 Jun 2019 09:38:38 -0700 (PDT)
Date: Thu, 13 Jun 2019 17:38:36 +0100
From: Will Deacon <will.deacon@arm.com>
To: Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 07/10] iommu/io-pgtable-arm: convert to SPDX license tags
Message-ID: <20190613163836.GF18966@fuggles.cambridge.arm.com>
References: <20190613162703.986-1-tiny.windzz@gmail.com>
	<20190613162703.986-7-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190613162703.986-7-tiny.windzz@gmail.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Cc: linux-samsung-soc@vger.kernel.org, heiko@sntech.de,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

On Thu, Jun 13, 2019 at 12:27:00PM -0400, Yangtao Li wrote:
> Updates license to use SPDX-License-Identifier.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
