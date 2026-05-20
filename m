Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092FF233925
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293646; cv=none; b=OuPX1S54XYETuX9j0TMUNNfP6Bn68IrHtoXSEv3IizfyA0N7dfEx2w3eVv5xi1xGSDYZh6vsrrbEVVX9eiyoNMpx1uFbKj+41hFfOk1UmHYrMWxAunWMQIkPsF4G+slLQUiVsyAtVvi6auPVrgqE0o7Pr2lw/513A9+oT68Kpj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293646; c=relaxed/simple;
	bh=97SF2OTzJd/H1caJQialhgZHqe7kO84O/EEUdMecaHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJIRLqDz2duY4+ba32DjyTkwn9je9w/NcH1KAQCGCr0E1kKinxQSrDGEDtSNlbPfe1ARsccxGb2wHuHXmnjXZK6q7sNeU2ee2qaYmlm+KWtek8BeSryOi5gtEGYqztUiFqro/SAWwJedOTE7RvHHeySS3Y1N5i+NZt02O54rdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CG95ZInu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CG95ZInu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B94025DE;
	Wed, 20 May 2026 09:13:59 -0700 (PDT)
Received: from [10.57.34.79] (unknown [10.57.34.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C12333F7B4;
	Wed, 20 May 2026 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779293644; bh=97SF2OTzJd/H1caJQialhgZHqe7kO84O/EEUdMecaHI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CG95ZInuIVPpUBu6Xfl19RNyqZf8H0QurnIU4lhIh81AZtdzbPoIzFa7ZVt+1V1eW
	 Xz4irlUKZipY5f5jSKAiW2pE8SC2bC6mYQ65YaWwltJopwLzl8G9qLlWFS+Tx05VT6
	 MsX5xoiJLkZxOBujejBKnr4V15lpQXkAFCWqidZo=
Message-ID: <ccfcf795-4f9f-49c6-a891-c69c99c47198@arm.com>
Date: Wed, 20 May 2026 17:13:57 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/riscv: prefer WSI on IGS=BOTH when wired IRQs are
 described
To: Andrew Jones <andrew.jones@oss.qualcomm.com>, fangyu.yu@linux.alibaba.com
Cc: ajones@ventanamicro.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 guoren@kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 palmer@dabbelt.com, pjw@kernel.org, sunilvl@oss.qualcomm.com,
 tomasz.jeznach@linux.dev, will@kernel.org
References: <7dc61855-d916-4659-8137-7f3457f6a56d@arm.com>
 <20260520134416.28552-1-fangyu.yu@linux.alibaba.com>
 <kkx6nqyc3evbfeutxkzwv6kbrotsbxopkvit2e2qh6hljicq5m@x4bb54loffkk>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <kkx6nqyc3evbfeutxkzwv6kbrotsbxopkvit2e2qh6hljicq5m@x4bb54loffkk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-20 5:03 pm, Andrew Jones wrote:
> On Wed, May 20, 2026 at 09:44:16PM +0800, fangyu.yu@linux.alibaba.com wrote:
> ...
>>> (As a side note, is there a reason this is calling of_msi_configure() on
>>> a platform device when of_platform_device_create_pdata() will have done
>>> that already?)
>>
>> Good catch, agreed.
>>
> 
> This is here for a device creation order issue. We have similar patterns
> elsewhere, e.g. drivers/irqchip/irq-riscv-rpmi-sysmsi.c:268. When the
> device is created the MSI controller may not yet have been probed, so
> msi_domain will be NULL. The of_msi_configure() here ensures it gets a
> second chance. Anup says he has a device driver framework solution to
> avoid this pattern that he intends to post soon. I'll clean this up
> after that.

Ah, that sounds like something somewhere between of_msi_configure() and 
platform_device_msi_init_and_alloc_irqs() needs to be able to return an 
EPROBE_DEFER if a parent is specified but not ready yet, similar to 
regular of_irq_get(). I guess this hasn't been noticed much yet since 
most MSI controllers run off early initcalls rather than being regular 
driver model drivers - OK, fair enough for now :)

Cheers,
Robin.
