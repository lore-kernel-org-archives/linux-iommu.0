Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478300;
	b=hcy+CtkdtVXOxeVc0nOdwJyOD8rMpqiBaFbKsa7Lqp0aIyT9tXEkEOsNpl8CB6vG1zCT
	 Li94CqgUa42F+m8M+fDTrsLgAu5V03v5cgztspa203B1XARw2pSb2bKJlNZNwFjKloGM8
	 buITH42SQcV3McIBJkUSwp2KFZoDKXooa2gT6KIkPgo1TcFkv6Pp+DQYXJPIXl1hzm3CN
	 aWRrfjOLXa/xcQOm03/eUMqIv5c+lo2kvCB1e1UbL926DgZeS5pA38GkHVBvLq8oR6oqo
	 7VDMvJIxHGkD2c4TrWN107DuKdrOcBDuixfWrlcQVFhbu9G/SPbcNNBUpHsfmNYpAsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WaoGSBUw+3Jzr2stHEJVabNKgV1ycEWdou5OEyDZ/EU=;
	b=MJGwRp9ghSi62oxBlf4bzcuNsArw+OvyXO/zLK2W97m9SF5FYS9IVzIr2RaBMLkf43Hh
	 9l8qNLgnERysK1TzTJoLRswlFsH1njx+lhY6DX86SaEXfQ4qk1HSn3VTf6Toywt6wdBXW
	 /VRT3HY39VQ8Yh1ki01LoDfUyEdh5JL/fuBRrGapGH5fGJja+9di3ssPSWbOWS1BatSoQ
	 PUpmtFKoKUdmIm8gr2/nypoDLrlN3LbeWiE0gdTfiXD8zzImHCBHGZDoPV9FHNR9VY8Ey
	 4rJPyQasbu4KjZZ2oy7shvgsDyGNVyOwU3hkDX4vVmYvNwesbyWF7/v5Mb9hl3EiYyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bDhEm3oM;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75361606A31E
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 06:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75361606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bDhEm3oM
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so2371635f8f.1
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 23:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478299; x=1793083099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WaoGSBUw+3Jzr2stHEJVabNKgV1ycEWdou5OEyDZ/EU=;
        b=bDhEm3oMvEtNelAm1lUnBoavtwxBjV9Et89CRKkoKvH2SgzgWZnKunoV5A0LUdR5gS
         uXvDeppTPloUucdE5tHcNTMEpz8sG68neGwbDlRUegN9CKfh1PAgFM6MU32zgKkFmqNa
         30fmvVs7x6Tqbkoa70EZbJC/hAt0lIQo2grbEXVLiW2m8wwUx8WVekJ5p5iSCdDOdPyi
         0gbaSzVmmKpZYIQuYq5u4FD/VNjhdAMbuBOxyIP8t1B+0WM3lnEyGyOEu7E2IM6H8Ww1
         eWopBKwNUFoI0itnAGNMFIMSFmKnyLChO9GqHPphO4LIyTXdUcjmNb1eq6rcxZbUrTL3
         D1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478299; x=1793083099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WaoGSBUw+3Jzr2stHEJVabNKgV1ycEWdou5OEyDZ/EU=;
        b=NTP1NYQA8vN0SekFWh2gqfqe0fl9V3gkhPIyL1P6dsuSTbLpu8k2H19mcw1b45E+pN
         oGMoO732dR/tmmqGv+t+rOZU6XSEyz4NPaCVo0tRYyD1UaWyCwIiYSacdLUi1lS6d1hk
         PC1Q9CFFntFtIe2waI5tDQFt9ZDmF2QeElAF5Er/oQ5s50CLZhZfNKgNeKNPAR4puk0Q
         SafwCgRIq9XHYoLCwFOO1Y1q9ULws6+n9GcHAfdhU8+gZMA78PdQsmCFpyqB9fyXmRlf
         v3UmmAIzNwaesMc8bPbfbYjGXluZPFrjqZrlFUR+7wYRSvjZp1Qk0HGuvD5boqsEkd+f
         7iQA==
