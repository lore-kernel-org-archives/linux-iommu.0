Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794513439;
	b=KBPfebH3uaXzGWpGqh1n6croXnXpOIG75/CI5BVIOAoiNkpPTcvlxrZD2SSVyVAuwIND
	 OpJvoIU8PUIl/Uez9OF5+UicQUtt533c+bzlX+52PV8KTWgw+2IIdha7ouHQcBeMVO5LT
	 8IHQlWzWK4cMnam4YezytKJJSWiSCFnQA1bzhHjAXigfK2H7bjSUcS+Nio0XeX8Or6RyN
	 7i18544M+3CT9pmVvyT1Uqjyp+wm+Ld3anoH/+wWqREBik7Mr89IYphjg65GKu8wu6D78
	 xgQEI+8qzZHpnz5g5lKcxTCn77kGx1q9lO2RYUqkJFlb+DnmQ/3eQ1S85K86Me7/jPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=muUL/i0pK+uF2VtOqzLp+1QKzl/yRdA7lx+xaRgrey0=;
	b=K5t30+glmtcjLdNEl8P70ooKofg0hYpGguWyBnTUcIIpM5i8W8/cNTsPpYz1uury8aXI
	 GXRwStSgyCaXV8CsieWEHwJcNvkl00lFYmVOEeKLK/vJ+yrhUi+rVQ6mLnfGxZEWNiUq8
	 gQOKB8cUoSiHisRCcgM8Ipq+DLZsw6j3Hzh1SPN/ipbhE+utyEChzekCg4Mgu+tTQpIwb
	 O+i115qK8x+7DHwTnIQKJW1+ASnOyN3yaI4ym63FfMNe0g+v8gz2MhGEHcQV92kTlRReY
	 qiWQMHFpspgoh0iiTTpKugQ8CE6QrO5nc+5wpoWAKqigJ1iFfw5OQ/WBtHQVmi/2xpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r5Xz6jco;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171D8606A33B
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 19:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 171D8606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r5Xz6jco
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53cd0c8614eso791081cf.0
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 11:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794513438; x=1795118238; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=muUL/i0pK+uF2VtOqzLp+1QKzl/yRdA7lx+xaRgrey0=;
        b=r5Xz6jcorebeTMRx1eKQEu0T4As6njkMx8zszfMfjgTvCVygWsDsvwTLwAVl+CIO37
         3xIl5bKgFtQhDFTg/EWdkRm1P920Gb5MYoeQ7Ifzm11HDNGr/w9h/it8nfoesZSjYtrE
         kbfNBDZ0CSw0yl/n2SL19zL4YmYXP5Ncoh10EYQbFh1MOVJ18qvPu4Y7+T0PK7Qi9NEz
         fBkcYzsbJHMpRaaLPItUwyVrgax7oAyEPoyqSNmHInSV80lrVdQ3+8eWScquhvDfSPZA
         f8c4TzZ59Z34oq1cxNQ20ZrHVbqOpF81c6kdXj39JulJ+ZsMyvyrl7q0n+97ugxwEV/w
         qUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794513438; x=1795118238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=muUL/i0pK+uF2VtOqzLp+1QKzl/yRdA7lx+xaRgrey0=;
        b=VQQfHNYh5Tfpb5R2HjnI+b3s/aHeEU+/csPlsE5JsYkrTF/dgxcQQJ25yh/kSRSvKG
         xKUXCbPUFqf0KGoR7k630aiSFLev6bIxG4nKsdmwjIHnLibliaZ3aQb3C9MGjoBYzeBs
         uKSrRLayVr/BQto/A2B9dTB3VNKCFLOOpoEJmUd9u/HaNEa9G0hih1wn3MBbQoNkNQRh
         XEN1cL55crFDmsD7BAwQ4AHgNCJkdE2eXcVb7lmn4FvYXnlHXppXJGi+HkF8e/fK8S/f
         88k4nb6aX1aW6Zd0Sbn9FvYma95V1k965MVt8zEG45j0A2MTLIbLsVn9rXiUlGNbqOiv
         faag==
X-Forwarded-Encrypted: i=1; AL+hErEcTX7YNfhUcm/qx12fhr5XOxOOfmZjIlti0hm6/t5Ta5qXgcymjjbduSb+tPsdAgTsWebDkg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9HRBhKj+m7hMeiHV0rbgR93NnbY+Kz9SxwCIq74Ci4Un3mBi3O
	Ic457OUJTAh7tnwowNF2F9lLvF+j/OcadftGaUPiCkkTpysciCeiG3XR
X-Gm-Gg: AYBFou0IAVIBscySHhKMgqgnG6ILyOvdcmHZp2Pz+4ewwvEuVK5C2Q7NXAxPGwVaSl7
	1jZeNn9UTZunDwNKJuC93EbuYhWYsintp+4Fh0XmEENU8t6o1OmYgFE7vCzaOIteN+NkM2605Yd
	BBpM7M4GxgtlofTxZVejNMX/1MtdVBb68UJM1dGapjHTVUosUQGhTazJsgHQ/4aB51iA+hSYPdH
	rw88pP2aXjhY9cJhicz7KoX/Hck3FFLR2RdvHwM9cKEM0bhX96lCgwZl7pN1jIILfa0fqzfdVtN
	xmfk/ROa7k7tAVaAsNy46bHC3SE1MoUP2dBoVAo0angBvSpUv4ivTg/HvNhKSSrI+UKp5r0G4nF
	1gxFjr4uEIxwT3xEl7CPL3aGGlIlb6FwAzA2JznK2+cidSEGxAirtM9E6NzqteaWJGqtLPNfv/j
	AAoyNIHXs/p9q5shgOltjx915NiZ6waVgOHnpzR6qb5DnI/D1xoYte6tqrOlyu/k0lYG26e6ni1
	T1FRC+8DZ9rr8YAbUCye6csLTf0tqI+6ROKCwqQNCG1MZdJ/vOvXpBM8MQIGhxORYbM7lxyS0IQ
	YVhvuq/IWcEHTPNXJlHbzEmeo9itOLOW1AqfxpSCtlydcCyGK+qs
X-Received: by 2002:ac8:610a:0:b0:537:6f12:69 with SMTP id d75a77b69052e-55ac888b9a3mr8854161cf.45.1794513437993;
        Thu, 12 Nov 2026 11:57:17 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55ad034918fsm2504851cf.4.2026.11.12.11.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:57:16 -0800 (PST)
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
Subject: [PATCH v2 1/2] iommu/hyperv: Don't free a paging domain the hypervisor did not delete
Date: Thu, 12 Nov 2026 14:56:59 -0500
Message-ID: <20261112195710.1417744-5-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112195710.1417744-4-oss.patchbox@gmail.com>
References: <20261112195710.1417744-4-oss.patchbox@gmail.com>
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
2.43.0

