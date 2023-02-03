Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B9CED9
	for <iommu@lists.linux.dev>; Fri,  3 Feb 2023 02:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675392705; x=1706928705;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UxeZ8FJwNzkiSv+FCcjHMP+ssabzgfr3PcMLKiBT6p0=;
  b=WTtTHnc4Iyd5y1FWOzWjW8o2fqGDG0DwHnj/sCgYtlbcsqpRMrklqY08
   Kg5rxnbgcrAjYKs3qY9NPYh+vqPa40MWiHog4vU4fMNZh5o6zloThN5A1
   hO5YpD4JCB+F87ccIKQfqp0SCOX+FoVJYfnDwIGRM7vLwI/65iUwfiSCQ
   Tb2P1jpDehG3aBDW0IEGyvYOFV70c6PBCxS64UdBBLxI9nlUbiq1s8p/3
   QCTMShQYagh8KJsayZCNglOjt93HKEZaqb5taDkYmE1UTNRsbR3NBrNnR
   3Ivay3NHweWfdZeA3zHdiLdVXBtiY/kANh28GLDthssmho54U9gDvTUPA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="414851309"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="414851309"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 18:51:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="615547679"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="615547679"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.253]) ([10.254.208.253])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 18:51:35 -0800
Message-ID: <018498d7-d966-6c87-d829-50270565147d@linux.intel.com>
Date: Fri, 3 Feb 2023 10:51:33 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, corbet@lwn.net, will@kernel.org,
 boqun.feng@gmail.com, mark.rutland@arm.com, catalin.marinas@arm.com,
 dennis@kernel.org, tj@kernel.org, cl@linux.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org,
 Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>,
 davem@davemloft.net, penberg@kernel.org, rientjes@google.com,
 iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
 vbabka@suse.cz, roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 07/10] x86,intel_iommu: Replace cmpxchg_double()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>, torvalds@linux-foundation.org
References: <20230202145030.223740842@infradead.org>
 <20230202152655.624998774@infradead.org>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230202152655.624998774@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/2/2 22:50, Peter Zijlstra wrote:
> Signed-off-by: Peter Zijlstra (Intel)<peterz@infradead.org>
> ---
>   drivers/iommu/intel/irq_remapping.c |    8 --
>   include/linux/dmar.h                |  125 +++++++++++++++++++-----------------
>   2 files changed, 68 insertions(+), 65 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
