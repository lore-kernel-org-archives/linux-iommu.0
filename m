Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CB36D
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 14:58:03 +0000 (UTC)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-541f2112f82so2891008eaf.1
        for <iommu@lists.linux.dev>; Thu, 11 May 2023 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683817083; x=1686409083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKh9RanEco8HkFU0f9YQUCI4J1uPooBwGH0J45ObAN4=;
        b=sfcr2gDmpA6MfW6T3fpKqQu/TnYVeZ0fxsPI86zsuUPnzmWasEialKeKTWXqS7u4D4
         nXAmdFPbkhVAxyjP9VrIVNaQNudJ45aNUqOCRB1IGcVfzLaPYqZpk+FHaEBKvM4nIvJa
         BrPZct/zhxfL5d8xAhEPBCe8Pfoeiko4NS+WsyWv/hMoEfjeE9l5SUEVkELWJLepsLWO
         bNVm6P2m43HS86NR/CHCBAMuP+OUM4yG/cZymVNXUrdib1sLGRStWZXVcJ6goiUPJ0H5
         WyjurJUrawTO+PfgOG+D+RJVm+oh27AwT+1gMmuyz1gnnZa2+3OFg+h2Xyq1OF/88BMz
         +fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683817083; x=1686409083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKh9RanEco8HkFU0f9YQUCI4J1uPooBwGH0J45ObAN4=;
        b=YfOdfrSrOc4WH6qnFTE2WPaLNIihTt0ugi+ltRzZRcoW3M+05duM75JboroN5uC0PP
         /nJ4Izjirt/lpebgTUwWRTOkS85LzF0oY/9OVdTO2HtSQcBz9MMFYGmsvYH8/ZO7oN0l
         15HR0bHDrTZr3EFBnClXrrN3FvPfb2i7wGN1CpD8+dM1+FBfi9rOryhYtWOjkFNQexAq
         Jk6BBnZB99phLyYbndieVRhMPB9r0TLLfiurEDFodFuhkTru2MVK+5a7TINwoz+sC4ln
         tMZlsFjBU7O7XnqV6TQ4XSPE7kvGgZTNrpPIXgUuyU2A0ohDHTN/pO1Ci0H8IUSEVQbR
         fsWw==
X-Gm-Message-State: AC+VfDwlsXLB+BzQKw2Icbkr1EJuHDXVI+Oojaypm0P87/qjtFUKvTDO
	Ss9Sg+LNakNQx3V4Kqj3Th9Zod+JBI3tDoh+q3d9RGKY
X-Google-Smtp-Source: ACHHUZ5Khr1M1krofX3oPdVbeyqlHZyoM2Fi52Fky/qFtI72qyW77RliSQNSaGdqi6r11ujdm5AjYBayy415E9N3LzQ=
X-Received: by 2002:a4a:7606:0:b0:54f:54b3:cb9c with SMTP id
 t6-20020a4a7606000000b0054f54b3cb9cmr4931936ooc.1.1683817082839; Thu, 11 May
 2023 07:58:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230509163712.376117-1-robdclark@gmail.com> <CAA8EJppVaCuh1kp7842pHt=5sWSBVaf18fZGC6ifmsQKgGNVSw@mail.gmail.com>
