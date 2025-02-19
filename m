Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453C381AF
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978173; cv=none; b=n40OccGQzIToSRAMh61T8kvUKVbOSZK/kaF+trA/d3wkzxZssjbjqv21CqoNpikYG4KYa6R73IfPuK8r2ay6uzzThr6o+4Qu0JoRBESTWEauxY54Rcn4a67Fc0hrmATcv6iQaN0qm8j80o8EaDxa9pdb8XbpbXSYoISf9C1WaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978173; c=relaxed/simple;
	bh=MpYdKaUscPRH/iamTUXOGwIyLCFTHDfqMIQ7NaihEz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DM/b8m2okbYinwYoSOO0cWD2CwJCt8eKPnhdyuUg56ggQfEsroKyYs0AcLqJk/CaD6/DOyYsZGveQ4Q2OoF2robzYL177UhiTTtdcap71eco3D8G7De1tvPMwv6/C3G8Ao7p1w9R2S99HkKr833kusiIeNxNDmQhC81w1+/3h0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08BD213D5;
	Wed, 19 Feb 2025 07:16:29 -0800 (PST)
Received: from [10.57.35.204] (unknown [10.57.35.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 738203F59E;
	Wed, 19 Feb 2025 07:16:09 -0800 (PST)
Message-ID: <a88b0a48-f7a0-4791-8ea7-a1e599c3313a@arm.com>
Date: Wed, 19 Feb 2025 15:16:06 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Spelling s/KConfig/Kconfig/
To: Geert Uytterhoeven <geert+renesas@glider.be>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ff5b7c88eea8b126ed76029fb57254f29542aa22.1739976486.git.geert+renesas@glider.be>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ff5b7c88eea8b126ed76029fb57254f29542aa22.1739976486.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-19 2:48 pm, Geert Uytterhoeven wrote:
> Fix two misspellings of "Kconfig".

Honestly after 6 years and no obvious complaints I'd be inclined to just 
drop those two paragraphs referring to v4.x kernel behaviour, or indeed 
maybe make a move on the aforementioned removal of the whole thing....

Otherwise, frankly when the same thing is referred to 4 different ways 
in the space of 6 sentences - "this Kconfig", "this config", "this 
option", "This Kconfig option", "this config" - I would argue that 
capitalisation is not the biggest issue with this text ;)

Thanks,
Robin.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   drivers/iommu/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 6cfd1b5b6e07f038..6c46e1d58987cd11 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -348,14 +348,14 @@ config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
>   	  an iommu domain will report an abort back to the device and
>   	  will not be allowed to pass through the SMMU.
>   
> -	  Any old kernels that existed before this KConfig was
> +	  Any old kernels that existed before this Kconfig was
>   	  introduced would default to _allowing_ bypass (AKA the
>   	  equivalent of NO for this config).  However the default for
>   	  this option is YES because the old behavior is insecure.
>   
>   	  There are few reasons to allow unmatched stream bypass, and
>   	  even fewer good ones.  If saying YES here breaks your board
> -	  you should work on fixing your board.  This KConfig option
> +	  you should work on fixing your board.  This Kconfig option
>   	  is expected to be removed in the future and we'll simply
>   	  hardcode the bypass disable in the code.
>   

