Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608699;
	b=0tkmigB7/4t/QgIQUS95Jf3knxUC+2bhp1Fw/hx9q/TPcgvkGepvPqwGvcR5sJX/r9Tl
	 uNiRk0NT3qK74zxjU280ygaFWYK4TbQhMJWswu+v3I+DFJ9Q4TrMTMcpIi4YmyHHZCmaj
	 Nmxq5qbISoYYsGU1e/4RcEc2WUeLuJe3vZ2WWIIxbDwPssU6uVGLtUPMWlCHIOaPOJ0Qs
	 R580AxJBZs6KJmbPhC/n+wN3oBklwbMHY8llBOpBycZ9whUkDRf8TfP56GZeHFx1P6Lmn
	 4A2cia80b9iWLP5BsEqgPm8fZYXrjvU6D1FdyeRagcd3i0XwOWH56CfFzJCFGkEEaog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
	b=B9o5jYLcMwfYnePPFVXGqGXHAoAEsgbqU2qA12JQVMVvyilnf4KMP/jloKq60Fd2z0Sa
	 B5DoT+7QZxngOj4RZzhBCvyz84yqLuXHusUxTF46w3PmZ7DyjQ4X/cxd7MuH3iUYIEAqi
	 iAoNFHkWA0xs4GqslW/cBAWM+g+zR+nR84iQwx/zT784qppieVLcOrv8HhNss2MmIk8d2
	 W4dz6uMyF0Lasvn4jUim9+ELoKUKcvDJj9K0r33jjBerd2BnYFxe8Gb7Ol1AYbhu5N3US
	 eepzmBU5B2wNiq2psqwELW8NQNx9OiSpOjK25436veAgfgDFpQeBRnXWn0fHVwpWVpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=KEmGnaVP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12A7606A31F
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F12A7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=KEmGnaVP
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1ec41d8e9so1131806a12.0
        for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 11:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608692; cv=none;
        d=google.com; s=arc-20260327;
        b=HAxbgdBDldpa/jDJ+SL3EQCLowFmlVX8BdhZqhW3t1cyeQQYlXvMM+CMslyJUojZ1a
         Gl/BiOvIcIZYUMzL31tv1sQ5mVL6Glm7aaU4BtIulWrVLTUzm6wxbLyiv6lP0YVyyfZJ
         IWectQVe5SXSxqiCGlv/s+f6sFHUgh85QFRhvJ2KHbrl20F837tEPrRC9873gTEVpYl9
         nlYQSkKqIHoWLby/yfkySrG91EAMecJym3CcpAsmdppQwS4GNmKF+9iULwPiNH4RFflk
         yMvbZBj+izXhzUz/DKq1lWERVD7yTvp/LSvE9eG0/J0J3cBSHmfyrvcZu4y33C6OVwR6
         PXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        fh=petp2EQltrzWyn5gMLSQeYVlcVlKkBwJMvpMc7rn2OY=;
        b=MlGXSTVpEkmLVycpfAZKWA9Vw6VDn0l9Tcbmpy+8cREcFUz8EkUk/COdVZL7NW3SvI
         KReZLXxTbgAJdNxMSprms9EkwkDkyPP0XQW6wQB/DrCGwM7p80fSy72wQ+H5zX4rXro4
         s88UD5KMJhKliqBb2Q/yl8/wfd3ZLKSCi84tuOQb6JvyH3wMTwqC0Gu0sIZzMHnIetOK
         xreM6Bnb+rdFSFSLDbZrTpZ+j5iso3LkIOhLG8xAyYX+cqdQp28zfUM6nSj6Jb3JHQ7b
         Z13QZRmBEqvmW3GFoCBLUfgYAHZ7/YzbpA+iLWoE9Gw59hB+e91HUyJcQuUIErwX/96s
         1sUQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792608692; x=1793213492; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=KEmGnaVPWuihSxSbiYPMiQd3ggd3b7Zr4Q7JXRQ36wUAVDwOaW3+J/J/96NGyv3T6z
         nBVeV4Qpx0Jk+gTtjLbVK+wSVko6eKMPQU+Pb1x9S8Ks9KL7/1al/+YN/b91c1LWietS
         iTt3z3KjNBzjr3TqylWVgax9H+4BcZ61OMGRVFVupYeliLUn0bsY+qeG7chYjGqLsIUb
         TwE2T1aHnqGYcglxeiJMExe1CQfFB4VzXrSdzglhCHjsk5Ui0uOGBrGnEkUJkO48oiso
         /RXVOcsoVGcF9ZmInLLtjDS8j/GOWVI9NXDdVU+45Iy2UPl+qAvw3WhMk69DBOVms5BX
         V9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608692; x=1793213492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=1ZnBFLcBo0ouQzjojwhCvxg+7lAaKj5StIK7Xqjv7jmmsVLb7Ak3vpgQzgZtR6wZzL
         lpHiZvY4y8R9vAuAJD+ljDKovW4Hb5XnlxxOKRc38jnI8kx8YcYh7MU2XNiP91MJ3P7M
         BTGWCFC0RnhYOEyyXJS/JWQUou37fxW/EnOxfGdAs2cRCWA+8KmwimDHtBgqkQpWac7X
         T/ktqokkMJaJmxvzjxvLFRKmi8GbQS4ZiDTx0WfFBL+ziSEWOlZj1/dusjzdLIr7ztFQ
         IZu0/WvnBJ1UCNlaZEHchOevN9eArpVVwtIJtMBlej6DPgtnbAvfpEXcT0dBn9PU8NUx
         vRfQ==
