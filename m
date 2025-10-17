Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F05B6FC5
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760665562; cv=none; b=Dc7UD9y5t9XMPZbxHqhedaQBkreVWKYiAB1MmBLfbLnh05/lg55I8KMHrSGvgW8Ev4xLW6N/rrwjUVCAYvnFKonBs0W5jahEoEIoMoFm2UP+10ms+gPXdnp3im6PovLgwT73D6Lib7ZL4CquVE9PKTw0dMmGGGMNvgrYKsJHwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760665562; c=relaxed/simple;
	bh=STs8Y+GLuT3+amxLmUST+PZ8gj8KTQE9Glui5npCtTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOqCS5Z8zxYhD0jp/Sn1ameQwYkhQbuacaxm2eNwKn4gPeGGMOH9/cLBstgJpt3Pj8I0BgllZ3Nq2bQAAJo+EDQal/PNcd0dfAJMUUYmAsL/0xVgjdT8sj0kX7iZhnAdki35l2KjlhMKUDimjmxNMAsKJaQJi7UD3b//U0TIS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IR9yqRnz; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IR9yqRnz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760665561; x=1792201561;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=STs8Y+GLuT3+amxLmUST+PZ8gj8KTQE9Glui5npCtTo=;
  b=IR9yqRnz61Owh8NijBgxhAhWaP7x7jfOh2q6fgJoM+jOkPSxvdG9toV7
   PbdulIOe68jRoJFkT0X/CK/8Ly/Kh5e9G3YJZFBuA6NupDPSa47/YHs+1
   OLFuqjFrZuf5VnHZgwBsT66LaD67C4WjY7Gb1ZcIxp7ZQKtLspoWs0eih
   8l/6h3QvZZL4H4xVJh37PceTOmVod8/rtC8XYwehZac6bx9CMkGJXXzst
   NEgFioymZiZsouTNd83HZgLcwUNaicDC4hxh1BEZdKxyN2XZ+AOJoTZBB
   l/fPVksuxSiB25OqNOA9WZPJtiJ9s8fT2kS7mqfdj/arxL0Xoe/VJcAi3
   g==;
X-CSE-ConnectionGUID: TplEv2DmS/uE/jWrXI+mKQ==
X-CSE-MsgGUID: F2Rs7zoxS/6ALhsQCdCBtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="62082053"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="62082053"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 18:46:00 -0700
X-CSE-ConnectionGUID: VLbXrEyqS+mO5QoMlH6F3Q==
X-CSE-MsgGUID: YKaojFyXR1qwVxffdSsIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="181744500"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 18:45:54 -0700
Message-ID: <11cad2be-9402-4d45-8d2b-c92d8962edfc@linux.intel.com>
Date: Fri, 17 Oct 2025 09:42:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Fix stale IOTLB entries for kernel address space
To: Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Alistair Popple <apopple@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
 <6b187b20-6017-4f85-93ac-529d5df33aa2@linux.intel.com>
 <ecee3200-c8e2-47ec-a219-c88e8e905b32@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ecee3200-c8e2-47ec-a219-c88e8e905b32@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/25 23:55, Dave Hansen wrote:
>>> Only [7/7] has acc:stable, even though that patch is not at all
>>> backportable.  Please give some thought and suggestions regarding
>>> whether you think we should backport this into earlier kernels.
>> Yes. We should backport this series to stable kernels.
>>
>>> If "yes" then the size and scope of the series looks problematic.  Is
>>> it possible to put together something simple and expedient just to plug
>>> the hole in older kernels?
>> Squashing some patches is one way. But would it be workable to backport
>> this series manually? Say, could we send a pull request to the stable
>> mailing list after this series has landed?
> I honestly think we should just disable SVA in old kernels at compile
> time, or at least default it to be disabled at runtime. That's the
> simplest thing.
> 
> The other alternative is to have arch_vmap_pmd_supported() return false
> when SVA is active, or maybe when it's supported on the platform.
> 
> Either of those are 10-ish lines of code and easy to backport.

Hi iommu folks, any insights on this?

Thanks,
baolu
