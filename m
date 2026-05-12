Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F43A2E1C
	for <iommu@lists.linux.dev>; Tue, 12 May 2026 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589403; cv=none; b=XAIY2UVS+1v4r+6E8j3OdI4VTQFluUgmJYb4LEZrPYGxL1/VkMyTm7TqWKSRC7ovkfTZxDWv0AWjq7dIL14ACEc7gNfbw8vp3cHt5MrXdCGPCRJGdarVteJCoSFoW+IZe2SK6DYRogyWg4nFBT2bxRjDx/4wjUZZ88vtoTzhLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589403; c=relaxed/simple;
	bh=QuXcvbNKcdRmJ0PUN7xsL0HY9nWmc8jMrwxpJx0KWZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J20REJPwILaIDFglj6wnBaC6EDHs6CgJAXbTohhdStVMvAmaKl6S/LQmwOf6ivmOyGxaMH9/GUylvhjJV1pg1w/hrIHb5UQBPHfED5N5g5terWk1YnWmmr7hO9PoXgqANjPKzGxFL+iPaOnwpbQNhBePMEoanncnonwCn1rxDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K3ARYiQH; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K3ARYiQH"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d75bfb259so36562901cf.1
        for <iommu@lists.linux.dev>; Tue, 12 May 2026 05:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778589393; x=1779194193; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MOp4VzQJzpVrzaLWG2n8IsNxEYbCwRvMjRwLio3IkjI=;
        b=K3ARYiQHob2GOLdEyCUnOsy8g+2jZe4IscAufQkYYjy1YpN+ln32DwhIFKsiSwt2DJ
         gCdoMcKe5lDoTlUDrbsXo+U5wqJWsMx1t7GCvGKcp4B7oIBBUFLPuXASWGoH8oVSm0wf
         WxRGOiZFNqIArjOMq3JzDp5CvGTNXJD/aFdK0I6BvJU/hriKzDz1f185NqH2vbgJ+1+k
         6V56tijB72BSgtymbmpo3fNraXKrBRqtQhTeHFJfr6ka3kR+j7H6DAngmDHaVeIYcMHw
         csmChOba2OwWSt1mQlObVMsGXUYZbfiBkZmbNrt+ty10DIiLjuPNZpEARziwbo5fMFRB
         394g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589393; x=1779194193;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOp4VzQJzpVrzaLWG2n8IsNxEYbCwRvMjRwLio3IkjI=;
        b=UqKYxR3i3XfgNoDypCLg6KYSYKzqaUscQHVDVWY9ZezwJRjAtgF8re+6oeStw+1FrI
         4fz4qFIEux9Tcwp3+9ZyIdd/TyQKfrEdw9CqvHWNJpsTtWNPL4rNzOCGGCCIrm0pDIH+
         7OTEw9uLd0RRViiWYTGPhgZYiRBQGq8Al5a4zegxxuHWCXgArTwfXJZecUAtOy+pURoH
         cEtDo0QbgAPeZWVM/7aD5PXuepOWtIj05AbiEreeoUlzeM7r6AmqKhjXmLjjUMbv9phB
         IZCjaxGmH59/Gkiz0vLsYfsUp3cjllkERB7B4TyPNc3Zq/WUhWQu7RwGl48a/zkKR6l7
         PnEw==
X-Forwarded-Encrypted: i=1; AFNElJ/tJhFeawIl7PoSjvmfnd8ZH+XmBNIsGCxAlyB3zVpk8WeGPfyf9LzKV3OiheW55dHtRtlx+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKiQYCH3G00i/wLZytNaURgclDghpOGFcGmD4vSHjaYiNmNnPH
	+4kyej0Fd4XhQk9YJJE3dpSp9wKNHrQStwf0lbaQ9BhKcDkXf4l/gNNnBHLgklE7wcE=
X-Gm-Gg: Acq92OFtNbwSIFTL/IM1k9SqeS2LW+bDl2xTfkafSdlP4JEGoQ40GYx424+eMWfwrKJ
	9UVicIIPjZ00qmV48oaG3kYdvWY/s/hlPh18TMdxGPxQWDTDO2l7yg7W9MWERsWtB8deF2cYDja
	0i05BhbSVcsDjH+6XqMySRHT5HJ2gW/B1EfcDjDN+A5rskL8H0Xl9BwVOL79qmJUqXmagX0YIHY
	dLp8iCGFl98bDngL2kXFlSTOGRY/fwGMbuH4vhZeXw4B827vR5+cujoV3SAoqmcRyuACS/atp5P
	yCJoExj8WuCx5g+c/kS1yMHvEjIAttbFmXmSNTLb7B4ZSkgnGTefed2f/0KDscuz4Onlla0AkJX
	T7jy5rGyEQcHshwysikGbKzzX3GvInhjVEQ4TC1oweqogxz1OdgVySI5Uj/zyHCX5eOkMmLLjJN
	+uIG+xqJv2ebRmH2ZGyvpk0WyGFTt8MTDS81m8ESdSzbLQSqomFDE9WnGOrqwrPvQq5rZZIGkEe
	WVHjw==
X-Received: by 2002:a05:622a:4ccc:b0:50d:97e8:939b with SMTP id d75a77b69052e-51461f9e47fmr406246311cf.36.1778589393437;
        Tue, 12 May 2026 05:36:33 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53cd827c5sm391412326d6.40.2026.05.12.05.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:36:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMmLg-00000005AiQ-0kgs;
	Tue, 12 May 2026 09:36:32 -0300
Date: Tue, 12 May 2026 09:36:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <20260512123632.GT9285@ziepe.ca>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <20260501130006.GF6912@ziepe.ca>
 <afiRB3e3o0G1oZvY@google.com>
 <20260509232714.GI9285@ziepe.ca>
 <agG8XtrHUfWGy-kd@google.com>
 <20260511142232.GP9285@ziepe.ca>
 <agMEFhxsmjpO0thM@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agMEFhxsmjpO0thM@google.com>

On Tue, May 12, 2026 at 10:42:30AM +0000, Mostafa Saleh wrote:
> > Also io-pgtable arm cannot trigger BBM behaviors, so how do you
> > implement it?
> 
> At the moment, we workaround this by mapping all the memory with PTE
> level, while MMIO remains at block level as they never change ownership
> at the moment.
> 
> This is one of the missing features I plan to add after this series,
> if you look in the cover letter, these are listed under “Future work”

Hrm, I would not be happy to see io-pgtable modified to have bbm
features :\ They are very complex this is what iommupt is for..

> > So that's the real explanation, KVM cannot manage the S2 in the right
> > way so you can't share it. RMM/etc are managing the S2 without
> > pointless page faults so they can share it.
> 
> Well, there is not really a right way, even with a fully populated
> stage-2 page table, you can’t guarantee not getting TLB conflict aborts
> without FEAT_BBML3 (which is quite recent), unless you map everything
> with a leaf level, which then impacts performance.

I mean, there is a right way - you need to rely on the BBM features in
all HW and fully populate the S2 for no faults. So if that isn't
present then you are doing things that will harm performance to work
around the issue. It's fine, but just explain in the commit message.

Jason
