Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792641088;
	b=YvJvmn8qP2S6WzGXqW6cCL2DnkhY8ePcrQGTxZeSxNJ+ZLGNB6IBpFnX8amz5hmFBKsP
	 Nmp6iyR+UQubCdbSV+eIv4bWKmeBsOyzfOsoyXjS9cmY5/cXpzxN0vai3mQhlmaq4Dq+9
	 L5tfasyikmxX+POBT4qzu+y3qj2aRApFi935AsiyozytnuUWUR0Cb2MvxMIB04g0pmQIJ
	 QI/GlcJ6P2+Gh641hZnTHP9EOSyyWC1LT7tqFfLcQtKyKp7RpjavC2ze/jvupTP/0RL0B
	 Fx+I43EBS6zhMuy01nlgaJMolx/EADhRedKjqXyrlu82QYf1VcQNBdzoCVDajcb+pCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792641088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
	b=I6m9nusEXBDnztge3SUv8jIvglYIxfFg0/7UPCRBp2qV6Noksk3obr05tdCRKWHVKIKJ
	 Msl3HKeoAdg/LDpeuzAU9G/APpBKMEN+ULgIXdZEOdAxro8t6jue8sXiRMtMqi/76lpCo
	 zI6xe6xdrduUF7Mr0P9kN8YWO7OhSPJPlAY87pGx3CtCwSWAp6ob+FUJP7x0zD21KOyWp
	 GUAqP0/VTTqRF35fn4SHtqenIY7uvFlxXsxcqNmA1ZqmitnSOfK4P2izXDonHi5mG40NF
	 eVdnUPv+S38t9MhisXaAPiPeLRU6gX0LgwyeGs1uPr2kG/p9fadthWDypRDXSLhlfGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=a715fJQH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BFF606A31E
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 03:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42BFF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=a715fJQH
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so1405452a12.1
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 20:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792641086; cv=none;
        d=google.com; s=arc-20260327;
        b=Iy6Ifohs2V28/n+LP6jgF3OaVxlXedK97d0mrbVqHqLJEfaCOjcQCPLmPjzZBKZ7nW
         sBp21xKMFrwSstleC5YE+BrZ9e3AXsKf/v3ATzVygmUs10vgPbaVaKeaAYthKC0+L1h6
         Is4uyQi8it4Npi0Um50odkxBTIu1Xi015xESZ9reULlsTzm5XVeuqvM3QGCfPhLKIrpu
         5k4KxEtnr7dbDU48LOb/XwBYYI3Fz7dlWhCvsjSDsj54p/yqjFo/1i7EI0CNaSrMUMMl
         /ylXd7Cd1n1vUtEJVE/wDs/8Fz8nxG8VKAhHbIkgFjwe6kpoLAEcN7KuvsI3BCs/tVyA
         QBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        fh=hRH4/Uj0D7H3Eplcn1NM9os+PtlkCkRFaWDIDVZBleg=;
        b=CurD6AY83feEEpyJsVuwHKqWIrgtbmyaVvnMeaGJqguFk+OoOhkqdaWmd8w/Rxl25F
         lrADGpqSzWpTW0EE4mXsl9zxiwEdW54gZ1RYlJzWITJJr9Q3gAjAjU+O8HGxlDCXIfsY
         z0gTPAZnHxVxY3BQspkkGkysgm3rD0qwhpJMoOd8gUi4s7A6RXSGu7kSJaZehpri1CqZ
         XILcj6yOJhw9n232Dd1ccR5JxGXWJKnCpOz3e2VLNwTzC48avjNbZNmSzr5HOmdGGoaD
         /MAfvbPgGf8J+0MGIFVTVDbv6T10Mb/Cz7QsH6j88ZxVCdc/ePbsri1RxqxcdfUB/8WX
         Xk5Q==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792641086; x=1793245886; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        b=a715fJQHuh4CRLFlp8uwpIvOIkjgCzjuB1gki0xJj1eVRcxfbMTn6aMM7O0hNUTlYt
         K2TJarYvDWRzoy2ng6Tu3CucqYhCSX+2tpIyQAmaMjbYHwy1zMT5pimZcNpJ33VXyjOR
         uB9/VbXv5whlJVaz0CAr9SvDG4fIqkqkCLuhHObKnmoIvI16kElXxofcI8ZDnnOdkKhM
         b8ABupWP2zKJYo1CqnlkPIFl5rn6qBhG7ScV9k3FV26aytvLY2x1LCbX5BFtcz1knQoN
         Im6fidlGeV9XRDOGhYY+TbxhTk3OnpOSCpIc8LCWts3Xuekey1+xZSIlrSKDDQdkdyS3
         sk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792641086; x=1793245886;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3R15WlwvcCDjwHgI3tMxUhnF1Vz0ctYaUW1v5Utzjsw=;
        b=XOa9hJgPdO7IKxPLoAzFSEh1LTz1MaWA1gecesLoWZg5zCKAh0KxCPg+e3BLP1agWp
         OgWpB7l7yGMY5v2GV0ifukifuUEj5WuONfnFOI5vDdHBb5ZrokR4jPTdLG8S4rKE7mA5
         6XvMrFUOCeQ5DGKUJTyUupBOK4FUnXO/s5opc670S8ocXZp+jycbiK/pv7cIvc3ovSZU
         4ug/EvUHr31LEGZ0KxjW732IsgYJqWDT3L2u4Aap6KkgWCv4wIfmxhXnc0GKiiYIdpLq
         SXs5C2FGfhFS6kaSVqcClgMIMFBHKH5dFVVWuMwzD9aG2jn+LNdL8vkokGh0whQRHR5c
         ctgg==
