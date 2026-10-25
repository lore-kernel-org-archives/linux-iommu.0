Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792960742;
	b=qnpD5Y26iRv5Gofh5548akp+CwnsQG+NyA4teJxmxyicMhiPp2Td9oGyG2zEBcIK9Kx/
	 68jEL4NmKLKGNWrRlevsAfG2ZYtkaobPOItqLLy9M/m/rRi1em14j49qRViRGKqpy7Jwd
	 o3+MMAIfAxNvSsHFNfBGM50ZXfQYy/RHGA70860KPKGgiCT9V1I/Vj9x2TIYTDp9bmK0Y
	 Gqee4N565rDs5W8mhJSh7WHkRp4KIJ6VdNlc5INXqt/XtzH3UKNCnJI7/e6nrprWlSshQ
	 mE4kcg5APTI9i0+oWsCpbwNW+YbsZRjCjlLS/G3unkaFKoSUbib7xRTLv0d09FR6saA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
	b=gh3bb+SlI3+tUmh2OwKIb4FfqzTju3txNTKytoRbUCw9fTM66uTQYIyfPiHdh7sLWnNu
	 +UnOrSkLLLKQ/AfXHW38qUrJeWbbsUaU4j0mdnLsgJB/g/MLaDHEIUIrPbi4H26ZqHnJG
	 /BfMPbQNz0s0d8IcmKVk3p8MMwk5yxKKSzA673h2DHInsz8xAORc601okg8yczj1omkKy
	 Z9foDST7RrtsHH2UzXUTbsX4mYC36nUBPLkiBmNRcDtZgUYZ/VL061IL1Z3eBXb8Q9yt+
	 lntg1NImNGX5hdJVdK3Rb9IdDWBQZCRNfdgBG8HX2GYSA6LMkI5hVvh0uyxrsX67kSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YN17xC1F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4766B606A31F
	for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 20:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4766B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YN17xC1F
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1aa4d71e7so2477361a12.0
        for <iommu@lists.linux.dev>; Sun, 25 Oct 2026 13:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792960740; cv=none;
        d=google.com; s=arc-20260327;
        b=pOCYpjDx9Bu3sugFqM2s0czz366x/BkQ8AwpyNmpYYmm2ci0IAoGoZ0EDkY+U5oTN/
         jNopVq6N+I0/ygHy7HoEQ7BAJazrzPd3IwROs8dp87T5BLz+/Mmrvsz1YOjTOQfvKM5H
         vKLqBgsQLCYndGh6uvetjF7kNym6LXlRrLp9ffrTD7vn3bCfptj5hSgMQf/XM9CX9rbX
         C61UX804zGCEze0efQQa1whPH0sFAkN5XVwSPx1t/ILYfC+TrdxIV9Wf3J1+939W5b+9
         QBzixTk5rWvdKtIL7rDoUy9bcsb7DJNCZVpOVGHTcHuGtLLZASn+CDYARb4VTJkXJYYM
         MTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        fh=7cf3J1ZpHq/b8QfIDqlyEObAzTx3U0ImIl5sXRzBXAg=;
        b=gz9YsCM48o5EibP0ivR/iB0B37cwQlmnlaPXNeosEpQdz7TlavEQ99SSlIMLL1Hlds
         MXXuljrH2p5MibekEn8T7BYOqa3iPbyMvUMAsIA9VZvGbYdLhg9y6QNfevgqxhHAM6aB
         hbVWJeF/9wdeZQw1TM3MNwZ2HYkx8tEsWTuq2TDOT5qqzzsgqO0NtTovEtAP+Sw4PQzI
         MSW6mdNeICCsp9F/pJDL1vcjecK0tZv8t+byCl8oqZC7VuQ0oBXnYeHbtgx/8RHUyT1r
         VIGZOnKrIQOc9eN6HLhzq1frQc2p5xglRJiqSejSdzZ3lJeEpUsSCVlvhRUSUmWBms0U
         yhVg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792960740; x=1793565540; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        b=YN17xC1FkD++R9UZhWocX20ZNF4zb9jZ1kF873M8nJJSSbgiT+/tq8JR3HAGMxs+XL
         hr1FuIJpiTL8UfybrZM05B+bAsZpmrel0pQ3dLPwmigbY1I4ChrDps/jqG780DCat1s3
         BHK+5jm4+mI5Tsb3uq1ZS5T0RddeUUxmQBXOBpARi40WrTLprFyIy01nj7vX8VVEUX7C
         q+nDrY3u6CKSTnfV+4DKSkWuFJRye68GBvVInQFeHMX8GKuDq+orGhC6F4Y4GjKVeIl7
         8e9mPow4Pkj5IcNIRRbuxZpjohGoc0vuMweoUZsTfmJgk+oWxg+qxBMwE9Q/MEseqMlz
         BiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960740; x=1793565540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rp5Fden8a6neVzulsysbnvEXD4vRCF1NzLSbVrqKH4E=;
        b=HTyNiu0wPbCODSsGgy92FESf6j2E04zuLpsfGalGQ3UI4tGtHZtK++JrkozIfBIi1H
         Wjb+bRwHMYt2LKIhAwJmn3SI8LiJpsv8xpixe29DOPgEWoGRl+WtVdxwe0kEm9bPTY1w
         XCtXbXbgJpLucrypi/5wE2PblkVj+eGp/6/Uc6XCAJovvRawlLPfjv10zGaQOFvZD6Ze
         OjheQd7HkURwcON02ve9Z0hOUByWfmBJptb2ObkoubNNaYjro4vHJF6+XJ3KEjCvhQ1J
         S1enP00uIwc5HV2vMl+MWKOKwyyHqHtLIKGV4BtlM+Y4yMH/Ke+FSmufWI1Xqq73iUyz
         UhDw==
