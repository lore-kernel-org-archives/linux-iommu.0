Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478308;
	b=1YTMX4cIhcsVmVW/7NwqZqUzQAr8Jk7nvycg/EBETZwb7lQQrWE1NNmZ3A4yH1h+0NBT
	 g/cZ8ENMjG8MRbfTq8m4zARQb5EZFkDoBjsLOVXVN+vxDH0n6JnZYrF4jwt9dBk+3s1Dr
	 c88QsNQkbc9/4JCLErs9LEdDfRKG1FZoR8qLLvm5CDm5lA+J70fpPfywGjtWZesWGUzH3
	 VRJgsBBKj5mgCSUiUNn0G20mrXpemeLJXmToVHjCMbK5MVV7dYItYvdTPRV941HPwTMTI
	 zcUC2m7o6f0l4gqhdHILuEsLERp5+NBG8LXJB2X2oczCy9unwZS2HZ95VbQdUeQ4WtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=54nP+hVnBR38qJFAJ37FPqemtxXLBnXTchrtQmC7INs=;
	b=wrg8sxatn5bh+VZLntQDyGlaSR2A4rZF4sdp3uqOa9Tkvy6k+znB2sMUvlte9Lj7Cc02
	 7JuacQlsPKvS4seVF81L5cHDTib3gs53wzVsXcRWkb5y8pEe1+XRCf7pySRRGdJiDfn0B
	 zJbFBIIEEJPtMBV6qoOn3DUtQ+0xcavSVu0wIlGWis1qKslUrOK8T/XMdPI4GrMrGZzEU
	 JTMZH0DKgLRbtFeCMgrIL76ZIc5P/X+tQtBwdIVDtSXY40TCb0nffKBptnVZG1bdHDgIW
	 Uo3wjYDUsf7a1kQu9zH6ZawReEnpVReGEYJGcEHPRFXRvS2hm95txYYIYuqrleLGnhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mYOZUBTS;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A265460A2601
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 06:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A265460A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mYOZUBTS
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48df4f540ebso1562370f8f.3
        for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792478306; x=1793083106; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=54nP+hVnBR38qJFAJ37FPqemtxXLBnXTchrtQmC7INs=;
        b=mYOZUBTS3zxJFXFdlThLSbUcGPaK+IzT6pU/6kGOmwZJqlhDT5eJsw5wKCCfFnETAm
         1o0cPI/xt4wwCjWFHJ5XWgTVSGyujaYCl+o7/19hUZL0j5VXPauhYo+9Pysx8RV60nLD
         Hv2Q92k/wD3QoVa71lixCZpe64yb49mCNbt03SoNgE/NYnP12czD6F++nmjD3T3WfhAG
         3nQHa7gBPPVSPmDHhikU1bsGpn5j3ea/pgmIV92L34SJlEpVieG57NdSVDjRiziCsMsC
         Tw0NLdgxut1w457XgO3fc/1rXmCjm/MvNCEYRtrj4kGqwAz7G8vgBUubMJTy01jQzl2v
         NPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478306; x=1793083106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=54nP+hVnBR38qJFAJ37FPqemtxXLBnXTchrtQmC7INs=;
        b=R/TF5KoDwxJPo7OMr9rYQAZpzZLN5pjsIF++tFFgumTI26dX1+BqhHwk++SeHHYhih
         kmD2V0rrJQPTC9WkYlI7wjVrON3eN75QFaEahdBoVuZ6sqyxjeHEKxRRQqiX8NcTxAqb
         L0xxe3B6EGVK+3yC63WwTrAtC3tp5107+MsCWMOF57zkEkf5huE914AoAVyJHX7aY7Cv
         EwK61pKc024Sj88yfR5S0bEgUUBjjCtR5Ml9jUAAGz4zj4H1lce3bAzrTf9F8lHU6f1+
         TvK+cur6rshebJintvrPdbAk5QM0KE4mjZoFO9/yWOReoHHBjT7r67VpiUFWXlsmR3Ui
         jcsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxalXpsANpzzVtjVluft5/xOTRe39siC+mQTg58+UBRY51oDL+W1Tx6hZsl7SL8K/4s+NJqNQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKY+qk9ZFLi6EMiWL+coQAzAPeTtyHf+p2K3AFisUETpDpsOJOh
	QSysK6b78fYgNyfOXXc/8DHB6AnY7a467wdWKa49+iLsG7bYZU+IqVpB
