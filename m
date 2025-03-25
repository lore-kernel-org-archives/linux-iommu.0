Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8025263F5B
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925048; cv=none; b=dP5UvDyLLlkPJY+iu1PXYA8791PfLVE1nEKln5d40Uj3c9ND9IhL/Ktjne9BBuW3O3S2uH3i4W8I5KIiHdaburP6viuFijJXD0NXOz2oIFrxEtKAaSl9d01WvGQCvEDg7GBj2aphsbfGrtlSaK6NOmRNQDUtluqhIbLlErmEgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925048; c=relaxed/simple;
	bh=b0ot2IZI/CRGb9xmEg4DI8ciOH9JnwgDn4pph3rl6Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKf8+KpXGuJdpK/trbeSwnyrphk5SjWAgn9MlKDsRUljWolUx2OfGaJZXy2YBkA4BNmOTdBBpxVc4iF/F9uKwvAVCPK9xmvbs7N01leaEKaTnmwD0dgevAveDz2BF7rIZ3/ZCO8MPQzVRAr4c6jHcrtZvyyIYeULPpfp4cF7Tds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmhJJ1XY; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmhJJ1XY"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so1347a12.1
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742925045; x=1743529845; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhGiInlcR7Xd84jcIzYAisPViUWvCzr4aDmZQupUUlU=;
        b=RmhJJ1XYH9ZyJzKLoVu0kwJP1XTjK3eGOQnZpFjczn0Bt/cMCfAqrJZY56SNK/0oep
         egwKkjAFPKEL1CV9oR+uzv0VxSkTkvXKIhcwbV89I9YLxnAOEEjFVtcrE2vwl4M3KzUO
         y7+BUNA1R8D5KaJFs8QDUQG094IbZeYq5WMSZXTQxMMs6tXVQ2ieV1LNB+JtSxtGaGGZ
         tHGE5a2a2e6BOrDoaM4r6V5fastRNQjuCSBfm8ydSe/LbaND9qZaowCoC/TjK5HwjQlz
         VQIzQu8PCXwzeO8bf0x/plhZe7L9JutSoyZ/JTFlq5f0fmusxtdTtYkrinvWWf6whbbc
         ddRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925045; x=1743529845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhGiInlcR7Xd84jcIzYAisPViUWvCzr4aDmZQupUUlU=;
        b=K+2UKKXY47iVylYX1JSziidF8hHO2SO0D8I+5Vi6Cx/zSBuGIKehSlvBfK0utrJ40E
         o6cX1p+amw5XLBbaLVjCf68k6A+hoGYnj5R1CBXzMMGKymGp4J0V6WPikZye+UmHsUmd
         FwHjB4U2K9OUNCWHKrz6mcaoaUbzWu++3O1WdxgV4BKowT2t/ZCp5jufEp5E7bSyNdYP
         yR5ZViwEUOisnwptmCNBYzAj+2QR8OVYXcI8yMulCdXFxPci3js7m9z4zfPw45JDBZLZ
         FTB4HY0KcKAwGd4ZsyH6fH+Ep9CvPOlm6UH2oCAQU56ndWGgids621XcMkUIvUq6OKmv
         abTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfsrHN818W9wlnYx5P8az6c7PfaOydAevt7xXOrZVQ9A3cCfRImAw+0CHb+3UiF16zeZ3Q6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7TdXsXs6huEbQVMh7Afp45PKa5t5R08NAsB11piuTTMjrDqBN
	iPw6yFmwgC7VCVdeb17Y1A6UyjTuXqB/6keplX8wykGWZgKDfCMlki8/lPEK9VSRprlJtOpK5fR
	93xjt0WhWghUfmSbTrnsxFkgNYQpCl6yJIhpn
X-Gm-Gg: ASbGncsvi9n6YtASOK1JXRjxGiJIFQKAO556QIfPSmbNBZE28724T7grGIcwv4DQleW
	PuZptl8pQoQepblA6kgRaum31kKTkk/RZrdhhvaTuZ1cdmm0p9GyZhgAT/z6buuMdJsrzXaFdws
	YJQ9ePEFTCrk+X9XECVwUZ8S+yIljREcfqaao40yGeNtjxOqwJCr7S/ejcREqo
X-Google-Smtp-Source: AGHT+IFT6iUQVGy9/S7WpYKz0/NWFcpS5+qwlX6SRyXlLEQ6LNxZsg3WuVnK2YpKIfIXw1YJ2xU9uian5VbBT4ya5z0=
X-Received: by 2002:aa7:d284:0:b0:5e5:606e:d5a8 with SMTP id
 4fb4d7f45d1cf-5ed53eedeaemr2656a12.4.1742925044906; Tue, 25 Mar 2025 10:50:44
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250319004254.2547950-1-praan@google.com> <20250319004254.2547950-3-praan@google.com>
In-Reply-To: <20250319004254.2547950-3-praan@google.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Tue, 25 Mar 2025 10:50:34 -0700
X-Gm-Features: AQ5f1Joqm0uz52JNNiTXYMzMoGiuoxGGMT67uwQkEDG0O3dOuMqoHzB_B6jqwww
Message-ID: <CAE2F3rARkn_CwxeBOGsivC+ytX1=5DWmi6LP=rSndiFo4fj8wQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] iommu/arm-smmu-v3: Add a helper to wait till cmdq drains
To: Pranjal Shrivastava <praan@google.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 5:43=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/=
arm/arm-smmu-v3/arm-smmu-v3.c
> index 80362d9f293b..f65d9bca0392 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -754,6 +754,30 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_=
smmu_device *smmu,
>         return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
>  }
>
> +/*
> + * Wait until the SMMU cmdq is empty

nit: There is an existing comment that reads "/* Wait for the command
queue to become non-full */". Align with that and write
"/* Wait for the command queue to become empty */"
