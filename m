Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15F37F31F;
	Wed,  2 Sep 2026 19:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788376748; cv=none; b=Zg3wVl/Fc/zVp+AWDZDzgQ/Ej2t9f1btrDXHDcA3hVV55EsU0MZk0ISgg9f6WCxsgE9ra+KxWzeeCEeZYVDbJ9BNp+IiS4oyVXc+ukLwZJBMHma9ThuratQjZAu2UXgPo65gZxqtMP+ZpaSagwva3CbKm8tNXAFhXFjlzVcBEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788376748; c=relaxed/simple;
	bh=k7xxpEHq1DhC5KsD1YXAr8f/rQawVsF7PKmfHr3A2Pk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=unlpGzXVK12SpLLIMS+ChOxUkyEwsUH977gwmuw/uajsjDrwUbeoxQMTFiHU6d6GDuqcjNypok48ovNCAuJ/TJgknfXPKzzKxOwPWybpkqJ18h7kCKKAt3YtQhPIY6+iXNz5IiLNVUxvbG8QSm0Jj2KiZThD+gA4lXLcDZVziFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=SaRJI1W5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cxiBKzrv; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="SaRJI1W5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cxiBKzrv"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9D7BD14001DB;
	Wed,  2 Sep 2026 15:19:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 02 Sep 2026 15:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1788376745; x=1788463145; bh=3V
	xzR4XZUdzGVUc9Qo3lpbK/1SemMVH8/KWSHV5sgYA=; b=SaRJI1W5e6ZC66fRK+
	PVqp4BCuQ/M8/NKkUgecC+Lzforn0Td/PFt8t8d+dKo6ILAqTKy73Pk6Jr1P0j7Z
	P0XB/9YcLy6mmc8n5bT49rHQgr3J7z+tdij0O6A9LURZA7Rb5JGklbEl0Wx6OgZu
	sVJEvpDUEUVQedXTu3D1jlWFSoWtcUsk17T4TMC5IFYaRVlfMwAd7oIiLjmwe8G0
	68JgHge3M1DXyAYGNOMsPfh70YOkWWfnL3tcTGkiyUQgiEVLgzTnfUtjY88mJ5UM
	cSfR5+l8mLPtslHJGcRJYtf/mxUKFeKLjQxsPLpVne1Ad6SMfQpolhcVS6BTt0x7
	vW9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788376745; x=1788463145; bh=3VxzR4XZUdzGVUc9Qo3lpbK/1Sem
	MVH8/KWSHV5sgYA=; b=cxiBKzrvFM3W3DAGsIYBWxXEECt/+7V269gg3npUJb+v
	2uVMFujP7+YXfUlJe1GMkK1yyLMac/kDsKefWoF8SbOl8pQLjcMPuSdmzl+kyh50
	+TkXkWqRM/TQAARB5d4FZTktSN6z0R5l4cXwzvDatah8sIvPHzLDlloCKZsuimlK
	m6Gki/FZieYJq3hLtqTB2xSRWHxghx4pCK0UgVhKQ6hScEkqHPYTHM/CGMWicJzc
	N4kvge/dyNwkQcqLVyrbG9yK2ByXr2Z2P9jN6JR+6kyNLQKlMw78xh1VWh7GDI3Z
	5KS05TiaNGZ2PRmUhOGuXZnVLUVRdupBCKRSQyI8jA==
X-ME-Sender: <xms:qXaYam5Dd25QzBPDvDwKOBMwPjDtu4sdEbWAhflEOr1rGZSBJw67Xw>
    <xme:qXaYandZVhM4FSZfM2_cK18NP2HcR3aSd5D7gXrdHlHd0QfvWmlKkAQ8MrHBdpH4L
    sDjXT6dvwWanQmPihnWc71gTOfQGgd8CQpn0dosoR1-kSN_FQRiNj9t>
