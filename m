Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC014EC52
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565435; cv=none; b=Rd0YDkOYuVIMIt/wlaOn1rNARRf+JI44n5vDQDyM23K7d92Q3o3kS13Z8by0QhrKLSLDvW8+AyOd4WFky/6OWd0J68XVqWsJgPN+7Q5PSNMqQO6QZ67BG7JIFlZncP+nVuKpEidGvV7WaiJw3e9mwGudyBYktQjlqVAwLdzaDMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565435; c=relaxed/simple;
	bh=WrLY/BLAwRgn0rVLflR92g+T8aY/Wew1eYHIwQcREVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFzsaxEwUj1uq2qEoQxckRlVRmOOmLnaceQC67mVGVDqXD2Nne0SO8yuVmOwCG7nMCGDcy928spnYW8EBgHawon3mDIqcSlM1zNHvYnoLb3CE8QeK4VapW2+jCMojatbSKXVCPdZgo+Gw9vPVjRrIZgXafaMNSDkbyRCGwGWOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=fsTavOsg; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="fsTavOsg"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7ec2d71059dso13864239f.2
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1719565433; x=1720170233; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/za7LeSnjhTm+OzP17ugGn+HzGEABfvFxH0U517Gjo=;
        b=fsTavOsgcDxQy96Btg9E9JcjM16xnALz0HFcISZJs2NWfLMorNtUnjDOoGi0Q02sqe
         qUj321JV1JZhR7B1RQ9Tm42o/EsdfYHQGsuXuKSKmOHkBDwKpepH8oBLwq4okXkNxngH
         eR1gWrV9hLZTEmj5R+7T6is4a3l/y7BoQvrmc60waJy7ah0GoXEcI+mzHJzHdphal9Tf
         rcrdR58FIjTTnER1/2a6kI6iGV8ylMTG+heDn4ZhsOcBSVBvCSq4FGyPygD16LNX3AV3
         zLoSnTwHvCL07T5iNUI1hD4g2HD7ej3F4Uih/OZ0+1dhzRHZUOSgjv7uB/jTZ2zlCKR1
         Y/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565433; x=1720170233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/za7LeSnjhTm+OzP17ugGn+HzGEABfvFxH0U517Gjo=;
        b=XcqhVavkfIEaaA+5wzzCJXF/PEfVWRFDsW0iJy5V6tRXbtrJLtmPtRVmt6aDD7oRwY
         EraWJfNnavxwHoHGWaswaTEbiNpHfbEOSGccndi5Lj89VpGAvgH29djMC3i7BIsgy3pz
         LMuw9Yp31qr/dSu19biUP8PYDqYNm7YJlyThVzKuKA++OfpwoZ5aHxmFgsKwJJxTewDL
         WSESs6gwzr/93VFDJ1EiSOIK0ETk/G8R2/JeyUVkwZs20zKv+dXECwHG257u0oFP8VFj
         Ec34xs5HJffiBm1i40CmS3Vq2MclGp8CyEjEy7GvEXZfNKSLZ1Ak8oWDpQ6DWDmi+da2
         FbOg==
X-Forwarded-Encrypted: i=1; AJvYcCXnLnLNjhLBxP48O0rEgrn4mXlR44zmFN8XnLiHi/vd3y0Co86UqK6Uyy0xKXChEadylA4GWROG6GJ5AQjJ7ApNBLSC3p4=
X-Gm-Message-State: AOJu0YwXT6c/FVYbXhZ1ExPyfBSDqZc436+PCqoWgog4Xc0mMrMXkhQX
	/D/ejLw1Ra5Etq+0Ge5XW5XEo8YyJRwjGiPE/A13cOH/LFFWyicygfodqTuGfO+OOa0odZccbBO
	4P5TeIL69hlRHDQUGOnw4D1rB3CoKKmLi9tA59w==
X-Google-Smtp-Source: AGHT+IGX0ZfX8BF54cMVKU/lpSgCRYHg2pyXsO/XvGxQj5HZhaNwfUPkpzzcQOULoy+umEF984ed0IL7WJjrmM9MD3k=
X-Received: by 2002:a05:6602:160a:b0:7f3:d326:1fa4 with SMTP id
 ca18e2360f4ac-7f3d3262347mr951857739f.18.1719565432871; Fri, 28 Jun 2024
 02:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-8-zong.li@sifive.com>
 <20240619160211.GO1091770@ziepe.ca>
