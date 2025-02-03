Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FAB1F9AAB
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738587716; cv=none; b=KP+RGIuIoJ/87TqrLjin/jY8DgVH7DSQhT927t0VjMcAn8NEktnykFLfYHuM7bxl27H6vvUppJ9e1o+Bp/biGhoP20gSlZoeqdANPKvRidwJO0u0F04O1V6p7eWebePrFRxhRmBaWBrq3ZoPp9pzMBqNRtCLTjBlHbG155moQ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738587716; c=relaxed/simple;
	bh=7U3L4yXUTJhjGPwyS5Q2iEGQ0qdZzVQZBVRxTXwRq1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rmpt8P0U1bgiO/UfOmzuiHfu5AHx99VYwipyi9FH8hYHZ5AYcPESWM2VHfWQDlaJXvvaTuooUv31yhqN4vrLkgQS6aQqkN7L5r4SZF6T+oAzMveTo9cnJA8glMoiN9P+GpZ8mmve3bRDFZUZPdSKb1s3driQ98w6ch/7OeXeL+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DDB511FB;
	Mon,  3 Feb 2025 05:02:18 -0800 (PST)
Received: from [10.57.37.14] (unknown [10.57.37.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C7203F58B;
	Mon,  3 Feb 2025 05:01:52 -0800 (PST)
Message-ID: <42a8ca6f-a881-4b4c-9ddb-bf3f2bc6f539@arm.com>
Date: Mon, 3 Feb 2025 13:01:45 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: iommu: flood of ahci 0000:e6:00.0: AMD-Vi: Event logged
 [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
To: Corentin Labbe <clabbe.montjoie@gmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
References: <Z6CGzUSV7llweytQ@Red>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z6CGzUSV7llweytQ@Red>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-03 9:05 am, Corentin Labbe wrote:
> Hello
> 
> I have a supermicro server which is flooded of kernel message:
> ahci 0000:e6:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xa14a4000 flags=0x0070]
> 
> The server works perfectly anyway.
> It happens with official ubuntu kernel vmlinuz-6.8.0-51-generic.
> I tried also a custom 6.12.6, same problem.
> 
> I tried to update bios, no change.
> I tried iommu=soft, no change.
> 
> I dont know what to do next.
> 
> Regards
> 

> IOMMU group 83 e6:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0 x2 4-port SATA 6 Gb/s RAID Controller [1b4b:9230] (rev 11)

Wow, a Marvell SATA controller doing something other than the usual 
phantom function quirk, that's a nice change :D

I'd guess that firmware has left it running for something like legacy 
IDE emulation (if that's still a thing?) or its own soft-RAID driver, 
but neglected to declare an IVMD entry to described the reserved memory 
region(s) it's using for that. A smoking gun would be if 0xa14a4000 
matches some firmware-reserved PA in the system memory map. In that 
case, if you're lucky you might have some firmware/BIOS option to 
disable fancy behaviour and leave it in plain AHCI mode. Otherwise, 
booting with "iommu.passthrough=1" (or the even bigger hammer of 
"amd_iommu=off") should at least allow you to ignore the issue.

Thanks,
Robin.
