Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1041A423A9A;
	Tue, 28 Apr 2026 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379554; cv=none; b=lteD+vP3kdQjQVoo7GyCmMcJOZ+EBsvtQIhVUPT8jWm8F5SscFEMkUr0DxHRpFHB+VKD6hmdH9EHEDGJUuD4UiU+ZGQHfeHMHdG6l/0BQtrm4bRWO6PvHmjC7FfujueGqQNW57vf4TtE4zwwaFmPCZnKo9QcW3G+agXs9wpxr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379554; c=relaxed/simple;
	bh=0Fme70mutnWfE+gMGA9aNcG2k7MUS9AC/srCubxZtSM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Mea4Er0RRMAjkHuO5Bdy0jTcciMgS5NHb5p1DJj9PU6I9m/0ow2hB0h8DwAGqbNZC4sBDtfZs6nhT9X8fxaeZdzaCqIZqTNOO8YXQeqDa/FiNmAZuKX5+5UGkGC5JVWr3HVCz1vrfzU+U8OKKVzSonUgvUjw7CCaVlz14I9T9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LFp0QVZW; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LFp0QVZW"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WYVh3rRNApPh1xCCN3OpCIIeR/JDDKtNd9mRTZdEGN8=;
	b=LFp0QVZWjsJ0M4aWYjOUIOQg+8m7/Uxy/nFSGQn3YvN1wf9blJa19UbcK2KFxPGA6iq+To5ef
	EhcDSfDevbu0qDIij7sis/Q+3ur0xwmHxUT5+HHppwRXaMgg1L3sYz7ofXCdxOot5ydgVNAwgzO
	ZSzpAHHo9w38T9efqE5QnCc=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g4fm32f6mzpSvH;
	Tue, 28 Apr 2026 20:25:39 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BBFC240576;
	Tue, 28 Apr 2026 20:32:14 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 20:32:13 +0800
Subject: Re: [PATCH V1 1/3] ACPICA: IORT: Add Root Complex PASID Flags field
To: Jason Gunthorpe <jgg@ziepe.ca>, Vidya Sagar <vidyas@nvidia.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <saket.dumbre@intel.com>,
	<lpieralisi@kernel.org>, <sudeep.holla@kernel.org>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<nicolinc@nvidia.com>, <praan@google.com>, <vsethi@nvidia.com>,
	<sdonthineni@nvidia.com>, <kthota@nvidia.com>, <sagar.tv@gmail.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<acpica-devel@lists.linux.dev>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20260423191417.2031652-1-vidyas@nvidia.com>
 <20260423191417.2031652-2-vidyas@nvidia.com>
 <20260423224318.GT3611611@ziepe.ca>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <e092b85e-9ac2-22ef-b213-1b2a32fbf784@huawei.com>
Date: Tue, 28 Apr 2026 20:32:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260423224318.GT3611611@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2026/4/24 6:43, Jason Gunthorpe wrote:
> On Fri, Apr 24, 2026 at 12:44:15AM +0530, Vidya Sagar wrote:
>> The IORT spec, Issue E.c (ARM DEN 0049E.c, January 2022), bumps the
>> Root Complex Node to revision 4 and adds two PASID descriptors:
>>
>>    - PASID Capabilities at byte offset 33 (2 bytes), bits[4:0] of which
>>      report the Max PASID Width supported by the Root Complex.
>>    - Flags at byte offset 36 (4 bytes), bit 0 of which reports whether
>>      the Root Complex itself supports PASID. This is distinct from the
>>      existing ATS Attribute bit 2 (at offset 24) that only reports
>>      whether the RC forwards PASID information on translated
>>      transactions.
>>
>> The ACPICA struct in include/acpi/actbl2.h was updated for the E.c
>> PASID Capabilities descriptor (offset 33) but stops short with a
>> trailing 'u8 reserved[]' flexible array, so the new Flags field at
>> offset 36 is unreachable and the existing ACPI_IORT_PASID_*
>> definitions have no consumer.
>>
>> Replace the trailing flexible array with a fixed 'u8 reserved[1]'
>> followed by 'u32 flags' so the struct fully covers RC node revision 4,
>> and add the ACPI_IORT_RC_PASID_SUPPORTED mask for bit 0 of the new
>> field. With #pragma pack(1) in effect for actbl2.h, this lands the new
>> field at the spec-mandated absolute offset 36.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>>   include/acpi/actbl2.h | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> There is a whole process to change this file, I went through it once
> for canwbs..
> 
> https://lore.kernel.org/acpica-devel/2-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com/
> 
> You have to make a pull request here:
> 
> https://github.com/acpica/acpica/pulls

Yes, please get this patch merged in ACPICA first.

Thanks
Hanjun
