Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8FC15C
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 11:40:52 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4036bd4fff1so203111cf.0
        for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692099651; x=1692704451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAJu/xV6A/2e1ZophwkUz7aqsqcAzGHXHsGTllbFSDU=;
        b=Yt3Z0KHaQfa/VFgCqpo6vQ60OvD5saTRP7dyiey6tapaKNkvQLdR/VDzkDGP59Mu/Y
         4gDzROVampwq61v03vv4W7YhLAV1zqxTjWqJUYTFrz/Wc8VwvqQM2SHxS4t//kljJ5Zh
         cSQxt1UXorwTk2lse4oKmtuxb06geCyC/g/tdWJb4xeIl/kqPIKaaR31Or/v184szh13
         XXf9Pvd27xDiPk56Jl1bnBg5ClOqqqv7qgxhiCjyKGAIIPBZiZ7kFXVEUg681wDT80uB
         /mvk/pbqUlQf/SMP187BtaVPwmPtjxiXgrTPCNGlnAQzdq7LAcb/uTglY7ruSDHnh/7N
         2zKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099651; x=1692704451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAJu/xV6A/2e1ZophwkUz7aqsqcAzGHXHsGTllbFSDU=;
        b=MEs+1rHiObhWbeR9wrwDGTjzE/e0NSee95hJiAESgOGcmJI539H4CmxARMrfASQSKu
         AKBS4fpcdVc4rSP34WJHMg7xEKfDzTLEYbyKkdNg6GO1SlSFH9SXhYrwUC+DMT60NyOU
         0WikxA7sN/FhSotycU8qVoPww+tzvpgDs3+DCVb2YLdDaNxXDItz6SJNJuML1k52g2pE
         u/sJvN1mahDo9DY2S7gUNHbA8Hk1HQt23zScOfHCGvIKEYYZfiDWAVCsGOARXXuk4+0e
         PttZ2e6xnRr8Cyw8gcIjqm/XohyVkEKbHvwGLIIfQyQLOnBl4rQg7QD6Lr18qRwqW5ql
         HWQw==
X-Gm-Message-State: AOJu0YylQMHzJYHagzKWHQspYoQV1rYzJhexc5Ytu6/7WS4ROCnR40/r
	y8eNPNgAY+3cDJ7AFszUFJZETDIU8Ybts4dUUDmwPQ==
X-Google-Smtp-Source: AGHT+IGukCAhnkO/MP1s3J3prH4E8Xxsrw3oUBPU0yFdTWkCjSA7h2v7C99fsT47XO1RphI+iVrq64CDVJqWgUlyaw4=
X-Received: by 2002:a05:622a:1444:b0:403:a43d:be41 with SMTP id
 v4-20020a05622a144400b00403a43dbe41mr871291qtx.20.1692099651163; Tue, 15 Aug
 2023 04:40:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <20230809134959.GB4226@willie-the-truck> <CAKHBV25CQYfqm80a1ztHXn3s6kj7KCuJBwJz4EZk5cog4n6R+A@mail.gmail.com>
 <CAKHBV27iMDaU3RgJSVFva0UBmyKD8oJEtzDU7PJ4LuPGWAjCCA@mail.gmail.com> <20230815101911.GA11399@willie-the-truck>
In-Reply-To: <20230815101911.GA11399@willie-the-truck>
From: Michael Shavit <mshavit@google.com>
Date: Tue, 15 Aug 2023 19:40:14 +0800
Message-ID: <CAKHBV25PuLERz9AwqtDF-WSPd3fWCEKMw3zyYFV=Lu-0c8Y5zA@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 6:19=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Tue, Aug 15, 2023 at 01:04:43PM +0800, Michael Shavit wrote:
> > On Thu, Aug 10, 2023 at 5:15=E2=80=AFPM Michael Shavit <mshavit@google.=
com> wrote:
> > > On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> =
wrote:
> > > >
> > > > Since you're dropping this and relying on the lock being taken high=
er up
> > > > callstack, can we add a lockdep assertion that we do actually hold =
the
> > > > devices_lock, please?
> > >
> > > Will do!
> >
> > I spoke too soon; the point of this change was to remove the
> > dependency on the arm_smmu_domain, piping the devices_lock would
> > defeat this. In fact, this section is really depending on the iommu
> > group lock not the devices_lock.
>
> Sorry, but I'm not following you here. What is the devices_lock protectin=
g
> if we're depending on the group lock?
>
> Will

Ugh, yes sorry, we do need the devices_lock held *in the SVA* call
flow. The group lock is ineffective there because SVA performs
cross-master operations on iommu_domain callbacks. There, the
devices_lock is needed to ensure that the list of masters that a
domain is attached to doesn't mutate while we operate on that domain.

Nonetheless, it feels awkward to require the devices_lock to be held
outside SVA, since there we operate on a single master/CD table
rather. We don't care what other masters that domain is attached to.
