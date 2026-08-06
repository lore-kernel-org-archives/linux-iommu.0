Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421FE41A519
	for <iommu@lists.linux.dev>; Thu,  6 Aug 2026 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786005746; cv=none; b=cfL6SnreSezyyaXHme1FGmA+LWfazz8T4u4/qKI3MkbPRCkGez3nvFCIhI5NL0pCYG5Frg4y/b1rGLkcCYH0EtDTFbCaf2Rre++pccrtI2l4YYJ16aaF3lKy16XNmpAArPUZaJjti2TS6UzRDYEVCVpYCz7nHtAnZ8+1j58drsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786005746; c=relaxed/simple;
	bh=1XZ52c7N7R/7ik+1Q56O2gFc7n1LYmIvcHRd9KWsOdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bM05OBJ50FTjBGEA8FHTeTtOptbpiK845Vi59ixKaILG/DhpKi6ud+BBH464i3Bop2w1Ds+G2fiIdOwGkUNoOZv9GDY6QPuC55Xz84pgHqM16IhzB1X8lGMtkweKzD+J7hlQy5jm2SmuaNNnbKucE1N3/ExD/lIf2O74HR0/5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vk3YFbse; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vk3YFbse"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8811153B;
	Thu,  6 Aug 2026 01:42:18 -0700 (PDT)
Received: from [10.2.212.8] (e134344.arm.com [10.2.212.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81F433F632;
	Thu,  6 Aug 2026 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786005742; bh=1XZ52c7N7R/7ik+1Q56O2gFc7n1LYmIvcHRd9KWsOdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vk3YFbseN1J/KkpXJV6XxeMhp8z09cM7QKEaGOWthnB2rK15LrGgVvARUQKfSIB3A
	 q+/JfafIf6kUrbpn/GxsrT0SfxqyDag4S4foyW9/Kksq3ryx9lyhrhSqMaGBY5RWAa
	 Z36t681xIH1xquFeoaBivxQxzxvg4wMqdvfwdNBs=
Message-ID: <7cf591e8-e182-447f-9808-d8e328d28f79@arm.com>
Date: Thu, 6 Aug 2026 09:42:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/7] riscv: iommu: Add QoS ID support for resctrl
 device assignment
To: Drew Fustini <fustini@kernel.org>,
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: xiaqinxin@huawei.com, zengheng4@huawei.com, palmer@dabbelt.com,
 tony.luck@intel.com, reinette.chatre@intel.com, tomasz.jeznach@linux.dev,
 will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
 aou@eecs.berkeley.edu, alex@ghiti.fr, Dave.Martin@arm.com,
 james.morse@arm.com, babu.moger@amd.com, corbet@lwn.net, shuah@kernel.org,
 jgg@ziepe.ca, kevin.tian@intel.com, cuiyunhui@bytedance.com,
 yuanzhu@bytedance.com, iommu@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, x86@kernel.org
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
 <anQaaQvpEXFTRYvS@x1>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <anQaaQvpEXFTRYvS@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Drew,

On 06/08/2026 06:23, Drew Fustini wrote:
> On Tue, Jul 14, 2026 at 09:06:50PM +0800, Zhanpeng Zhang wrote:
>> This RFC extends RISC-V CBQRI/resctrl support to external requesters
>> behind a RISC-V IOMMU.
> [..]
>> Open questions for this RFC:
>>
>>   * whether a common resctrl "devices" file is the right ABI for
>>     associating external requesters with a resource group;
> 
> I think a separate file is the right approach to avoid confusing iommu
> groups with pids. 
> 
> I should note that James Morse had an ARM MPAM "extras" tree [1] which
> carried an iommu_group assignment interface, using the same
> iommu_group:<id> format, but writing it to the tasks file. However, Ben
> Horgan clarified back in March [2] in a reply to Qinxin Xia that it is
> no longer maintained. Ben also wrote that the interface would likely
> change upstream. I've added Ben Horgan and Qinxin Xia to the CC list so
> hopefully they can chime in.

I haven't thought about the interface much but Reinette let me know here [1], with good reasons,
that we should consider the format of the tasks file fixed.

Thanks,

Ben

[1] https://lore.kernel.org/all/f9b08563-4958-4f3c-ad6c-1e7fa3047896@intel.com/

> 
> I plan to review the patches in this series further but I didn't want to
> delay any further in pointing out the above.
> 
> Thanks,
> Drew
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/log/?h=mpam/snapshot%2Bextras/v6.18-rc1
> [2] https://lore.kernel.org/lkml/d13fdc75-b647-44f3-9657-d592353e8a1a@huawei.com/

