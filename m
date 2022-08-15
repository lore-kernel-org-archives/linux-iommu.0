Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342347E
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 10:12:25 +0000 (UTC)
Received: by mail-lf1-f53.google.com with SMTP id u3so9999721lfk.8
        for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=MdskW5HP+CDyH23eInIpuoo8lXjbVqnmwkTOrQWFXYg=;
        b=UEx3+L/gV5rSZ6L2pIExhA4Ehw9o+jAookhe3x/Dl20YZFyIOgTKcbXMT/Kbcy0w9T
         PDDp+S5H5IRKkmc+DWuvU1KlfL/oTOA44P5OfeBI4698ZD/9uYM0so34cliZLrd+iUpd
         LQWx/p4UsAHk5rO+2I2ee/Q2VD0VZ55wG+ACs37Qh2CSJrdqeJq6jXNha5jO5IHSUMZ+
         wdyYxXgX71C+f/vC/2yVOsZR+2yUp65e6ibUygaza8v21jfbHoWyGTCRg3Vlgyo241/2
         +axA/OyBaJibj73Wm4khKZHCXqNw85d50/xKs6fFrjsn4zymMz6DzJun5Xyr0aQOb8G0
         8iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=MdskW5HP+CDyH23eInIpuoo8lXjbVqnmwkTOrQWFXYg=;
        b=BwcS/mc3oCgY3icOwq/db5xOj9JgFzb9AwK9E9B5uMxOAdoyWrNWXeKII71TpwbsrM
         Ab6y2NUxdNLb+d3umaGRY2OQx6vyl60HYmDCKN9uU/ZY5GK4h31HjWt8Ir/OLGft3Add
         ydS9Y/aDEc0NQB4FYFn9mXaJM4A9S1YqG+bYsvnSvHHHL2LYGcQnx20BRfZ90zRnjauv
         KrjHRsH7hK//HgPNq8+sz2jHVdA8B9rBJSkR7Ktdxjq8VqnV3K+RdZa5wZlXHAlSWMiI
         wWsjUb19NunGZR1j/v7arXNgyjOxpjTLFuCYWtihdfYN4OhgTtZuRXHqUpyKEKEV87rF
         KM6w==
X-Gm-Message-State: ACgBeo0Ie2btg3k8er10pUMnsEJ2Fv25ZzEw0ewi3C9Ehq5M0GGm0Aje
	4hE/vT4dqFnnI+xcTZ6u21E=
X-Google-Smtp-Source: AA6agR48ajQgkYbbBMkMx9FOY/cUH0YJqIDV8pf/uiQQV6pIiKrB6lPAhRoCRX+EWp5C+JPLBH6S5Q==
X-Received: by 2002:a19:710f:0:b0:491:fce9:cfb1 with SMTP id m15-20020a19710f000000b00491fce9cfb1mr2367812lfc.264.1660558343143;
        Mon, 15 Aug 2022 03:12:23 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:22 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Emma Anholt <emma@anholt.net>,
	Rob Clark <robdclark@chromium.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 0/7] Compatibles for SM6115
Date: Mon, 15 Aug 2022 12:09:38 +0200
Message-Id: <20220815100952.23795-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series add bunch of compatibles in preparation
for sending device tree patches for Snapdragon 662 SoC

Adam Skladowski (7):
  dt-bindings: dmaengine: qcom: gpi: add compatible for SM6115
  dmaengine: qcom: gpi: Add SM6115 support
  dt-bindings: mmc: sdhci-msm: Document the SM6115 compatible
  cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
  dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
  iommu/arm-smmu-qcom: Add SM6115 support
  dt-bindings: firmware: document Qualcomm SM6115 SCM

 Documentation/devicetree/bindings/dma/qcom,gpi.yaml     | 1 +
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml   | 1 +
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml    | 1 +
 drivers/cpufreq/cpufreq-dt-platdev.c                    | 1 +
 drivers/dma/qcom/gpi.c                                  | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c              | 2 ++
 7 files changed, 8 insertions(+)

-- 
2.25.1

