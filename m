Received: from out16-185.antispamcloud.com (out16-185.antispamcloud.com [185.201.18.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0030409273;
	Thu, 24 Sep 2026 22:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.201.18.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289891; cv=none; b=YHlzXRhplC/EyD/HkusACFJj/L+65EbBJC6rt05QkTMLLea5UPjOVEi8wMxwDPCRiFsEiGymC6+XvqkmmnWbwQfAwx0sbcYi88eGh0lzlz43tMxx7fdMfY0+GJD/a+d0hldb+mapurBl9GU4uXpCgr8w0k0j2XviUROwCqxnGVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289891; c=relaxed/simple;
	bh=3gUNdeM74TIZEnSxvWNY4vU2DDg8+Lyg7o4USgxAy1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKujMbTLc6gbNDoxadg8CCfnV+dFS7pC05CAjql3QY5rWRD4PWytwt3E17C8nG4iH+1WS0SLPPLBEGvZybLIegaREcz7hToz5fZVqzimcGDGQnmg5xoRv3cICEhdwTP1r2SO0egUe3fmXj3RovyRf5+X0sCbVMNTYX+xHE/xn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net; spf=pass smtp.mailfrom=reactivated.net; dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b=L7H03mcF; arc=none smtp.client-ip=185.201.18.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=reactivated.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reactivated.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reactivated.net header.i=@reactivated.net header.b="L7H03mcF"
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
	by mx320.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dan@reactivated.net>)
	id 1x9qjQ-004qWk-Cf; Thu, 24 Sep 2026 23:11:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=reactivated.net; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C1HITtr+aqcZ8nFC5kDWRbi3sk+xXAlik1wHbVlwcQk=; b=L7H03mcFPZ0n9WqOJxcaksQ4+/
	n/LRugw54a8O7mlOKcMXeoob5IvaXuG6ZRp9pGeR8IdaaPGRY2fWiq8ocJIqPxceNiLVJNM9Gc/k7
	sHKZlNRu6pmFjAgO/cb0bDsrNPMiU0W0AoPtRR3MqTzp8bwiOlTCfMZt6YsqN+thDt66JXStzLNL/
	Qh2rIn6JM91NbJS7h+5YXoRIXQjL/2GYb0DhjvF0N2PWEHKMnIujWAPYJZ34WMZdXFOdSwk5OHdNB
	tfnntZBazfAiHSR2m1Xv91Zzu7rIyphaotLMkS/n3WDlOMWvzrMfn8x32i+K3duQ4Knx8PMM62yb9
	jpmkzUpQ==;
Received: from [188.251.249.2] (port=56840 helo=[192.168.1.123])
	by s1041.use1.mysecurecloudhost.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <dan@reactivated.net>)
	id 1x9qjN-00000006M7u-0TIO;
	Thu, 24 Sep 2026 21:11:49 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Thu, 24 Sep 2026 22:10:53 +0100
Subject: [PATCH v6 3/6] dt-bindings: display: brcm,bcm2835-hvs: Document
 iommus property
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-bcm2712-iommu-submit-v6-3-7b3cace86973@reactivated.net>
References: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>
In-Reply-To: <20260924-bcm2712-iommu-submit-v6-0-7b3cace86973@reactivated.net>
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
X-Spampanel-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUDtRfT7lYBuECIPudT1XzSU7TacCi0f13j
 GhHdsSURRiu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIPqgfNcPdJXvbyUpLgnF1F3GnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCfZW7a9uhvfuE0J/hsBuu+eB7itP8hgjDRserKv4bhb4rodgkl+wsfxZHakHKRaVZWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKclZzoe+TZdeH39wA4E
 grA4pE2PuLHIFQdBY9qb1rRWgyz0f29FZkQs6Ir87R/YNAvXNJYSPALjIk1CrW/D5KV6hhIoFK2v
 s7u+GDFagW/56hdY10KWDe11L7IcB8KIVAX0ddipzuikhovwj3ZhlauoCGpSQ3YDiIuyc1oArSHW
 Z6JhwV5av+XQyyDMu89o9uPImyvadeKGjjJQWSFqkLDz7r2on3wj0x4ezS7JTqLnJdXFqoCaPGhq
 xOsFLn6FXrHoC90VuIq/wzRJuNyYmlcf2wvHbfwld3xCwVQvwEuT7xKb56pfSTPBxlVrsnJIzhEd
 i2dtActm1pKPAAGnfdVyej30Z3Gx8hXfff5gZXHdar2zTZYKe+y4VTLHb4QDZyhuR1U+n91YVqlR
 fRjPErXQYEWFSqUNAzHMtoQ0XumDZdCnPPqcrsJCa26g+1p6dnGqlgoL2vPcxoHP5fYm77ZLajhI
 /osHQYQOY9tKQuYhV2zSuqRaCWd5p5K78Cq+W1w0y2KsRWBIPw9nLpbNGPtYpG55mqwMpI5BYS8G
 lSNI2Ca/iJPEUj1bN/5NYVGLsL5Qw4IB9ToecrbmmnKjrsPhPgoNgiFdcZakx1C6U9RI/f+76sU8
 wGmOnLcaeINlh4D7gY7cv0cTP3w7F74GIfFgGZTlEmqqp+HcDRtShrxrNA4br2+mEmVJrJM4fd19
 PqjIyvGxWL1rN3cWjPD5viEZJolz8ClgrSFC0qV2pwUtO92lcKbdXd1aPKEJfyZsBP+3ojxAc8lp
 0sobbdB+F7B3Y8TjGBGmQjnZT0wGxghmQiiyHai0+C+cV2SwXGGBGRJoh9VoIekQHpwUfpYnEThm
 JIBq/vl4T589Eoyw88oKKzL2dp7mRKD4sMOHD4kTUbW5J5QyAL9UV03N5ANlY/XP/nvATdPRNfRC
 ogKUBoiGk7+7TY+LxsYMBY14CoC2k4ZFj2kpuIv/9gSqTljzmaSLiwQzKw+6v3CaIMG6s7LqJEBr
 r4RYD5fnTwa0tMnLz6SKQpgZ8zVbGmL5ozttECcg597p245AIcvvY28Ycjy4wUtEPn8DyQjjJgJw
 lknA97Qqa21qj9TEJmQFcQejLm6N02F0dRgAVZw81E22mZaseAdYAUt3zF2gN7skM/50TVH1H/aA
 warQpYDOYx/6JtUORHHV0k7mR0VPG9HQWV7dXfBjXbvxH2nMLfV+SMGovieHnQDrcLDN17YMjSrM
 Y2oTcPJOcrZu7OKsSObGAqhi7iERbInMiTBIUBbQ/Dy6Ip5s2Cc9h6F0bzi9eJvFy172Pif4H4Ku
 78pBi/ZAqnPyI/BjXbvxH2nMLfV+SMGovie1ATPpp8i1sHWZQrJ+tLuI
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com

On BCM2712, the Hardware Video Scaler (HVS) is connected behind an IOMMU.
Add the optional iommus property to allow describing this connection.

Signed-off-by: Daniel Drake <dan@reactivated.net>
---
 Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
index 9aca38a58a16..8f8aae9f3788 100644
--- a/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
+++ b/Documentation/devicetree/bindings/display/brcm,bcm2835-hvs.yaml
@@ -35,6 +35,9 @@ properties:
     minItems: 1
     maxItems: 2
 
+  iommus:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.55.0

