Return-Path: <SRS0=ytjs=7R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2720C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 09:16:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 757132065C
	for <iommu@archiver.kernel.org>; Thu,  4 Jun 2020 09:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757132065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4B46A87A72;
	Thu,  4 Jun 2020 09:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GaLKdj+uAQcv; Thu,  4 Jun 2020 09:16:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A254F86E1A;
	Thu,  4 Jun 2020 09:16:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A291C0881;
	Thu,  4 Jun 2020 09:16:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B0F9C016E
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:16:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0169888079
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:16:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-VZOkzh+DbH for <iommu@lists.linux-foundation.org>;
 Thu,  4 Jun 2020 09:16:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 06FE985B48
 for <iommu@lists.linux-foundation.org>; Thu,  4 Jun 2020 09:16:24 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 51022AB87;
 Thu,  4 Jun 2020 09:16:25 +0000 (UTC)
Date: Thu, 4 Jun 2020 11:16:19 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] iommu: Don't attach deferred device in
 iommu_group_do_dma_attach
Message-ID: <20200604091619.GO6857@suse.de>
References: <20200604073142.74701-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200604073142.74701-1-jsnitsel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Hi Jerry,

On Thu, Jun 04, 2020 at 12:31:42AM -0700, Jerry Snitselaar wrote:
> Attaching a deferred device should be delayed until dma api is called.
> 
> Cc: iommu@lists.linux-foundation.org
> Suggested-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> ---
> If you already have thrown a patch together, then ignore this. Also
> feel free to swap out the signed-off-by with your's since
> this is more your patch than mine. You can put a reviewed-by
> and tested-by instead for me.

Yeah, I already have a patch, just not sent out yet. I updated it with
your tags and will send it out shortly.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
