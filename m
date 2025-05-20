Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1C0251798
	for <iommu@lists.linux.dev>; Tue, 20 May 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747763111; cv=none; b=bj9FDe0ixDga7lkNDkUOrg4wiHENX3iBG0qg8OUlE/1c8fM4KZFyg91zi5A9DWLsM/IH69NXLUAD4gABMA73ZnR1fe1/DR/OxcuH8qVbe/YX46RQJitJAP6WM6H1ZS+Jggs93YGF+dcmt4sYOmor+zaoFy+EeY5SFE5tjhOJXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747763111; c=relaxed/simple;
	bh=T92V8eX3Vz4beQQo+V6nyo4FyO6B+nwmyPWJT1oO+Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LFPxC7PbWBYNDq9cXtx9WLLdowJsZESBuByN97CxKatFTfMin+U/1DE+BLmXF2EYP/drBO2dLXKeYgjSLS8EQSD+Rsh1rBC/FROPc/bgfZ33IwFyHVPcC02dxsGRBSJhksgQL6vl0hphAP6Wielj0zOOeCkQo6Q9Gmbezynx0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJIgKnL4; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJIgKnL4"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8af95ce87so8910446d6.3
        for <iommu@lists.linux.dev>; Tue, 20 May 2025 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747763108; x=1748367908; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/0lqXBgLimY0A+nlogIvRC91H4XJPyHb2uLAtGHc+4=;
        b=hJIgKnL4H5HPgqv4pb8oXYhQyW+TKlAq8MZyqtRqS9dWfNr+UXPBLEiDiMGbzPaG0s
         7EmeRFij670g4l1geU/yli9mcA9wmXedz7vrNblhDwm9dB6xPeNuCwuYbDtEeUP+gtYi
         +jqW2G/vJnAjAf5nRkCP6gQ0VCjWmxXowhzWIeHFjhcfsh/vP7bfrK5qQnMVXMsJ0MGP
         9bIh23r2s6v1oKJlyOLaQKlhvZnw3PIxWvzhTRX6XJiWkD/0hyNT0bYC535suyR51s1i
         +dmnrzkKSgrTb055bfCYgD4jYaiNiKEVhnjrbACfh29TK0Tua7XsTYoOZ4R4SXaV1NfH
         Mh4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747763108; x=1748367908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k/0lqXBgLimY0A+nlogIvRC91H4XJPyHb2uLAtGHc+4=;
        b=Wo453JeZNusTAMm5ekhiZ1s3hr5YaV3diCxgra9/9bheOORuqHcOTn+sZA5w5ezsLb
         +PKZttbLSqIoWdgdz9nv5mJ4o0qfcEBKdqnOnMDnd/M5tGFsHGJidvjsYCvQXcCd+Pbn
         uotiHUmxYedasigkFX1V9RG9GV151rwyxdEYGBfKmBNZV/vVNFXAu8uKHs7Yhhj+z+gW
         NYSmE1l0lNakDdWzePQRuTF+gSzC5IhGgcUBe9hi5d0ttq+Xy58b4vYv0nFaIlf3SyS6
         3V3l2YS9FHV8e0P+QXtoEGeZp/ou1wBxvot9lUPeHeMt7ndRhvTmKJv9kByx4KJzUswL
         uzqg==
X-Gm-Message-State: AOJu0Ywb/8mhEuq6namLvJ3Y/JuJwoeZJYzfGaSHn0xPwmP+dxtE8QlB
	gaR7Yf3FKYiMIQkvxrSl9r4mLWlIJDCE9QpV1tr6h2Q0HDqDQ/WHqx7V
X-Gm-Gg: ASbGncvgCKWc28IOY2Wd52W6N14HQj+wBY91qL1viNt6Yz+9lYsujAJZVeTmhzZHRGy
	7EOqsLIPNDtoV8YhRHHlauRs7Lpe2pWGAZ30b/ntHv/ZYQmbEFuWDl0nybVdO8NFTkYQEkyno6S
	zbA74dkEl8bR2j26dNz0WGLUZb3XrSu7lbXEPsDWd05+pujijoFuo04kVTYjvJgV/9KLAku7cwl
	c+w5gW9xoY8ZjC2edfp+HJXbY+u5Sz+YDsgNld3mrrhx1XP/GA2kAunRe1tzfHwhVVhUuGYyBYR
	qxRKi+5/CMfS8fixc8imCfIBAOCwQg5vOgkSijQZanomzwXnaAmnxeNy/SbRvAmyIZE0p5k+uzr
	8abRB+nMcjzNLq9A00Es=
X-Google-Smtp-Source: AGHT+IFCdFtXD0ROOtYtBP0OI+hMuOVWsDmLO4ZEV9rDAumTtHnKdWFKDekI52EYfVxWEILyc/wwTA==
X-Received: by 2002:ad4:5f8e:0:b0:6f5:3c5e:27fc with SMTP id 6a1803df08f44-6f8b089442dmr94348406d6.4.1747763108580;
        Tue, 20 May 2025 10:45:08 -0700 (PDT)
Received: from [192.168.124.1] (syn-067-243-142-039.res.spectrum.com. [67.243.142.39])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b096ddb4sm74126586d6.78.2025.05.20.10.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 10:45:08 -0700 (PDT)
From: Connor Abbott <cwabbott0@gmail.com>
Date: Tue, 20 May 2025 13:44:56 -0400
Subject: [PATCH v7 7/7] iommu/smmu-arm-qcom: Delete resume_translation()
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-msm-gpu-fault-fixes-next-v7-7-96cd1cc9ae05@gmail.com>
References: <20250520-msm-gpu-fault-fixes-next-v7-0-96cd1cc9ae05@gmail.com>
In-Reply-To: <20250520-msm-gpu-fault-fixes-next-v7-0-96cd1cc9ae05@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747763098; l=1671;
 i=cwabbott0@gmail.com; s=20240426; h=from:subject:message-id;
 bh=T92V8eX3Vz4beQQo+V6nyo4FyO6B+nwmyPWJT1oO+Pk=;
 b=vtKS5WA2jt4fvTdysRQedDxOh8WN7S66xhFGBrNMjcLIhRmubh69gcLR/NbqQtWPPrry50qfq
 lDnb+3B5orhDydZLJby6AbGaTMBEjlxIm7FW0NgjDlqGLt+O1uUASXR
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

