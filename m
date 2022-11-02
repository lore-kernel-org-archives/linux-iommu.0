Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152D2C9D
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 15:18:13 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so1526965wms.0
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ+0LGy5cr91Z7JYyFQjKjScDmLoFGyMsyW56rznHI=;
        b=4kmTkEjoaPkPpY5TeRCGqZQK4lVJKIoAywvwm8E4NUvoFaVAvU04m8VWQg6dM549kQ
         zaHGpKGC18yX/EuS71w9KcGLZSkBSzf1o4fAmTfDa+QYUBzSU9qeRaoPDKECAlfNIsGB
         bEMPqcgSfkQjJuER4kzyJjLZN9XEFBFUapGP+uJ1l/Ytb5YIh6gx2gYdEsw0M6pJMvaI
         xQivHSz7N/dL2v9bVa/crnn8EEa/TEDKEOEX8iPDFX8PlOAKg0gwOwbElmByDhnyB12V
         zEJPaTTEAL/Y7cj9mhc8d3HUwDVbY/2KJc92gdRyXcPYay90uG8UJ9E2qm0Cr4fqSkui
         Xl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puZ+0LGy5cr91Z7JYyFQjKjScDmLoFGyMsyW56rznHI=;
        b=j+CtcnKyHA7VRRktoSXskRDkBZVOm+iZJuK9VxQ6v8cYfPBxCbrQvcEb9r7WZ5hMLW
         rQp91hjiBNE6y0PKQ+VGyOlZAp4UJOB+4OGH4aGxxBJ+oaku04JW1lnj0TyAgT2x3psl
         Jfiqz12ehIBcNVCF3gpqpy67hZBlFMYv61OUkeiJg8UxJsQRz7bsAHNnSEyecwSRhpK3
         ieYopU7QuwCy/DP4cjxnqcehoTeyxn6/8LthyUejcAAQUPg55/Jd402i1l3UmUFKyB7p
         dQd5o0b4nxmzPhobpaacBz7mw0I/ILzIl2OBzM91W0LeU+5R6QyIaJnZ4h/y64ZysSeO
         YvPQ==
X-Gm-Message-State: ACrzQf3Cm3Nh0Fi4wIF1kG+FzC7CbkHzOIVfTw6c8Jn8KhG/YAheb2ZD
	zYxZELJR1ESVUpyyyNrZi80Bxg==
X-Google-Smtp-Source: AMsMyM7tczNIZJka+ESh5Vo1g4S4rneWYScW4p8/eTQG9IG8rYrS87aUS8u1710mEPfjdDuW9TTwog==
X-Received: by 2002:a1c:5403:0:b0:3cf:684e:e2fb with SMTP id i3-20020a1c5403000000b003cf684ee2fbmr14579042wmb.111.1667402291654;
        Wed, 02 Nov 2022 08:18:11 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id bq13-20020a5d5a0d000000b002365921c9aesm13332818wrb.77.2022.11.02.08.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:18:11 -0700 (PDT)
