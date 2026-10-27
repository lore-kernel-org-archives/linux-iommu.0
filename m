Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059276;
	b=5ovPZdfYQJv1aFXdH08/zyRvsXB7cRGT0q2XXiTwMKZkmal8/j+Ks+wRmWxKVDy9ZDWp
	 eyuiqgl/9fQ4/HPFWuXbbDiuvLxk8Rl+xP1e5GZ2HGyj2KUS6vZBMhpWDoqgHnjaodaqh
	 41eVoSlNLy5U7ok2qkP00vEI2lFJyj2Utbf1STSs6PsIwPxarAkHwvsjWdyKdEdAl0SEO
	 ZqXOt70rDzTD2druymiQz6H/u9me4Wxvu5vibHHB99nuvH1L5ALCd5fVRQ++YVLP73I8V
	 1vX9e1I5o585hRwK72oU774zFwDE4J12hDjbY27c9BR0AIW17lU7UuQG4ZWxT8kW6Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ixKouDoUlCLHB71PytJx4w1v0AUAxSqI48/quFxSDg4=;
	b=UNUVbQtIY/Th9LwkMuRezz9cqkmvzrX1DQ3AYOjlKmjCGLSplj+y+mI7d+Wqm2rNJ6EZ
	 ZNkiC0Hlxum0n1TrcSPY1vVmbv1Yvgkz+aizwvDVTG2s25N5RcgKQZVYnAQUJU6/9gaoT
	 XcsQZruzGawmXp/5MfCRlOYkyKY4DsrDox0WqrQNeS03kJq1kaKK1fFn/Zfjnatrx5XiQ
	 L20fH4KvGE7EnkqYg4xa+0MMvTvqUstgP3CIKaPYI5+ekMoUAMhXqFzRhfK7rGoLg//L2
	 jdLhRuApHUQUZ6nNafmsG2C42TBxIq7YlnTS8sQRT67z6yCYdTNxOffWQKFsJTyi4jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TD86hzHi;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361CE606A320
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 00:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 361CE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TD86hzHi
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398b3c37877so2047355a91.0
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793059275; x=1793664075; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ixKouDoUlCLHB71PytJx4w1v0AUAxSqI48/quFxSDg4=;
        b=TD86hzHiuoHCiDOTwIz1yYQefLujwfdvwJ7C2GtaAp7kZrq4Vu1dKmKR0EhMCRl0wS
         pEYaHdjKOOi5mV29jPm1gtCVi9D+Ix/1sCLW3O0EWKui9eGmYq85PoGCi8CMd7Ng+Ukw
         bZjCkoV4/Tt6bI5mOFeAg57X0X8TFFLiWWh6X6DBBV+ExKatBUaHO3ywYWqXcGmp8fFd
         9szV0Ue1QQMQVa3RS2vZ7OncuZl5SxSfc0sVKJ89+1eKT1k8irnWJ7YVhLNtuKgQpPKH
         AMjiTHqrG6Z9vgnO8z3wqAiCqyCHvDgDNJeiH5xMJ5Er3tMKWkklVLFgT3ix5U0R3zVB
         l5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793059275; x=1793664075;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixKouDoUlCLHB71PytJx4w1v0AUAxSqI48/quFxSDg4=;
        b=u9Ttst7Ju6eFc+/+8K+HRZjOxZSGducthGb3n1z2NhzIFkfLhvJUm+yDO4Jg5bgXgt
         81H2HuP5CmRyr5zad5xk7Hmj37sYN2aGOkvsi1BRpTM44Cyg3lREg5GJIJIz7PPMM9fe
         jQf7SkCKT9wQZeEVqu8/Bm6xTnsqE7OkWie/j4qdZtQCdpXAvZsvjhs9Why3ptbHEGxU
         0uCXoBrLFfkURzOpjOhDHqIxtbgmyPxndFvkdOdmNXfg1AMKd8DP97+0xZVtVUDPqDCV
         JB98agJpXxjvtRWCvi81dVRJ46fsg6WRm91dxXkWqAfxDgebmmyYzzTGGcFUXW4GEn4P
         kivQ==
