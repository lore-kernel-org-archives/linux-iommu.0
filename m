Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011104C70
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616840; cv=none; b=V61JgnSp1gkvJeEeKlKGKYh+bKPynuODQ17ceNfeOCxA29eeHiZvjdJ/FhDLh2c6nxJcOVIki8MNYX7F7xWGIhqebppdizSMKs9Udkd+8qh7HQKV8c8JaMuqMz0+g7Mo4UlndmOHXvBlJNMgLUExacn+Vm6+BFHxq2zz8fyRxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616840; c=relaxed/simple;
	bh=jpLsczkirjl3znww0vHtEndaxD24N3ExtJwt48GA4Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRFv9WBfubbGHS8QTvRbRw5280zsQwX1qIi+6ZUacTJ9cSIFcmCz5QX98zzjY69r5NJQnhIcNxLectlO0dB9OWVNjoPSjWBI7lGiqHxPLS07PsjZmYCu0eK2pL4bg/o7eVa4ZZembBXHgA2IwsE9BNl3ICAk6UclETMlF3vdsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLiGyHsW; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLiGyHsW"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso270754f8f.3
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 16:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740616837; x=1741221637; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jpLsczkirjl3znww0vHtEndaxD24N3ExtJwt48GA4Ow=;
        b=KLiGyHsWRDClKBlo457CBqd0XTfLu9+WAsJbzGisC+PP1IrCY5UPwVF3wmAvnm0tlB
         EDtOfoL+/WUCQ1dHvwkYg47LwqyXKUVYN9qRLuE+spAnVPd9m7AVSn6jv/O1gLz6DDYu
         ea07MH6pv0nalbm+tpLYTpwlgRjIsqfsUEjTAdFs5+Bnt+B/NdAP6jIoFPGHqQX8GLbQ
         LpPkZVKcVLx7K5oadnfT3ii7YclIr9FO6tCzz6uKF0eZFTbApAyRYcw7u/XrQ680UQv0
         /wBBkBlNVn+FmTgfdL3PaYHCuyWMGriuViYjWjhOD9qUmoRwB2Ofn+xfrep9D2+ohQpl
         QATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740616837; x=1741221637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpLsczkirjl3znww0vHtEndaxD24N3ExtJwt48GA4Ow=;
        b=ScvnxQAkqWUnr2OsM+ClE6K+Ut19gwA1vKQMpOr5VqqsmrvLAhEz1fz34pSv2OW3Bc
         wQaFsx+TNns5oycOuo9s0WoDH1veFZf6YhtyJzVW6J3Omqwg18WbRWQa2W9mGGopXvV5
         ZBKOpbq4y6Rx346Qa37ARj5xcuvOFH2NC+DcdbPAJbfqIsN/J7/d7/r28aTnH4A3lteR
         SLaLLi1MfmxTSd2xdE01IN1DhAvdR46P7urpLwCR+8SxWGkYQbcqWOcIMvherT+jpLJn
         wBKyZgeeUHXK4957tfikxESzi6qzh7lK6nah7he54oG1gwLyOAlmi6xJEjKAvXZPxl+l
         06zg==
X-Forwarded-Encrypted: i=1; AJvYcCVJZKOBLb1F8SNF+JHkAOQoPo9srk8Ru8w/bGuMfh08KHAClsjrAqSUEMPBQrpnVtsyznnXbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhGxPzGvg9jrRExYbyuJDQAmFUF1o+QqZVQRsKKkiiYv5KXHu1
	Y8f6MAXpCBzfyuJ9dcjjGabwzPzG6L0V0+hUx0AvbjFPRWbjPm7S
X-Gm-Gg: ASbGncuA4obkx6fx6/z2d9rECebSkIXmvKxvnKgc/TqQeBUZC+sEXRyXe4VGqzwSDgk
	ZTwJtH4UF8sTdYaQ/7RQkgZKrc0j4vUNspEDgDNjcd3aTRAw10GSBIivJrK7DH1HVAMV3uqwyhx
	64R5KriwctOnCLs+XFmj00iQSR9rYlWPNtaaHB20xOW77YXMTobhFE3XMRGd6zoRp56XmZTEnxZ
	uogBzB+LbLFgqJz4JNaHxJpvtVld5naBjieIOQuSX7BskoM/7r9ijQAOvnC4ymROOn3Mv9GTaki
	/70jk/ErIFtp6Pc3KJ6slBoL5hnSnR/NZPY5sSLygulL9xGfiFDjc5EYhHc5N6fkRI+LRnXUyKC
	eYxfaS2EdJ7IaMpvuqko1sCso3cbuQTMHcwfqBuhHyQ==
X-Google-Smtp-Source: AGHT+IHrZFOinDSrmWi4+m1t5sYEIk52JDxPafuRYroaeZUSAqukvpFIFZVBSIhGoAPxRg+hZKGI9Q==
X-Received: by 2002:a5d:59a3:0:b0:385:d7f9:f157 with SMTP id ffacd0b85a97d-390cc631b55mr9933881f8f.36.1740616837065;
        Wed, 26 Feb 2025 16:40:37 -0800 (PST)
Received: from [26.26.26.1] (ec2-63-176-201-248.eu-central-1.compute.amazonaws.com. [63.176.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e46f580bsm402728f8f.0.2025.02.26.16.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:40:35 -0800 (PST)
Message-ID: <f29818dc-a0a7-46c4-b541-1b469a6b3304@gmail.com>
Date: Thu, 27 Feb 2025 08:40:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
To: Jason Gunthorpe <jgg@ziepe.ca>, Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Yunhui Cui
 <cuiyunhui@bytedance.com>, dwmw2@infradead.org, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
 <20250226130423.GF5011@ziepe.ca>
Content-Language: en-US
From: Ethan Zhao <etzhao1900@gmail.com>
In-Reply-To: <20250226130423.GF5011@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/26/2025 9:04 PM, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
>>> Provided the system does not respond to those events when this function
>>> is called, it's fine to remove the lock.
>> I agree.
> I think it is running the destruction of the iommu far too late in the
> process. IMHO it should be done after all the drivers have been
> shutdown, before the CPUs go single threaded.

Hmm... so far it is fine, the iommu_shutdown only has a little work to
do, disable the translation, the PMR disabling is just backward compatible,
was deprecated already. if we move it to one position where all CPUs are
cycling, we don't know what kind of user-land tasks left there (i.e. reboot -f
case), it would be hard to full-fill the requirement of Intel VT-d, no ongoing
transaction there on hardware when issue the translation disabling command.

Of course, once you have clear motivation to re-position it. we would like
to work on it.

Thanks,
Ethan

>
> Jason
>
