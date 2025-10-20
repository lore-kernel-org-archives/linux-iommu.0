Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8C219E0
	for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760989636; cv=none; b=G1+fYJ1K2wFz0cFt6vnUK84ZtMJkoHUlt3evFFYAy0tWyDaHmdY2gCw/Eg2AzkbzY5JNzMiEKOKC+ShZMvWz/kqGSh1UAIe5rkqES4xNTdN8PAEstEVnOvUzLrKteQ/nhSjZK1uefNaTp5kunlFbR+T2IpTKjAM+adDbTGP//RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760989636; c=relaxed/simple;
	bh=Zd72u21sHnlUwvSbRt1SRLx/FrPMlp6pbPmb7VSQ83c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cO4s0vLRGVZgJMNYiP/y8FZTYLF5G3dLVEfZ7M9NOmeXoqw9Iz/Zjxbfrqz39vyWomMguhXURZNYbxgicdfIZ1REl+2m6vldB/E9bTf1kUO2pLosRi3V3G1nWOoUx60Sojuun3QADbYMJqNX2iLd7fdQ3/YNBUAEuDhgwMKEx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=VTP2AdQg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="VTP2AdQg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-269af38418aso57315435ad.1
        for <iommu@lists.linux.dev>; Mon, 20 Oct 2025 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760989635; x=1761594435; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T29G72fExJyk8VtqV3YJi7ZBrueGLIkeAq2lMcMuWYA=;
        b=VTP2AdQguHDEZJsjNb0bHxFtMoKexcamX4f5ag59kI+RFwFj5C9fMudqB3KhzNJP4D
         4QROUWLb95ohzEvAvFN2KuQI5x1o5N8FtnZdC5wzKAjriDZNf4X6M9sp7S9qrR1gG/Gi
         yCmubSMO9jt8brgUBEZiz0Ez8n2WB4RyTYt0glXvbBtk/UMD0ZpyMbLWiRZPcO4zDhQr
         f4xYj/+RCwEl9w7NhacsU6GTS5yKzdkCpVohAZFfS40km5Q/4NkO1yyQyGjcBcxb86uK
         2jxsoDw09qKEDmNnd5p+JGFTgbT/Z13BgX8oCoUi/80wE0q/hRu9u3vJ5kQSgbRw9Bl1
         7mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760989635; x=1761594435;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T29G72fExJyk8VtqV3YJi7ZBrueGLIkeAq2lMcMuWYA=;
        b=JtDbnBVZ+Qp89U/ForgaxtiCMqz+a9A8Q6ZSkag1ZKi4p0nkMYVmWguuG+0E2tXmLM
         NFTp5loSKHNP4lnc72PZciUQeDmEmmznx/TQFGzXi1xbFdwRaR87Q8MRRhSIJtueTCwC
         jYoxyaJOp6qnS0SpJ0vMwQLK5Jbw7GIBehxeNNEDYmblX64S68zdqD7lBy+zHQyxGIfO
         KAC2NyzRHjDYONoCo7BNTHSbBOxij1R9eIXtkeQ1hmWT2Q10OdfGAjwo/dcQY50CZiVp
         QabAlDf0G02t46ojJLJtzZ2wz1tlXHK2ctJ1OLzXsioZ8FzYkMDvt/SKCDlbuagyFkRE
         kOyg==
X-Forwarded-Encrypted: i=1; AJvYcCXUp5mSiowzjo7lBFeWlpKQ4GSDlhZrEkyolsG1DV4em5DseQnvCr/kkuQEHji76kLzRfFd1g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxb61g1R5wYROxxZFJAwEbJ7thwmiJ1mC0DCtTIbI5Yo8J1Kkrd
	zjJINpYF1N0jRZgpMJVmLpPd6q28XGGL5XRD8m0U6LcDNnpxJ6rSQWhQA6/+oeqms5Y=
