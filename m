Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468121;
	b=xNNDnnkl4yp7J3jUA98eYSL8idqtBVCsOrIfLK9eFWuHHWAUndLJCh6BLNzoDFR8oT8y
	 mXftao9lcuzVGD0Op56uvlJIV7pdmnppNz5QqxeOVF3vSzDzJDrhG8/qwqVW37c32AY6B
	 cA8dBlKmbwaozZhFzXg/C6YfWhyVJGGJkW5BV0cHLQkWuok6Y1bD36EiWVEvc+AA23/gB
	 TyfHg1+IEQ9uzaISSyh/x9aY17jNVVQuy1YkUbqBHTuPPHLhCQjHWX0hDlk1AXcCpztnk
	 purUxgu/ms0/Yt6plOUBSI2K5qEHareENg0kxYtMZXG1sxZ9HzFaOTtgjZ61ksbJaig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468121;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=bJ8bCP6CSgwTUoA5Jdtpfv6fl23Ll6VoeGU8ytMkhDI=;
	b=jQosf1laPLrDJqcbsNQwKvQH8KAjLMzcnnjFChuCO02VcPcBsnHRL8BA8tHTaOlzuaeJ
	 rqpNurPFBG6H34yu6EOYxUqE07xXDl2dlUSEyMUaTgGcMhWV+/0JOi9BXxkZmdvODtSc8
	 QDnkugFsJAClgYTTDv1Dac7MaeF6EcqKrUGdBOJ1z0mdvEveNlkkslZDTFyyYiKpDf0Pm
	 LzeixDa8icymgsm2H3R1EXh1vlVf66M1sdIbYomzmRIHT9c36xVxK1/m/DAb185ogiFyK
	 qdBuUrJt6TA37DIAe9EI8EFnGrTO6zUZX0wZHpzmzkUocHNWU1WtpLc41jHE3my38Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=tF0F9SoA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yaqfQY0d;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A6606A889
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 07:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 971A6606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=tF0F9SoA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=yaqfQY0d
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id C5829138020F
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 02:21:59 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 12 Nov 2026 02:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794468118; x=
	1794475318; bh=bJ8bCP6CSgwTUoA5Jdtpfv6fl23Ll6VoeGU8ytMkhDI=; b=t
	F0F9SoAH6M1Jmttn0BNFQF6wa/hS9p9c1PyA9ks+/9eTHeBsYHoJArnY8GZoYJmS
	/yt/X0KuLwZW8kWuoXS6twE2a0qfyrxXNRGmIdaphZ865Zdsc3syrj9kZLzWgw+F
	lZYQmdNPlh51PXnqyQ29bWm15B32QT+R9hCWFrQ8s52vIZy1+/2O8UlwghbBnMuQ
	c0j24paUuPZJCgxLdNHSSjkc9ntZKe+5wWCRCawK8SFfWsNA7bUdBrv/vBY1fzZU
	eFvxT0bURa0p33j4GkcyGWk3I13JEU+BdF979A0/7Myq9FNoo5FmVJwiTvwfoxXt
	6BTBXgtiZc43W3myuxPig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794468118; x=1794475318; bh=b
	J8bCP6CSgwTUoA5Jdtpfv6fl23Ll6VoeGU8ytMkhDI=; b=yaqfQY0dFDD/zQDXH
	fa9Wmy5pWzxphmoTfhGWdAY4CWIfBliCgnSSkkMtnn17G1aMwI7E3rnyo+ZZb6wP
	vyw7/y2HogD81EWymm8WAQdzTldcb3b5TpyzbZE8Ln6bTCIJv0WnbrdYlC+I1y0Z
	I8j5UJpRHuAXd2CMjSO8YcVFK7ZkqHvCD70gkc4gaeYN83G1Z17FL5HpNJb5rCi5
	MGeMbL9yS7uwuf0Qt7zwwOvFS2491yr+B04lHPS0lzPH1uiV6YXoBQlFMTTGpKlW
	uSh5RKQ7I1IBQE7DwU9RfdkUlXpRapzbIra1il9YhOSeHT60OJQ81iAike43l4cD
	qU0Dg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794468118; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:Jsg59hp2IgIt7m+1ZtSQYjhZ3OwFLOZEcKP6xH442O9TlPQ
	W3DxC3xKh+NAjB6bTom+JmIj3HzbPov9B4g58C/FVDObWMz1iACebvtBxR24jPJd
	R3329MJJJx+kmdld+5BV7DaSgYibm5MGBbpY+8x+toRThLYKnJcEbREpQmuAqkRc
	uDeZwH+SZejBOC+mS1Ow6k6EKhzKFDiJKPveHcZG1n0qSSAK4u0AYFSvR46Ht4Iw
	QeHoy92lEaFroTkuh7C4dISpsAnlBrljQeQvy0rFDCyYmHd4HPTVaZrGAIN40LCD
	SJ9tCHli6KTzyr5oT8auOGdlqZEnsSwog5+8V/w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xuxAie5g+6iRjBprhGgdJCyhDhMjW7s+lKKHIWO1yd0=:bJ8bCP6CSgwTUoA5Jdtpfv6fl23Ll6VoeGU8ytMkhDI=;
