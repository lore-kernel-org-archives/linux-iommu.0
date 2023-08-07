Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0B101C4
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 12:20:21 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-40a47e8e38dso421851cf.1
        for <iommu@lists.linux.dev>; Mon, 07 Aug 2023 05:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691410820; x=1692015620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKndJRH8+fA20vciO2QWMbTLEeBf2QvwlRovy10Zq5s=;
        b=goQJDvsQtRExrxHcS+ViWDBPY8yY1vbu/PiFqwPcHswJuKsGNLmJFm+sjmFUgfBjAv
         lPQTr5QQZWMgsYAYvLmPEfyVYuxaHuHJQAETCqMYgs6AOPSrAOES13LUMemC5Jg7TEzn
         WYZ653imtkIk1DppFnE+DPVhQHYg2tTyY/5Bcb6PSi9MrmmRaTEcCWMBh0yzXhvqc/Sh
         pa89CLgW1DtaO1cWMkAAGhQItaJtMS+nLWoXY9LPRVLvzXFtzmBbW2nXVsldWB6tVe1C
         2In9tNIkaNkVMeVz7PYhveuzZsSXHOp//xmdWYNSzD5OXDwpAGXpIrvQG+aZofQOB61J
         lHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691410820; x=1692015620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKndJRH8+fA20vciO2QWMbTLEeBf2QvwlRovy10Zq5s=;
        b=ShxnoX/OHwy8JhiEz5291LN0Z92WQAs69odclKvTk1beNAQww42bJqzjzKS4Q8Cwtk
         9vHijvT6X6hpLC5qMg5ZLvZHt6EQfAgQpJNQXjPLNnnrEe+5lLuffXAFLi8a4Vb4xSpM
         MR0jkmpRwaNMWQmZc86oiC1+EJL90ftaT5/ZbugVycKe8D/856tD6wiwgyvxQB8Ym51u
         Rt5P/EyqY9cH7gwqy9fdBLFpy8tvFjhkKpg8Fra5aoGkxtluaZGqWchC474Es6asAbg9
         NfuA0WoaIfK1CK9S92ZpKX0ZrCW0mhEYlJ8A4s0O6ScyY5GLwU80VEVQ/6Qz4LCoc3rw
         hxOQ==
X-Gm-Message-State: AOJu0YxZzblFnMqyeQPk6nqn8Icrp7g9W6569HgZTu8nQRV45ddab//L
	qSskLh/x9gxMqdm+HbditYkbfSARRGr6CKerDeGbOA==
X-Google-Smtp-Source: AGHT+IHLXvW9OoK5Akyt4yjw8GIDQ9eEk6i0Zq0Abc3A0zfrE7HvA40+g9GjhZY3GoldgZDmVpVHILmBuMpzLsKlJkI=
X-Received: by 2002:a05:622a:589:b0:403:fdf1:e05e with SMTP id
 c9-20020a05622a058900b00403fdf1e05emr338193qtb.19.1691410820262; Mon, 07 Aug
 2023 05:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com> <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <CAKHBV26OsQYRCifuD0UjSf5uqcvMSK2tizjFULLv8DTdz0zD2g@mail.gmail.com> <ZMv2WJX6b2UBBelt@nvidia.com>
In-Reply-To: <ZMv2WJX6b2UBBelt@nvidia.com>
From: Michael Shavit <mshavit@google.com>
Date: Mon, 7 Aug 2023 20:19:44 +0800
Message-ID: <CAKHBV25fCOE3pVysLaB2e67G0Be3FdWLKb+ZsmbHg8CyPpwo5A@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, 
	nicolinc@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 4, 2023 at 2:47=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
>
> I'm not surprised, I think arm_smmu_write_ctx is a little too clever
> for its own good..
>
> I would have written it by computing the full target CD entry,
> extracted directly from the domain.
>

Yeah I was considering making a fix to arm_smmu_write_ctx instead; but
clearing the CD entry on detach feels like the right thing to do.
Relying on the 0th CD entry being re-written when the CD table is
re-inserted feels fragile.

Perhaps re-writing arm_smmu_write_ctx could be considered as a
separate singleton patch?
