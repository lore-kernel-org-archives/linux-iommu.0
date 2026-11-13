Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794608495;
	b=HgJRzIQBhd5S6ULYN/ccO4a/LKOCG7/1QwKLDYTkLRvj7bJbt3viDs23ZKktVyRUqpIR
	 t2Hmdbv5+ADO0zNvrGzQW1FeboCzhkIbKJNKFg3lRI5tRxZIQTYjJO0CDWaaCzCiUHIFu
	 OeO/QU7S2O84Rh6EMOVjzCkyQ0J36haQAEWD6JpD3U1xTIjgg4vUAmgMoruaZ1KYR24OE
	 zgQd3ZfrueIPzXw/PTFYOxk7HNaCWl+bXLIyxA2VXbBViDAqnSS1sjukwtEkc6+j5y7x9
	 uqgneHKU/4QHrr7xA8sYmXFClMV+YgoUbKs44biz21XyjN0jM7mpUv5RocMLNneP6Sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608495;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=hKpqk6HLacU1LAteKJMU4Ufg/Oj/R3Wdsba8hrvmBjY=;
	b=KocUS6jqg2MIyjvIOmxKLkXagdUlY0oSYh463SISN5+G7ROAArmuzlswvnfRkvAnuWH+
	 pmoMoDrqXyUVTrXXaoxPVJ4XlkKvtyP1ulQq3kA4ew7sf/9Q8zBu213/VHL51ABojKnzF
	 bCKx96NMI8YI0R8pshfO7el2DW4haDU7gguis2m9P3iZcqV1j9RYYPIRZlJH959GFbutw
	 /HAj9xeFP7m/DxkjrC1lPn8TLp6KuzOTnXccA6Y7ZM+hRobfju+sOvauXNWtddrl6f8fz
	 6iXbS3uiiBrDh32d1MWYU/f72T+C8xcokJ01CZnfPxip4dxzvgIjtpZgIJCGoc2NGpA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEXo0D4L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF498606A89A;
	Fri, 13 Nov 2026 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KEXo0D4L
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794608495;
	b=vZeZfmrQWEgCVfEuEPhX9fgsAZU36ok18CsLVGNTP0EkAZ8GHoZoWxgUgixklSavg/SM
	 PWGkM/vFG5JssW5sJKuJwYZAPjJmbx8vqjAcsZOBD3SdUgxVySs/CzEQI3J0SP2nArEdb
	 RjD7/yQwDNk9ejpFN4hvub81U9J3XsjdhrlktPXZIbFC6sDg0wKb0g/DZ1FpFGWWY9idT
	 dIGnhpTCsy9q4l/8ge1k2aemGkcIzXZC0I+/pjrfHKh3pFyINvIEJjcBHwVfo3USwxzl0
	 No4MXvt26Ki2yRyj/wDGng+aimg7Alcu9UgRFQsOrtHNJujU9BvDIP0cCeQjM3ZJttQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794608495;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=hKpqk6HLacU1LAteKJMU4Ufg/Oj/R3Wdsba8hrvmBjY=;
	b=Il3SsAopXrNC7NwDNxeXeQfpujg3cuyjOwp2aCoTCA9byOfTeDWRdLz0UZXJPYZch31u
	 0wj1vQwo5j+LzuU0pHCONQPJyM0uYIEMrbmvO/bBH/4Lm3OLTKbn5WgUMid9DrLpt93qi
	 EgZ3rFnVNIKd3stbMxwrvEkT3IbV4SXBYi34GK6eYPuPy8sqmO9sut5mU1tgiEt82KFSP
	 ad/v5kgLjfa/LX6ZGCTh0Vha0ybAEALkg6ZLJ6U3KFjm4Gr+5IyPeLQdCaaf84k25Irl7
	 UrARNYp2Q23YzS+Yrj1AcTiQITYsKgapLkka1CbEvOjnOdvNRP7xvc6sGcR3qjhYEeA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E73731F000C6;
	Fri, 13 Nov 2026 22:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794608495;
	bh=hKpqk6HLacU1LAteKJMU4Ufg/Oj/R3Wdsba8hrvmBjY=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=KEXo0D4LZ7R5Fzg2pik/tMcjkomMmNGWMqj/8sfh2rsHACM5aSq3FdqxYCM5rsUMO
	 UDpTZWhkWgQ8NIg8HPKIAnCJxTUDCtKv6TvIuzXPy5o6oMT4zUuv61w87ncTlyXFcp
	 v50tP0eGjtW1B5q1hJqboLZJgkLn7xblh7MscohYbMzFQjMyxIaY0mrXaZZXi0xfR3
	 wkIcJOm1atokrkdfUeN5Vsay3sNlQ81GNEpkYKcSaLOLUvfRopO4R/en4frwJVqa/G
	 rFj+lECffHGGIjmq0eJ1HOH5iT6C4he97o6ZzkcCPm/4TQwb8pdb3QYba7QiRUY8hl
	 Vz0HQ2xc524Zw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 293E249B48;
	Fri, 13 Nov 2026 22:21:33 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH RFC 0/3] media: verisilicon: Multi-core support for the
 RK3588 VEPU121 JPEG encoders
