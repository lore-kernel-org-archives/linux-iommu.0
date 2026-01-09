Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F070255E43
	for <iommu@lists.linux.dev>; Fri,  9 Jan 2026 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767929304; cv=none; b=FDoJsFQp74W9tmtgFx9AV9K7N/tZfvcbMt4dDUoqhC2p7WDPOVcoXB1Pzd08ltzAMUMM3f+kubcHoVAvMQtHH17SJ9oU/B8mPjcwSJmL3tD6aCBuUrGou8TNkXhxcgiGLPbw9pRgcNaRO8Pmwsnxf7mawI+5nbWHn8u5LgMNFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767929304; c=relaxed/simple;
	bh=y4tYwPF3ZC63Ir+4yC1KcSfjvehP4llbqhsh9Bjl7/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V2j3/zTV68jAMarFCXaGFjnsJscnIx6LFIB26I7QQ9hCCr5fsIhyA3gr2alxxTsX26w/wfUjITFivy8mJY4ZrG1nmpBbIuwFpc4gPcpqzq7mtxA/OWPIJ3j0EJc9CVSjTN5QIMefTdjCvHcxtYH8mpMpmZYPEkPQUlC6pkFV70o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afRkp4W6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afRkp4W6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767929303; x=1799465303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y4tYwPF3ZC63Ir+4yC1KcSfjvehP4llbqhsh9Bjl7/k=;
  b=afRkp4W6KLwUtO4TNBtROPnQx2Jbq0ixXXDnZWte4+wa5tfYGrX5uVh2
   NrvUiEEFgCB0dJt3mbACdEA9Qm04zx7zdsb1SyozuheSGL2hv6HoICpg9
   wl0oehYHHB2RbsOgblqyK/OEb5td3a5l0xyzso87epsTskbdwynMp5jCO
   hx2l74DvKO4DcpMS/j+xYE6eHcFglu995vpCazax1oE8hncwmP/BX9hd2
   0tcu8Cf3RP8bW2tWbIFAPsI3V1nQXvb4y7JxNNLstaRX7oFUqvB2OXAu1
   XOQxJjxTSBf7NYNlLqUpXG8sTkhT2v4Qz2Rsmlwm0SeeOBCAOSWyvNYOc
   A==;
X-CSE-ConnectionGUID: xYUgZnj9TQmei3apmacopw==
X-CSE-MsgGUID: EAnfHz4hQEyqc7HZNKeRJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69296285"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="69296285"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 19:28:23 -0800
X-CSE-ConnectionGUID: 2d2ZBL/rTb2r1726moL31A==
X-CSE-MsgGUID: A7Och2SKQ2eaTHkkLOcU4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="234075920"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 19:28:18 -0800
Message-ID: <d6236413-7385-45c5-94ad-8b0f2007f1ac@linux.intel.com>
Date: Fri, 9 Jan 2026 11:28:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] iommu: debug-pagealloc: Track IOMMU pages
To: Mostafa Saleh <smostafa@google.com>,
 Pranjal Shrivastava <praan@google.com>
Cc: linux-mm@kvack.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, corbet@lwn.net, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, akpm@linux-foundation.org, vbabka@suse.cz,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, rppt@kernel.org, xiaqinxin@huawei.com,
 rdunlap@infradead.org
References: <20260106162200.2223655-1-smostafa@google.com>
 <20260106162200.2223655-4-smostafa@google.com> <aV56BWisUQTMK2Gk@google.com>
 <aV-PvBqQ0Ktiha8e@google.com>
 <CAFgf54o4Ja7jQwxo6XyW+JaT+aUuj3O2dvLqOTb+YSVCKTdvyQ@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAFgf54o4Ja7jQwxo6XyW+JaT+aUuj3O2dvLqOTb+YSVCKTdvyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/8/26 19:33, Mostafa Saleh wrote:
> I have this, it should have the same effect + a WARN, I will include
> it in the new version
> 
> diff --git a/drivers/iommu/iommu-debug-pagealloc.c
> b/drivers/iommu/iommu-debug-pagealloc.c
> index 5353417e64f9..64ec0795fe4c 100644
> --- a/drivers/iommu/iommu-debug-pagealloc.c
> +++ b/drivers/iommu/iommu-debug-pagealloc.c
> @@ -146,16 +146,12 @@ void __iommu_debug_unmap_end(struct iommu_domain *domain,
>          if (unmapped == size)
>                  return;
> 
> -       /*
> -        * If unmap failed, re-increment the refcount, but if it unmapped
> -        * larger size, decrement the extra part.
> -        */
> +       /* If unmap failed, re-increment the refcount. */
>          if (unmapped < size)
>                  __iommu_debug_update_iova(domain, iova + unmapped,
>                                            size - unmapped, true);
>          else
> -               __iommu_debug_update_iova(domain, iova + size,
> -                                         unmapped - size, false);
> +               WARN_ONCE(1, "iommu: unmap larger than requested is
> not supported in debug_pagealloc\n");
>   }
> 
>   void iommu_debug_init(void)

How aobut

	if ((unmapped == size) || WARN_ON_ONCE(unmapped > size))
		return;

	/* If unmap failed, re-increment the refcount. */
	__iommu_debug_update_iova(domain, iova + unmapped, size - unmapped, true);

?

Thanks,
baolu
