Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057601F2C34
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742551810; cv=none; b=W/f/xADPAR4CaTPeC68XFZD+EHZohPwXG4WxJKodXq/ZFaUfQ0j/0wGM1yz5dwP7UTlOUEArxKM9wgDkT8vGLDWH8464Uz/fOePpOqyDeuWOmj/rlnI7xP59yH6ZPTtP7/bP0tVO3LtiEtBguxJUHE3l/ZYeCiELd30gVoROKTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742551810; c=relaxed/simple;
	bh=cSG/dgb5ouYwXy+0Y8nbWZ7xh9ohZJ22vd/SOyMYhnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzlfOQROGdiRqNwQQIcRPjfqV08o7KedIyGh6GtUzm5SgTr/duel6A0Owjw7Bi+Z9KmYcca22FVLbhAFUMdsFY/vBhwLnHd4lHzZ0weKmzTWcTqs3ud5XBnhVsi8+a+wDH6W1ub+rNLpUMn4DadpEKNg8verstg6J3r0zqjIYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WxWF/NNY; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxWF/NNY"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-394780e98easo1085320f8f.1
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742551807; x=1743156607; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dgadgbfro0Ytl5CzevN3+XSUjzG1aUeGshCaOrB+Y2I=;
        b=WxWF/NNY2SuFno09XE+iEQ+xtNcFj5PqY4hIOA7sS44RC55hPDmq00uoBufgEs1knY
         YXDHa0vppub5t2ZvpCYG8F4n8d3rvhVhw64NDIcsfv9mhZb+SxR7h5y7VL/pqtDQlNLF
         6dIEUTlX3Ms9h/LVyy4V2tj5daUwvSfs3RvJBq8F+JibCP5IfODvrdrCKuhf1l26xuEo
         ZxVVkZhEPeK2KASfM7EQj6lyVj0rU91U63RlAo2DbuiayHbD+Z4b08tGVNuZjNZuq2tq
         F4YAIHy5dklh45bY6/tv68TglIMmsLfRqp4/GfwoxBqSfd0huaWEPgL1+At9pqlAjup7
         zrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742551807; x=1743156607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dgadgbfro0Ytl5CzevN3+XSUjzG1aUeGshCaOrB+Y2I=;
        b=rfLH/ZAxJfJFaVhzopQNS1iE7BfenrU89wA6f42sX7jbo70pojonVjhFTBVO025Xub
         k310uA3PPaDFt9NtDwKoGaAEEKAEf9cqttM8t7as/035gbpxSKUQSlIUWJI48pZL2DwF
         7QtmJiayhi4xYwQMPay2p3nbLWfA5hPf+36Bqcz8u3j/SFoeDE3cRk3gt/KmmQBzJ2NE
         ruiBIeEFGIRohMRW7Fm4HS7ej1dVvOFXyU1iEEZG2PKDi+3bR2Ue2rAmjQPJKOnbQy0/
         FcJ8Cn0wBv5WE/aWR7ckOhJOyoHiS4bSYuVAwbZVZoVcz4CMileESlf/LhT7UxxTdC0r
         gWkA==
X-Forwarded-Encrypted: i=1; AJvYcCWAqDWgYBKwV8szY9UtuE9tKNwEMcy053raZWoLGpXQScuWNy8H63qQibVxNHFOe3RxOZT+MQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1zFXI2U0ytc/5uztFskyilqcyttDCMuG1S1VVxuTmWoS6PoC0
	H63AH6MwcvmHhzUwSlye4GtQ8ekhu+qgws1zFt3bs/GivOBuooMSXKH83xKL0lY=
X-Gm-Gg: ASbGncugmtB7bgkO6+EPvTDgv2v4JGhhwrFzDhTJnoQRTpcD6NG42gwJGq2Sk/tUTdj
	0Q+dDjI9xRg9PAAprLaqAsz3IJ8vWTg9FEWmaRRwYAqCNfbAhc5s0wgjjsnykiqK7+7HMrYw3Dp
	YVSCpC/pJ1tPHnSjRpV8Yb7H87PyifdiOlGM3RKflqSqhM/Il1xR8M6FaYIuGI6YAHZAmN3zBiA
	2BvN/amZ2Ed4ctXdBNPt34+LS3bhMKaE/B0TzMs5JmovfP3dXUsiMvnA9BgkcknCUTrGqOUWLKk
	kjtIYqI4vlNPC0K6ct4D6GGHPc4Lh9S+3dAm8fLXi/w=
X-Google-Smtp-Source: AGHT+IGrK8MOj1Gb5k1VtA3JM/paS+CvdnDZ1/arBk1SWXXHnz0wY0XFwRInaReJTtN9gtF5Sxl8cw==
X-Received: by 2002:a5d:6d86:0:b0:38d:d701:419c with SMTP id ffacd0b85a97d-3997f92da9amr2879454f8f.41.1742551807121;
        Fri, 21 Mar 2025 03:10:07 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e65besm1946808f8f.65.2025.03.21.03.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:10:06 -0700 (PDT)
