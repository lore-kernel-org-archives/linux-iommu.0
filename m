Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBED283C93
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589820; cv=none; b=uGHmz/5y102QWcVXhCOkG+GHFEyC5sKtRzSqxD6gRd0vxk6DkfRXGhiTvMCLCxDVRO6OOjQM2HOuyT8G+xT+dhajACfJ7aRz2U8jMVbQyj20V/KZbs5JCcplRJ/5tfIijfOq0T6tyX3tt5p8WaKxluln5zrkyqGRpNqaFea1A6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589820; c=relaxed/simple;
	bh=FdL1/HKNTpO4kdE7n4NKm5VaVSkDlbNs48yc+1QgZas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J92g6UNh6sHCWUlUdpAh+HmGzSFmNrudVtTyTYos/rZyATD8asHpPfP+Y8TrsXx7lpOUkBFzGfHAC5QjU3rewdn2wOlc17ZXFirZKOJ32G8RAG0dMUa9OfAAsn8A3R59u7ESVdYdNwkh3tcGQh/afAfJeDB5LnkykfjLtYbIYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VrV8Yfuq; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrV8Yfuq"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e8b62d09908so5095040276.2
        for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752589817; x=1753194617; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4+7Su+tXNXtNlViREf/FpByOQe19DRJ2WhD/byKGrG8=;
        b=VrV8Yfuq4U+kN9oCLsyMGZLBwXsMZfe4ld6/xI54BsNAfyQXkhPZEk9u6OOXCp3cBO
         rjogYPdDLzbQYr+k5hXVPPaQ05rJ5LZLn6pO4fCUc+5I5gHt4NF32C/5zDd+nMiOci5H
         cvvD8Tbwfm/TOOChmo8KuoUNDYUiMLN2mZas9TjvZvndspY3gg4l4ggnZ5QLXdSLcx3o
         i/TibVAxXFRAwUXquIVcpX13xPnFIDG+n/KYV5EDT8emdNOUg8dBzPBX4wJOmQrx5wAr
         QWdcaPO0k1ytU7BdvKmokG8Krdp9nZ58eS41dmSdttaGjY8UQ8sjuI5qUAvdCySvJ1gD
         6d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589817; x=1753194617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+7Su+tXNXtNlViREf/FpByOQe19DRJ2WhD/byKGrG8=;
        b=dq06MNeR1pEPm2OOtYzv5CxK3iZy9xNbGB6TR6F3N3eAMlgy82MPi9EKUZ74zAvJce
         0zKXDCa7upY0JVEPmpeqHy6c7HnMoTHdWUjNOqn5YnCQsVsVUIcTKJayZse4w80RTqMl
         Ap5x7zkfu8Azn+AKPyreFMlkMjvvaOHtXRlTFgMDwjaOJ5Nept4UgAMD2i5iXR+q/ijD
         a/N9vn+4jdiNflb8mh1UFYp9mrf6IBgCrWXv6w/QIXKrZzacYSQ0YguLhfFpIb53gPbY
         ZSLddYvVI8A060GreyXDv+MuFkONzJ/HvZ+G0MMbFqERR6JdFSTgYcocWtxF/lNA7mYd
         v7rg==
X-Forwarded-Encrypted: i=1; AJvYcCUfGCPGxiaDLMWNZA+qTDXJdJrINNcXepfDC9OfpEsQM3vp2eckew4DRNb+apRcHGbliEmK0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhjYNfihoul7bCUTmZh3YLSh85NMsynKfsTrPnltVGAXaQrRLd
	HjwS1jhnNdoVMz0hDcjplvfMzGJx4Vgm4MCIKrgbal+9fOmGsR8PEayRpq4Dd0ie+K/BZc/Xuzj
	Qv3J4WD3USwCJxViJjztTSd6LCn+Pco20UqQNSJ8gKQ==
X-Gm-Gg: ASbGncsl1EMvhlwypjSdXetKuiZ5EgJyXtlKp3jmH+D6j7giGJNVbrUPJOOfV/SExfO
	l2d0ctlK4iaAL/twbfMXhEnvaBLF35xj+W7T9GSlSs0hJezyTv/O6jNu2GDjRBnvnYhGC2l/lEY
	xnf/fPXuj4yIPXaV5kVMSYk1i4nTuOpVrkJSudEzFkRMBGX3CqSIdmVzkt4zy8J3IQDmPUcOqno
	gLysBFq
X-Google-Smtp-Source: AGHT+IGBzBhoCXe5OGunO7xvl2ZbN7LRPwWWQsLELIyQWERT2XuyowSM7Ti1rVh+eETJFMAPU2ltq9fvUbOvfY7jIrI=
X-Received: by 2002:a05:690c:9:b0:718:2387:4544 with SMTP id
 00721157ae682-71823874737mr49946387b3.12.1752589816638; Tue, 15 Jul 2025
 07:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com> <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:29:40 +0200
X-Gm-Features: Ac12FXwmHbA2nWRNuYQwrZTMO008mwPCFYz6i2upkNA2qncGOOVsk9AzGvxKlLM
Message-ID: <CAPDyKFo77_0n0SefZ0N3osbSM=0tXW_rsjd9P4WaqoZAwyaTGg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: mmc: sdhci-msm: document the Milos
 SDHCI Controller
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 13 Jul 2025 at 10:07, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Document the SDHCI Controller on the Milos SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 2b2cbce2458b70b96b98c042109b10ead26e2291..6f3fee4929ea827fd75e59f31527f96b79b2cca8 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -42,6 +42,7 @@ properties:
>                - qcom,ipq5424-sdhci
>                - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
> +              - qcom,milos-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
>                - qcom,qcs615-sdhci
>
> --
> 2.50.1
>
