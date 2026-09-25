Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA03A488239;
	Fri, 25 Sep 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329664; cv=none; b=SPEZLSrcCav1ZjlKSab969uviFlitEDMSjaN2z5xLSW0jfdCBi+HCwmhVTkQ384k7KMyquh8mXXUp+vkW4PzsssXLBSxafDIRPHRvjlWsiLG025e3KZoZWnjS306Ty7nlnTnR8FcBwTJn049YTWiu26ZZ6vqW+2JVVgLA7iMVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329664; c=relaxed/simple;
	bh=gPBp7YjnBhZXB1UMvw24awBE99QQC/spIwV/x3YM9dg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syemX5ft4RoKOuHXDHqXPS7qp7TAbF/FMLNBzJc33diF3Hb3M1CenFKUHese4aCtUxT4+inFTf80el1YBwBQyivsx+57flimWFXkBdzO7ccedzVGhJ+lfX7tmpiL0+W0E17ftK8fgNUgl8ztKuuy9vtMVYTxSdlbwbUYdD9L4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=ma1i3EDF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jieGmqql; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="ma1i3EDF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jieGmqql"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1051AEC0141;
	Fri, 25 Sep 2026 05:47:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 25 Sep 2026 05:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790329662;
	 x=1790416062; bh=xnf5eJPU/Et9PwFMcHH+LJuA7omVK62KqT29Lpap9iw=; b=
	ma1i3EDFtC5xdytaFF326JimB07NoqtU5BqX4cLo19gWgib6EeRRiwEScDlLDiLL
	Ue22W1YMxj1muQypyK3k86Eu7ZI2mrHWfuiMXvSFyOLhepRfv8hdPiF3T3CaOzYt
	8AyyJ5cRHZm+aA5jj4vhlCRDxaHsd3eb4nLIxXFF6X1hothSrGGfWbEhMms12r4L
	Qz2r13UKDvXbCepr31Y6yuxVx9+PsD8y5Fyc2u0RJfuUeEpRvDY2yinQLxA/QQoU
	EUmNSJ3pttM91ccqP3BXJeDUHaW/ohJ1oYHnyoolRiwN43CteWBmuGRcVuhoq51F
	7raXTQ571t8TY3QM0YXMtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790329662; x=
	1790416062; bh=xnf5eJPU/Et9PwFMcHH+LJuA7omVK62KqT29Lpap9iw=; b=j
	ieGmqqlWjpU7LJ8qRTSaqZ75MVrZsxFft59tLtJA5XIxAFAGsQaUSaD2ebnosSnd
	9prI6+y+iIRGyYK3SAmiDY2GW9Z95ZQGGuoUK42NvyWM9fpVbhVfHLh4+onExLVp
	0ST2/g+BUZnGX88rqyS54WSugCOeOtMAOP6BuNbdPDuXTl9Ss8GfkdKPamMnF0gq
	uTNXks/+7B5lJz/EDzucM3sNV/JJS1sR7RGS8LsR6pF+CZ2XeEPAWRtf25aMNE7e
	98mxH9hVn+/zwL94EOS8dyKAOX7wAPVBnwIuUAnz5Mh55iqqwgAK69zqGC8jczpP
	jfaIr0bcVO14PVsEFmuSQ==
X-ME-Sender: <xms:PUO2anwjBsgoQBMS6s_lYyEkQlPLFvmfUXkqoNH6yMOyGcND-yLUnw>
    <xme:PUO2apwripePVTaWFBKSL9klycox-SwGf0MfRwT-pKYp3fvSPRNQSJEnlNXFvMvTX
    bSTqWeb_-stMMI2liUPbnheNFaXpZ8eBgvmpUh7TDOfg3v-UA7tuKUp>
