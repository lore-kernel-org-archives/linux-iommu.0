Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1396FC1
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668442686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hxvXy2EJc9Qd0pwiulW/osrJ5/Pv/7EvjVfPKadkE/I=;
	b=iCszBhR/W/l+/xv//Y/yM+yZA60ECwUWEN8iNJ1NA4dyBAKfCFyNCqz62QxrPvU3HPLWKe
	5HFGkJEU3WTjDCoAvswtmMS0/0kIwJ7uMYBqZ8jWJBwgniT4h5fhmtdozSUmQN1S1jgDLK
	B+To5HYNGWQz11gQf7sQwfIFsxkKGjo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-mtMeh9YjOiOIt193nTe7kQ-1; Mon, 14 Nov 2022 11:18:05 -0500
X-MC-Unique: mtMeh9YjOiOIt193nTe7kQ-1
Received: by mail-il1-f198.google.com with SMTP id s4-20020a056e02216400b003021b648144so9602963ilv.19
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 08:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxvXy2EJc9Qd0pwiulW/osrJ5/Pv/7EvjVfPKadkE/I=;
        b=oWsuCBh7c7DsgsyjosWni9VF73C25fKLn3S/M21wjL+9SoC4V2kyqhIkFEo5QgF6SS
         zvqhLsCRfFNsqKpTYQq7Fj9gVrDXVWDpS3XI4DFkB2UcXZ6ilpCewZoE+Z/mHnHFTvwJ
         61i7a0o9pZvullt8Pza0rp87Nto4f7+cL9YPZc1oNZo5aK/QLeZCSFbNrMn9OqH5nQhu
         LFOnuPm0N+YKfGVKAZ/Z/GtlbM/dSpA5h+Z7CnhKlYTlDulj3O1TWCWnQjbBThWgb1UL
         gKJPudADVzW1K3RrZxmnlQmKzIcKWmYHpBdMyfjrrd9MhSD5AMRUKW3PTKQl2eRJRcDi
         g8rg==
X-Gm-Message-State: ANoB5pkPwQ+Fm/ssAxpzz9JvG6ds7Lb3OAFgPRoHWc3dGSEJwbDzue1w
	OzqTg8stM1lpD+lFOiSivbfcCs0Lz1fdzkify8aLHPTuRNkOKqmGK7VL9RUFvTIiXEQaAbRyRt2
	0sLujLqLk9IF5zmc=
X-Received: by 2002:a05:6e02:1d06:b0:300:f4a5:7266 with SMTP id i6-20020a056e021d0600b00300f4a57266mr6579912ila.273.1668442684531;
        Mon, 14 Nov 2022 08:18:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7lPMQWW+38n5rm2EgYIjtpOtDqi7Qiix94SnrgiMLorpuKojFAx39PuDP8JvI8meve6GVa+A==
X-Received: by 2002:a05:6e02:1d06:b0:300:f4a5:7266 with SMTP id i6-20020a056e021d0600b00300f4a57266mr6579906ila.273.1668442684300;
        Mon, 14 Nov 2022 08:18:04 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id f19-20020a05660215d300b006ddf70e3ce8sm2290113iow.7.2022.11.14.08.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 08:18:03 -0800 (PST)
Date: Mon, 14 Nov 2022 09:18:02 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: "leohou@tom.com" <leohou@tom.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>, iommu
 <iommu@lists.linux.dev>, qemu-arm <qemu-arm@nongnu.org>, jasowang
 <jasowang@redhat.com>, leohou1402 <leohou1402@gmail.com>
Subject: Re: vIOMMU&IOMMU  gIOVA  to  HPA mapping
Message-ID: <20221114091802.6be5099e.alex.williamson@redhat.com>
In-Reply-To: <2022111420314945171759@tom.com>
References: <2022111420314945171759@tom.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 14 Nov 2022 20:31:49 +0800
"leohou@tom.com" <leohou@tom.com> wrote:

> Hi=EF=BC=8C
>      Here is my application scenario=EF=BC=9A
> 1. The NIC (Network Information Center) passes through to the VM(Virtual =
Machine);
> 2. The VM uses the user mode driver DPDK;
>=20
> Question:
> 1. vIOMMU maintains the mapping gIOVA->gPA, When do you use this gPA ?

QEMU in the host derives the hVA from the gPA.  The vIOMMU driver in
QEMU is triggering the gIOVA to hVA mapping through vfio in the host.

> 2. Physical IOMMU maintains the GIOVA->HPA mapping ?  If so, by what mean=
s (gIOVA -> HPA) mapping ?

As above, the vIOMMU in the guest provides gIOVA -> gPA, in QEMU we do
the gPA -> hVA, then vfio in the host kernel performs hVA -> hPA via
page pinning.

> 3. What does QEMU do in NIC pass-through address translation =EF=BC=9F

The guest visible vIOMMU triggers MemoryListener notifications in QEMU
for the device address space, which insert and removes mappings to the
vfio layer below it.  Thanks,

Alex

