Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938FD17F8
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 10:26:41 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id r2so10541414wrv.7
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPoBz9/1/N6ODRgUu0zywPKZ5Pb9peKUsXrjhFsletU=;
        b=ZRyN6STZ1TLPVz4LQ6q3JE4PIWOJj1I9SrDzQgnNUxCnJuucnPb47K5T+FT5VJqJhK
         O7/cyqU8K6RTZ+xoZ92FBBgXMi1SXmIumyAw3zE49VeVoVkCg+xC4bMIp9CwVBpGwgV+
         y1MxJbFLq0iCWns2b+hVFDDcpyNc720nV1LmafAtHn/n2W96sBotkpDyOvna77pG9sP6
         pPdfwpT2P+ZdYR6Qk6guRYpEpokyLcJ7bBJ2yNGthRpuCqIw7AOsVGJ/Yib4yo/Oh8fN
         FVTH/apMKrbFOcEOzGxtAc29B7xT//JupyxHXJDrXcqSVdyNziI2+Z/zZVg0y0FIe7Fe
         jywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPoBz9/1/N6ODRgUu0zywPKZ5Pb9peKUsXrjhFsletU=;
        b=23GlGaPZantNxt53cJcpoEzVBbHxT4IUIhMS+0DkgfK0yavLcH6/LjkA1xMRvA+tSE
         Fs4DIqDoLVppCQFx/e1PWjx/qH6waLNt8tm55XMQgNq8t6NavTHcgaG83bkITe6qxbNa
         F6acc0CV03qRu+vcw8AX6i5XfwgBdpEMu3fSM++EWMCeG+7DnmLXDtwTeh0t/fy/P/tK
         ZvTpz4VY/77FgF0obKAS8sGkG4uEAkQZTf0YntuUN0ui8NyP5WQfpdkIL9jKDwTInN+H
         w3Q4oakZSLl5z5SOtkE23DTwchX7mu5S7c6dSIpVOHn0eTBwFDoIonPlbpdgrtjtRWAR
         sepQ==
X-Gm-Message-State: AFqh2ko5ZLd5fzqXXUXXUfjFgIthO41G0c0snod0adjf5RVD0wMQx7js
	81yT+5W+N2fuVpOVR42uPR+woA==
X-Google-Smtp-Source: AMrXdXsW7ZQDGKlzFTYhQEjR+p+Zk8AHHZFaUSI9MHLnvUkGztcTA7MZHFFlS/Gqk/Zh0lJ9wDVJ1g==
X-Received: by 2002:a05:6000:1e18:b0:2bc:846a:8ead with SMTP id bj24-20020a0560001e1800b002bc846a8eadmr46483687wrb.37.1675074399921;
        Mon, 30 Jan 2023 02:26:39 -0800 (PST)
Received: from alex-T14.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d5105000000b002bdfcd8c77csm11426785wrt.101.2023.01.30.02.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:26:39 -0800 (PST)
From: Alexandre Bailon <abailon@baylibre.com>
To: yong.wu@mediatek.com,
	joro@8bytes.org,
	will@kernel.org
Cc: robin.murphy@arm.com,
	matthias.bgg@gmail.com,
	krzysztof.kozlowski@linaro.org,
	robh+dt@kernel.org,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH 3/3] dt-bindings: iommu: memory: Use unmanaged iommu domain for the APU
Date: Mon, 30 Jan 2023 11:27:22 +0100
Message-Id: <20230130102722.133271-4-abailon@baylibre.com>
X-Mailer: git-send-email 2.38.2
In-Reply-To: <20230130102722.133271-1-abailon@baylibre.com>
References: <20230130102722.133271-1-abailon@baylibre.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates the iommu id to use unmanaged iommu domain for the APU.
This is required by remoteproc to use the iommu.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 include/dt-bindings/memory/mediatek,mt8365-larb-port.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
index 56d5a5dd519e7..86d82a8f6017d 100644
--- a/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
+++ b/include/dt-bindings/memory/mediatek,mt8365-larb-port.h
@@ -24,8 +24,8 @@
 #define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
 #define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 8)
 #define M4U_PORT_DISP_FAKE0		MTK_M4U_ID(M4U_LARB0_ID, 9)
-#define M4U_PORT_APU_READ		MTK_M4U_ID(M4U_LARB0_ID, 10)
-#define M4U_PORT_APU_WRITE		MTK_M4U_ID(M4U_LARB0_ID, 11)
+#define M4U_PORT_APU_READ		MTK_M4U_UNMANAGED_ID(M4U_LARB0_ID, 10)
+#define M4U_PORT_APU_WRITE		MTK_M4U_UNMANAGED_ID(M4U_LARB0_ID, 11)
 
 /* larb1 */
 #define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB1_ID, 0)
-- 
2.38.2

