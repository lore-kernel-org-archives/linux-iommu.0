Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987881;
	b=0FbW3KUsDLh44Sctgtzs0hkuL7cVTdSnJNzSYO810zhYSGA+NLKd28DaVMaQECwTND2j
	 Z+unV09RkR2su1V48+i64Vo6xJGMukZrkV+/sUhXNot9RKiLjSsLVobE9zLXXf3WxNzYi
	 hEI7F5E9XfUWDgEt84LEePExCZ2/NrKcD5HnBx+VciCyBhPqb47d4TpbXcc2D2c/NQVq5
	 AvHQ5nt0G2RHLSjHcCkee8CYA7D69EU04ttPDpSMAuZKQxEb3Gf6uBRiIoeGN1fJePv5E
	 Qv1d0nELYbhFHk4kKMdLQcL5mPL4k2jsjxWgk+88ySTQT9S4MEOmC2sXsJPPPE02hoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=T+OBJumt7aOGbXuujpyPpgenryKc9X6dlmxG6bj1Jk8=;
	b=bV+4mUfmvfEuHGk6xbQlrorXnVWbM/98bl49//V8dqErIrYda2XflmVrA6AxmHGIU956
	 MmDOS6vPAC7dqkBlRHLUintc5QXmfuy80LvvC8i7Alb9F+nYHh6gHSVKTP9Ry93tTWWeI
	 AOiieC9oSLjbdjPirT+tOEZJ/Yu4YOj+q9VcwTDkNmMryf5lutJ26Y683Q1DP6wmIOLbE
	 5Y7QMPZ412q9UnZRJ9acOQIH2Jpc5RZd3MAocf6e8MXh2Emf/UEt6oEbiv9HT8YvK781a
	 7+B8Wgq09IT/3nhm6u+e6hFxXx/DPDSkCC2piZNKw7+pQL33F6CpLTuzB6IPIUMWcEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UmX0sHTn;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F3C606A330
	for <iommu@lists.linux.dev>; Fri,  6 Nov 2026 17:58:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6F3C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=UmX0sHTn
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so392314a12.1
        for <iommu@lists.linux.dev>; Fri, 06 Nov 2026 09:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793987880; x=1794592680; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T+OBJumt7aOGbXuujpyPpgenryKc9X6dlmxG6bj1Jk8=;
        b=UmX0sHTnvp+9NkdMk3SBxy0aYRw/4Fw8E+wGGxLEs46N/oqdOLsco1edOj2n2l6zZx
         Y75q9/FMd3IyuCGpBSU/j1cwu3mx9E91aX5ZrQJ90jf/69is3TVAFAVladXZBSZSorRq
         vcHJiz/1ZjSZmZVu6FATWkgKk/yKvUhU5S+CpJO1ZA+gZFEMgWyldQIUDF0Wg3+k/Y53
         sy2BDaHwmhtMaLCy5tWlSTBg7webZzZcz9+85LiTMqWTWBGViI6KBif5FuDtcUaMyO7O
         FvWxsp3VMneXdYqyqDcJ+AieomshLWTJFguAAr6GUKJvfQoQvpBJ9OQ2auIPjOmwzFJL
         Hhgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987880; x=1794592680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T+OBJumt7aOGbXuujpyPpgenryKc9X6dlmxG6bj1Jk8=;
        b=h3a2HwKQhoL1dw3ia2yf8MFTz15dFa969NUop5Ua/7s2gIxpuKux9L199xTbTXjdvh
         5uB/0lUAOYeMLQqVfuORs7NKEpyQiYoKWesMcQS4Hu6LYXcViu55bCJZvxykmxqHEDdR
         +sKDkVypDDq2GrMvfnbM0c7HoOkmkAglYnciiUa9Pcmg9mi3g8DUbGJxAk/Yp+rPU7Yg
         BZJ8MlEFizFIoQbRmDbj31HPnCiQln++AZsy6zzo7fei2ZQ4VHJlxbejrZzGbFfqy0eO
         8gtTFiWaVuGxc2MLGGEIfa344Hov43U/hDztHbuit5lj9RpeFmbCTNSSzmhTz5vJszqV
         8sng==
X-Forwarded-Encrypted: i=1; AL+hErEvpXGqy95cBdWAfSB18KUAZl1ju3qncQbncdC9DqPOVGkbqDIUkX8LFKrNAeDrubzTapfuzA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/NvPW1N+PR/SYyJ+thvyraRpcwHzfNr2r/nvfHDQPj0kNXgwI0
	JLDLNALJVlaWmwbv//Br7waYWND25NuozCFnLus0InhwuDQaMu3qieoed6VDEZbvMjE=
X-Gm-Gg: AYBFou3Q/CRrt2ofzekBCtTRnClbfUJLqaa5ZDuIAMI4aHLFjDgaZRpHd0e285be09f
	CKg42C2YtxUwSezBzrUOm+7xD1U0+SK8nzYWsy6+OO/hrlL4YnU01ibnZd3AS/kVPiXuvNAz5wb
	N6vAeyLNw/jwwOOu5Kp7jSYmDxIIL8SK4r74uuQXWdRAtrd4YYPs9wnezuvEjgpV/S1uQ39mov4
	PMDOjQJRob3QhsYjjBVDKuLO0R/NmZCa+v7R00sDjmKEEusTNmfIFcrXN4j9FU62BG6u/rhcVj3
	jR+oCQAE7Ur7KJjIVGUDN2WK7/yyWHG83ASF2u3M0KNGs4IFKDjLkBo36iiNBiztSNIVjVMhlah
	s+NBhWwbNwZAn7GkwOg1Pgt0FTHANkYNTiIw1K+U2IHn0BKLN70MHwvX7JzMxkXht4eKqRJNnum
	xGqbUVoGgq7RvwpIBlo4qCKSUwekoqEQbNHZNWeK+qlVgzsHQYv5mDaeSOLiPziyM1H9rFYXioF
	o/hRk100g5C2SqU4ajn/YcXY92pWprKgfeortF5enOOmmxy/KaPLMqKoGudSHwICU+5WNsrMZN1
	E0m7QjcPtIQvafMxd23OGqXtAryMgJCRVlUzUEpzHg==
X-Received: by 2002:a17:90b:1643:b0:3ac:97bc:4c98 with SMTP id 98e67ed59e1d1-3b0db7208c5mr3473355a91.64.1793987880151;
        Fri, 06 Nov 2026 09:58:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b101ea0282sm125897a91.4.2026.11.06.09.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 09:57:59 -0800 (PST)
From: Joe Damato <joe@dama.to>
To: Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Joe Damato <joe@dama.to>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iommu/dma: Add helper for coherent devs without swiotlb
Date: Fri,  6 Nov 2026 09:57:42 -0800
Message-ID: <20261106175745.3362057-2-joe@dama.to>
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

Factor out some repeated logic which checks if a device is coherent and
if there is a swiotlb.

Replace repeated instances of this logic with a call to the helper
instead.

Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/iommu/dma-iommu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78742aeba932..a25ee287a5ac 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -628,6 +628,12 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	return false;
 }
 
+static bool dev_is_coherent_no_swiotlb(struct device *dev, size_t size,
+				       enum dma_data_direction dir)
+{
+	return dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir);
+}
+
 /**
  * iommu_dma_init_options - Initialize dma-iommu options
  * @options: The options to be initialized
@@ -1103,7 +1109,7 @@ void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
+	if (dev_is_coherent_no_swiotlb(dev, size, dir))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -1120,7 +1126,7 @@ void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev, size, dir))
+	if (dev_is_coherent_no_swiotlb(dev, size, dir))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-- 
2.53.0-Meta

