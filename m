Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795375221;
	b=ii2qUSAo4rT2Kd8lRRU4OGgOKgSMBfcfpGw3Vv2xVRH5Le5Y0HC86ek8DSNA5nTNj4bL
	 p30+h+0f6Idfm60w4S0U2cN4mcJCedCC7jTqKckbkXOFimiCpgkp6UQwo/tU+tUZmCFaN
	 Vtk5v14KVp4C1VeHMT+ml9tjgKgHxGO/qEEDiyE3TVCKw/8Tbe/HX7ti5/kuWP6+I+5LB
	 oFwMuXFdIcneDJAK/au0ika8skmn3Cqo7ooyXWPuerDsD/P+9ADusGlZdJCiwoZGuW4b1
	 HXdpdgEV/hN6WCjvAs13+Q46qgeddBKIN3JvvYJIbfdBBPJDDArQpdt/QcpzFlcaZQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795375221;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rtJLIuILq38S7+xf1t/xBeKv84+48DNp6gcsQ42UeLc=;
	b=RkI6llm5e8ufEcn/n5uLoHFYmlIQxSuaFduOuDPxbWrjt1ZLl6yQv1EMfkax6CgoZc2M
	 g7MjcxtInRsmnTNyn2Pmnq7RymYLq1MDASmJVtMhTjl53N5CBohFTGU1z+WRwWAhDHOLy
	 yQd76dOhOX513yXGZ7wYBuX0pinD5Hmj8oPQihaz1DyqCvH4QxEDAS7T2wdGOLOLleGt+
	 woy40AqFQCSQGWkLSCZB0zeZf7XQsUZ01f7Cq53U7rRu1jzWsR8Wj0JsZElnIL7/8TiKF
	 4pdsZrMs1JzzlfqKuB7AL8biziKNpZE+SF/tBPNW9yu+y2bCmexNwprZWP4InZlgaHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4VmCOuz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C80C606A31A;
	Sun, 22 Nov 2026 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4VmCOuz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795375221;
	b=PkfXFP0hjCCsGSr6H3fQfOFZbSyLpqTyjpONUsbsD2ZNQpIYub84MO5lqw5UmByJTJMp
	 Q4NOlzRES6iHmfSBKGHPxJdBIkoYbLEx8TdROx2M7TduP+W/Y0jtCvOqCfcG6210xw67q
	 cbT488gNKk2yss26w5wX0MyIIXAJ2xLjuQF3cfznh/g7krsQQoxdN3B8BXufIkvTn0nhZ
	 m5e6LS4tR94JtxsEoN569it8aOdLUOmiRJRty/8OjzI8vZZ/stfdry8j6OmFYNijCd947
	 8WUCTkwJgrWH+fqrQ++eKEO8TFsGzXcOz/xfTg1IlIAFdApn3aENtgIPu8qSAS8G5kA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795375221;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rtJLIuILq38S7+xf1t/xBeKv84+48DNp6gcsQ42UeLc=;
	b=O/BttoSJTz/MacHSW/L5vQCAzMKsx45qDlqo64jOY7VUtNZfo9FuHERsjZD93t5vFiJM
	 lLW2vfzzDxQ2CMpPmFgcTQgEkd9k/g/lWk3K1liJBY7wk1KB76EKhEfmdZ63VPLVh57Tr
	 0vWWL6rrCH9fY7VPIMIVwx2oDOozlXUo7h2l3Mr43ctCuy1TSsAl6i8KfDcjseT5lAJqa
	 XAhqRZRtf7dLk66KehGTtVS/X8ozcJ1sC8LJSvKqov8VvskQ94FksyLhY72B+apNepNr7
	 lvYaULkDuQHHwLayNs5X2MMZwBCXSx3tHxs+GpO0YdKxvL25KZGM+IwL7KHLXYOOhag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1A8ED1F000C4;
	Sun, 22 Nov 2026 19:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795375221;
	bh=rtJLIuILq38S7+xf1t/xBeKv84+48DNp6gcsQ42UeLc=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=R4VmCOuz3WiLEv2VvbqPMryLSSv/H+jsEAzZ3mbFnNcHuJsyw3Mh6x5F8EkXmlD0h
	 JxCa1a2NPsrt7DKgxgZE/Tm+Fn0hgk35H8+6+dXs2AAvoSdHYjfkVeQ5ZFh9xe2TJx
	 aRX1mf82QaSVl+VJfitfcQ1ogGO9oE/16ibiAv8nRh8VLli3fX6UJSxCL1iHsIY9a1
	 qtW18dTjub3sSOSQPYzaX2IbvJoreZ5NQg7MHlrx9HNEhqS6qys0KYc5tULQoNPD9X
	 lwToUO9ADZp+LRTnx2d+cp1zodZGGNJJGh+vqsborZJYVh9NGEVwQgfPop3UviEy2r
	 n9snbELkiCn5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 964D64C1D2;
	Sun, 22 Nov 2026 19:20:11 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 23 Nov 2026 00:50:11 +0530
Subject: [PATCH v2] iommu/arm-smmu-qcom: Add Kaanapali MDSS to the client
 match table
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-molokai-smmu-v2-1-b269afb64de1@yahoo.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNQQ6CMBBFr0JmbY1ToFFX3sOwaMsgo5YxLRAN4
 e4Crl2+5P33J0gUmRKcswkijZxYugX0LgPf2u5GiuuFQR+0QUSjgjzlYVmlEAZVeosnsrUrmhq
 WyStSw+8td61+nAZ3J9+vjdVoOfUSP9vfiKv3Jz2iQlUWzhx1jrkz5vKxrcjeS4BqnucvMqksf
 boAAAA=
X-Change-ID: 20261116-molokai-smmu-5ca19eadb4fd
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795375210; l=1960;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=IOvN/fb6bq9WwffRaDqPrhV/ORJ4j4dNprZUstTRU0k=;
 b=LLBgn4fdGwva15pz51X5172y3KS1/TKgkPtY3er9X7hQioL/I5XY0vaKGmdkTsx+Q3P/9rBQn
 brpbiwrIZsUBV5gdT07l7JxFaGGJxI5Pwh1yyXUNdic8emQS2bgXhsF
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Reply-To: venkat.yadlapati@yahoo.com
Content-Transfer-Encoding: 7bit

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

The display subsystem on Kaanapali scans out the bootloader's splash
screen through the application SMMU. Use an identity domain for it like
on the other Qualcomm platforms, so the handover to the display driver
does not cause faults.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
The display subsystem of Kaanapali, and of Molokai (SM8845) which reuses
it, scans out the bootloader's splash screen through the application
SMMU. Without the identity domain the handover to the display driver
faults, like on the other Qualcomm platforms already in the table.

Tested on the Motorola Signature (Molokai), where the display subsystem
comes up through the application SMMU with it.

I used an LLM (Claude) to help write this patch and its commit message.
I reviewed it and tested the result on the device.
---
Changes in v2:
- Drop the Assisted-by trailers and the LLM notes from the commit
  messages, the LLM use is stated in this cover letter.
- Link to v1: https://patch.msgid.link/20261116-molokai-smmu-v1-1-54b682313b66@yahoo.com
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e8fa..0ee9a9cfdf8e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -407,6 +407,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,adreno-gmu" },
 	{ .compatible = "qcom,glymur-mdss" },
+	{ .compatible = "qcom,kaanapali-mdss" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
 	{ .compatible = "qcom,qcm2290-mdss" },

---
base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
change-id: 20261116-molokai-smmu-5ca19eadb4fd

Best regards,
--  
Venkat Yadlapati <venkat.yadlapati@yahoo.com>


