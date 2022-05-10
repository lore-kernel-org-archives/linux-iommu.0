Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477A3C433F5
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 14:21:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E8E254013E;
	Tue, 10 May 2022 14:21:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TZYUMEVXLLyY; Tue, 10 May 2022 14:21:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C0E9C40AE8;
	Tue, 10 May 2022 14:21:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94131C0032;
	Tue, 10 May 2022 14:21:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51408C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 14:21:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3039660FD2
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 14:21:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XSoX4SskrBcu for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 14:21:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9033A60FCB
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 14:21:17 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id q76so14736160pgq.10
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C/+VFEBe/LSPrTXVeYivM+3OUMTgtuIGywMyZxhof3k=;
 b=O6L52kFHagR46TJPmGCxbhTD7MAV7fRTV88+fu1qZh1PExXXRlTvUD8pwrqgsK1CoA
 6pQrsxXG/Ex/lsGUHN7nwxR1VOR5hGDzwetXGkCxfKRcJ+DgqVj1KspjlaUIBg7bB8oU
 tHB4VF8+qxlxUsBuPiYrg8ijAOb31n+sx64wgYOpqZEImZl2QiXSbMeqP9wyRe1jTKmi
 jsv7v1eED4sOxITiEBM8h8d7xZkNV2jNcnGFeFBwN1QJdS/7yhUfYf3ZmEVvM+UmfMps
 QBcfB7v6uPUEldWhB0LYC/mu6FWEIC2mA3hgWxuXXeF0c9jwq475Wsqqrv+oAnvkzf8H
 cEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=C/+VFEBe/LSPrTXVeYivM+3OUMTgtuIGywMyZxhof3k=;
 b=k3ggyz07x2HyQ7fKJSRQ2CjTM/Q4p/wFIcQ/zIwUnFeFOZnDQXCnC8V5V6HDYg3LwD
 YcpcjWa1TqvqA8A+mxo+Lo4IIsXluyXj7dBjoBx8FBtBJD2tKzgFJAishRaZxnN3oYad
 fkEikdhIBAwFp+/y5gLHQU1qbZ1a0uiFN3Y5Tqi7O0jQiiwRS9891+hel1gN7Iqe96fq
 2ungd/cES0jWCGxea7w++rzvdgOvVA26z/0F4s0mhcDbJHwpyCCASNAHWN/VAo8J0FgC
 /qVGyWif2gaf0oKt2K/mZ6p+ZnZjP3ou05N0CL0Gya2QVFZQ/QyaaUtBcZZpwhXyjd/r
 2a0Q==
X-Gm-Message-State: AOAM531CeCcnJ4pFA32wQ8xEU1L1at2I8KQfwZGUxJNI1by6suKjuzQG
 9wRhx5x1AZlkEL9TTT+ACJE=
X-Google-Smtp-Source: ABdhPJy97bolhJvIHOqV7+NcNzzrZ2GCZ5C6CuQaXVigvumxvAKUDd/RIyzO41HHMysQeVCx64xC2Q==
X-Received: by 2002:a05:6a00:1acf:b0:50e:1872:c6b1 with SMTP id
 f15-20020a056a001acf00b0050e1872c6b1mr20763004pfv.76.1652192476948; 
 Tue, 10 May 2022 07:21:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:0:6c3c:3386:3925:381a])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a62e710000000b0050dc76281d8sm11031647pfh.178.2022.05.10.07.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 07:21:16 -0700 (PDT)
From: Tianyu Lan <ltykernel@gmail.com>
To: kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com, hch@infradead.org, m.szyprowski@samsung.com,
 robin.murphy@arm.com, michael.h.kelley@microsoft.com
Subject: [PATCH] swiotlb: Max mapping size takes min align mask into account
Date: Tue, 10 May 2022 10:21:09 -0400
Message-Id: <20220510142109.777738-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com,
 linux-hyperv@vger.kernel.org, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 linux-scsi@vger.kernel.org, konrad.wilk@oracle.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 vkuznets@redhat.com, hch@lst.de
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

swiotlb_find_slots() skips slots according to io tlb aligned mask
calculated from min aligned mask and original physical address
offset. This affects max mapping size. The mapping size can't
achieve the IO_TLB_SEGSIZE * IO_TLB_SIZE when original offset is
non-zero. This will cause system boot up failure in Hyper-V
Isolation VM where swiotlb force is enabled. Scsi layer use return
value of dma_max_mapping_size() to set max segment size and it
finally calls swiotlb_max_mapping_size(). Hyper-V storage driver
sets min align mask to 4k - 1. Scsi layer may pass 256k length of
request buffer with 0~4k offset and Hyper-V storage driver can't
get swiotlb bounce buffer via DMA API. Swiotlb_find_slots() can't
find 256k length bounce buffer with offset. Make swiotlb_max_mapping
_size() take min align mask into account.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 kernel/dma/swiotlb.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 73a41cec9e38..0d6684ca7eab 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -743,7 +743,18 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 
 size_t swiotlb_max_mapping_size(struct device *dev)
 {
-	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
+	int min_align_mask = dma_get_min_align_mask(dev);
+	int min_align = 0;
+
+	/*
+	 * swiotlb_find_slots() skips slots according to
+	 * min align mask. This affects max mapping size.
+	 * Take it into acount here.
+	 */
+	if (min_align_mask)
+		min_align = roundup(min_align_mask, IO_TLB_SIZE);
+
+	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE - min_align;
 }
 
 bool is_swiotlb_active(struct device *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