X-ME-Received: <xmr:qXaYalEMhJaH2Sswm7jgzTiN3cCuy04khYY7Xf6aqwxYl4UuaCJH3Vr8D8SvpC7dSgQzIozJcDOf5JbdYplvzwZwq_2kMRu_qRqqXg>
X-ME-Proxy-Cause: dmFkZTEm195bcli+rhZmwLg/ogcb6bLFCp6yMh+TUBzbCcGZrhK+mAtSxPTWh1gG+bRiMc
    avWo3gEfru7hkKVNDEpJcOZJoqAO9BNzmRqoyU8p3Coe5rQvMK94368rpjSbDjvzy/3UYe
    8jvGQDxPgerCZ1SHWpG9LeiFq0nOzJmbymaafbwu33qgiPw9iRnv+GKlz94gSg5Bu94jS7
    dxJj+fEzoDm+doITeVDrMy1+4hoBGFWsFbcWvlLd3hVqDTeTiTFXd55hYgAlBYatkuMtaw
    SWgeUd4oB9xfByix3QiHg8o1oN9+HGiiqXot9fX/gKQtC4rzQjEsbnNG4Me18fpnTmx9qB
    wJdyPeHmoglQim2daLUrWA5ebxkPw+e4gKAYraXnNcNZeN7yaAbPIc09HkweilTCIOemo+
    Uf1NVB93zuyRUlnODsErt0XdXSSlX8eCDHRl8gwz3nY5O1DVSx3wR76t3sZYXJYMtLinqM
    Hkaud3eXeejuwyYZVs5OG2PJ6XxMNorICvjLtUui49mmZJ3gnLKJ1TNtoYtAqNSBAfuCMQ
    469aQYYCAUdYSxC2Zim7OwCaDnE//BTubZQtygDoIrI0hjIwrEh4Qfn59e5QCoLnNndCmq
    L1hCvMXroiLq3nr7E0Ul9FXWbaIpcA5MhJBNPhHLTz+Sli0bFHgWNwyb9Kcw
X-ME-Proxy: <xmx:qXaYav5jqQWpI8l718IKcXvZk1RJ1XUQdFXw0Em94njdX89GxMlJFw>
    <xmx:qXaYagtPbx8zYFtUiQ47y3ohFrn_SuBlD2jfcGqx4qLItZLUtsFRXg>
    <xmx:qXaYar_HEqtFbExKzvQTvzDqONuNpnaQriCEeoY336X4-nYc3quEoQ>
    <xmx:qXaYainChPIvuJes2TBAsUQ2_jcOR4qEmTiOt_I4YXOk9ev1OjGZqA>
    <xmx:qXaYate5mKaGXcCgSbJM5o_QoWvMgYJaFzTDLaJO3ONV9xdDXIR26QZT>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 15:19:04 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH v3 0/2] iommu: apple-dart: device specific DMA aperture
 support
Date: Wed, 02 Sep 2026 21:18:53 +0200
Message-Id: <20260902-iommu-apple-dart-aperture-v3-0-252ce55b7001@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NwQ7CIAyA4VdZOIuhEMfw5HsYDwidwzi2ACOaZ
 e8u20kvxlv/Jv06k4jBYSTHaiYBs4tu8CXEriKm0/6G1NnShDNeswYUdUPfT1SP4wOp1SGVEUO
 aAlIjrsoYqaxEIOV+DNi652afL6U7F9MQXturDOv2HzUDZZQfuGSiFQ1ofbpr7/W095jIymb+Q
 Qn4RfFCWagNCikZV+qLWpblDW8AHX8OAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2532; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=k7xxpEHq1DhC5KsD1YXAr8f/rQawVsF7PKmfHr3A2Pk=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqwZZfNk963aPSG+Xz9C0Krs450fFpX8M/ZdvbAxTlviR
 +ru/s8rOkpZGMS4GGTFFFmStF92MKyuUYypfRAGM4eVCWQIAxenAEykMZ7hf9atae8neTs/ent5
 JV9a5uPU74s2XfUVuSRWptX89tnhtFyGf3brvpUHFibtuH6ojUE86i5/ObuXj2Bh05Z9iyK/2JV
 6sgIA
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
Changes in v3:
- actually add `64BIT` to the COMPILE_TEST depends instead of removing
  it in v2 after misinterpreting range-diff
- added Sven's Rb:
- Link to v2: https://lore.kernel.org/r/20260831-iommu-apple-dart-aperture-v2-0-d16ce3770299@jannau.net

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
 drivers/iommu/Kconfig                              |  2 +-
 drivers/iommu/apple-dart.c                         | 74 +++++++++++++++++++---
 3 files changed, 73 insertions(+), 15 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260819-iommu-apple-dart-aperture-c3b9cc79d7e1

Best regards,
-- 
Janne Grunau <j@jannau.net>

