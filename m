Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C44402;
	Thu, 13 Oct 2022 18:12:50 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id l22so3758411edj.5;
        Thu, 13 Oct 2022 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5o4hmrTo+a4A6KCBunzs3GYyFuyFvq3xuPa8kZR43M=;
        b=DU//SwH+JfMDyVMKNcHeLU136bnf9QlAcBT+KWFVH1q8TwC873dRzVkVcKr2u+9nNy
         s4WnYSjekVglH1Dqi8Q5bz1KKUstGlkGyZICaJIhtnSxPx9i4eWPCG4iyWXTFMOu80Yj
         JuXKwqbN5s/MaQedvEbm5oL0MF5SwXqsOSAYwgO+wM1nu4MxZk5JEX47YxnmZKq5HFWM
         iOQKeimAZfXCEBU0wVC/OmlYE4XV5R7pbnkFQFzZelR3uIldMiOvA3dP4qKmlcR5MWv6
         vPAd8nW9lYSA7dr6TxoqTJEsvKy18NpG7B3jvYfTGmiaad+Tq72HVbY90tsQmCyC0nEC
         p6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5o4hmrTo+a4A6KCBunzs3GYyFuyFvq3xuPa8kZR43M=;
        b=04MIdYCApRG6fmBjuEKZh8LbUOenL5CGU+TPIIcx0nkPjCRzZTkVi9ZmJsEJrg7Gb0
         ZJytDi3fOUcOrFulcN9Inn90rkcstPc7LA8wptzJFdKGUh+HlqyR//dsjMwX3HzoxeNk
         DP8UC8Ow1ObdLEDYUPw3sXErFXgnFc6ARsua3GuSHHDbhUMXnNosuX2QLfTPPezo5pO/
         njCi+XGE0eu9RIF/KwYe4IoXJVveamtmXu2mal95I4wnwd4FAQYaT3+DJQsfUwNHNKvj
         KlgIO6WAPSJW7tbFfd7XfOepIVXV7NRzKajPKScBjxg+okn++daK82TnM6+esgkO0Yna
         gi4A==
X-Gm-Message-State: ACrzQf38CyNYSlravey9CBCrDr3wYgfB45UNwPlUjZ7LyEgzccQ+jjOd
	1VruG2ctlhErdFbPutT/JNI=
X-Google-Smtp-Source: AMsMyM779LnzMOJRUaV+d5Mya+59vT9EDrXNtlqV4dqAf2i/G2SCcwlVYTXuJQeHdR3GU8JloRYY6Q==
X-Received: by 2002:a05:6402:350d:b0:45c:f5a2:348e with SMTP id b13-20020a056402350d00b0045cf5a2348emr895071edd.398.1665684768460;
        Thu, 13 Oct 2022 11:12:48 -0700 (PDT)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b0078b551d2fa3sm211109ejc.103.2022.10.13.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 11:12:47 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: maxime@cerno.tech,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	wens@csie.org,
	samuel@sholland.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 3/5] iommu/sun50i: Fix R/W permission check
Date: Thu, 13 Oct 2022 20:12:18 +0200
Message-Id: <20221013181221.3247429-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
References: <20221013181221.3247429-1-jernej.skrabec@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because driver has enum type permissions and iommu subsystem has bitmap
type, we have to be careful how check for combined read and write
permissions is done. In such case, we have to mask both permissions and
check that both are set at the same time.

Current code just masks both flags but doesn't check that both are set.
In short, it always sets R/W permission, regardles if requested
permissions were RO, WO or RW. Fix that.

Fixes: 4100b8c229b3 ("iommu: Add Allwinner H6 IOMMU driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/iommu/sun50i-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 38d1069cf383..135df6934a9e 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -271,7 +271,7 @@ static u32 sun50i_mk_pte(phys_addr_t page, int prot)
 	enum sun50i_iommu_aci aci;
 	u32 flags = 0;
 
-	if (prot & (IOMMU_READ | IOMMU_WRITE))
+	if ((prot & (IOMMU_READ | IOMMU_WRITE)) == (IOMMU_READ | IOMMU_WRITE))
 		aci = SUN50I_IOMMU_ACI_RD_WR;
 	else if (prot & IOMMU_READ)
 		aci = SUN50I_IOMMU_ACI_RD;
-- 
2.38.0

