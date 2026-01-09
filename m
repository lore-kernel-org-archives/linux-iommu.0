Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC442741C0
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 21:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767994769; cv=pass; b=NPqLJR51ItmKmD+0IezimixgrD+E82iXwSnG0CkDnI0gTxRJkaRpPzkDO7alzfXsZmoDG2t6PnGgjfIReaEw6u/0n98mM866wvfuenzpYf+dtnrdB2nCBBRngZfqrt2tYMqxCxC74adqrpAm3aJ7FaL0U7Yb0AV0TAX+PhOWsX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767994769; c=relaxed/simple;
	bh=LRktjBIuVYAHxo/d1MN6i3X7/mOpSmpIHtlRCR3qKu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSAuJfielbn5sOKky5+L6FBDO4Y7PIaVFxmAH6xGUCQRahI1dKFDvHQInrhxf8GdelTachc2feeT0kftKHmpz4/dAwSpoIW6VXfap+oahyri7VdZU3KCGh5Gq5ulrXntYU+sUrrmAB8YpbiIKzuHG7ZklyGvhKabBRKesNwr+Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRR50XoO; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRR50XoO"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4edb8d6e98aso139671cf.0
        for <iommu@lists.linux.dev>; Fri, 09 Jan 2026 13:39:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767994766; cv=none;
        d=google.com; s=arc-20240605;
        b=bM0j8+vAIr+iNghsRFr1yHQm82BMv/ePbzyoBRXlWLv0m6a6aRMcV+gCp7+8WPwkBb
         Pjn8C4WoKrOgF3eR3ubNcclTgaq5v4tCDO7YYasB9bIhzQfPKBefbBiDLzcPTvNBDqpI
         NgMwDUQJyfXJUT27lnVbcRBdNOPSfQfwGrlsJGiiHB2o3+gKWPDxamCtRM48vKDPfMOD
         O9iwIvxjRbMFDPara5pUibmZsqNMY9h68xXizL9aLyWc4wIlDYRmwpZV00THrf48CYvt
         fkgUPo+2FAhayOwncCyDrzAi+9tNBOXrppYaERYxtc8RPVj80DJ6X1stCx++5isPJv80
         Dgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W/dylGzwVL+uyGpMZYNFm7dWAj2mtf9lYu+gfspoxo0=;
        fh=oqjE3nuZXK2YcJUvX9zMHWWyHOMOw4opOeItplO5Or0=;
        b=kp9N3oKZPQLKjIibikqarr7rgUrizb5iKLGXhBPT87/gFNDIXffQ0Z9mZGEty5wsME
         6+ZHZvkjwQMHjbcSjTKczjJe1XudxhKFQf79DqQSnzKopUPcDGuJ6Ffx03e5EFtXP3sD
         EfYLU7tfpokX7l4zY88TmQ1kIFjvoCsb0o9ImctZkWsbPk0coiLyQKbmorhOWh/2fL4z
         jZhRw5TgIgSuy6vxiqB3dmi5mE4R/MmHb96sXaHMdXIWVaqggujj6x3wx8sINucFDDBR
         j/mdKAtHwKLMr/h6mTC8hDQGocaZ2I/NRadBzK8nDZEz95QAIwlGwHoXLiR5M2/W/CIA
         pixw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767994766; x=1768599566; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/dylGzwVL+uyGpMZYNFm7dWAj2mtf9lYu+gfspoxo0=;
        b=vRR50XoOeRoIhdQG8q2SOoEB2rjCMtpP+opvwlsR7MWVIJIggiM5gfL7DDhxd987hD
         NP2v0uyBSEofe7gYbzsESGASZrohZSFxrLhyCbuk+RM8jE/whsr2qnsjeYbGnVRdP2JB
         yaZtWq3WLLgJvEUFJlTSX9UCLSUbNk2aFMYS11pqSXYDIuYpmWTyRlujv9rsUEIB5Vi1
         zYuTjS3Wa31VmMnNWrIrMOV8X9W4jCLx3aVdMj8lC3GjnE3uY2Jh8zdnKg/x8posKY9T
         1E5ucQp/Gt76G+XE6tigV3pNplMMnZHIx4s/uYCNdudBJOtZFxhTFIt6e35w6St0Z1TN
         GFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767994766; x=1768599566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W/dylGzwVL+uyGpMZYNFm7dWAj2mtf9lYu+gfspoxo0=;
        b=Zv8+817maHZ0L4R03LwEeSQoCOwSpXZCbZ5UjU8mGjzSAxiWXPdffvTVI5q2/9a6mO
         4rvPqwq++86STL5nCK4EHBgz+RnqL2wVjqbH+ywBy7f1/3iO+I+c4x1pFLrLj0i8TWZy
         jhw/rXbWvNv4Le4N3sLQfh8xbwcuiMYOwhnzY86Q9gXA9nxhjocWKPxoGa95r170Jsq6
         1ADVObvaKhGBEqZffGVJ4/dRGWvLdb0sDRKluflWztikaNmvEHVSpZTVkJrdrhZhjOcv
         ExOanui2JW335IGhVQhZjaGzKumN/UPEVyo36OE5mlJ0aBYTWHWML1ZdkQfmWrNChfd1
         y11w==
