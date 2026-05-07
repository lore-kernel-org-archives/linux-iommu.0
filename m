Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079A3BF685
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778146809; cv=none; b=bIHLMjpSVuJ1/KoJoLx2aYAasbbW02XJGH6kMpGzDHiCPzuniImvzfpdvv6t6N67WR6eE9c1nff5irUD9p7RFRpQ0RFrb8O7tDFQjHdx1UQGz+i2aA1Fqe1L1VjGrAg3JI9IB7iM4ob0szmvt3o2I+FvcY90m/DrH5/yfPl8Z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778146809; c=relaxed/simple;
	bh=//T+uUZKVsScMqNPuY2uDzqT14OVSZxoXfFh1I1LXYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aASgg5X9dNKCNknwAQiHbxEiUwv41sEq0oiSlQsJHQ4ymZgTHqsZtparO2mxh4FDEGHxP1d7jFqrMRME/vGWc7SolOokd/GctmnIcnjAegyd7CouKyP1xOX82hngiSqy87C0hiM5MD0WX/JkZuK6QXDrOlb7CvFzPed3lNI039Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/w2pbVO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/w2pbVO"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48d1c670255so79345e9.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778146807; x=1778751607; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iO2qxGV2Dz72sotDpa6WZEWx9OFKl0tlRmAkWtejDhY=;
        b=X/w2pbVOs6JJob2PkEG3V3W+kYJs+AROSXyZVPKAAby+0aL7vHvGBNRacRT5JuIWFT
         55h4mb/S1GIQ7Dz7Fml5DJybyHZ7Id4vx79xoCwsZsa7v9SRPi8ZQNShzkYlde0UB0OK
         lYv6bKuixu+EXAZTaqvp8n8nbVdMey/8HQcdjZ1sxLYFdx4/Mgv+o7N8semakPSFwU4T
         qVkzqYxlWaPFr3c2G2K7y/661F98EEKT5PwdDOlIyKdhP1GSCTeNWUAsx8KX0EiwzyYb
         TTJ0sVxxLKSjfpVnHxqsPoVINcrhOIpiTxNsTzgd1y6IwBQG1l2T+A7D8IcTDzPAZ/xR
         TwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778146807; x=1778751607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iO2qxGV2Dz72sotDpa6WZEWx9OFKl0tlRmAkWtejDhY=;
        b=f5pwZ+ZRfBG51pVSvi7ly+G9YOAkoymifhHOngnxyELcth4nwgE45yKxAZnkg9OcHE
         lTEhZbJPtE2xu4tG2YzVNqCbr7ZHkGPMl+GIKpnySBj/K2pKyNHbr8ovFusEH+4UIJMY
         CWdNWSuRb56ZcZtq82sNT27y0fqJUigP62+KDk40lF2Jhb8ulWJpl/h4zv2/z69pXyc9
         i1lRrzcauFYnsi2DLh5uSYWMDzmPVWa1fU8s+8a3MzyMVAfrbV4YS5KCSRPdnDK1/jG2
         cK+KJ0pJBxktT59KO+vu65BxqMq+Hb4AE9qwRRl2N6lNmq+oDkBSdFxdRRNEJplWjnLx
         42xg==
X-Forwarded-Encrypted: i=1; AFNElJ8D1n4+rIgDSBtVToCB2+jYTEJbDj9PZuQ94ZxCQTUhPnnkNTIpjhiIhin389WOP9EctSYD7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyl5jpZlJoWqkaVZasY/lzp/2c5oGubgxIuJ0OAYIy5UrWr7075
	T+f1rYSyMEHJuIt/krLVtP9CWgaAJ2JKanjjtrIaCdc5Hz8Wu4DV/9Xa0TbTsFp1jQ==
