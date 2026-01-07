Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com [209.85.161.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6685935EDAD
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767808310; cv=none; b=EvDjrScvG9+3cNm3DAZ1ySHNoFpof80fEMWGk6Zwstqd4Vo6NIj77grdVQDZRpYqThoL86oUyZnvBAUYqb1XxTR+tfPTMF1QrDjErUNv5QyJl0DnxaNWapYvoc04n4Z91vRVQ0SNT3VeY++tibbn6yowvnY0GaPRbc8CQa65djo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767808310; c=relaxed/simple;
	bh=RcoDYlucZ66l2Sfv7PYDyJOdRnPBCeYpyqcCKNIchCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgfovdzvZ/mKJhSR49GBfhiapNMAi9TuXyjE7SNIbFzu1cHHiqEAP6dn2xyRJnrxuFiOW0iviLiwwWiTAk2UomqhF8LCpUxKFVhZzX9Km7W+XdK3//rMRQFlaylRviFwd4IrYJt0wd1fFmuL1CB1v9lj0ESB7H7RuUrzEqhPehE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TIMwzyMJ; arc=none smtp.client-ip=209.85.161.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TIMwzyMJ"
Received: by mail-oo1-f65.google.com with SMTP id 006d021491bc7-659848c994bso1166266eaf.3
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 09:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1767808302; x=1768413102; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/E5kiVoPjL6HPjfNbHsUE0ncuM+O4VtxgKzooyiAI6s=;
        b=TIMwzyMJVNJDuikYZTSbBoqj1oGrOkxaHjkpFv/OT98oJv3SPXGU6F6kLkswc2v6pT
         rDOZje2MlH113thvlI+S2cre/eJ9odN4TDCz0fAmnsGUBqLXcbx9x2+fibI2cJDOYPe6
         wHLZLYmmquK0xLPqe11Txlbixa2ZYudBNRny3AHa8ZIK1svfK1izN2li6Y2gz0yy8cYi
         kzrXVVWXyuaydmNcxqmZ0Jtw3aSMbRh19AjAVniAvKckjg7SY88MQucR4a2ZJDH9fir5
         LHrKbXoiz5UaJJZsqSXI2+9+KSBLnRB46e9bNRwsHd+XxmdPWDoiBjgv7BC8FuH7974Z
         WnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767808302; x=1768413102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/E5kiVoPjL6HPjfNbHsUE0ncuM+O4VtxgKzooyiAI6s=;
        b=vSUsOAYYYgiHWf5kWySBfYVKeWm/CoecthmONC6wvosnFiHq+74PvyWha1G3GqsbxP
         iK6VIDpSAFUTous4Uar3ObPeGyuyBtLBJQlbJc+Tw+/KfiZPuhWZlagCMJEXA3vkoWng
         PSLsrUiTuPCI1LX/jPdgSBFrMoNawXJ14wIW4tiKU1M6uYZSzMCp+2qYrgGuz1hHujk9
         oZh9vkytibKGw64R6zw1g7Miu363mvw9sKrFJuyugzMIw1tyqXNGRCzwjkFf0T1xZjbG
         ibyGnpURLvGP4yxOEdZlzcSm6MPNfWB2kyvXUp7EDkEiTSj6uG8IdMtKjY5Lei0s/80C
         bjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV98OeutTlJaqOfQH8ZE8pDuI/+CkwBCA6m0xk/G37qt+O07GUnPd3Gh9H2qUS0QeqM1J0oAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLcjeUiQHbE+0+pB8OLgYrGXB1ib1JmZbKH8DHUJoTAL27OHTM
	3nm+mMpCWbdok9/6Bqzh8MpZJV+uslL1wZqbeouk94Bz+ltqOuOaDS2YiXnEbGfUOxI=
X-Gm-Gg: AY/fxX71ewt4t1Q5N58TP3A/xSvu9Lpu+62+3e9CvEujWmtagLct71oM6k6ovoZE6lY
	IP/sDWXpTCcjdLwpyVz7Oe8L1UW3MT/l40cdlV6jaXBsnkKIBbD9q5629Lzx0ZvhlhP5mO0jXmz
	S0ibiGCFb4pKT6eraXlKawwD2v8q7qjU0GFfhvoUV22E19W76035HPq4ZW8ef0Q21RfcGIcKSGV
	BXnaUr6vC1L75xlL/0V1tc78otHrrlLbIHPjvnM07c761OfKGsxY/ziS/7rx10N4Ed8Ol+VHAOC
	o5NXc9OnylEdKMLYyGuNtK+DRwK5tm1Kzmy+PInT4LX0InkWLHarbdqeEtQ00ut+XCFXhQjuiCx
	gIK1dFmdh0kAn2KslXFnQEZ0uRWtmbp1+JcazpRpLVYGUEd+cldkZJ5edNCnyhLECMxP5sKicn4
	JN1p9taA7LhtVA
X-Google-Smtp-Source: AGHT+IE13osf5CjYyTbx4kUFVq9/wdcOC/ch/TW3ja8QBG6H6cD6+EWQcns0Lx1kzYLZNwCYibHqkw==
X-Received: by 2002:a05:6820:2204:b0:659:9a49:8fe1 with SMTP id 006d021491bc7-65f54ed4064mr1332868eaf.14.1767808301928;
        Wed, 07 Jan 2026 09:51:41 -0800 (PST)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de8cbfsm3524574fac.3.2026.01.07.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 09:51:41 -0800 (PST)
Date: Wed, 7 Jan 2026 11:51:40 -0600
From: Andrew Jones <ajones@ventanamicro.com>
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Zong Li <zong.li@sifive.com>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, joro@8bytes.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Anup Patel <anup@brainfault.org>, atish.patra@linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, alex.williamson@redhat.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about RISCV IOMMU irqbypass patch series
Message-ID: <20260107-dc4b5f1d879db9afb00a4a87@orel>
References: <CAPYmKFscKJ1ff470d6YmuMxLdJPSZ-ZmuGMMAFO83TT-vvV2JQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPYmKFscKJ1ff470d6YmuMxLdJPSZ-ZmuGMMAFO83TT-vvV2JQ@mail.gmail.com>

On Wed, Jan 07, 2026 at 06:01:26PM +0800, Xu Lu wrote:
> Hi Andrew,
> 
> Thanks for your brilliant job on the RISCV IOMMU irqbypass patch
> series[1]. I have rebased it on v6.18 and successfully passed through
> a nvme device to VM. But I still have some questions about it.
> 
> 1. It seems "irqdomain->host_data->domain" can be NULL for blocking or
> identity domain. So it's better to check whether it's NULL in
> riscv_iommu_ir_irq_domain_alloc_irqs or
> riscv_iommu_ir_irq_domain_free_irqs functions. Otherwise page fault
> can happen.

Indeed. Did you hit the NULL dereference in your testing?

> 
> 2. It seems you are using the first stage iommu page table even for
> gpa->spa, what if a VM needs an vIOMMU? Or did I miss something?

Unfortunately the IOMMU spec wasn't clear on the use of the MSI table
when only stage1 is in use and now, after discussions with the spec
author, it appears what I have written won't work. Additionally, Jason
didn't like this new approach to IRQ_DOMAIN_FLAG_ISOLATED_MSI either,
so there's a lot of rework that needs to be done for v3. I had had hopes
to dedicate December to this but got distracted with other things and
vacation. Now I hope to dedicate this month, but I still need to get
started!

Thanks,
drew

> 
> [1] https://lore.kernel.org/all/20250920203851.2205115-20-ajones@ventanamicro.com/
> 
> Best regards,
> Xu Lu
