Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B3B156871
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600256; cv=none; b=pXPHMIEriapaPaf3yJAZl/DOyblnATgqytk950FhJf6tcsX17+E6+d6VZHJWMh/XnukZ+LxMs5es7KSrM9rNhsHXYeakpeVqEeWhkrEyNQDaDqSJvkIcSuI967q6gbVa3edEZMmRAd3sjVi8KPvc8Nur27yg84j567vEt6Fzet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600256; c=relaxed/simple;
	bh=s8KpSZ+s4Sc9Y9N9eZe6/xcSLB5erCt8F2Bylz4cMlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Je/wJZ151RH9ylze2mFAMY3cPVwo+iedIGRQDbBSrZEaNYl3ugNQUJFdMODr7E5d0biSfb5Jcx0hFgjGr5Fif/HhxBOxljTPIMCxFCYeBlETxsZbeWxToAXWWQvptMO/4N/IeBVm+jGbuKDPI0xYEl65wC7UH4YsQyWm4DPR+TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB111497;
	Tue, 22 Oct 2024 05:31:23 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D75B3F71E;
	Tue, 22 Oct 2024 05:30:53 -0700 (PDT)
Message-ID: <aa07f3e8-0f68-4772-975f-d9deefd7a019@arm.com>
Date: Tue, 22 Oct 2024 13:30:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Distinguish between sw-msi and msi
To: Angus Chen <angus.chen@jaguarmicro.com>, "joro@8bytes.org"
 <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20241021113448.1894-1-angus.chen@jaguarmicro.com>
 <a25451b8-b898-4354-acd3-2826a340f9fe@arm.com>
 <TY0PR06MB49849D564F3FFE2E1957F4AF854C2@TY0PR06MB4984.apcprd06.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <TY0PR06MB49849D564F3FFE2E1957F4AF854C2@TY0PR06MB4984.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/10/2024 1:02 pm, Angus Chen wrote:
> Hi robin。
> 
>> -----Original Message-----
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: Monday, October 21, 2024 7:59 PM
>> To: Angus Chen <angus.chen@jaguarmicro.com>; joro@8bytes.org;
>> will@kernel.org
>> Cc: linux-kernel@vger.kernel.org; iommu@lists.linux.dev
>> Subject: Re: [PATCH] iommu: Distinguish between sw-msi and msi
>>
>> On 2024-10-21 12:34 pm, Angus Chen wrote:
>>> iommu_group_resv_type_string use the same string of IOMMU_RESV_MSI
>>> and IOMMU_RESV_SW_MSI, Make a distinction for these.
>>
>> Why? What in userspace needs to know the exact details of how the kernel
>> and the underlying hardware are routing MSIs?
> We use smmu-v3 for a dpu design，and we set a private region to handle msi region like x86.
> We set some private iommu register to control this.
> If some customer want to use their os like openouler, we use sw-msi mode.
> If some customer want to use our customize os ,we will set msi private.
> Some customer use openouler and we private smmu-v3 module at the same time,
> 
> So I want to use reserve-type to distinguish between sw-msi and msi.

But *why*? What do you expect userspace to do with this information? It 
was a deliberate choice not to expose this distinction, precisely 
*because* it should make no difference to a VFIO user whether an MSI 
address range is defined by the platform or by the IOMMU driver, and if 
userspace did think it wants to know that then it's probably doing 
something wrong. IIRC, the reason for distinguishing "msi" from 
"reserved" at all was just as a hint to userspace that although the 
address range is still not usable for remapping memory, it's a good 
place for a VMM to put an emulated MSI doorbell in GPA/IPA space.

Also, this has been userspace ABI since 2017, and changing it has a high 
risk of breaking existing users who are looking for an "msi" region, so no.

Thanks,
Robin.
