Return-Path: <SRS0=cSHS=77=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FDFC433E0
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 17:49:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8821C207DD
	for <iommu@archiver.kernel.org>; Thu, 18 Jun 2020 17:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="eutxv2Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8821C207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3BEAE8971A;
	Thu, 18 Jun 2020 17:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QdgZqh0Hl6K1; Thu, 18 Jun 2020 17:49:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2DAC389706;
	Thu, 18 Jun 2020 17:49:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12FABC088C;
	Thu, 18 Jun 2020 17:49:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 612DDC016E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4CE21878C1
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6lce89df677 for <iommu@lists.linux-foundation.org>;
 Thu, 18 Jun 2020 17:49:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 21957878F0
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 17:49:16 +0000 (UTC)
Received: by mail-pl1-f195.google.com with SMTP id v24so2729176plo.6
 for <iommu@lists.linux-foundation.org>; Thu, 18 Jun 2020 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=gxk0mpNa0zDp1a6ZbGOjifp1sPgDInqSNRsdHtC1Hro=;
 b=eutxv2PiYY3Hf7kIcg35ZVWehj2QRs6NISrkXqJnBcO94eFIIVNhzMmYT/KvasEv/7
 Dg6yWieF5fjiNuTwsTlEcQTv67pMIt2tUtBgW2ivWgeFKOiU86ydlDXiQ7myVBSdjmVs
 oZMjfJI21sdpnTEgfOMzh5iU1XLpr+ltfBd+WQE2hlaakXSoS/M/AwwQAIac0glLq+VB
 EbsFJ0PB7xPqGSLemiArDV6EcbSQZfZTPsu4Hqc1f5tkVGA3VNvFrddyWMijSyYCNPoU
 aPnbeTJWsDX3rmbvw85AggJa1YQLV0rNwwGgjQE92KVT7h6oNxHRKbT4pMQf/kHUwMVO
 U+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=gxk0mpNa0zDp1a6ZbGOjifp1sPgDInqSNRsdHtC1Hro=;
 b=aM31VLuESr5T/DQtD4WmxeQ+NmJogWwh/59ZPV93Po9G8xHtalrmUDzwltxGqr+567
 1oz+FY5b1ZCstyuHZo6o+jH0SCmG3KpMu09dJ9byiEuRBgYn5mySWMPiRaHPFmQAYE/p
 evrnEtGDny17JpGypKvw/PX1IZY84NW41IgnPp4YKHbpaaiZUExHVP1R85fs127We4gW
 gmmMeIjh5117F5yZxre+brPuZGFtz8oJvtKuTUyYqH9gpxMSxCUuH4OfonHX837wOzXI
 QTcirUV9ZoMiyOUiDSfim6sGKZMCYfQVGVTI2Z8FoU0tpOXapNRkKo2DzkUXZYbAf9P/
 vo3w==
X-Gm-Message-State: AOAM530g+iCbgzePsBpKLU+4cwiKyw0OMhkXgTIKGJKWrDMPtmqRNron
 gWVIlXLMhxb7Qe9QD0Vt0ZT4Tw==
X-Google-Smtp-Source: ABdhPJwePPoyJKKty49/kFzWmOuIwz4LoRXlzrUor1Yd1A7Fb6F2+E5Hzyy+9kCNkRpMU8WU3GMsvQ==
X-Received: by 2002:a17:90a:e7cd:: with SMTP id
 kb13mr5312238pjb.138.1592502555536; 
 Thu, 18 Jun 2020 10:49:15 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id j184sm3447763pfg.131.2020.06.18.10.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 10:49:14 -0700 (PDT)
Date: Thu, 18 Jun 2020 10:49:14 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: DMA_COHERENT_POOL should select
 GENERIC_ALLOCATOR
In-Reply-To: <20200618152506.116057-1-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2006181047350.246344@chino.kir.corp.google.com>
References: <20200618152506.116057-1-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
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

On Thu, 18 Jun 2020, Christoph Hellwig wrote:

> The dma coherent pool code needs genalloc.  Move the select over
> from DMA_REMAP, which doesn't actually need it.
> 
> Fixes: dbed452a078d ("dma-pool: decouple DMA_REMAP from DMA_COHERENT_POOL")
> Reported-by: kernel test robot <lkp@intel.com>

Acked-by: David Rientjes <rientjes@google.com>

Thanks Christoph.  In the initial bug report from Alex Xu, his .config set 
CONFIG_GENERIC_ALLOCATOR already so I think there is very little risk with 
this patch.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
