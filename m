Return-Path: <SRS0=00Kx=7A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167E6C433E1
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:40:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45B6206D4
	for <iommu@archiver.kernel.org>; Mon, 18 May 2020 13:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45B6206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A67CC8863D;
	Mon, 18 May 2020 13:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W092R0qAMM8F; Mon, 18 May 2020 13:40:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 249C288602;
	Mon, 18 May 2020 13:40:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E358EC0888;
	Mon, 18 May 2020 13:40:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 714AEC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:40:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6A847871E0
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:40:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIDlE8WCR876 for <iommu@lists.linux-foundation.org>;
 Mon, 18 May 2020 13:40:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F281385D5F
 for <iommu@lists.linux-foundation.org>; Mon, 18 May 2020 13:40:04 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id D91A7386; Mon, 18 May 2020 15:40:02 +0200 (CEST)
Date: Mon, 18 May 2020 15:40:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] iommu/omap: Add registration for DT fwnode pointer
Message-ID: <20200518134001.GC18353@8bytes.org>
References: <20200424145828.3159-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200424145828.3159-1-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org
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

On Fri, Apr 24, 2020 at 05:58:28PM +0300, Tero Kristo wrote:
> The fwnode pointer must be passed to the iommu core, so that the core
> can map the IOMMU towards device requests properly. Without this, some
> IOMMU clients like OMAP remoteproc will fail the iommu configuration
> multiple times with -EPROBE_DEFER, which will eventually be ignored with
> a kernel warning banner.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/iommu/omap-iommu.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
