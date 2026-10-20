Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494830;
	b=bGLjAGDARzTi7nZaSI/snPhT5WeKMs5u05XOwYHV4xVGZLdEgEC9FlS9xeAUFsaZa8lS
	 uEphCFyrWHvkdVIkHADvmv/d36yXhNzLqefiK+O0Xgzh4K/6HPuA2HojpjaGx5hQzGq41
	 yccE87QfuiEUn5bedKy8EeNITwknh34boMQo/ykZvEpsllq6jzV9Pl7YhPSzfV6TQ6Lla
	 0MLxtDlbT24uwtRt6VrUoZA4Fyv7auzLBGUuZ8lmWi69fmhq7QZE1qy9YEbeVVGfZiiE5
	 VE013aXx/qDar5o3LwB6So11MeG+q+5ZE2MdlPhb5e/HaVB/OZ+KOCsPgncS8bqADVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ssC6O5op5kxsykPYGF90zu0HggsOhAnuDsh96PbOQGs=;
	b=guGtmNN1hgCQlEzf06dA8T6IUDEnq0xe5baZJDpTEu3AV+v+1RZHi1PdJZUn5j4Ja+L8
	 2FP0yN1Bu5MvMlAueMtjB44PPxKnR9Ln5DkE/pAg1Id8NO52j3u9kpnHbRFphuJs/Z8L1
	 kdzrJQsori3X2JagXKuLEJs6O85KWgDjKDTSzc2ZdUdMPnCiHZrOIFwnwwLDuTRt9WzaA
	 Zs9oxAq2Q2A7WCqLmIqaySGz/g8oUHFynQZ3f7sxVPpmye7UHwZ6sx00lFyCVJdP903ul
	 nQD4GiTJpBgWprJp/I1g80W7Tf4Ytihxu9laWkz2+HQwKpRGX+mWYVeJSccjxZQehPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AcX9MxKA;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD00606A31C
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 11:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDD00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AcX9MxKA
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a018493d57so60505e9.0
        for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792494828; x=1793099628; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ssC6O5op5kxsykPYGF90zu0HggsOhAnuDsh96PbOQGs=;
        b=AcX9MxKAO0vOecN9j9DyhUGhBD4/AAqJSn7fSCl8HoL59N3070h+jNND0IzIB6psWH
         A+tQ6e82ZIDRNtinYMIJeB1/Lyf+ceW5Kw/jHzZv64c2l+woXqHC1M3HQGUGgU54fT/9
         rZ+wqimdCTCFR5fFK2Ju2gwKXPMMdpYX9WJYmtTMbgCuoBqbpjaX/51eefgQJ/A8pjSx
         IgacqNWM7XfXk4tziY30aRnwgIymHkpLJ6SX20Nk0//tOZOkP7UM/j1mj4jrAJPxV9G6
         gGjpo+ezdGu/QXn+oNLhek8yD5pifZecEexyjVBP76I1HZLYhJ6cNvvBAH7hu52biLMQ
         1RqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792494828; x=1793099628;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssC6O5op5kxsykPYGF90zu0HggsOhAnuDsh96PbOQGs=;
        b=DM8vO5jnOHbHsxe2LiNmWGgVuKHG618/3hBz6SJW1yJxZixWrdr+RrEJXAEYWBlKRq
         EmZI+Yx55rG0ryoKpxwBmZGzP2q1mmnyTcmjRrUxuC18JTa4W/xJbLMtXeh3kKX/q04u
         QSF2BWvOtd6uP32HyaTN/kY6bfYlgvEpJsr5lqRNurWvaRarI5mtajha8O87UZtHZ8oo
         HRUcS/irpTNPhCbj1GS8DLEDaQyChIIddF01PJr3mZRZVAgCdAqqccRYVoyrepoZX5a4
         CAqQmy6DsEhfJLAhwHXh6/qWUMhpfcdRc/4/noLIvWps7LJoa2YsmCF+BivbbW7Yj0ys
         HTvg==
