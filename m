Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE081859
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 14:31:49 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id b189so11884545vsc.10
        for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 06:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T/NCsYKC04yFcK1fgm0juUVbSixz96HJYgI6+8cFKck=;
        b=aW5RhtAsBkNvIR682pacJYjMBchjsl6CBpgm1GNt+MoU0xR7oZIbXklJVEhSA5imlQ
         5u50ol+9QlNXecXRFfrW9BlWpiEgwr54V46RQJ7vPMFVZN8nUM7UL5cjfEyDNsEd6TlT
         I+s90R9sBzg5F4fXqzDg5UVxzzA1ZnYyjdfck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/NCsYKC04yFcK1fgm0juUVbSixz96HJYgI6+8cFKck=;
        b=g2rnmLRbbIg791yA7Xn3cdBM1/jXP9oEbbRWBc1Iyl3YZlXssdTIp4aV4N2uGWkky0
         rVHqg97ccBnYnVZ15etMR/EGZd2jghgNj9np03SWRLM272ssLXS//PZ4WfgSqkyQA64c
         z7SJzn2/A/ps4Q5H8kmjN5OlN0y2mzEj6ZkeiTe/ZMw5/rgsifTqqXibeCWg/6XSMGDg
         zW4JMm+4IsGKCOvmBgFUOHMjccHyCGHV52pNfVfxHbbEqbcZB9mKAXVkbovbWnsPQUcU
         eTMThYvf5dG3DO/KVyMdh67xLKMMRT+HJYd7hLws0Z0xXYtWl64vgSgE1D8JXV69aF2n
         zNpg==
X-Gm-Message-State: ANoB5pnfde49FK/7vU+bt2K9+P8Ea/DvUkApHOqA1CJnh3h0OqjJGEmE
	Zh0b/GV9Qg4evkNHIvpqnjqLKQ4n5xtKokpI
X-Google-Smtp-Source: AA0mqf7VYicO0wUdbfo8GrAwaxGuOdDNAAWSDxSuLVdMvNBFwBJgwZF6867uRWJbB8mbYJMPY1JWgQ==
X-Received: by 2002:a67:24c2:0:b0:3a9:f6f5:7967 with SMTP id k185-20020a6724c2000000b003a9f6f57967mr23243505vsk.35.1671546708623;
        Tue, 20 Dec 2022 06:31:48 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id z26-20020ac8711a000000b003a816011d51sm7639696qto.38.2022.12.20.06.31.46
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:31:47 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id c9so5331847qko.6
        for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 06:31:46 -0800 (PST)
X-Received: by 2002:ac8:4988:0:b0:3a7:ef7b:6aa5 with SMTP id
 f8-20020ac84988000000b003a7ef7b6aa5mr8424356qtq.436.1671546695878; Tue, 20
 Dec 2022 06:31:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154119.154045458@infradead.org>
 <Y6DEfQXymYVgL3oJ@boqun-archlinux> <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
In-Reply-To: <Y6GXoO4qmH9OIZ5Q@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Dec 2022 08:31:19 -0600
X-Gmail-Original-Message-ID: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
Message-ID: <CAHk-=wi493ukLwziiqofe=WCSfUU8Qa+LK0mp_GrGWKV3NnTpQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 05/12] arch: Introduce arch_{,try_}_cmpxchg128{,_local}()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, corbet@lwn.net, will@kernel.org, 
	mark.rutland@arm.com, catalin.marinas@arm.com, dennis@kernel.org, 
	tj@kernel.org, cl@linux.com, hca@linux.ibm.com, gor@linux.ibm.com, 
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

On Tue, Dec 20, 2022 at 5:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 19, 2022 at 12:07:25PM -0800, Boqun Feng wrote:
> >
> > I wonder whether we should use "(*(u128 *)ptr)" instead of "(*(unsigned
> > long *) ptr)"? Because compilers may think only 64bit value pointed by
> > "ptr" gets modified, and they are allowed to do "useful" optimization.
>
> In this I've copied the existing cmpxchg_double() code; I'll have to let
> the arch folks speak here, I've no clue.

It does sound like the right thing to do. I doubt it ends up making a
difference in practice, but yes, the asm doesn't have a memory
clobber, so the input/output types should be the right ones for the
compiler to not possibly do something odd and cache the part that it
doesn't see as being accessed.

              Linus
