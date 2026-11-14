Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794625542;
	b=u4efLaJR6savyVY2ig99FE2HwfA+UFwA3JPROfYF194LTOoUOoiLwBhPrQKqwZ1xDiON
	 qDfTjd3lM/vwSRLjuRIYh+fb72lEubG5WU8vJJJuy664iOjciw8OVsZzSBhHQNaaaZ1ZG
	 Jb/WpQclxJn09Kqqu7knMgpME35vz/+j3q3REgSLqE8XwhHHxImioQAN14AJUO7s22Ztz
	 xnLcVkYRduJgPCKPQgJNCHSOa4juPYBjRs5RrMCI/eJf+Q5OVyexIVASZZxFDTqeROEv/
	 wO/7z0wJcx/j8YzI7Lvtw22MUXi+0cuiyLY4y83vEnKBWV714xRmu8xPAYaB6/735CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794625542;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UAxf1tA4Cr+7QlSDXCBd5HF4p7OMrXfL6oGEmLb4cQA=;
	b=atEG5lIHEWpgSZWpug8+E0Egnp6LCHrShTPHkQB95/S8fDVZKxeTpB88FT0a5FVGIeg7
	 W72DJMdMKdNWGzdKwLsE4a/tMC+ynM7cW6kMErMt+qNwcgWdM2x+8QVl1Vm1NFMFXLna/
	 t4z+TK3S4w5CpmJOVJJ7TzoFcug/BZUVfhRby1ZuattjLgXdAvCfrS/mObQCLiGzvPkP7
	 m4E9w+NHQlievKDNv1LwylG0u9pxQJqwDJkud9wUN5Fh6N2FstRrYU9QXEyBprNogmD7s
	 Fvrh9mRAg6Pw6Y6qaKTb246Mqd9TULaSN7jCxclz+QjNjQMbsFukNYAKtLhDbxx4n1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=SLmf0B96;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=20ooXzuP;
	arc=none smtp.remote-ip=103.168.172.139
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4797606A882
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 03:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4797606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=SLmf0B96;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=20ooXzuP
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id D86621381A47
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 22:05:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 13 Nov 2026 22:05:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1794625540; x=1794632740; bh=UAxf1tA4Cr
	+7QlSDXCBd5HF4p7OMrXfL6oGEmLb4cQA=; b=SLmf0B96lGh0WKTDAucPkMFgEN
	Iq8h41jGljy4nBTL+FdQu0pDp/S9yXiE/lZVxmBMPPNrhZv8Cdxt7+nRwE+bg81R
	Vvi/4wjUBn+0L9oiMi3ley0y94fswPkXteiR74fxutN3NQCE1ZODqZTKEn2YXJg4
	a3IGa1zvp7qTXCbzXbd+AdZOqQgEsUCkKT6SbIMlXEF78wz8Q1aMHDQg7nbMOPhP
	7KYBbmcSMaTMzQDJbg+prwXsifYaK5ibE5bGj1dl7bdSW/1e1cVrL2NK0ggi/E25
	BpPHiN+NYZFKRB+A5BZ8pYCi2aDZYIuZn+CpQfKLSUux76gmTwE6UHdkfuew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794625540; x=1794632740; bh=UAxf1tA4Cr+7QlSDXCBd5HF4p7OMrXfL6oG
	EmLb4cQA=; b=20ooXzuP5gZ71GZkBepmSqaoytsS2AYyGiBJQIcPHTKQDg28C/0
	RLxMd7iVCoc6ucoidvzcn5gTwZoqgFwV36kpSVCYSsu/YCzQLqYCH5LEr/vBqab5
	6Ny2hxzUhZ3nsksyftzSyqR79byQS7PI0YtVFnKQbAZPDuLa/ja9vt6W36w9+56s
	qMbeOCL7IhWQDJ2TF2ZEqqS+7tfYKrx77eZCU3Sn2S74Iil4cQayrsWfwvC6SxIj
	qhlyf5qbA0YfDBPGFo6Kms1g53kr9rNeWZ4yiIRPcwNuMlasALi5UFTFO5kUDRWD
	6Vw1NJ/KcVQJtQ7jIRMzmqie4o539FrMuEQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625540; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:g5+B9w5xr2ikLDL6MtybdgAmJKq/RDa3n1SEyORQnceKN+X
	TwmQ9yMoUB9ZquezWwj5NGSqetBClB8sMcJn2DEY8zEXnV0LaTfPCqNLasrSJeTO
	E42XbWrPsRvvWjTRFgI00ttNe7sw1CqtJWXAjsrXUabe0zfO1uHbEetiAWfmHGaS
	1kvn7k9rCt/vG62Kji4Ytaszk9e/C7scPYQ68xHDTiRz5eJt0BiJ6ltTTAnIXvN0
	9OVjqNJsLNJ1K+o9wbbBgEmDWqQdp+pkaBGsD7ZBuVcGkjvC4LRfU3rm7tClrPlv
	rqcW/SbEtxAedxeyC+jVxOeQm8x4jdHAtiy+nJA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:SDtmj8snwKhq8a3m/AlQ2VN8lyhDTfavIW9m3/Hv9uQ=:Dxp8t0XS9CDQsuZULCGW4bCR/gfLgWevAxnrBCEXvoI=;
