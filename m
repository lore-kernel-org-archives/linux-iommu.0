Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A9E1BF328
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396636; cv=none; b=oVBhUhtpOCcOPYzNd0dCgqKqOrzb1OfZHRnXYX7lqipF3czhIJXWmbQhnm+hinGl6PI2GS48uFCUQ9DC9Mg6dMz2H7e5wnyguCNvDklx0SGsXXi7RdL3bIpnx9V45cHIycVzdcXf1at+XPNYwy3llUzj6PJMPEetshra/22PTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396636; c=relaxed/simple;
	bh=mhTsv1ygiWFnjDiVQe/E1G0vEfNsEKPKJTElZp6SXYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwIJZqjY86TR/GfuHVWINlERooNKGzENwl7T0RD2DfJgDO63lz7NutnFjW372cxH4nKDAkkKRrxCdn5rMcJwEZu1spFJtPKIJ0vBprmoNhYmfE0ezyKulWL4kF6BFhJPf0nKdvpt9xxOllxHjR/7BFTCjzW2uc9KGA+fHXxVFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PyuZ80NJ; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PyuZ80NJ"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83abdaf8a26so48030739f.1
        for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 10:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396633; x=1731001433; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=;
        b=PyuZ80NJUWKPi3i2DU6WIvumYyez+Qhsb8fewlIhaDJImM7pUSu43yHdBLQ0PGEZSG
         P4mnAJur2wBcGnWMbrw3dOCIUge0KMphVig8D5yZ1qjZRmhLV48iLn9nknKv5WjaKcg0
         g8ZApHI8f0dVEXc/GbzHlRuyMAib7J9fMTN+3QT0HJ2bH62MNckgRN2ed97SawqgumS6
         nSLn32WNluW2LOgFRF4V+xpz0oArhTYXqd3pXOGKb8R+rPaS7KJKAKTpAzZs2CDSM+4Z
         AblaYXlMmDK88UxiNHC8TxKHUGaYp4qM9vTg6m2iPfWzUm1pzPfBhLh8XFgzQ8mPlBGN
         LTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396633; x=1731001433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cJN1S3OA8zjlhqH9iA1Z8bsg9GoFf4IOEEdKUROgci0=;
        b=k2V2KicIxV2xWqolSsvEwExVMb4ZXNXl4TXzp2cvV5ay/1upLvrvaUVP0OJrumqbCT
         Pi/ZuCJUqY1Jmaw4gc3Clc1UkLST1ceDm4Z9gouhyP4rP9JlSNVBUVzuBWzr4bcFeMQd
         h47xqG7fkZC5aaMnm5cjqS9eSWt7ndXDYJZwM/I36krZMSiaXDaZm4DdGL8J/VIwgjSh
         63/ZGbcRiyQ+bbMXBstjMe1xRM9z+1SSUhKcXy28wqlL4ksq17GEGbuf2KPF7dCRCNuN
         /izriPokpNuS699xqjlc9DnlAd4leVIf2s5riJYlpjPNHues6BWNBac5CGzhrqUNFQ18
         HKIw==
X-Forwarded-Encrypted: i=1; AJvYcCVGFLVsMnYbQ00sPnhWwh7tR45e+gTDq/EddCbx3prJbbhJaGkBzouETHjXYCp3ria8OEL1mQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0tsxtjV3smYw0O7F2QZm67nCnTztdD+os2dGxlhfH/3hnZlDe
	3ube2+2d6BnSxpm+P10ukHUVYXjhLB2OfHxH/JCImw64T2l6PLyKezrGa9qUmNw=
X-Google-Smtp-Source: AGHT+IGqvDPac4jMToI9PP3ppL4bi2ob+amIyOKddZ0fGQ56qF7607m8ktK4Ur1sfUjByGfZ1fMmYA==
X-Received: by 2002:a05:6602:6d0b:b0:83a:a9e9:6dc9 with SMTP id ca18e2360f4ac-83b1c4c27eemr2156317139f.12.1730396633080;
        Thu, 31 Oct 2024 10:43:53 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048e3736sm379375173.81.2024.10.31.10.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:43:52 -0700 (PDT)
Message-ID: <8b4500da-4ed8-4cd2-ba3b-0c2d0b5b4551@kernel.dk>
Date: Thu, 31 Oct 2024 11:43:50 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de> <20241031090530.GC7473@unreal>
 <20241031092113.GA1791@lst.de> <20241031093746.GA88858@unreal>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031093746.GA88858@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 3:37 AM, Leon Romanovsky wrote:
> On Thu, Oct 31, 2024 at 10:21:13AM +0100, Christoph Hellwig wrote:
>> On Thu, Oct 31, 2024 at 11:05:30AM +0200, Leon Romanovsky wrote:
>>> This series is a subset of the series you tested and doesn't include the
>>> block layer changes which most likely were the cause of the performance
>>> regression.
>>>
>>> This is why I separated the block layer changes from the rest of the series
>>> and marked them as RFC.
>>>
>>> The current patch set is viable for HMM and VFIO. Can you please retest
>>> only this series and leave the block layer changes for later till Christoph
>>> finds the answer for the performance regression?
>>
>> As the subset doesn't touch block code or code called by block I don't
>> think we need Jens to benchmark it, unless he really wants to.
> 
> He wrote this sentence in his email, while responding on subset which
> doesn't change anything in block layer: "just want to make sure
> something like this doesn't get merged until that is both fully
> understood and sorted out."
> 
> This series works like a charm for RDMA (HMM) and VFIO.

I don't care about rdma/vfio, nor do I test it, so you guys can do
whatever you want there, as long as it doesn't regress the iommu side.
The block series is separate, so we'll deal with that when we get there.

I don't know why you CC'ed linux-block on the series.

-- 
Jens Axboe
