Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A4216C440
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955180; cv=none; b=Zf+LVwXQImWQqf7szMiSWrg5wmcK2iwBT/z8pi8hbMNcIPWu6mYmLq4SchdkWVDIi4jQvjtfSucBtNEZFJPEPrccqsIsl1j0Jo7mwj+cClNHm+ei+Tj0rSkn7DpsbNlNR+/tnYR0lOgOYmzxmAO/DZ0hrXff+kd7QgTjChjwboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955180; c=relaxed/simple;
	bh=Nc6TqAf/Y2o3KcUZLNmuYOweaa2c9DWtB9Prmytsiy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sah+3HVh7DB4qNTZgaE4rADHHxsGVsFq9Oic3j+X/G3BWdrXFnpuHX44veQpyuILN17weMKYeTUii+7egIxjKD8a3YQ6I+6ZUYa0UnVNdubLIJl7ZyVIGHfzYnt2HIvusEUAORShOpjgyg9I9XhNf25VI8WUHY3J0O7Z6Mbvaa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mNt3hJkT; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mNt3hJkT"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e238fa7b10so65588739f.0
        for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 00:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718955177; x=1719559977; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVfCPcleGZb0eMzqXi7Vsq/j2SxIArSsk0slGEmGrA8=;
        b=mNt3hJkTFHS0IGl4kkFGDzWL3D9ZQANEoXL4AdnpQIkknrDWFrkzDXaSMSQlDaYOky
         cwwM/N1rnkCCI5D9m9Mam4XR7+ld4todorJVtBWVU3jQ5shRVbY/335fitH9tslsiMgS
         pTIblgdrIu6d3cIVPzfXxibU2XgvGq1d9WKP+TJ7Mz9QroMXbJs7pS41KAHdVqXNLvBO
         +UNF9HZ9s66VPaEiQ+KrOqNWNrT0eHqn9h1/UBQE8D6QZodVj2x+EvB6RK5tfDm86j2U
         wAqyiDcCIOIi+Lw66gGKAqoLS7zS+6ag0qMmlx5gV+0qOmsG+0VhygTFhnqDPYwhJoYI
         6tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718955177; x=1719559977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVfCPcleGZb0eMzqXi7Vsq/j2SxIArSsk0slGEmGrA8=;
        b=uo1wgC8ZRi9vGU8yFPEPXlAb5DN0q+vvJxicLOF66kQuCSi6sTlyad2ubdWtiRJaD7
         LuyrM6mHjG0j/qzn+MiIE3i1rFeSP8S44cmQuhlVvnMzPoLuWSWeEzGNshrodq6dev+a
         gcjglOEMCmBzAoP9GlMgv9nGyXDSORwN3mGrzyOCP5ClVNgnKgbxDjfmdbm4FL3kWgfH
         muVazQlhfsjmMZE1hGjn/7Ua4KM4mNhegyzHN20b6eB8i0VPhboIBB7LV764sEBY73NU
         dlTCS7JoYCpxP95sB+fe+eG5Bt/t5WjhOtNygxvGQOa4K1e21VVVcLDYi5vxXBxD1LH1
         en9w==
X-Forwarded-Encrypted: i=1; AJvYcCX07Oh3gwgE7Y56RNz3c8NMolyw9grofKl9Uy9EKzmFZwlt8kpasnRrm3SMOJmu4YqiCal7IF1WwgrEpkxsWpw6RdxnZPY=
X-Gm-Message-State: AOJu0Yz3CkJjq9SRBRbehV5cL4dgOGK+JhZ4VTkHwOLzW5jrgv5NyH7p
	PndNNQc2mHGNFCCWE2J1h3jsbvmaX0e4ei8AhWYFam+FouTPCJWfj+R3T+vRAqmXxs3YFy2ucNd
	zdpsrzXdj8271QXEE2G06FIqgXlCVztiovX9inQ==
X-Google-Smtp-Source: AGHT+IEu4dzZYkNTMX3+BfnbcWOAfXALbnMrAKJ+znJ39Y2amlEx+w3//cBWxFx/TUtSBRZyaVePY5uzyySauxGMR6c=
X-Received: by 2002:a05:6602:2cc5:b0:7eb:af88:1e3a with SMTP id
 ca18e2360f4ac-7f13ee86867mr811509939f.14.1718955177505; Fri, 21 Jun 2024
 00:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614142156.29420-1-zong.li@sifive.com> <20240614142156.29420-7-zong.li@sifive.com>
 <20240619154901.GN1091770@ziepe.ca>
In-Reply-To: <20240619154901.GN1091770@ziepe.ca>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 21 Jun 2024 15:32:46 +0800
Message-ID: <CANXhq0qts90x4L6gOhrAx0dMpX1UbPqEAK6QK9fshgso+Pxk3g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/10] iommu/riscv: support nested iommu for
 getting iommu hardware information
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, kevin.tian@intel.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:49=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, Jun 14, 2024 at 10:21:52PM +0800, Zong Li wrote:
> > This patch implements .hw_info operation and the related data
> > structures for passing the IOMMU hardware capabilities for iommufd.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/iommu/riscv/iommu.c  | 20 ++++++++++++++++++++
> >  include/uapi/linux/iommufd.h | 18 ++++++++++++++++++
> >  2 files changed, 38 insertions(+)
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> >  /**
> >   * enum iommu_hw_info_type - IOMMU Hardware Info Types
> >   * @IOMMU_HW_INFO_TYPE_NONE: Used by the drivers that do not report ha=
rdware
> >   *                           info
> >   * @IOMMU_HW_INFO_TYPE_INTEL_VTD: Intel VT-d iommu info type
> > + * @IOMMU_HW_INFO_TYPE_RISCV_IOMMU: RISC-V iommu info type
> >   */
>
> Is there a more formal name than "RISCV IOMMU" here? It seems like you
> will probably have a RISCV_IOMMU_V2 someday, is that naming OK?
>

RISC-V IOMMU currently doesn't have another name. If we are really
unfortunate enough to need to overhaul the entire structure, maybe we
can give it another proper name. But personally, RISCV_IOMMU_V2 is
fine with me.

I have also taken a look at comments on other patches, please allow me
a moment to digest that, I will reply to them later. Thanks

> Jason
