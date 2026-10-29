Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282014;
	b=t7uRG3e6VYcQBgfwkTw1p8Z+EX66wZVr6KZFd3wX3I06HBJfN1A6wKK28pOi3nVy4roV
	 ebs+zUIefYeKahxt+GaLq58kQzR54IVi08Bkd3OD13KoqNnnjxVeMfYQf2nKSdKuJb+6j
	 WWM/VDPnZG0t0+7m/TC8kzd0rffeKk/MibmszRmdOnCLwC29w+i0q7cN69sxq7aXQy64d
	 MtBrZWQ2S+Pa7pUk6ks1fM+V8Bw1bZJwigQryY9NzGce046Au+60vIYngPEXs2v8YyJFH
	 n37Jq1SLgbFVUTCAQ+YnIv8OQRlSWGwNVQyl7/k3P0q1WPiBOGxh+gd/QzU7iGwUCEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=di8FFXt+7vH5gfYVYXteeo4wVuKU9N2jDIanPPy0lSg=;
	b=r4F7yLGSXxkuqsEx6MJc7LCWld2eHnMVKhoMgsUcbFkJVB/Emun8SQfH/FHhy/kPAUp7
	 VTJ9zkAjsvJPaecf49uTR70fs92IXihg5CcIHRRWFOgL2GXlAe5pInXuEGamORGgICfhy
	 QFq13h3cYRd/rqzPSgGQGjlKJjf3yiN4m37aoZR0Yy3fMkLLDFgL8+sqIBxy6XbZPT3bz
	 acIkUIK2yWqVn+PRazy/zQialexVYZhbU+8E5NRN3DAOsIXVNmxIi+hAQDn0ASRariZkm
	 YmjIsnc6q6YVB2OFVVA+CH+8xZ2iHgxaacxvIeNejLIC0vlmShgqoouJJUg/dgh60XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oVjqESUj;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591E60A6F7D
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2591E60A6F7D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oVjqESUj
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so23667255e9.2
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793282012; x=1793886812; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=di8FFXt+7vH5gfYVYXteeo4wVuKU9N2jDIanPPy0lSg=;
        b=oVjqESUjqiqp05qfYFP2BKCPNYJU3rLdWeihORDsc9MBi5rZwYABw1eSOTaXuGzsBV
         qO6VO0pbJO2lk4jxxBFpqoL65CUtiZRfl59psOJUGPtQzy1qmojdi3vg+f8Pj/yLxkhs
         /5QtlP68N1ANNdVn96sPjNBjMxbBQsZXpPLtE8dKLd3cdrz6VmBro5LSgzEVBFimuxJF
         CdZWBVmlRGDXVm5fdzry/mqMbVM307kPNmF1Qw4Xy31tOEYB3kwCGqxj/69cyxbsLxjh
         Ja9brbCu5cinxguA6pt4dOkctbF1gMhFT8+jwmvVPnWL6CZD0XK7dsx+bj5sBAZvAR2X
         Iq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282012; x=1793886812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=di8FFXt+7vH5gfYVYXteeo4wVuKU9N2jDIanPPy0lSg=;
        b=Fv/vzUSu4iaxrgBcQoOh2zufhwvmLuh19ht4o6WZjgq8u7ulHDi05uXFAa1vtg2G2x
         dLZCa0wsM2VNT9t0uTEA+XCJSrMQbg+39jCI3ivUrHOKKtzdTZB0S3zbTO5VJ2uiEeR8
         08WpYJL4N7yCBOAO85uOblOJLTTO7EInpgDIFPxmk1Tla00EotGT3F8SH1WrG6cSe/ea
         5ejOwL2jud+59n9eLpj4YMvOvWn7Vk0bEsrdDFldeoZVxP7fAt64+q5FkzukN+GKQfZM
         39wLZhtWSVkt6AI3WRu3hznYwVRRq7dkIXL9MCsgSTGDheVpkTuVPsto3u/Vt7W5bJwt
         VbZw==
X-Gm-Message-State: AFq9FYIbiSdkx8vwzK9QvZnr22M7vy0eUSpnZb736SPNSUfJu8GG7fEU
	0bDO8nByCvsjtnQhfYO9s/E+Hjf7lZr7auDAV0h2mAda97ExEfLogss=
