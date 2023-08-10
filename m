Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EC1EA65
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 09:24:14 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-40c72caec5cso169311cf.0
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691659454; x=1692264254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UvmlkjRaUwStD8KrOqZaQANSxCF6BiZRXjgKYWBLx+w=;
        b=XwtH4iwzGr5CwV7pQZ0W+QC1Vv5v3twEOn1MCsa1chsFp8ykj3mF6ncJL/GyxrxWJV
         4Ys2HBa79AkVfTv4Lttwzvr7CQabdyWQo0WyUJ3Wkatmr/A40BRrblkcp6mJoi4JGss6
         U/S1tksRh2luHIVkYDBg8vS+yOEsAQxjl3bk8toHfG5jn7VVotvWcCWUvlX+ulmJ4eUX
         suOMY8v2rnIasVijgnQgtHceJu0p32/W1Dzh4X4+rmAfZk4iAsJGM7dOIOuVA+9pwCpO
         nyXWpnFg7cW9KrUO/ijReoAaXuaXKBHGro+PDqgpJ90z5d1eggZsy+YCFPAPAxKTOGti
         cKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691659454; x=1692264254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvmlkjRaUwStD8KrOqZaQANSxCF6BiZRXjgKYWBLx+w=;
        b=V9idQBqQ2zucsVkrQAQ6lVgN28PS/2riR+2u4olkY6jxeZP4pE79sYv0yluD3cL6Rm
         bJgcM78B6rrPLRBkYwjlg+XY7wmwyRvEdc8NNdV900Bqx4hOpzMno8kRS2Y4nrCh+f01
         7nHI/rBw3LbwlDZ3VGvCtUMaSFZIoMAbmwl1IZJyOOsuae5eT2HJM8825TdWWbsHUZ8t
         gMyhoOhIDNq8lNjzdSY7Bmq33zRbmZ26/UEdwrcY0A61b+9Bz/klHIXMStTcUif0feIQ
         9/WSR68681uYGpMHNGkvnYG62Ij4R7dx7srVMqrUWkJ0l5ISoIk0Gu1IHiEgX2ylt4eW
         C4Hg==
X-Gm-Message-State: AOJu0YwTwsQzlgX1QA1KbFJSFHm8E9RJfQ0rXc4WLvZ/w47FF7k297Ah
	f2Zhrel42kHfuvgnEH4tHe67tRugtPEibjFWIYQNTw==
X-Google-Smtp-Source: AGHT+IEvxkkOOdQAeawTNBRXfZVPIuyN1RySq0hwMmVFjhEczedgs9oTSeoBmtpEvPQwpib+CFb1hglaX812zPHc57w=
X-Received: by 2002:a05:622a:cb:b0:3f8:5b2:aef2 with SMTP id
 p11-20020a05622a00cb00b003f805b2aef2mr440070qtw.26.1691659453665; Thu, 10 Aug
 2023 02:24:13 -0700 (PDT)
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
Date: Thu, 10 Aug 2023 17:23:37 +0800
Message-ID: <CAKHBV24ybm1gT+mQs1fDPZY_kGzop8+dQjccP+_qOFCmx69spQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/9] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com, 
	jgg@nvidia.com, jean-philippe@linaro.org
Content-Type: text/plain; charset="UTF-8"

>
> > @@ -2465,6 +2450,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >       if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> >               master->ats_enabled = arm_smmu_ats_supported(master);
> >
> > +     if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> > +             if (!master->cd_table.cdtab) {
> > +                     ret = arm_smmu_alloc_cd_tables(master);
> > +                     if (ret) {
> > +                             master->domain = NULL;
> > +                             return ret;
> > +                     }
> > +             }
> > +
> > +             ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
> > +             if (ret) {
> > +                     master->domain = NULL;
> > +                     return ret;
>
> Can you leak the cd tables here if you just allocated them?

The CD table is only de-allocated when the SMMU device is released, so
this isn't "leaked" anymore than on a successful attachment. In a
previous version of this patch, this CD table was even pre-allocated
at probe time but is deferred to first attach following this
discussion: https://lore.kernel.org/lkml/ZMOzs1%2FxoEPX2+vA@nvidia.com/
.

> > @@ -2472,10 +2473,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> >
> >       arm_smmu_enable_ats(master);
> > -
> > -out_unlock:
> > -     mutex_unlock(&smmu_domain->init_mutex);
> > -     return ret;
> > +     return 0;
> >  }
> >
> >  static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
> > @@ -2719,6 +2717,8 @@ static void arm_smmu_release_device(struct device *dev)
> >       arm_smmu_detach_dev(master);
> >       arm_smmu_disable_pasid(master);
> >       arm_smmu_remove_master(master);
> > +     if (master->cd_table.cdtab_dma)
>
> Why are you checking 'cdtab_dma' here instead of just 'cdtab'?

cd_table is statically allocated as part of the arm_smmu_master
struct. I suppose it could be allocated by arm_smmu_alloc_cd_tables()
instead?