Date: Fri, 13 Nov 2026 22:21:31 +0000
Message-Id: <20261113-hantro-multicore-v1-0-43811eea14c4@gmail.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2NS04DMRBErzLyGkv+tT+zReIAbFEWdrtNjJhM8
 HgQUpS744SIZZXqvbqwjVqljc3ThTX6rltdTyPIp4nhMZ7eidc8MlNCWSml4KPsbeXL/tkrro1
 4ygokau8SBTawc6NSf+7KN/b68swOf+W2pw/CfpM9Zo2+9nHYH9tz7Hgcd/NkYw4AogQbibI3K
 jjtvBBkYkFLGhIp1JTvnn/KKAUqRVA5oAWKQspig5M6ADkREE0qxXpzo1LciOO6LLXPU8wWTIj
 GOuOzEF5643UCDQSYVXTCWA8YPDtcr79WMxcjMQEAAA==
X-Change-ID: 20261110-hantro-multicore-bd251c387be9
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, 
 =?utf-8?q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Sergei Khomenkov <shomenkow@gmail.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794608492; l=5572;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Cv/EUDQj2tIl7BGTLv3WK2CnVloA8B8AeCHDaWxtbMc=;
 b=Cjv498CCL6jnQ0cAYOFvAR8oJ892okual6pS2C9nmBZcHZpoy38t0gdyspPIbK+WmdaTIIc/i
 UYTyd0qdXcZDDSwodE1G06NIKxixEK0kCu0vG0WZTDkjMEhOzAQHshQ
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

The RK3588 has four identical VEPU121 JPEG encoder cores, each with its
own IOMMU and power domain. The driver currently probes the first one
and ignores the others, so parallel encodes are serialised on a single
core.

This series drives all four cores as a single video device. Patch 1
splits probe into the per-instance hardware setup and the registration
of the devices exposed to userspace, with no functional change. Patch 2
makes the driver pick the core a job runs on, and look up the running
job from the core instead of v4l2_m2m_get_curr_priv(), still with a
single core. Patch 3 binds the other cores to the first one with the
component framework, attaches them to the IOMMU domain of the main core
so that they share its mappings, and lets the mem2mem framework run one
job per core.

It is an RFC because it depends on Sven Püschel's "media: v4l2-mem2mem:
drop curr_ctx member from v4l2_m2m_dev struct" and "media: v4l2-mem2mem:
support running multiple jobs in parallel", patches 6 and 7 of his RGA
multi-core v2 [1], which are not merged yet. The series is based on the
media tree's next branch with those two patches applied
(base-commit and prerequisite-patch-ids below). The core selection
follows the same model as Detlev's rkvdec multi-core series [2], so
comments on sharing more of it are welcome.

A single stream still runs one job at a time, so this raises the
throughput of parallel streams, not of a single one. Variants without
the new multi_core flag keep using only the first core.

