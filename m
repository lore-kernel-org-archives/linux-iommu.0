Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82959411A08
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 21:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014431; cv=pass; b=RHF7Ike6p5dNsxQvnBwyTdaKiB9RGOeYFotBvH2ywoC4jTryT87Jgv4jpczaKBRVz6yyE3DK6FEbxTjC4HS52AAaXJEyUi//H4qSf6QnJDrnPKBV57pDfjwV9zKDy2R5ROs1sjA3VjZH1tXxBZ3N+bgCmMRl0om6IkWS/TqWRZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014431; c=relaxed/simple;
	bh=MCaOs6wYNSB4LFrsDrFCk/QlJZrshEPv8X72I3y+9V4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IfEv6SFTqlVOr59mKWeUiUwxGUDF2CnNOymUD/KKuvTK/mJ/q3Ppy2LC8FXIFOgpFgZaYlZSNFAwKDcU6RuItGgPiUDhIIWy/63iGdNRY1bG0+4PHjX16yd0nV0xRsT4vcjIJzFJWaUKFximEImY875Ox+Gl/Q9SKJUWGdShd24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mqHFli7r; arc=pass smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqHFli7r"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917aca1aee5so9470786d6.2
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 14:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792014428; cv=none;
        d=google.com; s=arc-20260327;
        b=mCBX8eNKjxW0YiGQUh/pNm263/mYFkFaYJ+QmNq6N8UzSWVz8+YoJDQ9XxL67cLazo
         oE5pKJv4v7HpLnpOTEUFnlTIFRnRelHP/TOGa9k8n14Z4Mj5U6JoxzFLcvLt9lCXGk4A
         KwmlfHpeYodoNew02jUV1fL4eG0wbiCWJQeph6H3FikhsHNkvqnFi2aUfFtGGZZzNX/e
         hbMYbpLA4RuAfWirO4z9TQYEYLNfiyb82U7/CTd0QzWNuHmBVVL7f+AzJUt0GyafgEIq
         s1/ZMLC7+O7A/7qFOM1cEh2+DHvEMfwYI0gU/57iqbW9iLmhMSkjBu2uVIcm2A1LMRix
         Qu3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OmdjCtO0BT/G+HosYDOiIQ+MFbY+P6PHIY8xmD++EWw=;
        fh=rFYU3uEbcTH0zVoVJKd6I7SQqBdFobbKdRrYcmQ8aaI=;
        b=iC/E4p6U2JXI/8i95NNOYYwuBgaTZ6/pD4lEHjfIxcg/RiyufYr5othRry2IC4oRkQ
         g5QaVHSw6AV/OTzcEqJwhpLrBZCy+vWuzSCKQoO3pyETeGn5qKaTxhivwL/XDkbrPDQB
         G+VLUdK78cztf8QOBIwyMuziC+klcSmrjGQj1cfPdYeHxsmpk7FHHwxG4a3VOlJOqiS8
         QaeUjPm1UGHu3PsT6945b87jYVepV/Q/tpZHF5ZouUb96Aq0UOV4pXejkGIRs9C3BoXv
         A0GLChaZ7KBMj2xCt62dYrgPedGYu6cTZpLgxN1FKcWtOynnlpyg5FpOHaxshuCp3Zef
         zpng==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792014428; x=1792619228; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OmdjCtO0BT/G+HosYDOiIQ+MFbY+P6PHIY8xmD++EWw=;
        b=mqHFli7rwFgQHmtkcvvFTPDATz4ZKtKaSWnrO4QJPUuO2kPpFrwH2PZGBKV+7qe32I
         vdhhxNAaKFHqZpgzfxDNV8+OimgNO0VhP6HG0gW/08nQuqCTU1FS9S0ao7wVaakeA+x+
         tRaZLGSyHmNa+j4t5+x62Jy28DZoQmvYMCldvU2naTWTacFauJJ1qOkG0vyI45WdSXHy
         u+sWEfwF2IznfkpTH00fzmsssoPP5yv3AROacARelaDU/kjTm1ZDahWy0N52GGy/ys0q
         O44tMPk6lnHG1GO88lOQMfkFDaiIX+FwRq/OEY8UgX1Tp4u6AlRDzZ/MMId/eyGhmzjY
         xUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014428; x=1792619228;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OmdjCtO0BT/G+HosYDOiIQ+MFbY+P6PHIY8xmD++EWw=;
        b=U6aBSmvgTABljnrfEYxoifa+ufNW+WqsiwFNt6E+/rfaaJnIHfAeKa0mv71Tf4ttq+
         3XLpmEIzrtEd6UqnrvLUj1ssbZWB2SQ9+VQX7v3/wgwclrE5u6YFD8knvmPwezlEUIwv
         GZGev3/76DA36bXiNe8R+u34F22FPmHEuQ/gsWaBwxIVvqcIlumIDbs8eeMiVlR7f+yB
         vO3D8hpTw9kZIgWt1N3ioAVyKQS1HTuwz5OGtZpMfu4UNnt8yVBC//SVzfz/wEnJDvjq
         SZJhD3DI6uviMuJoobqs0Sl5bxbMAOB6/sqOyjeggOgEgRC8GF3H/HTIWKIeuBD7AxAV
         PEfg==
