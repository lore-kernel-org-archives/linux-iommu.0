Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87030E838
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768943; cv=pass; b=Tmkyf2IweGF6nIHVFlRWJFvPbz2bPiZ7n+fN9t7JpwYNz0SOh+6mYNg70dx8KGZM+sZHGrXZcgi4m6F/7cQcue8ItFsTGY92QasBIHHyJTXkQTl9ErJBmvU3539LcdmLf/4EWJWjY37gaS6CO6cUKlm4l8n8nR1PDM84tmnhp2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768943; c=relaxed/simple;
	bh=dNUpHR0oTQwJy+ecOBEV2Ruj/VUmFxhcmOhLjQeHLXI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SWhLlkQpJpC6VTvIfwAA8LrOa9a9e38wbUDXjpOvK5PrmFI4Jwcj+4zWiljRlLcZdAD3Gs/Mp2yZjHxgfzO2vwnncBf4TUoqAfbolKNxWKek2Yhl8f89Cp0LrDrkrU6sCcwh1pdXh1aQluXAKXgS9yRU45ok889KZkhYjK25cEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaElZWyR; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaElZWyR"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7982c3b7da9so82133137b3.1
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 19:49:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772768942; cv=none;
        d=google.com; s=arc-20240605;
        b=Jmq5OSAA7wNQ+sJ2veS5xqbQSQydi/UP0lmk1EPpO2qb/NFJ9cvYbUVQEYwcftWGcp
         ppRONoHtCGVucdvcCH66Wp59/COX55t5rmvPx5W96Z+659WJtHzTznNJX43vmW/QTWNq
         PmBUJu/4wS7lEBuBWSNOP2jPhWtrW484gbP6BruTWxPBXa+Eq+vSoKRtkSPlzs3Q2W1O
         GMYuUwNfAwpomPdgIQfJBw3EgJclIA3I0lH6JEMH8GCFycx/UqzdOZ1iqzmuf/Y/+DC9
         eU1lxuwBzbADOKBMOcu8fjOjcDfVY1c72Ism3oWYlTUoN2LUTS2JgjRvZuaz8jpLNbzf
         nYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+3KVfu4YF0iDe9x9XbVLpDOnpHDuNLpZRAeCr26k+RA=;
        fh=1j6noa+dFau8KMEBsmGG1lDhgsbJhESMIT+xii9vSxY=;
        b=EBgMzZyUqnhaCoLMMMJJaUrqQUzuLk1EXP1vzbBYnvbJlWncEF5Ua6upbgu3rEW7bZ
         qDeS0IMsDO9/WzCliahmFNZbotG11tKTesY0LWllBQz6emyeRxmyLddXO2Q6HYZEHr9Y
         eSQVOGuH/Ec5onQ3hMtyOhtH8nPjAanuzZUdLCZLfmVxpZxgPRXu2ez6CZF3PAFy416/
         1x2QS2mHdclslAvMmBGKBc73YjGxtzxpd027J6YQV1CY/xos2GggrTFhCnD6q0JucsFy
         6f1aAz4xzWeHqzpMIaOMq0Di9qxVz4TaBBblIf7UpvlbLuwL9KshRouf7GpZdqONijWG
         pV7g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772768942; x=1773373742; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+3KVfu4YF0iDe9x9XbVLpDOnpHDuNLpZRAeCr26k+RA=;
        b=PaElZWyRTSeKrhE1uVJTkzjymbnlqgtzmRxm7k/ybkXl4ioO2P0maCsEuRYsPP6Bmo
         uGsVsgqwv7EBZCfLKmOYakvcymG71V2CB64DezCzwD8OTQMaViEbw+7jyiR1U8mbViAd
         sEA41THHGryjXIweynQp2JmPdoLBF/c4rmsMp7DWetEl0r+7iHd0D2MwQNtpwfHtpi3P
         cKAGYRu4ay5gsJBZRaAE58iJ/TwqXPYxhr1stdkbQYOPOOT9cAJU6TN3TrUSoIzUzSiW
         nFlmgPOTuh3lcmaW2on7/XBpqFd0A2lgyNUaJw9SciwmjSHev/BM2AYKLk+C40bZYKvS
         rptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772768942; x=1773373742;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+3KVfu4YF0iDe9x9XbVLpDOnpHDuNLpZRAeCr26k+RA=;
        b=Y7Ue/sVz2PBE+8DQErd/yrniqKQZwM4kc3v3/xmrNoFINRI2BtlZbactgMAR+R7c92
         r1c1pHjWWSfGoeAoQ3C0o1JYbDCN6DAoQHPMbiM523U/9JIzxgrvVtVcBXggjlysoWYC
         UtyTGKQDRKbGH6Ov7gsJF13bNV/lgS4lIAWnyuRujm6BsCfneD0go9N50+hCdNABkV1c
         eH5V68DOJJ/7w5YxLiocECVtOfRbQN0htpxy7Tyvm7XNveOmIUjeRFY2os++SLYeBJYK
         X220e8PD9ru/LU4hyFYLtn4fdUK1iumicldOzSyQAvjBizumFCL/63yx+M0LivXT5FqP
         Wq5Q==
