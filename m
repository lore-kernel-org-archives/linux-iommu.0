Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795478521;
	b=WHi15D3kt0cztQnCRRwg0AL5gjsOi44yy80K9R+N8G8+YsQ6MxsvprWqM97rhn7pzOFY
	 7MguWI5QWP0wIr7c9ewjuxEVp0wOKKC4YxLSiJVRoRhI19XKGQmnzgQp/ptLReXqVaw4f
	 tr/FJId1ki83OA6yTK0BJ5QDc5eOI4qO50WEgASWELXD38zCypNfolRF+UYuFMHsFENzA
	 gtZSH1coIZR3eUISQjpWtuthPsSoy+pPF1wNfaKOyMDw0EZyFPLr9cyTC2FbpRJ40CfXi
	 y6kHY693ZROKHBkshaxAEnBIAtBf6LSLrnkdCVMt45tBJZcCLo3z9hnAIHPHeB5IrgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795478521;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KKx5Q0VuU2/e6f1PoJVzvJ/nSVlotgFqvYyL3B4vcIA=;
	b=DlqHg4lcDTIbYOWc4RQ9LlfIOWVhbD285bazmTtgUBXmlsThfR9+pcJmMr2Id2ZQQl5r
	 bi840ixSPSbn7T64lHBJh5jWIZsg4HIDwzGgxGeTS7YhVYcXdr89fH5vFMo+HRnS29lvr
	 p778+xl2eQLCs1RrQ/zV28mLfDlikIeTOmTSso7NPklc1ybtLFlWfmCBIGfOisGFgqNX9
	 xewto4Tht1+7JaNaNp24UgUsd9p8McRx2+rwMYJI4rj33p2GcGi+R4mp7ISNC0qNEcnBN
	 uyMAticcTetd+kV+Wgd7t5R4kHpySGHmtbqQuxTXzYg98rCrtug3hHmFaJzKnG/kE9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=iWP9oYfo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gQR7ZRGp;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E359606A321
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 00:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E359606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm2 header.b=iWP9oYfo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gQR7ZRGp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D437EC0B15
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 19:01:54 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 19:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1795478514; x=1795564914; bh=KKx5Q0VuU2
	/e6f1PoJVzvJ/nSVlotgFqvYyL3B4vcIA=; b=iWP9oYfoKz8vdvVNcJkyegK3+z
	oxjhFo8zLPV1e5JTMsdtpsA71/dRj2MAPN1RaxlitWXRGx2fYBQxhIKv/zgylpQD
	Tf3vK2EXGngcYtBN9c0+9kYAMut5WqBjt9Q9Z82sFd2nFb+GzYkuXjToxQcoQUoR
	3wa/umu+6zFYqVpV1ihmJ7JSK9vJvhaym9KrKY0AMjk3OEXCvsRBVf2H0kWOhrrK
	OPDpadAmmfd/LZFSHt+4nAj18BCPqcDiJmiyLSbgVdECd2O+AG+TQvJmMSJvqUxQ
	YeCsxuS3Vsk3EM3sYw8SSmAGFTmUX0cR/xTxx+We8BX+zTRNrheEGfPLMhBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795478514; x=1795564914; bh=KKx5Q0VuU2/e6f1PoJVzvJ/nSVlotgFqvYy
	L3B4vcIA=; b=gQR7ZRGpskGrnADFQKWrb14P8mlnCclct9k2/KYMVnN6Gf93Ybx
	1LU1kQVBem85ahKLYrtkst1Cs7DqG43rz6G7vcwhndP2Zei4wVHxv0ufYTjR7fw4
	kEargYnXlT/8wRI1E9TJU48GfAJF1RvIT94eNvcnRR6nNBqxRpyd0GJwjdMt3T5y
	cf83Jwy9z6A1yUjxSfP3xuYSnVJYuMk6AdkTHu25p2kOHsbJC3fBpJMZuW7elhBV
	/U4b29hoC2vyWgbB0KEMQPIOSIn1wx1Gh9IUARvZ7V0VWmw+J/dVyv4LsDaQBBR4
	lEv2SDPgagWX7x073PEYlOiufFME48j5bQw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795478514; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:lqNfumoKS8JB5tCGuMlMC73yFYMlVpJfC/YLuRTFDYgxDmS
	frjXgK+0TTDA6o9jg99W0ko1pLNgNEWGH8bIBArwfD1QKOo0cpYli5+kLSRNAT8V
	GW18wTE4QSWp8cuMYrSxTiPJV4g8HreB2777k+toSqYY9Lnmhb0KwsbqiclnOrMH
	XzwruDWxb17LDj8NBikYGpxdalI76Jk8BDMEkbbLv3SXMzZLYQ8WNecfTw2I+x6I
	Ui1r3rQAsML0+BMsKxu2qjh4bkpxyTYdF2D7pU/A3wxNgyeVkGorKrlA08KKlf84
	B8qIEaT1t4lwERdyJllT8f0lNBlUuQUT2wYzDtw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:XBkiax/mVjOMH/ql7HbN1vjdn1dgmhEk1Pibb2QZj2k=:WYvuWbIIUB3/05DuEse5xWx7f10TYxwWRMKXRK08Xl4=;
