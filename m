Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0299156258
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026620; cv=none; b=aG/TujrFStfWBkvrocpG2+VDVpVGgAhr+JRIt5PHkFa8fO5q/64fpQx0eTOzuCYYjIyquq+4RCusI4NHW/WiW4i8mgri9e/wqeyxXIEjrPJjr9NQ1xRwUDd6JTvwUohnCCqxX6Ao7SWYCNMhGl1zr88649MDq2pgGYtVfnNCR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026620; c=relaxed/simple;
	bh=O4m3D6QJkpCyIotiPkNx41gI4the4mNBM6wP0C8Edm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEWIKIoZdJmuf6FvS2SyW0OB314678loPItqXcKjo5JAKirNzeg2e1yCFchiYsBjnC3HUnj1RH1AL4UTHbIbgzOkMoM+/Nsi2wLOdwHm/ObfTxCAFBSkjeEAI/HV7KzL7p+EGQMvsbbFVrK2FIvE21oJDmAlQFg0zN9sTOnC/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t5bWwGTJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t5bWwGTJ"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2809490276.1
        for <iommu@lists.linux.dev>; Mon, 06 May 2024 13:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715026618; x=1715631418; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fr3FvzBZJmUemTYZLBAlTUKyWusYtW7x1D9jX3o6JY=;
        b=t5bWwGTJ7j554MjxQAetwtjVBdRP2YqkawzFeIyXz+DJm0KA70QfHgB8Mqa5g6mcCT
         gMSAxHttriMHyVdfW3FNWrpCD0UPhamQl/qGhM1rKH5OS7vyYHk+xY2fDvfFrLrtPyvn
         0ooDHrNWEH/XjJ5MQBuyeLAhNBrGL6riW6wnXi7DtSgR9L99p1U/w1pdyK6KoV3DsOSk
         d0fsozoADySoEr6n62QJzi1gD5z2PW8XnEXEkUqUSdPxYR0ubAYYeaxLhMBvwIUAsNWN
         1CsfDgv7cbEEZ7kau0t9Aj24ye3vJnChXmcOZxyXHwgDg8Dkeh3dbqO6Srwepml3KDll
         6U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715026618; x=1715631418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fr3FvzBZJmUemTYZLBAlTUKyWusYtW7x1D9jX3o6JY=;
        b=v0SizOgFHofkATffBpZhMNeBvkims+UGozNtZpMgg3UUIIx4PHlW7Q0QaALSe6HZJS
         huqrO9jxcTyORVrFTas4eGAKGD93Hp3JTnQseGlW/C0wXo2q7OL4LrhN3Cqec74jl4e7
         ZTPHYxrv/K5ws4c7X4vDp/FENu1060crTOBEZpXWzHwkDcggVenLqE6G00q1o+lFh5Jx
         2nI85nN24GbP16ejJc7Mlxr7nC4DcHjJuAWcp1qhOmNWGCYS0bY59snfVR2CCFREfnAM
         kfJ4O/5K+o7e86Xar3IWj3Zet1/R7UCmxuejlo6eODHeA0JumUGzoj/1sEhNWyOIKrJj
         YdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp5EomZrIURu0FAs85SKe9Sf6ou1kat0nWiwLp/MhnFwkRyEu/1lbqbhXdfNolXQzTyiEo8a+8SDMFXsU+sRvstY72sEs=
X-Gm-Message-State: AOJu0YyOlMCvEtLOx48dDwCcZCWt2S+kq+bb8LXE6NgPNk7CXQfsICkC
	07gViVPjWIqOok/4l8xxo4JvhLeu/twEX7h9A/nUu7mLXwBMVribTdrcLmWX6r79W1x1mWO8hnI
	FAycF6uGYZPnUZ7l0kc58/WrE0ry1IXDq+fFu
X-Google-Smtp-Source: AGHT+IGtWotnhPG27Dr3QshUJCxX3ZQr+AKdbHMvm08l/sNlWD/7aGB+2kgrdBLLg3rPTCwuYNEVPaohe4FIFH8eSqw=
X-Received: by 2002:a5b:a0d:0:b0:de5:9f30:e40c with SMTP id
 k13-20020a5b0a0d000000b00de59f30e40cmr10782095ybq.4.1715026617408; Mon, 06
 May 2024 13:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240503183527.1548119-1-tjmercier@google.com>
 <20240504101651.7de5106f@meshulam.tesarici.cz> <CABdmKX06v23-w8PQJab8kgfPDRYLU3bQSQ4AsC3zrzxYL955gQ@mail.gmail.com>
 <SN6PR02MB4157EE83332FF789FA6BEEE8D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157EE83332FF789FA6BEEE8D41C2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 6 May 2024 13:16:45 -0700
Message-ID: <CABdmKX2q1rELreKG4oOrKCwKQk9Xswe=gV9254rkHzMNYaD3GQ@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: iommu/dma: Clarify swiotlb options apply only to dma-direct
To: Michael Kelley <mhklinux@outlook.com>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "hch@infradead.org" <hch@infradead.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"isaacmanjarres@google.com" <isaacmanjarres@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 12:58=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: T.J. Mercier <tjmercier@google.com> Sent: Monday, May 6, 2024 10:23=
 AM
