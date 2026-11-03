Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668363;
	b=YP5FRZ6+OFsapLdWGaF7Rwt3SVU2Zepw7k6I8PMsHeWrsF49qR3Eh8b/ApbBip4t+zUU
	 UvbLOJhSUxcZwjzIDTzZkKCWNhO2mU01S26Zyyzj7ljopLANFQvN6DU/m5aNqgRUCFB1q
	 0/T2p7+se32d83mzYALanU6Fwe6dRWraWfl/oahbR6mVKOFRYhkmnT83iIYqxA1ItPdlA
	 OXCgnoW0tYcm8lKX8xJqC/a03T/GJqn4g2cEDVhZW0w0tqz1/51raBPizpKcc9uTe7TbN
	 vM+d3Q9Y7YvHbpJ5s+l9SjDgTl2i+OScH0hFykADJev9f3x3w37Wr0cQnc9Ib455m6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eAMU6Rk2mC3IXoyZ+xiiwlzQCqVx9u1/gi5nvdpNwX8=;
	b=YOU051pKQMHyJeCjZ3His4Yd7BlndRsaoxB3dof1DQ33JFoV/RLAFPqDD8VGUdgwq6EA
	 kjLCvaVQkCjWcP8JLdU05dprh2CqKhWsU85IAdBkvxjUYw2s4S0iujzFmze2tb4y7i5NJ
	 NbVatLD8oz03fSxVeTMk5fmGgNADwo70Pl/doQjG6vHtfX+GSMroblPoBD+pwY8q6+er2
	 OkvtVNHYgx5751/619YeLCC0XrQHsnVQlOOP6GEmxhSrnVhdFNTW4nO7gMPyq9DKDSqXL
	 W+9j8Tz1W0A7bHHn+sk1Aq6i33bkegAnsIpooj3GK98llSwkG5C5XmM+fLmRbBrAyEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bmuztMeX;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B6606A326
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 01:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 693B6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=bmuztMeX
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5366463571cso45319021cf.3
        for <iommu@lists.linux.dev>; Mon, 02 Nov 2026 17:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793668362; x=1794273162; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eAMU6Rk2mC3IXoyZ+xiiwlzQCqVx9u1/gi5nvdpNwX8=;
        b=bmuztMeXwgi+xvV3/MEwn/AR24EETQAiRk9Oc/a/iXdigAvuvG9xEWlfWuszz8t/3e
         Fdg2eaAtiRSDVg5cyskPL+2A/0ch+PIP3k4wgqKaacQSLs5EXEwLneq8gjwg3ETSjogR
         OUB1MgAOscALRxK7+akpyRLe7EIXCZt/5Uegu5IAJ4sr7HMBEIfUxKpI2gMDKpX3LV5t
         cNvCUY3q8JOxTDnHSClOs8Jxw0KpbHY2NXrm5lt6ElVZGVewKhEBxlt/AkAxwRme1PIm
         ePyAgsEjm7xIzQjHbvKJdAVFdL+4FfrmxoI6u2xFSrE/AfNOcRaZnGt+lrgggknEHn8C
         dITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793668362; x=1794273162;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAMU6Rk2mC3IXoyZ+xiiwlzQCqVx9u1/gi5nvdpNwX8=;
        b=ab+jWgPD450Y8C83d5V7mj7Kfk7f0eROzrJZw4y54kH96OZkk4a6XdTPXmrkDe0seB
         3tG0f8hlQbMlpBFRGzD/d9ky3EFM/NacnIb8jnR12WBmV1MDNuYRfIyxQsgIhTHi0owC
         YUMwsL2aRFsgSmTfxwrBbE9shmpbGV5mN/pVUwWQZvi7EnM0mWDfnHHODKjnhkruAGSq
         3/v/bfCwOc1IUQJgsViIKDUXZK9VIPSlYW4ZC4/eT+WD3tmq0vgBN3vqbskNuDxqWGkI
         4Lg40qCvepbwgXtwnqoIPKfEyXANxahp4TqYWcS0CCbrmvv4mM4Yko+I4FPbW8cxqHpw
         LJNg==
