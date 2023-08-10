Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BD83D71
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 09:45:40 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-407db3e9669so168291cf.1
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 02:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691660740; x=1692265540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pgn4/qIV7fxvKZzxqSyuDtxTvEtyWVBr/gC+RKJiMZ0=;
        b=Rl4LWFZSxmP0VkxHciD8VhjO8/5h/FGy+WWDDjSPkV1/KQ7gP/QeOi1plC5N32mwqV
         h4S1Qp28dCmmXe8/p1G1BMd1AcF95bf2635ohTrRogPkfsEK4ghPJoSJl0Waobhjp/if
         v5ooebxurbyrTUt6s9ePt4iAXz/zZilY+pMDvz1b8E1Ntvd2pImDQGkgU9eXgT4loKNd
         YoQTVuChJwP1utUbTyadI7n7v2/N8TQNFQ9yhyb/49obm4e/k6M927cCXxFNQL2qCxyX
         PPjvhcnZpJZW/R6OdvE+RWYzrjhDlugSVEg+cvqYsLR/Egt2VSttP6kHKrEpPHqFIiqt
         QZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660740; x=1692265540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pgn4/qIV7fxvKZzxqSyuDtxTvEtyWVBr/gC+RKJiMZ0=;
        b=bEDogEdJ3PhsbQKN59Xwd4LtfCcCOWZwn//Y3EneZd52NmHwj1E5tmxbJvNBEBKceZ
         cETAwMdvNQcaTSZeO83pah6y6FW5DYJTxUGs8Rgi6a7CqVIKhagk4wviojWptnDw1UBH
         g0Ga8xTz8u7ILvQbZvw7ufalrRDH9PfSNeG9vJPsAVBfcfuj9Lq4+/3ARaX/OrjEm2Qw
         YUjk1qaWeffuPO49vUQKeOxkr4UDCfmuY2c9BVaQ8lVqIGXHTMKB7TE7TLB8B1WLwA/w
         osyZZ+lcK6ZCQCsqaZQwV++ELesJIiJZCdyWgvuLBb2mOgz8JPSFhPAaZvMkXnr09Clk
         SINA==
X-Gm-Message-State: AOJu0YxHmqatxWcwetgrSJ+I7r9C250Eo3x0duThPoARFbPbtigcccSJ
	liJ/S40u34Oy3kzoDoiH4HQPdHFwAwPGiBt/sjEGNg==
X-Google-Smtp-Source: AGHT+IHYqi+XITMAC6nlqBrd8lUaSmvP6Ltp/H+mOIvB+jI0bmh1wykyAMSbPruSInfIOKj8aBor1Ra/apMk+Ehc9QQ=
X-Received: by 2002:ac8:58d1:0:b0:3f2:2c89:f1ef with SMTP id
 u17-20020ac858d1000000b003f22c89f1efmr402291qta.5.1691660739834; Thu, 10 Aug
 2023 02:45:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com> <20230809011204.v5.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <20230809135024.GD4226@willie-the-truck>
In-Reply-To: <20230809135024.GD4226@willie-the-truck>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 10 Aug 2023 17:45:03 +0800
Message-ID: <CAKHBV27uY3TK3bWX8q1VHPo-ejeNmY53RAVNH_VqyYwZASKsNg@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 9, 2023 at 9:50=E2=80=AFPM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Aug 09, 2023 at 01:12:02AM +0800, Michael Shavit wrote:
> > @@ -2203,7 +2186,7 @@ static int arm_smmu_domain_finalise(struct iommu_=
domain *domain,
> >               ias =3D min_t(unsigned long, ias, VA_BITS);
> >               oas =3D smmu->ias;
> >               fmt =3D ARM_64_LPAE_S1;
> > -             finalise_stage_fn =3D arm_smmu_domain_finalise_s1;
> > +             finalise_stage_fn =3D arm_smmu_domain_finalise_cd;
>
> Why is this a better name? Now we have inconsistency with
> arm_smmu_domain_finalise_s2().

There was a time where s1cfg represented the entire STE and carried
the entire cd table. We've gotten rid of s1cfg, and now only store
arm_smmu_ctx_desc in the arm_smmu_domain for stage 1 domains.
arm_smmu_domain_finalise_cd is IMO more clear, especially given the
historical baggage around `s1`.
