Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD924FD7AD
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 16:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789748326; cv=none; b=IozJelpZGv7/a4dvv9KkI7zbFtKpGG5nhwFf8gA1USPSDFnzUPEcCqrmx329HV6gQA8poCKXJrFKVMjB3Hy5XkzRLpjbArm/3wH//Pe36De1Z3jWrnc5MDIzBV9HzUFcOakGHSWFA9OoKBPwWnzjb4zCmDjym6TzBcGmnzV4rik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789748326; c=relaxed/simple;
	bh=58wNSoF3SLPEsw/UfT8kALXhRyGhLdeLuPi/koBCjj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5sfX1kzVSk927AqeOYH5gakdPu9wbHMMF3ts9DucP33LjYxfk/XNQZcUrIBn29+QZEf05y9o/JUBmV8sAyzmBN2ibNo8xGVH77kEz56j47fmAScrtKDUIWIHcNUAf11YIljI5CRmu0RGV8NDXBpczVA0xnwStePb5APbiEotVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W31NtBmL; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W31NtBmL"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso3247205ad.1
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789748324; x=1790353124; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=joaMZtZ2JkCfx/7wOkt6uB/JF0GtO4C1SVtTGC6XgyQ=;
        b=W31NtBmLp+z+kSCguJ9OkN3FYR/CXGaMzVI49K94sTltaEWxfCk67/NVKqwOtELTPH
         1ipk3moGVU0w/oolFHJGrLa6uQtGUtyyDDb7AjAq/3CE83wOba4JruBDXcM1AW3bv/5E
         GrkLK4wigEQupXPg2x3jt6dCo+xpq7SpislwQM6+xqF662tY3GH9tHE7arrnXHCxYtzh
         mS5p6Pr7m/7tME4auTBcOPKHyKO8noAY8CBp/2EjJaydelRGurHZgfZk7X4vU4/8BSuc
         Bwri2uc/3klZxkf2iFSBwSrUze0lvfWzhOYHMGcZzGK3thYj9H+p0b0OSMJKNgFPDNns
         sNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789748324; x=1790353124;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=joaMZtZ2JkCfx/7wOkt6uB/JF0GtO4C1SVtTGC6XgyQ=;
        b=Jk2Y/Q4ewdlshymJMBel3cjOhQteCufHeIFot3comQF0TicuE6lxJwW4G4qYbSD+HQ
         RBP1Tx62kXgXy0sK/YJn4WZ1i8j6I1U/g6f5wXaC6fEcWQUtXDNNc/0ajkiFgQ5wqZx1
         5gnGJ8Nm5/hpgHQNEdRPvlOj0dvWHPDwtyPXaxEJCATyd+nkjVpg6aTUaLuuBTSFPQZg
         jsCsbqAsjJA/M8guC898lZ0eRj0UmLFrPL2CwAD2UtIdOn/GJcorwXrgXcwttIclHWSr
         m7zmcmzfz56E5wPKYpTzj8By/aFMPy+FdCYTgNB/nDTzhtg57PXPEBE7RzoDeKIavnwC
         o6UQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4Pr5Hz/FXkBBvMEcY2BpCj5lPQorLMFm2z8upj3+YlIpN56zk7RjmIL+6Mr++s+5wy+Q/qA==@lists.linux.dev
X-Gm-Message-State: AFuF++lA9xMu7vDDDNJCe7RABUHdOcsySXlXeKDKCsiEasTSPDR7rybL
	oDc/tUOgb1wPiGs+kqh1XR8m0uXtKyx+LQ69m5E8wcv5LpxOMbBBEYhy