X-Gm-Gg: AeBDiesmfd1Hgu3IiRCS4vO4EYOWtDGdCJKUhraVlffez41GdGzobgxgNNnxoBphXNw
	PzPvSUPv4Ie6oucX481wJOqOdKVJ2fzxTq4Rhacu8k8UbB5Ak/q+ZmQ8weRRBAr4ICYhCWiD8+h
	NMBp/RcglVvegWv4djSHc9TW09Y9e7FlFXCRnivdcSASelaqK9cyQG47Mp5Eicdf9wn3G66vZH5
	6AJkzxrCmxYkKemvQL89ps8BpQzRbJRtDmOcmqRLorONLMa1sdm2f534Gwm8MVA75VfqtaMGpib
	lzA+0h5r7XezZZ3NT5VWJ35JrMAkiMsqxKaszo2mG/AqVCU2TsIwdDfctQvBBqsqf+yYcR7r/sq
	XuxuDrYNd2aA00DETmJh8o+Nn+IoymtgYXs1hNyqb7JrI3GiDgJPz4npwIaDG0iyepqTMlthZ+U
	j1bKS3CG14/0GTKB1Q9N+vFYKNMoGmoyOs7HVRePENqRHAzs5urdof+xPCGLICjqTjDdp/Q19v3
	z2rfg==
X-Received: by 2002:a7b:c314:0:b0:48a:5f32:62d0 with SMTP id 5b1f17b1804b1-48e5d650751mr703025e9.12.1778146806189;
        Thu, 07 May 2026 02:40:06 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e531578c8sm38996315e9.34.2026.05.07.02.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:40:05 -0700 (PDT)
Date: Thu, 7 May 2026 09:40:00 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 04/25] iommu/arm-smmu-v3: Move TLB range invalidation
 into common code
Message-ID: <afxd8Km40A5ulZvd@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-5-smostafa@google.com>
 <20260501124143.GB6912@ziepe.ca>
 <afiN1UwS9q6F6A_v@google.com>
 <afoYBYIJOTClsdLS@ziepe.ca>
 <afoeIVIGE-JjYy22@google.com>
 <afsPfEzgGtAFrN5P@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afsPfEzgGtAFrN5P@ziepe.ca>

On Wed, May 06, 2026 at 06:53:00AM -0300, Jason Gunthorpe wrote:
> On Tue, May 05, 2026 at 04:43:13PM +0000, Mostafa Saleh wrote:
> > On Tue, May 05, 2026 at 01:17:09PM -0300, Jason Gunthorpe wrote:
> > > On Mon, May 04, 2026 at 12:15:17PM +0000, Mostafa Saleh wrote:
> > > 
> > > > I am not sure if it’s worth it, the hypervisor is much simpler, there
> > > > is a single page table, it’s locked (also identity mapped), it’s
> > > > updated on VM boot/teardown only, we don’t even use iotlb_gather at
> > > > the moment, although possible but I wanted to keep this series as
> > > > simple as I can then we can add more features later.
> > > > So this patch is the least intrusive change, as whatever the main SMMUv3
> > > > driver does, the range tlb invalidation logic is the same.
> > > > But I am happy to experiment with that when posted.
> > > 
> > > Okay, then maybe just always push a full invalidation?
> > 
> > Like full address space invalidation? that will not be optimal and
> > will affect every device on the system, why would we do that if we
> > know the address?
> 
> Not every device, just wipe the VMID. If you say it is rare then keep
> it simple. If you need to be narrow then use the proper infastructure
> with a gather. No reason to make something boutique for pkvm here.

But all devices share the same VMID, which impacts all devices on the
system, and is not that rare to ignore.

I can add gather support, it’s not that complicated, it is currently
supported in Android.
But that doesn’t solve the problem, which is: At some point, whether
eagerly from the page table code, through gather sync or a fancy
invalidation array, the driver will need to populate a range
invalidation command (tg, ttl, scale...) and this logic is better
shared with the main driver which is this patch does.

Thanks,
Mostafa

> 
> Jason
