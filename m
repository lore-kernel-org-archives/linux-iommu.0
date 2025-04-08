Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612914AD29
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 06:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744093022; cv=none; b=Xlj+VrNvw/QK+JhnMu+aaaqTidh90JU9CGg4oc6FbLljMgbX08u78kdhQvgwxRhCr0u4/0Qc1HWKRUqYlfS9G9RcDJcrQHa23AhkkIZDV8EyS2TG4WjoEE+BBJUmfrESUv2G1f5F2Mt+kis+R7iR6eQwovWP8YKkLqXBLPVS3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744093022; c=relaxed/simple;
	bh=WvB+DjbgCeElNlj05BGwgV8GNZOVQdVUljaUHv5AKys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utWuaVWOG2E9URaI2ufe4PE090kR8eQl1pY0k5zQ72eErVw1hByZGeGrtUcd76+rWpLUWK7HABEJsnWURZYu+fW8PMwMZysEfeGLrT46Meyr6PAhzWJFBGKr6BPJa6xKQEJ02hI/WFnyTOhkpe3zc7UMK1WqWvoiOBAjmovmrXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SD7OEbWz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SD7OEbWz"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54993c68ba0so5802382e87.2
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 23:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744093018; x=1744697818; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lw+cGuu24MCFma9hbTCJ3waWTAm326WwXLS0tbmD93k=;
        b=SD7OEbWzZLqrOQLcnl70+3b9TMPR7+n6XkG9U9oRm8GGqpHLRYrFFpiYchdPzt0H6o
         3+lngfyA6wo6YrDcN9a0CjQON1H14VcUr9UF28DSyygsSafMhq3LtGBZSwQ+LUw5NIh8
         aYwRTbhRlzKi0KXm6CwpoOZim9p0pwpTmkrIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744093018; x=1744697818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lw+cGuu24MCFma9hbTCJ3waWTAm326WwXLS0tbmD93k=;
        b=a2Aarg14XQrF5DqGtnMa9Bz3vauUqGJXqqz2Jn/ZXG8CqNwTI+l80rHfkEFpdufXW7
         vNpesJ1EIVSpdV1bEpGcBoiyDI5BPRw9bqngJPyFF4Bseka/hm29cpj5DLMQ8Nv+nub9
         3ReKZ8nFUodsjaV8Y96ixVc8DKE32BcjgMf7ZZBI4k87PrUjPOcc+7ntSU6lijOxMg0B
         SGLPhJplJIFge/0+X5KwcQcSkbuBn2AfW2yEXtrLKwVDC1CmQ6+QCBk9Tzd5Uk/aPPc3
         YOoaZkwtzFIZJKUVmlPHlLhX3OSq0Hv4Uk8IBhtOMN8P83TU9pFkwkSd0QaMHradr6O2
         38vg==
X-Forwarded-Encrypted: i=1; AJvYcCVPknDdMw7vH9CvFaa3nLm5/FyHNJD5Brk5XOOjAlHuNAhBKyQA6/F5n318ol4/7KaxtN0zbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKN2Ot3vOALDxnNwF2JKx4F2qdLBoJyj9r9wF2NdU/+xzKXi0U
	IpmtTwXH58b2BE4tnX4Kda7FNy47qWKj7OyxNWHP3IlnVDVkoWraLBVJPnUmcKNRChQPTNh1kWx
	qYMgcD7faqe7hSkYa/gMoJuf18juMd4hAA/Yx
X-Gm-Gg: ASbGncuR1/g4egrQu9ZkNaEvI1jah+Lc+xHVTtV9XoCSUaqPtXZSBSyShUr5qLf993B
	vYFXeu3CSNRMlAEhRdap7U7q9JhMZ5CNup+3OBbs7T73EgmrBHgbHx/cV8zrJuWMMi76LhsMiQa
	5ZIgVbHXgYbctAwY8tcTAWVrbKolbh3c3i0b+VYUYjTAYNPN+bA/TVP1qBJfEGFxK8
