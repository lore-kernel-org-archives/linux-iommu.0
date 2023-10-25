Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03A210E2
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="F2uuPciU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo8638460a12.3
        for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 04:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698231704; x=1698836504; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gC1STNfqo/ReIXjrh5ODTmjb0+/6zWRqz5Oi0kVvdL8=;
        b=F2uuPciUy6C/duQOnvsXMa0waBnbk/I2UiwszPkGd1g+2ZIMdAeJXbPbbIuj/oFc8G
         H/xzhA3IglxluWhoPzPdZdn+Nce1wgY5ZG7Aq3xGWj4kZbY35xT1e8z4clZhHCqsRJA8
         0gDJ1kunR73L8ZQAusVPiNQnZe2tqze1tZ1jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231704; x=1698836504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gC1STNfqo/ReIXjrh5ODTmjb0+/6zWRqz5Oi0kVvdL8=;
        b=MZB2e+9JVXOn/unmncRyzKYyf8MMlF37QhpfL5UZnj7ELmZh5msY4ZZvW7GDxPPyL4
         XhANLiHzV7FpWAJ5C5SinFqy4LgI5IxqfGR4FuM6LeY5SqrVMhtvsCPGV5T6HDQJqeKM
         LM6ta0WYhY8M3jcPnxscxAfk7IT/A1lKfWkuiiIZxOkpR/MSU5R9ogWKJPmt3N3XCZ/l
         5+6csEG3G4VVDRv8Ze5IyttL5nUXEUM15aJdso+CmAPFiFONAE4LYr49K5OewXf8eRUr
         d3bwpMzHJk7Qk1XO+62L5Ta+8WTTHcHgt0bnjikuJz75FJ3knDz8peEhSai7At1UKGl9
         aiIg==
X-Gm-Message-State: AOJu0YxQ5IXdfSiZ5pOz3F8tvo3PoFcIHQ/1bkDvvYL8x118SctceG5h
	U47yEdOCdrNx21e8FPmbOnkn7W6GoK+NtS7p8vwMWA==
X-Google-Smtp-Source: AGHT+IH9w2CN0Aj8bDNQ5kfS1kQwZ9JApoyTHfrWQGMBaOerFMfpeyEW2qCqPLWSXbl29/SfvmGxCA==
X-Received: by 2002:a50:d0c1:0:b0:540:ea03:af81 with SMTP id g1-20020a50d0c1000000b00540ea03af81mr819224edf.41.1698231704313;
        Wed, 25 Oct 2023 04:01:44 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-50-51-252.retail.telecomitalia.it. [82.50.51.252])
        by smtp.gmail.com with ESMTPSA id v15-20020a056402174f00b0054042ebbb86sm5222999edx.89.2023.10.25.04.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 04:01:43 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: [PATCH] iommu/tegra-smmu: fix error checking for debugfs_create_dir()
Date: Wed, 25 Oct 2023 13:01:31 +0200
Message-ID: <20231025110140.2034650-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of debugfs_create_dir() should be checked using the
IS_ERR() function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e445f80d0226..cd1d80c4c673 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1056,7 +1056,7 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
-	if (!smmu->debugfs)
+	if (IS_ERR(smmu->debugfs))
 		return;
 
 	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
-- 
2.42.0

