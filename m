Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB7EC433EF
	for <iommu@archiver.kernel.org>; Fri, 31 Dec 2021 16:56:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 077D640126;
	Fri, 31 Dec 2021 16:56:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iylm1SGnOlNh; Fri, 31 Dec 2021 16:56:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8ADD140120;
	Fri, 31 Dec 2021 16:56:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61BDCC002F;
	Fri, 31 Dec 2021 16:56:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 337ADC0012
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 16:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2011060ACD
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 16:56:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ngmgvnF-0mJf for <iommu@lists.linux-foundation.org>;
 Fri, 31 Dec 2021 16:56:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 93079605E8
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 16:56:50 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id l16so8415844plg.10
 for <iommu@lists.linux-foundation.org>; Fri, 31 Dec 2021 08:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Fhqsai9/5uTpmhu9BCUGRv/iOpwY1XebeAJzkMmetAg=;
 b=DTTANcgQxP/+d+SIfU7vQgtLwKl7eY50ftYhrvl9vSh6Hu0HYf2iigJ3RKtoyq23sj
 gRii9H+9YyK62wyllPKWLhPo3BegEtpX6Yg3ZHXeUdvoOw0sH/I84xuypATf+fMk8LBH
 O4lBZrdOFmhBJQPp2875HXZ0ZVQblWDDurWrkXhIP5fG+QM8vpMSh7BpJwiVB1IQDsJg
 4m3w6u6gZPWBzgqiTJNinwfqTuL1w2cnMa/rTYP2hWmAH6sPVcVqosaxqYQSH5GxqZet
 xeSf1JN5N2AE76YbEuqRaWdJ/ngfTjedQ98lpvwYnHxRUFlTeLb3fXRkGObrPqaiDrK6
 4bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Fhqsai9/5uTpmhu9BCUGRv/iOpwY1XebeAJzkMmetAg=;
 b=B92GNe4G1ktki89vY8t3G1BWedKM9U8Uw7QYEdj9UvXgvX98TW2hV4ngLvYJnT88lD
 K7wJXosEfVo5V9+kl/yjrpIgtkaqx6bq2gJaQMY/SD4Vu2K5uzvmBG31x4EfsVnljVa4
 S31cOhfEy9YjrYLKC7Op5w0HsLAUF313r+Jmd67JubRJ13jYF//3y0LYOerRa+0Gqsrn
 aT7MZfdnV9xRBzxzSqmOqzboMX2WvvEVxuZqmSezp7Deb1f0Nwz/lXf2hwdWy22phDdr
 atISbNPxZfHU+cu7ohg+zfTI4V5ItfavBiiPlqz1GA/0HHwiSpddmNAv169yl00akIDU
 8yrg==
X-Gm-Message-State: AOAM531mXSJEw2d0JFv0/O4cTLdaChmfOfEjlF5KCNcB601LPj8PMUhy
 5qZr3lbkYKC6yqwX1og6cyU=
X-Google-Smtp-Source: ABdhPJxbh1vyPADNysAidGV2ytIAgoJ8tmJoKQuoiBd2eBUqHzHGm5J35dSdoI4BZhj0Nw+Z6BHyhQ==
X-Received: by 2002:a17:902:8d8c:b0:149:4497:faab with SMTP id
 v12-20020a1709028d8c00b001494497faabmr36204345plo.161.1640969809949; 
 Fri, 31 Dec 2021 08:56:49 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com
 ([2001:4898:80e8:b:18dd:5111:d391:607b])
 by smtp.gmail.com with ESMTPSA id mh3sm35188026pjb.26.2021.12.31.08.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Dec 2021 08:56:49 -0800 (PST)
From: Tianyu Lan <ltykernel@gmail.com>
To: hch@infradead.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
 michael.h.kelley@microsoft.com, kys@microsoft.com
Subject: [PATCH] Swiotlb: Add CONFIG_HAS_IOMEM check around memremap() in the
 swiotlb_mem_remap()
Date: Fri, 31 Dec 2021 11:56:40 -0500
Message-Id: <20211231165640.1245751-1-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: parri.andrea@gmail.com, thomas.lendacky@amd.com, wei.liu@kernel.org,
 Tianyu Lan <Tianyu.Lan@microsoft.com>, kernel test robot <lkp@intel.com>,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, brijesh.singh@amd.com, vkuznets@redhat.com,
 hch@lst.de
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

HAS_IOMEM option may not be selected on some platforms(e.g, s390) and this
will cause compile error due to miss memremap() implementation. Fix it via
adding HAS_IOMEM check around memremap() in the swiotlb.c.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 kernel/dma/swiotlb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index b36c1cdd0c4f..3de651ba38cc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -167,6 +167,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 {
 	void *vaddr = NULL;
 
+#ifdef CONFIG_HAS_IOMEM
 	if (swiotlb_unencrypted_base) {
 		phys_addr_t paddr = mem->start + swiotlb_unencrypted_base;
 
@@ -175,6 +176,7 @@ static void *swiotlb_mem_remap(struct io_tlb_mem *mem, unsigned long bytes)
 			pr_err("Failed to map the unencrypted memory %pa size %lx.\n",
 			       &paddr, bytes);
 	}
+#endif
 
 	return vaddr;
 }
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
