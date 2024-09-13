Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42D1D7998;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227927; cv=none; b=Gy7PRaL1PAWXIujsYMUqPfuADHkfj9zW94uf8nhx4NbbNgVR6rR/aX1PLfJimqMgfWE06xzoXfdP4NgTfXd0m3ieN4oG7SqwJsAOSkpQGNRzVwjtXFNnGm/vWt4QbGyPfzJZCNN561e4N2DcYDvmRDOCorgyMyKFFdsCYWo2uao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227927; c=relaxed/simple;
	bh=oGH1FuTsaRy7oacITrQ+mPPquktRVskCF8uOQBlSApM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rRfqF3aBEScnDeQw3diUn4is8pGtxZUjybp9FsJ4+UBIyq/V/kV/8+0K2lOqI7wCgphaa/Z9RVXpkFV1L+rlQse9rXdR0ykUHMP4P5Zqjis7cANT4GbacWs3cyyyjnxCUyEeUrHyCZgN/lc+Mp3hiC/JlVy+RVLjk0wrbjbL8uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2DRgy/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2DRgy/H"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 142ABC4CECF;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726227927;
	bh=oGH1FuTsaRy7oacITrQ+mPPquktRVskCF8uOQBlSApM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P2DRgy/HzfBRid/vB6c1vVycvrSx1Jm5UIr5b6vUmxZS1azrTN2x0T4zAV90BosBS
	 JPrdAxgTFEPSxI3ysUUolhllWmrqliCbgapeOVrHCkytcinBEcuBQ9STf2Uyrv8wHi
	 otSJ55weAElQsjosSJoLfRH62vRzfSCnIAECo7P5myK4vcJqegEr9qWLVXvCvce4EL
	 gyTwAOPMf25xYJ6io1DFqraMO/XWjVLG67/on6Bj+4SZRfkglw1L2a2IKmWkH3fi7d
	 gXhYSomQnAjp3UpKy/1/mzEhymjsrB7sDN5G21qHf2C7EZ/FAAFpPodynlzh4oYCwN
	 OvLO0MPL2aNSw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092F6FA374B;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 13 Sep 2024 13:44:49 +0200
Subject: [PATCH v2 3/5] iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-jag-iopfv8-v2-3-dea01c2343bc@samsung.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=A1IcN/yt0t1BbWgqjM2qPuJqNqel/ygqpz+aUMrV/hQ=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGbkJdN3k2cFzx1Cw4NfkutB8zhWv4i0QFuWR
 7OInIU4bLBQ04kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJm5CXTAAoJELqXzVK3
 lkFPuTEL/2zXwIxLN9rXthl7RCHBmHrGxaL4B5tD2/+4ByrYwQkou9LUbd/SDXbLSYrPjD/hxOt
 4l9oesPzfrhtrGrVaT96stXlcAXb4kXlpDYTBMo0IWjOdfohpuchaKfLBji0vhQaaNErkhn2QSo
 VtcW/iHI/yUFoHuG2sIl2K4J9eIZiufCAKe7SE34W3wPoMQLM3LwhiQC838vagglkVBkVygkZNB
 uoDe5TBFImhWMoflDebmemUChazEBZNFoLicCN7ABjBAAjPD+ECkPxcaz6DjR52zrBfQpaaylnq
 R3oxwM8976iITMt+HG9YHlIu9Vw/73n3fIGpsqo8kXwlEcpHX0VFzODCtfund5VuWZQr8fGQQ4r
 CgW8f5/0bqxsB3cXCxv18NCSYzfYEIhbcdfBCAgu8XgF1roF83ptSA/8nauVUGVPwqcdlSBCZeX
 /bd2QMSibTrU1TQBCvkXiLU5e5r9m+LzYgnDnLsYVwaA3fCyJn7wu6erUawImfYLth5DNW6EBc5
 iw=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

Move IOMMU_IOPF from under INTEL_IOMMU_SVM into INTEL_IOMMU. This
certifies that the core intel iommu utilizes the IOPF library
functions, independent of the INTEL_IOMMU_SVM config.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index f52fb39c968e..2888671c9278 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -15,6 +15,7 @@ config INTEL_IOMMU
 	select DMA_OPS
 	select IOMMU_API
 	select IOMMU_IOVA
+	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
@@ -51,7 +52,6 @@ config INTEL_IOMMU_SVM
 	depends on X86_64
 	select MMU_NOTIFIER
 	select IOMMU_SVA
-	select IOMMU_IOPF
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by

-- 
2.43.0


