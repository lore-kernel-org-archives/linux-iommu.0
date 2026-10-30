Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793328598;
	b=AYkrf4zFV75oldSjQiEldAujQ4GbK/EQDpmdBrmg4q4PmqHlct9jiYv4IEFrW6ht8o23
	 9wsaIU4VRhFVHOfbBFt0bt8z4en6SSW1E/aN6hVFkI4l6wn77cyWw175dc49zfuf+OMEx
	 eJtNzEdbDYo51aUUZptePppfCA8OtnW1upqve3J1SaLFAh1kB+4Nytc5GrodP4CjRp2kF
	 J9WXWqVnvgkX4HFWvlVIliGzKG0qF6LXc3BIMyVOhVuxnGs9H3kvTU07JPjIO5rm2CANa
	 9ZGVlt5xowoAJMTXsY8hooJamMXBl31HOFqLrEubGMKVAoseSOdaTUBg6f/hiYPfpkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793328598;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CfEmxolAK8lSlcJ/IDJ4OjlHBkMazQyT8J7ibClDgoI=;
	b=ZFRJDW/PYfxzZMmI3gZoWToKL8s4KKskwieLDKppT2/wpsVi8ZzialzfyyzrcYyhHGLP
	 wYBIf0wi30RiuFWo66LRiPE0TnN+rZ/DdxER/aGU7paVX3pvXZ6iR8UrIuWNo6EhrK2CN
	 sPjnQYdSR5RG+Sl8MXrulvO27WnS3bOernm8YamfrmXqhAK+sALPIHgtxe6DzeAk3S79D
	 9gKPszSANGbjZiVufEjNy5DoJXctieeJv5Rb2xdF1v8lPUU70jWu68hKWoIh5Ra1Y5EIR
	 ihVPol338Z/QJFPw3v2miPs0iCOFFajbG6Mnswz+k4ryYaVmLNbHzB+PfpUtFAKvidg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="Na6KxF/1";
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D9606A31A
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 02:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF6D9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Na6KxF/1
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793328589; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CfEmxolAK8lSlcJ/IDJ4OjlHBkMazQyT8J7ibClDgoI=;
	b=Na6KxF/102AdTUz136z8HdPBWN7K2OpcY6fLCIFV7ntQeUOYXMA0TxGnMETPUWWZ1x3iAbOi/k4GGPTO//4ABi1riQfMO3RwZqDZIhFtmdX4VP38tQOKcj+Lvr50235AwYqeFDd+8sCmn26NoFN/IPOcs0xSV3dIanAYu9i6rHI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=fangyu.yu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XDkuzbU_1793328587;
Received: from localhost.localdomain(mailfrom:fangyu.yu@linux.alibaba.com fp:SMTPD_---0XDkuzbU_1793328587 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 Oct 2026 10:49:48 +0800
From: fangyu.yu@linux.alibaba.com
To: gong.shuai@sanechips.com.cn
Cc: fangyu.yu@linux.alibaba.com,
	iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v5 03/10] iommu/riscv: report iommu capabilities 
Date: Fri, 30 Oct 2026 10:49:46 +0800
Message-Id: <20261030024946.93889-1-fangyu.yu@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261030023104.51259-1-gong.shuai@sanechips.com.cn>
References: <20261030023104.51259-1-gong.shuai@sanechips.com.cn>
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

>Hi Fangyu,
>
>> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>>
>> Report RISC-V IOMMU capabilities required by VFIO subsystem
>> to enable PCIe device assignment.
>>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
>
>This patch has already been merged
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3069e8f3e1e9bdf007316eadae4d1777065e7b78
>

Thanks for pointing that out. I'll drop this patch in the next version.

Thanks,
Fangyu

>Thanks,
>Shuai
>
>> ---
>>  drivers/iommu/riscv/iommu.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
>> index fe8e6d0f8a23..40beccedd39f 100644
>> --- a/drivers/iommu/riscv/iommu.c
>> +++ b/drivers/iommu/riscv/iommu.c
>> @@ -1444,6 +1444,16 @@ static struct iommu_group *riscv_iommu_device_group(struct device *dev)
>>  	return generic_device_group(dev);
>>  }
>>
>> +static bool riscv_iommu_capable(struct device *dev, enum iommu_cap cap)
>> +{
>> +	switch (cap) {
>> +	case IOMMU_CAP_CACHE_COHERENCY:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>>  static int riscv_iommu_of_xlate(struct device *dev, const struct of_phandle_args *args)
>>  {
>>  	return iommu_fwspec_add_ids(dev, args->args, 1);
>> @@ -1505,6 +1515,7 @@ static void riscv_iommu_release_device(struct device *dev)
>>
>>  static const struct iommu_ops riscv_iommu_ops = {
>>  	.of_xlate = riscv_iommu_of_xlate,
>> +	.capable = riscv_iommu_capable,
>>  	.identity_domain = &riscv_iommu_identity_domain,
>>  	.blocked_domain = &riscv_iommu_blocking_domain,
>>  	.release_domain = &riscv_iommu_blocking_domain,
>> --
>> 2.50.1