X-Forwarded-Encrypted: i=1; AKwUvBzeK8WxvgtUYwqnyLx9QuVP8zaW6LF4ZjW/ZK65VIm95ucytzGjUBcO2+oSrlmHrS4ZbbMQkw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLsli/zPTpEUnaumcSNeNNAM3r8WSYz9ps891DWwPFo8QPq5HSf
	npOBQHXqvRzDg4wD+nhPFECCUwyc3ZqsOvTMkU2tFnxuvh+jjeE+IWWmPniILmAQCA==
X-Gm-Gg: AYBFou3KqckiMd0Z2H7/pv5t7Ur8FX1rp2S9r6XTmD8/tx4LKUw2POB3uYLb3kUzB6A
	SBW57cwo9UdpFHmlGtQpQ1a2MZxYd/2djMKEvuVO7xpS/V5j2viQxLYJ58qKqO1IH7A8o9d2PSK
	gXpvN0fKCLInwHt+MrdanK8HArgoU0o6W2H2wowvlaT5bGjuncdUeTiKRT6hSRKyWH6vbMDr2j8
	qtrP1BwaXhnJSPI9u98pL8Xe/yp89Y7Dm+W8tKA4yQQzqaSaxgjTOhgzT7dNtOl94zIEgK28Uqa
	/WaRz90bPTjwhQULLPt0FhZSWFelQHGjmuN0qOQK5BRu1c5r4SxRmA2Mex85dTwI4bh6afpst9C
	2WnGtVpVkaYFjJemSqWePOYSQZfRXPQOzck/7CKUmDrY/KFHqmDi6WYlQWAOfFKXwM92aS5gW69
	M0PGKJdij+RYj3dXLulJp9qXTjhfRiFTrsFiGAyL9xPeq3CQzKJ6aqHB5Rv8OaGJQ4qXZfgzDnz
	aEm0vzAuEOR5P9o6nhfScEynWxAUCNpbSv4amBshfhM+fstJTMpSak2rxsVJOJoUnhVpQVyWxV8
	gdRDvPRHoQMrEPO2UHb88tV/DCMIE4E9JqMYaegmj5oKBGKQHvoTB3BXxdEEmU5dJGd8AYc=
X-Received: by 2002:a17:90b:528c:b0:3a0:e4ce:31fd with SMTP id 98e67ed59e1d1-3adead444ecmr7102022a91.10.1793059274755;
        Mon, 26 Oct 2026 17:01:14 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066cf2dsm1119900a91.16.2026.10.26.17.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 17:01:14 -0700 (PDT)
Date: Tue, 27 Oct 2026 00:01:10 +0000
From: David Matlack <dmatlack@google.com>
To: tarunsahu@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <at_pxoULR1Tp5anN@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
 <at_CncIPYCxOVkLo@google.com>
 <9huzecdcghxu.fsf@tarunix.c.googlers.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9huzecdcghxu.fsf@tarunix.c.googlers.com>

On 2026-10-26 11:28 PM, tarunsahu@google.com wrote:
> David Matlack <dmatlack@google.com> writes:

> > But looking at this again, I think the required bit is redundant. Whether
> > a feature can be safely ignored is a property of the feature itself, not
> > of any particular file. Every file that has a feature present will have
> > the same required bit for it. The only thing that actually varies per
> > file is whether the feature is present.
> 
> The required bit is subsystem property not the per-file. e.g. memfd_luo,
> it is set at compile time for a kernel. So every file will get that required
> bit set. It is not per file property.
> 
> struct u8 memfd_luo_feature_state {
>        [MEMFD_LUO_CORE_FEATURE] = LUO_FEATURE_REQUIRED
> }

Right, whether a feature is required is a static property of the
feature.  That's exactly why it's redundant to send it in every header.

