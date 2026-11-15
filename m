Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794773984;
	b=tEziIlv4wvI57rdpihimOjP2Yk8pQ6Smh58/d6Y6+KMcatPY3AFDUeswevVMnp2QUOIG
	 30nIiz2v/XN2Z4PNOOwoZIHp1ZjP3f+GBXt9xskmOKBF6zZISW0RWovQpjBuvVJ9+i4EZ
	 OtRrE6ZOUNc1lUlkAZAdRatILsRjoc54mBMnd/UfS3Eywm4ShCMSazd8pwdy84rvdWudm
	 an2afhtmkYKNPu91SRacVjnajGYeKcEGlTM8G3F4Ba7HrfMISwF+C3+ZelRdqe19HffYD
	 GzM336oh69TEepQRC4NDCCQTo9Wk+HAEx3d/G9wcRZBDL7Iy6UnCoZMupQkxi8fE7bA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794773984;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sE8fCk4typDnJvD+nhsRN4p0pLAgbnUmYhrIHo3jb4E=;
	b=vlH65aOZRWhEOB/8oM7Y4P5X6Cz7EakAIkwoN4Nuid4ZNrRlmaCCa9HrJdrb0xplgzcf
	 Evq4qt4MevdRBw1BoayXQFCQq8S5hiwskEpJTBRr8+K4u8Z2JbY05nX/Ha3TjN3cXYog+
	 PtBq3BDaQu14l3HRyeJPEe9ja+NeRmgGb4ROudjfcnA6Kl/B8nLIXbgu+UlsXM2tXLhjY
	 /gyD3YVi3+g4rDU9yX3W9/xNzzBjQAJaGpvSHUlbAylEXA/DRJij0gEAxEBozoGp0wLEZ
	 lwMH0AaI6xI3EEI/tnWbH36wd85BJ8kiDnFCap0aHKdVUBrlehX1UYj+TGN9gv9mclQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="K8Vg1AN/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560E4606A88F;
	Sun, 15 Nov 2026 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K8Vg1AN/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794773984;
	b=xE7D35lV9kOVJTzLYy8gOoJtYj6XpZe+fzclgtSKi4N+W7s4N1cgPtRIBIdVrqvYFUUu
	 mJoq4HcZjnrFVuEv/9bnDkMDsC/K3MidfzfZHTq/kv0XwTXw/pBqNpC6uheO87GCSSYOw
	 gv/krGBvm/6t32gpl8UyQKQ0hJEFkHRYBbEpiCHoeOf8XJRXdAC7XhM8Fx/a9i5tFCQA9
	 F20jaEJvNFiLfdCtSO9kxnSdKm89LuSJjp51skbXIzxJUb1BeMva66XaV+5jfAxDjzZhS
	 Qqb1R+uvNWjXEZaY4IXTeji1p1Lxe4kx1PiH4NMZJSa6FuKILnEaTRYVAjkeVrXgFSA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794773984;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sE8fCk4typDnJvD+nhsRN4p0pLAgbnUmYhrIHo3jb4E=;
	b=wtrEhu8RJGKys7Las56Q8dFqAqniHqU/mqYvXk7JvXa0gLPLn5vkWzcSqoJ74ste80r7
	 AgpqaxYWkGxlaGfIkUoi0YfnMExkP7hoqaSwb09/nbGrSmI63f3c0DOx9by3OhSTkEfEj
	 JHmg56BW2aGeEi8tTjjbPx4l/Zta14BCCxVg43RAnXcoyIOe2lThur+g3QIXsxMtnYIW+
	 iCUwqBvI82V7g2PjxQNll6q8skJqgloKy9zIAFy6f7R86Mb7Sf92A1MGxPDEiUwfLLsmN
	 TottgyK2Anu0aOHOdCLe4A6TSSHkpNDtbc2yHOPV289w2djw50ODAHDzeCYb2FImduA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8730C1F000C4;
	Sun, 15 Nov 2026 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794773983;
	bh=sE8fCk4typDnJvD+nhsRN4p0pLAgbnUmYhrIHo3jb4E=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=K8Vg1AN/kx9sz5cvK5OFTnumV+vS2Gz37/rJLinZQfP8rbfaFB2LjOjl+WU7H/Gpp
	 pdGd/oeE20Z+ieCkfFyx0/ddUiK5kGtZWmC0KybqntRwhC/w7T/Bvqf8JYQklyPh16
	 uygJNivUf8z5gmAomS+vJTm4IhpVNesvM0wizPs96HhnEaKdVYU0kTGb/SO62hAwqU
	 dtI/vfl8eRv6N9sIIJCRKOS2efqer1lvjeOjxP713ktGap6fEZrIknw6OOEjA6TeyB
	 2/1tYTsa/5aoTISNk9z1zL3qT1gaeaTDuFiP3mnwu5lW8LoxfS828wvGBDH7ZPVJNH
	 HOTIDVVOBox9g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 187ED4A170;
	Sun, 15 Nov 2026 20:19:43 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 16 Nov 2026 01:49:43 +0530
Subject: [PATCH] iommu/arm-smmu-qcom: Add Kaanapali MDSS to the client
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
Message-Id: <20261116-molokai-smmu-v1-1-54b682313b66@yahoo.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3dz8nPzsxEzd4tzcUl3T5ERDy9TElCSTtBQloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loASejl2HAAAAA=
X-Change-ID: 20261116-molokai-smmu-5ca19eadb4fd
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794773982; l=1779;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=tu+NFiw+fOcsWLYvR0WEdnLT33HysKPDUYnretNByDs=;
 b=usbyYu8k6ChN1bte4HvsGANsBt1ix37tDWesx4q+KT/zXgFn31cltG79xKwaZgpNHvZ8W++10
 DmrUBdISdqdDjCahETGzpqd0el2vERJN6CcIqrwg1/QQPkxdppHSk2G
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

An LLM was used to help write this commit message.

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