X-ME-Sender: <xms:8dMEa5Q7GFQyWfmn6M9VlmrtPHkVNST4OkH2QALO10rOkYdGcpJlQA>
    <xme:8dMEa9I9uXZbbBl6PBd5LpSWy3I5vUvriH2bzmx8NTeQ-Ma5SCHGuNG5EPzLNBAcA
    qdNubJmgBJCV6t8tmo_w7UkW-TJvZ6pGXYLk1tTHiggjpKFT4cra4cB>
X-ME-Received: <xmr:8dMEa6Z_269ozBlVDI5c3b5mczVizDJ2V8PnXiYVNlEsMffgrL4ei_qXvYG1RRtc4Xn1zYiE>
X-ME-Proxy-Cause: dmFkZTEO+jdX3VbqHwNFG1H/l5IqV/QA4KK2LxyqGkusUGBknKv3Xj1lEXrn/q0NWh9696
    uJcRyqwNAgUu1eI3+mw5Mm0lXI+Exbp4rbR7odfV5Ie/H0+KLpwyZZ9uObBJ4SUlfoT+VV
    jocDoaizgQd+irp/EWqfciQcGw/n6DFOoj1bsZAd80lRzyEqUKsjh5+A1TUQJwLoKPrirF
    8d754mQQjnz/m7I+bJphRJV6dZeDq5BGGozuCVQyiIOs/eBUa85noikxAgpdNeqSmOEuFe
    PF00S25zKkH6GNlyYmUPhzJBBYBJYmg4dhW0bNIZ1ocOseioSLu17CndKIRu5UbiZ7B2Wf
    ATDSyiy6FfIwiCqc/QL1C7jwcUgXg62S5yLczvcCP4qxN3pTTRxSVSuctoE7SO2Jv2ayUH
    0//0I1s/t/BMhQ+1jndiqqyRhZ63gfp/VP+M2qNceL7vyl9PNi1xi2PFYpDYfMk/kE2CsC
    SHGVwn9U/i0vmhucAEGBzmh6r/iyGS3AUJiio4tZEGOUlWCvYtGLJT/RdtXNjnmM3FypAq
    /3dEJc7sfWi4mEASfJV/tN4Kiw3hWAmi/mKOjZG9Cee7fImCoG4tZJPIz7HgDT/wpLuEWa
    J5ZoXeBdOSpflVemgYwT6jlfQhiiLUe1HXIWLy0L+Q13w/cGAhJRuP1cFzWg
X-ME-Proxy: <xmx:8dMEa7A4zAOKarBr9xXMWLiVNimIkqor8QYvbth8i3N05OZym_Sr2g>
    <xmx:8dMEa8XUWsqAPPDWYowJDKdh5vGsj10EcaLLAbu2IZ-Mc9cbuRSlhA>
    <xmx:8dMEa01imZHdK2-zwjv01fhHmen8aSw_yKvCDuaFrWtrL9OoLbuQYg>
    <xmx:8dMEa9XAgztFcAtfHyF-goqFUxB_ZAcGa9HN5Xxd406HjJFlpXQSFA>
    <xmx:8tMEa9HK4cR-7P3qY6agrjudQ3l39i8KhrPlp4qd2TTjwTa3bSsKA5U4>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 19:01:45 -0500 (EST)
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
Cc: ddrake@baylibre.com,
	royalnet026@gmail.com,
	sidong.yang@furiosa.ai,
	ulf.hansson@oss.qualcomm.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	chaoyi.chen@rock-chips.com,
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	vlwwwwww@gmail.com,
	jeff.hugo@oss.qualcomm.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v18 0/8] accel/rocket: RK3576 NPU (RKNN) enablement
Date: Tue, 24 Nov 2026 13:01:35 +1300
Message-ID: <cover.1795478392.git.gahing@gahingwoo.com>
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

This series adds RK3576 NPU (RKNN) support to the mainline rocket
driver.

Changes in v18

- Rebased onto next-20261120. Patches 1-4 of v17 are in v7.4-rc4 and
  are dropped. The pmdomain series has been applied by Ulf (1/3 to
  fixes, 2/3 and 3/3 to next).

