Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146CA125C3
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 10:31:47 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-407db3e9669so149521cf.1
        for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690540307; x=1691145107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/AXnTNrjt3ydEdFE4yO813xK+xMvSb9hSQ/KG4yXiY=;
        b=mIflqVFpPiPyE5coqLIaWLnBUmVWEBvqGt0jbIVzLQc5C6qj+8o2bO0+KhCxqUWJov
         CtmgIJ8meKYRW4W7+Gm6CtMyjfw2i+lhqB/SAa7eFDyi/wVYe6JcwbljhFYGk2z3Kgbt
         gUtwdoAGRhhODwV86DKsuUMEL50snPSFfgSxUZ+daYLIFXawYVJQ45nmP6GqgbXQXbSv
         NoA9FVxpE2kyIRYSO144o7RU6TFA2WuJUoE1mamcEvU00X6SQVJkEnrsbQ6aFTOnFkdV
         xnm/ZBpvBnqtwQDUPewsDPX1qVAmkI4oKitcEbKYi3FJ0+41eDYf7/bdoFbII+TlSFu+
         iaMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690540307; x=1691145107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/AXnTNrjt3ydEdFE4yO813xK+xMvSb9hSQ/KG4yXiY=;
        b=dGPbD/hmrMGEUCPHRUQbCGx7K1yOr8f02muLqnXOabBnxtPyc+VfUqpL8zFRatxnRg
         aTaQgSTsi2ofHGpUJJk29fSvJr6OmQikeqyh0SHpq87IdMPGz2GQpva3wXhY192RGlLy
         PCT3iRK110XcGzIpApVnT+k+cDtFXbzorIWo0tMygjxnKjtodFz/1gdTyk10Gy5EthI1
         SIJa14OU4iUs7K/Vcuj4gRH6pTNvCsnZkVmo7X3zela5dZiDQV47lXqydNkSP5WoQ8EZ
         R//HJb6OsAwo47hCzwGeSDKtPOdUUVHUuoWVfhozC38L5jyGpwa96oXMvKud1uAxZJ9H
         Y1nw==
X-Gm-Message-State: ABy/qLZfmc14+9d+Px801Gd/BBxnIkAOTjnOSEhzwdR2oZBgBE8LWwln
	d+PWlOYwW2cRPeBaxhLpxjWPEfH7duHNOL+fQXGyUw==
X-Google-Smtp-Source: APBJJlE9SwpJREDV8xCEmxNrhYG76qnWJF7dC5R7su/Hm9zssL6hBOFD4oidawqk/BxBEGlLlZO+2fyI6V8ckax7YrU=
X-Received: by 2002:a05:622a:1a02:b0:3ef:302c:319e with SMTP id
 f2-20020a05622a1a0200b003ef302c319emr255356qtb.8.1690540306630; Fri, 28 Jul
 2023 03:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com> <20230727182647.4106140-7-mshavit@google.com>
 <ZMLjqfp6M6n7HAxl@Asurada-Nvidia> <CAKHBV24bEYboxv9XXPvgt86q2B2DTm2He-mbO=kJqsNijCmMMg@mail.gmail.com>
In-Reply-To: <CAKHBV24bEYboxv9XXPvgt86q2B2DTm2He-mbO=kJqsNijCmMMg@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Fri, 28 Jul 2023 18:31:10 +0800
Message-ID: <CAKHBV25UURAQKEXADpP72Z3HT=EWT4aqnZYcOeus0Pn8jhvyUQ@mail.gmail.com>
Subject: Re: [PATCH v1 6/7] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 3:34=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
>
> On Fri, Jul 28, 2023 at 5:38=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com=
> wrote:
> > > @@ -1101,11 +1094,11 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_d=
omain *smmu_domain, int ssid,
> > >                 cdptr[3] =3D cpu_to_le64(cd->mair);
> > >
> > >                 /*
> > > -                * STE is live, and the SMMU might read dwords of thi=
s CD in any
> > > -                * order. Ensure that it observes valid values before=
 reading
> > > -                * V=3D1.
> > > +                * STE may be live, and the SMMU might read dwords of=
 this CD
> > > +                * in any order. Ensure that it observes valid values=
 before
> > > +                * reading V=3D1.
> >
> > This seems to be true only after the following patch? If so, we
> > should move this part over there too.
>
> This comment is more in theme with the next commit so I can move it
> over. But FWIW, the fact that the STE is not necessarily live at this
> location is true before this patch, in this patch, and after the
> following patch. Fixing this comment is just a drive-by, not a result
> of any of these changes.

Whoops, I mean more in theme with the previous commit.
