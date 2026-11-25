Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567195;
	b=qDojbPrD84JPd45lTqyTabF2fl/nx1K4tkWi19/tmx/LAfWlHT8mxB5kt1NvAgSlkuIZ
	 +HaT7UWlxN5cXH+PkT5LNxCMvgPl21tKi9R9/H0yGxsq1Q3um9DtsfogltCm56whwFJvy
	 UgM3JejeBQHKUenYz00ixvHMzUmueNFSxd2V5pp8uc24/HcdYJTAIbNVpv+9OxZmSCeKh
	 1XpX0nDq9HKQZHJljauyJUBepT6tAkcHL6/0Y3chvFUDciV0ySEgpHbWrLpeFHbEu5dSo
	 M5T3iZ0GtKYvheMyZhE0c9gqny1AcS+fbeCCrPbGi+lj5X09YokNmcZOcVLcYWFsQ0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
	b=D7opYfbgJWtDBZPSCzp02PtFaiYIy6253Gr63rxAtYdIhdahrLFipgnXVqkACBnOmVSC
	 PrxLvSn8pslhx0YNeuVG7rPflL7husLrKwlGnx0Y6Nkj1VFgscUZnUs4VG91mK+GcTVSI
	 6m+L326MLPB46y2XsX4PaWdZlABLz6dhMDXjXgNbDB/W9qJ9/oZMRZO1LefYNOOJiBch7
	 jc6RNV3S0CiDL+TW68hzmfZXtTmxqKVk1waBSQUE4cGX44XTGTdu+uX3uU4INCuNK0Y4I
	 0Ywgl6Ql7GCXsf1rNFQQfZANS5GlM01q/Ck/dkskGFc4MFsHJWLDf0c+eg7o3/W6pyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nCzlJqch;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C70606A32D
	for <iommu@lists.linux.dev>; Wed, 25 Nov 2026 00:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C70606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nCzlJqch
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2f05bc71e01so21445305ad.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567194; x=1796171994; darn=lists.linux.dev;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=nCzlJqchLm9wVfq1hfTMvrl4CGlTPvgGRlXCFvr67M9+kxomxzBfe6jf6It7yRuFjo
         Iu88IRlIfVu3mfnlUbhpXfvmbEM7Cfi1YZ+Iwvsiahf3GiPYFQYkhsXUa8ibrlDjodd3
         riMi5ZQPdNCiQ92rBvgXb+o2SCnWHCE1ypTYilpoRfgmNEJF5Iy89YWdMbsFcDMXltQ6
         ki38FIId3w9rZeY83JAEXF5pWqOf4PNm491qrzEzchzaOg0S/tePlieMC4xYwuDHXhvb
         +oLQoknGfG2FoM/vroKP+ep5rNgyko0PHDJblSI5dSIvJtXdr0A3lweNldmb4WVkeaDw
         v8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567194; x=1796171994;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=d4DCvzy8dI5QJ1+OcE+Iq5jrTPGESVqunWtXOFZZNUmt9BzYvlg0j2IkQVoOhZ44ft
         p5p60akr1EgQSf+GMBjGMqki+DVc2dwo9qeCJZTFAhSSo/dzIjjAj1V80qPR2x5UKrge
         V/fHJy9MBYWoFhzr4B7lF5UoLgdb3DAlp4BMswZFlFK4ImjtZt7FAUqRe6NGhqqvqDbR
         8o14VDxHJfIBlHHTAM7OkMA4Jhnd3ZgrntQ0/LlbECHOigVtynhMNMy4Gh4pulOuTIFY
         25E6x03TfzIybk1IAo15zvLZ/s1lXUfA4iEsSLkveHA8O3+ujtW8mYiTr9FqRhs7PqoQ
         jLeQ==
X-Forwarded-Encrypted: i=1; AL+hErGjKgZeR6bJ/SmMdd3sQlR/qpoKqQrWg7+MCazxc7J1eriKuz/vrXBZL+/hKIERrOT4zEdWpw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+KS6I/6AqI1sTrAk7PKKf7OeoYRK6rFxAx/BFDWMa8+chJZAvV
	G2uV4ICwzege6H6vzkIlFmH1w22wCt8qLdHS9GtyPyAnlgxEP1JCS77WUtEQLMEHRQ==
