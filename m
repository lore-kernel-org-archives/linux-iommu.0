Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7808E3B71DD
	for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606216; cv=none; b=svHTzT0f2U8dBJbcM2SvtPOfNd8VVdTzAWWu0Qgdcy00SDTQJ/2l7h1UjXYgqmwRVfJ22uzBfrd3OBqgOqs/N2yxZJrKHXa8o2XY4VCkB23MMQDHTy5IPRMzFoS7CV/hyb3r4D3/G9kX17r/zWxvjgbk6Ub2/kKA6Byt3ldBi6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606216; c=relaxed/simple;
	bh=mham4oXiC8G0ze0UEophqelkPV9RF5TD4W4HCfUq19Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbM2FcEl11Im8zK6i0EjHr1QlKbM+jejZZjKpMWAFSAh62iI9SyUv5OonCqh0L9f+9YjenrZklC6vKlBX/ozCk1G9Iqi1kjUnEMjA/VKeUgyQfeLBCmiKstl2wedHNUHaSU2tl2vhjrGjIm+ubUJVkmcIAeDX0SqiM+/jTNmw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaCi9L9S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaCi9L9S"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4908b92904fso54091165e9.0
        for <iommu@lists.linux.dev>; Tue, 16 Jun 2026 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781606214; x=1782211014; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCN4z+iPY+eriaEkOl+rtItlbIIjfyx0HCk1gZxOhtg=;
        b=NaCi9L9SrMq/j4OIMfN1wfX3i7jPKc/S01kwmVmX3IocWw+oxfcoFtGD9qozok6tER
         KDCkMVMt0Vj1OS8WaW9XEs1ajBfhAyeuW+cIfbCz4Mu3fyUYYrrAN4tJ8xEwcgzCGvyX
         OsuzzHABhSaAmCtlNm3McO/qXYM9M6PQ8B1UrXgmTkfdaU1VYyjzCV2HdhZAhjg0VCsE
         BPjPbR6JVJhidoqGMS5FM0/brmktOYsd8vzfe1P2u5PaJsetOQo9MQ39554Wbxr3vZnW
         es6CyZVksspbuBiReo1SHSBL+iG5umBmYJRlUQn1cMkT1lyh8zHNf+ahqTIU/p8m+g5m
         Ccfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781606214; x=1782211014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCN4z+iPY+eriaEkOl+rtItlbIIjfyx0HCk1gZxOhtg=;
        b=r66K2KDPnEUfIor7tLNGz4lZ8/lfkU3G0oE+ppTzpGjG/OCznTBkLQUfZvWobEhGpi
         YjmjR1gSZaEIFtHz1Guumm4BoWAN2udSqBtVB/WN4TChVcIl3ev9JqJAZ3Puq2WrKlqx
         vzQxPEFcBxSsUQGzrk6Wtzb7Bzk7SiwxtRG7VkQMQLH9ypfA6Q2GujJKz++kh3RWBtlT
         qHbmliICQWB7pahDLA7D3BU2ijA6ILmsxTkX2P71iGnnV3JopI6F37zaTGuC0Wc2U9LL
         yRbPQ7SrJk00Ko6aJcz68GguPy2N37t1p++Ddbt7LfaJv8frNh8Qz7J2zvvHj5sEG/dQ
         WVXw==
X-Forwarded-Encrypted: i=1; AFNElJ9moymglc2blFevvwmjy9Z21kyU5nWKDGfqrGTmb3gviH75YsCZj1PKI7H1ubWKKq/Yfq2Jow==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi2/ticgEL4PuXiYpf0780vqDxKOUY9oGJigl4Vi86QdxNaGiu
	Xpw8XSPGwW+apXPrByaCafHGMpPzdnecdXss+2H7AAsCrEV2qIy3V3Zl
X-Gm-Gg: Acq92OHhcuKq6P+O5jXaSEvDDyCtsa+pu+75q4BPnbO4VrGZdkbX0BnNVRHDuTEP089
	JaVisRUaO7CBeRGd7g6Atd2kA5KIhsCE3ibdIQLzj8y6TKbouCxIsnbRVzr18SW+lNto0chB7Yk
	7sINRUSBZlFphwACWYSN1KM2voEzc0Hfhi7xob5gffpX5mQI6tDNiIgziCwSY4czPiYoV1SZwLP
	U+BjtXEpX8zqtRG1wnwt0ZZbu+tgCllS4r6b4BrkuBdXhvc8vJXWqzHyyqq+9ZAs1qMAykVUwM8
	CixsNiPw1WjxDuSpkYOeOcVLTJmvkZGsqySOQNn5CDHT6hh/pHqPwuGr2zT7NFtwSG7x9ypEuP/
	d2y5NjCd2W7xibQr1j4YsPR+gXDNGCGMUWlG11Uq+BQ94uQwEN84PQQ9kTUz7UwGI8/6REFQEQw
	J6w651PDEBg3V/fk0yogGqKBNnssSoJFrr1PC3hcR39BiKkuB6/DJD2QSQSVKXTlr+IEp38Ec=
X-Received: by 2002:a05:600c:4743:b0:492:1e36:bafd with SMTP id 5b1f17b1804b1-4921e36bb83mr216605415e9.37.1781606213522;
        Tue, 16 Jun 2026 03:36:53 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26392esm42544726f8f.3.2026.06.16.03.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 03:36:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:36:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guo Ren <guoren@kernel.org>
Cc: zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr,
 aou@eecs.berkeley.edu, cuiyunhui@bytedance.com, iommu@lists.linux.dev,
 joro@8bytes.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com,
 palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com,
 tjeznach@rivosinc.com, will@kernel.org, yuanzhu@bytedance.com
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
Message-ID: <20260616113651.1048a19a@pumpkin>
In-Reply-To: <20260615123821.373248-1-guoren@kernel.org>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
	<20260615123821.373248-1-guoren@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 12:38:17 +0000
Guo Ren <guoren@kernel.org> wrote:

> Hi Zhanpeng Zhang,
..
> 3. Only performance-monitoring counters require 64-bit IO access or the
> high-low-high do-while retry strategy. For ordinary status and control
> MMIO registers, a single read is sufficient.

Actually this sequence should be enough for a counter:
	hi = read_hi();
	lo = read_lo();
	if (hi != read_hi()) {
		// Pick a value that happened while doing the reads.
		hi++;
		lo = 0;
	}

-- David
