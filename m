Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FD2163
	for <iommu@lists.linux.dev>; Sat, 15 Jul 2023 06:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689402482; x=1720938482;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E4dw5jTyrhJfmTFYFax04Yvl6K/d06zT/oytzRcJ5aA=;
  b=dBzLYQSYpocxIOfPM0COfDrt3GLpTipuXyCCnQmJ1L9dJyjj5XWxrz8K
   4FvxZSRjluCZnRRm4x/1oFyG+/m1etDNdgTk7h/cakkOLgsHaYCw6JvHn
   ls4CtVTpCoop3DjdvVZzAAJg8Y4F1Pzlxgwq7rEI6DOsMjkrXqB0aJIPn
   MnJ9g8QUg0MpOu2CVkwvMklxNVQjJ82n342u2nkl8w3mJgUAezcc8Lzs0
   Nro1NWUi80abYJh+kwMuhkWZK4gxmvL0phiynnpai9ulgt5it22eGmk8G
   8x2RF4tl0YgcfcHrr1WNaY17R0ggmtCiMZpkNYQkV/ib8B+Xz81QAqoOp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="345949301"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="345949301"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 23:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="812680999"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="812680999"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2023 23:27:58 -0700
Message-ID: <db554c27-f663-0146-5e5f-b319547757c3@linux.intel.com>
Date: Sat, 15 Jul 2023 14:26:10 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc: baolu.lu@linux.intel.com, opensource.kernel@vivo.com
Subject: Re: [PATCH v5] iommu: Fix an error check in tegra_smmu_debugfs_init()
Content-Language: en-US
To: Minjie Du <duminjie@vivo.com>, Thierry Reding <thierry.reding@gmail.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 "open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
 "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20230714081320.1998-1-duminjie@vivo.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230714081320.1998-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/23 4:13 PM, Minjie Du wrote:
> debugfs_create_dir() function returns an error value(PTR_ERR).
> We need to evaluate the return value using IS_ERR,
> rather than checking for NULL.
> 
> Fixes: d1313e7896e9 ("iommu/tegra-smmu: Add debugfs support")
> Signed-off-by: Minjie Du<duminjie@vivo.com>
> ---
> V4 -> V5: debugfs needs to have error checking, so use IS_ERR() to error check.

Why?

[...]
  * NOTE: it's expected that most callers should _ignore_ the errors 
returned
  * by this function. Other debugfs functions handle the fact that the 
"dentry"
  * passed to them could be an error and they don't crash in that case.
  * Drivers should generally work fine even if debugfs fails to init anyway.
  */
struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
{
         struct dentry *dentry = start_creating(name, parent);
         struct inode *inode;

         if (IS_ERR(dentry))
                 return dentry;

[...]

Best regards,
baolu
