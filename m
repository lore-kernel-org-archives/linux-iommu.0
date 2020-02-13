Return-Path: <SRS0=ZJ+1=4B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8535C3B188
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6CA217F4
	for <iommu@archiver.kernel.org>; Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXBaowXs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6CA217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4CB2F87ED9;
	Thu, 13 Feb 2020 10:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PVHw7gWslDVP; Thu, 13 Feb 2020 10:14:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AA72C87ED1;
	Thu, 13 Feb 2020 10:14:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DE1BC07FE;
	Thu, 13 Feb 2020 10:14:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2039C0177
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B02F483505
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OqA8-pJsCSQX for <iommu@lists.linux-foundation.org>;
 Thu, 13 Feb 2020 10:14:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D7F43834BE
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 10:14:45 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id n10so3972464wrm.1
 for <iommu@lists.linux-foundation.org>; Thu, 13 Feb 2020 02:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=75Ftdk1VkfsWCfyfd11tlv6ByY0EWRz2RXyuqWcTsCk=;
 b=MXBaowXsv5/KjGlJHGIVcJorZztVg4eKrM/0w4F0HaKMkhG7uZ2qpG0X5g06zIZ8KR
 JnvtB5DqxM5AgwN7+3b7Wzy/vFzqAreJ/+vi5VJzrqZ7NhUOdm/sjLs0apfmXzQOdYkf
 Os4dy5aCRHTv04//SmgM6n1wj/O42Jp8ACsQy+/eig82sByEXqlJhyFrDIIA/eGWwOXO
 1diY5LShRv4n2zK8u1QDFgf0OQ3NB/zGYXZyfr4uUbUEwvA7vOThvs8tguvgjdcGGU93
 ajPMjEjhiF4BL/q+Faw5CpisW0B6BCxtZnVvi+Ecuv97amlyxGaybdu2D6eh5DGwV4Lc
 GUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=75Ftdk1VkfsWCfyfd11tlv6ByY0EWRz2RXyuqWcTsCk=;
 b=qCWkD8vDqWQLV8bO68WgIpE3ljXDTAfGriC7/x18Q7h0lriCJqDqVXyuwAOa9zHZ4b
 27V88siRfvTn09JJ7/dLUhf4JLuJu+7Cj+nmEhF5mshWdkJ78eA6l/BnvEMkAfF1eX4D
 5kmnDCmLmCPcgtubeDMquCUhtQxJ11tbPf7i75dIR+k0lH30wFW7WVrrbHz5GXn66CNM
 I2e0gkVbmDQ+gboSs/wfqb1C489fHqsGUeSPliXkn7BORtOsjnwR/wktYxmvH7GyGxfw
 SBrKWQBdeGQk7HEOs/PEHChmeXwZ/hnpi1QfWNh2ybqgj5LkkSzgha0U4OVGbDyjxMog
 tsZw==
X-Gm-Message-State: APjAAAVkacmGSrGrlhCM5/w5tENt9aJgzbywMJLBTn1XbAwe0Uu+QhY+
 g0vW2RN51dcXbLALii0nkaJgiA==
X-Google-Smtp-Source: APXvYqyaY1njF+rZBaq9zhF3XVnI+fBQ+a+gjM1pwH0+xif4vevn+377YjCqBR53sPA0jLv2qnJW8w==
X-Received: by 2002:a05:6000:1:: with SMTP id
 h1mr19408168wrx.380.1581588884202; 
 Thu, 13 Feb 2020 02:14:44 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:2276:930:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y131sm2428059wmc.13.2020.02.13.02.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 02:14:43 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org, will@kernel.org, bhelgaas@google.com
Subject: [PATCH 0/4] iommu: Finish off PASID support for Arm SMMUv3
Date: Thu, 13 Feb 2020 11:14:31 +0100
Message-Id: <20200213101435.229932-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, robin.murphy@arm.com
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

Support for context descriptor tables was added to the SMMUv3 driver by
commit 87f42391f6a5 ("iommu/arm-smmu-v3: Add support for Substream
IDs"). The last patch enabling PASID in PCI devices couldn't be included
right away since it would have prevented from building SMMUv3 as a
module, another feature introduced in Linux v5.6. Export the relevant
symbols in patch 1 before using them in patch 2. Patches 3 and 4 address
the other remaining comments for the PASID series [1].

[1] https://lore.kernel.org/linux-iommu/20200114154007.GC2579@willie-the-truck/

Jean-Philippe Brucker (4):
  PCI/ATS: Export symbols of PASID functions
  iommu/arm-smmu-v3: Add support for PCI PASID
  iommu/arm-smmu-v3: Batch context descriptor invalidation
  iommu/arm-smmu-v3: Write level-1 descriptors atomically

 drivers/iommu/arm-smmu-v3.c | 78 +++++++++++++++++++++++++++++++++++--
 drivers/pci/ats.c           |  4 ++
 2 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.25.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
