Return-Path: <SRS0=V6zV=XV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB10C432C2
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:25:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FCDE21A4A
	for <iommu@archiver.kernel.org>; Thu, 26 Sep 2019 06:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5ag7Z0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FCDE21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 50A0BB88;
	Thu, 26 Sep 2019 06:25:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AB3DAB6C
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:25:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com
	(us-smtp-delivery-1.mimecast.com [207.211.31.120])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 19F5C8A0
	for <iommu@lists.linux-foundation.org>;
	Thu, 26 Sep 2019 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1569479098;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=R7DOXDo2EfE1TJnNp+djuxunurLi+S3j66Oz2J6aSFw=;
	b=X5ag7Z0BmHht1Gay6C9+OR2MMISl+4gEBIDCXzBm4hXVUqI5g7Ob3RiZ+vSkGa5VeU6EMI
	m80X81HnKeQsMYE87chojQDvWJlaObVCjG6Z1It8YjI+uoDNUxhPq1MN9CX2FVgp605rC4
	cXIdI/cJQcCMuVWc97MhsOPGZ0SEQUU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
	[209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-345-N3MPQkUrOaavcWjj-U9dyw-1; Thu, 26 Sep 2019 02:24:55 -0400
Received: by mail-io1-f69.google.com with SMTP id i2so2716990ioo.10
	for <iommu@lists.linux-foundation.org>;
	Wed, 25 Sep 2019 23:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
	:references:mime-version:content-disposition:in-reply-to:user-agent;
	bh=2GE367oBS69p1zi7IgE6o4AX1q3/L/HUCm3cVJ/rB2I=;
	b=lqBXrlWFuHQhgoIT7D4x3p6t/Cgf8Cg8X/OrY4400s38htHTcLrIFTpveX3yZtyq9A
	wEV2PnTj+b2lrtWZXGYFng6GcaDRF1MX5AvW40GjRVygB9YsTZgcCTD7OOwd4TqivsFP
	uY5qhpyzrTqRKOKcdBC1y3zVfjy20Kyin+dgbaMMayZYOuc6AAa9ZUuwLOkUiZNQzloL
	TiwllPmF7ZuM5rtJGwLO3frR7oIhw9AsM05dagMoFSJK9mYdNh7nK9dvvQu9XVpHnNOk
	hTn26c2YBqZw613vSYUDZCxUdiP5lXw1qNmAQEZu1VWlY/7FJZzdHJdMucsnr/d2z5zn
	Uv0Q==
X-Gm-Message-State: APjAAAUAD842y/HJATuO+CeEULRV5Baev9UzmduzasnvYs1l3ti20F7/
	EG+3XQwFd9Q6UmC3FyX2oleNmx1lEUsZSayqj6llB24quOguEEX5hjEDr1CxQUL6Ogb7AsjeHqw
	qHlJuwqfTHdlNJ9UuHoQEzjpirrolsg==
X-Received: by 2002:a92:c691:: with SMTP id o17mr898048ilg.185.1569479094669; 
	Wed, 25 Sep 2019 23:24:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0/3chzyozu8RngmT9KCfQtQXJaYkBpyCWMbY/I0to2uTztxdn3mnrg5gzG2jDhOmJyGcVFg==
X-Received: by 2002:a92:c691:: with SMTP id o17mr898043ilg.185.1569479094416; 
	Wed, 25 Sep 2019 23:24:54 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
	by smtp.gmail.com with ESMTPSA id 13sm309045ilz.54.2019.09.25.23.24.52
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Wed, 25 Sep 2019 23:24:53 -0700 (PDT)
Date: Wed, 25 Sep 2019 23:24:52 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/6] iommu/amd: Remove amd_iommu_devtable_lock
Message-ID: <20190926062451.olmmbpjkdnwljzd7@cantor>
References: <20190925132300.3038-1-joro@8bytes.org>
	<20190925132300.3038-3-joro@8bytes.org>
