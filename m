Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478319;
	b=oxcTLxZrHia0/IjjGixofoP7ImeadWp2vt3jm+nO9ZJ1JEjoFUcvLyB/6IO6T1u0aIEz
	 PtH+W2Pap9whwfg8JrzvbL8YOpy+m5MuCdzO9w2oQY6fbh0j8K5iZXyW/vhqTzZyW6ayd
	 idZC++bqAJm3znbwQAe0lp5NPKsfTQgw4iLKHLbDNrulWR7LYzZtP8yaTPg0NUm/H/i5G
	 W3Sjv8fmVRpCoai2M/Kjz7oxZAOUsnbwQhJNkEo5GyNbPwgJPzsH1HlR6PgGK1zkPSnrL
	 3SdwiP4+/LLoU0ARW4mipX/gz5MdoVxZBcs3xmtfiPRws4SJghCTnmjxYf0ae753v3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478319;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SzeDh/DG7K/TRHa14eJVZ0wsnX3im6yxpMJ76+c0/dY=;
	b=SRrhrBYMNjikWHfO1BPiL56QVR4oSChnS44lvuH9/5KNyD4yVxPTEQjFzTxosY7ievMf
	 UtElpq29nyns2KB8ioWhU2hZycvcbe56943NIDobuW59dGTa1YqCioHTGRSQOs9RD5fy/
	 6hm9l+5E8xRIZNMNMwtzjZqP5lpE6MqU10cM9OD643AXVN4wXY7zKa2fwgooADH1tOAtu
	 84rF9vPwt9yB9J0EW0j707tnLEg1+9Bp12Ge51W29d55f3jE4JEPQJN5FPBTffBKy6gOX
	 rolRiJLuZq4ha2E8KbK8pJBD/eUvtgbKy5zudWzqLu1eNkGP4Nzf49ZN9HiRO5+Pnbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=isypmVls;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F99606A325
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 06:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F99606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=isypmVls
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1518791f8f.2
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 23:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478317; x=1793083117; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SzeDh/DG7K/TRHa14eJVZ0wsnX3im6yxpMJ76+c0/dY=;
        b=isypmVlsLRaIS+wc6ALyH9/bC+GDFb+kDZCLi0Ze1FbJ1yrP5gm8ji1ub4021miBIz
         GDa3S4HoLw+GLvDt4h1/Z7e0YmbviaGIldM6vm2/Dy5TSD9CJKAboBtqNPhNyKRtyz9W
         gSxv2a8wtvAUYlWVKoYG3rOuqYZkMQsVmRVHU/RK5noAnUH1D67lzPhxCntrbvf4oSij
         cRuDFlwWmd3QjUi5ng7b26xKeStUF4X39o6/e7j28FM5+d+7VxJw5N1aPCsRxau4sD/i
         gik8aSa8Z5K+jxhpMXho2WEpXQgW3Q9Lo7UbVR9CZCTiNTUeLBW4cNQg8K4/eDofRgbF
         AdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478317; x=1793083117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SzeDh/DG7K/TRHa14eJVZ0wsnX3im6yxpMJ76+c0/dY=;
        b=UQT9AO/LhNgLzwuZXPcEr46BDPPiMhCaGeICYxXkS5AkQHXyvu/hIgB0XhLRNsqA1y
         OepJU9y1x9Xgdu9PXOyq0InzOPwoTJtUtybuWYL4KAW9uHIsTX7AiDpu1J5FHDgCFmQ6
         BHk2VRxhqQE40IddkI7oe+JZUxn0vRNh6ijFiDTlh0BOIpOAIUeIPX7fZ/5BpcB7oUE3
         Un79tgBIrbIA0drPMy7WXDQZH2yR8xLpHR0vEYdRsJVFFpYe3KRLHFfFTnJTN+SF17Fl
         0EkRHu4+Vfno/yoGp2vlaZbGFrmoeFFYAludquHjTnTs8OI/W2/pRnn9nIWCkyGNMO1a
         Qaag==
X-Forwarded-Encrypted: i=1; AKwUvBwm220V0HH5QtuCOpsVltBfN3svq34Fmqn/xyVMU9Oz2JCVhn0OrXJLJQ1lqhAyhbGBtH4uPA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLZah2yE6TzZWOP/w9s0TQebNNV/dgcZcyLZZwd1RxdIRVUoDWo
	bkQjTAP5ZEf+zOuFmUrXYVe6Ecvd6A1GemR9ew9ub3RMagUFShhyG3Ox
X-Gm-Gg: AYBFou1oLJ+Y6QhiTFWMQuDmwmFb3fLUJrpx4kiwnHn66PTWmYfrViTyEq/JPNVHUt+
	rPzw4qd7TF1uItoF8gj1sPQX5HHmIM9dMbjiD5g61C36bSsTb9yx5gSp7plBJlJuXrQajKOsgym
	TkSUzUB3F51XNGn5FeXNfXEoPSxXxucx5UWGFeuDXWa07FZPseG3QUYOINSrnjUa3iO2S5M1pB3
	mhilBCeB5/stSOzpiOGb3agVTzw5hepQix+qWlyRHKKxMDlN1lvcuzz2CXwpTGRo8pMKh7++Hi6
	Z/1dVV62TRGaxD+uG6Xx7cg3nyiXxSBFHfi3abo1PgsQ4NEuSUilosSfOOiDw6sYhA6O1MjkqZs
	3lhvg70l3QLrpWOgAFBtQy9+D7sHR82KsWp+Fr+yeIG6By3QbDdy1wd7wFmzd0VKC7xwnsKTpH/
	JLK9wjIEn97E2/IbSYbOQYF5ePUqzWkcopcrzERvPbX5fwkveaD6Z0ccHS4LEKnRmNZgWboootE
	Jhi9nB/Z+4Q5uZPYyESTNX01tLWaqVPwQB61r6SYr40OaiilGBkdIRtSU/OIlEmcgrA7tkKpZrd
	I8NyatS5++o05wrLivqjYsFQLolAaQy1+wx2vrAVA3l8/4BTlvIr2CC2Drel9FlyxntHWLELxh2
	bHQ==
X-Received: by 2002:a05:6000:2313:b0:48e:d27:bee4 with SMTP id ffacd0b85a97d-48e0d27c1f4mr17275309f8f.2.1792478316869;
        Mon, 19 Oct 2026 23:38:36 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de. [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 23:38:36 -0700 (PDT)
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
Subject: [RFC PATCH 5/6] iommufd: Unpin the DMA-buf while holding resv
Date: Tue, 20 Oct 2026 08:37:44 +0200
Message-Id: <3ca8c42d7a597658329e77a8af92aa294f0dc4e1.1792477872.git.kmehltretter@gmail.com>
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

iopt_release_pages() calls dma_buf_unpin() after releasing the DMA-buf
reservation lock. The unpin interface requires the reservation to be
held while it invokes the exporter callback.

Move the unpin into the reservation critical section used to release
the PAL physical list.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 59ee68a1a..85004a936 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1678,9 +1678,8 @@ void iopt_release_pages(struct kref *kref)
 					       pages->dmabuf.exp_phys);
 			pages->dmabuf.exp_phys = NULL;
 		}
-		dma_resv_unlock(dmabuf->resv);
-
 		dma_buf_unpin(pages->dmabuf.attach);
+		dma_resv_unlock(dmabuf->resv);
 
 		dma_buf_detach(dmabuf, pages->dmabuf.attach);
 		dma_buf_put(dmabuf);
-- 
2.39.5 (Apple Git-154)

