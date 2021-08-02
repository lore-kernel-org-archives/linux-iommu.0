Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77EAC432BE
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 14:46:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFEA61108
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 14:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8DFEA61108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51A8B40177;
	Mon,  2 Aug 2021 14:46:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d8EKooYB4Quv; Mon,  2 Aug 2021 14:46:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3246740168;
	Mon,  2 Aug 2021 14:46:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBB87C001B;
	Mon,  2 Aug 2021 14:46:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71BBDC000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5059E8302F
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9hL-tbxTlV6D for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 14:46:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6D418300C
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 14:46:28 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5893460F5A;
 Mon,  2 Aug 2021 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627915588;
 bh=PCyu/Y0oyAjSVhXusuoKFGjC/gazcGTZ7a+kCE6+TgU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qvCVQELnU1ndwO//2Z0IEuRfGtQDeGfy5jOET9KRUmeZtILAwFChOT5WU62TStRhp
 VFr5cMybOmmsXE9vNkxj5p5vmaZvlPcetHGFB6Jn6nyHakFE0+4qy0uNtABHlGR7gj
 0IUgCqefhhus8DtsNOFZOUZZOdhUV4OSXHOfp6tdMe7OmH3P9KgbktnbObZ8uEC6o3
 uB43y2UnFBcD9ymFukR0sZn55vZr8MSUcJs5HlFBbQ83688xCIlnUz/EHlGxeQxfTD
 CZL2cehfqa9yMljCDHRhnvEPxoOViomRyb+0xt1WJI62FZPQZeDFbueqpIHt6EwODD
 3rcl7gJE9Xbfg==
Date: Mon, 2 Aug 2021 15:46:22 +0100
From: Will Deacon <will@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4 1/6] iommu: Refactor iommu_group_store_type()
Message-ID: <20210802144621.GB28735@willie-the-truck>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1626259003-201303-2-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com, mst@redhat.com,
 airlied@linux.ie, gregkh@linuxfoundation.org, linuxarm@huawei.com,
 jonathanh@nvidia.com, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, daniel@ffwll.ch, bingbu.cao@intel.com,
 digetx@gmail.com, mchehab@kernel.org, robin.murphy@arm.com,
 jasowang@redhat.com, tian.shu.qiu@intel.com
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

On Wed, Jul 14, 2021 at 06:36:38PM +0800, John Garry wrote:
> Function iommu_group_store_type() supports changing the default domain
> of an IOMMU group.
> 
> Many conditions need to be satisfied and steps taken for this action to be
> successful.
> 
> Satisfying these conditions and steps will be required for setting other
> IOMMU group attributes, so factor into a common part and a part specific
> to update the IOMMU group attribute.
> 
> No functional change intended.
> 
> Some code comments are tidied up also.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  drivers/iommu/iommu.c | 73 +++++++++++++++++++++++++++----------------
>  1 file changed, 46 insertions(+), 27 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Although likely to conflict with Robin's monster series.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
