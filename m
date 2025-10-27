Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03292D3A94
	for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583867; cv=none; b=r93YphucwHlUxUrfDOSkPr3zBfCcZGc8hntLje07ocPmqx1k79FW4eTpeFlgf97tmpGODbVf7hWdiHhOVV3z0uZryZ6ttCco4o58C+qhNzlBUAlDRBRJZa+yTRd7IE5oJMbsnnXSjRJKX6uEeN+YxmQaP6HmFsnOeMctmYXDkbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583867; c=relaxed/simple;
	bh=EqepgGC/l3BkBwlCg2C9JuMnjeSRmoKoLRq7E9G076I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzjyjYp9cLOK6PCV+bgOvdXCkkqUUNOZSJIzLv5DqAnOBQeH3nOUFA8RaLRFpzHv+bDd+KIkXwbzM1ITRkxdETZ9o/bsLyvYsdKmgwvHLJ1L8otDzE+WMmPduf/F1RjmcKx9leUmSi9lV2WkPipg3PJAqN6rf/YQgOKiPtZdW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AB5nHOgP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AB5nHOgP"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b553412a19bso3146129a12.1
        for <iommu@lists.linux.dev>; Mon, 27 Oct 2025 09:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761583864; x=1762188664; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nKP8LnlisYPvQbnTYeeSfnr4LDRpnlUnYi1OfgjBiU=;
        b=AB5nHOgPZ4UbIU1TNM0FyKuTWTM1TdWY73kEHQEYb1aYKlGVmY+1cUfRxT0rEm2T5F
         ji/BHkxNx9Gv89erGnJt6W6T43TqkjN3Qo4ABK67N0o170mc6Gl8Sy9epLBM+RayL2i1
         M/2QVVNyIGM0gep2CXktwFcJD9G4Uu4uTNPW2U39cE9lAUSPCqBnAN5cLHgV9vGFvq9j
         uPufSeT5I9cY0nLc8RTPHyNW0lOvkoUfIGeDW4xiI0QR4fmSby8MBYbzNF62sR2cIUMQ
         Rf9aYgs9KduGMBhSfifdynRdcbBNfx/+y8we6q+bj4B9ppEz0TFzjIgj7hXKLq2OXUf+
         03KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583864; x=1762188664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nKP8LnlisYPvQbnTYeeSfnr4LDRpnlUnYi1OfgjBiU=;
        b=V0rbKMcWv1AVQx3TP8NSCKSIy456QIV5GxkAUazcGdM7DDZpsf8et2sZMUc8tUpl21
         DZTm9/6KyjzVByiW8wHlfHYjCmucoIR0eFplLPJnHUyDn5XAMQWxln0Re4HR3rXWLMeT
         cu55fuHZRbSMvMSRjodTCat98ItKAdpic1RH/SHBYRheioyhf36qft2yTTp4ygG9tQeW
         ivks4elkJsIr3k89UmLmzKSk/EFQEBI8I9IXsd1X/kEjqWz3atUFZwiEmlYu0Koo9EIS
         E9D+5Hnh3JJkraJ/QOdAWmqLu526O347jd0FaHSK3BByC5lne5GW9wONJVtIwMFM1sT6
         xnnA==
X-Forwarded-Encrypted: i=1; AJvYcCUj6IEw2qs8iVEQP4wR13c5I5WbWET6p5cY2hWZrSQf4f1JxyEuWwBPrRDGUnAwgLsQwnuMDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw+SzYORDH9ZbfNugEPbBzm0BKXv6HFkMHYQk2zYr7Rfw/cW58U
	iEzaUPSubgUXMAraiIVvlBCED6MBidMerGzFuK72UaGRcpzW1KUVmEa7UmFzEv0z7lPzvDaIF4U
	Qc9U7
X-Gm-Gg: ASbGnctz5Xizd0lse6fw/ieDxIL+i71EzysoGAhB3sY6q7Qy0sE97MBK5k4a5jAH5js
	CCFjWxyBlkCDPRQhlWfwi6m7hDh3QR6bjT5JWDyUQSp5XAZ+OiZc3WsTvLuck2v8IwX+kSb/fr3
	Mfs4uD2oOC64Wdt8PB4U90Powl3LmzuCH+QNmfg22j5np9JYICq/opd+FTn/LwmX7jxV5W7E5tv
	f1u18oIdgSQTdlXvYgw5I1TJSdKkyggUJPZTNLVUMtVcFCV5siiAdozqvzq5UYFUFQduyFPAB/i
	EuZ+xb+tfTAox/VDUNJ8euKLrUmPgORlHkOOlVt2/ReNPCAz+6kjmpBiX4lt58hpz+HXEx0kjB0
	JPZyf1/5x6h1xZeVUE3fAhaPjH/7oa4qv7mCMSWlYXj513rWhM4XLDY70wvenbQjkDSspZadvlc
	LMmZphjXZggtSL3KDAhC0SFt0Ah1BT27W2aGKfydAxqLLe
X-Google-Smtp-Source: AGHT+IGjTdmlbc2UYCLdzv9SaAZWrdWKW4UkBxQqwzd5S6LRB2MyeaD63PJEhKAkXPLm5tJfWml8NA==
X-Received: by 2002:a17:902:b281:b0:269:8f0c:4d86 with SMTP id d9443c01a7336-294cb67176dmr3769265ad.53.1761583863479;
        Mon, 27 Oct 2025 09:51:03 -0700 (PDT)
Received: from 5CG3510V44-KVS.bytedance.net ([203.208.189.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70b5sm9075326a91.10.2025.10.27.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 09:51:02 -0700 (PDT)
From: Jinhui Guo <guojinhui.liam@bytedance.com>
To: joro@8bytes.org,
	suravee.suthikulpanit@amd.com
Cc: guojinhui.liam@bytedance.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RESEND PATCH] iommu/amd: Fix pci_segment memleak in alloc_pci_segment()
Date: Tue, 28 Oct 2025 00:50:17 +0800
Message-Id: <20251027165017.4189-1-guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
References: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix a memory leak of struct amd_iommu_pci_segment in alloc_pci_segment()
when system memory (or contiguous memory) is insufficient.

Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table")
Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---

Hi,

Just a friendly ping—resending the unchanged patch in case it got
buried. If there is anything I can do to ease review, please let me
know.

Thanks,
Jinhui

 drivers/iommu/amd/init.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ba9e582a8bbe..77afd5884984 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1608,13 +1608,22 @@ static struct amd_iommu_pci_seg *__init alloc_pci_segment(u16 id,
 	list_add_tail(&pci_seg->list, &amd_iommu_pci_seg_list);
 
 	if (alloc_dev_table(pci_seg))
-		return NULL;
+		goto err_free_pci_seg;
 	if (alloc_alias_table(pci_seg))
-		return NULL;
+		goto err_free_dev_table;
 	if (alloc_rlookup_table(pci_seg))
-		return NULL;
+		goto err_free_alias_table;
 
 	return pci_seg;
+
+err_free_alias_table:
+	free_alias_table(pci_seg);
+err_free_dev_table:
+	free_dev_table(pci_seg);
+err_free_pci_seg:
+	list_del(&pci_seg->list);
+	kfree(pci_seg);
+	return NULL;
 }
 
 static struct amd_iommu_pci_seg *__init get_pci_segment(u16 id,
-- 
2.20.1

