Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAECC433FE
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 12:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98EC94255E;
	Thu, 26 May 2022 12:01:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2C-L9O9A339H; Thu, 26 May 2022 12:01:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3A3694255B;
	Thu, 26 May 2022 12:01:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E030C0032;
	Thu, 26 May 2022 12:01:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD50FC002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 12:01:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC215845EB
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 12:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0zJW3gjKjxY for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 12:01:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 375A5845C7
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 12:01:19 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id 202so1564841pfu.0
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 05:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=olJVsa+imhZbIKfwYfCiwIDRYc9xg1wbsCc3f7jqMns=;
 b=hGhiTVMQrBdxXb+ebcEPGyBOUj6LNRR2pUIBaSCjRGYIrixAojVkDf20FUVeLG7Pjv
 ontXkDMXnlq5vvhr/MhbJ4XqqvK+dlMP0YkcJhMaS5ampadi9hkjjB3g5+U8Ciw29N0D
 i8WWZUqBhodFqu+qMoRUObdw8UF+sj0caBvrcVjRkBeLarmTKWfVRNAs7NrCAAYr0Edj
 P766cBKxM03M3G9Lx8YLfKGnIjHv42GUBI05180y5oYrKkZZtSxZ0yThNrmlrm5mOkzo
 CTFZz6xBNovdU65JpD48KL8Jj4PtJ97r9RPypzfsxmn5mf3abn9LSPRYlVUotJromWno
 Tfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=olJVsa+imhZbIKfwYfCiwIDRYc9xg1wbsCc3f7jqMns=;
 b=zYemgIcqXmtcAVVsDySe2IkuXmREGgzRKZYniJRTGWebWDXljS1od3Uh8Jz31H84HJ
 AwM5prU7x5H8qJ3FM1P83rb3m/J5iiHZAJ4u4I584HMo9bEQRDjMVg/52opY5tx0EFk6
 +vCfP9GTEgGe0jGEV+0iHd3XwGvoTBXfsXpb5jEkpXMAoJSpfD13UhBg2N3PlmyO48ya
 7oiY3C6z2zDwnb8wMqiVNo+Q0qPwvwi9uo/QK9vwL5sRDNa6k9+qCFj+zwM/2l65ThCf
 +HP70MLNTxVtRSgb8yKmuhudxnjBM/KyKjDBnIXmcCED4gd/1f2JGdfQJ2bj038R5cNg
 NOuA==
X-Gm-Message-State: AOAM530zVixVrG/ivyQKpr53ZCR9+bfgjWTlEJd+5DmtKvECPV7BdL8v
 QleuQaUXDnSfaWKUEt7wCTA=
X-Google-Smtp-Source: ABdhPJzLzAuPjPrbmsZkr4fRsgdboaUdZStwLpGgpVUvkhrmLbOYM8puX8iCU21k1NPJPwOUvEJZFg==
X-Received: by 2002:a05:6a02:105:b0:381:fd01:330f with SMTP id
 bg5-20020a056a02010500b00381fd01330fmr32208794pgb.483.1653566478613; 
 Thu, 26 May 2022 05:01:18 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:1:45c7:d5e2:7b45:3336])
 by smtp.gmail.com with ESMTPSA id
 bi7-20020a170902bf0700b0015e8d4eb282sm1328190plb.204.2022.05.26.05.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 May 2022 05:01:18 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 michael.h.kelley@microsoft.com
Subject: [RFC PATCH V3 0/2] swiotlb: Add child io tlb mem support
Date: Thu, 26 May 2022 08:01:10 -0400
Message-Id: <20220526120113.971512-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 konrad.wilk@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kirill.shutemov@intel.com, iommu@lists.linux-foundation.org,
 andi.kleen@intel.com, vkuznets@redhat.com, hch@lst.de
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

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Traditionally swiotlb was not performance critical because it was only
used for slow devices. But in some setups, like TDX/SEV confidential
guests, all IO has to go through swiotlb. Currently swiotlb only has a
single lock. Under high IO load with multiple CPUs this can lead to
significant lock contention on the swiotlb lock.

This patch adds child IO TLB mem support to resolve spinlock overhead
among device's queues. Each device may allocate IO tlb mem and setup
child IO TLB mem according to queue number. The number child IO tlb
mem maybe set up equal with device queue number and this helps to resolve
swiotlb spinlock overhead among devices and queues.

introduces IO TLB Block concepts and swiotlb_device_allocate()
API to allocate per-device swiotlb bounce buffer. The new API Accepts
queue number as the number of child IO TLB mem to set up device's IO
TLB mem.

Patch 2 calls new allocation function in the netvsc driver to resolve
global spin lock issue.

Tianyu Lan (2):
  swiotlb: Add Child IO TLB mem support
  net: netvsc: Allocate per-device swiotlb bounce buffer for netvsc

 drivers/net/hyperv/netvsc.c |  10 ++
 include/linux/swiotlb.h     |  38 +++++
 kernel/dma/swiotlb.c        | 299 ++++++++++++++++++++++++++++++++++--
 3 files changed, 334 insertions(+), 13 deletions(-)

-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