In-Reply-To: <20240619160211.GO1091770@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Jun 2024 17:03:41 +0800
Message-ID: <CANXhq0qqrU8xbTecFOcRNLqm2=DbTYsN2YBX5K_O1ha530bu_A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: support nested iommu for
 creating domains owned by userspace
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 12:02=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Jun 14, 2024 at 10:21:53PM +0800, Zong Li wrote:
> > This patch implements .domain_alloc_user operation for creating domains
> > owend by userspace, e.g. through IOMMUFD. Add s2 domain for parent
> > domain for second stage, s1 domain will be the first stage.
> >
> > Don't remove IOMMU private data of dev in blocked domain, because it
> > holds the user data of device, which is used when attaching device into
> > s1 domain.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c  | 236 ++++++++++++++++++++++++++++++++++-
> >  include/uapi/linux/iommufd.h |  17 +++
> >  2 files changed, 252 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index 2130106e421f..410b236e9b24 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -846,6 +846,8 @@ static int riscv_iommu_iodir_set_mode(struct riscv_=
iommu_device *iommu,
> >
> >  /* This struct contains protection domain specific IOMMU driver data. =
*/
> >  struct riscv_iommu_domain {
> > +     struct riscv_iommu_domain *s2;
> > +     struct riscv_iommu_device *iommu;
>
> IMHO you should create a riscv_iommu_domain_nested and not put these
> here, like ARM did.
>
> The kernel can't change the nested domain so it can't recieve and
> distribute invalidations.

Ok, as you mentioned, there are many data elements in that data
structure won't be used in s1 domain.

>
> > +/**
> > + * Nested IOMMU operations
> > + */
> > +
> > +static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain, =
struct device *dev)
> > +{
> > +     struct riscv_iommu_domain *riscv_domain =3D iommu_domain_to_riscv=
(domain);
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +     struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> > +
> > +     /*
> > +      * Add bond to the new domain's list, but don't unlink in current=
 domain.
> > +      * We need to flush entries in stage-2 page table by iterating th=
e list.
> > +      */
> > +     if (riscv_iommu_bond_link(riscv_domain, dev))
> > +             return -ENOMEM;
> > +
> > +     riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
> > +     info->dc_user.ta |=3D RISCV_IOMMU_PC_TA_V;
>
> Seems odd??
>
> > +     riscv_iommu_iodir_update(iommu, dev, &info->dc_user);
>
> This will be need some updating to allow changes that don't toggle
> V=3D0, like in arm.

I think the right code snippet is put in 8th patch as you pointed in
8th patch. I will correct it in next version.

>
> > +     info->domain =3D riscv_domain;
> > +
> > +     return 0;
> > +}
> > +
> > +static void riscv_iommu_domain_free_nested(struct iommu_domain *domain=
)
> > +{
> > +     struct riscv_iommu_domain *riscv_domain =3D iommu_domain_to_riscv=
(domain);
> > +     struct riscv_iommu_bond *bond;
> > +
> > +     /* Unlink bond in s2 domain, because we link bond both on s1 and =
s2 domain */
> > +     list_for_each_entry_rcu(bond, &riscv_domain->s2->bonds, list)
> > +             riscv_iommu_bond_unlink(riscv_domain->s2, bond->dev);
> > +
> > +     if ((int)riscv_domain->pscid > 0)
> > +             ida_free(&riscv_iommu_pscids, riscv_domain->pscid);
> > +
> > +     kfree(riscv_domain);
> > +}
> > +
> > +static const struct iommu_domain_ops riscv_iommu_nested_domain_ops =3D=
 {
> > +     .attach_dev     =3D riscv_iommu_attach_dev_nested,
> > +     .free           =3D riscv_iommu_domain_free_nested,
> > +};
> > +
> > +static int
> > +riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_io=
mmu *user_arg)
> > +{
> > +     struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +     struct riscv_iommu_info *info =3D dev_iommu_priv_get(dev);
> > +     struct riscv_iommu_dc dc;
> > +     struct riscv_iommu_fq_record event;
> > +     u64 dc_len =3D sizeof(struct riscv_iommu_dc) >>
> > +                  (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT))=
;
> > +     u64 event_len =3D sizeof(struct riscv_iommu_fq_record);
> > +     void __user *event_user =3D NULL;
> > +
> > +     for (int i =3D 0; i < fwspec->num_ids; i++) {
> > +             event.hdr =3D
> > +                     FIELD_PREP(RISCV_IOMMU_FQ_HDR_CAUSE, RISCV_IOMMU_=
FQ_CAUSE_DDT_INVALID) |
> > +                     FIELD_PREP(RISCV_IOMMU_FQ_HDR_DID, fwspec->ids[i]=
);
> > +
> > +             /* Sanity check DC of stage-1 from user data */
> > +             if (!user_arg->out_event_uptr || user_arg->event_len !=3D=
 event_len)
> > +                     return -EINVAL;
>
> This is not extensible, see below about just inlining it.
>
> > +             event_user =3D u64_to_user_ptr(user_arg->out_event_uptr);
> > +
> > +             if (!user_arg->dc_uptr || user_arg->dc_len !=3D dc_len)
> > +                     return -EINVAL;
> > +
> > +             if (copy_from_user(&dc, u64_to_user_ptr(user_arg->dc_uptr=
), dc_len))
> > +                     return -EFAULT;
> > +
> > +             if (!(dc.tc & RISCV_IOMMU_DDTE_V)) {
> > +                     dev_dbg(dev, "Invalid DDT from user data\n");
> > +                     if (copy_to_user(event_user, &event, event_len))
> > +                             return -EFAULT;
> > +             }
>
> On ARM we are going to support non-valid STEs. It should put the the
> translation into blocking and ideally emulate translation failure
> events.

Ok, let me consider this situation in next version.

>
> > +
> > +             if (!dc.fsc || dc.iohgatp) {
> > +                     dev_dbg(dev, "Wrong page table from user data\n")=
;
> > +                     if (copy_to_user(event_user, &event, event_len))
> > +                             return -EFAULT;
> > +             }
> > +
> > +             /* Save DC of stage-1 from user data */
> > +             memcpy(&info->dc_user,
> > +                    riscv_iommu_get_dc(iommu, fwspec->ids[i]),
>
> This does not seem right, the fwspec shouldn't be part of domain
> allocation, even arguably for nesting. The nesting domain should
> represent the user_dc only. Any customization of kernel controlled bits
> should be done during attach only, nor do I really understand why this
> is looping over all the fwspecs but only memcpying the last one..
>

The fwspec is used to get the value of current dc, because we want to
also back up the address of second stage table (i.e. iohgatp), The
reason is that this value will be cleaned when device is attached to
the blocking domain, before the device attaches to s1 domain, we can't
get the original value of iohgatp anymore when attach device to s1
domain.
For the issue for only memcpying the last one, I should fix it in next
version, we might need to allocate the multiple user_dc at runtime,
because we don't statically know how many id will be used in one
platform device. does it make sense to you?

> > +                    sizeof(struct riscv_iommu_dc));
> > +             info->dc_user.fsc =3D dc.fsc;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct iommu_domain *
> > +riscv_iommu_domain_alloc_nested(struct device *dev,
> > +                             struct iommu_domain *parent,
> > +                             const struct iommu_user_data *user_data)
> > +{
> > +     struct riscv_iommu_domain *s2_domain =3D iommu_domain_to_riscv(pa=
rent);
> > +     struct riscv_iommu_domain *s1_domain;
> > +     struct riscv_iommu_device *iommu =3D dev_to_iommu(dev);
> > +     struct iommu_hwpt_riscv_iommu arg;
> > +     int ret, va_bits;
> > +
> > +     if (user_data->type !=3D IOMMU_HWPT_DATA_RISCV_IOMMU)
> > +             return ERR_PTR(-EOPNOTSUPP);
> > +
> > +     if (parent->type !=3D IOMMU_DOMAIN_UNMANAGED)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     ret =3D iommu_copy_struct_from_user(&arg,
> > +                                       user_data,
> > +                                       IOMMU_HWPT_DATA_RISCV_IOMMU,
> > +                                       out_event_uptr);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     s1_domain =3D kzalloc(sizeof(*s1_domain), GFP_KERNEL);
> > +     if (!s1_domain)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     spin_lock_init(&s1_domain->lock);
> > +     INIT_LIST_HEAD_RCU(&s1_domain->bonds);
> > +
> > +     s1_domain->pscid =3D ida_alloc_range(&riscv_iommu_pscids, 1,
> > +                                        RISCV_IOMMU_MAX_PSCID, GFP_KER=
NEL);
> > +     if (s1_domain->pscid < 0) {
> > +             iommu_free_page(s1_domain->pgd_root);
> > +             kfree(s1_domain);
> > +             return ERR_PTR(-ENOMEM);
> > +     }
> > +
> > +     /* Get device context of stage-1 from user*/
> > +     ret =3D riscv_iommu_get_dc_user(dev, &arg);
> > +     if (ret) {
> > +             kfree(s1_domain);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> > +     if (!iommu) {
> > +             va_bits =3D VA_BITS;
> > +     } else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
> > +             va_bits =3D 57;
> > +     } else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
> > +             va_bits =3D 48;
> > +     } else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
> > +             va_bits =3D 39;
> > +     } else {
> > +             dev_err(dev, "cannot find supported page table mode\n");
> > +             return ERR_PTR(-ENODEV);
> > +     }
> > +
> > +     /*
> > +      * The ops->domain_alloc_user could be directly called by the iom=
mufd core,
> > +      * instead of iommu core. So, this function need to set the defau=
lt value of
> > +      * following data member:
> > +      *  - domain->pgsize_bitmap
> > +      *  - domain->geometry
> > +      *  - domain->type
> > +      *  - domain->ops
> > +      */
> > +     s1_domain->s2 =3D s2_domain;
> > +     s1_domain->iommu =3D iommu;
> > +     s1_domain->domain.type =3D IOMMU_DOMAIN_NESTED;
> > +     s1_domain->domain.ops =3D &riscv_iommu_nested_domain_ops;
> > +     s1_domain->domain.pgsize_bitmap =3D SZ_4K;
> > +     s1_domain->domain.geometry.aperture_start =3D 0;
> > +     s1_domain->domain.geometry.aperture_end =3D DMA_BIT_MASK(va_bits =
- 1);
> > +     s1_domain->domain.geometry.force_aperture =3D true;
>
> There is no geometry or page size of nesting domains.
>

