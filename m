Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE33AE188
	for <iommu@lists.linux.dev>; Mon,  7 Sep 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788813352; cv=pass; b=WJfYNQQKe3HcGj3sMe7gCACm9NxwgMoqTdn/DiVlZ640ZR0zr/AyuzGUX/OLjI/MuhBc9Hwl4/s2Okl7gM3aA4G8hEdlfXrqlXY7JKSWBfmhrnS1jOGJ0e/OJ4xcOnr9rQN+02pOW03TL6yU06VZMYmrmij97IpdRUqljgxvcB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788813352; c=relaxed/simple;
	bh=g2edYdPOPgZKEChE9Ez32/9YQy9OoP+wQgUwIBi8dXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+hrAAWtfqYqIREKlt1SRLn7FDAGmfdF93rBLoKSlc1AYxRaEm1bzUqRXkZKGXU3N/nVSSL3XR6Zul7EVM0lrBB1OXeJx9pkitCeQYH2k8Do0cVx0vDuZBOhfOyNvZ1brtxNNN5coneGzXoQcmxsfVUCNIJkEXvdsdoSiP5Xd/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmpTOjXo; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmpTOjXo"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3a1f628b1d1so29394451fa.0
        for <iommu@lists.linux.dev>; Mon, 07 Sep 2026 13:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788813348; cv=none;
        d=google.com; s=arc-20260327;
        b=e1x2qTfQi5wjzKC4g9Jlv65dAk9/s3v8Ib+dwKFkJqGgs02ERSoNBqWm1NTrxA4Ujj
         zgQpZ3hMb2Av5/DJcIxLMwtzkVCcbgWQOddCrHZWeGvCWWDjPT14dOKJEkGFmd2Au8ev
         f29Pr5znTFv1ilpo6ZLnXCKsq2nPs3uMZFUvMOLnsQd81WzdR6dH+FE3Qgy05pG90Gvi
         CXQN7O0e0uWxefU/LrwZXEyX5xEtz546aSVqzWvRfNSB5bk7muYSAO31Ua0xH7gSO9As
         UcL6ML9ovUxUEmCaqbfolBo9yHtoyNqsgTSgsMmM02A/36VZSXxrunrDZhkJWiGr/FPt
         VTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQJBvHPYM1qUyu1hspVrhi7UIm26jG8CTRoSY7wgXLs=;
        fh=5YVYeNKjd0gMqgKZJQBgUfE+d7U6P+HadvwDiancX/4=;
        b=b7zTUQfJ+rgaUmQ94X5qSa77MHi5MROBgjtvrSZNp9fNE+kZ9HVdoO9k8ocOA7jlyM
         4s/1F7qG/t+sv7M0jHWxtCmFMBJ4BuvTeyckZ9Ca1FTgPjnw77k9h2HwxaqEa+dJaZ/s
         +qkCe1zOSufq1QejBZ0/3oPmZymj+Yai5RU/5Tv/jKeaW3dABfH2F/+dgf6E4yWioKA9
         B2Jrzr/Np86gyz009WffvMq0TJWJNwSXKIVNnd0e8x8331QfOcvKAs9QjreICk4bGfY0
         UObvzfN2eHjVq5ihg5xhm+iFhstufcEM/aAeVkjPHYUi47daiiK7GQBucJeMJjoUMrpe
         /GQA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788813348; x=1789418148; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VQJBvHPYM1qUyu1hspVrhi7UIm26jG8CTRoSY7wgXLs=;
        b=bmpTOjXozNq+BeMSVa6aNYsOT8GUZUQd+CtNeSyvPLLr7tuw5IxZcIp+ugA8eu/5wz
         Nv9yh1qjmVj6t/iSlPFCm2ogH838hfHVsD0m/3v7b7DUnaelj44RpTt8xMmEw8kcfkaP
         r+QEXfIp1XvaFRmBQWjifNuk6zOupF0gZlhc5jXp/ZLwC+1Bxv9HjEbiOZ3Jpt+j5d+7
         HdIKhYL+aVSo98IJszAJllBTSRWBl1WdWaehK52AnRgHflPGgtFRRcmxeaG7oXplN1iS
         hz5+M006G//I4WNz/21WYpSuW07BHDKejOPEQWVimuySq6mZ5BK8eZLt9xM75T1eZh15
         WX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788813348; x=1789418148;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VQJBvHPYM1qUyu1hspVrhi7UIm26jG8CTRoSY7wgXLs=;
        b=bTaXnU+wN0Es//Ly6jEpsYBp7KymH3sEOTpC5/ixtVKGc8bZi+oK8ouv0eG2Wh0mRo
         hGRDbJoqR9n8szDbYaouHK5Hhr/DUMXCuZ2N38DWgz8nonSi40+wmS1UDPpSG4FSoDnT
         6NJllWvk0gNWvIpT2jANKEELcgIEvaisu6JRiKqvKX6WJ3W5a4eRpMgWB32L6iu7y+Vi
         c9dqTw9Q/vevT3EFk7vmkDHQdAksKAOew59nQLpP/idreR1e2LaUG2X3wgBO8YOpM1nQ
         p36catXLkykvK0eY/5sljvp1YRMduC8SD86BT6jlFWcrJ3egAzKnph1V69cQhcfkMbZY
         esIg==
