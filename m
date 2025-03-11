Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7BC25FA2F
	for <iommu@lists.linux.dev>; Tue, 11 Mar 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714180; cv=none; b=nCmOOLETAfyYdDOga/4GeVoT74zf3XBs8x05XUOnydPuAb2nEVJfuJ31hrdHWf+AIzgO0m4bX1ZpJ0m1cGCfGmqIPJLwjmA2ZunIGXhjES9ZXM4obK9xEjJ4xjtxElhbpgF4mKAEjT37iW3j+iX4Q03vFLnHn+0HvYpJkApiPwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714180; c=relaxed/simple;
	bh=dNaFF2I5Gxfj66buzQR0TbVjSPqPPsRobfCdX/cIf1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mcy+MxEWocSATvbGB2izAw9WXuKUfmhnz7oYrffUJ3cJ5mek2a5vWJiKJ0jg7b6SwfLRReM3OglwLH1mPeDRhXb5ZnJmUmGJyTnQPj1J1qu1Ey1rQT8lDgaXHqHUmH5LDoP0mTip4nVUx7NEjQ6WoQAZ/MnFYljgGvfK1oeoo6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF71B152B;
	Tue, 11 Mar 2025 10:29:48 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A6303F673;
	Tue, 11 Mar 2025 10:29:35 -0700 (PDT)
Message-ID: <053851d9-49e3-46f7-86ae-59dcee6ddaa9@arm.com>
Date: Tue, 11 Mar 2025 17:29:13 +0000
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
 <c99db1aa-8b3e-4a8d-8cee-b9574686cb7f@arm.com>
 <CALHNRZ884fF4kpM_=N4d1vR27-9BOeaS7_cN_JhKN0S6MYQVQw@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CALHNRZ884fF4kpM_=N4d1vR27-9BOeaS7_cN_JhKN0S6MYQVQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/03/2025 8:15 pm, Aaron Kling wrote:
> On Mon, Mar 10, 2025 at 2:52 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2025-03-10 4:45 pm, Aaron Kling wrote:
>>> On Mon, Mar 10, 2025 at 7:42 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 2025-03-10 6:11 am, Aaron Kling via B4 Relay wrote:
>>>>> From: Aaron Kling <webgeek1234@gmail.com>
>>>>>
>>>>> If ARCH_QCOM is enabled when building arm_smmu_v3,
>>>>
>>>> This has nothing to do with SMMUv3, though?
>>>>
>>>>> a dependency on
>>>>> qcom-scm is added, which currently cannot be disabled. Add a prompt to
>>>>> ARM_SMMU_QCOM to allow disabling this dependency.
>>>>
>>>> Why is that an issue - what problem arises from having the SCM driver
>>>> enabled? AFAICS it's also selected by plenty of other drivers including
>>>> pretty fundamental ones like pinctrl. If it is somehow important to
>>>> exclude the SCM driver, then I can't really imagine what the use-case
>>>> would be for building a kernel which won't work on most Qualcomm
>>>> platforms but not simply disabling ARCH_QCOM...
>>>>
>>>
>>> I am working with the android kernel. The more recent setup enables a
>>> minimal setup of configs in a core kernel that works across all
>>> supported arch's, then requires further support to all be modules. I
>>> specifically am working with tegra devices. But as ARCH_QCOM is
>>> enabled in the core defconfig, when I build smmuv3 as a module, I end
>>> up with a dependency on qcom-scm which gets built as an additional
>>> module. And it would be preferable to not require qcom modules to boot
>>> a tegra device.
>>
>> That just proves my point though - if you disable ARM_SMMU_QCOM in that
>> context then you've got a kernel which won't work properly on Qualcomm
>> platforms, so you may as well have just disabled ARCH_QCOM anyway. In
>> fact the latter is objectively better since it then would not break the
>> fundamental premise of "a core kernel that works across all supported
>> arch's" :/
> 
> I'm not sure this is entirely true. Google's GKI mandates a fixed core
> kernel Image. This has the minimal configs that can't be built as
> modules. Then each device build is supposed to build independent sets
> of modules via defconfig snippets that support the rest of the
> hardware. Then what gets booted on a device is a prebuilt core kernel
> image provided by Google, plus the modules built by the vendor. In
> this setup, qcom-scm and ARM_SMMU_QCOM are modules and not part of the
> core kernel. For a qcom target, arm_smmu_v3 would be built with
> ARM_SMMU_QCOM. But then any non-qcom target that needs arm_smmu_v3
> currently builds and deps qcom-scm. But there's no technical reason
> they need that dep.

There *is* a dependency, because when ARM_SMMU_QCOM is enabled and both 
ARM_SMMU=m and QCOM_SCM=m, arm-smmu.ko references symbols from 
qcom-scm.ko, so the module loader literally cannot load and dynamically 
link one without the other. As I said, you are welcome to do the work to 
try to relax that dependency somehow. What you cannot do is turn off 
ARM_SMMU_QCOM and functionally break ARCH_QCOM while still claiming to 
support ARCH_QCOM, because there is only one arm-smmu.ko - the fact that 
it's not built-in is immaterial, it's still effectively a "core" driver 
because it is shared by many different platforms.

Thanks,
Robin.
