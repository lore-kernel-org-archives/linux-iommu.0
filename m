Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD777C
	for <iommu@lists.linux.dev>; Wed, 21 Sep 2022 02:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663728632; x=1695264632;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UJKeT+rGrn3fh6xI+4XGfUnq9lL3lT3rg8jN+yT5b70=;
  b=bm1qx68YtZwqHvdtwUMw3DkbiDMciKI/bHWipk+8fMmjHzjCXsh2NjR4
   KtPriy15bAlRAIGt5sbh+uxk9hG6dfwK5KPJ/wfTaiXzBE8LcuS8FoJAN
   S4TasW9EeqryXR1soFh0ALQRUxTPHWP5EAp2sSRCLkZTwYBQhJqMF4+va
   jttwqyA4GnIeCD/MqZCcmjvsZmJVAVWL+agL5DhFzM6EENcuBrsNkgeGc
   GTbOG0TQfUpO0E3fUV0BZkv37MnqTNfOmpJKTvuA9Rk4KGQMD9EQzOh5C
   F2vvhbHrEo4mAUNl7fmePOKZO8Goe4Bkzc4y7xRPdpXivcWTmYVynzTBb
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="279606769"
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="279606769"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 19:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,332,1654585200"; 
   d="scan'208";a="794501084"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga005.jf.intel.com with ESMTP; 20 Sep 2022 19:50:26 -0700
Message-ID: <a5f2141a-d819-20de-1e6c-b9e93323998a@linux.intel.com>
Date: Wed, 21 Sep 2022 10:44:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, baolu.lu@intel.com,
 raghunathan.srinivasan@intel.com, iommu@lists.linux.dev, joro@8bytes.org,
 will@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu/vt-d: Check correct capability for sagaw
 determination
Content-Language: en-US
To: Yi Liu <yi.l.liu@intel.com>
References: <20220916071212.2223869-1-yi.l.liu@intel.com>
 <20220916071212.2223869-2-yi.l.liu@intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220916071212.2223869-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/22 3:12 PM, Yi Liu wrote:
> Check 5-level paging capability for 57 bits address width instead of
> checking 1GB large page capability.
> 
> Fixes: 53fc7ad6edf2 ("iommu/vt-d: Correctly calculate sagaw value of IOMMU")
> Cc:stable@vger.kernel.org
> Reported-by: Raghunathan Srinivasan<raghunathan.srinivasan@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>

Queued for v6.0. Thank you very much!

https://lore.kernel.org/linux-iommu/20220921024054.3570256-1-baolu.lu@linux.intel.com

Best regards,
baolu
