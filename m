Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD63451B5
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884626; cv=none; b=NEd2fYc06Ag9CF6u4trj+IDQx3jibSNGtM8B6jWhlRyjstwGb4tf5g1zpcJhO2vC9YewtODMMGs3uZZtCZOGiOM3AdknkpIsASno+dBIbIFpUFt46hdfPTXRnfjWukonUtbBxDlRSbvCgZc3jwOPO2627XWxcC6TnjbOV4P/kQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884626; c=relaxed/simple;
	bh=8G2MYLkHarREZZIj1FKM36skYth+lTD9vvfeDou5IhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFeo3uYm17ZYEz8UXRON3ljZvM9d+WqCWHPXL1Vr4G6rDdJebQVIWfLZWfASb7l5e6Aebz9Ca2d1THgd4ihw0VzVa9bFq0Ka0L+yeEse3lH68+PQJEDcsofmicLSJfjciMxnoUJ6W6TENuFdROVokX+USBd5fsHg8WsP/DdVK1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M1knXs4I; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M1knXs4I"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b243198058so141425ad.1
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774884625; x=1775489425; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BtXcK49aTtWbzyQjb6oAhiRd5s0yTyImqad3No01Ee0=;
        b=M1knXs4IjX8jQrxZfx49QfqnnKNYSfk6141CPVXR25/zlD+Voi3QwbbF9L9JQLjOVq
         bpxxHVEg5h6d7oX4NQK/iiTNTl3dDJTmHgz4OdEU2z2FuXMjs+qRDe+tykBMzRl3SWYj
         /u3kvMDtEy+qNf16XzfBsbbyTzhtLqXSX+wpn68wHUNF7E5DhGVdOj1GNBjVRAonciGF
         zLW8mWf/Wen+yaBwviA9I1YRJEtwWAbwiyMeIdQ0FKaWf2kO3mkjC/fFceDSFmKMJ8Zt
         UcEvHMoTXjjs8j0KIe5zTKrgdcdgOMNm6IFJTy1uFqIm5/zGCvUHVeiu5lidAokT1GHN
         GcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774884625; x=1775489425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtXcK49aTtWbzyQjb6oAhiRd5s0yTyImqad3No01Ee0=;
        b=hhw3H+gDmiCPbkJfJD4FcOYD+TV0Pf2/mYplvs+vT9zI64tKjTkg5zOWNUEZcKroyb
         ftRjpyfi6BFs8rIavxe5aHlCEZvyIfJccHEqo8Rl794lc68NZpiEsRR7Zx4Wg+j4Wfdt
         2RKEFgCnocjLOBqXxIBTh7rr4+QWIyR6hLJ/j8STDJRbIJE/+7W+BdNUmWSe1uVQ0DgI
         OA+wmVeox9C1G7LyLGvApVDVEwXj7GDj+4QAbi1QkU00aNT4eo0jYGvVow6NepAfw2Aj
         ybnnX750tMp7+82MRA/vbSRO1kfHzoEZh2TV3uAvUf9zIM967gYScT7oYF0iMi1PSCsG
         iYUA==
X-Forwarded-Encrypted: i=1; AJvYcCWPUsL1f1l6lDhl2kT6PkXJu2fYiRv0nvLYjBkBRYa+BwXJ0FvANoB5GnHlggRvEvbRJzaB8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMLhpV1iBjswC3NE95j07xztLv66UG0vUxRX7CA6OuS4BcjPym
	IRMeohTbtGchFfxEmngTAn9mRm/wWhrALq0K8L8wDjunx6gLVIoDx/NXbCI+dy5/Rg==
X-Gm-Gg: ATEYQzyDgq9NiOOV2oZwNpO2yTX45jlsZf1qltQnEvSR/B5+ZoBv7uAhkOda4wremzt
	PkQtku4LOPPuc6U7ynSUUqNgr+3hz1ib3inYyNcGCOKzl38OlmLFstwb01AqEuhPR0Cv/ddCnKI
	RbIPtjLO6C28d0/mFx74Bezsjggc3SbSQrlIWq1ysHrlX04rzGGYmzCEOC7twe5l+5T3oH1c7Lg
	2P/GM7i9NaB8XzIhaLO5kq0Q4r1Lvm6TLSPl+MqHa/T4az4SeRrW5loRDMMjHwScBRMjfj7pvhV
	82k7g0+Km70yNlsxlF1f5Iz307FPB7FLRPagjjO65HeySr45mH54i7wkG12Dz+6NJFV1E4EJUa7
	pOjGdFqTWTqt4uJ7BRKFVS+aeU4PsWkCculZreMGbZ2tjfljsf1I7jGn2aZk5QGwNepfnAE00s/
	sZnmp0Ee7FKpvv2ao8qlFkzCzVdiw+svTA5hmYBL9kYHjORwaho9BjmdaViXOqJw==
X-Received: by 2002:a17:903:2ac6:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2b242d1de8amr4988175ad.21.1774884623856;
        Mon, 30 Mar 2026 08:30:23 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24265aa9fsm81931225ad.20.2026.03.30.08.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 08:30:23 -0700 (PDT)
Date: Mon, 30 Mar 2026 15:30:17 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Dmytro Maluka <dmaluka@chromium.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iommu: Lift and generalize the STE/CD update code
 from SMMUv3
Message-ID: <acqW7gXck7zpQfOa@google.com>
References: <20260309060648.276762-1-baolu.lu@linux.intel.com>
 <20260309060648.276762-2-baolu.lu@linux.intel.com>
 <aa9W4ZKYWHr9-UNy@google.com>
 <20260330130024.GM310919@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260330130024.GM310919@nvidia.com>

On Mon, Mar 30, 2026 at 10:00:24AM -0300, Jason Gunthorpe wrote:
>On Mon, Mar 09, 2026 at 11:33:23PM +0000, Samiullah Khawaja wrote:
>> > +	for (i = 0; i != writer->num_quantas; i++) {
>> > +		/*
>> > +		 * Check that masks are up to date, the make functions are not
>>
>> nit: "the make functions" looks like a typo.
>
>the smmu drivers called all the functions that build STE and CD
>structs 'arm_smmu_make_xxx' So they are the 'make functions'

Interesting... Thanks for the context.
>
>> > +	} else if (used_qword_diff) {
>> > +		/*
>> > +		 * At least two quantas need their inuse bits to be changed.
>> > +		 * This requires a breaking update, zero the V bit, write all
>> > +		 * qwords but 0, then set qword 0
>> > +		 */
>> > +		unused_update[writer->vbit_quanta] = 0;
>> > +		NS(entry_set)(writer, entry, unused_update, writer->vbit_quanta, 1);
>> > +
>> > +		if (writer->vbit_quanta != 0)
>> > +			NS(entry_set)(writer, entry, target, 0,
>> > +				      writer->vbit_quanta - 1);
>>
>> Looking at the definition of the entry_set below, the last argument is
>> length. So if vbit_quanta 1 then it would write zero len. Shouldn't it
>> be writing quantas before the vbit_quanta?
>> > +		if (writer->vbit_quanta != writer->num_quantas)
>> > +			NS(entry_set)(writer, entry, target,
>> > +				      writer->vbit_quanta,
>> > +				      writer->num_quantas - 1);
>>
>> Sami here, the last argument should not have "- 1".
>
>Yeah, I probably botched this when I quickly drafted it
>
>Jason

Thanks,
Sami
