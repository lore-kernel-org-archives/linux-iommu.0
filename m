Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B15663D6
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 18:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669054538; x=1700590538;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=xX4/g0oio96LX1HY5otdCTZt6qmKzdQZbF++Ebk/k10=;
  b=KuAHObFMefHByW8DqVfpJTsnCWQJArrB8BPfn4CO6tv6EifFixaPiiwC
   p9vcFzj6acPUYJqait4SwOZq51hwLSw7+4anvqT4iJfL41fk9q7sFhlVF
   D48BJw7CCeGJHb1gp/Db6MZCvLSqidydahGiiGDMHHMZ9h/BF3HFRfEcf
   TL3rY1NC/MqQ+Polsvr2f5dachg8hQ1F4ULz9dKKX48OCC1XwmHIIjYt0
   wY5NsUYWehjBEyj62TwJ+r4CPfWsMPK9LFn/y7yB7uiVSm/HKqjTyONE1
   yWxckocSGTfxCBkMs67M+aEA7Sx9/midqCwC5ny2cKI1lhT9uYvP6P5kT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="313658359"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="313658359"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 10:14:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="709905335"
X-IronPort-AV: E=Sophos;i="5.96,182,1665471600"; 
   d="scan'208";a="709905335"
Received: from ticela-or-327.amr.corp.intel.com (HELO [10.209.6.63]) ([10.209.6.63])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 10:14:28 -0800
Message-ID: <e5f9529f-955c-fc28-5d46-c77f23a71d04@intel.com>
Date: Mon, 21 Nov 2022 10:14:27 -0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [Patch v3 01/14] x86/ioremap: Fix page aligned size calculation
 in __ioremap_caller()
Content-Language: en-US
To: Michael Kelley <mikelley@microsoft.com>, hpa@zytor.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, luto@kernel.org, peterz@infradead.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
 bhelgaas@google.com, arnd@arndb.de, hch@infradead.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com, thomas.lendacky@amd.com,
 brijesh.singh@amd.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, Tianyu.Lan@microsoft.com,
 kirill.shutemov@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 ak@linux.intel.com, isaku.yamahata@intel.com, dan.j.williams@intel.com,
 jane.chu@oracle.com, seanjc@google.com, tony.luck@intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev
References: <1668624097-14884-1-git-send-email-mikelley@microsoft.com>
 <1668624097-14884-2-git-send-email-mikelley@microsoft.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1668624097-14884-2-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/16/22 10:41, Michael Kelley wrote:
> Current code re-calculates the size after aligning the starting and
> ending physical addresses on a page boundary. But the re-calculation
> also embeds the masking of high order bits that exceed the size of
> the physical address space (via PHYSICAL_PAGE_MASK). If the masking
> removes any high order bits, the size calculation results in a huge
> value that is likely to immediately fail.
> 
> Fix this by re-calculating the page-aligned size first. Then mask any
> high order bits using PHYSICAL_PAGE_MASK.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Looks good:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

Although I do agree with Boris that this superficially looks like
something that's important to backport.  It would be best to either beef
up the changelog to explain why that's not the case, or to treat this as
an actual fix and submit separately.
