Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CD633CEBC
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362734; cv=none; b=MWRseWsenzmRyqd+qAJLapH22whonyo9/Cl6QYFJSv6m4vXNVJjoZ3LvGcostpsBF0xkYjc5c/T/WUwk5GTx5TM9Iead4ozLT189vgKU042wmDCUps/mgg8vIl3i5O65wiUFSGR74idA832vjtzakgmfOyinNZsGwXj8FvynXQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362734; c=relaxed/simple;
	bh=RxBxFvM3oAmYwj+WD7NzxAgbGcX4OOVwNkYZi+Tgv38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa3nrBuE0uZdRvA3I2LlU1JaA4bJmWrn8LNzWdHqMfj+uPsjBuPNgnss8yRypGKlTYTUgPEl6Cm5qE/Kh0S8ctFzT1xaHcS31ReO+PuM+/9vJP4o4pJQ3kJ7KJqKdmaZnEyqmkVqsMSCxHIALz56OyvinyYgBR2i7px85fgTC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eAesbtpG; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eAesbtpG"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b1e54aefc5so3773985a.1
        for <iommu@lists.linux.dev>; Wed, 05 Nov 2025 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762362730; x=1762967530; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wkO/YIgxaPM/wEK82kFqjfst+ouG4RuvuAOrJV+EoBw=;
        b=eAesbtpGTAwnPJBKNk1mNnYIIW5cAuVcZCJXemIHNUFegKvI3t59nXH56uaPq3A76j
         7BL91lypdZ9/otK/EtDjcA2stzhQE77eBatdK/zG7byA0iLlrEttUShLEGItp7VrTivH
         cRxsboVUleJjSjE1/0+5GrjN2fsJbIA0vHEeSkP7d3TXW6cc1dH7szEnqeHIqBV7skot
         NJq3W46iR7lb3E29JQ0vJQJqRyUro6e+hwIajaZp+FXbpE6X5K0prq/6yaWw4bKEDAgZ
         OZr7BPnxwI03CT1VJMg691JUzSug8WGesqLUK7pSCRBUe7rG7XYjzrQNcvYCQ9qFw5pK
         6vow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362730; x=1762967530;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkO/YIgxaPM/wEK82kFqjfst+ouG4RuvuAOrJV+EoBw=;
        b=lMRWSp2+eQ6ThmLEHnN2i5eclVWQ8ycRVzvmLIaQFbohdsphGyGPmu6sn8KtDJQqmW
         lVGhn2PIj3i7FPjgXt3SEM+XQkWguRTiYgKDcifWuTYKKEeei+9USYz5uyu0qsbzJ3jr
         KwL0XJe9MfJ9MOJUDooCIHzarVL3XF1gKLCLzwSPn5BzmCjNBXhhZEldjVWrS0oqkDRm
         +Pqhnwz0vDDTMvw7EM9wHn2LZG/Z//XdbaPMDan+4EPOhj1li7STm6xg0Y4FTdl+t/Bn
         +hpYJRR0YnqWdAuxiu94NbHE64GzbnTfkovdIxtzw3ji7ElQu6IWEyzCOXeeYNwjnJf8
         sA0w==
X-Forwarded-Encrypted: i=1; AJvYcCW9aWx7RpO8rNnqIDJ7OztMgepYqVeVOe0NT4YTCnArIwju7tVZuoaj104p9n+d0o3CsUtlhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/5xnhzVtIPdL6Dwrjhzdz12DH6tXOTKfepuiEtpqxjUjjOTS2
	cCttwPVRndgK+N6MH2Mdi/uNa5kPIsiTG0iv4cV/xsYFPH46sOcYT4qZjlw9xce8QyM=
