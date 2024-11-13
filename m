Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587D5FDA7
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527424; cv=none; b=XmAhHh2bAn7SqcofK7fmEohxEi+EFx1sEwNAa2aPQ1AhljKHdYCo4cT5SOnjiqDu6zEJIDSQ+sdu9B2QXZUnLakcpYeqs1025SFz2X2Q0AERoFScrtVvhBDEHDXHDXg7el9ujZQwOMNI+imBjldCqR2KfHGRdh2ZtOaavYacGRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527424; c=relaxed/simple;
	bh=Oc+LuTOdlevPxcwmiIdW93NWBNLrwRRkqST9yV7jHzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/RU4vibuWPNaASW3fWdMz3tPTWReJTV3tLoGAdZ3Y344Xa5VQk39esrvViOXcZlRev26nZCPhjb3e/xOZUNChpv2AOqNsLGR6rMIjKLQc8RDfiiHMVsiGQ2IKF9ZpVFwcX/IaNyBC08ihHMvRQl8GniyB+aT425wrrBzyLCbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb/2u1zx; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb/2u1zx"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f7657f9f62so64215581fa.3
        for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 11:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731527420; x=1732132220; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OuUklqc2/spqh6bD65znVHh3ypQAuDk9FVQdh8lmiQ=;
        b=Gb/2u1zxPK0sHscS/ACUhsy1loSLYE7CaLH6t5McAO+TrGNQq/k++UYUF+LmKD517m
         hOAOwLH5Qbyv4dZnN2lOTxYFjYab23EyQSgdxXJrzEWVBOk5gPjsthZ73gak++0Qazkh
         MgIbWzoE6SUh1ssykWc+VvD9O5mwCkgyETBguXVFkDS7ik4HtSfpI43ByIth7OS5WyJ8
         kjqwQs78D1+rIhwXbfB0CJ/4lzWgLO5MjV38BYwkWCWnMDDBwe/U+B8n3m0NNjOhKNrc
         uoh1cKih6W4csLELUpRjJt6pt+awlbx9qd6tWVTmX1NmaaHbTizVjVe3pzhlTBS1qrk3
         0Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731527420; x=1732132220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OuUklqc2/spqh6bD65znVHh3ypQAuDk9FVQdh8lmiQ=;
        b=uXgGxzkq49kuAxmcFiS3UHpAtIDS4vtQoM4KLfefTD7XxfKtt4SaDGyHetrpYX4vJQ
         oIHvuy2L0mLG3WofyN3wCzlARXSjxW38BWcAO91wOsYvPxvoQAs4/q1toOJICeANYKjv
         E5qKPsq9RjxlmsdnAROJ+YR5sg8SgW95ReGJ99J6J7XeAF82p698CDmbiWXZVZUeb8R7
         5u/coAmHHbNJVps5Z9CkTOVGCs4NERe7gT48b1vKtXoZGP9XDQOl79pvQL97sKiPU8YK
         vKtNKAJa/Uy0ptAwNNC/NHoZAyiiS7LBToUsDx9Ny++/IrBVRMA3YKh39TrILxLmUwLL
         JCbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF+igCmQ1YMJwPFoK0o6COkoQgE1pQ1ikvViwxgVPjmkemsOUHMT+lSENkutFQ+gOtpOsTyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrPSN41toaFOCrRJt82U0IH8OQDOWyC4aU0LmaDLCfGDYDb3Zo
	IxJHutYgWA7c1HNEfCGy0h3NGwHV+k0COBRkbiPgPxeH+U/BrzwhkzFrDncox5Qs/5xtgUs66fr
	wH/JejgwMoAW5md3TcswslV2JTs8=
X-Google-Smtp-Source: AGHT+IEPKNz9D20Li+iExsg6R/ZQRB0io0za1Ty3bQ/hNr2mZDJKgUIzpNphRGleTsbog/5umI3YsX7yUAXjOJLvzjA=
X-Received: by 2002:a05:651c:e0b:b0:2ff:559e:c94b with SMTP id
 38308e7fff4ca-2ff559ed4e7mr4466281fa.17.1731527420081; Wed, 13 Nov 2024
 11:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241113120327.5239-1-suravee.suthikulpanit@amd.com>
 <20241113120327.5239-6-suravee.suthikulpanit@amd.com> <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com>
 <20241113132031.GF35230@nvidia.com> <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com> <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
 <20241113142807.GJ35230@nvidia.com> <CAFULd4aFvGj=kz5Si9WpAr33KFtJDO5+sdNO=NBB+boS=E-E_Q@mail.gmail.com>
 <20241113163451.GK35230@nvidia.com>