X-Forwarded-Encrypted: i=1; AKwUvBw7bbNz5WJkkH/9TLmd2PwaGXU+0LGPeQsjpCp1JCeyZMCg4cVxpKdts+R4gxxOuQhbkUpslg==@lists.linux.dev
X-Gm-Message-State: AFuF++m6AevMRz9TIlqLqQuEmMxKkk5/i7EJs2oo+l8jKxEOaFxVd4zs
	y0kxRcdLoH7JlIuPwZtf5gMDpscKo+Z9kUS3FFtvepscTblsssDXjH6/QW4BDFhqknKpIY+sdv7
	1OMeH6PGil7ukW2jsJY/9qqML+OdVVIQ=
X-Gm-Gg: AYBFou11dKnauHqj91rrsuONO77/CWa2236kUcjtrfmKiRTU9Y+Z1KO6Q2EtsW2wb7s
	U5Q9DZ9k3o/Zf2M1Kq7yv9OSvNoYwg5Sg16wGvQEtaa5wp4mLI4AyzFqiEbQNjf7mB9+fTH55BO
	9PLztoMc+llatVJ4BKdteDGKeTwDgTS40gldiEpZv618zYcm8auWtPo/aTQmdqi06Df2W45ZE2F
	qpCgVV1iuFTbPkn2otpTClH6VuQiLlN2yXum2m6FY15+o9GDERqifW8+2z6Hr8uF+zZHoPLu2K0
	BYZklZSWKL1Q7USk7XKu+p3sOHrbOabXzQ6Lmvni94mCU8uHIZ4QWfVOevBlu5+EfBSRyG37QOc
	uWEc4wQCSCVvuwT2mo51PMFtWGl/QVp+wWBf9HTVP90Mp/w==
X-Received: by 2002:a2e:be0e:0:b0:3a2:6bdf:336 with SMTP id
 38308e7fff4ca-3a371f6c5a0mr50578371fa.14.1788813347971; Mon, 07 Sep 2026
 13:35:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANB4YXR7h8V5Xp=MXVZeSdvw9UiriSagp=E+ju5RRDNghoPHLQ@mail.gmail.com>
 <yq5ao6egyn5j.fsf@kernel.org> <CGME20260902182632eucas1p2d0caf5a54243c630ecbd4844cc278a0d@eucas1p2.samsung.com>
 <BN9PR12MB5146EB49E0988618FBC13515F7B72@BN9PR12MB5146.namprd12.prod.outlook.com>
 <f48c2a3f-38c8-44ab-8352-35ee1874b420@samsung.com> <yq5abja9p3nb.fsf@kernel.org>