> >
> > On Sat, May 4, 2024 at 1:16=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tes=
arici.cz> wrote:
> > >
> > > On Fri,  3 May 2024 18:35:26 +0000
> > > "T.J. Mercier" <tjmercier@google.com> wrote:
> > >
> > > > IOMMU implementations now sometimes bounce memory through SWIOTLB t=
o
> > > > achieve cacheline alignment [1], or prevent DMA attacks by untruste=
d
> > > > devices [2]. These uses of SWIOTLB differ conceptually from histori=
cal
> > > > use which was a solution to the problem of device addressing
> > > > limitations that prevent DMA to some portion of system memory
> > > > (typically beyond 4 GiB). IOMMUs also solve the problem of device
> > > > addressing limitations and therefore eliminate the need for SWIOTLB=
 for
> > > > that purpose. However as mentioned, IOMMUs can use SWIOTLB for othe=
r
> > > > purposes.
> > > >
> > > > The swiotlb kernel command line parameter does not impact IOMMU rel=
ated
> > > > use of SWIOTLB, and that is intentional. IOMMUs cannot be forced to=
 use
> > > > SWIOTLB for all buffers. Update the documentation for the swiotlb
> > > > parameter to clarify that SWIOTLB use can only be forced in scenari=
os
> > > > where an IOMMU is not involved.
> > > >
> > > > [1] https://lore.kernel.org/all/20230612153201.554742-16-catalin.ma=
rinas@arm.com/
> > > > [2] https://lore.kernel.org/all/20190906061452.30791-1-baolu.lu@lin=
ux.intel.com/
> > > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > > ---
> > > >  Documentation/admin-guide/kernel-parameters.txt | 1 +
> > > >  Documentation/arch/x86/x86_64/boot-options.rst  | 2 +-
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Docu=
mentation/admin-guide/kernel-parameters.txt
> > > > index 213d0719e2b7..84c582ac246c 100644
> > > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > > @@ -6486,6 +6486,7 @@
> > > >                                to a power of 2.
> > > >                       force -- force using of bounce buffers even i=
f they
> > > >                                wouldn't be automatically used by th=
e kernel
> > > > +                              where a hardware IOMMU is not involv=
ed
> > > >                       noforce -- Never use bounce buffers (for debu=
gging)
> > > >
> > > >       switches=3D       [HW,M68k,EARLY]
> > >
> > > Yes, this part is correct. SWIOTLB cannot be forced if there is an IO=
MMU.
> > >
> > > > diff --git a/Documentation/arch/x86/x86_64/boot-options.rst b/Docum=
entation/arch/x86/x86_64/boot-options.rst
> > > > index 137432d34109..066b4bc81583 100644
> > > > --- a/Documentation/arch/x86/x86_64/boot-options.rst
> > > > +++ b/Documentation/arch/x86/x86_64/boot-options.rst
> > > > @@ -285,7 +285,7 @@ iommu options only relevant to the AMD GART har=
dware IOMMU:
> > > >        Always panic when IOMMU overflows.
> > > >
> > > >  iommu options only relevant to the software bounce buffering (SWIO=
TLB) IOMMU
> > > > -implementation:
> > > > +implementation where a hardware IOMMU is not involved:
> > > >
> > > >      swiotlb=3D<slots>[,force,noforce]
> > > >        <slots>
> > >
> > > But this part needs some improvement. The "swiotlb" option is not
> > > entirely ignored if there is a hardware IOMMU. For example, the size =
of
> > > the SWIOTLB can be adjusted using "swiotlb=3D<slots>", and since SWIO=
TLB
> > > can be used by IOMMUs for other purposes (as you correctly note in th=
e
> > > commit message), this setting is relevant even where a hardware IOMMU
> > > is involved.
> > >
> > > Petr T
> >
> > Thanks. I think I should also update the commit message:
> > "The swiotlb=3Dforce kernel command line parameter does not impact IOMM=
U
> > related use of SWIOTLB"
> > and title:
> > "Clarify swiotlb=3Dforce option applies only to dma-direct"
> >
> > As for fixing boot-options.txt, I think it makes the most sense to
> > expand on just the force option rather than the section summary like
> > above:
> >        force
> >          Force all IO through the software TLB.
> > +        Hardware IOMMU implementations can use SWIOTLB bounce bufferin=
g in
> > +        some circumstances, but they cannot be forced to always use th=
em, so
> > +        this option only has an effect when no hardware IOMMU is invol=
ved.
> >        noforce
>
> Note also that the documentation for swiotlb=3D in boot-options.rst is so=
mewhat
> out-of-date.  It doesn't have the optional second integer parameter to sp=
ecify
> the number of "areas" that have their own lock.  Perhaps that could be fi=
xed
> at the same time?
>
> Michael

Thanks, I could add this as a second patch.

I also noticed that several of the iommu options (soft, allowed,
nofullflush, panic) are not listed in the set of possible options at
the top of the IOMMU section. Rebooting is the only other section that
does that, so I'm wondering if we're better off getting rid of it to
be like other sections.
