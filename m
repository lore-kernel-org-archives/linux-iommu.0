Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39C4F96BF
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747745; cv=none; b=o0x9oy4TivvflqJckc/GlUGnvF4B2vqKaj3pQ3nZhIxW+1kj6OWmSzV6W9kL94RcYMyfCgZmCphPmoPDtPr1iIkXi3NsMPysr73pQB2SOUmLDRYaNRqtJ77CtbukFR8P4hCFm14CWOnB+rpRGu46gUUCE5NSGq5Wkr4lL/tGFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747745; c=relaxed/simple;
	bh=cYI6D3YGhnxQDwopLlFtXMW15VE1IpzDLjkleshyjpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aa/IhNkxueMGoGWAZo4rr975MCVPBsiVxJBxpYO8XhgMbMr59/xU1tUui/JqEgprP9dTd9l5EJj6rfZd2ksZ93d6ecSqo3cNrmnFtDfKUENUnhPdMANSqsU0ujsvQZIp7g9RiS5IdZZ8iHPPKZ9MTmLbmZWUv63oWhUGMQp3vDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJXucjr/; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJXucjr/"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2dae660f31bso6720825ad.1
        for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789747743; x=1790352543; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sTFwCwuuJBdUqXmrDgIcnP3ObUsaQ9UCrGTYomH04hg=;
        b=fJXucjr/cRif87UORP46RWUhCih00AG6+XSSoUQQhOM3rm4wGkiVYGkw0PvZwPSqNF
         R5jhkzYgzKrPL1JxLkF5DpL7dloZVLccVC8GuNNI6TU9sT8F9j3vLj5HZA6vBXd1bAuf
         Lwb+f4tua7kxNfMDhJdTp7gWnGJty66NyvRZ8lSV34uZTaRxiL0Wacj31P3TBRrmRqbe
         A2fAHNbc378caY79wT/M41zpp/49JPbeGhzNpi9T92e+9aZrun5L+BbCCRNYI8TgXfDa
         i3NFYACMNyYsVAPxxKvzHImpjyFdhbXXIOWzA5iCzL3K1Q0VkMeH5SVf+TlbfIO6+buU
         +kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789747743; x=1790352543;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTFwCwuuJBdUqXmrDgIcnP3ObUsaQ9UCrGTYomH04hg=;
        b=lUR7tuCGMSropN97Ot1XcKQOMdCqHQu9JsZ7V7NzHk8tILJFQkzuVu9D8JKaRO/v2+
         0LzsM8baQUmwJJ66Lzwm5Wx/O4mYNahmYgn+LXny85nwUxuabTf1GbI3FLfvCIev5At1
         pXQ+Q01zVzfaNsw/q0U6KTEonB/CIOyEyZKY12tV/iYM7Glm29Bn17nKVyV3zywmcNel
         Gc9Q3XzeXt9YL29MjfVx7KFfjswrbAHKoN+iWV1dBkrSb70rE2WD6rGmOEO+EzVNTsNU
         1T8iWKw3HhCPxeHf7SRFAqbpYPz7bro0cCD1vrBAFU7ad/CkjCctTrE/UxjcRyl93x2h
         vv8A==
X-Forwarded-Encrypted: i=1; AKwUvBwmPbg0NbIAzVsKiQ3dme+f4XJrU2uVo/QgweFtp670MfKiAUrkst2rWTxaUTfhgEo92CZItw==@lists.linux.dev
X-Gm-Message-State: AFuF++nxGtxzrXcMDktriiSxDJNk81sXWQtYuXORNARVkdAsNRQm05FG
	GzjmkbJVNZF9fh3Omru20gi/kJHSst51wR1nQJCo5DduUh2RL/+ewI+D
X-Gm-Gg: AYBFou3kDcxW5LWvJvX4VQGAH/iocwtXRBPwqsliKeHQocAT3gSnVuAToXEp7OjTBXR
	H43y+ZpkvXsF808aw9g6WLXmNKppfvdngJLL7N6MJfLXpi1WVxVQw+/glMCKS0FyWFouc1vNcvc
	iJNO7ShLx3woNuQs5NSABUce69xVD6zo5STIA2iG57sLFz3ZBrde6nPz1B9zniNYxVP+Sje1Ccn
	GLuz5FULrTNLtChe7IUK2f6LNDdlDQQd+jgiU3/bOx6WzXARh97atbuYUzbkse/At7ATHl5k0Q1
	XRPqYCOKIkICFMGmFpCQoKsTbBE8QUMSgHVHgqqYgwAhj7CKzdmPnYBmTSBgCJGuag6Z3GjaYih
	oP1yGBigSXlGgW3B9MsH8FEAOlaJ66J6ihKocH3UU9EBo7mUc1shUgfWn1+MlxpBCyEcgrAkASz
	tJVsH+FuomWkgUijXeiaqGXF8p2RjTRDXRb6qvAsF3GIzlTO2JuP8Z4zjzM1mH4yTlqXdFU5RQR
	9Jw6ppKLtr+6ZhhKA==
X-Received: by 2002:a17:902:ea0c:b0:2dd:c100:7ccb with SMTP id d9443c01a7336-2ddc1007e5cmr1279195ad.71.1789747742619;
        Fri, 18 Sep 2026 09:09:02 -0700 (PDT)
