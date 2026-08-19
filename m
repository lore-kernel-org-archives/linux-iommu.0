Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21A93806B0;
	Wed, 19 Aug 2026 14:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151174; cv=none; b=elVSx3r6Er2MSnIZDk7BeL/8BpVK48b+aM9NMi6DYeAZquJ4msAm0OD1Lcwxblp4f3ZKBZlDb5QLkEYp4M7DD/UY03m1t4Tz3hSlCHd3mdGQs988s7RzTdOCGmVPG9GxRe8aJUFeL65x97oQVAHqYVCOPsmSuKWlsddqUCXKjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151174; c=relaxed/simple;
	bh=X1xG4Kti7UIhBCAaxOlNaOaly0r9qV++jQJBZvB4bzY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qmlo2B+qvrF3ikHYRT5VBDMLGk6L4+7sA56VFF8c3vq3XwJ+5RaJ3al0TOJNEVxx8xPPA8XYECzaNsUn45cGPWy7VN7kR1d/5P1cGjb5iUBg6MmHT2z75jJGaOOnzP1m/H3mV8U0CZNc+FhOH+csi5KKQOM2Sy6x6g84hplgQ/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=GZh+AQ7t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=duVt8ETT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="GZh+AQ7t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="duVt8ETT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13D2A1400162;
	Wed, 19 Aug 2026 10:52:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Aug 2026 10:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1787151171; x=1787237571; bh=+B
	s+pMSu1VkeOn9n/HUp7Qz2+0g+eALUwogZ0nkvl2o=; b=GZh+AQ7tvllWonwb9x
	gcNt162S/Lulqm18JmDUmgGl55csWBPbQDhcW9psf0gb9t7EENYdvaOIItOgkE3q
	/Uku36Lt5TjWi1Yx0vtgb2/97gQi3vYAwcX8twWxIEzbpLlryYiBilNTY+VqpXjI
	KzdUojz1sb1UKWG8KLVwjBc5/eP3eOjBdeEvROoLo1oDnvqMfJNUmKUd9cO3psue
	4JXMvYmKNtDEotn4YFxN6PoVL4SktjRW6yZ064FLu02HhyC3wgikfS75CaOQ5Uqb
	x3+6r/F30Bh+RV/8g+FwgJkpQsJU8CkCGIAoRv/gyqPPfqP2zcPkgommccjtQqYM
	dNow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787151171; x=1787237571; bh=+Bs+pMSu1VkeOn9n/HUp7Qz2+0g+
	eALUwogZ0nkvl2o=; b=duVt8ETT5ad/Q03hXA5FxQ0HaINaUcYoyASE5hiPAmdj
	DneflhvgZhz18sauAvc+N10GVKFCY3ntYdAknQBkjD6k12gd/nzMVKpZNo5Jqn7s
	2zDri/+/tNmswfBMj8PBM9j093VR3Ix6nBjTMvPQsetqITWvv5SRpf3eOQEc9zQa
	7NKjwt/DO/XXal3xSemyrpODoUn4raR/cL1Qg9Pik6+CwdDcpufIKOyALRhZwhcA
	hStQQWb1/ETf76TqgtuixnuhSoCPyqU0P2vSd4uGfz+7qDskT2vn700UW8T+RPxT
	pxnZ4MW0NaSRCtIk2Nh/sjqXTpXOvj/pbRtKGmdAqg==
X-ME-Sender: <xms:QsOFau4MGlWn5dIP98cHZgHbi7Q0BVxSmFFA6NzhOU0tT0KivxwKwQ>
    <xme:QsOFavckr0m9tMTs1vZ7kX2Vrw-g1mFBZodnqI72XqUE9MQV-bhZ2ChAVQguXZ9i8
    AoK5hyxy_ag7nJ0jBcfZDNjAj5IxfHNdtHN5H5yGzHWNCARBwhQiw>
