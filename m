Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808361F9EBD;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729026509; cv=none; b=UONcnWhuj7psfGVxtgNHdFVe4yAnH6wfUhmaf6SUCNWq516mmgRqTkp7GEGi5/G5jLJFvhcLWD35JiH4pzVcHud4AOy2nbLHzoECLiWU2XI5cjqnZZZcFX8nhKqCJqTWKiGOXYTEvSG5cDQTCF1ub32ezIfcYN098Z0+DxaipJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729026509; c=relaxed/simple;
	bh=DFZ/f2G030ayl8RBGNPku2LZ2t8SBPpzPS8cPjwszTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAboW1oT15tDEgTRsnjbXbAq1gbS32R3oOQFDAVmAbfRHp3h2mR3ay95FOx/x5uW1uN2QM6jBo/tHuxFBX7hYgGvWzeoG/S5A/vlG7o8FTqlNiN1L8mpVKM/tnV830rjX+k4mFIQnlPMlBmN8ZKvXkfMm0VNyr09/1Caffw6Rzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVrz2qGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVrz2qGs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35065C4CED3;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729026509;
	bh=DFZ/f2G030ayl8RBGNPku2LZ2t8SBPpzPS8cPjwszTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UVrz2qGsfqT9U2x95lhObVcrrDMwesgZJmec4eV4EcOzlIina/dyb0hbSIBtBp6nc
	 kDwcgpLw4HvMBrIltUOp5w259ffDdiSupySvVOdp65wjDCH7whaUOUcRP+LQrIAzz3
	 1bk08ISCP0Ee+AoAqu4yPliknkKzPewrmBpUbXuayoTirh4/WSeIWV+kupuiswV9HS
	 eRyS9iH8B25rFWJUP8xSInVpXVippx5HohHOpMBJpefB2UqunYmC/soOi2VhvyoYF2
	 f6a0sToZ++n4rH/KN4ylhNrpBnJ2Ffz/SPXJZrosVkT/I+2YCSjpR4/6o5s2EdpiuO
	 kOaEJPFEHizbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB3D1D876;
	Tue, 15 Oct 2024 21:08:29 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Tue, 15 Oct 2024 23:08:13 +0200
Subject: [PATCH v4 3/5] iommu: kconfig: Move IOMMU_IOPF into INTEL_IOMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-jag-iopfv8-v4-3-b696ca89ba29@kernel.org>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
In-Reply-To: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <joel.granados@kernel.org>, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=DFZ/f2G030ayl8RBGNPku2LZ2t8SBPpzPS8cPjwszTA=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGcO2cmuEQdDRIu0ztscVdErPio1hSdtYEEn7
 5j7xIBJ62+We4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJnDtnJAAoJELqXzVK3
 lkFPTaYL/2kUhvQzC9gxlz5YFxpD/xouya4yX0Pi8XjQTh9x0JlkJiTFztVPqQIY8ilagv8lFzb
 Z7LYxN59eVgd3M0hgXn68Db3HN2t9Zph60JSHCaKWKFbQN+fx1y++gtuYgk/GACUNaEkZ14m9Ru
 KOyhd7EiF7wu/uoUTmeh0d+q1Xi0NXOmI0qcK3uI4M1IXniKN/xBKlEX2gw/eB/ymzIP6Wui5p9
 rIfQBwakxeNC2fWjIdcMeJcjKCCFYbLRPlo3bbRG93vniPhPEVRh5Lxe6LVpvhJX4DME/fDtpSt
 srXfrL28ionabr1esrXMEtNEChKCqEDc4xpyo19mfikyV86lqu8ixJLuiitT7NJMqvfxzUJsdEj
 yGE+jkz5KWuEEaKOa73/ApAZl8iZn1royYVFuFsMFWy0B0/OcBiCy4u6E205wLmSYBAY0tAbO6s
 95TG6607JFAfIJShO0lgociU5MpRIC1WPNXsbiu7s5re2QvaDXJ1rLp2MfDLNjiTzAvkhFIp/i6
 Ts=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move IOMMU_IOPF from under INTEL_IOMMU_SVM into INTEL_IOMMU. This
certifies that the core intel iommu utilizes the IOPF library
functions, independent of the INTEL_IOMMU_SVM config.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/iommu/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 88fd32a9323c..f2f538c70650 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -14,6 +14,7 @@ config INTEL_IOMMU
 	depends on PCI_MSI && ACPI && X86
 	select IOMMU_API
 	select IOMMU_IOVA
+	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	select NEED_DMA_MAP_STATE
 	select DMAR_TABLE
@@ -50,7 +51,6 @@ config INTEL_IOMMU_SVM
 	depends on X86_64
 	select MMU_NOTIFIER
 	select IOMMU_SVA
-	select IOMMU_IOPF
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by

-- 
2.43.0


