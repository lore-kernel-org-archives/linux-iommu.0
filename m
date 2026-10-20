Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792474483;
	b=f1BREbn3cT28j8FNyntqE5QVxxpH/p5eJl1roEJ2Bo3ajkSSPTD1vIucE+2U9vf+vIpk
	 WHQJ5SK+OUolH2WIRuOxeeA7y+PdRxGaXQXLQvrB6r0EeFw2hCxxEBcq6wVmm7zkSqekT
	 nNpJUAIWVtkN5GIReFhYgiQedFjet4onE1VwSCWmAKoWT+qCA8bKcqzdgaqFtLr8EjYyV
	 ZObMmWcz0X5ZAsM+zeNt59HiO1LmKb6QzNGPOt8HDJxlGuWM7W8SWiV9c/YRK0JXm8onv
	 O8we3EoEXJP5DA0fJX6LhoyvBPCXC7N8mAoCzWkzuyJ6IKGf5rOFati4trAWzhGB2EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792474483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=flDdnbgpLbuu0srS7vDLug/Gj+E6AwZDNNV7bkNw8vE=;
	b=U85pioQtyLpvCws8B9vtk53mSrzj4GGVM/hnUl7eSlluPm4eHUK535Nfedi5YiuvOX4H
	 beO1AwNMs7NHfgGix/SOcETMiQM6ljLjDxFsk1WyLlKPECf/XkLnMCc1X/AJUOmOKP8h/
	 fHnK0DKbPVkXRVtz9Er0clqKsfljnlWJVlA9Fma6BJSyMMIOvrNIAfRb9txmiTErOCAzq
	 ciwndttCfcwfe+44xQ71USXv0ec/y0+gvK8urZfGqJOQNnPxAaBP2VVD3DaSm/Ooa6NJM
	 5vMmhEWmt6QZ0Suq38+wsg+xK7u8RBz7dX4/MBF6hfyqFEClDDBb4e/3sETRdLNr3MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ok0KLiOt;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A4606A31A
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 05:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A94A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ok0KLiOt
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f2f2edb19so234424585a.0
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 22:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792474481; x=1793079281; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=flDdnbgpLbuu0srS7vDLug/Gj+E6AwZDNNV7bkNw8vE=;
        b=ok0KLiOtAEshF/UxiSpsi0qmHLIlKFTKm2GfgZFqLSX80kUzOvNRI/m1l+URI2fHdn
         K5+U1H+syEKnuTaD6sVWuRhUCVD9CaCKDL8oh1j7fwz16UgIE4wRoNnj8sKo+iCGrtiU
         fISIs/b0BQJIAY3AFyeNVPx96tsdj/H6al7RTXt1lRvA/RGI9ZQPouAl4VuOOha8xuqY
         jHF5scxu6xDJHquBpmgZkNHA+SHahdnElH0D6/98StCqybWpgYsRtsxFqum/QPzHzlI0
         Tj1p1pdB4sOoGesVbC/HS5ApnOdKVr58hHBv/tQ41P8cniT/Ex2HmdmODIwUVUfSUARM
         qZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792474481; x=1793079281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=flDdnbgpLbuu0srS7vDLug/Gj+E6AwZDNNV7bkNw8vE=;
        b=0pyarx2mq0MSYskezKV7cj74pgbQdTI1FzWftxqZnPf9qgvO5w7PcVWUf53kVUdOMG
         uD9biHU54v7zAvSts2AlJW/RIbl3jYcnJNL6QLpMPwsOF4TNnYZijyeH1VYkc8UFn1mx
         LcX9p+FFYdzRZ9ggpGy9Wt5aJUeXAoAPRCC7gpuXZ2KoO8rNnyaVEbbBul9Oim7pgLct
         LETNt/oZW5do9kPaWFhe2q2mTuzPuVFYn/cBL4Oks60hQ9Adb2l7CbsVzxzxhGKrwr+X
         NE8LVG/hLmhaVSd9IYbTRpVT9277RQ66kIFZqQtvZqdPGtjz+ZEotYYn5jNDlESYcY/J
         fTDA==