X-Forwarded-Encrypted: i=1; AKwUvBwHqdp2xm/GO2XHWB2FLr1+31r+RLlOtzOfagq0RTfa/+Hs0npz1ER9H4YSxgJVjcSV+WQ6DQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLQq9ZhAk3jUJuMXb+/S2rJcuRrvNPIv+otz1ChKhHsqY50WUiQ
	otbpIeRpI8k/SSUSkSJFiluoJtKD+zzwlMBqdrfbliQ95rK7QBzfiAFe
X-Gm-Gg: AYBFou0m26ecebIp3dTACHnrMnbiqJ4lwaXuxVt0zERn1bY00G7IN1iS5dGUsXsmmU4
	WEyphS+IC7YZzE4pl0pjroXid1GAzQGCQQlyX6DrfnZ7seHYNDq7qW8s0cuibYd0HnmvdURBpRs
	9iGEVGVS0KdQ2Ea+FbYFLF53zxala5WANNldNM81esCMlMIi3PypIE38Adpt7N+YcoXEkIUIDVw
	uv6TC53i9sj8hiJwUK82mj4ONfiX9Hzq1+jY0LNAm6LMn5hu2ekl+rETMsP/g0J5EpWRpY3Ljms
	FvlaNBfl9lyh5TZgeoS5IsyQ9SiHqSVCuF9aWGgC2vPG26oJ82BKDMR2KAI5k8o1Nr5TLZQJHlg
	KCWs9BIn2/VldSBEcaIVz8kh4yCAnyeKcb+nF1eUIIevqLczjZv/gOuKgLQ00OT8Z/W7jYbJs20
	poVTf6Ea4MEINH/38LRUUyVo8ii7+viuOhpgGUO9iVPJp25Pq+X2nDE9MHYCNEIuMvCjZEdX/wK
	ujO5j/1X1jeUpCdXl8BuS2ovchchUVLVuLXu3JgxlMssWFJzIuTbDifD+z8RC7S0MckcP4R02rn
	yDOcVibQUTryhr/RrLxEZIbCI0kb3a9aHG9ChWaaxF0M6Cx0eWMZ65h0S7z5jRTGpAUBOCszeoC
	gK1niR51imBCX
X-Received: by 2002:a05:6000:4694:b0:48e:3d2:44b1 with SMTP id ffacd0b85a97d-48e07fb6991mr13514200f8f.52.1792478298615;
        Mon, 19 Oct 2026 23:38:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de. [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 23:38:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC PATCH 1/6] iommufd: Preserve DMA-buf pin errors
Date: Tue, 20 Oct 2026 08:37:40 +0200
Message-Id: <9a3912ce01cfd1205daeb13b57de47aa8f27f076.1792477872.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1792477872.git.kmehltretter@gmail.com>
References: <cover.1792477872.git.kmehltretter@gmail.com>
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

If dma_buf_pin() fails, iopt_map_dmabuf() replaces its error with
PTR_ERR(pages->dmabuf.exp_phys). The newly allocated pages object still
has a NULL exp_phys, so the function detaches and returns zero. Its
caller then accepts a DMA-buf pages object with no attachment.

Keep the error returned by dma_buf_pin() when unwinding the attachment.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 98c2a8027..0b32c65af 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1510,10 +1510,8 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
 	}
 
 	rc = dma_buf_pin(attach);
-	if (rc) {
-		rc = PTR_ERR(pages->dmabuf.exp_phys);
+	if (rc)
 		goto err_detach;
-	}
 
 	pages->dmabuf.exp_phys = dma_buf_pal_map_phys(attach);
 	if (IS_ERR(pages->dmabuf.exp_phys)) {
-- 
2.39.5 (Apple Git-154)

