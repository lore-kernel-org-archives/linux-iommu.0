Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E58F37CD32
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557724; cv=pass; b=KzbD5d3JhNG8zRL2SmNn8FiGCODv0iyKzs5aHdfpbIuRqN6mysP67TLdLN/VWXXsbhJuHRwGeOJ+PdlChRvMIYW2L5+S1l+kaP82bkoHnLKhkaRotrFZ9oBkm8cfcLESMHvdZaP4uzosjymPC12bSZb+lFr49tkvO6y5vaYxjZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557724; c=relaxed/simple;
	bh=6meBRs5nEnzEznihvbKKzPhzXCt5ZLXtMWNzXDh/Pz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZ4SzgL2b1JbBca82TSfSeLnes4hALumgW2uNYNC5F2GloQGsobZFkt3Ll8BUisBAEbZQ2dAkVcsFfOeQpwtdDsPW7s949vKcIHzKd6Q0/Zxgq010XHzJUCBJKO/mqFRogmOZq6cl86ZPrbLUnKGPKwobvofjXksFi91ATGF3Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=halhBqlI; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="halhBqlI"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bec4639953dso58095166b.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 00:22:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780557722; cv=none;
        d=google.com; s=arc-20240605;
        b=LfpVt8uL0D77Qo4Q0ageBzlQqJbCtpZxzRuk44ozMX9Bn6djg85BYLQCfusZ41GUiF
         f+CDzOznkBvRSWfAfJxYpn6khmqvsB8yEzmXHsGrMTesymyXy05vmQeFFACPnMRbo7fQ
         OqEYcucrKCQAsm3XeLLXMpmYajtxTDWQ6Qf24MaI6JcDU/5OJWTIHRVLRCeXeinT+Zby
         /eX2/bxqCjCouj/On1KHZUgfgY5/QJMvt94tjXsxnA2EawhK5KjbqE7HSOHkPjbyZJVT
         9PstZo26/jNOjr8C6JdF4MLNLMz7wnsRtd/FeTCGwurDB00avxGIIImKY/lp+fMNM2DN
         qUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        fh=FwemGkgTJqcMG/4bWcJ1upINJZcFlJOd70A0mpLhlo4=;
        b=L5+iAPk9V8KfzOJ3jCREajIoSV0kG/BXf7E+Udm/L7YDH6aDirFVJgN5QBGew4enLj
         iPK4f5TZ2vMZMn9mhuXRZAfonu3mWgRk8HkMwTFy8xjLzSIcVQHwY42IdSmJJjC6AiGb
         0gYENlaLoIiKmyX4RprlnrG1xMDz5zFIbtSrx8DQkty1WCeaB511MqHUTAMFk8FOY5bN
         NDHDL1CmYERhPe9v53fSweRsbSpWleY2X0/d5nICyP0yJlmXwH2wkr0LwWlHHPlijZww
         CTSz40Xa/2GVUts5F+ItnA0/eYc/8bogTNn9YBJSIz9MZpMCeuyhbVmAxmQak6Xcar7K
         MN4A==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780557722; x=1781162522; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        b=halhBqlIr3YZDZ5HHeex9L6j5NOZZmIscmJ0eoGrWadELCIVSTYfJjUF9ixnEbtdqA
         aAesvx/Ui1HPSf0xJzWRLvTDkIc+TOWVbFWS57/4wJdeQ93ltf3EnzpTYfvBSKdjJT86
         5oqvtFIg9HeLT6ZwZ1qGGe9eUX8ti4Mxz/Y9IxeUf5+MundgeflSxBWsXRVqL7f4trlq
         5EjoV3K5+PlKMaEoYAv66CXpciEGSUmyhFnQ8XLzFMoCGlDvHtMh/MfREZ48f2OXrqrD
         apYdnidML1JvXq1Hxh20lnLkbkOMra0wPNpB62Jjw5+gKEH+TalsBT8plS3NG0l08Gg8
         lGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557722; x=1781162522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrvkDQfBnoMGYCzLOCiivKkoiHfHm/OTQW0RCIfHRHg=;
        b=TzfiQ8+tieHwsKSyqRxSDK6Imr/d49MZiuNerJt4EHTWXTGlRy/WC76+J0tF2dexUp
         QTLjwfwPDOxN5ZOKRlM9fL9SKquap+BTFjGGY2nVfzXWbhY3/Le8Z6xl6DgtuesToOb+
         /hUgJ9RSOQfUhmbVKsJeLl/hALPR5wZFPcHFTLJ3Vlv+YRrn9/7MSTGbJqnGiBymJiL6
         IY6CxdK//lwB5ykrI/qFEwITgmkj51X4ruF6ewS6On08HTUD0pX9ENVol8XJm8yKsUnx
         wjVPGtu+tww93k9tFFx7eun57dx7UcRxqkJvzk89tFKm3+l4ky/1kl5ObSnvpqFoS4Vu
         iVyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zwnBkdUi8XhMgZPukyDPl7aSFEdHxrkp3lZ+69Sw/ThdcSDX3D3IqOPLFOGQjm8jHsT4bwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxks0L6+7HCdT2tMsWvHlixSo06PqyrmtPbjjHsB6Iv4NH+NVUQ
	VxhE7/uwSzS/UXh6CF/8HwM7TiCwxqTU17Gfq9yglZj1LAFO3jd4ye2iewbQyh14DsUv3Z6ukDf
	L2hrIrA6tHID9fauPCZTlipy7zTl/p3AbvfSrSjWC5w==
