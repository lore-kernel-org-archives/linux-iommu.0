Return-Path: <SRS0=H3NW=7Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F8FC433E7
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 22:29:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDE7C20801
	for <iommu@archiver.kernel.org>; Thu, 11 Jun 2020 22:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="s360jw6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDE7C20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C2B1D88F88;
	Thu, 11 Jun 2020 22:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gv69QhdIgkDe; Thu, 11 Jun 2020 22:29:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66A6988F87;
	Thu, 11 Jun 2020 22:29:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61A4FC0178;
	Thu, 11 Jun 2020 22:29:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EDA5C016F
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 22:29:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2B2FC88F87
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 22:29:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gz6trY8zIRYD for <iommu@lists.linux-foundation.org>;
 Thu, 11 Jun 2020 22:29:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 23662890BF
 for <iommu@lists.linux-foundation.org>; Thu, 11 Jun 2020 22:29:43 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1591914585; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=PQnTZkYVOn9g39XJGJ/Fc5lnyvhq0qe68meDTmbVWdk=;
 b=s360jw6u5bJpfd7R8HPvqxHHHn6I9GKDIGgWdNlhVtAgr0cHb837Dvl+232LjT45+xnoBg1m
 sHGWIxHa4/19nEDFImKvG+RjFQCtz7Rkf38QYsKqsyWiZUs3o+/CVaAfjQMkdjnNpxo0cprC
 XTGpSQ48Fqa2wHu5kXFGrpZuEew=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5ee2b04b8fe116ddd99a5836 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 22:29:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id C318DC433C8; Thu, 11 Jun 2020 22:29:30 +0000 (UTC)
Received: from jordan-laptop.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id B7CA5C433CB;
 Thu, 11 Jun 2020 22:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7CA5C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/6] iommu/io-pgtable: Allow a pgtable implementation to skip
 TLB operations
Date: Thu, 11 Jun 2020 16:29:17 -0600
Message-Id: <20200611222921.464-3-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200611222921.464-1-jcrouse@codeaurora.org>
References: <20200611222921.464-1-jcrouse@codeaurora.org>
Cc: Joerg Roedel <jroedel@suse.de>, Will Deacon <will@kernel.org>,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Allow a io-pgtable implementation to skip TLB operations by checking for
NULL pointers in the helper functions. It will be up to to the owner
of the io-pgtable instance to make sure that they independently handle
the TLB correctly.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 include/linux/io-pgtable.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
index 53d53c6c2be9..bbed1d3925ba 100644
--- a/include/linux/io-pgtable.h
+++ b/include/linux/io-pgtable.h
@@ -210,21 +210,24 @@ struct io_pgtable {
 
 static inline void io_pgtable_tlb_flush_all(struct io_pgtable *iop)
 {
-	iop->cfg.tlb->tlb_flush_all(iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_flush_all(iop->cookie);
 }
 
 static inline void
 io_pgtable_tlb_flush_walk(struct io_pgtable *iop, unsigned long iova,
 			  size_t size, size_t granule)
 {
-	iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_flush_walk(iova, size, granule, iop->cookie);
 }
 
 static inline void
 io_pgtable_tlb_flush_leaf(struct io_pgtable *iop, unsigned long iova,
 			  size_t size, size_t granule)
 {
-	iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
+	if (iop->cfg.tlb)
+		iop->cfg.tlb->tlb_flush_leaf(iova, size, granule, iop->cookie);
 }
 
 static inline void
@@ -232,7 +235,7 @@ io_pgtable_tlb_add_page(struct io_pgtable *iop,
 			struct iommu_iotlb_gather * gather, unsigned long iova,
 			size_t granule)
 {
-	if (iop->cfg.tlb->tlb_add_page)
+	if (iop->cfg.tlb && iop->cfg.tlb->tlb_add_page)
 		iop->cfg.tlb->tlb_add_page(gather, iova, granule, iop->cookie);
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
