Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794290719;
	b=Rirx4LG27/Lj8y7PWUdxQ/OLc2A/9aZusuHOtyB9sl9Lv8dUAzlHmt5Hn32+B8nYMIw0
	 iwmnV1ralFhzlS3QfXlbj7EofrmqlY4qr++p1ff47ZdlMyjy/tYkBAavRgjgVlmb2WOh+
	 g4FkaRzLs6/axQzoeq/o/IPqhKMxiLzDRinhG68RKaZinX6490cG/gTbaLBsjzGHivfBE
	 BBjBjCg63/tns6VoK0y1/s9bUGDxZpErs7oL5E8lmVgt+Y29wICxzFbQfwb+8uyPgwCym
	 hW9QqiSQipiN2ab15SKGVU6PFz3j7h2cstQLNZGSOwnQnpuoSb7lONi3394WALQDXyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290719;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=isj8QmDoAv2l5fg1HSQfo6B6XERKWEnEINwxmN+yGVQ=;
	b=RMAFoTjY950NLgrH7cu1Emqw14YAHTpFsFOR1dNHJnq8hXbIy54LQZWQ0WDcXc1EuxyF
	 A2+CRVliI5m0vJ8hwJrH7dPfT3jMedk5xaBG1e55RJyXzatG5LyAVCRu7Y2CDfw+uT7Hn
	 fdUY7uqSqQ3UsC+63wmahJw612t0KnTsRswagnCM+RLHY8wESXDDxv/v/wgkoorpGef/K
	 IyRuiN7MpQyKACRjm8ygpCENwkF4wUta1MMBaT2unGk55xpiIjT9Z6cHjpYtWZTIZIvDB
	 zGcME1nxHCrntm3BXgKOYejUJOpYYQd1phzpnCv/OQjj2agPS78B0ssBS2Vmbeiub6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQbbbDeG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52E606A325;
	Tue, 10 Nov 2026 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQbbbDeG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794290718;
	b=FpJsAeTy7CbyxhwjhEXAGXDL3NuNl8Xfk5v+RDmFob9wV3mIrrPlQ4R8pSOEWZ+YeuTP
	 aqtHqObpYPNmWdLDySlen0qHmjwGNURK0WP1CK16Zyqn96oUP8B6fVYKbpLf/MzipFQ2k
	 Xj94ptofHUMxzzQNTuKyYfHIx4OE0YeY6zuyVjNEq+rEuWd6YQSSSMA2FEv4EPmGMW00U
	 aipHfFXOUdHYw0sUvMAW1689/yoJuV8xK0w3ZePG1SfOcaWb1rKzi7CEFVDYJhrVxUXif
	 mpHOqR/bpCeJF4Iv/KDWa+MDifaBPy05eGm7Ae2hu7jxSOXhq5P2C/YcpnRq7S7nTgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794290718;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=isj8QmDoAv2l5fg1HSQfo6B6XERKWEnEINwxmN+yGVQ=;
	b=uuMGALfJxD8G9dsjPPGHhOCtfSfaZNr9JgB2m1vcxdgU/umikHSWGXvXDqEV3BXS7fmI
	 mdrmbYTxgI22zJK4ehrOaubOeqLnc4Jvt/MnPPXFtuKIxHUuYEqCxk/WUuCXEJNISvJyF
	 Zy1fKl+94sTViqcXg1PHODK0Dh8ZsWDG+CLVqhehKf9OVdJwZNHsTJweDYZhVLZ2+dTEF
	 efKu5qlOaalUebmwCRpr3fqGof95fpRKQTMIhF0mx2FB3nA4S1uvxRhNC7xSQveUMWIFg
	 dIY1/Fodc/HOBTftXUB6BQjjiTEdaX9zSS1kodjOJrEox4xgBuhT6M3MjuFBpzUFDaA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ED1F31F008A1;
	Tue, 10 Nov 2026 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290718;
	bh=isj8QmDoAv2l5fg1HSQfo6B6XERKWEnEINwxmN+yGVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XQbbbDeGJPEkijR+PANK2i0N+5nZw9uZO7emzRSVW86HN4it8UxEvwKwDp9i7izg4
	 GnV4efxY6Hx9ia9HU9St4ueVIy6cos/wJkSN2Gyjdye/07jYsSP2M6kPACANtIYq99
	 sN6NFeqgflbWTrsOlwMdGFZfl0wljwcPtES1dfHDIhpEwxvSrt3gZAlQwpP1Fgrfcl
	 fXiWlzobOnMJlV/Z5Mu6KbsP/Bie3s51KDHq7OrUdilwka1Cd8z7hfSYXljOlUIby/
	 +eMykFG9YyUl4u09Qs0hTqgJqso2gU8+63bJMg7jBm9iShVVL8IXRudZ9P/CujuKDR
	 kupzcOUfBM9EQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 71183488DF;
	Tue, 10 Nov 2026 06:05:17 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:05:17 +0000
