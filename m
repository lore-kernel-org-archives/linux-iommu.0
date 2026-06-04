Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCB358D00
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558364; cv=pass; b=NGtAyhpGdxl1rIrmhaiidLz+HMm8Ps26nm/wU8yz4U5OmriJCLAJ8hr8bYmJYWPWZavITFvyfOmXRvNu+vvjjHWMfwZ8gEVoNKorhLCkbVClUdO0Zf32KpPu5kbJBmjLP8NzYCwQz9BgF89jlHqMGgn1PqWLvGjiyhzGA6PEWsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558364; c=relaxed/simple;
	bh=S3yZUPmgM96a8eLarLrzfMcx4Pi7ZeX29Z2UxIQ+heQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK349dpZBWqSPhexQPYZLLouMNZlMYcj1gbHipvpbpbIeBQu7t6I8rafWu8NvQ0YoLbDWZrYz8u5LdCyrvnf0o3SaWobhuYHSUPLFwm3vDF8+96lhgZxa4PG7udT8xMYxxmK2A/S3TURT2AUKPTKK0JUEou1iTgY8N58KI2GBCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OrYkigHP; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrYkigHP"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bf1cdcfd6deso35949866b.3
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 00:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780558361; cv=none;
        d=google.com; s=arc-20240605;
        b=AMXmDVk7gN3EwJI3Vrv0KxlOYsgiyUw0ydRH4qlt2Uf2sU3Gq5RFcupq423ZF3fkpL
         vMqKZzPYElnmwpF0OsuiY0aSjIqUFDQwMTdl6U34J3s0AZvQtEjyVrh+pR8Vq+jSzJzW
         G9xgzwNN50Lz/IZBVKPwDKnq5lTpkZCj/BEj9XVIwHT24A6MNMjsdsasbi/xqGcYbFyq
         yvGUTwhlwcgoKaumDu8MYJWJ9839ALtIEghREH9UiTH4mEltXG6oRWs8CWEh8RKuKOn9
         C3iA33ZKwcDB+rfMUFUyxxR378lRQLgLBjvnCMjU+VPtCHHxbM6JlJTqZkhRddhMr0xv
         VwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        fh=CPGWTJyQqZP24qqhkLhNCy4zKkmquoUoGh4UukESPyQ=;
        b=IjHFmGYqQHTGnqDaVuGlq20nmiwpXSEzyLanCke0TATfo5BLEvoNcmEFqyoseV+k92
         Gpirp+vntchteFe8yHM+DoVQLOOu7XDtvvFw0936hOwsGIkfWQ3Q2NTFgPJeacBXnjs+
         fWhSn2YWKIRSMMk1wjHMP4xFbi4kQ0aoAD5YmpvlPrw4KysNhEKFIzZ0AXFs/zBrPFxm
         PDpn2xAS643OFVTBQBKu6t+Nl89C/wnld7LIL42a30GuvifmTtXKBM/gGZDy3usuv9Bn
         o/ZGMtA/AieRWL8bdMzRIWhI2Usn5QW889ltUppNHD8JAQIser7+xPrRecIiKtWQ5hzO
         bMiw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780558361; x=1781163161; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        b=OrYkigHP1z4Q9To2Zo4kRBYFiTD+lnwlqmGniPbzdPxr+CBGDUWWCGFJMVw9s0xUiO
         KPzoX+u/P3Q9X/OuB9EbSA/+GSnQLjNj+aY2aR9IKFfpR/U7LzxL/JEm55fKOhtyNioe
         DaZIwmuBfY9MoOZja4wF6CqE0YrnC5duVyRF6CIvX2S/9ZV70qD8sHKl0ciqKzeINqVI
         oYfylLp8XFRyx1Tdz9Ljlj6eyzYhRBBqKkU22jYhLLq5h2MJqgni6Qvu6Xw8+54B/Qfs
         5pyHOJMyC84L24UnXa/9YzYF74H9nlNGTYu3U3nzH53TibvInOlZhvXowiuy6FA1vR3T
         3dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780558361; x=1781163161;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QeCUKmkVy2NrZVi3REONjZfBBnfnlNmwwM3gXjDs+A=;
        b=gZISQOSpjokJBWf2pHZ3RWJiPLgA1lV2X77R9+P5wPPz0e6YkQE/pu/rKtsq+v+yom
         CV/XCD93ceEqVKcfv9DL8esxGoJ12cpjAKNNXMWAj91407ClsBtbUM5WHKg/7+N10nYG
         Ho7Qo9GQ3BY3xBuZ/ysH35e5aFunQrpN8nr6WzmXCfak5+ZPaw0smT0tz9vXancLxyGr
         znzoKk9BR3dZOjYrL4zZzB7jhRW8tL+eHn2JAF0fr9fNxbe5TcShcNyzBg5oQQ6X4lAh
         2LSca6o1T1bdDUAE95oqxdYbN0fxhMH+p3Bu0Yu/F9aCaewjPmk4CmxnqMcGvxTinN2O
         aJiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+uoIJriNKaXdVaz/SwyD4GHXNQnQDJnskt16s4ltpuzJUiT5d9VzN6Rpc1+O/Di0JCGynbRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBEBlPD3WMBK9peZ6/umPfTEDJEX1AfAXfxAEMZ+JbtsjRzmSf
	m0Ee5ZOJ6HVWnB1MXWitvwRRArgJpGRkz6xAU4VO7TGSkawOvug8X/iHhzyUNylNbJ7zLyvOCDk
	p9+tlPiHz752/XfAba9JKZ5mChuhmxkxWUr2S87XYJQ==
