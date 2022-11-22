Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD24817CAB
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 23:37:29 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so336670pjj.4
        for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 15:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mforney.org; s=google;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXREoY6IalOfAmwpvzIhPYj8XLXiTvIZQIbuCU5nvp8=;
        b=Jk5QE8gqF/vU8ZoSNIYM4ZebM9hf4ktQVyAE+s0TfAxdJug0x59/Qzx4Rqdvo+Qufw
         YepypkzF23DBfv7E6W2VBvVO15IV2+NP3TwNq2+ShmIy42vEK00eEu8+zffD5p+M85Qr
         EpmnZMrqFgo5risQhcy/MGYxF1xwj83wI22DATkvgm52IXOJR33bq5PyZzUn1mOD7HFO
         TtnY8MVFTtjSumXzdtpzZ+t48WuvfbxQDWx1ESpe1g3CArHeBvMuEYcqLoX6NNuakyDY
         kKgZU0G8M1yX7fisvzz/MDItPh2uoS72GbZI3+SV7rTEXAl5lwODK51f7aO151soa9N3
         bUbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXREoY6IalOfAmwpvzIhPYj8XLXiTvIZQIbuCU5nvp8=;
        b=ZoQjrGTsNbHm59Cx+zBNaouaxK7+t7xSjkl8YseLN+MVyznRtQaNG04xTmRG3duPa4
         gKpExWym6y9iJuzcUqcg95HLQgtA8hmpcqw1io8ZHwK4tWh78oA2SdpYVP+7O1V5tonR
         pmM1zO922gcH7BJFscQkoOUIp/ugmHadB1EaXv0c0O/dpsgJuqienAMfeb+gMti/EeRQ
         zwPd2CI6ChlIvQguxZ/BAr1u2KcgjRE/kyEczaSc/muY8YfghNYDm6uOx1PdMxHf+pWS
         raPIjMjc9UXKCJEr6VeNFEELQDIAXaswYXtoDW3eBROWm4NlER/E5mcENzdkIaH+ntQk
         OH9Q==
X-Gm-Message-State: ANoB5pnxqVBMX4grvz/F3m2KMvhlKoGFzoELeTcicOpfRwAHaW8LEwtv
	fQqqcuFMF0ajdn3d8gzFjQ7WWrokfDZZyb6ILlxZfQ==
X-Google-Smtp-Source: AA0mqf4/ZfGw6ah0ZdB0vb6fgNjKwn2A5f3Nxw/l0DoQ6OgcoSbP4IVaXMfmB1VStvnuGl5C+y3ZEQ==
X-Received: by 2002:a17:902:db09:b0:188:7dca:6f4d with SMTP id m9-20020a170902db0900b001887dca6f4dmr19411533plx.68.1669160248980;
        Tue, 22 Nov 2022 15:37:28 -0800 (PST)
Received: from localhost ([2601:647:6400:20b0:5605:dbff:fe00:eccc])
        by smtp.gmail.com with ESMTPSA id k6-20020a170902c40600b0018911ae9dfasm7935927plk.232.2022.11.22.15.37.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Nov 2022 15:37:28 -0800 (PST)
Message-Id: <381fbc430c0ccdd78b3b696cfc0c32b233526ca5.1669159392.git.mforney@mforney.org>
From: Michael Forney <mforney@mforney.org>
Date: Tue, 22 Nov 2022 14:18:25 -0800
Subject: [PATCH] iommu/amd: Fix typo in macro parameter name
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Michael Forney <mforney@mforney.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

IVRS_GET_SBDF_ID is only called with fn as the fourth parameter,
so this had no effect, but fixing the name will avoid bugs if that
ever changes.

Signed-off-by: Michael Forney <mforney@mforney.org>
---
 drivers/iommu/amd/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1a2d425bf568..099ca3ed7d73 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -85,7 +85,7 @@
 
 #define LOOP_TIMEOUT	2000000
 
-#define IVRS_GET_SBDF_ID(seg, bus, dev, fd)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
+#define IVRS_GET_SBDF_ID(seg, bus, dev, fn)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
 						 | ((dev & 0x1f) << 3) | (fn & 0x7))
 
 /*
-- 
2.37.3

