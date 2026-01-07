Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02491284694
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780099; cv=none; b=nAzov7Hu2jPZBc6P7jWAzWp197YJ4u1MjXqhM0/vS8D64Nvgu94VuyMuZ9jtlVWA/IGWl1GvjaLTaBHEqzQEDCVPFC831XiboPOGbfdSfhj0t+p6s7aRko5JY9gi/JtX6g6aVDR8KYdnNynnkGg1pJ4E34CcMQxm/aBNw2gVBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780099; c=relaxed/simple;
	bh=1e7HzwoffI5S/6V5SheLWTLvf9f05N/KDUwstam8N0k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JKZbyPkN6LiZWmZ9jpVdvAvhs5LLTMq57dM/gPJvtDnxsN3OD/1jbGpFljDeZK1ww4VEzr230LT/4QkisQJIHZlP0Jg4tHHPtSljGuut8LTn+HtBlw+sqEMJGbNQTmyEA8LEBcIo9dn3nYVd4I/j0u+grSNfnJuR0ieOOp6UEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DfaOdHpE; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DfaOdHpE"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-941063da73eso1236704241.3
        for <iommu@lists.linux.dev>; Wed, 07 Jan 2026 02:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1767780097; x=1768384897; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1e7HzwoffI5S/6V5SheLWTLvf9f05N/KDUwstam8N0k=;
        b=DfaOdHpEyvbFAxECC71HBb4atB+6N8Jx+2tBaL82CEyUouXHK35W5CsUnKYq2TiG6Y
         ZM4uzKdAkHQ3btMy3HV3gfAuClhavZEisMDVVTq3g1PODvqhNJT7dfDxFbxzUowR+EhY
         QKEkEgO/uPwSQwNDvAfh3jjloeNu1nQKoG5hROdWHByew4LTRmJWobe2yL1PkJ7VbaRB
         /894cGcZ+4MAY75dGzIQar6bnSKzm/ENcaYTHc5P7d+pGLrcuhy1z1DwZzkJXNuejLxj
         YMq9jwhWSimLqd4/+N4kGDz2VXQRF30UndI00nPUdGOOzjq6QhdpkmTlUJklwKcno9t2
         vTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767780097; x=1768384897;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1e7HzwoffI5S/6V5SheLWTLvf9f05N/KDUwstam8N0k=;
        b=adL5UJetevukGbajjzEi7DQE+poMupp5N2Ayl5g64qiaZUrdrOSQuPDNQmno3UFa1I
         1j/V0C+cHuoTyelAkC5n6ilWsfyzfGH1BD7BDmTDAOlYz2Wdc2GbK2qSMqFrXKmtltM7
         eLECGEeh0ByFx36gWZZ3wkLNmGzKRw3bqdYRsSmFFG7KuSdQ16nfua82SbeYhYgByx2o
         08qqtegVGfVAwwySwx/OvEcnSFbq8YzfxBLSCGzJVKyed2IClBEKJNlYPMHnoTyoPuGi
         hCKQgFN0KQNJshpfl44z7+s/UJ1UmKB3B8xmJ64lhPm1iA3GG7PzXXjt2R8RFW/i8GOl
         AQfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHdoY70UpOMNAdYuR5+Y5fgSxdknPpF3nGjBdz/lDZBCubNbnOBpDaBq3Z4A4CGDagpy9ekw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTOo1AILjTC8k//vFt9IDycJhPOwu6WDd+R7tuvrOxPN6L5pZz
	2khcvkNGkuu7/3vAFr7tEfXMIm7sF9kr4q6BM7s0Q2XXfK7WmxXW10QQbXHP9DmnR9QwNDR5sqH
	OWb5zHlaIMvqZmL1/gruAkyMwqqx99v2HkV4GAB6Umw==
X-Gm-Gg: AY/fxX7VJ99P1lf30jTCafil8das2fXJw5KiZFaZwByBOUkX8V7Wg5vtrbSyLnLohF2
	NpITLLine5aNXHFrWGJ88Q7UTZ05sJWtJSLQqFqWfiWd0T4ImXpjOVWrYI9rane+16hVH2QU3mD
	vhEzL8vPcyvV9Z7fPexg5kwMccnc0DgtMLO8s3/fXgpq7TSx7feC4JB8PMeKfUp4XoH1Zzfs372
	EtUHbJtVpeQ42eyYx4hIWykh+FuwwfOic5VZ/dMLv0EoP7dEXpeSdiyXWgHvTcvAwB7e5sxeqjs
	Xpox1RyL
X-Google-Smtp-Source: AGHT+IFY9o6LoBGhJfHFhrwQmRjYbAjez+97Fc8MV2H/JqEGQGgiF+2CT3xNTtCeZryZYDcntgXs7hAyuiU8xea9t8Y=
X-Received: by 2002:a05:6102:534f:b0:5db:34b5:318c with SMTP id
 ada2fe7eead31-5ecb6955532mr709984137.45.1767780096723; Wed, 07 Jan 2026
 02:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 7 Jan 2026 18:01:26 +0800
X-Gm-Features: AQt7F2okIYDpNGyBgdlwrVkXSKzrOvkkA7_TMkO--kZnCCpAAR9jkMnVcWZBt1o
Message-ID: <CAPYmKFscKJ1ff470d6YmuMxLdJPSZ-ZmuGMMAFO83TT-vvV2JQ@mail.gmail.com>
Subject: Question about RISCV IOMMU irqbypass patch series
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Zong Li <zong.li@sifive.com>, 
	Tomasz Jeznach <tjeznach@rivosinc.com>, joro@8bytes.org, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Anup Patel <anup@brainfault.org>, atish.patra@linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, alex.williamson@redhat.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, iommu@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Thanks for your brilliant job on the RISCV IOMMU irqbypass patch
series[1]. I have rebased it on v6.18 and successfully passed through
a nvme device to VM. But I still have some questions about it.

1. It seems "irqdomain->host_data->domain" can be NULL for blocking or
identity domain. So it's better to check whether it's NULL in
riscv_iommu_ir_irq_domain_alloc_irqs or
riscv_iommu_ir_irq_domain_free_irqs functions. Otherwise page fault
can happen.

2. It seems you are using the first stage iommu page table even for
gpa->spa, what if a VM needs an vIOMMU? Or did I miss something?

[1] https://lore.kernel.org/all/20250920203851.2205115-20-ajones@ventanamicro.com/

Best regards,
Xu Lu