X-Gm-Gg: ASbGncvTbfcPgBz7wY03KyalPLjN1px7jMf3OdzbHNXSVQOI/KmWckeWF+CF0PD2ogf
	c0rwakeXYhPJkRHiSeqLDCYlrwKc+1u0MPmwLTarmsZQc9lYfYgbX3RM0ZwH5yH7//jQYnPSMDj
	fyyFktBhCsXmgAoONRGVu3iE8V4HpQeffm5Qayq7ekrhWGauZgWFDg7fyzhWQLlfYfmC5rp0/B5
	hRKPzYtBRw02yeC1rC1d4c+7856sSX9uYcYzEt9UMtvEQY5jFz7lEmvWkoFOEf5A00E5y4+nb+6
	zkK2ju6714rpXW/b++MnYj2KfCLLCJ2JlmxW3qHic4WwKrzgeNPQpwfV0zgcqC8Hhf0/WTWu/DK
	65zN4yY3lVfxEf3H6yEcj76Nv5l+mOTBiguaXjFngQFXh7s3Nx6CTxTr0c89MbfbU+Qw2oUK5u/
	KF8wmDDkk7CVPh2c+rY4fiGI3BV69raZl1GiCweYXwlgoreYwZu+CiGdZ3fgCgzi+u
X-Google-Smtp-Source: AGHT+IHbuqXK1u6LquvMt8XAnfwihmyV2uHtYn9qEdWcAtI1wb6x8mv/e+BQVy3+n2euvz+X557SNA==
X-Received: by 2002:a17:902:e88e:b0:290:a3b9:d4be with SMTP id d9443c01a7336-290c9ce63cbmr161125965ad.24.1760989634647;
        Mon, 20 Oct 2025 12:47:14 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc1:8cb8:dfc4:4af0:d7c6:a030? ([2804:7f0:bcc1:8cb8:dfc4:4af0:d7c6:a030])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fd5d76sm88303565ad.39.2025.10.20.12.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:47:14 -0700 (PDT)
Message-ID: <4d1e8b55-e404-466b-a2d6-b189de910637@ventanamicro.com>
Date: Mon, 20 Oct 2025 16:47:07 -0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 18/18] DO NOT UPSTREAM: RISC-V: KVM: Workaround
 kvm_riscv_gstage_ioremap() bug
To: fangyu.yu@linux.alibaba.com, ajones@ventanamicro.com
Cc: alex.williamson@redhat.com, alex@ghiti.fr, anup@brainfault.org,
 atish.patra@linux.dev, iommu@lists.linux.dev, jgg@nvidia.com,
 joro@8bytes.org, kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robin.murphy@arm.com,
 tglx@linutronix.de, tjeznach@rivosinc.com, will@kernel.org,
 zong.li@sifive.com
References: <20250920203851.2205115-38-ajones@ventanamicro.com>
 <20251020131218.68932-1-fangyu.yu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20251020131218.68932-1-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Drew,

On 10/20/25 10:12 AM, fangyu.yu@linux.alibaba.com wrote:
>> Workaround a bug that breaks guest booting with device assignment that
>> was introduced with commit 9bca8be646e0 ("RISC-V: KVM: Fix pte settings
>> within kvm_riscv_gstage_ioremap()")
> 
> The root cause of the guest booting failure is that an HPA is obtained
> in the kvm_arch_prepare_memory_region.
> 
> Here [1] might be the correct fixes for this issue.
> [1] https://lore.kernel.org/linux-riscv/20251020130801.68356-1-fangyu.yu@linux.alibaba.com/T/#u

This patch fixes the issue we've been seeing with device assignment inside a
kvm guest. I suggest folding it into this series and dropping this workaround
patch in the next version.


Thanks,

Daniel


> 
>> ---
>> arch/riscv/kvm/mmu.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
>> index 525fb5a330c0..994f18b92143 100644
>> --- a/arch/riscv/kvm/mmu.c
>> +++ b/arch/riscv/kvm/mmu.c
>> @@ -56,7 +56,7 @@ int kvm_riscv_mmu_ioremap(struct kvm *kvm, gpa_t gpa, phys_addr_t hpa,
>>
>> 	end = (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
>> 	pfn = __phys_to_pfn(hpa);
>> -	prot = pgprot_noncached(PAGE_WRITE);
>> +	prot = pgprot_noncached(__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_READ | _PAGE_WRITE));
>>
>> 	for (addr = gpa; addr < end; addr += PAGE_SIZE) {
>> 		map.addr = addr;
>> -- 
>> 2.49.0
> 
> Thanks,
> Fangyu
> 

