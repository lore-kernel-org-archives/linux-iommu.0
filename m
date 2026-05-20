Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725DA24E4A1
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281958; cv=none; b=lBO78MJmoPjQAOAtv9slE9wPjy8t0NfFGBLtf3PsAcR7beRHUKL/gfq8Ul3Y93GHZ+sdiia/CTdXchVlBlfbfggJLP68JxaQMGj39ORzX7+SRWrHbcNDw6JjNdT7h6h61QmlcvnwloSoGRiyI0aicHnHZYfFPlrkcMiG/TbKjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281958; c=relaxed/simple;
	bh=REOM245G7CIl5zoT+snm7tQ+xPdTeWo5pJCFGFovHGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2YvDyGcHK5T0AtxEa4Pz3U64U0Z0NPQtHPwpLqUtPiwwt6A7GjBxIv0NmR3h9YQTRgOLWo8P1oPMjaBmHP4l3qmqKBLm2+9qUuO8IDZC7McAcTZd8Rw4sxue5sR5/3JQJj8WLGi94+7LpNpnW1tv9TE9jrg+k4FAe6YkaHh+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BxNmM/v1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BxNmM/v1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779281955;
	bh=REOM245G7CIl5zoT+snm7tQ+xPdTeWo5pJCFGFovHGU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BxNmM/v11NdR4+bNKzLXUHVVgXvOVouczXVH8Rvp1MR8xShvuIUhc1FHMkzx9yBXp
	 0C/BDXVQXknFEh7yFWsVPGNEvBVzoe7eMtkwV+FoM95c40s2ZmYarNjoRC4gwMXNhD
	 tKX1x9eGsBGrMPlIy2qTzUBw5Di6V9Lh0vn/F9RyHsDO8j58uPFnnGnPgeWaKWR0qC
	 rw9u2iEm8jJTf527X+BTtZkYdK3R3S0OJzDDDDThYjL0Artl2X4HnqJozUqpNUug8T
	 JPgw8tKi+liUC/GqDU173oQsIHaihV8Macs6DZPGWncsNpzqEBWb2PLeOxfZ2mqcx5
	 Mg0w3lhlNwN7w==
Received: from [100.64.1.43] (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A116117E0940;
	Wed, 20 May 2026 14:59:15 +0200 (CEST)
Message-ID: <fcedc7d8-f93e-4d96-b23a-fb9ad5a1f534@collabora.com>
Date: Wed, 20 May 2026 14:59:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: vsi: avoid -Wformat-security warning
To: Arnd Bergmann <arnd@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260519203658.1341889-1-arnd@kernel.org>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20260519203658.1341889-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 19/05/2026 à 22:36, Arnd Bergmann a écrit :
> From: Arnd Bergmann <arnd@arndb.de>
>
> When -Wformat-security is enabled, it catches a call to
> iommu_device_sysfs_add() that passes a string variable in
> place of a format:
>
> drivers/iommu/vsi-iommu.c: In function 'vsi_iommu_probe':
> drivers/iommu/vsi-iommu.c:717:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    717 |         err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
>        |         ^~~
>
> Pass this indirectly using "%s" as the format instead.
>
> Fixes: 917ace84b770 ("iommu: Add verisilicon IOMMU driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/iommu/vsi-iommu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/vsi-iommu.c b/drivers/iommu/vsi-iommu.c
> index 5d0721bd2c7a..23913720d484 100644
> --- a/drivers/iommu/vsi-iommu.c
> +++ b/drivers/iommu/vsi-iommu.c
> @@ -714,7 +714,8 @@ static int vsi_iommu_probe(struct platform_device *pdev)
>   	pm_runtime_use_autosuspend(dev);
>   	pm_runtime_enable(dev);
>   
> -	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
> +	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, "%s",
> +				     dev_name(dev));
>   	if (err)
>   		goto err_runtime_disable;
>   
