Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE20517591
	for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 09:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988835; cv=none; b=MNz9L4qoB94MtSn1CbEyyfOiMDPFUYlKqt8DXTYLAAiwIuz3Gz5xkni86ukM2SvpPT9poHq3xT1k22OiGcoE9FYUvzN+18hadyoopgEle85zwrGAn6iWkLIUzF18DUMmc9MOuSb9HfZ89DNnK1GgjSI7C+sfWzmCQTVJ02yrJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988835; c=relaxed/simple;
	bh=QCkz/HAlxsbVXDc+FMCgFBx5P0nVAWSA4UynpoVJyfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nlkl8I/eq9lnxzigl4KhLpdxYg6+D2N4pdF4d0nm9kNNS4TxDKteggKH9F5gatntc2X6tfLjgdHRMd7uFJnS5PjkWtZAN1yeQF4ub7JiKQz7oXufAk2eHRRz3HKQPfuGxDQI4lwHNUN9chHus8SAWgYyU9yOcJBWQaaT6WeHOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F6BALh1R; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F6BALh1R"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d090c83d45so7788171fa.3
        for <iommu@lists.linux.dev>; Thu, 15 Feb 2024 01:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707988832; x=1708593632; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RMgnrHnFvnkqmQ/HYz89uTL6/4/6fzEmMqCiEApO7Y=;
        b=F6BALh1R4vmtyQEoTqa1qnZHq/LhzYSkFVS2Dt1PNs5dkIFyTnzQ9kfJQlIFd5XrxH
         OZJassbaZFi83TdHzqx3gcZUTU3+hjXLFlIR8ERAGBrw6H2UvF1nTBzHtL6EV0uLezVh
         YXD9sE0jw5R+2VTpAix8KMr1PMYLkupQBV5uyk9aWX/xiCDpmCgPkdEnrXR6bAZuiM7s
         qpDGHVPQN9C+wmuD5u64J+/BJIG6Q/q5z7mhZLDSvHaJHfB6UXxX8wOK+hDGWvdRFCOp
         cF8Z8rAvEoKw8ZojUgFIomPsCitGZsTcVeUllMj/5LDm4rlNIB2iPH0OQhWMnyuqsks2
         xnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707988832; x=1708593632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RMgnrHnFvnkqmQ/HYz89uTL6/4/6fzEmMqCiEApO7Y=;
        b=F/vXkCOakrATlSj4XDUuZm3tG7kTME11djz7Vy26LhgZhOw6nxLepoft9yWao641ay
         U7SIlrwiSscfU2z+szqbusmexxAArJzn2WgRQz8WvwKdK/ctn8KpUl75UqFGCegG74Jb
         POepnTMvv8crkEDkQgl1VvrowPvkEN9z1+u7ywia/suJIq2H716yJ52ZgOoZMPc3xsDH
         ctSDmfln+NpGxSLx4iEPahzpvv7qo7oEBTETBUjC0mqQwh0Wnq7CdTj3qPuTxEDq9zUe
         sRIuj53WmBK7vTAHaEDaoz1miOi5nwJSLGAtpE9ZgshXolcFgqOJVMg5CSltYWNsHRy6
         rKaw==
X-Forwarded-Encrypted: i=1; AJvYcCXf68gNrJHnq4dAQAA6MlJViGTfzEop4u6WMsHnSlvQN0tbyaH/SuhURHam704TYhr49ZR8N+46gyg7Vz0g1wGbtIR1emE=
X-Gm-Message-State: AOJu0YyAIPw67RP4QUCyX6NR+kc63fq0gEJDbBE9A9bmXBG7JU7YBmbq
	vAxskNEoxwzHBwiZZ0fOul8gSWEyOtpL7HW/jJNbPdZd0IGSXp0iJNNEUMcVC+8=
X-Google-Smtp-Source: AGHT+IHjoLYwjQO2evmWDkGzS21OU9pSICDlRxJhWfQtTk/vibTdzci6Q9CTyCXn5Ys3Glr07s+Xqg==
X-Received: by 2002:a2e:a1c9:0:b0:2d0:c308:5f6e with SMTP id c9-20020a2ea1c9000000b002d0c3085f6emr771443ljm.44.1707988831872;
        Thu, 15 Feb 2024 01:20:31 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id l8-20020adfa388000000b0033b66c2d61esm1156435wrb.48.2024.02.15.01.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:20:31 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 15 Feb 2024 10:20:23 +0100
Subject: [PATCH v2 1/6] dt-bindings: display/msm/gmu: Document Adreno 750
 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-topic-sm8650-gpu-v2-1-6be0b4bf2e09@linaro.org>
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
In-Reply-To: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=799;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=QCkz/HAlxsbVXDc+FMCgFBx5P0nVAWSA4UynpoVJyfQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlzddasnMca9nUPOla3cwN7PCE0JduOPzXxA2qqUzW
 e2kOVoeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc3XWgAKCRB33NvayMhJ0Wj9D/
 0RrWe9Gn5RAb867YZH0V9YAQVDSuc+HT6lV+Agq2y2GLHtzIvXJ4JsruwNsmuq+ZqPe2MkIMFnx+/X
 MjUYuej5kzmpVhL6yKUf8hm1MGWPg603I+yQpGGDbRtv/LMwkXU/25tTDKJVWNA51megauxy0xhMcE
 iyNW00psGC5hAqM8sz7hoIfgxkH3en1jUV1FRO/SqwecGflASYiAu3ipm966nrm0+slYNljFvYHhfs
 KsfSSCFLpDtSF32DZxeBvCEXlqWpZ0iatAC16NfWMcxvwnVDRC5Uvg8zZ2cjXR4HJCH9UG4xUI5MjZ
 5R57NvkOFIENTbZlLisDk+KCJrKjwxia2SYeIXvSAt8tXtRC0ptAu8nAjQlukMpigIoz3qwnDduS0x
 Xc7RSPzhVpLd7nayvRfGvqKGJrpoyQYQXCK/WKvln+fVnOJjKCkxJW0OSBSIIXl7s4CUpLU8PNhRiA
 0VGRhC7l6fpzGNMKk3ROgQ7IEQIJpqr/Sk0HtuobQh+a8hid4CV0EDYZylLf7neHtwD2dIK6N8WML6
 tTK8CC0A0vJYJOUlYuSfXlQU0F59EBeq8S+5xUI+nLMsVPaOr74uQjXV+uXpQdemascqVz3dWudKwF
 MJat0Wecksh1yK/yjz0ofkVSRa5Bdv/rpEx2JhojBfqBnGuGL5yEJp2AMPQw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Adreno 750 GMU found on the SM8650 platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 4e1c25b42908..b3837368a260 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -224,6 +224,7 @@ allOf:
             enum:
               - qcom,adreno-gmu-730.1
               - qcom,adreno-gmu-740.1
+              - qcom,adreno-gmu-750.1
     then:
       properties:
         reg:

-- 
2.34.1

