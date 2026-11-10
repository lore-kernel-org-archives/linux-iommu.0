Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335150;
	b=f1ai+4FfeEnIGsOrXqlLC2xW3KiqXW/W5vs/CGMpTuYSYN1Uv0h2f/pgcxTTbdNXi/sy
	 /JcbizWqX//KN5zNcN0Ow+4OuOKSqHZXmsg0loMoxUH9AymAV9ftqbk/KFKb6Ei3K0qGT
	 CC4pGqOUiaTKwZ8/5Oj/hXLf8CxCZHMPifRCiqBE++bDzTqCynp1wD1rdkbXIA8vYgrvO
	 iAyPV8i8exqf3iZh7t/Sk9fQQJxIPGmaU5GwdkHMofBSLl19sZ5hVAiDtc5b8yPTY3v0/
	 aA3hcNINdkiqCjy2t/8dh8kuzDbxJxfD7+S+n3qOQ1IMZ/b4OdnSeg5KJiVCpBS8wCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
	b=R3tqHicrEVVREN8Xe9bHteN2otfodv08NEk2/jg5k564sfhJ2tvyYMHchbcOCKQBS+6c
	 +bMRuwcOE+VxeYNH8Z69KNh+jBc0WREFPWB3Tk/IRygLA/QZa/wcfo4yo3vgO7ysj7bfM
	 Rhq5E3gpTBpZVEA5YgCzzi71sPgS/JPwA3U2wb7NqfRnf+qJwdkXJlfJj6b4LhzDVTDWT
	 1Uf3RVcjHN2DDBe/tyYvIMq6hbksdvtZA91ffvVaKE6JdDBrMBj/vybA1nAO/xzy6cZtA
	 o/wPl76uylP703HwOgMxc9lUrD9znO/WlGcC0NcUAuyp//kK2qzRsC6hCuiPjhZEnAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fql0BhI+;
	arc=none smtp.remote-ip=209.85.208.71
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5243606A325
	for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 18:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5243606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fql0BhI+
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a125f5b317so2506853a12.1
        for <iommu@lists.linux.dev>; Tue, 10 Nov 2026 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335148; x=1794939948; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=fql0BhI+Yui31ZQlbGpw1mYTyhPQnCObdzl7Bw/cE30dA3OlXhfAy6VIIMskgyDfuk
         hNY4HKKMAF0RZk95kS+vdFHWtgoJ/RXuBppdVPxruoU3oLP/v7rGmDKHSsMOa/epjba7
         noX9FZsl/0ChCkf+nkhIH1/YnWMstE8fC3HRnHWGziB0ML4M+97XquJ5lc4DZVCo9SNG
         rtNCtP8Qj66G7eI7X6VLyOJbJ9lBGlJclbdiXFsj3zLSNnCnwlEkQLZonlBwEOdt8LE3
         0heJKnc41mVb5qSMOJH6IWosmlQ1tViG2ohSAMY6BpW3KxkqVvhM2lEqeSe6dEhrGWuU
         PElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335148; x=1794939948;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=i3SLAfCzp3jZHG+PIQvVyVjOIxFdkUUZ6YE8Ae12OMJoCvlgT2KAO38nWYdQvajzlJ
         xLvzozTGCRowIlbOWK8thqTA+6m1sRNMl9W/iJvMY4rDlLAklHZ0Rf5L0Y8ZNOlylX72
         GCRhWOjXugxfbH2FuVR3ijL3gjREXMDCXsqxqEuKnl0KAOEqNiDXPYQc+RFk1tp+Ohla
         zjQeEpL9HxKVhihApBfOy6bfrE9andJpcSmks2DpoZ9YsaArttiLgRRDWaGdteBvXoDL
         PzcNB4Av+8vsYlKzsK+8pBqTZ3kxQ+oJ0M1V1/88XBLp5B5NSpVkRe/B0GFvrHsZtWSl
         Og4g==
X-Forwarded-Encrypted: i=1; AL+hErGhtdylwJTnDhTSRU6K168jch+oj48nikFj/+2qX1KP7DZTN+csGoMdZtn7BnGh6jJhsYy3Ig==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1Vt7miK/f40n5yf17rerrwkq1uGAtkL83BXwyEYeNOjbdnuZV
	ZVcWNpgQnzwMrHFEFXgpT9VN2AXQEhggBLAyFxUT4wju1L5Xt2D3zfBXCB+sIIBe/GKeC1obDaJ
	4KteO9Ouo4zYnI8dY1A==
X-Received: from edfg4-n2.prod.google.com ([2002:a05:6402:a244:20b0:6b5:813f:c569])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13c5:b0:6b5:76be:be54 with SMTP id 4fb4d7f45d1cf-6b777829b2fmr85425a12.35.1794335147866;
 Tue, 10 Nov 2026 10:25:47 -0800 (PST)
Date: Tue, 10 Nov 2026 18:25:47 +0000
In-Reply-To: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-6-tarunsahu@google.com>
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Message-ID: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Pasha Tatashin" <pasha.tatashin@soleen.com> writes:

> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
>
>> +/**
>> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
>> + * @name:         Structure tag name (e.g. luo_ser).
>> + * @payload_size: Compile-time expected size of struct @name in bytes.
>> + * @nr_required:  Total number of defined required features.
>> + * @nr_optional:  Total number of defined optional features.
>> + *
>> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LUO are
>> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
>> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
>> + */
>> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      sizeof(struct name) == (payload_size),		\
>> +		      "struct " #name " size mismatch");		\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      __alignof__(struct name) == 8,			\
>> +		      "struct " #name " must be 8-byte aligned");	\
>> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\
>
> Remove this extern.
>
>> +	enum {								\
>> +		__KHO_SER_SIZE_##name = (payload_size),			\
>> +		__KHO_SER_NR_REQUIRED_##name = (nr_required),		\
>> +		__KHO_SER_NR_OPTIONAL_##name = (nr_optional),		\
>> +	}
>> +
>> +/**
>> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or parameter.
>> + * @name: Structure tag name registered with DECLARE_KHO_SER().
>> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER_PTR).
>> + *
>> + * Declares @decl with type struct kho_ser_hdr while checking at compile time
>> + * that @name was registered with DECLARE_KHO_SER(), documenting which
>> + * serialized payload structure a feature header pointer belongs to.
>> + */
>> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) decl
>
> Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.


I added this, because wherever in the kernel a serialized struture is
preceded with kho_ser_hdr, it will only be called `struct kho_ser_hdr
fhdr` which does not display (to readers) that this declaration of
header variable is not alone, it also holds the serialized structure
after this variable.

Using this macro, it clearly explain, that "Hey, I am header to this
serialized struct and I am compiled time initalized using
DECLARE_KHO_SER for this serialized structure and my pointer holds
location to both feature header followed by serialized structure."

Techinically this is just for readability.

WDYT?

~Tarun

>
> -- 
> Pasha
