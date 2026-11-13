Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794600277;
	b=XuOESB6cauS3ugiVTSjraFox3GV5Ohrj9qTskKgk0SYbJNHek6udhTFx1HgvdtH2YZn2
	 +7Hy4B+d3J5Yta0xX+n1K5Oh97cpK5ACi62LBuhGLMm7J7A5BqVVL+k4t17bbfmftkpHm
	 DPTnvYNkWcCN3ksbn3Hhdu3lw0EG6twemxm0jmOvzogxUZovLLdTw7OWxTQZOn5DYK2ZA
	 xx/0fVE8MiisBKxcPOPj0xHG6/cSeppf7HZMzMOQaxlzXGAy3/zpixs5BmJzoVNmEKB2S
	 v7Tw2e7QzWxXed0NNEAHrFGM9GSaBfpjUraEPsDunu3XTQRjXfXrZKtPWvw7WptxTKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600277;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AenUk3H3SoNZx7tOP4Z5LGrWlksJrYbREFQjbb7z+eA=;
	b=3D1eoxz3B/2XCipCewT6xuJJiCJJO8qXn7+Xvxj/+tVjw6ErB3/WhAOHO5efnL7UKoy5
	 Oe5+jHCgARrs2CVKuqR6qwBs9CWHTVF6kv3VYZ3qeBxz6A67lOvBPXtPbETEKSN6Rdcyu
	 02sDR++GNZa6JOUxHUZHxfHMzhHgb8VBpMpGGdBp2o9Krw9YD/j4bjrTRvfB+xhhKifuy
	 zUVjtmYrhruV1j78bW4kheBOdl7CzczGu7sDujLsndtzPUueEg6Bn5yC5G03263Tv4Zyp
	 ZNBcPtbO7jObLqaBkxVOufzKhOn9KQB6vejVF4Sw2Idgh5RXXffP9h8SleF39y39Zpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpwXWMkr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7755F606A331;
	Fri, 13 Nov 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FpwXWMkr
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794600277;
	b=OsOo6HAcCWqSm8R7X3bKHJo9iOwEb88FCR/ixS1GD7cU8w0/U7EugN7UAPd0Dd+1xdDs
	 chtol7DI/R+TE0pzYlTXP1crZ47941vMOi6gbtDTLicMkXyhCoDx5ZdpOChWuPQxZA18F
	 vw2Ywq8c0Ua39ACDZ2/9yTGZDWyvQ1C2OaQkZC0OjidBPSs9QUMW9ZoimV8nKwtuooY5x
	 f4wBdTSsi6L01+p9Py5MJ0buFNi+Ne0F7zUWlukXWF2jG5dlxEnNvv+QNQiIn1lGWlMB9
	 REgtvyNl8KBTLtQLRffp/uaQK6C6XYaOmcS7YC1Q7gUrM/3Fh91RM8cvcimLlCKTOYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794600277;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=AenUk3H3SoNZx7tOP4Z5LGrWlksJrYbREFQjbb7z+eA=;
	b=IYBtaydmOfudwIdO1sMSJGoRrhlDhhmboY/cvc373565E7UvHZUXiosWnvkxVGQmCTZ2
	 h+X9lueEoZFobBynHJ6lh/DYt4SY5s5ATWl46GBGmXctTn3eq6vu8EqIvvtce0s3TKgPa
	 ocQDBoK0k4xoGVtVk0oCKSww6AFVEWg8j00wXicjBa/bM6e4nNbqFv/vFRJYV14rtudUx
	 yxjoZZMWQ8Ddgy5u6c1Hua0gmQ0KYUp/0y4VsbmoKjb/CTT6YEKmuPpvLh1OSNc8Grewa
	 DbjciEYeCT6lBcdO5qNm0t7cEExVFcSQebf/zB/tEqA7I0qUOaHmuh1GprYEFe34e3g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9495F1F000C5;
	Fri, 13 Nov 2026 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600277;
	bh=AenUk3H3SoNZx7tOP4Z5LGrWlksJrYbREFQjbb7z+eA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FpwXWMkrTglQQxNKXHvUf0g5nz67F/Ga7FeU46NQepXuYe5+jd4B+kGw9HnvVgLwQ
	 4vpvhzk+EiaaaRQDTWxz+3RsREwjm+VF6mbBLUpQZkRZyJTkMFjLHM3N7+znE3GMb6
	 I2jb9beoNz5mnNoMVWgzRF7PWnGjQB4ON4pMMrIdOfW7m2QRSn7vSid7Gk/2mv67cW
	 qVDABkgtF62j0wPK0bNuORx2QtZcD8SBqCI9sIVq95cyB/QO/WHjcyQW0b0NzSryWG
	 0FlWAb23fSEL6CwwUBM0tmhTmpOxiEUrFgsTWVEr7QglfHu3NvAjegOTwsWA01frBR
	 L79mQi1ls7ASg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1A71B49ABA;
	Fri, 13 Nov 2026 20:04:36 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 20:04:36 +0000
