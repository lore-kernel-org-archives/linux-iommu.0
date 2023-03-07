Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B9BA23
	for <iommu@lists.linux.dev>; Tue,  7 Mar 2023 16:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=k1; bh=JtgpuSK8MmevXI
	itz6mQVyFwa8KVkr2/FF+DSt6FhcE=; b=tyKU84erH9mXtS96aLIMQKmyVSd9L3
	ZS1PHqinNMVw4uzLZioEtVQewxGVlp1FYSsHs+bLNjI8rdqUhOF7bCoZiTMhNvN9
	JSyLEQ7lm3IwtF6a+KvacNjqBY/D0XS7XVvgQcjo1ktaJnGqkujpq3oi0H34OJxL
	V3Q7L7KzZf5Q8=
Received: (qmail 751874 invoked from network); 7 Mar 2023 17:31:02 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 17:31:02 +0100
X-UD-Smtp-Session: l3s3148p1@DE3z71H2QI0gAQnoAFQ+AGEn9EY5VOxJ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] iommu/ipmmu-vmsa: remove R-Car H3 ES1.* handling
Date: Tue,  7 Mar 2023 17:30:29 +0100
Message-Id: <20230307163041.3815-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
References: <20230307163041.3815-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Please apply individually per subsystem. There are no dependencies and the SoC
doesn't boot anymore since v6.3-rc1.

 drivers/iommu/ipmmu-vmsa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..ba42001a6f57 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -697,7 +697,6 @@ static const struct soc_device_attribute soc_needs_opt_in[] = {
 
 static const struct soc_device_attribute soc_denylist[] = {
 	{ .soc_id = "r8a774a1", },
-	{ .soc_id = "r8a7795", .revision = "ES1.*" },
 	{ .soc_id = "r8a7795", .revision = "ES2.*" },
 	{ .soc_id = "r8a7796", },
 	{ /* sentinel */ }
-- 
2.35.1

