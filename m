Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238741;
	b=jD3zLPgAjeKQh1W2gF9c+3A9IUymLJfsILISdzOmeZXYQ0D8yN/ojYoWh90RTVObiTn4
	 UPSJA4AxdRu4B71+7G5ylrgPnBCqpqpYxnlmnK+2wvRndK6bq3GoBJ2HAR6t00fdFgge0
	 fH0Xmp0xSrkvVMuqpVHCdsteFqNBLCzOUgPKeTb0xHpjvrJvl3hJww9ArRAZNQO0Y9DxX
	 Of90KTmtLObnDFDUt6l9h9Hth/q2XPJUip04/85XNX8hz6pylPN3pbSIXB89dg4YMKFGF
	 rs9d3ZUSVS74Yi8vmU3qJIHhtfZPOjT3ZFSG22zRvVDdXOvJQLmxPq3iAE7MRwspBkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238741;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a+kTNEMlGRHVqhyrD9wjKCx3s2EeROQLPFxQ8ka5f9I=;
	b=vRP1yiLqC7eDO6DXH5SlWD0UrGYndxDs3Jb7SgxODSag2/lv7raBlKx2jQloN9yv/HL/
	 v0JVMqweS3QInvqgDwYWldCYunNaCkIQ+Xdvvmi/j8sZB7JAFrVg+naLD8myB98sl1Rtg
	 SIku4CkU0q0kY60L7AKYJRSebIIvyEhzlqGiAoO8sKiusdHEKb3KYRfweTQZ1mcGgqIOk
	 yULF7m3p4odOoXYxIUfeRDKw/NfRSzHMkaNCVEmyXE/IeDcCLPwVy6GimNlGJcOj3iyFx
	 E//0GoahtwQV140k5uQZF1egijwdZj/OB5g8yE05RVN54ew+wEyP2XXZgALryAQnnYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KOWEmtUL;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A6606A325
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 01:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F7A6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=KOWEmtUL
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793238732; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=a+kTNEMlGRHVqhyrD9wjKCx3s2EeROQLPFxQ8ka5f9I=;
	b=KOWEmtULoDa2JCruIYMNOqf1ogyQPkHfiiHqOv/sCbd5mWj717ui0B/5ihHhijf4hMMV9yek65Ugaxn4SLFmwAwvev3kEBmr/WsBoR0F2eIszCCENEsQxMegt+We1vrBLdwQ+IIxmhTIqhJ+WZvtDfTfjGgk0JmbaE215OdfWVM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XDhqoRO_1793238728;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDhqoRO_1793238728 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 09:52:10 +0800
From: fangyu.yu@linux.alibaba.com
To: jgg@nvidia.com
Cc: alex@ghiti.fr,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	gong.shuai@sanechips.com.cn,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	joerg.roedel@amd.com,
	joro@8bytes.org,
	jroedel@suse.de,
	kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robin.murphy@arm.com,
	skhawaja@google.com,
	tanchi25@mails.ucas.ac.cn,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [RFC PATCH v5 00/10] iommu/riscv: Add hardware dirty tracking for second-stage domains  
Date: Thu, 29 Oct 2026 09:52:07 +0800
Message-Id: <20261029015207.82522-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <179320128818.2412245.14186677086155168748.b4-review@b4>
References: <179320128818.2412245.14186677086155168748.b4-review@b4>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>>
>> The RISC-V IOMMU architecture defines an AMO_HWAD capability (Hardware
>> Access/Dirty update) that allows the IOMMU to atomically set the A/D bits
>> in second-stage PTEs on DMA access.  When DC.tc.GADE is asserted, the IOMMU
>> autonomously sets D on the first write to a page mapped by an iohgatp
>> domain.  This series wires that capability up to the iommufd dirty-tracking
>> interface (IOMMU_HWPT_SET_DIRTY_TRACKING / IOMMU_HWPT_GET_DIRTY_BITMAP) and
>> reports IOMMU_CAP_DIRTY_TRACKING.
>
>These patches don't apply, so sashiko couldn't run:
>
>https://sashiko.dev/#/patchset/20261020094106.92722-1-fangyu.yu%40linux.alibaba.com
>
>> [ ... 86 lines skipped ... ]
>> [1] https://lore.kernel.org/linux-iommu/1-v2-563ee63886f0+1209-iommupt_armv8_jgg@nvidia.com/
>> [2] https://lore.kernel.org/linux-iommu/20260818092444.42755-1-andrew.jones@oss.qualcomm.com/
>
>Because of these extra patches I suppose.
>
>Please figure out how to fix this before you send it again..
>
>Also no base-commit trailer which helps sashiko apply them.
>

Sure, I'll fix the apply issues and add a base-commit trailer in the
next version.

Thanks,
Fangyu

>--
>Jason
