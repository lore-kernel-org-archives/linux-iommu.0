Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B42222D6
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752138272; cv=none; b=vAyhYzmwh/CRk+jdcZ4YGTqnWgSELnZjnBXQ8Nz2KhG+RPtdJby44hp6Jfq9ZgGsSVUOZDh+27y2a+xLHp4u2NQX7lmZmvuYcs8xxODuJaxOqGM88OPl69D8ECICQoK5JK9/n1h37FUiL7PXp/O79uF21eInVAATsOePYBv51OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752138272; c=relaxed/simple;
	bh=UHq0Bpn2ipr+kaNHbOBnceI/82zqPsegalrxYbyF9JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5P0Fj2Atlr7C9HUBTDcB0sZngOAdyWfjzX30anUD2XHQG2T/eBjq+/ppITY4FeVhTJiE8HxiLvQl/Z6ca24otjRxnGziGoZvTtXTNaDRkGSHC/pgnfPJOHM5Ixkp/TkYMbDRS9tyBtaMazQ7VMXVacJXHF4eamHz9x06TXxm0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rYAVBRZz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rYAVBRZz"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235e389599fso168145ad.0
        for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752138270; x=1752743070; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DjeE3o0RxHj2yfYkiiw6nT6qNxm9Jz3LUgLh8cuza0U=;
        b=rYAVBRZzdQVxiF2eS0+vltBAYxHR/mUhzf7x62KdCHpQFXAxaZhOdAvZ/UXaDVlyti
         ScaTZvbNhscnGOf4XWsntbX8eYYR1VrwG24XCfLeQ16WeJLMgGXh/pE7rOxP2VDD0e3T
         v6nZ3XrGd8tr36CZ0N1TgcoP/uotu3QwqYrXlEDnBaqNMUoSnjBFECDz6aVvqGyMECA6
         Ts4fVoMYUo6J4M1kpNFxFtVBaWx6FOAcqdXDAlz6iuDLlcxu9A5RcTT9Xg69KRQFtQ4q
         7ExQgcBXR5QFtQeul5vToh5QvVIRTybcIqRZxJlxmXL/YOmxDdksTkcBEbVxcydg2SA+
         nLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752138270; x=1752743070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjeE3o0RxHj2yfYkiiw6nT6qNxm9Jz3LUgLh8cuza0U=;
        b=cVjJXDZehUTZCrphFmBdkm5PEi1N3HbHv0ZUbswHQOILBGFAAiyt9KhDnzqNEM6BNQ
         xllKR1Q1zm+0ix6T0LNwGgO92AQtIgOi0n2Ze6ZPERNsCvwlRM+r6LrVRXNLD5YqyCYs
         Dl1o193p5oLQwzcUVRlEKOpWj8BLh+rI9fwvJ1uGDrEytr2DDgly0KtPH7uQCUaX5JM3
         9CSNNoCHN4xGrPvN16iwagyA8UqhRjw7CuERcF0hqHrd7KZcGQoPMGyTtMYhDAkcrURX
         pk2vJOr1Hi8q1y6oZ03Gu7Dlr4DFzs15+stTM4hiiJdgjTW+RDV2XPDpF1Klz35d0728
         03yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZH4O1J6tbhl5trIHfo4o7VpFQ8djSCVlR3TBMpfx2qhHxLeVoNn+JZ/nBrqzsBIA5HQyIHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0YwAZqdnF0CRMXZf0KnMiiND2HyMDF82LJKVoLtLs4kICm3kF
	BOPFTzL4l6F/fMuo0FlMavwjerG1t921H0+wH+zjH2syoHqwFQtYWkvxJ7r9hKkgxg==
X-Gm-Gg: ASbGncv3ly6MMRGf9hbQSJ2k/rOjdQpg6NPhHPCecQ3ao+eiEXd7qNxdByxMiKIi1gV
	9oobV9LgzKLHcCdwcJAFlfbqAFDIxjId4JqzdGABJcox+42TQ9rLUPXkCD2QyXFytGS/hAWXjz2
	8skYmyJaEUTuXyxgPMqD7twqIMooc/mPEul6MgX35Up/V5AhSPpad8JMi+3e3/XPcHGVHLH41pm
	tQZ28JrL+UGxhTFjWs7wKdTKQGnTis0+Fs70gTpSYo68QVKoOkux2JWeexOHqmiUuX268f2FgtR
	S3+hnJDpV+KQKWR7z//SCdv3/HDj3KvSvOs95Ou560S40NKnuf62C7ujW++N8BTIoNZ/NxQq3T1
	clNdUOU25AeswkevdH4Rn
X-Google-Smtp-Source: AGHT+IEUCwoHbQmo67knPJ74PmLn5sw1tOh05zzgGXqHLIH2hLihrsg/DC4THre9sZfOvA98I9mneg==
X-Received: by 2002:a17:902:f547:b0:215:65f3:27ef with SMTP id d9443c01a7336-23de372b90dmr2361415ad.12.1752138270075;
        Thu, 10 Jul 2025 02:04:30 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f49502sm1369146b3a.115.2025.07.10.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 02:04:28 -0700 (PDT)
Date: Thu, 10 Jul 2025 09:04:19 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	corbet@lwn.net, will@kernel.org, bagasdotme@gmail.com,
	robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
	vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org,
	jsnitsel@redhat.com, nathan@kernel.org, peterz@infradead.org,
	yi.l.liu@intel.com, mshavit@google.com, zhangzekun11@huawei.com,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
	patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
	vasant.hegde@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v7 27/28] iommu/tegra241-cmdqv: Add user-space use support
Message-ID: <aG-CE0jUxK4k1FMb@google.com>
References: <aGRmaOORg-YDfncY@google.com>
 <aGRozoIDIlgl9H9x@Asurada-Nvidia>
 <aGR55PUBnwb8qT8U@google.com>
 <aGSBTpY0nkdp2TTL@Asurada-Nvidia>
 <aGSNmf5Q82xEbDpX@google.com>
 <20250702180541.GD1139770@nvidia.com>
 <aGaXqwzfLwsgCH6n@google.com>
 <20250703175532.GF1209783@nvidia.com>
 <aGbQipeSn0aZnwZU@google.com>
 <20250704125012.GK1209783@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704125012.GK1209783@nvidia.com>

On Fri, Jul 04, 2025 at 09:50:12AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 03, 2025 at 06:48:42PM +0000, Pranjal Shrivastava wrote:
> 
> > Ahh, thanks for this, that saved a lot of my time! And yes, I see some
> > functions in eventq.c calling the iopf_group_response which settles the
> > CMD_RESUME. So.. I assume these resume commands would be trapped and
> > *actually* executed through this or a similar path for vPRI. 
> 
> Yes, that is what Intel did. PRI has to be tracked in the kernel
> because we have to ack requests eventually. If the VMM crashes the
> kernel has to ack everything and try to clean up.
> 

I see.. thanks for clarifying!

> Also SMMUv3 does not support PRI today, just stall.
> 

Ack. Thanks!

> Jason
Praan