X-Google-Smtp-Source: AGHT+IFb+TeowgfoI9jyPGgjiTC84g5fC1KcHX3rW/8XVKEIp2euKeYNGDybwWA09DVF9ijzM+qUVsOK9TjVFAYBLkI=
X-Received: by 2002:a05:6512:12c3:b0:545:f4b:ed58 with SMTP id
 2adb3069b0e04-54c22786586mr4008465e87.18.1744093018538; Mon, 07 Apr 2025
 23:16:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250403-fix-mtk-iommu-error-v2-1-fe8b18f8b0a8@collabora.com>
 <CAGXv+5HJpTYmQ2h-GD7GjyeYT7bL9EBCvu0mz5LgpzJZtzfW0w@mail.gmail.com>
 <2792b9df-fc82-4252-af64-cf888a36f561@arm.com> <CAGXv+5E=NhFcS0fG_kbLTnF6xfTkBOHQwsNxszHDcgWfn3zFiA@mail.gmail.com>
In-Reply-To: <CAGXv+5E=NhFcS0fG_kbLTnF6xfTkBOHQwsNxszHDcgWfn3zFiA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 8 Apr 2025 14:16:45 +0800
X-Gm-Features: ATxdqUFzThHrbbZ4rjRkEmEZgPttTHwgVmz8SvDgRpu43MI3Grht_HvHvymI90U
Message-ID: <CAGXv+5FybqwFThh2VZh+U-RUs_LFB_AzFQyi7rvpc8jvgybh1A@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/mediatek: Fix NULL pointer deference in mtk_iommu_device_group
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
	Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"Rob Herring (Arm)" <robh@kernel.org>, kernel@collabora.com, Joerg Roedel <jroedel@suse.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 12:46=E2=80=AFPM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> On Mon, Apr 7, 2025 at 8:38=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
