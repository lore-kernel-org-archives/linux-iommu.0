Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD51CBA14
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 15:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005577; cv=none; b=Fsp98cwZj3HPsJZJ8+bvfdRJgkHs9MG4NZeNR69u2Tt0LXl/hDHCGgP5rLT4FQaLYjL+D7Amq7JT7VuuQfdKbeiK8GqgHHp15ozXyFUUFqedBLDfvrZuglVbv/NpawGfD0spdL8c0QUoZ9XAPE8NChdivdVzFLN8uDTBp+hs1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005577; c=relaxed/simple;
	bh=OeZnDiQ21Kow/ABo1m0beQ7QhnKZe0Ia9aumI15eEHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRGiEjoJ8VGH+jPHb425ttMHrLWqMVifftxjJWGxbtlLRFeZoreo+D9oZMWsVCQVoxqvXURyAKtMOoxh8QsoS9PixL8OZNycbb1d5jy1OeolpgXUnWelYgt8Td6QyZizXRP28kuH9nEiaMyo0v9EknyXZS/hVyM2t+nqvmHbxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oy1n98Rk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oy1n98Rk"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca4877690so483325ad.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729005574; x=1729610374; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r3Rnuzqm/ZJHbwtJkwmQDmYpY5KahmUtxVsIkTFG29g=;
        b=oy1n98RkmiqtVPzT8WIAjOMuNNyD9/AUyp6eb5G9NdMTwADn+R+nHPZjEMHhoDIWdi
         9wWa20qPl8vsbheyXqtr5IgDSQwvmOjdIqY+K2pyM+5ODvufiGZk63D2oVc9zo+9j53K
         7EKcdZoKaDQSSXUoJk6+iZS02FrbkqStAVEotQUuXNBWg+ejHIVtr6WLHTML9w/dN+Ao
         lVdygpw7CkEWXkL5frcZNRfdfsFFCLY4kTm5j/o4hOxfl5JYLVHx+3ywvRenY7a34+eB
         Yn9KOX2BYC5rxxyBxLLVs+yDuX77BA3F5MP7ZzZ1EENbwa8VkVvEMJ/9DGUH5YJFMoL1
         FPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729005574; x=1729610374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3Rnuzqm/ZJHbwtJkwmQDmYpY5KahmUtxVsIkTFG29g=;
        b=Vg7iUQvvOpgWW1jvv72n+aVpJ3VCuTQ+KZVLjVa2ILX1zcHLxZ+9fMcxGb0+GxspX7
         pw7Hr/wEnz5cFzND+szi2S4QyYJ/My5qK6J+tvn47GPiv9DyVHRi871edtVqvpCjoqYU
         8vZrYXhMAXm9V6JgxYV6D4cz68OvujQBVoRK2T6bIjEO0JrnghnC74UY76Iawbl6SgCQ
         lwTPuz31Ijb6Yfy7Qjoh3Yy1ywEWdd30eFV6S455tfKwS3hxWmSVbPtcFtgjZNqijv2H
         +p/yZCLXE8no77ilt7vj19gcOy82liTe2waJO5IugVE/vu7EdtfU571Q/c5mteTw/wCn
         3tWA==
X-Forwarded-Encrypted: i=1; AJvYcCWMf5Xaa4Xw89EHpq3RnCpD4tocOQmlerr20bRgJ7r030QqyY19F0EqAPJGskvxSQSBZVcG0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSHslYSby3Cm7Bryppwaw0llaGCTHdu+6chZdZTcmDdRkNvtqe
	gS/0+0RCJkrxgiH+F6S6YYOWmUlsjhq0D1zKXYWy3J/fCr1IBYgkfK7Re07nCQ==
X-Google-Smtp-Source: AGHT+IE0f2VvQeg757IQK69py4gyL7jf6g+kTHLVZTHwi8LjtCbcD40rA6RPqNG0wlsLEIalLzekKg==
X-Received: by 2002:a17:903:2292:b0:20c:568f:37c7 with SMTP id d9443c01a7336-20cc02a791cmr6712555ad.17.1729005573959;
        Tue, 15 Oct 2024 08:19:33 -0700 (PDT)
Received: from google.com (62.166.143.34.bc.googleusercontent.com. [34.143.166.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f037aasm1919291a91.29.2024.10.15.08.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 08:19:33 -0700 (PDT)
Date: Tue, 15 Oct 2024 15:19:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 2/2] iommu/arm-smmu-v3: Bypass SID0 for NXP i.MX95
Message-ID: <Zw6H_fl14_r3bvgw@google.com>
References: <20241015-smmuv3-v1-0-e4b9ed1b5501@nxp.com>
 <20241015-smmuv3-v1-2-e4b9ed1b5501@nxp.com>
 <Zw4kKDFOcXEC78mb@google.com>
 <20241015124723.GI1825128@ziepe.ca>
 <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab21d602-5349-47be-b346-2fbc041fa13e@arm.com>

On Tue, Oct 15, 2024 at 04:13:13PM +0100, Robin Murphy wrote:
> On 2024-10-15 1:47 pm, Jason Gunthorpe wrote:
> > On Tue, Oct 15, 2024 at 08:13:28AM +0000, Pranjal Shrivastava wrote:
> > 
> > > Umm.. this was specific for rmr not a generic thing. I'd suggest to
> > > avoid meddling with the STEs directly for acheiving bypass. Playing
> > > with the iommu domain type could be neater. Perhaps, modify the
> > > ops->def_domain_type to return an appropriate domain?
> > 
> > Yeah, that is the expected way, to force the def_domain_type to
> > IDENTITY and refuse to attach a PAGING/BLOCKED domain.
> 
> There is no domain, this is bypassing an arbitrary StreamID not associated
> with any device. Which incidentally is something an IORT RMR can quite
> happily achieve already (I think the DT reserved-memory binding does need a
> proper device node to relate to, though).

+1. I assumed that the use-case was to first attach the streamID to a
device and then intall a bypass for that specific streamID. If that's
not the case, I'm not sure why are we trying to achieve that.

I thought about rmr too, but it looks like the "device" is a DMA and may
want to write to more than a fixed region of memory.

> 
> Thanks,
> Robin.

Thanks,
Pranjal
