Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1237B71
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 14:29:40 +0000 (UTC)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id C0EED163F4B
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 16:22:02 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1686061322; bh=cKPuvJd+hkUDroUzY9LFq9IvOomVs8pOMCeXThQv6Dc=;
	h=Date:From:To:Subject:From;
	b=y/hJjdqU7u2IQDK4jO4IouK7ph1ub6dbwZAvH/CB24ObCTWhVXXKiagqE1+86kt/n
	 +1hoQBYkiIKJM1LzRHZ9IQP8dTtbMA+LwdrsnaEj41ijC3fXegc1Ci7NOwK0sSE4zy
	 8d8Nqu8yTXGDQ50mo/bdsrbIeJAvLaO+tu7HagILqENKKqKDNRpx3kgWQt2H8FQj/r
	 ISxFDoJ0RHNgK9VpH2CGjH0RM4XK1K6GtlyHgt3mpSOTuOQ1rI8VQO7JRPGbGWLIr/
	 +fMa+oqWwX+jdRPll0c3oeCZ0cvqoyQ+p5AJ5wnWgsbHIBqrDfrxU+f5z+B6x4b1sz
	 tpO1/ujkvmT9A==
Date: Tue, 6 Jun 2023 16:22:01 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: iommu@lists.linux.dev
Subject: Scatter-gather DMA
Message-ID: <20230606162201.1daceefa@meshulam.tesarici.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

while looking through the kernel code, I've noticed multiple places
which try to convert a DMA address to a struct page pointer just
because a struct page is required by the scatterlist library.

Of course, most of them do the wrong thing (e.g. amba-pl011 simply calls
phys_to_page() on the DMA address), but I wonder if this is merely a
limitation of the API. I mean, some DMA addresses are not even backed
by physical RAM, and then there is generally no struct page, but such
addresses may still be perfectly usable for scatter-gather DMA
transfers.

Is there any reason to use struct page except that the SG list API is
based on page lists?

Any comments welcome.

Petr Tesarik
