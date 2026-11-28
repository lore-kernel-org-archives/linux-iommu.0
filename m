Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795854611;
	b=Hg700QlvKPEQHxMA35zFELHJm0PSz6peSJ5U66qUNSzTppqUNieRyzoEJ+G+MTDY8by/
	 fXGts/+FUK1a/MXJxf9LAlpLU0o7G+lUGolWZbIEjEGXbkvu/NxsYH8fXv9JgRbx1mrRT
	 0Z5CG4Y/PCOB+GB0hbUzP2sGTPC5FtJwjA7oHYN5tH/oD7LHmLCaVrZaaOtanNBzRN1li
	 EGbvzM8K1JQ9/7Q/BKOXBA38R+91in8gTt0Kw7mAcusHQsMpsMXuynI09GPIJ+omvzxZi
	 LRTpGx/C7OROWJO8R2LhwVMLCW5+HO2iGqakWKUDNE/Z3Go6vB4yvQ8m7wcUNQnpoVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795854611;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=1L8y7/SvVJPBXVNhtWStywFXrh9qI7ojM3poj+inXm4=;
	b=E04ScC16FKxQS+5VK7Pfmls2r7AvG67W/nLYD+u0NRl8Q9qCvVhsu0/FbF7IBdu+1fTx
	 BcLZAT3E15th3qunq2Tu7SmypM073JThRvJJjtMD4jG9GsGWN856truN+WARqFhw6wso6
	 nsa9c0hn61nCYwd4zTiCjlkwGvSXUanGzJGjGK56BLOwv+8qrmXqHapqoEEZQ7yAnUR3O
	 6GzHBlzMYP2NobqNYppILNUG0QBCTFFE+5tjw4E3uRQX6FUeR/Mkp7ehKcJkclNLVpshM
	 V6N+lp6rLRy6pSv+Y6U12QmYz7U+dt/wLw4TgYj3tRfD5jj+XoDn7Jh9FTR4lwIHYdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEvY7QnV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C0606A31C;
	Sat, 28 Nov 2026 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEvY7QnV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795854610;
	b=Z+CPoWJTsCXPq/PmCmXF+yrUaZqPIpFfTvPOQj24thyC6eWeQ0LrcPusNXLSb6L8wt4G
	 RPsRdpGbYeJ1P03/VLqK9lRlINVMcYTzznteacvf5x9Xe31jDzpS1xgWD6a5KnJcwaBcW
	 hmol/vavPDTwnJrJmYNQ6xzDT6yo+rueJJukDxyosacGwM2xDkSDkzS5GBTS8evCbKnPD
	 CZnACewKP2xKe9qWXishfyCYDxkd7oR1pkcd6RwjT+BQfhf+MajKmu5janqNgMEOCNZod
	 6g0QXWmRDsVO3wFFZtsWJwRkl19BUWpDPR1dWHUCt51gB880ZozkQXJ1p9SXyIYCWBg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795854610;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=1L8y7/SvVJPBXVNhtWStywFXrh9qI7ojM3poj+inXm4=;
	b=IqpZmhAynb97lh27iyyjbcZV2IOmD1pMklyiEneoSAhHZmcAA+YmfqLJqYucy7+qvApS
	 ddcBdKhVktqEnhyQF7lwlK3iJxKLAb6ESqWSSqjSw4R9nFEfk1g8Ywgqjo4qqPDZhKX3f
	 SOje3QR/tm9GKHxHlMq/pZaPmB7ZaWNk8N/48XMPeQXAvDzASGjOJaMIXYkNTW4pYGlkL
	 yIHGHnPei3dbPgzi5mgtvZgXXn2ZGMyp5+bmRPBOJqfd+6f3AXrle9fe4ICNDH8pRbIds
	 SwY2cwjnzlzA6grsrbVyxPlcogJHTPgwwfXuJmlPp8/NsZ3hNik7v5z5kf9s8kFbRfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A5F671F00893;
	Sat, 28 Nov 2026 08:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795854610;
	bh=1L8y7/SvVJPBXVNhtWStywFXrh9qI7ojM3poj+inXm4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=NEvY7QnVuWJ2zOQn2P9Wq/gOeNvr4e260/IgCjx1zN5XRz2tIZAHMU8QgfyKivqOL
	 JYBtwnX8ab0p/BE6OkR6BOaAG6XUsLa28878KR97IsActpdXDIYDd6YY1cylOGScIV
	 hCzS7J5kj9vgwW6gVuT5hRQZAR9zDStN/QF254qiJtgTcaCvaXsjfJkTtR5i/fnLOY
	 hB8M+bLDGQNyaNwCQupR3lPvpsP8l5uFc74n7/0KtngVAjr/x2xflKYK27T5yiGvsQ
	 F8p92XiizOz+Jsa9c3yKc0FwU1ih/p005dWWSFCDCbW3XhlJCRJT5TzS2bSWvO3A0p
	 zyNfQ1eAJz9AQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 057454E03E;
	Sat, 28 Nov 2026 08:30:08 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v6 0/4] media: rockchip: Add the IEP2 deinterlacer of
 RK3568/RK3588
