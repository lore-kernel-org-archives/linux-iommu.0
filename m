Return-Path: <SRS0=b5RZ=T4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516B3C04AB6
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 21:32:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C4F2053B
	for <iommu@archiver.kernel.org>; Tue, 28 May 2019 21:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y4ConJGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C4F2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D4D912357;
	Tue, 28 May 2019 21:32:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C51612279
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 21:31:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
	[209.85.222.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 33B467D2
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 21:31:03 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id m18so72386qki.8
	for <iommu@lists.linux-foundation.org>;
	Tue, 28 May 2019 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=WaEhEdCDX7uVq9EdlB8MxNmxyl6leWtk/aFuLl2SSoI=;
	b=Y4ConJGHbioYv9N8Mp37Mj8nKajpa5ftjec2jpdjMUbE27zB3Tu7iMV1rU3diBPTtJ
	M8VPPdZZogxpMM7rutYD3+rpwFECxAYTGVoAjXcIUtqaQjdlLUbzSRbbRh+Z7t0xlDd6
	EcxoA1KiFZKpjVfAas/YfbwO0+IpPbLqlbnhGL7UlP5cJdXcmF98E7M7ScQPtCpj02qh
	4u+A45QoHERFkt1mES+PfsKkbzkFct8oYodaFXg4b6H6rTC9cNjE1rodn7BxT+HAH1fW
	PA9Mgm+QPz8NRecEbMvD9qIJT/RI7ToVft4fSarxQ9hDovoTYpnkNFco6/p3jlyh3kYh
	l/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=WaEhEdCDX7uVq9EdlB8MxNmxyl6leWtk/aFuLl2SSoI=;
	b=TNDh1wDTcSE1RZ+52WsF+KGfaeneR1ByikYM2atPEPgWuMI781kkNP+1kNCLAfngSx
	rQ9BIGgw+8HpEFSOl0h4GDJDldPi0ydCSgM+6uScGMK/UeOZ93sisR0A9VM/ezBIMzsG
	JMTqqQbY/wKD+5iy34XiVppuGR2/c/sGIHnrb+H15a9L9TYsupKEIRXt4+nY32QQfzXa
	RVWRE1dJ77PaRSuYFc9X1xmJx/4yZiVfbzRChmlrDfyKzZP88fSP0lTf6H8sAydem2UL
	hnG/sNZHrr0FxMlO9eSKZtSg/NsZuxwSK0+CyeDC7nYtnTTsZAMr+2MbNCZpoNg8Lhod
	r/YQ==
X-Gm-Message-State: APjAAAX6nyywYbcQxMGHXLg95AtYYbgm1gM5hUzW+gYlUYhrBErnAx+b
	Qa8jSP3lyv3mo9Qags6m4oeRMg==
X-Google-Smtp-Source: APXvYqxV1hnwlMudTqV/qXWNvA3YNO35Xwlomr1L0uUD4+Itqbe5e4yQQHoskQMtRgPPNjLXahIUOQ==
X-Received: by 2002:a37:a854:: with SMTP id r81mr12066985qke.53.1559079062257; 
	Tue, 28 May 2019 14:31:02 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
	by smtp.gmail.com with ESMTPSA id 6sm4669423qtt.72.2019.05.28.14.31.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 14:31:01 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Subject: [PATCH] dma: replace single-char identifiers in macros
Date: Tue, 28 May 2019 17:30:41 -0400
Message-Id: <1559079041-525-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
	robin.murphy@arm.com, hch@lst.de
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

There are a few macros in DMA have single-char identifiers make the code
hard to read. Replace them with meaningful names.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/dma-mapping.h | 24 ++++++++++++++++--------
 include/linux/dmar.h        | 14 ++++++++------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 6309a721394b..2f0151dcfa4e 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -602,14 +602,22 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 	return dma_sync_single_for_device(dev, addr + offset, size, dir);
 }
 
-#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
-#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
-#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
-#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
-#define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
-#define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
-#define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
-#define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
+#define dma_map_single(dev, ptr, size, direction)			\
+	dma_map_single_attrs(dev, ptr, size, direction, 0)
+#define dma_unmap_single(dev, addr, size, direction)			\
+	dma_unmap_single_attrs(dev, addr, size, direction, 0)
+#define dma_map_sg(dev, sg, mapped_ents, direction)			\
+	dma_map_sg_attrs(dev, sg, mapped_ents, direction, 0)
+#define dma_unmap_sg(dev, sg, mapped_ents, direction)			\
+	dma_unmap_sg_attrs(dev, sg, mapped_ents, direction, 0)
+#define dma_map_page(dev, page, offset, size, direction)		\
+	dma_map_page_attrs(dev, page, offset, size, direction, 0)
+#define dma_unmap_page(dev, addr, size, direction)			\
+	dma_unmap_page_attrs(dev, addr, size, direction, 0)
+#define dma_get_sgtable(dev, sgt, cpu_addr, dma_addr, size)		\
+	dma_get_sgtable_attrs(dev, sgt, cpu_addr, dma_addr, size, 0)
+#define dma_mmap_coherent(dev, vma, cpu_addr, dma_addr, size)		\
+	dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, 0)
 
 extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index f8af1d770520..eb634912f475 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -104,12 +104,14 @@ static inline bool dmar_rcu_check(void)
 
 #define	dmar_rcu_dereference(p)	rcu_dereference_check((p), dmar_rcu_check())
 
-#define	for_each_dev_scope(a, c, p, d)	\
-	for ((p) = 0; ((d) = (p) < (c) ? dmar_rcu_dereference((a)[(p)].dev) : \
-			NULL, (p) < (c)); (p)++)
-
-#define	for_each_active_dev_scope(a, c, p, d)	\
-	for_each_dev_scope((a), (c), (p), (d))	if (!(d)) { continue; } else
+#define for_each_dev_scope(devs, cnt, i, tmp)				\
+	for ((i) = 0; ((tmp) = (i) < (cnt) ?				\
+	    dmar_rcu_dereference((devs)[(i)].dev) : NULL, (i) < (cnt)); \
+	    (i)++)
+
+#define for_each_active_dev_scope(devs, cnt, i, tmp)			\
+	for_each_dev_scope((devs), (cnt), (i), (tmp))			\
+		if (!(tmp)) { continue; } else
 
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