X-Forwarded-Encrypted: i=1; AKwUvBxxC/9JE3WxdVv7Zwb13AUvLSc5+k2F8nldAvYIwfom2HK0vgpQ678L+YcsJ3WxgXKE+jcgwg==@lists.linux.dev
X-Gm-Message-State: AFq9FYI5HmCQKfN7qKci4MkPIERF/dozhgXWIGmNZqpO1SvoDxcDxr6O
	qq6/AJfEGM1cuz1eNhlfEtIOHI97h6pQCnDGtmC4bB2Ufdg0T984aMi/QJOIuaXIfAaRl77cv3f
	9o9pThfoeTKV81+h/6NRGTCXPbCzm5LV6Ug4EnZtqGA==
X-Gm-Gg: AYBFou2+iB/3BEQ0i7FPH5Be/iKmu4py1sRZu0X3E1A7pntMWYfVZ+0CJObjshJeS6L
	w1AU37fa1wCHgraZ3hj5XH3RhrAFytu+EGahJS0e1OtawPslY9EdpxkgvrmLnKp4kYo9F+N2CeY
	AJwj/3jepZVfFfuvNwB/3127CwpEAXWqLL7YA1+xdjWzGRWNU7cnl4xEKj7IYcjwa5QBsWBiSRb
	taoX69bCkPrXKL6WzSTCJnnKZRN5eOBwhDgy8LLtPnodW3VypQp+3V5xYPfHtRu/XcW5rFiQ0aT
	mC2Np0lUGQVw+vEC+fLJ8s2A2ZaskNQJJgL1nog9cN6g9EgMKWv11+PDm2wKF+opr27dtWaCBFP
	Xq8LQ0HOVxEDjJEudtJAt+eP+t2R/boMnbd9zfqwX76+b7QhJsELAAOSdoWf7yTelbkQ=
X-Received: by 2002:a05:6402:400b:b0:6b4:2185:7147 with SMTP id
 4fb4d7f45d1cf-6b4218572dbmr568868a12.15.1792641085570; Wed, 21 Oct 2026
 20:51:25 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-5-tarunsahu@google.com>
 <CA+CK2bCWo7ixrNLKPvqETn3JSFwSNaB2UsPgy9RHVAhWroJURQ@mail.gmail.com>
 <atlINfvlXY4wMbpO@google.com> <CA+CK2bDf-pKbH2J13mRYRT7Ddj-Q+VXaGYePs+E-azSWXKzV5w@mail.gmail.com>
 <atl6K2Juy6Bh29lh@google.com>
