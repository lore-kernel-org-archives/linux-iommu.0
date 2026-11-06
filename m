Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987884;
	b=DlOOODdLr8CwvvLl9cbjZZi9L5ufv29r0RcSq5a2KVKU880wsBNpZaQzjDvqRSaP2GBn
	 w0VweFCbLxwwinz0dEAc8IN2g50Yo57W0LJaY1lGHRme3QbQMyGQsrv9HGamiPVAtKJur
	 UDvFUqw77pCgu+7Or+O3Y4a9SKdTlrbqUV9vU+oJpELRQIPSuZbAI77UeuAmBghxofOdC
	 70Y4W+j8mgWROyoFZmsE4e2Cj5MgU1YFq4SVyzVpdnZfgsMlYONrUEko1AqdwbR55k9WU
	 PkaFYj2d6bhfdvKEi/SI3ZFhcSgj61/e+32f3YXdPgygsUtfAs1CfcOW5vdWceKOgCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a15VN+jCu3B1XSBa24cW34JdNvW6biC29j8hroS+/qA=;
	b=GLJFuZO3pvJ+Sqh3S7TBDG0EmpCwd1FCpndcgMmTPlg7zZT5nbO+jmGMzFP5Awkozhhm
	 W0BUypFzzp7UyrR3FYNLsPj95vc01VW/Y0vTXkQni4xOir4CvnxcNtvTAhy9EuxuTJ7jd
	 2VIgEGn+YjSWufw9FHxvjgj7RIcn8cF1YsLcbT70c49TGZyj/wnzB2WzbRXX0faab3+er
	 Ddj+/z3lB1IFh2EbjXZLs1PMmJeiywKbIMYMy5ILDklCiqCliSzDf9v5X/XvR3ClDzgPx
	 rvSu8HIdq7IYQ9oGCRXMQm+VfkRf+0VbeU0dV2slTqFIybpL/ig5shqWTmdqfO+aFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IzJhUAAV;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB538606A33E
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB538606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=IzJhUAAV
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so357060a12.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793987883; x=1794592683; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a15VN+jCu3B1XSBa24cW34JdNvW6biC29j8hroS+/qA=;
        b=IzJhUAAVID+siJ9iu66GSGks5qxxJ+D3xs9jHlMh4eXPdG05psk4/0kQ0JmsRiSkJD
         AVcTfBejIRVstcImLG9KSsldJrVSIE67Wtgko7tJqUhFE9sHifWPZetSDEjckGOtX8vz
         0Wzks/cEuAzKHd1w2yS8lugC39YuqJ+rw0G+OEnvWVif5HDZC4Eq1P1IAVwXLouSeV2D
         cgMQTa6ssoVHbyOEvZzsCftQSafepewfzTodS6vkPj9TwiVRi2iLrbkHqc9auI1fOI4G
         SptSQXI/K2KoA+bXUN7wjYTxoI0xlUq91hYeLhoDHwSwkY3m2MX0aBhDsyEwWfPB9w+z
         f7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987883; x=1794592683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a15VN+jCu3B1XSBa24cW34JdNvW6biC29j8hroS+/qA=;
        b=baepHDP1Gzg2xd9944uVAjJpYmQaN2cN5AtHEHdQt6x7/PVvypvyR46dG6mZ2KlAJQ
         vAazp4rOVOad3nnDgUAb6gsmsl6+1pm6rdtPHlnf/WUsroSR7SAASANlv5LAlfQUnfhQ
         S11qQbQJl1LScQ2Ci//qWU4dKajqdnUxIIyzRX1Bv719MM2MugmFPn7TkHdKjKUQ0F6W
         hezJ0CekglyI+1JrMu9+isdCfRoThSkPVeZEBWdiWX7YLe4XCPiGFHIMjFKcfuzgJAk+
         INmmuLz1gMu2HbjdT92nLRGSJpiA6r0tDT3imXCkGqw0xVOfm+Y8AhaRLw/XU0rJ+ghG
         kwSw==
X-Forwarded-Encrypted: i=1; AL+hErFcHKAx3Y5eMcbDTq/W2PqmAJAa9eqK1mYdoaPRfztdLGY3u2pUIl5EcVTYXwrNm1hJUlDcEw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/EPr0akg8l0N5lfFVOfIDEWOdK9zjMHVkhj5eMqoRnU6RrKh64
	tQDFGUuoWK4nAmQp7q16KcUaZEA08EVWJHhh0IDipF6sKLPiWUgCyUubXnIvwxlZqRXSpwohpX2
	4IUBh
X-Gm-Gg: AYBFou3BTKBYTf0Z+eQtxfpp1ntBtRIw4GGssTPPFrCEuf1d4uV6sAlYEHLww62Xxdu
	7hdmusxeiT48r4AbHBvAXSvoTPo9nsR3p+EBNirU0Kz0yn4TSnJ/pSPwBNt3dJd5YMyhkICC6nR
	VEvbLwkamYaufdX3ZB2VI4BaH5UXB6b992iB2tq9yXZLfaHT6zrJrq1rzmlL33rPcDWXa507KOY
	VZ3OT4RuyRanA7hmOiImOzkv8eRDxP3rSDCDlrEHpH5k55ZMGKidstLqntFHkb0Q/VKqo6xcYuh
	Obv4KlUNXTV8IvfbEHf0FWIEhEELvGAg6gp1adnOBQUhd3Pgb0XGmm+4LB6OQEeEh2SPNyFMTyp
	aoGX3Mm3IH3okbAlKjeKlaCCwPC3cFUFMKr0H/DNxPemPMnhSKFmdIe/aTjuUv6Tszt3IJGIJ2b
	iShtM2cLhP5JYwTkRdwlm9L1YvQt3xz/SP5a0hm7kmSm86QjVNDkn9hUIeSsjMO3bAqJp4kc2He
	IkgmEUQpb+519zADyo1AOi+sVydNsIJhN9u5DlWlC8fdCu7dXbho5QNpDoWzgN+9tu4swQW2BZR
	aJDCq+2DQoiRzMSTekMQx+wLEe4eYHt1PHSr8rNoMxOLjeSRGM0kHhgOyJuysKLY
X-Received: by 2002:a17:90b:5703:b0:3a0:abc3:afb5 with SMTP id 98e67ed59e1d1-3b0db6f46bemr3110575a91.34.1793987883162;
        Fri, 06 Nov 2026 09:58:03 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:4a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70661c97sm891550a12.5.2026.11.06.09.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:58:02 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Joe Damato <joe@dama.to>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iommu/dma: Skip iova_to_phys() on unmap when unneeded
Date: Fri,  6 Nov 2026 09:57:43 -0800
Message-ID: <20261106175745.3362057-3-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106175745.3362057-1-joe@dama.to>
References: <20261106175745.3362057-1-joe@dama.to>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_dma_unmap_phys() looks up the physical address of every mapping
with iommu_iova_to_phys() before unmapping it.

This is unneeded for a coherent device that does not use a swiotlb.
Skipping this saves a page table walk.

iommu_dma_sync_single_for_cpu() already skips the walk for these
devices, so do the same in iommu_dma_unmap_phys().

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/iommu/dma-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index a25ee287a5ac..c4a5fac4f7cb 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1260,9 +1260,11 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 void iommu_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+	unsigned long skip_phys;
 	phys_addr_t phys;
 
-	if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT)) {
+	skip_phys = attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT);
+	if (skip_phys || dev_is_coherent_no_swiotlb(dev, size, dir)) {
 		__iommu_dma_unmap(dev, dma_handle, size);
 		return;
 	}
-- 
2.53.0-Meta

