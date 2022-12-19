Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0A77E
	for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 11:28:15 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id 192so9090010ybt.6
        for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 03:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VMzRLzpincvsgDVrWJjWjP9c4+ebaH5xlefFAGcNSZA=;
        b=DMVPFm0Qra9ZvdI6GKXI+xlvwdbT5lwLM8UR0YOC5fSQbwHKk7RntvaxLgWFASZUJe
         oT3TvPOVWUVCYvbvqmplYlrGXZfBUDnlyOQ/sD7QXyaYJ2SaDr+a9Ea7GVxpceseaHdF
         t78QI68S8jMNZqs8bs2zDXosG6U4O8hV/YvQFqnBdgesha7r4NqWJ69ZbDDbicDWC0eO
         flxfn+AA6g8koS4YKFWoq3x3PL5+mG+/+Mek1UdKpzt0LlXKBmDzQK+8Zw0hiISX1Wi/
         mVGMxFrBL812p0tNTD/JHf8iUFfWFztY5Bjuo2JOyW1GAowqmvez/cwZMxjE1graAlxZ
         HHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMzRLzpincvsgDVrWJjWjP9c4+ebaH5xlefFAGcNSZA=;
        b=clLnwF8vz7kOQuWrk2iXSVrP9ObuXiXR9bCyt2qJLeXTz9AAvTjE1vTvn9MxKit7Y8
         8dxmAXMK93J/2BPL2dEmuM4Pm9CmGH/oQu5shAfdAyry1IS4VRaz9XD5SaMdAZnMepe/
         W9VLS+WIz1TTJ5izNppEHhU0wOK/pKns9mXqSvjgjLJrXQNjqJiL1xMQLQ0JqagVvrRu
         7oc1gbjNrmN5LyrfU9lsSmSjHePn3haz/C9V+MAIvEhy8ZPM/Qp4hKPQETq7Ty+RKzhE
         ELiJQEtP38+khqj4BKW7Kq2L1H4wdZiyxZFqLupA2/HdX4V48/oGvGAVLETiecdIa5e0
         dcSw==
X-Gm-Message-State: ANoB5pmq8xFpblEio+ZEX2VFwmh5iXMJp0Vf+BxQhynd30Gt1LtDRoX9
	9fvbmTmviTnrSYPrFnfhcL2jTGrH92XhPByEmOpbiQ==
X-Google-Smtp-Source: AA0mqf5rJm4+V2jdIAc5ils+CtzrRHnCeWU83mLN5tiYq2OCzVIN03D3XQasvpS35GJdyTd4AGBBoPofWN2Kt+wpZTk=
X-Received: by 2002:a25:8544:0:b0:723:5b57:cde9 with SMTP id
 f4-20020a258544000000b007235b57cde9mr4351163ybn.194.1671449294770; Mon, 19
 Dec 2022 03:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-6-iskren.chernev@gmail.com> <9e94c0b9-f901-5ac9-2abb-40e958cbe5a2@linaro.org>
 <3134ba66-27bb-7015-8988-6c8dec046b0f@linaro.org> <CAL7jhid=inAk85h9tHOD6rjFc-aNufvZPQw3ALfsrqTm6oHCag@mail.gmail.com>
In-Reply-To: <CAL7jhid=inAk85h9tHOD6rjFc-aNufvZPQw3ALfsrqTm6oHCag@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Dec 2022 13:28:03 +0200
Message-ID: <CAA8EJpop-xO3TJgxHQ7PRCEi55tQNEM58vbOsKwjC_vQRCHtqA@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] iommu/arm-smmu-qcom: Add SM6115 support
To: Iskren Chernev <iskren.chernev@gmail.com>
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

Hi,

On Mon, 19 Dec 2022 at 12:01, Iskren Chernev <iskren.chernev@gmail.com> wrote:
>
> > So, hopefully you can skip this patch completely by depending on the
> > generic "qcom,smmu-500" compatible.
>
> To be clear -- I still need the qcom,SOC-smmu-500 compatible in DT and
> bindings, but not in the driver (i.e driver will pick generic)?
>
> Then this can indeed be dropped (but it is merged in linux-next ATM,
> 6.2-rc1 based next won't have it, I guess?).

The thread got bumped in my email client, so I replied with my review
as if these patches were brand new. However I failed to notice that
the patches were already accepted by Will Deacon. And that my rework
happened already on top of your patches. So, you don't have to do
anything, the IOMMU part will be a part of 6.3. Please excuse me for
the noise.

-- 
With best wishes
Dmitry
