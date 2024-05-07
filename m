Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA6161313
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096130; cv=none; b=UHCcT5h8BxGr375vr+uDTg+Td/2E64jSWmej0mUuxwmKiuzYQBbwNSDFZqC19Z4hAHqz9VyZjK+5w3twwApZU95UUSy/ZapdX1IIwVh5uPwHDPqcn2DBLEVNJgd9nM7wVqqX2Cm2h/siOCGwkFGv8jU5jYh6c1NHZ5k1ziAzEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096130; c=relaxed/simple;
	bh=AHmd40tFLpuB76nYEEXIiv7NLdIIAMsC68vMChwHn6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uPgJzNZN4ziZDD/4FNfQPjHU48G56CjwMjtU7O73FmcmLeJJmSJheFBBN26kA/vUzJknwvXjLGJuLa+6yXe1j5XaYUXfjVCL2kntrReUPjWQZMOJdmaN4j3QjNYkwpcHdPWwakOHwhG+gjPtoIsbTffeAEJZ5M3SuEG+cJCxa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Y3ni0hgJ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y3ni0hgJ"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7e181fcd763so33440839f.1
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715096128; x=1715700928; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fZeIxGU7jDZbp8MIAMXuP3cI2fycrTuvDnx0IrbFAQ=;
        b=Y3ni0hgJ8RFGxAlFlpiknaDuru9dNDFnlqe+LmPTq7AP6GM2Zu7WHA3QO/ZkFvLo3O
         7MYpME8LlMyEvuPZ/8x4EXGP+Wa2DF6yXWGpGlCq4KDElxfAs7+Bizl+w8Jwif0ajV0z
         NFhEWuB6aDmRzbjOcTo+hJhu0xyw/izMfEv93o/abrVkDxRxQkto65zjNdgfwOgE/YDn
         fJHttY4gTn6t9G7tuOT4MUl9m+MZOv3wt+n9+LaS1PLm8uaQr+WGZTgxdGYHeahwHVJO
         oPSLiNFaEgYAhT449dGPk9itoy2U9qYT71lWQmjWOZUqSvKQ1maDpzFv1ZJ93yapaOaN
         rizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715096128; x=1715700928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7fZeIxGU7jDZbp8MIAMXuP3cI2fycrTuvDnx0IrbFAQ=;
        b=tHJ+/yjsBsvPhHwoSzYD5wH46Fn1Kk5UB/QuN0zJcZf+ShORaY22eBjez+BCDKbgMl
         xxs2XZ86SxlX9Om8umaaH6QHGj34vOoV4x2GpBgsQOjsIjmV5QD/9O0KxUxkpmYIMdak
         vg/Z7dKjdU7OeWCfpyz+rISM22jevsM/DL9Lr7pVcByZQ3WGvBClUHSpMujQWuclBwFL
         CQWEj7YILO/MYHef3GvZpSptn+FCpziPCZ7ewi/zrbTrTlkqcfTlKD77rnblVYubCCDP
         WLfj0S/GD7vElOzbrA7QmstQ4rh+hf4otNJkSt5nCKW9E79ZnRHXour1mKicL6MZ+Lpz
         NGOw==
X-Forwarded-Encrypted: i=1; AJvYcCWumQejhgvGtNOaxZZJitvAPCljjSEpoCoT6bdZSXB8ujj29k/M5c15qYZf844UF0pghp6wnoNs1IdqzIfQtCQsWBPTDZI=
X-Gm-Message-State: AOJu0Yze8z+HWzbJGIf6ZbNVhSy3KGykKk6z3x5ZXpwK4+wKujXnjSSv
	uSw2+7ODBXvqjclQBm505eVlhyZkTSfuD3sqo+cW7Ckz5nlP4YYe5R5Y50K76fyqhipzs5+j0OR
	mFA6GlNFF/2U8ww64MzTMaYi9X4Y3m4y3uEj5WQ==
X-Google-Smtp-Source: AGHT+IHqhr+YVZAu1ZOtkTbNqavDX8MQUCsFnE/WXIvw3MsduOLxL3dNlYhKHRcJc+TT/v2hNtcpr3nZKzMPIQcSz3I=
X-Received: by 2002:a05:6602:6d12:b0:7e1:7a0b:3091 with SMTP id
 im18-20020a0566026d1200b007e17a0b3091mr5247906iob.15.1715096127791; Tue, 07
 May 2024 08:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240507142600.23844-1-zong.li@sifive.com> <20240507142600.23844-7-zong.li@sifive.com>
 <20240507150829.GJ901876@ziepe.ca>
