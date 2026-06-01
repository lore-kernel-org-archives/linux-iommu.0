Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1A33B8D4A
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324614; cv=none; b=MA68MWojRGTS3iQsslZm0cGugH6+RtzEE/99MIbZDbTW6oyn/YSEzXH7gz0go7xp8nf/Ab/C7oxV50K+snbjURJ4ixTBZmLitJJ2uJfX8J/Y0ZNWM57pa4VxiQKKubMpvf780r2GwR+hqqV8lu+HGBzURoSA6nksVx4GDfaDWZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324614; c=relaxed/simple;
	bh=ZY1CHI2qLE7gvcNu09TeXmB6q3EuV2tMfE05QxQiulQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IABWHiZdjZ25Bd4S+vhvjqSj2d5IzX0HN58+ERV0U7t0Mb6jrnniHp/2znt7kYNdUy91M5FiMGpJrkQc4jSVryy+u2xIQmgmIxURKyURQb5jV+AY6hKjcYAnUscEYlA8YpTDDNFoEUk+y4+jYzxP1zbm41YkAxW6nsjHQDZFH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nui6Q2QY; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nui6Q2QY"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d8719bae6so1398572a91.3
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324613; x=1780929413; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J1VlFw02VkFXjGZD0LXM1rfEtalYzEU51knuxCZNQpI=;
        b=Nui6Q2QYhLbsT6wZofoAFfdNC3vyjcHLBLNhtgWs3qKaiahinJFh3C9d+k2VNneH3K
         HylWFFBtP0ViXd3ot5xkUSksAfoHhO0sHCisAMMMg4+wth33jXYnZppgbonRNrSG4S5W
         hpBAQkO2SEZu7PMWRClt0N9H4osLZYCO2Md78FVH6QqFIsbj0cBgY+oglRREQqkFDGFg
         6mE++QTMz/IMiLHILd+c+dJkOVEjQtB5urHoUPh30Lk8+MQFV+YkamSutmNOCjnCu5PM
         B6STDc1zIE3MejNW3uPb2kVMzXIdomkjsJ3CZ6SSH7La6TkQlQfvTjkFP2GZJ5g0XLHL
         3lMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324613; x=1780929413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1VlFw02VkFXjGZD0LXM1rfEtalYzEU51knuxCZNQpI=;
        b=Dnuo164aavr4sTUaoWaKA5f878X+Mbfs26niEk+72NdWdXqsDFGZlcp6D3paGs4s/Y
         qMvjmV6x+ssOZmVG6T/AFoirxEuU3/lHP4hEhItTIG802F675/tPor3cVR2ngRJicKOz
         x1wygINsqC+DoVcf0MYusMRVinRHmlEJoBobAs6mhfynJK9kbPSqpMbq51zrLgV6HxuR
         pBK1a4gNIHQ8BPxHAqdtV9Z1JRwVHv0K+8uuvGHar2NCea/NNwv9SCrQ3yPn3c3qYDA0
         LlT1CuuCPYckhsaBTyXF5Vx+OZ8NPtiNnEMeUJ09Q0TxYZh0JYYQ2qhhbCgHztRi98Xg
         Lhsw==
X-Gm-Message-State: AOJu0YwEEoKxKIZUVbjlxuK14CNqbzFc0jCE0QUYBg6Q4NeTO84l6b0m
	tiUVjaTbC0gsve8t4su7PclyR43xcxxBd5r2Giy4Gh82f7hOo7KCyBuxGNzo561jvq+K/KzM50/
	d0SNWHhiBUwU+RrUuveOPyrE+4e8M29AMzIO5gPepS3yhjALJwPWKvKinr0GTvXox5CZOp/4bHZ
	qHd3nO0i+zfbedQlddyJsGwnSIGVFjwg==
X-Received: from pjnj13.prod.google.com ([2002:a17:90a:840d:b0:368:eea2:5650])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c84:b0:36b:9faf:8396
 with SMTP id 98e67ed59e1d1-36c4ff6b3cdmr10066002a91.11.1780324612870; Mon, 01
 Jun 2026 07:36:52 -0700 (PDT)
Date: Mon,  1 Jun 2026 14:36:42 +0000
In-Reply-To: <20260601143644.2358771-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260601143644.2358771-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601143644.2358771-4-praan@google.com>
Subject: [PATCH v7 3/5] iommu/arm-smmu-v3: Fix a UAF in the probe_device error path
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Clear the iommu->priv to NULL while returning an error from probe_device.

Fixes: a2be6218e649 ("iommu/arm-smmu-v3: Improve add_device() error handling")
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a10affb483a4..54c7f1ae3a84 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4206,6 +4206,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
 err_free_master:
+	dev_iommu_priv_set(dev, NULL);
 	kfree(master);
 	return ERR_PTR(ret);
 }
-- 
2.54.0.823.g6e5bcc1fc9-goog

