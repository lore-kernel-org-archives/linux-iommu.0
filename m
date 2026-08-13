Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FACB3BBFDB
	for <iommu@lists.linux.dev>; Thu, 13 Aug 2026 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613251; cv=none; b=Renp+ji/bV1NpspBuUCQrFgKSaF7MFVDAZCFHrKqE12DE8CC2q0rKY0bRmKB5WK18WKiUTuKQexgK3G/592zqYiZSs4NHiyGeWKNjsvGSSSj6E/qYhvObR7XUPGt5NCpZxQDnrZb7ynhDhHv8qQAOZWsSRQqrSuz7RZDSeaf1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613251; c=relaxed/simple;
	bh=PzXt9fO5ods3LYBlDUJ8bo6GhZCYWvmTmzg9jvrmsIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYMNnocY5JbsIsR3EnhUWVFtjoYbt5JWNlncrxQSzHWauexoSbnAziEL1rD9J1P3TB1XryIbsOM3CSiVRdla1oQDBwRqhMKyTjKFsomQt2IZL/VyeBCo1FBLRnNUA5FaHCna42U2JFNgJJTAnd1ndoOoDB95kqoDGCZ378FsI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=JchNOQX7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jEpgy3wT; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="JchNOQX7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jEpgy3wT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id BCBB013002E3;
	Thu, 13 Aug 2026 05:27:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 13 Aug 2026 05:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786613246; x=
	1786616846; bh=c8K+15YOUpp/urrn1ei3bbHIw6RB2VLNWq7MiAQhpqc=; b=J
	chNOQX7cEmymzrAnkJA7lvWYy1imq69zWuKIU7V8Kk/eTo76f1c03s45OJRKvbui
	R2VskZjmr2BLe0AcOBEQnvlcDD2ViT8fRBOm1WlBOTL2p6jEfPlmNyWS414C4yHk
	iyfoxHkqHNqCue0zm1Lw41EPUGG5h9lJChx+YZ9wJqdjINC+cS1lOgJtQ3pibKOP
	ea5rgROYnBq36uImEwpUb1rbaCwnVB66WSWqSDTe3p3aDKrTjcMNOyGWUAw6ZOFp
	wyBojU6Jnb979ghWWqtN8Lrg0OBYbvyl5MBpOclsoWFpEXHDRHMiIroZ1BR0fvKX
	l6LH43UN88W4zASBXj2jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786613246; x=1786616846; bh=c
	8K+15YOUpp/urrn1ei3bbHIw6RB2VLNWq7MiAQhpqc=; b=jEpgy3wTLbg+/gDI5
	mUdvggjWKy6dyYlYxQGxRMXJRm+2t48ub18tUm0YShpuE6Bx4nen971VB4xEFBEW
	ksB+EOqcEym9p0Vcj43YqHYmWdfwNIx7BBn5WHY0tbiuHtoCRcWs4q+CKpL5+84P
	ibQ2CG90ADyWsH0NmyMHIimYlGu1faJxqRLCZwUWYWhNsPnR05jhN+8vc5vXTJ63
	/NgHYSa151nwHuYKOTbiPuk46j9g2+mQqRyLUOMjB6uI8GKOVkDomXutzohb5SCY
	eKVRiiM2Mt4HXGXZESlun93gkkcABA+Pp6ZlxjQyWwI+JyLZAeyZKbHxNc11HIeV
	Nk+YA==
X-ME-Sender: <xms:_o19atKDrgbiDyHeg4Dq8gSr4IB1dYjlvJ_hJVlhql_XpiTTIUMsTA>
    <xme:_o19aigYuxWhvVLo6jCySzHSQ187dEvsEROWcPAw30KOmfg3c1ybLiA0Nj9dad4I0
    oSXi9yLwxMcPpf9wzdnoBjPvb890VgnTaPW56tk2F8cBmaMaUJZunA>
