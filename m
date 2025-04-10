Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697D2144D5
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 23:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328701; cv=none; b=d1lqh9OkQe6KnhLiEoN2MYbfDXTTtdZnAVrI7V/ZsRK7VEtv4U++FvdCnwk1GuaMbWnEW1L/8GxcrGd4jwDVkPZn3UaXA+yQQJ6Vpo/hspJ0kDpPzylfAd8ZWcxqlUgfL0G6LWdYC24Cv11EvGSjfjpt3b7LoRWte1bVcANV50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328701; c=relaxed/simple;
	bh=mghY2rYVvlPDE9Jsz5ZnOqrYyA6SfVM8M7wxlDc8iBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ3cinDXRVq/bGHMYiFpTZJyhjIi/84twWELoyVJL1svQMOuyDCny8EJj3KvIoY2FaeXACLIbZJkwiI3RBD+x6Y141keHRltCYsjBDOaZ22iQcSJ6vFlleQDmt5nWhYXIBSXAkCc8hBnQ+9qhTx/8lfv3gIQ2JGy98rFsKzB/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AZvJsv4b; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AZvJsv4b"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c55500cf80so118523185a.1
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 16:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744328698; x=1744933498; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uBiekUdIFmCYXVIVV+7WWzU3nvigAruofoH1gZDVt3E=;
        b=AZvJsv4b5de+PJ/7FLn3dX7MrKFDYjtzDqg04KXlGL+uOwj3f7JRG4+2iIXDSCIaKa
         sycbW4BTZEEWF61wVYKq07KlAa6loCE410+MYgTGFaD2G7KtwUYtp3EWKd7unNG69+8G
         KFsqOMD73HB34RLFopM/TO6coJHBJWSneUIo1BLSz7Gy0vGeXZEWh04Xq0xITNfOo6Ac
         wQyaLwSh59iOWRhISDQkq++nnJawVGUEm0YBc3wgG5FtW7wuvDmI8MpGUxtaynX1/BWF
         4jU+u0t4y0mLU1wMnJluAWKEYBsppbR+zgurR4rkYsjH3gtG99HNG7H1FwPmplQ+FmKV
         JFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744328698; x=1744933498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBiekUdIFmCYXVIVV+7WWzU3nvigAruofoH1gZDVt3E=;
        b=mEgRrZcX+WcTmjpHX6lFbrOLOJQrqsN6Gazkuriy28CGBSB9tE55bLfr8092IX98FZ
         w1h8fJRhtsb5LdpRppCxGusH7vF5k5cfTnXyyqdjPHtmpWdiLji6FCC6bDIJlWRI+W+5
         Oayca8pvdSKtPjg3oQLB3MQ9XwtAc8Nd0tYyr0IWHHz89InX0DJFCGAOgZfXV92d73E/
         qIshv8L3N9QNpWOKhCTqAoprhj+IwyV3cQ5JdeE56DHbm2c/fiokR2QGJ9ft4pYtN1f9
         LBuKLBSJOQ+4Agz4f47kf2epzTN+kxwB5lQhXShZufhFj28dAlxKiKPcALMCPR696D3h
         VQ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6VEq9ph1amCRAMhuU2GaOjsr/YuJWLICIeoeoswqqptyS8VQ2n0St2IVeHOJ3qHjw3oMqIQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxdIhkriC7nSIzFn4C20LopGxrKSJJULWDTzpeTZTLo+ZxWPuqm
	wePKfyoxSGB8n69uzFrt41U2x6NFNn51ZzOnrk31E4piiq7pZepIp3hOC0/bAKs=