X-Forwarded-Encrypted: i=1; AKwUvBzwVW9zICIP6vmccE1xmxsBa5aT7Zd/Cq7UmPNNKMbVA+b88e7ysTCcriSntqnW1u1K0o9PEg==@lists.linux.dev
X-Gm-Message-State: AFq9FYKjoUKv3kMmBPjkPmPsWIWmD0OKyYpDguTdDWyZnuyWu9GTwywL
	TaEZEHXv+MCVbz6D5xw88X3VGUGTrxqkQOW2DLC0yUD+Juc7AJUXyacsL9nIXA1E/jeNXTR0eJy
	2eOlJW2OimrD37a64m1QsBI5F+KPbDhRSf5HmEpaNPA==
X-Gm-Gg: AYBFou01hjpTsZtFjPGK7eUL9JeaigAdjSbdBZfih8neDxSxZnXHqXgyG3Q0wbPuOtj
	Pfqo+rSsm94t7hCUUjHnnt/bFKN1f+DQCko/ybkRwSRQpkVAqVtX203ZY4IhrzMUKPQTxxxMwti
	Avw93Gl4xgIZSbX+YrGjHGLDCQpvApt7FHagwVRhPdlAQNwMHi89OG+bgmzkdhMoql/UITJaswR
	F68q7f6Jl2BSPvQecKtijs2nWVHwA1YNciOS+l11s8aN4TPDDJM8B1osAvCwoTgUn3Y/l0+j7ad
	u/jmWUF1haN8qlOLyDRtIK9ImyLuiYiKQBzTuDC9jpN9rBi6x54pydY5/PbuMMpxmi+8gY+KODP
	xtmuHolWrRxyslvK3h/+lh6aXG6eJF2WfNDazOyhdvVgvSL7E0uHiqIAInLUNjglP9Z0Y
X-Received: by 2002:aa7:dd0f:0:b0:6b2:2339:370d with SMTP id
 4fb4d7f45d1cf-6b443000b00mr4543991a12.39.1792960740017; Sun, 25 Oct 2026
 13:39:00 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
 <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
In-Reply-To: <attmFVIFU_mS0Y7p@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 25 Oct 2026 16:38:23 -0400
X-Gm-Features: AclHuK80OiwlBnY6tUr3jZ6atHcY2MdRSOFYk5-Bhewn5rIfzUZ_oGQw-LNyjus
Message-ID: <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
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

On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-22 04:53 PM, Pasha Tatashin wrote:
> > On Thu, Oct 22, 2026 at 1:51=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > > On 2026-10-22 12:11 AM, Pasha Tatashin wrote:
>
> > > > Lets drop the fourth macro argument and generate the combined struc=
t name:
> > > >
> > > > #define DECLARE_LUO_SER(name, expected_size, ext_flags_count)      =
        \
> > > >     struct name##_hdr {                                            =
        \
> > > >         __u32 size;                                                =
        \
> > > >         __u32 flags;                                               =
        \
> > > >         __u64 ext_flags[ext_flags_count];                          =
        \
> > > >         struct name payload;                                       =
        \
> > > >     };                                                             =
        \
