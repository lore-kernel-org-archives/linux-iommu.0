Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42A33002CD
	for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761403967; cv=none; b=bPhY4nzQ3TrJF2wgiFqCYy0BIyKkGgujE9NrEcUw1fEI/H0oaWn1K5fVSJR4QONemAQCqckoiKp5IWeZiX+S+o1VKByUf0ZvUTMkf1VNlGYOfKkLkdHBtbKB/vgsi+P7pb5irqgJTe/+Y/z6kukCu8Gyfjw4WCmLZtRFPs6Fypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761403967; c=relaxed/simple;
	bh=rxkH9HqQp8MJpuSr9SUPPrL1eIBYUI8t2HD6mPry1gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xqs9GuBwEM1QQor/V8lBWwz+D7qbbJ/kKkwi9zNEKV//zu7+KMDjgGXOm2hDIv5UOhr96Kv8DCAEJ4w9NF8oCICmFTB1l1R1829sHEXpVc0MZVOwLACoVI3fg/Cw1pU6cdLNVrrn+u7ZUBujEApbpBdqBa6Wil2+u/PsHc/PUHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=gyTuKpDl; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gyTuKpDl"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso4933366a12.0
        for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 07:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761403963; x=1762008763; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rxkH9HqQp8MJpuSr9SUPPrL1eIBYUI8t2HD6mPry1gY=;
        b=gyTuKpDlC7h/8d+8pgTfoWAWqWRXJJL1Xk6JRhnU8eshfqr0Qeo88YQDvi/rTLj6pY
         GrXTpS4yRFEEg8Z/fHItlCIReTO+Des8WRUxXPCrkvafw6gYztKgqc8961xlrnMveETu
         8J/UwcCF3W4pgMoYAxN/Yg6MJ01jk7B92mwPhTXjONi+EKs6X2gnE4WM0njSnvUsAz2d
         DddpD4TNsC44taEes7hs9qgLrEpBrNkKTsjsuNqQoruqP2iu5NcF5evWYYJr74QKUGaQ
         s13R4X0qIpVywmXO4KAhAcrZsAsO4EOB/TUCefKINIiapbojkqLD3TIqa5OiD+S8yHBy
         bbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761403963; x=1762008763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxkH9HqQp8MJpuSr9SUPPrL1eIBYUI8t2HD6mPry1gY=;
        b=ZQZTwHrk6mhRhCHqqf0FWvpXTlW6UX21XyrGtCfV19L7Hrs+Li6u4hH1xVLzfF3a1b
         zVP5ATMSWu6xqYrGjMZ+7uhVtWEDi7uLn5WBCFUMalR4+oCrTdzotQSnIw0XpWvah8VA
         eLRcwg2E5om5gyEKPF4Z+vFtxh+rDQXqr5PHrssse8niKJIw7J9lsz01a8U+egoADy1m
         aH1hZGBfcjiT59fZXuQ3t3ExwqmUrDLkIMluqCc02nu6qDgIzpGJAoNBWBQGzNIHNAi2
         kCrcjjgGV5y0gqR1aFFKpS7P2QrZ8RvOlGWKAs4lRzU5TkPUC0LroGCEcZ17uQtholKN
         ddhg==
X-Forwarded-Encrypted: i=1; AJvYcCXzp9yqCMc4m2Zi4AGw3LqAp0XXlbHniRwfyXldcUd6NKjeiCKaUQgm4OPCxThOop5z0tPvqg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyf0VTCHsu1CnfzimI+au8PI6AofB7NPw+il+3wjiAit34+ir2e
	LqJJrZ+E68geufIeglqEIBVOuznvEFxfUD3qblNurPD3BlAJpKLS5b3tO6WYUHfx22rAP0Zmstb
	qlMgRhv9UhWnADgPtOdgxs35h8nk8AYAmp9pG8FVZbw==
X-Gm-Gg: ASbGnctzkHJU9JcGLQbWFLDSbYJYAM/cx+l52uU40YQnBwkrqbTwYlm96GyXXzW+6d8
	L2NkUaNvwyMa5UhS+rPGlSwBd/ISfZF+SxeFi5Cfab2NZDh5+d1TzV3Biaas2H72UrnD0uVN5+P
	99HxcHG8zG2herlI6waf2fUQ5M4ha0c5BGQlU28WSdXc2CArWWJSMLXTk+4b4XdcUEFWFxkFtE4
	GABupCyjNs9BU9y7uvMEyZm+TMQnWPDx/FZ3XLsQ5JSBEUpLJLLeNkQGYLoo4jGBhTrW3FQXsZ0
	VrNQRWD0+P3r1JgCWntAOJs9cBv4
X-Google-Smtp-Source: AGHT+IEEmtC5AP/1Gyl7o28TLb62A6fjQmpgJI/nFlghPy3b8TZfgzFAjEpwZUdPvlcd5pyK5S+BLKOml0q59+GzhB4=
X-Received: by 2002:a05:6402:13ca:b0:637:f07d:e80f with SMTP id
 4fb4d7f45d1cf-63c1f58c0d3mr30957969a12.0.1761403962844; Sat, 25 Oct 2025
 07:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 10:52:07 -0400
X-Gm-Features: AWmQ_bllNz8YycDjixpyqg8hZuOQcw77RRZ1nqOvRZhBjS1lHQKHtPcetSr4uhE
Message-ID: <CA+CK2bBvCytQhJ-DbgBDUo-MT0xtuXNW=yzX3StwaNUj=JfnoQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/15] Consolidate iommu page table implementations (AMD)
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: James Gowans <jgowans@amazon.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

I tested this series via iova_stress [1], on Intel, AMD, and ARM
machines, no regressions were detected.
Tested-by: Pasha Tatashin <pasha.tatashin@soleen.com>

[1] https://github.com/soleen/iova_stress
