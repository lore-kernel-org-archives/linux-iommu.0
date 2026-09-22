Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EC740A92B
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099323; cv=none; b=QqQ0S8Uk3svf1wD8VU/xYD6uSuX7u0aM9fJ7lvy0IT9COB5BlK767KzDjTJ14rGfyzvjwz6uQlEPzC4+lNaQr2Xx3oglnb/lf+6Uvw8TkA+U6jF3EnhjlFfPUHnD3kSgw1+MQoDuKQhG0lR09up1/vtc7YrY1N8z7N8iyDq0mGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099323; c=relaxed/simple;
	bh=hROc+a0Vg2NgIOCzGL4hJedwPNiwG4QC1dmVhkMm/BQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lT+h3esbPrUoEIgvPb36Q6SMv2IZUVWNvKy0ht7UF1t8zHW8jcaQpGMbLDT5r2CELpld8/u4nkk2qmvFwLOVJkXjMSGfD/gag+YWK5Lo8EA0KBx78IVYUFqu+aVCG2nvvxQOwacetvEEeHVIiRi3sLxoWzagKv3yj9rhhzS4Vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MRGlkqCz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MRGlkqCz"
Received: from [100.64.33.11] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1055D20B7167;
	Tue, 22 Sep 2026 10:47:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1055D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790099273;
	bh=eaOnYQxE8z2ZJvsby/FJ6ww5rwVyjRrp/amSfAq2Pa0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MRGlkqCzcgIO7WmhjMdMJPX9S273nVQbqtNV+dTeqafhXD9sUabDkd3Cz+2RDHgfB
	 eRFlRx1/vfwU9zR/tMzoXGawKnS2sojdomUC59f1RPKFl4j5wEU/TUDv4e2M0viSJY
	 u1CYi0tSztY1bj9JJKmum+GolcR6hph/cYcXMaFs=
Message-ID: <5aaddb48-3061-4a4c-a081-67befa955143@linux.microsoft.com>
Date: Tue, 22 Sep 2026 10:48:40 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V0 1/3] PCI: hv: Export hv_build_devid_type_pci() and
 change return type
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260921225028.4007330-1-mrathor@linux.microsoft.com>
 <20260921225028.4007330-2-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260921225028.4007330-2-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/2026 15:50, Mukesh R wrote:
> On Hyper-V, most hypercalls related to device domain management like
> attach device to a device domain, or to map/unmap regions, interrupts,
> etc need a device ID as a parameter. So, make hv_build_devid_type_pci()
> public and change return type to u64 to enforce it's size.

Nit: it's -> its

> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c     | 9 +++++----
>  arch/x86/include/asm/mshyperv.h | 6 ++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
No other feedback than the Sashiko review, so assuming that's fixed:

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
