Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974CE28EA
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 02:59:08 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id x16so6872803ilm.5
        for <iommu@lists.linux.dev>; Mon, 07 Nov 2022 18:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dd4KtU41hGXmzHVze/eO+HNqRRdroUnZSC2vRqE9sso=;
        b=l7mcY0ltQTQLHnJ4/+/f+cryowvZyYJzkpeWV5nosvV00ze+HRgAacrVuNcxqZH+er
         h8B2Gs1o6qoY1XUgXSTBTnfyexbJAQa2XPBaFEpWrn6TcQn7jdvKUDlJRMcegPiIw9GP
         IvcnviQIBKfdtlXmO+1i5k6x1c3ihYkySwjVDIAp4Fg3OtZjj4RQpccn+VKSYB2hHXA5
         18P4Hy+1CQl25d9O94PF8oC+VQnfH5PaXGrZyzl/WMAs9KfHUnu04itCOKiu7i5L40hr
         dvzmfWwX/4Fpc9gA2/PCGE7Dzm8hKD3sF0XlU5eVn/YEN5QWzrQEzbaCAgRUWtowsUAL
         CCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dd4KtU41hGXmzHVze/eO+HNqRRdroUnZSC2vRqE9sso=;
        b=PZxbU6ipz6Dj/DDmguSgcCmrW3v7b5nXD13v427gavyMW9qfFEhlbMY4geA1K95GDV
         lLrM2MwHtffLp44Zw8BEW1UOGNlSBaDQ6LNXiA2OSmM5e/MqSu4x4J6+FRTrR57+Gybg
         EdeDHHbKTQF35+tNTwzKd9rfEhy4MPatAxqQEsa+76Bktv2+9cKzGOocMO8y9xQFydfz
         0Xyf09I55nCxm0dzYOOgec2pYWAVHL8FCRfegqf7cOQ7XI6xkV7W/4TWacO9sOuHjLAT
         pF97sPnaHluyGSyQD/pET9Te9FSckBQCax9kvRsiVVI1A9Pii/LQ6A6F7GVv3lecwZcv
         doRA==
X-Gm-Message-State: ACrzQf0K6Afac40kAwYebhyNNXuidjkz9reTI0F1BnjWtbFdWqDro64i
	RdIPujX2u2umX/QDJclpYlU=
X-Google-Smtp-Source: AMsMyM7ZXYEuZeVcwaYIgiEWOPHHTqVVpW+CsyngneukVkJOTe6835Mr7QQsPey9HjSIaciDmvSiiA==
X-Received: by 2002:a92:bf0e:0:b0:300:cc8e:fe07 with SMTP id z14-20020a92bf0e000000b00300cc8efe07mr17748340ilh.184.1667876347655;
        Mon, 07 Nov 2022 18:59:07 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id k15-20020a02334f000000b00363753f4730sm3328904jak.91.2022.11.07.18.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 18:59:07 -0800 (PST)
From: Richard Acayan <mailingradian@gmail.com>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v3 0/1] iommu: SMMU for SDM670
Date: Mon,  7 Nov 2022 21:58:48 -0500
Message-Id: <20221108025847.58352-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v3:
 - drop driver patch

Changes since v2:
 - rewrite driver patch (2/2)
 - rebase on (1/2):
   https://lore.kernel.org/linux-iommu/20221102184420.534094-1-dmitry.baryshkov@linaro.org/
 - reset review process (1-2/2)

Changes since v1 (no emails related to this series since last week):
 - accumulate tags (both were added because it seems like the discussion
   ended in agreement to keep adding compatible strings to the driver)

This adds the compatible string for the Qualcomm Snapdragon 670's SMMU. The
SMMU is necessary for GENI I2C, included in initial bringup because it
doesn't need non-trivial patches except for patches conventionally added
before the initial device tree (global clock controller and pinctrl).

Richard Acayan (1):
  dt-bindings: iommu: arm-smmu: add sdm670 compatible

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

-- 
2.38.1

