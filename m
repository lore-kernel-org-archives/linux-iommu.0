Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F91A266581
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 00:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448098; cv=none; b=riaaITcSQyqqJcpmoXlY7NMzvfN/zu+hN9vNWGc20I4Ak0uoYqIOMNZjjZiMXFA+MPidsSWRjs+QOlKkv+HZorakkjLmF50D6nHQfPrn7vquHWYfAbZ+bMvmUZvN5wOZIOW2heNyLnY3X4GxPBpTbpO7qlhSYzgZ75ATOxnJp80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448098; c=relaxed/simple;
	bh=W/c+ST5uf3ZVEZ/AWys6/pG+OcAIML9okmITgYiOjr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDa3Fa2Rkpz5qVnlaGVX686Gnq1qvbP3paZTUh6crBIF0uErSv01lihDvkX+jjR2JNia/qdH1h6CDv0/vQrSvaRVkmnT4qghC02+uVcrso3elUFjzIhfR8uVQtsmq7bqdH13pVCcoL/VXdsA+RUZ9wtEBsRvH1VAlB0wwxqrEUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HGhSxbyQ; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HGhSxbyQ"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91588056619so54485785a.2
        for <iommu@lists.linux.dev>; Tue, 02 Jun 2026 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780448097; x=1781052897; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npyTF2LAztZXio21Bq8j0RB5zw9LU0pLQvjc7W7RzIc=;
        b=HGhSxbyQBn7cjHprCd+F3SD9tstHAyyD5kBo5Dq4Cr12keaWIDkbXX7tjH4LT+85GN
         FH0orV2iURLGYPDd5je+TyRK6rrJKuyGari8TG3BGFJGzETspJxxVo/zjvklTdarVhnj
         8I1iruQzbVXqE43F1M3qq5QJ/zzKMITYhxOyy6eyvmYqZmRlCwfu7blftvV7CrNJ+vFx
         lGvTGtRIrp0XsoFO/OnpSmboDKwcA7kEA9l5zSH1feekb1/PK6g+uGHtb2wxr/Px9T8h
         ccZaWZMI6KYHkQ1J+kc0KC041in8M2x0ZMjwSnGqgb6O2kJqAuDo79t2Zl+1vrYJFuOS
         el3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780448097; x=1781052897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npyTF2LAztZXio21Bq8j0RB5zw9LU0pLQvjc7W7RzIc=;
        b=YJ6bz5NBw4N6s7TPn1L79/Mqy/fu69Uq83AiydEtgie7tA2krMqHZ3fQesKR35PgB5
         iAHNNFb7AwhlQSLqk0NUeKNrtg3niv1ZzMAtx85dYsOda6q0Ct1qtChdp2CS1rutbMuA
         BRpBhaeM0lzgjD7JrcV3h1II+5ArQ86mjXvlR4y9wsgsgnEESvjfZcJoSVqXzd8h+hJK
         eEoMw5U5EQ8Wj5/olJZRHkOR2g8JrBTYlzZTIKzHGz4XKM7ceKzwB7AkEXdVftWJHBfz
         sclbFEpPUDnD7pYhkLjpUhMHIWCBmBIhxl80iIohsppdOA5IY6lBYeEq8OPAE9POGnRf
         jxlA==
X-Forwarded-Encrypted: i=1; AFNElJ8MZekrUUmZ0W1BRjgf1Ub78bE4fPzpXDRh5u6F7ZUwBxHmwpVcl0ucusMAc4RIqeb1Reg31g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+BhRkRqdz0bLOg18kkvOUj/aNvAVVvos/CU2FcyU9Q39+JCJy
	iWW/5CPTfD+egvd1KF3s5ji7MPOGJPKy7hW3GKKzvianiY9iz/v85uH0Wzytt7GvKGc=
X-Gm-Gg: Acq92OFYpxxTcLSkA7rMTtuEUTCU1WtzOgNAo28PMwFsVjKDHgVge1SvNhYcn53U0VA
	q/5BBKeEBCXBpcKBinZ9sqo1TGd0dO8QlYe27yjETNj2Y+48fd+QS8i4Fo9UX+DzchIIKu8Ib6P
	yEjAXXl7TOMjwKLterViR52L3nuxm11JRW/IfOY/1k807/R8sXiPAzOVX0whypZfX+rtqS6+KbL
	17+TzkSTMpMu6liDuhfXAlGp0v+WHjIiFLlkqrGhvEUM3HaLA1iYF1xCgNTv2EUFxkivLaA0f4n
	Z5IQJy89rQmiOd0aJdFGgkKGCKSinav+dsi6ARJutvqCgW+Wh75S1YwB6h8anh7PJCU2nlFSP4R
	ZsQl8cgxS8SReKfetogvyGkCCQJ0leRLsjsWyUvB5VB94gvSyB6OdBWBrBd8fOkXUEtEQXVpXW+
	TkeJsSNjBUXv+Gn/DPApdNlRsYqKCiUBYUN7aLnMg68CmwMTNmOYk8ecPseimPAXaOcWJy8CSWc
	s1w9w28Kz5L3Dkk
X-Received: by 2002:a05:620a:4409:b0:8d1:a75e:2f8c with SMTP id af79cd13be357-9158a86b6acmr242337785a.53.1780448096650;
        Tue, 02 Jun 2026 17:54:56 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a237330sm100630585a.16.2026.06.02.17.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:54:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wUZsk-00000004x1y-3mPP;
	Tue, 02 Jun 2026 21:54:54 -0300
Date: Tue, 2 Jun 2026 21:54:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"x86@kernel.org" <x86@kernel.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH v5 05/20] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260603005454.GM2487554@ziepe.ca>
References: <20260522042815.370873-1-aneesh.kumar@kernel.org>
 <20260522042815.370873-6-aneesh.kumar@kernel.org>
 <SN6PR02MB415754E94A9505C2B9739E4DD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <yq5afr35sciu.fsf@kernel.org>
 <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157D9955A93244014AB7978D4122@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Jun 02, 2026 at 02:24:40PM +0000, Michael Kelley wrote:

> Except that in a normal VM, the "unencrypted" pool attribute does *not*
> describe the state of the memory itself.  In a normal VM, the memory is
> unencrypted, but the "unencrypted" pool attribute is false. That
> contradiction is the essence of my concern.

I would argue no..

When CC is enabled the default state of memory in a Linux environment
is "encrypted". You have to take a special action to "decrypt" it.
 
Thus the default state of memory in a non-CC environment is also
paradoxically "encrypted" too. "decryption" is impossible.

Therefore the "unencrypted" state is a special state that only memory
inside a CC VM can have. A normal VM can never have "unencrypted"
memory at all, so having it be false in the pool is accurate as far as
the APIs go.

un-encrypted = true means "the memory in this pool was transformed with
set_memory_decrypted()" - which is impossible on a normal VM.

Jason
