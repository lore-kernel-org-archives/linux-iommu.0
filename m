Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DB3180
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 00:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674174449; x=1705710449;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RaIhrk8EZ9LTPDYkzu87WS+yeMpipgyZuC05/+fP5JM=;
  b=Z1JPx3fI0qF2CJY2zyVgpfxaKgokRg+BjO3oiY2swPpKX+KwWsw/nk5x
   p/Dvoqy58ZXpOenrWjDM879ouBLpMh23pZp7HXvunS1q4aZy/3zqRIaz6
   7YeqiJR6Aw5iQSY7ljcC/dBTbw3fPBApJG0HYzxwzBXNZvABLmqjI0CGA
   4p2L8xi8MzNn0++ZCSnJ3KArG4jkn3PLS0rC/CSxRB/IdjCHrH8/K/C+F
   y3DN1nTPlW28GSpT0+P7lnURdwGF+whc311dPYaR1ZYluLu5Wa9Q0CHUf
   mcrFUFZ0M7lP8YcPw5yr6qQN3l20a0RJgaJSZYQa4XtazRc4mpPpDJChH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="309048687"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="309048687"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 16:27:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="662345168"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="662345168"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.184.51]) ([10.252.184.51])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 16:27:11 -0800
Message-ID: <d798bc7b-a87a-26b2-17e0-48e9c7715abc@linux.intel.com>
Date: Fri, 20 Jan 2023 08:27:08 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc: baolu.lu@linux.intel.com, hch@lst.de, jgg@nvidia.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6/8] iommu: Retire bus ops
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1673978700.git.robin.murphy@arm.com>
 <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a2db51f8f417bbe0032e2c4231579f8c4ce9a089.1673978700.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/1/20 3:18, Robin Murphy wrote:
> +	/*
> +	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
> +	 * instances with non-NULL fwnodes, and client devices should have been
> +	 * identified with a fwspec by this point. For Intel/AMD/s390/PAMU we
> +	 * can assume a single active driver with global ops, and so grab those
> +	 * from any registered instance, cheekily co-opting the same mechanism.
> +	 */
> +	fwspec = dev_iommu_fwspec_get(dev);
> +	if (fwspec && fwspec->ops)
> +		ops = fwspec->ops;
> +	else
> +		ops = iommu_ops_from_fwnode(NULL);

I'm imagining if Intel/AMD/s390 drivers need to give up global ops.
Is there any way to allow them to make such conversion? I am just
thinking about whether this is a hard limitation for these drivers.

Best regards,
baolu
