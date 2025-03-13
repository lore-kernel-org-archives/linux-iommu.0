Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E7D13B29B
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883424; cv=none; b=ljDCf7evlEtvjkMGLESj96sg8DrlLOPL/CKMBiank8rhYgty7S5mlZNbfnHh6i2i2P9OHX7JxfxQc3Bv6b9H3gD141gNFBURcUAZjj2wl9jSeZ1i2SLuuh1bHX46dOoJLuBJjTlg5o7+JICWP7ossVztNiE79idio9w9acgS4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883424; c=relaxed/simple;
	bh=4hhdqF3Rp1vH31nmCsGM4U9PNPxQFzWtChioTmpUmgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4azSGd9qlx1MKjlyaCfcnTpvuBUi4Ois4eaefwJ2sVUc/z28BuVyw9TMJNTJqc4IMbzz7vxAANxFl1WcPanfKyCEL84y4jCvTE7WsxDmIxUfovlTZQO+tHlkBz2VYKFiSA4E8SilNyzLXvpSc7M0UgtYeOecnv8FjsHqoGMuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oBGYtfzj; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oBGYtfzj"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5499ba72f0fso114480e87.3
        for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741883420; x=1742488220; darn=lists.linux.dev;
        h=content-transfer-encoding:content-language:user-agent:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aFrAK725pGLGAzrUp2Rsi/GlBUn5vFqjGk9jd1UKZys=;
        b=oBGYtfzjRYaKLGqN6joTL4x3Pyy+66WK7QeXL7r4TDaWRGGrK7DhJRl7kY63yvrsro
         kHHLTgeOdaS++vfnxvRklMKiGuvVOLT62eCgCKtl6jOx2L3oDaECrOfipDxLdjRxQsiF
         +FjqYNyG4Ie8pdvE1Ip9T+an28U7mNJ+ZPwJS5V23u2fNydjfpFr5fs+COCTUWc2mf6u
         kFG5FJGtH4Gow6P8DwCzPsOTlz1r7G9YDdYK3sHgsuc+BEUmUcQoaGNrOKTkSqsDaRKO
         vrvErjldQsn/A2byJISBXOB0/UQEsXCgRhA9EJjCe+T32kyAgqAqYPRI98yKbUdHbb4M
         iBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883420; x=1742488220;
        h=content-transfer-encoding:content-language:user-agent:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFrAK725pGLGAzrUp2Rsi/GlBUn5vFqjGk9jd1UKZys=;
        b=lXNg1WYzP1wG1IQHrvu7tLd+mpPR8B9slKKIv3E53pt/lm3P7AIMpDmU8OlF4EWEtm
         XJkZJkNfPN3SLtiDnDLd43wRwX6zNwUPOQXmOdl2xoCJOdSLd+ed7SphnZUSdph4upqJ
         2pnCxAcWZxAGud6Ev9nDjJRKwYtTtgL7kiA/NIgKlwp9YZB3vCGNIqR4PmWcP7bDVMXW
         0DMcNfDkBn2mlFtlFxagFYe1yEJpTRykmEzSkBt/uUda6DbCGBlvdtLsoIr40lq1mOX4
         gXcntWl9B0m06zJ47IX1vp/5TIrga2FinBkEMO94zTrEsrUJxiFv6Kj6DTQcBI6z57IQ
         7FUA==
X-Forwarded-Encrypted: i=1; AJvYcCW7A0C5KVUg96bnym8pkel5QNGdCsEjrTyhlxg/K7KtwVPLbKFHMJqlkRbwn/jh7eucxhsDKQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxgYHLIImoUb5qxFKa431U/EVgG4T2QvsVIajtRBnQdEj720HZK
	CqM2s90/reOTKfTlSIA3UavO173901cLw56JzGPf8v11iXauFln9bELo2uqnHB4=
