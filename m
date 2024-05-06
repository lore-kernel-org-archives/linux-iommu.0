Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9DA157487
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715016185; cv=none; b=nrZNoJ09VdOpLZpMDKlmbFT2ZXI0ada8/z9OUcnyOWP+pG9tED1y72jYuyQxjvKG6Bwr+j/7jupPEtCg+tnR4vryr5mAmz+1Ymu7hSBdWg63cQNl+Fp+QgHDz2PpQxbZHtO3j88Lm/QFJcqAw/0g/wsPSScnhFuik+jWoGNEVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715016185; c=relaxed/simple;
	bh=WZrKW9lX4tg3tPxy5c0NpUNmhHAib2hOo3+Fq/V8re4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7o2n2lrvR9VpUnpD1RlGVMX3xeEf+F8qHBe0kXV8H41+AuB08bXEQUU2Wc1GRLNPsoi4p+7kCXiJpza1Mo7VlWbaMvXEFAybeIqcN0WXOsS/LT4dNwweXfV1dVdRzT7BIl2i/PIpUp4fVJRhwNiAG6TWZ/M8P0rBaldSyWXOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4PKrK/s; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4PKrK/s"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de604ca3cfcso2153991276.3
        for <iommu@lists.linux.dev>; Mon, 06 May 2024 10:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715016182; x=1715620982; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCrwSzubKtvsGNfMW8E9OfepfV+lPFMQFEMiDBoSQgk=;
        b=X4PKrK/s2kcxzk1WGj23yqj5P0hE8ssGPUuLqKyA3NTLSDwiCOjnpy9wncorrl62s8
         5sT9lYck7TxzcQ/FRWNLKapA9mUm7wZPeuFnOv4FT1Ih41LpPWzgpF/myXC/4XRxAzHn
         MrH0A7JjLD/PkSwg6f6ChAL5/cmpwuvo6Gc6ap1/d/XlbLTiySi2Iqvz5pFJg7YcDnRA
         5vLhqjCAdMBUIfFvWyI62Sn7ooCR9/r9kylJg9CbxI4n64amuecGAZzncswTl3txYRU6
         L6XE6+N4HwipBOT3sW3LZAZbVRmkaWfggjzOrDQqzeEW5oCmYoZD6zCGdyIqnZcxt6VS
         Kn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715016182; x=1715620982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCrwSzubKtvsGNfMW8E9OfepfV+lPFMQFEMiDBoSQgk=;
        b=KAq4eAb02G7nKGXJB8181Jq6Kt4VJr1wAdJg2QYjp1Xpqv9/SP4jCYbuobrrTFnZJI
         6gEL0KUkoy/+raen4lSfPrtJHg3feVLNWxlOfRXOen5x/oinA91V4tuegTRer4NReilE
         U87lnvpzGORCOhQ5FJzA2faIAcZzOuG/fQC9NGhcTgrcnloOoEyl1QgO3lvsNAyqPavW
         XU53jIbMUh9KNp1yuMXQfomdE8IAj7spKpfi9gxBj8lYfTizmHkwI0H1DjJA8EtNUz+e
         BQaRB8ByZnTxDJ9o2AsaKSiMPI8rZrcn/Lc2SsDCF1/ELYgWScyKezZZ480hH1NAWnwV
         IR4g==
X-Forwarded-Encrypted: i=1; AJvYcCWqWf6WDyECPzmkBZ90xYPx17qSb3EaXaQQHCqRzKaLb0QS1o4Fipw17gnVd2TP18P6SlbTB6/WgPsHgZ/DXX0XMhH7nws=
X-Gm-Message-State: AOJu0YyULcWDjlQUwtSkuOjRYwrNUkH0bFfY+LymUTIuHF5QDBTDln+b
	Tmgr4aKyECjzNOvpChjsx/I/6uT2qQyzfaDXUelWFI3/JHo8mBth+tpgGa/nweQQCZIb3N9LLuU
	3g7wIfXqQgXi9DYtWrfRmPaB82/rMpbF4Y19Z
X-Google-Smtp-Source: AGHT+IFF+xrCiZxZzYs8KepraXuOLw4ukSfLThnPpCCYdtURoAqdQvuK/9ekO9RvFnQzQ2yuIw0Z6Hw7T7hUsdyFDBA=
X-Received: by 2002:a05:6902:2747:b0:dc7:465d:c06d with SMTP id
 ea7-20020a056902274700b00dc7465dc06dmr12341901ybb.28.1715016182087; Mon, 06
 May 2024 10:23:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240503183527.1548119-1-tjmercier@google.com> <20240504101651.7de5106f@meshulam.tesarici.cz>
