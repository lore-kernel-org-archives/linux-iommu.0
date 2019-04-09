Return-Path: <SRS0=aFDh=SL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F992C10F0E
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 22:47:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1531D20820
	for <iommu@archiver.kernel.org>; Tue,  9 Apr 2019 22:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRtjNu8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1531D20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B2FD410EC;
	Tue,  9 Apr 2019 22:47:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 96BD310D8
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 22:47:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
	[209.85.214.169])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 40C6BCF
	for <iommu@lists.linux-foundation.org>;
	Tue,  9 Apr 2019 22:47:25 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id f36so103883plb.5
	for <iommu@lists.linux-foundation.org>;
	Tue, 09 Apr 2019 15:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:mime-version:content-disposition
	:user-agent; bh=Jo/eJIL8GHRKnYyGMryXH1DndZnHlreh09hDlipbqzM=;
	b=bRtjNu8u0sZc3Mg6QFbD447xL9x4MuBSJ48k1qgP/EtdnZnE7QByq1qLvHa6x2s0dn
	KS9ShTzhTewQBpJ6LVCsZzN58/fxAEU/E6QaCuBnrWIWS8XSC3LoW99cIcDtqlIOhZJi
	XNSTQP/3SrvB/ND0MT9i9zLCO4X0IFZNNPKB3ESb4ZKdHEmS4Sl3w+FZe4SYBQXuFRSC
	+N/zJcNcxsz9DLmZVcaGxWAVOfS1Sx4blb2MPFbdeG0WEbr397lwYxyQUYN7EKG5Olbr
	33mVHQYmiSG1GuVerzHG1TYx/X5jAjQe0Mkiu9Y9bNDnYkKe7cjIFbYPvtmAUdLPfxpO
	gEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
	:content-disposition:user-agent;
	bh=Jo/eJIL8GHRKnYyGMryXH1DndZnHlreh09hDlipbqzM=;
	b=ThtrKGbZa+GULSPe6h136pBWIYtJthImxw7hTZZahwtAgVH3Ws0evoEXhSB3UbC57c
	/yPj4+MJxnk/4RT05xGz6OnVa4uw1ZGVnFZGAbRnzB8nAiPx2YtIa12zOSftXB7JVarO
	T/PtLKDnnEraOgUNlNmsy0DNDyDz25hewm/BSo/fiOc7PFP6p7b/rgnj3hc15wz9ogys
	+j2ZViJSx0Mp4b6sm17WpgT8/B1IZWqwfTdIGgSi7eNiYIYoOaqLpFyKD7sLOAqWcQQw
	FYJQxA6bKVUfAY6x+7q3YV6Jp9+dsHni96ly0/SJ28o267ghtshNQmOhSQK+5I5kQYB9
	aXqg==
X-Gm-Message-State: APjAAAUdHQWlokAVGBUKx+mlQCwDxDLxYeDxisYy2uMXNXdUHeOwh8Jr
	77sFDM47S8+vmu+QV3M0sbs=
X-Google-Smtp-Source: APXvYqyO3WhNyXhqmmGRbTBPO3U0flN2rTYFvt4IffAKmyD8sbQUfDkc4Pu+K6D2ZLglFzu3YF0gyQ==
X-Received: by 2002:a17:902:3e5:: with SMTP id
	d92mr38179766pld.11.1554850044711; 
	Tue, 09 Apr 2019 15:47:24 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
	[216.228.112.22]) by smtp.gmail.com with ESMTPSA id
	t82sm91190347pfa.153.2019.04.09.15.47.23
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 15:47:24 -0700 (PDT)
Date: Tue, 9 Apr 2019 15:47:19 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Ohad Ben-Cohen <ohad@wizery.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: Do we always need to reserve an iova before iommu_map?
Message-ID: <20190409224718.GA3281@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: iommu@lists.linux-foundation.org, linux-remoteproc@vger.kernel.org
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
Message-ID: <20190409224719.dzsck1mMHxihUbki-4pl05-71WuOI7oH6JTgEugFgW4@z>

Hi all,

According to the routine of iommu_dma_alloc(), it allocates an iova
then does iommu_map() to map the iova to a physical address of new
allocated pages. However, in remoteproc_core.c, I see its code try
to iommu_map() without having an alloc_iova() or alloc_iova_fast().

Is it safe to do so? If an iova range is not allocated but mapped,
would a later iommu_dma_alloc() happen to hit this iova range when
doing its alloc_iova() and then fail to map?

And I am not very familiar with remoteproc code, so if I am missing
something, please kindly educate me.

Thanks
Nicolin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