X-Forwarded-Encrypted: i=1; AJvYcCVpI9g9wny3XbkgWOK4SpQ7mDd64x/RTZEjqzIRBPbrJZq+CU9o0rEArbTb5kseA0h2sBip6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwNCLe9zccYFgwATtvPL/YX5ntpp8hTupCfw70TcN5pg/ArPUdK
	27bRDHWdn6yAoUfE+j22aWzGTCkmx2vq42BSScTX7iqb2qXQkRejWkTbHj3z7LNKFNIPIEOzxb3
	8ri5u/tTwUnxFrQVcHL2pS+sIMfUCNzoPiHbIA/PL
X-Gm-Gg: AY/fxX7U7S76QyQFPDvY6tjdpOEghiy2hydnTwtnWBdVRD3B8mdpVE+N/x0yTfHgGo1
	AP3TcrFPP1gcV1fAkE7k/qYMjeWNOS6UBPVLTjXMi561K3wmEq2ALR5M9muziKpSQ6qbuTAYJBk
	lLdWkTrAQ6UZaepA+TegTktvI/AlDUg4y89OsTTYbkl007P4gW6oZCAHQXCqK2D4HjfIJS8sLZW
	fHB7XaPCpb1Xij3D1zSZfr80vSysZYAUD6ZUj95rflMpxCz+m0A595uUQOZ7G50QLrJwfhF7L6k
	xW6r+zjnrQ77RYadyl9BUd4UBt4=
X-Received: by 2002:a05:622a:5cf:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-5011975f24dmr1250271cf.7.1767994766141; Fri, 09 Jan 2026
 13:39:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107201800.2486137-1-skhawaja@google.com> <20260107201800.2486137-3-skhawaja@google.com>
 <aV76VWKNxMw2t2kH@google.com>
