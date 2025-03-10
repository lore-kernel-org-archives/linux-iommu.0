Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224591DB34B
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636363; cv=none; b=Gnhc8YnqsXk2niwHFbVYOkkimLt5dZIx1JkIqbcIcPiWPA7ZNow6HI5JPPcB9namT8QE75CavZ90MlZrAoLYXV2ayzaX9lUTAuf8m/oj1tnq88DnHLgdjK/4kJlo4tqqOcf0WXc5ehjDZgcLUDoN3UpgUJukUgZCgxepiev9+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636363; c=relaxed/simple;
	bh=1tkpbiZ7E17Wt7R9E9H3UyjHoEvZGC4NKmCrbl4dbTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJN9azftsU8CPv/WZ8N63tPqxB2K02SdyoGscSewhMj5jej1CfHZaiURPN35oy6UKUZmOEbepkMd5gQZOUIOU0B6A6UO1A26e50pOT4GSIzGUdcHgkDqxoSwq64p3uN1bHxKgVIlc5cHIgH05Yy96clkq5OrBYssJHnhmu7W0g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B55F3152B;
	Mon, 10 Mar 2025 12:52:52 -0700 (PDT)
Received: from [10.57.39.174] (unknown [10.57.39.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2537B3F5A1;
	Mon, 10 Mar 2025 12:52:40 -0700 (PDT)
Message-ID: <c99db1aa-8b3e-4a8d-8cee-b9574686cb7f@arm.com>
Date: Mon, 10 Mar 2025 19:52:37 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in
 arm_smmu_v3
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
 <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com>
 <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CALHNRZ87t7eXohTcpFnejFAPDsyE_1g0aPsASuQ7y5c_zxnLUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-03-10 4:45 pm, Aaron Kling wrote:
> On Mon, Mar 10, 2025 at 7:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2025-03-10 6:11 am, Aaron Kling via B4 Relay wrote:
>>> From: Aaron Kling <webgeek1234@gmail.com>
>>>
>>> If ARCH_QCOM is enabled when building arm_smmu_v3,
>>
>> This has nothing to do with SMMUv3, though?
>>
>>> a dependency on
>>> qcom-scm is added, which currently cannot be disabled. Add a prompt to
>>> ARM_SMMU_QCOM to allow disabling this dependency.
>>
>> Why is that an issue - what problem arises from having the SCM driver
>> enabled? AFAICS it's also selected by plenty of other drivers including
>> pretty fundamental ones like pinctrl. If it is somehow important to
>> exclude the SCM driver, then I can't really imagine what the use-case
>> would be for building a kernel which won't work on most Qualcomm
>> platforms but not simply disabling ARCH_QCOM...
>>
> 
> I am working with the android kernel. The more recent setup enables a
> minimal setup of configs in a core kernel that works across all
> supported arch's, then requires further support to all be modules. I
> specifically am working with tegra devices. But as ARCH_QCOM is
> enabled in the core defconfig, when I build smmuv3 as a module, I end
> up with a dependency on qcom-scm which gets built as an additional
> module. And it would be preferable to not require qcom modules to boot
> a tegra device.

That just proves my point though - if you disable ARM_SMMU_QCOM in that 
context then you've got a kernel which won't work properly on Qualcomm 
platforms, so you may as well have just disabled ARCH_QCOM anyway. In 
fact the latter is objectively better since it then would not break the 
fundamental premise of "a core kernel that works across all supported 
arch's" :/

Maybe if you can find a viable way to separate out all the arm-smmu-qcom 
stuff into its own sub-module which only loads when needed, or possibly 
make SCM a soft-dep (given that we already have to cope with it being 
loaded but not initialised yet) then that might be a reasonable change 
to make; as it stands, I don't think this patch is. And it's definitely 
not a stable "fix" either way.

But frankly, weird modules happen. Why the heck is parport_pc currently 
loaded on my AArch64 workstation!? I can't even begin to imagine, but 
I'll live...

Thanks,
Robin.
