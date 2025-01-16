Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE581946C3
	for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737055195; cv=none; b=FDm4PKBFv/PD9hpI0zsgwLhblXeq7ZjoGH+Pa4kHcg9HF+khUpmPG5rposRiLF2rnHos30Q7t/35dIp28O0ebBdUazMGjen3ubI7q6QPF1TAnEDt8Hs64bSOZLZx4xIGnY378scSpCPDWCPdHex1wcELJy4rnJN2KqTD07Xsdg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737055195; c=relaxed/simple;
	bh=bChrpxoXYLOi2YUup3iemrrMhFmpTodAygOPpJhId9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j87EFziwiiZzO8qc4VE8lQdjcqXqVTADmRzolJJJLHVqjjYEfMHOY74whWuArDGvTP9ivCObirGJfw9DxHaBFzh35zINH/9bWAz4O4EMHZoSbv3gKdYoDCAaBsslPWV+/WgLAkJsQbOGD43OqBuUCT3bnxP8LNO+JPGyX6B2ehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G49tWjEA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G49tWjEA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b702c3c021so121041485a.3
        for <iommu@lists.linux.dev>; Thu, 16 Jan 2025 11:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737055193; x=1737659993; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bChrpxoXYLOi2YUup3iemrrMhFmpTodAygOPpJhId9Y=;
        b=G49tWjEALMsHRg+7TOZCK5Xpr5trL2L3J3rEva4cWATLUB2G/gkte4xsdBcN1i4UZ+
         4rSH8++pEjGsO2IjpARJn0irCOhB8tT9oA4vh1Ph9oyJCZGYnJ35sT5MPxACtejyQLUX
         fWXsuLsATiNxoQuS5a/uGzSAd4UJlsCBxDD2mNHgx6uJUXzzHNrtaWH8Nk/s8ThWG7/P
         cdKD7uzhSU76XIPy7L+Eef8GP8BiGSMRWYlv9Ktqc6VF5o229juI1NZkWbICfUAtGhzu
         hoKL9piOr8DEzo0MM0/y4ZsP/d0mIF4Zk4EZXjAeXCwTj2/irk/vMg1yC3Zyf6FtTjud
         ryWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737055193; x=1737659993;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bChrpxoXYLOi2YUup3iemrrMhFmpTodAygOPpJhId9Y=;
        b=pm6q2MV+SwBBysJXhogjr4Ii8838aRYUSkKCBNsf1lSqOeXNQwaG1N/NsO+OfFZcsn
         DsmZ47TytISQwaPpZ90gULOrU12HfeFbvLp9fmq0aRdPfKGYAtwmgvR20vYMieqdEom0
         c0/JUomQk9w5nRYGQMUxQN5USCoKzxkUr06ZROjAsEOUBx420HSFFJiJuhJGe8/VAj7w
         Q07hxzzq3ZaOgwZoQgez89DTM+cX9Pc4tp9d/5znanIwIMzr9V1JI9elGS36fRj/Fpjy
         Jg4wSRw1m0PgDOey6E6gqpV9wkOJWtSt3BnP7cl3Ag7VD8C0NYZZr1FJGq0GvVhW/ep2
         xfeg==
X-Gm-Message-State: AOJu0YynHATk1CqesUPITJcZxPDmE0uyXoDsJDhQdkQYFUE2BStUVOZj
	XSD+ca/Z8JGNpqbavqJB9TOd0FwP/PgMNzAYs3f8UgeqyBmTn87PC+DBBu2Nb/0=
X-Gm-Gg: ASbGncsasiGD+1/Pfx9NkrViorZKf7qQIAVIGmdSBYj44i/r7NIWsKurekQjzeqmL52
	PsFx9iopGAwEJ+n3oLEeNUGRde91nJZiF6vOS/iVwVwd/HGe7+EmXf0EVWOynwwEwFxwy2SabUk
	+5QrNuNP0tFmSgu1iuAKrM4uGIdhfTVyhRYOXyTlOW/wgiJPYP47jFER+PSpn2OGeXVeGPQgux5
	LGt8RKZ26TOCB7R1ewZ9hvq3b4wQpuV8oIFKInYmIxGhLbt1H40fNzsElzMK2SuCizjKu9ROsDv
	Tq6fI1A8gDfGYWg7brvdlV5HJ/KIEQ==
X-Google-Smtp-Source: AGHT+IGTm4bFEwhL8GqLcY8z3nt0mSjwsh1Z+7KfLW6eIDlz0sFoLhtw28pz+YDUvgq5sFx2TdqJnA==
X-Received: by 2002:a05:620a:2a13:b0:7b6:d8aa:7ef9 with SMTP id af79cd13be357-7be6320c0f9mr4896085a.32.1737055193220;
        Thu, 16 Jan 2025 11:19:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be6147f2e7sm33743585a.32.2025.01.16.11.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 11:19:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tYVPE-00000002xf3-0us0;
	Thu, 16 Jan 2025 15:19:52 -0400
Date: Thu, 16 Jan 2025 15:19:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org,
	robin.murphy@arm.com, jean-philippe@linaro.org, nicolinc@nvidia.com,
	vdonnefort@google.com, qperret@google.com, tabba@google.com,
	danielmentz@google.com, tzukui@google.com
Subject: Re: [RFC PATCH v2 00/58] KVM: Arm SMMUv3 driver for pKVM
Message-ID: <20250116191952.GD674319@ziepe.ca>
References: <20241212180423.1578358-1-smostafa@google.com>
 <20241212194119.GA4679@ziepe.ca>
 <Z1yNWI9lBNIZg6Le@google.com>
 <20250102201614.GA26854@ziepe.ca>
 <Z35rEeSVwfZVA9IF@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z35rEeSVwfZVA9IF@google.com>

On Wed, Jan 08, 2025 at 12:09:53PM +0000, Mostafa Saleh wrote:

> I am open to gradually upstream this as you mentioned where as a first
> step pKVM would establish DMA isolation without translation for host,
> that should be enough to have functional pKVM and run protected workloads.

Personally I hate these giant patch series, you should strip it down
to small meaningful steps and try to stay below 20 per series.

I think getting pkvm to own the SMMU HW is a great first step that
everything else can build on

> But although that might be usable on some systems, I don’t think that’s
> practical in the long term as it limits the amount of HW that can run pKVM.

I suspect you will end up doing everything. Old HW needs paravirt, new
HW will want nesting and its performance. Users other than mobile will
come. If we were to use pKVM on server workloads we need nesting for
performance.

Jason
