Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0637717AB9
	for <iommu@lists.linux.dev>; Tue, 29 Aug 2023 14:30:12 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-79277cfc73bso164179439f.1
        for <iommu@lists.linux.dev>; Tue, 29 Aug 2023 07:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693319412; x=1693924212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li72CkXM16Ln9NW3SPhtKIIZifBFJt90AY2kX9Azf5I=;
        b=Jnx5M6bNanT9jKvTXo4B/6KQpx9DZGN/gL7USk9V2Ephg9WkVe/1pFuSAazCAfH4e2
         0t0dko42o9F6+nunniwbsMLZuJQ+suy0fNN/rsUQ7Sdx2sL4sD3DIa5z1aPkhYUuF9UP
         /OX1yZx2v9YktyZDjlcJK+iG0ONrHuZ3J6a88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693319412; x=1693924212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li72CkXM16Ln9NW3SPhtKIIZifBFJt90AY2kX9Azf5I=;
        b=H3FOK3TWRpWqvDsCqJoTnY202VZO1ES3EzUQhrG4Lj+d07AwMoWXAb6HSn1goxMJ91
         D0m3m1h94e+O8DQqKXnham62i7RNwgWAMnV07HBAczPPQRIJ1J4MWz9kptH0yxWB6P33
         tQJaoxE/1dSzkUdpCNJ1CSD17TSj+2wf+nxTWgS6d9yRB5ndfqXszgyGIsZwy1L5u7uS
         2mzoXr3IkAmjLE5Sig8iIzyIfoShJU8BdNbxMsUlR7m1p51dP+nVw9RWp7zUdW38zzYG
         eapcWFQhULguOFJidq+qg2x108h5iDeQD/cHixzcIGC/ySCrJz18zN6n85/EGJ7Q6T4z
         zxqw==
X-Gm-Message-State: AOJu0Yzk9uH3TL7VQtY4YmENoRjj3p013K5c3ikOrOkFfiA+pvasllzo
	hSsyhX+R4O7fYfAS1SdteLrNRSQb3jrQI9s1eKppQQ==
X-Google-Smtp-Source: AGHT+IGO4I5Tjwq0xJwAXsidjN2LFdllCHmzJnVKdXqiUOEZhZjIq+GyLgok+D/dPf4otxt2I7zDEUOXnnCkwaI6NGc=
X-Received: by 2002:a5e:aa0f:0:b0:791:385c:f8b0 with SMTP id
 s15-20020a5eaa0f000000b00791385cf8b0mr20800696ioe.3.1693319411828; Tue, 29
 Aug 2023 07:30:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230816225509.11070-1-quic_aprasann@quicinc.com>
 <CAJs_Fx7132o3iHDH0ZR7L9G69o2YV2-jC0v15shQcEhH6=-6RA@mail.gmail.com> <c06a31fd-e3b5-1f58-9e4f-7fafd8aa3f28@quicinc.com>
In-Reply-To: <c06a31fd-e3b5-1f58-9e4f-7fafd8aa3f28@quicinc.com>
From: Rob Clark <robdclark@chromium.org>
Date: Tue, 29 Aug 2023 07:30:01 -0700
Message-ID: <CAJs_Fx464vFbfLaaWWs2Y0pTmhXrJS=AWFTwEyQjifJoU72rCQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/arm-smmu-qcom: NULL pointer check for driver data
To: Aravind Vijayakumar <quic_aprasann@quicinc.com>
Cc: will@kernel.org, joro@8bytes.org, robin.murphy@arm.com, 
	dmitry.baryshkov@linaro.org, quic_bjorande@quicinc.com, 
	konrad.dybcio@linaro.org, quic_eberman@quicinc.com, quic_psodagud@quicinc.com, 
	quic_rvishwak@quicinc.com, quic_saipraka@quicinc.com, 
	quic_molvera@quicinc.com, marijn.suijten@somainline.org, mani@kernel.org, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 2:35=E2=80=AFPM Aravind Vijayakumar
<quic_aprasann@quicinc.com> wrote:
>
>
> On 8/16/2023 6:01 PM, Rob Clark wrote:
> > On Wed, Aug 16, 2023 at 3:55=E2=80=AFPM Aravind Vijayakumar
> > <quic_aprasann@quicinc.com> wrote:
> >> The driver_data is NULL when qcom_adreno_smmu_init_context()
> >> is called before the dev_set_drvdata() from the client driver
> >> and is resulting in kernel crash.
> >>
> >> So add a null pointer check to handle the scenario
> >> where the client driver for the GPU SMMU device would
> >> be setting the driver data after the smmu client device
> >> probe is done and not necessarily before that. The function
> >> qcom_adreno_smmu_init_context() assumes that the client
> >> driver always set the driver data using dev_set_drvdata()
> >> before the smmu client device probe, but this assumption
> >> is not always true.
> >>
> >> Signed-off-by: Aravind Vijayakumar <quic_aprasann@quicinc.com>
> >> ---
> >>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iomm=
u/arm/arm-smmu/arm-smmu-qcom.c
> >> index c71afda79d64..5323f82264ca 100644
> >> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> >> @@ -231,6 +231,9 @@ static int qcom_adreno_smmu_init_context(struct ar=
m_smmu_domain *smmu_domain,
> >>           */
> >>
> >>          priv =3D dev_get_drvdata(dev);
> >> +       if (!priv)
> >> +               return 0;
> > could this -EPROBE_DEFER instead, or something like that?  I think you
> > patch as proposed would result in per-process gpu pgtables silently
> > failing
> >
> > BR,
> > -R
>
> Thanks for the review comments. Returning -EPROBE_DEFER wont work
> because the probe of the client driver (which sets the driver data) will
> never get triggered. However, the probe of the client driver succeeds if
> we return -ENODATA. would that be acceptable?

I _think_ so.. I need to page back in the sequence of how this works,
but I do have some warn_on's in drm/msm to complain loudly if we don't
get per-process pgtables.  I'd be interested to see the callstack
where you hit this issue.  From what I remember the sequence should
be:

1) before the client dev probes, arm-smmu probes and attaches the
dma-api managed iommu_domain (which IIRC should be an identity domain,
and is otherwise unused).. at this point drvdata is NULL
2) the drm/msm can probe
3) at some point later when GPU fw is avail the GPU is loaded, drvdata
is set, and we start creating and attaching the iommu_domain's that
are actually used (one for kernel context and one each for userspace
processes using the GPU

I guess maybe if you are hitting this case of NULL drvdata, then you
aren't getting an identity context for the dma-api managed
iommu_domain?

BR,
-R


> Regards,
>
> Aravind
>
> >> +
> >>          priv->cookie =3D smmu_domain;
> >>          priv->get_ttbr1_cfg =3D qcom_adreno_smmu_get_ttbr1_cfg;
> >>          priv->set_ttbr0_cfg =3D qcom_adreno_smmu_set_ttbr0_cfg;
> >> --
> >> 2.40.1
> >>
