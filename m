Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C25375
	for <iommu@lists.linux.dev>; Fri, 18 Aug 2023 01:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692321818; x=1723857818;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wq92PvLflxstlVH6JDii+UZnycqNrlpgrgbBGqunPMs=;
  b=fkUWQx8Qdbhblg4Mv8yJlWz1Pe4mna4PyTZHmF2R0YbIXdUlXKGLbcpM
   QyeTlXKME7nUcii2dcFCZFBsESIPKZjSvzvnlMwb01zvlFn0wp31/BANw
   fN4046RyPFLCyi/GBgxQGHRHRu6F8q5My2pDMboaAltSXJh1vD0SzM4oU
   qlliBnzbyEMpcfKIhMvHpS6EG9NmBFTuAfMMQjHsqr+rFNzJ3oKdhKlpg
   ruCJ0qaaxdTrrC/kTA9lWK4YjV5V+RITrWNRecub7FJm5Gk+ww/Npukaq
   C/CUKPa6a9N8aJZ86WTgimuF1jA/3AyO1bLQtBmL0tAu/cWtWyaSGYASA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363141995"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363141995"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 18:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728401389"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="728401389"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.185.113]) ([10.252.185.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 18:23:36 -0700
Message-ID: <fdc6b5fc-0e26-965d-ae53-fd4a0f87d1ea@linux.intel.com>
Date: Fri, 18 Aug 2023 09:23:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc: baolu.lu@linux.intel.com
Subject: Re: Software bounce buffers Vs allocating DMA buffers in page
 granularity
To: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>,
 iommu@lists.linux.dev
References: <CAD7mqrygN8W59SmeS2nEVppNVeoW3FsiVtOG_PH7fcV4C16YEg@mail.gmail.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CAD7mqrygN8W59SmeS2nEVppNVeoW3FsiVtOG_PH7fcV4C16YEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/8/18 4:17, Chathura Rajapaksha wrote:
> Hi All,
> 
> I have a question regarding the IOMMU software bounce buffer feature.
> I understand that this feature was introduced as a mitigation to
> sub-page vulnerabilities (which were shown to be exploitable by
> Thunderclap).
> 
> My question is:
> Can allocating DMA buffers in page granularity (multiples of 4KB pages)
> be a feasible alternative solution to software bounce buffers?

Yes. I remember that we skip software bounce buffer if the buffer size
is one or multiple PAGE_SIZE(s). Any change during recent evolution?

Best regards,
baolu
