Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF023B71A7
	for <iommu@lists.linux.dev>; Sat, 17 Oct 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257127; cv=pass; b=WRBlCpP7hWwvQqOK8sLGTnNrKZYqJE3+5EQvNxL7tSzfrXShR9rtoc4Z6LDJs4/DzmcVVMbjz+qvg9vJ7Bc9OOgrEguU6AsXImSWYdHXTLdLVyGtSYpeT0Ic/IyJYfXTX82vNSsG7E5Q96xaQex3eOIIVg6JzQOowKDBk8BQ4MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257127; c=relaxed/simple;
	bh=TQ0S3+GvPqkyCnzw3WaiERWE0gQzxysyRgtfYYbHNSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jf3IIQ2irDVm3RJpWgeBLdZACO0g3lqDDzwXSNAIzPXGSm70SdkLvZracX1Eet1UYH6MFNSICRat0D8nqyi3Cm5Zo1W82+Ie+VmVs/RRhJPaJZGlndr0mg2bT298KLNMqllP+zcgbUG38SrCE72oz1FGPmo3UlxXAWDnJ4qc/N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eg1oAbsN; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eg1oAbsN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so24915ad.1
        for <iommu@lists.linux.dev>; Sat, 17 Oct 2026 10:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792257126; cv=none;
        d=google.com; s=arc-20260327;
        b=TS9cKcxWS3a3zj9H10StfHsvJtDBPAA6LKxpLN2j+flAdqHsPIQZEoE0NtcFQ22VaJ
         enFElrIcAChVZ/hqZaxEAAHedVvjParbWzfEogpPJOK94jDGzCK/iUtIV88hh3uPXrb8
         WQ6Oy1VbRT8JFeqVHCSZvBvVTBpoeBi79mQe/Qt6FV0z1TobfZe4z2/1ZD/cfF8RMN0t
         cCw5lrHvx7u7eyvTwGPUzvMkxKwivDUdkF5nL678zLaL0dpKVADqT94TESsbIPjLlgkM
         J0oVVduOW9DM+ShN2GjpJFLtcHET23/r4lOgbyCYxajdCeFAdjTu9/50XTDif0CQxxyI
         4kMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TQ0S3+GvPqkyCnzw3WaiERWE0gQzxysyRgtfYYbHNSY=;
        fh=zdrg+OyYtofBq1HPQ4t8naxYsU0soxoJC4L0XENVy0c=;
        b=WkboBRlaS/sbVL9zhMVs33SShHywKw8UAkia5yzI6yCQjkt6NsxRvSRYj0zPGv1IcM
         g6xru9GheufnbYv0HwACAxCXN7snT7hKf+hCK3MuSwXUB0TX9lwbGQy3EFGcQ5TIcamL
         75VjHUUuH00iaD364+juW21rKReQ8Z7TO+zJ7fUwW0/XKQTsRanIdCNdMKoe1aXUdsV3
         s4gsjW/mQ1oem3RpQNr/pdcTPUI3zv5lT1sgV97GG8S+5KBvbrgrtbeOG8CVrI35JVFR
         ZxXl5comH0tXs0oZpoWm4Ixc/SZg+9QHFvTNeGWdz9UAxR2NUBroaKsrKeVt+YVywVuu
         7nAQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792257126; x=1792861926; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TQ0S3+GvPqkyCnzw3WaiERWE0gQzxysyRgtfYYbHNSY=;
        b=Eg1oAbsNn/23y7i4HD2noIjZgYIp/iufp1BmNnNruGEfIVddJYte0K23l2fZ4Gq+51
         JwGgwxJBwE7+KG3pjeeAaTWd18ergMx1bzR5sJBWBL4otsRrl30T3U7n9v6N5pyquV2f
         3Y1WGQjSe5y5RmQrfXJeR4ikdW6QL+99Fwn/aMHOX5NLef6vxUfQkZ0VCEXHHIbVjhKo
         HDtEqh+BYGbr4X296Cs4jQR+BUFhsQB0xJncqTWJe9lKaYBA7zhI1rCS9zfxF+Rs4gG5
         y8cuWktyoyHNOgX9F7PV+aBwILTNPgUR/qeDbyFzwQpXUJmm6/H/xWJYbyRfXCVTEO5t
         +R3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792257126; x=1792861926;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TQ0S3+GvPqkyCnzw3WaiERWE0gQzxysyRgtfYYbHNSY=;
        b=iFq3uUdTH4lo9RKr0lp5tEbwD2tZyAAZbsbiwcGJWbjQSgxOFL07bo4In/QqAHyyxf
         ChxE5Fv5jgWNeQPk3+lqji5gJu4MbcROBxxYH93GEwoHgCz27ob+obQZ9ndrlBQvbg4I
         O5dLeG9vpkmm9Nj6HLWuBZKJpyVtK6JcKYlu7CdzrXEH1bfYtL5ANSZ7Hmx7GFYqZqVZ
         yEDuECjZHjOdx0IPKlEPoQH6MINTkq45MPL83O9WCWt/V9gXgnBcbWuC3sLXXoc9kQ2x
         HpCuj38Jz5t3YT2poGibQ7kdW11me2UQQUgW5il2sZlJ6SFJTbrt6IKf4xjhuhTgCuJG
         8LAQ==
