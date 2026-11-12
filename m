Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468107;
	b=04flETiL6HFjQgJX5VNAq0cEJtp1s7SkJhKgkDEITfNAoUVeJyfKhHE4GESZUeunj+/Y
	 IUihhGyWQqgVejEfpFNlxewtYuWUD+rlBiPODMalwtlRGZR4Vtu3NIo7RYgWtqrZt3JHY
	 xKSBdnNYWwnVSWiNq91uanjg3ScmSJr4Mfsnub08x5OuvhrQZAPC62uvX2jMIh6xCCQvI
	 OTfAZYTNmBZtq2R5H8Emf9xVTgSwPhgC/y9l3pSeGXKTQ5PRZZ59ZeBMsNd5+A9cLwhEO
	 jCg7Jr7kVlL3AC9Beo3PMMpYdmJt2C/uVDcYZIp2E20+3m1RDSxH3cF7Du25IDqu3nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468107;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=/aOs23e7QQCLKmjceydNMayYEdRUeyCwIuXTSXDmxCY=;
	b=pdFUKbM6qOxgKkJ2tGy1YxlK3RDLXKND0SkFFGaYi/H7Jz4HpuJhdCli3Cratnm0T9sj
	 CaolMKWx3RZCs1fnGbGt498z1pHAi1SCgSglHFCDgWUoH6AqkIAsLiUqlqjoz5wB/Xn0C
	 8vXM6rvKO2Az4DcvKaRKrTCyjx5NXX5BymsTIqqzhK62ukRsMtrSZVEy3tom7ljKDYR1q
	 dMVAXX/n+AhuAEOaFvO9E5Fr0qESg6wbIbgbqCVPFT0yhGLmX7DpNGIh/zKZZ1+dlGuLQ
	 fKZF7A1yME1Q/b2GQpAJTOxxl7LJWS6OSFMqeOcnXUWV2AVJoWlgV96emfkOwJ5Oz8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=UMhJojbY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Hf+OCWh5;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7D1606A32E
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 07:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE7D1606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=UMhJojbY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Hf+OCWh5
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id C31A6138161A
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 02:21:45 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 02:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794468105; x=
	1794475305; bh=/aOs23e7QQCLKmjceydNMayYEdRUeyCwIuXTSXDmxCY=; b=U
	MhJojbY4cAiIKzf+X751/oHdycGroZlxrqjuBwWWuucaAC/EQDZnIhVH8T671Ca7
	IC2JJEqrlnpJzo7KbyoAUIjyKiVLFZMV3jbBFLka0c+LMnxeyWhUa0lPSbJCxUtH
	jl5SmfiHbYFSAIn/L3GKDczHniTna4DW0X7tDE8JiwDwHiubTK7bzWnnb4G5e1YT
	qjwnMsRKRF56pFUObPhkhkgAXeHA8uvc/St41eVeP4i5GxiAoSP9rLpo75JbmcIT
	lIh8gl+AH0uRkmIa9LAhWmADSK/e1lAYgYvok1XOHA4BvE0BGXWO1qRpU6IQw23W
	tF/x9il53FfEXX6QGam5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794468105; x=1794475305; bh=/
	aOs23e7QQCLKmjceydNMayYEdRUeyCwIuXTSXDmxCY=; b=Hf+OCWh5om9p2L2Oj
	3/wcvkJ6VC2/SbUcju5EPySYY3dwu/iDDsIiuY6yDgwJbWzLWRhIq9Hi33oKvDOu
	PJFesYOxyCPFBeZh5ezTyltt0Oa47EZdQz+7X7rMRH9pc8xfI8k89dCmgPMB5Frv
	Vawsfax/rR4p4s7v61SAk0Ht1JUOHiCskU0nBAUeUJNcR0MpMkd7E+adG2TI4z5Z
	iPaE+LXhTuLdca2ttyw0y5aKIiAtTpEZP+qYIUWx6T/Q+RX5Z+KHfesUCokXr136
	CPFgp3/CTcFn1ydMXyoJczVl2snJBf28nB4Sfcad9mF1HG5y3eXWRIfAfVe0wShe
	29Z9g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794468105; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:b3DlJNZmcvoNuWOaztsSj/1bzgbMCp6mXgAbbWAja1U3GCv
	TI6UxFuO1hKsQZGWiWmzXegedjjB6Byf/K/0H6BAZE/In6zSeXt+HFA3NKLfSVbu
	n7I4ylVUj5rT2GnNCHNUHuj8WEzDyLTppPVhIHHQfh2Qfu7Y+/2a1lFCOt6E1kL4
	YaxGiN3a5D9xgMAhrlph21ea252vs94WI8VC+sqUym1fYqzu7L2FIh0zCldpYD1D
	U7Mr5PYoE9EcGACvSZu6n9EnkKSu8j9aK+xMz/wavaXXp+PvdsYn9MxpnTrYorHu
	rsCT4TMHl0gJfP0xzqO6O5B7uPjnHyuJsZaRocA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:dIE2y9Uu6HnLr9tOub8WZVw3c3AePlzWlyUat1T5uX4=:/aOs23e7QQCLKmjceydNMayYEdRUeyCwIuXTSXDmxCY=;
