Return-Path: <SRS0=d8dU=JF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0293FC433ED
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B755E61108
	for <iommu@archiver.kernel.org>; Thu,  8 Apr 2021 17:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B755E61108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D46F83AC6;
	Thu,  8 Apr 2021 17:14:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q-OI_5SNhNuc; Thu,  8 Apr 2021 17:14:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7694583AAD;
	Thu,  8 Apr 2021 17:14:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 518F1C000B;
	Thu,  8 Apr 2021 17:14:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F2ECC000A
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with UTF8SMTP id 40A7B4192B
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with UTF8SMTP id WmmwcNoAF6KB for <iommu@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 17:14:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by smtp4.osuosl.org (Postfix) with UTF8SMTPS id 5515040266
 for <iommu@lists.linux-foundation.org>; Thu,  8 Apr 2021 17:14:18 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1617902062; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pF54yaXGNjyAS94ctXcnMQoya1r6ZJemTSniWuZIrfg=;
 b=eXfOJN0uc7UeK4EOyxKsVte3LIJVY9WoNgwpF52sKeotyXbwrjMe0cw10gPqrkCM5IHESBnY
 b/hUoIotnZll6Iwqh2eO05UBp0zQo6ch28xmYcXPw4iMiX8gA00l0EWLKrXtpO8bVj1zgtQA
 /3TUDZtpUVnvJgDf1N8QmmcAn7o=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 606f39e1febcffa80f587f70 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 08 Apr 2021 17:14:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id DAE7AC43463; Thu,  8 Apr 2021 17:14:09 +0000 (UTC)
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: isaacm)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 121FCC43468;
 Thu,  8 Apr 2021 17:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 121FCC43468
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=fail smtp.mailfrom=isaacm@codeaurora.org
From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
To: iommu@lists.linux-foundation.org,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH v5 01/15] iommu/io-pgtable: Introduce unmap_pages() as a
 page table op
Date: Thu,  8 Apr 2021 10:13:48 -0700
Message-Id: <20210408171402.12607-2-isaacm@codeaurora.org>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210408171402.12607-1-isaacm@codeaurora.org>
References: <20210408171402.12607-1-isaacm@codeaurora.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>, robin.murphy@arm.com,
 will@kernel.org, pratikp@codeaurora.org
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

The io-pgtable code expects to operate on a single block or
granule of memory that is supported by the IOMMU hardware when
unmapping memory.

This means that when a large buffer that consists of multiple
such blocks is unmapped, the io-pgtable code will walk the page
tables to the correct level to unmap each block, even for blocks
that are virtually contiguous and at the same level, which can
incur an overhead in performance.

Introduce the unmap_pages() page table op to express to the
io-pgtable code that it should unmap a number of blocks of
the same size, instead of a single block. Doing so allows
multiple blocks to be unmapped in one call to the io-pgtable
code, reducing the number of page table walks, and indirect
calls.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/io-pgtable.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index a4c9ca2c31f1..2ed0c057d9e7 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -144,6 +144,7 @@ struct io_pgtable_cfg {
  *
  * @map:          Map a physically contiguous memory region.
  * @unmap:        Unmap a physically contiguous memory region.
+ * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
  * @iova_to_phys: Translate iova to physical address.
  *
  * These functions map directly onto the iommu_ops member functions with
@@ -154,6 +155,9 @@ struct io_pgtable_ops {
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
 	size_t (*unmap)(struct io_pgtable_ops *ops, unsigned long iova,
 			size_t size, struct iommu_iotlb_gather *gather);
+	size_t (*unmap_pages)(struct io_pgtable_ops *ops, unsigned long iova,
+			      size_t pgsize, size_t pgcount,
+			      struct iommu_iotlb_gather *gather);
 	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
 				    unsigned long iova);
 };
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
