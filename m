Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA9B7E1C
	for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 22:41:10 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id y141so3629863iof.5
        for <iommu@lists.linux.dev>; Tue, 20 Sep 2022 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BXZcT0E7Jcc0vW0Dx7kPuxWsfI+ZPqAybt6l/VMr1KI=;
        b=ebT0WQQ5Ujpx59vwyT50M5q2rqtt/BPqShL1yERo5xwrUFKiBLy9XEV2Owk7LpSBNy
         4bwU1b/JpyL7LDC9BwPBHa5OUNozbPINErat9wBD9K6VqONoXjOGK1MrJjrgk3OyaK7n
         81mempDCiN5b0GddHkZk6D323cGvAZ1OQpBUKYLTV9I9717YmktrX8tBSX3T63clu1Xn
         XF5WgnH5n9wARfqL4prk3neF366kxlWhPMgWtntnTuZPk5OENXAWvOyYSivBFtMkTT6U
         HvnfEz6msRBEZj41pM5aVWvsIyyfCQyhDDRxUtvZCH8Z6ZyvL6Ha06TjynkECwlKIaCK
         2rkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BXZcT0E7Jcc0vW0Dx7kPuxWsfI+ZPqAybt6l/VMr1KI=;
        b=TPtKF8qj1GVCoqKixy6785LKVZnnAbXkCKp0kbFYM9sp7OFGAJvoCMmNoRPF01qfVc
         0VHGk8lyZh9tPnH9lDp08deg+Zsmrg+QO80pjShKGpG5pgxYVXVRGSY60HDQgchurKLu
         1hF4RPJWNp8yJA+dWdJoxk2e9hR435vacMro7Myx0Gj3+JshQcJD7g2w/Wi5VsjytSx6
         t1FW/2HTvE9idjlmelpMwtnB+MdUExm6EMMdR7BWUQmAZRWycP4d5OKkBKVp0g/ub4Ku
         TVcWCpKo4Eg7hDWu5ZLwMdEmWEXpVC/ltIcNOH7y9K2T/kLIZamjjuRce8pmv63Gd/g3
         CfTA==
X-Gm-Message-State: ACrzQf06ZGTSB28wTkngl/TJneKb7wviUlJUWQcasODa9AVM92EnXz1+
	Q56EkbSltOA/VRVeApCdDFM=
X-Google-Smtp-Source: AMsMyM7NkZzTh0GRIEY+1f9ui/U2uufl/iyIvknAsND/nMHbPXS7jDpvdSDmPBzieXbh/etrDlVQnA==
X-Received: by 2002:a5e:c819:0:b0:6a2:ef12:2f1a with SMTP id y25-20020a5ec819000000b006a2ef122f1amr6980737iol.133.1663713669646;
        Tue, 20 Sep 2022 15:41:09 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::a533])
        by smtp.gmail.com with UTF8SMTPSA id x2-20020a029702000000b0034272baf43esm366081jai.168.2022.09.20.15.41.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 15:41:09 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Rob Clark <robdclark@chromium.org>,
	Sibi Sankar <sibis@codeaurora.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 0/2] iommu: SMMU for SDM670
Date: Tue, 20 Sep 2022 18:39:54 -0400
Message-Id: <20220920223955.151507-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the compatible string for the Qualcomm Snapdragon 670's SMMU. The
SMMU is necessary for GENI I2C, included in initial bringup because it
doesn't need non-trivial patches except for patches conventionally added
before the initial device tree (global clock controller and pinctrl).

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)