X-Gm-Gg: ASbGnctTZd12y+EMFZ7Eh+nY6TLpLRTUucHg9zWO8TjhSVgqrS33fF0QRxhT59+x7VU
	GSnVYFwtZ6PEyxxfQ9YrX27ijsKfL90kCIhofjTVSEbeTcD5JwIINx7v38IyjrY5WbSNSCYEQ+8
	lis2B+/J9F02LS+tuRQdaleJmd8PnmTKupfG0Dzh/ssTnnaXij7ZjR7zloIY+A60NhIXO8J2Fsm
	HijPCs9cGNPpDosN1I3IM9CPuR/fN42GVQaCsEnDjuR94xd3N2FMxzWUj9MIYiRNcfCbFSsFPK3
	w2UFD2C/GqTdQajwwDzyNZ7eYqGCJLpOuNrOly22FeigwbanLbJI/k0GDNwRCOOcS550skAifp6
	R0gHgjEbr3xgKp570Pcg=
X-Google-Smtp-Source: AGHT+IH4fTle0lZ5BXeT1W/Tk1EOzJKOHLxPsiVRzXbPb/Lh5qnqWIfCqkylbYRbJ/h5OGn56sXdfg==
X-Received: by 2002:a05:620a:4141:b0:7c5:b0b4:2cea with SMTP id af79cd13be357-7c7af1137f6mr129267485a.38.1744328698540;
        Thu, 10 Apr 2025 16:44:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8969f1asm169263385a.59.2025.04.10.16.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 16:44:57 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u31Zp-00000000N4j-0j3F;
	Thu, 10 Apr 2025 20:44:57 -0300
Date: Thu, 10 Apr 2025 20:44:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Robin Murphy <robin.murphy@arm.com>, aleksander.lobakin@intel.com,
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
	catalin.marinas@arm.com, corbet@lwn.net, dakr@kernel.org,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com, hpa@zytor.com,
	James.Bottomley@hansenpartnership.com, Jonathan.Cameron@huawei.com,
	kys@microsoft.com, leon@kernel.org, lukas@wunner.de,
	luto@kernel.org, m.szyprowski@samsung.com,
	martin.petersen@oracle.com, mingo@redhat.com, peterz@infradead.org,
	quic_zijuhu@quicinc.com, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, x86@kernel.org, apais@microsoft.com,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH hyperv-next 5/6] arch, drivers: Add device struct
 bitfield to not bounce-buffer
Message-ID: <20250410234457.GB63245@ziepe.ca>
References: <20250409000835.285105-1-romank@linux.microsoft.com>
 <20250409000835.285105-6-romank@linux.microsoft.com>
 <0eb87302-fae8-4708-aaf8-d16e836e727f@arm.com>
 <0ab2849a-5c03-4a8c-891e-3cb89b20b0e4@linux.microsoft.com>
 <67f703099f124_71fe2949e@dwillia2-xfh.jf.intel.com.notmuch>
 <20250410072354.GB32563@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410072354.GB32563@lst.de>

On Thu, Apr 10, 2025 at 09:23:54AM +0200, Christoph Hellwig wrote:
> On Wed, Apr 09, 2025 at 04:30:17PM -0700, Dan Williams wrote:
> > > Thanks, I should've highlighted that facet most certainly!
> > 
> > One would hope that no one is building a modern device with trusted I/O
> > capability, *and* with a swiotlb addressing dependency. However, I agree
> > that a non-shared swiotlb would be needed in such a scenario.
> 
> Hope is never a good idea when dealing with hardware :(  PCIe already
> requires no addressing limitations, and programming interface specs
> like NVMe double down on that.  But at least one big hyperscaler still
> managed to build such a device.
> 
> Also even if the periphal device is not addressing limited, the root
> port or interconnect might still be, we've seen quite a lot of that.

Still it would be very obnoxious for someone to build a CC VM platform
where CC DMA devices can't access all the guest physical memory in the
CC address map :\

Keeping in mind that that the CC address map is being created by using
the CPU MMU and the CPU IOMMU so it is entirely virtual and can be
configured to match most problems the devices might have.

Too much memory would be the main issue..

IMHO I wouldn't implement secure SWIOTLB until someone does such a
foolish thing, and I'd make them do the work as some kind of pennance
:P

Jason
