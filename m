Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8F1974EA
	for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608407; cv=none; b=IHRLP0b8tquKHTdH3YHDSS4qDokTZWyBx7KnzRBBi2ShwenoWSHxJ6UXPDr7LpOVSbc8NJt15WxUjPCt5dvrhQlGvgAyoZNr4s2w2x9Ur01IgPYMz4gnjdfTgRtNt+67J8WRVZh044HENJLDhLGe/8gkp0mIf5BAgMIj99Lrvtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608407; c=relaxed/simple;
	bh=HWx17Ja/nrWOhLtiPs11ahPTIZP2IaJfWwrpTQt1PGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0CjJMJmLlGTKNCujYcIB4rGJCpE8H33A1jg07SLCuaYmmjVhdBeJFync7/etVAtLpaPrP9uHnGuW2EHFdhAoIMuqicChO1C0Kv6M1WSO7qUbbnkbCYqfVMNH4qwGqdc0xBRpXhU+iTtYNkI04mR5+JFfGpgqYbfMye5mlWNk9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Olln4p+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Olln4p+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731608404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcMft76BN43/zCq0u89bKlLBN+Mk0EQrrjguFLKXzzk=;
	b=Olln4p+NNOjwywOsc5TUQpLT4xiVSjykJYvC/+80hVIXCGrCgKcA7W11nNwut0h216lP66
	SwIOc87MFrYo4nWmKlPX6Bsfqrwt7/F3RfYbYY73sc8U3qutZoLqVz7APqfJTwR/xzG+jp
	mIQZY6Mwf/cy1yrnIyM0iiuOwJElyTI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-u-TKp0ENPWWPRrVcy6htnw-1; Thu, 14 Nov 2024 13:20:03 -0500
X-MC-Unique: u-TKp0ENPWWPRrVcy6htnw-1
X-Mimecast-MFC-AGG-ID: u-TKp0ENPWWPRrVcy6htnw
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4d8e3c162so1324155ab.2
        for <iommu@lists.linux.dev>; Thu, 14 Nov 2024 10:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731608402; x=1732213202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s15vRddefejG6fhwQ57mKyTAs3rkfSslp/KnwL6dr28=;
        b=qXBPc0fQNLsPqP7ybTi4up4rFH2tzk0TOd8TmjHEE/Mdu0NBGuctU4OzZ9ZllNZWo+
         iHRTeKIK3CpivC1Ei3/NtcEv3jK6TmtS0OtE9o3al0qllcri+IgMmQ96M34wSAdC5ZCS
         q56irPu7/iy5VkAz+EV9JhWZoU/GVssr0GcNbllESbuA2err5DjmnbX/cuD+zNKnQMdw
         v27B+EAllsey/zE9V7schJSZxm+XpQWJLlVqWfAYWXqrO1BDwv3SRO+Whe4XfrB3uqBU
         lplCujokzGMAjJuIqZyLLIeKhvVqtMDBh0Oo7fKLK91P38h6aZzMuLEAAboDXN6X3PCA
         +92A==
X-Forwarded-Encrypted: i=1; AJvYcCX3lmq7XeHG8Q5d2osHYjvK8mrTArdR3nPEJxVkfyDgT26nZ6hm0Hcw8816uVXCLsqhL58/QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwspT0vUAI1V7NwfPGcUjlNv5ds+ZFN60MqjKeTTqgb+4XLPeYo
	aADwdhszQFF5dUADmnvLpXEtCsv4ORuwe4ifqT8eBXx9c7drSgwd2yu6G6PrulI8KcRzzVpa/9h
	2iXRjUAOGclLPcc8bKhSJYQkJfQJmpkwfFx/FFkyK+zV2xYZpTWZh
X-Received: by 2002:a05:6602:2dc3:b0:83a:9350:68b with SMTP id ca18e2360f4ac-83e6bf4cd52mr4147839f.0.1731608402413;
        Thu, 14 Nov 2024 10:20:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvRjOBHJy7qQH++XUG5nfwskcvDFSYilImpnQa2boVQelR3q3PEExN9cFszyyb1hYMDs9x6A==
X-Received: by 2002:a05:6602:2dc3:b0:83a:9350:68b with SMTP id ca18e2360f4ac-83e6bf4cd52mr4146739f.0.1731608401912;
        Thu, 14 Nov 2024 10:20:01 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e02fc542b5sm366816173.30.2024.11.14.10.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 10:20:01 -0800 (PST)
Date: Thu, 14 Nov 2024 11:19:58 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <jgg@nvidia.com>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
 <joro@8bytes.org>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
 <kvm@vger.kernel.org>, <chao.p.peng@linux.intel.com>,
 <iommu@lists.linux.dev>, <zhenzhong.duan@intel.com>,
 <vasant.hegde@amd.com>, <will@kernel.org>
Subject: Re: [PATCH v5 4/5] vfio: Add vfio_copy_user_data()
Message-ID: <20241114111958.7f6c64a8.alex.williamson@redhat.com>
In-Reply-To: <7808f8da-8932-486d-8d47-10a95bc5002d@intel.com>
References: <20241108121742.18889-1-yi.l.liu@intel.com>
	<20241108121742.18889-5-yi.l.liu@intel.com>
	<20241111170308.0a14160f.alex.williamson@redhat.com>
	<9d88a9b9-eeb5-49e5-9c59-e3b82336f3a6@intel.com>
	<20241112065253.6c9a38ac.alex.williamson@redhat.com>
	<7808f8da-8932-486d-8d47-10a95bc5002d@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: shKh93InIrS68-npHRRniTsJmJeujWmAdcsEdSa3L6k_1731608402
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Nov 2024 15:22:02 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 2024/11/12 21:52, Alex Williamson wrote:
>=20
> >>>> +{
> >>>> +=09unsigned long xend =3D minsz;
> >>>> +=09struct user_header {
> >>>> +=09=09u32 argsz;
> >>>> +=09=09u32 flags;
> >>>> +=09} *header;
> >>>> +=09unsigned long flags;
> >>>> +=09u32 flag;
> >>>> +
> >>>> +=09if (copy_from_user(buffer, arg, minsz))
> >>>> +=09=09return -EFAULT;
> >>>> +
> >>>> +=09header =3D (struct user_header *)buffer;
> >>>> +=09if (header->argsz < minsz)
> >>>> +=09=09return -EINVAL;
> >>>> +
> >>>> +=09if (header->flags & ~flags_mask)
> >>>> +=09=09return -EINVAL; =20
> >>>
> >>> I'm already wrestling with whether this is an over engineered solutio=
n
> >>> to remove a couple dozen lines of mostly duplicate logic between atta=
ch
> >>> and detach, but a couple points that could make it more versatile:
> >>>
> >>> (1) Test xend_array here:
> >>>
> >>> =09if (!xend_array)
> >>> =09=09return 0; =20
> >>
> >> Perhaps we should return error if the header->flags has any bit set. S=
uch
> >> cases require a valid xend_array. =20
> >=20
> > I don't think that's true.  For example if we want to drop this into
> > existing cases where the structure size has not expanded and flags are
> > used for other things, I don't think we want the overhead of declaring
> > an xend_array. =20
>=20
> I see. My thought was sticking with using it in the cases that have
> extended fields. Given that would it be better to return minsz as you
> suggested to return ssize_t to caller.

If the xend_array is NULL, then yes it would do the copy, validate
argsz and flags, and return minsz.
=20
> >>> (2) Return ssize_t/-errno for the caller to know the resulting copy
> >>> size.
> >>>     =20
> >>>> +
> >>>> +=09/* Loop each set flag to decide the xend */
> >>>> +=09flags =3D header->flags;
> >>>> +=09for_each_set_bit(flag, &flags, BITS_PER_TYPE(u32)) {
> >>>> +=09=09if (xend_array[flag] > xend)
> >>>> +=09=09=09xend =3D xend_array[flag]; =20
> >>>
> >>> Can we craft a BUILD_BUG in the wrapper to test that xend_array is at
> >>> least long enough to match the highest bit in flags?  Thanks, =20
> >>
> >> yes. I would add a BUILD_BUG like the below.
> >>
> >> BUILD_BUG_ON(ARRAY_SIZE(_xend_array) < ilog2(_flags_mask)); =20
> >=20
> > So this would need to account that _xend_array can be NULL regardless
> > of _flags_mask.  Thanks, =20
> yes, but I encounter a problem to account it. The below failed as when
> the _xend_array is a null pointer. It's due to the usage of ARRAY_SIZE
> macro. If it's not doable, perhaps we can have two wrappers, one for
> copying user data with array, this should enforce the array num check
> with flags. While, the another one is for copying user data without
> array, no array num check. How about your opinion?
>=20
> BUILD_BUG_ON((_xend_array !=3D NULL) && (ARRAY_SIZE(_xend_array) <=20
> ilog2(_flags_mask)));
>=20
> Compiling fail snippet:
>=20
> In file included from <command-line>:
> ./include/linux/array_size.h:11:38: warning: division =E2=80=98sizeof (lo=
ng=20
> unsigned int *) / sizeof (long unsigned int)=E2=80=99 does not compute th=
e number=20
> of array elements [-Wsizeof-pointer-div]
>     11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +=20
> __must_be_array(arr))
>        |                                      ^
> ././include/linux/compiler_types.h:497:23: note: in definition of macro=
=20
> =E2=80=98__compiletime_assert=E2=80=99
>    497 |                 if (!(condition))=20
>       \
>        |                       ^~~~~~~~~
> ././include/linux/compiler_types.h:517:9: note: in expansion of macro=20
> =E2=80=98_compiletime_assert=E2=80=99
>    517 |         _compiletime_assert(condition, msg, __compiletime_assert=
_,=20
> __COUNTER__)
>        |         ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro=20
> =E2=80=98compiletime_assert=E2=80=99
>     39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), =
msg)

TBH, I think this whole generalization is stalling the series.  We're
de-duplicating 20-ish lines of code implemented by adjacent functions
with something more complicated, I think mostly to formalize the
methodology of using flags to expand the ioctl data structure, which
has been our plan all along.  If it only addresses the duplication in
these two functions, the added complexity isn't that compelling, but
expanding it to be used more broadly is introducing scope creep.

Given the momentum on the iommufd side, if this series is intended to
be v6.13 material, we should probably defer this generalization to a
follow-on series where we can evaluate a more broadly used helper.
Thanks,

Alex