Thanks for pointing it out. I will fix it in the next version.

> > +
> > +     return &s1_domain->domain;
> > +}
> > +
> > +static struct iommu_domain *
> > +riscv_iommu_domain_alloc_user(struct device *dev, u32 flags,
> > +                           struct iommu_domain *parent,
> > +                           const struct iommu_user_data *user_data)
> > +{
> > +     struct iommu_domain *domain;
> > +     struct riscv_iommu_domain *riscv_domain;
> > +
> > +     /* Allocate stage-1 domain if it has stage-2 parent domain */
> > +     if (parent)
> > +             return riscv_iommu_domain_alloc_nested(dev, parent, user_=
data);
> > +
> > +     if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DI=
RTY_TRACKING)))
> > +             return ERR_PTR(-EOPNOTSUPP);
> > +
> > +     if (user_data)
> > +             return ERR_PTR(-EINVAL);
> > +
> > +     /* domain_alloc_user op needs to be fully initialized */
> > +     domain =3D iommu_domain_alloc(dev->bus);
>
> Please organize your driver to avoid calling this core function
> through a pointer and return the correct type from the start so you
> don't have to cast.

Ok, let me modify this part. Thanks .

>
> > +     if (!domain)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     /*
> > +      * We assume that nest-parent or g-stage only will come here
> > +      * TODO: Shadow page table doesn't be supported now.
> > +      *       We currently can't distinguish g-stage and shadow
> > +      *       page table here. Shadow page table shouldn't be
> > +      *       put at stage-2.
> > +      */
> > +     riscv_domain =3D iommu_domain_to_riscv(domain);
> > +
> > +     /* pgd_root may be allocated in .domain_alloc_paging */
> > +     if (riscv_domain->pgd_root)
> > +             iommu_free_page(riscv_domain->pgd_root);
>
> And don't do stuff like this, if domain_alloc didn't do the right
> stuff then reorganize it so that it does. Most likely pass in a flag
> that you are allocating the nest so it can setup properly if it is
> only a small change like this.

Yes, if we don't rely on the original domain allocation, it won't be
weird as it is now.

>
> > +/**
> > + * struct iommu_hwpt_riscv_iommu - RISCV IOMMU stage-1 device context =
table
> > + *                                 info (IOMMU_HWPT_TYPE_RISCV_IOMMU)
> > + * @dc_len: Length of device context
> > + * @dc_uptr: User pointer to the address of device context
> > + * @event_len: Length of an event record
> > + * @out_event_uptr: User pointer to the address of event record
> > + */
> > +struct iommu_hwpt_riscv_iommu {
> > +     __aligned_u64 dc_len;
> > +     __aligned_u64 dc_uptr;
>
> Do we really want this to be a pointer? ARM just inlined it in the
> struct, why not do that?
>
> > +     __aligned_u64 event_len;
> > +     __aligned_u64 out_event_uptr;
> > +};
>
> Similar here too, why not just inline the response memory?

I think we can just inline them, just like what we do in the
'iommu_hwpt_riscv_iommu_invalidate'. does I understand correctly?

>
> Jason