> > The required bit still has to be conveyed to the target somehow, since
> > the kernel that needs it is the one that doesn't know about the feature.
> > But it can be conveyed by the feature's number rather than an extra bit:
> > split the flag space into required features and optional features, and
> > assign each feature to one of them when it is defined. This is similar
> > to the required_flags and optional_flags approach in struct pci_ser [1].
> >
> > Keeping the same header shape as discussed with Pasha:
> >
> > struct kho_ser_hdr {
> >     __u32 size;           /* Size of header + payload in bytes */
> >     __u16 nr_required;    /* Number of required feature bits */
> >     __u16 nr_optional;    /* Number of optional feature bits */
> >     __u64 flags[];        /* Required bits, followed by optional bits */
> > };
> >
> > Required feature N is bit N of flags[], and optional feature N is bit
> > nr_required + N (using nr_required from the incoming header). The length
> > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> > are numbered contiguously, so there are no gaps, and up to 64 features
> > still fit in a 16-byte header.
> >
> > Each bit just means the feature is present, so the truth table becomes:
> >
> > Source bit       Target supports  Action
> > ---------------  ---------------  ------------------------------
> > Not set          -                Accept: feature absent
> > Optional set     No               Accept: ignore the feature data
> > Optional set     Yes              Accept: use the feature data
> > Required set     No               Reject: -EOPNOTSUPP
> > Required set     Yes              Accept: use the feature data
> >
> > There is no invalid encoding left to check.
> 
> 
> IIUC, I believe this will not work.
> 
> To Communicate between source and target, We are defining a protocol, A
> protocol which will be standard for all the kernel. And each bit location in
> flags must have the same meaning in both the source and target kernel.
> 
> Now in you approach, If Source kernel send feature N to target kernel,
> target kernel must understand Nth bit as the same feature. Even though
> the bit position in your approach is not fixed but they are fixed
> relative to their starting point.

I think you misunderstood the proposal. I'm not proposing to pack only
the set bits, and I'm not proposing that each feature have a bit in both
ranges.

In my proposal, there is no such thing as "feature N", there is
"required feature N" and "optional feature N".  Required feature N can
be found at bit position flags[N]. Optional feature N can be found at
flags[nr_required + N].

In more detail:

 - Each feature is defined as either required or optional, once, when
   the feature is added. That choice is permanent.

 - Each feature gets exactly one bit, in its range, and that bit is
   always at the same position whether or not it is set. Required
   feature N is bit N. Optional feature N is bit nr_required + N.

 - nr_required and nr_optional are the number of features of each kind
   the source kernel knows about, not the number of bits set. They tell
   the target where the optional range starts and how long flags[] is.

 - A set bit means the feature is present in this file's payload. A clear
   bit means it is absent.

 - There is no invalid or reserved encoding to define. Each bit just
   means "present".

 - The target doesn't need a supported table. Required features are only
   ever appended, so it rejects any required bit at or beyond its own
   MEMFD_LUO_NR_REQUIRED. Optional bits need no validation; the target
   just checks the ones it knows about.

> For the current appraoch and V3 [2]. Think the below one as msb is
> required bit and lsb is feature present in payload bit.
> 
> 00  FEATURE_ABSENT / DEPRECATED
> 01  FEATURE_OPTIONAL
> 11  FEATURE_REQUIRED
> 10  IS INVALID (analogy: required set but feature is not present) which can
> have different meaning in future if in future, a need arises to reuse this
> field.

In v3, 0b10 is reserved and not checked by the target. That means an
older kernel will silently accept it, so the only meaning it could ever
safely take on is "safe to ignore", which is what 0b01 already means.
A reserved encoding is only useful if older kernels reject it, and at
that point it's no different from adding a new required feature.

> Deserialization can happen per feature from right to left. without
> jumping back and forth.
> 
> Because of all these reasons, I believe current approach presented in
> V3 [2] is the better. It is close to your PCI series with two flags
> field for required and optional except I combined both field into one
> flags. In your above approach you do have two counts but not having gaps
> (which is wrong) and the way you proposed to parse with an offset is different.
