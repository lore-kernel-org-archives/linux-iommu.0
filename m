Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF2E1D2AF
	for <iommu@lists.linux.dev>; Thu, 11 May 2023 14:25:59 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ab0bad2587so3005929a34.3
        for <iommu@lists.linux.dev>; Thu, 11 May 2023 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683815158; x=1686407158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUMshOhJ/jCmOAXf0wSXeoJInJRRSEiHUd4QhJk0RRA=;
        b=DBl+lObSFhApj2jZOTQrUAOrwRIAf4xArfq5YCzK0SszrY7+8QX++/DM1qlgt14Z4R
         qEopsANTv+hPnlePep+XdcNtxdNulvw4P5qNfXchJTTbUCd4MSP29UPZAWuBhn0ffsNe
         uhXM+8dw1jy9CJHT+Ql38XqBeVvflRY7TBo3m4f6CCuzjIKoMFKj/JS2HWrh7bdfKWuB
         jUFxRKvMdOMAQoKc0pJI563yjY1+zqSRmyDiRVXpx0HsB3WrccNCpvBiX+VEv4xtPcB7
         UtSTAo8Q5KxkKiY0EdMzMlhESgiq2VDLZO4Z51EjGPKslAyjqv3+PuBbQGS8w2KckX/T
         1POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815158; x=1686407158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUMshOhJ/jCmOAXf0wSXeoJInJRRSEiHUd4QhJk0RRA=;
        b=SMIE9EHPfLVnph3MRpPqYlu7T6iDWiz1zEbxp4I/ZUnY6nahthbZU5bqdIp5yiPTmp
         mssEjCPjPD/GK3KQvq1lvmrwgrm/1siNV1a04I6c8+5c5qceqNgw7WMtx2EzdNcpEQr3
         qdP/1ybBsPUYrBmZloM+WtQk+DrEBhv65Ao0unn+YpQ3x2h8hgIHoeiE7jhvX03iPLU3
         KZbSeEZBx79RgAFBXv4huis+OultUkqDgI5f/sYedT7QcA0R0rzcQ98bHpu8DL42wAGj
         b2de0gmlKSAKRkm1QEeXb3AGVM53Z2lOI6lqHOvueGYaal0WibLVusTOWE/4ppW3Bq5+
         ulkg==
X-Gm-Message-State: AC+VfDxeb4walsdpUniWWqcwEWSvJL1UwB9Kj6ak1NalX8kUlOM5Axd/
	/ZXKvjpyg9mXHy5KthxPkYTUGN0a360ok0zhvzY=
X-Google-Smtp-Source: ACHHUZ7poZgOitdfQqtIlPzYx5Qk56gFW9JRYK0fJ/hsY7AKW7RFp3/ZwhYX+SOn+yAUhmAJCncEuRY5yF/6vgL4jRQ=
X-Received: by 2002:a05:6808:59:b0:38e:eaf:cf29 with SMTP id
 v25-20020a056808005900b0038e0eafcf29mr4889151oic.29.1683815157913; Thu, 11
 May 2023 07:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230509163712.376117-1-robdclark@gmail.com>
In-Reply-To: <20230509163712.376117-1-robdclark@gmail.com>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 11 May 2023 07:25:46 -0700
Message-ID: <CAF6AEGv4kThhyCEhf3NeqTSwVT5X7rgxM5nuM_jq3aFbfUHpqA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
To: dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rob Clark <robdclark@chromium.org>, 
	Lepton Wu <lepton@chromium.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Emma Anholt <emma@anholt.net>, 
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 9, 2023 at 9:37=E2=80=AFAM Rob Clark <robdclark@gmail.com> wrot=
e:
>
> From: Rob Clark <robdclark@chromium.org>
>
> When the special handling of qcom,adreno-smmu was moved into
> qcom_smmu_create(), it was overlooked that we didn't have all the
> required entries in qcom_smmu_impl_of_match.  So we stopped getting
> adreno_smmu_priv on sc7180, breaking per-process pgtables.
>
> Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu chec=
k into qcom_smmu_create")
> Suggested-by: Lepton Wu <lepton@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Any chance I could get an ack for landing this fix via msm-fixes?
Broken per-process pgtables is kind of a serious regression..

BR,
-R

> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/a=
rm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..760d9c43dbd2 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -496,20 +496,21 @@ static const struct qcom_smmu_match_data qcom_smmu_=
500_impl0_data =3D {
>  /*
>   * Do not add any more qcom,SOC-smmu-500 entries to this list, unless th=
ey need
>   * special handling and can not be covered by the qcom,smmu-500 entry.
>   */
>  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[=
] =3D {
>         { .compatible =3D "qcom,msm8996-smmu-v2", .data =3D &msm8996_smmu=
_data },
>         { .compatible =3D "qcom,msm8998-smmu-v2", .data =3D &qcom_smmu_v2=
_data },
>         { .compatible =3D "qcom,qcm2290-smmu-500", .data =3D &qcom_smmu_5=
00_impl0_data },
>         { .compatible =3D "qcom,qdu1000-smmu-500", .data =3D &qcom_smmu_5=
00_impl0_data  },
>         { .compatible =3D "qcom,sc7180-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> +       { .compatible =3D "qcom,sc7180-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
>         { .compatible =3D "qcom,sc7280-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
>         { .compatible =3D "qcom,sc8180x-smmu-500", .data =3D &qcom_smmu_5=
00_impl0_data },
>         { .compatible =3D "qcom,sc8280xp-smmu-500", .data =3D &qcom_smmu_=
500_impl0_data },
>         { .compatible =3D "qcom,sdm630-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
>         { .compatible =3D "qcom,sdm845-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
>         { .compatible =3D "qcom,sdm845-smmu-500", .data =3D &sdm845_smmu_=
500_data },
>         { .compatible =3D "qcom,sm6115-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data},
>         { .compatible =3D "qcom,sm6125-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
>         { .compatible =3D "qcom,sm6350-smmu-v2", .data =3D &qcom_smmu_v2_=
data },
>         { .compatible =3D "qcom,sm6350-smmu-500", .data =3D &qcom_smmu_50=
0_impl0_data },
> @@ -540,12 +541,14 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct =
arm_smmu_device *smmu)
>                 /* Match platform for ACPI boot */
>                 if (acpi_match_platform_list(qcom_acpi_platlist) >=3D 0)
>                         return qcom_smmu_create(smmu, &qcom_smmu_500_impl=
0_data);
>         }
>  #endif
>
>         match =3D of_match_node(qcom_smmu_impl_of_match, np);
>         if (match)
>                 return qcom_smmu_create(smmu, match->data);
>
> +       WARN_ON(of_device_is_compatible(np, "qcom,adreno-smmu"));
> +
>         return smmu;
>  }
> --
> 2.40.1
>
