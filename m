Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33C10EF
	for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 10:01:59 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id i2so8188196vsc.1
        for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 02:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCDOO4VPZC6I/ow/QnYvYYMpSXdiSjKaJtZIVyZxvEE=;
        b=mOtdqjcN2Q+lYcbuQkk+7XmEkdgmncgKTiCt6qcnIl9LxKIyrA9C9+kYAYYGX3Iq3b
         6JKV2CH5JjzySELSxzFzDkXA0/qzGraNPEjqOCNTaqSteogolPKnnmO1NBOZoHwGzQgs
         ptI9YgvzV13kcdXChGr0YKpidltW4SSG67y2STPnCLdbED+CJy4hT6R3657k6ji6DYPb
         JTjtNbBcBH5D09ZfJc0LkL/jd/kbtj40S9T7fJfvGAQAInlBHLr6+7fbhUcJ0M7zzgXF
         a91M0M24p25GDDYDRbm+qU4Vp3ikeprcRgzhGfokpCInUx58z3HNWedmoqXF5PKpgpdB
         1dJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCDOO4VPZC6I/ow/QnYvYYMpSXdiSjKaJtZIVyZxvEE=;
        b=myUfot+TOi5koJwbOmQJBKVyX17Clnpjty7Cxfk3rQZMe89A5X8BNj57T1s+tO6XuJ
         UbAt71GoOIuhDdo+irBVYKM10E7412kDtMHbzmfAtC/dERUqarTK2rBd1P9RMe7fRUHr
         iZyjUYwTwvpG6PsMWPiO/WxiVv84vZIfZqXr5vJDhmel3e8q7tgPOBXYGYsfj/gwMYOG
         UxeuDVdpGKn8++kh5at0rI4zlqHUXIiu5EnTvUds3WIWCOJpK4sN1+Lw+/U1lKko0h1v
         133zaQ8EbiV7YoyZH1eSdSDP68p63C+j0fUuUYiaJPJtO7YdhBnhHQxxAwiG9ocEVCaT
         66RQ==
X-Gm-Message-State: ANoB5pnq1h8iBXHXaCh7jME4TakX1RNwxf3dIS6FDZbN/Qc7aynVbmmu
	Bo8feibWFKL7FgNlzyfjueDh3Y4rzc9/Vils6xM=
X-Google-Smtp-Source: AA0mqf4ROgAqL66e4a/+lmlVndnHpc5y+QPZsBm8wwkxvClIFBYSMaQfW5JScMW2tffHoRiJQd70LauX0BVgg7SXON4=
X-Received: by 2002:a67:fa8f:0:b0:3a9:5a1e:ffa with SMTP id
 f15-20020a67fa8f000000b003a95a1e0ffamr41970859vsq.39.1671444118071; Mon, 19
 Dec 2022 02:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-6-iskren.chernev@gmail.com> <9e94c0b9-f901-5ac9-2abb-40e958cbe5a2@linaro.org>
 <3134ba66-27bb-7015-8988-6c8dec046b0f@linaro.org>
In-Reply-To: <3134ba66-27bb-7015-8988-6c8dec046b0f@linaro.org>
From: Iskren Chernev <iskren.chernev@gmail.com>
Date: Mon, 19 Dec 2022 12:01:46 +0200
Message-ID: <CAL7jhid=inAk85h9tHOD6rjFc-aNufvZPQw3ALfsrqTm6oHCag@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] iommu/arm-smmu-qcom: Add SM6115 support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, Adam Skladowski <a39.skl@gmail.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Konrad Dybcio <konrad.dybcio@somainline.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Emma Anholt <emma@anholt.net>, 
	Rob Clark <robdclark@chromium.org>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> So, hopefully you can skip this patch completely by depending on the
> generic "qcom,smmu-500" compatible.

To be clear -- I still need the qcom,SOC-smmu-500 compatible in DT and
bindings, but not in the driver (i.e driver will pick generic)?

Then this can indeed be dropped (but it is merged in linux-next ATM,
6.2-rc1 based next won't have it, I guess?).
