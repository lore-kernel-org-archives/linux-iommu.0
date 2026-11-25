Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795634767;
	b=rhy3OGZySyPBtoAbSUJ0cwDLeFvBniE5aZyWWscDZdSEti+bw9LtVpyR32quW9eJRptY
	 Bf32n1xTm6nWu6m/zp9xyr9jY6SPgJ0l9/WXUUENaixyYuZI9WkWi5rQJP4YZCj6sXypP
	 0ga8e5vybkDxtV0OIaWN1VkNRfLNcXgoYefGpBjpVKPIZ0GMwko5w7BGnZNgmoHbt7nuo
	 ogPlKa7NYKPh5g/5oI92FTMhfLoLvMf+DYNKGnkf8cDcq9/r26Uor8B4ztNHuo3ePzb4G
	 EmVr2ygqLjpIvmKr7yYxTb/Ao4S4lXTVmQSGlRbVrTV5G8z5z1gNpnrFKxAzZC3jX7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795634767;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=nVEfa0p4nUhAy9RkM9DjIM3WMQi1x6mlGWa6MjSqXyY=;
	b=3Hev1MzpvDr3sVcS2LcVJAua9L+EeY7TDhFs+oUGaVD9RDtyZSMgDmftPoP4iK1yvxOt
	 Ov9ZpNh5xBRgH4szv7hhlpMZxD/Lhf/afw22phal69Nmn7W5Yh2n80HuiL42j8bI/nHsR
	 z5cx+8MJbrnytj6ZckRgyQPvLEbRqhZFnLSdoZ56Lg/q4qwlJH05AgQvwch3fEM04Gv47
	 gHFcvdnujEpXnL4I7dKtkfNVaz3cnFh1am2z99ELTmYPtVytzq3rilErayD5Fwo6cQZ51
	 5Li2RSyY4t3CdB7r8PJIRTsUF6wTjeaO8ZyrPR7ooDx1QMzVTvV0VsUFFPoi+YtDZ3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AquARwiF;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDCD606A321
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 19:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDCD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AquARwiF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795634765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nVEfa0p4nUhAy9RkM9DjIM3WMQi1x6mlGWa6MjSqXyY=;
	b=AquARwiFl9ZPOjlURSKFDYDLKuJoUL7XlmJeqy0XiR3J3Z+YycWlusXRcwybGYFnzSzoHz
	CAo7YWWPXvktMkY66sEPPUoKF/mQU4fMM3D6nhsRulUE0+7jXzI7s3kTIhHgbeK9Y8lw/g
	plNYwvEbx+CKn3L76+wHsccR3UPpmPg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-y0y_UYJfOQql7Zhn0c8tuw-1; Wed, 25 Nov 2026 19:26:03 +0000
X-MC-Unique: y0y_UYJfOQql7Zhn0c8tuw-1
X-Mimecast-MFC-AGG-ID: y0y_UYJfOQql7Zhn0c8tuw_1795634763
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-94960bd17b5so990075985a.0
        for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 11:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795634763; x=1796239563;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6NmbSBdWpSm2uVrOp8tpZ65xhznrbrVh6qn8OyPhJ8=;
        b=swZg/+OXoR9lVBN5tqd7oHlQxksM9/62fK8skOwPuSVkZ5tdA1b01uMxwWK2kULUl0
         JxBswXchlmfv5ywG/pRSwL31P7kB8hmmGENz8tGOmoVMk5OXvses5B3cmzJzk83pyTDK
         qXs9bcbTlzWlfdjTKEgw4Sr5UMq2FcsUbpjFM8NB2jFhO6zFbhxjyxA1c05RZObNRnk2
         MBO51c3vJyx2X+v8J7j+V1Oecv95QGgJgWbySpigkN4voLMqI2vcgF7e80TLPMyxP1kr
         ywr34aBSMlRM8KdpHg6FdRug6ElvJXtIFh57wBvL8Uf4w0Uajy0ffpgrLW3gTaDHN4UA
         oDMQ==
