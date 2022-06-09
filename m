Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1495C43334
	for <iommu@archiver.kernel.org>; Thu,  9 Jun 2022 15:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66C7082882;
	Thu,  9 Jun 2022 15:47:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6bkHVLhyXWMy; Thu,  9 Jun 2022 15:47:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7029282883;
	Thu,  9 Jun 2022 15:47:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A649C0032;
	Thu,  9 Jun 2022 15:47:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE9DC002D
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 15:47:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C0A682883
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 15:47:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QqcVPLhBsgMZ for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jun 2022 15:47:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 16B2982882
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jun 2022 15:47:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 512DE61F62;
 Thu,  9 Jun 2022 15:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC149C3411B;
 Thu,  9 Jun 2022 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1654789626;
 bh=Ig3PZxq6X7jjVwsOQX/FxhA7SqMs07gOu2FyHVJ6vds=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KWYeGUMlnWf18Seq6J3rYnR5qb1T+QvCJdhi1QQAEYXfX0OkszfpEmywzR1JX8CeY
 zOQq6h8GVilu1KKQRTNi1bMrZfMxk79C2tQ2svu3P+6HKgfbtz+SjveJPX/mIPUC/7
 Q4D7ilZRcN8rXgUVgoJJPrZ1DSlItZck2rl4A0V6+40DTjrrxgMcr83ydAImqK352i
 uFMY/yiIgcFn0ICWk3RW2HFnS7G6kP8z+BfnyZkaSd+g9GjsEHbG5QxbESSebPBxev
 FET8oI2h6MfdMt1Pnv42g1N7l6IG2/7qd7q7ma0QVD4r77mjtNYr2y0FExR6S8JpPx
 Xcd7D7BQPR6jw==
Date: Thu, 9 Jun 2022 16:47:00 +0100
From: Will Deacon <will@kernel.org>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v12 6/9] iommu/arm-smmu-v3: Introduce strtab init helper
Message-ID: <20220609154656.GB3444@willie-the-truck>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <20220503163330.509-7-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220503163330.509-7-shameerali.kolothum.thodi@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
 hch@infradead.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, wanghuiqiang@huawei.com,
 guohanjun@huawei.com, Sami.Mujawar@arm.com, robin.murphy@arm.com,
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

On Tue, May 03, 2022 at 05:33:27PM +0100, Shameer Kolothum wrote:
> Introduce a helper to check the sid range and to init the l2 strtab
> entries(bypass). This will be useful when we have to initialize the
> l2 strtab with bypass for RMR SIDs.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 28 +++++++++++----------
>  1 file changed, 15 insertions(+), 13 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