In-Reply-To: <CAA8EJppVaCuh1kp7842pHt=5sWSBVaf18fZGC6ifmsQKgGNVSw@mail.gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 11 May 2023 07:57:51 -0700
Message-ID: <CAF6AEGuX721j41jCco1B6F_TW3EO3_W6+JDmh3S7Dfd62iAv7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Rob Clark <robdclark@chromium.org>, Lepton Wu <lepton@chromium.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Emma Anholt <emma@anholt.net>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2023 at 7:51=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 9 May 2023 at 19:37, Rob Clark <robdclark@gmail.com> wrote:
> >
> > From: Rob Clark <robdclark@chromium.org>
> >
> > When the special handling of qcom,adreno-smmu was moved into
> > qcom_smmu_create(), it was overlooked that we didn't have all the
> > required entries in qcom_smmu_impl_of_match.  So we stopped getting
> > adreno_smmu_priv on sc7180, breaking per-process pgtables.
> >
> > Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu ch=
eck into qcom_smmu_create")
> > Suggested-by: Lepton Wu <lepton@chromium.org>
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom.c
> > index d1b296b95c86..760d9c43dbd2 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -496,20 +496,21 @@ static const struct qcom_smmu_match_data qcom_smm=
u_500_impl0_data =3D {
> >  /*
> >   * Do not add any more qcom,SOC-smmu-500 entries to this list, unless =
they need
> >   * special handling and can not be covered by the qcom,smmu-500 entry.
> >   */
> >  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_matc=
h[] =3D {
> >         { .compatible =3D "qcom,msm8996-smmu-v2", .data =3D &msm8996_sm=
mu_data },
> >         { .compatible =3D "qcom,msm8998-smmu-v2", .data =3D &qcom_smmu_=
v2_data },
> >         { .compatible =3D "qcom,qcm2290-smmu-500", .data =3D &qcom_smmu=
_500_impl0_data },
> >         { .compatible =3D "qcom,qdu1000-smmu-500", .data =3D &qcom_smmu=
_500_impl0_data  },
> >         { .compatible =3D "qcom,sc7180-smmu-500", .data =3D &qcom_smmu_=
500_impl0_data },
> > +       { .compatible =3D "qcom,sc7180-smmu-v2", .data =3D &qcom_smmu_v=
2_data },
> >         { .compatible =3D "qcom,sc7280-smmu-500", .data =3D &qcom_smmu_=
500_impl0_data },
> >         { .compatible =3D "qcom,sc8180x-smmu-500", .data =3D &qcom_smmu=
_500_impl0_data },
> >         { .compatible =3D "qcom,sc8280xp-smmu-500", .data =3D &qcom_smm=
u_500_impl0_data },
> >         { .compatible =3D "qcom,sdm630-smmu-v2", .data =3D &qcom_smmu_v=
2_data },
> >         { .compatible =3D "qcom,sdm845-smmu-v2", .data =3D &qcom_smmu_v=
2_data },
> >         { .compatible =3D "qcom,sdm845-smmu-500", .data =3D &sdm845_smm=
u_500_data },
> >         { .compatible =3D "qcom,sm6115-smmu-500", .data =3D &qcom_smmu_=
500_impl0_data},
> >         { .compatible =3D "qcom,sm6125-smmu-500", .data =3D &qcom_smmu_=
500_impl0_data },
> >         { .compatible =3D "qcom,sm6350-smmu-v2", .data =3D &qcom_smmu_v=
2_data },
> >         { .compatible =3D "qcom,sm6350-smmu-500", .data =3D &qcom_smmu_=
500_impl0_data },
> > @@ -540,12 +541,14 @@ struct arm_smmu_device *qcom_smmu_impl_init(struc=
t arm_smmu_device *smmu)
> >                 /* Match platform for ACPI boot */
> >                 if (acpi_match_platform_list(qcom_acpi_platlist) >=3D 0=
)
> >                         return qcom_smmu_create(smmu, &qcom_smmu_500_im=
pl0_data);
> >         }
> >  #endif
> >
> >         match =3D of_match_node(qcom_smmu_impl_of_match, np);
> >         if (match)
> >                 return qcom_smmu_create(smmu, match->data);
> >
> > +       WARN_ON(of_device_is_compatible(np, "qcom,adreno-smmu"));
>
> Could you please add a comment here, noting the reason? Or maybe we
> should  change that to:
> if (WARN_ON(...))
>   return ERR_PTR(-EINVAL);

I'll add a comment.  Not having an iommu is even worse, so returning
an error isn't a good idea.  I just wanted to leave some breadcrumbs
so people can see where the problem actually is if per-process
pgtables break again.

BR,
-R

>
> > +
> >         return smmu;
> >  }
> > --
> > 2.40.1
> >
>
>
> --
> With best wishes
> Dmitry