In-Reply-To: <aV76VWKNxMw2t2kH@google.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Fri, 9 Jan 2026 13:39:14 -0800
X-Gm-Features: AZwV_QjwmaqpUXqrmGnwiQj3ddFB2KVdvzXHx4tgLOWE3HGuUmdzWyLSYVCMyWc
Message-ID: <CAAywjhQSPveBybmq32CtRMnmz_kyzzqRgimqZ3euXB5yZq5-sg@mail.gmail.com>
Subject: Re: [PATCH 2/3] vfio: selftests: Add support of creating iommus from iommufd
To: David Matlack <dmatlack@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:29=E2=80=AFPM David Matlack <dmatlack@google.com> =
wrote:
>
> On 2026-01-07 08:17 PM, Samiullah Khawaja wrote:
> > Add API to init a struct iommu using an already opened iommufd instance
> > and attach devices to it.
> >
> > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > ---
> >  .../vfio/lib/include/libvfio/iommu.h          |  2 +
> >  .../lib/include/libvfio/vfio_pci_device.h     |  2 +
> >  tools/testing/selftests/vfio/lib/iommu.c      | 60 +++++++++++++++++--
> >  .../selftests/vfio/lib/vfio_pci_device.c      | 16 ++++-
> >  4 files changed, 74 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h b=
/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> > index 5c9b9dc6d993..9e96da1e6fd3 100644
> > --- a/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> > +++ b/tools/testing/selftests/vfio/lib/include/libvfio/iommu.h
> > @@ -29,10 +29,12 @@ struct iommu {
> >       int container_fd;
> >       int iommufd;
> >       u32 ioas_id;
> > +     u32 hwpt_id;
> >       struct list_head dma_regions;
> >  };
> >
> >  struct iommu *iommu_init(const char *iommu_mode);
> > +struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id);
> >  void iommu_cleanup(struct iommu *iommu);
> >
> >  int __iommu_map(struct iommu *iommu, struct dma_region *region);
> > diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_=
device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device=
.h
> > index 2858885a89bb..1143ceb6a9b8 100644
> > --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.=
h
> > +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.=
h
> > @@ -19,6 +19,7 @@ struct vfio_pci_device {
> >       const char *bdf;
> >       int fd;
> >       int group_fd;
> > +     u32 dev_id;
> >
> >       struct iommu *iommu;
> >
> > @@ -65,6 +66,7 @@ void vfio_pci_config_access(struct vfio_pci_device *d=
evice, bool write,
> >  #define vfio_pci_config_writew(_d, _o, _v) vfio_pci_config_write(_d, _=
o, _v, u16)
> >  #define vfio_pci_config_writel(_d, _o, _v) vfio_pci_config_write(_d, _=
o, _v, u32)
> >
> > +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, stru=
ct iommu *iommu);
> >  void vfio_pci_irq_enable(struct vfio_pci_device *device, u32 index,
> >                        u32 vector, int count);
> >  void vfio_pci_irq_disable(struct vfio_pci_device *device, u32 index);
> > diff --git a/tools/testing/selftests/vfio/lib/iommu.c b/tools/testing/s=
elftests/vfio/lib/iommu.c
> > index 58b7fb7430d4..2c67d7e24d0c 100644
> > --- a/tools/testing/selftests/vfio/lib/iommu.c
> > +++ b/tools/testing/selftests/vfio/lib/iommu.c
> > @@ -408,6 +408,18 @@ struct iommu_iova_range *iommu_iova_ranges(struct =
iommu *iommu, u32 *nranges)
> >       return ranges;
> >  }
> >
> > +static u32 iommufd_hwpt_alloc(struct iommu *iommu, u32 dev_id)
> > +{
> > +     struct iommu_hwpt_alloc args =3D {
> > +             .size =3D sizeof(args),
> > +             .pt_id =3D iommu->ioas_id,
> > +             .dev_id =3D dev_id,
> > +     };
> > +
> > +     ioctl_assert(iommu->iommufd, IOMMU_HWPT_ALLOC, &args);
> > +     return args.out_hwpt_id;
> > +}
> > +
> >  static u32 iommufd_ioas_alloc(int iommufd)
> >  {
> >       struct iommu_ioas_alloc args =3D {
> > @@ -418,11 +430,9 @@ static u32 iommufd_ioas_alloc(int iommufd)
> >       return args.out_ioas_id;
> >  }
> >
> > -struct iommu *iommu_init(const char *iommu_mode)
> > +static struct iommu *iommu_alloc(const char *iommu_mode)
> >  {
> > -     const char *container_path;
> >       struct iommu *iommu;
> > -     int version;
> >
> >       iommu =3D calloc(1, sizeof(*iommu));
> >       VFIO_ASSERT_NOT_NULL(iommu);
> > @@ -430,6 +440,16 @@ struct iommu *iommu_init(const char *iommu_mode)
> >       INIT_LIST_HEAD(&iommu->dma_regions);
> >
> >       iommu->mode =3D lookup_iommu_mode(iommu_mode);
> > +     return iommu;
> > +}
> > +
> > +struct iommu *iommu_init(const char *iommu_mode)
> > +{
> > +     const char *container_path;
> > +     struct iommu *iommu;
> > +     int version;
> > +
> > +     iommu =3D iommu_alloc(iommu_mode);
> >
> >       container_path =3D iommu->mode->container_path;
> >       if (container_path) {
> > @@ -453,10 +473,42 @@ struct iommu *iommu_init(const char *iommu_mode)
> >       return iommu;
> >  }
> >
> > +struct iommu *iommufd_iommu_init(int iommufd, u32 dev_id)
>
> I don't think the name really captures what this routine is doing. How
> about iommufd_dup()?

The reason I used _iommu_init because it creates a new hwpt and ioas
also, and it represents a separate "struct iommu". dup might indicate
that it is pointing to the same IOAS? Do you think maybe dup is an
implementation detail that doesn't need to be conveyed?

Do you think maybe I should rename it to iommufd_device_iommu_init as
it is creating an hwpt compatible with the device "dev_id"? Or
iommufd_iommu_init_for_device?
>
> > +{
> > +     struct iommu *iommu;
> > +
> > +     iommu =3D iommu_alloc("iommufd");
> > +
> > +     iommu->iommufd =3D dup(iommufd);
> > +     VFIO_ASSERT_GT(iommu->iommufd, 0);
> > +
> > +     iommu->ioas_id =3D iommufd_ioas_alloc(iommu->iommufd);
> > +     iommu->hwpt_id =3D iommufd_hwpt_alloc(iommu, dev_id);
> > +
> > +     return iommu;
> > +}
> > +
> > +static void iommufd_iommu_cleanup(struct iommu *iommu)
>
> nit: iommufd_cleanup()

Agreed.
>
> > +{
> > +     struct iommu_destroy args =3D {
> > +             .size =3D sizeof(args),
> > +     };
> > +
> > +     if (iommu->hwpt_id) {
> > +             args.id =3D iommu->hwpt_id;
> > +             ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
> > +     }
> > +
> > +     args.id =3D iommu->ioas_id;
> > +     ioctl_assert(iommu->iommufd, IOMMU_DESTROY, &args);
> > +
> > +     VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
> > +}
> > +
> >  void iommu_cleanup(struct iommu *iommu)
> >  {
> >       if (iommu->iommufd)
> > -             VFIO_ASSERT_EQ(close(iommu->iommufd), 0);
> > +             iommufd_iommu_cleanup(iommu);
> >       else
> >               VFIO_ASSERT_EQ(close(iommu->container_fd), 0);
> >
> > diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools=
/testing/selftests/vfio/lib/vfio_pci_device.c
> > index fac4c0ecadef..9bc1f5ade5c4 100644
> > --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> > @@ -298,7 +298,7 @@ const char *vfio_pci_get_cdev_path(const char *bdf)
> >       return cdev_path;
> >  }
> >
> > -static void vfio_device_bind_iommufd(int device_fd, int iommufd)
> > +static int vfio_device_bind_iommufd(int device_fd, int iommufd)
> >  {
> >       struct vfio_device_bind_iommufd args =3D {
> >               .argsz =3D sizeof(args),
> > @@ -306,6 +306,7 @@ static void vfio_device_bind_iommufd(int device_fd,=
 int iommufd)
> >       };
> >
> >       ioctl_assert(device_fd, VFIO_DEVICE_BIND_IOMMUFD, &args);
> > +     return args.out_devid;
> >  }
> >
> >  static void vfio_device_attach_iommufd_pt(int device_fd, u32 pt_id)
> > @@ -326,10 +327,21 @@ static void vfio_pci_iommufd_setup(struct vfio_pc=
i_device *device, const char *b
> >       VFIO_ASSERT_GE(device->fd, 0);
> >       free((void *)cdev_path);
> >
> > -     vfio_device_bind_iommufd(device->fd, device->iommu->iommufd);
> > +     device->dev_id =3D vfio_device_bind_iommufd(device->fd, device->i=
ommu->iommufd);
> >       vfio_device_attach_iommufd_pt(device->fd, device->iommu->ioas_id)=
;
> >  }
> >
> > +void vfio_pci_device_attach_iommu(struct vfio_pci_device *device, stru=
ct iommu *iommu)
> > +{
> > +     u32 pt_id =3D iommu->ioas_id;
>
> /* Only iommufd supports changing struct iommu attachments */
> VFIO_ASSERT_TRUE(iommu->iommufd);

Agreed
>
> > +
> > +     if (iommu->hwpt_id)
> > +             pt_id =3D iommu->hwpt_id;
> > +
> > +     VFIO_ASSERT_NE(pt_id, 0);
> > +     vfio_device_attach_iommufd_pt(device->fd, pt_id);
>
> device->iommu =3D iommu;
>
> > +}
> > +
> >  struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct i=
ommu *iommu)
> >  {
> >       struct vfio_pci_device *device;
> > --
> > 2.52.0.351.gbe84eed79e-goog
> >

Thank you for the feedback.