In-Reply-To: <20241113163451.GK35230@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Wed, 13 Nov 2024 20:50:08 +0100
Message-ID: <CAFULd4bvDhfSprPEyirvX9VmKK_fpxaVNRO02oqT_KQAdLFhfg@mail.gmail.com>
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 5:34=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 03:36:14PM +0100, Uros Bizjak wrote:
> > On Wed, Nov 13, 2024 at 3:28=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
> > >
> > > On Wed, Nov 13, 2024 at 03:14:09PM +0100, Uros Bizjak wrote:
> > > > > > Even without atomicity guarantee, __READ_ONCE() still prevents =
the
> > > > > > compiler from performing unwanted optimizations (please see the=
 first
> > > > > > comment in include/asm-generic/rwonce.h) and unwanted reorderin=
g of
> > > > > > reads and writes when this function is inlined. This macro does=
 cast
> > > > > > the read to volatile, but IMO it is much more readable to use
> > > > > > __READ_ONCE() than volatile qualifier.
> > > > >
> > > > > Yes it does, but please explain to me what "unwanted reordering" =
is
> > > > > allowed here?
> > > >
> > > > It is a static function that will be inlined by the compiler
> > > > somewhere, so "unwanted reordering" depends on where it will be
> > > > inlined. *IF* it will be called from safe code, then this limitatio=
n
> > > > for the compiler can be lifted.
> > >
> > > As long as the values are read within the spinlock the order does not
> > > matter. READ_ONCE() is not required to contain reads within spinlocks=
.
> >
> > Indeed. But then why complicate things with cmpxchg, when we have
> > exclusive access to the shared memory? No other thread can access the
> > data, protected by spinlock; it won't change between invocations of
> > cmpxchg in the loop, and atomic access via cmpxchg is not needed.
>
> This is writing to memory shared by HW and HW is doing a 256 bit
> atomic load.
>
> It is important that the CPU do a 128 bit atomic write.
>
> cmpxchg is not required, but a 128 bit store is. cmpxchg128 is the
> only primitive Linux offers.

If we want to exercise only the atomic property of cmpxchg16b, then we
can look at arch/x86/lib/atomic64_set_cx8.S how cmpxchg8b is used to
implement the core of arch_atomic64_set() for x86_32:

SYM_FUNC_START(atomic64_set_cx8)
1:
/* we don't need LOCK_PREFIX since aligned 64-bit writes
 * are atomic on 586 and newer */
    cmpxchg8b (%esi)
    jne 1b

    RET
SYM_FUNC_END(atomic64_set_cx8)

we *do* have arch_try_cmpxchg128_local() that declares cmpxchg16b
without lock prefix, and perhaps we can use it to create 128bit store,
something like:

static __always_inline void iommu_atomic128_set(__int128 *ptr, __int128 val=
)
{
    __int128 old =3D *ptr;

    do {
    } while (!arch_try_cmpxchg128_local(ptr, &old, val));
}

Then write_dte_upper128() would look like:

static void write_dte_upper128(struct dev_table_entry *ptr, struct
dev_table_entry *new)
{
    struct dev_table_entry old =3D {}; <--- do we need to initialize struct=
 here?

    old.data128[1] =3D ptr->data128[1];

    /*
     * Preserve DTE_DATA2_INTR_MASK. This needs to be
     * done here since it requires to be inside
     * spin_lock(&dev_data->dte_lock) context.
     */
    new->data[2] &=3D ~DTE_DATA2_INTR_MASK;
    new->data[2] |=3D old.data[2] & DTE_DATA2_INTR_MASK;

    iommu_atomic128_set(&ptr->data128[1], new->data128[1]);
}

and in a similar way implement write_dte_lower128().

(I am away from the keyboard ATM, so the above is not tested, but you
got the idea...)

Uros.