X-Gm-Gg: Acq92OEi/UswzPklthu0k6J40eKvgbV/77g/M51RXECzvsWgzHVe/BjR1BiIB7wwD2/
	obFGGfb41KEaQfJfz/m5XcYarZlU5UdvHfmHWY3gtMQiiomlleI/TB2jbcFjwQlXyhqnhW8LkEf
	wfDypQnG+BtgYH9eVQ8JDZVEaaYjzZSZKkjIY2TdiegJ8twlQUpl/G9soEmkyWOOUXBRKb6O5G1
	I7nmDzxjsJ5icjJcQtcLXKdhJSqpPR7SdyfK9HGkhTqHCVEK9fkcXLEsXTWiyNYy9OzDwoyn8C4
	Otxu6sdZ+4Mjui3wEnfmpgZBwY9WwNDaA9asJWlL7eVjZDLx7g==
X-Received: by 2002:a17:907:cb89:b0:bee:45f5:3e with SMTP id
 a640c23a62f3a-bf0b4395beemr416640866b.47.1780557721718; Thu, 04 Jun 2026
 00:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
In-Reply-To: <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 4 Jun 2026 12:51:49 +0530
X-Gm-Features: AVHnY4LN7rgVW4AsJ6ueOLy3-gj_m35-QjBHqySb09IN1JOBtBY4T1wqgFsSviE
Message-ID: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and set_memory_decrypted
To: Maxime Ripard <mripard@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>, 
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org, 
	lkp@intel.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-mm@kvack.org, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-s390@vger.kernel.org, Dan Williams <djbw@kernel.org>, 
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Thu, 4 Jun 2026 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> > > On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > > > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > > > module") the system dma-buf heaps can be built as a module. The
> > > > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > > > but those functions are not exported on powerpc. This can result in a
> > > > build error like:
> > >
> > > I'd much rather revert the above commit.  Yes, x86 has exported these
> > > since 2017, but that's a really bad idea, and we should fix it instead
> > > of spreading the export.
> > >
> > > Setting memory decrypted is a dangerous operations and should only
> > > be available to core code.  We should have various allocators for
> > > decrypted code, but not export the functionality to random code.
> >
> > At the very least an EXPORT_SYMBOL_NS.
> >
> > Looks like there are about 3 modules using it already..
>
> So, I'm not really sure how to fix this now. Should we revert the patch
> making the system heap a module, or should we export the symbols for all
> archs?

Given that Christoph's objection is not really about the modules part,
but that the set_memory_{encrypted,decrypted} should not be used here,
one option is to revert 78b30c50a7ac until that issue is sorted out?

Jiri, any thoughts from you?
>
> Maxime

Best,
Sumit.
