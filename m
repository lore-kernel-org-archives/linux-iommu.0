Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220DBB677
	for <iommu@lists.linux.dev>; Sun,  3 Dec 2023 11:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FOaBNh+v"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ca00dffc23so1255911fa.2
        for <iommu@lists.linux.dev>; Sun, 03 Dec 2023 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701602799; x=1702207599; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRBX9qjaYScewEyAGN3ZWpm24vfD1L73uIHC1C0KO4Y=;
        b=FOaBNh+vRFN9esZdmrCEk8MNzIcu3S91vxTS7IsxkWr3sxy8tQGd3pdV5euV435ZSv
         quhqO4STzxCafgNv45jBZqGnnmbU2lZx4zv1W0HZhEh3CL1FG5r+eQC1h0sNlHa4EFo+
         CWNo8JEuk8rdtve+QSeFuYBNCvc+jv2BolIPENXvJtE3RH1wgrzDPhARfNf/p52njRo2
         FLfEp/exGZUv1Wt1UEl7U7MHnfkpKDqmI+iD1jJzRHMjZNILX5irATDYHCSaj7lTNIE1
         YOCls0VtgNW2S2PbTA3xlpw+wiG2EE7gn27KR3L5rt7V1z5RJfIh/CCjZ0PMCSj5cVC3
         fevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701602799; x=1702207599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRBX9qjaYScewEyAGN3ZWpm24vfD1L73uIHC1C0KO4Y=;
        b=msd+ZS2VjkENgztfQ4C5lC2zgdHdtTb95wtGHvFQSFkk9xexAS5FjJW1Fr89O3ewmw
         +gENLJMi7o3WxXZgLt9yQgCqPxm1M6OEOxr2uuv+n6NLwJRcSg5UdlJZFZcK8HTQGqa7
         kr3JiLDkiFA6wKgBBjaUcSMSkdQ3331XknpnnCHt5FOijxq7a7vSAlRjIGEJTjE7jUlb
         2KIwjPP1N4KjItYlaaLF/QYi1kfGhbunetI1twpDBEnv9rxdSK5KyI8ID4Qn35/M4G94
         /M66hrYmEDBQ8Mt87pC71TVv/TfXiWlc7lm+f5kFMrlSCKhqYGY2bUTFVBf/gMS47Np9
         dI8g==
X-Gm-Message-State: AOJu0YweNcIP5ga8wq/Hx40jqAusQ7AxOpBUHxDGvNhiJjWxhQVkz27d
	vl1pFg6eW2af+46eXG8+P9wl6Q==
X-Google-Smtp-Source: AGHT+IEo2kVrDxKWsLCcwvE8hl19v/Tnab9g7q9epanULPqx4nYnbkuhxAF8ZygQf6iwFdwfxMYOiw==
X-Received: by 2002:ac2:442f:0:b0:50b:d764:6e9c with SMTP id w15-20020ac2442f000000b0050bd7646e9cmr1980872lfl.76.1701602798822;
        Sun, 03 Dec 2023 03:26:38 -0800 (PST)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b9-20020ac25629000000b0050bf01760a1sm241224lff.295.2023.12.03.03.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 03:26:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Loic Poulain <loic.poulain@linaro.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <djakov@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Robert Marko <robimarko@gmail.com>,
	Das Srinagesh <quic_gurus@quicinc.com>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3 00/12] RB1/QCM2290 features
Date: Sun,  3 Dec 2023 14:26:23 +0300
Message-Id: <170160265544.1305159.7127586815591334441.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 29 Nov 2023 15:43:57 +0100, Konrad Dybcio wrote:
> This series brings:
> - interconnect plumbing
> - display setup
> 
> for QCM2290/QRB2210 and
> 
> - CAN bus controller
> - HDMI display
> - wifi fw variant name
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: display: msm: qcm2290-mdss: Use the non-deprecated DSI compat
        https://gitlab.freedesktop.org/lumag/msm/-/commit/25daacc60394
[02/12] dt-bindings: display: msm: Add reg bus and rotator interconnects
        https://gitlab.freedesktop.org/lumag/msm/-/commit/a1ed5860efd3

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
