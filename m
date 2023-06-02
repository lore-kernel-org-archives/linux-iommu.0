Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFC91E53C
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 20:03:31 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-97458c97333so222351666b.2
        for <iommu@lists.linux.dev>; Fri, 02 Jun 2023 13:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685736210; x=1688328210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pqo3OfJjzReA0YZCNQePZ3Xh5QPxALpix/U4edhgSI=;
        b=BFs9XRn8pkTDlPwuLP/tR1iFv3fxWkVWV5lFayNIIqcNdmHsSK8W3jspKe+crDVjiT
         MU6CRIuAjpFeMMFJebIQHLL4BSwzaiav9ZCPgaPNJVtrngevyE3mm5lGUESoTs3hw2FZ
         cilalJGJDbV4z5Lno4zo9bgl2OcgZZ9hl3BNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685736210; x=1688328210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pqo3OfJjzReA0YZCNQePZ3Xh5QPxALpix/U4edhgSI=;
        b=FF00axjOj/vx/HxUoLqR82+KO1kP3wZdi3uLnDchmHBxu0n/i7vR/WbOcV0d2+JyUl
         tZ6jE5Opefbh+p4rJYPIV7SafmTgDiLQAnQB/j8tDhOtYMdr9zBaqL0riDdCN0cSXQxf
         uaDA5MgJshDf3yx05VzzyaRLXKy2ao0xei4ULynzK2OGNDuF08JWeYVg3vJ61r0WgX3j
         P9faJTtu5M1Wa2NciYwxYFK3KBDw8ASH4gn0IywJ0TEa1diYPDAJGZ1tg/WYC8VayJKY
         kHvKo9yKWD5q7ghdc+dlM99JrYYI2GI2DYx9h+2ZpYVQ9yL8qf6bATR2aAaSPthAovTy
         BcNw==
X-Gm-Message-State: AC+VfDzwdGNbyGJY9zNHtlDT5ja4wbz5/kbG6mZXAiLd+7jbxCWdBzms
	CMNAuAMAin4OzND3Gwv57UnpAFIrFppgU0MZdREc8xJ6
X-Google-Smtp-Source: ACHHUZ5hGNywyW8TXFDQL1pVxYw7LDmUL7Kdnjq5UZBMV/g8n2Fw6frMp6Yg1SKbcGdzWTMIxAr2qQ==
X-Received: by 2002:a17:907:320b:b0:973:c070:1b5f with SMTP id xg11-20020a170907320b00b00973c0701b5fmr137886ejb.44.1685736209798;
        Fri, 02 Jun 2023 13:03:29 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id cb2-20020a170906a44200b0097457363fc0sm1132264ejb.33.2023.06.02.13.03.29
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 13:03:29 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-974f4897d87so114158166b.0
        for <iommu@lists.linux.dev>; Fri, 02 Jun 2023 13:03:29 -0700 (PDT)
X-Received: by 2002:a05:6402:b10:b0:514:9b60:ea65 with SMTP id
 bm16-20020a0564020b1000b005149b60ea65mr2665357edb.16.1685735862382; Fri, 02
 Jun 2023 12:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
 <20230602143912.GI620383@hirez.programming.kicks-ass.net> <E333E35E-5F9C-441C-B75A-082F19D37978@zytor.com>
 <20230602191014.GA695361@hirez.programming.kicks-ass.net> <B432FCD8-2ED7-42B1-BC3B-34F277A1CD9F@zytor.com>
 <20230602194021.GB695361@hirez.programming.kicks-ass.net>
In-Reply-To: <20230602194021.GB695361@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Jun 2023 15:57:25 -0400
X-Gmail-Original-Message-ID: <CAHk-=wi4q=_+vQkOM0LRY7SfsH+D1-9DOSBABAzXrZwWxmJR+g@mail.gmail.com>
Message-ID: <CAHk-=wi4q=_+vQkOM0LRY7SfsH+D1-9DOSBABAzXrZwWxmJR+g@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>, Masahiro Yamada <masahiroy@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, dennis@kernel.org, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Heiko Carstens <hca@linux.ibm.com>, gor@linux.ibm.com, 
	Alexander Gordeev <agordeev@linux.ibm.com>, borntraeger@linux.ibm.com, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Joerg Roedel <joro@8bytes.org>, suravee.suthikulpanit@amd.com, 
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

On Fri, Jun 2, 2023 at 3:40=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> "With 64bit builds depending on __SIZEOF_INT128__ to detect the
> presence of __int128 raise the parisc minimum compiler version to
> gcc-11.0.0."
>
> better?

I'd just say "64-bit targets need the __int128 type, which for pa-risc
means raising the minimum gcc version to 11".

The __SIZEOF_INT128__ part isn't the important part. That's just the sympto=
m.

               Linus
