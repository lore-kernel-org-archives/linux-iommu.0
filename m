Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33795377
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 13:31:56 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50078e52537so9505088e87.1
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 06:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525514; x=1695130314; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aby31Dy3sRvYCseJbVFaOLlk+QjTt8y5N0c9zPR8ufo=;
        b=DED0E8LY2aOc5qGDZ9BQMAKODwOs9XHlR2l/bTeihzPjdbTwFHa0Sv06TJ5cfjZRJ0
         prrx6d7u2+TYS9FqGyfvo3m/qNYPo20YA6gQD3Jx92gdnl9P8c3K+ByH/WtiI1JNptmv
         9KcLInuGfvnS+ePwVM3lZhVXjjqambywA7Kkgzlu3mYNg/w9t1xNTdoLZeKAamv05or9
         zVbzo6GUbd8vAtBSG4f73Pu31ndR5Mg1j/hlVFa/lE/FhBFkilrkdfa6YOf5k+gk5RZL
         lMMzhFcypejDyxyxMoSYqNkr7RJ2uDuV+qncrCOZ9Qq4fskZHmInfLDBqUwcrgDldqzs
         b6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525514; x=1695130314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aby31Dy3sRvYCseJbVFaOLlk+QjTt8y5N0c9zPR8ufo=;
        b=QbsXZP9XoLdvPQLQnWYu4hHXFZEKIrPl2RRS7E0IHIO7JZTmXAROpFp9f0FVjpvvZD
         hW/7FDSUDkBdt9MGqJbUwuFhSTLPLl8YVY6B4hrFWVBE7cHC5SO8RDoC/ppWTAv7byDn
         jDePz6soQ0LhRTz01pLgIYzd7dGBjEW7Ti53sUv8R5iIfwznh7UOSo6sMxSPmFGfi7ci
         ZUlDctoO7wmvtk6CB1X7n5fnB64AqQzInt6I1i+g3PTNqunHAMFczfiJNoJ3uZSvkU7E
         7rwoiqOvOqvaPBMPOBo7a98E7zl+lVFYNYsvd/lTuevfjCUMz/LHvtMbaEosRcuafhVb
         qWKQ==
X-Gm-Message-State: AOJu0YwQ4FCJDq9a/xpe5hp7PvUIavSMupiDAPUsFgyF2pDCplRww6/s
	CWyzl5uFlT0WBIBUDRJdMs2L5w==
X-Google-Smtp-Source: AGHT+IGitYmBkgkDWLSUP/hqdunkKg4+XgDzDLG69n03cDAVQWkDehzLwjYkdh+olbp2hd4+BN7ZaA==
X-Received: by 2002:a05:6512:3082:b0:4f7:6453:f3f1 with SMTP id z2-20020a056512308200b004f76453f3f1mr12382111lfd.15.1694525514362;
        Tue, 12 Sep 2023 06:31:54 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:31:54 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 12 Sep 2023 15:31:42 +0200
Subject: [PATCH v2 04/14] dt-bindings: arm-smmu: Fix SDM630 clocks
 description
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-4-1e506593b1bd@linaro.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
In-Reply-To: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=1204;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xOXLCwUDc6wbp5lgmZN0L2nK0COMDmBWvidVIRQZaEM=;
 b=9rLnt5RKSrJMRFdngo5FKCbjpslTV8Cgk2lRTkIJu0MXN2kamhiEW4QKh2iqUto0uklN8jmmB
 RJYZYYDcHW/DK8tejnqcKw+w+Nc+bm6mUhq241rpD7dt2X/C+0XTq7z
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SDM630 was abusingly referencing one of the internal bus clocks, that
were recently dropped from Linux (because the original implementation
did not make much sense), circumventing the interconnect framework.

Fix it by dropping the bus-mm clock (which requires separating 630 from
similar entries) and keeping the rest as-is.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index cf29ab10501c..b1b2cf81b42f 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -270,6 +270,7 @@ allOf:
           contains:
             enum:
               - qcom,msm8998-smmu-v2
+              - qcom,sdm630-smmu-v2
     then:
       anyOf:
         - properties:
@@ -311,7 +312,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,sdm630-smmu-v2
               - qcom,sm6375-smmu-v2
     then:
       anyOf:

-- 
2.42.0