X-ME-Received: <xmr:QsOFatGxJxuVPiyyz-eknaHpWWVAreedcqPfeAGu94P5TBRCUiH4H-NkvHX93_9Tqzc7OaGO_FzA5tyoG_klJn_Q5_wYm-ErJUIXaw>
X-ME-Proxy-Cause: dmFkZTE6YB3JNns8bfRytE6dZ1jon8G7xO0nm76xYPMj4e26q+SpmC/dc7fRyZlphoFfhq
    WUYxLH7X6fyYf15L8HMJUJuKlgexmgRalnAsEvxvUICSMI6A74cmSHfPmgjCnHLZq70Vsb
    aBNOvSJVs2+kN74AcRrHPRN2/dwRPCA3v0iPPqfwf0DEJWfnAtpNKayf6PVX0DQlEZfLCh
    i8/aVcpYrKElaDgNcLWEN2EeK6AJAuJ1Aj1eRBu711R3Her2vzzlOZFvCtmvHxDnR9Di+l
    VtANwnLxh1f1MF/XNVqHWGHZ1/5WR6HIbcVgzaAFOTDKvkEiir164+W59LgJdUmjL/WWb+
    bOGmBDiicOp0qF66bnEuL7OZVDRBxenI9gGtNBjSy2cscIucn0TRExko9nHLbkwzSbwLJP
    NlbyMfTfN1wPe3VC7unsULtty4pnqry9uSnb4mMzyR03TAxlGo6KpdQypfFhf4/aFVj8kS
    Ouav5RjdRFUjtGvy3qDz35fajq3dU1mngMDEYZN45MfjQLnhayvuY/dHz+RcbTFgii+fPa
    QkFudgitMtfzy8lUAQeE2wrJuex7HMRUcsd0/y2uAgmCMp6gyzVfVXghtpBKYpbc9xX5cc
    JI5pDMhYWOaPlcgBejpWuS2qUb3Jf1YQ/MkHHZcpdTpPFV+ICDvFDzwXdhww
X-ME-Proxy: <xmx:QsOFan7bBxiJPm2KHQnSYv_KvXR7ROSRI4CX164nd3Aq0_S9UcguYg>
    <xmx:QsOFaoswBfs9XbXB5vLxPkBTJxJh7UHcL9lUNSyXJi6TVr05bssFRA>
    <xmx:QsOFaj_LfLQwt-lL38-96AE1CVyRsMnRUSBtTuZGVJyxwkCFr4kW2g>
    <xmx:QsOFaqk_zW1pEQKNtsrvS3v0_T6ymoTyibsG2FV5w3vpDGc_6FES3w>
    <xmx:Q8OFaleh5c8Ke_St7ylE9WQ_FOTzrods3oRjsQ7mMpZM2m0KD3f335wW>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 10:52:49 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Subject: [PATCH 0/2] iommu: apple-dart: device specific DMA aperture
 support
Date: Wed, 19 Aug 2026 16:52:26 +0200
Message-Id: <20260819-iommu-apple-dart-aperture-v1-0-252703f381aa@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MwQqDMBAFf0X23AVjQRt/RXpIk2e7UDVsogjiv
 xu8zRxmDkpQQaK+OkixSZJlLmIeFfmfm79gCcWpqZu2fhnLskzTyi7GPzg4zQWheVWwf36s950
 NHQyVPipG2e/38D7PC2XbnKVrAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=X1xG4Kti7UIhBCAaxOlNaOaly0r9qV++jQJBZvB4bzY=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqzWw/Yqh7SW3gsLLLzStkRrxbYpoktrLziYudRHTNu13
 yLj07/gjlIWBjEuBlkxRZYk7ZcdDKtrFGNqH4TBzGFlAhnCwMUpABM5M4nhf/kXs8WCStIlfP6P
 Wn2LW98o8H05dslMYnK93uVpr+vLSxn+qTJKxB3ddnxnrzPvHcWw1PSco72iezcet1sYEvXfmuM
 cIwA=
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
aperture start and the aperture often spans 36-bit address space.

This range *can* be outside of the DART's IAS. In that case, it is
assumed that the hardware truncates addresses and the page tables will
only map the lower bits of the address. However, the specified range
cannot straddle an IAS boundary (you cannot cover more than IAS worth
of address space nor wrap).

This corresponds to the vm-base and vm-size properties on the Apple
device tree side of things.

Signed-off-by: Janne Grunau <j@jannau.net>
---
Janne Grunau (2):
      dt-bindings: iommu: dart: Support specifying the DMA aperture
      iommu: apple-dart: Support specifying the DMA aperture in the DT

 .../devicetree/bindings/iommu/apple,dart.yaml      | 12 +++--
 drivers/iommu/Kconfig                              |  2 +-
 drivers/iommu/apple-dart.c                         | 62 ++++++++++++++++++----
 3 files changed, 61 insertions(+), 15 deletions(-)
---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260819-iommu-apple-dart-aperture-c3b9cc79d7e1

Best regards,
-- 
Janne Grunau <j@jannau.net>

