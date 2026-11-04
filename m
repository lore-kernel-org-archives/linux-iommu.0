Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815541;
	b=d+4sMghQ2yQtHCHN/lCH+fqtU7NbATF0/303SisJZRR4IP4e0rebFumVajpR3r+8LjcH
	 SQGqPiNJW0qRGQt+6RQ5LuvgpMaSvZoRUWDR0DLtqMWpNzFUje2qZQGLDcNAgWyNNXGrb
	 v+ptZTCKZhJ9v2kP7ZG3AH+9T83BHbKoOQY8yj/eX4DK3QUCX0nOrXC1LUxSykDVk/2bU
	 3RqwYCg9+Mszm60mbygmraBZNuTsdjxGuEHCUSnGIBnXX5n8303h1E0MlWQSSvARpgQNt
	 rK7GE2tDowkDfMWekYvG1mpuPISVeTsWCFumLYEpbHpdHvJEThxtEsm9nJppoACE+sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815541;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8t2Xff/1DSUKaDzEnQpPidhAwqFbrWLlVj0t+jNDN2Q=;
	b=juv8GfH5/T034mEUnxqorANeNlmbiNYFIC6keMtPZXczKBvC0zYkrMeUaxgPJ1MS4NZW
	 XeV+TLDL84JeeZz8ZBiHBqvhUp8T504FgOLdZ+bsXxenOJrTNNhAc/zFQII1Iw45wTq6g
	 A/RFe2me/YMPDKGraAr0iVERYRpQxbNWe4RE6yv5SB/vER/hOqhRmZmmasKZyPFV/tWNa
	 M6YZzTltK0wyeoufVSRZ+RGCjJjd9HFuH/vXTALMCWhe6BKBcAg4ShAB+rNGQugNqs4Xj
	 qoDW1pdQ3QGEikXkEY8N2qrfvNZLgt4SYLTHLyZUcoV2Pr6JVt8TfNTtHe8PyPPJ1PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nGaW00kZ;
	arc=none smtp.remote-ip=91.218.175.158
Received: from mta0.migadu.com (out-158.mta0.migadu.com [91.218.175.158])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA1A606A334
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 18:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EA1A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nGaW00kZ
X-Envelope-To: iommu@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=APEjYZTpAPwsLJnzLt2e35nbL7x74iTU9z6VBsbq6/4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793815537; v=1; x=1794420337;
 b=nGaW00kZ1kYe0iUwf1lyS2kx6eH+kH2DTylQy9zXAjKjIvKqZ3WUS6SVRm+WxIw5vd7N8CcV
 nDzxC3mHGakCh/xPgduGr/mbSPCDT6hdDzRpi12SUMgnAEKX6ClnUjJ4LJu19YbAOSnC9ZZjPLn
 8z6WPn0XNaKs0WF7ieOAPqnQ=
X-Envelope-To: iommu@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 6cce56c66b11413f;
	Wed, 04 Nov 2026 18:05:36 +0000
X-Mizu-Trace-ID: 6cce56c66b11413f
X-Migadu-Flow: FLOW_OUT
Message-ID: <327c462a-3360-45fa-8398-4c23c1f2bd84@linux.dev>
Date: Wed, 4 Nov 2026 10:05:27 -0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fix the x86 defconfig build with GCC 17
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Brian Gerst <brgerst@gmail.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Robin Murphy
 <robin.murphy@arm.com>, iommu@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, llvm@lists.linux.dev,
 Jakub Jelinek <jakub@redhat.com>
References: <20261104160722.1637541-1-vineet.gupta@linux.dev>
 <20261104162747.GAautdA2q2lw2gsth2@fat_crate.local>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261104162747.GAautdA2q2lw2gsth2@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+CC Jakub

On 11/4/26 8:27 AM, Borislav Petkov wrote:
> On Wed, Nov 04, 2026 at 08:07:17AM -0800, Vineet Gupta wrote:
>> Fix build warnings and failures (CONFIG_WERROR=y) with a GCC 17 build.
>> GCC 17 adds -Wconstant-logical-operand which is strict about operands
>> of && or || that fold to a constant other than 0 or 1.
> Just from looking at it, my initial reaction would be to disable that option.
>
> Because, frankly, I don't see the point.

Here's my 2 cents:

I wondered if this brings any codegen improvements, since we are telling 
the compiler that something is 0 or 1 vs. some other range before. And 
it doesn't, because of the way it is used. So focusing on just 1/4.

- Constant bit: __builtin_constant_p(bit) && MASK_BIT_SET(bit) folds at 
compile time to the same truth value, with or without the !! bool 
conversion.
- Variable bit: __builtin_constant_p(bit) is 0, so && short-circuits and 
the mask is never evaluated.

Basically, the masked value never reaches generated code, so compiler 
gets nothing new to work with.

So I did some digging, and turns out that it can be helpful to catch 
bugs in the source code itself. In fact GCC implemented the toggle at 
all, when Jakub spotted an issue with a typo: (data->flags && 
ff_genericize) vs. (data->flags & ff_genericize).

In kernel, the predicate like *_BIT_SET() not returning a bool is not 
clean IMO and it used to return 0/1 before anyway so its not like we are 
going out of the way here.

I'm mildly in the favor of keeping the warning, but ultimately your 
call, I can respin with it disabled.

Thx,
-Vineet