X-Forwarded-Encrypted: i=1; AKwUvBx55/rBJQG/V/UIHnYS5jrvrX7sUC+nTxoIJ8HwGw8qh/OppTxiy/fFOmv77Parc1n84roTUg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKchjjrG9S98xQEbAkfIbeyXR3fflL0QptpAtNkdyLXL8pq/Qp2
	EhMwDJbSIgcugTWYdzohw+rhM5yYRkFOOl9K3ZnqFXGJttFrju4fvYDx
X-Gm-Gg: AYBFou0ENr4xeQi3J48cSxWgVuLsh7zXNC6C/rEPnNdhye8nwAV2sFn7KuH2fovhDlu
	NiSSnsjvedvD6oiPSFH0dA1uaR1IJMzgOkLgLN11X6XUz6Fw/R7DNdxnbWHwJA/AK/tovAijn3j
	1nRssbaoWG+Vb4oxq60lNDTMqKB/rOboOjlqmnwN4LmYbu65cdr9LbkO1wluoqhl5IId5LNSByL
	P9BcQ/d8wU+tIncfy16DpKBs0RUnJeQoSParrSF2GsjiWdSr98j35zoRGmdeoojyANWTCdOqHXx
	ZnuK7VYxCeradDEc0EeIaXiLtqpKgKHMuNBdZdrEU+2ivz6HTvn3UhrpIV7OsztqyO0TTQhA4tQ
	M9Q5wFARAY7KKIjJWNjd8pZ9Niwp0Hev+HZSaBdovLNtSsj4El6BuzC4jGg88PKrv190EnxROYX
	G58YiL8C3YiSr4zo6rIC1LEpMj64QOZzEH/TE5HJA7+YeMZDz2tYs8o3HCVNboEQnnKqRFkHigk
	bh/4FfdFVz4/m4Ll43IcA==
X-Received: by 2002:a05:620a:2416:20b0:93f:34c9:925f with SMTP id af79cd13be357-93f34c995bfmr845551685a.17.1792474481518;
        Mon, 19 Oct 2026 22:34:41 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f4b082168sm139455685a.22.2026.10.19.22.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 22:34:40 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Tomasz Jeznach <tomasz.jeznach@linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Fangyu Yu <fangyu.yu@linux.alibaba.com>,
	Zong Li <zong.li@sifive.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1 0/2] iommu/riscv: Keep page table pages when IOTLB invalidation fails
Date: Tue, 20 Oct 2026 01:34:22 -0400
Message-ID: <20261020053435.1179054-4-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

riscv_iommu_iotlb_sync() frees the page table pages on gather->freelist
without knowing whether the invalidation that should have removed the
cached references to them was queued and completed. Patch 1 makes the
command helpers report a failure and leaks the freelist in that case.
Patch 2 fixes riscv_iommu_queue_wait() reporting success when the
command queue stopped on an error before the IOFENCE.C ran, so that
patch 1 also catches that case.

Neither failure is expected on working hardware, but when one happens,
freeing the pages lets the IOMMU walk memory that has a new owner.

The pages that the dma-iommu flush queue frees after flush_iotlb_all()
and the data pages released by iommu_unmap() callers are not covered,
as the IOMMU core does not let those callbacks report a failure.

The issues were found with a static analysis tool from ongoing, not yet
published research, and confirmed by code inspection. Compile-tested
only (ARCH=riscv defconfig with RISCV_IOMMU=y, W=1, each patch).

Yuho Choi (2):
  iommu/riscv: Keep page table pages when IOTLB invalidation fails
  iommu/riscv: Do not report a stalled command queue as completed

 drivers/iommu/riscv/iommu.c | 74 ++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 21 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0

