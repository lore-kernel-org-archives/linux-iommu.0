Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFD01CC179
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919038; cv=none; b=j6/aP6B9cL/HEdEzl83iKpHqj7BaBQocyLao6v+MC4LbsbA+1GTCqE3NVeZDtG+5t4Z31qreXrlXkPXliksksbpaEdfI91sbo0WcXa1+P9O6c7fLORB86qmiWoVU5bS0Bd4xjFIX8hr8gqnjWzldjx2tySg2mkVCaWIfW5Nbi0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919038; c=relaxed/simple;
	bh=qZjZkJC8TvuLicHKx/g9ilkvy1AyBGceBizbkfzAbO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ji9paFJccTAKSyYr5/bJd3eM/q0vyhppFrRDRhyiaQVaT6zJxRfcNxs05V+Y0rj/isMlFuzrOD+aEysXxInRS1Usa5ktFjJxMpvhTvkRQMU3Uoi1Rass9RILHUeSUIX/J3XY+Y7pgefRKUv/m1JHcRifJPJSYvGJ1EtWQF4hRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=uHxknDtF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="uHxknDtF"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a39cabb9b8so12352895ab.1
        for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728919035; x=1729523835; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1f6tWVkVeZpuD6W55vu43bMEka9Bgfs26D5vnHOkHNk=;
        b=uHxknDtFElWGlG28VLSEH8h6WWFxqL+1DARWh/FM70ZvUvgh1r8ftjE7zuORkebHze
         EGpI4QuCWaLlJIIEAf5ZpIcjymeMTuirIvojlFe12+JtgnyNrF2xVryFzf7MaEjol8Pp
         rvddmzq+KjacynDS54FWuY4k7YahepLU4tMc+7leIAlXcQHhb6Eh2HlFfnZ1S8fgwnMc
         MzwgMhKaN839xC/l2ArVorfS4xrS3vyIfFWl9uYLS14BbcxcEFoaPMbMLBl/nDjW45wZ
         x4q7JHXuROzk3ImP8RTSaMsc8WTkfbe0rJnSG++URprJfU5YZcgYHOwgD/ATMlsxMsec
         wT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728919035; x=1729523835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1f6tWVkVeZpuD6W55vu43bMEka9Bgfs26D5vnHOkHNk=;
        b=AijngY7i6FsjRy6EllK7lR1hvOcYDuh4rrj4nAVhGA93vX4jw+oME99+44Oi+hJ7PL
         /FWeXLus3My6Iw8OhutnP6hU5AwbtLdWAsVrlGFMDDAWB8DEgqApGfEhpGQf1RgDYMdh
         QFE/yRtB+6LWgy0HtiD+8PY21/ceMvGaCmInV3GIFiTcHrUFCV4L0ybBhjkw/5lCYARJ
         U8K2bCY+3YWhglU4UMUYjDP6NI09UE/UbJ226jV1KW3/et+Kr4I/8GeDmemFQdruSMiW
         OXuWjCWFckFJ3qk8EQZMTXK04UU8BUbSWAnTMLAWZpe/tkdgzMwKu1TPgmuZtHWnxomK
         JvGA==
X-Forwarded-Encrypted: i=1; AJvYcCUY5B/bQouEJbH2P5enXYY5mOkfGWw+7AUfkwvMvWpslCIAsGYVRhY5zwGXw4IvUZMGrSstOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqPy5ksUNHq5KPKj4HEEvhPfCmpbZBJp2GXzZz+3BwQseBYQgu
	s46H6FT9SLcOClL8y6BIwKXIGMMCNlIyNQaK32fqGi7kUKkiO+s45I2YXtO1iI0=
X-Google-Smtp-Source: AGHT+IFxU+6iK4vm/BjVbsnxaxXdxk8G3H1g9vd9g5QB1bRM6/lXrHOk9SFlCvgoUX4Lt8bWzNOpnA==
X-Received: by 2002:a05:6e02:2192:b0:3a0:7687:8c2d with SMTP id e9e14a558f8ab-3a3b6019b61mr78076955ab.26.1728919034952;
        Mon, 14 Oct 2024 08:17:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afde8cb4sm56162565ab.76.2024.10.14.08.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 08:17:14 -0700 (PDT)
Message-ID: <a9fcd235-18b5-4b17-bd4f-75dc2d228e17@kernel.dk>
Date: Mon, 14 Oct 2024 09:17:13 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] annoyed dma debug warning "cacheline tracking EEXIST,
 overlapping mappings aren't supported"
To: Ming Lei <ming.lei@redhat.com>,
 Hamza Mahfooz <someguy@effective-light.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 linux-raid@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZwxzdWmYcBK27mUs@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZwxzdWmYcBK27mUs@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/24 7:27 PM, Ming Lei wrote:
> Hello Guys,
> 
> I got more and more reports on DMA debug warning "cacheline tracking EEXIST,
> overlapping mappings aren't supported" in storage related tests:

This is easily triggerable with dio and reusing a buffer. But it looks
like this will only trigger if CONFIG_DMA_API_DEBUG is set, so should
not be a prod issue? If so, I'd say that debug printk should be killed.

Maybe turn it into a pr_warn_once() or something?

-- 
Jens Axboe

