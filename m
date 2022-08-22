Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D6E4C6C
	for <iommu@lists.linux.dev>; Mon, 22 Aug 2022 23:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661210738; x=1692746738;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=P3zN1Gd9BytgDfRPNsJA/SKlYpoKj+jVmmRQteZBSYE=;
  b=AQm2bUr4xMpM2EbSwvrGlG68E0qHnFH4xALbzoLwV2zgOVTRxAOwPHtc
   Je0KgQ6jd0DceNFJn3c95a2M4CFAaOrwp6dOFqtZ369d7VO8XS2mFj9sH
   bZgDLspmKuCdGslzcVwXMGa8ARcxASKEPHnIWw6gxI6dojg0Jnp93t0o5
   JAmwtcKdpScBxVRvUYNZpH9k/COz3OfEqC9POYSC0wga38hJGF4aYxVwO
   rbLUn+hqkiiOIRloe6J0TVqLyAVlb9Y/ui3Kd2oaxu53L2NQqCebJ9E0L
   HEMEGwIJuyrN+ifaIvDJBmpE4b9P5EAF30YDBwJ0aYKaPbfUZPIPfn0h3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="292287050"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="292287050"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:25:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751470848"
Received: from jcsarker-mobl.amr.corp.intel.com (HELO [10.212.204.203]) ([10.212.204.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 16:25:36 -0700
Message-ID: <3bfa9a4b-d09a-bb23-f66c-55166350c6f0@intel.com>
Date: Mon, 22 Aug 2022 16:25:36 -0700
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
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
 x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
 <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
 <09bccb93-2c0e-4962-0c46-c84c22fa140d@intel.com>
 <20220822162454.490ad1f2@jacob-builder>
From: Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220822162454.490ad1f2@jacob-builder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/22/22 16:24, Jacob Pan wrote:
> Sounds good. I thought about a helper also, thinking there are so many other
> cpu_has(X86_FEATURE_PTI) checks already :)

Yes, but almost all of those are in PTI-#ifdef'd code already.
