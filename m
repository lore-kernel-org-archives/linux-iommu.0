Received: from out13-75.antispamcloud.com (out13-75.antispamcloud.com [185.201.17.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C93E8C74;
	Wed,  9 Sep 2026 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.17.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984554; cv=none; b=FPlxcxVv8z8pA40liMlEhr8qUfu3B+pzT4may5WvoljLHCXli15GadG1FAp+BhanJIqSg74TMHV4NY+J4+p8qKhkzf6MeVe8bSyRsg8EoueQqwGyHdmivvyPo/pbAYr0N87Yi78ba+yqHiOf/npTrIB8MoS2e513a2ioKVISKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984554; c=relaxed/simple;
	bh=jhOSHKKWvdGf+373qgi+uNlImBVNl8of8Byvc26bMTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCvEi6qd/Bb/GHW6XLcOMYBZTD4SQztH+vpL7USyXWSnNv18OHmlmbCmx+CpJhgABJW+GPNHO1T+PvHhJaYcrw4G1VvryllTkgcgFDxCNdlDr/7OZ5RDisNWwfvjJSuF8OiT35ILN43ubhPyEihML3bEK2Q9IdVqPGvDT7WNOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=t2rYm5bf; arc=none smtp.client-ip=185.201.17.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="t2rYm5bf"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx321.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x4ObT-003Tal-6H; Wed, 09 Sep 2026 22:09:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+U98VHTJnoCJClU4vtKi3XydHHa9Y5G8dke5eY353k8=; b=t2rYm5bfMxYtEGkc5OiP1vQwiX
	h/sCUqxXGGZ73gyLSz/lpi/Evh9kvI/l1p46jNdbn7a8i5efVDW1kKGCO5G3mb4RIOR4i6zsYnGS6
	0j5YuXTE0Y5057eWD/lDjy43/zCw/y811w8VTcTof9BbA7gFeODH4mWdbwUQunXm8NYJ0B8oLuh21
	oHG+b/3F9uiAWoPL1vc0+nzCbVPExIQprlHdRbnZWLxn3l6QZL8LB9M6fN5ASz6JggnX50GjQTQ67
	hvQ6PpwMUs0FZdhmJ162geUFPPex0sQ8pnOSBi3pzcWSUapYSaV9sWim3Fv2wxt1mVjwOOt2VADDg
	vvPR3HmA==;
Received: from [188.251.249.2] (port=52430 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <dan@reactivated.net>)
	id 1x4ObS-0000000DWp8-1DNV;
	Wed, 09 Sep 2026 20:09:04 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Wed, 09 Sep 2026 21:08:11 +0100
Subject: [PATCH v5 5/5] arm64: dts: broadcom: bcm2712: Add GPU IOMMU and
 IOMMU cache nodes
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-bcm2712-iommu-submit-v5-5-2539c52b249e@reactivated.net>
References: <20260909-bcm2712-iommu-submit-v5-0-2539c52b249e@reactivated.net>
In-Reply-To: <20260909-bcm2712-iommu-submit-v5-0-2539c52b249e@reactivated.net>
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
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.00672512193597)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUotdtz0EqniYeLXSRPpJj4oL0aLKDz7BK4
 AmnE4PQtyyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOwqOrUsWnwk6uqkD8xcwQBGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWBp35AJbRNknLgMOj3O/cqXeB7itP8hgjDRserKv4bhb7ubyJcscJCC/8jhyq4eIIJWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5Ay6i8PhAwy
 ohd+GCGjMSaCo2g+pLXSstFFr2Pmsof7eeRHKvLDzn+sBlvbv5VnduIaCC8T432LXhcN9iDypd/G
 jBIJaw3nA0JWQqC5+Jig4CpfjrlgQefNeWcxSH+UCzbtFoUUErjvkjClnO+z3Y8BCB4GKZ8tHsR5
 A+L9kzDG/K63IFf1tTl6XjJBLr8hyqcPiIfzvuBQjcdRxCwh8eiHlonTJYQp6P0LGGk5YcssJBnE
 oCFelNEuPkquluSoEnYwJqEylk1bBhjIWUVQpiEaCXgutbnJ8XLRZlxuyGE4ZkJ+Ct1rytEV3nXE
 30Z2uRLE/8mc4sO+W8vok4IjJdnmU8DTX941WdbezDc4vvZrV3V8zxJiAh4HD0pbHodESl7kaNlb
 x8xIGSNGie95MFeWVyO9Qfhfm+3ZVXwsV2bUYWW4ep6BcO097ndMLXudKQNe6wQxb/xNrVv5jqyP
 WOQmo5yGQxPG/xMZnQ40fhcNtfvkev6/xX+U3yGuqyRgemTtQtCSvx4KxRbJEJ09WFY+0epO6OZG
 ArYx3jVR0FzGbpLboasl4DTMuBftporpB7j1TF3K4aTBfMUL3R9jex5BEvvs2fA5zL3xWHlW2VXa
 wF/lag+DgD9xY7Yj7fvC65xWAU3TJceJXG+jXar6FtDTl6SazWHDhW0k3iY0Nxd1+egvPpyylyRk
 sDtvh9EglVwlBP3PkVHlQGQFk2KBEkFw3+vw1RS8zKP8o2x05FSSJsC7k+LzVpQY05oubiJ9GrzY
 ++DuIQUs/5JJj4C/n4CILpFTKQlqbzX/LSb50zWeMLtz8gacq+U9Dqtm91PWIuQm+gHvhbUQMCQp
 BDD10s62nqJfN6DTVjUszJAalIcW0Bh5dbygTK7jtNAOpOLoYrBwYYKC6XIWdfPsJXrcrDW6vfdj
 zQ6YC7Heg3Xf7O1TOd7yUx++SDY6V9XDGiqeh8jJhxFbE1QSjfwMTndprmVkWxS1mi+nw+nJxqi8
 G/0EWIVJA/X1E5lxcDfs3JvX4rNFly4ThMfV8G5zmJNkDGUg7XNHf6G/7NjKIViWFaEeldR/m2+i
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

