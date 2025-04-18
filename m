Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA01A3168
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744978687; cv=none; b=Hhr0yKKkOGqa0uZNY8kFfiOR6TkURTNk/hjGXtvqOZU3GWJbtSvJdmbWGLrsyUg+gTg0jZPD/nLGQBEXEbZ7n2rKJuiDm8lz3LkPATrX/vlSXRY6JHin/FhNk3ZRIX1SKiwKODuF0vtH4K40ewD526rVty9mU+ExplnNd9ckP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744978687; c=relaxed/simple;
	bh=4jk7QVt4nEFg1SlsP3hvz8KbPKus02m6kD3C19TAsa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSuQ/ejr1F7q5+wVjS3eWgZj4tJ7V6xfH1jZgJ3bcDZDCelh/xiJy/IuJO5mUaeL4d43ulENnAFtEyWuQU6bwmR6UdXc8GqJtTIk3d01CTgopdxaaCmUPO5pzHVDQnuoaVDIrtrR2qiFoMCNLbQ7BQhN94OFuM0mLsNlPqCKVUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sJSj8ax1; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sJSj8ax1"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85517db52a2so29184739f.3
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744978683; x=1745583483; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgbC0Ho51LBhNAGrJS6KpfvBsql1IBS8J1NX4yoaH+M=;
        b=sJSj8ax1b/tvlKSEmqwBKftlfPDXHoIwEMlmZq0hd5sKrQWD11ugrmyHy2AiACMkkr
         Iehzqx0AKXvDnookB3tUv6PE+5ilca/Ko9yLX/0L+WGyTvjjfJH/Zwg0mIgVIfn4fvIc
         0pI7MZP3+bZcDi15t+AFiNKnyDHUUmuHR/QqtE9FkV4Q0OK0c06XauS9Ttoc8IyPQPo1
         m0M+Ti+n/yhr6gkkj9nGnIf8oQrLO0xM4qQt6LWnGkIlolVSHACRXl9di2b6x0uBOv5s
         OTtdVKeTXS7pOc/3d8j/YDE1Go11xIaxGTPhUj+4i25X6TmrJ4R2SJEvZ5fSasRgDGhX
         nZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744978683; x=1745583483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NgbC0Ho51LBhNAGrJS6KpfvBsql1IBS8J1NX4yoaH+M=;
        b=UDBmXWm+ttSHaDF3yWTqpLzNbi9iPrlZGix3dZJedjBUQNQxr0Lh3Bg08TrDoggVhN
         UMpLRfKKc4Efp7nqZXzMc6e6PG95pXiKeOuumkz3y4OihpodXZZlRYUlKGZX9YLIXiyX
         ISjytviI8H/poBiqeIsVcp+FnvchHnrgqNFrThJb6ON8VhMkk7ZaWJCtOUFfUuujhCjg
         xMyV9e0b0zje1fzDDIsORl2O1BZ+xdn9bHxsXA3lAhdmgUwCZNEmY9KMnJ9T12H7nKSn
         pO2n8l89Utqjhg7zFvwSuILDraLJ7Su+u0FAhMtaHGdbRoNRBxFBCIo9spdEGarZptEd
         ogEg==
X-Forwarded-Encrypted: i=1; AJvYcCWRSbRx5+4EMhE0Yatqwe2pDLr0I6CrSgA608L8VYQWp7VFiHWYPwGEoxFslvRLFJ36WNZdUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdUDlRnd/UwFjUW7P9DXWKncat4pgq0N31cq75UKSran3Zzdzl
	cYP1ehHS5tAY5Xu3a+zOBwMgOGajQ/Im+NXKzwJu/W/OfnjpWzsjsZ0P/xjhiBY=
X-Gm-Gg: ASbGncvPVYPC1WMgHiXQchMx+bsAQJBs9wJCzVIe+L6DAHLrdowogYZPymQkuLW+Wox
	lfr6snQQ7qXaPGSvvUu/ku6CEiQ8eLEDNzFTluetryzaczwvWHVuCjIr22S5T/L00Olm8drfGIB
	Fsk44Aag4HRR8T5Y3TvSclF3RGiwO0FKV3g4+e7cl6SE1RNDHETqUQX1QGJujUJy9NXfHcCJfKj
	yPPKKIMdmlGscc9soy8CMV2su1dK1Z7LdhCLa5h2/zjcw0gGqYjR4uPD9ah/l8roB1AyVttWtFq
	CDmpVvEcy7u46HBMdGHR1KdUzdfGUVnjHVi/vRGfExfhT9vJ
X-Google-Smtp-Source: AGHT+IEcKW8yUly7My6VmHwOUQO6x2LKb/qwvAEzz9JLvNvB2Bo85wGWvtKeixpJ/OLzr9zB/iMeqQ==
X-Received: by 2002:a05:6e02:17cd:b0:3d8:211c:9891 with SMTP id e9e14a558f8ab-3d88ed7c3fcmr25688805ab.2.1744978682766;
        Fri, 18 Apr 2025 05:18:02 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f6a3957613sm406821173.120.2025.04.18.05.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 05:18:02 -0700 (PDT)
Message-ID: <93ef8629-4040-4773-beac-03c62f848727@kernel.dk>
Date: Fri, 18 Apr 2025 06:18:00 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/24] Provide a new two step DMA mapping API
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <cover.1744825142.git.leon@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1744825142.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/25 12:47 AM, Leon Romanovsky wrote:
> Following recent on site LSF/MM 2025 [1] discussion, the overall
> response was extremely positive with many people expressed their
> desire to see this series merged, so they can base their work on it.
> 
> It includes, but not limited:
>  * Luis's "nvme-pci: breaking the 512 KiB max IO boundary":
>    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
>  * Chuck's NFS conversion to use one structure (bio_vec) for all types
>    of RPC transports:
>    https://lore.kernel.org/all/913df4b4-fc4a-409d-9007-088a3e2c8291@oracle.com
>  * Matthew's vision for the world without struct page:
>    https://lore.kernel.org/all/20250320111328.2841690-1-mcgrof@kernel.org/
>  * Confidential computing roadmap from Dan:
>    https://lore.kernel.org/all/6801a8e3968da_71fe29411@dwillia2-xfh.jf.intel.com.notmuch
> 
> This series is combination of effort of many people who contributed ideas,
> code and testing and I'm gratefully thankful for them.

Since I previously complained about performance regressions from this
series, I re-tested the current code. I no longer see a performance
regression on a AMD EPYC 9754 256 core box, nor on AMD EPYC 7763 128
core box.

Tested-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
