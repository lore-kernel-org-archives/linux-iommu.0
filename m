Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C405C433E0
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EBB206C3
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="cLhqFJsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EBB206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2CFAC2041F;
	Thu, 11 Jun 2020 19:20:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xis4CcocribC; Thu, 11 Jun 2020 19:20:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 28987203FB;
	Thu, 11 Jun 2020 19:20:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07D57C0865;
	Thu, 11 Jun 2020 19:20:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F1F7C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 060CC880C2
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K213W80XOHvY for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 19:20:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com
 [209.85.214.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D84A2878BE
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 19:20:27 +0000 (UTC)
Received: by mail-pl1-f194.google.com with SMTP id v24so2691147plo.6
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:user-agent:mime-version;
 bh=vs8zuDzvjHdETDEcGTy3L+gn3DFxvZBwvmNgqN4PsP8=;
 b=cLhqFJsu1N/2ngljNE1bZa8+nfqnzZi/4WMjB13VYRrKiXxxh9TnKyU3rnpTIuEqso
 LrbP0J0WrIybuzHP4Hy9ob/t/lIMe7AAn2rdgO23DyfahHsHhNNFLgXadYJV1JPpHAZn
 NZo8AWG6yiXW9qWaUFsMOIfIwugr8kjyEJp6RNFql5qP25/9l/K1VZmqeFLH99dd+VIf
 4FNfqf9Q5nQcyO2ezmSMHoC3IuvOiUyCZKDO5ZkKXq08No6Buqb/VdHc2FXM9B37sb+g
 whOTRTL/rvO/vAqmYaglbc8vp1f1CmqUKu1wvN5iEBvg7lfiFI4+oss2G7quLINrYGl9
 i8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
 :mime-version;
 bh=vs8zuDzvjHdETDEcGTy3L+gn3DFxvZBwvmNgqN4PsP8=;
 b=Zaiq9hbAH9bS65+YXQufLdi5/2epgq4qTBkMxtlvnrjytCb86YslHki68LyUZmMZyH
 ZTSnwyBOvMtonLwnFvzy0z+OhG8kxUKSwqxy2ZLi/v4Ul0rpzXZYJsxaZvisSTmXlVKv
 Asv7nMX7VJVZlg57kdBqXUQKL+10p/sZhoo+MoQzdC10YK+V45C4Br0tBeOFp6wwzX+M
 DuGSOpiDL1X1owCSpK0Q+q2CGqD806bW618/KXpyUflNJlCuNEya/HOsY1Ff3eTWJVqK
 hAmXuN8gu9oc7VGRfRKMXzOjXAbcT8goRWZR3FNjX8Xn6u9Hu9cYDg2eJ3usLoE/u+ll
 LRuA==
X-Gm-Message-State: AOAM533ZMc5V0riSv9cv34xFw+hvimp2YAk02Kjs3aM+tAk76zNAruKp
 TljQF1b8kC7QicCfbSDF1zlWyQ==
X-Google-Smtp-Source: ABdhPJzytk0KYlXV5rOWpFspxq0MH757orr/tBcyS6r2KR2i5RmbUoahzpSj7DOXXQ6kmIJR2nWXhA==
X-Received: by 2002:a17:90a:e801:: with SMTP id
 i1mr9154849pjy.79.1591903227192; 
 Thu, 11 Jun 2020 12:20:27 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id f29sm3470376pgf.63.2020.06.11.12.20.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 12:20:26 -0700 (PDT)
Date: Thu, 11 Jun 2020 12:20:25 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: [patch for-5.8 0/4] dma-direct: dma_direct_alloc_pages() fixes for
 AMD SEV
Message-ID: <alpine.DEB.2.22.394.2006111218200.153880@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: Thomas Lendacky <thomas.lendacky@amd.com>,
 Brijesh Singh <brijesh.singh@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

While debugging recently reported issues concerning DMA allocation
practices when CONFIG_AMD_MEM_ENCRYPT is enabled, some curiosities arose
when looking at dma_direct_alloc_pages() behavior.

Fix these up.  These are likely all stable material, so proposing for 5.8.
---
 kernel/dma/direct.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
