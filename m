Received: from out16-31.antispamcloud.com (out16-31.antispamcloud.com [185.201.18.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F8D233924;
	Tue, 25 Aug 2026 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696598; cv=none; b=FhSnwBAuSljN4mrn8tX4F91j1zJWwSV80hANZXz9+TCrw6VVjkGqmCuPc2HRwwfSF+yQzi3oZD6+c8p3LUUq02RfeqAiIkj7dxj2gLvUWy3ha1S1Ssu8B5Cht3iLKUQERn2zDDGDiZjUVV6zdsp9qmjdVzImAFIpXIoVfbXt3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696598; c=relaxed/simple;
	bh=jhOSHKKWvdGf+373qgi+uNlImBVNl8of8Byvc26bMTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c+YOvYb3PmNq0CtbkJpVJ7yqcvpZNpZF8KLhiNeriSu11rFdTw6KFVH4n62xIyHZJ59b3uuMDhWYcyg/0RMirFl1fTU4WiUFQDGm1y0FOrb3nEtBvhihDYcEPcUJgMu6g82mB/uKnhHMb8M+/nobHxoCaYxz/h8NdiC2TqpJ33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=lDal8ZLn; arc=none smtp.client-ip=185.201.18.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="lDal8ZLn"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx321.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1wyyCt-009yCr-De; Tue, 25 Aug 2026 22:57:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+U98VHTJnoCJClU4vtKi3XydHHa9Y5G8dke5eY353k8=; b=lDal8ZLnh5dmyAq20fBfmuv7MY
	l4i/pW4yYCw/tmp7TTXfS9nGQnC2lJR1/MOYFPiSHJmpULu1Or0FLFSyINpcbc7pQXtYGbJsP014h
	6y3t+oRrRZgzswOQOTIPszs6Nx6v/iZZM9vl/B0vh+zjNJTe5qM/k6A2/WIbyWsV55rURi+7bhpNI
	PskTXI/jjCJQSxVgVjGioZjLJiqKP2byp+kF2nAx0ta7hN4tI4yg2SYGeKAyXdyOL/Z0hB8MNJACd
	ombvQdIN01QN7hLvlpcjFLBpJ+tq1INm7CdGIikZZTSkYQZiALTMDxRjBxyoS20Fc2IYp7gbBDL/N
	sbDsaUJg==;
Received: from [188.251.249.2] (port=59110 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <dan@reactivated.net>)
	id 1wyyCr-00000007Cd8-0I5r;
	Tue, 25 Aug 2026 20:57:16 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Tue, 25 Aug 2026 21:56:08 +0100
Subject: [PATCH v3 5/5] arm64: dts: broadcom: bcm2712: Add GPU IOMMU and
 IOMMU cache nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-bcm2712-iommu-submit-v3-5-7f143e7289b6@reactivated.net>
References: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
In-Reply-To: <20260825-bcm2712-iommu-submit-v3-0-7f143e7289b6@reactivated.net>
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
 james.quinlan@broadcom.com, Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.14.3
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id: dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00684167432342)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuVOT+A2Kg7Fq7YwtVrRLGVygN4JWRjTqyvf
 DSrj/vbnVyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOwqOrUsWnwk6uqkD8xcwQBGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWD7cCGtDjbxRVgnsKOrWMc2eB7itP8hgjDRserKv4bhb7ubyJcscJCC/8jhyq4eIIJWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AygJMVWPun
 1fB37VxVhASG8hN+IElQvHervZEzNuSEoswa+OggXLEoEANlDvY/gFZy/MXBXk8D5mjUeQRayE6u
 dz97s/DG8E3upRpJ0bS+wzRBHUR15RaqDwm4ioO24b2V/xoVM7xa9YKQVz3PCbzL9B0khM/Q6RX5
 n4wBXe4eJbd26ZpMsCKGEUNQoHD1dBwhSjvFGee+Sma/00rxpBtmA6JtX1tl9hlvVkB9JeTcvfje
 ogVSYoS8EzjRInfDtnb9xonw6auRGB+OqkfrxZvcAu63p/UbUTcmIpuXtxg/CxkM6Ccrh6NgeWPZ
 s2GGiUiSf3BA53ZrBURq7d95Cv9KDCFTYFcUbz5aS+1lWj4m3FNu1rSqDrVNGOYEXgKxu9VpMkhE
 mWb0+yA4G0yKmjhEqma1+/4Wol0EDMzOaSXdF5ul5d/P34eiOeGg3eceP8JBR+Z2rauNhtOAipyU
 VUOpJpoR8LmZMG0KW2fLvmDcwq5ovx/jotULrGAMzuIdJELu9Wrt/oF2ofKYeezPZTW+uJOuOlF5
 x2YtjfaUnDylc396zd5b9fxPYcgbuN9DD1eMzs1Q66kV+UAovquwsOu3XxP+6w9smK/hg5o9u16q
 yIzlag+DgD9xY7Yj7fvC65xWAU3TJceJXG+jXar6FtDTl6SazWHDhW0k3iY0Nxd1+egvPpyylyRk
 sDtvh9EglVwlBP3PkVHlQGQFk2KBEkFw3+vw1RS8zKP8o2x05FSSJsC7k+LzVpQY05oubiJ9GrzY
 ++DuIQUs/5JJj4C/n4CILpFTKQlqbzX/LSb50zWeMLtz8gacq+U9Dqtm91PWIuQm2xDvQwKzzdsI
 7TYy29zNpaJfN6DTVjUszJAalIcW0Bh5dbygTK7jtNAOpOLoYrBwYYKC6XIWdfPsJXrcrDW6vfdj
 zQ6YC7Heg3Xf7O1TOd7yUx++SDY6V9XDGiqeh8jJhxFbE1QSjfwMTndprmVkWxS1mi+nw+nJxqi8
 G/0EWIVbz7StnzDMV8fRd3yoW2k7yN+hG4BzNMiSVhwzB5XeanNHf6G/7NjKIViWFaEeldR/m2+i
 TN8ji+Mhbk3TTo2Lw6nIoDr0sXUZ7YZoZ/GZ+slJL25ATsZTVifNjYlkFmCz0w5vcdcHI3py3L8t
 PqWAmEN/CjKjK3VVq9SDkpBDU8/nN9BMID38D/++xf97O23y3deP8vNnmz84mDUvZqxnHNc/wp8s
 bbUui5b8WkACIg5AB/ilm4apSU2goW8TQ8+z0w5vcdcHI3py3L8tPqWAC7xZyfryQF81aCkSJYKS
 vg==
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
index 45aa8ec5e2b1..f40651ea29bb 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -626,6 +626,19 @@ pcie2: pcie@1000120000 {
 			status = "disabled";
 		};
 
+		iommu4: iommu@1000005200 {
+			/* IOMMU for VC4 (HVS & MPL/TXP), Unicam, PISP-FE, MiniBVN */
+			compatible = "brcm,bcm2712-iommu";
+			reg = <0x10 0x5200 0x0 0x80>;
+			#iommu-cells = <0>;
+			brcm,iommu-cache = <&iommuc>;
+		};
+
+		iommuc: iommuc@1000005b00 {
+			compatible = "brcm,bcm2712-iommuc";
+			reg = <0x10 0x5b00 0x0 0x80>;
+		};
+
 		mip0: msi-controller@1000130000 {
 			compatible = "brcm,bcm2712-mip";
 			reg = <0x10 0x00130000 0x00 0xc0>,
@@ -667,6 +680,7 @@ v3d: gpu@1002000000 {
 
 	vc4: gpu {
 		compatible = "brcm,bcm2712-vc6";
+		iommus = <&iommu4>;
 	};
 
 	timer {
@@ -701,5 +715,6 @@ hvs: hvs@107c580000 {
 		interrupt-parent = <&disp_intr>;
 		interrupts = <2>, <9>, <16>;
 		interrupt-names = "ch0-eof", "ch1-eof", "ch2-eof";
+		iommus = <&iommu4>;
 	};
 };

-- 
2.55.0

