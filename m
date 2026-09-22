Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18C579802
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098008; cv=none; b=TAm8W2Amxz2cLw0iL51/SfILfvBFRCe7bwDQRahX3XpmaW1QfumVlQUkRGGIsy/Dfhh0/ZOpamRWQvAK2fDNF76oadcke+Yam2+o6AC1mVyktS+UQ1xwqaMRjwJobNJ50ExvdKJ72WfY/1KMeImUr8uN9Ry/RsOd4bx4teUIBK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098008; c=relaxed/simple;
	bh=ZsMda0uwAQyf/r755/L9LfI3ibTlAaDp5ifNzI89+Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZYYI27691CP4Z8jvW3jHlWoDbX85QObxH7m1s7ZtFc1EKs45TCphNSUkj5j9UalY1gXIjQe0EdwK2xdpVyxVy+hOy75RCDJYiOiY3e6LUOxaUDx3cTiA2oLz8sBoH6n/SPBSNAZRuRrueUZ4WyUsR88StCAf9KLcJf+RCbKL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TAA+MgB5; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TAA+MgB5"
Received: by mail-oi2-f13.google.com with SMTP id 46e09a7af769-80a71781323so141798a34.1
        for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 10:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790098005; x=1790702805; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZsMda0uwAQyf/r755/L9LfI3ibTlAaDp5ifNzI89+Ro=;
        b=TAA+MgB5i3cj5yTmEWtVqFhtQ64ZDiqeHgy6UZGJ03kUNPjdmLb0ZCE7n/yjJYMM1m
         phFG0a+ZHJO7whgI3lU5UKeyeYguMaZxJ6+L8V56K1aMGKekK6b94dM2iyGco+r0NRvC
         1OZCOPVzFU7zeZ+CCE9lDDPooBBSiEMAJlnqKtPA4yDVWFN6Kf/QeNFjESVxVDxVWL2G
         y2zR9vS7crazIU8I4BnupTjsUVtDkAFP5CTelWMs4y+6vdyh5kNsT0Z/o+V6l280QkJG
         sNhTBtksjk1GKBAHXLL9e4dRx0s+qHaSfGiI7act45TzAASFOWxDDbtX9BhFADV/dsWL
         VQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790098005; x=1790702805;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsMda0uwAQyf/r755/L9LfI3ibTlAaDp5ifNzI89+Ro=;
        b=C6MQg83KUMBg9DZ/Shs1ICeqq/8xWBTHwc2A2sDGiSOoXxw6VyLjl7XqBCkbWfkJVV
         /MSkpf2tE3H6ncAyVOOQCZgr5zRK2wWzRu4Et8+pScvZeYgocR0FrFiWImFlE5b+9gbB
         IIgqxUnft8RH5C55v8zmwuGPXBcZv/b41s6m0n85kCeRAI9LeO+flcgcusJGz/GpmkBx
         RFTrIsgLcvLKDlt5QLoAgdmCnJLCpI+0OKL1wvh4hdLHt10aatFyNyy+ijkIOM6EFlU7
         GFI8xXCh/mm30DGBj76SCYjksQGbnjcLGAA+c1zalugFK8ekAIETNxVLqTPhfOfdcSGL
         AdFg==
X-Forwarded-Encrypted: i=1; AKwUvByVd9KaiD6UnfSGNMjpjY2/gSZT2CY24DGGGrZeNRJzlwsNh4Tl9U5JaYJ8u4548NVOpCmbug==@lists.linux.dev
X-Gm-Message-State: AFuF++noNHmWgUkUpRxwo9y702vE7o7ldEa/C8Dh8AhFTxhZrP5GcZwD
	TORjcQeN+/M65EFGvHdIxwHxSk/nIVP3wiGboKirKJU4GraWgx8JpFxgyokg2Tqnqtg=
X-Gm-Gg: AYBFou2lri0pr8L913dYLT5zRlX/LIoUndPaD8hFDeSUlhL1vCjoyT2KKylUwNNjh4q
	E+Z4+/gEi+7v7LtyLvQfCqf01cQWvtAfC6dOqKIJyKEoeLMiEwB5BwuJR34EZxGUR+ss+ZCzPki
	7/V0egz2127vaqZllYwsUtxb5Pd3k8lr3HLRXotwG2hwWuEMVkxQ3UYeL5SSUie+DkxX8st8C/e
	bFC7OfI4Rd5g9uB0Y3FZjWIBImFxhsY7IWeKS1xY/qx6LRW7DcHxn1WuaGeOx0AuRIPuDmkbw9b
	GyvY2lEkEM3FB45UmHDnd07BLyMNRjCObkW0RW5NlpraZaGPZWKHGTUgGmOUT4Ap1NyUUX67aZK
	Nc5floHV4f0j3SI4ODi7178C5IlU0FHV/61HWXyq4QNFUH2rm+QQcDvtn0auAZR/iiRKMawn3WD
	rfUr9ql+TjRnnsmmvhFQCFzs/wpTkW0eog+5GeTsPmIgnf
X-Received: by 2002:a05:6830:82ee:b0:7e9:e488:3bce with SMTP id 46e09a7af769-815f0071c0bmr324985a34.6.1790098005310;
        Tue, 22 Sep 2026 10:26:45 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81603fc79dcsm103564a34.14.2026.09.22.10.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 10:26:44 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x93id-0000000AWlt-1Oeu;
	Tue, 22 Sep 2026 13:51:47 -0300
Date: Tue, 22 Sep 2026 13:51:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
	christian.koenig@amd.com, Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <20260922165147.GD1540250@ziepe.ca>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arKsFofudnTYpXj1@arm.com>

On Tue, Sep 22, 2026 at 05:25:58PM +0100, Catalin Marinas wrote:
> Does the memset() post sharing logic work for pKVM as well? If nothing
> clears it, we have a small window where guest data is leaked to the
> host.

Same question for RMM? Or did they define that the RMM zeros on these
transitions?

Jason
