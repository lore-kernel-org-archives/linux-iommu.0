Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447125745F
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747768152; cv=none; b=sBYAKt0hK/JnEF/0ygrEjKHCA9xMxMc9IBgJEyqXiUJ9u6zyWodYJrqvQNtvS+Tu/LxBrN+gboxIbVRml6DbM/4RYAW/xfCnYUwnSz3RwzQ1NPhmrT5gcIwsvarwx6Mp/gXHvcsxYCJjZOgbJNkFSPupHOREWXZz6xJfZfbVBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747768152; c=relaxed/simple;
	bh=T92V8eX3Vz4beQQo+V6nyo4FyO6B+nwmyPWJT1oO+Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHP0uJuC9hVk4+vxbQipdvUTLcdMVqBSDwEkJQk6/VLOCQzPCt6FYz8QXG5fuXaL7vGaav2Yf2GFuqJs26rytJ7kq8kczKyD0EGclM4nkzsCe+9C4nrOex4kQJ8Bde5sRU4+nVpXXUqyp6r2s1ekeutw8UjBq6LwDW8WyZLcCVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+x8IptC; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+x8IptC"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-47745b679a4so1657191cf.1
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747768149; x=1748372949; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/0lqXBgLimY0A+nlogIvRC91H4XJPyHb2uLAtGHc+4=;
        b=O+x8IptCR+wyANlKMDD4mq1bj1v5HKUK/mkuXE+E0Rewg/3MBYRZn1LQMxqcdnquo1
         dd82lfFsLxImNHMlMi8WlwBl3NkqrWk1cGRItoLxmEMexcO8TpvhuRQMQqpfgm4YFVJb
         SDi0T0/6O2q1GxHl7ubPWZUCbxdpyfsgJN3zuOVCRa6AVHcnsHQFbuJ4FFVq/1bIgTYc
         T2RojG38ux23pu0ewB+jCeoIsvmwwn/fAGFtQtWCq9cj6T2fAsmzDDrKM6xQAXGR71qD
         gALjHinbPP0owP01sQB7+ZW665JKU2uCR+b4FCGz1hTBLW7xwF0bwxjGwDYOXJXIr7n1
         5+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747768149; x=1748372949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/0lqXBgLimY0A+nlogIvRC91H4XJPyHb2uLAtGHc+4=;
        b=iYJsVvb9pIm6UvuW8d+SxLqsj/VJhF+7KGU1XOsFMiUxyJ2Boj68rI3QGikRUv6/a1
         pPOsn8GHuYL8T4jmcobIsIUAqjpjPUQj0UVjHVgZF/K01kM1gSFrDCTtCcEVgkyQra/B
         US5Dr6OUL5b7lBzWHUScvpcn1dDYDExZ7KG4pvaevgexdzVQzZZcv9MrM9du8WyIFlJj
         5cv5ZXqmGrL2fTjyFZF9QzFD0iMed8Fu+AZEheuwouhUQjsCVTiOuYVdvd2Pq2wfinhY
         xgRZB4bHbXSExC4iwsDuYJRAaUQ24Yk9gUPVHr9VoZvgkFClGM9AApIcSIVoursrXaKr
         Q4fA==
X-Gm-Message-State: AOJu0YzVYsrthxgvtHCD4yQYXa6Sn94aboqL+VyqsdvmgoxDecg1OPMn
	KrGB/3QhVIkxNTMcm1VsYFvtSsYI0LxHUiyMHOFu+k6yXsr7AjqRIZnE
X-Gm-Gg: ASbGncsRl2YmZKQ4sGu6RtJFuWq/P1ZyC/FC/RGK6byIBTN2ZdEOPmalvy+IxIFLzBO
	u20oY3YOyNWQY82KqAdNXIWGLOe//FpxiX2wyjAneuLx9doyUW2aP9fFoTM3kRiJbpwFaWg0Rvf
	NA13J0WLrHqDGFQO+a49BnmGscyfMnhrG5eI1H5CfeywUhlKxsr1mNIc+N2aKM5fh2W/y+QwfZE
	LvqqQ8LYRDUe61DATq47xo6obgk2k/iED9Sc8D2at1K7ORCOTBAiXNv+xKi0w6pkEp/B+oX37ZS
	qjgTcaTMF5klbglrUXrlkSboRX4tbNA4Lv34AVtn3lFlPzriEH3DGECCgCLxTqPAn1qSZGGM7i5
	GHYFsOADTO8WP6Ro9a6MIzt6or/AjEw==
X-Google-Smtp-Source: AGHT+IFR5pt9/GVP1EPATJ5cgZRIzs6LVruq0q5vYeQ0eAM0wqovWxYcOeeO8H0l7rzEaFl4O0FbJQ==
X-Received: by 2002:ac8:5893:0:b0:47a:e5b6:50d4 with SMTP id d75a77b69052e-494ae3f7e46mr90403491cf.10.1747768148499;
        Tue, 20 May 2025 12:09:08 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae445b99sm76554051cf.48.2025.05.20.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:09:07 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 15:09:00 -0400
Subject: [PATCH v8 7/7] iommu/smmu-arm-qcom: Delete resume_translation()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v8-7-fce6ee218787@gmail.com>
References: <20250520-msm-gpu-fault-fixes-next-v8-0-fce6ee218787@gmail.com>
In-Reply-To: <20250520-msm-gpu-fault-fixes-next-v8-0-fce6ee218787@gmail.com>
To: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org, 
 Connor Abbott <cwabbott0@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747768138; l=1671;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=T92V8eX3Vz4beQQo+V6nyo4FyO6B+nwmyPWJT1oO+Pk=;
 b=V6LelLjLszEjGIEg7Z7nBX+1w5ysEhFN0tIa8dRMNROYBzA6VMJ+NwDe2jnJAGKdUiJCz18nz
 McgNjrJt/A6BgWCGL2r/nQUpmNIJeHTCHHVFZazeqlf0zl9zY1lh5XO
X-Developer-Key: i=cwabbott0@gmail.com; a=ed25519;
 pk=dkpOeRSXLzVgqhy0Idr3nsBr4ranyERLMnoAgR4cHmY=

Unused since "drm/msm: Delete resume_translation()".

Signed-off-by: Connor Abbott <cwabbott0@gmail.com>
---
 include/linux/adreno-smmu-priv.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
index d83c9175828f792f1f43bcc8056102a43d822c96..4106b6b372117119bbebe67896de18fc6286fb44 100644
--- a/include/linux/adreno-smmu-priv.h
+++ b/include/linux/adreno-smmu-priv.h
@@ -46,9 +46,8 @@ struct adreno_smmu_fault_info {
  * @get_fault_info: Called by the GPU fault handler to get information about
  *                  the fault
  * @set_stall:     Configure whether stall on fault (CFCFG) is enabled. If
- *                 stalling on fault is enabled, the GPU driver must call
- *                 resume_translation()
- * @resume_translation: Resume translation after a fault
+ *                 stalling on fault is enabled, the GPU driver should return
+ *                 -EAGAIN from the fault handler if retrying is required.
  *
  * @set_prr_bit:   [optional] Configure the GPU's Partially Resident
  *                 Region (PRR) bit in the ACTLR register.
@@ -71,7 +70,6 @@ struct adreno_smmu_priv {
     int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
     void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
     void (*set_stall)(const void *cookie, bool enabled);
-    void (*resume_translation)(const void *cookie, bool terminate);
     void (*set_prr_bit)(const void *cookie, bool set);
     void (*set_prr_addr)(const void *cookie, phys_addr_t page_addr);
 };

-- 
2.47.1

