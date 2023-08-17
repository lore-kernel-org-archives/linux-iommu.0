Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E940CA58
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 08:01:24 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-40a47e8e38dso162241cf.1
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 01:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692259283; x=1692864083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSYgEfTdvrAxuARSdYaVapE5EBsAzwJfjMqZiIg1LHE=;
        b=HnlFIWhlEPQJP28WZqeTEi8kjfstDU/BOdQ1uR4BgtPzon8+OtS9R0sXJ8nLSQcbOH
         AacCIISJ/IRRBqMwzIwITdJ+QwDptepDTY0IEQFRIB1AwrLCcEMPuifH7v3H6RPaNNFT
         hLDC4zVDe/24ppWOduyZnKB+bsmYNm+qJ7eTC8XH9PqnKT/PUghUXNVb4Ie5J1NNg45d
         LnMMm9vKwSBjAKQ+vQGIgrsBHb0wuwjYkr/6548cXfc4OyL6WZAVI7tPEtHLI0NiPGhr
         ed6RPXhryt/Q7tGDbuJtenNPKuUcxbiUddAc6reSdj9yg29mbnO1HaHeDPdCwqp9qHEM
         0QPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692259283; x=1692864083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSYgEfTdvrAxuARSdYaVapE5EBsAzwJfjMqZiIg1LHE=;
        b=jMvb59KtIfU+Xc6ZOVZ+/ZhxrXofwTy3DxZung5s200efJOhziKXcqUejwNxwbtF5j
         V+/0Yxa5sZmD3tAMeFZjF7SApQ4AM94VwK7kqcTCDaMdwiT/65N02/rJD4drpfJaNxJd
         3iwgDLZNHpNZZgWkAR6DQh1v7LDVkuqZALlp9JvUeGuawr/hNN/gEh93HOxYfcHOkAK0
         e7S5ZdtEqM3wtox2Ov0sIm+Uo4gEnBS9Nsj33+gPXO7yQ8QdRSU7qWMO5fVLppEM97L8
         zdHwwSR9Ltx8NowaWIwd+mfLtAoZTD60gq28GnWwuTEU++CAyONVVvDp6n/SnZ81NG/U
         +qMw==
X-Gm-Message-State: AOJu0Yzmmt22+U7R+yzqNfRAPtb1b1MnO72Itlf+WwxFj3Yj2PbvtQzC
	RH3vtZGHwUeC0FjgDq7phMfO0A2vf9JOwu2cxsMwsA==
X-Google-Smtp-Source: AGHT+IHbfgK++65DoATeXiXQdrRY9c9JHcMxJE8038KsOZ10RQC5vGhSDM7cqGbixOzdgwbIWF2fb/9FeL78JYVKP1A=
X-Received: by 2002:a05:622a:1052:b0:403:a43d:bd7d with SMTP id
 f18-20020a05622a105200b00403a43dbd7dmr235775qte.4.1692259282809; Thu, 17 Aug
 2023 01:01:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230816131925.2521220-1-mshavit@google.com> <20230816211849.v6.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
 <ZN1Piqq8EpwOy2e6@Asurada-Nvidia>
In-Reply-To: <ZN1Piqq8EpwOy2e6@Asurada-Nvidia>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 17 Aug 2023 16:00:46 +0800
Message-ID: <CAKHBV25KdKtqsMEOLUe50oFh8KR-8uP8HO=mMC2wmv7Mc99WoA@mail.gmail.com>
Subject: Re: [PATCH v6 05/10] iommu/arm-smmu-v3: Refactor write_ctx_desc
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org, 
	jean-philippe@linaro.org, jgg@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 6:37=E2=80=AFAM Nicolin Chen <nicolinc@nvidia.com> =
wrote:
>
> On Wed, Aug 16, 2023 at 09:18:45PM +0800, Michael Shavit wrote:
>
> > +/*
> > + * Write the CD to the CD tables for all masters that this domain is a=
ttached
> > + * to. Note that this is used to update the non-pasid CD entry when SV=
A takes
> > + * over an existing ASID, as well as to write new pasid CD entries whe=
n
> > + * attaching an SVA domain (although the domain passed as the paramete=
r is the
> > + * RID domain that this domain is mapped to).
> > + */
> > +static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smm=
u_domain,
>
> Iterating the entire device list of a domain looks like the
> arm_smmu_atc_inv_domain(). So it feels to me that it could be
> called arm_smmu_write_ctx_desc_domain()? Not a critical thing
> though..
>
> > +                                          int ssid,
> > +                                          struct arm_smmu_ctx_desc *cd=
)
> > +{
> > +       struct arm_smmu_master *master;
> > +       unsigned long flags;
> > +       int ret;
> > +
> > +       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > +       list_for_each_entry(master, &smmu_domain->devices, domain_head)=
 {
> > +               ret =3D arm_smmu_write_ctx_desc(master, ssid, cd);
> > +               if (ret) {
> > +                       list_for_each_entry_from_reverse(master, &smmu_=
domain->devices, domain_head)
> > +                               arm_smmu_write_ctx_desc(master, ssid, N=
ULL);
>                                                                         ^
> Here it always reverts back to NULL, which isn't ideal since
> an CD entry could be something valid other than NULL prior to
> this function call. IIUIC the conversation in v5, we'd need
> another SVA series to clean up domain sharing, so this would
> be cleaned up too after that? If so, perhaps we could note it
> down in the comments above too.

Technically this is OK because it can only fail when an entirely new
CD entry is written. Honestly I'm tempted to revert the addition of
this helper function, especially as it ends up further complicated in
next patches since it has to deal with the fact that it's used to
update PASID-entries-on-RID-domains as well as the non pasid CD
entries for the asid-sharing case.

>
> > @@ -2458,8 +2446,7 @@ static int arm_smmu_attach_dev(struct iommu_domai=
n *domain, struct device *dev)
> >                 ret =3D -EINVAL;
> >                 goto out_unlock;
> >         } else if (smmu_domain->stage =3D=3D ARM_SMMU_DOMAIN_S1 &&
> > -                  smmu_domain->cd_table.stall_enabled !=3D
> > -                          master->stall_enabled) {
> > +                  smmu_domain->cd_table.stall_enabled !=3D master->sta=
ll_enabled) {
> >                 ret =3D -EINVAL;
> >                 goto out_unlock;
>
> This doesn't seem to be a related change? Probably should be in
> one of the previous patches, or just dropped.

Whoops, must have sneaked in during a rebase.
