Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474507;
	b=3/X9uwNKbzN75/TPSMlmZ4ogQ5PnVHYLVCMEnCTZL0sZ+5Dg81FKAevInBGLhltSPxNL
	 fE5WnTWuO1SFFBAx4KzlTmMSELyXl5DF1NdD6MFk75YUTODKmIH27uxg0d1mvOdxOd1cZ
	 EvcVimKCWI83ZEtldGFSHJBqKAHLVWp7yimWSTY0Cf+hWFbxP1KHNyD0hI8VHJGyhYDfz
	 oR3tAKCWXDCAEFl8vmSCeyx1sAe9TtjCgItXCoC4YhwE75J+1VcRA5WrS4HnbTh5qZ5Fv
	 53aEOl/gXaDgXzZ6j/9xdGE6ja+xKL2Oiu99c5kNKqevSUId6aWmt3TYhczTU0D6WPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=47QGolyVJG7rJ7+E1J8PPA+rcCQGmFElB+S6NGZ8+EY=;
	b=QzXI6t+DUMsiio9ZeZYuITjsfsBL2O7LxHSeD0M4/TFsfnWif6QevC+9jZEt3oGKjFt7
	 iYN1oezM+iv+ZNeo/POqTZV0bKfTUVjVr20eloTRrywwv7L+qYnjG2Via/1OGmrEH0hNY
	 EqQ+jAeHocGqLvTy5q0DBBkTnI7x4omA/XBpLnCeqncepjus50ryKtZ16yzRUZL5qh0No
	 H57QyGrE4kylB5Nk+3Vgb1+mjnB4LY60K9w86CnRDCvy4J+Q0S2+CyfcwxrQJ6WoujC9h
	 nPRQO+t7Z3U+vJ8soWrvScl3hA8YCBE5SpT5AmyiiMqoONTgtpuOX8gb6EZYEA8oW3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VYggLMdp;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E0606A320
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 05:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 530E0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VYggLMdp
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-9178d514951so23771126d6.0
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 22:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792474506; x=1793079306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47QGolyVJG7rJ7+E1J8PPA+rcCQGmFElB+S6NGZ8+EY=;
        b=VYggLMdpwDP+AHzm1RLlWR2MEURet9906TcJLvTsU7NBenriW3kTrnX6hIKvRIel6D
         qzWTYcFDMz9g0x85jNyQrp+cbHXypbXZ6uyZaHb9mMMUsRBpdBWGAlTdm/sG4mwPTw0Y
         1szAQv+dibtq3GUE+6tq7CIRaw0rfyMBgWvpkPa9diBANHZn63sSHL1OoMsVaR0jfECs
         VUdDNOMXC1A612JTahEaszeB7qqHR9+rqDG/LstyWxX5NNcOE9+N2v246NIJnccQ9lDT
         MWTjo5TtoEkgnkx9HBrEJaFjnkNpcWW/9I3O+xKk/438Jcr8lD86NmKzcl7pH9lD0vMF
         W5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792474506; x=1793079306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=47QGolyVJG7rJ7+E1J8PPA+rcCQGmFElB+S6NGZ8+EY=;
        b=MgvLySK4yXIXnPtzGEHz17GSf7Z71NA/qK0dH1Eer5lhgDeGF00Z2RD268o8OK7MjF
         UgkX7flh+NZuXvwxvTb7YF1Ms4cRo9hU7qYe+bxFjGa6XXreHrwZGmrxRI7GR1XycSPD
         Mji3M84PzgcdQjgwNrunau/zo/Jdu1DadR8T1ZXSlOkNqegthPddZXkeIk66X1DlPocr
         dDMHvLdt44MGQ2wqCgFomAaY5EWFDDN0vXq8AWraNNTHcmyfTdlzHS6RdmMSyfLMGxss
         vWEuO6Y3LlEeiyBCb6SJSxLqXMuVNjjYsKw6UV1HElgpXp27It7hLOe4GFZjfLZJc8q5
         JmCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJ9LQkXlsDpB+Fxk1QKAqsQLNbEptSLBG5nQG/4lp8sAn1j89zDkSjrRf0+yQ7Lu8APxC0FA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLOsbaTG1CN3cpGuH21BtiuTT7Auy+OThMxRbOurF3/rimwm3Tg
	QVFr/VQ+v/gtgFOIPYcfNflOrSHlmptaXFb+wvVXkIHViXaAlD4ufC5K
