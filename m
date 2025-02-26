Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B3E219FF
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 00:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530125; cv=none; b=BbCT2+wTlr8P5Luc2sNdvgwQltl2Y3XIvJ4+tlTzDRj8dm5Szlkt0AH8nNmbCeBFQccew/W1dJmc4tEkolU6YiRwCv03XIZGqlyg1Z6pOVmzbTwEC3DR3iBu+ZeffOKMmSelLsOVl+rUojoTVPKUmbULUU4NHCXNy8iJG+BmxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530125; c=relaxed/simple;
	bh=WXk+NSNdAwFqqx+MVizfGGgWgwuhd31Tk8ZujVhcpSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l3LL6MFOEYYYT56/JxgDV848vioFf2CICBLiZXKKrfx96MHqr59wztWIXuJTv1PhVP+yzg2EwRIffh2EWFfm5imBzlx+FW73cLRbP7VjMR5vr3cR5ayiv+pe4piFf19IKrw7UGGo4DvXzLaHk4dGWk138itpGFvpNQqxYH6xRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YySzhMxM; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YySzhMxM"
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-aaec111762bso441644766b.2
        for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 16:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740530122; x=1741134922; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2sWr60tesWUFRYFPqf/atpsmtwt+NxovXy8XB/PMBUs=;
        b=YySzhMxMQYbMkDD3GPf0IH1gS+L6/HRpbXO9LGDcKeHtFlUIf5cSCDO6KOMgoXd4zU
         LeMnV08UZ9BX6Pc2cfABEb9mzHpWrjB1QJ11J3OicV4ERIfDqGsDGxKhb5bF7etc7nu5
         XkWeIEwV00V41UM4XGAecFYYUpngjy+OS7kJp8fgkEZwTMRcDeVYKNpRRxuYskNxQsXD
         8YQv1MswgG7KrSB75iyfWfQgHL05obExhc/NPcycD1Uq28i0IRGUjcGCfCsyOWAxSBkU
         QXSMkNywH41+EQAvvE2EaPIv9AqCTPDBDgd4hp8Sr8hIrHnr5a0k0KrPW/4MthCmc5Mt
         mIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530122; x=1741134922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2sWr60tesWUFRYFPqf/atpsmtwt+NxovXy8XB/PMBUs=;
        b=Xa+JeYScdRVnqDJfG+nppc0+rzAmvHkLy51MXwqGpiVrpqUV9G1uLScPq4eF8kidYg
         fUvxszahV1rPoF/+bUaIWea9FasCSniAHcawjGUKOEhlpnmo7/m4NggJkCf8pDFdrZDF
         R0zfY8YB7V107U2aBxeeETigP3lGmhR8o5G0BCrR9air+vQpJem+fNwq8vcjLfxqq0d8
         cq9nrVQ6hS6qxomMVmq+IlOLFcl6awiFdfbsf5i/+aV3vJKhJqDXs5SPRQ2f2xWI5v3R
         cyhXrsdqR7ySqR0wPMi08pOGemCfvBDsEtFW40Jcn8lmu3Y+aJ5/pBPp3Q4F8WKgblGl
         HYQA==
X-Forwarded-Encrypted: i=1; AJvYcCUEQvjH1fnS794cPQ7AGVeNXMfsY4r/wUrnTtUAJmUxLagkt16ensBQT8eBpjMWuHOwXXjkvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw7btCC/8b1D7mzLHoK+vMSCx8P2GM+hxyopCcIahjfJ0zNx+3q
	1Sr6Rxu4/jN9Zyxs+qVllDHEb6BofijTaIDXo73FdG8bWkHCZUnC
X-Gm-Gg: ASbGncsrKEc3jGmnGXZ+YGsQJBEBQije9RVhmJqciqSXlICBrEqlQduxOrhX7f42wvk
	XPAC9oyzp60YktW/XCoq90e3JP0HM19moxJo4wHc3VVFs4M3EEeg5bhHVGOKZittChcEcuYv2j8
	Q7jS+Tis9ekUZEvhNwfaJVCKYVghP2n7rkvXroGZLuPfdEsUJuKSbMbO5i2EUgDRGM/bhvXBrIT
	lVB7DZq+b9QW2YgyZWzJcLOecScofgExa/YxCGaQHji9RuZWLxjoCnPSqTc6xMjW0NjmQQAtrGg
	jLIjqC+23OW8vu01hhXeewx+jAvvDce7kO+6s9/1ZIbEjL69byZpP1oeeBkUCdXQxGGrg5+K5N0
	8tsQDLMPAY+QSfV0WMyGblD7FdVU1V/7gXFLsuexJEIoVaDHu0pr6HkY=
