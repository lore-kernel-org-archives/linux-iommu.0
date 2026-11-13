Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794600277;
	b=sHV/GXVV+qsQvjfxdTGC/wHM/QFwzNUlQUsZZJ+Qhe+W66zUOtTfo3eQ7aBc09LlCoIp
	 D+nQmGutQU2qQcP9iQRUwsmD3Zh7tnO86RRffvrJ3wXBHsNEyWqvTRDVkiZdcJYud/UuK
	 9CKgiLBOAdfCQaLrvb/21m8Oc3VTGGYtn7+XrkJIIm0hNiRX6l8uMKzN6FCA6RR6oGhY2
	 GNWkSzwdhLS1tGn6mwJ8GsYPOhCW9u3qb12G5LWV5IXcdWeRgoFyMhy+MiCz2fLy8fRH9
	 7Ex6XSG5QDklMul4IZ603/MDudM+OnSr09lXtUQrMPapVyecLPWY4ssxZhGbRycH4Hg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600277;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=jpOlhNnEzegU4+aUHfoh3qxqQIoT5d0OA8m0B/M7F/A=;
	b=mOkJ6An8VfgDbJFXjaiVSmatl/MfwO5XSb192DEZ3NDe2sBpXAT/zX7DaB1OxbQZh8iZ
	 FUGyQzY+A73UmGQZu+VvtGpY+7qXr1J/ognSUYjUNzUsgW1wqrOS2zK4hAuI/t4qvpTI9
	 mt3+WEvdECQzqhJckMAFw5qzFHbTvfxBXIw/xG9mJI6civoJf8nCy4dIgndeTD7ihLPI6
	 vQSNocpNQ/3oAPTue1AFnnvKSsiHtyqDH35WAJBTNY2X661UN5+AiK2Gbv/aU96z9OYkn
	 zHEj7NhgHMrBs5oD2vXHnT3NF6ZYsQfl76qJh21PBcvyQRA8DKsfg9LjEvX1xaHPDRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fq8zVBTm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D655606A330;
	Fri, 13 Nov 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fq8zVBTm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794600276;
	b=vwZ5J+956Jio558RvJ5VoH+vm8T9v4JxBAofWTFgO0p9XeY0V+DrKxqTWn4UBnRISHgp
	 MOgTqxlR1hVii1taqc8iEAq/+ZhSyMWQmabgtY4FNNsLhOIEDufQG3KcvFHQNYmtk/5td
	 0IbEfda6xJ+xFrm7EyqN1XtM9BloGGBh+x4xcKRDHJ57E4tmX2Hwa0v85xtcvW3OEXCaw
	 gIceHFtni/YdiRDpOVvGQZGs2ohOhuSbD7OoTHfIQwMT8qwJhUP+UR6jw6eThizMdtmRk
	 a6Fi8t+3fV8nK7x7L5vkwNQJMnlq/6rRC9QgQVq6sbr/nUjq7lKcoO6Vsigk6UmSHgg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794600276;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=jpOlhNnEzegU4+aUHfoh3qxqQIoT5d0OA8m0B/M7F/A=;
	b=UJlOhsZJHmzvo8DGQ1iOtKz9a2XvWvvc5rEOcApWkeJCShZr1OgkXcgSF5rTGz71yR6h
	 gN5DTB9Uy5QNubNzVlOeAkcfVcgB8O8MnnCa7+Oa1B1fv/HjkYU150pPlmNCAC2ujTdpR
	 aB6nLRPMm76lC+tQ/K1CQlK/icnJVsOTP+StCt7U9HdFmAOmMReMXoIlOKIGyEQ3yFHrN
	 7oo3qLP50R3oZmPi/ZPOyzXD4uKElnSya24w/zPCwe//v9XCPLGJFRtOnFAMKs8RdIZHG
	 GUa897gs7dB5HicIU31ai1e1+AUx1nabDQJwFNtetL/GxpfX4DqFMILt5QxR7mD/ZSg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 68F591F000C4;
	Fri, 13 Nov 2026 20:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600276;
	bh=jpOlhNnEzegU4+aUHfoh3qxqQIoT5d0OA8m0B/M7F/A=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Fq8zVBTm3mm9mefvWuY19gqprehWhemCRbSS4iAPZWRppH8iAKpI7CnzEPOPjT8Lh
	 PjkgvbubWjeyaEr4unQF8t0tGOBNDMamfpUP9xxj/64QM3z88mNExQCuMMxtTB5/VC
	 6uuimRMS+ZryNWYsHEDMPGEJ02WYlftrDEeRpKFZT5Q1S6qH31dmSNcrWhFWKtLRxu
	 K2qDfXoenC43Xkd0HgFxTzwwh+ISyhVT2P1bMAFsCgHmqabNrRerJfy4aB9xpDI1hu
	 fn0v0Clumm4G3oNpX17tmUZtuaB3aIYnD8FBMcgpwtsjwJ2l6oZUa3xHQ1do7h8Bqx
	 7lPOcSPNtRG+w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ED35F49AA3;
	Fri, 13 Nov 2026 20:04:35 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/2] iommu/vsi: Fix the runtime PM of the IOMMU
Date: Fri, 13 Nov 2026 20:04:35 +0000
Message-Id: <20261113-vsi-iommu-pm-ref-v1-0-fd917eebdf18@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Nj3bLiTN3M/NzcUt2CXN2i1DRdI6NkC+NEUxNz46RUJaC2AqBgZgX
 YyOhYCL+4NCkrNbkEZI5SbS0A2OhOpXQAAAA=
X-Change-ID: 20261113-vsi-iommu-pm-ref-22c83a5473be
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794600275; l=1341;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=OnaLvuwoDST0/gcJvgeXw4+Y6GTFZAaQ3WwkuisPspY=;
 b=a0QmlQGMI02EGwxxNhSePSHkOd98uDn0EbSCnEajjB24tD6MO/hrdOt//32l4Z1nbwRIS2D0x
 cnbrsDOSwUaAJOdprstpzS0q+TUDntWYIvavBHaV6nW/4vc9SgJiDHD
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

Patch 1 lets the IOMMU suspend again: a failed pm_runtime_get() in the
TLB flush leaked a usage count. Patch 2 stops the interrupt handler
from resuming the IOMMU in hard IRQ context.

Tested on RK3588S (Orange Pi 5), v7.3-based kernel that also has
hantro-robust v3 [1] and the vsi-iommu suspend patch I will send next:
without patch 1 the AV1 IOMMU stayed active after decoding. With both
it is runtime suspended with usage count 0 after AV1 fluster (203/242,
unchanged), 20 AV1 decoder unbind/bind cycles and 3 s2idle cycles. No
IOMMU fault occurred, so patch 2's handler path did not run.

No conflict with patch 10 of [1], which touches the probe.

Developed with Claude (Anthropic), which wrote the code and the commit
messages. I reviewed every change.

[1] https://lore.kernel.org/r/20261113-hantro-robust-v3-0-82383c722ad2@gmail.com

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (2):
      iommu/vsi: Don't leak a runtime PM reference in the TLB flush
      iommu/vsi: Don't resume the IOMMU in its interrupt handler

 drivers/iommu/vsi-iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)
---
base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
change-id: 20261113-vsi-iommu-pm-ref-22c83a5473be

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


