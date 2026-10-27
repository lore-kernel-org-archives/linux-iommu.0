Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793071595;
	b=N68ZBgopajxnzsuhlsyJhNbMiA4D8E+eM8uls7v6Wpuj1d1QiBfjk26Yk4pFIifcw0Y/
	 0+KKgbK7QbvsJT5NxRWDyABhudCCK/iw1rT7XXDmZBnpta3WRESU69hwqNJa8pohkhMiX
	 iOSRIGVUdkb7drmMdjLtVDwhNZJssx3YOpbppXDZjlsF8HCdUiH44mcrYXj+nvW/EXI15
	 r2zf3JAVIw059Zzdi75rTotyqJlQ15uSzOhN5lM54HIepBwGPnh8eBh53YCKpdjnBJiS6
	 2NRF2/Hp5LeLb2Ne7z8b2JNMj+tKAVUNWyDuOhz9SqRsTP6zuO6DBbxEQ03IQ2aPEWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793071595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=;
	b=Ehpf0zLn/xPnqJ7hYFYag+Hk64bOEQsrmi0Ku2lOaAASYx/VUvhUqQMX5RaR+ZkQMena
	 GuVyW2o8ujbDvFbHdR0knGv5ykhlGkuyj0a8ii5v1TASAcriJoxEpXba+3EkRJAjAxavS
	 tONm+rHwms8wQxH0KcCgZ2ruo/AR+RHwqsjt4dBzu311mhHbOXe6x8qO5L1eYz38xuLfd
	 b/AvTDNR7E2lJWpi2PffhNTSIN5POsLqJ6qlr6YEeBK4KQrdJO2WdWE7jW54/pAA01zqU
	 bNWHwMrLpGtLLy7MEemrs9wyAjrERBtS4Fjf2DJui/PP90MqQ7acNkRa48tduOkJ85A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U+Gv9oLq;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DA7606A31A
	for <iommu@lists.linux.dev>; Tue, 27 Oct 2026 03:26:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1DA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=U+Gv9oLq
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9eb579c0eso20722375ad.3
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 20:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793071594; x=1793676394; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=;
        b=U+Gv9oLqFlnXs4AnAkURpZ71LCXNIU/wDGo9lUA0jvWqKb7i9BQoaCQQ/UdWGUE7CT
         ddEQ+GbcsvF1YdmsXCT+DxaXWJjtQ9fuxSsP35bKNy867K5docJCDJWtdSijVDI4c2Kw
         pn7N/2cNR5l5u705o2ZENW2dwabt0VRp7Zf4TGEbFWIr8NCv/mXktuFiCciSW79Unir7
         lF33l63HwtsFDgSMCh/sfClD8PV2GOYPQ2dAsHO7GAyNO2WwIceHKX9F8W/ARVQKjSCY
         m0NvOma9lFcZJfmtwRxFBtbyX89kpciSKnWBwPozre90fSMZXYjLA3vPKT1r9Y2eOg6/
         +LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793071594; x=1793676394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mFFfrqlGcCKVNylEOU7fJD0/AGoCZ65FALqe+xT5SYA=;
        b=KFrQyAwhlX3i+QzhRTwldRrS494XqFAUDXc3fR+fn9yevw8ZtT84R/vnN1vXFuNBsS
         IJQb95zSwhsRae3bGtYwYkhL66yT2JsEEA3f2fnAihhu+PQzodbfLWL1AwjgiK4sEAO4
         HfMVK8tYNRdFdz6Tb4IJp8wsGH4tHS788W5mDOFh1ql09xFn8JW74GbF28Vk1DL2+Ir2
         EgIfoUETT/kMeDKyEpuqLUj3L8mt+rcViFCvNN2DLT71lDLgXoHdGK8BFOdx6N0T/rEi
         ZuiMyDZbRbiXO8Sa+d8QPIU4JheDzoj+KKS2asJIGx9Or74BQhPngX3YNHFFFDVLFJet
         Ycrg==
X-Forwarded-Encrypted: i=1; AKwUvByT7KwZ4LVLLi9G62GF8MZUt2eLq/btmHEnEYxbsYMYAT28nvRuusQ7tZHSsY4KRHcPfMbqiw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ4+2j5ZVrCRzgfAf9sk5UEyrNvf7VEVvsibnOTupvuIiQNowAo
	CuSNf2WnH5t7p8kT9X8gJw4xkIy8HT1WxC4jav+MjPdQuU2dUMyp93Yp4xRLaxOdfw==
X-Gm-Gg: AYBFou2KEj/mNiJlW7Zoh+0mWNHJ8c3YBGebRbsyhhvcbU/KRgEXqEkGXM9YPRffrcv
	9bmiy7kJD0u9mm3rgqj6cNzMFPk8cK//RuCG5Jzq6EXEv+ia1531gVPYxmbqteEgA2LrQNQLaQt
	lCHr/O8pAmeZyvWS5slJ29f4Uj46hj7w/s49h5XQ5Pu+99X1IQrLTxi16CHxvcgPEyxQphy4m8s
	pJtNSDsqhJlHETZ9XPgoFl5RZPpcL5ZHZ2vxCponAqXxIpQDahH7QsVVzLImgeRtYLotjiVDjkU
	sJPKvMua1um8xa4IyctTokl3UzyqnoUGN14AlQcfL3PatiCBaIFFHt94VcwzhJjPZqIJmAmESAN
	lXCG0Cc2xs9R4G10ZqM+pR3Fv4Qu1KJrjgfJcmTtPB8E1LZe6OSwb9ZtZttHeF779HEmZTz4t2n
	tFTURheSijBNkUQWvzbmcmISIR6giBf7zzpoK3KE4xWTcvvzzImjC5ytTAGqLaRxavIRXm2lAoG
	Ca3QYpwtw91yZ0RYKey2p0mH8ht2ch6b4sRAcxh8p8yv21779yCU5xFGSFpVVsJECwxXHU2Er1h
	dGV/ER69eJJTBzsKaBxiy6Byp/8kEiHa//ONla60qpj8RvGi5qby0WydXm4dBDHFvtV+m2c=