Subject: [PATCH 1/2] iommu/sun50i: Don't report TLB prefetches of unmapped
 pages as faults
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
Message-Id: <20261110-sun50i-iommu-prefetch-v1-1-43428e792ef6@gmail.com>
References: <20261110-sun50i-iommu-prefetch-v1-0-43428e792ef6@gmail.com>
In-Reply-To: <20261110-sun50i-iommu-prefetch-v1-0-43428e792ef6@gmail.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794290717; l=3445;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=yLoe2znns7P0Nlmxz+qhOed7bJSPIV/igjF81whNh8k=;
 b=7OZXIY/FUo+0ssrRcC5PVK4pgBVfPVCGENntFR4oujOO4H4aYnqjXuNlSiLoiimQAbHlN1eXl
 lGGYmF9UU/zDufC7H+GTKls3rXhjGA1bAxCCLdmCvb20Mn2ibWiwLtH
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

With a display scanning out, the driver reports

  sun50i-iommu 30f0000.iommu: Page fault for 0x00000000fff00000 (master -1, dir rd)

on an H616 once when fbcon takes over the framebuffer (the first
scanout frame), and again, vsync-spaced, after TLB flushes while a video
decoder frees its buffers (every unmap flushes the whole TLB and PTW
cache in this driver). No device accesses that address: with the IOVA
allocator handing out addresses from the top down and size-aligned, the
3 MiB fbcon framebuffer of a 1024x768 mode is the first allocation and
lands at 0xffc00000-0xffefffff, and the top 1 MiB of the IOVA space
above it is never mapped. 0xfff00000 is the page after the end of the
framebuffer.

The walk that fails is the TLB prefetcher's, for the page after the one
the master is reading. The H616 user manual (3.12.6.50, 3.12.6.51) gives
the L1/L2 page table interrupt registers a bit 31 next to the per-master
bits for walks that no master started, and Allwinner's sunxi-iommu
driver treats a page table interrupt with bit 31 set as a prefetch of an
unmapped page ("It's OK to prefetch an invalid pagetable") and does not
report it. This driver masks the register to the master bits, gets no
bit, and reports ilog2(0) = -1 as the master.

Return early for a page table interrupt with the prefetch bit set and no
master bit: no master read anything and nothing is stalled, so there is
nothing to report, reset or zap. Print such walks with dev_dbg so they
can still be counted.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index be3f1ce696ba..1b7a7f0d9b62 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -73,6 +73,15 @@
 #define IOMMU_INT_ERR_DATA_REG(i)	(0x150 + (i) * 4)
 #define IOMMU_L1PG_INT_REG		0x0180
 #define IOMMU_L2PG_INT_REG		0x0184
+/*
+ * Besides one bit per master, the L1/L2 page table interrupt registers
+ * have a bit for a page table walk that no master started: the TLB
+ * prefetcher's walk for the page after the one being accessed (H616 user
+ * manual 3.12.6.50 and 3.12.6.51, bit 31, "debug mode"; the vendor's
+ * sunxi-iommu treats a page table fault with this bit as a prefetch of an
+ * unmapped page and does not report it).
+ */
+#define IOMMU_PG_INT_PREFETCH			BIT(31)
 
 #define IOMMU_INT_INVALID_L2PG			BIT(17)
 #define IOMMU_INT_INVALID_L1PG			BIT(16)
@@ -891,6 +900,20 @@ static phys_addr_t sun50i_iommu_handle_pt_irq(struct sun50i_iommu *iommu,
 
 	iova = iommu_read(iommu, addr_reg);
 	blame = iommu_read(iommu, blame_reg);
+
+	/*
+	 * A walk the TLB prefetcher started for the page after the one a
+	 * master is reading fails whenever that next page is not mapped,
+	 * e.g. for the display engine scanning out a framebuffer that ends
+	 * at an unmapped IOVA. No master accessed the page and nothing is
+	 * stalled or cached, so there is nothing to report, reset or zap.
+	 */
+	if ((blame & IOMMU_PG_INT_PREFETCH) && !(blame & IOMMU_INT_MASTER_MASK)) {
+		dev_dbg_ratelimited(iommu->dev, "page table prefetch of unmapped %pad\n",
+				    &iova);
+		return iova;
+	}
+
 	master = ilog2(blame & IOMMU_INT_MASTER_MASK);
 
 	/*

-- 
2.55.0


