Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880004;
	b=1prNTIQkp+KIterYumGi8vZIWcJFVIB/NpUkDTJnOUYnOeqlXDWwxxO2+IhWENbDj2F8
	 PTtftYIoc23wKkKXZz/lv+5CgatsiIcd314ZfY+O1vxMFTr1D7payGXy5ttrHkQd0j0DL
	 1P7wnNLo/faMshFNpjTs/VomHorPskijIn2YHYPjDJBXCRkDYgBVR4l813AxsTT44ZHf+
	 GAl+lKVHdbN3JKEPENdQg5heBi9NqeRnjtzm4trUSimVsAIBSfSg2hn9KKNed3qCxmYcs
	 nn+zjwOqXOFdv/Npsg1cRgjPBOdFp125ztSdKNNCqNydYYZFmKHzScIMjT1fdD0+8FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880004;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=k/EkrvzyMPcB7+7XB0j5UOtYgmhfoUiE9lB743bbi6A=;
	b=ojj5+McTxSmqcrLGLhXG3rtkI6G8U/OnDlKVqjBzZagFRlv7UkyVXc40IQE4nsVjJv2E
	 PiWB+Zh0nclgRsoQ9BjjVjOHGYyNn5UvvHwKA/XDRzVLDkhS7M5yCrheaNhBUtQTdYBMP
	 O0StlHdNTktNNtuloq3vceItze35N7ZA6ofPx59KyECLfdsTuG3j7W4fzIhE+hW91Qr4b
	 F6S3U0l9lRSKaU7bAvdGAQaYqMYhl7E1QZFUTiu2DXhdFC7+HeieiYLg3dZjCunQbynA9
	 pxVoA3RPnpMbGwPIs9BbiKP2tZvLn2P9FfVUpr3BobaGoxRhGFeeK9yjpMFpfcE3lwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bhcwWzLW;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAF606A323
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 01:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39EAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bhcwWzLW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794880003; x=1826416003;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m/Sndf13hDJr8DhJxFGdx+xq/srB/KQKSVwl4mfyHgo=;
  b=bhcwWzLWKbPKicnQi360M0oSpHDtqtA0rVvEgDXYZG7sbwFCxM7KkmFg
   Vd4r9fqU34lrVZOcjlD30hEzUp37IID+atZtvZjNhWyo9EN9hkiFwhiuz
   n7Uwjp5Mq6Sg4bzhFRxCnlYpiLGR6RPU8tTXwsMoi+xhd2FzGONl106bE
   ZV3fci9UGleHbr3t8kgaHZtZ1PHa28FiWZCx9dq6AzDX9q9dIMQiSjZ4v
   13TWhCWvAFCxqIX901EUnJUVql1BkKEw0qMm3Zmi4t/0xmlBayzx6u7TY
   leUY2xBN0SKSE8JS/xhItTutqLfTgHD+KhiCGF6yvzlBEBoBc9NhAumd5
   Q==;
X-CSE-ConnectionGUID: wgRgnMiVQZaivOZjqzgssg==
X-CSE-MsgGUID: 46pWOqmiTfiNF1LMxqwDhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3716479"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3716479"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 17:46:42 -0800
X-CSE-ConnectionGUID: lFynkrW9QvOWi6zAXa36gw==
X-CSE-MsgGUID: d307Z+NnTcWuTmtop1izKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9946123"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 17:46:38 -0800
Message-ID: <05ab75bc-9630-4e62-b3be-0ada47008508@linux.intel.com>
Date: Tue, 17 Nov 2026 09:46:35 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Pranjal Shrivastava <praan@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma
 <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 08/18] iommu: Add APIs to get iommu and device
 preserved state
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-9-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261110040828.1774343-9-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
> The preserved state of the device and IOMMU needs to be fetched during
> shutdown and boot in the next kernel. Add APIs that can be used to fetch
> the preserved state of a device and IOMMU. The APIs will only be used
> during shutdown and after liveupdate so no locking needed.
> 
> Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> Reviewed-by: Pranjal Shrivastava<praan@google.com>
> ---
>   drivers/iommu/liveupdate.c       | 88 ++++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h | 70 +++++++++++++++++++++++++
>   2 files changed, 158 insertions(+)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
