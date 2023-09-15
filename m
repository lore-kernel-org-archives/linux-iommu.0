Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220C101D4
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 13:21:35 +0000 (UTC)
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-d8153284d6eso2590794276.3
        for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 06:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694784094; x=1695388894; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HnObA/kZmhyC99jO+R9W14le1Eiuc2fMp54pXjmpHL4=;
        b=3UZslM8pI1uy+g6NlUyDRwd4w1TPZ5vPaIXeRXrJTKq4UeXeyhZvAqgvEde9sZNYBA
         e2eoxL2DLyDCeP8inqjoaVJWJAj2XZ5IEQMvT8V0njdVj1bMmEw5uJ0Z/ypY1i2TCENY
         zDRT8+1w9tCPaxl387h/nITLZmLkJD6UtyXStaw0sClHAKDKy6Ou2bToreCCG57PKXaw
         KM85tzcf+PTJETUAv0FlmzrVhWheANOoitAIYO8AQQKbOyuyU+Pff3MQ3Zl/v6Pe/YzL
         7YWcUG+xckDUJ9BDbkn+OPAPWeZvSH8nmS8qhoTOAuEgc/qOkYuj2AuNMuknmngL5VYh
         Gl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694784094; x=1695388894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HnObA/kZmhyC99jO+R9W14le1Eiuc2fMp54pXjmpHL4=;
        b=MSr/bRWf4nXwMncix2cmR8s6SBTWOkA66N/uT0HRMmwrut571WbYhgQJb1iuaTHiDu
         VBRRN9l36D3fR+j9DSzdVTumoe2InRgdVIWxuQjo3iaD1t+UeTgdoc18W5QSGmODUG4E
         J5jMsb/OLzTjf6A2hxtP8deYlfD6E2/4ycZmPxaC6PX5904gxEfuD+9b9Ry+kEgcrlM+
         kDg+CMEUKQXzouXpBBXBaMcoTeOVlCrx6lwL9uN7b7gnAQLXK+YnkOjmZ735zGMhnwTM
         Qj0Ts+2jZmmv+/9ARhK1SKbvEHFS50i1nWlk1Qv30YmqgdV5peLuBTD5Cw/TaVlydYwU
         oPaA==
X-Gm-Message-State: AOJu0YzeSNXMNrvQfxdfxX7DM2AjYYyUdZOb1MVKneNS/ers+8ku3EzF
	SFoxRApmAwnV7rKsrS2EXBMgTY0VoAgTmLTfzt/ckSAJaaxkQyK2F3FNnHrio0wl03Voc+vjsyt
	Sq8iGPRCHCr+dWI6XOP3mkpJI2nfTTaQMuIfe1n67a3rrcPCEu2qGuJ1ziVy/Zmg=
X-Google-Smtp-Source: AGHT+IHyk/sqE5aZccgTBXt08m7PCIRAy+acYkivPYOmlI58JYhGiCdcp65xDmKbHdJDgO6y9+7t5EQ2s/Xo
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:47bc:d53f:1c50:a3f2])
 (user=mshavit job=sendgmr) by 2002:a25:ab0d:0:b0:d7e:8dee:7813 with SMTP id
 u13-20020a25ab0d000000b00d7e8dee7813mr34021ybi.8.1694784094306; Fri, 15 Sep
 2023 06:21:34 -0700 (PDT)
Date: Fri, 15 Sep 2023 21:17:39 +0800
In-Reply-To: <20230915132051.2646055-1-mshavit@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230915132051.2646055-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230915211705.v8.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
Subject: [PATCH v8 8/9] iommu/arm-smmu-v3: Update comment about STE liveness
From: Michael Shavit <mshavit@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: nicolinc@nvidia.com, jgg@nvidia.com, jean-philippe@linaro.org, 
	robin.murphy@arm.com, will@kernel.org, Michael Shavit <mshavit@google.com>, 
	Alistair Popple <apopple@nvidia.com>, Dawei Li <set_pte_at@outlook.com>, 
	Jacob Pan <jacob.jun.pan@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Tomas Krcka <krckatom@amazon.de>
Content-Type: text/plain; charset="UTF-8"

Update the comment to reflect the fact that the STE is not always
installed. arm_smmu_domain_finalise_s1 intentionnaly calls
arm_smmu_write_ctx_desc while the STE is not installed.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v6)

Changes in v6:
- New commit

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f9bfa2c8ab1e3..86e4e2df9e2fa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1091,7 +1091,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
+		 * STE may be live, and the SMMU might read dwords of this CD in any
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
-- 
2.42.0.459.ge4e396fd5e-goog

