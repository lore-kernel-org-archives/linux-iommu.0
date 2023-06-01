Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3BFBE8
	for <iommu@lists.linux.dev>; Thu,  1 Jun 2023 13:29:59 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-96fbc74fbf1so123136166b.1
        for <iommu@lists.linux.dev>; Thu, 01 Jun 2023 06:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685626198; x=1688218198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0MHDOHZ+ksADoGSH1YMQnsp1jrJ4XOCHJuXFHrOLiU=;
        b=Wzrl9TtntucSwzWDByRAkxjCnSV+EgfqMh48dfQmaPumGsHnc/KjkNxIYEpzsZtrbE
         yTrJXb2D2OePNeDxgtLVBfiFOXCU4B/mT/iF6wGooOHsqF5zv2l0crtZfAD71X5MyYEm
         k8oR/59towjRKyvjc/GD2+AYunFzYiKcaePnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685626198; x=1688218198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M0MHDOHZ+ksADoGSH1YMQnsp1jrJ4XOCHJuXFHrOLiU=;
        b=kJliNiQupcnPRrR8MOL3KqwG1B5rK3qvZKTod9QBUnTy1dVNAZiDY0eqD15nTMm2cG
         ZwDw4RQRTjDEjbod/yY6/mbl4iD93oL0h1C+pKsOur3IQ1vFByv3ha/OHmbp9L+O9TCY
         U8VYOaXNQdIcJ7W09FDrcb4yMoLCdTbrZRAGLQfNQNZ1Gm6OCcTSVy0NbDOGsRC+TOXk
         qP9Pl2E55nT8NjF8/TAJSa/d7RuPZRoYpzCSS1nV4nMALXWSdmVBKTKtD+aZPruGNRST
         HTEI10B1H1E6YoVVb6Aa+z26j8xxhDk4UvZxLabGNaR+7gT+XxhuaHSs/Np49nV59QcU
         7zOg==
X-Gm-Message-State: AC+VfDyZGmJsuUMKpJV2KkvKga4XOKiKGtQckYuWQqAgvWbPOW5SRwQV
	KjXxHFHQOt73wFk15wogSIpxLz1pCOj9En2zYU6Ev3Ix
X-Google-Smtp-Source: ACHHUZ6nuQfUeV+J4sCqUy365dagmySEDU50YnxF0HVnKNSg4DNgY1ZW4O9zDVOm/16zE4+R9O+VtA==
X-Received: by 2002:a17:906:9b93:b0:973:fa96:aff1 with SMTP id dd19-20020a1709069b9300b00973fa96aff1mr9109845ejc.35.1685626197929;
        Thu, 01 Jun 2023 06:29:57 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id ja20-20020a170907989400b0096f89c8a2f7sm10650274ejc.90.2023.06.01.06.29.56
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 06:29:57 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-30ae61354fbso790693f8f.3
        for <iommu@lists.linux.dev>; Thu, 01 Jun 2023 06:29:56 -0700 (PDT)
X-Received: by 2002:a17:907:2cc6:b0:973:fe5d:ef71 with SMTP id
 hg6-20020a1709072cc600b00973fe5def71mr4787778ejc.14.1685626175454; Thu, 01
 Jun 2023 06:29:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
In-Reply-To: <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Jun 2023 09:29:18 -0400
X-Gmail-Original-Message-ID: <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
Message-ID: <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To: Helge Deller <deller@gmx.de>, Masahiro Yamada <masahiroy@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com, 
	Alexander Gordeev <agordeev@linux.ibm.com>, borntraeger@linux.ibm.com, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>, suravee.suthikulpanit@amd.com, 
	Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, 
	Baolu Lu <baolu.lu@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S . Miller" <davem@davemloft.net>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-s390@vger.kernel.org, iommu@lists.linux.dev, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-crypto@vger.kernel.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, 
	John David Anglin <dave.anglin@bell.net>, Sam James <sam@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 1, 2023 at 6:32=E2=80=AFAM Helge Deller <deller@gmx.de> wrote:
>
> I don't think we need to care about gcc-10 on parisc.
> Debian and Gentoo are the only supported distributions, while Debian
> requires gcc-12 to build > 6.x kernels, and I assume Gentoo uses at least
> gcc-12 as well.
>
> So raising the gcc limit for parisc only (at least temporarily for now)
> should be fine and your workaround below wouldn't be necessary, right?

This absolutely sounds like the right option. Let's simplify the
problem space by just saying that parisc needs the newer compiler.

Right now we have that "minimum gcc version" in a somewhat annoying
place: it's in the ./scripts/min-tool-version.sh file as a shell
script.

I wonder if we could move the gcc minimum version check into the
Kconfig file instead, and make it easier to let architectures override
the minimum version.

I don't quite know how to do that sanely, though. I don't think we
have a sane way to error out at Kconfig time (except by forcing some
syntax error inside an 'if' statement or something horrendously hacky
like that).

Added Masahiro to the (already overlong) participants list.

                   Linus
