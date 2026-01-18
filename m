Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045C1A9F93
	for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755510; cv=none; b=RO3+ovLro5MUVHwJ42C7C2hQ13RnT1cCbXLtuRsPsHvR9sguJE1r2mKjfQY5uhU3xbcbz/os6EwDu3Baj015NBd8w9mqfgGJj8zoFZWG5XMjDBWfM2UTJsdc9TQ72dgAMB9v2UE6jhp0T9A81hDcqGP7vTGj4tfoecgIlGjLjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755510; c=relaxed/simple;
	bh=0zgzcjV2i1ItPBygPoRVnUl5OQb076Xxb+6J+rVvyEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMqIsPb+LOcAUTv8UBjD6c4t877Xbz/sRaumAhNb5G1swEVgSi5gmAy/6qelRBavWXlWW/ySvfMMzlbBB3M+eoL8bevoReedikrzGecDXlJLJG2z/vOzv5E1dkz/nfZEFxgCNstboGpz6afRSsv0X6RQfB+gqVrs+CyL+LhYU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=zL2iubP8; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="zL2iubP8"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfd6f321b5so2114920a34.2
        for <iommu@lists.linux.dev>; Sun, 18 Jan 2026 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768755507; x=1769360307; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv4mJ1WA5PkVw1gpZVpA4eWj7mOEd86WM3sQnHXBrw8=;
        b=zL2iubP899RsSIRpRMvXEnIxvMO8xZAoTjXYWX7nqh1YuOIJ2KMLjsMzk0Si0+DBhK
         sO+TP27F1p93IJ3vMTeByjf6Fm5RAaCt0LJFMntbZ4dFqtQYmX73iAY6mu0eBvrgm5iz
         RJikGP7ll+BgxMOYQnw7RtwSbvcFezuCik+h6povyWrMnxtNZoZEwEJ31sI8XE16LpwI
         +gCCvwiO8JfRZdEID+QCwwWvzFNUKgTZNKcYw/oUXYJ/9wVGm8iZg859quDZ2WBPtHf/
         M7mwWTFZU6XLAPJMNrmdxnIsnyYVVlgPNx3v/8VDWXaGzSTU8oT0XVbiSUAMglb+BhAO
         oFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768755507; x=1769360307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bv4mJ1WA5PkVw1gpZVpA4eWj7mOEd86WM3sQnHXBrw8=;
        b=qlcDXURIqvUerp1QTTnyDfEfp0oD35S/3zjfWC0WaeON9sGg6RSfDxqq0yeVuePcOV
         j3O8BGPfUn6dAV3zW9FQx574Tp9QwPPBP8PEbOOgI5zHny6o8ez72ejRx9s3H7VLhxyC
         ZCR+TEgTF26umSR1FKckuhqWO226sURQYq8D9+y5aCp4vA3b+TKbzxe0HZBAHYCuN+Zp
         h/03NjGr6V4t802jJqK/kDhyPWjsuD5Z2gCLLd3KQX3/D07g3Uvh/1mySWDUHC0y2JEh
         VvpLuJQX1cIO3eWZns7Ou+u19RipLraIBGVGuYpXPGhkTqageKg/1rdzTPVSySOKf5/x
         FrCg==
X-Forwarded-Encrypted: i=1; AJvYcCWFQBIdQJUTOc/KiF79s9qLZI/LGO3Jro6F3mgre8O2SPWZWp17F3wv3VzMJTMCVduKBTsFQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXTHlfvnQ30LZCB2S5JNCw3pa1AUAvhlOlPljxeMj+fDFdP92S
	4SdUxKrfH5e6HmYDwfha9KoLZSFjt6UwvtSIl4pvu8SDuITIEulATxwqmHl2LQrQO3U=
X-Gm-Gg: AY/fxX4HWMmuy5js+D5K5mTF16y2THTIXX3n7IE90u+s2BCwiQTL/hu9KZ7tg6HUAKn
	YC7Cnd4S4JOuIcS71LnC1alZz8a9XFO8qOHCGeOAyF/+IJcPt1XO2zr09yEFo/xkj+5JKQCMaHv
	HOHyDhBXw67RNUS/s6RXSGN7RloPXHqAgk8ptj650Psqj1Xuxe3WtuLw8Psmvnw51jnAamxMpbf
	qlS+1m2ZKEO2lY3QRPHp7AsQEsW7V8lVln+UjdMQYg3JR9YU8gtUFt9ol1fI6pyq9sua0AMS8Ze
	5DDYApavhubhcc3hONhVQbnZ3OXLTrOn5kRPpiaQOwE09VnpmZrW801tw7VujliM0fY/qumcKN2
	ahLdDq+h+v+w3fUZdHUl1phHaTYXVs/ms35pTvHGLCEzAPn15pTwwWp6HzW7czo/zzxALQJB/y8
	zSTxOz3LdPDlnZKVWxTfLUHypCJKgE1DTl8LuiKEKmai048TkB0Fcuko9NPUddR+O3hxy0fQ==
X-Received: by 2002:a05:6830:3156:b0:7cf:d213:7ecf with SMTP id 46e09a7af769-7cfdee7a81amr4387364a34.32.1768755506711;
        Sun, 18 Jan 2026 08:58:26 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0efe41sm5290925a34.11.2026.01.18.08.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 08:58:26 -0800 (PST)
Message-ID: <184b3699-1eb6-4701-b827-47b34e997af2@kernel.dk>
Date: Sun, 18 Jan 2026 09:58:24 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_types=3A_reuse_common_phys=5Fvec_type_instead_of_DM?=
 =?UTF-8?Q?ABUF_open=E2=80=91coded_variant?=
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, kvm@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Ankit Agrawal
 <ankita@nvidia.com>, Matthew Wilcox <willy@infradead.org>
References: <20260107-convert-to-pvec-v1-1-6e3ab8079708@nvidia.com>
 <20260114121819.GB10680@unreal> <20260116101455.45e39650@shazbot.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260116101455.45e39650@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/26 10:14 AM, Alex Williamson wrote:
> On Wed, 14 Jan 2026 14:18:19 +0200
> Leon Romanovsky <leon@kernel.org> wrote:
> 
>> On Wed, Jan 07, 2026 at 11:14:14AM +0200, Leon Romanovsky wrote:
>>> From: Leon Romanovsky <leonro@nvidia.com>
>>>
>>> After commit fcf463b92a08 ("types: move phys_vec definition to common header"),
>>> we can use the shared phys_vec type instead of the DMABUF?specific
>>> dma_buf_phys_vec, which duplicated the same structure and semantics.
>>>
>>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>>> ---
>>> Alex,
>>>
>>> According to diffstat, VFIO is the subsystem with the largest set of changes,
>>> so it would be great if you could take it through your tree.
>>>
>>> The series is based on the for-7.0/blk-pvec shared branch from Jens:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-7.0/blk-pvec
>>>
>>> Thanks
>>> ---  
>>
>> Alex,
>>
>> Could you please move this patch forward? We have the RDMA series [1] that
>> depends on this rename, and I would like to base it on the shared branch.
>>
>> [1] https://lore.kernel.org/all/20260108-dmabuf-export-v1-0-6d47d46580d3@nvidia.com/
> 
> I tried to ping Jens regarding why the branch with this code hasn't
> been merged into their for-next branch, maybe you have more traction.
> Thanks,

I get a lot of emails, and pings inside existing series don't always get
seen... Usually better to do a forward for a ping, then it's a lot more
likely to get seen sooner.

-- 
Jens Axboe
