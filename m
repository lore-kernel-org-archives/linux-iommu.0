Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9CD9479
	for <iommu@lists.linux.dev>; Thu,  4 May 2023 18:08:13 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-54c8fc45273so540138eaf.1
        for <iommu@lists.linux.dev>; Thu, 04 May 2023 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683223693; x=1685815693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xo9ZPKfjYHt2qv3p5XYXld4Ww9M7Eu/gP5wGsS4ugts=;
        b=WmWVKQdJ4kXpxuDVsTGYJXirxdfh0MpwgYxg+cJIDorj84aAA747e+u5D02g/tlCQJ
         SElVskW438vl4UQIDmOst73rTFpI6dukamAMyZfOFCVfCfWHSED3VoKWCgNYZ49lTtO6
         2vRE/TW7REDJB5NkIQDU99BqdP4lnY4qOoXuxmGL7DrsQOL+ybYLS0PRb5S+bJcKowPe
         sPdZrz8oEgGBJBfJ8YmhdWJl6G/eUC36Y1RhrPXpQqcNYHOxWTk0l8zykCqqI+kaKJ6B
         ap1+/HEzMtarpW50cILkegl3hIBqblIdTmz9Hl9tGAzI9JXiGOM74LV8in25vIYVoCim
         650g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683223693; x=1685815693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo9ZPKfjYHt2qv3p5XYXld4Ww9M7Eu/gP5wGsS4ugts=;
        b=BicVfWWAC2RXoCxHLi46FkHZhzYsLv+z/xgclr0VOFxhqKur4qRsL6E1j1z0UB5JDh
         Mjq8XaY/ZxpvywMYcq0TRLq54gi08W/RmnlOO4KI3ZWwDznqUFJY1gr7SH0lrS4Zrr+g
         IQJxoCgMZdxFoL1w3UczxFyunMaM6NDqG3YftKxZnT6yEgO5yEK5EgjsfMC/5zDAE5lV
         E09/7YtJuuxMQbcXb9SlQnzROwPo9+FPBwrvfrOpTPZ2nxO9pBIayE/2dTfxG7A92ab4
         8t2eqziUgQEpqELUwzvxBr3NUGjp3+DExyvPraUfpRynLWxhl8DDrEsAPL1kHRxkPCUV
         Bd/A==
X-Gm-Message-State: AC+VfDwUiruPJaQVJulhqv4FknA7Vym2tWZsMB5L3DX/gtO+WO3LiMV5
	mb+evY5Bzxmckq8V+obMRr5qs2WmBXGZci9FdOY=
X-Google-Smtp-Source: ACHHUZ4smDg5nxeRyL73RnMQ8tHc04rAiW534zEE+316+lYeXbVloHvMH7EZuHxsav+tuJowLyvhOsb4Mtk9aeLP8cM=
X-Received: by 2002:a4a:d88c:0:b0:538:57d4:2d62 with SMTP id
 b12-20020a4ad88c000000b0053857d42d62mr12002690oov.2.1683223692626; Thu, 04
 May 2023 11:08:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230502160950.1758826-1-robdclark@gmail.com> <db8ef06b-a729-a085-8671-2b4d99a8e2b2@linaro.org>
In-Reply-To: <db8ef06b-a729-a085-8671-2b4d99a8e2b2@linaro.org>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 4 May 2023 11:08:02 -0700
Message-ID: <CAF6AEGstOTfaKvmaAXbxvoNvs3odJBiASzmip8+x0FNqFoniKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, 
	freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Clark <robdclark@chromium.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 4, 2023 at 10:41=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
>
>
> On 2.05.2023 18:09, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > When the special handling of qcom,adreno-smmu was moved into
> > qcom_smmu_create(), it was overlooked that we didn't have all the
> > required entries in qcom_smmu_impl_of_match.  So we stopped getting
> > adreno_smmu_priv on sc7180, breaking per-process pgtables.
> >
> > Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu ch=
eck into qcom_smmu_create")
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> I believe the issue here is the lack of qcom,sc7180-smmu-v2 instead.
>
> qcom,adreno-smmu does not have to imply the "qcom smmu v2" impl

Yes, but the ordering after "qcom,smmu-500" does.  Currently we just
need the one missing "qcom,sc7180-smmu-v2" but that seemed kind of
fragile to me, which is why I went with "qcom,adreno-smmu" as a
catch-all

BR,
-R

>
> Konrad
> >  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu=
/arm/arm-smmu/arm-smmu-qcom.c
> > index d1b296b95c86..88c89424485b 100644
> > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > @@ -512,20 +512,25 @@ static const struct of_device_id __maybe_unused q=
com_smmu_impl_of_match[] =3D {
> >       { .compatible =3D "qcom,sm6115-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data},
> >       { .compatible =3D "qcom,sm6125-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> >       { .compatible =3D "qcom,sm6350-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
> >       { .compatible =3D "qcom,sm6350-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> >       { .compatible =3D "qcom,sm6375-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> >       { .compatible =3D "qcom,sm8150-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> >       { .compatible =3D "qcom,sm8250-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> >       { .compatible =3D "qcom,sm8350-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> >       { .compatible =3D "qcom,sm8450-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> >       { .compatible =3D "qcom,smmu-500", .data =3D &qcom_smmu_500_impl0=
_data },
> > +     /*
> > +      * Should come after the qcom,smmu-500 fallback so smmu-500 varia=
nts of
> > +      * adreno-smmu get qcom_adreno_smmu_500_impl:
> > +      */
> > +     { .compatible =3D "qcom,adreno-smmu", .data =3D &qcom_smmu_v2_dat=
a },
> >       { }
> >  };
> >
> >  #ifdef CONFIG_ACPI
> >  static struct acpi_platform_list qcom_acpi_platlist[] =3D {
> >       { "LENOVO", "CB-01   ", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU"=
 },
> >       { "QCOM  ", "QCOMEDK2", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU"=
 },
> >       { }
> >  };
> >  #endif