X-Gm-Gg: AYBFou1JcCW335JtARCRuco95ZE6+mu3Qs24fih22dQKb7p3+t8Xv/DKzU/WncCkrcs
	m2u6GdUZWHZV4/IkLtEKp82wTdJLnie1bjsUtg5l3q8exB7gDWCKVro8t/Fyo2qfJ2v1iQEZbUd
	ru7e2f0SWF0wromq8WM2dnJ70T4maSAxj1wklLQzoursV/UUaycFoCurzLAFDwpfKh120dxNfYn
	3js6ntxjLM7cFNKICCHyrWPFWRPqi5uYgOYRhlu79IokkBkr2EMUKt3NPS62tbLMPEszH2RioYB
	zjiWRKyRwrDN5n///9L4t0VsVQybF5+GQgdr7tJxmmC7XzCVN/cGd5xuMLX+mwujy7FHmXCfaE+
	JBM9ruE6Bn91ct9BgZpCflKqkQ4dQ92YQcHpc25D9/Gdhb3wtKuTbKo+N+me5LtvxCPqaK7f6CW
	+1fhQTo6zfG6PmUl0/bw3OB7h8revQ6ybL2wW6BDV2Qwe6orv4uIPClvp5AqxAIW/Yv42R7184M
	QyHStaZv9xbdPgC9eZRtd+Iqft5Hyh43pqTArTYZSPEM4+plQrazr9md2xjO9qTV+/BB8/Pi4FG
	1KdPf2gDFN8XYoC1vKZ2Ip5oD4VotKnXCWTOTc4amjOE+A==
X-Received: by 2002:a05:600c:8b38:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4a966c4062fmr131340985e9.14.1793282012331;
        Thu, 29 Oct 2026 06:53:32 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:31 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:49 +0100
Subject: [PATCH RFC v2 12/14] drm/msm: add lpac ring to devcoredump
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-12-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=2731;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=SjlYjQ7B06EmsCE9KnnMd2bONmqc/uyNMNAcvp2x0Ec=;
 b=Y4u2ENL4nkbD0aM3WvJ/ELGPfCSRXNJvoXA78hkmUU4GFxXHhBZNuc0iEh6bPVi314GSCwW/2
 pbbFXwlzl23AkJnsI3vrmGEICHfTAEqdZf+4MgQRM3PA140b5G6lp9N
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

Add the LPAC ring state to the devcoredump for debugging.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 19 ++++++++++---------
 drivers/gpu/drm/msm/msm_gpu.h           |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 085e1b9044bc..1ce172e5f73a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -785,25 +785,26 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state)
 
 	ktime_get_real_ts64(&state->time);
 
-	for (i = 0; i < gpu->nr_rings; i++) {
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
+		struct msm_ringbuffer *ring = i < gpu->nr_rings ? gpu->rb[i] : gpu->lpac_rb;
 		int size = 0, j;
 
-		state->ring[i].fence = gpu->rb[i]->memptrs->fence;
-		state->ring[i].iova = gpu->rb[i]->iova;
-		state->ring[i].seqno = gpu->rb[i]->fctx->last_fence;
-		state->ring[i].rptr = get_rptr(adreno_gpu, gpu->rb[i]);
-		state->ring[i].wptr = get_wptr(gpu->rb[i]);
+		state->ring[i].fence = ring->memptrs->fence;
+		state->ring[i].iova = ring->iova;
+		state->ring[i].seqno = ring->fctx->last_fence;
+		state->ring[i].rptr = get_rptr(adreno_gpu, ring);
+		state->ring[i].wptr = get_wptr(ring);
 
 		/* Copy at least 'wptr' dwords of the data */
 		size = state->ring[i].wptr;
 
 		/* After wptr find the last non zero dword to save space */
 		for (j = state->ring[i].wptr; j < MSM_GPU_RINGBUFFER_SZ >> 2; j++)
-			if (gpu->rb[i]->start[j])
+			if (ring->start[j])
 				size = j + 1;
 
 		if (size) {
-			state->ring[i].data = kvmemdup(gpu->rb[i]->start, size << 2, GFP_KERNEL);
+			state->ring[i].data = kvmemdup(ring->start, size << 2, GFP_KERNEL);
 			if (state->ring[i].data)
 				state->ring[i].data_size = size << 2;
 		}
@@ -1004,7 +1005,7 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 
 	drm_puts(p, "ringbuffer:\n");
 
-	for (i = 0; i < gpu->nr_rings; i++) {
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
 		drm_printf(p, "  - id: %d\n", i);
 		drm_printf(p, "    iova: 0x%016llx\n", state->ring[i].iova);
 		drm_printf(p, "    last-fence: %u\n", state->ring[i].seqno);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 877f88ef90d9..6b05c2d45bb3 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -640,7 +640,7 @@ struct msm_gpu_state {
 		void *data;
 		int data_size;
 		bool encoded;
-	} ring[MSM_GPU_MAX_RINGS];
+	} ring[MSM_GPU_MAX_RINGS+1];
 
 	int nr_registers;
 	u32 *registers;

-- 
2.56.0

