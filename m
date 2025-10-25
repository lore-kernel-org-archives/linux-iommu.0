Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BCD30215A
	for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761405905; cv=none; b=gssVyvKovwEoHzqx4edlK9WubrSAv9VxygaBmjke59AwHkY54XqN4ZlyJ9x+Z7LTyd9FngHTbsiO/wO1WWVMgX1z+q9+5hFneNmtG7MtXQ8T94c2X/xBx5KuIk/rDqDfLBMRSm16SUTl9w4B08CySEKREAlTW01zTBjHX70UpAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761405905; c=relaxed/simple;
	bh=xDRkpAn0D2lhlrXt3t3UOPRfnSga85kN6uhnRJl1ndk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOTqWG35rPfwT/3U7bftMnNWetjLjllplSUczCYiI6k/MJen3om3MkWMIYoZqn1WGY2GTMljbnmp7DI9DHYD+7UJlHAXzFDxN53GFdM9HNT8JYtyHV/SvSEjt/gHH8H4IgT7hWYBE6RkC0T8gLqnH4kkqbfl6PwvoY62A3JIDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PRUeNaeK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PRUeNaeK"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so713504566b.3
        for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761405901; x=1762010701; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEsLv/ORWjWt4JjusiVyw1pkRSWkY2jVnldvJ/kYxAc=;
        b=PRUeNaeKOtTTmdRrJjB6ndz2/T4vYC4Wrl54Nt6fCen2IPIbA2yKywDhzeqW6npX8d
         1iOB1Jxgl5OBvLiBEfHhb6z5c4DJz43daK4kcITK2B1GwGFtH2K2JqDziM3x4XQ8GecQ
         LiijprQGdGTauCUJQMC8uS7Z6a+eRwTmAwsWB1whChMdJHwp+DeyYjOC4e8D0TTVsw7r
         C3iMibl9ujbiPpOtXyh/OBuWtDc/mOznzs6mKqR8uc91r25ifIj5D9rMAfssO0blg7SD
         qeQcdYuaeHM5evSKuXT9tJUDJHJ+tRTtJU2ivkNCP3zeTsg0a8gndbCKsrejAk/64gTl
         3vyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761405901; x=1762010701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEsLv/ORWjWt4JjusiVyw1pkRSWkY2jVnldvJ/kYxAc=;
        b=giPAgxl0n9V/b6Orzk+zEY45dENvVMjIfI+DMZ9MuxgvnfVkyIsNtU5jnsNlIDKmVS
         ICke3FarT1iUPzuJX1NblxDmd/HqzTSxRbovv47OcM7dvn/BjpHJKFv/UtBMxRimxBeV
         c54lV8V7wC/E6PRbZ+kncw9+9R4JLRodmzSCRFdsGuMciyTFGrR0uegSZ+V9Ww+EQjd5
         3rgbgxtmWCLgsqN5JxbcPazHMkfVJTqwth3ROYKPAnXwXdzuIGsSLy1tcx+J04UHBl/Z
         K5khjluttx5mBo4fUHqiDl8u6Id/wJ7fpCzG9LiQ4v82GQ0WptWjgF1uHhBP6UaXOGdr
         xdUg==
X-Forwarded-Encrypted: i=1; AJvYcCW17LVaFa4uQpp9LkzmYFc356gbTKRUoxWR2WQS2IIhi2HmUyA8Fb2WLKg8Qtb68KqIrlnN1A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwAV5A2TCWz/hmWNpwALxB6fzYjE2bMtkh190saANQtTBxdOHtC
	XTGzk/fYaYDWr9BW0XeSJIScdVv8+PUO3/vjm47E014SziBwR1Xtmnc40FrTdoYVh7MBMITA56t
	V7HgAVnptlFt/b7jHWc+KVJ7++ws7Bpb2cmN45LBs7Q==