X-Gm-Gg: AYBFou3gUaJxJe2LA5eGoX3MIXmSAUecF3BcDz/BUxYRZ/8NgXvv2SEo8El/unTbQ42
	Z3XixB9Cmhtn0PXHs8mCVHZxJ0wA4MHGTRxhhCD0+lrK9SuBTidVNc6ORh0bWgvGKN7hdTqowvI
	0wvPI1ZaTZvNX7AjA8Hgu5s45dBcfHp7RzWE9Njzrt9jMeGUYBKcQ99gMwX2664XirqwL4LWYfC
	stvsDVHLMb3z/vdMKi6y8mamzbkWNpbyG6yc16EoTmF9qy+MO5KLme4MbiCnNs+NAPXCxVQcCyl
	RHRnOD1y6p6TP/PW3tBYELvry7FZAM9MSWo5pgrepX7UmlffH1/JQxyx9v3BbUnF8qtLBEuEk6x
	37IHTyO8s72UqJlgaqlT4+/KAKez/UYwIyWbKgTl8vL+G1X+UmFfkU5TSM1EucmwO+RuJ6heOCc
	wwK3kbR8q13h7OfbDYLJYYpqG66q7nyeUpE4MYHdhWW9Xann+3SkuKcqOf5zpj44t06WuOKikii
	nUDios2sT1mdS/3wiuX3Q==
X-Received: by 2002:a05:620a:2990:b0:93c:c08f:ecf with SMTP id af79cd13be357-93f29d69e08mr1677471085a.53.1792474506083;
        Mon, 19 Oct 2026 22:35:06 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b082168sm139455685a.22.2026.10.19.22.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 22:35:04 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Zong Li <zong.li@sifive.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1 1/2] iommu/riscv: Keep page table pages when IOTLB invalidation fails
Date: Tue, 20 Oct 2026 01:34:23 -0400
Message-ID: <20261020053435.1179054-5-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020053435.1179054-4-oss.patchbox@gmail.com>
References: <20261020053435.1179054-4-oss.patchbox@gmail.com>
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

riscv_iommu_iotlb_sync() frees the page table pages on gather->freelist
right after riscv_iommu_iotlb_inval(), which does not report whether the
invalidation commands could be queued or whether IOFENCE.C completed.
If either fails, the pages go back to the page allocator while the IOMMU
may still hold cached entries pointing to them, and whatever their next
owner writes there can then be walked as page table entries.

The kernel-doc of struct iommu_iotlb_gather requires these pages to be
freed only after the cached references are gone. Return an error from
the command helpers and riscv_iommu_iotlb_inval(), and leak the freelist
with a one-time warning when the invalidation was not confirmed. The
other callers of these helpers keep ignoring the result.

This does not cover the pages freed by the dma-iommu flush queue after
flush_iotlb_all(), nor the data pages released by iommu_unmap() callers,
as the IOMMU core does not let those callbacks report a failure.

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Assisted-by: LLM
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
This was found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. It has not been
reproduced on hardware or in an emulator.

 drivers/iommu/riscv/iommu.c | 63 +++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index fe8e6d0f8a23..816d50c0f508 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -508,15 +508,15 @@ static irqreturn_t riscv_iommu_cmdq_process(int irq, void *data)
 }
 
 /* Send command to the IOMMU command queue */
-static void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
-				 struct riscv_iommu_command *cmd)
+static int riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
+				struct riscv_iommu_command *cmd)
 {
-	riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd), NULL);
+	return riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd), NULL);
 }
 
 /* Send IOFENCE.C command and wait for all scheduled commands to complete. */