Received: from [192.168.50.100] ([111.199.57.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddb76025afsm10835745ad.73.2026.09.18.09.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 09:09:01 -0700 (PDT)
Message-ID: <6d1bfb10-fd04-4e4e-895d-55c16fcea13f@gmail.com>
Date: Sat, 19 Sep 2026 00:08:53 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 04/10] iommu/riscv: use data structure instead of
 individual values
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
 <20260915032828.11250-5-fangyu.yu@linux.alibaba.com>
From: Gong Shuai <gsh517025@gmail.com>
In-Reply-To: <20260915032828.11250-5-fangyu.yu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fangyu,

On 9/15/2026 11:28 AM, fangyu.yu@linux.alibaba.com wrote:
> From: Zong Li <zong.li@sifive.com>
> 
> The parameter will be increased when we need to set up more
> bit fields in the device context. Use a data structure to
> wrap them up.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>   drivers/iommu/riscv/iommu.c | 27 +++++++++++++++++----------
>   1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index a6c8307e82ea..c5b6214ee672 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1165,7 +1165,7 @@ static void riscv_iommu_iodir_iotinval(struct riscv_iommu_device *iommu,
>    * interim translation faults.
>    */
>   static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
> -				     struct device *dev, u64 fsc, u64 ta)
> +				     struct device *dev, struct riscv_iommu_dc *new_dc)
>   {
>   	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>   	struct riscv_iommu_dc *dc;
> @@ -1204,10 +1204,10 @@ static void riscv_iommu_iodir_update(struct riscv_iommu_device *iommu,
>   	for (i = 0; i < fwspec->num_ids; i++) {
>   		dc = riscv_iommu_get_dc(iommu, fwspec->ids[i]);
>   		tc = READ_ONCE(dc->tc);
> -		tc |= ta & RISCV_IOMMU_DC_TC_V;
> +		tc |= new_dc->ta & RISCV_IOMMU_DC_TC_V;

According to SPEC 3.1.3.3, the "V bit" does not exist in DC.ta.
This should be a convention from when the iodir_update() function
did not yet use `struct riscv_iommu_dc` as a parameter, using bit 0
of DC.ta to indicate that the DC is valid. Now that iodir_update()
receives the complete dc, it can directly access DC.tc.V, so this
convention should no longer be necessary and will cause confusion.

>   
> -		WRITE_ONCE(dc->fsc, fsc);
> -		WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
> +		WRITE_ONCE(dc->fsc, new_dc->fsc);
> +		WRITE_ONCE(dc->ta, new_dc->ta & RISCV_IOMMU_PC_TA_PSCID);

`RISCV_IOMMU_PC_*` should be replaced with `RISCV_IOMMU_DC_*` for
readability. There are several other similar places in this file
that are unrelated to Process Context or PASID but use the *PC* macros.


Thanks,
Shuai

>   		/* Update device context, write TC.V as the last step. */
>   		dma_wmb();
>   		WRITE_ONCE(dc->tc, tc);
> @@ -1288,22 +1288,22 @@ static int riscv_iommu_attach_paging_domain(struct iommu_domain *iommu_domain,
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
>   	struct pt_iommu_riscv_64_hw_info pt_info;
> -	u64 fsc, ta;
> +	struct riscv_iommu_dc dc = {0};
>   
>   	pt_iommu_riscv_64_hw_info(&domain->riscvpt, &pt_info);
>   
>   	if (!riscv_iommu_pt_supported(iommu, pt_info.fsc_iosatp_mode))
>   		return -ENODEV;
>   
> -	fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
> +	dc.fsc = FIELD_PREP(RISCV_IOMMU_PC_FSC_MODE, pt_info.fsc_iosatp_mode) |
>   	      FIELD_PREP(RISCV_IOMMU_PC_FSC_PPN, pt_info.ppn);
> -	ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
> +	dc.ta = FIELD_PREP(RISCV_IOMMU_PC_TA_PSCID, domain->pscid) |
>   	     RISCV_IOMMU_PC_TA_V;
>   
>   	if (riscv_iommu_bond_link(domain, dev))
>   		return -ENOMEM;
>   
> -	riscv_iommu_iodir_update(iommu, dev, fsc, ta);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = domain;
>   
> @@ -1378,9 +1378,12 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +	struct riscv_iommu_dc dc = {0};
> +
> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
>   
>   	/* Make device context invalid, translation requests will fault w/ #258 */
> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = NULL;
>   
> @@ -1400,8 +1403,12 @@ static int riscv_iommu_attach_identity_domain(struct iommu_domain *iommu_domain,
>   {
>   	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
>   	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +	struct riscv_iommu_dc dc = {0};
> +
> +	dc.fsc = RISCV_IOMMU_FSC_BARE;
> +	dc.ta = RISCV_IOMMU_PC_TA_V;
>   
> -	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, RISCV_IOMMU_PC_TA_V);
> +	riscv_iommu_iodir_update(iommu, dev, &dc);
>   	riscv_iommu_bond_unlink(info->domain, dev);
>   	info->domain = NULL;
>   

