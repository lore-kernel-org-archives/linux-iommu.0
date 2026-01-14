Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64F32571F
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768416677; cv=pass; b=cOzimjth1oHjr+1wPTBB5OWVXPpU4T/+D96LgD58MI9qNm+GUhPA7v0GEN7toVcA56yaPrVboZwE+jnVgxiULeLRboccCZVh1Pt4r31gb/HQJrQFZ7vV6FUp/oAyApGk9Vg1TuTd9kFhuBPTk7GddnRy+fSMUTG2rYspDOI03dM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768416677; c=relaxed/simple;
	bh=+hkFU/PThH0WRRLKg7fDmb0LbyWst9OpM/cAVejwRuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4jiY5hZnyKnbXZu/iKJbFpazehUL2DdU8Ih5RUohnpYSXfqfjs1ZZau7rq4PDBTVmNYWKfg+qmnPWj+GB5IIruvKxgZRFoug3opVBaGXUCOrD1Nfrqoj88NNqDJNWSsHgFd+pOGDFamdcUA6Sa31+gSsmyH+2rSVc9b78Qz3QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kRT7+xbt; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kRT7+xbt"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-501511aa012so59821cf.0
        for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 10:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768416675; cv=none;
        d=google.com; s=arc-20240605;
        b=TT/nAopUWIB2j6mTYIVGxM5zVLazqFXs4/TV/hAcXXKCSonWtbX8g62SxEfpcHeOLJ
         Y2sTAax/JsdrT/i7DHtJG70AEuIO/v4I2cx2yC7hyiDbtBlEohRUCsGv1bvwU2S8s3lv
         UewHr5D6wgWfM3MvvqdpleHvG0idDNwi+NMLgccrQo1OrsiN80BVium5vM92iko+8dcL
         C6KooauHg75nJvMuLz+hqCYYWXY7C+hBZIyrDza8IDnNeaPlGdQ77ZlUvq1Lqo90j+DE
         AUc8suJ9zLLxTlzZ796ULg8i/HnxIgPpc6XX543uLbFQtWrOnQnEALOSXCjUjVQ+RlrZ
         tAMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gfBaI6O6viKcFKX0Y/yQvkPDqEeMwpywTB7IuoVSZ64=;
        fh=8ZuPcdZvhvc6HcMSBxMWtoEE1jzT/UWCBtoriipQVa4=;
        b=IDuhewQIx8L8PySjPsbzeT61PznpQsc6pKsOuBpwD4ENDlqyEPWyBUN9NQAZEhCFAK
         BUTor7fHN9LZqnmTIsnxYYjrKpALmp5DQOWpInkGRgKqHeQueazWxH4VU6b4L6hH9okf
         Y4/WOJIGnnLCYNi1qCKK+MG+PQ2PuvHqRC7QinV9YCxrgn66BT2gPW/Lj1ea3r7/a2BR
         gBFv4+sV683pvLhCZMgHk99EoCpM7appMFZgZr4ABrblVmXjk2rHJiqjPfcMnRHYjtNJ
         tEPhc9Z3zzs0D1BcgrKiBcrPjGcycxmNqNApx122uRbDg0h18prauft7PEx8uN0Q4i5E
         2EBQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768416675; x=1769021475; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfBaI6O6viKcFKX0Y/yQvkPDqEeMwpywTB7IuoVSZ64=;
        b=kRT7+xbtvd4AH44KiBYNNbUeC36VwYX28JaiutbSpWlnpa3A79XSveSeNgqnqzlI/0
         sV2qugu/NTJW3gkuS0OkPhnpS/5HhBM4RXRt1csrzoiwZEaOGqS6TcyXCKSZ/RfpTQJF
         tNd/oajWdi/k7Yzxs2M9kf7C1Xex6ygI6p0OYJcURTCeADKmwFion1534+3uz0U1DCjo
         Bdh7ZlvcH8zX/WUHHJwZGGfsa73Lxmnl0ZRKVIrxa8Ko60FFIgQuoTaM04HsHEqNo3q+
         SnF34ef+LOYCdLo+HYKLJez9aimJl/uoEfR7jW+fnar4uKJL74iOUKBb+VgbelM4jstl
         dUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768416675; x=1769021475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfBaI6O6viKcFKX0Y/yQvkPDqEeMwpywTB7IuoVSZ64=;
        b=EfF1bW/Z9lRGjqzoavtHbYIQbs6rs+b3y7p2anT/7hGZEBMkUGvDKmxMia3mj54Tbu
         0uPZCWqiX/blh+8efADRehiXchcNH4OybS1p22p5IfyC+zUOyNgkWM5OiSG9V5m+STvS
         27H4tlUmtSYqRWYD//yAFeKQA8vX3QI6+rXq1fjy72EHz8aStD5rfUzM+hgMZT8LxJlU
         ZNpNT4kdGxq23ok9B5Gj7Mc2T9EwQq3EeGQnMKbPzKYrQHgjx06h8i5kseSQRUt9Jp02
         gJ3YDCrNbFCnAGbEiwUnt4Q8NGxQBl2Nr5Tx5el7M7gO+37R6xN9U8xLk51YFuMvo21V
         e/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBADB0L3MEk2pck2C2/kkHzr0af36t0HaNAA8Shbxa8n3Wc0JKEEbkAm78ZjOYnxDBS//b7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyeyDAbWdfr14em0T81BCI7MOZ36315Y62JWNJGjVDElZI6v8ZY
	Gz0UOFGLWBXEwcD2a/yw9ehomho/4ZtKBX1E2OKmbIrAXYL9qOVeLNHxQ/7wg6vDL5uVzAkc/Zg
	AeW4wPVDM9erT/FL8aorX3GoW9mikklZKOamgC+lm
