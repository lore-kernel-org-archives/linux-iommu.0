Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5354EC433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 10:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DCCF440B18;
	Tue, 26 Apr 2022 10:05:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 295-E84vZ7Rl; Tue, 26 Apr 2022 10:05:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAF1240B1A;
	Tue, 26 Apr 2022 10:05:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CC0EC0032;
	Tue, 26 Apr 2022 10:05:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 764F2C002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 10:05:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5513981871
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 10:05:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BKP6xoi1miAa for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:05:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3CD6817A7
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 10:05:43 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id d5so9498592wrb.6
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 03:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uZD806fAvlTFy6OKXpve0j8RNhfNiiOlgYjNQWG7hlI=;
 b=uGIVMshJ4QK6HnKtIHs0OqW+LWR8wthJkkvxdCdvUrMLbzirGhUAT57/2qH1G6fhPV
 k8rMSOb2eDlAahynqoK7c2/UAsVxnWJ6TYVcq8nqfFHxDGIj8jEi9mFUFbz+pNH+n+cl
 SReBXSo15FcnwaA6sLSN2NBNN0QGW8eucApo+flQA/Nnd7nyqDjDJbV4e8nxMNOJ1MXQ
 ybViU9mkPlGLMSpWGvPgZN03MG0chWI2dtixBJkAgIxt7kQ2x3VzsTcB1VoRN+fon2GP
 YYT6NLm4eeTR7adnFPksYxF6uHpVVfcmqXrOQjTFY5rtafyfeuAs+PjHP0bhpiCSiwoo
 sj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uZD806fAvlTFy6OKXpve0j8RNhfNiiOlgYjNQWG7hlI=;
 b=I5Z2y0pE/aMB1SGqYmu365sMfTat8ADxgWE43whlAt1g16nBRfaBwmXowcHpzYlkXc
 JcFfvly11sK41kjGDxZGCahlrDsQkEQvi5DMl57BKLTLC4pp+ubG+iGDOnXh/9uLmhC9
 sthJYNKKVdaTDxPGZW3EQbvvHcSNH+wnExTZ8rAH0kCi2E3c6PP5BOkbUUecENvWpwSd
 dru+xDM6kmznLgi/v/l2bFcfNV11lzo3D9mgjYKLZAMCgWn+4rfdd6dVqbgnXVuxcLsy
 5vx+LjegkRl//afqmJ99kgZI/dD4E6C4i5n2TLOECWmBmhQYBMnQ7YdWVG0G8E27tdlT
 wTQQ==
X-Gm-Message-State: AOAM533afTLBRclbWVFh6uK1BFWnqO0EV5QHTc8zaneJnGcRQ5qAV3Y3
 K9XZicGtD8NwNcBirUotVTbpKA==
X-Google-Smtp-Source: ABdhPJwwkUfQ9WG1CEy40iBc52UrT3d2XkXI4u0pzFMW4BRCogbCx1PCxcNLa7QvPV6TSTOyB0znYQ==
X-Received: by 2002:a5d:59a6:0:b0:20a:ea15:dcf8 with SMTP id
 p6-20020a5d59a6000000b0020aea15dcf8mr179843wrr.146.1650967542196; 
 Tue, 26 Apr 2022 03:05:42 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id
 p125-20020a1c2983000000b0038e6c62f527sm12806891wmp.14.2022.04.26.03.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Apr 2022 03:05:41 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org
Subject: [PATCH] iommu/arm-smmu-v3-sva: Fix mm use-after-free
Date: Tue, 26 Apr 2022 11:04:01 +0100
Message-Id: <20220426100400.147482-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: zhangfei.gao@linaro.org, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
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

We currently call arm64_mm_context_put() without holding a reference to
the mm, which can result in use-after-free. Call mmgrab()/mmdrop() to
ensure the mm only gets freed after we unpinned the ASID.

Fixes: 32784a9562fb ("iommu/arm-smmu-v3: Implement iommu_sva_bind/unbind()")
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 582114f94da0..c93477a2d7f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -98,9 +98,14 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_ctx_desc *ret = NULL;
 
+	/* Don't free the mm until we release the ASID */
+	mmgrab(mm);
+
 	asid = arm64_mm_context_get(mm);
-	if (!asid)
-		return ERR_PTR(-ESRCH);
+	if (!asid) {
+		err = -ESRCH;
+		goto out_drop_mm;
+	}
 
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
 	if (!cd) {
@@ -167,6 +172,8 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	kfree(cd);
 out_put_context:
 	arm64_mm_context_put(mm);
+out_drop_mm:
+	mmdrop(mm);
 	return err < 0 ? ERR_PTR(err) : ret;
 }
 
@@ -175,6 +182,7 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	if (arm_smmu_free_asid(cd)) {
 		/* Unpin ASID */
 		arm64_mm_context_put(cd->mm);
+		mmdrop(cd->mm);
 		kfree(cd);
 	}
 }
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
