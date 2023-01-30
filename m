Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDF817D9
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 10:26:38 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id q5so10595066wrv.0
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a1sabGNp0i0jnpvKtDcfkVpINZEUTfpEqzCGhBjXqIw=;
        b=TGbOhzz/rPG3jSJFwXwz9IARb5DEJa0LNKqqAhM8Or6IuR3iLbqSOj9ah3EQaWUZv3
         QtpJDEd/CQRktCQqVLtB4vMZaVkaUSlj+f5413ziTkTbsZUGJC4difgipU7P2mnJ841b
         zG1f6EeK7NeiAN/BqZVB1ON0FvRmlPDDVE9eVMZVPoBM9CLB5O5dIyX2rQeA6GAJEwJ6
         16CHJhQItoI+eKYhP7OGYNAFW1GMAdm5Dtrr41T9yxgdjS3/MmzxF9LWlc0xEXyuXtgP
         cmZDGJRW7Ap0j75DnTuemaHRy5l01XZKOCvIULOdnHGtgMI/vE9fKap6yzNcupMNxijc
         Q35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1sabGNp0i0jnpvKtDcfkVpINZEUTfpEqzCGhBjXqIw=;
        b=r/ejwH67OgLFrhO/rA7fCxKnxzGdTq/jw7qUMuoMcXJTBorgFQiefwN4/sjT/wj52o
         mRn03PW1ZeAXw/T0J791fsrEt19yutLQeT3h8HmPMUZBKzVn3/gqlmbf9zbJpvGvYuXn
         NvhkUT1eDXyDqt8Lsuj3hPWu0+ApqronZlAgFWGdzYsmW3kYs01+znhL0cPFwKNoP51+
         RBRTwlMCsyp/pGtngEU95FgXV5ijx2mTpUeOfE0zks+SspcplFCJ0kJ04Min4E90ddVS
         JPG8UW2XA1vEeWujRISoqpJN8I1UWprSJ2FDbNXWwutzATqBTyT451gzpobKl1CfrnGu
         1F7Q==
X-Gm-Message-State: AFqh2kr8qXHVGWC+FtCbsAfPcXx4o2RVu9deE9ZZBkTWODNyAdc0t+16
	hHrYU90RTVcYjDTcSzKA8I4Luw==
X-Google-Smtp-Source: AMrXdXusnxR1vGulnY9qOYGIrAj2fP/mpLLBdaOBnAzh7KNVOon1ShfM7VQfgnYhs0CrTstGHVq8UA==
X-Received: by 2002:a5d:6e8b:0:b0:2bd:d9b5:8191 with SMTP id k11-20020a5d6e8b000000b002bdd9b58191mr42677507wrz.61.1675074396348;
        Mon, 30 Jan 2023 02:26:36 -0800 (PST)
Received: from alex-T14.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s5-20020a5d5105000000b002bdfcd8c77csm11426785wrt.101.2023.01.30.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 02:26:35 -0800 (PST)
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
Subject: [PATCH 0/3] Add support of unmanaged domain to mediatek IOMMU
Date: Mon, 30 Jan 2023 11:27:19 +0100
Message-Id: <20230130102722.133271-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.38.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mediatek mt8365 SoC APU support (AI Processor Unit) is being upstremed.
This device, behind an IOMMU uses remoteproc which requires unmanaged domain.
This updates the iommu driver to support unmanaged iommu domain and let
remoteproc use the IOMMU.

Alexandre Bailon (3):
  dt-bindings: memory: mediatek: Add support of unmanaged iommu domain
  iommu: mediatek: Add support of unmanaged iommu domain
  dt-bindings: iommu: memory: Use unmanaged iommu domain for the APU

 drivers/iommu/mtk_iommu.c                              | 6 ++++++
 include/dt-bindings/memory/mediatek,mt8365-larb-port.h | 4 ++--
 include/dt-bindings/memory/mtk-memory-port.h           | 3 +++
 3 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.38.2

