Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413873;
	b=KKtxzIxTa5Knok+m5zWVueV/nvBe7flD3vM7joRBYZ8jvwNm+4ogcX+RjRFEnQY5kv1t
	 ZxWrMrbxuiGVVurxqDATix9uerkJIwQfzdR9oF8mFWlPXnJbRz9ocozbqTZvAHqi45IZe
	 /VCH+I7LVPQl+yt4MHH9GdL8Z7ZI8X7owLK36sxVb3B1SWEIS8puuX1iAdiQF9KNfi1gn
	 Km0KmVLVDH/BNiov2E936+j7o/3cOwdu/F4er5WmVLYL9Bm27mKQXVTvNCiln32PWYU3B
	 Ou0eklBSu0m0TlGa2cTUQv10vnaFitQcZHz+HNAmFx4ORBZk+V/IhdSup9azQtRU1/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GVQ2P8AWX362fj3fL2PAz+/e6GDEOziBkBiUeIWv0MY=;
	b=KQZ+L3AnrlK8rEQZV+tClMKLGoXJB/xAW9vDQrK4ddN/aoqKcVtF1ZI2dAFLwqD0bz9f
	 mvJkOUM4wZiyKxoUfjspXP/PDZntHDuStt5Ct6QsoQJrswspUY5A/EYK2ZS2CePy+m+Bf
	 cLQhOufwvJx7t0Yr6HeodDVYZrQZEWX5SRgzvMMRIaDA2yan9pMIL8cQNQUxcL7z4u57L
	 beEqVZb9VIPJSqHZVDui08rqZvLZF0Cl3+KolKP3/z3qWnc4SiY6ctrss7018ly8H4hGX
	 glB6SqSRmcxm5A653cKda1hVFaEOEEc83BIXCiP9VvzmrXvECOKQ6dwqWNU0pdzOrNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMAAKigP;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C3606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 06:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C5C3606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TMAAKigP
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-862bb0a189aso1326749a34.1
        for <iommu@lists.linux.dev>; Sun, 22 Nov 2026 22:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795413871; x=1796018671; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GVQ2P8AWX362fj3fL2PAz+/e6GDEOziBkBiUeIWv0MY=;
        b=TMAAKigP2om2rD0J5gihb22MoPA02b5iOZrmpUo2LLCPXImMy+qIz2QCUenVr27e+V
         UsT98WC2l7vJmL3nRn5BYPuZKoskNTqGuGOUBJdLiDF41v4qe6N3e1gtUE7k4B7JFHFM
         uZXnE/l7yZju/fs/OYmcr6ZaKTF0lXiyd4JiRftpj8zA+rnrvtSwW/5E8Xz40tbg7a7U
         XcXYP2LZhVz2iBxyHto8DRxfpxlnkEIhFoTadF+YuFq9s6o94bQM0H4oSHIo2iwe08NF
         VE8MiqJdT2YpxxIM1FmN+Urvpp+eggE7535dblsKWgKcAgI5GToLz8gCMziwxd8Z0v1U
         lSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413871; x=1796018671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GVQ2P8AWX362fj3fL2PAz+/e6GDEOziBkBiUeIWv0MY=;
        b=TfpcN9jTbIpg+cOlCux7tJbuw3k+4GYvvq69t/TAuTB/XX3q2Mu9Cz4XjA5zb6fuVS
         6N/IOIhaAoFvllVsaY2meb0YtFe2QOTed5fIxoGtfvg1u0TMXOEXPo9sUA+wpu7JcM0y
         o/7k4csx1yYz03EQEaVabkSwHkzBT1Ppf+CEPru1+9n9JgICsZJC2n41tZpPt3IY7mGG
         bgeemKoj0qCLbL2/4904XYfRcm9lu2APnSpfYJX5fCpZnJM7fOVw1bckVJnJZ3Z5XA9v
         cPKAL1hdohDEkWP0XazuJCa/vsZ+zG2rV9WmxvrMV3iZ0jwU/2PW6u/tWN6sximVUhWp
         vwvA==
X-Forwarded-Encrypted: i=1; AL+hErHLeTDBDnPLOIwsxY8alod4IUQyCbLnvMVBdLOvr9i/bJRby49du0nrL5xPnY1dKx8mfhI/Bg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9YXXXNRY6LSWkPcUXjywINIGkpF+cbx/My/vQ2uBRz2us/Cami
	ZW1klfjKGDDzHmRHEb465ZQ3oeDiVi58O/JzYMyFQdyrFoCxRE2WGr8A
