Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EDB17E8
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 03:02:01 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so7166117pji.1
        for <iommu@lists.linux.dev>; Thu, 17 Nov 2022 19:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0BPaM8FRNxyjrgi80/IHtEdi//TfYvYEdnlSUnsg7I=;
        b=Kg1Di143IsqlNKp4LopyknneEJmTpurUoKLRaod0LBE3Nqge5CgiwIqYqnhSX2TWnC
         lrqRnsWCqfD5LpphZSF41SrKd8JZ9htzgj1cPhNgwe8fpClXmyAin61AWj4v2geUjtY+
         KZTpBwWKM0CzIxRZKnNHMcWnIjvY3a5FBF2EbN8MkMacnUSk/OhgvmeaH4eERM5PQDGK
         5CZHRFBi+VdG4+djI2Zlht3oCsIy9f0RF8EYivur7S7uKEtsDIlEsbZVN7qrrXsN6EDi
         ZcadoXBSvwEhHiTyfV/25MRe+KZFtfPmdHAhoOUMMOuWti/Bcc7rEyhaPc9MRtjmN4zq
         uf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0BPaM8FRNxyjrgi80/IHtEdi//TfYvYEdnlSUnsg7I=;
        b=mWDS8R8cUXJ0G9A6wRfIMp806ffOc3tTZ+GlISFkVG5AmEDbKlI9+7l25mBqkZiLvE
         kvNPhL6WkOfM4meOX9I43eUE+/+lLvuVYeMxjde6bObKqT39qs/GBKhZstanc1HY6cRU
         KJ6OpwKrz7xB76PeMnY6X2CZw7pcboZGvaV5oGuKKufF1ZHnkeUHuN7bSYbzSm/MZR5r
         b5aQ5CPcq0EIf40v+PsRQBYRzuaU4JlvW1z7NUnxkDJKOXfZeBe8QBsE1os5Cvscz3Cc
         mrv8LvXU33AyXCCAnEJEFVfJXP/Psex4IXC5NbB5umq9Xz9aUYeU7ZJ+yZFi7DCQu0+q
         RGPQ==
X-Gm-Message-State: ANoB5pnM6Gm+Zf+PYX5MVXmvx7jtQ6M1Vc7+ZndYfSHnqSt7XtHT4PnP
	2KdQnJVhvWdvZ9LKBL1y2Bc=
X-Google-Smtp-Source: AA0mqf7ZpKWT+rnFQJRXqI6RoyJMsad3ljcqmFaADVSvAnONx+SpibI0gZuU9nRpmOX3SzFlqznhgw==
X-Received: by 2002:a17:90a:2c0a:b0:212:cd9c:b44f with SMTP id m10-20020a17090a2c0a00b00212cd9cb44fmr11472177pjd.14.1668740521521;
        Thu, 17 Nov 2022 19:02:01 -0800 (PST)
Received: from ?IPV6:2404:f801:0:5:8000::75b? ([2404:f801:9000:1a:efea::75b])
        by smtp.gmail.com with ESMTPSA id y12-20020aa79aec000000b0056ee49d6e95sm1913002pfp.86.2022.11.17.19.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 19:02:00 -0800 (PST)
Message-ID: <354a1247-056c-076f-850c-cda78f00c628@gmail.com>
Date: Fri, 18 Nov 2022 11:01:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] iommu/hyper-v: Allow hyperv irq remapping without
 x2apic
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
Cc: mikelley@microsoft.com, sunilmut@microsoft.com, wei.liu@kernel.org,
 kys@microsoft.com, Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, dwmw2@infradead.org, joro@8bytes.org, will@kernel.org
References: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Language: en-US
From: Tianyu Lan <ltykernel@gmail.com>
In-Reply-To: <1668715899-8971-1-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/2022 4:11 AM, Nuno Das Neves wrote:
> If x2apic is not available, hyperv-iommu skips remapping
> irqs. This breaks root partition which always needs irqs
> remapped.
> 
> Fix this by allowing irq remapping regardless of x2apic,
> and change hyperv_enable_irq_remapping() to return
> IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> 
> Tested with root and non-root hyperv partitions.
> 
> Signed-off-by: Nuno Das Neves<nunodasneves@linux.microsoft.com>
> ---
>   arch/x86/kernel/cpu/mshyperv.c |  6 ++++++
>   drivers/iommu/Kconfig          |  6 +++---
>   drivers/iommu/hyperv-iommu.c   | 11 ++++++++---
>   3 files changed, 17 insertions(+), 6 deletions(-)


Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
