Received: from out13-173.antispamcloud.com (out13-173.antispamcloud.com [185.201.17.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D4522D792;
	Sun, 12 Jul 2026 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895563; cv=none; b=cpWtXeVzv4nACSap3bGT9b33i9cFD2penhqbER9Vvn8Cr/zz5NoRDu9+Ien+XkfbcSIbQLCX9UVrMSpOA+2gL9EYS9h3F0iURQ/54Ssli/zc3ck2JFRTkUqx59val/aP4gQNtIyhsCW+LLqV9i+wXcxbrgWQV5FZxprqqfM8NbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895563; c=relaxed/simple;
	bh=YPG617zMyV2rjYCiW5rahdVGD1+8qBHRMMWTU2I4cro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZiAPLpGYAeGyD23fp6fyg8I/XD2VTiI4QNNdChOQ+dAC6mRA53GBFghGFWug0+YQdL+FaBFaeTzBfo055QqZmJ5Kn6Y9alHHvyQAo2Tqh0e0Wa5ywgJ8y4wmpFdmljxFqfGoM4mzysv/86YeFUfdY2QpQRQj1yIztToBkBJQfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=a/IB9eia; arc=none smtp.client-ip=185.201.17.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="a/IB9eia"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx195.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1wj1Zq-00GoMi-Bf; Sun, 12 Jul 2026 23:19:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WU6K0l6pgqJ4tQYRgEPvrPUUwevNJ3/EYlqoRBVOvhA=; b=a/IB9eiafELEGAZvhAVH2Z43Ri
	6d1y7ifmCm01i9RsPFL/zEqs3FbZrtPYI7m15C0vnLLc204hXxZkfKFdaWAy5G5PFoOp0N9oYdAuL
	1mftaf5VAESsAtleI+bENErRf4UH4zrTZZ8pwvUzWeNY5aCkyBJ0cXf1kcKjSpVuBXwbA8xDO+4Kx
	7GbLeaU6UXYN+33u4866qkQQ5Rvb4M1q/cCSzS0m4gxNOvjhae34UHwLixHHTHu34yj4JXEapqhBT
	3ZzDZZrB4YT74ogD67BLAZ8Md1hCVHgvAgRJQ2ENb8SA15O0q09PPtSX6S8kwWXYy+lJ6LqSGYEJD
	bUcCTlJg==;
Received: from [188.251.249.2] (port=43526 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1wj1Zm-0000000D6jk-1kWW;
	Sun, 12 Jul 2026 21:19:02 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Sun, 12 Jul 2026 22:18:51 +0100
Subject: [PATCH 1/6] generic_pt: allow missing sw bit in DMA_INCOHERENT
 case
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-bcm2712-iommu-submit-v1-1-80e10cdde2ea@reactivated.net>
References: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
In-Reply-To: <20260712-bcm2712-iommu-submit-v1-0-80e10cdde2ea@reactivated.net>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Daniel Drake <dan@reactivated.net>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, nick.hollinghurst@raspberrypi.com, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00760531874771)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVm61tCxVcDzOdvOz23cNvJYpZ17O5Cs1PC
 LegHyxalOSu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIPGvhmpFjxC7HO0xZ1sgnmgGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCulNo0fvnzmZPW3MC2/ZtQeB7itP8hgjDRserKv4bhb3RyZlCL9i3kc+ehInPHgYZWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyPIv7c2tg
 uiTnO7hoWdxS2Euf+eM3l5KPnbp/eQthjVPLCh11+xKgET3fXj754wkhoRweeXUyelEFumxqJC98
 W2Chcvueb7X9IVOP0nXi5ScUGZbDvQNAWVsKTgEVkGFZkrTBb08hz2+hQWIE/jMJBRjlXAPIIi6r
 dxgy5Mnu2cDsZps7XJtkUNhIi117bsGJ7ren9RtRNyYim5e3GD8LGd17Yt5uvWRLqYZ7YcWBwuaj
 bB9FLgbTIobDkucCu6K1Qts6ESwZ+TRkjY5CmPXd4fzFwV5PA+Zo1HkEWshOrnfOczv/Rq1TfV/y
 9sPCUZ0yjBqTnQMt5W0GKvZ5TPS+0sUsSnvAz6a57TzpYAKZxAOMmYkwXP3g8rtJn6lRuSHjV8Jw
 2Fxq1Vd7xIu/TP3zxxtadaYgn3OIzsUC2wDRiPKWwieZyauFYqHkIbFa+ipFHuOywN1cBSoAw5Iq
 u8uD6H9vRamlPbOxG7rXq5Czwgf6xGEuqjPYHqCiHsRpKiyawVZCoGB4EfDx2fRuW8Y0o7OCze69
 5wqpq4Ow1lDfcfvX9sw5VBsaDF9CxNBjABkH3hTMjGc3lQAtuckU+MNQlLpWhjjykqbde3UjWoF9
 cBo9q3T2iWmfFRW/Psbz8QFVy0V5rN3M2TZ9grsaBV7hOgCSkfEzb1aIdlnbLZp4DCYOuNFQ+5eG
 III/qgXB3gv2NI/ukWuQBNrXV+EmIqM8SxKOhcObZXWnkEw+6F9CGyYC9AhR1ZLKC40YaZQ+trtn
 Eh9wUysc4uCrhmcWLql8TI/3DtpogqvULFO+LE7qqHyizxFc684o/A69h/CvHI/GeXW8oEyu47TQ
 DqTi6GKwcIp24VOsP5eu885wo+t+ynT3Y80OmAux3oN13+ztUzneZGHdcUfaxYq0ZH+Cc9iqnocR
 WxNUEo38DE53aa5lZFsy2onypIM6qetbKE/25wcB/G1/I6v3VuCfuuxebDW9m67rCRcaqNp40+Vg
 uPVAld1r3Z1SFe+4OrB9Rro7EpOy1Um2iVRPSUxhtw3wz3yqYcOpyKA69LF1Ge2GaGfxmfp09oMS
 l8c4ShQ//ve+MHzjs9MOb3HXByN6cty/LT6lgOv2AzRyYGlsi3xQeIJ6TM5o5F89lTjPCn99uwfA
 g5wm8t3Xj/LzZ5s/OJg1L2asZ/4te3BTDYEBZZ1yPQnIH5IVn/pKnch3lmmwSrgldH+Ps9MOb3HX
 ByN6cty/LT6lgO+c9AHZZ12442bv/l3jZJg=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

When working with a iommu with PT_FEAT_DMA_INCOHERENT set, generic_pt
will attempt to use a spare "SW" bit in the hardware page tables to
denote when a thread has flushed the CPU cache after modifying an entry.

This means that other threads know that they are not working with
cached/unflushed data, if they come across the same entry.

In the case where no SW bit is available, two things happen:

1. __map_range() defensively flushes every time it reads the PT.
   This ensures all data that may have just been manipulated by another
   thread gets flushed and made iommu-visible immediately.

2. An undefined reference to __pt_no_sw_bit() is created, causing a
   linker error in order to alert the developer that they are going
   to suffer a performance penalty in the previous point.

The BCM2712 IOMMU appears to be the first device supported by generic_pt
that hits this case. The prod to check for sw bits is appreciated,
but in this case there are no known bits that can be used, so we need
to acknowledge and accept the performance penalty without a linker error.

Adding an empty __pt_no_sw_bit() symbol to iommu_bcm2712 would be
problematic because if a second IOMMU were to have the same constraint,
this would result in a symbol clash in the global namespace. Also, the
kunit build creates and builds a 2nd variant of the same code and hits
this exact collision.

Add an opt-in PT_SW_BIT_NOT_PRESENT flag to avoid this. This prevents
the undefined reference from being created, allowing drivers like bcm2712
to acknowledge the situation and accept the performance penalty of the
defensive flushing.

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 drivers/iommu/generic_pt/pt_fmt_defaults.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/generic_pt/pt_fmt_defaults.h b/drivers/iommu/generic_pt/pt_fmt_defaults.h
index 69fb7c2314ca..cc57106c87d1 100644
--- a/drivers/iommu/generic_pt/pt_fmt_defaults.h
+++ b/drivers/iommu/generic_pt/pt_fmt_defaults.h
@@ -249,7 +249,20 @@ static inline unsigned int pt_max_sw_bit(struct pt_common *common)
 	return 0;
 }
 
+/*
+ * In the DMA_INCOHERENT case, if no SW bit has been defined, produce a linker
+ * error (undefined symbol __pt_no_sw_bit) to alert the developer that they
+ * will suffer a performance penalty due to defensive flushing. The driver
+ * can either implement pt_sw_bit (if supported by the hardware) for optimal
+ * performance, or otherwise set PT_SW_BIT_NOT_PRESENT to acknowledge the
+ * performance penalty.
+ */
+#ifdef PT_SW_BIT_NOT_PRESENT
+static inline void __pt_no_sw_bit(void) {}
+#else
 extern void __pt_no_sw_bit(void);
+#endif
+
 static inline bool pt_test_sw_bit_acquire(struct pt_state *pts,
 					  unsigned int bitnr)
 {

-- 
2.55.0