X-Gm-Gg: Acq92OGGBsNl93WDvVE0wT5xxm163lAs4kwrux7T65Qm68l0rFXD/AwGowOrIj5oG9i
	m9UO11K7XRJBv4/ZSJQg9nBrY1GGZLP4CmqK2stk8IAL1qppg51syck8bkUVGjU6lVRfygz06Nz
	2rn42M427d3h8iOfOjhbDdmqUkC2+TD9sR18CjZR7IfXIzk0WLUwLxK6oWfJG6XmNhK2WV7BTM6
	kqLX5u3klOXA7fOuCbjdqzPDIoOI4L/nlhqenfjP5+ANnrQRw0xZBcw1rech9O2kY77zo5GVHRk
	Tx3dfsC1mBlRO+9y/e/vVOhl7uwIS32bOgtX4j1n0nSpeBM=
X-Received: by 2002:a17:907:8e0e:b0:bea:4c91:fe88 with SMTP id
 a640c23a62f3a-bf0ad204057mr309239166b.18.1780558360935; Thu, 04 Jun 2026
 00:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260522225853.878411-1-tjmercier@google.com> <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca> <20260604-dangerous-tuatara-of-sympathy-28e05e@houat>
 <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
In-Reply-To: <CAO_48GEJsg4X7++zg-ztQgVibY_FjjManaA5_W3usjicGUQPdg@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Thu, 4 Jun 2026 13:02:28 +0530
X-Gm-Features: AVHnY4Iu3YbvJ8smZ2k5Oglofp60PZLnbqbe_g3OJ5J_F-575g430amKBK4ebP4
Message-ID: <CAO_48GGCdU6znkdHW5gns=s+N0wtNAq4U8s4OtLEyW6Y73oMUA@mail.gmail.com>
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

On Thu, 4 Jun 2026 at 12:51, Sumit Semwal <sumit.semwal@linaro.org> wrote:
>
> Hi All,
>
> On Thu, 4 Jun 2026 at 11:04, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > > On Sun, May 24, 2026 at 11:21:33PM -0700, Christoph Hellwig wrote:
> > > > On Fri, May 22, 2026 at 03:58:53PM -0700, T.J. Mercier wrote:
> > > > > After commit fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a
> > > > > module") the system dma-buf heaps can be built as a module. The
> > > > > system_cc_shared heap uses set_memory_encrypted and set_memory_decrypted
> > > > > but those functions are not exported on powerpc. This can result in a
> > > > > build error like:
> > > >
> > > > I'd much rather revert the above commit.  Yes, x86 has exported these
> > > > since 2017, but that's a really bad idea, and we should fix it instead
> > > > of spreading the export.
> > > >
> > > > Setting memory decrypted is a dangerous operations and should only
> > > > be available to core code.  We should have various allocators for
> > > > decrypted code, but not export the functionality to random code.
> > >
> > > At the very least an EXPORT_SYMBOL_NS.
> > >
> > > Looks like there are about 3 modules using it already..
> >
> > So, I'm not really sure how to fix this now. Should we revert the patch
> > making the system heap a module, or should we export the symbols for all
> > archs?
>
> Given that Christoph's objection is not really about the modules part,
> but that the set_memory_{encrypted,decrypted} should not be used here,
> one option is to revert 78b30c50a7ac until that issue is sorted out?
>
> Jiri, any thoughts from you?

Argh, I'm sorry I missed that some modules are already using it. I apologise!

Christoph, is there a way we could accept the symbols export for other
archs if the arch maintainers are ok? Heiko seemed ok for S390, so
this needs agreement for powerpc.
> >
> > Maxime
>
> Best,
> Sumit.

Best,
Sumit