X-Forwarded-Encrypted: i=1; AL+hErFwW5B7UNkoVMgXKHyApldVRRu+pGepmaKglINLgw8+w2MSd8Sxxmo6o61SuNv95RVIa8r8ag==@lists.linux.dev
X-Gm-Message-State: APuU4Z8PYW0KDxL2SOfUbJ6kwCUqmxKTgTokjOyh+kswFPui0AlxGxFp
	s0E3Y7dgmhyRy6WFE65qK7lfumkuk9NIP00jcr0bdvOwm70w83cCweDJTop1nzN5iECYx398Vnr
	4UrTeI7NlhGtQkloySgH0DbuVvV9OvbI0+suwHq4ZwHb4ygA3E3idXA2P
X-Gm-Gg: AZFdTZeH043Ot6pCeHPTRlb3776A4xmm/EGPxMMSRIKP9ViOAtjx1LpAeXRXi2t7nJk
	8xlkyhO6FJAE4vIuiphBCXn7mI8pD4UOjyc/C1SUGQzPKbaOUpDjSLDQgXRpKvfVxghEZAxUiHW
	G/SKy5rbQXcnbi6X0BtH+RMcLFYFLa+68kYQ2XoQ+jGq73m86L0xe4KWqNuoNnHrr0UNGs8Gvd5
	LHIqSPyqbHIKu2mvB6XmmXxo4GcItGvnbp8tEu+BIb7RbZmbUk0LjNuO48SOjZO8IeeFMitm57B
	TEXoqZQl10lwlAe/DnHlpqnD8KLu9Ro3yuSiJf7LMW0B+bUGNFnteoWJMME16WmQyUl4MvAxw3K
	VeHZAaFomeRBrcZev4iVQ8UCLPZ2iTrVOpbHya98b7uQuSXXJ4G7FZPuRWU1szzdXVPjD75BKnV
	bUscF3ToJ8/bS3x1QCevrNucXuMMsoxK+7galmg86zKUAz+fVTDlGQOaKDuSGOG0drUE5mUP8=
X-Received: by 2002:a05:620a:462a:b0:949:3302:1d9f with SMTP id af79cd13be357-949bab350e3mr3218670585a.78.1795634762623;
        Wed, 25 Nov 2026 11:26:02 -0800 (PST)
X-Received: by 2002:a05:620a:462a:b0:949:3302:1d9f with SMTP id af79cd13be357-949bab350e3mr3218663985a.78.1795634761937;
        Wed, 25 Nov 2026 11:26:01 -0800 (PST)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213515f467sm168088266d6.41.2026.11.25.11.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 11:26:01 -0800 (PST)
Message-ID: <2adaf0ef9e1a2fa18590f7d8dbf203c0f7de2be7.camel@redhat.com>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
From: Laurence Oberman <loberman@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>, Thorsten Leemhuis
	 <regressions@leemhuis.info>, Tobias Laas <tobias.laas@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	regressions@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,  David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Niklas Cassel <cassel@kernel.org>, 70sp
 <70sp@protonmail.com>