Subject: [PATCH v6 0/3] iommu/mediatek: Add mt8365 iommu support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAC6KYmMC/42Py2rDMBAAfyXoXBV59XCUU/+j9OCVVrXAjyDFhhD8793k1pKaXCRWMDOrm6hUMl
 VxOtxEoTXXPE88uLeDCH03fZPMkWcBCqBRqpF5HsdF1uV8nstFJqN8aEl5Q04wg10liaWbQs/UtAwD
 P/a5XuZyfTRW4OvzP90KUknnEdvoolJgP7C7DhkLvYd5vAf2wIiJEhARBv8b/GJy1btlzYJw1EiJAg
 DFl8sPsEWtrEcVG/ekbHbLhgUUHC9vDaHFl8t3MDXUaKOPMUV4Ura7ZcsCDyEi8sf5+CPYtu0H9RIj FCACAAA=
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Wed, 02 Nov 2022 16:18:06 +0100
Message-Id: <20221001-iommu-support-v6-0-be4fe8da254b@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>
Cc: linux-kernel@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>, iommu@lists.linux.dev,
 linux-mediatek@lists.infradead.org, Amjad Ouled-Ameur <aouledameur@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org,
 Fabien Parent <fparent@baylibre.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2977; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=jrXGfpF0FZV8/iv8F9volsSlJjJIqhNJ+DNMJkMCyUU=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjYooyXKwNIizT6oUBlfzf2waw3+sC4LEjNwSAKtWx
 aI7rt6CJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY2KKMgAKCRArRkmdfjHURdGaD/
 9GZcXu79nnoqE+ZUz0yEZX9OWN1PuGu73BnkE5nr3ghfLBmD7asrUkd/dGPP1VC2jT0Lb/WtB0OS3j
 8vtPmMCoBoklVapxVrUuGuIlOSFpVs6kfNDAuopkiKWgK1YYnXUDUcWWGoblW5Oyvkkvec/66ZOTJZ
 tI1Ab8TWdY9s8dVu3JGoIifjZWLSlb4PcAmu29AkXWiwwXQiQ+xHXGUfxN3IkRjTOZnKwJ/QyayROD
 XJhQsIgcL5fflLJN7Q40NyoBotaVRBzmvdQGUXXLFkVXmU8BpNFjPW2pQKt6QplOcigJYdDzfSLx2q
 h9dQ+kQ5CH+rNCh5mWcBy9gKyenu6XQHzfwr5rO8PoOFD+N516sKlvJoc/rBBYOZvQ0nnd9cZlAwvH
 NwMeW2Dzhxx6cm7k/G+IoTq5qiVxbN64uVyZOq2nKkU7CprzjV+ov/kCdyZ5a4jcYi9XEEgh8aDEmt
 uPFujssehSLpPwJz2GnIIdVXw7/2Fi6rr5xFPxpPoSZPOwAEEEH5Pa2+lYZnHYYt7CZ6xzmGee75vz
 c9zivbL1Y7ApRIvGpKq1+aIHQDP+vzOEhKvbgXPysYtnVjHlltEGnFNSRd1SkZ/1H9KoNPtv9Po29C
 75i0+LnXCExK4PEsHThhi+CX+6P+MXuUFSCWl/jfVB5pqIYttbo2Z+uaJqJw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Hi,

This series contains patches related to the support of mt8365 iommu.
Thanks for your feedback so far.

Regards,
Alex

Changes in v6:
- Rebase
- Add new trailers
- Link to v5: https://lore.kernel.org/r/20221001-iommu-support-v5-0-92cdbb83bbb8@baylibre.com

Changes in v5:                                                                  
- Fix name file in mediatek,iommu.yaml                                          
- Rename defines to be more consistent                                          
- Rework INT_ID_PORT_WIDTH_6 check                                              
- Link to v4: https://lore.kernel.org/r/20221001-iommu-support-v4-0-f1e13438dfd2@baylibre.com

Changes in v4:
- Typo
- Rebase
- Link to v3: https://lore.kernel.org/r/20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com

Changes in v3:
- Rename "mt8365-larb-port.h" to "mediatek,mt8365-larb-port.h"
- Rework the macros which retrieve larb/port ID to improve human readability
- Link to v2: https://lore.kernel.org/r/20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com

Changes in v2:
- Rebase.
- Change M4U_PORT_APU_READ & M4U_PORT_APU_WRITE port to avoid display
  conflict in larb0. These definitions are used for vpu0 device node.
- Add dual license.
- Retitle commit.
- Rename to int_id_port_width for more detail.
- Fix typo.
- Set banks_enable and banks_num in mt8365_data to fix kernel panic at boot.
- Link to v1 - https://lore.kernel.org/lkml/20220530180328.845692-1-fparent@baylibre.com/

To: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev
Cc: linux-mediatek@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Fabien Parent <fparent@baylibre.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Fabien Parent (3):
      dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
      iommu/mediatek: add support for 6-bit encoded port IDs
      iommu/mediatek: add support for MT8365 SoC

 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
 drivers/iommu/mtk_iommu.c                          | 25 +++++-
 .../dt-bindings/memory/mediatek,mt8365-larb-port.h | 90 ++++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)
---
base-commit: 11082343e3bf2953a937509f0316cabf69dbf908
change-id: 20221001-iommu-support-f409c7e094e6

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