X-Gm-Gg: AZFdTZfUe5Sl2A9egrGhzqeT1zsuk0Ljuf5oI8tboXE1p0irBp/MD5n7chtfiJ0ZVpe
	rwtTl8N8fIvY8bdR8g/Y+/OuhYiIUMjFNPhOr84vd+GD7SfU8PtQvpJ6ig+XDH60IudXbxQJH/+
	uSUR4dirDKohzAZ/hS3bDVK8Jz/r5u8Z01HrknSdRMkqnvVysIzPkaM8iBlyPrZYKHW5ekRwaiQ
	rlT8eVyFesKcikAOvDwV8USkTHUveaWTle3A1tiz4OpwPRMWjy38dgDRImdyBsqlwml7dkttAEd
	U5AghGPpnb778EboklJPSgxzl45SYjEEqCTGNQoEjAQnmuBmFRkTocNbkeM9ZpPsf4iHnaeUu2H
	rXEUcWiTo2Tt+dZLs+ShjaoYQwVdDokvXyJzdzT3tfj1QKpl52ALqiunlJvF4Pgq41ZM5W8LwvZ
	wE9MBhwetLsDWjBotjUti6+jNbnbEn0jybAPbGViHNandDel/uAij8PzUrEnQxSPtVkE8F5c1Mc
	O7Ri8vC3AIpTucUINSY1lISTL835PuwxgUhtxv4f87ZiEKkxyCr8EVX0yYRNMFOqnO6RlOYbM4S
	6f7wlSHEsptydQbH7qD4fDLd5LwzUMsnb5BbDF8aFZBGclBtTkwFIbyr1mMzvcXW
X-Received: by 2002:a17:902:eccf:b0:2f0:25ea:8fa8 with SMTP id d9443c01a7336-2f03f176abamr169618335ad.19.1795567193320;
        Tue, 24 Nov 2026 16:39:53 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee848c1sm75603595ad.10.2026.11.24.16.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:39:52 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 16:39:52 -0800
Message-Id: <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Tarun Sahu"
 <tarunsahu@google.com>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport"
 <rppt@kernel.org>, <robin.murphy@arm.com>, <maz@kernel.org>,
 <will@kernel.org>, "David Matlack" <dmatlack@google.com>, "Alexander Graf"
 <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org>
In-Reply-To: <2vxz4idb1i2w.fsf@kernel.org>

On Fri Nov 20, 2026 at 10:19 AM PST, Pratyush Yadav wrote:
[...]

>> +static size_t memfd_luo_ser_size(void)
>> +{
>> +	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
>> +}
>> +
>> +static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
>> +{
>> +	struct kho_vmalloc *kho_vmalloc =3D mem + sizeof(struct memfd_luo_ser)=
;
>> +	struct memfd_luo_ser *ser =3D mem;
>> +
>> +	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
>> +	return ser;
>> +}
>> +
>
> Hmm, I am not a huge fan of this. This makes doing such allocations
> quite annoying, and I reckon we will be seeing a fair bit of them in
> many places.
>
> The key observation here is that most file handlers need to allocate a
> bunch of preserved memory, but they usually can free it all at once. So
> we can get away with a very simple allocator that hands out memory
> linearly.
>
> I have sketched out some code for this, take a look at the patch below.
> Note that it is only compile tested.
>
> Perhaps give it a try and see if it does the job better.

I agree the manual packing in memfd_luo_ser_init() isn't great, but I'm
not sure we need an arena. This seems like something KHO slab support
will solve properly, and since kho_alloc_preserve() already takes a
size, KHO slab can be dropped in underneath it later without changing
any callers.

Until then, maybe we should just allocate struct kho_vmalloc separately
with kho_alloc_preserve() and accept wasting a folio per object. For
memfd that's one extra page per preserved file.
