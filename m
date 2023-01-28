Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729733232;
	Sat, 28 Jan 2023 11:11:29 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 2B136320077A;
	Sat, 28 Jan 2023 06:11:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 28 Jan 2023 06:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1674904286; x=1674990686; bh=xDomocLJf0
	3dCkIOxFCLTmZfi+dECzZoANJhC04FOUg=; b=rDfp/wHubIgL8zdEbfERntzhyR
	yuGwH3l7OnTflO1d3w0ryGp7lMPWsIf7pPRART36FwCGDMe0PNDyLg2u8+SIl3i8
	sM/xgJXYisu9q3U/c4LmvpexbpecBkdTgHpBoJmOfLD522J4tvGtI+mnL6dv6qYZ
	x3gH829HawFTW+ix7HJ6rV8Z6EVAlPxidyFMADkED3Or4DEvtCt8YjJOJqVcBSbp
	zrgn8uRetSxXKY/5rVbGecjVSfCBmpFHC+M9B4LoBZOzTnxENJxupWzvfeIlTNhV
	XKqlWg3OPCHt+sJ+S6fdupVIpMha/Jf2I52FLT1HFqCxQdASW9G6ehvoDmnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1674904286; x=1674990686; bh=xDomocLJf03dCkIOxFCLTmZfi+dECzZoANJ
	hC04FOUg=; b=cJzlVy+puyryLt6DlT2axtUawKzi7sDeWqCg/AnkMDMwu+11XjL
	u7nyfZpTl09ilndUocKijBLGxVPLq3sPgezj9/zD6p+OkLvCxS4k34ST+F06WPBx
	SiFm7MCPHoOexsn2WBIvNosP5Hy6APSwDjOwwS+KC1eRlgROAz+Jlxm322iaPy28
	Z60UEsD8/XtZP0DrE3IMeQ4vNaSZeHL0lxD1LTQ5xhsOavYEXCZrWXr/xFT+H66x
	wlFqXwm/7FakIWq+pz0JGmihm70eYvK1jS4fAJyLq/NsOg39sM4J1sB2cPGjtPf2
	pT8zXUjGUwft5xobNLJjCfcYwc89b8TgEMA==
X-ME-Sender: <xms:3QLVY1HZOl3F4BxUGSU2xHKzHgD53OKvjyWgWMnWHnRuTmb9IFikxw>
    <xme:3QLVY6Vp723A04WZKcfd5_d7_5N3CbFJcRkPACSycaUDzkQXoA_47HPY2QDTvUz8H
    IVkIo68jC6vda5nsGk>
X-ME-Received: <xmr:3QLVY3KRVllc4SUsb_B6k37V7VuRMIcfzMiU7ZfMJ88aYR69L5Hla7lI9JCU6_xHTF7srxE4cm7HuGhKuoO4chEyO5xBtofqLTGQOhE6C29UbC5_EGswDhzANjCHzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
    vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
    hnpeeludffieehueevtdffvedtueelleejuddugfettdevhfefffdvgffhjeehgfelleen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnh
    esshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:3QLVY7HFgwbJXAXQ5RkdnoBIAGFGsLvwEPHO8gYS6SaE_Fk3JChu3g>
    <xmx:3QLVY7X2JyNQT6N14U-b4cRTKmRqonhj8i-yhcIQ62DkYku42cRU1w>
    <xmx:3QLVY2NFbcWOxlj8ckUHzo9WYMStv_5UNPk6p13lMitCWFgzwfrJug>
    <xmx:3gLVY-N2u8rV0ZRTmlryWJGpg41MQ8oHS3Dr7o1iXZvgj1f6WXICEA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 06:11:23 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	asahi@lists.linux.dev,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Apple M1 USB4/Thunderbolt DART support
Date: Sat, 28 Jan 2023 12:11:10 +0100
Message-Id: <20230128111114.4049-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The M1 SoCs have a second slightly different variant of the regular
DART used for the USB4 PCIe ports. It supports 64 instead of 16 streams
which requires a minor change to the MMIO layout.
There seems to be no way to tell them apart from the regular DARTs by
just looking at the DART_PARAMs register so we have to add a new
compatible for those.

Best,

Sven

Sven Peter (4):
  dt-bindings: iommu: dart: Add t8103-usb4-dart compatible
  iommu: dart: Add flag to override bypass support
  iommu: dart: Write to all DART_T8020_STREAM_SELECT
  iommu: dart: Add support for t8103 USB4 DART

 .../devicetree/bindings/iommu/apple,dart.yaml |  1 +
 drivers/iommu/apple-dart.c                    | 42 ++++++++++++++++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.25.1

