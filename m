Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53A01E5213
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675716; cv=none; b=W0aVTmauPpcmDMnvqhgkogtGWnBcytkPd3EwUmIvX1dhmxyDCW8IL+GacvrriT82ZhNstNNIv3MECPF6Av0wK0CjDOzp4I+HB5gqTwLOAmKzchpN5hIJyWMfdzP9+OGvrxd37gKd9+jzBlNBmNKaZgU/0IVxoYQy/BFUxatpHJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675716; c=relaxed/simple;
	bh=b5WU0cXHr7v+e7BT5Ibw9679ejdgncNvKBhfc/UOLmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVglqlA95aNByRXw90UD4OYhlcXwwclhwA13H+Ht7WiN5wOQ6Ady3Y3qTpuE4nMr1PsEbkF6cmqlpxfvih5u8xDBOyIdcjVcLvFuChWYP4RyXS2Q/tNzxSdwcI7w+WMYb1BKxBwLAITh5wiLv6Phbt1wd+AHiZ0xJc1mVFghBC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I46cTFp/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I46cTFp/"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7481600130eso7567346b3a.3
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752675709; x=1753280509; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRgANhiZNBnDfTk3Cs6H1fGZwr7ZYCqusPX7KWdZOuI=;
        b=I46cTFp/7SQvBEr+D/Jg2m8vy5KfzVTxAQMpGc5JuBWFksfAVsotNG7rBZ1LKwu9vR
         twCvWQHTqdUsulkql3Ygf/MYceQcZ/4HGDPqkwVvdf7IxeksPtjslfLlWReqJkf5eG7G
         5qFmxrMI9H8mX0EuTskp/UTbZiG2+zAngM4bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675709; x=1753280509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRgANhiZNBnDfTk3Cs6H1fGZwr7ZYCqusPX7KWdZOuI=;
        b=EzpJFM0/+rA2UO7QPqmYzMDTyhsIVoBwtubOkhG8d5rwaV5gE4UxJ2jeKVXS/9EQu7
         3xcT9K8ztQgps4y3YsAwL2wAcGiiBrn8IYevsBHhm1f/MsVRaTDrRETF8Yoxv3HkzvIZ
         B+ocrDsmJZfa/LyAY+LWP/H/jZzYPiJxZVCfjCca0a7iwmbTrKFpasf4ufHrWBvkvBOA
         d6yS793DoMI9Unn6Q2GWyeHVr0zlaui6bhFRZlVJZAhimdBN9a01LSCR2t+eHVJblMt2
         /fJHW0t0sD3SUpoKV+lY7MEIF99n/nytdhZC06ebP/uDdTGFf+psAcQ/F/q3lgsNrmgH
         iSJw==
X-Forwarded-Encrypted: i=1; AJvYcCU6rqmEorsyTxN1xoAqb/0egtS7ZYM7qQ9gy+W5WWD7355mkOZEx3SUe6gYxCP7ywanb2RLug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtHxxtw7UP4GlDCLBNRVWr3QreSNU2UfLY9eauvFNezlip7AjG
	ogOKv7Wd86WR6jnytCfyBmQ+dZgJahPwLP1n0sEVbK3gyW1lf5eqbJ/3sR8Y5qoPMqTwRMwkQkf
	Yx3w=
X-Gm-Gg: ASbGnctSpWeVRjvt2CUUSneoIN5wj/pSOiphzSlIXcu9AhB5hsMRShxMcsro9GXWZTe
	bsgNS+SwCms2KOnRXryMZNURsZ/8r5SHpgiNAF+d1pF5d9K3ZQ9027qNBTGh7tt6J1UZN02qJ5T
	rK36ciGXIEBIu464HDsvlD6EBwFXa8p3K3c0nXCt3+36hJg0k9k2dlYdrf0rQUaDWdkrWBvvJSP
	4b3r7XWE0IqedG9kxA/t3rreUmeipfot7fiG2hMTDsxZhY/Nhpa+f34aBf023I+4VQ9iqxB8jNl
	/T6FHz+XiDcrFKcR3WTCD6KzU12IGSz2xy2JLqrkqVmxic9fxwqVkwXbR7pKCrErn7eZ+92gE4D
	nAidojDYynTK/L9rpoekqSa4Cj9iQMpWJivLcIy8PsodC/EacgkE7zgzT9POF9THJuA==
X-Google-Smtp-Source: AGHT+IF3sxcZ7ga4365fan4W4PtNYbP6lY5ftpuFzkkbYlQEXMNZNZCGLvvl01gVAzNd7eXEqgkesw==
X-Received: by 2002:a05:6a00:1945:b0:747:bd28:1ca1 with SMTP id d2e1a72fcca58-75722771f31mr4550629b3a.3.1752675708915;
        Wed, 16 Jul 2025 07:21:48 -0700 (PDT)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com. [209.85.215.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e07facsm14695060b3a.68.2025.07.16.07.21.46
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:21:46 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so6634469a12.3
        for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:21:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWG75OjpwZFvFAR7i88wSDeaJLuaOuccq3PXJMqVvR92+T3yAEDww6vmkTsGQ90jE++KHrUxg==@lists.linux.dev
X-Received: by 2002:a17:90a:d2c8:b0:312:1c83:58f7 with SMTP id
 98e67ed59e1d1-31c9f2e1b97mr3914439a91.0.1752675705212; Wed, 16 Jul 2025
 07:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250716-topic-goodnight_cheza-v2-0-6fa8d3261813@oss.qualcomm.com>
 <20250716-topic-goodnight_cheza-v2-1-6fa8d3261813@oss.qualcomm.com>
In-Reply-To: <20250716-topic-goodnight_cheza-v2-1-6fa8d3261813@oss.qualcomm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 16 Jul 2025 07:21:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wn4C-cs1y3obzxdtdYcSM44m=AJVnb+Pn3kaaos2ng5Q@mail.gmail.com>
X-Gm-Features: Ac12FXw3qS1FXk204atE8vfiTTzOmf0rWggWMgrUTIEYVKUJNOkL9pqvkeQi0pU
Message-ID: <CAD=FV=Wn4C-cs1y3obzxdtdYcSM44m=AJVnb+Pn3kaaos2ng5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: Remove sdm845-cheza boards
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	cros-qcom-dts-watchers@chromium.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Clark <robin.clark@oss.qualcomm.com>, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 16, 2025 at 3:16=E2=80=AFAM 'Konrad Dybcio' via
cros-qcom-dts-watchers <cros-qcom-dts-watchers@chromium.org> wrote:
>
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>
> Cheza was a prototype board, used mainly by the ChromeOS folks, whose
> former efforts on making linux-arm-msm better we greatly appreciate.
>
> There are close to zero known-working devices at this point in time
> (see the link below) and it was never productized.
>
> Remove it to ease maintenance burden.
>
> Link: https://lore.kernel.org/linux-arm-msm/5567e441-055d-443a-b117-ec16b=
53dc059@oss.qualcomm.com/
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |    3 -
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dts |  238 -----
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dts |  238 -----
>  arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dts |  174 ----
>  arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi   | 1330 --------------------=
------
>  5 files changed, 1983 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
