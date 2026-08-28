Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F040A4483A1
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787921660; cv=none; b=XQywosll82CCxZmP7YcCtmkiCq4LgzdyIZmbTdFgr7yJ+KZns9GtFglr+L5jbyIEtaegcCHVvhGuWZoLevU3U3Wb6khvGBImqlhoOPPPYVALzcDzHhYEnzkxgQn6cnf0KVAFZROdj/QhSD29/zao6kiuEdlqKVM+Jc7z59k8COE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787921660; c=relaxed/simple;
	bh=5aBJVTFNtKdzt7V9kiKFCTKnRo+Q44vjxsSxWUMylcM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=quhFxMaNB2TiMFM1IVHzu19Yoh05jBRE9DCp3N5psvXiVB6qmrOIShfZhWbp5eQv0pQeQt6KD9KlJBTaijvejT4qOKTPXj5gndW/sDeZcmVunjxHOuM/woTT/8uh+DgwFQnUmDiWCgSN5/k+XhcZzxJDemwx2O0p5UfwaADKDkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R8HueKKH; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R8HueKKH"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-482e538ad9fso832767f8f.0
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 05:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787921657; x=1788526457; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtQo4uL9ciRrWrgSm+7tcMPkQTLbUYsP8Kt9QCNYgXs=;
        b=R8HueKKHh+2e1sMMVyz/hWZTt+81EDZAS3CSY9+CHbVOi8TRixMKd/QqSCTgiNlO4+
         H0KUTaJvWEIMkoyYdAc3oxQGuv8iwNNeGJljl2gFdfR/P74Az0WQBRWie4pgtvHeTlxd
         H0mFlB9r1IjNSR2vAe5XhVfkWlX2xp8A6ffdH9XeuBwTI9vukLVeVYfDiSV9SEhTokuv
         3xY/smxtqJH7jUGz19KlXEEI+wqrqrn1tj91rhpI118y8XSMz6svrU742fcsuiaH2IiL
         eAGxEx7cZkJEfGPP+1grH/VCkLPB5KDa/MWwN5nvRjtVfD1AGkZhtx+XuMSF/xADzJw9
         fYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787921657; x=1788526457;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EtQo4uL9ciRrWrgSm+7tcMPkQTLbUYsP8Kt9QCNYgXs=;
        b=fVaoPeTdLgCT0Xz3LIauA9/yL6AJTS2JyZCA7+5u7bpMG29I7hMUaEwlRVJSeG/DAB
         cLUCxALS+75HNNVS8yB+8aKzn1Bl6Epi0MBXlV+p0FMWgjyIShR9LPkIM9ylZxTlRN+l
         YpF8TXnylxTRx6/DaTGmfykK0gyl5Lj06W2Quum9kwThUrhQrqZauVN5Uif7zsp8yF7g
         BGB9WMfDZ4vR172ID2aVlIGbYWyE2R7Cyh8phG3IXFTyYAY0Ot4WN0IN1POx+pmwPTZj
         G1Rti0B/8gNPKPaeY9tNvuzYX2uoiL67tMRprDt09gj9/yaYTVqSA/mND6U1HBHcaFsk
         qNSg==
X-Forwarded-Encrypted: i=1; AHgh+RpuEQUgFyJoyVm+pRezvpuNFLb8+pFJ8Ab7EPClj1u2xW5I/5ml9122jvmDS+hYhMw4B9wXTg==@lists.linux.dev
X-Gm-Message-State: AFuF++n7yhJJ/hPxI7cpFNJsld6s2kIIFw8NT3EjV/Sgz8dHUmlQzZ9F
	Dbgk3zYx/J+Fm7kZalgi5sf2Xk8sXZmDaMN2D/LfDjH8CZtbcZjBYSStgBVZCIpHAFGhvgcxOmy
	ifciqgvYE8gdoDA==
X-Received: from wmbgx10.prod.google.com ([2002:a05:600c:858a:b0:49a:d4b6:42fc])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0cf:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-49b91c51e62mr90214355e9.14.1787921657014;
 Fri, 28 Aug 2026 05:54:17 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:53:37 +0000
In-Reply-To: <20260828125409.1921538-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260828125409.1921538-1-smostafa@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828125409.1921538-3-smostafa@google.com>
Subject: [PATCH 2/7] iommu/arm-smmu-v3: Prevent rbtree corruption from
 duplicate streams
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

In handling PCI devices with duplicate IDs, arm_smmu_insert_master()
will continue the loop skipping the duplicate sids insertion in the
rbtree.
However, in the error path of arm_smmu_insert_master() and in
arm_smmu_remove_master(), the code loops over all fwspec->num_ids and
calls rb_erase() unconditionally.

For the duplicate streams, the node is zero allocated including the
parent pointer "__rb_parent_color". That means rb_erase() will think
that this node is root and it will corrupt the tree which includes
other masters not being removed.

Fix this by initializing those nodes with RB_CLEAR_NODE() and check
if they are empty before erasing.

Fixes: cdf315f907d4 ("iommu/arm-smmu-v3: Maintain a SID->device structure")
Reported-by: Sashiko <>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 494bbfd2869f..36e3778c971e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4147,8 +4147,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 					->master;
 
 			/* Bridged PCI devices may end up with duplicated IDs */
-			if (existing_master == master)
+			if (existing_master == master) {
+				RB_CLEAR_NODE(&new_stream->node);
 				continue;
+			}
 
 			dev_warn(master->dev,
 				 "Aliasing StreamID 0x%x (from %s) unsupported, expect DMA to be broken\n",
@@ -4159,8 +4161,10 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	}
 
 	if (ret) {
-		for (i--; i >= 0; i--)
-			rb_erase(&master->streams[i].node, &smmu->streams);
+		for (i--; i >= 0; i--) {
+			if (!RB_EMPTY_NODE(&master->streams[i].node))
+				rb_erase(&master->streams[i].node, &smmu->streams);
+		}
 		kfree(master->streams);
 		kfree(master->build_invs);
 	}
@@ -4179,8 +4183,10 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
-		rb_erase(&master->streams[i].node, &smmu->streams);
+	for (i = 0; i < fwspec->num_ids; i++) {
+		if (!RB_EMPTY_NODE(&master->streams[i].node))
+			rb_erase(&master->streams[i].node, &smmu->streams);
+	}
 	mutex_unlock(&smmu->streams_mutex);
 
 	kfree(master->streams);
-- 
2.55.0.897.gb25b4bd76c-goog