- 4/8 (was 8/12), following Daniel's review: the clocks are taken with
  devm_clk_bulk_get_all() and the resets as a reset array, so their
  number is no longer given per SoC and enum rocket_clk is gone. On the
  RK3588 this changes the reset deassert order: srst_a is now released
  before srst_h.

- 5/8 (was 10/12): GET_PARAM now comes before the RK3576 support. The
  hardware version is taken from the match data when the first core
  probes and stored in rocket_device, so READ_ONCE is not needed and
  core 0 is not assumed to exist. The driver keeps its own enum rather
  than PC_VERSION, which reads 0 on the RK3568. The UAPI documentation
  no longer ties the version to a compatible.

- 6/8 (was 9/12): the RK3576 TASK_CON uses a register definition
  generated from Mesa's registers.xml, selected by the hardware
  version. The cores are counted in rocket_drv.c. The "# Conflicts:"
  lines left in v17 are gone.

- 7/8 and 8/8: test notes removed from the commit messages; 8/8 states
  its dependency on b1bff9ced657 in Ulf's tree.

- All commit messages shortened.

Review tags

Kept: Reviewed-by from Igor and Heiko and Tested-by from Sidong on 1/8,
Reviewed-by from Krzysztof on 2/8, Acked-by from Conor on 3/8. Dropped
Sidong's Tested-by on v17 8-10, which were rewritten.

Sidong, could you test this again on the RK3588? The reset and recovery
path after a job timeout matters most, since the deassert order has
changed.

Testing

Radxa ROCK 4D (RK3576), v7.4-rc4 with this series, in an image built
with Armbian:

- Both NPU cores probe.
- GET_PARAM returns the RK3576 hardware version (2); invalid requests
  return -EINVAL.
- 30 inference runs in a row give identical output, with no job
  timeout, IOMMU error or SError.
- Booted 3 times with the NPU not enabled: NPUTOP, NPU0 and NPU1 are
  switched off, and so is the NPU rail.

Known issue

A core reset after a job timeout can leave bank 0 of the IOMMU paging,
and the NPU then does not recover. The fix has been sent separately:

https://lore.kernel.org/all/20261123235154.315460-1-gahing@gahingwoo.com/

With repeated forced timeouts on the ROCK 4D, about one in every 2 to
10 is not recovered from without the fix; with it, 20 in a row all
recovered.

Notes

- 594 MHz (Daniel's question): mainline does not scale the NPU
  frequency or voltage yet. The NPU boots at 786 MHz and 750 mV, which
  is not in the vendor's OPP table. That table runs up to 600 MHz at
  725 mV, so 594 MHz is within it.

- npu-supply: the binding requires it and the RK3588 device trees set
  it, but the driver does not use it. The NPU rail is switched by the
  power domain through domain-supply.

- The register definitions are generated from Mesa's registers.xml;
  the XML change will go with Mesa MR !43804.

LLM-assisted.

Jiaxing Hu (8):
  accel/rocket: factor the completion tail out of the IRQ handler
  dt-bindings: npu: rockchip: add rockchip,rk3576-rknn-core
  dt-bindings: iommu: rockchip: describe the RK3576 NPU MMU
  accel/rocket: take the core clocks and resets from the devicetree
  accel/rocket: add a GET_PARAM ioctl for the hardware version
  accel/rocket: add RK3576 NPU (RKNN) support
  arm64: dts: rockchip: add NPU (RKNN) nodes to rk3576
  arm64: dts: rockchip: enable the NPU on rk3576-rock-4d

 .../bindings/iommu/rockchip,iommu.yaml        | 26 +++++++
 .../npu/rockchip,rk3588-rknn-core.yaml        | 40 ++++++++++-
 .../boot/dts/rockchip/rk3576-rock-4d.dts      | 22 ++++++
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 70 ++++++++++++++++++-
 drivers/accel/rocket/rocket_core.c            | 25 +++----
 drivers/accel/rocket/rocket_core.h            | 13 +---
 drivers/accel/rocket/rocket_device.c          | 11 +--
 drivers/accel/rocket/rocket_device.h          |  6 +-
 drivers/accel/rocket/rocket_drv.c             | 52 ++++++++++++--
 drivers/accel/rocket/rocket_job.c             | 45 ++++++++----
 drivers/accel/rocket/rocket_registers.h       | 32 +++++++++
 include/uapi/drm/rocket_accel.h               | 43 ++++++++++++
 12 files changed, 329 insertions(+), 56 deletions(-)


base-commit: 909ef7a9a30fa139e69e555e3606680f5cca7726
-- 
2.43.0

