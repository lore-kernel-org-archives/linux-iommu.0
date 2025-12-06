Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F79CDDC5
	for <iommu@lists.linux.dev>; Sat,  6 Dec 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765024463; cv=none; b=i82t6RoUfacI1gxbnphcAQ/+9heaK5/wx47ukBtYVK+CIE+/LZbdz6ZoT2lAao1FIwqs3ykTwBt3VQbKqKeiVUYdMP+hydA1zTD7O5lh5/GtXHj7C8aaOJoOqfC0OIi6dp8Df2GchUKQn/gN8XpO3KpyP9wTV6BFjIZHwDjZHnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765024463; c=relaxed/simple;
	bh=1B+b5uMzv7tPRzPZuitUQCDp5n3sI/lCFuOUyr+d234=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvW1QeZ2IAl+XC7rNfnCNWcXt/f3G1WzVXyBu7/v0GL33fL3vjzcNb4Phbcd7eAqpc65afikhNsFDnK4LR9jUjDsnRCCYW+zOSX7v6sZY63r7uQjwMwQRuIp/oeexdIagu5thiM6mkYPp4QcEtcehIVp+o6lv06UbEQCV3rE0i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K062gmr5; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K062gmr5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765024451; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bjwnmRwNJgra34vToCJ4x7gNRKm2tiUS3qQS46PNKRY=;
	b=K062gmr5xiGVMFrO+7pzSt/+rzKqu3F3gjIubrq7/ws/sw5cn+guFnqtJJf4FBPwTrCDzsY19uGU6KoY9CzZr1RzYArU/khO8A6S4+2K0nNy6wUR24EmZ/siBG7TYV+7jnDQ6tqNCWi2q4xGy/EWRBbv7ueUMKuouGHZbBRt5wM=
Received: from 30.246.178.18(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WuB-biP_1765024449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 06 Dec 2025 20:34:10 +0800
Message-ID: <703ba08f-eec0-44d8-a224-c96706df5fab@linux.alibaba.com>
Date: Sat, 6 Dec 2025 20:34:09 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rc v1 4/4] iommu/arm-smmu-v3-test: Add nested s1bypass
 coverage
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, will@kernel.org,
 robin.murphy@arm.com
Cc: joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 skolothumtho@nvidia.com, praan@google.com
References: <cover.1764982046.git.nicolinc@nvidia.com>
 <3c838833d8bbb69a72a85ddbcc325b22ae7a7d6d.1764982046.git.nicolinc@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <3c838833d8bbb69a72a85ddbcc325b22ae7a7d6d.1764982046.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/12/6 08:52, Nicolin Chen 写道:
> STE in a nested case requires both S1 and S2 fields. And this makes the use
> case different from the existing one.
> 
> Add coverage for previously failed cases shifting between S2-only and S1+S2
> STEs.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c  | 32 +++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> index 9287904c93a2..56bdcf5a517e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-test.c
> @@ -553,6 +553,36 @@ static void arm_smmu_v3_write_ste_test_s2_to_s1_stall(struct kunit *test)
>   						       NUM_EXPECTED_SYNCS(3));
>   }
>   
> +static void
> +arm_smmu_v3_write_ste_test_nested_s1dssbypass_to_s1bypass(struct kunit *test)
> +{
> +	struct arm_smmu_ste s1_ste;
> +	struct arm_smmu_ste s2_ste;
> +
> +	arm_smmu_test_make_s2_ste(&s1_ste, ARM_SMMU_MASTER_TEST_ATS);
> +	arm_smmu_test_make_cdtable_ste(&s1_ste, STRTAB_STE_1_S1DSS_SSID0,

arm_smmu_test_make_s2_ste() makes a s2 ste and it will be overwrited by
arm_smmu_test_make_cdtable_ste(). Finnaly, we got a s1 STE, not a nested
s1dssbypass ste.

I think we need a function like arm_smmu_make_nested_cd_table_ste()
here.

Besides, from the function name, I think you mean
STRTAB_STE_1_S1DSS_BYPASS?

+	arm_smmu_test_make_s2_ste(&s2_ste, 0);
+	arm_smmu_v3_test_ste_expect_hitless_transition(test, &s1_ste, &s2_ste,
+						       NUM_EXPECTED_SYNCS(3));

With get_ignored(), a nested s1dssbypass STE to a nested s1bypass STE
will be hitless, a.k.a, NUM_EXPECTED_SYNCS(1).

Thanks.
Shuai
