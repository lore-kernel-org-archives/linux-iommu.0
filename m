Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39078839
	for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 08:45:22 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-401d1d967beso188361cf.0
        for <iommu@lists.linux.dev>; Thu, 13 Jul 2023 01:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689237921; x=1691829921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q79c/OvfP4qr4NBPZHCFLwvY8dzwJlyvbkHoNMl1ds=;
        b=3bjgVTIt1JTtnkHk+MgnbYdzDKrD/JqGAViWxl4ZRYiEZ3tGle1rnB2YGtKEoQ4IrP
         rQida9wVL+gFpg4A+H+P5BOX5TtFJEkAqrPlrFhsyyaXWlU60ubx3DVrfbygIz4/+aQ+
         YnQQkmI+RQQJfbx0PUu6qo5fFf0I+F4fNcwOPvrTE2zuarH5ueitaMv4isrMBe59HTtc
         yd7zNW2re8vay05D5k8OtZmr52v0067Yjp1iLI4IAePtuyDFht+yQuCNZb0AKqULukuA
         Lp9wdxmatiUpkqwuzlcUpBE1yRcm3y3ptV9erV5qlVlH6jozJo9oiqCPk8pXbfSPxyar
         s/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689237921; x=1691829921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q79c/OvfP4qr4NBPZHCFLwvY8dzwJlyvbkHoNMl1ds=;
        b=Hu5QnU8NmjmWDH0EP5tshG+KCLjReCf+ptReNcgeTh0v4vf0UgC18U9+0hboZRFoyW
         CnuaMUUER3EZHM9madHGJ+gCO9XshxI7p1X8A8T8NMlXo1DyxUFuwZODEFCZIZlMzLDh
         bfn1LXI5Zh/ilTYxPt3h3EDCklQfzS+D0PG+9Z9zmPNvMJTmuxK3UTXuHQlFMB5VYD4g
         9Pa0jB7sFoeKOfuqvEZp7Q7oGXbuMuHLL/KNJvdv7BqoKurQlEe9xW9CdGHeizSZxbcx
         kvGdZtI1hXr3MxhJlQ4AcsQaY+jt6Eu+HMVDRThAePiEvQCqMHINsnkClBfX4GQFUlY0
         FIKA==
X-Gm-Message-State: ABy/qLbEkl8/s7mO+m8rNF/WDYfVNGINozu76dIRjCCUnr5D6VvgbOk6
	sKRvglZ/oRnn3e07BJC1acq8tm1C9iX78sZyZ7QeHA==
X-Google-Smtp-Source: APBJJlHXesm+i+xAfOeS9zP/btd2JTeNsiyCDuYNbetw72DcwsPYgQxuCw2/cvFIS2FdMjWEX21pSxBW8kzjGULMJHs=
X-Received: by 2002:ac8:5b8b:0:b0:403:b6ff:c0b with SMTP id
 a11-20020ac85b8b000000b00403b6ff0c0bmr515839qta.6.1689237921386; Thu, 13 Jul
 2023 01:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-10-mshavit@google.com>
In-Reply-To: <20230621063825.268890-10-mshavit@google.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 13 Jul 2023 16:44:45 +0800
Message-ID: <CAKHBV24gX6nuCeb2O13XPLw7aohi95ReZfqKVtX1X05WM7LZQg@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] iommu/arm-smmu-v3: Implement set_dev_pasid
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>
Cc: jean-philippe@linaro.org, nicolinc@nvidia.com, jgg@nvidia.com, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 2:44=E2=80=AFPM Michael Shavit <mshavit@google.com>=
 wrote:
> +       mutex_lock(&arm_smmu_asid_lock);
> +       ret =3D arm_smmu_write_ctx_desc(master->smmu, master->s1_cfg, mas=
ter,
> +                                     pasid, &smmu_domain->cd);
> +       if (ret) {
> +               mutex_unlock(&arm_smmu_asid_lock);
> +               kfree(attached_domain);
> +       }
> +
> +       spin_lock_irqsave(&smmu_domain->attached_domains_lock, flags);
> +       list_add(&attached_domain->domain_head, &smmu_domain->attached_do=
mains);
> +       spin_unlock_irqrestore(&smmu_domain->attached_domains_lock, flags=
);
> +       mutex_unlock(&arm_smmu_asid_lock);
> +
> +       return 0;

A small bug in this patch as well: we return 0 when
arm_smmu_write_ctx_desc() fails instead of the error. Will upload fix
in v5.