Date: Fri, 21 Mar 2025 10:10:31 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] iommu/virtio: Make instance lookup robust
Message-ID: <20250321101031.GA3998895@myrica>
References: <9beaed48da83a0882dba153e65e6cfd0a8e21482.1742484773.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9beaed48da83a0882dba153e65e6cfd0a8e21482.1742484773.git.robin.murphy@arm.com>

On Thu, Mar 20, 2025 at 03:32:54PM +0000, Robin Murphy wrote:
> Much like arm-smmu in commit 7d835134d4e1 ("iommu/arm-smmu: Make
> instance lookup robust"), virtio-iommu appears to have the same issue
> where iommu_device_register() makes the IOMMU instance visible to other
> API callers (including itself) straight away, but internally the
> instance isn't ready to recognise itself for viommu_probe_device() to
> work correctly until after viommu_probe() has returned. This matters a
> lot more now that bus_iommu_probe() has the DT/VIOT knowledge to probe
> client devices the way that was always intended. Tweak the lookup and
> initialisation in much the same way as for arm-smmu, to ensure that what
> we register is functional and ready to go.
> 
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Pre-emptive fix by inspection...

I get the warning introduced by bcb81ac6ae3c with DT boot, but this patch
doesn't remove it:

[    1.463193] igb 0000:00:03.0: late IOMMU probe at driver bind, something fishy here!
[    1.464265] WARNING: CPU: 3 PID: 1 at drivers/iommu/iommu.c:446 iommu_init_device+0xdc/0x300
[    1.468885] Modules linked in:
[    1.469835] CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc7-00005-g18abf92a52cf #2120
[    1.470170] Hardware name: linux,dummy-virt (DT)
[    1.470441] pstate: 61000005 (nZCv daif -PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    1.470692] pc : iommu_init_device+0xdc/0x300
[    1.470808] lr : iommu_init_device+0xdc/0x300
[    1.470920] sp : ffff80008278b970
[    1.471022] x29: ffff80008278b980 x28: 0000000000000000 x27: 0000000000000000
[    1.471382] x26: 0000000000000000 x25: ffff800081f49960 x24: 0000000000000000
[    1.471557] x23: ffff0000c156b0c8 x22: ffff8000826f4930 x21: ffff8000826f4928
[    1.471861] x20: ffff80008248d878 x19: ffff80008248c8c8 x18: 0000000000000006
[    1.472046] x17: ffff800082489500 x16: 00000000f8a49ce1 x15: ffff80008278b52f
[    1.472223] x14: ffff80008278b340 x13: ffff80010278b527 x12: ffff80008228d478
[    1.472396] x11: ffff8000821dd4d0 x10: ffff80008228d4d0 x9 : ffff80008018908c
[    1.472597] x8 : 0000000000000001 x7 : 000000000002ffe8 x6 : c0000000ffffdfff
[    1.472773] x5 : 00000000000affa8 x4 : 0000000000000000 x3 : 0000000000000000
[    1.472948] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c03fc500
[    1.473220] Call trace:
[    1.473478]  iommu_init_device+0xdc/0x300 (P)
[    1.473723]  __iommu_probe_device+0x48/0x208
[    1.473859]  iommu_probe_device+0x3c/0x88
[    1.473961]  of_iommu_configure+0x270/0x2b8
[    1.474069]  of_dma_configure_id+0xc0/0x2f8
[    1.474180]  pci_dma_configure+0x5c/0x110
[    1.474285]  really_probe+0x7c/0x3a0
[    1.474383]  __driver_probe_device+0x84/0x160
[    1.474488]  driver_probe_device+0x44/0x130
[    1.474597]  __driver_attach+0xcc/0x208
[    1.474700]  bus_for_each_dev+0x84/0x100
[    1.474803]  driver_attach+0x2c/0x40
[    1.474900]  bus_add_driver+0x118/0x250
[    1.474998]  driver_register+0x70/0x138
[    1.475096]  __pci_register_driver+0x4c/0x60
[    1.475198]  igb_init_module+0x58/0x70
[    1.475300]  do_one_initcall+0x60/0x2f8
[    1.475400]  do_initcalls+0x114/0x158
[    1.475500]  kernel_init_freeable+0x18c/0x1e8
[    1.475640]  kernel_init+0x28/0x168
[    1.475752]  ret_from_fork+0x10/0x20
[    1.476008] ---[ end trace 0000000000000000 ]---

Apart from the warning everything seems to still work, so a fix doesn't
seem too urgent and I can investigate during the merge window (I haven't
been following the probe rework).

Thanks,
Jean