In-Reply-To: <20240504101651.7de5106f@meshulam.tesarici.cz>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 10:22:50 -0700
Message-ID: <CABdmKX06v23-w8PQJab8kgfPDRYLU3bQSQ4AsC3zrzxYL955gQ@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: iommu/dma: Clarify swiotlb options apply only to dma-direct
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, hch@infradead.org, robin.murphy@arm.com, joro@8bytes.org, 
	will@kernel.org, akpm@linux-foundation.org, isaacmanjarres@google.com, 
	iommu@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 1:16=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
>
> On Fri,  3 May 2024 18:35:26 +0000
> "T.J. Mercier" <tjmercier@google.com> wrote:
>
> > IOMMU implementations now sometimes bounce memory through SWIOTLB to
> > achieve cacheline alignment [1], or prevent DMA attacks by untrusted
> > devices [2]. These uses of SWIOTLB differ conceptually from historical
> > use which was a solution to the problem of device addressing
> > limitations that prevent DMA to some portion of system memory
> > (typically beyond 4 GiB). IOMMUs also solve the problem of device
> > addressing limitations and therefore eliminate the need for SWIOTLB for
> > that purpose. However as mentioned, IOMMUs can use SWIOTLB for other
> > purposes.
> >
> > The swiotlb kernel command line parameter does not impact IOMMU related
> > use of SWIOTLB, and that is intentional. IOMMUs cannot be forced to use
> > SWIOTLB for all buffers. Update the documentation for the swiotlb
> > parameter to clarify that SWIOTLB use can only be forced in scenarios
> > where an IOMMU is not involved.
> >
> > [1] https://lore.kernel.org/all/20230612153201.554742-16-catalin.marina=
s@arm.com
> > [2] https://lore.kernel.org/all/20190906061452.30791-1-baolu.lu@linux.i=
ntel.com/
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 1 +
> >  Documentation/arch/x86/x86_64/boot-options.rst  | 2 +-
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 213d0719e2b7..84c582ac246c 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -6486,6 +6486,7 @@
> >                                to a power of 2.
> >                       force -- force using of bounce buffers even if th=
ey
> >                                wouldn't be automatically used by the ke=
rnel
> > +                              where a hardware IOMMU is not involved
> >                       noforce -- Never use bounce buffers (for debuggin=
g)
> >
> >       switches=3D       [HW,M68k,EARLY]
>
> Yes, this part is correct. SWIOTLB cannot be forced if there is an IOMMU.
>
> > diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Documenta=
tion/arch/x86/x86_64/boot-options.rst
> > index 137432d34109..066b4bc81583 100644
> > --- a/Documentation/arch/x86/x86_64/boot-options.rst
> > +++ b/Documentation/arch/x86/x86_64/boot-options.rst
> > @@ -285,7 +285,7 @@ iommu options only relevant to the AMD GART hardwar=
e IOMMU:
> >        Always panic when IOMMU overflows.
> >
> >  iommu options only relevant to the software bounce buffering (SWIOTLB)=
 IOMMU
> > -implementation:
> > +implementation where a hardware IOMMU is not involved:
> >
> >      swiotlb=3D<slots>[,force,noforce]
> >        <slots>
>
> But this part needs some improvement. The "swiotlb" option is not
> entirely ignored if there is a hardware IOMMU. For example, the size of
> the SWIOTLB can be adjusted using "swiotlb=3D<slots>", and since SWIOTLB
> can be used by IOMMUs for other purposes (as you correctly note in the
> commit message), this setting is relevant even where a hardware IOMMU
> is involved.
>
> Petr T

Thanks. I think I should also update the commit message:
"The swiotlb=3Dforce kernel command line parameter does not impact IOMMU
related use of SWIOTLB"
and title:
"Clarify swiotlb=3Dforce option applies only to dma-direct"

As for fixing boot-options.txt, I think it makes the most sense to
expand on just the force option rather than the section summary like
above:
       force
         Force all IO through the software TLB.
+        Hardware IOMMU implementations can use SWIOTLB bounce buffering in
+        some circumstances, but they cannot be forced to always use them, =
so
+        this option only has an effect when no hardware IOMMU is involved.
       noforce
