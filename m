Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707893C3C
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 09:16:28 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-40c72caec5cso167311cf.0
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 02:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691658987; x=1692263787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpw3JUEGHiq/LD/RXRvZX688rUhVSeJWU4czgkKu7KI=;
        b=sJDe+JlWehpzvzJFhdHgLdsv4qfNjhJHHqrvk3Ge58DXQB5dIZAKWuWn4foxIlGqZF
         t0tP4a+Oab6l+4dNONjMXerEKJ4OqecQfXrINVusn4qmVI/IG4OIOuv2BZ0UBsYt8ZHv
         OcRbptiBTseTqranLSqqtQ2nzjK18Tq5+TFW1wuBMfelzEnCOZNPINLUBvygt7p7pdvP
         PvfuOwQ1h2FJVrmK898Lk1WAcowZi5/XocNQSaVAwkbfpyG7e+sFN7LZ8NAXR9paewUr
         nYiN8yuXrV+77fIEV4xXziGUX6iMOpo3sxTDMVT2AV2kUM7XwvDpvhpXrHIORuQwmlb1
         Sytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658987; x=1692263787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpw3JUEGHiq/LD/RXRvZX688rUhVSeJWU4czgkKu7KI=;
        b=IsRVjIFqwe6/Q5VTntdBOD1snWdaV7bZQGEtw5pS2sEipEQUnYSl1gZWzdabmTcbWg
         Jc79pzQSROwyHGjTcX4ltr0F2/2TTwrU6YKCzcJ2+KkpqMc1zy0CRen/odi8kJRdrfbv
         ltywnNoc+/fQ1mI19Hil95Q+hERu0I+L9GpDWjhJA+vRV/iyQlUuCfytZ/TwlbtrkL7D
         YUdjqdQsXkkGlojyKnMQP6fPO9E8w9QkcJa6xefTlp9P2I8VnUx1JVF7ue4yHztnqKOb
         SQRnFxykMVToIH4QEPCcJKQ2rVSyVOM1m9WS3Ltuhv+K5e86cbWTr36NwmLR7GD62UQf
         folQ==
X-Gm-Message-State: AOJu0YxxzqkTSbHT11UWHN0rl2VxzugmY7r91oiYPSyC2djaW6fw8NtI
	i3XKDEVtSYfczHl4Es+0w4MVAefTfm3ZkRW0JgAf5A==
X-Google-Smtp-Source: AGHT+IF4rdDpqmBY/TG5y/6H4m7inB+2qvpBQbb1PethUpY0FMTMLWgAwIA7n1i3HYnGQ/l6IFLQM2daFvy6HquU82c=
X-Received: by 2002:a05:622a:1802:b0:3f0:af20:1a37 with SMTP id
 t2-20020a05622a180200b003f0af201a37mr340765qtc.15.1691658986946; Thu, 10 Aug
 2023 02:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck>
In-Reply-To: <20230809134959.GB4226@willie-the-truck>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 10 Aug 2023 17:15:50 +0800
Message-ID: <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> > -     ret =3D arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
> > -     if (ret)
> > +     ret =3D arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, c=
d);
> > +     if (ret) {
> > +             arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, N=
ULL);
>
> Why is it safe to drop the lock between these two calls?

Hmmm this is a tricky question.
Tracing through the SVA flow, it seems like there's a scenario where
multiple masters (with the same upstream SMMU device) can be attached
to the same primary/non-sva domain, in which case calling
iommu_attach_device_pasid on one device will write the CD entry for
both masters. This is still the case even with this patch series, and
changing this behavior will be the subject of a separate follow-up.
This is weird, especially since the second master need not even have
the sva_enabled bit set. This also means that the list of attached
masters can indeed change between these two calls if that second
master (not the one used on the iommu_attach_device_pasid call leading
to this code) is detached/attached at the same time. It's hard for me
to reason about whether this is safe or not, since this is already
weird behavior...


>
> Since you're dropping this and relying on the lock being taken higher up
> callstack, can we add a lockdep assertion that we do actually hold the
> devices_lock, please?

Will do!
