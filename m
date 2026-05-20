Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0424E4B5
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 06:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256830; cv=none; b=GS+2VmGj0oOlgrQWx6yrG12xhKAAFwRakS7i/Cd98UnuXmRkTgiYbdAxOiF8OJj+lbU1TtyewKY1tCTngQAYackp3GP4rWlEQ8M3BXSHx8smJVr9MbIzvGpgE9K8+OhFB6Rdg6wgshjKcneVvpUr0o6sl/MlNfOtI4bwnNyiKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256830; c=relaxed/simple;
	bh=ehA4ttutELSmlyGVel+w9zKQl/Ae6wxB/zvQoA5zHg4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LtdKJXzobgiOdpMC1lCsxBwQkInke2u1LUSKtUsQKykSE67oPtGe0ghfllHGJqZUzDwsLUGI7kswyKuOLlWueYVDMlZ0fJj0RXVyzPM6yEIePtVLUEsknm7xZamcpeMCrt3mc4Z3BxVFvinoFjVgYaXo5Sf48nuedbSgXqhid68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gijSWP/i; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gijSWP/i"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-459bf19e87bso2594363f8f.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 23:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779256827; x=1779861627; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4BraLHhw1khrduXE2WhX+9/5GdBOzVf9xcCtOVB8Kk=;
        b=gijSWP/iLevWGTKgRQR5txD1MAsjihRUqgtKOv1Xf5IxYfLSlDMWex75DrRflY2JE+
         b6PhlSk8kE69D28+XcEq4LEA0wLHZ3rI/IKaGMJbHYGEKWggyYB4AIh70PAUWyLtUd6+
         CN0YIsSOAs13t7DQU/0qP5ubQfZOV7+zXvqMyDVJIMB1c951ab22ODNDuWSkr0TVdYaN
         oswyIsCCiw6pM/hBiJqO+98Vx8hbWKUraHAuSCL++aybfGZeugKWDk0u5m7VGOCVV6c0
         FnJQSe+Q6VUxDxMstaygRVDERmSHogYXw5cEMA0iXclRMQ825yirELnhyHYeEhOZrYnK
         XC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779256827; x=1779861627;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S4BraLHhw1khrduXE2WhX+9/5GdBOzVf9xcCtOVB8Kk=;
        b=qJL3+AKXjbZpCh6Vqhx/JDVWn0+kdzA1VXRO+Xr0vf7aHnytvd8FcvVsAMOcr5nqC+
         NMjhuivIeRuSu9TX+09dwX9+QMHpGslTKSN36ZRLRt8R0nrPaAAFaoh8WwPBPQaW+g9k
         T5IgsvHuS6DDfeuhmtF/tnVlraORyTK3mKHzBcTvb+fW1v+HVSyhGD2OGCDOLJjHmabh
         nlv6p/WZr7+t5CUBewJ8pmWfh1NREZlbuEET6tJtkC/6IP9EJRkuyRhlEcVld+ZyBLQ0
         pTO1qmAButVLOb95Hf2nOXDZ4tRVLPXnGDVPl5ug81h/zGU2eT4NZYWJ8FsyPwzyO72l
         YE3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Upe7KBsl4hsupp4j/cMM5FGk/IR/Dr2+WcEN74DgFNoDBVuSAXYjbeHKZnPr6h9woZFRqIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBknVCL4B4emhUS90d1EWBiWusDArRTM0nXywxW95jak7jv0Eb
	853oGmjoT8XRsbBYnCwug6FBWzW+Yt/pD4tf4rQqGBOy9zsmr6ykf90LgoBJGA==
X-Gm-Gg: Acq92OHnCEE/Z4BGGxZs/uGwrxBN3btCozzFsxJe5YTED8ZTb3zzZDRlNPHBanJ2aZF
	cyXM8qdfF5xBlM30uOwdAT4ObfY2lnc0BWyXeYiQCBJAHW7eTDigrcl0c9uBQb0/V7vAYBZ4lXP
	WYaF+G5Gs3fxbnTelFvpHukCvGnXZ7535+uxRcrbjIWUWFOa/ZGt4UNRAKrYGDto6rEHQHxAXjM
	v88K2uSdD8NSgeW4ufokTmCUExgIzcUv8XddEo+EnXTO70C8gXILJtqNImlBIDLdIzNfQDfLfDf
	At/nJQmhx6PQkM6H+Vx7n2+m9fvibhjbNsk95UhI/AhXn13HCUiPmXM2DCxCgEIuZA5iUpEPime
	dxJyPB8D3n7D7O2YOQJim9cQf/ynYZaaFyS9Zhf29CbPVZSG1u5kiKzI8NJxLhrieseg5KE5v+r
	I09sCSjl21SNvV/5L17qPMJVw=
X-Received: by 2002:a05:6000:4205:b0:44f:9b70:2996 with SMTP id ffacd0b85a97d-45e5c5bfba8mr35320532f8f.21.1779256827186;
        Tue, 19 May 2026 23:00:27 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a562dsm52007643f8f.33.2026.05.19.23.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:00:26 -0700 (PDT)
Date: Wed, 20 May 2026 09:00:23 +0300
From: Dan Carpenter <error27@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] iommu/vsi: Use list_for_each_entry()
Message-ID: <ag1N99H-xnmSh-hc@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Smatch complains about the NULL check on "iommu" because list_entry()
can't be NULL.  Clean up this code by using list_for_each_entry().

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
Untested, but it compiled on the first try (no typos!)

 drivers/iommu/vsi-iommu.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
index 5d0721bd2c7a..9954ed414526 100644
--- a/drivers/iommu/vsi-iommu.c
+++ b/drivers/iommu/vsi-iommu.c
@@ -366,15 +366,9 @@ static int vsi_iommu_map_iova(struct vsi_iommu_domain *vsi_domain, u32 *pte_addr
 static void vsi_iommu_flush_tlb(struct iommu_domain *domain)
 {
 	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
-	struct list_head *pos;
-
-	list_for_each(pos, &vsi_domain->iommus) {
-		struct vsi_iommu *iommu;
-
-		iommu = list_entry(pos, struct vsi_iommu, node);
-		if (!iommu)
-			continue;
+	struct vsi_iommu *iommu;
 
+	list_for_each_entry(iommu, &vsi_domain->iommus, node) {
 		if (pm_runtime_get(iommu->dev) < 0)
 			continue;
 
-- 
2.53.0