X-Gm-Gg: ASbGncsCT1hDj9K2G0/I3D+2dnfFwSZT6MEXOaGlaJi+0/dYtCe4Gi2VmDXtA5vdDrb
	TEyO+pVFUv4Qi2dpu5eb1yb7rKNC56bh8jX3To2PCozzNgPpFrkeZbcIF8wxL+rctFKlC0ieT5E
	Y1a55MBXdAXfUyVgUUlCoStwVdWyrSlUGsKkdxeSqjyRElRueVBo19yVERv98BVjwwXeaoXkk+T
	y/amnFd8a8QB2L2s8M+cTBJJmIpnuBljI+u/gaY4hzFFM2EfSvrdvWn1kwdF0WSGGqhkJhtoQCS
	6AqQqqq+Xkm3wR1oJcguOGczfJ3/c4nP7uOSHKp+pf9KWb3YTrYFUmMnOm1wz2JdW9LonT3mL0m
	Wu0DFwMcnJp3PMsVqug==
X-Google-Smtp-Source: AGHT+IGtn9WumNOaMuo9cAzRTdloUKB5tTLRLe9/61uA56u97uNJuHXYLD/mRuofS9RqJFSJqixgYg==
X-Received: by 2002:a05:6512:b0a:b0:549:8f39:3e63 with SMTP id 2adb3069b0e04-549abaea8b6mr1524832e87.9.1741883419995;
        Thu, 13 Mar 2025 09:30:19 -0700 (PDT)
Received: from localhost (c-85-229-14-155.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-549ba8851e1sm256528e87.201.2025.03.13.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:30:18 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: robin.murphy@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	quic_charante@quicinc.com,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe path
Date: Thu, 13 Mar 2025 17:30:11 +0100
Message-ID: <417d6f59-0d78-4e81-ad0b-e06846f786b0@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
References: <cover.1740753261.git.robin.murphy@arm.com> <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com> <CGME20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd@eucas1p2.samsung.com> <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
Received: from foss.arm.com (foss.arm.com [217.140.110.172]) by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBD1EE7A7 for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14]) by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D5E1516; Thu, 13 Mar 2025 04:01:50 -0700 (PDT)
Received: from [10.57.40.246] (unknown [10.57.40.246]) by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C60353F673; Thu, 13 Mar 2025 04:01:35 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID: <20250313163011.R_zhEw_IFbqRtIBQPTudfCj6gGklnTTEC_RMZh6lCNk@z>

From: Robin Murphy <robin.murphy@arm.com>

> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
> [...]
> > This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
> > ("iommu: Get DT/ACPI parsing into the proper probe path"). In my tests I
> > found it breaks booting of ARM64 RK3568-based Odroid-M1 board
> > (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
> > relevant kernel log:
> 
> ...and the bug-flushing-out begins!
> 
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000000003e8
> > Mem abort info:
> >     ESR = 0x0000000096000004
> >     EC = 0x25: DABT (current EL), IL = 32 bits
> >     SET = 0, FnV = 0
> >     EA = 0, S1PTW = 0
> >     FSC = 0x04: level 0 translation fault
> > Data abort info:
> >     ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> >     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [00000000000003e8] user address but active_mm is swapper
> > Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
> > Hardware name: Hardkernel ODROID-M1 (DT)
> > pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : devm_kmalloc+0x2c/0x114
> > lr : rk_iommu_of_xlate+0x30/0x90
> > ...
> > Call trace:
> >    devm_kmalloc+0x2c/0x114 (P)
> >    rk_iommu_of_xlate+0x30/0x90
> 
> Yeah, looks like this is doing something a bit questionable which can't
> work properly. TBH the whole dma_dev thing could probably be cleaned up
> now that we have proper instances, but for now does this work?
> 
> (annoyingly none of my Rockchip boards are set up for testing right now, 
> but I might have time to dig one out later)
> 
> Thanks,
> Robin.
> 
> ----->8-----
> 
> Subject: [PATCH] iommu/rockchip: Allocate per-device data sensibly
> 
> Now that DT-based probing is finally happening in the right order again,
> it reveals an issue in Rockchip's of_xlate, which can now be called
> during registration, but is using the global dma_dev which is only
> assigned later. However, this makes little sense when we're already
> looking up the correct IOMMU device, who should logically be the owner
> of the devm allocation anyway.
> 
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe 
> path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This patch fixed the boot on rockpi4.
Applied it ontop of next-20250313

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders
