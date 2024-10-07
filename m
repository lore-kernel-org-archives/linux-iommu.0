Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAAD1DBB3F
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319018; cv=none; b=Nh6smHdb7wQUN02SnC7ZCQfYibiF9O7wuXYsz2SnvC8JolguYHWAaztp9S1qPTwcX758uRcpTwVdJ2miDZ+EfwzKZ4pPQ0J57og3mVk9qs1tJjwX7JSODY+YeHctyXU0ipdR48lwQgVBOJX77muMCxLeIPHkO99t3bx6EV4unVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319018; c=relaxed/simple;
	bh=pfTZwskcRDO6J/EbWenc5MF6EkG6LlfKiG02QhaJm0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGI2ZCjdi+TEoBHRHQcBnCii4A7eQWf+XLOAdUh8aN2jO5UWz7fHfjVxfAa3Bj/BhWgqnbmYBUlOnJJaS78H/9RQz4iT9ksmdO3YO5zQui1+wuUqge+KFvZ2+5CJtRpbOP42fsSRh8HmwsPDioWAHZnZC7n3phOiF6KvluNuPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ksSPMB4T; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ksSPMB4T"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb1dd2886so1565e9.0
        for <iommu@lists.linux.dev>; Mon, 07 Oct 2024 09:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728319015; x=1728923815; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfTZwskcRDO6J/EbWenc5MF6EkG6LlfKiG02QhaJm0M=;
        b=ksSPMB4T3Xt7zRcIDzJuHyHS/3/YDWqB3IxXgkinUWldMm7ZytLH11vPd8C5P+G5kh
         KNuxoZUPEf3LaKZOplTwEzPzjfIbI0harmm8P8QDTKp9JGjYDXowRMdeTG2jJDGNN34o
         0LcIxG8OpZ46C+jbLtLWHyiz1x2+M6/6JsLVZ/OH0XzIn5iWU2xLptW7XLEL89KIr4nm
         IuIPKj4I0tbBXgvARGnDTEugOvMMziXrU+NjdZBOAl+6/URETwZqCVIWjTDVJBXnD2+a
         o2jN3BtRFZYpObxzjW/NX6LaJrowb3Dscvdl0FJ6XwLU0xQ07jifZDOF1jGqh4K0YD01
         V8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728319015; x=1728923815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfTZwskcRDO6J/EbWenc5MF6EkG6LlfKiG02QhaJm0M=;
        b=SSzP0txs3kb+jafJHEdUeOlptfbIhs/MvqRBBkKZqYGzJFAW4UO1lKTv2VmG4oqhKP
         aG3ONwCkaFnvLAT0qaRaMg1Igz8KcwPkySdA/+XUbCr5VvXH/LPXw+XFhPgcuaF6epmb
         Qj41Xwmrdxb/BmTKeuSOTEkGsnOPduS1PfVnGsZCJdLkX1/gmsRIIMS1hSN9NIGjy2Jc
         NTr+YCbAprz4vDGDZZm3w+0X+DhoYsrvzm/lpdjuW4oJ95DGswzv+GtgdoWLgUHgm0si
         oC7TY8Jk5XeEk6lMrjJCOCT9K9LQLPKe9gu9RSs/TBdkaOytwfNBCpqzVUiddMVksuD/
         WKbw==
X-Forwarded-Encrypted: i=1; AJvYcCUSWtVML6qqeuk4hC9gUHZW5SGiItZM++rcxDSZ0VwqoQKYi3scWLiMlUF5lh7uLd6Br//m4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzsPNAVXoPc9WedCQHC5GDy6E+kfJZA8ctdd+5aexIbIrsNKmyK
	0Kc8vICFj863JkOhvX0z1n1G3hkIlLBpo5qXLKnZtkfdJ9kDQn+qoDF93r4LkPBpTWpB8Pq9tEI
	PjZlstx4bW4U1xmkHbuAHyNn36FBpy24SJmM9
X-Google-Smtp-Source: AGHT+IH34cxrwgzamDDHn8fVay3ejEi2/D2Db94dqzGJ9HPOBNHO5mDXamAvocyHnv6A3u/XE3ClTvdIor2h2iZ9fS4=
X-Received: by 2002:a05:600c:34ce:b0:42b:a8fc:3937 with SMTP id
 5b1f17b1804b1-42f8ac7614cmr4992935e9.4.1728319014948; Mon, 07 Oct 2024
 09:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241004180405.555194-1-yang@os.amperecomputing.com>
 <CAE2F3rDH3aK-OLO6TSXgQFU+DDx6Rq+4uwLQb3WZ+CMWWEGCNQ@mail.gmail.com>
 <87ac9686-cffb-43ac-b8f0-ccd3632fe5cd@os.amperecomputing.com>
 <CAE2F3rARZ_qq7MYnAT7nNKcNsL3DzaTH+ehPTNrwaaP20d9Cag@mail.gmail.com> <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
In-Reply-To: <faf12f39-0048-4e47-b600-e686cf82afe1@os.amperecomputing.com>
From: Daniel Mentz <danielmentz@google.com>
Date: Mon, 7 Oct 2024 09:36:41 -0700
Message-ID: <CAE2F3rBBx_bMgVi5R1G7d-B+c3UdXiUB4sEL6KnsNc4gWJHroQ@mail.gmail.com>
Subject: Re: [v3 PATCH] iommu/arm-smmu-v3: Fix L1 stream table index
 calculation for 32-bit sid size
To: Yang Shi <yang@os.amperecomputing.com>
Cc: jgg@ziepe.ca, nicolinc@nvidia.com, james.morse@arm.com, will@kernel.org, 
	robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 6:53=E2=80=AFPM Yang Shi <yang@os.amperecomputing.co=
m> wrote:
> >>> On a related note, in arm_smmu_init_strtab_2lvl() we're capping the
> >>> number of l1 entries at STRTAB_MAX_L1_ENTRIES for 2 level stream
> >>> tables. I'm thinking it would make sense to limit the size of linear
> >>> stream tables for the same reasons.
> >> Yes, this also works. But I don't know what value should be used. Jaso=
n
> >> actually suggested (size > SIZE_512M) in v2 review, but I thought the
> >> value is a magic number. Why 512M? Just because it is too large for
> >> allocation. So I picked up SIZE_MAX, just because it is the largest si=
ze
> >> supported by size_t type.
> > I think it should be capped to STRTAB_MAX_L1_ENTRIES
>
> I'm not expert on SMMU. Does the linear stream table have the same cap
> as 2-level stream table? Is this defined by the hardware spec? If it is
> not, why should we pick this value?

No. I don't think it's defined by the architecture specification. I
don't have a strong opinion on the particular value for the size limit
of linear Stream tables. However, I do believe that we should pick a
size limit. Today, the driver limits the number of Level-1 Stream
Table Descriptors in a 2-level Stream table. For consistency, we
should limit the size of linear Stream tables, too.
