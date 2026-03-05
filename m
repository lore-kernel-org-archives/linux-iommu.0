Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2484F39F167
	for <iommu@lists.linux.dev>; Thu,  5 Mar 2026 12:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714421; cv=none; b=pKwVS2FjjtTYngUYPImCyBUGRaDNjOrwuYV63q3XebD+264kkoZ3QP5cTtZM8f04I9/AIbNNhwv6cR0rYH1ZlxWsqJdBiMDRE2Y9kfPyZfjEG9dXRReaSTjkur7UETqa784GakEEyGFw67ukY6R7bqfulDCa3XW1UG5XQOyejHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714421; c=relaxed/simple;
	bh=vEuPDSsDt//wtmzfe9Xu8GSe0LEcvi4euzHg4drb0UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvrnB8FHH3aupQYdgH4TvQqAiynIiusVGQtb/JzX9p9GLusN9o9QkqG98OMpCceC2Ki7b2VDLr5gbPpEBAeJVV84kWPCUz3mxeZWNQSfpcmgs7FbaIqaDhAkqsMoWPveR2bG1mbCXz3cpEFC6ADogGc9mBYDQDJmFKOs4yUfVC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=pOv+/2RU; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="pOv+/2RU"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso5094231f8f.3
        for <iommu@lists.linux.dev>; Thu, 05 Mar 2026 04:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772714418; x=1773319218; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEuPDSsDt//wtmzfe9Xu8GSe0LEcvi4euzHg4drb0UE=;
        b=pOv+/2RU35bJrOFIGfg6h/pv3HESCAgZcaod0Cix/Cm4J2JnAYfwbr8/TRx4bZXCIY
         Pqu9sz8VVGYb/sfiI3snqtWl2NebdPy9GbiheC1VznwmqS8NiBBj5fbvKgZHW3WhKyi8
         n4xG2ZD0KxEx3iLc0mPzJeltKB6d2yu/8kG0+MDxnt0kv3y+6Ldoi8dfsHo+ZbsBTl4a
         lFq54cdp2jzhCxHvp5TVW0aHiRSzFrNYWiHYYPTLh2DBY/qTfUz5vvv5CQVQJ60+Uc26
         AfBp/W5uGLzfxvuKAKI82QJWjl7FklW/5eJ/zCPXsSaw9NktBUAP6Pu7Q6zH6VVVJuJU
         vDoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714418; x=1773319218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEuPDSsDt//wtmzfe9Xu8GSe0LEcvi4euzHg4drb0UE=;
        b=E5ADWZ1gqRC+zd2htPi9jg5pTs7/WDjVmyZmHeEDItK3MbHHFAAZy5tuCR4ff0O7UV
         CYewtzI25Q1qmvSy9IsmdVi6l0YTj+JwjkJRZLrMP361aTtavRVYMXqK3F+YJLmAQgE0
         JyZwPMuv4GKIT+bg0rzFRSzpuUHIBR06JLFx8ty91MSHZBdY5Nbg38OsVMxg07zoyftn
         i4aO7e0EJVgBQ5fr7BcAWPT5URw5jWw1deBLuKUadmtT4Jk26LpqO1zEQJvMg9c9Sg6x
         4oSZr3kyt3afrGf3TnjI5NTRVxWNtfv1HurXqC+oB/zaJTQwfLkqdPMPDC5bV7Er1NBZ
         dQwg==
X-Forwarded-Encrypted: i=1; AJvYcCUM3K63YAZrlDd2i8TLU+Wf2ZXGpBU59wuaXE0v8+92H2H3eQGdyF5qZBKVqWUJsqJ8eSwiSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQyeQhTxwZZMoRNlbxuuAg+Zd0Qq2NrftbdW8T2j2H9xVnFD72
	QqAqtyKjrUdQA8vFOruMngQbR4aFCeBaNe1mWTK8w1mMSyF3CiXNhGYFiEw4pV1Ldxk5o62OHPp
	g+cotukGc+w==
X-Gm-Gg: ATEYQzw6n2apwtC536iww3FYhtesoSl9cWjFVmyXRA3Eqz+0ulxeKp4Z6jg/2FpxyZx
	6p7KOq+ty/B7os4eYeqfbhIDsYDWQ4Mz6kyT1kBMFi/9v0qRlCW7Zb9QTHDoXWrxCB3foCkgSF6
	X0IldWyvvQp8AsN5yez0Qe9PYJe4KvBRUqyaensMq5yRrSgf/swkip286FXQp+nzFgVdBdcP7oI
	ySLaiHdozRlKDwFrP8H3EJMGTahkREZmrjaavVachWPGEBtUcliyzkFJ2nj/Qa1EHdHbylQC+Br
	HVe07LAbwMxhXJiMIxUw+zIzHdiVeZmZtwoz+R6vtkeWOecxitoGcodv19pKccdlJhFJr7UTNoU
	1I+2fRnajuL3Cs5B3xkSNzYJGxNlAJqj5pvkPEt2AY4n9wJNSSFEgV864k63wVBjXs4Iq1h2IxJ
	O7h3bLrVXWXljlV6fnR4USrXhGQEiqfTM=
X-Received: by 2002:a05:6000:2510:b0:439:cd10:a1f9 with SMTP id ffacd0b85a97d-439cd10a224mr6376565f8f.54.1772714418526;
        Thu, 05 Mar 2026 04:40:18 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503425asm33480811f8f.25.2026.03.05.04.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:40:18 -0800 (PST)
Date: Thu, 5 Mar 2026 13:40:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	iommu@lists.linux.dev, linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, jgg@ziepe.ca, 
	leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
Message-ID: <yyb5ozsxnfcuzo5rzpg64hgj4rtxz6glpqf5fpkhp4zrwdgted@izdksr4b3vte>
References: <20260305123641.164164-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305123641.164164-1-jiri@resnulli.us>

The "net-next" in [PATCH] brackets is obviously incorrect, ignore
this bad string please.
