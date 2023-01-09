Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B535233
	for <iommu@lists.linux.dev>; Mon,  9 Jan 2023 22:03:01 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id z4-20020a17090a170400b00226d331390cso11268440pjd.5
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 14:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k0nIhdmoq2YN+8CYmcGGz5g09uBL17k5HRqIgJjfUJU=;
        b=F4QSW1fmPta1SdZoMgqppkBUl/S595vxphelnA2n0Z8L7+V9JICv9+FhFq2SezihUL
         AZzzhDrgCA39Hc/bNA+TttzJcb5t9eNeDk24AJ2XPx+BNVsLNoozshq0sopE0CVIK+mb
         mldZC1Aw99FFSuOlyX98h9PUcGiDBvSvEDfSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0nIhdmoq2YN+8CYmcGGz5g09uBL17k5HRqIgJjfUJU=;
        b=wqxX31ONJIq8uncyI7FEe/xfb/lirxx56ggzeFQZqBC7YWxLCUSYTWymm2a0gSQoW9
         FHddqRAyYLbNECZM/1Psg9QUbad6sxanzH46alfgqEnu6FY2PqskoeADHhgkApeSZCed
         kzEJ5kWrFOeuVaE98ubHRJ4aN/DkxMAzKklRtofd3ERIA+qK0w8XFH5SyP/zLFIDBMDe
         f/hSbhmUH25lfcigCgYiGc8fzZtK5m8bqBn21FeQF8K3cldVLFYWrQ7nHPAWHuddG+KR
         PGuz6zZVLtDCgD4ZrYjgMfpdjIvzTDd/01zksorja3ManfMcW4Y+/GjrALbofmQRGIFY
         lLBQ==
X-Gm-Message-State: AFqh2kpKFKFRqvd+Q4HThV1Iz+jDDfrx3YLNwKwg1rbQ13EficGmh1dd
	FsK9hoKM0KtACPU/tKXvP89wWYb5O9H8kEwEfuY=
X-Google-Smtp-Source: AMrXdXsuR53tJt59kc5g8ENK97Qs9rog+6GQ8DtTNcWkyNgB8SohmXbpat+733w8P/Vtd1d5L30X3g==
X-Received: by 2002:a17:903:1c3:b0:192:903f:7ac9 with SMTP id e3-20020a17090301c300b00192903f7ac9mr72490590plh.42.1673301781145;
        Mon, 09 Jan 2023 14:03:01 -0800 (PST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com. [209.85.216.44])
        by smtp.gmail.com with ESMTPSA id jg7-20020a17090326c700b0019324fbec59sm4292589plb.41.2023.01.09.14.03.00
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 14:03:00 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso9529274pjl.2
        for <iommu@lists.linux.dev>; Mon, 09 Jan 2023 14:03:00 -0800 (PST)
X-Received: by 2002:ad4:4150:0:b0:531:7593:f551 with SMTP id
 z16-20020ad44150000000b005317593f551mr1338900qvp.89.1673301769392; Mon, 09
 Jan 2023 14:02:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154119.550996611@infradead.org>
 <Y7Ri+Uij1GFkI/LB@osiris> <CAHk-=wj9nK825MyHXu7zkegc7Va+ZxcperdOtRMZBCLHqGrr=g@mail.gmail.com>
 <Y7xAsELYo4srs/z/@hirez.programming.kicks-ass.net>
In-Reply-To: <Y7xAsELYo4srs/z/@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Jan 2023 16:02:33 -0600
X-Gmail-Original-Message-ID: <CAHk-=whm+u8YoUaE9PKugYBxujhDL5twz6HqzqLP8OTXjKuT4g@mail.gmail.com>
Message-ID: <CAHk-=whm+u8YoUaE9PKugYBxujhDL5twz6HqzqLP8OTXjKuT4g@mail.gmail.com>
Subject: Re: [RFC][PATCH 11/12] slub: Replace cmpxchg_double()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, corbet@lwn.net, will@kernel.org, 
	boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org, rientjes@google.com, 
	iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz, 
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-crypto@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 9, 2023 at 10:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I ran into a ton of casting trouble when compiling kernel/fork.c which
> uses this_cpu_cmpxchg() on a pointer type and the compiler hates casting
> pointers to an integer that is not the exact same size.

Ahh. Yeah - not because that code needs or wants the 128-bit case, but
because the macro expands to all sizes in a switch statement, so the
compiler sees all the cases even if only one is then statically
picked.

So the silly casts are for all the cases that never matter.

Annoying.

I wonder if the "this_cpu_cmpxchg()" macro could be made to use
_Generic() to pick out the pointer case first, and then only use
'sizeof()' for the integer types, so that we don't have this kind of
"every architecture needs to deal with the nasty situation" code.

Ok, it's not actually the this_cpu_cmpxchg() macro, it's
__pcpu_size_call_return() and friends, but whatever.

Another alternative is to try to avoid casting to "u64" as long as
humanly possible, and use only "typeof((*ptr))" everywhere. Then when
the type actually *is* 128-bit, it all works out fine, because it
won't be a pointer. That's the approach the uaccess macros tend to
take, and then they hit the reverse issue on clang, where using the
"byte register" constraints would cause warnings for non-byte
accesses, and we had to do

                unsigned char x_u8__;
                __get_user_asm(x_u8__, ptr, "b", "=q", label);
                (x) = x_u8__;

because using '(x)' directly would then warn when 'x' wasn't a
char-sized thing - even if that asm case never actually was _used_ for
that case, since it was all inside a "switch (sizeof) case 1:"
statement.

            Linus