Date: Wed, 25 Nov 2026 14:26:00 -0500
In-Reply-To: <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
	 <awSs5Cw3hFkf4O4T@ryzen>
	 <ec36d13e-e4c2-4bfb-8b50-69d4a1628839@leemhuis.info>
	 <87b1bbd8-8113-4890-8623-738b19a9cc7b@leemhuis.info>
	 <a0ff3156-add0-4f7d-8373-09f95bd7036b@acm.org>
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KffDoVDj-qqQgNSqEz94bekFCvMQX3dWXjnhDQM5sCw_1795634763
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-25 at 10:29 -0800, Bart Van Assche wrote:
> On 11/25/26 12:52 AM, Thorsten Leemhuis wrote:
> > For completeness, =C5=A0imon Posp=C3=ADchal (now CCed) shared findings =
and a
> > WIP
> > fix (both with the help of a LLM) meanwhile here:
> >=20
> > https://lore.kernel.org/all/QISmXFlpPMgvFUKmdIBDwqn4JHHXt2NZeJzerMLHF_5=
icLo0lPKVlN0Ig9v8Vb52NmCeSFdyrao4x8KoN1DCXtDlnZS7eRIClC6vZyu-hPU%3D@protonm=
ail.com/
>=20
> Thanks Thorsten for having shared that link. The LLM I'm using
> doesn't
> like that patch and came up with the patch shown below. Untested.
>=20
> Bart.
>=20
>=20
> Subject: [PATCH] iommu/vt-d: Disable superpages on Haswell with=20
> integrated graphics
>=20
> Disable Intel VT-d superpages on bare-metal Haswell client systems
> when
> integrated graphics (0000:00:02.0) is enabled and an active remapping
> unit advertises superpage support (CAP.SLLPS).
>=20
> Per the 4th Generation Intel Core Processor Family datasheets
> (document
> 328897, section 3.1.2), the integrated graphics VT-d engine does not
> support super-pages and BIOS must disable super-pages in the default
> VT-d engine when integrated graphics is enabled. Several Haswell
> BIOSes
> leave CAP.SLLPS set on the default engine (dmar1). Whenever Linux
> installs
> a 2 MiB or 1 GiB leaf entry (PS=3D1) on dmar1, hardware aborts DMA with
> fault reason 0x0c ("non-zero reserved fields in PTE"), breaking VFIO
> passthrough, discrete GPUs, audio, and AHCI storage (exposed by
> default
> once BLK_DEF_MAX_SECTORS_CAP increased to 4 MiB in v6.17).
>=20
> Prior to commit c376a3456d8b ("iommu/vt-d: Remove
> domain_update_iommu_cap()"), domain_update_iommu_superpage()
> intersected
> superpage support across all active IOMMUs, so the IGD unit (SLLPS=3D0)
> masked off superpages on dmar1. After that commit, dmar1 domains
> started
> honoring dmar1's advertised CAP.SLLPS.
>=20
> Detect bare-metal Haswell client CPUs (INTEL_HASWELL,
> INTEL_HASWELL_L,
> INTEL_HASWELL_G), verify that the Intel integrated graphics device at
> 0000:00:02.0 is present and not on an untrusted PCI link, and clear
> intel_iommu_superpage during intel_iommu_init() before allocating any
> paging domains if an active IOMMU advertises CAP.SLLPS.
>=20
> Fixes: c376a3456d8b ("iommu/vt-d: Remove domain_update_iommu_cap()")
> Reported-by: Tobias Laas <tobias.laas@posteo.de>
> Closes:=20
> https://lore.kernel.org/linux-block/5ad27a97aafbc08a8702d5b90d09cd59@post=
eo.de/
> Reported-by: =C5=A0imon Posp=C3=ADchal <70sp@protonmail.com>
> Closes:=20
> https://lore.kernel.org/r/HYhMd0Klo0XE_yiVY7XmsgyKKFDwKHfKRy22KrycLcYd0V_=
ykA4xdbBMJXkA07YX3os6qK-NhMIVi6ITo-CkNIIF0e-GcI0UwwZmdDhAJ0I=3D@protonmail.=
com
> Cc: stable@vger.kernel.org
> ---
> =C2=A0 drivers/iommu/intel/iommu.c | 53
> +++++++++++++++++++++++++++++++++++++
> =C2=A0 1 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/iommu/intel/iommu.c
> b/drivers/iommu/intel/iommu.c
> index 5a2e705a2f2e..dd37aa25e287 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -24,6 +24,8 @@
> =C2=A0 #include <linux/tboot.h>
> =C2=A0 #include <uapi/linux/iommufd.h>
>=20
> +#include <asm/cpu_device_id.h>
> +
> =C2=A0 #include "iommu.h"
> =C2=A0 #include "../dma-iommu.h"
> =C2=A0 #include "../irq_remapping.h"
> @@ -43,6 +45,7 @@
>=20
> =C2=A0 #define DEFAULT_DOMAIN_ADDRESS_WIDTH 57
>=20
> +static void __init check_haswell_igfx_superpage(void);
> =C2=A0 static void __init check_tylersburg_isoch(void);
> =C2=A0 static int intel_iommu_set_dirty_tracking(struct iommu_domain
> *domain,
> =C2=A0=C2=A0=09=09=09=09=09=C2=A0 bool enable);
> @@ -2762,6 +2765,7 @@ int __init intel_iommu_init(void)
> =C2=A0=C2=A0=09=09pr_info("No SATC found\n");
>=20
> =C2=A0=C2=A0=09init_no_remapping_devices();
> +=09check_haswell_igfx_superpage();
>=20
> =C2=A0=C2=A0=09ret =3D init_dmars();
> =C2=A0=C2=A0=09if (ret) {
> @@ -4266,6 +4270,55 @@ static void __init
> check_tylersburg_isoch(void)
> =C2=A0=C2=A0=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vtisochctrl);
> =C2=A0 }
>=20
> +static const struct x86_cpu_id haswell_cpu_ids[] __initconst =3D {
> +=09X86_MATCH_VFM(INTEL_HASWELL, NULL),
> +=09X86_MATCH_VFM(INTEL_HASWELL_L, NULL),
> +=09X86_MATCH_VFM(INTEL_HASWELL_G, NULL),
> +=09{}
> +};
> +
> +/*
> + * Per the 4th Generation Intel Core Processor Family datasheets
> (e.g.
> + * document 328897, section 3.1.2), the integrated graphics VT-d
> engine
> + * does not support super-pages and BIOS must disable super-pages in
> the
> + * default VT-d engine when integrated graphics is enabled. Some
> Haswell
> + * BIOSes leave CAP.SLLPS set on the default engine, causing fault
> reason
> + * 0x0c (non-zero reserved fields in PTE) when a 2 MiB or 1 GiB
> superpage
> + * mapping is used.
> + */
> +static void __init check_haswell_igfx_superpage(void)
> +{
> +=09struct dmar_drhd_unit *drhd;
> +=09struct intel_iommu *iommu;
> +=09struct pci_dev *pdev;
> +
> +=09if (!intel_iommu_superpage)
> +=09=09return;
> +
> +=09if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) ||
> +=09=C2=A0=C2=A0=C2=A0 !x86_match_cpu(haswell_cpu_ids))
> +=09=09return;
> +
> +=09pdev =3D pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(2, 0));
> +=09if (!pdev)
> +=09=09return;
> +
> +=09if (pdev->vendor !=3D PCI_VENDOR_ID_INTEL ||
> !IS_GFX_DEVICE(pdev) ||
> +=09=C2=A0=C2=A0=C2=A0 risky_device(pdev)) {
> +=09=09pci_dev_put(pdev);
> +=09=09return;
> +=09}
> +=09pci_dev_put(pdev);
> +
> +=09for_each_active_iommu(iommu, drhd) {
> +=09=09if (cap_super_page_val(iommu->cap)) {
> +=09=09=09intel_iommu_superpage =3D 0;
> +=09=09=09pr_info("Disabling superpages on Haswell
> with integrated graphics\n");
> +=09=09=09break;
> +=09=09}
> +=09}
> +}
> +
> =C2=A0 /*
> =C2=A0=C2=A0 * Here we deal with a device TLB defect where device may=20
> inadvertently issue ATS
> =C2=A0=C2=A0 * invalidation completion before posted writes initiated wit=
h=20
> translated address


Hi Bart,

Tested-by: Laurence Oberman <loberman@redhat.com>

Tested on a non-affected platform to check the quirk does not
misfire: Coffee Lake i7-8700, Cannon Lake PCH AHCI, both DRHDs report
SLLPS =3D 2M|1G (dmar0 cap 1c0000c40660462, dmar1 cap d2008c40660462),
7.4.0-rc1 with intel_iommu=3Don. The quirk does not trigger, superpages
remain in use (2 MiB leaf PDEs, e.g. 0x000000018f400082, confirmed via
domain_translation_struct during 2M O_DIRECT reads), and there are no
DMAR or ATA errors. I don't have Haswell hardware, so Tobias's test is
the one that confirms the fix itself.

The Fixes: tag looks right to me. c376a3456d8b is the commit that
stopped intersecting superpage support across IOMMUs at attach time.
In my earlier mail I pointed at 5bdd86ec5d19, which only removed the
remaining hotplug user of domain_update_iommu_superpage(); both are in
v6.13-rc1.

Regards,
Laurence
