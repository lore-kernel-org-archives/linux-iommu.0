Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6304A3E
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 12:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668427249; x=1699963249;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PojqU7cW3j5r69duzZm+JxZz9bwdlVJ83nNetoIqbf8=;
  b=EFUMBkpm/xIKsNs0g+f4JaJK6AGN+Um2uX/SaBQuK4fIAuaOqHzZeTOv
   wCKalI+hbch/UOIMuy1x42osBc3iKf1KX+c6G9REqhQfnlJGpORcpmlVg
   k+sGsiNUuX52OfejT485KSpJwcjkqCF3XzVJ17/fINxX45fo/rR36q74n
   jDi47KcJpiWLWSpoy68L25T0xYGcz0zju09PSFbPpzqxZdNeWozSD5Va7
   90aXPnhqMHSaShLRzZsrC6aTCtT6Nym/v2cu178OXhzQOiMkcRqlZ4L27
   Ln2GMhxTK7+BYqna7+q6SGOCb2E4Y7i7dNt8OaYDwWBNUmmwXHq7TqGFY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="311954809"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="311954809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 04:00:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="669624456"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="669624456"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.50]) ([10.254.212.50])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 04:00:46 -0800
Message-ID: <6a34aa78-17d2-bb44-1e50-76239cd1ffbb@linux.intel.com>
Date: Mon, 14 Nov 2022 20:00:44 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Cc: baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Set SRE bit when hardware has SRS cap
To: Tina Zhang <tina.zhang@intel.com>, iommu@lists.linux.dev
References: <20221114085514.1105039-1-tina.zhang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20221114085514.1105039-1-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022/11/14 16:55, Tina Zhang wrote:
> SRS cap is the hardware cap telling if the hardware IOMMU can support
> requests seeking supervisor privilege or not. SRE bit in scalable-mode
> PASID table entry is treated as Reserved(0) for implementation not
> supporting SRS cap.
> 
> Checking SRS cap before setting SRE bit can avoid the non-recoverable
> fault of "Non-zero reserved field set in PASID Table Entry" caused by
> setting SRE bit while there is no SRS cap support.
> 
> Currently, both intel_pasid_setup_first_level() and
> intel_pasid_setup_second_level() implicitly take care about of it. The
> only missing SRS cap checking is in intel_pasid_setup_pass_through().
> 
> Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table interface")
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>

Nice catch! Tina.

Can you please double check  intel_pasid_setup_second_level()? Its seems
that we missed such check there as well.

Best regards,
baolu
