Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC673FAE1B
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969340; cv=none; b=oVk7mVG1S5FG0xEBldrSpVx8z/htkpuBPYHYc2KOsV+q59R4zEvZ/TuWj1YrL9mC2592daflcYGNMecyfmEktpWiZSlq1oyKhCjOvqt+eeE41632syf/24RFdFipEllrkYcE3Ye6mfNwvBc3vaoPUDzNHrjIztD2gmMOLu8rOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969340; c=relaxed/simple;
	bh=I+UkeZQjqj3g0bJcjZoQjrVdpo8txWH3MfMsXY6UQ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNGq/vyxX6D5gP2VQczeJcjCZdsa2HCfIJ+l2ouyO/E2JkmBq4FrtKjVW2enwlwfBz1/KyG/nm1gMbHvgKR+lNPjnz9irGd1Ku7KNBFNYiBQCfOIyLALUUfTDfb1tggePkOZdttT1M7WcuoLHYq2/34tBOxl8jIxNPfjETanwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mbtoOYii; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mbtoOYii"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-936d00181abso145277685a.2
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786969337; x=1787574137; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fjc8YE85ySy/Tyy7fdL+qRRJqTW8oWeIB13unlKZzTU=;
        b=mbtoOYii7wiaFa0bzJ6zps6/oalD8oh7u3KltnoXIxNZ4baeoikl3gX+8eEAHLR07k
         jYo4fglb+dTxLJ0L/rf2F0x90n6tRQfqQ78lT7xjMWsGSZYMaLbEeg+8oOQZW6NbNGxa
         UDYLj+Ja0PwGhkIOIRrEcCUvM/k7mIzEiCIgATSSS6mXncdyI3oMVu94zMNRGubxuBXB
         5t1YSdR6FKUMcE5SRkR1A27klyU43DenNK8/poN+MljLfbeoxEuUXjihgkoGoTRBoPXQ
         GEWmPxFv4kjrdb4GXrrP/icXCxhVNj0IDAJnQQ3qcMjvXlfCMvr5bfwpkg8scK1IdsMF
         AhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786969337; x=1787574137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fjc8YE85ySy/Tyy7fdL+qRRJqTW8oWeIB13unlKZzTU=;
        b=FEaeOq5P7nXvHh3VSgDMl2FV7UUrtGstWw069mbVbPg1u6cOEvmXnrIqXUPofoNtxr
         7mHfwHKyYxqaJNlVMVJbXB+xZqy/ZxtOd0h082DKKxH1VKMm45sdck03vue9Wbb8uGq9
         Zq2RG+eo7hmbzj7LBPz9dtNwgfcq3bsSWT4MwarH4Hi4Ju/ygIdacL1eyRlDjGBTwLFP
         TayCkG+9RbdS4qtbifQu32FFmdXBC2oOdJRjGmvNBatHqPEmcfqA3DKvRmPzZDeeaV+X
         JQpvfihXEmIWxOcOgLwxEXKfx7AB4CM2JdGsONZkONuRF+Pm+KmsSqiyp8V2kFQhE+aY
         iM1g==
X-Forwarded-Encrypted: i=1; AHgh+Rq8AdeS6eahjL7btccUeIumv8QfvPRjW/moHOUUcvRrhVPr/QVmj5Tm9+zWIGdTvQ67KIqeuQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVWvxMYD+PrXBkpxYd/Mer82t3POsncxIca4Gov2iFRyeoybV1
	Z1GNobhSMBXmx6LyO5pyI0xDCp0LaIHF6EcmAPXGRnE6doDf0091djhpTPlMvqTOhhb4t7IcUTX
	0hV5B
X-Gm-Gg: AR+sD12zl24fTuuyjtQgtRZywxh80qJtPkav3CjH52SYO3z0UXFU0yiJeEFf4JTRUbd
	7RRbKuRuOolDj/N/YcYk2S5Qxfu3SxDhftv8u+aVzmNBgnkLB9hBzqVBwp9ohVuU1XrsjGP8O0o
	DNylc5Rx7s3BCQhiYDrT6PBo37Bj6QAv4xYpXYctqlvVppGFaG12f7TBwXRW5uBfM14ENlPUZap
	krOp9fLnv7LXWuFto2MIxEE66XouWYLauT7d28WDk5vPIT66iq6L+44SLglbolS048fsVgBhxzA
	5301fWT8pi9noHIrCcM5pPD/57c9Q4+TNPq4/HyR93Q4r+oyjiAc2rlQ/liOnxzoPKC8pxxDrRF
	Ecr3N5Xx3D4prc3W2E7YxT7fIhPbfas29C4mrtWUu3MSqPuJGZSt4vHh0w7DkE8aiAWwt4BXDo+
	3xZtixL+SjQjth81Wi19zbwIBueNV3g4ZnwfHeIcU3m6sPnlU56g==
X-Received: by 2002:a05:620a:2552:b0:92e:f3ca:2ec8 with SMTP id af79cd13be357-936d202b715mr2670485685a.19.1786969337333;
        Mon, 17 Aug 2026 05:22:17 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033fad12sm31868985a.36.2026.08.17.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:22:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wvwM4-00000005tO2-0GS8;
	Mon, 17 Aug 2026 09:22:16 -0300
Date: Mon, 17 Aug 2026 09:22:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260817122216.GD933791@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>

On Fri, Aug 14, 2026 at 05:37:48PM +0800, Yu Zhang wrote:
> > Why check it at all? Is there an issue with attaching the same thing
> > twice? Will it blip the DMA or something?
> 
> Actually, I do not think there should be any issue with attaching twice.
> Hyper-V *should* be able to accept such attachment. But I do not want to
> make such assumption just for a redundant hypercall.
> 
> Does this reasoning make sense, or would you prefer that I remove the
> check?

I would probably drop it. Having blocking always set blocking to the
HW regardless of what the SW tracking state says feels more robust to
me.

Jason