X-Forwarded-Encrypted: i=1; AKwUvBwuBUObHYJUVZ3eeJbwHVInakrqyvk828+h4/dT6EUxBRdakLyXt27Yfj0OBtnzvlng+50QUw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIIqglyw/46doU0P4zDGz/B9sOGTLGR8nfGXbWXjipNi+zD6hy3
	ugsJGgl0hNbkf+bogOzBT3W8T0jDlorEnDi7huZQQluyu8CaFgStZCC4bg0ZPeH8nFSkxbFDLk0
	L/0+xIwi+Hyvp2GNNUMYsOd7FjwEp27bvE2+6qrDE
X-Gm-Gg: AYBFou30Tr+qGLlXYeDAEIizdBRYapzAjPPota18qo4Ch6hk1Ra+6zYSFLdqE42B4ir
	7HpeRURhhB6eX2QNNLZU+O20gkayc5IpX/pGKLy4Lw7glhkBrBRnxnIMac0UN1SC01lESbqEUmJ
	ridCpwhjfvYBzKYuvyET6E4LOxTJV4IviY0bF2MvGaLTy1t4u5DPZ68vTgtm04Z4AjwyBy5MRqd
	I4pGnuFm6eczPHumIRacmR9fDkUUBZ8bxmrYyH5t7As+Aq4xuSwcMrgqKniK14PlKoQK7qwWkSY
	SvG+EniDwsHO7kc3fmTCDIW28kslOps6mebprCSrtdDQIwg4td27nfUMDa3bCcQVJXR8ypdhYSx
	utpldniHFCBrA9zMU1PCtHHAHlhVPgMSa664EbKDthVwJuJPrPK3w
X-Received: by 2002:a05:6214:43c1:b0:91b:8e06:73f5 with SMTP id
 6a1803df08f44-91b8e0680ffmr139578016d6.15.1792014427625; Wed, 14 Oct 2026
 14:47:07 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 14:47:06 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 14:47:06 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261014095702.39676-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com>
 <CAEvNRgEseLO+LbkwXrEit0H2LH5Wx-srSvHEMpt0=upPL3tF=g@mail.gmail.com> <20261014095702.39676-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 14:47:06 -0700
