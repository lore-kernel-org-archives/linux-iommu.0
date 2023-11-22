Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB81381
	for <iommu@lists.linux.dev>; Wed, 22 Nov 2023 01:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAc50IBe"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso8683572a12.2
        for <iommu@lists.linux.dev>; Tue, 21 Nov 2023 17:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700614944; x=1701219744; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXAWsG9iOloHUdNE5mm3jXIIiOW32R7yz4554A63aDM=;
        b=cAc50IBeJ3u8nrHQeoKq/GrhNmv5jid6NfXPNoGyy6lxwhqrYCKnimEBkZ39q26Qzu
         7ppEAWEXHkEM/0OmTGu/bBYvGcohwLLwk6v+jM3pfCx/zbjjJiWWhZQSLFChhp+//oDA
         47w7WuPFEY8En1sbQH9N7qPgmUHcvfJmk6GmZZUJ6l8VgqvRzjJNbXWjCJleFgOSv3Lx
         3DMlbCmC05ikUDRLgOW0aNQ7wKwe9MRbRlgdatmPdk0Q3dkdFgSq1A1KDrguyY+eLH11
         i6OMFstf48emW5LnHJaHJzVRXDudSk9z+kUHftkAW9VrW4tso71pd9OuXwTAVTxmXU1E
         m+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700614944; x=1701219744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXAWsG9iOloHUdNE5mm3jXIIiOW32R7yz4554A63aDM=;
        b=fLr99Riir2Mjf9ULhobjZEyTJVTg7BLwp8cdS+rl+Jvt1rGUQH6vdwMC5RwqSrAaSp
         KHMiZUGSi6iJq/n0aJiwFrN/c9fH1/oQu9hjpjWXvqyCYlkFNk1lSNuz9Lud7+md2i24
         8ym5isq79s2CiOzqL5TUe5dfH4q+OPtEdD15Ftc7yrsYZlg2SWpikuMU/B2FK0EYHBeZ
         PYyH2n2siAQ23pCcvd8e8N0mqJW6kpb7BLtlsPIZWlafNEP3aYg0ds4XLNYjV2zp21N1
         EaNDLOEysF2VMb2HxwhR8mBjRuq0CiPjGL5Nq0zSrFO/h7aIEI5cxfBNFsVv9tD+7oc0
         pvSA==
X-Gm-Message-State: AOJu0YwQKCtWmnaT6lLsY11Lx23nEZ7H/epKAf7wKLVHUD2S7Wa9rE3/
	ERNic3jPAxQPkFEMomrW6/CCnoGyjXPFlD3492I=
X-Google-Smtp-Source: AGHT+IFAAdSEYQU+FjN4tYW+dYheU4U1L4a17RYKBvYXsMva3YuIChgqqiL7+fiTRx2WV4Qr3vc5DWuiTLVP4mKrrMs=
X-Received: by 2002:a50:ed89:0:b0:548:5fa3:1483 with SMTP id
 h9-20020a50ed89000000b005485fa31483mr630561edr.6.1700614944335; Tue, 21 Nov
 2023 17:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231115020209.4665-1-yaozhenguo@jd.com> <20231117152746.3aa55d68.alex.williamson@redhat.com>
In-Reply-To: <20231117152746.3aa55d68.alex.williamson@redhat.com>
From: Zhenguo Yao <yaozhenguo1@gmail.com>
Date: Wed, 22 Nov 2023 09:02:13 +0800
Message-ID: <CA+WzAR=7R=JPeu4+-ojgfjM7vgP5pcg7fS0yU_CRaLzNSdRaLA@mail.gmail.com>
Subject: Re: [PATCH V1] vfio: add attach_group_by_node to control behavior of
 attaching group to domain
To: Alex Williamson <alex.williamson@redhat.com>
Cc: yaozhenguo@jd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Wenchao Yao <yaowenchao@jd.com>, ZiHan Zhou <zhouzihan30@jd.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood, thanks=EF=BC=81