X-ME-Sender: <xms:B2n1ahqZ1H311A66OHoN-mktRlG8B_0ankZd-7BcrwLvuI9H1FjVeA>
    <xme:B2n1agENmigRG7FZw2_E-VsZsyFZgR8xHMGpc3zWxdX_1H_8ETEqRIajkVHyRgWne
    lFw-ZSNhDScLRyCLaeTNXahXFBJg1FLZn-go_ZeO2yEWyZBDwlN5i9X>
X-ME-Received: <xmr:B2n1ale6EJcl-5YzOkbhnVkzqYGOsIZohDQqq84-J5uKya9NFQZJCqfv-9iA7TtzJ6HK0Yv->
X-ME-Proxy-Cause: dmFkZTEFPa/ikIisriaO4o77tKRhcPablI28CtNe/elCLig9diYpUh8uAKQt8w1/Ua9XDn
    MYP+BtAoededCx7UOhVeX909ExHT+W5b3Dfx6UlWzsatLZAj4ODaBI5BauuLSt33E7jS3u
    JMUUY3pdsA1kClQuMcyKreUq0Dk83Tw3OeICiqV7+TESuUUnv0R8weCLazSv3CyKesrjwp
    GMxT3yOUNsU9sLlfEz9yCaWNy5EVYBWBMw30/wnxX3B+qzxl4lHHnVoY7Xykr6G+lPFlm7
    p9HBW8/FxPy6yaC10ITkFRzmyBnSP2OUSEPzn54ZKoFxC2k6fZ9zIjFyHBebuTfOx/LOt1
    sgMJx99jwBu/plx3bqeiSLJMZKrxOnQqiA9o1l57xk0gLXGFKIqH+8wnOKeUn0jDQmdtWq
    GchdKvA8gSUDLrwbH/vxkmDYrNqHvQ1H1UfcBssXFZ+HN7Ga7LYBvHeOA6ewc+/7YZkd8H
    VfGjBR+DJiHH7vR2+N1Ai3Ri+XJMRZE85ExfBtsdtaoEVjtEJUIozJP5UADWTtPoyh/SuT
    1lDa1oMUcRhvGliCGCSdcV6Z/wIo83ipSCDuEAkXnBPw8RyYSvAKUw7Euyaa60BwYiN3yJ
    LaQn8iSRb3kVHI2FSyBqfhS4ijk3rZCahdP+rsYdKRjFmFPPCqC3ROXt7aUg
X-ME-Proxy: <xmx:B2n1ajadElEp1GCnr-LhNuuoqDh9czUabfNfsbWgbIJIcGeCo_dUgg>
    <xmx:B2n1ahLZ1lNigw46BpK67DqCiDF9-CtK1NlIVYPwGyEyTcsnd_fOXg>
    <xmx:B2n1aqiPmMh-V84cYLpaR0qcVaSakEUIP7qYRRSkXKhcTnrpTc8EuQ>
    <xmx:B2n1alsPyG0WXCQvTneUN-6VXNuZRHm7mFGpdTBvWqzVgzcR2wfzPQ>
    <xmx:CWn1aruzqIbiDPpgycEpUBK81Is8VqdsiKro5McapK0aXtXZdIwraUIC>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 02:21:35 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: finley.xiao@rock-chips.com,
	tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	shawn.lin@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v16 10/16] pmdomain: rockchip: cycle an optional power-domain reset on power-on
Date: Thu, 12 Nov 2026 20:21:31 +1300
Message-ID: <20261112072131.41144-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ca90a994-70cc-410a-902d-5c4c0aacc9b7@rock-chips.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com> <20261108065917.135194-11-gahing@gahingwoo.com> <ca90a994-70cc-410a-902d-5c4c0aacc9b7@rock-chips.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Finley,

Thanks for the feedback. I agree with all three points.

Some background on where the reset came from: we added it in June while
debugging the IOMMU, but found the same day that it did not actually help.
The real problem turned out to be that the IOMMU was missing the CBUF
clocks, which is what later went into mainline as 841363ebb508.

We had in fact already removed the reset in a debug patch at the time, but
when the series was put together later that step was missed and did not
go out with it.

I went back over the commit message, and both claims in it, that the first
access hangs and that the vendor kernel also cycles this reset, are not
accurate. There was no actual test showing a hang on the first access, and
I have checked that the vendor kernel has no such reset at all.

I also retested on the current code: without the reset, with the power
domain clocks back to two, and with no delay on NPU0/NPU1, both a warm
reboot and a cold power-on are fine, 30 runs each.

The VOP delay makes no visible difference on this board, so I will add it
as you suggest.

Thanks again, these were worth sorting out properly.

Jiaxing
