Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8378C3C0636
	for <iommu@lists.linux.dev>; Mon, 13 Apr 2026 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776078978; cv=none; b=mL2dYD99kIAHYdpQQFEXQT/YVF2LZYkOYAyqRXl5TbYnE/gnxYFKp/jRZRVeJZmM2YukcxsRkaF4xelBqNxTZlCdTV/+xpxz2jC10xlT1mlPTIduHYo/RffjFtreef07+ngE5a601kob4XyENZJH8d3GpZh+lBOAy4dDkALRBuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776078978; c=relaxed/simple;
	bh=SPpBhGkDjv3AauTWgP9dlq3/DhigNR+aoVgRNA/fkOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTDfs5D5U7usng4qEURjwLRQQerGn8FTpxdogzXO3fO5G8XyC+ve0X481uB1CtiBjg6QDDP1H2KceWvZIig+CDgJ31Wij1RgSu6UkLWuA0zC4xr6Y+hQy6Jw3Lzdaj5XbXm71vfCMoZY9asFNshMKOZTURErcnlHoMr3/My5aqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eJMq+Fht; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eJMq+Fht"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776078968; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Fg7zc1O+7fxsBgREHbt/NhuoP2H8B/ZI+5a2SV45XUY=;
	b=eJMq+Fht8b/B7DdRO0jcSyR9p2jF6CZ6ljs9s04UeE5WdcsSf4zZ0vckZCBE1sQRXgFCsun95Sy2dTPINqYh81xcyUDBbpnOCMCpTqVeJXm8t3WGo/30kbjeSvoGOF3ldi7PVXOOLMeKk1UXxV4XI/jd5Ow2LlqwA8H9yw9URzc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X0vN5Dx_1776078964;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0X0vN5Dx_1776078964 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 13 Apr 2026 19:16:06 +0800
From: fangyu.yu@linux.alibaba.com
To: kevin.tian@intel.com
Cc: alex@ghiti.fr,
	aou@eecs.berkeley.edu,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joro@8bytes.org,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: Re: RE: [PATCH 1/2] iommu/riscv: Advertise Svpbmt support to generic page table 
Date: Mon, 13 Apr 2026 19:16:01 +0800
Message-Id: <20260413111601.26167-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <BN9PR11MB527696935354C345259C39E18C242@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <BN9PR11MB527696935354C345259C39E18C242@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: fangyu.yu@linux.alibaba.com <fangyu.yu@linux.alibaba.com>
>> Sent: Saturday, April 11, 2026 10:22 AM
>>
>> diff --git a/include/linux/generic_pt/common.h
>> b/include/linux/generic_pt/common.h
>> index fc5d0b5edadc..dfadf8a5752a 100644
>> --- a/include/linux/generic_pt/common.h
>> +++ b/include/linux/generic_pt/common.h
>> @@ -188,6 +188,7 @@ enum {
>>  	 * Support the 64k contiguous page size following the Svnapot
>> extension.
>>  	 */
>>  	PT_FEAT_RISCV_SVNAPOT_64K = PT_FEAT_FMT_START,
>> +	PT_FEAT_RISCV_SVPBMT,
>>
>
>nit - every feature has a comment.

Thanks Kevin.
I'll add a comment for PT_FEAT_RISCV_SVPBMT in the next revision.

Fangyu,
Thanks
>
>Reviewed-by: Kevin Tian <kevin.tian@intel.com>
