Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F66C433E1
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 08:18:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6DB520759
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 08:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MOk2lX2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6DB520759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 931578841A;
	Tue, 30 Jun 2020 08:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5znxKhpTXzbA; Tue, 30 Jun 2020 08:18:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0D1518831E;
	Tue, 30 Jun 2020 08:18:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0944C088F;
	Tue, 30 Jun 2020 08:18:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D01FC016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2B04C860E6
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yb92o87PqC_b for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 08:18:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 799CA85F7E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:18:08 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200630081806euoutp028ebece3bc3857da5ac13cd52290ae30b~dRG8B-vgt2015920159euoutp02q
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 08:18:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200630081806euoutp028ebece3bc3857da5ac13cd52290ae30b~dRG8B-vgt2015920159euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1593505086;
 bh=RWG/PR/gBUqd8f+OZR74giIFbhfefll6k6y1Sbjhgps=;
 h=From:To:Cc:Subject:Date:References:From;
 b=MOk2lX2wgtOq1GMB2CN33JB4b59W3TGL7xDSdyqBCAaGzIo79jknsWyFOK78IMWLJ
 6rkmAjENkkFdQSU6FVzvwpRH6Kdm2upVemhamR6Z1EX6DOeFcY5FD2fjDRuD6CHpuD
 DIQmPVrUUH6xwPCvw3reYD2aNvMHLlgOXWdKtYAg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200630081806eucas1p1ad6ce83af09e1a83a003d6f711376f14~dRG7yb_1m2671126711eucas1p1x;
 Tue, 30 Jun 2020 08:18:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 31.CF.06456.E35FAFE5; Tue, 30
 Jun 2020 09:18:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200630081806eucas1p2a9a0ecae69dfe3306092aff30e21cb5c~dRG7iYQ4Y1608216082eucas1p2z;
 Tue, 30 Jun 2020 08:18:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200630081806eusmtrp106d065c6596320eab0f44e0df896ab41~dRG7hysVX0327103271eusmtrp10;
 Tue, 30 Jun 2020 08:18:06 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-68-5efaf53e2d35
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id FE.9C.06017.E35FAFE5; Tue, 30
 Jun 2020 09:18:06 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200630081805eusmtip29437a87f9578340dd994fc55bba24247~dRG7LSvNX2950629506eusmtip2W;
 Tue, 30 Jun 2020 08:18:05 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iommu: move sg_table wrapper out of CONFIG_IOMMU_SUPPORT