X-Gm-Gg: ASbGnctZUDpTfTaKHCxWfgwoAcn6UufxYIyCsbp+9yVx+bH5YZSI1/3sVSdZ9HZgwki
	0gx2kg9T+4NFv+7VHoxIPX5nsCmlvOnZG8dMn0MPSp1GVeU+e+QdzUrIN0DQTyiNmcBfs8w6vgh
	DakkjuplEF50I8ONzirePyCihA3BzPHA/bcyYz98qRqhS48PwZ+gSt6HuKLS8iqFFND4EkJPQfr
	OhOQZGQuVNpIyvgQhPQm0LjHaZ1DVyk/EbgImBmQbLqvJfhz8wBBZCPkc1vuawu6iLzXUc7/+D6
	WkrD6Jvt0PA5vVg5aMDZ1wZ91DulriGakmVQ/UqZdp+hR12a2UNC/BKsK6eMI4CCNsu6PPYzuqD
	qPUsaapZi6FvtyD5qTd/sSlrMqj95+TCCavLuCuUUstECYbPaR6CQDToBNvBhDu347Tz8NNKvwI
	W6lUFhh3rp/asB1nkdGdyCh0Tr9/FMicLEyf/sCE1+tsAkkA==
X-Google-Smtp-Source: AGHT+IE+H5A+GWBd94mKAScAzkbN/plh8wCL54OtyUq33k2cpyVKMqW/YnW1kIG+WLt6H619/vMFBw==
X-Received: by 2002:ac8:7e93:0:b0:4ed:2140:7a96 with SMTP id d75a77b69052e-4ed7262fff1mr49444101cf.58.1762362729905;
        Wed, 05 Nov 2025 09:12:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed5fabbbc9sm40585631cf.6.2025.11.05.09.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:12:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGh3I-00000007Bqn-3NXB;
	Wed, 05 Nov 2025 13:12:08 -0400
Date: Wed, 5 Nov 2025 13:12:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, maz@kernel.org, oliver.upton@linux.dev,
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 15/28] iommu/arm-smmu-v3: Load the driver later in KVM
 mode
Message-ID: <20251105171208.GN1204670@ziepe.ca>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-16-smostafa@google.com>
 <aMQmA9cLaeYWG5_C@willie-the-truck>
 <aNKwROPzDCWgJBGQ@google.com>
 <20250923173806.GF2547959@ziepe.ca>
 <aNppE9A3PDiDg_1W@google.com>
 <20251002151308.GG3195829@ziepe.ca>
 <aQt9-kTCe8TpuyVq@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQt9-kTCe8TpuyVq@google.com>

On Wed, Nov 05, 2025 at 04:40:26PM +0000, Mostafa Saleh wrote:
> However, that didn’t work because, as from Linux perspective the
> nested driver was bound to all the SMMUs which means that any
> device that is connected to an SMMUv3 has its dependencies met, which
> caused those drivers to start probing without IOMMU ops.

??

What code is doing this?

If a struct device gets a fwspec attached to it then it should not
permit any driver to probe until iommu_init_device() has
succeeded. This broadly needs to work to support iommu drivers as
modules that are loaded by the initrd.

So the general principal of causing devices to not progress should
already be there and work, if it doesn't then maybe it needs some
fixing.

I expect iommu_init_device() to fail on devices up until the actual
iommu driver is loaded. iommu_fwspec_ops() should fail because
iommu_from_fwnode() will not find fwnode in the iommu_device_list
until the iommu subsystem driver is bound, the kvm driver cannot
supply this.

So where do things go wrong for you?

> It seems device links are not the write tool to use.

Yes
 
> So far, the requirements we need to satisfy are:
> 1- No driver should bind to the SMMUs before KVM initialises.

Using the above I'd expect a sequence where the KVM SMMU driver loads
first, it does it's bit, then once KVM is happy it creates the actual
SMMU driver which registers in iommu_device_list and triggers driver
binding.

This is basically an identical sequence to loading an iommu driver
from the initrd - just the trigger for the delayed load is the kvm
creating the device, not udev runnign.

> 2- Check if KVM is initialised from the SMMUv3 driver,
>    if not -EPROBE_DEFER (as Will suggested), that will guarded by the
>    KVM driver macro and cmdline to enable protected mode.

SMMUv3 driver shouldn't even be bound until KVM is ready and it is an
actual working driver? Do this by not creating the struct device until
it is ready.

Also Greg will not like if you use platform devices here, use an aux
device..

Jason
