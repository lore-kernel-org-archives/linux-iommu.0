Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882585;
	b=iGT/KZ5c8Epl4RM/z7VStnu4jFc4e0PV1bo1hJVlRhhn0MNWdP2aQZCRg5+Fr5gzc3Jm
	 cxTr1aeBkq78nfsyF+57LtrIqhtm4WQ004c2yjsXMNec28Kd6m0Q+9CFMaGGUe2r+B4Cn
	 LB+XWsJSv39m2kruB3R4Rf1NOR4zhyNGzg9obXHKm/yiH3/Z2k7gW3YMOyCaO6WqMISVD
	 YJo2lUrpCP+AH4o2JbIypM6IguTTYlt8jOL2STvOeZe0Ezd8Qc0+z8v2V6j5lM2sXFo/t
	 CigrPf6LITCjhupQ+Gc7t5jC+DNrQ53doBouC0wcXRES4mP99VLhfv5CWMyJZS56YuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882585;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=4aa33zmn0/LsYRR3Lwsj0J+lh7ZAiwzA90QRHu2kPf4=;
	b=48QC0ZRZSTSNDvQTxoT2/oy4CVmbvfzF82vBUFQEZN8NrkncWyW0NLDLDHPMYSNg19jM
	 e1vE83lOAmD1CgOrQU873u3UuVtO29yb3XDzrLHl37c6y0zoTxCebbVMZFWdNrBOIDVJE
	 wSK5+RSXhJj9pzKMlWBxJODZTJEISR5tBrJB6VJOGMPfsXdGSgAAAUdLJqfgzb4dbD6Bh
	 iv8THsdChuwMXHUjjrETfCvoulyz//D67Iq4/TQL+s5PuIjnqniUJ5fJligY3bjqtFCKs
	 vc8I8Mrpu+NIpgo2v6+UTEhuenSoByFJjjXPmfoD6rehvy9S7qvpjUWuolZebanTEWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XeZGaBVT;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56D4606A323
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 02:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E56D4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XeZGaBVT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794882585; x=1826418585;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2ZW1fo/wT9YBn3H0pQjxLNsIi0ZgOfFQrdKWxULCaVE=;
  b=XeZGaBVTXS63jxO0IiFmPXVW009kDvXmj4JPVtTkANxkuzkAvRX1QlSI
   uJzrp6NcFVjhVZh2B65OpNZpqEzH2asjIdXUPld+OWxgOmIx2LE1M2Fo/
   o5EED/yuodcf9woQBzK4xn8Oj/DPJID1KqA8BZ03sz4aEJaTxFPyBOPjR
   r6fhBYWKRALEksYI90iLW7h1Bzlx6kLmb+cqwjsYlIzmmp62lsoHcj5eN
   Ul675QVj2tVUgxCyhHxPWbZcPQfn1RtOHePaiLl2J/MmbVRWL/qCEf4AC
   F7myyP0f96C/QEnbcRlePi61HCU+5YaW+o9eqigIehs8JCe1lVpqRjeOr
   g==;
X-CSE-ConnectionGUID: w73Cibi4QAScY2NejU1vNA==
X-CSE-MsgGUID: 1aQqY8vZSqSy7KsYYWsD4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3718663"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3718663"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 18:29:45 -0800
X-CSE-ConnectionGUID: 4wxTypuSToG5eKpXyEilvg==
X-CSE-MsgGUID: 0VVikp2gQcG2tO5Xky8qrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9747442"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 18:29:40 -0800
Message-ID: <0a38ae25-3eac-42f6-862e-3dc1d644ab97@linux.intel.com>
Date: Tue, 17 Nov 2026 10:29:37 +0800
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
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 12/18] iommu: Restore and reattach preserved domains to
 devices
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-13-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261110040828.1774343-13-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
> During default domain setup, restore the preserved domains by restoring
> the page tables using restore() iommupt op. Associated the restored
> domain with the iommu group of the preserved device, and reattach the
> domain to the device.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/iommu.c            | 115 +++++++++++++++++++++++++++++--
>   drivers/iommu/liveupdate.c       | 106 ++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h |  39 +++++++++++
>   3 files changed, 253 insertions(+), 7 deletions(-)

[...]

> +
> +/**
> + * iommu_restore_domain() - Restore a preserved domain for a device
> + * @dev: Target device
> + * @ser: Serialized device state
> + *
> + * Restores or reuses a restored preserved domain for @dev from serialized state
> + * @ser.
> + *
> + * Return: Restored iommu_domain pointer, or ERR_PTR.
> + */
> +struct iommu_domain *iommu_restore_domain(struct device *dev,
> +					  struct iommu_device_ser *ser)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_domain *domain;
> +	struct pt_iommu *pt;
> +	int ret;
> +
> +	ret = iommu_liveupdate_flb_get_incoming(&flb_obj);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	mutex_lock(&flb_obj->lock);
> +
> +	/* Preserved device should have a preserved domain */
> +	if (!ser->attachment.domain_phys) {
> +		domain = ERR_PTR(-EINVAL);
> +		goto out;
> +	}
> +
> +	domain_ser = phys_to_virt(ser->attachment.domain_phys);
> +	if (domain_ser->restored_domain) {
> +		domain = domain_ser->restored_domain;
> +		goto out;
> +	}
> +
> +	domain_ser->hdr.flags |= IOMMU_SER_FLAG_INCOMING;
> +	domain = iommu_paging_domain_alloc(dev);

Ah, here it is.

This allocation uses the driver's default. For VT-d, it prefers first-
stage translation when supported. But the preserved domain may be
second-stage, for example if it was allocated for dirty tracking or
nested parent. Would the restore callback then walk the preserved page
table using the wrong format-specific operations?

> +	if (IS_ERR(domain))
> +		goto out;
> +
> +	pt = iommupt_from_domain(domain);
> +	if (!pt) {
> +		iommu_domain_free(domain);
> +		domain = ERR_PTR(-EOPNOTSUPP);
> +		goto out;
> +	}
> +
> +	ret = pt->ops->restore(pt, domain_ser);
> +	if (ret) {
> +		iommu_domain_free(domain);
> +		domain = ERR_PTR(ret);
> +		goto out;
> +	}
> +
> +	domain->domain_ser = domain_ser;
> +	domain_ser->restored_domain = domain;
> +
> +out:
> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return domain;
> +}
> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index fb1e8efac8ec..68c7ebca25f6 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h
> @@ -99,8 +99,31 @@ static inline void *dev_iommu_restored_state(struct device *dev)
>   	return NULL;
>   }
>   
Thanks,
baolu
