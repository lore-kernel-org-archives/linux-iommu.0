Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7713D091B
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 09:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270861; cv=none; b=ZmeJohpxMo1TmCJVA3YAStltHGzhEP+tbteuj8N9BJTk+EcKDVIfBZbhHAAYxz47YqDj/kUAgc3rw4QcUcWETfZfqTtiy1GknyngV5KpHGfEdc+HTR13exjP4g8E7n9tUNLXGfTvSB7sKW2MK8g9ooTHc1rTX1Nwdxarxn6dtfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270861; c=relaxed/simple;
	bh=UcAVuvE+8QyqVUO8IoaABWHAbp7vgQNlHXubjfnZfh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUe0G1YI399jVdN0Iclzi8psS/mTfBy+/NSwFSUmI+M/douaBsCzXqWtUDRBt++s0GFtWKnCi33erhGkFT6mZNkKkh1nkZpnP19H5KZPTJtBaXm/UWOSv5hgOS1JTQyzvyYAthOu2buYmxz/1fiYWYP1hnLBLLE2YkEcuhSSpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lTNUu/sF; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lTNUu/sF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779270856; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=wHQ9qfRCExCn044qkCOJYBlx1vnsQcVgKurXXWpgTbI=;
	b=lTNUu/sFCJgXbLOqEgRNwN9lpoqYzmT80bLFB1gCibsjvrYH1it7WMbtdF1VZkrJ8Ux4Nb1S3HiKROj5yZe0u4T0rUq2eXeauj5CNklhQP6MURgRjJgGDaONq+zB3ScwGBhyqtgJ9iAg3JXzDptLMlwciF6fUOClzbOuqe18xoo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0X3IbTSf_1779270853;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X3IbTSf_1779270853 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 May 2026 17:54:14 +0800
From: fangyu.yu@linux.alibaba.com
To: sunilvl@oss.qualcomm.com
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	andrew.jones@oss.qualcomm.com,
	aou@eecs.berkeley.edu,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	joro@8bytes.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tomasz.jeznach@linux.dev,
	will@kernel.org
Subject: Re: [PATCH] iommu/riscv: prefer WSI on IGS=BOTH when wired IRQs are described 
Date: Wed, 20 May 2026 17:54:11 +0800
Message-Id: <20260520095411.92045-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <CAB19ukGk2AUA3yjsrBxjsUsH9pUSeeu5F6vo1FFBcd504VQPzg@mail.gmail.com>
References: <CAB19ukGk2AUA3yjsrBxjsUsH9pUSeeu5F6vo1FFBcd504VQPzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>>
>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> The RISC-V IOMMU spec defines IGS=BOTH as supporting both MSI and
>> WSI, with software selecting the path. The DT path already behaves
>> as expected by selecting WSI when wired IRQ resources are described.
>> The ACPI path, however, currently falls back to MSI even when
>> firmware describes wired IRQ resources.
>>
>> Use firmware-described wired IRQ resources as the trigger to select
>> WSI for IGS=BOTH:
>>   - DT: "interrupts" present, no "msi-parent"
>>   - ACPI: DSDT _CRS Interrupt() descriptors
>>     (mainline does not yet parse the RIMT Interrupt Wire Array)
>>
>> When triggered, rewrite igs to IGS_WSI and reuse the existing WSI
>> handling. Keep the existing behaviour otherwise.
>>
>> Fixes: d5f88acdd6ff ("iommu/riscv: Add support for platform msi")
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  drivers/iommu/riscv/iommu-platform.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/iommu/riscv/iommu-platform.c b/drivers/iommu/riscv/iommu-platform.c
>> index 399ba8fe1b3e..bd7712231140 100644
>> --- a/drivers/iommu/riscv/iommu-platform.c
>> +++ b/drivers/iommu/riscv/iommu-platform.c
>> @@ -71,6 +71,21 @@ static int riscv_iommu_platform_probe(struct platform_device *pdev)
>>         iommu->irqs_count = RISCV_IOMMU_INTR_COUNT;
>>
>>         igs = FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps);
>> +
>> +       /*
>> +        * IGS=BOTH means the IOMMU supports either MSI or WSI;
>> +        * the spec leaves the choice to software. Use the firmware-described
>> +        * wired interrupt resources as the trigger:
>> +        *   - DT  : "interrupts" property present, no "msi-parent"  -> WSI
>> +        *   - ACPI: DSDT _CRS Interrupt() present  -> WSI
>> +        * Otherwise default to the MSI path.
>> +        */
>> +       if (igs == RISCV_IOMMU_CAPABILITIES_IGS_BOTH &&
>> +           platform_irq_count(pdev) > 0) {
>> +               dev_info(dev, "firmware describes wired IRQs; preferring WSI on IGS=BOTH\n");
>> +               igs = RISCV_IOMMU_CAPABILITIES_IGS_WSI;
>> +       }
>> +
>Won't it change the DT behavior as it doesn't check msi-parent
>anymore?  IOW, should this be made specific to ACPI
>by checking whether the device node is acpi node?
>

Thanks for the review, you're right that the current condition would
affect DT as well.

My assumption was that DT would describe either "interrupts" for WSI
or "msi-parent" for MSI, but not both, so platform_irq_count() > 0
would effectively imply "no msi-parent" in practice.

That said, I agree that this should be limited to the ACPI path. That
matches the actual bug scope — only ACPI was falling back to MSI when
wired IRQs were described — and leaves DT unchanged.

I'll respin a v2 to scope the fix to ACPI only, and tighten the commit
message accordingly.

Thanks,
Fangyu

>Thanks,
>Sunil
>
