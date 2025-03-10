Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F02822E418
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625138; cv=none; b=Lz54tvpcHgaquXHRsJAXmCMoag4facfBhUzQJTG2CyiPDxMyGAkRSr1jl7hvwcrvpqC2ScLT3Wy/9IjKQ80qs3cPqjRnv4p9QjARFHO/mO25SG0T9ioufKomeIEIAD403pvDe29lXWWFtM5KMP4n5ZtUiBJnwJSfZqZf7WJeEo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625138; c=relaxed/simple;
	bh=AhSiebyZisSEOEjFm8MpCPrlAdsRA9L9FC+Hd4Xs7NQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKDRhRFf//mYFFX8vrgRDeEKEI5e3xUeyQBjv8xuybJBDexIH4RSkMGsXgqV3m4Ga7DYYOA8j0qlVTA/GHXUBeu29ybQQd50BNY6m6CBybt+RHqFSvQSCQbqLT6gwex5sYKim7F334y7z9vPdA3QkBcll1TRY2zN9yJa7qcoE1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0shG7Bl; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0shG7Bl"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so28612521fa.1
        for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741625135; x=1742229935; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xsicxmenQMOAQy9ZUHws7xk8D0uVS0Ti0PNVqRnMSU=;
        b=T0shG7BlvxDccf3dUTw0ee9FIFIl/SjqREYrGhpJaIkkGLMZNXFs4s8SOt+vTrPcMm
         Iu+Aw1AusFUZRt/UjFl9qGeMPtSr4jmswXv40hBYphmNp8UgqJ/JmXwQbVOCKp+WjZF6
         LwgDKs59FMUUSoFlyNZHeyTSh9aSqFH+k6hDChG9H/rNmgqNTZSJZ+MRvu06vK2ic5xD
         HgJJqqadyQGme1OAVT0gNpptSXjj+ooUwWrYsMzE1dbdFY28k1sqaE13aVaULWlyq6Yn
         ixJzxFW5UHWT0AfdAZFM9O9V9ks0OBhFvodQPqFmwzD96qcp1tUjZFrcFgcfJHdACqul
         olRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741625135; x=1742229935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xsicxmenQMOAQy9ZUHws7xk8D0uVS0Ti0PNVqRnMSU=;
        b=uKCxicJfxWdQIedhz+Sp1tOzXzzdf3pZHj18/umeJbOwtzqdGhZ2nrIyaSgesDDNM/
         26V3g1LwKwMdD3TBohWgdgis20GPNlZzfuJu0vt2UWxoYJRZg1XAwQXT8pj8XSvjmHmL
         2d3czHuFD2qGIgHGyVV5lnjs8yxuvWjNeNBmT02dKYD2V/yxp4zGTzcTMz54h7euXuB2
         143+VwpNWfGCPX0cIbYNQg/BWhw9gbV9NmjpQRpPEXXTNHhZiCGydtLs0ElhW49Rl/pw
         cA4/2OcJxpcEPZ5bGD1ecKIBIdaEI73cRqNVAlfK83ZCtMdjaMT5qS2rhg81sXC/dtHl
         L3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUzhk9jeQ1b4yPUMWpWstgf2NJbgLxzFHjpC0N8wfWPaB+qECmcoHfOIfJ3j9WEbL2+biPTtA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRJYZmmUx9TskJccIqU9Tf9XfUPB//nBPjkWe7I/VXKwrrOf2u
	2acSLw1mJoyyXrri3CcvpftIrk3rVYV/rut3/M2OIFUpB4GoXQhJkcnmZrxff7crwvSlZLDdirm
	jD7Xq8H8c0lDVb7Zp9ftKulYkd2U=
X-Gm-Gg: ASbGncudYfbP0fRQWwdeqDTbscHU31mNy1Iy3PFxVoCVPXYpwBj0lJqyJALA46sl4ek
	doeZ83PhGwBezKjCtkrIKjVzYT3Q8+T9842CAyhS1XMMl+ua0UMuOTuACOhaDwZyrIeNesxedt1
	yewr4BOSi6e9qpl/ZBN7Qocl2Teg==
X-Google-Smtp-Source: AGHT+IELaT2li0TDFdIGi0ECQA6PJQbMNSD/H8pY1VH0V8khSOVia+1VvBGBenJ4MrkzN10ddT3NAwJsgribGaiDenw=
X-Received: by 2002:a19:385c:0:b0:549:9813:3e6b with SMTP id
 2adb3069b0e04-549abc9f5fcmr91423e87.0.1741625134237; Mon, 10 Mar 2025
 09:45:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com> <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com>
In-Reply-To: <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 10 Mar 2025 11:45:22 -0500
X-Gm-Features: AQ5f1JqmGHzEzkS1We4m_O_rX5wft37F9HsGwqv_A82mE5sllwO43e52LVF4N6s
Message-ID: <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in arm_smmu_v3
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 7:42=E2=80=AFAM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2025-03-10 6:11 am, Aaron Kling via B4 Relay wrote:
> > From: Aaron Kling <webgeek1234@gmail.com>
> >
> > If ARCH_QCOM is enabled when building arm_smmu_v3,
>
> This has nothing to do with SMMUv3, though?
>
> > a dependency on
> > qcom-scm is added, which currently cannot be disabled. Add a prompt to
> > ARM_SMMU_QCOM to allow disabling this dependency.
>
> Why is that an issue - what problem arises from having the SCM driver
> enabled? AFAICS it's also selected by plenty of other drivers including
> pretty fundamental ones like pinctrl. If it is somehow important to
> exclude the SCM driver, then I can't really imagine what the use-case
> would be for building a kernel which won't work on most Qualcomm
> platforms but not simply disabling ARCH_QCOM...
>

I am working with the android kernel. The more recent setup enables a
minimal setup of configs in a core kernel that works across all
supported arch's, then requires further support to all be modules. I
specifically am working with tegra devices. But as ARCH_QCOM is
enabled in the core defconfig, when I build smmuv3 as a module, I end
up with a dependency on qcom-scm which gets built as an additional
module. And it would be preferable to not require qcom modules to boot
a tegra device.

Sincerely,
Aaron

> Thanks,
> Robin.
>
> > Fixes: 0f0f80d9d5db ("iommu/arm: fix ARM_SMMU_QCOM compilation")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >   drivers/iommu/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index ec1b5e32b9725bc1104d10e5d7a32af7b211b50a..cca0825551959e3f37cc2ea=
41aeae526fdb73312 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -381,6 +381,7 @@ config ARM_SMMU_MMU_500_CPRE_ERRATA
> >
> >   config ARM_SMMU_QCOM
> >       def_tristate y
> > +     prompt "Qualcomm SMMUv3 Support"
> >       depends on ARM_SMMU && ARCH_QCOM
> >       select QCOM_SCM
> >       help
> >
> > ---
> > base-commit: 1110ce6a1e34fe1fdc1bfe4ad52405f327d5083b
> > change-id: 20250310-b4-qcom-smmu-d4ccaf66a1ce
> >
> > Best regards,
>
