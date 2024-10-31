Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC41BE841
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396533; cv=none; b=LWZRHs8oNiYJ2AyVvtYoFkhWI5izM3Rb9ih0dU8fotOZJR5NI519/4qZv/IpsdFQJkxNnhtILKrOd0hNvE3WAolp/EIPEtAXUwUrLuguA1Wv8TptPPvBK3Ce23Jj8dk9xXmvKBHdE/IJT2FkyGohTKNRvf5RFHEKuaRphY9rFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396533; c=relaxed/simple;
	bh=Rf6mnPpy9l06l6dtMxbRoYeknemanNGyXKBqhdu+XDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axr+7N7AEJJYGz03Gm///6hWs6nxB6e7KH2I4ogvIH/2AZgX7GEFPp6NhS4uXpZT49Ton+Q6r0y45ZAfj+0Mf/q3Lqb3AwMT8TiKOrV1s59w/96pGkKXruPzcCNWlnER9+rlpjLjRZxF9N9xOIIkOIS1p4V41wAsjaqfh3HlAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PfwnE2Fa; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PfwnE2Fa"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so44977939f.3
        for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730396530; x=1731001330; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x40+SjEaq5943TtiP/UXom9Wy7SciOs8xRpZ9sdjGNw=;
        b=PfwnE2FaKIQ/fAHNEJXYy4tL3d41WPCC9Fm8he/+Il4n7Jesrgygll3Vwm8uNLQoGk
         Jms+KcJykKsm82YhI6tPGvfFB2RLjyDIhbteb0I7gjX58f+H5OLUIEVyWWzWWg6ybdQ8
         aDrxULYiijKp+0GZtTpo+cNiG3HXpGi+LePjKVeNMkPT5CO/pm8w1TbzgqH0KHzGx8W2
         y6bE/ClqgI/zFVIs1FGT4cssllsI8xCJJG/fbsMwf3FnxPWBcC2v0TL/ZE9aenplKvbT
         HLdls/lZyvvGycuv/tfuxZ9eyQC6B/3FUovfZbs+5G5ij2GS2wtkV97ZYT2/lvhHahKl
         Zw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396530; x=1731001330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x40+SjEaq5943TtiP/UXom9Wy7SciOs8xRpZ9sdjGNw=;
        b=fGrmnPwxnUuj1eKoXnb9a562/j/JCLPo8l+mMz2830Qz7gAe6euX4Wwvm8CCw/Byp2
         95yl3jCZlysdj++89hsSuCSxMuE3wQkVpoPFYLOVIhuVmPuFlQHd5riUjVrjsxpHUV22
         JETFfjXGg03afhYnFdktkPtYtLwX3aUsPYh5xOcODRS1KsKAbzM4TpMlkmbF/sg7vlXR
         CwUNJpkWp7olruMIZO8wBnS5SqNHsUNa9lzzqEAR3+Xcr//CJNXCbONiKXASa/ED1/ql
         WtJfBoiRDIHmckNwHMZLS1xTo2F2ZvOm+sfyYeH81L9pZt8FzL3hhuQ73qIsClsx4spg
         FWhg==
X-Forwarded-Encrypted: i=1; AJvYcCUjMveHKlOYyLcEpSvNxqzThXUZbmIS+/msMZ/UplILRvWIgmLtViQcw57VwM7YasGE6LVpHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXgr5v3wWIXW5UPqS0dk0cn2ZSLdG1gbG6OYb9MF7iYV+JVaCW
	4DFiKUPHZON6wizVHLm92cF+jNZY7oE0NQu4VlF7iQcGikhqgIIy4ctru3zxFyw=
X-Google-Smtp-Source: AGHT+IG0ksmejkYn/tsWOFj5UDq65mB5fTjw0uagwhlJwyCNesDEnrmSpfLQj8+GbqVblFhVpBgdOw==
X-Received: by 2002:a05:6602:15d4:b0:83a:c242:82aa with SMTP id ca18e2360f4ac-83b1c5cd123mr2127656539f.13.1730396530549;
        Thu, 31 Oct 2024 10:42:10 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83b67b4b157sm40604339f.22.2024.10.31.10.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:42:09 -0700 (PDT)
Message-ID: <2a0fc88a-53af-4d7e-b8fd-8cee3f0804a1@kernel.dk>
Date: Thu, 31 Oct 2024 11:42:07 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
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
 <20241031083450.GA30625@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241031083450.GA30625@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 2:34 AM, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 07:44:13PM -0600, Jens Axboe wrote:
>> On Christoph's request, I tested this series last week and saw some
>> pretty significant performance regressions on my box. I don't know what
>> the status is in terms of that, just want to make sure something like
>> this doesn't get merged until that is both fully understood and sorted
>> out.
> 
> Working on it, but I have way too many things going on at once.  Note
> that the weird thing about your setup was that we apparently dropped into
> the slow path, which still puzzles me.  But I should probably also look
> into making that path a little less slow.

That's fine, just wanted to ensure that no push was being done on this
before that was resolved.

-- 
Jens Axboe