Two postings touch the probe/remove code that patch 1 splits, and I
will rebase on them if they land first: Benjamin's "media: verisilicon:
remove unused variant and code clean up" v6 [3] (textual conflicts) and
Sergei Khomenkov's "media: verisilicon: suspend the device before
unregistering it on remove" [4]. Patch 1 keeps the current teardown
order in hantro_hw_cleanup(), so it carries the runtime-suspend-after-
unregister problem [4] fixes. My recovery series "media: verisilicon:
Recover the Rockchip VPUs from faults and timeouts" v3 [5] touches the
same probe, remove and device_run() code (textual conflicts), and I will
rebase on it if it lands first. Once both are in, its IOMMU restore has
to detach a secondary core from the main core's domain first, which I
will add in whichever goes second.

Known limits: the video device and the m2m device are allocated inside
the component bind, so unbinding one secondary core frees them while
the main core stays bound. If one available secondary
core fails to probe, no video device appears at all, where the first
core alone would work today; the RGA and rkvdec multi-core series use
the same model. Comments on both are welcome.

Tested on an Orange Pi 5 (RK3588S) with 1080p NV12 JPEG encodes through
GStreamer v4l2jpegenc, 600 frames per stream: 1, 2, 4 and 8 parallel
streams reach 62, 120, 216 and 223 fps against 62-68 fps with a single
core, with the interrupts spread over the four cores, and the encoded
output is identical to the single-core driver for NV12, I420 and YUY2
at 1080p and NV12 at 4K, also when 4 or 8 encodes run in parallel. The
VDPU121 VP8 and VPU981 AV1 decoders of the same SoC are unaffected. With
patch 4 of [5] the module can be unloaded and reloaded with all cores
rebinding; without it the reload hits the SError that patch fixes, which
is not new but easier to hit with the longer teardown.
A later run together with my three rkvdec RFC series: JPEG encoding at 63.1
frames/s with one stream and 215.0 with four, all four VEPU121 cores
taking interrupts; the four parallel encodes give the same bitstream as
one. Fluster on the same kernel: Hantro H.264 JVT-AVC_V1 129/135 and
JVT-FR-EXT 44/69, VP8 61/61, AV1 203/242.
These hardware tests ran on v7.3-based kernels, where the clocks are
still enabled in device_run(); this rebase onto the media tree, which
moved the clock handling into runtime PM in the meantime, is
compile-tested only.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/linux-media/20260916-spu-rga3multicore-v2-0-23aa2cb74e61@pengutronix.de/
[2] https://lore.kernel.org/linux-media/20260810-rkvdec-multicore-v2-0-986f89d22cdc@collabora.com/
[3] https://lore.kernel.org/linux-media/20260930151241.58233-1-benjamin.gaignard@collabora.com/
[4] https://lore.kernel.org/linux-media/20261106-hantro-remove-v1-1-d0a4678886d7@gmail.com/
[5] https://lore.kernel.org/linux-media/20261113-hantro-robust-v3-0-82383c722ad2@gmail.com/

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (3):
      media: verisilicon: Split probe into hardware init and device registration
      media: verisilicon: Pick the hardware core for each job
      media: verisilicon: Add multi-core support

 drivers/media/platform/verisilicon/hantro.h        |  41 ++
 drivers/media/platform/verisilicon/hantro_drv.c    | 451 +++++++++++++++++----
 drivers/media/platform/verisilicon/hantro_hw.h     |   1 +
 .../verisilicon/rockchip_vpu2_hw_jpeg_enc.c        |   4 +-
 .../media/platform/verisilicon/rockchip_vpu_hw.c   |  20 +-
 5 files changed, 424 insertions(+), 93 deletions(-)
---
base-commit: ad6549a46748d00818483b535e5cd2a704685c98
change-id: 20261110-hantro-multicore-bd251c387be9
prerequisite-patch-id: 6ad9550f96aeed8429737800e4afc6e35be2c3ed
prerequisite-patch-id: 42252ba52d9c65ea011f6971395e709cc4bff684

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