-static void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
-				 unsigned int timeout_us)
+static int riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
+				unsigned int timeout_us)
 {
 	struct riscv_iommu_command cmd;
 	unsigned int prod;
@@ -525,14 +525,17 @@ static void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
 	riscv_iommu_cmd_iofence(&cmd);
 	ret = riscv_iommu_queue_send(&iommu->cmdq, &cmd, sizeof(cmd), &prod);
 	if (ret)
-		return;
+		return ret;
 
 	if (!timeout_us)
-		return;
+		return 0;
 
-	if (riscv_iommu_queue_wait(&iommu->cmdq, prod, timeout_us))
+	ret = riscv_iommu_queue_wait(&iommu->cmdq, prod, timeout_us);
+	if (ret)
 		dev_err_once(iommu->dev,
 			     "Hardware error: command execution timeout\n");
+
+	return ret;
 }
 
 /*
@@ -1002,14 +1005,15 @@ static void riscv_iommu_tlbi_calc(struct riscv_iommu_tlbi *tlbi,
 	}
 }
 
-static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
-					  int pscid,
-					  struct riscv_iommu_tlbi *tlbi)
+static int riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
+					 int pscid,
+					 struct riscv_iommu_tlbi *tlbi)
 {
 	bool use_nl = tlbi->non_leaf &&
 		      (iommu->caps & RISCV_IOMMU_CAPABILITIES_NL);
 	struct riscv_iommu_command cmd;
 	unsigned int i;
+	int err, ret = 0;
 
 	riscv_iommu_cmd_inval_vma(&cmd);
 	riscv_iommu_cmd_inval_set_pscid(&cmd, pscid);
@@ -1027,7 +1031,7 @@ static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
 						tlbi->range.sz_lg2);
 		if (use_nl)
 			riscv_iommu_cmd_inval_set_nl(&cmd);
-		riscv_iommu_cmd_send(iommu, &cmd);
+		ret = riscv_iommu_cmd_send(iommu, &cmd);
 	} else {
 		unsigned long iova;
 
@@ -1039,21 +1043,24 @@ static void riscv_iommu_iotlb_inval_iommu(struct riscv_iommu_device *iommu,
 			riscv_iommu_cmd_inval_set_addr(&cmd, iova);
 			if (use_nl)
 				riscv_iommu_cmd_inval_set_nl(&cmd);
-			riscv_iommu_cmd_send(iommu, &cmd);
+			err = riscv_iommu_cmd_send(iommu, &cmd);
+			if (err)
+				ret = err;
 			iova += 1ULL << tlbi->single.stride_lg2;
 		}
 	}
-	return;
+	return ret;
 global:
-	riscv_iommu_cmd_send(iommu, &cmd);
+	return riscv_iommu_cmd_send(iommu, &cmd);
 }
 
-static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
-				    struct iommu_iotlb_gather *gather)
+static int riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
+				   struct iommu_iotlb_gather *gather)
 {
 	struct riscv_iommu_device *iommu, *prev;
 	struct riscv_iommu_bond *bond;
 	struct riscv_iommu_tlbi tlbi;
+	int err, ret = 0;
 
 	riscv_iommu_tlbi_calc(&tlbi, gather);
 
@@ -1096,7 +1103,9 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 		if (iommu == prev)
 			continue;
 
-		riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, &tlbi);
+		err = riscv_iommu_iotlb_inval_iommu(iommu, domain->pscid, &tlbi);
+		if (err)
+			ret = err;
 		prev = iommu;
 	}
 
@@ -1106,10 +1115,14 @@ static void riscv_iommu_iotlb_inval(struct riscv_iommu_domain *domain,
 		if (iommu == prev)
 			continue;
 
-		riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+		err = riscv_iommu_cmd_sync(iommu, RISCV_IOMMU_IOTINVAL_TIMEOUT);
+		if (err)
+			ret = err;
 		prev = iommu;
 	}
 	rcu_read_unlock();
+
+	return ret;
 }
 
 #define RISCV_IOMMU_FSC_BARE 0
@@ -1270,7 +1283,17 @@ static void riscv_iommu_iotlb_sync(struct iommu_domain *iommu_domain,
 {
 	struct riscv_iommu_domain *domain = iommu_domain_to_riscv(iommu_domain);
 
-	riscv_iommu_iotlb_inval(domain, gather);
+	/*
+	 * The IOMMU may keep walking the page table pages on the freelist
+	 * until the invalidation has completed. If that is not confirmed,
+	 * leak them instead of handing them back to the page allocator.
+	 */
+	if (riscv_iommu_iotlb_inval(domain, gather)) {
+		if (!iommu_pages_list_empty(&gather->freelist))
+			pr_warn_once("IOTLB invalidation failed, leaking page table pages\n");
+		return;
+	}
+
 	iommu_put_pages_list(&gather->freelist);
 }
 
-- 
2.43.0

