Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE15C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 14:44:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F01161209
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 14:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F01161209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EBF2B40342;
	Wed, 16 Jun 2021 14:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdmXtO-KAXfZ; Wed, 16 Jun 2021 14:44:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8EF54030F;
	Wed, 16 Jun 2021 14:44:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9410EC000E;
	Wed, 16 Jun 2021 14:44:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B6F1C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 14:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55E42834E8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 14:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oDGFPHmmp681 for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 14:44:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CEF6E834CB
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 14:44:17 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0534867357; Wed, 16 Jun 2021 16:44:14 +0200 (CEST)
Date: Wed, 16 Jun 2021 16:44:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [RFC PATCH] iommu: add domain->nested
Message-ID: <20210616144413.GA2593@lst.de>
References: <1623854282-26121-1-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1623854282-26121-1-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: jean-philippe <jean-philippe@linaro.org>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Jun 16, 2021 at 10:38:02PM +0800, Zhangfei Gao wrote:
> +++ b/include/linux/iommu.h
> @@ -87,6 +87,7 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	void *iova_cookie;
> +	int nested;

This should probably be a bool : 1;

Also this needs a user, so please just queue up a variant of this for
the code that eventually relies on this information.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