X-ME-Received: <xmr:PUO2auRW-Gp1rlSx-QejRSIMPgCvLjlUJ4J8GN0-qB5-rOBJahgw6OU5GJICSb2dFK5BWOU>
X-ME-Proxy-Cause: dmFkZTEwps/QxAWSkagPSHBbcYwuI37XW4DvirwdiYOGwq9AEZKxmSwYz63+coJ7wZHluP
    jgjVctfghm5b5XWz2n07A9q1QaNev+5azhP7D1mIEnWcc7GyMeAKCOuAf09Zm6QFlhMejE
    gEXz+W+bKMz+kccVLYaqKBvNoAlmwe4qHn6j33++Tfk8NkCZ/4YxJmJFnYYt6bNYB5JyX7
    wU1UqpqLmMC5vJwj6KME23vX03QIuAPw+2Jxt7R/8XYigoV9KzDK+UG3MNfCxO5B75MboJ
    lkHYESZxGP1e30qhetVcIgSKr1zAlGTH0xqrbEx7tCd6z8+Rraubfup+2SsfcRLuC6VyRg
    65n2r4lP04EDjqEva+Lv6CnkWixNDvxxHLQbVKVaB4PspHezwBEjkcq1KIssSmp4TIFDeM
    BRENCV+DyyK90jj1yJX1ozSixSZ79xnPGKdSiYoLsyC0+w7CCzdjLWycMRgiLNjSDbpzrX
    ff8VTkQv3oz4mwQpBUUY07W/b7wqxiyE63GzclZiMkWjbjt7YXODY9d4qiBjVmpZMR1PHd
    M1ADvWZvKEe/X952wRXQXDgDx5281hbcqjdrsU1SBQwTP7AjIK7Xh84g6HLaS6/6zR89xf
    8dyZgsx3h3daF6TbBwsGmxeaPLFJ5dkvEcSxRJ8y8C+Jo3Y/GV3+/HIOylMg
X-ME-Proxy: <xmx:PUO2akOeapetEV41CsY3EJLQAy1fYEmKYmhw0KBj4SX-bzBHP5d4AA>
    <xmx:PkO2ahTYFxfrqTsxj44l9LXOlvwqbTZ434sW5zEgYD0fEjjMuj41ww>
    <xmx:PkO2an9P8eHjaaFBpgk-A_PvORw8E4gVCMPfS7zpsks2rvJDMZ1hlw>
    <xmx:PkO2arVr9mOtV6Y52d-milcMlptDbpO5PeJx0YapLc8N57afYFRauA>
    <xmx:PkO2alN4C6JEs7G0oo-hIfX2eVObRoOfJE3RwVumz6p-ukNXyn9A8DHJ>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:41 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 25 Sep 2026 10:22:50 +0200
Subject: [PATCH 3/7] dt-bindings: iommu: apple,sart: Add Apple M3
 compatibles
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-m3-nvme-v1-3-5e832e2f4aa9@jannau.net>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
In-Reply-To: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, iommu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Michael Reeves <michael.reeves077@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1047; i=j@jannau.net;
 h=from:subject:message-id; bh=PJAOyXjGNsPD5L2vY9Far9r/YRFBjsEABd+0I+c9gqA=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtztpHrVdM4HonPctA0unhvAjHIk+14Ictj12WfHpyI
 ftidMnajoksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKpLoxj+J5xZb7HUjEloYmNzs/qBhthn95+I2qgcef54+bEcW5/ENQz/na1UDjJ
 EP79e9kfnQJtcXTOP9NNtzzJ7PCN/eqxOkWbkBAA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

From: Michael Reeves <michael.reeves077@gmail.com>

SART on M3, M3 Pro and M3 Max/Ultra is compatible to SART on M1
Pro/Max/Ultra. Add their per-SoC compatibles "apple,t8122-sart",
"apple,t6030-sart" and "apple,t6031-sart" to its dt-bindings.

Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/iommu/apple,sart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,sart.yaml b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
index 88e66d4b13c6..015158a9676b 100644
--- a/Documentation/devicetree/bindings/iommu/apple,sart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,sart.yaml
@@ -32,7 +32,10 @@ properties:
       - items:
           - enum:
               - apple,t6020-sart
+              - apple,t6030-sart
+              - apple,t6031-sart
               - apple,t8112-sart
+              - apple,t8122-sart
           - const: apple,t6000-sart
       - enum:
           - apple,t6000-sart

-- 
2.55.0