Alex Williamson <alex.williamson@redhat.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=
=8818=E6=97=A5=E5=91=A8=E5=85=AD 06:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, 15 Nov 2023 10:02:09 +0800
> yaozhenguo <yaozhenguo1@gmail.com> wrote:
>
> > From: Zhenguo Yao <yaozhenguo1@gmail.com>
> >
> > Groups will attach to one iommu_domain if ops and enforce_cache_coheren=
cy
> > are equal. And all the iommu hardware share one pagetable by default.
> > There are performance issue in some scenarios. For example:
> > Host hardware topopy:
> >
> > node0 + PCIe RP0 ---+ GPU A100
> >       |         |---+ GPU A100
> >       |               |---+ NIC Mellanox CX6
> >       |               |---+ NIC Mellanox CX6
> >       + PCIe RP1 ---+ GPU A100
> >                 |---+ GPU A100
> >                       |---+ NIC Mellanox CX6
> >                 |---+ NIC Mellanox CX6
> > node1 + PCIe RP0 ---+ GPU A100
> >       |         |---+ GPU A100
> >       |               |---+ NIC Mellanox CX6
> >       |               |---+ NIC Mellanox CX6
> >       + PCIe RP1 ---+ GPU A100
> >                 |---+ GPU A100
> >                       |---+ NIC Mellanox CX6
> >                 |---+ NIC Mellanox CX6
> >
> > We passthrough all NICs and GPU to VM, and emulate host hardware topopy=
.
> > Mellanox CX6 ATS feature is enabled, GPU direct RDMA enabled.
> > We test NCCL allreduce in VM at different cases.
> >
> > Case1: allreduce test use 4nic and 4GPU in numa0.
> > Case2=EF=BC=9Aallreduce test use 4nic and 4GPU in numa1.
> > case3: allreduce test use 8nic and 8GPU.
> >
> > the result are below:
> >
> > |        | algbw (GB/S) |
> > | ------ | -------------|
> > | case1  | 24           |
> > | case2  | 32           |
> > | case3  | 45           |
> >
> > We checked that IOMMU pagetable is allocated in numa1 when VM boot up.
> > So, if IOTLB miss happan, IOMMU hardware in numa0 will access remote
> > pagetable in numa1. This will drop performance. After apply this patch =
and
> > attach_group_by_node is 1. Group in same node will attach to one domain=
.
> > IOMMU will access there local pagetable. Performance is improved:
> >
> > |        | algbw (GB/S) |
> > | ------ | -------------|
> > | case1  | 32           |
> > | case2  | 32           |
> > | case3  | 63           |
> >
> > Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>
> > Co-developed-by: Wenchao Yao <yaowenchao@jd.com>
> > Signed-off-by: Wenchao Yao <yaowenchao@jd.com>
> > Co-developed-by: ZiHan Zhou <zhouzihan30@jd.com>
> > Signed-off-by: ZiHan Zhou <zhouzihan30@jd.com>
> > ---
> >  drivers/iommu/intel/iommu.c     |  8 +++++++-
> >  drivers/vfio/vfio_iommu_type1.c | 33 +++++++++++++++++++++------------
> >  include/linux/iommu.h           |  1 +
> >  3 files changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 3531b95..2c6d8f0 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -569,8 +569,10 @@ void domain_update_iommu_cap(struct dmar_domain *d=
omain)
> >        * If RHSA is missing, we should default to the device numa domai=
n
> >        * as fall back.
> >        */
> > -     if (domain->nid =3D=3D NUMA_NO_NODE)
> > +     if (domain->nid =3D=3D NUMA_NO_NODE) {
> >               domain->nid =3D domain_update_device_node(domain);
> > +             domain->domain.nid =3D domain->nid;
> > +     }
> >
> >       /*
> >        * First-level translation restricts the input-address to a
> > @@ -1767,6 +1769,7 @@ static struct dmar_domain *alloc_domain(unsigned =
int type)
> >               return NULL;
> >
> >       domain->nid =3D NUMA_NO_NODE;
> > +     domain->domain.nid =3D NUMA_NO_NODE;
> >       if (first_level_by_default(type))
> >               domain->use_first_level =3D true;
> >       domain->has_iotlb_device =3D false;
> > @@ -1808,6 +1811,8 @@ int domain_attach_iommu(struct dmar_domain *domai=
n, struct intel_iommu *iommu)
> >       info->refcnt    =3D 1;
> >       info->did       =3D num;
> >       info->iommu     =3D iommu;
> > +     domain->nid     =3D iommu->node;
> > +     domain->domain.nid     =3D iommu->node;
> >       curr =3D xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
> >                         NULL, info, GFP_ATOMIC);
> >       if (curr) {
> > @@ -1837,6 +1842,7 @@ void domain_detach_iommu(struct dmar_domain *doma=
in, struct intel_iommu *iommu)
> >               clear_bit(info->did, iommu->domain_ids);
> >               xa_erase(&domain->iommu_array, iommu->seq_id);
> >               domain->nid =3D NUMA_NO_NODE;
> > +             domain->domain.nid =3D NUMA_NO_NODE;
> >               domain_update_iommu_cap(domain);
> >               kfree(info);
> >       }
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_=
type1.c
> > index eacd6ec..6a5641e 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -59,6 +59,11 @@
> >  module_param_named(dma_entry_limit, dma_entry_limit, uint, 0644);
> >  MODULE_PARM_DESC(dma_entry_limit,
> >                "Maximum number of user DMA mappings per container (6553=
5).");
> > +static uint attach_group_by_node;
> > +module_param_named(attach_group_by_node,
> > +             attach_group_by_node, uint, 0644);
> > +MODULE_PARM_DESC(attach_group_by_node,
> > +              "Attach group to domain when it's in same node");
> >
> >  struct vfio_iommu {
> >       struct list_head        domain_list;
> > @@ -2287,19 +2292,23 @@ static int vfio_iommu_type1_attach_group(void *=
iommu_data,
> >               if (d->domain->ops =3D=3D domain->domain->ops &&
> >                   d->enforce_cache_coherency =3D=3D
> >                           domain->enforce_cache_coherency) {
> > -                     iommu_detach_group(domain->domain, group->iommu_g=
roup);
> > -                     if (!iommu_attach_group(d->domain,
> > -                                             group->iommu_group)) {
> > -                             list_add(&group->next, &d->group_list);
> > -                             iommu_domain_free(domain->domain);
> > -                             kfree(domain);
> > -                             goto done;
> > -                     }
> > +                     if ((attach_group_by_node =3D=3D 1 &&
> > +                             d->domain->nid =3D=3D domain->domain->nid=
) ||
> > +                             attach_group_by_node =3D=3D 0) {
> > +                             iommu_detach_group(domain->domain, group-=
>iommu_group);
> > +                             if (!iommu_attach_group(d->domain,
> > +                                                     group->iommu_grou=
p)) {
> > +                                     list_add(&group->next, &d->group_=
list);
> > +                                     iommu_domain_free(domain->domain)=
;
> > +                                     kfree(domain);
> > +                                     goto done;
> > +                             }
> >
> > -                     ret =3D iommu_attach_group(domain->domain,
> > -                                              group->iommu_group);
> > -                     if (ret)
> > -                             goto out_domain;
> > +                             ret =3D iommu_attach_group(domain->domain=
,
> > +                                             group->iommu_group);
> > +                             if (ret)
> > +                                     goto out_domain;
> > +                     }
> >               }
> >       }
> >
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index ec289c1..c1330ed 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -123,6 +123,7 @@ struct iommu_domain {
> >                       int users;
> >               };
> >       };
> > +     int nid;
> >  };
> >
> >  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>
> As I understand what's being done here, we're duplicating
> dmar_domain.nid to iommu_domain.nid, then when enabled by this new
> module option, we'll use this node id as part of the match to determine
> whether to create a new domain within the same container context or
> re-use an existing domain, which may have non-favorably locality.
>
> If we're going to implement a node id on the iommu_domain, it should
> replace the existing use of node id in the device specific structure
> and not simply duplicate it.  This should also account for non-VT-d use
> cases as well, for example AMD IOMMU also has a nid field on their
> protection_domain structure.  Alternatively this might be implemented
> through iommu_domain_ops so we could query the node association for a
> domain.
>
> I question whether we need this solution at all though.  AIUI the
> initial domain is allocated in proximity to the initial group.  The
> problem comes when the user asks to add an additional group into the
> same container.  Another valid solution would be that the user
> recognizes that these groups are not within the same locality and
> creates a separate container for this group.  In fact, if we're using
> QEMU here and created a q35 VM with vIOMMU, each device would have a
> separate address space and therefore a separate container and we'd
> already avoid the issue this patch tries to solve.
>
> Separate containers per QEMU AddressSpace are a requirement, but QEMU
> might also implement a policy to not re-use vfio containers between
> virtual nodes such that if each locality were mapped to separate PXBs
> with unique proximities, then simply reflecting the physical locality
> into the VM would be sufficient to avoid this non-optimal domain
> allocation placement.
>
> In any case, the type1 vfio IOMMU backend is in the early stages of
> deprecation, so any choices we make here would also need to be reflected
> in IOMMUFD, both in the compatibility and native interfaces.  Thanks,
>
> Alex
>
