Return-Path: <SRS0=TfYV=XM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC00C4CEC9
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:23:14 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 547F821670
	for <iommu@archiver.kernel.org>; Tue, 17 Sep 2019 18:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DjzbQywx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 547F821670
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 228D8A95;
	Tue, 17 Sep 2019 18:23:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 647F9265
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:23:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
	[209.85.215.196])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 1185176D
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 18:23:12 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id x15so2439018pgg.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 17 Sep 2019 11:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
	h=date:from:to:cc:subject:in-reply-to:message-id:references
	:user-agent:mime-version;
	bh=N+ZvW5XGZPlKGoWdD6lQLoORQOVvTeBoK7Mquxm8Mos=;
	b=DjzbQywxFH7fD+3bt5IqiSsQVUCbjqXB+I60sfjSk/EfG9e3ii1X1mx/WPlGJa5p7a
	4cLinS9ljquEiFVPO9VHp6n2HEbyMHVfactLBezhvUtTsTs2m4eO9BhahGuVt6D0i2U7
	dv/n92xSw2SsI2qt8jgaJ/F39/7kPn+9KPaAulNegpOwgtAjurrSGB9b3M9ZXj5XXUn6
	ioVkxAD54oYmSnxuB0E4ZEB8/JXeTe8hDpgDtd7iEQx9XfZunGXkRlK5SJxwJDj10cuy
	lJyAbtoLBV6gzip4nzF49wOwL63nDnj16cJErgUFx2iCNevjldP4YHXHc8fRMQNb2DZw
	KPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
	:references:user-agent:mime-version;
	bh=N+ZvW5XGZPlKGoWdD6lQLoORQOVvTeBoK7Mquxm8Mos=;
	b=SnxlWi/diarPeSOqKKGidPPp4gaHwlvslvM/YqYgAhh/haqqSVsjrsrQgnmFMKLd4t
	gjrGUhe0mhelzVoPfM447g+qMICi8HNDwLr8FkeOHUyHklmKiur23DzTEmgNwt+JpHFK
	5CDrSm9qkMgRaBm2dPqV2asSpERDvPj+vN21ou4QpMcIKssOCz1oDIU5Xb6Qo+qfg8Ct
	6pJguUMOT1BCUN1JBFBjLMmetkbwJ5a68ffdVeVAez2I9W8pIaE47WLiDjas6MUpLwgd
	2whw1GuSSWvvvX2uA0xP0PrYtqUxpOw6CPNVQE2KbNauRFFOHfAOVocTFq5LsWd/q6Dx
	PT1g==
X-Gm-Message-State: APjAAAV3c03495QmDFYkxfu0BsaJLa9Wp+WaEVo31iYuDH+h5e7a/zoA
	WqdYOSCNTFRFo4TeETp35CDqYg==
X-Google-Smtp-Source: APXvYqx2KDzDaitTwku3JFa1UCEMfkpT0dPM41Q9FIaSsoOK23XkEzPeudmDOZYYF8r5xDdrW60fJA==
X-Received: by 2002:a65:5cc8:: with SMTP id b8mr212852pgt.30.1568744592123;
	Tue, 17 Sep 2019 11:23:12 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
	([2620:15c:17:3:3a5:23a7:5e32:4598])
	by smtp.gmail.com with ESMTPSA id
	e21sm3021514pgr.43.2019.09.17.11.23.11
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Tue, 17 Sep 2019 11:23:11 -0700 (PDT)
Date: Tue, 17 Sep 2019 11:23:10 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [bug] __blk_mq_run_hw_queue suspicious rcu usage
In-Reply-To: <alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.1909171121300.151243@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1909041434580.160038@chino.kir.corp.google.com>
	<20190905060627.GA1753@lst.de>
	<alpine.DEB.2.21.1909051534050.245316@chino.kir.corp.google.com>
	<alpine.DEB.2.21.1909161641320.9200@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
	iommu@lists.linux-foundation.org, Peter Gonda <pgonda@google.com>,
	Jianxiong Gao <jxgao@google.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, 16 Sep 2019, David Rientjes wrote:

> Brijesh and Tom, we currently hit this any time we boot an SEV enabled 
> Ubuntu 18.04 guest; I assume that guest kernels, especially those of such 
> major distributions, are expected to work with warnings and BUGs when 
> certain drivers are enabled.
> 
> If the vmap purge lock is to remain a mutex (any other reason that 
> unmapping aliases can block?) then it appears that allocating a dmapool 
> is the only alternative.  Is this something that you'll be addressing 
> generically or do we need to get buy-in from the maintainers of this 
> specific driver?
> 

We've found that the following applied on top of 5.2.14 suppresses the 
warnings.

Christoph, Keith, Jens, is this something that we could do for the nvme 
driver?  I'll happily propose it formally if it would be acceptable.

Thanks!


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1613,7 +1613,8 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
 		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
 		dev->admin_tagset.cmd_size = sizeof(struct nvme_iod);
-		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
+		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED |
+					  BLK_MQ_F_BLOCKING;
 		dev->admin_tagset.driver_data = dev;
 
 		if (blk_mq_alloc_tag_set(&dev->admin_tagset))
@@ -2262,7 +2263,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->tagset.queue_depth =
 				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
 		dev->tagset.cmd_size = sizeof(struct nvme_iod);
-		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
+		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE |
+				    BLK_MQ_F_BLOCKING;
 		dev->tagset.driver_data = dev;
 
 		ret = blk_mq_alloc_tag_set(&dev->tagset);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
