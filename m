Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912057B
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 01:11:05 +0000 (UTC)
Received: by mail-il1-f178.google.com with SMTP id d14so6752569ilf.2
        for <iommu@lists.linux.dev>; Mon, 17 Oct 2022 18:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lUGmLAO+UyEHxzHYsfZWHoOtdpAGmxoVd+nS8TzFDs8=;
        b=qiCS1CYVNm2hhnp0GB1inFD/WgFm91+6EQ/i2Q6MEqZ2w4Hf7VZc7QgYL/OsHtH6g+
         eX4vgHBLBMhCP0btXHSSOWsPQ0+HEyP88/M3R8sfToGKM+os0iAI+DFnUCggCyrr33pD
         khZhonkn8A0m+4UUGUOlTzZkd3WzPMk70Yvqsh3H2RggatREM7lu7z1xxEC49f35M+vL
         zM08xOUgi75DAXdGlhVr3SEm/K0q7z/7gHCcNRsSjKfpIOZJ1akPVp6PhjeISYLU8Mkp
         n9x9P53hi0Y+6xGHa0S5ryLoDkCC9a634nqkrePHmQeKXQtO8mSxdWohECc6DGmRNY/K
         kbOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lUGmLAO+UyEHxzHYsfZWHoOtdpAGmxoVd+nS8TzFDs8=;
        b=qgvPVbdTxl0U+EVs+EfTopm0zsmVgmIcjT2WNr9zlo+lFuQ8UoMYH7DKBj7cA5jaAX
         9JjcATnLf0L4zTWK6RH3qZxDSg6KJUWStB/3mz8JcS64329gn66E/JzxERXr3eNfcBh4
         /XkBkW1dgHAjXMy691BzEibImlpUYtkwnSp4TbxqQ5yEfOTlPplNpVrvN247rYcqKYBT
         hULPADyFtlTcebo+97m3FMkQh/ogDvrrNaNmB8DM16uuiFOkzpUBbZcqkYnjK+TUDV+8
         dIys+bLNs5MkVkhLdgrTZVoYE78QguDQhSHfJTPZIEbuF9xW2biGpJxYE6ABM0LbAwdW
         IEPg==
X-Gm-Message-State: ACrzQf1xq8z7KJ+I+u69tYU54ChxGibMhDL4LeWUoEuv8oIJhxhZJC2L
	dcaAL5EC84toUWQbWDVfpl2/ZXJmnX68XQ==
X-Google-Smtp-Source: AMsMyM6IB6dhw+gIryWO6kHLBntXwikUmUVZu9vEkx3nSgFpNYvp6/Q+aN+jppnMktaHfdUcrF4txQ==
X-Received: by 2002:a05:6e02:1c02:b0:2fa:1594:b7aa with SMTP id l2-20020a056e021c0200b002fa1594b7aamr528586ilh.263.1666055464387;
        Mon, 17 Oct 2022 18:11:04 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::4a89])
        by smtp.gmail.com with UTF8SMTPSA id g19-20020a05660203d300b0069e1bcbddaesm499939iov.16.2022.10.17.18.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:11:03 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Richard Acayan <mailingradian@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [RESEND PATCH v2 0/2] iommu: SMMU for SDM670
Date: Mon, 17 Oct 2022 21:10:46 -0400
Message-Id: <20221018011048.25371-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v1 (no emails related to this series since last week):
 - accumulate tags (both were added because it seems like the discussion
   ended in agreement to keep adding compatible strings to the driver)

This adds the compatible string for the Qualcomm Snapdragon 670's SMMU. The
SMMU is necessary for GENI I2C, included in initial bringup because it
doesn't need non-trivial patches except for patches conventionally added
before the initial device tree (global clock controller and pinctrl).

Richard Acayan (2):
  dt-bindings: iommu: arm-smmu: add sdm670 compatible
  iommu: arm-smmu-qcom: add sdm670 compatible

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.38.0

