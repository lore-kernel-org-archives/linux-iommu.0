Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857E29D05
	for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 15:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="T/Y7unuc"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9b6559cbd74so896016566b.1
        for <iommu@lists.linux.dev>; Wed, 25 Oct 2023 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1698247572; x=1698852372; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6kIXcR1VU3TM5nz+Od8WlpDMDBhPdIZjdnlTVp9UJg=;
        b=T/Y7unuc37BAt5BLfVUnFZa2TYjWB60Qbq1nWsrAilnvjEEADJzWeR+pTqmqIefs1S
         s3jo6hOxj0x+CSqKLfPM4WTxLPYT4sVP1BrrvMa1RatB3nAo2ynzeQCkqpqACrrHo/qE
         1PgbcfkYur26BMPYenI73EZ8Fl7x3PgahxMsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698247572; x=1698852372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6kIXcR1VU3TM5nz+Od8WlpDMDBhPdIZjdnlTVp9UJg=;
        b=CaqSiQQtYpvqJuqhCBcItK70pE6jBcxmHzPf2Knug9GWVduaz8x1PaJK4Ll2HExNFi
         FxbKPPcfI4wen5Txyw9+6YHUkDZDn7Pi0tgK60GlraJ1dBV2PVXFBrbCzFtHDUTyLW+h
         V9ow4mOfppT2uSpryYVF58FKk+JrSnO9tkYg+6JroeY/aqLLUoWqhleytpHjvpeVd0b/
         AgJe9quSEx3N8RpoqUGV24ak4rogDkHNgJ7pyDfScltMwty9m1KoGo++oeI/NI8oCUGe
         tHaLyHhmu4vk0A/kS4WxZObkZrJAFsNHZ8CUJRgm0yVES7CA1KY2fvGOvAPPDFrv80jE
         p4bQ==
X-Gm-Message-State: AOJu0YwxRvALkIehiqCnyM/zwHhqkWF2JmLXJS+qtAnGdKpf5ijuVfrR
	DsumbuLvdRoo1KxRCvWt0kebVQ==
X-Google-Smtp-Source: AGHT+IFZHatwpLh7F13bXFgOd8oEvInM20j/qQ1kWD4VR3k0O98n3XUgnAuYWIfT5SXzA9vF7lpujw==
X-Received: by 2002:a17:907:c386:b0:9c7:fd91:4309 with SMTP id tm6-20020a170907c38600b009c7fd914309mr8380498ejc.0.1698247572476;
        Wed, 25 Oct 2023 08:26:12 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-50-51-252.retail.telecomitalia.it. [82.50.51.252])
        by smtp.gmail.com with ESMTPSA id u24-20020a170906409800b009bf94de8971sm10110156ejj.70.2023.10.25.08.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:26:12 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Reddy <vdumpa@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2] iommu/tegra-smmu: drop error checking for debugfs_create_dir()
Date: Wed, 25 Oct 2023 17:25:58 +0200
Message-ID: <20231025152609.2042815-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value of debugfs_create_dir() should be checked using the
IS_ERR() function. The patch, however, drops the check statement without
fixing it because the subsequent functions (i. e. debugfs_create_file())
can handle the case where `@parent` is an error pointer.

Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
 - drop the error checking statement

 drivers/iommu/tegra-smmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e445f80d0226..3e573148d18c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1056,9 +1056,6 @@ DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
 	smmu->debugfs = debugfs_create_dir("smmu", NULL);
-	if (!smmu->debugfs)
-		return;
-
 	debugfs_create_file("swgroups", S_IRUGO, smmu->debugfs, smmu,
 			    &tegra_smmu_swgroups_fops);
 	debugfs_create_file("clients", S_IRUGO, smmu->debugfs, smmu,
-- 
2.42.0

