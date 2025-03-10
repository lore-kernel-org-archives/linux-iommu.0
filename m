Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C11226CE6
	for <iommu@lists.linux.dev>; Mon, 10 Mar 2025 12:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741610536; cv=none; b=ugXfwNyrdimY0qqFFFc4xGw7LnPLLPlpE+3dWTfTaqQz7opc8K4g80549Qv1ock6hJklvmYvofn0rT77LsW8OiwN4as42FQUNqv7LUOvpP4SHmwUsbFhFaOLQlsUJZd8Jz7xTyXTgDDSZhXjmMDGsXFtlBGemaNApOnYgp7tAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741610536; c=relaxed/simple;
	bh=Mr3ArIL90r3nfEex8ek2xRQJm5qwrKjXOVhHUs4sTTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cH0I2v0bsPqrVjNkalfJvIYYYylrIHmdsm5Afxq6l95HJNXl69eC52jUob//1TBmeDvyewvBToNjjiXuJOlYKh38YL5aoTgY5ApBxui56MM3Pz4XjbufuzK0pVmujJRel12f39HO6ng7gCxYeVTu97uIWiVhz9FKFiLa2/sIwao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0DF152B;
	Mon, 10 Mar 2025 05:42:24 -0700 (PDT)
Received: from [10.57.39.174] (unknown [10.57.39.174])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 142693F5A1;
	Mon, 10 Mar 2025 05:42:11 -0700 (PDT)
Message-ID: <6f5f2047-b315-440b-b57d-2ed0dd7395f6@arm.com>
Date: Mon, 10 Mar 2025 12:42:10 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm: Allow disabling Qualcomm support in
 arm_smmu_v3
To: webgeek1234@gmail.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250310-b4-qcom-smmu-v1-1-733a1398ff85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-03-10 6:11 am, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> If ARCH_QCOM is enabled when building arm_smmu_v3,

This has nothing to do with SMMUv3, though?

> a dependency on
> qcom-scm is added, which currently cannot be disabled. Add a prompt to
> ARM_SMMU_QCOM to allow disabling this dependency.

Why is that an issue - what problem arises from having the SCM driver 
enabled? AFAICS it's also selected by plenty of other drivers including 
pretty fundamental ones like pinctrl. If it is somehow important to 
exclude the SCM driver, then I can't really imagine what the use-case 
would be for building a kernel which won't work on most Qualcomm 
platforms but not simply disabling ARCH_QCOM...

Thanks,
Robin.

> Fixes: 0f0f80d9d5db ("iommu/arm: fix ARM_SMMU_QCOM compilation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/iommu/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index ec1b5e32b9725bc1104d10e5d7a32af7b211b50a..cca0825551959e3f37cc2ea41aeae526fdb73312 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -381,6 +381,7 @@ config ARM_SMMU_MMU_500_CPRE_ERRATA
>   
>   config ARM_SMMU_QCOM
>   	def_tristate y
> +	prompt "Qualcomm SMMUv3 Support"
>   	depends on ARM_SMMU && ARCH_QCOM
>   	select QCOM_SCM
>   	help
> 
> ---
> base-commit: 1110ce6a1e34fe1fdc1bfe4ad52405f327d5083b
> change-id: 20250310-b4-qcom-smmu-d4ccaf66a1ce
> 
> Best regards,

