Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794081655;
	b=ABqVQiI/upHleFuc9w0RNCFOf9wEmd3xyDaqwtY4rMlZY8BBrJq5tvqupmDm1uI7Cj1D
	 N20OjjZMHTGw77hnQGo7kJ1GmdUavuiaSMvc8UqyQ3Rwzy+vEC3jJCPJgsFA1Oz/QG1ka
	 bWw55A1bNZp5e+GM+GXTzjB1HHgMNFyQjatPlBq0W49P4Ob07bEQxKCf9J1Ltxll7gDpO
	 w9dmM8hSzSEVtL/NWm8NQJbbrF8kospNJuNH8u4owD4PfjjahRwrD15gy84egKHu0OoxR
	 qn3c4WbbgSNelTDtBZtIYesZ3JmPto5Zz0a7HtEKK3E7gDtQgQr7ON7TSTgFf/s/VZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081655;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A9PiKhrsfGsTyeU01SUsRcBpanBcSXe1TCOBbWxDRmw=;
	b=ns7raHYQczb2c/KViSwr4Eyfe39EQxv2xMrZkVRZl8btUgSEdsA6ySg0Ftv0w8yM6bVD
	 iAJyL0rzQTOPl9zbjK8EWWubLtO55tqFQliENRpujPudAEjs3dxKBOP+eRx7dty+iviFK
	 XSa6kR/Ky5MOVIZv/fdz9v7YLkqi5zPDRklDe/pD8QJoyHmAXw274Rrjm/5QK8q+dwdMM
	 laZYd4CIEQGd9ObBUZZV1+aNTXuHYaXqPifbenka087pjADKElrDBxieS1mafjWm9ItiY
	 VJg5jWNs8bogdZOmtujFB3ShNxi1hgqyopY6+jUZDNMaPckZr209UEg7KYQmu1m+zOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPoWJ1p3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC050606A336;
	Sat,  7 Nov 2026 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPoWJ1p3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794081654;
	b=I/cmiLf2CJ82CIkKNrvyNzTLJJ0I5vlh3VEuH96UKVlUKONyU90zmDEs7Qg7Lq6+jpMn
	 C1Oi2MohCtg4R9vvdoZWf4prDVSkESOYbgWYJ0RaYPa7Gyn++g0KRNcfSm+6ayLTJJogn
	 G9JiT2R5YJh2wHXbXj0hIHEOFD4AXx69gJd6URj1cNUpEPTaqhMLOPo7Od5oJQDJLWrVP
	 puVgwSk1q8ztsu2BX3Rc9Y+CLVQAzbxJaJVFBJWmjkDlwVAS4P2l4FopRGevImLr8wfRQ
	 zRyrTlgDukYM7Df3wL6R8sKlFW5bgriBSRlBgMN6BrTZWurllddDVHYI6LXpXolSJag==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794081654;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A9PiKhrsfGsTyeU01SUsRcBpanBcSXe1TCOBbWxDRmw=;
	b=PrfSOhBozZ5wIDq9Dm4oRS+5xwT+T4AJHB8KX7VUgLcuvdOVUyqtqRXhSSZaLpzQtoSo
	 bIGUGvo25VUSj7A7i2vvQiMSdLnOdL+D5B3js5JX2MEPoYXS3la1W046GL/elXVgVRyV7
	 oLrGapSkob67x/xbQgF2mpEdeR4OPB0MmXFkIc3+zHsHGVr4gYsN3m1X+MowjfhYdY7NJ
	 KCOy3mfvMAO57A+L9oFe/XvItQVtUPJd87/qCQszzQgOcLg0w7Pq+z7cI+PbEYhf9egg7
	 vxgz/+145FDe1lMSx3Tgk0lYgJC90DYMIq0sl683M4+lq6rQVjEkVnN27IthanXZ0gw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D68601F008A2;
	Sat,  7 Nov 2026 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081654;
	bh=A9PiKhrsfGsTyeU01SUsRcBpanBcSXe1TCOBbWxDRmw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=aPoWJ1p3AFwlxXpT2At1fuXsCnFsOpFlWDkh3BpIMDi/KGALhD7T82Pyg6UJ1WuQo
	 ovAFzu2/JIQZQY/rxScJoEe2/xOFhdYKc4rcuHXG+CcioQBrYJra8Bpvsojwd5QnyE
	 jqrSoh/pt3h2pUgb/QB/zjjV2WlX3THXaOV6+qvF4nasAm3kYzLBTV0zk/Gls0a2b8
	 nbn6uLnMog0Rh4KUpQ7oFgfGiX88tY4QSiFK9gGpwqolETHm4t0NRMBTYvtFdpgBq8
	 T6GVs82vghqIqv0mMosnc7x/Im/PvielJdz6jXQTNEh4CTBgu5SxTWPYub5Gczc2Ic
	 HxF2GgQ+sZRoA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6970D47CD4;
	Sat,  7 Nov 2026 20:00:53 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Sat, 07 Nov 2026 21:00:50 +0100
Subject: [PATCH] iommu/arm-smmu-qcom: Add SM8550 MDSS compatible
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
Message-Id: <20261107-b4-smmu-sm8550-v1-1-777d0a41170b@dxdmail.cc>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNz3SQT3eLc3FIgYWFqaqBraWFqZJhiYpmanGKiBNRUUJSallkBNjA
 6trYWACyoUvRgAAAA
X-Change-ID: 20261107-b4-smmu-sm8550-98521d49ecd4
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794081653; l=1170;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=I+cZ1+xcU8CJV0qjts4gYWFK7UhBiDpGLpae4t5CYy0=;
 b=NkMED2aV/LYn6RCVXeu3yCrogjKaMuCYqOcoLgxBi5pmCjZKeQcmzjGxY5BtpSm6lapuAMURR
 NGRdTTK028QAJ5nW1ofTlnfor8Sr2Tw8Z9Ne1DmhB0Kp0Bl0ZxYUqr0
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
Reply-To: nacht@dxdmail.cc
Content-Transfer-Encoding: 7bit

From: Nizat Mikayilli <nacht@dxdmail.cc>

Add the SM8550 MDSS compatible to the clients list, as it also needs an
identity domain at boot. Otherwise the scanout of the bootloader's
splash screen causes unhandled context faults and the screen goes
black.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
Found while bringing up the display on the Samsung Galaxy Tab S9 Wi-Fi.
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 795e8ec7e8fa..483e9e4147b3 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -426,6 +426,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,sm8150-mdss" },
 	{ .compatible = "qcom,sm8250-mdss" },
 	{ .compatible = "qcom,sm8450-mdss" },
+	{ .compatible = "qcom,sm8550-mdss" },
 	{ .compatible = "qcom,x1e80100-mdss" },
 	{ }
 };

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261107-b4-smmu-sm8550-98521d49ecd4

Best regards,
-- 
Nizat Mikayilli <nacht@dxdmail.cc>


