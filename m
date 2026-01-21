Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EF6421F1D;
	Wed, 21 Jan 2026 15:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008269; cv=none; b=n6fT1tAhxcm9wBjuA/XyRgxLdYFblia6IZVLGQmCvmek+tnhejPjE1GMWcoEO9GgJuexK+w/mJptgKX5DrGaAVGhNOLGZsJqiqUnCPkPcb4sHpj1k7JpQLjAG7zOWD99AE/DXZY6lC404Vz4WwUGiRkH8tcgB9vG3kcvKvUYErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008269; c=relaxed/simple;
	bh=pl9AN7mrkmrrcSPY7LzRnmTnRRdHbG6I4Yzm1E/3Vs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUGkyVb+pZf3pRmNAxxuLU30IpP9Yl5IZdkfmgvNU5PDDWAMJ2aAan8AzBAuuSymAJOHWL3ZXOu9YvM1nHdZwMmgCQSZvqN2i+nxbt7hfFpY90zWp5x7tqZCxFRKuwu3zYlDqFQOavA4mRnboGuWbELQrsb2Jo//nOTiuMd5Pck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEF4D1476;
	Wed, 21 Jan 2026 07:10:59 -0800 (PST)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 897FF3F632;
	Wed, 21 Jan 2026 07:11:04 -0800 (PST)
Message-ID: <56506bb7-89ff-4b7a-9cb3-42f6ecf4dc6a@arm.com>
Date: Wed, 21 Jan 2026 15:11:03 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-qcom: do not register driver in probe()
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, broonie@kernel.org, will@kernel.org, joro@8bytes.org,
 robin.clark@oss.qualcomm.com, hanguidong02@gmail.com,
 quic_c_gdjako@quicinc.com, dmitry.baryshkov@oss.qualcomm.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org
References: <20260121141215.29658-1-dakr@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260121141215.29658-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/01/2026 2:12 pm, Danilo Krummrich wrote:
> Commit 0b4eeee2876f ("iommu/arm-smmu-qcom: Register the TBU driver in
> qcom_smmu_impl_init") intended to also probe the TBU driver when
> CONFIG_ARM_SMMU_QCOM_DEBUG is disabled, but also moved the corresponding
> platform_driver_register() call into qcom_smmu_impl_init() which is
> called from arm_smmu_device_probe().
> 
> However, it neither makes sense to register drivers from probe()
> callbacks of other drivers, nor does the driver core allow registering
> drivers with a device lock already being held.
> 
> The latter was revealed by commit dc23806a7c47 ("driver core: enforce
> device_lock for driver_match_device()") leading to a deadlock condition
> described in [1].
> 
> Additionally, it was noted by Robin that the current approach is
> potentially racy with async probe [2].

On third look, the current lack of unregister, when it can end up in a 
module which (theoretically) supports unloading, is also sketchy :)

> Hence, fix this by registering the qcom_smmu_tbu_driver from
> module_init(). Unfortunately, due to the vendoring of the driver, this
> requires an indirection through arm-smmu-impl.c.
 >
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/lkml/7ae38e31-ef31-43ad-9106-7c76ea0e8596@sirena.org.uk/
> Link: https://lore.kernel.org/lkml/DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org/ [1]
> Link: https://lore.kernel.org/lkml/0c0d3707-9ea5-44f9-88a1-a65c62e3df8d@arm.com/ [2]
> Fixes: dc23806a7c47 ("driver core: enforce device_lock for driver_match_device()")
> Fixes: 0b4eeee2876f ("iommu/arm-smmu-qcom: Register the TBU driver in qcom_smmu_impl_init")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Looks OK to me, thanks Danilo!

Acked-by: Robin Murphy <robin.murphy@arm.com>