X-Gm-Gg: ASbGncvBPTE6+jtZDdNLSygifGrg1IkdhvzNkMXLnjKP9tM2SqBhNvzuG8pEM4hdkbW
	LxYLDm4FTrYlVCcKsmbAmAAQ+a3+nC3CV/1lwAFafvKTYsqSWnd8A+OotjeTCRp3dnMRwBCdvkR
	USpk5GNZYwwp2igFAPYkfFajIr2QBcjVqWv7+AoQYmavs+owrpuwV4NAALWPY36keND6EDmnh9k
	WvCJc8NxY6v5t/1wOaYdktEIA5Xl8lSBQMCc5Zvqbn1tPC177m0IValVIRRoEqdCI21hdKYhTT5
	ip9sV3kv5VDkY2yw8kICMsgIP/Jg
X-Google-Smtp-Source: AGHT+IEkKuyMVmFsWXRY0bxtHWTNzex75v+WBGMxRJwOZQScs1xFZAgq+kDpvorbdJ+d0KcQ27kL7+tqDAzCdvkawvY=
X-Received: by 2002:a17:907:da1:b0:b6d:5e64:c36b with SMTP id
 a640c23a62f3a-b6d6fe9fac7mr565664566b.29.1761405901273; Sat, 25 Oct 2025
 08:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <3-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <3-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:24:25 -0400
X-Gm-Features: AWmQ_bkMrpRaMfcHcpe107aX1k_bm11BfLXJjxsMDuts5-Fo-hDichMUKRxipls
Message-ID: <CA+CK2bC5=rb1C6i5yMad_tG9JpbYYgSRxAX-vhYctuoLvcQbWg@mail.gmail.com>
Subject: Re: [PATCH v7 03/15] iommupt: Add the basic structure of the iommu implementation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:21=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> The existing IOMMU page table implementations duplicate all of the workin=
g
> algorithms for each format. By using the generic page table API a single =
C
> version of the IOMMU algorithms can be created and re-used for all of the
> different formats used in the drivers. The implementation will provide a
> single C version of the iommu domain operations: iova_to_phys, map, unmap=
,
> and read_and_clear_dirty.
>
> Further, adding new algorithms and techniques becomes easy to do across
> the entire fleet of drivers and formats.

It is an enabler for cross-arch page_table_check for IOMMU. There is
also a long-standing issue where PT pages are not freed on unmap,
leading to substantial overhead on some configurations, especially
where IOVA is cycled through for security purposes (as it was done in
our environment). Having a single, solid fix for this issue that
affects all arches is very much desirable.

>
> The C functions are drop in compatible with the existing iommu_domain_ops
> using the IOMMU_PT_DOMAIN_OPS() macro. Each per-format implementation
> compilation unit will produce exported symbols following the pattern
> pt_iommu_FMT_map_pages() which the macro directly maps to the
> iommu_domain_ops members. This avoids the additional function pointer
> indirection like io-pgtable has.
>
> The top level struct used by the drivers is pt_iommu_table_FMT. It
> contains the other structs to allow container_of() to move between the
> driver, iommu page table, generic page table, and generic format layers.
>
>    struct pt_iommu_table_amdv1 {
>        struct pt_iommu {
>               struct iommu_domain domain;
>        } iommu;
>        struct pt_amdv1 {
>               struct pt_common common;
>        } amdpt;
>    };
>
> The driver is expected to union the pt_iommu_table_FMT with its own
> existing domain struct:
>
>    struct driver_domain {
>        union {
>                struct iommu_domain domain;
>                struct pt_iommu_table_amdv1 amdv1;
>        };
>    };
>    PT_IOMMU_CHECK_DOMAIN(struct driver_domain, amdv1, domain);
>
> To create an alias to avoid renaming 'domain' in a lot of driver code.
>
> This allows all the layers to access all the necessary functions to
> implement their different roles with no change to any of the existing
> iommu core code.
>
> Implement the basic starting point: pt_iommu_init(), get_info() and
> deinit().
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
