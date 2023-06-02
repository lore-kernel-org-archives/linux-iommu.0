Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FA51C75A
	for <iommu@lists.linux.dev>; Fri,  2 Jun 2023 16:09:51 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4eed764a10cso2992304e87.0
        for <iommu@lists.linux.dev>; Fri, 02 Jun 2023 09:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1685722189; x=1688314189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeFT72TXfXAwhYRh1W0GvqbmonxTxhIBsAfBN2yDsw0=;
        b=RTvspkHEUsSuNPDqJToga/D9ksuhPWw2CQKitisED6WLmRQIOFQAE36LbEBLA3ru/5
         PJaVdbxblp/DhG5XSh/cIh4cCXLdK2RBCol4ghYD8ryW5np9H/RxNs7NiX1M+4siepQU
         9jFNTjB9dX6Udb1vS1HyTdFCulGwzv3BJcPkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685722189; x=1688314189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AeFT72TXfXAwhYRh1W0GvqbmonxTxhIBsAfBN2yDsw0=;
        b=C1M2Me/Vc7eMCTbtQJ15/NNinMMCnULn3H7qjkVb7cEaH+wpZXEN+nFfE3mQDYPn7i
         Uhuws7/IqomGMSLQvpM6Rm/MH4cxsFvUOhV5hHbZ5G423YbYnlq1gd0Y33B0aRUM/OO6
         mMyh/ky/dNfRz155MX4BNBkcy9c+VrG1PlFfn5gb92rY2S4imPt6bkh5/HOOXe1F/VpP
         1xeyT0HYa/MrhEIVJCbMSBiOUTMlqDZ+ubpFO4/EQH9jtODuO5+MJa8uAUKQf2qkrW9v
         cg+qd9DMj80DbkFZyt7tjxWc4LZvhe1w2S/o1L56Ly6dErs+HKEQJFxeFAXSdbX1OHUN
         c0hw==
X-Gm-Message-State: AC+VfDyYh/tK5T7AhUhxzv7rTSxA3Z/PZLtDxLllZ8/SJFWR2hi0k+fV
	8ZknbCAZRwceqaGqzQ0V995xqPhACHug2qSJrVtTMKhW
X-Google-Smtp-Source: ACHHUZ6NPJ6oBTGR7uzoXR41KhVKTbyRXSg7KsvGa2skqEHsE/tcBvixNn4dSkfu/5iM5wfqdncbsg==
X-Received: by 2002:a2e:8503:0:b0:2ac:80cd:6c0d with SMTP id j3-20020a2e8503000000b002ac80cd6c0dmr288399lji.19.1685722189441;
        Fri, 02 Jun 2023 09:09:49 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id r10-20020a2e80ca000000b002adb8c028dcsm267669ljg.75.2023.06.02.09.09.48
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:09:49 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so2975213e87.1
        for <iommu@lists.linux.dev>; Fri, 02 Jun 2023 09:09:48 -0700 (PDT)
X-Received: by 2002:ac2:5d6c:0:b0:4f2:509b:87ba with SMTP id
 h12-20020ac25d6c000000b004f2509b87bamr2034590lft.50.1685722168361; Fri, 02
 Jun 2023 09:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230531130833.635651916@infradead.org> <20230531132323.722039569@infradead.org>
 <70a69deb-7ad4-45b2-8e13-34955594a7ce@app.fastmail.com> <20230601101409.GS4253@hirez.programming.kicks-ass.net>
 <14c50e58-fecc-e96a-ee73-39ef4e4617c7@gmx.de> <CAHk-=whL65CLuy9D9gyO608acM5WLWo_ggAMP1cGu2XvyC0-hA@mail.gmail.com>
 <20230602143912.GI620383@hirez.programming.kicks-ass.net>
In-Reply-To: <20230602143912.GI620383@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Jun 2023 12:09:11 -0400
X-Gmail-Original-Message-ID: <CAHk-=wj7K3Q9WbBtQHiOXKc04SRjeOF+TRopkwVoQh_CFU+kvg@mail.gmail.com>
Message-ID: <CAHk-=wj7K3Q9WbBtQHiOXKc04SRjeOF+TRopkwVoQh_CFU+kvg@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] parisc/percpu: Work around the lack of __SIZEOF_INT128__
To: Peter Zijlstra <peterz@infradead.org>
Cc: Helge Deller <deller@gmx.de>, Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
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

On Fri, Jun 2, 2023 at 10:40=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Something like so then?

Ack. I think it would be much cleaner if we would have it as part of
the Kconfig file and architectures could just override some
GCC_MIN_VERSION value, but that's not the universe we currently have,
so your patch looks like the best thing to do.

              Linus