> > > >     static_assert(sizeof(struct name##_hdr) =3D=3D (expected_size),=
            \
> > > >                   "LUO struct " #name " size mismatch!")
> > > >
> > > > For example:
> > > >
> > > > struct luo_memfd_ser {
> > > >     __u64 pos;
> > > >     __u64 size;
> > > > };
> > > >
> > > > DECLARE_LUO_SER_HDR(luo_memfd_ser, 24, 0);
> > >
> > > I think we are getting close, bu I have two remaining concerns:
> > >
> > >  * Reserving bits in each flags word for continuation leaves gaps
> > >    in the flag space that users have to know to skip.
> >
> > Yes, but callers should never manipulate the raw flag words directly,
> > and we can provide simple accessor macros or inlines that take a
> > contiguous feature ID (0, 1, 2, ...)
> >
> > enum luo_memfd_feats {
> >     LUO_MEMFD_FEAT_HUGETLB =3D 0,
> >     LUO_MEMFD_FEAT_SEALS   =3D 1,
> >     /* ... */
> >     LUO_MEMFD_FEAT_FOO     =3D 15, /* Automatically lands in
> > ext_flags[0] bits 0:1 */
> >     LUO_MEMFD_NR_FEATS
> > };
> >
> > if (luo_ser_get_feat(hdr, LUO_MEMFD_FEAT_HUGETLB)) {
> >     /* handle hugetlb */
> > }
>
> Sure but why deal with all the complexity just to save 8 bytes? All of
> these structs are allocated on folios and there are kilobytes of unused
> space to fit this header. And even if we optimize that we are talking
> about 8 bytes per FH/FLB... or 16 bytes for structs with arch-specific
> sub-structs like the KVM ones.

The reason I care about keeping the header compact is that we are
defining a foundational kernel ABI and want to use this header across
almost every serialized data structure so we can evolve them later
without breaking compatibility. While some top-level structs are on
sparse folios today, other serialized structs are tightly packed, and
we are looking to add KHO slab support in the future where tightly
packed allocations will be common.

That said, in your proposal, as long as nr_flags =3D=3D 0 is allowed when
a struct has no feature flags yet, luo_ser_hdr_size(hdr) is already 8
bytes and only grows to 16 bytes on the first feature flag. I am OK
with that.

> > >  * struct name##_hdr only matches structs written by the current kern=
el
> > >    (in terms of length of array and offset of payload).
> >
> > This is not an issue on the incoming path, we never cast incoming data
> > to struct name##_hdr or access ->payload directly. Instead, we parse
> > the incoming buffer, dynamically compute the header size from the
> > continuation bits, and cast the payload offset to "struct name *"
> > based on the negotiated feature flags.
>
> How?
>
> This is the only data structure that describes the header. Are you
> saying the incoming path will parse the header purely with a void *? Or
> use this header but just be careful not to access payload?
>
> We should have one header structure that can be used on the incoming and
> outgoing path. We should not have one header data structure that can be
> used on the outgoing path and one that can be used on the incoming
> path.
>
> Also we need a standard header that can be shared across all structs,
> not a per struct header. Otherwise you will need to do weird casting and
> overlays to implement the shared helper routines that parse it.

Having DECLARE_KHO_SER_WRAP() in include/linux/kho/abi/ makes it
immediately clear just by looking at kho/abi/ which serialized structs
have the versioned header and which do not, while also enforcing the
header when preserving and static-asserting the combined struct size a
compile time.

So with your header (and let's use KHO as we want to version KHO
structs as well):

struct kho_ser_hdr {
        __u32 size;        /* Size of header + payload in bytes */
        __u32 nr_flags;    /* Number of features encoded in flags[] */
        __u64 flags[];
};

The wrapped struct will look like:

#define DECLARE_KHO_SER_WRAP(name, expected_size, nr_feats)                =
\
        struct name##_wrap {                                               =
\
                __u32 size;                                                =
    \
                __u32 nr_flags;                                            =
    \
                __u64 flags[DIV_ROUND_UP(nr_feats, 32)];                   =
    \
                struct name payload;                                       =
    \
        };                                                                 =
\
        static_assert(sizeof(struct name##_wrap) =3D=3D (expected_size),   =
    \
                "struct " #name " size mismatch!")

On the incoming kernel we don't use struct name##_wrap, but we use
struct kho_ser_hdr for the wrapped data, validate the flags, and
unwrap it via kho_ser_payload(hdr) to get back the struct name *
payload type.

Pasha
