Return-Path: <SRS0=0/W0=IO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AABAC433E6
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 13:16:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0460065036
	for <iommu@archiver.kernel.org>; Tue, 16 Mar 2021 13:16:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0460065036
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DE5343188;
	Tue, 16 Mar 2021 13:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OXUyNC_kL3xv; Tue, 16 Mar 2021 13:16:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7499C414E0;
	Tue, 16 Mar 2021 13:16:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50C50C000C;
	Tue, 16 Mar 2021 13:16:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1D79C000A
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 13:16:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9377D4EC86
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 13:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Km81TG3-cCzY for <iommu@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:16:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B16EF4EC83
 for <iommu@lists.linux-foundation.org>; Tue, 16 Mar 2021 13:16:38 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 49836AC47;
 Tue, 16 Mar 2021 13:16:36 +0000 (UTC)
Date: Tue, 16 Mar 2021 14:16:34 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] iommu/amd: Fix iommu remap panic while amd_iommu is set
 to disable
Message-ID: <YFCvsort3oZGfDBy@suse.de>
References: <20210311142807.705080-1-ray.huang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311142807.705080-1-ray.huang@amd.com>
Cc: Xiaojian Du <xiaojian.du@amd.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alex Deucher <alexander.deucher@amd.com>
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

Hi Huang,

On Thu, Mar 11, 2021 at 10:28:07PM +0800, Huang Rui wrote:
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index f0adbc48fd17..a08e885403b7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3862,7 +3862,7 @@ static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
>  	else if (x86_fwspec_is_hpet(fwspec))
>  		devid = get_hpet_devid(fwspec->param[0]);
>  
> -	if (devid < 0)
> +	if (devid < 0 || !amd_iommu_rlookup_table)
>  		return 0;

The problem is deeper than this fix suggests. I prepared other fixes for
this particular problem. Please find them here:

	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=iommu-fixes

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
