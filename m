Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156093B7B91
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778239865; cv=none; b=EpeLLzgngx5UNH4v6QYS8wYi+jHjtOJu+lj0XQNaRcz8W5567jttqjCNZEx14DhNnnU22AAiiyq67bmickSdwodybe5GoczsNc0zhOzdJbOztVClFWdyCzOMDEICyAynmfn2U9OpPX3WiJcoZO3ckHHsfw1KzlJIRnY4gyR+Zws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778239865; c=relaxed/simple;
	bh=BbxJFnwClrzpI9NJL8l2W8HPO2FxxlMcsmgLf6HUPsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9P9WhnRa1JpyU0lM9nRXODqVJUPTi/yDMhRlO4hVGKAuklLqj/MQ+a/OfKDxc0Qux7mn8QBdO4uLTF44kwjKT/w5b0MNA0ApQOahcj1xhbOppTy0NQ9Td81dTyl4/3Jwz0C15yBcjlR25KTV6aO6AF+TTBU7OL/qYQSFLS36KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OclJh7K/; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OclJh7K/"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f36da5c8fbso1820754eec.0
        for <iommu@lists.linux.dev>; Fri, 08 May 2026 04:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778239863; x=1778844663; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BbxJFnwClrzpI9NJL8l2W8HPO2FxxlMcsmgLf6HUPsA=;
        b=OclJh7K/uGBVz8cpEdabAsOIpqeYAi/nOyMGF2bqNwZI5hVcJ3nB0pebsKkVN0hISP
         zYa74mj/4lUUB94Dgc5J6VbQdq/ovgRX4CMNAoUDjdZ8yzn2r7RdfPwUci6jHSbuza0D
         YoR+qT39hSMPfC18O4AdE788PkiIWUeBEOciQGwUODoDfWB1/Wx8+oVdQIxD0N5haWlD
         jSYZVEKCTGeBc7hiZViEAIrhzTGMUt6DSeubGJVLhvkSObBg3gp8wAd2c+btB0w/LmH1
         eBC9Gon8GZG0uNdtZQ9e0UkHC6IoXRFMVShSaX3HMTOkO1fVnCFt0vwAv3f0Byi3oQ8N
         Z0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778239863; x=1778844663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbxJFnwClrzpI9NJL8l2W8HPO2FxxlMcsmgLf6HUPsA=;
        b=PFS+kNk3hR+wOi84Dub4txmw7+AimgX3BhH6eFU/z+lU4ZEJwrn+oNrsEpst/rKOag
         iWf00TQ+o1qJ6s7seECUijdpLypCh8wIKo5a3uDXvZ3LihHacZkn5KBBXxq6EF0J09p5
         x7lix07Y58waZW/doEWbSz3PXos3/6stWMGjjrNQpLUXSYJVIiAY8ZdQ3GpxEICmfcDe
         3wra+/SBelQ+Tm8SVnqRnhxBMhgt22G/ncuXtkwJTdrQ+pNDqJTFt+koeRA/3czXS9YV
         ZYx7/PPMFs6M+cPQhigT8RJxgHtA07APhB95yPtHoHlDMo3qit7oCnRC8Xg2QxewkM93
         WROQ==
X-Forwarded-Encrypted: i=1; AFNElJ/xftkLVO89Mr6tDpEoqPH7JKJt/1IX912D4cOdkea3LAvc9sVdNfEn2piZhQ0Zr8NoHVTw2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwP8eLZCsn78wzFl7aGocyWpQJ9vuLZtKiC8U+zaRyv/V94ULJk
	x8Cg8QYinoMKjlMv/IqyS7caZ4biu6CpPh845hQXIPKd/EdzNAH7O6X5y1xEheUR/tM=
X-Gm-Gg: AeBDieu5oDajnoaVUaFt6eXPkmMciYLYhzsR5JFE+iP/pdjWtFhK6H+3PzNJYvkjm9F
	4D0h3GWGzNOizlaYI7SIFwtoi6tj5Tz+cCJjgo+HHQX9XqgUCBhERo2sWx7nJUrx1d81EYheyOO
	sdTy89jkBZM5IXNvFGUsZrVtDXmbMVusnUhfs/7WPBDoLoAarqwx5sBbJJfsBA6kpjNmVkqNFLa
	pZyKA5c+Oj/fA4TaWLl/tx1hWdZL9sD3qGbAKnWrxqFasJkmIWF21GMCYaeofane8Zn6WNxuaT9
	bAR7X/NWQQH4ockIRoX5xVUYfO+i9c7fnJhZEcnNeBj6oqQ4UuT344uVBrBkLDZZF5NteybkypL
	wL684ngykyeInD9DEOwcyVbv3TmI4lr50VbJotuaW4A/XsDYDTwJHkRvclCJaqcy4oC5NNTHNnQ
	CTJL0xzKM+
X-Received: by 2002:a05:7022:1a83:b0:127:5c3d:bd95 with SMTP id a92af1059eb24-1318e919fcemr6049587c88.32.1778239862942;
        Fri, 08 May 2026 04:31:02 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm2331622c88.1.2026.05.08.04.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 04:31:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wLJQ4-000000002Qs-3y7p;
	Fri, 08 May 2026 08:31:00 -0300
Date: Fri, 8 May 2026 08:31:00 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Cc: Robin Murphy <robin.murphy@arm.com>, m.szyprowski@samsung.com,
	leon@kernel.org, kbusch@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: remove bogus test for pfn_valid from
 dma_map_resource
Message-ID: <20260508113100.GA9285@ziepe.ca>
References: <20260507032120.4072283-1-jianpeng.chang.cn@windriver.com>
 <2dcc29d6-a4a9-4fdf-861d-312941ab0f07@arm.com>
 <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89094011-fe78-40f9-9695-d50ee19167c5@windriver.com>

On Fri, May 08, 2026 at 06:01:01PM +0800, Jianpeng Chang wrote:
> > As I said last time, I think pfn_valid() && !PageReserved(pfn_to_page())
> > would be enough for what we want here, although now it's strictly under
> > CONFIG_DMA_API_DEBUG, perhaps the overhead of memblock_is_map_memory()
> > might be less of an issue. Either way though, now that it's all
> > channelled through the single dma_map_phys() path, it would probably
> > make sense to consolidate any MMIO sanity-checking into
> > dma_debug_map_phys() anyway :/

> Thanks for the suggestion. Move the check into debug_dma_map_phys() is
> indeed better, and I will replace pfn_valid() with pfn_valid() &&
> !PageReserved() as you suggested.

I'm not sure that is right. IIRC pfn_valid() is true for ZONE_DEVICE
P2P pages that are used with map_phys but never with map_resource.

PageReserved isn't enough to fix it.

Jason
