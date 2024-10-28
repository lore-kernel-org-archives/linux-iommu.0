Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1218E04F
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730097688; cv=none; b=qdmx//JxF3qvoBW/o8eGQ+azkzgDeJRblhEZUX4Ltz2nTd4q8HjwylbFFXPzUjdgBY7KLu8KMX0U90Nv0DyksrTXgfGCvIK/BigMDCiUUiiavNQJFW45kawdS1kaPHENTPcjZcNRH8e3fU29KQFvjYu6nz1A4kkWf6bzC2ItN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730097688; c=relaxed/simple;
	bh=NS+Tuf100NVa1bY+369mrzPv7GRrI/vVftNytsJXNYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U+iuht5foqx+J/Ukaw5fePCBQQfWpGkmuWT8iufLVgtWvhPRPGabMXMy0+VgSX9pKFzLOHOAk4Qjqd15jxJrdBB8JLVcbziqpEYBEEi18NF+jKuhZL7uhupCsPZ9f9t6rECm+zzJquYLx4sVfWnsABNwU3L3Tne9LsVb6XDamDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJAEvwX6; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJAEvwX6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso3875443e87.2
        for <iommu@lists.linux.dev>; Sun, 27 Oct 2024 23:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730097684; x=1730702484; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NS+Tuf100NVa1bY+369mrzPv7GRrI/vVftNytsJXNYU=;
        b=tJAEvwX6z5fBZZ6fakqx5sd7QBUoW0lVK7dTglL7H70u52NNBMWjIW7kWdSgFw/Uw7
         q24gepj1Mn52OZ9Le9C0QpdQPCJRfnz7XBox3/ZWs7XrOn7wScgFZ829hz84BHvsIbYo
         wNt33sN1ri5z02dkEUXl1KKbRBov+AElxzZ7aukKk/MFm7NaTFsLChn0uzKjLgM9cddl
         0nPP+UxjiRlSbmoif1atK09mHQ8vmb7E2Av1GgksiSg+46imfkjeGL88UjLZF5+wVshr
         QBYr+WSbSrd9YYVjb1HhUnVdvUnnkEtfkcixdOJFo4qwpktXdMv6XLZxYiS0hTJ7mJsV
         9Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730097684; x=1730702484;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NS+Tuf100NVa1bY+369mrzPv7GRrI/vVftNytsJXNYU=;
        b=a0AY6G0QOoGKmed0xnKlHphjtGvnunsPnJTbbzSSDH/CGQl3qvxeefFi7UZDJSyYmr
         TKsnEAplFcCkWFVi4quG4xDo0AHboottX9N1HLIVXdWp7ibE3TiAfqYCzgHC7oUI1Esw
         ZpCQ/oayuuVJj7IJPEY1P5KRRUkObtLgv/fiCe8u3d1qNuzt/SlRv6SSbe3s7zjgJUty
         u/sHNEHv3SBH5QparJeFBbhzKa+W5Brh85HOZgfXc5EjkCJRkEJZBddC9p9AyX0CTWQe
         AgnBN25jlFgjDmNo0NehVHjAF17aZ6qMLXCgU0db98AdHWFpmwcjQH9Fz/ZICjqc23Ie
         O6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCXjWz+TbgBAGpYQFboWnHukIayMeDBChWOgfYtR//Cdp6Qvy3RmY0DkFYPQDEj7smXMqdaS/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5OsT9azKfoETpEJDRz4A5butgyJUF4y6RnG41i01RMzOD8Umy
	w5eVIzgUTd0KW/Ziy3CslPA7fip6gStKSEn7Z2cH4NKFJig9NpN881VdwXJCrEhYv34RKWzRyS/
	CzL4WejVepZstZ2o9QJwbBs5vKyDuz12yI7bsfg==
X-Google-Smtp-Source: AGHT+IFgFEA9LsVMQUWWo/dM/XVqyt5Trns048cVWzUxR/mKJTkgDk+3ErfamKRGebF05Z9nNEe+Ai1eCzQr3FLp3x4=
X-Received: by 2002:a05:6512:3d93:b0:539:8bc6:694a with SMTP id
 2adb3069b0e04-53b3491e22cmr2604980e87.43.1730097684106; Sun, 27 Oct 2024
 23:41:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240912131729.14951-1-yi.l.liu@intel.com> <20240912131729.14951-5-yi.l.liu@intel.com>
In-Reply-To: <20240912131729.14951-5-yi.l.liu@intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 28 Oct 2024 14:41:12 +0800
Message-ID: <CABQgh9HvJLJ9Zsa69oHiNSPaRr+NGhrbY4n-80kNWA+DA5W_ug@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] iommufd: Extend IOMMU_GET_HW_INFO to report PASID capability
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, alex.williamson@redhat.com, eric.auger@redhat.com, 
	nicolinc@nvidia.com, kvm@vger.kernel.org, chao.p.peng@linux.intel.com, 
	iommu@lists.linux.dev, zhenzhong.duan@intel.com, 
	linux-kselftest@vger.kernel.org, vasant.hegde@amd.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Sept 2024 at 21:18, Yi Liu <yi.l.liu@intel.com> wrote:
>
> PASID usage requires PASID support in both device and IOMMU. Since the
> iommu drivers always enable the PASID capability for the device if it
> is supported, so it is reasonable to extend the IOMMU_GET_HW_INFO to
> report the PASID capability to userspace.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Thanks Yi

Have verified on aarch64 platform.

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
