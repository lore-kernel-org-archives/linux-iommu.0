Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12871547E9
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 11:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672459; cv=none; b=QBslHzloxa6VYG1VYzSmckwLPAfkqCmIj7SkBwALeu4YIZF3/tYz2R/uQcuhq7c+uR0ZzVyvTIN4iUGE8ajTggXV3m1EFVW5QM1aqZknOY7azE/rcbcwaF+6cyZOUeNEyskPG2EOFvdt7Ky8h3hB88fYGMuAypNvSgNyACP6mTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672459; c=relaxed/simple;
	bh=6mOIGi8eWFfBUbXfMtI8aXTqY1hiHLwOMEvzBhD/gMA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WBJ5WUMqaTh8XanY2KdrZTdSU23c3k1ZQO35dadUBmC7ON9Q8jcA6xg4+LqxMPF5lnWWrPCEqQG1v8s9FaVmysrRiXT5NEBY5pDGaklmkLyXThlQv6V5y/A8p6Q9RpYxpmX8i4TkoiYV3dGkkzls/j0aW54BSbOHtTW0X/h0+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk; spf=pass smtp.mailfrom=irrelevant.dk; dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b=V2vOca6H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mn24dR6w; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irrelevant.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=irrelevant.dk header.i=@irrelevant.dk header.b="V2vOca6H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mn24dR6w"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 16D2A1151B30;
	Mon, 26 Aug 2024 07:40:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 26 Aug 2024 07:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1724672457; x=1724758857; bh=Fl0Byk6Xko02Any/zqz+yNt8CJ2vkbrY
	q01MKLCOOiE=; b=V2vOca6HjHj9mb/PkdTHTPQwce2eLBP6e1Wq86sYd2iRd2cs
	DfdSKsbDqXlg4UPg1LnDXdfV3a3dSmXZwooNzphwrrK4ibyCBgMxP5w0eKYTElcg
	u0pHdjpH+u6F9cPlXZ9AX9WiuvYHGEa6Y6NCmmO1lDmA3fNReuQvP1QIqpzIcz/n
	3OobJ/GOdEiPnzKOwKu/FWqG31jaQ7EpoOdr6lmbdF1TCLfoHwMTSUv7VpalPz/X
	0g1KpAmfXlCEWeJG9yCHryMtBH/F94dGB7xSVlUO0gUjVHhnHQnAZ9JbVMN+fgQ4
	Ful7ud9Tm0E8b3/N1ETfZgpYeFN1BmMFurbMaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724672457; x=
	1724758857; bh=Fl0Byk6Xko02Any/zqz+yNt8CJ2vkbrYq01MKLCOOiE=; b=M
	n24dR6wAW1aVWcuKDxg6bunmo1GFcVr0KrJp6kCFYNyCAy2WuSEOAVCaZlrOWsFV
	/q0B5okbaEeONzJRlGffIHeIzuQB+HDnqaTVW5G6m7oOBdOWg1hmWlQiFIiNVixc
	H0zIvNWhqC5XrTSzxIJGO96ex4QsEYp3Ct/ndkJCmpUDM4EEsVLlPe9duYzs3VwQ
	OVyZzRuwHv8eAaIV3SSUtgdFXHvVBmjq7SOQhMucMYqPce5XW/WvIX8NCSuAjEw8
	ajg0VRXrLYyZ+jbrqHj3BbOo9qB2HWsLL08EcDTG0Whd8/RlKKZUEkfQWQXLprK0
	AVyo8paAtT67GNtiUzwOg==
X-ME-Sender: <xms:yGnMZohF3qMUFr_hEd85s977kYe8SauPm-WZib6g-xoAquSzpF_oGw>
    <xme:yGnMZhDnccnyL5kiMkPV9gem6ZoJXSsBKiGqKBA0QSBZTm0BX1yQIDTA6mHfp0kU1
    MCy0lm3oaIR8ljqqc4>
X-ME-Received: <xmr:yGnMZgEaOPWo3LvMPoyjdyedjRN6AqU8DE2he9IhH74iFYLsRkzBfouumBr2B5mQGJmsQDJdd9IgMp9U_7WwUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
    drughkqeenucggtffrrghtthgvrhhnpeekiedvtdeuhefffedutdelfeekhfeitddtudev
    gefgffeiteevfffhhefggefhffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphht
    thhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhdrghhrrghnrgguoh
    hssehsrghmshhunhhgrdgtohhmpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmshhu
    nhhgrdgtohhmpdhrtghpthhtohepkhgvvhhinhdrthhirghnsehinhhtvghlrdgtohhmpd
    hrtghpthhtohepugifmhifvdesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehi
    ohhmmhhusehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheprhhosghinhdrmh
    hurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepsggrohhluhdrlhhusehlihhnuhig
    rdhinhhtvghlrdgtohhmpdhrtghpthhtohepmhhinhifohhordhimhesshgrmhhsuhhngh
    drtghomhdprhgtphhtthhopehjohhroheskegshihtvghsrdhorhhg
