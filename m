Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2761AC433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 11:49:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AE4207B6
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 11:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AE4207B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4295185C98;
	Wed, 27 Jan 2021 11:49:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRz6wzdLMYHV; Wed, 27 Jan 2021 11:49:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 92699864E0;
	Wed, 27 Jan 2021 11:49:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63187C08A1;
	Wed, 27 Jan 2021 11:49:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53D19C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3DF2421511
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b+UG+UlfiC2e for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 11:49:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by silver.osuosl.org (Postfix) with ESMTPS id 0798C21509
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 11:49:09 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 0E5ED303; Wed, 27 Jan 2021 12:49:08 +0100 (CET)
Date: Wed, 27 Jan 2021 12:49:06 +0100
From: Joerg Roedel <joro@8bytes.org>
To: trix@redhat.com
Subject: Re: [PATCH] iommu/amd: remove h from printk format specifier
Message-ID: <20210127114906.GE32671@8bytes.org>
References: <20201215213021.2090698-1-trix@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215213021.2090698-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-kernel@vger.kernel.org
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

On Tue, Dec 15, 2020 at 01:30:21PM -0800, trix@redhat.com wrote:
>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
