Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00451DEFFD
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393731; cv=none; b=B/5DIAKoS52pvlBv0qp9Vbkpe36S97Dn6GFlBkc9ef98SqulCuQt5CUMbCv4MDCGhcatSRfxMZpDMXdidMr+5MBGdu6PkC66WxQs2dgkC8kbccceGeUf57SHf+waiTE0ZhCx89oaECzykKwce/g7qNVzvmthLlsNcVhFLvXzwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393731; c=relaxed/simple;
	bh=YIH+i4hon9OeIABlByObQcoJuEqAEQRyrmg//TWxt9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giBrfj+pew0SoZD73Mf2eIUlpGjqEHTVIXwEct+GKNQ3rSFf/TZRVdfQUo0yCqu8mz0EnWVblvIvMpzk+XyenNC4Pvua6IK3aj4vgFCSZvh5j6/dd+a9NmJhCrHX24A+zrZoPEj28x9dG4SQjUgND84PC6zl+BueTVU1iSQgMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEdxwF4m; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PEdxwF4m"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53e23fb807dso365850e87.3
        for <iommu@lists.linux.dev>; Thu, 05 Dec 2024 02:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733393727; x=1733998527; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Bla2k6xsSNv8Akp73rgxD6m3gZJB5hhrIHZs9PXF0E=;
        b=PEdxwF4mjRkrVFqlfQRe6cbgWG6LW4FJKJ7E84zt+JnsmJNF/RkAOGfHBOs90+t5m8
         +2xhNKAjv0hzmKJXlKwySv3J3YAef9fBbqcMYHcn0kgfuGekcgDoNnbEdXiaMECfTeEF
         I9zIqFLzHs36UHgxQZT5cB+dAnddBmM9BJWSEQYfd5vlbf5IT3qSEaJYBepKifxsepZk
         nRDmMuQnBHrEOA2c8cDzQ++o3ucwJ69h8p3wkodxmHJxK3OizdufR0oS78OxkDXOBREv
         4zglTntu+8GzKHNLggvBl7RaAMS02C7m7BZ4Q2puxgXy0IHpwKKjXOPny1gOb9e2B8fw
         JS1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733393727; x=1733998527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Bla2k6xsSNv8Akp73rgxD6m3gZJB5hhrIHZs9PXF0E=;
        b=YQv3w9S8MJPcixfq2Uy/+PvKn8AJld8YYavEnpFI3O38TBwWcyNPSOZ8/0GaAhN6eh
         rI7eQvcnvHafRgmJc1YgPP0mhe03xSihC6sSPmVdPcP6oKg0opn/i1Iu34CkeMDesVfu
         93nE6XK+8v8QwGUYt0jRc+nV9+FKVuPmDIjbsTNtdVbNfGlCq2xDSkQhJDvGThsWMnyM
         1lFMegdZyV9Yh+pIk7USpNaOkzh+kwPIiJLcvmDUnd/+mlG6cOiYb3MOI/Iedhm/sgOw
         8w2GgjKTy5hwxJ66fg4t67ojnHli3FNw+spFfo158gw1aV9zdQb1jw2wxl2Y4CPzzPl8
         3SHA==
X-Forwarded-Encrypted: i=1; AJvYcCWH9Elw4P0wHNrENVaAV/egs2unST7FpW2ZZ/ZH0aP3zatHL6bf8BECRHhHQqdB2JH/j8ONVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy03mfpL7SDRrl6jGvXjMJYvycggK0uccDEpCMk+mI3fIxRD0A1
	NNVu6ygE5fZY6OeFglaAAJyFDWCrWyCOymr2znEAdL4BfLDuNYHU
X-Gm-Gg: ASbGncsxedunQBhboV6i3INDFOgbXGVwxt9v4aU6oqKHx2XZ/g9lfQulGoUFIAvjyzd
	M9DvM/lUz/t2zQ4CIa9zZ6f2kyqX6r1dem/87PhfXRYCCvGsWsoLPF2RckwkQ8HqpUbIvMN7LVB
	ZPfxiJJAGq+Rm/rFkvJFlm/ofGFWdUxz+VJ72DGuDE9LT4yJEnzdRKKR86mnUGgrVcVih0nbXlg
	LKydG3UhqkABQlL7zSvlT9lsNXVl7QKboReaRao1a/X/dKYEctOz4w5x29eYzOuwccPVgtTbeN8
	dP+lic80b4wTev71jcX4
X-Google-Smtp-Source: AGHT+IHp7Dxl+Jd/Hyw9W2xFaZ4ccKDM4H/1DrGPwTqKtAYK+lO/In2P/+jMlCzQXYJqAI5hPFajMQ==
X-Received: by 2002:a05:6512:3ba8:b0:53d:a4f9:6141 with SMTP id 2adb3069b0e04-53e129ff45fmr3925636e87.14.1733393726909;
        Thu, 05 Dec 2024 02:15:26 -0800 (PST)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ba814sm189644e87.120.2024.12.05.02.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 02:15:25 -0800 (PST)
Message-ID: <c3e1def7-0ab8-4fc3-8b37-257a29c1235f@gmail.com>
Date: Thu, 5 Dec 2024 12:15:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] rust: add dma coherent allocator abstraction.
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Wedson Almeida Filho <wedsonaf@google.com>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <20241203170752.1834271-1-abdiel.janulgue@gmail.com>
 <20241203170752.1834271-3-abdiel.janulgue@gmail.com>
 <AFCEFEB8-3FB1-44E2-A31E-93863E11BF87@collabora.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <AFCEFEB8-3FB1-44E2-A31E-93863E11BF87@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 04/12/2024 21:08, Daniel Almeida wrote:

>>
> 
> 
> By the way, I tested this using a slightly modified version of the sample Rust platform driver
> from Danilo’s v3 submission. It’s working as intended :)
> 
> With the change above, you can add:

Will do. Thanks for the review!

Regards,
Abdiel

> 
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> 
> — Daniel
> 