In-Reply-To: <atl6K2Juy6Bh29lh@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 23:50:49 -0400
X-Gm-Features: AclHuK9es7KH6zjO9m5YDGIDDY6Onq6kZ5W4q1tuNZUyMat9PK3sQU18xuWoZac
Message-ID: <CA+CK2bB9xoAWP0kC+KtXeDTdwt0kWqb-PLHN=6DsA=mnRpMfxA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/4] mm: memfd_luo: Add the 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 10:51=E2=80=AFPM David Matlack <dmatlack@google.com=
> wrote:
>
> On 2026-10-21 08:41 PM, Pasha Tatashin wrote:
> > > > >  /**
> > > > >   * struct memfd_luo_ser - Main serialization structure for a mem=
fd.
> > > > > + * @features:  ABI feature and size header for memfd_luo_ser.
> > > > >   * @pos:       The file's current position (f_pos).
> > > > >   * @size:      The total size of the file in bytes (i_size).
> > > > >   * @seals:     The seals present on the memfd. The seals are uAB=
I so it is safe
> > > > > @@ -79,6 +103,7 @@ struct memfd_luo_folio_ser {
> > > > >   *             struct memfd_luo_folio_ser.
> > > > >   */
> > > > >  struct memfd_luo_ser {
> > > > > +       struct luo_feature_hdr features;
> > > >
> > > > I have not looked into this yet, but I would prefer to use some kin=
d
> > > > of macro constructor for serialized structs. That way, they will
> > > > automatically include the header, making it easier to search the co=
de
> > > > for what is actually preserved versus what exists only in this kern=
el.
> > >
> > > If you want to know what is preserved don't you just look at
> > > include/linux/kho/abi?
> >
> > Yes, and having it initialized and declared in the code correctly with
> > proper macros and verified just gives the right handling and avoids
> > making silly mistakes. The second reason is so we never forget to
> > include the header, and to make it expandable and easy for everyone to
> > use. I think this kind of constructor is just useful overall. Are
> > there any reasons why we wouldn't want to use it?
> >
> > > > So, I think something like this:
> > > > /* Base serialization header: 4 bytes total size, 4 bytes flags */
> > > > struct luo_ser_hdr {
> > > >     __u32 total_size;
> > >
> > > Why do we need the size? I'm not really opposed to it I just don't
> > > understand what problem it solves.
> > [...]
> > > The luo_ser_hdr is needed for top-level file handler and FLB ser
> > > structs. Those structs are always dynamically allocated and preserved
> > > with KHO.
> >
> > The top level is not enough. I think it is needed for every single
> > serialized struct in kho/abi - the blocks, the FLBs, etc. They all
> > must
> > be expandable in case we need to allow that. Let's have future
> > protection for everything that gets preserved.
> >
> > For example, take a look at vCPU preservation:
> > https://lore.kernel.org/all/20260920193650.3373435-9-pasha.tatashin@sol=
een.com
> > https://lore.kernel.org/all/20260920193650.3373435-11-pasha.tatashin@so=
leen.com
> >
> > +struct kvm_vcpu_ser {
> > +    u32 vcpu_id;
> > +    u32 flags;
> > +    u64 vm_token;
> > +    DECLARE_KHOSER_PTR(arch_state, struct kvm_vcpu_arch_ser *);
> > +};
> >
> > We might want to add fields to the arch-independent part, and we also
> > absolutely must keep the arch-dependent parts expandable. Therefore,
> > the header needs to stay small and flexible enough to grow as needed.
>
> Hm, anything that is dynamically allocated can have it, but anything
> that it is embedded directly or in an array cannot, because those
> structs cannot grow anyway. So I agree it's not exclusive to the
> top-level FLB and FH structs. But I would push back on any a mandate
> that _every_ struct in include/linux/kho/abi needs it.

OK, we should *aspire* to convert as many serialized structs as
possible to the versioned format by default, and require a very strong
justification for any exceptions (such as tightly packed arrays or
block set entries). Even in those cases, we should be certain that
omitting
the header saves meaningful memory and that we are not shooting
ourselves in the foot if we later decide to replace those container
primitives or need to evolve the entries independently.

Right now, shared serialized primitives like kho_vmalloc and
kho_block_header_ser do not have proper versioning at all, and because
they are used by many clients, updating them is already problematic.
We can't simply rely on top-level FH flags to version everything:
since these primitives are shared across handlers, any change to them
would otherwise require updating every FH that uses them.

BTW, since these primitives live in KHO and all the ABI headers are in
include/linux/kho/abi/, perhaps this header format, versioning, and
the declaration macros should be part of KHO rather than LUO (e.g.,
struct kho_ser_hdr and DECLARE_KHO_SER)? Then LUO would just focus
exporting FD preservation-capabilities to userspace, as it deals only
with FDs, not internal representation. There should also be a global
switch that shows the KHO version the kernel is using, perhaps via
sysfs.