In-Reply-To: <yq5abja9p3nb.fsf@kernel.org>
From: Timo Witte <timo.witte@gmail.com>
Date: Mon, 7 Sep 2026 22:35:36 +0200
X-Gm-Features: AcwNN1WdIwGGYx1CcrwVES-R_oDbj88wfaLPQ52dQe8RDXdI-MvoZWW2p1Z-yO8
Message-ID: <CANB4YXTs7NhMRexPOjV8-2JQp1ZLRRVr8z8mMcJLDo=++-DNwQ@mail.gmail.com>
Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
 regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs (commit 8277a12d0d60)
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	"Deucher, Alexander" <Alexander.Deucher@amd.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Hegde, Vasant" <Vasant.Hegde@amd.com>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tried out the fix and it resolved the issue for me. A clean boot
shows no problems with the GPU which does DMA with encrypted memory.

Environment:
- AMD platform with SME enabled (mem_encrypt=3Don)
- AMD GPU with a 44-bit DMA mask behind the AMD IOMMU (translated / DMA-FQ
  mode, iommu group 29)

Thanks a lot,
Timo


On Mon, Sep 7, 2026 at 3:55=E2=80=AFPM Aneesh Kumar K.V <aneesh.kumar@kerne=
l.org> wrote:
>
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>
> > On 02.09.2026 20:26, Deucher, Alexander wrote:
> >>> -----Original Message-----
> >>> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> >>> Sent: Wednesday, September 2, 2026 6:16 AM
> >>> To: Timo Witte <timo.witte@gmail.com>; iommu@lists.linux.dev
> >>> Cc: m.szyprowski@samsung.com; robin.murphy@arm.com;
> >>> joro@8bytes.org; Deucher, Alexander <Alexander.Deucher@amd.com>
> >>> Subject: Re: [BUG] iommu/dma: "Not yet supported" CC_SHARED rejection
> >>> regresses dma_alloc_attrs() on SME hosts with IOMMU-attached GPUs
> >>> (commit 8277a12d0d60)
> >>>
> >>> Timo Witte <timo.witte@gmail.com> writes:
> >>>
> >>>> Commit 8277a12d0d60 ("dma-pool: track decrypted atomic pools and
> >>>> select them via attrs") added to iommu_dma_alloc():
> >>>>
> >>>>     /* Not yet supported */
> >>>>     if (is_alloc_cc_shared)
> >>>>         return NULL;
> >>>>
> >>>> dma_alloc_attrs() auto-sets __DMA_ATTR_ALLOC_CC_SHARED whenever
> >>>> force_dma_unencrypted() is true. On an SME host (mem_encrypt=3Don) a=
n
> >>>> AMD GPU with a 44-bit DMA mask hits that condition, so every GTT
> >>>> (system-RAM) allocation fails with NULL/-ENOMEM, amdgpu init aborts
> >>>> and the system boots without a display.
> >>>> IOMMU in Translated/DMA-FQ mode (iommu group 29).
> >>>>
> >>>> Before the mentioned patch it worked: the IOMMU PTE carries the SME
> >>>> C-bit, so the memory controller transparently decrypts for the devic=
e
> >>>> while pages stay encrypted at rest. For IOMMU-backed devices
> >>>> force_dma_unencrypted() is a false positive - the device DMA mask do=
es
> >>>> not limit addressing once the IOMMU translates, so CC_SHARED should
> >>>> not be auto-set for them.
> >>>>
> >>>
> >>> This means that, with host memory encryption, DMA does not need to be
> >>> forced unencrypted when the device uses the IOMMU?
> >> + Tom and Vasant.
> >>
> >> Yes, otherwise most devices won't be able to work with encrypted memor=
y since most devices don't support a DMA mask large enough to cover the C b=
it.
> >
> > Is this the proper fix/workaround for v7.3-rc? If so, then Aneesh, plea=
se
> > send it as a complete patch so I will take it to the dma-mapping-fixes.
> >
>
>
> I am still waiting for testing feedback. I sent a reminder on Friday.
>
> -aneesh
