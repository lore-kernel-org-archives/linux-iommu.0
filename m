Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427620;
	b=Dws5fs+ICc7/9XU/vp3aPcgqloBPAJ+oZefhM5Ky98W06h+bDv4L0uOpLYdR6mGJLFrJ
	 wrjXSBuBEpAFN/xeBYJUOwz1ncxmf0d9UA1WP4IjrwwxS86lFP1gd1UvL5UboMDzdnvLF
	 Cy5zTMOxMg/F4TZBoo0GGiypfNAUJY2jP/WutGY5NK56WcBMXFfNqjIbQWLVflnNWaiTd
	 eWAvGby4iBTGsOQMqeRnnHbcJH1pJVvapphy+bWUl4xzyui0JFyfoxro6N6os9ACIar8h
	 eUgPpHHmmO1laE+3nVMPv529XQsaEmXcDuRZRokXcb90eK2jX+UjSrpEoqJZZDRp5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427620;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7c4vlbk54P0M4SB9yAZYXNwhVgmZ5xlQ/W0RjlrWerY=;
	b=bvVn44zjOy0WdkHHx1/egfVJnGsJpJdcMXxIbYsThtPleoFsJ9Sh9tG6oRgVKPbtDR7o
	 /VPlCdQVdBKFF+PG+6RlqZaxDlFf0aJ+UNR2wToMe2oItuJRCYZCm8O98xfcNxwj8Y6Sh
	 aWr+YR+1/wSQKL3JabhlnpVZJt+fK/N6ENIFSdjxp5EFIFmPJKk5BpiMQTEBoR8LHNLN8
	 8uoNGOu96V5/UsEdQtz+QloF3PzjG0W9Ix9jaZvAp8dNg6EHCpqTdM70JrFJ0JzN/kf5Q
	 5pxXw7hnGNl6MC7yCQKHtZTGirdxpSyNdPSej4o1A+SdgDJ9FIV30I0asrlvw8ZofAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C02B606A31F
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 09:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C02B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 955F52436B3;
	Mon, 23 Nov 2026 10:53:38 +0100 (CET)
Date: Mon, 23 Nov 2026 10:53:37 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: YeeLi <seven.yi.lee@gmail.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@ziepe.ca, 
	iommu@lists.linux.dev
Subject: Re: [PATCH 0/2] iommupt: fix zero-length unmap causing a full IOTLB
 flush
Message-ID: <awQNDPY9vUDi5ncL@8bytes.org>
References: <20261105121227.622631-1-seven.yi.lee@gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105121227.622631-1-seven.yi.lee@gmail.com>

On Thu, Nov 05, 2026 at 08:12:25PM +0800, YeeLi wrote:
>   iommupt: fix full IOTLB flush from a zero length unmap
>   iommupt: add a KUnit test for unmapping an empty range

Applied, thanks
