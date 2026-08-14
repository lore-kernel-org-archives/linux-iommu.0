Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C317B418
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672619; cv=none; b=avMituXe5qgogyWZeRuiZjwkECBUW+TLSmAB+c5XH8aQVo50lpyMmxSydseYFbQH8/Aoff3VEtU7OKEQEtg0/VkHPx1JZ2c6DUyk2wROhosix+1r5x5tSRaqR+MhvouW13fJ4c9FYCQseg/DfF8UQeaFNNUzry1yUjjml5t6Tk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672619; c=relaxed/simple;
	bh=Q85AWLNgqcnljz2teM8bODhKb9R3SSUmpf8wLn2uxcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ftYP+QcLYGhKHZ25qbrgzaCCXFx6Z6cXyHXk2BWPlMcWaB/tYik+43cZ0cQLm9QGGeF2fpHaOTAvnL/dec8APK8Du27LPaeoI54tGEQBxe+rqxzjFapnOwdtNpG1Q54IhhpsmZP6dKtPk+E9W8rYwr1cnDs/b9pXP1Ri1XcBQuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tj5GvpSx; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tj5GvpSx"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d02df2bf09so6230345ad.0
        for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 18:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786672617; x=1787277417; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=suvqJCeCQhgoLkpZWaB5Gj2eD50qz+gC2/v02GoDQJQ=;
        b=tj5GvpSxRYj25nCq+zDnbph7/1jluLBPeK+1qXW/IuxMgjcW+73gTa2ksyKpSH46TM
         1gBPiVCNcf6XJsE3FGZ2mewSgSf7FXnnpZd4tk/vJtdBzb3NiCvz9vBmpb322gmZVB2D
         ngx6t9iZZtsUY5C1s9BWrsiGp6/qiJ7Fi9PzUuKTBK+U0gsi+to/t+iyi+5mfhlWkNkp
         UZKimhgH5GhiJL2pvx9blNpQJ2hBWXiNdyEbunU8GmQw3cICOqYLwS/JFpAIK9Fy+RPP
         TopnwwgBXXTEd1tdd+iOHg1xw75JagzAOZqPyAy66FeCWEANUmgLf/7LDtCv1ppYnYEb
         qqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786672617; x=1787277417;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suvqJCeCQhgoLkpZWaB5Gj2eD50qz+gC2/v02GoDQJQ=;
        b=T+s31b5NZuh/a+2vCLKk+hHmmg7JIqb9yjUcmD5NjoTNG5J3FQVn5pgMI6jvbVZIBC
         wXFxzptot4S+7ku0NZ204/u95ZsRcJKZNjHgN6LBQCB6nDZyvC6R8lqaH4uwh+Jv/pFJ
         Sgbc0ncVqryR5jPtDniCNit/lOMuJRvxGnJ4CWu7VtFM1Dbh8xDYdQmAIBYQJ7jwlURZ
         hCdnGQ0QYNzUQnOZ1wUm2WJm+MjwwCKw6mtM39HDdxMumDSzxoYtZKaD7o60ZxgAxdeC
         hZuh0zxG2c/QOQ67c+MXask9x63mD6svyi4rBE0rS3Wey9KbDKAvpmeKQWck2fm5zztX
         u3hA==
X-Gm-Message-State: AOJu0Yweh5ALY/yaNJ7aPnRhKt6xuIMiuKtSHWSUMpY1xjoSha5w4JM6
	Rsoc+0kEtKpWm/zf0gCg9MDfyokXeFouyrLcx/nP2n1SgiYKj6EgKnpJS942J3fZHbkY29K3q/E
	xcyKG7chfroSkNC94OP+83+x0/GCbyGTNiEt3kirwzIp+zt3nmhFXARdHuxL8jJSflFXfnPvc7C
	smu4tKJO74pZnlZ+vV88jRCsf9t3RXVg==
X-Received: from plri2.prod.google.com ([2002:a17:903:32c2:b0:2b0:5538:b55b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:985:b0:2cc:9179:32e
 with SMTP id d9443c01a7336-2d3b0896781mr26039055ad.10.1786672617149; Thu, 13
 Aug 2026 18:56:57 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:56:45 +0000
In-Reply-To: <20260814015647.3370124-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260814015647.3370124-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814015647.3370124-4-praan@google.com>
Subject: [PATCH v2 3/5] iommu/amd: Split probe error paths to preserve IRQ remapping
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Ankit Soni <ankit.soni@amd.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Pranjal Shrivastava <praan@google.com>, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Split the amd_iommu_probe_device() error paths into err_deinit and
out_err. Proper init failures continue to call iommu_disable_device_dma()
while configuration failures (like PD_MODE_NONE or ATS mismatches) skip
it to preserve the rlookup_table entry required for IRQ remapping.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel.org/
Suggested-by: Ankit Soni <ankit.soni@amd.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/amd/iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 911a95527d74..808011a700de 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2540,8 +2540,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		ret = PTR_ERR(dev_data);
 		dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
 		iommu_dev = ERR_PTR(ret);
-		iommu_disable_device_dma(iommu, dev);
-		goto out_err;
+		goto err_deinit;
 	}
 
 	iommu_init_device_caps(dev_data, dev, iommu);
@@ -2554,6 +2553,10 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 		goto out_err;
 	}
 
+	return iommu_dev;
+
+err_deinit:
+	iommu_disable_device_dma(iommu, dev);
 out_err:
 	return iommu_dev;
 }
-- 
2.55.0.691.gc56d675ccc-goog

