Return-Path: <SRS0=D+h4=F2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2002C433E0
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 18:14:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9EB22510
	for <iommu@archiver.kernel.org>; Tue, 22 Dec 2020 18:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9EB22510
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 978C086723;
	Tue, 22 Dec 2020 18:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZKN61CFe6AU6; Tue, 22 Dec 2020 18:14:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 90CF98698E;
	Tue, 22 Dec 2020 18:14:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73680C1825;
	Tue, 22 Dec 2020 18:14:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F4C1C0893
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 16:42:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4386785D72
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 16:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ysNhZCBTY5lB for <iommu@lists.linux-foundation.org>;
 Tue, 22 Dec 2020 16:42:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9F7FE85D6F
 for <iommu@lists.linux-foundation.org>; Tue, 22 Dec 2020 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608655361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=lrk6ItTLyfFFu92WG6dQ6R2YCLUBjao3+3CmL/ZZMi0=;
 b=LDUGiDYHiOTNFu/v1hF1ULFc2SPX/w+G+ZdkPCAgJZ9HzYoQPCJNP0dYUdhYSrTNwPonud
 WWr6hz4wT00F2rv4bghltooH2LUEuTb/tqxqydiGPaszI01EJWsVHhBxP9JDtDKrS4hoBv
 slpPZVV4W7msMc5EGsIOOHYdkePcbV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-loHxs7zkN8uHxuNKvdSgKg-1; Tue, 22 Dec 2020 11:42:36 -0500
X-MC-Unique: loHxs7zkN8uHxuNKvdSgKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60610107ACE8;
 Tue, 22 Dec 2020 16:42:35 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-112-116.ams2.redhat.com
 [10.36.112.116])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 14A185E1A8;
 Tue, 22 Dec 2020 16:42:33 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH] iommu/iova: fix 'domain' typos
Date: Tue, 22 Dec 2020 17:42:32 +0100
Message-Id: <20201222164232.88795-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mailman-Approved-At: Tue, 22 Dec 2020 18:14:16 +0000
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

Replace misspelled 'doamin' with 'domain' in several comments.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/iommu/iova.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4bb3293ae4d7..d20b8b333d30 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -358,7 +358,7 @@ static void private_free_iova(struct iova_domain *iovad, struct iova *iova)
  * @iovad: - iova domain in question.
  * @pfn: - page frame number
  * This function finds and returns an iova belonging to the
- * given doamin which matches the given pfn.
+ * given domain which matches the given pfn.
  */
 struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
@@ -601,7 +601,7 @@ void queue_iova(struct iova_domain *iovad,
 EXPORT_SYMBOL_GPL(queue_iova);
 
 /**
- * put_iova_domain - destroys the iova doamin
+ * put_iova_domain - destroys the iova domain
  * @iovad: - iova domain in question.
  * All the iova's in that domain are destroyed.
  */
@@ -712,9 +712,9 @@ EXPORT_SYMBOL_GPL(reserve_iova);
 
 /**
  * copy_reserved_iova - copies the reserved between domains
- * @from: - source doamin from where to copy
+ * @from: - source domain from where to copy
  * @to: - destination domin where to copy
- * This function copies reserved iova's from one doamin to
+ * This function copies reserved iova's from one domain to
  * other.
  */
 void
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
