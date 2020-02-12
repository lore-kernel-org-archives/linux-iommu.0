Return-Path: <SRS0=qRzs=4A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99769C2BA83
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 13:44:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4D620659
	for <iommu@archiver.kernel.org>; Wed, 12 Feb 2020 13:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZDlKb8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4D620659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2B8CD85D61;
	Wed, 12 Feb 2020 13:44:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nQ3pys3QFoOr; Wed, 12 Feb 2020 13:44:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 62AB085D3F;
	Wed, 12 Feb 2020 13:44:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4A9C0C07FE;
	Wed, 12 Feb 2020 13:44:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9047C0177
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:44:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A543A8669F
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s8DnHVUcpnhR for <iommu@lists.linux-foundation.org>;
 Wed, 12 Feb 2020 13:44:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com
 [209.85.219.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id EBA1F8671A
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 13:44:00 +0000 (UTC)
Received: by mail-yb1-f196.google.com with SMTP id b141so1066877ybg.10
 for <iommu@lists.linux-foundation.org>; Wed, 12 Feb 2020 05:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
 :content-transfer-encoding;
 bh=rgnLcOWtBG7HmNFyjA8xmyYMT1AlY0pRvxs1/WLvyMQ=;
 b=CZDlKb8sMfjdD8cyZVlg48ZpXDyUM7tS4WYvHuJCP1q8F4nxvJ5d8ksvSRzmvyzH5S
 XM3bfmn6RZvzRHZ1+1s+fZpQzMU7YV7oA5SPnX54cgT43bOLKr7YMTauG0vEDgzckwyo
 i06mDuAAOBuJI83tH819CoZiBbwzwH+J2ziofgA+J1/Dck3EBWjDHshfp/NwpL7iLkix
 BMvYhAKS2QQh6YO/4oMLk0Ao0eCXUSru6A6c6C1cpVwy/YYm6IbHsVS+EtGUa7Pw+PO1
 v2nFzJ4YWiY5yOfkev1j4vKV0oEMzmdx4DDKFjefhT3ulJpkw3TRA/acTmmy7uyJeGth
 54Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
 :user-agent:mime-version:content-transfer-encoding;
 bh=rgnLcOWtBG7HmNFyjA8xmyYMT1AlY0pRvxs1/WLvyMQ=;
 b=bQggARZCKtFDIuhne5v3HLi1LGxxTMMdh5my/m/bFwiN+ax6ltoFI/XZbZrDodo4y3
 QwNty9wKlf4Xk1wsXlWLET0bxpTtSPbmjWH7jEekdBUh0Alz0LsD0/oRh2POJQehm8SF
 SsoUogf/5bO7Q5RqLly+KrgGIEIvTi4WXkGQ061ItFcqR/bTTXBWE92NAqLPkh76cpEC
 8o3RS60HhBJAcwSkfZ9mAVYjlOkT2gWoMDlHn3nrY4uM9W+wc8CNL6AlJt1KQK5isyRW
 90H1lDzQ/c9hhG+YKVF8J6vNlPh2t/YHV0dFpfVKCeQwZgfZOC+Jd1gHN2Wr/2shOfDV
 MVMQ==
X-Gm-Message-State: APjAAAX4Z0WFljb/eOQu8sOS+H89qRmA1NM2Ng/OncrnucZQaHUTIUNP
 VdWmN9m5+B3odKHeCdGLYI8=
X-Google-Smtp-Source: APXvYqwt4z5HURrT2jThj6VGGkhDoQ0o5YnLK6cuBi3g1HRh740JQAAT7rq0AXnPOrpkFmQgMTKk3Q==
X-Received: by 2002:a05:6902:709:: with SMTP id
 k9mr11385084ybt.121.1581515040074; 
 Wed, 12 Feb 2020 05:44:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net.
 [68.61.232.219])
 by smtp.gmail.com with ESMTPSA id p6sm177786ywi.63.2020.02.12.05.43.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Feb 2020 05:43:59 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
 by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01CDhuSb021777;
 Wed, 12 Feb 2020 13:43:57 GMT
Subject: [PATCH v2] xprtrdma: Fix DMA scatter-gather list mapping imbalance
From: Chuck Lever <chuck.lever@oracle.com>
To: andre@tomt.net
Date: Wed, 12 Feb 2020 08:43:56 -0500
Message-ID: <158151473332.515306.1111360128438553868.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Cc: linux-nfs@vger.kernel.org, iommu@lists.linux-foundation.org
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

The @nents value that was passed to ib_dma_map_sg() has to be passed
to the matching ib_dma_unmap_sg() call. If ib_dma_map_sg() choses to
concatenate sg entries, it will return a different nents value than
it was passed.

The bug was exposed by recent changes to the AMD IOMMU driver, which
enabled sg entry concatenation.

Looking all the way back to 4143f34e01e9 ("xprtrdma: Port to new
memory registration API") and reviewing other kernel ULPs, it's not
clear that the frwr_map() logic was ever correct for this case.

Reported-by: Andre Tomt <andre@tomt.net>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |    6 ++++--
 net/sunrpc/xprtrdma/frwr_ops.c |   13 +++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

Hi Andre, here's take 2, based on the trace data you sent me.
Please let me know if this one fares any better.

Changes since v1:
- Ensure the correct nents value is passed to ib_map_mr_sg
- Record the mr_nents value in the MR trace points

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c0e4c93324f5..023c5da45999 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -275,6 +275,7 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
 
 	TP_STRUCT__entry(
 		__field(const void *, mr)
+		__field(unsigned int, nents)
 		__field(u32, handle)
 		__field(u32, length)
 		__field(u64, offset)
@@ -283,14 +284,15 @@ DECLARE_EVENT_CLASS(xprtrdma_mr,
 
 	TP_fast_assign(
 		__entry->mr = mr;
+		__entry->nents = mr->mr_nents;
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
 		__entry->offset = mr->mr_offset;
 		__entry->dir    = mr->mr_dir;
 	),
 
-	TP_printk("mr=%p %u@0x%016llx:0x%08x (%s)",
-		__entry->mr, __entry->length,
+	TP_printk("mr=%p %d %u@0x%016llx:0x%08x (%s)",
+		__entry->mr, __entry->mr_nents, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
 		xprtrdma_show_direction(__entry->dir)
 	)
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 095be887753e..75617646702b 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -288,8 +288,8 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 {
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct ib_reg_wr *reg_wr;
+	int i, n, dma_nents;
 	struct ib_mr *ibmr;
-	int i, n;
 	u8 key;
 
 	if (nsegs > ia->ri_max_frwr_depth)
@@ -313,15 +313,16 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 			break;
 	}
 	mr->mr_dir = rpcrdma_data_dir(writing);
+	mr->mr_nents = i;
 
-	mr->mr_nents =
-		ib_dma_map_sg(ia->ri_id->device, mr->mr_sg, i, mr->mr_dir);
-	if (!mr->mr_nents)
+	dma_nents = ib_dma_map_sg(ia->ri_id->device, mr->mr_sg,
+				  mr->mr_nents, mr->mr_dir);
+	if (!dma_nents)
 		goto out_dmamap_err;
 
 	ibmr = mr->frwr.fr_mr;
-	n = ib_map_mr_sg(ibmr, mr->mr_sg, mr->mr_nents, NULL, PAGE_SIZE);
-	if (unlikely(n != mr->mr_nents))
+	n = ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL, PAGE_SIZE);
+	if (n != dma_nents)
 		goto out_mapmr_err;
 
 	ibmr->iova &= 0x00000000ffffffff;


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
