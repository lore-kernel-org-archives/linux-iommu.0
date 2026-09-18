Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85051AEED
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750685; cv=none; b=hORMwbRANq11livabA7gnfvq+bsu98Ej76u7JUNUG5JT6TjUweKtRIZXMaIgZS0g/xqnsONvTOiOLpgInmBSnaw0iKl6rbpR2G5xP//KjXhPJBxaoOzeThvQYlhVYgdt94nylsap+0Af5PCuP0fdeMoxyHs2eRAbRAi4E1h0zr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750685; c=relaxed/simple;
	bh=6pCoeSjfIM1AWSdeWFfupOCaccy7EnX/IEuPyibjz0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0lGZvrQrl4EhXHjdatKa9r3ZBT8FfA0ADn1VLESvkcknraaMcpwC/QHAccRE68fK8uml19b4wlwWs0xvH68kfjF9SUQghtW5k36T2LSfSBlVT217mFRtj43vJl3OGuIAUZpop5E8UDYSeYXEGqb/lWoOugjHsyjWdRx3rlvCoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=EYyE62iZ; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="EYyE62iZ"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530301ff353so10619981cf.2
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 09:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789750677; x=1790355477; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xg8bxcCx9Xplr0VksHoJCXIx7eh2ZBKcRPIgfCbqvCk=;
        b=EYyE62iZOx9YOxUvHZZavua+NH1hUoSwUO4Kq+WoEYAleNzn3SZ+6g+YHgvPmTtRy1
         Jzxp9cx7FI48pc+CD7Rb1ptMU43a0u+V83twfnWU6ZsuyCqD0ywyoS7Uu+m5r8sN7d94
         SVsiVwo6DLVGpt2soH24COATMfVo8w1EkIKw+n1ay5klN6/wbyb8S+UUPMc/IdnlqTiG
         IP2d9jvJepWxHM2KoaCdOPuw0w7jJu/kGOEl+3GqCMrl45ZvDI/m+NuX4sMTapFAKCNF
         Wnfae0zz7mXMvlv5GV+65gKp2A5uxC1GOQqLHQlFSkWly2ekhmHjBIw5iA6UU20yqez2
         T7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750677; x=1790355477;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xg8bxcCx9Xplr0VksHoJCXIx7eh2ZBKcRPIgfCbqvCk=;
        b=XohZOIEZM+7JUnjso50ARz8m+7Fo9MIZZ2Y0n1kOTrS3DFh+h7ZhZcefX3Jb8fDPQp
         vNl3/efsl0j1CRQ0JR0fSMU5VlCbvBXDJOT37UX7EUJQ4j8oVUKffGpaYiTTt8ZKhaJV
         KwwWx3+kwhoSX1jcx1aNsHKF8P12coo6zeg223OAO+3LjS2iF/ZNypp/Dm5b6o6HPtpU
         kj1uTa9Mtv1b/z2smrnDVyrqtrFZHZzUi1MZhArNOmKevEMckxFBw3NF0v635lWuwzfN
         424tkmh42vJCUhu2RhPxTmVgCsvJmGBX9L3MoFRHiZkard/xvsWqG8EcYDt4YOz2IJaM
         JP6g==
X-Forwarded-Encrypted: i=1; AKwUvBw+H19thtIioEW+UbyPCT6AexLCtmXTpqwvREHKYKD7UygmL/o8EgJUdzz8Rdk5WRCI6wCd+Q==@lists.linux.dev
X-Gm-Message-State: AFuF++kJwM4ll7MQE/3bOzdfDpmliYMYwASsUjYC21J1C4Q5H1rbPpEM
	PIo2H07sf/giL9gVtFnwBDRHyisXCX2NIfPK4osrfdRTsZQCx+Ec+h1+y6QHUz9Z1aaYYMXYjBN
	C/hqv
X-Gm-Gg: AYBFou3RJ/cEg9HQiFouDf/IMrCWyvI7hOQoz0bmMZlzDuX51GqM1B9w2je02544buz
	VTIL21DALRnaPIjr5EP1gLRPQY+7MMgkFS9xmGkW7cP1U6IanYLguLuZZWK4tle8LJydwClUDIJ
	u3eoAG/ZqQsrVsDlaOlgyl3oKempXyHMVAKo5yW+mjnsRBwUzZcAT+NByc0Ep34SieQ1iLCt9Ec
	MqzU6PhzOjE/NUp8HGhYnJ6s3BYR2Iga1VUd0/TIfmU3cCu9nTkua/LmAPSJXbHQiOFxs5vL0Jp
	mq4t2SjqJptvWrmvdCM0wM1a2zfWm5H8u7j/6Y4vxK1sfb4HV3OUhefQkXk2MDUtX36rk0vZ0rp
	y3L7xITpq7uO0LmK2eykBsXsGQ8CMhWCI6QSGNwKr0aTPhZD9gMO7LV4XoJI9FIT0lIQzgGNvC3
	8YizHmmJc4b04JfSRjp+HZQPPPtAPID/4DkXZcwDZaqpBdy3er3B1n6D4RgV8K/Ij5HkAlrZDSh
	X5LZ+aaaLEI37ofhCdHCP6LnMIOoARSGr3OouaTI5+YpS13M/UBpI9i
X-Received: by 2002:a05:622a:60d:b0:530:9bb:54ae with SMTP id d75a77b69052e-5329e259e51mr55816971cf.15.1789750676599;
        Fri, 18 Sep 2026 09:57:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae2c6a33sm1773871cf.0.2026.09.18.09.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:57:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7buM-00000001zBN-2BHs;
	Fri, 18 Sep 2026 13:57:54 -0300
Date: Fri, 18 Sep 2026 13:57:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 0/9] coco: guest: Enforce host page-size alignment for
 shared buffers
Message-ID: <20260918165754.GG11599@ziepe.ca>
References: <20260904103452.1197239-1-aneesh.kumar@kernel.org>
 <aq1sT2EDsGaomqST@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq1sT2EDsGaomqST@arm.com>

On Fri, Sep 18, 2026 at 05:52:31PM +0100, Catalin Marinas wrote:

> TBH, I'm tempted not to support this configuration at all, just fail
> gracefully if the realm page size doesn't match the host's. However, if
> that's a real world configuration, 

realm != host is going to be fairly common.

host > realm is probably not that common, I would guess.

> I wonder whether could we leverage the swiotlb mechanism but with a
> separate io_tlb_mem as a shared coco allocator with the right
> alignment and use this pool when force_dma_unencrypted() instead of
> specific alloc_pages() with adjusted order.

I propose we fix the far too low level set memory decrypted apis into
proper allocators, with APIs that can handle a round up. Then see
where we end up after that.

If we can hide 90% of it in an allocator then lets see if we can open
code the rest.

Jason
