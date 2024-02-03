Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B44F15EB0
	for <iommu@lists.linux.dev>; Sat,  3 Feb 2024 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706947287; cv=none; b=ZHwYpOaGTk0Pz3BtuydGRn4+Of2Rze+Yk0FT36d0FOpG1ygJdoMrD1zgXWUMIKeFGdzDgwgRv8WnWOz5/IhBiFfNufjlIVK3F63TO2BNWbgVtFqHkXZMu3+cs6baZkttetve0hbtQ8DD88fxr+4HTvRSXhSYhOprOwPiMv5GWx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706947287; c=relaxed/simple;
	bh=+g16HrGN96hzdHBolAzt3tNlVJ8Z21trlG1HVlRsjjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hO1/n8HvUmt21AS2cu5fh1pdVzVrWmFiI3O1gzZUC0ZDZiLIfw6DQ4+Z1R8lEAnE1zs56bgkLdIl0IvGwFpxSn+ptjtnhkOY4rBSS1WDv1r6Sh/OJUF1gC7gLCExy9LTP0iYYRK7ZNE7fTufI/7uyOBJXWEpvUYM4GdcBMOcrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ze2tHI2R; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ze2tHI2R"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a88ad0813so144941cf.0
        for <iommu@lists.linux.dev>; Sat, 03 Feb 2024 00:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706947285; x=1707552085; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cSmLB5WYtUgO7CvecWtcD7c91pkeFVjOJE5t9NnwCIM=;
        b=Ze2tHI2RjwqRKCxR0bUK9m36zb5erQQD1eYaLr5OdG9coDWYHLDb3mxV5vRmWvb1XZ
         hWQ12h+nd2Qx3j1D4FtkCdbo5xjpHYzwtCMGy708taUj+N5Z0FuthEk22hgXkhvUTxNO
         trY9an17+NZwqW2MngJ4quAmxdlvo79ZTaZwRFZmKBKsDYm2c/2NA8jIQyzBPv16MWDF
         toIflbq9/cKasvolZqFP2vXXzbgFwXVxELBnPPthbmeKc6tS61ykspxpfQp7MbWmxz2W
         oRhTHUvLMTRFO/DXF6ZzCVZ2YD7Q3rBGNV3tSuf4gImj2/goTAF5RpFRD2X7Yn+N927G
         T6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706947285; x=1707552085;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cSmLB5WYtUgO7CvecWtcD7c91pkeFVjOJE5t9NnwCIM=;
        b=qB+ReBmKYgs/OGKry6IJA4FRzD5JYtJrWHnQvG57myX4Ymo6B2y+LJMDP+xI/3CfRO
         5nnfaLzZ51JMVwHXq1QAzcvh0ew5je+B1CDwB0Ke4r4KxhxdmTb4BCCRN9P/m13b6yMw
         5krnAjCs5dr4n5RsCea11RAW5lMO7DMrmiDxFh0vXY/JIxxtOXXddFF38p9PCqCL8azC
         sqas58vjpETqLdT4G79IhTP9V3QHKy/p30YqNPVoOQRTwEyKylDG+4NNlSgs7yidJ69g
         y6V0V42IZuQOl7fovWhJsNAvMIvcCC2B6NzRe7SbsNhBxRu3GM2PPP2WsPS32jTxedCX
         2nGg==
X-Gm-Message-State: AOJu0Yw2Gdi0go0n/SOviqY6psEUBmYyrdbYpaeizN81iRMJ+nleuGIm
	2hb5OW8sINEUorsVB58lB4V7fyAZr3sJ6K+tT3Zw3PfdllY1o5KF0zqmLk/7bUJyzPyAwHMpWJn
	QojoUuMlNdELrOnhWP120D/wCVGcu/qrU8Irj
X-Google-Smtp-Source: AGHT+IHCscmJkj2ovilbVfC8FPzM/Lu6DQmpNsY5bby6dfOlRcnY6ETTDD3wcL3UQB0NtZHIrXMsxkFGaVrF3HM+JmM=
X-Received: by 2002:ac8:7fce:0:b0:42a:8a49:1750 with SMTP id
 b14-20020ac87fce000000b0042a8a491750mr120716qtk.7.1706947284809; Sat, 03 Feb
 2024 00:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <4e25d161-0cf8-4050-9aa3-dfa21cd63e56@moroto.mountain>
 <CAKHBV24oM7JpenJfGXymcxkRdW=49dVWS72oCuTxt-FEguSueA@mail.gmail.com> <20240202133557.GR1455070@nvidia.com>
In-Reply-To: <20240202133557.GR1455070@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Sat, 3 Feb 2024 17:00:48 +0900
Message-ID: <CAKHBV27suFN-o+MTX0+QENfvPHh9wnoWcWBr6tvaLu4Vvn1QPA@mail.gmail.com>
Subject: Re: [bug report] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, iommu@lists.linux.dev, 
	Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 10:36=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Fri, Feb 02, 2024 at 09:33:14PM +0900, Michael Shavit wrote:
> > Jason, should we consider moving arm_smmu_get_cd_ptr() further up the
> > call-stack as a standalone patch to remediate this report in the
> > shorter term? It won't make this static checker happy, but should at
> > least resolve any true positives.
>
> Moving is the right answer, but I suspect it is too hard for rc. Lets
> leave it to my series that already exists.
>
> Instead we can preallocate:

Yeah that's what I meant; thanks for the help with the fix!

>
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -588,6 +588,11 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_d=
omain *domain,
>  {
>         int ret =3D 0;
>         struct mm_struct *mm =3D domain->mm;
> +       struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
> +
> +       /* Preallocate the required leafs outside locks */
> +       if (!arm_smmu_get_cd_ptr(master, id))
> +               return -ENOMEM;
>
>         mutex_lock(&sva_lock);
>         ret =3D __arm_smmu_sva_bind(dev, mm);
>
> It won't silence Dan's warning warning but it will correct the bug for
> now.
>
> I'll send a patch
>
> Jason