MIME-Version: 1.0
In-Reply-To: <20190925132300.3038-3-joro@8bytes.org>
User-Agent: NeoMutt/20180716
X-MC-Unique: N3MPQkUrOaavcWjj-U9dyw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
Cc: Filippo Sironi <sironi@amazon.de>, iommu@lists.linux-foundation.org,
	jroedel@suse.de
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
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Wed Sep 25 19, Joerg Roedel wrote:
>From: Joerg Roedel <jroedel@suse.de>
>
>The lock is not necessary because the device table does not
>contain shared state that needs protection. Locking is only
>needed on an individual entry basis, and that needs to
>happen on the iommu_dev_data level.
>
>Fixes: 92d420ec028d ("iommu/amd: Relax locking in dma_ops path")
>Signed-off-by: Joerg Roedel <jroedel@suse.de>
>---
> drivers/iommu/amd_iommu.c | 23 ++++++-----------------
> 1 file changed, 6 insertions(+), 17 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 042854bbc5bc..37a9c04fc728 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -70,7 +70,6 @@
>  */
> #define AMD_IOMMU_PGSIZES	((~0xFFFUL) & ~(2ULL << 38))
>
>-static DEFINE_SPINLOCK(amd_iommu_devtable_lock);
> static DEFINE_SPINLOCK(pd_bitmap_lock);
>
> /* List of all available dev_data structures */
>@@ -2080,10 +2079,11 @@ static void do_detach(struct iommu_dev_data *dev_data)
> static int __attach_device(struct iommu_dev_data *dev_data,
> 			   struct protection_domain *domain)
> {
>+	unsigned long flags;
> 	int ret;
>
> 	/* lock domain */
>-	spin_lock(&domain->lock);
>+	spin_lock_irqsave(&domain->lock, flags);
>
> 	ret = -EBUSY;
> 	if (dev_data->domain != NULL)
>@@ -2097,7 +2097,7 @@ static int __attach_device(struct iommu_dev_data *dev_data,
> out_unlock:
>
> 	/* ready */
>-	spin_unlock(&domain->lock);
>+	spin_unlock_irqrestore(&domain->lock, flags);
>
> 	return ret;
> }
>@@ -2181,7 +2181,6 @@ static int attach_device(struct device *dev,
> {
> 	struct pci_dev *pdev;
> 	struct iommu_dev_data *dev_data;
>-	unsigned long flags;
> 	int ret;
>
> 	dev_data = get_dev_data(dev);
>@@ -2209,9 +2208,7 @@ static int attach_device(struct device *dev,
> 	}
>
> skip_ats_check:
>-	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
> 	ret = __attach_device(dev_data, domain);
>-	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
>
> 	/*
> 	 * We might boot into a crash-kernel here. The crashed kernel
>@@ -2231,14 +2228,15 @@ static int attach_device(struct device *dev,
> static void __detach_device(struct iommu_dev_data *dev_data)
> {
> 	struct protection_domain *domain;
>+	unsigned long flags;
>
> 	domain = dev_data->domain;
>
>-	spin_lock(&domain->lock);
>+	spin_lock_irqsave(&domain->lock, flags);
>
> 	do_detach(dev_data);
>
>-	spin_unlock(&domain->lock);
>+	spin_unlock_irqrestore(&domain->lock, flags);
> }
>
> /*
>@@ -2248,7 +2246,6 @@ static void detach_device(struct device *dev)
> {
> 	struct protection_domain *domain;
> 	struct iommu_dev_data *dev_data;
>-	unsigned long flags;
>
> 	dev_data = get_dev_data(dev);
> 	domain   = dev_data->domain;
>@@ -2262,10 +2259,7 @@ static void detach_device(struct device *dev)
> 	if (WARN_ON(!dev_data->domain))
> 		return;
>
>-	/* lock device table */
>-	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
> 	__detach_device(dev_data);
>-	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
>
> 	if (!dev_is_pci(dev))
> 		return;
>@@ -2910,9 +2904,6 @@ int __init amd_iommu_init_dma_ops(void)
> static void cleanup_domain(struct protection_domain *domain)
> {
> 	struct iommu_dev_data *entry;
>-	unsigned long flags;
>-
>-	spin_lock_irqsave(&amd_iommu_devtable_lock, flags);
>
> 	while (!list_empty(&domain->dev_list)) {
> 		entry = list_first_entry(&domain->dev_list,
>@@ -2920,8 +2911,6 @@ static void cleanup_domain(struct protection_domain *domain)
> 		BUG_ON(!entry->domain);
> 		__detach_device(entry);
> 	}
>-
>-	spin_unlock_irqrestore(&amd_iommu_devtable_lock, flags);
> }
>
> static void protection_domain_free(struct protection_domain *domain)
>-- 
>2.17.1
>
>_______________________________________________
>iommu mailing list
>iommu@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