X-Gm-Gg: AZFdTZfD1NFGZcihOUwaNtocc1bgaRjt84P3qyfNiq6dWKPlQ61AzdN7rH9Q9Iz50id
	Xb7iHPsd43lfqwAI52ZzHUAz/smwZUB0nBBvjd1KTeUs8mB4h6b9SpsB7JWoevMDMqV9vWwnXNx
	6tFCRZInC032+0IOxaXQcYRFUTeEgzzT10RkiMUIM3AX38tHzMAo1qpODP1jjXDFj+ywUWSTxM9
	Iqfif+TSyPhqJLZawj3yF7uezgbkqtJt6hrUboA1cKgcf4Ue0fBPZX+Tj9S4t3/uKfw/svXYfhW
	f7PmZIP1Uxz/O6yLXkTIlbwlrBczSlrpekjr9HYdYNRmue65DLNs+z/M7D2xH3YXRdy7jwM4ZrY
	Ce50F2/Fegt/NYLRM8AJAFVP45Gg20YRjaAa4FZmIC6z7ya5dQqU69FbL3t7FCxkY6Rra+9JoEJ
	F4IUPpxWYm0jGO1VjwGAQuOjJt7cvmMgDMpg53rpNe17ANtDhzZbCr5GIbVVj1mSHtiNZ6rUge9
	3+BmSBYLAu249nhTpXrBrGzZSK3q+qSl8BSsSUb+FWLdeZ98gNK6KwiV343OXtnZxdbaJJn/Mcw
	l5A6RHLNvg+4qIPVDd4trYL6ZPVmmT9M0uKPPIdzdfPXw2d1fhR1+PDQmL842c445K2xrVG2K4y
	k5d1wa5bdK4JgQg1vWjRmTEC2evtEoCXDvC2CivxwUBMWmEfPzA3owiTTtXRQCgYMLbc=
X-Received: by 2002:a05:6830:640d:b0:85b:c75:dc65 with SMTP id 46e09a7af769-86315611616mr13072110a34.7.1795413870968;
        Sun, 22 Nov 2026 22:04:30 -0800 (PST)
Received: from tempest-testimage-cc-centos9-stream-server-1191361818 (chi-dyn-129-114-108-164.tacc.chameleoncloud.org. [129.114.108.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631681f30asm7644864a34.1.2026.11.22.22.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:04:29 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 1/2] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Mon, 23 Nov 2026 06:01:55 +0000
Message-ID: <20261123060419.119078-5-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123060419.119078-4-oss.patchbox@gmail.com>
References: <20261123060419.119078-4-oss.patchbox@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hv_iommu_paging_domain_free() frees all page-table pages with
pt_iommu_deinit() and only then asks the hypervisor to delete the
device domain that points at them. If HVCALL_DELETE_DEVICE_DOMAIN
fails, hv_delete_device_domain() only logs the error, returns the
domain ID to the IDA, and the domain is freed anyway.

The hypervisor then keeps a device domain whose page tables have been
freed and can be reused for anything. The ID is also handed out again
by the next paging domain allocation, while the hypervisor still has a
domain with that ID.

Delete the domain before freeing its page tables, and keep the ID, the
page tables and the domain if the hypervisor fails to delete it. WARN
when the delete fails, as the domain is then leaked.

Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/iommu/hyperv/hv-iommu-guest.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index 9f4fa4315091..aa1db9db1e97 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -107,7 +107,7 @@ static int hv_create_device_domain(struct hv_iommu_domain *hv_domain)
 	return hv_result_to_errno(status);
 }
 
-static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
+static int hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
 {
 	u64 status;
 	unsigned long flags;
@@ -122,11 +122,15 @@ static void hv_delete_device_domain(struct hv_iommu_domain *hv_domain)
 
 	local_irq_restore(flags);
 
-	if (!hv_result_success(status))
-		hv_status_err(status, "HVCALL_DELETE_DEVICE_DOMAIN failed\n");
+	/* If the domain still exists, its ID cannot be reused */
+	if (WARN(!hv_result_success(status),
+		 "HVCALL_DELETE_DEVICE_DOMAIN failed: %#llx (%s)\n",
+		 status, hv_result_to_string(status)))
+		return hv_result_to_errno(status);
 
 	ida_free(&hv_domain->hv_iommu->domain_ids,
 		 hv_domain->device_domain.domain_id.id);
+	return 0;
 }
 
 static int
@@ -466,11 +470,16 @@ static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
 {
 	struct hv_iommu_domain *hv_domain = to_hv_iommu_domain(domain);
 
+	/*
+	 * If the hypervisor still has the domain, it may still use its page
+	 * tables, so leak them.
+	 */
+	if (hv_delete_device_domain(hv_domain))
+		return;
+
 	/* Free all remaining mappings */
 	pt_iommu_deinit(&hv_domain->pt_iommu);
 
-	hv_delete_device_domain(hv_domain);
-
 	kfree(hv_domain);
 }
 
-- 
2.56.1