X-Received: by 2002:a17:902:d548:b0:2df:ad58:cf54 with SMTP id d9443c01a7336-2ea9c81ab95mr64373815ad.34.1793071593614;
        Mon, 26 Oct 2026 20:26:33 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6ce0f45sm2398915ad.70.2026.10.26.20.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 20:26:32 -0700 (PDT)
Date: Tue, 27 Oct 2026 03:26:29 +0000
From: David Matlack <dmatlack@google.com>
To: Tarun Sahu <tarunsahu@google.com>
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
Message-ID: <auAZ5agR1xBo3RLN@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
 <at_CncIPYCxOVkLo@google.com>
 <9huzecdcghxu.fsf@tarunix.c.googlers.com>
 <at_pxoULR1Tp5anN@google.com>
 <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALe+6DxTR0BpvW7mXMjq_+dczT2jO=R_qLbHhSduhnuSPcXhzQ@mail.gmail.com>

On 2026-10-27 01:55 AM, Tarun Sahu wrote:
> On Tue, Oct 27, 2026 at 1:01 AM David Matlack <dmatlack@google.com> wrote:

> > Right, whether a feature is required is a static property of the
> > feature.  That's exactly why it's redundant to send it in every header.
> 
> I meant the different thing.I was saying if a Feature in a kernel will have
> constant value either required or optional which is fixed at compile time.
> But the same feature can have different values in two different kernels.

Those would just be 2 separate features. One optional feature, and one
required feature. They might use the same fields in the struct, that is
fine.

> Maybe a seal added in kernel version M. Later in kernel  version N this seal is
> deprecated and replaced by a new seal.

I think this example works fine. The old seal is still a required
feature. The kernel just stops marking it present and marks the new seal
present instead. Retiring a feature doesn't change whether it is
required, only whether the source sets it.

The only thing this split doesn't allow is changing the whether a
feature is required or optional after it has been introduced. But for
that case we just introduce a new feature of the desired type.

> > I think you misunderstood the proposal. I'm not proposing to pack only
> > the set bits, and I'm not proposing that each feature have a bit in both
> > ranges.
> >
> > In my proposal, there is no such thing as "feature N", there is
> > "required feature N" and "optional feature N".  Required feature N can
> > be found at bit position flags[N]. Optional feature N can be found at
> > flags[nr_required + N].
> >
> > In more detail:
> >
> >  - Each feature is defined as either required or optional, once, when
> >    the feature is added. That choice is permanent.
> >
> >  - Each feature gets exactly one bit, in its range, and that bit is
> >    always at the same position whether or not it is set. Required
> >    feature N is bit N. Optional feature N is bit nr_required + N.
> >
> >  - nr_required and nr_optional are the number of features of each kind
> >    the source kernel knows about, not the number of bits set. They tell
> >    the target where the optional range starts and how long flags[] is.
> >
> >  - A set bit means the feature is present in this file's payload. A clear
> >    bit means it is absent.
> 
> So For #NR number of features, We will end up using 2*NR bits which
> is exactly same number of bits, V3 [2] uses. So this is just a different
> way of encoding in implementation perspective.

No, it's NR bits. I think this is the core misunderstanding.

Let's say you have 3 features. 2 are optional. 1 is required. That gets
encoded in 3 bits:

  nr_required = 1
  nr_optional = 2
  flags[0] = Required-Feature-0
  flags[1] = Optional-Feature-0
  flags[2] = Optional-Feature-1

> >  - There is no invalid or reserved encoding to define. Each bit just
> >    means "present".
> 
> What if a buggy source sets both required and optional for a feature?
> That is an invalid case here. Same as 0b10 is an invalid value set by
> buggy kernel.

That cannot happen. A feature is either required or optional. If you
have a "logical feature" that is sometimes optional and sometimes
required then you would have 2 feature bits for that in flags[]. But
that should be an unusual case.

> >  - The target doesn't need a supported table. Required features are only
> >    ever appended, so it rejects any required bit at or beyond its own
> >    MEMFD_LUO_NR_REQUIRED. Optional bits need no validation; the target
> >    just checks the ones it knows about.
> >
> 
> As I explained above, incase a feature is replaced by another feature,
> new kernel
> can support it deserialization but it will not be required from there on. So
> The supported table will still be needed.

The one case where a count isn't enough is if a newer kernel drops
support for an old required feature entirely (e.g. removes the code
that translates the old seal). That can be handled with an explicit
check in the handler, or we can keep a supported bitmap. Either way, that
question is independent of how the header encodes required vs.
optional.

Certainly in the immediate-term we can just use a count.