X-ME-Received: <xmr:_o19auN2PB2eZ01dHarhyxttOujtwYUhFzXwr0CT8lcFi6LQsX_UvwlMsUDhNWAxG5waLz4QpQ>
X-ME-Proxy-Cause: dmFkZTFuCr/cvrFkRUf8ITKF+H2T3+BzZRnX5rHf6gKXH/26Iw/KHABBcdjKQe2rhLwLS5
    TaMb0vpJrni78/UwkRMYpJ9Y7lQ366meAvyCdu0npRBw9/+Ng04388nGiPzu/U5RcyuVkR
    w/TOPVCwMsGrhPKD7nbP8LRzzGM0lbM3SZ8Ad5ojSL3i2CqcoeXL16oisQiBvGK1YuUf6e
    uoh2BP8y5PIY0wC8ImE4FS2TzpbIDM0wVbhBoSSlu3QbvNxjHls85NMxx2CqVfR97FxXk3
    CFEuyzwYAZcFXpoBx7S62xcdOaonv+ExSnsiZJRLGbhC1b6pOSRjs7Svo+R2b3hKW9mKY8
    ff8adf94ky3Th4lwWzeN9rVN55lR5BCN83BH2XboF0N0hZPmGbtSUFymvQ9zOQSbsyWIY/
    VDSff9/Gv2k8R7aiIKcxzGoPdcyKPUC+M8cBRvv+AW4DoQtwpG+SsVojaMPy7fMH/FIPMl
    mZxut+vppC3vo4kSlJSoZydKFkphNdd4tT0rDuKywn9VOAC8GEQVPx/Zwn3hOWuKanX1PH
    xqSJxuTSd2tXlkqtzwj6toj9LsJnGXtnEsfIvn3BKNMmmp5W9VoltkjE598mu+iCaf3XFX
    g4HHN+v62CHSn+Qs6deFpLqNDHGdTqLBwdYYs1lLVuMqbNth2db31JjdXpzw
X-ME-Proxy: <xmx:_o19at4OC3XLjAlWPr4JsaetVpAuO-lO-YS8tr-SF4S1slG89839SQ>
    <xmx:_o19alnOZdx7cPWnK9N8eq_ZFexjF4V8AxzqAxonshU04tsDQWgJ6A>
    <xmx:_o19atKbSmTfla4cszXQQNGEOxmVYe6F_Ti2K1o_nwP5UdwY0UE4Iw>
    <xmx:_o19atSmUDcAgqSYh74X3ZEJHbmjqeroQGjGFhedL5RY7fFathqyBQ>
    <xmx:_o19ak1HWZygJY6_xiu1kRMZibI8SVyxZkx-BTKgTZrxH4wDTjTJxPEe>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 05:27:15 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: diederik@cknow-tech.com
Cc: heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tomeu@tomeuvizoso.net,
	royalnet026@gmail.com,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v7 04/10] dt-bindings: iommu: rockchip: allow the RK3576 NPU MMU clock set
Date: Thu, 13 Aug 2026 21:27:11 +1200
Message-ID: <20260813092711.2568595-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DKMWKH7ECZZM.3GL6MUEUO2Q1N@cknow-tech.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com> <20260812094106.1391698-5-gahing@gahingwoo.com> <DKMWKH7ECZZM.3GL6MUEUO2Q1N@cknow-tech.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Diederik,

You are right, and worse than that, this is the same thing you asked
for on v6 and I told you it was fixed.

My reply then said v7 would carry a compatible of its own and pin each
side with an allOf. It does not. What v7 actually contains is a
minItems of 2 and three descriptions ending in "RK3576 NPU MMUs only",
which is a comment, not a schema, and it leaves both of the cases you
name allowed: an rk3568-iommu with five clocks, and an RK3576 NPU MMU
with two. I do not have an explanation for the gap between what I said
and what I sent, only the fix.

v8 does what you and the bot asked for the first time. The MMU nodes
get their own compatible,

    compatible = "rockchip,rk3576-npu-iommu", "rockchip,rk3568-iommu";

the enum gains it, and an allOf pins both sides so neither can borrow
the other's clock set:

    allOf:
      - if:
          properties:
            compatible:
              contains:
                const: rockchip,rk3576-npu-iommu
        then:
          properties:
            clocks:
              minItems: 5
              maxItems: 5
            clock-names:
              items:
                - const: aclk
                - const: iface
                - const: npu
                - const: aclk_cbuf
                - const: hclk_cbuf
        else:
          properties:
            clocks:
              maxItems: 2
            clock-names:
              maxItems: 2

so every existing devicetree keeps exactly two clocks and only the new
compatible may have five. The ", RK3576 NPU MMUs only" wording goes
away with it, since the schema then says it.

The DTS patch changes with it, since v7's NPU MMU nodes use the plain
rockchip,rk3576-iommu string.

I will not claim it is fixed this time until the patch is in front of
you.

Thanks for catching it twice,
Jiaxing