X-Gm-Features: AclHuK_bDoENPFsEJnePb9piUrHFuROo5b9vCnTZ7F3PMjuUH-N1Jl6pvQGbDQg
Message-ID: <CAEvNRgHtB8j6=9r=txjsKvQM0F85nRN4KW5sdnuv_-Og=cWEfg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> Ackerley Tng <ackerleytng@google.com> writes:
>
>> When the provider wants to revoke the page, the notifications/function
>> calls flow this way, the last [ENTITY] in the chain actually does the
>> zapping.
>>
>> + [PROVIDER] -> [KVM]
>> + [PROVIDER] -> [DMABUF] -> [IOMMU]
>> + [PROVIDER] -> [GUEST_MEMFD] -> [USERSPACE] (AFAICT this was not
>>   implemented in the RFC.)
>
> Thanks for going through it. I have just posted v2:
>
>   https://lore.kernel.org/all/20261014093733.90312-1-griffoul@gmail.com/
>
> It changes two of these chains. dma-buf is gone: iommufd attaches to
> the provider file itself, through a small interface in mm. And
> guest_memfd now maps the file into userspace from the provider's
> frames, so a revoke also zaps the VMM's mapping:
>
>   [PROVIDER] -> [GUEST_MEMFD] -> [KVM], [USERSPACE]
>   [PROVIDER] -> [IOMMU]
>

Thanks :)

>> IIUC guest_memfd conversions was not illustrated in the RFC: what
>> happens on a shared -> private conversion?
>
> There are none yet. Only VMs of type KVM_X86_DEFAULT_VM can use a
> provider, so all their memory is shared.
>

To borrow David's words, the part about this that makes me itch is
conversion. We have to support conversions. Even if it doesn't merge in
the first patch series, we have to have line of sight to how conversions
would work.

Conversion requests originate from the guest and then the host handles
the guest request by making calling an ioctl on guest_memfd. Hopefully
this part doesn't change with alternative provider support.

Suppose guest_memfd still gets the conversion request first, in RFCv2,
to reach all the mappings in various page tables, it would have to be

+ [GUEST_MEMFD] -> [KVM], [USERSPACE]
+ [GUEST_MEMFD] -> [PROVIDER] -> [IOMMU]

since guest_memfd must ensure no IOMMU mappings to guest private pages?
There's that extra step through the [PROVIDER]...

>> Does your provider need to know if some memory was transitioned between
>> shared/private states? The provider can be notified too, if
>> necessary. If not, then isn't guest_memfd doing all the coordination
>> better than going via the provider?
>
> Our provider does not need to know, and I agree: once there is private
> memory, guest_memfd converts the pages, so it should tell the others
> what to zap.
>
> I think the two models meet there, and the v2 cover letter now says so.
> The iommufd side of v2 does not pin and keeps no references: it asks for
> the frame behind each page, treats a page with no frame as a hole, and
> maps again on a revoke. guest_memfd can offer that for its own file:
> shared pages return their frames, private pages are holes, and
> guest_memfd revokes a range whenever it converts it, in either
> direction. That is your [GUEST_MEMFD] -> [IOMMU], and it should work for
> folio-backed guest_memfd without memfd_pin_folios() or refcounts, as
> long as guest_memfd also revokes a range before it frees its folios.
>

This part makes sense, if I'm understanding you correctly.

> The one difference is that v2 also lets iommufd map a provider file
> directly. Going through guest_memfd would add nothing without private
> memory: it would only pass each revoke on. And memory that only devices
> use, such as MMIO, does not go through guest_memfd at all. Both paths
> would use the same iommufd code.
>
>> Does the revocation model work for you? If it helps, I can rebuild the
>> sample provider to illustrate how the revocation can be done.
>
> Yes, the revocation model works for us. v2 replaces David's sample
> with one that moves, donates and makes pages read-only, and a selftest
> that checks the guest, the device and the VMM's mapping after each
> change. It may be a good base if you want to try guest_memfd as the
> provider for iommufd on top of it.
>

Thanks, I will prototype what I have in mind too to make sure things
work as I think they will :)

>> 4. [DIRECTMAP] Kernel direct map.
>
> Agreed, that is separate. The memory we have in mind is a range hidden
> from the host with memmap=, so it is not in the direct map.
>
> Thanks,
> Fred
