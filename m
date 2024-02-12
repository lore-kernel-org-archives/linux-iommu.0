Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F143AA1
	for <iommu@lists.linux.dev>; Mon, 12 Feb 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770509; cv=none; b=OmBGr5A53PwdH+FIAWNAMcS17DniIia1qanWTyZvGtntI7KQ38qycCbwB20f8LgFCJrd99vgNDmY1UYzgT5I0e15uGSN2XKqo+FUFiwsod5BqOOGAQEjLtwYEdhImJnmDfnWDUeCzcW3UAV741zxE8KJEOJcsozvAaOFTCOio6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770509; c=relaxed/simple;
	bh=70Cs7ov7NoNjbFObZWdWEBGERsNBoSbDT7igOQYMoRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFqGE4NbCCywgX/qduv0a4+nFNMrP6x558ukVhbkyQSYmZJL3Fa985zOzTDYEuZAcDGmNkjMkwptmhltBDygaaK2o0BFzNU7KBOmmKfAjFko9xHYRr6oBELmZ5EuAqSsi4/WtJAqhnwA8gJXy/0GUzEi45C6Bn1ibVcWLawM3Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=zhl6oJc5; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="zhl6oJc5"
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
	by cmsmtp with ESMTPS
	id ZVy4rlreP80oiZd7Vrkoou; Mon, 12 Feb 2024 20:41:42 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id Zd7UrbGeRb248Zd7Vrkhzb; Mon, 12 Feb 2024 20:41:41 +0000
X-Authority-Analysis: v=2.4 cv=CK+JXgrD c=1 sm=1 tr=0 ts=65ca8285
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=VhncohosazJxI00KdYJ/5A==:17
 a=IkcTkHD0fZMA:10 a=k7vzHIieQBIA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=7YfXLusrAAAA:8 a=twS1si07rgy1n0NQfEIA:9 a=QEXdDO2ut3YA:10
 a=9cHFzqQdt-sA:10 a=PUnBvhIW4WwA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=SLz71HocmBbuEhFRYD3r:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=g8WgyYvFBXBBBgo1I/QNHAeGuuE+z9BnEavTarLPM9k=; b=zhl6oJc5gO0wT4sO9VwHZu1bvK
	5Ibo/tsf1dUH/iwg6SVWrJrIBH5EbxUKD92wnCdBRSTYQN8KojIVzJxUA/dEo9K+kvr+3p786I2I3
	/s+j6AAKOqnaAUH2xM7ECwXiDj7ESDU6d0CVjkrBWtdSAgFfRQgaXeQv6CS8hYm4P1guh02py00LI
	HbvFeGk1ubVimzUKao+h0ABigZiIRiaNssDv/3cxVRsr8S7e3aUZDCz5g7HY5GCnS+59eDcociH/s
	aMFrrKMWxLFs4u1QPlQCJtEpq0R7BUbUGLzGcbi+w4yBv9dI/eOo0Id7BFHL9dDSETjNiA+0BWl/2
	/clN8iJg==;
Received: from [201.172.172.225] (port=34544 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rZd7T-000F5z-32;
	Mon, 12 Feb 2024 14:41:39 -0600
Message-ID: <b66caca8-a8d8-4081-b462-92a95a7fa830@embeddedor.com>
Date: Mon, 12 Feb 2024 14:41:38 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Use kcalloc() instead of kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <keescook@chromium.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240211175143.9229-1-erick.archer@gmx.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20240211175143.9229-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.172.225
X-Source-L: No
X-Exim-ID: 1rZd7T-000F5z-32
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.172.225]:34544
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDdTQf/fn9p9tqc1xnFhSdNyztnL9mc3zh4jx2jgxSdFkQ4IZ4QR0aNKQkw99sZzXdnDElpwNmeRIUR1czD0LC6l0iakWDWe8QyJA4AsOXG3OCBx4PkL
 Lcq5Aq8+sICvd0WEmy75KyNkffygNb0NY1NqR9yCR+B5Tb9NJ6fGszpCvxUBpBhnPanEhtv80rmhpj24FUD2/rOcFgwdleI6Cvw=



On 2/11/24 11:51, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1].
> 
> Here the multiplication is obviously safe because DMAR_LATENCY_NUM
> is the number of latency types defined in the "latency_type" enum.
> 
> enum latency_type {
> 	DMAR_LATENCY_INV_IOTLB = 0,
> 	DMAR_LATENCY_INV_DEVTLB,
> 	DMAR_LATENCY_INV_IEC,
> 	DMAR_LATENCY_PRQ,
> 	DMAR_LATENCY_NUM
> };
> 
> However, using kcalloc() is more appropriate [2] and improves
> readability. This patch has no effect on runtime behavior.
> 
> Link: https://github.com/KSPP/linux/issues/162 [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

LGTM:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   drivers/iommu/intel/perf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
> index 94ee70ac38e3..adc4de6bbd88 100644
> --- a/drivers/iommu/intel/perf.c
> +++ b/drivers/iommu/intel/perf.c
> @@ -33,7 +33,7 @@ int dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
> 
>   	spin_lock_irqsave(&latency_lock, flags);
>   	if (!iommu->perf_statistic) {
> -		iommu->perf_statistic = kzalloc(sizeof(*lstat) * DMAR_LATENCY_NUM,
> +		iommu->perf_statistic = kcalloc(DMAR_LATENCY_NUM, sizeof(*lstat),
>   						GFP_ATOMIC);
>   		if (!iommu->perf_statistic) {
>   			ret = -ENOMEM;
> --
> 2.25.1
> 
> 
