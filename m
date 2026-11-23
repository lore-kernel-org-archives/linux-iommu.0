Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795470572;
	b=2xSuVq/ifJ0eAOrEf57vKWqOQVXATPrWcUR8wC3R//OYuU2C3oxjjZpu4MC0Y5J2dtDr
	 W33zY2GP/DZTto7KVlKdt8SfHFyxILwkweJoKdnEMmzgB/SDUMTXHD6qpX9HHgPdLM8s7
	 2yQSSPsPW+5me4miVlG4kN0xx1zO0iJMc10AKRnrJn2k9p9G4q21FOCn799+o/0NXs1o0
	 CKaUVjiFa/9OCC81KAjZzmIDs2qPtuyPIJu/vuagkl0ikThd+IcpASSYbJCbQR5i67YDb
	 J3+FRc2yX85K8utfIKEPd+NilCUHPJWcI3EYluRToQYze9LrtOM0o6yEqcSKzptEnHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795470572;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:User-Agent:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
	b=pD42efC0whfWk4QR7eedV4nbVVEtMSqZYIA8kU3pG4OKymO0g9kL+QdUCwhWq+j8eL7Z
	 beVphV5fdWrbUAhnr30RXQdo2zq6zBKkfvMpFG7BHE7wmphbn16ZRyz7McJDgD4wfcXbH
	 Yx863YSFNL8i79huQA17/3+3ywTUaIWEP7Ri8J0byz4Vb7csakvbEJC9WuZW/j+49iRDp
	 qhIIsOQ6wFdiWUQvfeS4L1hU9xxON9dIRNYMNG7kx54/MUiYidkdWyPIlulzYH+cuYw82
	 P2pNhxBXU6+ntNWMGtXEM3hLAi3fO5eooiGaEcEuDI0IPQP1IdYI/Sr+QxAur7M2D9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P8utDJXe;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A772B606A334
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 21:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A772B606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P8utDJXe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795470570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
	b=P8utDJXemWcB23UD8Ny7GUBZQFlqFR2oolQreTffV2mwufBZyHki6jKc6+5UwtuI/kTfo9
	hasr5FK0ggrkdSg/WOUUIKxpO1wqyCBztiJ51m2FhqAmq03OojH3MGn9TZ5hhHsqySuD/B
	bU2N2IP9WR6a8PIdTUCWdoQPZnM7OV0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-LRtSyHBRPkyY_IQ61iTq8w-1; Mon, 23 Nov 2026 21:49:28 +0000
X-MC-Unique: LRtSyHBRPkyY_IQ61iTq8w-1
X-Mimecast-MFC-AGG-ID: LRtSyHBRPkyY_IQ61iTq8w_1795470568
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91b937ecbb4so67807966d6.2
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 13:49:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795470568; x=1796075368;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXrg3FsOffaVIw+j1I0rphKMSxfBIiuUxoQNWeelH+I=;
        b=NZHd8NkENq198B7YIIISXbam4mZjrJ2LdV4FZ1AH56FBr2Yg7YhovSvX/hbNZ3xF/v
         NQ7XIPXt8KFZHcYkvdXMbaImsJGdlU6EIUkVoEQw4eiuGKCFLxak4uXcxEIpaJvnoB8V
         M+XrexWeeHaDSotbJIvluP24N4dAs3c77Rb3E5rb96rsbFNWhGu5o+ITB/rMR+UkEalp
         tCb6DhuurZiT78rnghSMRRhGQEGpB6Bt2k+fhgWMMBKUy1aVA/gCRenac3kLrtCofx0K
         Ca8l0g6SJft/rGmtlopJ/jN9T/KVa+IoSNAMsaknj99EHF16+FsYwXpgwZErsW9mSBns
         WpRw==
X-Forwarded-Encrypted: i=1; AL+hErGvL/0pNlOUGuAdYaAebqVLlFYkOFx2TR22TPjAgqSMyut5jz8kMtZLJCydV1jH9qsbS7xJeg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9YxHkL7/o23JvIpH1wRsSV+zmhwgm0f01Ah+Lg8lclCuI6IdBZ
	Nu20xlikZ/aXEHJD4zFNYy8RZhJDrA6L6IHvd4Ehkv4KEO/osb2lcFGILD+sX6+qrBEtp7RF7hs
	gMt+hk/GdJ+3n0kJX2qHsFUT2YSNV7tyMAdkm+GtuQfQcC1OGMpE7PsTJ
X-Gm-Gg: AZFdTZfFcCtQJIGpnA2i/COTKewkD4mJqr/o1ChmkJVzGkWXmmBG5nXDaZUh90YC66b
	B4RVTQvxsa32V8tRWWSuaJGWvBjNi+zl4oGsJyIQP8pDjQPSLAqaNPLPY/BMhBBnxdOHWfp2x38
	QLxuNDMC7xzUXUp8GeuXOXXHZN/nuBK5dcfdGY9Dmwf2+d4Gp/zgunGM1tsgeAL2R3Cg+V419Qx
	K3t+IR7aKYrADW0vWkG+hsPZMYPtTeoK4oCpq3s5iLbJr29FKQs/n41PbHUYUseZyCncshZ/IIe
	diiYBpS4SQ683E5C7E12J4V2tujf3IR/Pph/tEXEAz8uFep2Eq7v04a+qiG2KFzrAJwhgYcT4Yb
	/YmvGYYYjKaM5KbrnUIxU8nVzYfkJoNFo7jR/vP8+p3ULWDwBSYES60R5r8UiyW8YLnPpbhQSrN
	dWRNd+fED2SjItiy6nwLaMM6XACIgec4lSiGRnWEfgfCN3k6PkXt8HJKD2L7Uv/hTrw4tBtOw=
X-Received: by 2002:a05:6214:252d:b0:91e:a73b:f9cb with SMTP id 6a1803df08f44-921349d1a8fmr238824566d6.4.1795470568048;
        Mon, 23 Nov 2026 13:49:28 -0800 (PST)
X-Received: by 2002:a05:6214:252d:b0:91e:a73b:f9cb with SMTP id 6a1803df08f44-921349d1a8fmr238823796d6.4.1795470567440;
        Mon, 23 Nov 2026 13:49:27 -0800 (PST)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:aa2b:ddff:fe88:da74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0f6bsm117366396d6.21.2026.11.23.13.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:49:23 -0800 (PST)
Message-ID: <7eb28c6334a655eb5bfbf3035cf1f1ff1041bb3e.camel@redhat.com>
Subject: Re: [REGRESSION] DMAR fault by Intel H97 SATA controller since
 "block: Increase BLK_DEF_MAX_SECTORS_CAP" (6.17-rc1)
From: Laurence Oberman <loberman@redhat.com>
To: Niklas Cassel <cassel@kernel.org>, Tobias Laas <tobias.laas@posteo.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	regressions@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-ide@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org,  David Woodhouse <dwmw2@infradead.org>, Lu
 Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>
