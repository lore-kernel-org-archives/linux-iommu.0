Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E391D3563F4
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322034; cv=none; b=Kb1XIHp0wQyDqZBX1aCiBishpHKxr+IZ99Y5Po67jep5eedy+bh5xCaAOw25u4j3qj6HACE4Y7mvs/Y4UXW0L2EOSZa/3A/qrx1vAXHmo2Lo/FB7lTlWJqxVUdvy3nPu5f2rfRtJq/9xV0xxlYCKddXSCPbsJ0WgHuu73mh+QWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322034; c=relaxed/simple;
	bh=gpA8yPsxWr0YYMreEtPtRRIeMQAt8l2vEE7xAShAnkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuQ7HmoquoM9nbvmc9BiyebWudIV79u2YNBwojH+BhzGuA5e/CWn8smCluJ7EbQX70UfGY/0brn+Sapf8ZkkrQdkbRsSurZ1YHsHu93JUHytKkerhNT4o61dhztQYWvINAhd0G9ssZi/FRD1//8pIghIP6f7dBeKIHXt9tPBizc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=o3L/llHp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="o3L/llHp"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so1265332f8f.1
        for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773322030; x=1773926830; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9eBBP4AujN/dlLV9JaVbLVwoGymEEzkiKrZGnylO0o=;
        b=o3L/llHp/eWrKjA5sIdT4n7la7Jk9gxSzgcCfNLubQrLNsW4zN6rwb2wB+f5zhMlZU
         YhBLbgRFgHJk3S81UWzAi3Zi/+ZezqhwHjpPyB1ctiNbRPFwxk7+xUaxtUilsVlkBPjc
         yqEzRybbq6RZa8x77ZmvREG/JUV4y4FiCtAJ0lKsm8lC4Qb5DLorrW8Ag+c+58YUrw98
         SzQn4caZ+ehTbBp+VKhj2n8eDQovREim8CESxPgpm2KO6U6CNJW3whHgjIcmAmPqKVrG
         grQXFjFdJDpIaXF5rr/rWFoidr9oWm+Ts3I5VHnT+XhuiJ1VCh30+2Ib9RDGx8F4Muum
         0u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322030; x=1773926830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9eBBP4AujN/dlLV9JaVbLVwoGymEEzkiKrZGnylO0o=;
        b=LsuszEihteyc1R1higmyska6U8fz5bTiNI7f5cDKlV9OY1ABHKH3gScQ8P3tCmYyha
         WbPxa0XigMIIV76dpJkpZ5iKnuoZuJzXwYBQzwxHrliaqu9LdQJh4Gp6sD9GkMGluWLk
         E/XbuCJYdykTLId80s5azWGwGYIsrOx35UUSRxu33DyRmAa84El1NyndJcAPUJAvRODF
         nzkk0ZI1epx0cCdk7p0K9ouhJXQMgWdrRH/bxSxN43JddmNzw8DPyctlU8G5ru7ZL2l/
         U3P4aLT1m6sIQpZn8K2TLDEUGP9usx+eKJIcQBrLBERAZrTdN9M2l6Q0hfYTV8nSiWsI
         8UmA==
X-Forwarded-Encrypted: i=1; AJvYcCWeYCi3fXxzMzKgyJbjIPqNAXXKLVBbIOd/PpJUsaBSSARku46B6gOYPJAPlNrLX0BaVwuPCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7KRyScuV0I39eEO/Cgqvwg7jx1R0v/axBrCnI7gyPMlo9B3XB
	7cC9lKrZ1rx1KNxz/tP8LjP0KGPi3YHuvyyGYC+/c01ar105sCABKDA1wVBl/m2TYBo=
X-Gm-Gg: ATEYQzz5x3faU1yDWMULX5dTeSAwAb4x/OjKlmbtYNLXgIHDh9dj5fIOtV2a9eNOQiO
	nsXGUcfoqnpzyNGM8jSEK0a9+39p4MSkjEMJ6hwa1Vvak62bz+YCL27j3LMHcLz7e/nPTvp1qd1
	Wbi8PnsFG85/JnlLLjAbYgJABO+YbG5I2Uwwj25sqzyllYXFZF1CW4Ad8any6mQDlpPvhJ3K4lR
	VhZ5w2r+/2pFBueudVUJsM/NbStYjc+0Cds87P1uSKiSZP9ptl8fBqhj9F1ovf9G0TkdrmUlGzQ
	31ebscf/RBFpgWKqzdKDDQMqYEHRiiCSchLHbPS92agq594nDxXOIAFkPs7r6aPAiYWNFqIIVZ4
	3lkK4svMMoLmkecK/Epn4hoK52RqPqiogo79jIkEGRApT6yfnKupPRxnudq6IYZ2bg0vGOxZX7T
	5vDwBzfvWnZKa1x71SMIwmN6SmmsI7Rek=
X-Received: by 2002:a5d:5d0b:0:b0:439:f5ba:8c2e with SMTP id ffacd0b85a97d-439f81c6390mr11949569f8f.18.1773322030015;
        Thu, 12 Mar 2026 06:27:10 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2186d5sm7889290f8f.28.2026.03.12.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:27:09 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:27:06 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, 
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com, 
	m.szyprowski@samsung.com, robin.murphy@arm.com, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/2] dma-mapping: introduce
 DMA_ATTR_CC_DECRYPTED for pre-decrypted memory
Message-ID: <qhu6ahugrw7ehxubssin4amdvsdqeuezjm3vdja5xpcykyjij7@kcg3fojxysqw>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <20260305123641.164164-2-jiri@resnulli.us>
 <20260308101948.GO12611@unreal>
 <20260309131530.GJ1687929@ziepe.ca>
 <20260309140233.GW12611@unreal>
 <20260309151857.GO1687929@ziepe.ca>
 <phry3e2dtgxzxdqvrnqfuskangp4al64f2auithwme5kwkgepe@7qtftrhgv4l7>
 <20260312003408.GA1469476@ziepe.ca>
 <pmfxzgtazwa7fwz4mx53htdg4jjifwyq3gyzwklc45affy3xrp@57hxan4pqnkx>
 <20260312120606.GC1469476@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312120606.GC1469476@ziepe.ca>

Thu, Mar 12, 2026 at 01:06:06PM +0100, jgg@ziepe.ca wrote:
>On Thu, Mar 12, 2026 at 10:03:37AM +0100, Jiri Pirko wrote:
>> >Alot of device MMIO is decrypted by nature and can't be encrypted, so
>> >you'd have to use both flags. eg in VFIO we'd want to do this.
>> 
>> Why both flags? Why MMIO flag is not enough? You still want to hit
>> "if (attrs & DMA_ATTR_MMIO) {" path, don't you?
>
>Because we will eventually have both decrypted and encrypted MMIO.
>
>> I mean, CC_DECRYPTED says the memory to be mapped was explicitly
>> decrypted before the call. MMIO was not explicitly decrypted, it is
>> decrypted by definition. For me that does not fit the CC_DECRYPTED
>> semantics.
>
>I would say CC_DECRYPTED means that pgprot_decrypted must be used to
>form a PTE, and !CC_DECRYPTED means that pgprot_encrypted() was used
>
>This flag should someday flow down into the vIOMMU driver and set the
>corresponding C bit the IOPTE (for AMD) exactly as the pgprot does.
>
>Less about set_memory_encrypted as that is only for DRAM.

Okay, that makes sense. Thanks!