Date: Sat, 28 Nov 2026 08:30:06 +0000
Message-Id: <20261128-iep2-v6-0-5f4f10a0dbeb@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13OTW7DIBAF4KtErEvFjPkxWfUeVRcYhoSqiSOTo
 laR717suBLy8knvezMPlmlKlNnx8GATlZTTeK1BvxyYP7vriXgKNTMUqAFA8EQ35IN11msyxkv
 JavU2UUw/68z7xzPn7+GT/H2xS+Oc8n2cftc7BZbe/6R8ThbggrueQiDlEAjeTheXvl79eGHLZ
 MEWqQ1hRV3oje19sE6pPeoahNvzpauIrKTBRo024B7JFsGGZEVGCx9RxQ5x2CPVIr0htb5Hzgt
 rdATRonme/wCLRsEmfgEAAA==
X-Change-ID: 20261110-iep2-b9a9c6e77c44
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Alex Bee <knaerzche@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795854607; l=3235;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=rFNZILi2ME4y6OfNvGVSrCQyr6wuwJ3qgVj2XSS5dA8=;
 b=WgtOWwnabvlgKjmdigImzuW1G0Qw7LJLJ+7qbj6QJSAT/WgbDKleaZjZoILRGeyC6qubZP/Px
 zQMQRfKwRt6Akk3R2nDAjcR5FwmN4xyKJvGw2xljgrBM6rW4Ugcd5D7
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

Add a V4L2 mem2mem driver for the IEP2 deinterlacer of the RK3568 and
RK3588, with its binding and the RK3588 DT node. The V4L2 side follows
Alex Bee's IEP driver. 2/4 adds the Rockchip IOMMU helper the driver
uses after a reset. 2/4 needs an ack from the IOMMU maintainers to go
through the media tree.

Tested on an Orange Pi 5 (RK3588S) with a 7.3-based kernel (KASAN,
lockdep); build-tested on media next. The test kernel also carries the
rockchip-iommu fixes 1-4 of
<20261110-iommu-rockchip-faults-v1-0-b1dda574dbb8@gmail.com>.
v4l2-compliance 59/59, FFmpeg deinterlacing (local patches; no
upstream application uses the driver yet), suspend and unbind while
streaming, forced watchdog and IOMMU fault resets. Not tested: RK3568.

Open: a reset that cuts a transfer (seen only with forced 1 ms
watchdogs) can leave the IOMMU with the transfer outstanding: its
stall and reset commands then time out. Jobs fail until PD_VDPU
powers off.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

---
Changes in v6:
- 2/4: kernel-doc says the caller must own the IOMMU (Nicolas)
- Collected Acked-by
- Link to v5: https://patch.msgid.link/20261126-iep2-v5-0-3deac0976f10@gmail.com

Changes in v5:
- 1/4: clocks before interrupts (Sashiko)
- 2/4: new: rockchip_iommu_restore() (Nicolas)
- 3/4: use it instead of attaching an empty domain (Nicolas)
- 3/4: IRQ saves and clears the status; the thread finishes the job
  only if it cancels the watchdog; no spinlock (Nicolas)
- 3/4: drop the IOMMU fault detection, forced suspend and reset
  retries (Nicolas)
- 3/4: after a failed IOMMU restore, fail jobs until PD_VDPU powers
  off
- 3/4: defines for md_lambda and the default size; comment the motion
  table (Nicolas)
- Link to v4: https://patch.msgid.link/20261121-iep2-v4-0-760cf25f322b@gmail.com

---
Arun Iyengar (4):
      media: dt-bindings: Add Rockchip IEP2 deinterlacer
      iommu/rockchip: Add rockchip_iommu_restore()
      media: rockchip: Add IEP2 deinterlacer driver
      arm64: dts: rockchip: Add IEP2 deinterlacer to RK3588

 Documentation/admin-guide/media/rockchip-iep2.rst  |   32 +
 Documentation/admin-guide/media/v4l-drivers.rst    |    1 +
 .../bindings/media/rockchip,rk3568-iep2.yaml       |   95 ++
 MAINTAINERS                                        |    8 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |   22 +
 drivers/iommu/rockchip-iommu.c                     |   38 +
 drivers/media/platform/rockchip/Kconfig            |    1 +
 drivers/media/platform/rockchip/Makefile           |    1 +
 drivers/media/platform/rockchip/iep2/Kconfig       |   16 +
 drivers/media/platform/rockchip/iep2/Makefile      |    3 +
 drivers/media/platform/rockchip/iep2/iep2-regs.h   |  191 +++
 drivers/media/platform/rockchip/iep2/iep2.c        | 1263 ++++++++++++++++++++
 drivers/media/platform/rockchip/iep2/iep2.h        |  107 ++
 include/soc/rockchip/rockchip_iommu.h              |   17 +
 14 files changed, 1795 insertions(+)
---
base-commit: b7ac871daee981f1963f632586ff9b9d898ce5dd
change-id: 20261110-iep2-b9a9c6e77c44

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