X-Gm-Message-State: APuU4Z/sfjJh0oEBDTGQ5cU0AxngedY7wow+LphE5JvzJCKH7MClQQmQ
	MaDnmyadzXtz0jMD46Zdge8O400DRaajU/L0YyvsLZZsVnX1AFGTFOiw7GFI7J+TE3s=
X-Gm-Gg: AYBFou1KJ2iYyBp2ZGRgZMCts6WISN9d8I2OU/UvZkNy4sgEpGwATm0c5S5NUTbtmqq
	aOKc/1V66xX7LF7GbnVCsm6yhUiBIi3LRMI2avEBZtvFtG8AOsC9JI1aeoyWvEr6dAbMbomS/Ze
	KZ0adF1wGQQUXxFWm7zMpK6D0UM9OlcDX/1MTsQhGd5opHSYb9MMJNpAZ/N1gdseSqJ2zOezYgw
	B0nBrC+/4oPwu7QOcqJ9BIdqS6c8+lpDcruCkJK6WGg+lBKk1LCALModbAXuXYffcPshjpa24Fv
	zcvhHD/9SPQBJt3m65iO/7SUxBydyPrK+jpcZt01kP7mGaqmNPrDvO1e2RpkuYLewDcrBWAUZ4K
	tm8PGngO2fsdlr30XpheNlOVoxBcN6y41OIHixZyjc2xbVKqHy1q7zAXDlKUBnGbTUccEXQieen
	Lt2mCt8XpVAu/oDAySkTNavTDzsVLK5w4obuUBLyGtfyxUDWKtptBOC7NSQdd6LKEkNPB3VhwM5
	gAIljFOtBKuGy20x50IhIVrz//+QgHcPfmRk53hkzLAAdq+MX0fj9LfJLMC/fodKXKhwa54UL0b
	RmR+TeF3uBD0LPRKLGU1jgkjKgu8RITJCTk6LhH9zIrxyzR1DKED0Vf98trZiweOMo+9TyVdH7y
	F33EgZ6qjluiKcn4WQeSYqzM4NXI8gpA=
X-Received: by 2002:a05:622a:17ce:b0:535:e8c:4258 with SMTP id d75a77b69052e-542b7b0b9e9mr209257251cf.54.1793668362334;
        Mon, 02 Nov 2026 17:12:42 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498c379989sm12317581cf.19.2026.11.02.17.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:12:41 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xO34r-0000000BJux-09A2;
	Mon, 02 Nov 2026 21:12:41 -0400
Date: Mon, 2 Nov 2026 21:12:41 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kyle Zeng <kylebot@openai.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kevin Tian <kevin.tian@intel.com>, outbounddisclosures@openai.com
Subject: Re: [PATCH 1/2] vfio: Publish the container after all fallible
 initialization
Message-ID: <20261103011241.GA2696898@ziepe.ca>
References: <20261031042527.6418-1-kylebot@openai.com>
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
In-Reply-To: <20261031042527.6418-1-kylebot@openai.com>

On Fri, Oct 30, 2026 at 09:25:26PM -0700, Kyle Zeng wrote:
> vfio_group_init() publishes /dev/vfio/vfio before vfio_init() has
> finished. The optional no-IOMMU backend is also registered after the
> misc device. A concurrent open can therefore obtain a container while
> the module is still COMING, even if a later initialization step fails.

You didn't cc the vfio maintainers or the its list.

Nor did you refer to my prior remarks here:

https://lore.kernel.org/all/20261030120845.GA3889730@ziepe.ca/

> The failed-module-init path frees the module without waiting for these
> open files.

This is a cdev core bug. It should not allow the file to be opened
until it has secured a module refcount. I don't know much about how
the module refcounting mechanisms work, but it is unreasonable to fix
it like you are doing here by hacking every misc user in the kernel.

Jason
