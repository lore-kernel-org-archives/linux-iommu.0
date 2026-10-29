Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282018;
	b=YN08FFSPTSKG0/ok91gabQEEFUFbDtD/HL293FiwhjPzluji5s9usuTPU3Ll1S4HBS8X
	 utagZIIZ+zOoua7HQlxB0+SZnQ2DoMRSMXlH/HfBfFo84lkhxkeR/sqS3pPrdaf/erV83
	 vErrNubW5uf30rSA0qs8I8dZ+P7sF80GcozQi+ZmcagEU2YKOO+OM0mkiD4lrcmomy9YH
	 gV1P/7eYBgmXN3MUal+rJKv8rvP/w9PngTfxz4GClTswuPScgY2CjrfgKSHwFQ2FHWriV
	 adDauIokmFbhdIhKAZ8VVo0/wUlj1XFJYeFpa+6yHvLXKcu2Yvt6k32Ey9U5piUN26w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hjD6VzzjtnD3e9erzE1FqqRgAbYyuZXKrgqZLwMhAKA=;
	b=daOCriemyrfKBSOAKyfBvA+w8FDDSMLgh/Ki+ZlrMb/xVlao1Zybq9v2RzfYRXxXkFws
	 M9d5ScBb6gGcCTlpW9h2EM7oxaT+8XJwc6Sorgo5smSkTbyMCW2GgfXKTc+GOrv5+fVwf
	 jTfcbOaqDh9BGb9xwxRlucj2gDYmwbg3lWO0yzFe3HMIFAee/aUphg7jIsb3ExhW2zv29
	 LvERv+GFYHQ7Xg84bwD3QduL6Iew9JQF4ZuErmsxtQao6xJhSZIOLDW3xkuA+vx20/9Ii
	 DHCESdel24gtT3oAYG0nigM/2ev0W6SgZR7yk0coAJpbDiA9vt77Gg7hTvPNPCi6c1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uP5gesAf;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1773606A836
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 13:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1773606A836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uP5gesAf
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e47347279so1475788f8f.1
        for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793282016; x=1793886816; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hjD6VzzjtnD3e9erzE1FqqRgAbYyuZXKrgqZLwMhAKA=;
        b=uP5gesAf2N24wE7KfeyszEsaL/lBA4L21CQvBH87VfSIvejwO6jUhY7aw5Onh7YUyd
         fKE77aohuobqc0pckZ0Dx1PGkFGME3bu3KnuTtu3h6ilaEu3BizNeseBeqLwhuIdfumA
         rdKCisS3A7A7LSDyagW/rtPOs+gBYS35LdbzYAKlegKs33yF3ly/W2qvJLQ4RlOk1r/J
         Mzp66DvG+Dime+Zicf5EgP7kGjb9fDev7XIORkyKMgRnV1iTOgeO20OBUkOk5Y1j41vk
         7MDBSmnImcNV6jgnRBTTF7cO1UcXRgy6fjEfxJ643m5YIkKBFe+OuMxmKCi1jaWOAqMb
         MvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282016; x=1793886816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjD6VzzjtnD3e9erzE1FqqRgAbYyuZXKrgqZLwMhAKA=;
        b=DLdg1z8HZ5jII5bPr9iXHcwLR23jM1qFY34Yq7AW7BwImVyME64/EfkcaMJzjX9GDf
         c/+2fio9OTAQhaMXTdegtkdFrHOXJv8nrdUmqskYQxFc0bYMVH20KeZY844grknrlg6L
         c/oO7BmkD9Ze9YUrbvsUQlZtuCtjjrDYTUR8unOt+vORmS5rXJVS+qeY8RwZ2RdyEKZv
         bsw5b7iU7cm/i7BiScNki6pjPGMVpDSSRGp+8BRvrVKO1+bLIfbCg+9WUg++5dGeoq7J
         jL/ibRiqKPejNtxnQLtdBXLEYM1CC9cgqWdebwtRtZOdTSoivMOAVR6G7agsripscK4E
         tMGQ==
X-Gm-Message-State: AFq9FYJRNgxmEHnuh05WpbXxs/G3p+AWeHJ9BBp6frMpdutesh7TCm3V
	a501bLcEktHgmxy37dpOeG3ezHmjFRbIvZzol0aEvTniGSKc1zD9BQE=
X-Gm-Gg: AYBFou2mg4ghnSpqH2JRR1zhZUUTgNu+7EwRAkfNP4I7fdUvpAup7cyhhaUGZEOscAG
	tPyE2pAV2qIFa5uo0ReFQQc/TDy/1QbZIkrQUjEIBSiS1zX5pjhxoJPKPo4jST3jRqg3rjP7JS6
	rEtbjzbSwh2Owd/7DWva/xGbx9jwFZhGta+S4ipgE2XNKb5L7q3wSPfuOL50Iw4AsRP9KJegmWO
	xwxnvDgmqay7m6ZkG2kqFP5PfTkQylxyDZkkLa9kwY1MLDDa176SXk29jTBpSOaYZx8n57tMxp/
	Ox/ygJ3DtPZrSBkTf4XiqPqwCUDezKjGKljr3q9uoMZVyUlevczExbbvZ8v2XbRPDw6uxjlBVdp
	rfOVVR0gHC2GU23Q1Cf71wNgBZCnKso7uaJpsjj/8ZnQ0kaVLI70hBAiEB//tznKyPKw4OydZ42
	y2fmxdVwbYUI5dfa0PhVCuwVA8mD9Q3xRCfbCUxRq9qOJ4ejhlKvZ0DY+EYQfKkYkZNndoOkE3j
	vtvM1K1Xo89gISwpzrtNHGuPwZYlie5zfjtr1DtpXAQFhTKeZDJoTAN9Rt2f+GHWJPTtwcURsE4
	1Ja+dIjbKskkxVeyBOckJDInivdmWBOzk+eCm7Hoo4nEJjbWwt09Xk9TWkaAHJ5AOsc=
X-Received: by 2002:a05:6000:178a:b0:48e:56fa:9645 with SMTP id ffacd0b85a97d-48e5d5cf38fmr12439039f8f.29.1793282015845;
        Thu, 29 Oct 2026 06:53:35 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 06:53:35 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:51 +0100
Subject: [PATCH RFC v2 14/14] drm/msm: enable LPAC on gen70900
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
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-14-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=982;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=zftBrxFOdArPW4SDW/zPbLM/dW8N0ZZjr0f9slsMd44=;
 b=drJK44c9MU6MO0yKK3/YNJmZlff0GX8bkfJNHj78s+gEdYZMo0J9ar0ZFCpDUnU9s9p/mTv9U
 QEVDlUzSQ7wDLCQ28Hd4GN503IJPB36U2UQmXnTQDK6NcMLz/o9Mfkc
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=

When the enable_lpac mod param is left on auto (-1) LPAC will be enabled
for targets that are known to support it and are known to work.

gen70900 (Adreno 750) is one such target.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 5ee00eead14c..cd1bdb54429d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1591,7 +1591,8 @@ static const struct adreno_info a7xx_gpus[] = {
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
 			  ADRENO_QUIRK_PREEMPTION |
-			  ADRENO_QUIRK_IFPC,
+			  ADRENO_QUIRK_IFPC |
+			  ADRENO_QUIRK_LPAC,
 		.funcs = &a7xx_gpu_funcs,
 		.zapfw = "gen70900_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {

-- 
2.56.0