X-Gm-Gg: AYBFou3Ix5IFADLNtHzj2tEvQHTYt9g0cdTq0N9CdTFDn7JGGzfV+Ve2YjoJrTjJ7c6
	5LBDIvOwmBCk4nqzs5r3SujjN5uayOYGtpXs1p71gp3SMLFj1lTQdp9/DgML9i9owyp2ShS8sa5
	3G8nAPYT0PZkt1qB8ZonJaBcRottRngnYlCS/qo/xJhgkCzqhzhnI57NQ0u/LX+s+LFEZAR8OiH
	hqMptk58tV/w2mrleHO4bIQRLEJl50WSIJrZUKmKX/wFi7oHfdhklnC52JVW9fVMf5vWF/iyiob
	vPToXLBcGGofyZKPPbLn6ed5Ea+dh13QlEQyQLXDNyS7uGbs0GE0iNcwM7icG2b8GpvdO3Q8WsP
	HZImzATfEC+o02BXK4TM3+OKPW9Dtm9OFjstnIrwmdczvkngY1JSUcGOpbAeRic90envv6MUEuT
	gnxn+ivERiuN9OmcMgclTTm95n5psRue0F4lU5ymnDhMDgfbkurVUsfZjA/cHhekcOSPa63I4Fc
	9yfJgMHbT7gtA1Pcw==
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:2097 with SMTP id 98e67ed59e1d1-39e6c6a2359mr184187a91.56.1789748323892;
        Fri, 18 Sep 2026 09:18:43 -0700 (PDT)
Received: from [192.168.50.100] ([111.199.57.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55895112sm1814952a91.3.2026.09.18.09.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 09:18:43 -0700 (PDT)
Message-ID: <90826872-1374-49e4-832d-555abf8e8369@gmail.com>
Date: Sat, 19 Sep 2026 00:18:34 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 08/10] iommu/riscv: Pre-enable GADE for
 second-stage domains
To: fangyu.yu@linux.alibaba.com
Cc: guoren@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
 tomasz.jeznach@linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, baolu.lu@linux.intel.com,
 jroedel@suse.de, zong.li@sifive.com, andrew.jones@oss.qualcomm.com,
 anup@brainfault.org, jgg@nvidia.com, jgg@ziepe.ca, kevin.tian@intel.com,
 atish.patra@linux.dev, skhawaja@google.com, vasant.hegde@amd.com,
 joerg.roedel@amd.com, gong.shuai@sanechips.com.cn
References: <20260915032828.11250-1-fangyu.yu@linux.alibaba.com>
 <20260915032828.11250-9-fangyu.yu@linux.alibaba.com>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260915032828.11250-9-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fangyu,

On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Pre-enable RISCV_IOMMU_DC_TC_GADE in the device context when
> attaching a second-stage domain, if the IOMMU supports AMO_HWAD.
> 
> Software pre-populates second-stage page tables with D set, so
> enabling GADE by default does not change normal behavior. When
> dirty tracking is enabled, iommufd clears the pre-set D bits and
> GADE becomes necessary for hardware to update the dirty bit on
> write access.
> 
> This avoids toggling GADE dynamically and keeps device context
> setup consistent with second-stage domain attachment.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>   drivers/iommu/riscv/iommu.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 16779877351b..f01fd4e2f840 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1330,6 +1330,8 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_MODE, pt_info.iohgatp_mode) |
>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_GSCID, domain->gscid) |
>   			FIELD_PREP(RISCV_IOMMU_DC_IOHGATP_PPN, pt_info.ppn);
> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_AMO_HWAD)
> +			dc.tc |= RISCV_IOMMU_DC_TC_GADE;

I might be missing something, but I don't see how the GADE bit set
here reaches the hardware IOMMU DC. In riscv_iommu_iodir_update()
(in patch 04/10), it looks like only the V bit is taken:

	tc = READ_ONCE(dc->tc);
	tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;
	...
	WRITE_ONCE(dc->tc, tc);

I saw that you mentioned you tested it on QEMU. As far as I know,
mainline QEMU has not yet declared the AMO_HWAD capability. Could
you clarify whether you used a modified QEMU for this test?

Thanks,
Shuai

>   	} else {
>   		if (!riscv_iommu_fsc_supported(iommu, pt_info.fsc_iosatp_mode))
>   			return -ENODEV;