> >
> > On 2025-04-07 6:17 am, Chen-Yu Tsai wrote:
> > > Hi,
> > >
> > > On Thu, Apr 3, 2025 at 6:24=E2=80=AFPM Louis-Alexis Eyraud
> > > <louisalexis.eyraud@collabora.com> wrote:
> > >>
> > >> Currently, mtk_iommu calls during probe iommu_device_register before
> > >> the hw_list from driver data is initialized. Since iommu probing iss=
ue
> > >> fix, it leads to NULL pointer dereference in mtk_iommu_device_group =
when
> > >> hw_list is accessed with list_first_entry (not null safe).
> > >>
> > >> So, change the call order to ensure iommu_device_register is called
> > >> after the driver data are initialized.
> > >>
> > >> Fixes: 9e3a2a643653 ("iommu/mediatek: Adapt sharing and non-sharing =
pgtable case")
> > >> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper pro=
be path")
> > >> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> > >> Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183 Juniper, MT818=
6 Tentacruel
> > >> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@c=
ollabora.com>
> > >> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@col=
labora.com>
> > >> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com=
>
> > >> ---
> > >> This patch fixes a NULL pointer dereference that occurs during the
> > >> mtk_iommu driver probe and observed at least on several Mediatek Gen=
io boards:
> > >> ```
> > >> Unable to handle kernel NULL pointer dereference at virtual address =
0000000000000000
> > >
> > > This is a reminder to please land this and send to Linus ASAP.
> > >
> > > This fixes the v6.15-rc1 kernel on all the MediaTek Chromebook platfo=
rms,
> > > except for MT8188, which seems to have another issue in iommu_get_dma=
_domain()
> > > used from the DRM driver:
> > >
> > >      Disabling lock debugging due to kernel taint
> > >      Unable to handle kernel NULL pointer dereference at virtual
> > > address 0000000000000158
> >
> >  From the offset and the stacktrace code dump, this would appear to be
> > the dereference of dev->iommu_group->default_domain, when
> > dev->iommu_group is NULL (and CONFIG_DEBUG_LOCK_ALLOC makes the mutex
> > really big). Which is a bit weird, as to get into iommu-dma at all in
> > that state would suggest that whatever device this is has been removed
> > and had its group torn down again after iommu_setup_dma_ops() has run..=
.
> > but either way that implies the DRM driver is passing an arbitrary
> > device to the DMA API without making sure it's actualy valid.
> >
> > Trying to trace the provenance of dma_dev from mtk_gem_create() back
> > through the rest of the driver is quite the rabbit-hole, but it seems
> > like in at least one case it can lead back to an
> > of_find_device_by_node() in ovl_adaptor_comp_init(), which definitely
> > looks sufficiently sketchy.
>
> It kind of makes sense since the "display controller" is composed of
> many individual hardware blocks. The struct device tied to the DRM
> driver is more or less just a place holder. Only the first block,
> either the OVL (overlay compositing engine) or RDMA (scanout engine)
> accesses memory, so I think it makes sense to use that as the dma_dev.
>
> With some more logs, I did find something else fishy. Here the IOMMU
> for the second display pipeline fails to probe:
>
>     mtk-iommu 1c028000.iommu: error -EINVAL: Failed to register IOMMU
>     mtk-iommu 1c028000.iommu: probe with driver mtk-iommu failed with err=
or -22

This looks like it's caused by an incorrect IOMMU description for this
device. It's referencing the wrong IOMMU device for the port it is tied
to.

I'll send a patch for this.

> Then later on, deferred probe times out, and the display pipeline is
> brought up regardless:
>
>     mediatek-disp-ovl 1c000000.ovl: deferred probe timeout, ignoring depe=
ndency
>     mediatek-disp-ovl 1c000000.ovl: Adding to IOMMU failed: -110
>     mediatek-disp-rdma 1c002000.rdma: deferred probe timeout, ignoring
> dependency
>     mediatek-disp-rdma 1c002000.rdma: Adding to IOMMU failed: -110
>     (repeats for all the individual components of the display pipeline)
>     mediatek-drm mediatek-drm.16.auto: bound 1c000000.ovl (ops
> mtk_disp_ovl_component_ops)
>     mediatek-drm mediatek-drm.16.auto: bound 1c002000.rdma (ops
> mtk_disp_rdma_component_ops)
>     (repeats for all the individual components of the display pipeline)
>     mediatek-drm mediatek-drm.16.auto: DMA device is 1c000000.ovl
>     [drm] Initialized mediatek 1.0.0 for mediatek-drm.16.auto on minor 1
>
> And all without a functional IOMMU.
>
> So I think this brings up two more questions:
>
> 1. Why is the IOMMU failing to probe?
> 2. Why is the core code still going the IOMMU DMA alloc path if there
>    is no usable IOMMU?
>
> I'll look into the first question first. Insights welcome for the second
> one.
>
>
> Thanks
> ChenYu
>
>
> > Thanks,
> > Robin.
> >
> > >      Mem abort info:
> > >        ESR =3D 0x0000000096000005
> > >        EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > >        SET =3D 0, FnV =3D 0
> > >        EA =3D 0, S1PTW =3D 0
> > >        FSC =3D 0x05: level 1 translation fault
> > >      Data abort info:
> > >        ISV =3D 0, ISS =3D 0x00000005, ISS2 =3D 0x00000000
> > >        CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > >        GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > >      user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000001185ab000
> > >      [0000000000000158] pgd=3D0000000000000000, p4d=3D000000000000000=
0,
> > > pud=3D0000000000000000
> > >      Internal error: Oops: 0000000096000005 [#1]  SMP
> > >      Modules linked in: mtk_vcodec_dec_hw mtk_vcodec_dec mtk_vcodec_e=
nc
> > > v4l2_vp9 v4l2_h264 mtk_vcodec_dbgfs mtk_jpeg mtk_vcodec_common
> > > cros_ec_sensors mtk_jpeg_enc_hw cros_ec_sensors_core mtk_jpeg_dec_hw
> > > mtk_vpu v4l2_mem2mem videobuf2_v4l2 snd_sof_mt8186
> > > videobuf2_dma_contig snd_sof_xtensa_dsp sha1_ce videobuf2_memops
> > > mtk_adsp_common mtk_scp videobuf2_common snd_sof_of mtk_rpmsg snd_sof
> > > rpmsg_core cros_ec_sensorhub hid_google_hammer hid_vivaldi_common
> > > snd_sof_utils mtk_scp_ipi fuse
> > >      CPU: 6 UID: 0 PID: 12 Comm: kworker/u32:0 Tainted: G    B
> > >       6.15.0-rc1-00001-gfed05d98b726 #628 PREEMPT
> > > 06e695da6360d22824958738f9ba1c9b2416be19
> > >      Tainted: [B]=3DBAD_PAGE
> > >      Hardware name: Google Ciri sku2 board (DT)
> > >      Workqueue: events_unbound deferred_probe_work_func
> > >      pstate: 40400009 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--=
)
> > >      pc : iommu_get_dma_domain+0x30/0x58
> > >      lr : iommu_get_dma_domain+0x30/0x58
> > >      sp : ffffffc080186ee0
> > >      x29: ffffffc080186ee0 x28: ffffff80c4c59028 x27: 000000000000000=
0
> > >      x26: 0000000000000014 x25: 0068000000000f0b x24: ffffff80c4c5ca2=
8
> > >      x23: 00000000008ca000 x22: 1ffffff810030df8 x21: ffffff80c20ea01=
0
> > >      x20: ffffff80c20ea010 x19: 0000000000000000 x18: 000000000000000=
0
> > >      x17: 3d3d3d3d3d3d3d3d x16: 3d3d3d3d3d3d3d3d x15: 072007200720072=
0
> > >      x14: 0720072007200720 x13: ffffff80c0a1bb80 x12: ffffffbae2ca45e=
9
> > >      x11: 1ffffffae2ca45e8 x10: ffffffbae2ca45e8 x9 : dfffffc00000000=
0
> > >      x8 : 000000451d35ba18 x7 : ffffffd716522f47 x6 : 000000000000000=
1
> > >      x5 : ffffffd716522f40 x4 : ffffffbae2ca45e9 x3 : ffffffd713717e6=
c
> > >      x2 : 0000000000000001 x1 : ffffff80c0941dc0 x0 : 000000000000000=
1
> > >      Call trace:
> > >       iommu_get_dma_domain+0x30/0x58 (P)
> > >       __iommu_dma_alloc_noncontiguous+0x34/0x498
> > >       iommu_dma_alloc+0x2f0/0x3e0
> > >       dma_alloc_attrs+0x1b4/0x3b8
> > >       mtk_gem_create+0x124/0x170
> > >       mtk_gem_dumb_create+0x84/0x180
> > >       drm_mode_create_dumb+0xf8/0x128
> > >       drm_client_framebuffer_create+0x11c/0x240
> > >       drm_fbdev_dma_driver_fbdev_probe+0x154/0x5a0
> > >       __drm_fb_helper_initial_config_and_unlock+0x4f0/0x928
> > >       drm_fb_helper_initial_config+0x50/0x68
> > >       drm_fbdev_client_hotplug+0xc0/0x120
> > >       drm_client_register+0xa0/0x100
> > >       drm_fbdev_client_setup+0xc8/0x260
> > >       drm_client_setup+0x60/0xd0
> > >       mtk_drm_bind+0x4f0/0xaf0
> > >       try_to_bring_up_aggregate_device+0x258/0x2f0
> > >       __component_add+0x104/0x240
> > >       component_add+0x1c/0x38
> > >       mtk_disp_rdma_probe+0x180/0x260
> > >       platform_probe+0x98/0x128
> > >       really_probe+0x118/0x3c0
> > >       __driver_probe_device+0xc0/0x198
> > >       driver_probe_device+0x64/0x1f8
> > >       __device_attach_driver+0xf0/0x1b0
> > >       bus_for_each_drv+0xf4/0x178
> > >       __device_attach+0x120/0x240
> > >       device_initial_probe+0x1c/0x30
> > >       bus_probe_device+0xdc/0xe8
> > >       deferred_probe_work_func+0xec/0x140
> > >       process_one_work+0x428/0xa80
> > >       worker_thread+0x2c0/0x538
> > >       kthread+0x258/0x380
> > >       ret_from_fork+0x10/0x20
> > >      Code: 97e8f12c f9422673 91056260 97e8f129 (f940ae60)
> > >      ---[ end trace 0000000000000000 ]---
> > >      Kernel panic - not syncing: Oops: Fatal exception
> > >      SMP: stopping secondary CPUs
> > >      Kernel Offset: 0x1693600000 from 0xffffffc080000000
> > >      PHYS_OFFSET: 0x40000000
> > >      CPU features: 0x0e00,000002e0,01202650,8200720b
> > >      Memory Limit: none
> > >      Rebooting in 30 seconds..
> > >
> > >
> > >
> > > Thanks
> > > ChenYu
> > >
> > >> Mem abort info:
> > >>    ESR =3D 0x0000000096000004
> > >>    EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > >>    SET =3D 0, FnV =3D 0
> > >>    EA =3D 0, S1PTW =3D 0
> > >>    FSC =3D 0x04: level 0 translation fault
> > >> Data abort info:
> > >>    ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > >>    CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > >>    GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > >> user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000101380000
> > >> [0000000000000000] pgd=3D0000000000000000, p4d=3D0000000000000000
> > >> Internal error: Oops: 0000000096000004 [#1]  SMP
> > >> Modules linked in: btusb btrtl mt6315_regulator btintel mtk_vcodec_d=
ec
> > >>    btmtk v4l2_vp9 btbcm mtk_vcodec_enc v4l2_h264 mtk_vcodec_dbgfs
> > >>    bluetooth mtk_jpeg ecdh_generic mtk_vcodec_common mtk_jpeg_enc_hw
> > >>    mtk_jpeg_dec_hw ecc v4l2_mem2mem rfkill videobuf2_dma_contig
> > >>    videobuf2_memops videobuf2_v4l2 videodev videobuf2_common mc
> > >>    mt6360_charger mcp251xfd it5205 goodix_ts can_dev panfrost
> > >>    drm_shmem_helper gpu_sched lvts_thermal mtk_svs mtk_adsp_mailbox
> > >>    snd_soc_dmic mtk_scp mtk_rpmsg mtk_scp_ipi mtk_cmdq_mailbox
> > >>    mediatek_cpufreq_hw spmi_mtk_pmif fuse dm_mod ip_tables x_tables
> > >>    ipv6 mediatek_drm tcpci_mt6360 drm_display_helper drm_client_lib
> > >>    tcpci drm_dma_helper drm_kms_helper tcpm drm mtk_mutex mtk_mmsys
> > >>    typec rtc_mt6397 mtk_cmdq_helper phy_mtk_pcie pcie_mediatek_gen3
> > >>    dwmac_mediatek stmmac_platform stmmac pwm_mtk_disp pcs_xpcs pwm_b=
l
> > >>    backlight
> > >> CPU: 5 UID: 0 PID: 12 Comm: kworker/u32:0 Not tainted 6.14.0-next-20=
250326 #4 PREEMPT
> > >> Hardware name: MediaTek Genio 1200 EVK-P1V2-EMMC (DT)
> > >> Workqueue: events_unbound deferred_probe_work_func
> > >> pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > >> pc : mtk_iommu_device_group+0x2c/0xe0
> > >> lr : __iommu_probe_device+0x130/0x490
> > >> sp : ffff8000827b3970
> > >> x29: ffff8000827b3970 x28: ffff0000c0028000 x27: ffff80008164f2b8
> > >> x26: ffff0000cbc47130 x25: ffff80008096a9f0 x24: ffff80008164f5a8
> > >> x23: ffff800082684b60 x22: ffff8000827b3a80 x21: ffff0000cbc47130
> > >> x20: ffffffffffffffed x19: ffff0000c117c010 x18: 0000000000000000
> > >> x17: 6f702d616d642d64 x16: 6574636972747365 x15: 0000000000000002
> > >> x14: 0000000000000000 x13: 0000000000128d55 x12: 6f632d616d642e30
> > >> x11: 0000000000000100 x10: 0000000000000001 x9 : 0000000000000220
> > >> x8 : 0101010101010101 x7 : ffff0000c117c010 x6 : 306c766f2c727461
> > >> x5 : 0000000000000000 x4 : ffff0000c10a2de8 x3 : ffff0000c10a2e70
> > >> x2 : ffff0000c01a4600 x1 : 0000000000000000 x0 : ffff0000c65470c0
> > >> Call trace:
> > >>   mtk_iommu_device_group+0x2c/0xe0 (P)
> > >>   __iommu_probe_device+0x130/0x490
> > >>   probe_iommu_group+0x3c/0x70
> > >>   bus_for_each_dev+0x7c/0xe0
> > >>   iommu_device_register+0xd8/0x22c
> > >>   mtk_iommu_probe+0x270/0x53c
> > >>   platform_probe+0x68/0xd8
> > >>   really_probe+0xbc/0x2c0
> > >>   __driver_probe_device+0x78/0x120
> > >>   driver_probe_device+0x3c/0x154
> > >>   __device_attach_driver+0xb8/0x140
> > >>   bus_for_each_drv+0x88/0xe8
> > >>   __device_attach+0xa0/0x190
> > >>   device_initial_probe+0x14/0x20
> > >>   bus_probe_device+0xb4/0xc0
> > >>   deferred_probe_work_func+0x90/0xc8
> > >>   process_one_work+0x148/0x284
> > >>   worker_thread+0x2cc/0x3cc
> > >>   kthread+0x12c/0x204
> > >>   ret_from_fork+0x10/0x20
> > >> Code: b4000500 f9401c01 92800254 f9409821 (f9400035)
> > >> ---[ end trace 0000000000000000 ]---
> > >> ```
> > >>
> > >> I've tested this patch on Mediatek Genio 510-EVK and 1200-EVK boards
> > >> with a kernel based on linux-next (tag: next-20250327).
> > >> ---
> > >> Changes in v2:
> > >> - Fix goto label usage in device registration error case
> > >> - Add review and test trailers
> > >> - Link to v1: https://lore.kernel.org/r/20250327-fix-mtk-iommu-error=
-v1-1-df969158e752@collabora.com
> > >> ---
> > >>   drivers/iommu/mtk_iommu.c | 26 +++++++++++++-------------
> > >>   1 file changed, 13 insertions(+), 13 deletions(-)
> > >>
> > >> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > >> index 034b0e670384a24df10130cbbff95ce8e0bc092d..df98d0c65f5469c6803c=
d9d151c85ad855558cf5 100644
> > >> --- a/drivers/iommu/mtk_iommu.c
> > >> +++ b/drivers/iommu/mtk_iommu.c
> > >> @@ -1372,15 +1372,6 @@ static int mtk_iommu_probe(struct platform_de=
vice *pdev)
> > >>          platform_set_drvdata(pdev, data);
> > >>          mutex_init(&data->mutex);
> > >>
> > >> -       ret =3D iommu_device_sysfs_add(&data->iommu, dev, NULL,
> > >> -                                    "mtk-iommu.%pa", &ioaddr);
> > >> -       if (ret)
> > >> -               goto out_link_remove;
> > >> -
> > >> -       ret =3D iommu_device_register(&data->iommu, &mtk_iommu_ops, =
dev);
> > >> -       if (ret)
> > >> -               goto out_sysfs_remove;
> > >> -
> > >>          if (MTK_IOMMU_HAS_FLAG(data->plat_data, SHARE_PGTABLE)) {
> > >>                  list_add_tail(&data->list, data->plat_data->hw_list=
);
> > >>                  data->hw_list =3D data->plat_data->hw_list;
> > >> @@ -1390,19 +1381,28 @@ static int mtk_iommu_probe(struct platform_d=
evice *pdev)
> > >>                  data->hw_list =3D &data->hw_list_head;
> > >>          }
> > >>
> > >> +       ret =3D iommu_device_sysfs_add(&data->iommu, dev, NULL,
> > >> +                                    "mtk-iommu.%pa", &ioaddr);
> > >> +       if (ret)
> > >> +               goto out_list_del;
> > >> +
> > >> +       ret =3D iommu_device_register(&data->iommu, &mtk_iommu_ops, =
dev);
> > >> +       if (ret)
> > >> +               goto out_sysfs_remove;
> > >> +
> > >>          if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) =
{
> > >>                  ret =3D component_master_add_with_match(dev, &mtk_i=
ommu_com_ops, match);
> > >>                  if (ret)
> > >> -                       goto out_list_del;
> > >> +                       goto out_device_unregister;
> > >>          }
> > >>          return ret;
> > >>
> > >> -out_list_del:
> > >> -       list_del(&data->list);
> > >> +out_device_unregister:
> > >>          iommu_device_unregister(&data->iommu);
> > >>   out_sysfs_remove:
> > >>          iommu_device_sysfs_remove(&data->iommu);
> > >> -out_link_remove:
> > >> +out_list_del:
> > >> +       list_del(&data->list);
> > >>          if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
> > >>                  device_link_remove(data->smicomm_dev, dev);
> > >>   out_runtime_disable:
> > >>
> > >> ---
> > >> base-commit: bc960e3e32c8b940c10b14557271355f66ae4db1
> > >> change-id: 20250327-fix-mtk-iommu-error-af6ec347d057
> > >>
> > >> Best regards,
> > >> --
> > >> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> > >>
> >
