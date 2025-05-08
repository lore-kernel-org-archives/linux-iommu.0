Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0D1EE03D;
	Thu,  8 May 2025 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685332; cv=none; b=hx2zPO2wI6CoiVJfHgEa9dAw9E+KifOxem7GvN+bSAybkSze171wB5D3hgfwt677sueDW93u26zXXGpAehMg9Wnvz16CY+TCHXEf+Y5i8ZPuzz1+eKIX+N+HH206wAYbo6DK2p3AfaNgSWBel+0PA2dYKmMPEiJE+N68BpQocZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685332; c=relaxed/simple;
	bh=UTfT43DfYGsrBz0pan09byc5cJNTiyCIUxAyVV244CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7nSblmb7t0mHwFmz1A4r621XZxS9ReP8grPFBl9plriajr5Wp74cjfwLRxhjTRyaeSWam0421TYYhrCIGpJNZxEKdjgZj3RXVOikXAXJJwpWv0N3fH8MyTrdDHvcSJN5fze5H1qXhmuqOwCXHWC7vhajqzHaEtR8vqOjlyNfpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZLjdB0m; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZLjdB0m"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22e5df32197so7488355ad.0;
        Wed, 07 May 2025 23:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746685329; x=1747290129; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGRiPozPCKlTceAlJbkKm3qZDESryv+qOsVno6iyAH0=;
        b=MZLjdB0m7LK1R358F+6VQirrnVXB/ZV5YiKTA5182z5kvweo9JiUf9IgvO1Y5/cgeQ
         W4W0P+Xpx4U9WJFFE2tr/9SGt0waKrEULow0pW/0wgNxFai5u+/GuJiprlzgTNkk/slv
         GyJ1TyDFFI0+npPK/yqH0hK515Mls6Ji8VhYoM71yk9YWPYLXieVCcnCmnWpNSlYpf1+
         QvZcdbQXlJ++GVWaUKz3q48tTwz+I1jtvAf3TM/mzPwceENwQWJSehQhTsP7ym2Yw6Gu
         71F7Q142quSdw9hX6kMmP/Rky5RMxPePWC3p3VKT98QdNkNNyUa4UVSn87ANbFFa5CYr
         RJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746685329; x=1747290129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGRiPozPCKlTceAlJbkKm3qZDESryv+qOsVno6iyAH0=;
        b=aYdOaOFDgYmqKtsunj0fOxklcZpJZFWpeKxYP2BjUcE3cznxXRh/762VBAVPW4xPPE
         dwN7s4ST/32bwgmVKNVFV5mKrSiSqUCwvbzrRpuk08FBoBWaBw7evkXmtaBkd9I2pZZA
         gN93+QHBb4krAuC91211DLXpYGDUO4ve8CmY25xPD0RaPT6SzX6+udAhvco3T4qqrTN8
         4oNHI8cqrCGzFgo2+PYy/WH1pm8XurhM8SyvorCBsKwmLvcI13Ybtux9aXNxn1jOLECd
         AflMJdkMp4nWOBxYQEEuVSfSSqV0eTxFV/tPeSX98OKlRXA25QCnOM51NI/t55e/2HPc
         gdDQ==
X-Forwarded-Encrypted: i=1; AJvYcCURciK/Qz8y3ol8XSoNbWHvoJEj6RobazrNFTLzeje6ajrdmiAJKyqVT428+lt3uXzaZmxASw==@lists.linux.dev, AJvYcCWUujeBYupE7SAh6ngLo+Z0IhCtSTJBCACEdCvf8MTkd/uZXe5mX+wY5Vfp11/vSnpTxXFajGnJ3su1Wb8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzXxaSWxyXc/XjhedDymclshMUIZW6BC97GMzQ0kYC6gkfciEPi
	IpJ82N08M1T9Te6/b+xp7UG8o5xTUtB0a/CKp+PDEgwDUImdnU82
X-Gm-Gg: ASbGncuQV9P575uObgN7WkJLxNpP/Z8gJnEwXfSLNrXzGXOdvCegUfwCARt4nqhGlDf
	95ucUSIzRCgG5QO6j5MlguwS6P/Tgvz4mO8W/nYqYrXbMiiH+ACVnPIrwWzrlyYeg0GGY8BsyJ2
	GBShch+UE/LzQQbk76kDr7uAE8EzBq1AXmKNqakLDDFOqtJoGLMDILL9ev7lfBSzZ31Cll7Z0au
	QC1tRjcdq4BD1Qf0hD/btJ0atXo1e597NvDnRpJNKSewj6o38xw7MkATq7h6yicXes/pcyd2bRB
	TlPY3fMcVoDft5C3xgEf+fJKiTV+VcFxJoPYWzdPF/j0M4Ooptdd
X-Google-Smtp-Source: AGHT+IEzMVc56iAT+a/tMSCcX9N+OfWHSiME3hDRqUVurDIzobwAS9xBHQ7vI2Z7UkKgma9R7jLLrg==
X-Received: by 2002:a17:902:f789:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22e5ea643bamr92011055ad.11.1746685329124;
        Wed, 07 May 2025 23:22:09 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:61af:8a13:a547:7dd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229399sm104436315ad.187.2025.05.07.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 23:22:08 -0700 (PDT)
Date: Wed, 7 May 2025 23:22:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Aditya Garg <gargaditya08@live.com>, 
	Berkel =?utf-8?B?SsO2cmc=?= <joerg.berkel@bfh.ch>, linux-input@vger.kernel.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-spi@vger.kernel.org, lukas@wunner.de, 
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [REGRESSION] applespi from 6.12 onwards
Message-ID: <n73jgymwf62kfexrwrhpz45lrj5pc7e4x7m6otbvypctlowjdl@ztaox436vezk>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>

On Thu, May 08, 2025 at 10:15:31AM +0800, Baolu Lu wrote:
> On 5/8/25 01:07, Aditya Garg wrote:
> > Keyboard and touchpad stopped working on several Apple Macbooks from the year 2017 using kernel 6.12.xx . Until now I could only find this discussion affirming the bug on Debian and Fedora:https://github.com/Dunedan/mbp-2016-linux/issues/202
> > 
> > On siduction I also tried the more recent kernels 6.14.5 and mainline 6.15-rc4 (from Ubuntu) and the issue persisted with my testdevice MacBookPro14,1 -- see the relevant output:
> > 
> > kernel: platform pxa2xx-spi.3: Adding to iommu group 20
> > kernel: input: Apple SPI Keyboard as /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/
> > input/input0
> > kernel: DMAR: DRHD: handling fault status reg 3
> > kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> > kernel: DMAR: DRHD: handling fault status reg 3
> > kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> > kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
> > kernel: DMAR: DRHD: handling fault status reg 3
> > kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> > kernel: DMAR: DRHD: handling fault status reg 3
> > kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
> 
> It appears that all DMA faults are related to a fixed address,
> 0xffffa000. Is this address something special?
> 
> Also what does below message mean from a SPI driver's perspective?
> 
> "applespispi-APP000D:00: Error writing to device: 01 0e 00 00"
> 
> I am asking this because the IOMMU fault messages are about DMA Reads
> (device raised memory read), while above message complains failing to
> write to device.

When sending a command to the peripheral device applespi expects it to
acknowledge successful transfer with

	static u8 status_ok[] = { 0xac, 0x27, 0x68, 0xd5 };

but we are getting "01 0e 00 00" instead.

See applespi_check_write_status() in drivers/input/Keyboard/applespi.c

Thanks.

-- 
Dmitry
