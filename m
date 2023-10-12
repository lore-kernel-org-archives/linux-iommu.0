Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5496253A6
	for <iommu@lists.linux.dev>; Thu, 12 Oct 2023 04:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ins+aO6E"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9b9a494cc59so77837766b.3
        for <iommu@lists.linux.dev>; Wed, 11 Oct 2023 21:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697086255; x=1697691055; darn=lists.linux.dev;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSjZDUjjPOz4QqV7E0UZLHS9zrizXOtrbmGqfrqmqCI=;
        b=ins+aO6EknN08b/Wvd0rZ9+LpNzKl+228dIFq71pD0kfwOBmYS//ykjC2yvs2vq/sJ
         oZIMpKkwHTkNauCzV7MsD2+jL3/3ofQJeJJrq+m71BJaPqsNv091TpetiP0Rz8G7i6q1
         TeD1P5Zjs8pweS031epGkQrR/AjICHoDqoncG67j4l13p+rBrnCTaveIkaLOo432QZXI
         yYWdsg8WeaYOSmpv3nvCQQuIVGXVEvepRHXGIeBuG3MQKDCI9WBBCCrFLG3Ce7mi0HBo
         SNsL8x2wFnFXPNCcR3tsWSuz7Q9cj6LqLf91roAw3AlO6tTsEGhJ2l2DF0UkThikact8
         zhbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697086255; x=1697691055;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSjZDUjjPOz4QqV7E0UZLHS9zrizXOtrbmGqfrqmqCI=;
        b=CHVPm9/UpW6J2QpUg4POWJ5QDpHj61n9iknItbGbRMEbhn7s/gQYfXr0v7PGg5OlLK
         mZh4U1fq5B1ntv/A7qOLgHfcDcX3qVWSwV9jn5uF4nLKUJqMW2nJng9J+3IoH61YiPYX
         5J7P9lj70/BL9FYWxPB2n7Uxvjfnzel5LmnKmwlTIbHOHHT34v4OTNC1wOPp1Btk3mjZ
         Ek77sVupOJk+RRHjWcHhQ2QIrND4hC8Zx+rII1Kr3myoGPr8nbOm52hzbMs/dvrZN4tU
         L1WX+xgxzAXVR2s+u9P5j9fqBDiX8lmTZqVl6/SucG9wWCJ+zJPWxqWc2XLj8k0avIWs
         Pc1Q==
X-Gm-Message-State: AOJu0YyaKKzk0BECSEdKLDiWGLhO6HeTEDK0GxK21uDJGYJDR8HBoDTg
	Du44vIYpfPtPKaL4vDwL1I1W5A53dpw=
X-Google-Smtp-Source: AGHT+IFJU5Xjs5SYCirYwBHBkaBd6589j3RzlYuxc/TtMyuhUiNB3IoWlaEQrYaPTu0/d3k7JkPpdQ==
X-Received: by 2002:a17:906:2d2:b0:9ad:8ef8:a7e8 with SMTP id 18-20020a17090602d200b009ad8ef8a7e8mr20459122ejk.25.1697086254881;
        Wed, 11 Oct 2023 21:50:54 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:78dc:282:cf18:8032])
        by smtp.gmail.com with ESMTPSA id w19-20020a170906481300b009b9720a85e5sm10573362ejq.38.2023.10.11.21.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 21:50:54 -0700 (PDT)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <jroedel@suse.de>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] hardening: x86: drop reference to removed config AMD_IOMMU_V2
Date: Thu, 12 Oct 2023 06:50:40 +0200
Message-Id: <20231012045040.22088-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Commit 5a0b11a180a9 ("iommu/amd: Remove iommu_v2 module") removes the
config AMD_IOMMU_V2.

Remove the reference to this config in the x86 architecture-specific
hardening config fragment as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Joerg, please pick this patch on top of the commit above. Thanks.

 arch/x86/configs/hardening.config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/configs/hardening.config b/arch/x86/configs/hardening.config
index 19bb0c7a7669..7b497f3b7bc3 100644
--- a/arch/x86/configs/hardening.config
+++ b/arch/x86/configs/hardening.config
@@ -9,7 +9,6 @@ CONFIG_INTEL_IOMMU=y
 CONFIG_INTEL_IOMMU_DEFAULT_ON=y
 CONFIG_INTEL_IOMMU_SVM=y
 CONFIG_AMD_IOMMU=y
-CONFIG_AMD_IOMMU_V2=y
 
 # Enable CET Shadow Stack for userspace.
 CONFIG_X86_USER_SHADOW_STACK=y
-- 
2.17.1

