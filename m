Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D6433E7E
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976147; cv=none; b=Oivz2C6e12y/eVjym8mAtmZtVKbS1d2PM7oq26z52H13zOTxuTUjc5g6r/LZ7/RTx6lujexUYf3zCV1vitDM+yBN1TalfQE7GVR94rb6MMjkIeuvSRext4T6YPXYPmO8Vomz8K3m31XtUvdcRiK5WeVnTw/t5ang2ioujBce1xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976147; c=relaxed/simple;
	bh=UK3eqmyaQv49dgSjgCQotcoCCG0rNrTA9aEt/MAh0Yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4An+dN5B6zNiUuGLPykx/lTJxXV/DOs8jf2jL+alVpck1SH2X+ycvopUQUynTnk+85OXXNAJgROb85qDzTgANwpvMCuYMV/HodYQ41R99NoYUkivypdhuAx7WBMGRm2/K5BsbROAwhuLWq1NOcygkuuUDGkJheTXiqx2dtB8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kHmZbiVg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kHmZbiVg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D90191655;
	Mon, 17 Aug 2026 07:15:40 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1B1393F85F;
	Mon, 17 Aug 2026 07:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786976144; bh=UK3eqmyaQv49dgSjgCQotcoCCG0rNrTA9aEt/MAh0Yw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kHmZbiVgh2+8yoL6/yas/fsJ2z3Y/Me4SpNPGRpu19KnELHAFOVWLJVW/NCg5zMyA
	 ZQPA4OZj448cV7cNY/7FlpTgP/76Xx+E7FCAgw3V4hwx3/JrZtjaPRRfG70hzI1Kut
	 mzFxfH7PE+5onUXesqwYIDt9c2dQ5tkQM7PEJ7pI=
Message-ID: <032dc5ff-3930-43ab-ad82-2f92b16c65e6@arm.com>
Date: Mon, 17 Aug 2026 15:15:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/iova: Clear the slab cache pointers when destroying
 them
To: Davidlohr Bueso <dave@stgolabs.net>, joro@8bytes.org, will@kernel.org
Cc: mcgrof@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260816184339.420285-1-dave@stgolabs.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260816184339.420285-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/08/2026 7:43 pm, Davidlohr Bueso wrote:
> Both iova_cache_get() failure path and iova_cache_put() destroy the two
> slab caches without clearing the pointers, leaving them dangling with
> iova_cache_users at zero. The next iova_cache_get() then re-enters the
> respective block, and if it fails early enough to reach 'out_err' before
> re-creating both caches, it calls kmem_cache_destroy() a second time on
> whichever cache is still stale:
> 
>    BUG: KASAN: slab-use-after-free in iova_cache_get+0x216/0x280
>    Read of size 1 at addr ffff888001b9fdc0 by task swapper/0/1
>    CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc1 #2
>    Call Trace:
>     <TASK>
>     dump_stack_lvl+0x53/0x70
>     print_report+0xce/0x620
>     kasan_report+0xce/0x100
>     __kasan_check_byte+0x36/0x50
>     kmem_cache_destroy+0x1b/0x1c0
>     iova_cache_get+0x216/0x280
>     ...
>    Freed by task 1:
>     kasan_save_stack+0x33/0x60
>     kasan_save_track+0x14/0x30
>     kasan_save_free_info+0x3b/0x60
>     __kasan_slab_free+0x43/0x70
>     kmem_cache_free+0xbe/0x3c0
>     kobject_put+0x14d/0x280
>     iova_cache_put+0x8e/0xd0
> 
> Clear both pointers after destroying them, in both places.

Out of curiosity, what architecture/kernel config have you found this 
with? I see the logic, but off the top of my head I'm somewhat 
struggling to imagine the scenario in which iova_cache_get() succeeds, 
the last user (so no iommu-dma) cleanly calls iova_cache_put() to be 
able to free the state, then another iova_cache_get() fails. Is 
everything else also falling apart in flames anyway at this point?

Thanks,
Robin.

> Fixes: 84e6f56be9c6 ("iommu/iova: use named kmem_cache for iova magazines")
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>   drivers/iommu/iova.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index b710e5ad37e2..0e8ea04b824f 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -984,6 +984,8 @@ int iova_cache_get(void)
>   out_err:
>   	kmem_cache_destroy(iova_cache);
>   	kmem_cache_destroy(iova_magazine_cache);
> +	iova_cache = NULL;
> +	iova_magazine_cache = NULL;
>   	mutex_unlock(&iova_cache_mutex);
>   	return err;
>   }
> @@ -1001,6 +1003,8 @@ void iova_cache_put(void)
>   		cpuhp_remove_multi_state(CPUHP_IOMMU_IOVA_DEAD);
>   		kmem_cache_destroy(iova_cache);
>   		kmem_cache_destroy(iova_magazine_cache);
> +		iova_cache = NULL;
> +		iova_magazine_cache = NULL;
>   	}
>   	mutex_unlock(&iova_cache_mutex);
>   }

