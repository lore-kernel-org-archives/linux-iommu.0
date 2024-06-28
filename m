Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3651428FE
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 08:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719562783; cv=none; b=PZCSMG3Gm2rBLwZ2xsU/NXVbykgC1L91mj/EeAXRyEI97dDytHW6ys3DwzLk9OBjoket0uOlIldWphB+EHtMQ0sdZWt3F4kUU9slirVhp7vAK/ABjsWamtH0ZgArzMrXyf2oOgtuFr1HjlUGw0pe9r31m48TQ1DtLzfdpUPy8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719562783; c=relaxed/simple;
	bh=s56WFNCfVR9NR2a4mjgRyVAOJGxNrIS6iWxfdXLw8AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqR77D938AKpZJcooOzYDLeFYahwcArlmTi6CzP/I49f4oS26EC2f8lG1M/4bbftCHu5KjkgxDgJAgfR6Rvy0mAp9DXXHfImySSHwVaQw54ttuvVAW7B0eNnfn4m4bpPIrWkBmb6uCTCeAT5T/l6tzD9dTlz5qjETs/L2kxQLmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=DI72NqeQ; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="DI72NqeQ"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7f3d884e70bso13726739f.3
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 01:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719562780; x=1720167580; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/qO9FkT/vVabsz0HBj+1khfm42T6GUcPufAI2E8LYM=;
        b=DI72NqeQ7rilqetSexZ4rWjKePQnytLysyMrTZ3TrzuItanX1g8t8cKp/Dy5CU701l
         a/n530+pgXwXD0gR/1voOjSf4q0cYhyxSh0GJxT4hAbHjX//O7ht9Q+zEi9+m4BeNZOQ
         EOhByFNcqveGxZAzx+wCpTTjQ64kD0G+U/xqEaQ/VWRc4+HO0nu3xEvZiPwc3NUtcDeF
         qNa0bm9r4ZEJp2h0fdfCR9bcEcvevtMZIscYGCJ3ZMAOg37t6LI4Vpdqyw6V0GdxYu1z
         45YQpfjlYzEYAe+Z5169Dp+R5/m42QigmBKf4yDRf1aGS1KELPQ466JnHV+FRq7k3+Vs
         bShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719562780; x=1720167580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/qO9FkT/vVabsz0HBj+1khfm42T6GUcPufAI2E8LYM=;
        b=cZflM3+GYPw6WAKc3NAtfQs/DLT4nUxHV9Uy+fzi+VLFP+KKgPtsKRYfpkuX4H87X0
         gGWdfF1ayHQkT+iLL4TaZDW9yiYlNpdrtdxlAzNvFtMCVqwHMOeP8bC36HW6mhEiclHr
         iGDy+WjHaxiEzwsWNQR6F5yKC4Vlz1OmW2Uqjnao+pvtw//wZKGNGhymGkTZxM/qrnGB
         u0oSRtQ58IlcWKIaFRyFHgKufSKdk03VpXNv11XN7aFlT0rTlV9YdCfYOl5f9pmPqXbn
         OryRIHz+RjFb4xMSQcHQwefXjF/+9OVX6xG2KIP5RucRalP2yHju67UJkcGzdXwqVKQG
         54Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVo9ZnVzX8CqrFJ6WBI0rruLCsYVJ3hgyKMGNrashDl91WT3TGlD8IHfTEq3wpDJ7tXKLwnGFr86ExxR4+QuQIGBBBIGPE=
X-Gm-Message-State: AOJu0YxqIo+JTCDJwsEgvxa+OuEK1JV2F/sfML5VtrYeYmHbwMVCCpvv
	b5bVEu1wNNRCrPpKmNgFwb7bzN5yC8vd8fCCBAPIy36/EnwsYhE+qiXA7ngupCicPkS2P11OdRL
	f20iLNv/ZN91pIjj30MUYCuOewUjQcPLSovXrQA==
