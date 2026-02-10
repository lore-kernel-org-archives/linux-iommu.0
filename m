Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341133F38A
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 14:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770734951; cv=none; b=aeg5BOobsmNrIBhGb6K/v5RlsFt6/t6oJK0yKHyw30xYMFRlfWF5asw7O9nV3A3TQJA5+rv+XiXzNm0XbCFebiQKCvNIu2KBsgWBZjQ9k2lzaF1FiWWM/bN3ypOKpYKCF2PCBU4dazgyenPDsLRFXLytsAxD4ngCDyu4dVOKaDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770734951; c=relaxed/simple;
	bh=+bIFsqkuMlO2AMozRHfhdOolt0s77l01f5PiZRSILuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mifSAHsgfx91okfqRfCpo+hJ24J/Aa+EkHsJ9BSXuK4IcNHH3ml1K1vfkPqX1wcTK99x5Qt/E2Un+vwJFl8C0xlgrhVzYu87y2D3Wj0/B6/P84/ry2hDFfINhmHF9RepighbQhKKLv/SPuQurAKtavAw826IVrr14luKh4g9BjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZWqYFOCB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZWqYFOCB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48068127f00so9064505e9.3
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 06:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770734947; x=1771339747; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knkS23bKgxD0sGFgNoxwcHFypphehdzY/C+BgKABh1k=;
        b=ZWqYFOCBn+8P8n0C2fcZ0DzXSmct2hRDjuXF7sb5PfCSnTyZKMnoX6MAEQlQbQjqR8
         6ICRwCQil8hx27mU1A6U/DlQte5q3Jt84ANXqisIHcGPQ6xINCsj1QYp2WboXBJfOYF3
         DhUiefUxNQO5TjwlgqAW97d71D1b1DmodCcdv0XBnQJhVzYBZteNwXQklGPDcqgCvHKv
         Ul6RcbnL3SUYBJEbyACWlzMe9VdUNrcO5pX1XJPD8oNt/cJwPkaYcTBE2+5o2YvoUFG9
         EtSTBLu1w4lsRGvHcoaqcpJP5yeQYfWzX3m35RaKUO94Abos8COJePe0kKFm7SrlWpjX
         ijPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770734947; x=1771339747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knkS23bKgxD0sGFgNoxwcHFypphehdzY/C+BgKABh1k=;
        b=Xpephk+dzQKThA3h9MeXaYugSmpMRAQOhe2wAemJUM2BTDUbJjHR+hRVhppSGfkAO9
         nRGjC2WnGcx/KLZVgye/LjQq4hHj/uGGKYL0jZg4lUa3BAOSjhoBaoI4cxU2R3+j4IxV
         gMgwKLRMww+lPegLRCFSIB7E0BiQhWBG3blo/KVirEjOMSK7YELzQ77IMK03LM3uk1IM
         LOg5zF1E+tg8oHoZ+ZH+q2wjZwM+rLS3bLEU6EyfINL8u7ev5pr1w2zl4IHoPJs4r979
         7ygsNlOJxCWCNpao1HJDBQUO5B28s5/plcF3hbAHZvCYcPYOv1vbQgJQiHxLGFhICFjU
         BEgg==
X-Forwarded-Encrypted: i=1; AJvYcCV39NrBGKpDniwPRNWikWHX3xMxJ4s3zanCDgl8++S8WZY5BdUI0KZ4ZTBXl5Rqz5uNDlohCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmwyF6tPQWgzBmB1nnqhJjlGD/0yNhv1dvchMZ1jwJEXueqHNt
	nxgvfiQVOqu6XGo14prdOnOBbtI3StHgQ7Ulz2i1SivcO5kDUczysq6nOdailsr0pJA=
X-Gm-Gg: AZuq6aLOlhimNEeZBFJsaOoSn9FFESsDdyUJ/zGf4WQrmwxxLh2Yi92e052pBkhZTVT
	hna8EmQHD62UL21u5sfehsQx9L6oZOtq3nLEAohBdxJinOJBOy4oWdd/Jwp14FK8TdmfaKRnTVt
	dUpVPA8G5NLEKUozrmp9eqIJX827SnNHo7BDeZsg5WVH5k+f5bRF6XY6c63v2Pco+Q8hPlv4l2p
	lfQolfuO76vgA106v3XtGruCE0PAQP/Qd6y3MRVLbdDfdAGmltMAVmxXi11/cLQTk2M+NDb2Oj4
	PmV7e0eYlLjTT4t2/jCbFJcbnPSFvSVbTgYgcRH4DwK3NTbD/As2zxhGX1ZCXtO5KNyriDtf0nn
	3EUyzEDeQuj2tlWdKpSIXiYelZZxh8bUb72zIjX0nOHmStCANc/QIQSxS4f793kegjegm2JRHFg
	MzAeUBUZbLkyPoqRF9IuTSxhkkPX944tgEXXA=
X-Received: by 2002:a05:600c:3f0a:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-48320236ad7mr236498725e9.31.1770734946334;
        Tue, 10 Feb 2026 06:49:06 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bd1c9sm34022302f8f.15.2026.02.10.06.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 06:49:05 -0800 (PST)
Date: Tue, 10 Feb 2026 15:49:02 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Stultz <jstultz@google.com>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, linux-media@vger.kernel.org, 
	sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, 
	tjmercier@google.com, christian.koenig@amd.com, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap
 flags
Message-ID: <y7gvezflidmma7odnut2rmlecsbxahrcwpmoevfnhzjveusuwj@6qxqogin45j3>
References: <20260209153809.250835-1-jiri@resnulli.us>
 <20260209153809.250835-5-jiri@resnulli.us>
 <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>
 <20260210002927.GC943673@ziepe.ca>
 <tgvdjszwxggr53digbmddcbxvupzl4xcoprofkgrs2kgf6rknx@44ebljjpghjm>
 <20260210124357.GD943673@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210124357.GD943673@ziepe.ca>

Tue, Feb 10, 2026 at 01:43:57PM +0100, jgg@ziepe.ca wrote:
>On Tue, Feb 10, 2026 at 10:14:08AM +0100, Jiri Pirko wrote:
>
>> >I'd advocate that the right design is for userspace to positively
>> >signal via this flag that it wants/accepts shared memory and without
>> >the flag shared memory should never be returned.
>> 
>> We can have the same behaviour with the separate heap, can't we?
>> Userpace positively signals it wants/accepts the shared memory by
>> choosing "system_cc_decrypted" heap name.
>
>So what do the other heap names do? Always private? Do you ever get
>heaps that are unknowably private or shared (eg MMIO backed?)

If I understand the code correctly, you may get something like this:
$ ls /dev/dma_heap/
default_cma_region
protected,secure-video
protected,secure-video-record
protected,trusted-ui
system

The "protected*" ones are created by tee. I believe they handle
memory that is inaccesible to CPU.
