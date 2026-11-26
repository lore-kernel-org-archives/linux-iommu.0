Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795722692;
	b=nsumpR9O61ohBA8plt1c4bH1b0LVjyiA7qn5L6QSsJk2meUbBXAV99opqdOARJhWy4Mm
	 NcruCr30QJq/1LWtEVRf+OtudxNYsXB/SQ37Qiu5drx69ZeDpeiDvpVxR0pFGAvd77SnT
	 nouUuqM7kRbAHmBp3jOVxhJB2XOCbI/3/yJbPLmv1OyajiABTL8oSgyAjqly2F+iC4wMX
	 ql41h+SsK1BqpLgEurEuu1ASfSTQByvzXneABYUu8HaCbyv1pp7FhHrfz5w16ukhgYZ3Z
	 XUHT3I3k/vEABjUC9rMm5M8rcATz62JSq2hasdNN0pUqaPCcI5CyNJNBYZp7XVVlH8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795722692;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=xm3i8ZZDFXdHiTu501SM6Y34RS7EcjmJB7itC3SN0i4=;
	b=eX8RAPbqLdyeiX4BUxRiWPcry+46MgU/rBHROU7tcpy+UfSVKptOLeekFlfHaRDvBLg2
	 xuz3KvdlsEwz7+TZVdtzcuk6Kn4EsyIhe/k15pquwZlOuQZOPeeprjnXewYMx8cUpEbf6
	 0ROIJmGSf/L+3VSNXz7VspMFO8pll9Fl90OeElF9MM3cmEZ43LKH461F+UZjUjCFpMec8
	 /8iYDD2ak/H6egtLIHPCZtWQpbXh3ETa8yG+8U0QI5/tZXaJpydFt5E4NjJCB0p6tgbnP
	 VeX95+usIcIwZf2Gy0yW0Slhvi0AXVaEN4SdEKo7V4ULhxuCa3TpM+8wvXa3wTluohQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfvOH7Zw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA3606A31C;
	Thu, 26 Nov 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CfvOH7Zw
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795722692;
	b=aSQaKEBUegPbCjVx2GmTpPbNydSjMoYdPsfDZFZDL5GNW9FKWvNEMttfx8ujWjXjD/9m
	 VAzYGfulPxNWT+AMwuV6/4hJ2rosa5i5GZrYovacA8wKkxr0lTBQa7FvwzhfcpaZlcyDq
	 zNY3mvhzdUg4Mo6baZpLHWxF976ibLDZSTlAMuf1UA0GvjM609/pvQzVOVyWWPPxs1l3J
	 65QifrM6EfxYRlTKis0Vs/RlYhYCa1tP3Xu+Jlb2qNqIIpHCJu7luE8l3qT/XZ87cneM8
	 q/ClnbGE1gIExNCtGetwkGu/Ksm5MdPDBUncL4kxI3xBFwmaBlI8tYuF5Z+NEEdA8ZQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795722692;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=xm3i8ZZDFXdHiTu501SM6Y34RS7EcjmJB7itC3SN0i4=;
	b=Bf+TL7620xJdPuWJdlbAOtPl6+i0nasU7ra3SrWDv357KuLynImc6tz3nfQc/76/T+ER
	 dJ/LEwuQrlacjBGaDnd8NvEKaniIwKMrPpngSf6cgzVADiZVJL86202xy52X1Hy3Mor1I
	 IPTTHoKPqUBHJnIt+pa1x4SQ2njD1V1oHr7hM4DcZjVGb5/vV6Awsr4+k0WMwbPzKsq2m
	 BRPb86XjdWi2Rod9dK63nkbU1Bis+DC08jtn9rV7CezdzTWq/ACCouvb2CoO6Ua+7Hbsi
	 5mxkZNh+30k07busvrGG9v+9SeK0LPXb0nReLs8z0aka0LAu3SzET4HwdUG08MrrDyw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D7A4D1F000C6;
	Thu, 26 Nov 2026 19:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795722692;
	bh=xm3i8ZZDFXdHiTu501SM6Y34RS7EcjmJB7itC3SN0i4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=CfvOH7Zwd7eAAYs6zkHZeBgJNHXKn59MGH4Hd1j0kKmt5MzFyX4pYKJmwqIpMoTxl
	 wz/mYp8LzPXZ25smlMTMMjODJ89oTCBpDpR5ezJ3/Hx7601JpI6f5jjjgyqLm0+6aG
	 iOr5Ct2zjWF8ekA5WPiLoQrdX6CJ3W1QsOfnJAue4FDctq60FxhYpJBU6JdylSC0C1
	 RaDrjwnB6JweboxsFIMFsAWMaEjlZrVLzUAORE837lx1sR9y1w3CgqwyVbiXf1sG9x
	 2PMyhVAkfs0e70FSpNFzM1hmEjqzDim2h9fC4+K62gpNSaIT4RzSFP5TB6W3qOMFp/
	 zoCPAJqmpCG+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 386F94D7C6;
	Thu, 26 Nov 2026 19:51:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v5 0/4] media: rockchip: Add the IEP2 deinterlacer of
 RK3568/RK3588
Date: Thu, 26 Nov 2026 19:51:26 +0000
Message-Id: <20261126-iep2-v5-0-3deac0976f10@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13Oyw6CMBAF0F8hXVtDhxaoK//DuCjtADXyCMVGQ
 /h3y8OEuLzJPXdmIg4Hi45cookM6K2zXRuCOEVE16qtkFoTMoEYUsZYTC32QAuppE4xyzTnJFT
 7AUv7Xmdu9y27V/FAPS52adTWjd3wWe94tvR+k3yb9IzGVOVoDAoFDNm1apR9nnXXkGXSwxGJH
 UFAickzmWsjlRD/KDkg2J/3SUAoORayTEEa+Ef8iNiOeEBZGusSRJkAFEc0z/MXItBd+UkBAAA
 =
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795722687; l=3049;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=dVuriuFsWIYJJR6FOm+moA+R4Cr1AZjWCwJzDebEMao=;
 b=zPucMdWJlKkneePzNkJIwe10RjrEJn9QLQJ6YaDMIjFjWPipShzWy/uh9Nppa6xt12jMeqG4J
 tKtU+lwvDyYA3FXnFlNRd5aHdPEpeMSYndhcyOaBC/0WyRmwdULdUjl
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
 drivers/iommu/rockchip-iommu.c                     |   36 +
 drivers/media/platform/rockchip/Kconfig            |    1 +
 drivers/media/platform/rockchip/Makefile           |    1 +
 drivers/media/platform/rockchip/iep2/Kconfig       |   16 +
 drivers/media/platform/rockchip/iep2/Makefile      |    3 +
 drivers/media/platform/rockchip/iep2/iep2-regs.h   |  191 +++
 drivers/media/platform/rockchip/iep2/iep2.c        | 1263 ++++++++++++++++++++
 drivers/media/platform/rockchip/iep2/iep2.h        |  107 ++
 include/soc/rockchip/rockchip_iommu.h              |   17 +
 14 files changed, 1793 insertions(+)
---
base-commit: b4e3c4b6a36fd76f57bf3e48638f68ddecc54ba4
change-id: 20261110-iep2-b9a9c6e77c44

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