X-Gm-Message-State: AOJu0Yx51pUAV4rVNe8flyVbTHeHnwUaacR1ojGglq4+YaMQYo6XvX8q
	47AyIP+7Cct6gvQ1YWcKJzyLTnFPqda3ziMbekQ9BX7QD7NjuEi1x3ZcLOOgIB7cieqxA6hdf+C
	/m+sTgXrSdSmgOgchiM0WqH9UsN0jLWc=
X-Gm-Gg: ATEYQzw25MHHS+4fNxmuMYpUa7avvVDB3bD2H4xUgzy+FuHGuEh8nrcVXdwgpXV+twa
	2jeS9KFfOZxmehqgFk31wjkF3eS87vsX1nVrxWl+JZOatZMVrr81bDBwgZMrWwhc7lFHr4H4UIy
	nWjyi+ZSChxjzvGk0EHMm8mps5gsKrqGIT0onllmRvgjtHiT1YpVRJ+O7msIlvMsu3QgsQpNjdg
	dioLtHjlCn/EXSAthQRHE/mtaOghJ8RqdwUTiHtrqjIV8G2VB+pLNNtPKjMtVh/bkmen8JJR06t
	wnTuVH81LQ==
X-Received: by 2002:a05:690c:d8a:b0:794:ecaf:c501 with SMTP id
 00721157ae682-798dd787623mr6124827b3.46.1772768941686; Thu, 05 Mar 2026
 19:49:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Owens James <hechushiguitu666@gmail.com>
Date: Fri, 6 Mar 2026 11:48:49 +0800
X-Gm-Features: AaiRm52csMwF0QK4pgCSSR3OS4LQ5YiTwX8PFjLU0ZrSNYhf25gvuUCbgnI340M
Message-ID: <CAEZ4rQ8xmmw8sQ9UX7y3iyE0-UVLEHa10vJwxcajfzcqp2SaYA@mail.gmail.com>
Subject: [PATCH] iommu: tegra-smmu: Fix spacing around operators
To: thierry.reding@gmail.com
Cc: iommu@lists.linux.dev, linux-tegra@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, joro@8bytes.org
Content-Type: text/plain; charset="UTF-8"

From 976ec7e6ca46a3f9f6031b74e2e88f630ae709c2 Mon Sep 17 00:00:00 2001
From: "haoyu.lu" <hechushiguitu666@gmail.com>
Date: Fri, 6 Mar 2026 11:36:52 +0800
Subject: [PATCH] iommu: tegra-smmu: Fix spacing around operators

Fix checkpatch.pl warning for missing space around operator:
- SMMU_SIZE_PT-1 -> SMMU_SIZE_PT - 1

Signed-off-by: haoyu.lu <hechushiguitu666@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 67e7a7b925f0..58ccaa74475b 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -137,7 +137,7 @@ static inline u32 smmu_readl(struct tegra_smmu
*smmu, unsigned long offset)
 #define SMMU_PDE_SHIFT 22
 #define SMMU_PTE_SHIFT 12

-#define SMMU_PAGE_MASK (~(SMMU_SIZE_PT-1))
+#define SMMU_PAGE_MASK (~(SMMU_SIZE_PT - 1))
 #define SMMU_OFFSET_IN_PAGE(x) ((unsigned long)(x) & ~SMMU_PAGE_MASK)
 #define SMMU_PFN_PHYS(x) ((phys_addr_t)(x) << SMMU_PTE_SHIFT)
 #define SMMU_PHYS_PFN(x) ((unsigned long)((x) >> SMMU_PTE_SHIFT))
-- 
2.53.0.windows.1
