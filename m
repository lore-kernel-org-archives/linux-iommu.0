Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2E4C8E
	for <iommu@lists.linux.dev>; Wed,  1 Nov 2023 06:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="3gVKElee"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-b985-910f-39e1-703f.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:b985:910f:39e1:703f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 1F6671922D4;
	Wed,  1 Nov 2023 07:27:25 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1698820045; bh=2K38LTZ5EoAOqClnClNnktlaqykSFUpuuZUZg3QG0Xs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=3gVKEleekoVAHcBLOfcL+izq2BI4OydQGxObjHIt3+wSzt5Yd2uF7ZIgn5MXx6YYX
	 O6q4MsnkcxkoMLELGHuTkKwnvHGvH0bu40gmZctNfY2hTWvHoN+AluJrxZ17iey9/f
	 wJ2nItTpXDczp1AvNybKWUGfhGFuu4Wb3badjbRg7I7t6NlUZOPmu9LKn4ejW5lrgS
	 EGbbSsTRO7jZCUrXB5orn9YIZgwbN8Ao7Xkb/aPrAelyV7uA5Bczegnm0mjyszr45M
	 eFDTksnSvTIqHkylNovjtcs+B2f91lFBN1OdgZG4+RODglkiuvS4xNcKcIrS8o6Fl2
	 J6iadcl/6oyHQ==
Date: Wed, 1 Nov 2023 07:27:23 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Lutomirski, Andy" <luto@kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
 <thomas.lendacky@amd.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "Reshetova, Elena" <elena.reshetova@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "Christopherson,, Sean"
 <seanjc@google.com>, "kirill.shutemov@linux.intel.com"
 <kirill.shutemov@linux.intel.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "Yamahata, Isaku" <isaku.yamahata@intel.com>, "Cui,
 Dexuan" <decui@microsoft.com>, "mikelley@microsoft.com"
 <mikelley@microsoft.com>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "hch@lst.de" <hch@lst.de>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de"
 <bp@alien8.de>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "sathyanarayanan.kuppuswamy@linux.intel.com"
 <sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>
Subject: Re: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Message-ID: <20231101072723.44d00721@meshulam.tesarici.cz>
In-Reply-To: <3903bbaade7ba9577da88d053b67b8bfdf0d3582.camel@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
	<20231017202505.340906-5-rick.p.edgecombe@intel.com>
	<20231031114316.0bfa8d91@meshulam.tesarici.cz>
	<c0233c531965a69ffb55210ace6a8a9d0f844e74.camel@intel.com>
	<20231031181340.30233c17@meshulam.tesarici.cz>
	<3903bbaade7ba9577da88d053b67b8bfdf0d3582.camel@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 31 Oct 2023 17:29:25 +0000
"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> wrote:

> On Tue, 2023-10-31 at 18:13 +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > Thank you for the explanation. So, after set_memory_decrypted()
> > fails,
> > the pages become Schroedinger-crypted, but since its true state
> > cannot
> > be observed by the guest kernel, it stays as such forever.
> >=20
> > Sweet.
> >  =20
> Yes... The untrusted host (the part of the VMM TDX is defending
> against) gets to specify the return code of these operations (success
> or failure). But the coco(a general term for TDX and similar from other
> vendors) threat model doesn't include DOS. So the guest should trust
> the return code as far as trying to not crash, but not trust it in
> regards to the potential to leak data.
>=20
> It's a bit to ask of the callers, but the other solution we discussed
> was to panic the guest if any weirdness is observed by the VMM, in
> which case the callers would never see the error. And of course
> panicing the kernel is Bad. So that is how we arrived at this request
> of the callers. Appreciate the effort to handle it on that side.
>=20
>=20
> > Hm, should I incorporate this knowledge into a v2 of my patch and
> > address both issues? =20
>=20
> That sounds good to me! Feel free to CC me if you would like, and I can
> scrutinize it for this particular issue.

I'm sorry I missed that free_decrypted_pages() is added by the very
same series, so I cannot use it just yet. I can open-code it and let
you convert the code to the new function. You may then also want to
convert another open-coded instance further down in swiotlb_free_tlb().

In any case, there is an interdependency between the two patches, so we
should agree in which order to apply them.

Petr T
