Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF75C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 13:26:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF6661492
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 13:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF6661492
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 53DC7203C4;
	Thu, 28 Jan 2021 13:26:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nwxPtv-cqzvo; Thu, 28 Jan 2021 13:26:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7E1DA20362;
	Thu, 28 Jan 2021 13:26:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F9D0C0FA7;
	Thu, 28 Jan 2021 13:26:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD68C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:26:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 738E58724D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:26:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YWjiHpP1mH2h for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 13:26:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CCB7E87247
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:26:41 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 136445AD; Thu, 28 Jan 2021 14:26:38 +0100 (CET)
Date: Thu, 28 Jan 2021 14:26:37 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH RFC 2/9] iommu: Add iova and size as parameters in
 iotlb_sync_map
Message-ID: <20210128132637.GQ32671@8bytes.org>
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
 <161177763296.1311.15197214300351076283.stgit@manet.1015granger.net>
 <20210128125112.GN32671@8bytes.org>
 <20210128131929.GA2296@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128131929.GA2296@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: isaacm@codeaurora.org, iommu@lists.linux-foundation.org,
 Chuck Lever <chuck.lever@oracle.com>, robin.murphy@arm.com
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

On Thu, Jan 28, 2021 at 01:19:29PM +0000, Will Deacon wrote:
> Heads-up, but I already queued this patch as part of its original series:
> 
> https://lore.kernel.org/r/20210107122909.16317-1-yong.wu@mediatek.com
> 
> since it's part of the Mediatek series for 5.12.
> 
> Would you like me to drop that, or can we stick with passing iova and size
> for now, with a view to refactoring it later on?

I think its okay for now, we can refactor it later.

Regards,

	Joerg
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
