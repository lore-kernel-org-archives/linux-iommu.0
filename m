Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522E199E80
	for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739177670; cv=none; b=RgH3g5y1cPqtZ3LkEdx8be0vl64YRZjPLqL4nkmbyDwG1/bD/RnefUZIxBJcaGZI1OS7RUXknHgkuhsAg6zSRD06jGjodt050OrcmQW4g7BelPJIdjUBelzblv12qoWZQJM69rL7mvJLqbA3f5Pnp8HAiwdDN6hVA4QFnkirdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739177670; c=relaxed/simple;
	bh=FqHLXPTE5JOaOFlcnuZckn2lMpa/iaI6OVBprZozpEg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=NXNaP3yqV97m0dXVbsnkLeuBSD9QI37NgmrTXbDKVWz6/nPbwtMSabiFmZ7wZWs/6+B8ofjLd3C3AAhxzJgL+iEJ6r9mxoAqFfiSVn5v+3aV1TigpOgXDRZHYaBuXeDEimBfhpkEwG0UNwe74KQGtJbxBxyl4m5cXpHWQlt0aRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaaYDFAP; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaaYDFAP"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f6022c2c3so31449475ad.0
        for <iommu@lists.linux.dev>; Mon, 10 Feb 2025 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739177668; x=1739782468; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZY9QxeB6byfsjoTiXPkYkQd3pShX29qM3n0pKB8504=;
        b=eaaYDFAPik02CM8ptJa99uaTkB+6BqWf4vXnu53M3R2X9a2BASzhhyjMMmCtwZ+h9A
         TwZvWxmD18fIsFycAiAKUEb07YmvSyBlJAxkCPI/0tiAvxyGeLjU1kAb/jdLDJ3Ggc/U
         7WKut9hI7/uAoc2RgyFXv2HGqqX8nAhu/M60MzNrhWEGP5GuTjvfvob2RZ5qRnou3mvk
         gDfsWJWQ6XTpsuRhwA8rc+p3uisnVCwxpTkRyb1mcSdgfHdrx/P9CgpranJOXZqOz/wX
         eArogYFA5o064e9F0ZVGxy8ZpzaTj22mRcXGOqLHr8Zm7x1aNOiWWmhoaytzEhAr5cpl
         Q1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739177668; x=1739782468;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZY9QxeB6byfsjoTiXPkYkQd3pShX29qM3n0pKB8504=;
        b=WHLDLXbaIR5nzpuwOOd+88vrZNA8p+WiwETWRWY8X4nqS27irUEjiGGy6iMQXfEz7J
         8n723TDeEZpCs36gtes8q9y5KZDPDD57jlI5ysSeN5teXVcBn6QLFKTDiBh1eyKUp3nm
         YUyCDmP7zYfmrFsZWbwX6vX9Ewhb2V1lzePlgDb8zsbRVCjKKHq/21/DP07teEJ4byXA
         4u+foPoLfrgM6gkvjAnuy05q4U9Khfj4d0WysXxoxZb2gduN53dE734gYNNSqHcNQWC7
         xsmZ1n8odSCEFTpM12B7hflnuX7jv/U0YyYW3mQvDL2wRiOxTR4GbrPyvz9uAMxEkT2O
         bcuw==
X-Forwarded-Encrypted: i=1; AJvYcCWYIyIW4dftnXDJwqTa57lSLK/CQXI8hTCUD0MZjP/bQqwdEvj1HGVIJyavJfLsb27ftV+TLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEit5O4IkSy4PrEbf6uNXiOw+t1BzNULV2h5U11DcHo1JZt8hG
	edgUNmhunAI0yEUnEx463KTYuvZdP+4AnIWCB0KyQ8bfasLrbtmY
X-Gm-Gg: ASbGnctOO5k9Axdl/R5G3VAx8VIRppwPIuWE1pcfJ5bNldshbomGk2iKB1NqGhH0Hfh
	Le7atjlLLixphQPOtB4x/IHXVsyTY7hOnWyDeI7sroz+3QnT1HCj96M1GuYdhenHtt0rzt1gbzM
	cl+gDYJJbR6iJLFmUxUix69GC3WlS5UgD/+xdazh+xkDDF0QgXqUPvqHgW5NxXITan0vbGVIieH
	2K0CsXn0KBBctTUqqlD5TTenBOw6NMRib4sCVA3Bbcj7y1xKZMOAc6jMehwrRrUpM/hYsc+EpSa
	YQYS2V44/SOxNhS/PmsUzTZKNpIpy8MV5NMIlzNmi/ib6Ds9nkh3ieewqWSX4gf5HWwL
X-Google-Smtp-Source: AGHT+IH4LYd2U2+mMJVrI0jt3gQ3wCg7Wf0JB/MAap/REkLBk8gqHUE92qCKJFDkTSqCyfB6NZEhKw==
X-Received: by 2002:a05:6a00:909c:b0:725:4915:c0f with SMTP id d2e1a72fcca58-7305e504eaemr20232809b3a.11.1739177668469;
        Mon, 10 Feb 2025 00:54:28 -0800 (PST)
Received: from ?IPV6:2601:645:8a01:f00:4c38:12c7:b11:98bc? ([2601:645:8a01:f00:4c38:12c7:b11:98bc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-730673cfe05sm5080781b3a.62.2025.02.10.00.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Feb 2025 00:54:27 -0800 (PST)
Message-ID: <b968d31a-b63b-4d2e-be6a-030e323aa7e0@gmail.com>
Date: Mon, 10 Feb 2025 00:54:25 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: abdiel.janulgue@gmail.com
Cc: a.hindborg@kernel.org, airlied@redhat.com, alex.gaynor@gmail.com,
 aliceryhl@google.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, dakr@kernel.org, daniel.almeida@collabora.com,
 gary@garyguo.net, hch@lst.de, iommu@lists.linux.dev, kernel@valentinobst.de,
 linux-kernel@vger.kernel.org, m.szyprowski@samsung.com, ojeda@kernel.org,
 robin.murphy@arm.com, rust-for-linux@vger.kernel.org, tmgross@umich.edu
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
Subject: Re: [PATCH v8 0/2] Add dma coherent allocator abstraction
Content-Language: en-US
From: Pyrex <economicsbat@gmail.com>
In-Reply-To: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm nervy about the Rust code here.

- read()'s comment says it takes a snapshot, but it doesn't

- read()'s name implies it does a read, but it doesn't. It returns a 
live, dangerous view

- into_parts()'s comment claims to decrement the refcount. One, it 
doesn't. Two, it probably shouldn't, if it's supposed to transfer ownership.

- write() shouldn't take an immutable receiver without unsafe

- write() is unsound if used with the slice from read()

- the mutation in write() breaks read() without contradicting its 
`Safety` requirements

- write() memcpys T, which isn't explicitly Copy

This doesn't have to be this unsafe. AsBytes + FromBytes implies Copy 
(or at least it _should_) -- so the view could be of Cell.

