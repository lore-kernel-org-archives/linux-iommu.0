Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794588038;
	b=jXRAj92oS+cjAA87oeve75E4dge7XERnPESRUyuOYZv8OHzobUNUYZiWBs2F5Psbb7Od
	 fw3LsLgrOGLz/iWGRIBjAizpkIpEK9Q2N5yHH0TrFdGoZ1ej4vHzXzu3/9JCqbBWtZvsx
	 /Blm3pzCCavkfMqX0rhGXEgExhrnRdg+j52Nq/mZLYkWuHWKXM8IYmlSUKKIfUCihzrHQ
	 X6lDQHlHSAKwcFvBilkiyXqELFJfpGB+UDCOHRhiXGcSLiqK6l4eLZvH8QinrISO/rOCv
	 HM9RkWWZY8rCJl/70qYXkV+JqTMIsK4VGOtzPYbAmjvAr9QLrOgzGn4Y3I7SNyzKmdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588038;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ftkGVaWmlEcBnSmz/bQQARpxpmtHnb04sqbnV5md88k=;
	b=iAytAj0TGKOpbiLlG56F/1gWkCniWR3raYYRsE8so0QZC9QFjEdMTujRNPHiFaqtwsGO
	 o51l74dfAchshyS1w8M0VGO3uyAIq1ONcPzYbELi2R9H7o5gQerzvVRSt/rCy3mdtb7+6
	 pOfFJ3f34ZeNFU0YqOL4H6evQy5lMyyQzLwtwTywKlYtEP/rACwMpsq3VQf4642XGY0Ax
	 KGPKmAw+gbWUkuZkmVXM0n2tPICR6sp8e/vyEoCrwGFPqXU5nGZncIK6HwJBEKRcd2eTh
	 lc+3Th6s7pTIcdxxYM1o0RTLDdEq4S3mRNqjfzvamCbN0WTmzV6QfIp76Xiq6ksYqGQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaAh4chl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFA606EBD5;
	Fri, 13 Nov 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaAh4chl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794588037;
	b=jYQ+qyfYzydhddR+2VlsA2+x8jk2mX05EQCZZHvxM/vqEss335rq9wtH7MYilyEY/qF0
	 p7j0g2vEh7IFAiMFTsYRaOjiC9pmyZj843WzFt2tx71gBseoY6c2mPJHHJKg3vrkxdqoc
	 MRR1w5rOCifdJSGd8pRq+EZSEcqCp1K7jRH9LSWky0WFYCmdWJeSTJryZoP+bKgjTeb6X
	 znKWZeT9KuSlwSIu5ld+CN0Ib4Co4BQZon0gmhLOAtrkcAksJ0yVPRmCM6GYqABdfpA3U
	 mdkKA27SgRJofJGBdnAIHDyY43CrCV8RO9n6KvcabX7orTZO/VTbreCiYJD2OkK0k3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794588037;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ftkGVaWmlEcBnSmz/bQQARpxpmtHnb04sqbnV5md88k=;
	b=koxsb38HhK07p+cg9DYxk8zWWZLhvQLlVKX4zpGbvD15PXwhg0c1QO41i7Is8x8MU19U
	 e/FdirlPxRZQkh7/z29kP4pnk5Exl2BbyBtPOGg/cYAUau1r7jbLtccUfN/SpuI/rz43+
	 sYsWv1bNrKcp+KpjxfU88flsIH6b8Gyp6fBDvYrXm0MK2NZriHQ5c8foN/lsOJwiDtccK
	 s165E+hG+JSukME8tTHh+xj+EqHri0U9AJ9oV3NLoeOnug3o5apZTz1XVF1rp1OizksTj
	 aXbBlaMBJT6YfQ0fHsxoQVgMd/NeWOOi9BNAggocFGadqD7laRXQkehrIVgw6jutCnQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 124031F0092F;
	Fri, 13 Nov 2026 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588037;
	bh=ftkGVaWmlEcBnSmz/bQQARpxpmtHnb04sqbnV5md88k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FaAh4chl/Yil0oZC/EyZYFF45BoK7wbj8rYXoVVSOQsksOy9+Z4iuZp2i2jPy53+X
	 fr4F7IPuo3rrMRgTyecyN8ttAp+ZmljX6ghER6avcgi56iP3zhhhKGbzP+r+s/z6KG
	 vk2SgIEEE5EXvxB+Rh3KUgwpKh4qz+n0zylyE1gcbQZau/dtaJfcYPpihCjtQgBlXU
	 pAPzpQMbQUIIMZtkT0aKvXcM8uPZccNR1V6ezt165w8BSGnqWCHiMLb4FaJhL/D6X+
	 A2mERFdOhMQERa/kCaRCVKhZbXocP/44tPZKxzsHY3KHeKiQPWu5Zppw91UA1WtlY6
	 O4K8NM+QDaeNw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C800749A03;
	Fri, 13 Nov 2026 16:40:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:40:43 +0000
Subject: [PATCH v3 12/12] arm64: dts: rockchip: Add the reset lines of the
 RK3588 AV1 IOMMU
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
Message-Id: <20261113-hantro-robust-v3-12-82383c722ad2@gmail.com>
References: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
In-Reply-To: <20261113-hantro-robust-v3-0-82383c722ad2@gmail.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Andrzej Pietrasiewicz <andrzej.p@collabora.com>, 
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-media@vger.kernel.org, iommu@lists.linux.dev, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Tharit Tangkijwanichakul <tharitt97@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588032; l=991;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=N909YZvJDjc6Eq9/44zn9avdFUylGlgxFkCrBk5+cUM=;
 b=BQaN2uqxim4dpFhP/YfDh38Y5VbQnw/qqCKpdYq505D02a2a7pNhN8nd1rWuZzk6Z/6s7djyT
 2zG3b+iEGYwDzl3rfH1HhcujKURdiCZ04KKgu5HoqY+GBRm4100xBmA
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The AV1 IOMMU shares the four AV1 resets with the decoder. Describe
them, so that its driver deasserts them before using its registers.

This needs the decoder to get them as released controls ("media:
verisilicon: Acquire the reset lines only while using them").

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 227465d446a2..96898fefe840 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1491,6 +1491,8 @@ av1d_mmu: iommu@fdca0000 {
 		clock-names = "core", "iface";
 		#iommu-cells = <0>;
 		power-domains = <&power RK3588_PD_AV1>;
+		resets = <&cru SRST_A_AV1>, <&cru SRST_A_AV1_BIU>,
+			 <&cru SRST_P_AV1>, <&cru SRST_P_AV1_BIU>;
 	};
 
 	vicap: video-capture@fdce0000 {

-- 
2.55.0


