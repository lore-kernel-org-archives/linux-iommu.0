Received: from out13-173.antispamcloud.com (out13-173.antispamcloud.com [185.201.17.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD530F95C;
	Sun, 12 Jul 2026 22:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894034; cv=none; b=iS1WYimPBJse3UZfuH19bOs5v15iC/0QiFIaIVd3VZ4hYNedjtF7ciBzdTeXI2kplj/KFHeBNQ/GDfO6Wd0JgNKuXt150NIMN165UXl3exu/eVIf6y49DRvsUtT0VvVn9KlHFmv9uI16sZY8WRFpxZmyyw6CtIpp/75sNj0RQII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894034; c=relaxed/simple;
	bh=C0N49oshx87g0IoRZILja8XZbKFzwzuAxoXJeIhvICo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtKMgJ5xik2oE+ICcgVkr5dMYLS72fmAAIj9Q1GZkx71MKJFfyD7hDzLsIKAkVxeVWUjBM2Zdnr2i4mIqKdz8ezqk+aBG2VLIskyFaVwA75BIcAZqmkbL4QvkkgRkTJUHIHGZL7Fym0iILjsSllNYNGoQ6T84eteuWmK2FwBDps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=aoKcojZR; arc=none smtp.client-ip=185.201.17.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="aoKcojZR"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx199.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1wj2KH-00Gan0-Iy; Mon, 13 Jul 2026 00:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=U67P9sBZlm1TqULX82yliNZyk22cqhSD+9K5qcqcVzs=; b=aoKcojZRMHjYSWcWF3g2pBV4ck
	iCRmjNOyAHKLrIfHDC2QkNH8Upd09B+PPuv+rzwrIDWzBpVRJ/1SjfgDArkqnHi7atxH1PeWGqI32
	RB89Oj8XnXCTuch36L7GPKIAeSg4N/G6wuN+fO8ePf+DKnTiwDDxviPBb+ZS4l2Xl1N2TV/DiGHyi
	lf6XcVuFWAJgDy5WgKN4mpfq2PhcD8Lto/C9/zdyk3lsVtZbjLMcf7Hw1e/l2CsILGK8bQFVwE7vI
	F5zCpg1L1haJuA+oWpCCQwqps8L9D6FSF0n+9fXz9UCvGRuic2MkYPYR6vO5bOl6Rv6J0W4U+ai4x
	LSGBIjkw==;
Received: from [188.251.249.2] (port=43526 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.4)
	(envelope-from <dan@reactivated.net>)
	id 1wj1a9-0000000D6jk-0Cl5;
	Sun, 12 Jul 2026 21:19:25 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Sun, 12 Jul 2026 22:18:56 +0100
Subject: [PATCH 6/6] arm64: dts: broadcom: bcm2712: Add GPU IOMMU and IOMMU
 cache nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-bcm2712-iommu-submit-v1-6-80e10cdde2ea@reactivated.net>
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
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00641874052884)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuX0E8hk8bGvhU85OUU8HztkUWQYKwJLRxCX
 EaPAyPergyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOrsK9eXVzfCzGPGPoMTsaCGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCulNo0fvnzmZPW3MC2/ZtQeB7itP8hgjDRserKv4bhb0/SRhwoSlflSk9103+2bwRWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyPIv7c2tg
 uiTnO7hoWdxS2Euf+eM3l5KPnbp/eQthjVPLCh11+xKgET3fXj754wkhoRweeXUyelEFumxqJC98
 W2Chcvueb7X9IVOP0nXi5ScUGZbDvQNAWVsKTgEVkGFZkrTBb08hz2+hQWIE/jMJBRjlXAPIIi6r
 dxgy5Mnu2cDsZps7XJtkUNhIi117bsGJ7ren9RtRNyYim5e3GD8LGWaC0+QPoFNxyOIq8TsINlji
 ymlRNpReZ1I3el/0lzrWvCrJPmnnTHzVkpybMK7ZTQBnhkC4lsDj2Rvn3fRrBZxIEqAi0wzqTkXD
 hL9Md9nbANC3664yGzQgQoWOdw5uRoOUdiQWureL08h33lnlzu8Ruq5JZegAD9AgQAuseEpn6J1f
 hOzjF0b4LXcjJZ5louj91d0NzavE6T3cSEf434pMCXGziQTrOqTQXJsob4ddqgn3ypjdlCtgo26+
 mqlSzX9cL6FVYpUXP5nNGNsC14UPJaLjF5nzmoW2327B0dq2KuCxOqaKSWLrG9Gd2Lbs3JeGxr8w
 KgLcAwzfYDEUde1+6RlO7s/UIdgWJf6ThYnP2vOLIIdMquvnSg+lakyl5p40UVQkY9GtqwEL7MvY
 hIC2glO0k793IyDbSbCg0NYrXPWlFdaGOH191uXjgjQN/XHwvKE5abNWblSagV+o6eb6eYX62ubn
 bfLcFvSNqcD5JKSje/U6aGOkDsjrr+KNgwCeIZyBg7HvH2nIa17LbgjKuFO+2mEj3Ei2hTvWconv
 l0zt//GunbhmdTieO/Uj4BEIKHNsu7wu9bE4ph6wePERKXVqBsAqpP1UojQRo/+LmbN980q6i5Sk
 EHqnd7VhlgCeIZyBg7HvH2nIa17LbgjKuFO+2mEj3Ei2hTvWconvAY1vt4HtHvrvgGmkJ/UDfw==
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

Define the IOMMU and IOMMUC nodes for the Broadcom BCM2712 SoC found in
the Raspberry Pi 5. Enable use of the IOMMU for the graphics/display
block.

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 761c59d90ffc..ed3178db8acb 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -626,6 +626,20 @@ pcie2: pcie@1000120000 {
 			status = "disabled";
 		};
 
+		iommu4: iommu@5200 {
+			/* IOMMU for VC4 (HVS & MPL/TXP), Unicam, PISP-FE, MiniBVN */
+			compatible = "brcm,bcm2712-iommu";
+			reg = <0x10 0x5200 0x0 0x80>;
+			#iommu-cells = <0>;
+			brcm,iommu-cache = <&iommuc>;
+			brcm,iova-window = /bits/ 64 <0xa00000000 0x100000000>;
+		};
+
+		iommuc: iommuc@5b00 {
+			compatible = "brcm,bcm2712-iommuc";
+			reg = <0x10 0x5b00 0x0 0x80>;
+		};
+
 		mip0: msi-controller@1000130000 {
 			compatible = "brcm,bcm2712-mip";
 			reg = <0x10 0x00130000 0x00 0xc0>,
@@ -667,6 +681,7 @@ v3d: gpu@1002000000 {
 
 	vc4: gpu {
 		compatible = "brcm,bcm2712-vc6";
+		iommus = <&iommu4>;
 	};
 
 	timer {

-- 
2.55.0

