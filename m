Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220BA1C296
	for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 10:16:22 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59c0a7d54bdso100065737b3.1
        for <iommu@lists.linux.dev>; Tue, 26 Sep 2023 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695723382; x=1696328182; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uIEc9U4qkmacD4ETjJlkL/nxFs0U5+wCxL+ah5n1/b0=;
        b=VFymtjFfONqVaVNLTZP9NsKrOVEI7LbbWht8+EkUiJqxDhFOg0jJhzlRtURlqM5wtx
         mfTBrTaHWanKI6A8sidyHfN6ewzgB4/GnXEnRtwq07Boso9YcRB6zgO84wZstlIiQwi6
         LyzybI3b3HfFvgeKPT6A0Z/XjlpyTIcjiOI2dZaR+2ozHpad9EcddGmoJLkUwGE+OV9j
         w7Rm9mHeQAsq+x9dEA1Jbcf9MlE6WJVXmYpf4cCUGNsr8RjVHu1/Y+pi67ELTceUFWQt
         DdZoG7uPLtb56mRY5wMdOAA+Kyoz53TQb4qOblLfX9ohsovseeM/NPazNQm9xJ71w/tS
         O0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695723382; x=1696328182;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIEc9U4qkmacD4ETjJlkL/nxFs0U5+wCxL+ah5n1/b0=;
        b=PwCWISF3ppYwzZbQnJRdWUDsrl5q8LNlcO69cMTRi+L3+Igeqrtt/ogT6h8drgo4KS
         GiKnsXEs0wEfhxx1S+WaqwSITXN2PwCHYGbD11hir05FEsbxiP3bpCMYqdoSKHOqEPi2
         G1XqseBm9438TaxkiVefdH/Ecmx1b36PHHts+ZwyBN8f1sjMVMuGC8AUOHZ+V1xPfiFy
         wQeu3bAFtS7Z1bMxIUdTQWXA0JqJ8vvL4dA7wQPTELeaKyoSUxy+wiLqcLK2KZzFr0XT
         BewJ4Ihgc9fPwIetazaZ2SmlzbUI2IHazrG/PmDqX6tojnKqWcNoWyI9ZyHuyPHIeyJA
         ZhKw==
X-Gm-Message-State: AOJu0YzE5VBwJQzPx6VlA7vbcpSd9VN7tQhNqgSPuCXFXRiNgaZgc17B
	S5Mbsusl8aUBXsamV0+a96DZtm/0Fb+NdjmGAFoOCg==
X-Google-Smtp-Source: AGHT+IFK7R88h66d1jQKQxdjg4tKF4Eq/k+Koio+Uk+xN6IaDTtvM7jHZmp1EX4bf0/UrOV2kPrLn5Xhz392Fo4i9+8=
X-Received: by 2002:a0d:d58a:0:b0:585:ef4e:6d93 with SMTP id
 x132-20020a0dd58a000000b00585ef4e6d93mr7956133ywd.47.1695723381975; Tue, 26
 Sep 2023 03:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230925234246.900351-3-mailingradian@gmail.com>
In-Reply-To: <20230925234246.900351-3-mailingradian@gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Sep 2023 13:15:15 +0300
Message-ID: <CAA8EJppe_SPs--_0__VrpwuzMXypE++eUezR3zibkzBcc7GaaQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Add SDM670 MDSS compatible
To: Richard Acayan <mailingradian@gmail.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Clark <robdclark@chromium.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Sept 2023 at 02:43, Richard Acayan <mailingradian@gmail.com> wrote:
>
> Add the compatible for the MDSS client on the Snapdragon 670 so it can
> be properly configured by the IOMMU driver.
>
> Otherwise, there is an unhandled context fault.
>
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
