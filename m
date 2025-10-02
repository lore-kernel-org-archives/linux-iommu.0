Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548CF3C1F
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417185; cv=none; b=YtMHDd+VSd0UTP6otO2ZkKS8srBJ+VdNH5tNDsZpvftmMhCBDqmqnI0q8r/TV9fPTtQ5s4S8b/xSsNXo87mbub2YoVi12+0uVMyVEeYI0FbJTsglMkcn/8wgBO8Kmw0KdFlFnsr3QsEj99OBv5VyRCAJK4eQb6FYLTLasQvPSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417185; c=relaxed/simple;
	bh=6WeaPM89+N+t6zeVK5eW6ZJd4Yp9j6uP6WJ/D1N5cM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNeE4BWzLmkMNxNBo09DPdLA12Qka2k/bUwP03+mrKMmZNbIeeDNfGDLoutiZZfUbI9zG+DDBv4a6ZNArHDySV48bpR50Y1jrLYBwJ8ileYdENBmkpviNvbmMFE7gsiAnMQ8lgV23U7aTln92Ly1q/1B8lsYUjGq1A3mR1dxR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=GMSgMhVN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="GMSgMhVN"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4de659d5a06so6656481cf.3
        for <iommu@lists.linux.dev>; Thu, 02 Oct 2025 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759417183; x=1760021983; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WeaPM89+N+t6zeVK5eW6ZJd4Yp9j6uP6WJ/D1N5cM4=;
        b=GMSgMhVNRWO8tiUuh4rS6COYtzq+ZmofIgYbtxHn1b6sQSCKdpt3u7QM2GRQf7CQZp
         KsHuEf0QS16fw6Q3KTGTSx2QHwyGPp2nTAhU6kuSLDdYAJCXzItk8cLDf/Wr9ZtFXmLj
         r0hRY9hMOhsOm/hPKQdsroiFZrcGXmPB7AeX3EEfWBNt6C9PQsLWFU6CzD2rMnrTn61+
         xVU3tWTS/0EX3dh+ifgs81o24e1U2lX4fh4ThqTPitkHnJ6/jWuNN5eeYikVoXpS0fB0
         vqHmBXXQhtkKvWGLYAajETArTS4DkPUzOQ+Hy10KyfiP7fRqcyzR0IL41nOEiWcJQ9Fc
         qYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759417183; x=1760021983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WeaPM89+N+t6zeVK5eW6ZJd4Yp9j6uP6WJ/D1N5cM4=;
        b=mJ/hV1W6Z5awFu7kaaKvBGju7pEHJAZOFAT6wGobYu969682oDxd4mPurBQu5KWuE7
         R5uMV7S2Jx/mRBihons4m5C3eA2+OG/UNEHxxlNYs9+j2J/tzLST+EC+1igf1WY7CfNv
         YihSPHLrBm5+6Ooi1KEoNEtk7h+INuD/uJJxaAeM2lC4MorLawGHMbGlhceDCeqaUMCa
         EpMwCw+l+BlgNVeOBmpFLmKaK2TXLp0IX3nzG1hsQaZF/C3/ZbTFHiQECKeNzSysm/cD
         FLs+mXueBHiSHNEigu2AwywVc7UfjWkvpF4W/8HPeZwovsxb7c57KIaXOrUNEtniw2lv
         XuDw==
X-Forwarded-Encrypted: i=1; AJvYcCW10p3CxNFw5GE9Ow+EAMF9Nw5cf3LOOcXwPyAVOQnx2WGOS6XyN8lXmuFf7IOdkdXWRd2wug==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpncVxiDkEsuZXOUNQYLMsS7JL+mIJPIjWDoet/I54d0XmW8vm
	dtRfxQGO8ao7PhHNWiR0NScHeAzirHuYZ6CKlZ5c5xE3NEW7ChIBo55RXMKm1dt/LxN4CSOIOym
	HUq55m94fho02FvgXjO2E3hcLoFCy5IUO4ybxwCVxag==
X-Gm-Gg: ASbGncveOHj7qrStvbYRsqaL6OKy8t6F4ap1Klt9zv7TmIb8eC+mouh/H5qP0nXPG0K
	8v3S0y6owyNo+2S7esJ9/bFd624IN9B05DAe51XeYtRWSTrYhBF3zH1lNB5DCFd0qY9yr93zzJM
	mu7Y46ulQSpvQg1dVdrCkV0AHe+4bszqH3E1OFFWeySEvFpI8JkrQiWoHDnd/jMB8cBdqlXdcjO
	Tkrp3tn5Ld5qWbyTmrVo+Nl7hgs
X-Google-Smtp-Source: AGHT+IEDIsfGTs5/bZKY8SdHaNpGi2ufbe9YQq/ztYQ1wGQjwGVUH9/Oqkd/Pudem5j79i0mGz4zL0iNCnq1XUSd4JA=
X-Received: by 2002:ac8:7e86:0:b0:4d9:9f2e:fede with SMTP id
 d75a77b69052e-4e41e44a6e9mr90560991cf.69.1759417183048; Thu, 02 Oct 2025
 07:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250928190624.3735830-1-skhawaja@google.com> <20250928190624.3735830-14-skhawaja@google.com>
 <20250929160034.GG2695987@ziepe.ca> <CA+CK2bDqDz3k0gXamJEbKUL7RPBLVjaA5=Jum=CF84wR+50izA@mail.gmail.com>
 <20250930135916.GN2695987@ziepe.ca> <CAAywjhRGrGjZK3jQptieVWmdzvjfNtTYrp2ChTZJSmFyrBaRqw@mail.gmail.com>
 <20250930210504.GU2695987@ziepe.ca> <CAAywjhRQONuHsxTGQZ5R=EJbOHUD+xOF_CYjkNRbUyCQkORwig@mail.gmail.com>
 <20251001114742.GV2695987@ziepe.ca> <CAAywjhRKvZBShj7KAXew2v_uGjn3HhvO=sFrZ=bVfMJ8ye-Vyw@mail.gmail.com>
 <20251002134112.GD3195829@ziepe.ca>
In-Reply-To: <20251002134112.GD3195829@ziepe.ca>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 2 Oct 2025 10:59:05 -0400
X-Gm-Features: AS18NWAvLdllLM2EOaTpN6MfJF3yIZHaZjSWh7GNC14VBVCD_9nlyXMqeR1Swt4
Message-ID: <CA+CK2bBvY7A-PBozXC7DQwza6OqETe_x3XasuUx9VJBKWkZR-A@mail.gmail.com>
Subject: Re: [RFC PATCH 13/15] iommufd: Persist iommu domains for live update
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev, YiFei Zhu <zhuyifei@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, Chris Li <chrisl@kernel.org>, 
	praan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 9:41=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Wed, Oct 01, 2025 at 06:00:58PM -0700, Samiullah Khawaja wrote:
> > > No, finish should never do anything on the restore path, IMHO. User
> > > should directly attach the newly created HWPT when it is ready.
> >
> > Makes sense. But if the user never replaces the restored iommu_domain
> > with a new HWPT, we will have to discard the old (restored) domain on
> > finish since it doesn't have any associated HWPT. I see you already
> > hinted at this below. This needs to be handled carefully considering
> > the vfio cdev FD state also. Discussed further below.
>
> I think the simplest thing is the domain exists forever until
> userspace attaches an iommufd, takes ownership of it and frees it.
> Nothing to do with finish.
>
> While the domain is attached iommu_device_use_default_domain() will
> fail.

Ah you answered my question from my previous email, let me talk to Sami.
