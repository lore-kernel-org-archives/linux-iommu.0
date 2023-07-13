Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B012DDCD
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 08:42:23 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-401d1d967beso187011cf.0
        for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689237742; x=1691829742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yM9D8Wn4tf81KIGl10BLC3f+dDmdYxYtYbJJvo+qETw=;
        b=LIIrcTlJ/0S9iLkK/yCdCp/74+2+s9KCAkZF+YQBFPiyj+s4mpNMGSfmb6RmKFYOwx
         vXuFS2VYcpBaOh0dypk6/GhVcCn8x3jzWfr12TSocnLU0Hq95pQCPs4Yo4zOyX2xdbh+
         kapgsUfLjn3WqZYtLdq6aQSBaMtvZKPGekJpq1XuYX3eUKXM2zA1snATLp7wfe8E3ltf
         WMg1P8RcLalncYXCq9SMjdheEN9X+RsQSSzCq+bV5XMYZDmZzz2d0JCtAPECfVs62KkN
         ssigb3A+7qzyNmXLoS5xgB31AO3QRFuI5xKr3nQPzGrscrxBsKDAdlRj9Phe7kK263Ok
         UuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237742; x=1691829742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yM9D8Wn4tf81KIGl10BLC3f+dDmdYxYtYbJJvo+qETw=;
        b=ZT0pP3UrNBVlui5hb0UQ3vNsyxhu3tDUOU8uUzj1oFh4RixBzbS8k3CKOBBJFngLUK
         5iRyyKYbBNLp6g5F2TYyjsuyJ3UckYDiEmOpchtTScR/AjMMfSySb6XXf25Bo/HnEd1z
         /74EeEBBBL9ApsofaHccL2R+xJvfCAxEVgeVKAllht2YWBgvxUZN3DxYe7/T8H7qG1DX
         Mxg0gaG3F+A/X8AgCDsI5w/5N9WvmKtZoUgVsduvpfhyvel90NCGUoIuGInk/keSeayV
         2YfWqt1oHOkxhBUfYH1ykwrTzNqHSjQ1xc0rs0ww0hwmhj/44e90t8TIbg5k5uSoc/3w
         hB5A==
X-Gm-Message-State: ABy/qLYU7GkFBo4Z7ZQ1pwn0pbN9j+xmQLd+IDfEE6fg5vr2Z4XwW2cI
	WpDSLVco8RISdxJ9br87utkFnZM8H7tfPW/8cqyLeA==
X-Google-Smtp-Source: APBJJlGFCkELb9W0qLcD6Ra+EXy+AX80hvNLPJL36UOj2Zni8xwtiqtqy2trSWa7UrvWFggoM5iaNxg4YHXZTUoQUtA=
X-Received: by 2002:a05:622a:301:b0:403:ac9c:ac2f with SMTP id
 q1-20020a05622a030100b00403ac9cac2fmr380524qtw.17.1689237741861; Thu, 13 Jul
 2023 01:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-13-mshavit@google.com>
In-Reply-To: <20230621063825.268890-13-mshavit@google.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 13 Jul 2023 16:41:45 +0800
Message-ID: <CAKHBV24UZgcXyKd_L1s+Cvujw_Y1NDWXm+=xO=y4Z1GPb=Gmew@mail.gmail.com>
Subject: Re: [PATCH v4 12/13] iommu/arm-smmu-v3-sva: Remove arm_smmu_bond
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: jean-philippe@linaro.org, nicolinc@nvidia.com, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Wed, Jun 21, 2023 at 2:44=E2=80=AFPM Michael Shavit <mshavit@google.co=
m> wrote:
> @@ -545,23 +534,12 @@ void arm_smmu_sva_notifier_synchronize(void)
>  void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
>                                    struct device *dev, ioasid_t id)
>  {
> -       struct mm_struct *mm =3D domain->mm;
> -       struct arm_smmu_bond *bond =3D NULL, *t;
> +       struct arm_smmu_sva_domain *sva_domain =3D to_sva_domain(domain);
>         struct arm_smmu_master *master =3D dev_iommu_priv_get(dev);
>
>         mutex_lock(&sva_lock);
> -       list_for_each_entry(t, &master->bonds, list) {
> -               if (t->mm =3D=3D mm) {
> -                       bond =3D t;
> -                       break;
> -               }
> -       }
> -
> -       if (!WARN_ON(!bond)) {
> -               list_del(&bond->list);
> -               arm_smmu_mmu_notifier_put(bond->smmu_mn);
> -               kfree(bond);
> -       }
> +       master->nr_attached_sva_domains -=3D 1;
> +       arm_smmu_mmu_notifier_put(sva_domain->smmu_mn);
>         mutex_unlock(&sva_lock);
>  }

I've encountered a bug with this change while working on a follow-up
series. arm_smmu_sva_remove_dev_pasid() is called on the domain if
arm_smmu_sva_set_dev_pasid failed. Removing the WARN_ON(!bond)
condition removed a protection against that scenario. I have a fix for
this change that I'll push into a v5 of the series.