X-Google-Smtp-Source: AGHT+IF3XIr+VPlmtfyD5U0Gg/aRmrzOoS9BOhDrJkrfSsducyRIXJb03Wm06EbWrn1gJBz30qxBmA==
X-Received: by 2002:a17:907:d8a:b0:abb:aef3:6052 with SMTP id a640c23a62f3a-abeeef81b5emr99428266b.55.1740530122412;
        Tue, 25 Feb 2025 16:35:22 -0800 (PST)
Received: from [26.26.26.1] (ec2-3-73-218-181.eu-central-1.compute.amazonaws.com. [3.73.218.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20b5cc5sm226238966b.168.2025.02.25.16.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 16:35:21 -0800 (PST)
Message-ID: <f77cc212-deb0-47a7-90fa-8d76bc891564@gmail.com>
Date: Wed, 26 Feb 2025 08:35:17 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Jason Gunthorpe <jgg@ziepe.ca>, Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250225142610.GB545008@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/25/2025 10:26 PM, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2025 at 04:54:54PM +0800, Ethan Zhao wrote:
>>> On 2025/2/25 14:48, Yunhui Cui wrote:
>>>> We found that executing the command ./a.out &;reboot -f (where a.out
>>>> is a
>>>> program that only executes a while(1) infinite loop) can
>>>> probabilistically
>>>> cause the system to hang in the intel_iommu_shutdown() function,
>>>> rendering
>>>> it unresponsive. Through analysis, we identified that the factors
>>>> contributing to this issue are as follows:
>>>>
>>>> 1. The reboot -f command does not prompt the kernel to notify the
>>>> application layer to perform cleanup actions, allowing the
>>>> application to
>>>> continue running.
>>>>
>>>> 2. When the kernel reaches the intel_iommu_shutdown() function, only the
>>>> BSP (Bootstrap Processor) CPU is operational in the system.
>>>>
>>>> 3. During the execution of intel_iommu_shutdown(), the function
>>>> down_write
>>>> (&dmar_global_lock) causes the process to sleep and be scheduled out.
> Why does this happen? If the kernel has shutdown other CPUs then what
> thread is holding the other side of this lock and why?

The down_write() actually executes might_sleep()->might_resched()->__cond_resched()->

__schedule() first before acquiring the lock, thus there is change to got scheduled out.

The caller is scheduled out due to voluntary sleep or because its time slice is exhausted,

not because the lock is held by other processes here.

>>>> 4. At this point, though the processor's interrupt flag is not cleared,
>>>>    allowing interrupts to be accepted. However, only legacy devices
>>>> and NMI
>>>> (Non-Maskable Interrupt) interrupts could come in, as other interrupts
>>>> routing have already been disabled. If no legacy or NMI interrupts occur
>>>> at this stage, the scheduler will not be able to run.
>>>> 5. If the application got scheduled at this time is executing a
>>>> while(1)-
>>>> type loop, it will be unable to be preempted, leading to an infinite
>>>> loop
>>>> and causing the system to become unresponsive.
> If the schedular doesn't run how did we get from 4 -> 5?

We got from 4-->5 because caller thread's voluntary invocation of the scheduler.

>
> Maybe the issue is the shutdown handler here is running in the wrong
> time and it should not be running after the scheduler has been shut
> down.

Move thex86_platform.iommu_shutdown() before hpet_disable() ?

I didn't figure out why we need scheduler is active when we execute

iommu_shutdown(), or the reason to keep this pair of down_write()/

up_write(). could you help to shed light ?

Thanks,
Ethan

>
> I don't think removing the lock is a great idea without more
> explanation.
>
> Jason
>
