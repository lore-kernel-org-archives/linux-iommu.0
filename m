Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789957;
	b=iP+GqZRwdncmQBdqps1JiOnwEdwi5eO56WXWGxIN7qDCpkne01RrRcD09ylM50qR47I/
	 k4wvu2KqMPkeA3qLc53UswRlXRSU/xvkUvQz4t/2fHUMgfd+7khVbWrkMQm6Dl6UkpbCx
	 qFt7MHZ8Xh95CFeQCr4socKreGRQTRvt8gV4LhF1W0nI/MBLkVnSglePR+B+kyBzG1JG/
	 9bfheBuIkigH1mjf7gkvi79Z7mLuPXR2p5PlIsz3i2LmIvYw1MglUvo/MPdUJg/rkcpll
	 UNet5amwpg2o7h3uTnn2dSSGiVouWbIWXKu5HjbazhYkl6waT+YgB9z1xazPUVJqu/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789957;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3nff9d/AA4m5vVgbnjj/6QnlBWUP9A3eO3LG2cNpO0Q=;
	b=PPutqJKaTNU+SAsSWzEvr+ouJigoylSZ8HyUMdV8vBsGiI4lgCzRHRW6Z/4sl10yS2jg
	 Ouwd3qioX/GLdsgPDWTdyvCK/itPJUSsmHsLsxN7gQafvmBW28U3HTdKh1by2DxsWm2yc
	 MWY/unMhc25kxeBh9zZwVXXTRT22v+3NNqkhVEHIIAmWIRTj7OI7XvbKi7wgkJlvUIIjY
	 BsfIwyZWGa+B2oi4QSm4QJF2qMh2hLxv1XFDL/X/JnsVgn3nCkZxPo9mLHjM6FBloKS81
	 bLGk3ToAMaquI4WaLgFhxk5RzyBIJ5fbPcHutKLb0i0S6Q+h/me2JuOXEMGtzHPn1ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m08KhV0f;
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD67606A329
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 10:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FD67606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m08KhV0f
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793789946; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=3nff9d/AA4m5vVgbnjj/6QnlBWUP9A3eO3LG2cNpO0Q=;
	b=m08KhV0fkxsfrfrjQiWp6HnWt8T+koWD1umEJghybHZAO3s6Qf6Jm3NiZccdI3RejYTik1tSWFB1jgRoGgRirlwwBvH5vgBJX5YZ2VerKPUC/oBEHXmL4YwXrJD0JKPAwSd2c3LHTYEb7wyizeUoO6jx5KNIf0rdOs/qlAL3jQQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XE5XI7y_1793789942;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XE5XI7y_1793789942 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 04 Nov 2026 18:59:04 +0800
From: fangyu.yu@linux.alibaba.com
To: gong.shuai@sanechips.com.cn
Cc: ajones@ventanamicro.com,
	alex@ghiti.fr,
	andrew.jones@linux.dev,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	baolu.lu@linux.intel.com,
	fangyu.yu@linux.alibaba.com,
	guoren@kernel.org,
	iommu@lists.linux.dev,
	jgg@nvidia.com,
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
	tjeznach@rivosinc.com,
	tomasz.jeznach@linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org,
	zong.li@sifive.com
Subject: Re: [PATCH v7 06/10] RISC-V: KVM: Enable KVM_VFIO interfaces on RISC-V arch 
Date: Wed,  4 Nov 2026 18:59:01 +0800
Message-Id: <20261104105901.64207-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261104064540.115560-1-gong.shuai@sanechips.com.cn>
References: <20261104064540.115560-1-gong.shuai@sanechips.com.cn>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>Hi Fangyu,
>
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> Enable KVM/VFIO support on RISC-V architecture.
>>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> ---
>>  arch/riscv/kvm/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
>> index f7e4d0f9b156..13552cfc2cd3 100644
>> --- a/arch/riscv/kvm/Kconfig
>> +++ b/arch/riscv/kvm/Kconfig
>> @@ -28,8 +28,10 @@ config KVM
>>  	select KVM_GENERIC_HARDWARE_ENABLING
>>  	select KVM_GENERIC_PRE_FAULT_MEMORY
>>  	select VIRT_XFER_TO_GUEST_WORK
>> +	select KVM_VFIO
>>  	select SCHED_INFO
>>  	select GUEST_PERF_EVENTS if PERF_EVENTS
>> +	select SRCU
>
>This option is now meaningless, please remove it.

Thanks for the heads-up.
I’ll remove it from the next version.

Thanks,
Fangyu

>See:
>https://lore.kernel.org/linux-riscv/20230105003813.1770367-5-paulmck@kernel.org/
>
>Thanks,
>Shuai
>
>>  	help
>>  	  Support hosting virtualized guest machines.
>>
>> --
>> 2.50.1
