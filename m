Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298123ABA7
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 00:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982111; cv=none; b=bVTlQ5QVyyJr50VfDp03GYcOnA1Yf2yi4yBivo5AiNMaY97ee7AYLjf7C2AX927B2Qb/KekkDzOxRm+pCn97XsVcsIvKgS1/Xfo61G3WAph1hfvVnEKqmUaFTtC5dqAMQD4NWKwY24m0TWpEJtcjLmxlTKr087Mfrhf34E3QfV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982111; c=relaxed/simple;
	bh=dvZED7I5EaWFDhOiPzTV12QUqtQZj+HgZ6ZZDFaq2uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vAgxEE1jF5iDZtvqU/2+WhQIAGLjHeiCzkFIGShHANcoNSKymO77KUgnZ3+xJd7OFCShEff7dgf/kl8HXM0dcb6BZYRKKPxdeVjOID1NlGWtAQm48zXh7UsDsTToZeUXo+JYz8P+FC8SFWGwhJ+ZsgrtWSZGCCWKJSQ0P0CueRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VjdwJnQo; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VjdwJnQo"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so3850072a12.0
        for <iommu@lists.linux.dev>; Fri, 05 Dec 2025 16:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764982108; x=1765586908; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYFSn4Mla56zrJfrsS9OVnybbb/9yNVAJbUr5EfaPD8=;
        b=VjdwJnQodacvVgkq2HMPit4tHX+RTjXXIJLUnYudsCz3IMy5nz12mDXARvHEI1r6ZJ
         wnCHOGUIfOf3x5Yzj8FZW1xoJeu2rbZQAeUTEkn9y/81j5mb6O+Ui92XeTzh8plL1Dhc
         4eNR6nH3zDLipXkPQk/PR1Ghiu2JHirbcxtf7wG7MzGp9Np2YuUGnzl6o/gQFRWcJ/nc
         7TreB6FDXdfizE55q95ofNjplzTh0esEReTyyrDYIeKwH5kDc2Kfmab7AodXtEJvFGk2
         bub/Lrn/j10awHvUP84Kb+HtjNb3wUCy5DEiXD0RtAcSsNrObuHgqPfFZ/X1kuzAl25D
         Acfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764982108; x=1765586908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYFSn4Mla56zrJfrsS9OVnybbb/9yNVAJbUr5EfaPD8=;
        b=QRpu1nxawQQCq2Nrv4VFZoWQ9Q0VjNzBOmBY1aAnmbZ3psLWlsRqCbp9ei3DoWc9O7
         YlIBMJ8SiCfRBgpckGZ28a6atxc/YHdRY6O3SyQvhvm1ZGYDrfWM8cOIQEIynj79sFRB
         sBGKpm1RWmN/WWayR9fmQi2AurpWGygXhDmDhjA4tCMuT1HfXJr8DhcrJR9ftxUzteE6
         ZL9DHXAkpW7OUJW0jlwrbVk7b0MD8cZH2i2msWzvx6gWa0NwS+P+ObobqSUczi916rzO
         ABZW9/VnlQUPNnkljd11HacJuPl2Pq3fZwzBYkSXJhyRM4aztMeiUbsWU9VyerXVKqr3
         Wplg==
X-Gm-Message-State: AOJu0YwBPIB40/bG7iy7k5nRrKtyw6df96k4LcQLV+PsskuOMM7yPlWu
	wQ9NbeuSHq0jUarzQa+Z9aYnoUeeDgoBOtoP3drj5r/5OrAlwkJGetghymAiIbw2YskoV5PSYMI
	8Mu6lG9huvIaeSoR8s7dVxLdl/FInDxIc/mO31txN5A==
X-Gm-Gg: ASbGnctZpOEm0HyPjIkzBtmLyFDOuNTtc/WqgN6egUud6l5KQpuzzuPtFq/Cw4opnSV
	6CgBlFzEFIG8oyFJScHArJ1P///tPFMePFtr9I275zpN/WteceyJpP3b/fY5auDjXznGTCAOxUc
	PvU9gLme+NY4lhnjm239u6e5fSTU5vqrHcQwSk6tKq2GpojFyVWq1gnL3tqjQXbh4EDjrUGy9Jm
	VS1lR1Bqar7kJJ7LhUTo7CjDkJkOp18+IeumLVNZFNSkpdbHO2FJN6NnXHmyJC2GXxAN3pLpw==
X-Google-Smtp-Source: AGHT+IHeuea7f018W/ybeuOlyuBz3yajrAEMzeUHfvEK3l9q7hep1NqHdVXjVJEaRnPLDzqQLTlpbkDwXtGRJpndsRM=
X-Received: by 2002:a05:6402:5241:b0:640:a03a:af98 with SMTP id
 4fb4d7f45d1cf-6491adef3a4mr604730a12.18.1764982107917; Fri, 05 Dec 2025
 16:48:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v1-c8ed57e24380+44ae-iommufd_selftest_hwpt_leak_jgg@nvidia.com>
In-Reply-To: <0-v1-c8ed57e24380+44ae-iommufd_selftest_hwpt_leak_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 5 Dec 2025 16:47:44 -0800
X-Gm-Features: AQt7F2ogqxyh6MmWmgDQORDb7kXEZHiqdN2QBJWMJQd5nBv7GMEfINDGJAQTmqc
Message-ID: <CA+CK2bARGxxeafk3R06256dFRB_VNj02N41iADTSQOT35Z-K4g@mail.gmail.com>
Subject: Re: [PATCH] iommufd/selftest: Do not leak the hwpt if
 IOMMU_TEST_OP_MD_CHECK_MAP fails
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, Joerg Roedel <joerg.roedel@amd.com>, 
	Kevin Tian <kevin.tian@intel.com>, patches@lists.linux.dev, 
	Samiullah Khawaja <skhawaja@google.com>, "Lai, Yi" <yi1.lai@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 4:40=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> If the input validation fails it returned without freeing the hwpt
> refcount causing a leak. This triggers a WARN_ON when closing the fd:
>
>   WARNING: drivers/iommu/iommufd/main.c:369 at iommufd_fops_release+0x385=
/0x430, CPU#1: repro/724
>
> Found by szykaller.
>
> Fixes: e93d5945ed5b ("iommufd: Change the selftest to use iommupt instead=
 of xarray")
> Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
> Closes: https://lore.kernel.org/r/aTJGMaqwQK0ASj0G@ly-workstation
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
