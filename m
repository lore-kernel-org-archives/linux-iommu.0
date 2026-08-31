Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0623454937E;
	Mon, 31 Aug 2026 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788183989; cv=none; b=st4b+GiKg60gwZp4AksRvFCf3tfAEIT0rZvGuX/fTm3JX+hAiKD6oItLJ25AknG78r6utUpLgVmTOsFFUr0TjnERE20tOiFMmaQBxOtCp6tmV61Ho01y1nIeGYENy+UpJ+MCQ2ipGpu9a+MtTzouwXWGS6TaSz9pVzfyKNTkbbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788183989; c=relaxed/simple;
	bh=g3bHuiF2eZyWuULtviNSCTfwDIZfKAG9MuMKJoMM/e4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a4HPG+lx77WPxZNOGzYXxhMNbdIUd+HkfyK9YPlM4RcbvpTWaTojUlEYy7CQwlwylvrIl9MHBM4Lq/KXiFhVIlPpFbpRUCFECB4ej4KS1+SJF9n3r0PgncEfS3p22wIX6Hx7gzfyrv5t0obdLd2pSN6FxvMhmrF94oLWkIf8prY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=pWyC59VG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PyaRBkqn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="pWyC59VG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PyaRBkqn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 75D7B1400041;
	Mon, 31 Aug 2026 09:46:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 31 Aug 2026 09:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1788183984; x=1788270384; bh=g4
	/XPVLrP5egtPNVWUyJ/PG5UFV4N/qltkV3ELg9guw=; b=pWyC59VGXVwtGE7jxK
	0fvG5y9233VGY9k2Pp4TKIbBHpUmdOWYPROY+8jzilZ9qBnwb3aAqFs+9A7H0LCf
	V2swXI611Al3ogdwMZ2H4OjYgoL1Bj22+G6It77CnYp0SeTSGR3DHL8MolybURWf
	A6IBF86BRxCIHWyy2F3XL9cdxa2lnCneK6g21k2tMMpVLiUvu2cYD58T7qL24MPw
	x2B4yvY2cND4vAjQNtA/lC4XnlFXVM4y/K4Ysw9hLnsiSdI59AlocRsqCsoQ+ki7
	scbGCwqzWMtpIb7dI9MOeGZ6ltPQziUApHWngoQMjEf8djNOVk0PLeYHQznqXXX0
	6/1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788183984; x=1788270384; bh=g4/XPVLrP5egtPNVWUyJ/PG5UFV4
	N/qltkV3ELg9guw=; b=PyaRBkqngoXLhLW0vtay3lx32XeqT4Xo89hqv78sf9AA
	tXlrYNwG+FRyd9UZ3hWnkGYkxQxVjTs83GVTw05Tsd0bp5x/rXNsGjxHGZO6VuQg
	1nd2mOc+kEWpbT/O6wDToS4IpCn+E2ZStyfN7+0G0I7aXUvOpo7UABBZHJ00T2Qu
	YkQa0UHsqpBPmv2eb23sTVnCLKgO6JopelsLwGxxdUyD7crbr1D2e+p3XNsv/J8v
	ZH28wH5ZyqHiaVdisZYk2DhpJ6+hrQ2YLt0cLv5EdELGFiDgf/fngfNUKoO/4p7M
	Jhb7I8aitc/tYE4twQ1o6ZdYJz2SuAr+hdOG+T3EEw==
X-ME-Sender: <xms:sIWVagpRnYxRqO4aYwMtyOWrQVcTowCgLYNCcu75vDSlnzgGt1qxIw>
    <xme:sIWVauNMlO01SI9I4okCxgZ8kVd1wxjo1fpcDyhhFPCIQ120jaAD7CvksfKX4Kxg0
    9dYEmS40lpkdjU06HovQB3kL5EjmV_DgCVWqALdG3N8gIE23iNmYUU>
X-ME-Received: <xmr:sIWVak25JzsUSjExxmVAeZY_1FjyrJHhABWfEKz92ptsx9ZxS8-ymd4j4eTPWcmhcySWRBEzJWETYUToNVF18FhP8s4DLhllodmVCw>
X-ME-Proxy-Cause: dmFkZTEvZMkLEr7MhWmsStG7sJZXSLt7S/MV99zX9keQluRTeC57NW+zSl9TBQNf7FCT0S
    RXUa9Qi0huZw7DA+PRaJ8kjJOGulGLX/LiEN4HozDLX996QN7h/AOwG62KOyPTtLmclyik
    UHj7e7+vMjCfGxOG7OXwW475YieXIhYchvFCr+heSc7oFhINNeY21c1xRHLgBdfYjwDmVO
    grhY5RQNgA1kjTZTEMjAFDX+9YjO6jFERPW1FbHLuNe+dmrUdOEfypWf5n9tbhXajYMKiT
    QqEDXTOJ+ghOws43X9Z+YPTMVomE7EACJ7/jHjGM9Yme83Mw/KKcvSxUFWyF/TlOEVUvIn
    uU+2rlECtsqv3fBiGUSDwjJu7QdT3GfY0D5J9WrlLI8ygmpkx1tolzbXB4MWB63spDLuUy
    V1D4Yc2MMkpXvdW6P97vYdip1ZyQfOB02veRDW/eteKeamSgh+e5xrP5puCcjMYTwkBpSM
    mTcI/mEJgLi+UO/mCGPRtOY7GiNmrI6T0zVfR3jXmowo3epjNdDCH9iNAObwTBr4bdO5Gj
    UShA9Ck3lIRf7kZ98bp2YdEF7aUOWZp6+dcvxjKlioYlk0kYOeuekjuswa0Jdska1bs7ou
    x2Px/mOodOEGCibbDTDsoM7EsQMWm6qZIX5i+MfcNUkMRO0eEL4fn4fzZ6fA