X-Forwarded-Encrypted: i=1; AKwUvBxytwjqPI0M2AnyggHbrAtY3gAKNZFEkTMDHSIVxi21+5f7RZS8z3utXNOWdFE/WhKFZS95aw==@lists.linux.dev
X-Gm-Message-State: AFq9FYL32vQZz+/r9miISiuDuOGR6tz0o4VSOjA+RjjCCZIlB2J7Cbrd
	IVZrlcJR4hiKsy5y5//16v7jcaKpKMhDiUNphpL/6RhlNTN47mszsmdjbDgwBL7WBfVr9G53VML
	e+W7t6PRAP2A3fnfciduEzA5twZQK2QkbAIpST5Lc
X-Gm-Gg: AYBFou1SxW2uMAFxaj8fktc5U2sWLj8HuGq+cdKjDnABHJzfINYpDeFSV6iuKBxewSE
	be058r8a8Utwa8eistwvCTSvnHLIhA32tlPoUzfTQm2Nzs//PW6fxnZEyC8UiJLILOXKlRtvG3I
	MCzzFjXRxyqdYJxq88zz67sNJsED4jqXV7zzJBn0e8CcSO5dVaqiz6Xpi9JT6qSqZEl2/Zcs9qU
	FxJcOK5f2VwewoJuoTkeRtGEf9oEVVNtP9QDnPA2jZ2oTUzf0vVPVcM+4VtsqllWP+5KeOOBpn7
	eC8U3tlqWGRdCj5axvqBoPpZfjYSsxzyCNj+bd13V+ax2+vOTpAMN7k6
X-Received: by 2002:a17:903:144e:b0:2e3:981:4cc4 with SMTP id
 d9443c01a7336-2e9b3252cdbmr3330175ad.9.1792257125060; Sat, 17 Oct 2026
 10:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com> <0cc1cac1-a500-489b-9c1b-b49598b5550b@kernel.org>
 <CAMOZA0JaiKsRgDdjHkL_N+MshhcyLSv+cT9SzEbNsC_sumHvOw@mail.gmail.com> <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
In-Reply-To: <b31efcd5-149c-4edf-81a2-1744d363c390@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Sat, 17 Oct 2026 19:11:28 +0200
X-Gm-Features: AclHuK8222c3YwWa2EndazmJS8Umg9HTADwML-hsKq06OdSigMokkN9A-iBy5wE
Message-ID: <CAMOZA0+6kAbwgNwGTsCT5AqpwcZKz4pziEGC9UpHkNCVoqrF-Q@mail.gmail.com>
Subject: Re: [RFC: DMA_PMD 00/22] DMA_PMD: PMD_SIZE-backed IO buffer pools
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-mm@kvack.org, driver-core@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 9:44=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/12/26 16:45, Luigi Rizzo wrote:
> > On Mon, Oct 12, 2026 at 3:51=E2=80=AFPM David Hildenbrand (Arm)
> > <david@kernel.org> wrote:
> >>
> >> On 10/3/26 23:22, Luigi Rizzo wrote:
> >>> Here is a subsystem called DMA_PMD on which I would like feedback on
> >>> architecture, possible enhancements, or kernel components that could =
be
> >>> reused to avoid duplication.
> >>
> >> Here is a feedback to a subsystem called DMA_PMD ;)
> >>
> >> Why is basing this on PMDs (and embedding it in the name) the right ap=
proach?
> >>
> >> On architctures with large PMDs (512 MiB on arm64 with 64k), would we =
really
> >> want to use 512 MiB pages, or rather something smaller (e.g., 2 MiB) t=
hat might
> >> possibly also have TLB benefits (cont-pte)?
> >
> > I had to call it something... an earlier prototype used the name IOMMU_=
2M,
> > but I didn't want to suggest that the design was limited to 2M (it is n=
ot).
> >
> > Aside from the name, the _current_ prototype restricts to 2M allocation=
s,
> > exactly because too large units are expensive and wasteful.
> >
> > In the code, decoupling the allocation size from the PMD size is trivia=
l.
>
> Yeah, we should do that.
>
> We should probably just find a way to describe that this is a POOL that f=
ocuses
> on physical contiguity in some configured granularity.

Before embarking in a global renaming, I would like to get opinions on
acceptable alternative names (possibly with a short prefix usable for
identifiers in the code). I could think of the following

DMA_PMAP (for PreMapped or Persistent Mapped)
or, ahemm...
DMA_PISA (Pooled IOMMU Superpage Allocator)
both using dmap_ for internal name prefixes

Other suggestions ?

cheers
luigi
