Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388763D3A9;
	Fri, 22 Sep 2023 13:48:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sendonly@marcansoft.com)
	by mail.marcansoft.com (Postfix) with ESMTPSA id E9BE24203C;
	Fri, 22 Sep 2023 13:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1695390035; bh=wnRMaJBOS2DBNUxEtrGxJj6grzGED1qsQnxvwl3853Q=;
	h=From:Date:Subject:To:Cc;
	b=EL+kQP6z2D1r/FcD1TXdu49qUlyYgYgj0amx/V7WZ9ABEa/REXdo+1rVGrP5gIKpu
	 geBzkpMjccNNO5cAGwX2nbtGyBjoKy0G5FwgpoB5xobEZXQdtOe4vKBrZLUavK08HW
	 cxRQAeVZdV2m+EYqL0bjS3NA7Gx6HxP6jFJuxVMLBGyCsm8TtvhygKKpF+bi49b166
	 4uC99oKwrAvYnU20loGtw829HDNtfL3B/s8vNfiSEgQLcGJsg+7mTo/gTrDZpa+Gaq
	 y4U7QZohJ04few8TmHtIC1vkcmc1HvG3dD6Hs2nOw42BMUobiKs9v5wkoPn7dhvDlS
	 gG8UbmaElcWNw==
From: Hector Martin <marcan@marcan.st>
Date: Fri, 22 Sep 2023 22:40:20 +0900
Subject: [PATCH REGRESSION] iommu: Only allocate FQ domains for IOMMUs that
 support them
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st>
X-B4-Tracking: v=1; b=H4sIAEOZDWUC/x3Myw5AQAxA0V+RrjUZRYRfEQuPDl14pIOQiX83L
 O/iXA+OVdhBFXlQPsXJuoRI4gj6qV1GRhlCAxlKTUmEss7zgfu9MSqPyu4TSHmX2SwdbFEYCHZ
 TtnL937p5nhd8EatbZwAAAA==
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>, 
 "Justin M. Forbes" <jforbes@fedoraproject.org>, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, stable@vger.kernel.org, 
 regressions@lists.linux.dev, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=marcan@marcan.st;
 h=from:subject:message-id; bh=wnRMaJBOS2DBNUxEtrGxJj6grzGED1qsQnxvwl3853Q=;
 b=owGbwMvMwCUm+yP4NEe/cRLjabUkhlTemf6MGpdr17EecAmcefbUi4gtXz2fGH8+UWdeZCSzT
 uqnx3arjlIWBjEuBlkxRZbGE72nuj2nn1NXTZkOM4eVCWQIAxenAEyk4gvDT8bEBMkPJ67IfVtn
 yV+s31PwoTNX+83atU/P8m3g375coYeRoX/Oi7b2+oKDy0Sr3eZP3Hw85t/sV/OsFJfeuW7EPyn
 HgRkA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5

Commit a4fdd9762272 ("iommu: Use flush queue capability") hid the
IOMMU_DOMAIN_DMA_FQ domain type from domain allocation. A check was
introduced in iommu_dma_init_domain() to fall back if not supported, but
this check runs too late: by that point, devices have been attached to
the IOMMU, and the IOMMU driver might not expect FQ domains at
ops->attach_dev() time.

Ensure that we immediately clamp FQ domains to plain DMA if not
supported by the driver at device attach time, not later.

This regressed apple-dart in v6.5.

Cc: regressions@lists.linux.dev
Cc: stable@vger.kernel.org
Fixes: a4fdd9762272 ("iommu: Use flush queue capability")
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/iommu/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3bfc56df4f78..12464eaa8d91 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2039,6 +2039,15 @@ static int __iommu_attach_device(struct iommu_domain *domain,
 	if (unlikely(domain->ops->attach_dev == NULL))
 		return -ENODEV;
 
+	/*
+	 * Ensure we do not try to attach devices to FQ domains if the
+	 * IOMMU does not support them. We can safely fall back to
+	 * non-FQ.
+	 */
+	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
+	    !device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH))
+		domain->type = IOMMU_DOMAIN_DMA;
+
 	ret = domain->ops->attach_dev(domain, dev);
 	if (ret)
 		return ret;

---
base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
change-id: 20230922-iommu-type-regression-25b4f43df770

Best regards,
-- 
Hector Martin <marcan@marcan.st>