X-ME-Proxy: <xmx:sIWVakpzFC2EjKUzSrmGuzKUDNTfvCCZyYiO40u62GaQnvgDtZ-icQ>
    <xmx:sIWVamca0xnfrYqJrJSI5_K_Pd4R8w3opLkgTPVOSTr_TfoaSZaV-g>
    <xmx:sIWVausFFTEhiamIR823ckEc_yjVmcx-1M9hr_TvLZuJEpE3dTwlIA>
    <xmx:sIWVauXC5H3dhH69dF_q5s1lkynYDgfMSXPjdMvtOiX5a-87WpuaKw>
    <xmx:sIWVaqM-_XAM7WANhzrvEK8yMGjyFkOSYj9-i4XcBVhEc8K-AtpCpOZo>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 09:46:23 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v2 0/2] iommu: apple-dart: device specific DMA aperture
 support
Date: Mon, 31 Aug 2026 15:46:07 +0200
Message-Id: <20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0Jm7Zi2RAFX3sOwGMsgNdKSaSEaw
 t2tnMDdfz/5768QWRxHuBQrCC8uuuAzmEMBdiD/YHRdZjDKnFWtG3RhHGekaXoxdiQpR5Y0C6M
 t7421VdNVrCHvJ+HevXf3rc08uJiCfParRf/af6yLRoXmZCpV9mWtia5P8p7mo+cE7bZtX5sWL
 aDDAAAA
X-Change-ID: 20260819-iommu-apple-dart-aperture-c3b9cc79d7e1
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=g3bHuiF2eZyWuULtviNSCTfwDIZfKAG9MuMKJoMM/e4=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqyprWs62h1eFt7nVK6b+eLhibSEegfJpetf9G1stC2Ze
 DF3p0tiRykLgxgXg6yYIkuS9ssOhtU1ijG1D8Jg5rAygQxh4OIUgImkbWD4p/Put7t0181crdWS
 +luXNspsY/9b8sItYKcvv0hlgKDNIUaGu0cuGU/VPhh6mEdr4s5tXC/YjptX/9j39qtvb+tx8eZ
 53AA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

Apple DARTs are often connected directly to devices that expect only a
portion of their address space to be used for DMA (for example, because
other ranges are mapped directly to something else).

The USB4 native host controller on M2 Pro/Max/Ultra devices expected to
be sent by Sven after v7.3-rc1 requires this. In the Asahi downstream
kernel the display controller and ISP require a specified DMA aperture
as well.
The downstream kernel uses a "apple,dma-range" property in the  iommu
node to specify the aperture. This is not a good way to describe the
aperture as it is not property of the iommu itself but of its connected
device. iommu.txt describes this use case as DMA window in its
"#iommu-cells = <4>" example.

Implement this for DART allowing additionally 5 iommu-cells specifying a
64-bit aperture start and length. 0x100_0000_0000 is a commonly used
aperture start and the aperture often spans a 36-bit address space.

This range *can* be outside of the DART's IAS. In that case, it is
assumed that the hardware truncates addresses and the page tables will
only map the lower bits of the address. However, the specified range
cannot straddle an IAS boundary (you cannot cover more than IAS worth
of address space nor wrap).

This corresponds to the vm-base and vm-size properties on the Apple
device tree side of things.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Changes in v2:
- validation of the DTS supplied aperture: page size alignment and
  overflow checks
- actually add `64BIT` to the COMPILE_TEST depends
- Link to v1: https://lore.kernel.org/r/20260819-iommu-apple-dart-aperture-v1-0-252703f381aa@jannau.net

---
Janne Grunau (2):
      dt-bindings: iommu: dart: Support specifying the DMA aperture
      iommu: apple-dart: Support specifying the DMA aperture in the DT

 .../devicetree/bindings/iommu/apple,dart.yaml      | 12 ++--
 drivers/iommu/apple-dart.c                         | 74 +++++++++++++++++++---
 2 files changed, 72 insertions(+), 14 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260819-iommu-apple-dart-aperture-c3b9cc79d7e1

Best regards,
-- 
Janne Grunau <j@jannau.net>

