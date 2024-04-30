Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A8412B176
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474860; cv=none; b=u7/KdohU/iX4Wrl1LE+j/zMr31orS6kIWUWE+6dy6hprSiAj9ZuRyC+oHP4KEqoCPkuA5eJv/0UVqV7+neO4zJyaGp1+XVKy4w8ILaaEFpgy6E1sO8k/BAR/rvNyiB5liYOsdC8qTj0jWTyr1M7wTuk9AdmAfvvWOZkEMlFpyEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474860; c=relaxed/simple;
	bh=ia0m/v3NkfxuBvlrAdojfIkIRk1HopN19vUMuivFtk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slwrE1PNLjNwJN2QyMbVpiTMBk6Tj9m1YvxN+WiEXqna8ojW2oWR/5Wlglk+xLKEu8hAjaU7fEHDvgK0SpTTTT8iS1K2WjacV5nL7i64ZcYArxjrT69VyauO8m8ICPZ/ai1ccNCEdWdEgiq7P8U5kZKlqC32vbkQSyUk4c8yYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10C772F4;
	Tue, 30 Apr 2024 04:01:24 -0700 (PDT)
Received: from [10.57.1.41] (unknown [10.57.1.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EF2D3F73F;
	Tue, 30 Apr 2024 04:00:56 -0700 (PDT)
Message-ID: <658581c0-eb0f-408d-a32e-c97d948103df@arm.com>
Date: Tue, 30 Apr 2024 12:00:54 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: Properly clean up iommu-dma remnants
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: joro@8bytes.org, will@kernel.org, catalin.marinas@arm.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <d4cc20cbb0c45175e98dd76bf187e2ad6421296d.1714472573.git.robin.murphy@arm.com>
 <CAA8EJprv9At9t-C+EzUt60F1_ke30F78zpGr=vLFBB9Mk1zv+w@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAA8EJprv9At9t-C+EzUt60F1_ke30F78zpGr=vLFBB9Mk1zv+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-04-30 11:32 am, Dmitry Baryshkov wrote:
> On Tue, 30 Apr 2024 at 13:23, Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> Thanks to the somewhat asymmetrical nature, while removing
>> iommu_setup_dma_ops() from the arch_setup_dma_ops() flow, I managed to
>> forget that arm64's teardown path was also specific to iommu-dma. Clean
>> that up to match, otherwise probe deferral will lead to the arch code
>> erroneously removing DMA ops set elsewhere.
>>
>> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Link: https://lore.kernel.org/linux-iommu/Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru/
>> Fixes: b67483b3c44e ("iommu/dma: Centralise iommu_setup_dma_ops()")
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   arch/arm64/Kconfig          | 1 -
>>   arch/arm64/mm/dma-mapping.c | 8 --------
>>   2 files changed, 9 deletions(-)
> 
> 
> Thanks!
> 
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Great! Always nice when the issue is one of simply not deleting *enough* 
code :)

Cheers,
Robin.