X-Forwarded-Encrypted: i=1; AKwUvBzfBbrdGV+DpV2WPR4J8UurljT2+U29NwVjUwp2YVGu5EXS97aMxGdEu6QGGV68OZI9Tq4cvg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJPBULFHxibJEyfbaPKJSEYe2jFcIMtdr7QtIgSLLKJZT1CvLJO
	g+8crKZUToCwN/AbnAgGV/e1GxdWniNND4WiYh7xuYjwynLXDO+yVsIbAm7LDLtswQ==
X-Gm-Gg: AYBFou1cgTpuT0KcODjt3cBnP5bGjL1xGoKHdC4FddjNHvmeLKufE2xqLSRt6ik3egU
	8GiI8FbEEbIHXiAXS/+M3nubBKfCTcXBlOz9G2SDRa4M+jXAX1GxzQxSf94hMytycnwnjWkRWFg
	3fxiZU8hv9vOFrvQsNx23QtO1Y7I1xdwNRFci1wIl5kKrUoD0ebqhOuzT5n7nC5GqmJzWqVPF7X
	Ke9knM2rD73IRUY8xt7gY36gVG01CZueqP/KArf8xlcL+f6gXq//BOZkE25NrRDB/1b/PMCNwjT
	nh07gTe80+91G0moHGSuvi4nuuXkZM/ezVL8mmVtExuSxfGFC7IhAAp7H5YG3cYsEcD//FhxJso
	74eq+wSd5OHjnGMsIMLhkg7GqG1I2CorA6GGmnzgzYvfbSjVjcYBXdO+KyEW6wZxwuM6WhtX5d6
	SFg6o9C41YuXjJvGCiJEDinJa+ckpF69OX+OCcJKzhE31XoVthmbzzNJvJ2CQFXIXT29Z86gj+q
	HkUEO87tENrFYJkZmj79luLNAFGkin0l61sqPwp
X-Received: by 2002:a05:600d:4447:10b0:4a1:7af1:5386 with SMTP id 5b1f17b1804b1-4a1f37a469emr748285e9.1.1792494827956;
        Tue, 20 Oct 2026 04:13:47 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d41c8asm64987465e9.8.2026.10.20.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 04:13:46 -0700 (PDT)
Date: Tue, 20 Oct 2026 11:13:43 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
	praan@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
	Cristian Prundeanu <cpru@amazon.com>,
	Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 01/11] iommu/arm-smmu-v3: Init the vmid_map ida
 before the stream table setup
Message-ID: <atdM52CxWJTZxOIz@google.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <058aeb235a458c5b48d918d947608c76dde0d845.1791226953.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <058aeb235a458c5b48d918d947608c76dde0d845.1791226953.git.nicolinc@nvidia.com>

On Mon, Oct 05, 2026 at 12:30:44PM -0700, Nicolin Chen wrote:
> The vmid_map ida is initialized after the stream table setup, along with
> the devres action that destroys it.
> 
> An upcoming change will reserve the crashed kernel's in-use VMIDs in this
> ida, from a kdump kernel's stream table adoption that runs in place of the
> regular setup and returns early.
> 
> Move the ida_init() and its devres registration to the entry of the whole
> function, so that the ida is ready by the time the adoption path runs.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 34e916ea339ff..792627e1c790e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4842,17 +4842,17 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  
> +	ida_init(&smmu->vmid_map);
> +	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
> +				       &smmu->vmid_map);
> +	if (ret)
> +		return ret;
> +
>  	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
>  		ret = arm_smmu_init_strtab_2lvl(smmu);
>  	else
>  		ret = arm_smmu_init_strtab_linear(smmu);
> -	if (ret)
> -		return ret;
> -
> -	ida_init(&smmu->vmid_map);
> -
> -	return devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
> -					&smmu->vmid_map);
> +	return ret;
>  }
>  
>  static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
> -- 
> 2.43.0
> 
