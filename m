Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E241C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 10:00:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F6020883
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 10:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uP0ICWjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F6020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 2192FB43;
	Tue,  9 Apr 2019 10:00:32 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 50327AD7
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 10:00:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F422AF4
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209;
	h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IXMMc4OiWvkqldHfL4rJc+t+O6uuGFYhzXPx42szgWk=;
	b=uP0ICWjVf6WS5J83uwMNAHxHh
	XFN+wZUimhj857maKOxbHP8NgZHhENp3bGMvqb6qa2YbJpqm5yMU8VOHdUmbcxwktpqM1GYqoht2d
	a41JyJ6pkH3xnlac8Z1JKWiI3f99gqQR7GLQB6d9aUOVza6h5SvdMZrMAxlKYUCzPRohvGxYAxx/A
	pGbXl2DQluXT+wleFcqtrbbmXdfRof0mvQwc5dycX+Qjo4VjDjVYrTl4ZWqryh5xmlaL237YfcdgH
	j+xG07Mj3k5Wym34/sn919TyD+1ndgFq5baXwwraFboL1QZDKCV1TzRm3uh+kBJruOT4+r9C8M7ZE
	Nevh4rAjQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
	Hat Linux)) id 1hDnYI-00075Q-4e; Tue, 09 Apr 2019 10:00:26 +0000
Date: Tue, 9 Apr 2019 03:00:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu: Fix offsetof() usage
Message-ID: <20190409100025.GA22084@infradead.org>
References: <85778a4619eab832eb0b003a68f377aea9d97b22.1554727307.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <85778a4619eab832eb0b003a68f377aea9d97b22.1554727307.git.robin.murphy@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: David Laight <David.Laight@ACULAB.COM>, iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190409100026.vz2NCgq2iuNLsc2vbVn5gFgeVlEdmOaD7fZbPeWGDqA@z>

> index 74e944bd4a8d..81d449451494 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1484,8 +1484,7 @@ static int arm_smmu_add_device(struct device *dev)
>  	}
>  
>  	ret = -ENOMEM;
> -	cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
> -		      GFP_KERNEL);
> +	cfg = kzalloc(struct_size(cfg, smendx, i), GFP_KERNEL);

This looks like a huge improvement, but I find the usage of i
here still very obsfucating.  Can we please use fwspec->num_ids
directly instead of make it much more obvious?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