X-ME-Sender: <xms:A9D3angTc-jJQKx0ThFjBcTKyPvThemEnut9P74Wtw8oPCEbnZ_i2w>
    <xme:A9D3agebrEJfkntbm-8goOK0-XsiRYoNCujfEhjbpjdM46Ec1X4_VQp1nr5W5ThBb
    iPSvQy0cmnjfyUrd_jl_x3WKuzkSpPYNUSOGoftZ4QuXVmlHYc4p0s>
X-ME-Received: <xmr:A9D3auWWGH7B96NWRO8yJ7BP67qoYSODrwmYZ2-7EYDqW5XxwCwp2GvwUszfNxwfBL0UooGS>
X-ME-Proxy-Cause: dmFkZTEGsJpuk8b1nRIC2ZrNHABVA/y8lolim0B8NUFBfTO9HHBwOHtfr1x7E/bYF5Rt+N
    +fjHwgF+/FNTCnlkrazUp18/rPOl/rB3MJ9LPbCMpWMDKR7xfhSwxoxPOfrVjehsZ7rThv
    ObWwQdnjukeezJvsx5kDz3ycsHw9/RLsGLfuLEJD3Ydv7ya52aK6hdyT4N02jwdG3OB97/
    uAkfIG1lPXQjQwUOSldTArF9y9eMLQtbvdy8MTZ+DPxll8mMqe7lwyYcoBWgL6tVFYilbk
    MAUBYBkVsYjIUgH+DbbB8DukvKdVszTQM/MLV5Ry5ydTWvI5NAVGO8aCgn9iOHfgKVaAAm
    up1kE8+dA0pOwmdQtr63+CYXBeGBtrTBqHX9W6buBbK/luOWcT5tcmsOBVSzIHy7AT0XIS
    i1sZds4JFUx3zpbTCo5EdT8xqZ2oHuOdkmU2i8Up3xBOSTY3/POVhaxUfrF4KoC6Bs1mQp
    H+cq7dq/GHrUDAFxAhITR8mcFkDaXX1dftqHTA2oFN199H8xk5w/iR25U7SUnRT5oE7tUm
    pcynaSRKV1eOXdanBhPZF2mxX5XOeRgarTBfiAVIcBBTx2tZ8mQiLj5rAXFTT1mmKvw5iq
    8HNLrq5o4H7zFP6FqTUCvrgwTZ+dsaGxBqnTJxCa4NrbCTA9tfIZKfrzSvOg
X-ME-Proxy: <xmx:A9D3aqwZezan7IGAqtDx_WjYTbAkStq5wbiY39PeB8RObbHTrXRiNg>
    <xmx:A9D3alDb7fE8RwLpRRJtmCEAn5ewxmdvh-Xvu7VKAd_VIEumDIrAAg>
    <xmx:A9D3ag44kJmGA00JLhsf7K57Pk5D8wOY7VSwTMxvP8pnZ2RWIuvZIg>
    <xmx:A9D3aslmjpoQ6q5gljMj7oMNu3ZuU5jyze5kWObhF71nHilj1z5oBQ>
    <xmx:BND3aknGvxDzWrnVpXrprETPSNYjPF7oTQIq3S91xg89qomcRWza7CD9>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:05:31 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	ulf.hansson@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	vlwwwwww@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v17 00/12] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Sat, 14 Nov 2026 16:05:17 +1300
