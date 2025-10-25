Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67191302CD1
	for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761406845; cv=none; b=UAgN2gYNbyKhPdHemLrmAZ1HyGkmb6NFR858Vuq1H111a+pIGTUs6+w9H8Cznkza9vTeUwUUmDeQSpH7V4kEkbMZ0xNuwKdORR0TIgOrei2T9EdodjPPy1wCK2Y/eMoeGjwf8kqT0ICbUFdZrDv22z7ixT5PkDxePebnSHO1edA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761406845; c=relaxed/simple;
	bh=0HY16VFXZq4Fs4AqSUpKJwWPQq433JoGDwf5zAVL/Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lfurg0IrViF1dup+jGviVZeFd+f7EUWEDwK0Uq9lxJrF1vGTPQtxvJ9pnIiWrqyPxHxNC8cfVqE/Qsl4LF2Lf+tbf2PdezFJMFs/z6kAydJ6vN1xn1aURGpz/Z3zBhGR9Geja9MQvxA7Uabwr9HFuP0gU2rpfCdvu78mn6nTF6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Er46V1n6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Er46V1n6"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so4823323a12.2
        for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761406841; x=1762011641; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HY16VFXZq4Fs4AqSUpKJwWPQq433JoGDwf5zAVL/Es=;
        b=Er46V1n6Fw6/BPk9iMgnmBgWni2LuJKZB2sAPWxSTGpy86AZ1P1+iLSbSP9CDq4i3O
         4YiHrUj4/+P1ZceZA8X0Wd4TF2PZ/cBT4myv2/ZjLaUVEs6G9mVjdua3KZML+k8v7UTw
         ck+XQQ4VOlX5t8C2Xhere1g2ZL2IfATPRj9k0VlKmdj2gHSHpJcmTxrJj9dUNADzsqxM
         /OneHyvqQKx7uWMTAdLdXVxC89WMfhhuiBhR5i61dUT2+0uPq8D5cDU9jjPD1V6nRP6s
         x+YSYAnWWmUOwsESA8prd3L/kPqVzNP7bZek0gVAgZ+scO/y6aZRH/3+Pu5cvOi20Q8/
         1v0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761406841; x=1762011641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HY16VFXZq4Fs4AqSUpKJwWPQq433JoGDwf5zAVL/Es=;
        b=FCUAfRIuXV7NkdrfGOUZLm7aR9oQ7zi8icBzU69vrj5iVAmo4oc/cAIvvjz4ZLp/rp
         4jibDCyeG6G6JImY/cpJXhU5D7s4gjZX0Z4YzssD/c+aP9Zrfs+UjzEmXJ60yStUGbmN
         aO8WVCkY644u3bssquuQ2F7JSGdk+94nplOxI9+H1ZCdUZ7RQPUdcMHRtyjnaDDKqjW/
         B4WGFUEcKWi1RBHeeiXSVi00WLQ2v5p4Sq6uTwGqytaVwtQGyLSx4wdocR5+F9+co+VR
         L+va5XCKIV6ECp8fRf7fkaZOHeMqTANWRlLYUzbgqE3m2bQ0f9lgJZDUCPtiw5wPd3PK
         FKXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhczp2S/+S7NNt/1Mq4NJMDdbwTD8DWd9nEYZas17y8KvutohLzKDCv+8dr6h0GkA6uAa3SQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPkt0afZpgBsGAlEy5f0nP/rToXuxFcD0BrV3kqX9/9DY84Rzn
	8ZlCnYd7B5Z34hgIG1dv43KJNXizOQcDx8I1KIC2ml00V9zx7fdTV5KHBAEXOlTM8fbxx6RN//7
	2dOCi8io+pFBmzRcamZDcm0TeBSnqMOBReDQisvXyNg==
X-Gm-Gg: ASbGncsVrb/DRfb2lH/TAz9Z6BmcUq7oCz5agF6QVKm8f6ZdK9KkBNoxhjcJodPuXIV
	dpZAjcvWKnAnTTlwxvIR2uB9R0zGwwC3o9U7cq5ptrP+PjmcIuVhrzRx9bZFRfKpFcrsVJJM5V8
	4oztTnL5Wyvgim6e2Z5DmeR/G7jKqnCKQrgupF5xle0jbZLWyU1iGsE+S2un+FXBar8URiKX2+n
	gUJHT0nc0Byasz9xwpmUv5r5UVGPV2FKEyDKdlhIGOnzcjscLjOkfp+nw52xRrbSSvZ6fOOtV7D
	5OYdkcvr03ADJ/H9oQ==
X-Google-Smtp-Source: AGHT+IHusR3pR0UReEeTXHeTWS5omMas6c+gaYiIEsLmjRg06Miw4AMQcuQX3fi9PVgOyyAmpc1NpRtLuc0jLuFpHKE=
X-Received: by 2002:a05:6402:4504:b0:63c:103b:e1cf with SMTP id
 4fb4d7f45d1cf-63c1f584283mr30192670a12.0.1761406840700; Sat, 25 Oct 2025
 08:40:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <6-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <6-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:40:04 -0400
X-Gm-Features: AWmQ_bmCjfexrZLPPfdt56XAonJ2DbSa1CpJkmBpIfIxbAsyN_ouXa6sCMuBecc
Message-ID: <CA+CK2bDZ1RX9o80x2+HTshix0zxLcruzDfW--NMS8CjWo1PfUg@mail.gmail.com>
Subject: Re: [PATCH v7 06/15] iommupt: Add unmap_pages op
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

On Thu, Oct 23, 2025 at 2:20=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> unmap_pages removes mappings and any fully contained interior tables from
> the given range. This follows the now-standard iommu_domain API definitio=
n
> where it does not split up larger page sizes into smaller. The caller mus=
t
> perform unmap only on ranges created by map or it must have somehow
> otherwise determined safe cut points (eg iommufd/vfio use iova_to_phys to
> scan for them)
>
> A future work will provide 'cut' which explicitly does the page size spli=
t
> if the HW can support it.

Are there plans to add "free" when a table becomes empty on an unmap?
Not sure what would be an efficient implementation for that, maybe a
refcnt for # entries in table?

> unmap is implemented with a recursive descent of the tree. If the caller
> provides a VA range that spans an entire table item then the table memory
> can be freed as well.
>
> If an entire table item can be freed then this version will also check th=
e
> leaf-only level of the tree to ensure that all entries are present to
> generate -EINVAL. Many of the existing drivers don't do this extra check.
>
> This version sits under the iommu_domain_ops as unmap_pages() but does no=
t
> require the external page size calculation. The implementation is actuall=
y
> unmap_range() and can do arbitrary ranges, internally handling all the
> validation and supporting any arrangment of page sizes. A future series
> can optimize __iommu_unmap() to take advantage of this.
>
> Freed page table memory is batched up in the gather and will be freed in
> the driver's iotlb_sync() callback after the IOTLB flush completes.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
