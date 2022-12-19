Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6720863D4
	for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 17:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB39C433EF
	for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 17:03:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="iqHjA6Et"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1671469408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IefjMF7tOMH0wax39/RLpi+AIb8VNuSkBwczTr3jg6k=;
	b=iqHjA6EtH/BErKl8Q+ih/TwoWgTf6nmWjN0OWisAyKx05PwPJ+q8knOXAIYGaJ0HKBu90I
	c8CprBhVTmMpMsmYquNydFuNUy9UYKHoqIqkW9dqEXGM0dhddu7b5cz3RIwNZJhFgc8hkf
	lz+x7xq2SAuGaozwrxKNsbExyf9wLqI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 21d053de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <iommu@lists.linux.dev>;
	Mon, 19 Dec 2022 17:03:27 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id x25-20020a056830115900b00670932eff32so5702580otq.3
        for <iommu@lists.linux.dev>; Mon, 19 Dec 2022 09:03:27 -0800 (PST)
X-Gm-Message-State: ANoB5plGusrJcdNDfo+SZx9QDkyaefCUSVespBCfc5+JZnsfMLiNFbAt
	A5r7WLDjnms1dftjkUccNFdUHfB6FZS/kXKkZ7U=
X-Google-Smtp-Source: AA0mqf56hSUvnp6sOH/4lCw8h7C5hUdYBXkDOQf8YsHAL5a33e68otGl2Xumid7SYgRvw7HIbTyPONVAqZXy7J7ezBw=
X-Received: by 2002:a0d:c6c3:0:b0:3f8:5b0b:bbb8 with SMTP id
 i186-20020a0dc6c3000000b003f85b0bbbb8mr14883107ywd.79.1671469396034; Mon, 19
 Dec 2022 09:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221219153525.632521981@infradead.org> <20221219154118.889543494@infradead.org>
 <Y6CJsWBhcbKatZNg@zx2c4.com> <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net>
In-Reply-To: <Y6CYu4skFFMopU+g@hirez.programming.kicks-ass.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 19 Dec 2022 18:03:04 +0100
X-Gmail-Original-Message-ID: <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com>
Message-ID: <CAHmME9oCBgNCfYFxirA-fdarGip5MvOG-iUxT=2HC=iSXRMH-Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 01/12] crypto: Remove u128 usage
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, corbet@lwn.net, will@kernel.org, 
	boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com, 
	dennis@kernel.org, tj@kernel.org, cl@linux.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, Arnd Bergmann <arnd@arndb.de>, penberg@kernel.org, 
	rientjes@google.com, iamjoonsoo.kim@lge.com, 
	Andrew Morton <akpm@linux-foundation.org>, vbabka@suse.cz, roman.gushchin@linux.dev, 
	42.hyeyoo@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Dec 19, 2022 at 6:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Dec 19, 2022 at 04:56:33PM +0100, Jason A. Donenfeld wrote:
>
> > Why not just use `u128` from types.h in this file?
>
> Ordering, I can't very well introduce it in types.h while other
> definitions exist in the tree. So I first have to clean up the u128
> namespace.

Is there a patch at the end of the series that adds it back in to use u128?
