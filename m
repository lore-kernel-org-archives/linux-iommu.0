Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC28F1917D8
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738059947; cv=none; b=HerezUhojn3db4KReILeBkSHO2EKRDY0smUJ5JyFUhZE2wv3IweU7bq+Ss9nel7X9agWfPGiWblxkx7TdEq3IPuxttNKXJP3oLBuX+EkhOXTU0IRqRknFuJCkT2waWTFEuz6Tz7YV8J73nKeZ5uRNAQ9N0Z/fmaD17weizcJeZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738059947; c=relaxed/simple;
	bh=MJu5R0MF5TiC+CyW0Qe9EekqjqUAvKAoZ/rwwaVRzWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHsHp+iSyYOUnAi39nIuXte0lwXm5QH7vavRj8ym3ONMrKZp+VoY7nkrt0W8E2YJEK+FHkdu9qQVmdSzaUw00rv2TJuZ6AwedhZiNspQQWuEn8DSx48irpmhwECQVnCIj2bQEZ98d/1PsS+9iX7GuTg+V4IOiJNXpuREFl8xmMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoCAalQW; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoCAalQW"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so3913304f8f.0
        for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 02:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738059944; x=1738664744; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJu5R0MF5TiC+CyW0Qe9EekqjqUAvKAoZ/rwwaVRzWU=;
        b=aoCAalQWfmLew9clX72avo7M5/uSpMKhHwSR+Oi/DMdGFw8ZgKzkeRmL+MG7FormsT
         c6exFSOamihVLrk3BH546oirQpWWnYOP0O/4XEHAXlh/86f+FdUHsiQIls11oAisO9Wq
         qRX0gq+OjmuOpZb8ieBV4axbxPGBlnsQbn5/kjzSZXeV3wCOySA8eybTgLjykChqzZeO
         S/NQSZIiLQPmXggRVvQcp4s5qauorkxnIC+FBKVsiVygcl9ABEvZS32X696NJ7Yc96Sw
         77l31wKnRxP4gWYuj/0t0rg9V62Du5sBgfowkOpJYRe12NKcOdc9wlmas2wBLY/Bai18
         4RDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738059944; x=1738664744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJu5R0MF5TiC+CyW0Qe9EekqjqUAvKAoZ/rwwaVRzWU=;
        b=tMS8uIksPCnNfDdEby9kmDt92bVSujyBymctW8vOb/lVzHwAkEiqlmJnrQCSMcRrNW
         g9xJ8MhqazXsuVGwK5M4zUh4YAvyiEhfPWb7/vgbtgv0CpHmeQWrIbVTOEfjJ2u+O3DQ
         n83BqJl88D66sAmn2jqaktEPuOp4AjZiIRv9y/JHJQ3xcdgw4h13gjT0nR+tEdyX0hdH
         x95Dj/gKUFNPJ+5o+2bVh5l9N9BG5gMJJ5hnzxC5aK18bkYazZCr1eRDlnjg3drl1kXA
         NJepw1vMceZpkKtdzrZ6RcsAohnyR3ko+hoEnaABp/Vpxx1+C554j3yEKW7Ka9xa2PH2
         oivw==
X-Forwarded-Encrypted: i=1; AJvYcCUYI2J4Yd3uUTE+za5a4keAQr+NduEkfVaZuz/1NAXaR8/24PLnlsx5tnFRg2Fwfpo/8Oqs5A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqBDMMCJNycmS6/1fVOlwFYmYvSGKg9Y0OevNvwUMopvPZdL/5
	+Q81I4W+Kfdk0JlYJHIb3iYk4j0whi9I6eWxgW5rPa9tnOcPq+VUUojh18r2sqyd19TvD2BfS/l
	mK1goRHxnaXNCamcPTfNmou/iMROlRuvcx3t1
X-Gm-Gg: ASbGnctOMJ+MM58c5b65O86G72IIFAL01K88oGEahPu8fpoI2Vs2Dj0SHa45E78YbTm
	UKpcn49wAWcCH2A0MIGvhfvP9+CQitbisbxBr6oRstlUh6AlgKBc1z5FAHCLGTCtV3Z4xMF9cRN
	cvFaLLc3E/YmNqJKyJV8yresKh1A==
X-Google-Smtp-Source: AGHT+IEH90BFbkOp2SYmGkeYnH3Xp0516Xr0wSSe7xPqdF4528/Cj7GbtqfF9cTkbeL7NcQEeKy+SngdmFt02Mg/p5A=
X-Received: by 2002:adf:e946:0:b0:38a:88bc:a8e3 with SMTP id
 ffacd0b85a97d-38bf567a57fmr33366059f8f.33.1738059944088; Tue, 28 Jan 2025
 02:25:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250123104333.1340512-1-abdiel.janulgue@gmail.com>
 <20250123104333.1340512-3-abdiel.janulgue@gmail.com> <CAH5fLgjL0aGGwkjEfXH08Jopwin1NfkLzp9vQWKcHPEum8jV4g@mail.gmail.com>
 <0E0FC88B-95C0-4DBE-B497-AF9101BACE70@collabora.com> <CAH5fLgiW6n82hMhbmJ-ynd6329mEDFX6TzxXQZaaoG47HAWWcA@mail.gmail.com>
 <95382414-7A44-45A4-8F3F-C6D755422AD5@collabora.com>
In-Reply-To: <95382414-7A44-45A4-8F3F-C6D755422AD5@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 28 Jan 2025 11:25:32 +0100
X-Gm-Features: AWEUYZnhdm-O4jhFXri6BK-i1np_sxsPH8BwJdv_jxk9-d66JQytiLOOaeJiOPM
Message-ID: <CAH5fLgjZiux1_=dNuZN+7SEY6fUGMDNLoJNTwmHcB=WbKChwzw@mail.gmail.com>
Subject: Re: [PATCH v11 2/3] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, rust-for-linux@vger.kernel.org, 
	dakr@kernel.org, robin.murphy@arm.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 11:23=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Alice,
>
> >
> > The difference is exactly that - you reduce the amount of data copied
> > to just the size of the field.
> >
> > Alice
> >
>
>
> Is your idea to have that *in addition* to the safe methods?
>
> How does it work when you want to read a T at a time?

I mean, I imagine that you could make the syntax
`dma_read!(my_alloc[7])` read the entire struct. I'm not sure which
safe methods you are referring to, because right now there is only the
unsafe as_slice().

Alice