X-Gm-Gg: AYBFou1a7CkuqTxHovOSXYeqlLnGi/uosMj3hv+TN1qJOXow1oLhJZLNDOjM/Oj/hfd
	KuxoX0vYl+fhrQxikxvXujVtgTOEgHNlf+lnWH3HfgwhUdEqvENcusRmDvCqV03sMbPN/UbywJg
	r5ee1vtigvPhLwGOwerl91iY5npRqjglCkMu14M3r6aR+TcU9Z+GfIP+zCn8KR0Kb4WIq3+d2HN
	2I9AbK6XV+nTX79RZznu4jMACkEknwYVXobkTwRO5D9ftPzbua8ezSBB4cLDV+nUKUfa+/t4l5A
	pMxzt0n5Dpe+QRZGsKkBqUGw2xKLDtQwerd3JTSttnt2wDAPo4VSv2y7p8JChWe2tIULRIpIEnu
	HWcHWfCnXGt0QvDtoZVqRyOxD3HvA9YT+GN2WbLFlUnCPUyfhjctkw0YRDqX2wytD1PEDWEVM41
	YbWKWC7Bbr3zp12k024TFvVoQrDS4o7RLCt27K5rujeoLX+9+fwsAnScPpVNN/lyiw/adLnxkSg
	+opjcWSn9gVr8SbeDNC+TSFVhOS9vlA1jNF3q1EGK7OSsQKDVm3RtoCLa8ZmYlEUYeBLDy5A1Xb
	5XOspAELVLNBRRxDDbEPBonFemSeEhhcZ0WnGF4H/f10aOk4vqRnkRMzM4gfkHPsTkfBLqPTDOy
	SAUlRXO4CLVuu
X-Received: by 2002:a05:6000:1e4f:b0:48e:412:3829 with SMTP id ffacd0b85a97d-48e07fb2b18mr14486670f8f.15.1792478305848;
        Mon, 19 Oct 2026 23:38:25 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c92-6501-2169-eb9c-7ad3-f5db.310.pool.telefonica.de. [2a02:3100:9c92:6501:2169:eb9c:7ad3:f5db])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d820714sm3916393f8f.35.2026.10.19.23.38.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 23:38:25 -0700 (PDT)
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
Subject: [RFC PATCH 2/6] iommufd: Publish successful PAL mappings under resv
Date: Tue, 20 Oct 2026 08:37:41 +0200
Message-Id: <10fbbfdbf3a19fff48e504bcf5ec3a74f11bfd7c.1792477872.git.kmehltretter@gmail.com>
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

iopt_map_dmabuf() stores the PAL map result in exp_phys before checking
for errors and publishes the attachment after dropping resv. The
attachment is already linked to the DMA-buf. An invalidation after the
unlock can therefore pass a NULL attachment to dma_buf_pal_unmap_phys().
On map failure, the non-NULL error pointer also looks like a live mapping
to iopt_dmabuf_revoked().

Keep the map result local until it succeeds. Publish the attachment and
physical list together before dropping resv, leaving exp_phys NULL on
failure.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/iommu/iommufd/pages.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 0b32c65af..9e9bc6a1c 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1491,6 +1491,7 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
 {
 	struct dma_buf_mapping_match pal_match[] = { DMA_BUF_IMAPPING_PAL() };
 	struct dma_buf_attachment *attach;
+	struct dma_buf_phys_list *phys;
 	int rc;
 
 	attach = dma_buf_mapping_attach(dmabuf, pal_match,
@@ -1513,16 +1514,16 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
 	if (rc)
 		goto err_detach;
 
-	pages->dmabuf.exp_phys = dma_buf_pal_map_phys(attach);
-	if (IS_ERR(pages->dmabuf.exp_phys)) {
-		rc = PTR_ERR(pages->dmabuf.exp_phys);
+	phys = dma_buf_pal_map_phys(attach);
+	if (IS_ERR(phys)) {
+		rc = PTR_ERR(phys);
 		goto err_unpin;
 	}
 
-	dma_resv_unlock(dmabuf->resv);
-
 	/* On success iopt_release_pages() will detach and put the dmabuf. */
 	pages->dmabuf.attach = attach;
+	pages->dmabuf.exp_phys = phys;
+	dma_resv_unlock(dmabuf->resv);
 	return 0;
 
 err_unpin:
-- 
2.39.5 (Apple Git-154)

