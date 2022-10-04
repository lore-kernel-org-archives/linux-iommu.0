Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3215723B8
	for <iommu@lists.linux.dev>; Tue,  4 Oct 2022 10:01:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so619467wmb.0
        for <iommu@lists.linux.dev>; Tue, 04 Oct 2022 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=tKU7evcDNmKM2NyEmOubND8UgSxdHh2PbRRWmqzSe2w=;
        b=xN+rfGtVX8AJ5IvHIYXHWrWp2qqPVbtRtxDUEN8FTd05ln1AEhTbpYy5Qz0bwzFmy0
         XbHP4GvJPlKn5PD4LAUHqjvjY0Da9bNpNxyF7qxaqg8dQ/bMOlBsaWdqBi/9qOJ8W0Jb
         K5Yb8hYTpqvE3ZI/ATNZl1/Cx4x6AbEoHfan9X6bOJLsNDB4qFlvET9NjoIo1BLGn578
         BtzIA0AOLiSKROSQxsiT2DBhI9fyUBer1Wpqf9v80Xe4vHTSl3qfr3+SerzGD59seRDV
         0R5YE48e+ePI/tM4QtV4sxzg1L6L2bswfHJhxFOQS1bF4/P7xHjAm5lER40hto3L6jXu
         dQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=tKU7evcDNmKM2NyEmOubND8UgSxdHh2PbRRWmqzSe2w=;
        b=zAWwdViqmC9bj9si149f8KmbYqIfV5QjgBeP/F/mZVPyN24S/vPDGdCo3OT8oj9Ski
         80xeDrnd83H/AndexVF1zSG3yCh1QVHlvjjLAehFtXikB4llxGbJrcyU6MOdQRUiVFwK
         nA/BDNuf7aqy9ifN8noPpiwnyaerRGHqok2LQ+Lal2zVX4533tV0h4+CvnENtXFWK7Pk
         hrszWJZcUNDRPlReQnrTCrNxrEnGp/P8vjUNz16ZnBah/MYtfVzNQRYTXvzWimcujri9
         I92IW3gWM1/vIqC0zF48AwVxVaZQxKEDH3dPDDyx4dKQ+kYBwByzG76PVvH65FRIgKbO
         4dww==
X-Gm-Message-State: ACrzQf2BoK61b66DiNzRUd/WGoItKgbJsVLvwujGnNCAF2zUNwODQ5fb
	EeSAy0Y/F0TPDrkpOBOG9odJKA==
X-Google-Smtp-Source: AMsMyM4QADSoQD6BI5POivnrAYpJaFBXo2k6iMLIzBD4ZHLZ1LRVhikrMgIoctpBYEGWa2+MaybjWQ==
X-Received: by 2002:a05:600c:1c1f:b0:3b4:8330:5a46 with SMTP id j31-20020a05600c1c1f00b003b483305a46mr9745590wms.45.1664877709319;
        Tue, 04 Oct 2022 03:01:49 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d3-20020a5d6dc3000000b0022e3cba367fsm5473645wrz.100.2022.10.04.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:01:48 -0700 (PDT)
Subject: [PATCH v2 0/3] iommu/mediatek: Add mt8365 iommu support
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAIIEPGMC/33NQQqDMBAF0KuUrJsSxxhrV71H6cKJYw1oIokKIt69Q5eldTX8D//NJhJFR0ncTp
 uItLjkgucA55OwXe1fJF3DWYACyJTKpAvDMMs0j2OIk2y1qmxJqtJkBG+wTiQx1t52vPJz33PZuTSF
 uH5+LMDn8Y9bQCppKsSyMY1SUNyxXnuHkS42DOLJ2JIfAjkD9pojtWQBqPkB6ENAM0DWYEuFJizwC9 j3/Q2nvszFNAEAAA==
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 04 Oct 2022 12:01:38 +0200
Message-Id: <20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com>
To: Rob Herring <robh+dt@kernel.org>, Yong Wu <yong.wu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Alexandre Mergnat <amergnat@baylibre.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, Fabien Parent <fparent@baylibre.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, Amjad Ouled-Ameur <aouledameur@baylibre.com>, devicetree@vger.kernel.org,
 iommu@lists.linux.dev
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=wkZ+3sWJG6Ki+/rHRdrbUO5DYzvEVkUDbNJFrbYO/CY=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjPASLaqK95in0T9QMfwgqhBOMZ9LhaECkSxMbAXJE
 POQrg9GJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCYzwEiwAKCRArRkmdfjHURVC4D/
 49eK87NwJmmnFfBn2wOKHykIRQFWX56rejL3Z2zFx5pcOhzOuUP2qsm9xlwqUWiyMk03I9oUyqlzcD
 6cniug/vPaB89Yijho9Vb+nBvLfAaK5qBHa46FJjUeRb7EE2S5g5Ex7d1vNL1xSh7ZVJEw5gkUPzu+
 N+GpG8ix0crSZ4+nOAsYb+wLhburt/1sqgLUtVYKKmnBDqtiLUMeUm4KZOx5k4ELdwPgdKb6dOEwH2
 IR+mAh8ZGjSY+mw07bIcoE3pnlg35r1jxb7AMwC31AB1OQc+XABPOHmDyVN6ePQ0nZgtSi5cdN2ENG
 mvPbCV/N1G/+F2kdv0YJECduDpT/btoV/3fOeTSfUQSgI8c8Z5oXfIXQGGPnyqdVYclzUQvyxU0erd
 jPc03HWIr85fuW4Z+Nx5DoE8F8sYeDQsaxMI40pS/93ZJNxyRvdpsz1l9htySAlxPAQpMh8+LPoBnP
 g2Qc8ia78dfVgs+IGqZq8J7RWfvapJ4H4T6YPBkfEiPVZOSqsQmIAIKmlfbsq37aKKrXg6IWI8DMJM
 zpHXslLrR4jr5D9WuCgqV+iVJhkeEPjmtiUNFP2MBQWGi/DRQKJX5oxslKDnqcK3luoKRwY+LL4jFg
 VANpg2cS3J3tKJAFa2mj5FhHATKUUo9WE0wJYfWxdsWqMm1aN14d6Hd1ZjSg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Hi,

This series contains patches related to the support of mt8365 iommu.
Thanks for your feedback so far.

Regards,
Alex

Changes in v2:
- Rebase.
- Change M4U_PORT_APU_READ & M4U_PORT_APU_WRITE port to avoid display
  conflict in larb0. These definitions are used for vpu0 device node.
- Add dual license.
- Retitle commit.
- Rename to int_id_port_width for more detail.
- Fix typo.
- Set banks_enable and banks_num in mt8365_data to fix kernel panic at boot.

Previous versions:
v1 - https://lore.kernel.org/lkml/20220530180328.845692-1-fparent@baylibre.com/

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
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Fabien Parent (3):
      dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
      iommu/mediatek: add support for 6-bit encoded port IDs
      iommu/mediatek: add support for MT8365 SoC

 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
 drivers/iommu/mtk_iommu.c                          | 38 ++++++++-
 include/dt-bindings/memory/mt8365-larb-port.h      | 90 ++++++++++++++++++++++
 3 files changed, 126 insertions(+), 4 deletions(-)
---
base-commit: 11082343e3bf2953a937509f0316cabf69dbf908
change-id: 20221001-iommu-support-f409c7e094e6

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