X-Google-Smtp-Source: AGHT+IHn2evgOJLaaJiRgXsD5cceTO6G9y4KoRv5dNvVpAYoPqBKVn2PGWboQ5lMNsbOksImkAt4wfLp1T5FCVkhq0I=
X-Received: by 2002:a05:6602:2cd5:b0:7f3:d2d5:f06a with SMTP id
 ca18e2360f4ac-7f3d2d5f2acmr952657739f.13.1719562779958; Fri, 28 Jun 2024
 01:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-9-zong.li@sifive.com>
 <20240619161740.GP1091770@ziepe.ca>
In-Reply-To: <20240619161740.GP1091770@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Jun 2024 16:19:28 +0800
Message-ID: <CANXhq0pgQMHGVv12K0s9ovd0OkOa15QCdH4HMfZGCy5hYXSWMw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 08/10] iommu/riscv: support nested iommu for
 flushing cache
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:17=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Jun 14, 2024 at 10:21:54PM +0800, Zong Li wrote:
> > This patch implements cache_invalidate_user operation for the userspace
> > to flush the hardware caches for a nested domain through iommufd.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c  | 90 ++++++++++++++++++++++++++++++++++--
> >  include/uapi/linux/iommufd.h | 11 +++++
> >  2 files changed, 97 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 410b236e9b24..d08eb0a2939e 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -1587,8 +1587,9 @@ static int riscv_iommu_attach_dev_nested(struct i=
ommu_domain *domain, struct dev
> >       if (riscv_iommu_bond_link(riscv_domain, dev))
> >               return -ENOMEM;
> >
> > -     riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
> > -     info->dc_user.ta |=3D RISCV_IOMMU_PC_TA_V;
> > +     if (riscv_iommu_bond_link(info->domain, dev))
> > +             return -ENOMEM;
>
> ?? Is this in the wrong patch then? Confused

Yes, it should be in 7th patch in this series. I will fix it in next versio=
n.

>
> >       riscv_iommu_iodir_update(iommu, dev, &info->dc_user);
> >
> >       info->domain =3D riscv_domain;
> > @@ -1611,13 +1612,92 @@ static void riscv_iommu_domain_free_nested(stru=
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
>
> I'm not sure what this remark means, but I expect you will need to
> translate any devices IDs from virtual to physical.

I think we need some data structure to map it. I didn't do that here
because our internal implementation translates the right ID in VMM,
but as you mentioned, we can't expect that VMM will do that for
kernel.

>
> >
> >  static int
> > -riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_io=
mmu *user_arg)
> > +riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_io=
mmu *user_arg,
> > +                     struct riscv_iommu_domain *s1_domain)
> >  {
> >       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> >       struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > @@ -1663,6 +1743,8 @@ riscv_iommu_get_dc_user(struct device *dev, struc=
t iommu_hwpt_riscv_iommu *user_
> >                      riscv_iommu_get_dc(iommu, fwspec->ids[i]),
> >                      sizeof(struct riscv_iommu_dc));
> >               info->dc_user.fsc =3D dc.fsc;
> > +             info->dc_user.ta =3D FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, =
s1_domain->pscid) |
> > +                                           RISCV_IOMMU_PC_TA_V;
> >       }
>
> It is really weird that the s1 domain has any kind of id. What is the
> PSCID? Is it analogous to VMID on ARM?

I think the VMID is closer to the GSCID. The PSCID might be more like
the ASID, as it is used as the address space ID for the process
identified by the first-stage page table.
The GSCID used to tag the G-stage TLB, the PSCID is used to tag the
single stage TLB and the tuple {GSCID, PSCID} is used to tag the
VS-stage TLB. The IOTINVAL.VMA command can flush the mapping by
matching GSCID only, PSCID only or the tuple {GSCID, PSCID}. We can
consider the situation that there are two devices pass through to a
guest, then we will have two s1 domains under the same s2 domain, and
we can flush their mapping by { GSCID, PSCID } and { GSCID, PSCID' }
respectively.

>
> Jason
