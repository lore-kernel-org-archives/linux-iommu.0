Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621425332B
	for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746026345; cv=none; b=GFQN05HQYZ+ePtCimCvkJ6NEvhYSM9AYWLauBNd1N53xMU4rWZ21goAfCziNy6s87JpETnoIdo8tEarztDiMM+IaavnflJD2Rrncj4TbyGLc9l/yYgTwSS+k8Q3USFVDxmSz5TkW2q6ltygKSXXhZwcZXHc1gkX7GUkypPCI9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746026345; c=relaxed/simple;
	bh=B6zlRgYwaeYfdtMHlof62UGUmnIkYfwM2CVLuHfDnyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aPa+X6kpU208b8KdRIW6E9LU3tX8R56w3ruc0ts65hs487I4VsNOo5oNeJBU8q1YYj5hJgGtndkwq/OLnrfqyV+b91AdTHCkUErwi4HTqiyEJzHeV6DmuK4bGnrzdoqwdoh5eP+P5AbPx2Y0F+OLAh9lkSsBUygv3OLwMPbyUa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvexUXFg; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvexUXFg"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso58301045e9.0
        for <iommu@lists.linux.dev>; Wed, 30 Apr 2025 08:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746026342; x=1746631142; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXK8bvaCytItNT9ajRVYbpjpuh3Pnz4jGeM0l/N4gcc=;
        b=TvexUXFg7EyV+qprNvXQ6svJALbK39URQciKCCJVy+VtV6bzw5x3f+cMpnhhNIdJE6
         hSrC87OLE6pUwzhKJaRNM1g13OA6VfdCFLAt8HaDeXgFyPwgGTc0CgS/O/NH7NiGiJc8
         sR+wJ6ALffjI+CW9HUXpyTdXyxKsMQZwIX2nusjoHFc0IK8DT0so9ozr99Xx+FkMBC3y
         r9T/EAdT4rXU7XfckLLjORqelERPi9/F2pTeR6JtTU6ELXoq7MjDTMcT1yeVsZfwzA6C
         nwQpZBKfCoZLJRt770aksTPcXnJp13tYARnvYJqoHspbE8gmzgcaPjvwN2d8ksnHqFmj
         RBqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746026342; x=1746631142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXK8bvaCytItNT9ajRVYbpjpuh3Pnz4jGeM0l/N4gcc=;
        b=eBxUOBOlMeanSADnAACv0q20uCTFBKTTGNslvjCV4zB+ik3n4hHShxOYHidMgAA52e
         wQ55AIecrhIez7phBfoiVEfSl5XnPCNCBU5GUTqzLijjuaEFOq+GtRp+8B2Xmr4QhJlV
         68xJWk4MXrHm7+Xg5MzH5ACkUx+7glXUIEHY0C5TVxFxiJfL5YGryX3+jE7njtbyStXv
         0UX1r91TqqiqomhlPfFk6ukge6RQgoP7+Hzn+Hd6nnyL1CIfJ13bbDErKpdnJ4tQgFNd
         RkonlKGjumTccOT4YeaZNrQxBLrHkNP4nILL2wDYTV60ED2Aisf7yci64FNFc+evWVf2
         Lkkw==
X-Forwarded-Encrypted: i=1; AJvYcCU5wzKfxiZxsyHAJrF1Zgr7v9gZInEsXAs4jdwNHfmaKg2bgJNgJ/wHQEiqnuTMF3YkosB6qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxEkrWsqsTxpv+bYPxLb3UUSbKo05FVpXvULY6A3N6FBHkKA5hz
	+S+i780ny9GYQaw390eWVUsU/yX7qGyRDH402n33lB2GsaMmy2cu
X-Gm-Gg: ASbGncudz68fuw0FwP2ISeHbsqillvqIT4vI3tScfBlt2U4c2JyQIo6O4Y7zX4i4Yh3
	Ffgl4GaCMG6r4ttOmNjArIkMOzss6wFOhqYBmNLhmWBPFIzsQA59xd0Zpb3b8HtDuYgBsindI/w
	fI4NY/Qz3rSpiM321wOk44k7gDhiD+0a3+uIQcowSYfA8rce2KX06KlIkeAW2s0Vx3KbCudhBhm
	gEtKPPhuViI+dR/Dao1Q+d7n9NtUCnPofjbcFqASlDmjPgU4VA4HZmkoEq44tUVe7rI6MTpy/4G
	Tmm08C52EXRFIXaxsIMf4eW4QKW8SaVkOGd6nPMAGw==
X-Google-Smtp-Source: AGHT+IG5yLDIazGKaXeNaIe5P/3I0dJ19S1HBF6Ews+DjSapkFmQX8lg5ffFzK8P21Kj9uOTim/K8w==
X-Received: by 2002:a05:600c:511b:b0:43d:fa59:bcee with SMTP id 5b1f17b1804b1-441b1f61df3mr28185545e9.33.1746026342104;
        Wed, 30 Apr 2025 08:19:02 -0700 (PDT)
Received: from localhost ([194.120.133.25])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2b28796sm28242845e9.33.2025.04.30.08.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 08:19:01 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] iommu/fsl_pamu: remove trailing space after \n
Date: Wed, 30 Apr 2025 16:18:53 +0100
Message-ID: <20250430151853.923614-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraenous space after \n in a pr_debug message. Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/iommu/fsl_pamu_domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 30be786bff11..5f08523f97cb 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -64,7 +64,7 @@ static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
 	spin_lock_irqsave(&iommu_lock, flags);
 	ret = pamu_update_paace_stash(liodn, val);
 	if (ret) {
-		pr_debug("Failed to update SPAACE for liodn %d\n ", liodn);
+		pr_debug("Failed to update SPAACE for liodn %d\n", liodn);
 		spin_unlock_irqrestore(&iommu_lock, flags);
 		return ret;
 	}
-- 
2.49.0