Message-ID: <cover.1794615324.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
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

This series adds RK3576 NPU (RKNN) support to the mainline DRM rocket
driver.

Based on: next-20261113

The pmdomain part of v16 9/16 is now a separate series on Ulf's next
(v16 10/16 is dropped). 12/12 needs its 2/3 to make the NPU domain take
its supply:
https://lore.kernel.org/all/cover.1794615323.git.gahing@gahingwoo.com/

Changes in v17:

- Dropped v16 7/16, 10/16 and 14/16 (the power-domain reset and the
  extra domain clocks), following Finley Xiao's (Rockchip) review.
- Following Heiko, the clock indices are now ROCKET_CLK_* constants
  (1/12 and 9/12).
- The pmdomain changes are now a separate series, linked above.

Testing:

Tested on a Radxa ROCK 4D running Armbian edge 7.3, with the v17
changes backported (this series and the pmdomain series):

- charsiu (https://github.com/gahingwoo/charsiu), an open source LLM
  runtime that drives the NPU through the rocket UAPI (/dev/accel)
  without Mesa or the vendor runtime, ran Qwen3-0.6B (Q4_0) 30 times
  after a warm reboot and 30 times after a cold power-on. Each run starts
  with the NPU power domain off. All 60 outputs are identical, with no
  job timeout, IOMMU error or SError.
- Job timeouts forced with a 1 ms timeout, three times in one boot:
  after each, the next run gives the same output as before, with no
  error.

The v15/v16 comparison of the reset order is in 4/12.

Logs: https://github.com/gahingwoo/linux-rk3576-npu/tree/main/board-logs

Known issue: in v16 I saw the IOMMU not recover after repeated resets
with a 2 ms job timeout ("MMU_DTE_ADDR is not functioning"). With v17,
after three rounds of forced timeouts in one boot, it recovered each
time; I have not looked into what changed.

Tool use:

An LLM helped me read code and technical material and write part of the
implementation. Some of the code in the series was first drafted by an
LLM, and the commit messages and cover letters of earlier versions were
mostly written by an LLM.

I reviewed the generated code and tested the changes on real hardware.
I also used an LLM to write test scripts and to compare register write
traces.

For v17 I wrote the cover letter, commit messages and code comments
myself in Chinese first and translated them into English with an LLM.

Tag changes:

- 1/12 changed in v17. Heiko, does your Reviewed-by still apply? If the
  change goes beyond what you reviewed, please take another look.
- 7/12 keeps Conor's Acked-by. The clock count changed from five to four
  in v16; Conor, please confirm it still applies.
- Tomeu, the GET_PARAM enum in 10/12 is unchanged (RK3588 = 1,
  RK3576 = 2). Is that fine?

Igor Paunovic (1):
  accel/rocket: request the core clocks by name

Jiaxing Hu (11):
  accel/rocket: take the completion register writes under job_lock
  accel/rocket: wait for a running IRQ handler before resetting a core
  accel/rocket: let the core suspend after a reset
  accel/rocket: factor the completion tail out of the IRQ handler
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
  accel/rocket: select the per-core clock and reset counts from match
    data
  accel/rocket: add RK3576 NPU (RKNN) support
  accel/rocket: add a GET_PARAM ioctl for the hardware version
  arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
  arm64: dts: rockchip: enable the NPU on rk3576-rock-4d

 .../bindings/iommu/rockchip,iommu.yaml        | 26 ++++++
 .../npu/rockchip,rk3588-rknn-core.yaml        | 40 ++++++++-
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 22 +++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 70 +++++++++++++++-
 drivers/accel/rocket/rocket_core.c            | 14 +++-
 drivers/accel/rocket/rocket_core.h            | 20 ++++-
 drivers/accel/rocket/rocket_device.c          |  3 +-
 drivers/accel/rocket/rocket_drv.c             | 61 ++++++++++++--
 drivers/accel/rocket/rocket_drv.h             |  2 +
 drivers/accel/rocket/rocket_job.c             | 84 ++++++++++++++-----
 include/uapi/drm/rocket_accel.h               | 40 +++++++++
 11 files changed, 345 insertions(+), 37 deletions(-)


base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
-- 
2.43.0

