Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804017F8
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 10:26:39 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id a3so3854738wrt.6
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 02:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/rwlLDEtbW36VfCqW0mnDyKREjKUOT7fxTwKpedSJQ=;
        b=3E0zkA2gqTmqoeeFb3Q+vnT07aKxFwrUH34EgWo4WmsznGFTb6oc/GlWxTb3M5RUud
         UpNd0oOfSg9RHk2rK4Qtmk3soyvhnU8HOmBmEKP3nwmU3dlqRPt2zGLETL3HRegddjlw
         GMBvu07lIEFQjUx+90/7IwQ9Vf0kjB7AQhdWVa3SPuLup8G6jeOQa2sFj8MzYy4l+cAq
         j5vZgqbDnzOhOGRLq5GC+J8jqaJMkwz2FTQK7Q5eFL6tXwU3wKLq0HkrAn9m+l4Wx1ff
         NOUX31pnVurLmnDzXn/SttucqBwkn4mJ4IjYBq0um87+eUw7KmIB72WmryhMVtgR4zwq
         Rd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/rwlLDEtbW36VfCqW0mnDyKREjKUOT7fxTwKpedSJQ=;
        b=wmzyRm6gWw4cBlfRraNoY4UtIi1CybhEn4aUqTHcw9OU8I671KPY0BvgLu5Sgn4SCy
         Ec94uQyJuN7MWeYOBzXa/+Bvh/EagXXv6UCUzG9qikfTb3cWVwDKOWXhreLTW6lYM3v+
         pL+1Xcb1xMsQp2cWPC5WWyW6wM4I5I3cTF91yQrSC042v+hRBVQ36XBRvumwp53T1FwJ
         WhP6NGhRsK/etpBHPdYotL5tXJMQ+fpRdTgqkp+rc22SgJdi9cjDoicsVEm1TKaVy0PI
         Ni6Ivinw8MEv/XNn97iOolpurMhV6vxtqOgU9DM4Hf4lXXQLMwQDcEtBPE0KPS0sv1Yk
         AWTw==
X-Gm-Message-State: AFqh2kpLKrbLxD40Xm3iOMjfewJ0P3lgfZJjd8hBEV1jVGqb2SiYGGRi
	I6asB+Ke+TKGUdMAPZV1uSyXXA==
X-Google-Smtp-Source: AMrXdXtCiNfSdUuMkTNChaAYiBD0oXk/tcW8F7bQQHQBjcoe+x26vkfwvHt6Gpl6NHBhKdyyS31KtA==
X-Received: by 2002:a5d:46c2:0:b0:2bf:9468:340 with SMTP id g2-20020a5d46c2000000b002bf94680340mr29633671wrs.19.1675074397479;
        Mon, 30 Jan 2023 02:26:37 -0800 (PST)
Received: from alex-T14.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d5105000000b002bdfcd8c77csm11426785wrt.101.2023.01.30.02.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:26:37 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: memory: mediatek: Add support of unmanaged iommu domain
Date: Mon, 30 Jan 2023 11:27:20 +0100
Message-Id: <20230130102722.133271-2-abailon@baylibre.com>
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

Currently, the only way to have an unmanaged domain for a device
is having a dedicated iova region or bank.
This adds a new bit to MTK_M4U_ID that allows defining devices
that needs unmanaged iommu domain.

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 include/dt-bindings/memory/mtk-memory-port.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
index 2f68a0511a257..86896c776691a 100644
--- a/include/dt-bindings/memory/mtk-memory-port.h
+++ b/include/dt-bindings/memory/mtk-memory-port.h
@@ -7,11 +7,14 @@
 #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
 
 #define MTK_LARB_NR_MAX			32
+#define MTK_UNMANAGED_DEVICE            (1 << 31)
 
 #define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
 #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
+#define MTK_M4U_UNMANAGED(id)		((id) & MTK_UNMANAGED_DEVICE)
 
 #define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
+#define MTK_M4U_UNMANAGED_ID(larb, port) (MTK_M4U_ID(larb, port) | MTK_UNMANAGED_DEVICE)
 
 #endif
-- 
2.38.2