X-ME-Proxy: <xmx:yGnMZpRkD-y_WgtagL5ptT_YYjbGPYv6yLH-iDeTbJAINVrQT3GpHA>
    <xmx:yGnMZlyPnqOllvVUNDKOUur59tE4wnKN_aErlk05b9oOJGWBKdPICg>
    <xmx:yGnMZn5OBpHiGybeB7T07FlYTioSFsW2BO7NSYQ1jC-LxiNmVSz3Uw>
    <xmx:yGnMZiwx-nyfBAsYE4kTffAhkb3DYNXsqLIEuKSkP3oGLCf-dGIxgg>
    <xmx:yWnMZorUhB6oW5W5XAIiieQCFY5In2Xbk2x228d-A5Vq9aBBNfcqVEph>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Aug 2024 07:40:54 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
Date: Mon, 26 Aug 2024 13:40:28 +0200
Subject: [PATCH RFC PREVIEW 2/6] iommu: Make IOMMU_IOPF selectable in
 Kconfig
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240826-iopf-for-all-v1-2-59174e6a7528@samsung.com>
References: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
In-Reply-To: <20240826-iopf-for-all-v1-0-59174e6a7528@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
Cc: Minwoo Im <minwoo.im@samsung.com>, linux-kernel@vger.kernel.org, 
 iommu@lists.linux.dev, Joel Granados <j.granados@samsung.com>, 
 Klaus Jensen <k.jensen@samsung.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=k.jensen@samsung.com;
 h=from:subject:message-id; bh=ht2xZMigewF9A7qohlF48obc1MLGHg3kw4jDBytvoWE=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR2JNYWIvVThUOWJWcXI3bXpWc2JOaVR4eURDCnJlbzUwTCtCQndiYW9GNHZX
 c2pQQjRrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKbXpHbS9
 BQW9KRUUzaHJ6RnRUdzNwZEw4SC8xeWZYRFlJOFpuL0gyQk9STEZibjVxM1VDb0gwRU1Tay9XTA
 pOcG9QTlFEMG42Y1JoYjJodnUzaWgzb0xzeC9RN3hYNE1PYStGQWxxVDh0Qk83YXJPRitSZFhYZ
 jF3SkNTM2JYCm51NExITEwzZUFHdTJIbjAyRE5ibldCWFIrZU5KQWlyM2NDQ2VIWDFQemh1Wkpo
 RTl2TUJTbnBtUEJuck9jYWQKbFF4OXpXL1NRVFRxSTQySzI2V1pETjZ5Q2twZmlPSkRuY0xmeEk
 5VWl0aHRwbWJoYzdOb0srU2JQSCtnYWJPZgptSjlFdTdhMklKRE1rZUZxR3JVWlRiUm9LY3k0UC
 treTJRSUNrT3BNUnVrazZ2anB0LytueUs0K052UDc4NDlZCld2SXorcFh2cnJLMUdZaFFaRWp0K
 1RyT1lKMTVuNlRuTHFiaytyRVBKU016cDM2bjhLOFdyckw1Cj04anQ4Ci0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838

From: Joel Granados <j.granados@samsung.com>

IOMMU_IOPF is no longer selectable through INTEL_IOMMU_SVM effectively
severing their relation and allowing them to be used independently.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/Kconfig       | 2 +-
 drivers/iommu/intel/Kconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index a82f10054aec..d3ee8a0ad4a6 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -164,7 +164,7 @@ config IOMMU_SVA
 	bool
 
 config IOMMU_IOPF
-	bool
+	bool "Enable IO page fault in IOMMU"
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index f52fb39c968e..fb5a4593c197 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -51,7 +51,6 @@ config INTEL_IOMMU_SVM
 	depends on X86_64
 	select MMU_NOTIFIER
 	select IOMMU_SVA
-	select IOMMU_IOPF
 	help
 	  Shared Virtual Memory (SVM) provides a facility for devices
 	  to access DMA resources through process address space by

-- 
2.45.2