X-Gm-Gg: AY/fxX57rnzy3n+C4TxeekNEQybLwVCqE5fOZilKyCELVEs5i5vGXZTapnI/uZsIg3z
	auNfNrPfWaA1rLH+xcjAdcr52+7ndlJpcViKKlRm5oTnZz9pdrv4Qau7YlWId8FMuhOJfJ+n0jb
	90vRJIQEl0Uk+dVBtlOtxc7/WvSgua39JW3C7TNeSx+NM7+XoNVoVIA89WOBXAfREERIcw7z1wM
	CtAcenxuuyVvnKWf5/YHNC0qFRRfzRwXhUlU/QJ0twtM1DcZwRf4Jkh4MB+qdbxwv/5dQWjr+Yu
	wqnJCDeU7ZXRaEVmkVb95DPfSKIn
X-Received: by 2002:a05:622a:a:b0:4ff:bf96:db86 with SMTP id
 d75a77b69052e-501eabbd815mr553071cf.16.1768416674922; Wed, 14 Jan 2026
 10:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com> <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
 <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com> <BN9PR11MB52760881132AD4513E32373C8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260114131715.GA961588@nvidia.com>
In-Reply-To: <20260114131715.GA961588@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Wed, 14 Jan 2026 10:51:02 -0800
X-Gm-Features: AZwV_QihFi5WNQBWxhBG62ErdFJDEtScQ_R7baNpxgkm4IWHAg1LshRVy6cxWaY
Message-ID: <CAAywjhREggcahuWbk-ZqRjoW4v51X-gKw1pdA9TAcp-uO_6Bfg@mail.gmail.com>
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Dmytro Maluka <dmaluka@chromium.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 5:17=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Jan 14, 2026 at 07:26:10AM +0000, Tian, Kevin wrote:
> > before cache is flushed, it may contain:
> >
> >  - entries tagged with old DID, with content loaded from old table
> >  - entries tagged with old DID, with content loaded from new table
> >  - entries tagged with new DID, with content loaded from new table
> >
> > Compared to 2nd-stage the only problematic one is old DID + new table.
> >
> > According to 6.2.1 (Tagging of Cached Translations), the root address
> > of page table is not used in tagging and DID-based invalidation will
> > flush all entries related to old DID (no matter it's from old or new ta=
ble).
> >
> > Then it should just work!
>
> Unless the original domain is attached to another device, then you've
> corrupted the DID and corrupted IOTLB for the second innocent device
> that isn't changing translation.
>
> > p.s. Jason said that atomic size is 128bit on AMD and 64bit on ARM.
> > they both have DID concept and two page table pointers. So I assume
> > it's the same case on this front?
>
> Hmm, yeah, ARM has it worse you can't change any ASID/VMID
> concurrently with the table pointer.
>
> You could make a safe algorithm by allocating a temporary ID, moving
> the current entry to the temporary ID, moving to the new pointer,
> moving to the final ID, then flushing the tempoary ID.

Interesting Idea. I think this can be done.
>
> It avoids the cross device issue and your logic above would hold.
>
> Or maybe the case Samiullah is interested in should have the new
> domain adopt the original ID..

There is no immediate use case for first level, as I understand we use
second level for all our VM use cases. But looking at the code and
specs, the first level is used for pasid compatible domains (using
IOMMU_HWPT_ALLOC_PASID flag) and it will not be replaceable
hitlessly..
>
> Jason
