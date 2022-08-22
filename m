Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD62F5D
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 22:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661207490; x=1692743490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gwgkmAh1m4dxY9h21mXik/a1rHa0oTuFFeRyk4XA4BM=;
  b=Pr0mwEuCpJOaPcrCvJU7tec0mYaQTrq0Nl6kptz6I4M2WIH5o18t6Kzc
   0TOc3tNbPXw3HEpnDj2NHSYzNplMX+lANyBC5SEWsOzopQPhaUpASbP6b
   PdLyth0XOiwNmAutRqNAGhAYnGY2L2eF9plwhnOfP+Zm1ZybYdQB/26Wj
   Xan17p2YFR4G9WrwIgzVnY5ktoqeebLk6qgV2ecx1L4FpJIgtTgjSKBA2
   icLXmboPyyEOsuV1fgkxfo4hH8xN5FAagbRPZf7lUDtuYTBAJl/HeP7hD
   JJVEq8AZUtfkPnvwu+KtBq/BIhsg4wCv4I/JyLq2Yu+/TCUE2i5IDKXNR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355266573"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="355266573"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:31:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751455019"
Received: from jcsarker-mobl.amr.corp.intel.com (HELO [10.212.204.203]) ([10.212.204.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:31:21 -0700
Message-ID: <09bccb93-2c0e-4962-0c46-c84c22fa140d@intel.com>
Date: Mon, 22 Aug 2022 15:31:20 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] iommu: Use the user PGD for SVA if PTI is enabled
Content-Language: en-US
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev, x86@kernel.org,
 Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: Raj Ashok <ashok.raj@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
 <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/22 13:12, Jacob Pan wrote:
> @@ -394,7 +395,9 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>  	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
>  			PASID_FLAG_SUPERVISOR_MODE : 0;
>  	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
> -	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
> +
> +	pgd = static_cpu_has(X86_FEATURE_PTI) ? kernel_to_user_pgdp(mm->pgd) : mm->pgd;
> +	ret = intel_pasid_setup_first_level(iommu, dev, pgd, mm->pasid,
>  					    FLPT_DEFAULT_DID, sflags);

This X86_FEATURE_PTI should really be done within a helper.

I'd probably do this with a *new* helper since all of the existing
kernel_to_user_pgdp() users seem to be within a PTI #ifdef.

Maybe something like:

pgd_t *mm_user_pgd(struct mm_struct *mm)
{
#ifdef CONFIG_PAGE_TABLE_ISOLATION
	if (cpu_feature_enabled(X86_FEATURE_PTI))
		return kernel_to_user_pgdp(mm->pgd);
#endif
	return mm->pgd;
}

That #ifdef could even go away if your kernel_to_user_pgdp() stub from
patch 1/2 was available.  I'm not sure it's worth it though.
