Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEE1377
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 13:32:12 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-522dd6b6438so6813538a12.0
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 06:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694525531; x=1695130331; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxtccacpBwGixpSIy230e0q5PgRxGFascOoiViGLP3k=;
        b=YJxHnpS5LnJSVAjbWxGjyrS+FCi3/0huL+wAQkLUnW57RlT6iELC5OdPEu7gKeqlLe
         J3/uJjHcW3atq1kxs2Z/WY0nBfy1csOyBqYhnfcDo4vXeO9Oa2lvgubD0mlelAus8KXO
         4nov0F+gFjCqaUHnpGOSJtDoEXcDXdByqLd76qm6SqoZ211ElJ4ndiv4xQR3KfnCw5uw
         f3XEAkRZoRNNClbgHjE3MV/AXOIWfOKjgA3S29LGNCwjljrjv+8IjPC5bBKnyQj/56C6
         dgOh2N18pPXvB7EAhLfggu594KXwWHqfKgctRL/JvT3h/OZ7fv02m7Py80Lz5dQm7dVo
         +R1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694525531; x=1695130331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxtccacpBwGixpSIy230e0q5PgRxGFascOoiViGLP3k=;
        b=QlQmw17pgaDy95g6yAoVZBqf3NkDObGQs+C4uggtD8mNkuqOtoICDVh+2AQyRWq9WG
         QB7AO2rWIubHqbN1GU6NuPFekqI3XYGHmxmgkqh+HcX/5tAjXsGkRaZD8u0To1xe5gyz
         FuFAmHBewgyWwjC6SPHG6nTmob58JQ1Uc/H5d6m74ba856xb7sU5zYuor5vFsYT2eypK
         1ZdfNvBGHboQVgK+iwBv42zc/LIQV9FS7ylS9zQNgbwAEOrADZIK1nIA7xV4OvQDxM/+
         Y+1bXwi69pWL0mLjHsLTkjwwpucUiMQNuuX2ln5RSPQj9S4a8ScDEYhP/106MMRIsGma
         EWXQ==
X-Gm-Message-State: AOJu0YxamnmUJfpPFk23IFvrKFaJfsHpoorZ/uWmHEwUpFee36DsPajz
	aZSuiXKxjvIPBtDyDPg5+X4QyA==
X-Google-Smtp-Source: AGHT+IGDdLlH6QMNo0LesrvW7tqQ3UhLo5jMkBHR5ISm+pmrwc0Td7mwqYE6zY6eveDY64WIEHBQDg==
X-Received: by 2002:aa7:d508:0:b0:51e:ed6:df38 with SMTP id y8-20020aa7d508000000b0051e0ed6df38mr10476262edq.13.1694525531150;
        Tue, 12 Sep 2023 06:32:11 -0700 (PDT)
Received: from [10.167.154.1] (178235177248.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.248])
        by smtp.gmail.com with ESMTPSA id j2-20020aa7ca42000000b0052a401d8ef6sm5983830edt.71.2023.09.12.06.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 06:32:10 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 12 Sep 2023 15:31:49 +0200
Subject: [PATCH v2 11/14] arm64: dts: qcom: msm8998: Remove AGGRE2 clock
 from SLPI
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230721-topic-rpm_clk_cleanup-v2-11-1e506593b1bd@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694525501; l=889;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=APDJWKGv0OM8xkXbz6kn7MnEY9F1MTCZxMvBScddrP8=;
 b=fm7ExDvbRT0Sd/IS/guUrW0VKUsM5an7PF7RCJbaYOVZf0humdCmaqSivS8PZcBVQ8jHJJVQP
 gaA9Ee5eVxDCUutCLYzu7eMoDF6RCNm3MutO/ynMxiuRHlPqxZGgrxS
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The AGGRE2 clock is a clock for the entire AGGRE2 bus, managed from
within the interconnect driver. Attaching it to SLPI was a total hack.
Get rid of it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index f180047cacb0..5667ffa83ce5 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1618,9 +1618,8 @@ remoteproc_slpi: remoteproc@5800000 {
 
 			px-supply = <&vreg_lvs2a_1p8>;
 
-			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			clock-names = "xo", "aggre2";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
 
 			memory-region = <&slpi_mem>;
 

-- 
2.42.0