X-ME-Sender: <xms:Fmn1ahqt2i__S3t7VvjOrolKTcZTzWIO9Ft1sy_kHoBpWb2kGnoXAg>
    <xme:Fmn1aqd1uZtVZuZdtUBboJ48SIjUmggzXUZI6xF6StzTUeq8g1Nwwe7kMcI9kVrGZ
    HlkzW7JBsOWynfbajCgqn5rtvqi7k6xBD8ALBgXrwARL1uzcYWXt2c>
X-ME-Received: <xmr:Fmn1anK4LBOxBOc2_iI6ucfoGI7MgN9u_9HzmtYFDfbAMTt22u_pQWU8maFuOP_OWsPnFrf2>
X-ME-Proxy-Cause: dmFkZTFmFrZJuGg63UB/F32b8s4zaNC9XRPHixjcDy/1vRk99j3V/8zr+THDSX7svlTEmy
    4dG1lJL3583nXtEoyQR6vHI3FPNAjfS21CqW0k2k5cqZ6TEkfUZ7yQZP7OGrUeVIb7c94X
    pjCA4kDO/W68xNy+tBda21RUbJBqnVTo13bxuqEK4DXiqGGhK5YkgbNkV1B+oHr7BuxNzL
    6gcR6FSGRDK+sNbEjPHIzQmGts9QCYc0FS6HRQLTfllqbaGvOHcy25AxQ3fsV8kYeJqbUj
    7tVHvFDs9cT8uJ4rYzEmLPEKorO5JjMbXdlfCstWJmUKho5t5lQxrSvoMeGxIT83vk+OFg
    oymre8z6E++IHi7zKFs6Qov/bFKiB7eSCarIj1JByykDyGDcJIcME12Yuyid7W/v7bSAbB
    LOH4BVqyVHo5cT9cFwsbTTdnL+Uj8eB1IAcwu2L7lR9qYchicjJzG1wi0jgWnMp3BYOoF8
    s76ocnS16UhP8orLeETzE+jzEtLU/P2SI35DjW5ksOmenlWKIlOxz6qp6KjvKtE8qRhQPR
    /lLUKdbgnrfV2gpx54przCT/IlygE7BcK4fCrGNxtoihP6PuhL6FExioYnjC1pbTtD73rk
    oIBpknCPShTMyBscXFsE6BhYclqKbyrJJ1bMPbn+4dl/f/vS+dWgzzOiT8bg
X-ME-Proxy: <xmx:Fmn1avu_2lSgVeR5VpguZSSSn2NdBdOLsGy0vv1OTRYkrMkpby07cA>
    <xmx:Fmn1alLDs25vhaf8vjWaDnxwwNcVPWkVeLmV1zG1s7SQDYYY7NmBoQ>
    <xmx:Fmn1ajA-jDLtM-goDOvOk1Rthu9AWRrftj3QaUPu21odKhGmARgi1w>
    <xmx:Fmn1aiXXlYQ8-1M-Ks5bixOrYM0T_iA4GAG52_di3rgQGXa6kJVIZA>
    <xmx:Fmn1anUq41PMEbG7seJ1o17fqqnKl6ZIxTtEfJDLEGco-ZB8ZGTAzHtr>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 02:21:48 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: ulf.hansson@oss.qualcomm.com,
	heiko@sntech.de
Cc: finley.xiao@rock-chips.com,
	shawn.lin@rock-chips.com,
	tomeu@tomeuvizoso.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com,
	royalnet026@gmail.com,
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
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: Re: [PATCH v15 00/15] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Thu, 12 Nov 2026 20:21:46 +1300
Message-ID: <20261112072146.41218-1-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com>
References: <20261101082307.151957-1-gahing@gahingwoo.com> <6777074.j6PcuT4dK6@diego> <CAPx+jO_gRtipR7iuh0D7G2Wi25GZoqFD1JHVbJNmhd1UyC3Bmg@mail.gmail.com>
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

Thanks Ulf!

On second thought, I think it would be best to drop patch 7 (the
binding) and patch 10 (the reset) from next. Once patch 10 is gone,
patch 7 is no longer needed either.

Finley Xiao from Rockchip pointed out on v16 that the reset is not
needed, and testing on the current code confirms it:
https://lore.kernel.org/all/ca90a994-70cc-410a-902d-5c4c0aacc9b7@rock-chips.com/

Patch 9 can stay. I will send a separate small patch to fix the delay
table.

Thanks!

Jiaxing