X-Forwarded-Encrypted: i=1; AKwUvByT0kzUls9G/hcG3girSSCXVQWNeYLU03mZ/eV0Vl8ioh5aEm3X78kn3hwMmzNXDim8iYiPOA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIvPwobYYZP9o51SHWI1OMFWglQnHcmA7EHOBMVhJkswCo3Ycn9
	8Rmw60KBKN14HlSfHRjjN8POjJI4GGhiowpNT1aSOT3XwhaDsPlbI6mgkrEtsnIIcHYF23qIY7I
	RdZG/oMyYNY7mCFvA3Wy3pqa+JUk+PLuheFz+/isO/A==
X-Gm-Gg: AYBFou1TvoFzFQwxlZZhE/etD9G7a0un7z1L3GpNqKJNQrY+hI1JyfWmQGM6FQ3iWGo
	XvkxK9u3AuebfCzor/uuuE270P0zaHipK6d+B540mCxNQDfhocL/2D8CyRTb9V2KUSSG4WwRwtp
	+3Rh9IAgNJpBIU+bMhJxEHbPVb339+WwrQs/mJdnfS1MV8ytZz7dXBy6gphpdBdIa+7T+TVqq0V
	eTXcW/GTwP+J/NDAf9Z7M8ctTRVrZ8RmEJ49a9Upx1vs0tnjWCRqKvdbNeapD13gvpd3WG8om9v
	o9+zWlnaMDCfDujvBut6jFFM6Pe23m7zfty8TD6X3nP1Z8dYfvaVqTS60gVzRGrGzEPFr3hDR/L
	CGSGjQHeZj1vWhUL7wvR/59jTojJmVy/147niMknY+cFv+C+pe0/+GeZHiw9Io0KhgGw=
X-Received: by 2002:a05:6402:241a:b0:6b4:1df2:244e with SMTP id
 4fb4d7f45d1cf-6b41df242e6mr53870a12.38.1792608691873; Wed, 21 Oct 2026
 11:51:31 -0700 (PDT)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
In-Reply-To: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 14:50:54 -0400
X-Gm-Features: AclHuK9td__2XcAMViewCe_NhDoA_TjTC8gr4y8u3SANqGewpEKZoTgIKv6iXME
Message-ID: <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
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

On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
> >
> > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> >
> > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google=
.com> wrote:
> > >>
> > >> LUO and its file handlers validate handed-over state with monolithic
> > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serial=
ized
> > >> structure, even an optional additive one, must bump the string, whic=
h
> > >> breaks live update between adjacent kernels. Replace the string in
> > >> struct luo_ser with a feature header, so that the target kernel can
> > >> accept or reject the source kernel state per feature.
> > >>
> > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > >
> > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > struct, we only need 8 bytes instead.
> >
> > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > over-engineering.

128-byte per serialized struct is not starter.

> >
> > >
> > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > bits of the flags indicate whether an extended flags field is present=
.
> > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > that yet another extended flags field follows.
> >
> > If we will have dynamic extension of flags, Think about this.
>
> To support dynamic extensions in a backward compatible way you want
> something like this:
>
> struct luo_feature_hdr {
>    size
>    flags

__u32 size
__u32 flags

>    extensions  // offset of first luo_feature_extensions (or 0)

__u64 extensions[0]  --> but the size should be specificed in
declaration macro that I showed in the next patch.

> }
>
> struct luo_feature_extentions {
>     flags
>     extensions // offset of next luo_feature_extensions (or 0)
> }
>
> And then an example serialization struct would be:
>
> struct foo_ser {
>     struct luo_feature_hdr header;
>     ... fields ...
>     struct luo_feature_extension extensions1;
>     ... fields ...
>     struct luo_feature_extension extensions2;
> }