Date: Mon, 23 Nov 2026 16:49:07 -0500
In-Reply-To: <awSs5Cw3hFkf4O4T@ryzen>
References: <5ad27a97aafbc08a8702d5b90d09cd59@posteo.de>
	 <awSs5Cw3hFkf4O4T@ryzen>
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
X-Mimecast-MFC-PROC-ID: PXzjP0m0uBsaOVd6L5xf-9m4kJV0Bb1tMHN6Nb3Jw2I_1795470568
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-11-23 at 22:15 +0100, Niklas Cassel wrote:
> Hello Tobias,
>=20
> On Mon, Nov 23, 2026 at 06:51:03PM +0000, Tobias Laas wrote:
> > One way forward could be to a new entry to __ata_dev_max_sec_quirks
> > similarly to the recent commit
> > a12cc63129380a5364e787d92b30a3257f66c250
> > ("ata: libata-core: Add max sector quirk to INTEL SSDSCKKB240G8").
> > However,
> > I wonder, whether that would fix the underlying issue or rather be
> > a
> > workaround, because 4088 does not fit the pattern of all other
> > entries,
> > which specify either a power of 2 or a power of 2 minus 1.
>=20
> Your attached kernel log shows that you have a
> Samsung SSD 860 PRO 1TB, FW: RVM02B6Q
>=20
> This SSD is probably quite common, so I somewhat doubt that it is the
> SSD that is at fault here.
>=20
>=20
> >=20
> > Furthermore, the first error messages are DMAR faults, and a SATA
> > SSD that
> > isn't functioning properly shouldn't cause any DMAR faults, because
> > the SATA
> > controller should never read from or write to areas outside its
> > memory
> > region.
> > Since the issue with mounting the rootfs disappears with
> > intel_iommu=3Doff, I
> > wonder, whether there is a limitation on the maxmium block size
> > either by
> > the hardware or from the configuration of the IOMMU and SATA
> > controller by
> > the kernel.
>=20
> Considering how common your SSD is, my guess is that it is somehow an
> IOMMU or a BIOS/ACPI bug (since the BIOS generates specific ACPI
> tables -
> DMAR on Intel).
>=20
>=20
> We have seen similar reports here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220693
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221713
>=20
> Does it work if you revert:
> d373449d8e97 ("iommu/vt-d: Use the generic iommu page table") ?
>=20
>=20
> It would be nice if we could involve some Intel IOMMU experts.
>=20
> If the ACPI DMAR is at fault, perhaps it is possible for the kernel
> to
> patch the ACPI DMAR for your platform.
>=20
>=20
> Kind regards,
> Niklas
Hi Niklas, Tobias,

I tried to help here but (full transparency) I had some LLM help for
further ideas after I coul dnot repriduce this on my platform.

I tried to reproduce this on a Coffee Lake desktop (i7-8700, Cannon
Lake PCH AHCI 00:17.0) whose INCLUDE_ALL DRHD reports the same
relevant capabilities as Tobias's dmar1:

  dmar1: cap d2008c40660462 ecap f050da
  (SLLPS =3D 2M|1G, ecap.C =3D 0, MGAW 39, SAGAW 4-level only)

with intel_iommu=3Don, DMA-FQ default domain, max_sectors_kb =3D 4096.

- 6.12-based kernel (pre d373449d8e97, i.e. the old VT-d page table
  code, with the larger BLK_DEF_MAX_SECTORS_CAP): 2M O_DIRECT reads,
  clean.
- 7.4.0-rc1 (generic iommu page table): 2M and 4M O_DIRECT reads and
  2M writes from hugepage-backed buffers against a SATA SSD, ~15k
  I/Os, no DMAR or ATA errors. The iommu:map tracepoint shows
  2 MiB-aligned iova/paddr mappings, and domain_translation_struct
  shows 2 MiB leaf PDEs (e.g. 0x000000039c200082, PS set), so the
  superpage path was exercised.

The 4088 vs 4089 threshold matches exactly the point where a request
first needs a full 512-page (2 MiB) IOVA, which is where superpage
mappings become possible. All three of Tobias's fault addresses fall
in the same 2 MiB window at 0xff400000.

So on this hardware neither the old nor the generic page table code
shows the problem, which supports Niklas's suspicion of something
platform specific. One difference: on Tobias's system dmar0 reports
no superpage support (cap c0000020660462) while dmar1 does; on mine
both do.

Tobias, a few things that would maybe help narrow it down:

  1. Boot with intel_iommu=3Don,sp_off and an unmodified cap. If the
     faults go away, superpages are involved.
=20
  2. The full dmesg from a failing boot, including the DMAR/DRHD
     lines. The faults are reported as DMA Write while the outstanding
     commands were WRITE FPDMA QUEUED, and I'd like to see what else
     was in flight.

Regards,
Laurence