In-Reply-To: <20240507150829.GJ901876@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 7 May 2024 23:35:16 +0800
Message-ID: <CANXhq0rnWUT4ia-cUoTbSyEQUeCcmC9bC7HHru6Se-1K-PZRDQ@mail.gmail.com>
Subject: Re: [PATCH RFC RESEND 6/6] iommu/riscv: support nested iommu for
 flushing cache
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 11:08=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Tue, May 07, 2024 at 10:26:00PM +0800, Zong Li wrote:
> > This patch implements cache_invalidate_user operation for the userspace
> > to flush the hardware caches for a nested domain through iommufd.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c  | 91 ++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/iommufd.h |  9 ++++
> >  2 files changed, 100 insertions(+)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 7eda850df475..4dd58fe2242d 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -1522,9 +1522,100 @@ static void riscv_iommu_domain_free_nested(stru=
ct iommu_domain *domain)
> >       kfree(riscv_domain);
> >  }
> >
> > +static int riscv_iommu_fix_user_cmd(struct riscv_iommu_command *cmd,
> > +                                 unsigned int pscid, unsigned int gsci=
d)
> > +{
> > +     u32 opcode =3D FIELD_GET(RISCV_IOMMU_CMD_OPCODE, cmd->dword0);
> > +
> > +     switch (opcode) {
> > +     case RISCV_IOMMU_CMD_IOTINVAL_OPCODE:
> > +             u32 func =3D FIELD_GET(RISCV_IOMMU_CMD_FUNC, cmd->dword0)=
;
> > +
> > +             if (func !=3D RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA &&
> > +                 func !=3D RISCV_IOMMU_CMD_IOTINVAL_FUNC_VMA) {
> > +                     pr_warn("The IOTINVAL function: 0x%x is not suppo=
rted\n",
> > +                             func);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +
> > +             if (func =3D=3D RISCV_IOMMU_CMD_IOTINVAL_FUNC_GVMA) {
> > +                     cmd->dword0 &=3D ~RISCV_IOMMU_CMD_FUNC;
> > +                     cmd->dword0 |=3D FIELD_PREP(RISCV_IOMMU_CMD_FUNC,
> > +                                               RISCV_IOMMU_CMD_IOTINVA=
L_FUNC_VMA);
> > +             }
> > +
> > +             cmd->dword0 &=3D ~(RISCV_IOMMU_CMD_IOTINVAL_PSCID |
> > +                              RISCV_IOMMU_CMD_IOTINVAL_GSCID);
> > +             riscv_iommu_cmd_inval_set_pscid(cmd, pscid);
> > +             riscv_iommu_cmd_inval_set_gscid(cmd, gscid);
> > +             break;
> > +     case RISCV_IOMMU_CMD_IODIR_OPCODE:
> > +             /*
> > +              * Ensure the device ID is right. We expect that VMM has
> > +              * transferred the device ID to host's from guest's.
> > +              */
> > +             break;
> > +     default:
> > +             pr_warn("The user command: 0x%x is not supported\n", opco=
de);
> > +             return -EOPNOTSUPP;
>
> No userspace triggerable warnings.

I don't complete understand about this. Could I know whether we should
suppress the message and return the error directly, or if we should
convert the warning to an error (i.e. pr_err)?

>
> > +static int riscv_iommu_cache_invalidate_user(struct iommu_domain *doma=
in,
> > +                                          struct iommu_user_data_array=
 *array)
> > +{
> > +     struct riscv_iommu_domain *riscv_domain =3D iommu_domain_to_riscv=
(domain);
> > +     struct riscv_iommu_device *iommu;
> > +     struct riscv_iommu_bond *bond;
> > +     struct riscv_iommu_command cmd;
> > +     struct iommu_hwpt_riscv_iommu_invalidate inv_info;
> > +     int ret, index;
> > +
> > +     if (!riscv_domain)
> > +             return -EINVAL;
> > +
> > +     /* Assume attached devices in the domain go through the same IOMM=
U device */
>
> No, you can't assume that.

Do you think that it makes sense to add a riscv_iommu_device structure
in riscv_iommu_domain? Or we might need to add some data structure to
build the mapping of the riscv_iommu_device and riscv_iommu_domain,
then we can get the corresponding riscv_iommu_device by
riscv_iommu_domain?
Thanks

>
> Jason
