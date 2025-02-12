Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035F51DDA1B
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739343199; cv=none; b=P+dsN7Fyw4x0mL+sE6MT1pO0+fn09HaKHCnfn2Y7c5pE/Kyu677JJoT9HZKQYmQbYsPB50WFO+QvFirZylNV5g5hD+M2EI7dmVPKhzlqFLEDGOp2OOQvrjWuI52Qengw8OMz12hVSdmWe75mum06EbYWmcs23KJPtcAcqECHa/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739343199; c=relaxed/simple;
	bh=3zUdjh6v2wfB250eT8s3roIt8Qtd79xlup5Duj+e/Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAIwIYl+i1kI+fGcgBf68qwWhyDnBg3ggrlPKnmszXNCYthWoDzHmE6LC34XjNBODnCS3tsknbOMzxAL9SoKgmEIWXbCv0G4wrrS6FtX2n/ErNI4EjBQDGCvGUm1rnE6CLzFu4BCHPOkNflJCz47ttJ4FCUNXsv8/NZoNz7/GWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kd7jbL+V; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kd7jbL+V"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ab7e9254bb6so172346166b.1
        for <iommu@lists.linux.dev>; Tue, 11 Feb 2025 22:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739343195; x=1739947995; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3zUdjh6v2wfB250eT8s3roIt8Qtd79xlup5Duj+e/Gc=;
        b=Kd7jbL+VXcgnhS4LPf9LXEIxZ0qAVNpmm13r8wjpT9IVq7d0NjlJILsMvR5ttGijz+
         efRGiLsp5Unq6X8iA+nucU1w3jiOSrN6G2U1Jmpk1Dm//44PDix92SGVLM5RS4qiVOGP
         Za3Obl6JlGE8oiHLQF/rNRmx9dbShKgfGWkDSr9uKgZarDgm5V4m2N7csBcNPBYOL0+m
         BoSBJQzxeF5czK8qJL8vH5OvuSSdzZjl1eP9wAqL8l9XftHSvxjL26h1DfxVVvh5g0NE
         pZ/TtZX0BK/D1TcPiVZ38OVIN4Qq+OXG+P3X2NR5LUdQqN7AQ7f3PpqZNjkorzrDoyIA
         oOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739343195; x=1739947995;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zUdjh6v2wfB250eT8s3roIt8Qtd79xlup5Duj+e/Gc=;
        b=kQmRANnklBydDQcbdTAMAsj/UyFyUEz1SOXIZAFcJv3qbEQiIO+vawCh4tKF2zh2Mw
         Ap8z6LbbU2Mwj+Rm27F4aRdS/kYTZ3Rz5lwYJ91c2yW4nl6FP/570lXfa0tHOEUErpDP
         BXv8ePvV+pvLX56ipf5rhvF6drH3tla0BqCSMSrW9STvjrwKJKZQw5OTcLcjS/O19aUA
         bfpB/Ze0dtfEHQrTRMlZlz3QGPCqbRWBqjjyx/G7bX7jaoyhTrGo4O7jgk7GpvOCVaOz
         tK8b4JJJsIkDflCgIhgSeAqqW2Z0j0xFcxvxqYwHimKMYtu/w31RGrIgz5oGBvhQR+zd
         sXOw==
X-Forwarded-Encrypted: i=1; AJvYcCVHnofI6Zbai34Hk0s5zwPmtu64Z5MkFI0yJeznkpm6wdUuYm3Ab9dGakBp653bdw2yTZozGA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz6eroE+e0V2qzrDGdnSuXqtul6gOjzJag1XASneHjZzjb1J/6N
	tfpBYIt9vfzhnxAGQhLvga2mBqbIfmg5s4Lt1+yp+dM5ZpjwCAvMW2shp4Z/Bw==
X-Gm-Gg: ASbGncs6VOShN4vUy3hGznQzakhX5OUZpnd5lArfuO0qtRxsnJgceLWaJSHYEpu+96Q
	P4c/z5bl1QavpUWbJAfzaAdRTRnsp9P83VPGY6WrnVAhxgt7CZlT+Jj7fBLQzTWOsTZ0IRWnTba
	VN+B+DhCH5Zz79PAS5wiyIgDbpBJgXl5eDpOvEQlSWhkJvjFD/tcLxHhyXM9auctJebrzt5u+iM
	Gh/RhN4wGAekl0JliQ4vzW5/NHSR00KjefKQ64OfRtU+fW+9NND0PhMxjc/an+WXnnuAiXF1miY
	05N7Zk6s4u0MHv4UplFox+vsy8S4LF6mEIcUwVdLUjX8iPsLEcSU6ugdWL5YNd1NJG5eX60fy49
	R
X-Google-Smtp-Source: AGHT+IH7szDJ7r/FLs7HCSZgQOG6ClTKkQlnfHrZmIaLFikv1S6Fh81Vo5LwUTuyR2T+FFP/nHdGEw==
X-Received: by 2002:a17:907:2da1:b0:ab6:f06b:4a26 with SMTP id a640c23a62f3a-ab7f33e0e2amr203666266b.34.1739343195217;
        Tue, 11 Feb 2025 22:53:15 -0800 (PST)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7cae13326sm458952566b.115.2025.02.11.22.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:53:14 -0800 (PST)
Message-ID: <5255102c-de9f-4cd8-8311-5d5b5eb26832@suse.com>
Date: Wed, 12 Feb 2025 07:53:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] xen/swiotlb: relax alignment requirements
To: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 xen-devel@lists.xenproject.org, Jan Vejvalka <jan.vejvalka@lfmotol.cuni.cz>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250211120432.29493-1-jgross@suse.com>
 <20250211120432.29493-2-jgross@suse.com>
Content-Language: en-US
From: Jan Beulich <jbeulich@suse.com>
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <20250211120432.29493-2-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.02.2025 13:04, Juergen Gross wrote:
> When mapping a buffer for DMA via .map_page or .map_sg DMA operations,
> there is no need to check the machine frames to be aligned according
> to the mapped areas size. All what is needed in these cases is that the
> buffer is contiguous at machine level.

Is this really true in all cases? Can't e.g. compound pages make it here,
with the caller then still being permitted to assume higher than page
alignment? Alignment checking in xen_swiotlb_map_page() would perhaps
need doing with the base address of the incoming page, i.e. excluding
the incoming offset.

Jan