Date: Tue, 30 Jun 2020 10:17:56 +0200
Message-Id: <20200630081756.18526-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VRa0hTYRjm2znbzkarr83yTcNqqZiQNjIYzaSsYP3JhEBKvKw8qOmm7Khl
 QUjJzGkhmWRqIhYpyua8ME2LckkLV2POSwaVXaEClTTz7vJ41P49V56X76MI6QjpQ6Xqsmi9
 TpMuF4hJ68tZ596Iqbn4fV0Ptimby5v4yppnKmVhpUWo7O+sEihNPR+Eh/nqb93VPHXpcB1S
 32prQOrJFr9T5FlxeBKdnppD60MjEsUpg9ZFYeZ72aXplgGUh6zYiEQU4DD4vjQjNCIxJcX1
 COo6engc+YNgyOXic2QSgan9C3+t4u4z8FgsxXUI5qo3rTfGfpeRrCHACjCOGgVGRFFeOBL6
 7+1kMwQuQOCZbl3JyPAJ8Aw5hSwmcQCUdzUSLJbgQ+B8MU9wYzug0fKcYMuAnwigd75p1TgG
 3dUzAg7L4Je9Tcjh7eAoLSa5wnUEn50mIUeKEfRfK0dcSgXvnXMr5xF4DzR1hnLyERh7/RCx
 MuCNMDy6mZWJZXjbepfgZAncMEi5dCBU2M3rs90u9+ppaugqquRzDxQHr3rv8EqQX8X/rRqE
 GpA3nc1ok2lGoaMvhjAaLZOtSw45n6FtQcvf7liyT3SgKfc5G8IUkm+QJDpn46V8TQ6Tq7Uh
 oAi5lyTyjSNeKknS5F6m9RkJ+ux0mrEhX4qUe0v21/6Mk+JkTRadRtOZtH7N5VEinzxkEXuK
 owa2OvpUMa2dDfeT3OKrjwNa/Quf7p7oM7THKBYE796KgkTOg+bJMhx9RvI1P9jQeGDQWkpr
 Psaelh2PqhzflUnUtqlIO+EZCLsgD3/kuRL7wzVV4ttxc6TZlD9bn1CUu7A4Pn2yx2JbqArC
 W8zRfz8VBJT4H00LNFvlJJOiUQQTekbzD/kjcn3yAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsVy+t/xe7p2X3/FGSy8zG6xccZ6VosF+60t
 OmdvYLe4vGsOm8XaI3fZHVg9nhycx+Qx+cZyRo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFV
 ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuLrtL3vBHeGK75uuMDYwbhPo
 YuTkkBAwkbh0sY2pi5GLQ0hgKaNE278WZoiEjMTJaQ2sELawxJ9rXWwQRZ8YJZben8kIkmAT
 MJToeguS4OQQEXCR+LB5JdgkZoFORomJM3aDTRIW8JT4f+0cO4jNIqAqMWP3arA4r4CtxLnD
 v6G2yUus3nCAeQIjzwJGhlWMIqmlxbnpucVGesWJucWleel6yfm5mxiBYbbt2M8tOxi73gUf
 YhTgYFTi4U049zNOiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYGWT2SW
 Ek3OB8ZAXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKYPiYOTqkGxmsNla8Z
 /bLuMxcql81t+PvDUCSv/2ZZtRS7yNpK2z+Tg6yCvh0Uejrd3JijfM6qebL11h4HhI7te7hK
 R7RP+X2l4jaXt+6huvOW3bojzx6QL7Sotyd8qx3fksK22HXfJx0ROp+2tm/Ghnd6f65u5TDx
 +W9r9XZijY5eyrXXvCu+WJl++qBqrMRSnJFoqMVcVJwIAEe7axhJAgAA
X-CMS-MailID: 20200630081806eucas1p2a9a0ecae69dfe3306092aff30e21cb5c
X-Msg-Generator: CA
X-RootMTR: 20200630081806eucas1p2a9a0ecae69dfe3306092aff30e21cb5c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200630081806eucas1p2a9a0ecae69dfe3306092aff30e21cb5c
References: <CGME20200630081806eucas1p2a9a0ecae69dfe3306092aff30e21cb5c@eucas1p2.samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

Move the recently added sg_table wrapper out of CONFIG_IOMMU_SUPPORT to
let the client code copile also when IOMMU support is disabled.

Fixes: 48530d9fab0d ("iommu: add generic helper for mapping sgtable objects")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 include/linux/iommu.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5f0b7859d2eb..5657d4fef9f2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -457,22 +457,6 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t io
 extern void iommu_set_fault_handler(struct iommu_domain *domain,
 			iommu_fault_handler_t handler, void *token);
 
-/**
- * iommu_map_sgtable - Map the given buffer to the IOMMU domain
- * @domain:	The IOMMU domain to perform the mapping
- * @iova:	The start address to map the buffer
- * @sgt:	The sg_table object describing the buffer
- * @prot:	IOMMU protection bits
- *
- * Creates a mapping at @iova for the buffer described by a scatterlist
- * stored in the given sg_table object in the provided IOMMU domain.
- */
-static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
-			unsigned long iova, struct sg_table *sgt, int prot)
-{
-	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
-}
-
 extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
 extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
 extern void generic_iommu_put_resv_regions(struct device *dev,
@@ -1079,6 +1063,22 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 }
 #endif /* CONFIG_IOMMU_API */
 
+/**
+ * iommu_map_sgtable - Map the given buffer to the IOMMU domain
+ * @domain:	The IOMMU domain to perform the mapping
+ * @iova:	The start address to map the buffer
+ * @sgt:	The sg_table object describing the buffer
+ * @prot:	IOMMU protection bits
+ *
+ * Creates a mapping at @iova for the buffer described by a scatterlist
+ * stored in the given sg_table object in the provided IOMMU domain.
+ */
+static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
+			unsigned long iova, struct sg_table *sgt, int prot)
+{
+	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
+}
+
 #ifdef CONFIG_IOMMU_DEBUGFS
 extern	struct dentry *iommu_debugfs_dir;
 void iommu_debugfs_setup(void);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
