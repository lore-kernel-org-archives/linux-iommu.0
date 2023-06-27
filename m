Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70641ACA2
	for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 16:25:01 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-4fa16c6a85cso4820124e87.3
        for <iommu@lists.linux.dev>; Tue, 27 Jun 2023 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883100; x=1690475100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q33POZnKUnc44DnNl9mQs414WVdMBUFcIaqMk7TwHgM=;
        b=QYqAGssgz0Eg7BvDE9m0UQjkpMaZujlgUxNELGTmjD/MUVciTwQqEoa6l1YospPYtK
         9RQXvrhYxwr7/oTsoUsYNvG996nx+nOAwJU/4w7mkXKc1u6gCJODyPi+N1RCjTrUBoHT
         G9iqKDcKCSr8Tp5OT86Bf+Sbj4Ap0iFnrDivV0NFWY6HiPjy/vysASuy3DssXAjL6Q70
         NtJaI/MD19Zj2FiWLhrRuLnqPI77AqLWTsRzGQYDC31x1m0Ov41R9rnU48UkL1od+hXN
         gO3ZFvK3qr6OjgPRkphBhwnN7jzLsS3vm7o/d+TSkeXLXX7LBCXRe4l46p6vNfbq2Kzv
         5Z/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883100; x=1690475100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q33POZnKUnc44DnNl9mQs414WVdMBUFcIaqMk7TwHgM=;
        b=FwWNIk0+ftp44dKcf0QXV30u2ALDk9jdzQq6FDf5xR/GPWYT7pbShh2Q5PkX7+M2bH
         89DC4bcZk5lJdp84DOSg3vcRtFN8g+i0aFGf+GS/epKLZrBMrjY7tfm9+nKD78KPCz7x
         U2SJ1O/HOgHFjI3tj3VnFzJbTMkVN+Piw4ft8nMdJBdeUmSOzXgG948gXsv8pjtWd1qO
         /+jLiftucx77154+tfulXi5Gc8fOeJn4+oaLF1lTcKcwFKeCvVCWsYPsQM8aYrxpnzNI
         qqPBePZisshGOMKCrt9dYtmYw/aXD02RClj9eXK2+Ng93+y438eowqrgPTn3yPlDEu8W
         XJhQ==
X-Gm-Message-State: AC+VfDztqeSIhqoom+aKopxCEiQktY+xbTrvUN4qQ4tBUxe30ptU+l3z
	pC2Eg4q+WcGbMMZg9aqquWe0MA==
X-Google-Smtp-Source: ACHHUZ6CFt+d+5Xq/e+nMds5v3rJtmCSaJmgAZcrHw7TSi73DKGhsgqOetWXrvYdZglDMZM5e2B0FA==
X-Received: by 2002:a05:6512:3d26:b0:4fb:89c1:c209 with SMTP id d38-20020a0565123d2600b004fb89c1c209mr1281822lfv.62.1687883100008;
        Tue, 27 Jun 2023 09:25:00 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:59 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 27 Jun 2023 18:24:25 +0200
Subject: [PATCH 09/11] dt-bindings: arm: msm: kpss-acc: Make the optional
 reg truly optional
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-9-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
To: cros-qcom-dts-watchers@chromium.org, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Benjamin Li <benl@squareup.com>, James Willcox <jwillcox@squareup.com>, 
 Joseph Gates <jgates@squareup.com>, Stephan Gerhold <stephan@gerhold.net>, 
 Zac Crosby <zac@squareup.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Wesley Cheng <quic_wcheng@quicinc.com>, Jun Nie <jun.nie@linaro.org>, 
 Max Chen <mchen@squareup.com>, Shawn Guo <shawn.guo@linaro.org>, 
 Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Knecht <vincent.knecht@mailoo.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, alsa-devel@alsa-project.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>, 
 Andy Gross <andy.gross@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=947;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=wt3diYHxaifCvK5Xl8Y/T0S8CL1BVeC3ZMzX71Qv7t0=;
 b=LUZZ9rw1io0j4EW3EhtpAO7GnVfigJDEYVe/+eZsBuOm+mcYfTwRC4+7VMCWlKK93ARSOPAoO
 RkmO+n5mJD7A/i1W37MwjkK+vgktyNsi+MknPe8Bf8NUXAKU42wjmD/
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The description of reg[1] says that register is optional. Adjust
minItems to make it truly optional.

Fixes: 12f40018b6a9 ("dt-bindings: arm: msm: Convert kpss-acc driver Documentation to yaml")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
index 5e16121d9f0d..75b6287db2c9 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
@@ -22,6 +22,7 @@ properties:
       - qcom,kpss-acc-v2
 
   reg:
+    minItems: 1
     items:
       - description: Base address and size of the register region
       - description: Optional base address and size of the alias register region

-- 
2.41.0