Subject: [PATCH 1/2] iommu/vsi: Don't leak a runtime PM reference in the
 TLB flush
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-vsi-iommu-pm-ref-v1-1-fd917eebdf18@gmail.com>
References: <20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com>
In-Reply-To: <20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794600275; l=1868;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=i0Td+6MujQPe/DQQLSw3KocWhyfuPseeSSAgf/Ii2lY=;
 b=MS9jm5kQt427s30pjdB3RvqYejasoBAlixqn90BPdp56Se3+a3Gt3T+n3MbnDymK1sI+uqQ7l
 t8ZajGSwg0vBAcismXo4r9WwGpMnyZZHD2AspeX64HKwZDW4kgjBJBU
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

pm_runtime_get() takes a usage reference even when it fails, e.g. with
-EINPROGRESS while a resume runs, and vsi_iommu_flush_tlb() then skips
the put. The IOMMU then never suspends again.

Flush only an active IOMMU and flush the TLB when the IOMMU is enabled,
which covers resume.

Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/vsi-iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 5dac20b143a5..5d581be95333 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -369,7 +369,8 @@ static void vsi_iommu_flush_tlb(struct iommu_domain *domain)
 	struct vsi_iommu *iommu;
 
 	list_for_each_entry(iommu, &vsi_domain->iommus, node) {
-		if (pm_runtime_get(iommu->dev) < 0)
+		/* A suspended IOMMU is flushed when it resumes */
+		if (pm_runtime_get_if_active(iommu->dev) <= 0)
 			continue;
 
 		spin_lock(&iommu->lock);
@@ -545,6 +546,8 @@ static void vsi_iommu_enable(struct vsi_iommu *iommu, struct iommu_domain *domai
 	writel(VSI_MMU_OUT_OF_BOUND, iommu->regs + VSI_MMU_CONFIG1_BASE);
 	writel(VSI_MMU_BIT_ENABLE, iommu->regs + VSI_MMU_AHB_EXCEPTION_BASE);
 	writel(VSI_MMU_BIT_ENABLE, iommu->regs + VSI_MMU_AHB_CONTROL_BASE);
+	writel(VSI_MMU_BIT_FLUSH, iommu->regs + VSI_MMU_FLUSH_BASE);
+	writel(0, iommu->regs + VSI_MMU_FLUSH_BASE);
 	iommu->enable = true;
 }
 
@@ -564,8 +567,6 @@ static int vsi_iommu_attach_device(struct iommu_domain *domain,
 	spin_lock(&iommu->lock);
 
 	vsi_iommu_enable(iommu, domain);
-	writel(VSI_MMU_BIT_FLUSH, iommu->regs + VSI_MMU_FLUSH_BASE);
-	writel(0, iommu->regs + VSI_MMU_FLUSH_BASE);
 
 	list_del_init(&iommu->node);
 	list_add_tail(&iommu->node, &vsi_domain->iommus);

-- 
2.55.0


