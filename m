Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430144;
	b=VXLncYY3hj5s3gn6PVhoHdpd6sIFYi+lqN0r6aT8QaIqmeZKlaMthVJHSMjwmnbDfS2r
	 DN83YrR94qF14UR7WjNPLlZ+ROLGqROhcMlIN3sJBoYXooUXBhop79DcXVnIRIuQG2M04
	 Y5/NnTzlcHaKBVuOPBW7x3WGauG+vXPPVtrW7dMZs4RwbWJTJqFZ2uuKHIufzOnrBLghT
	 CjAQf6nz9e6sssW4zak5Tv+5dhQXm7IUUX30gBNex+Zv/PsHAQMw70lMENkIn6qHcVvo3
	 VWBne0eXl+tO21hp8d0hxu/ZjPX6u4mzPcfyl3nH/Y4j2WJ6pk8vEG4/GEqiAeshkCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430144;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1qO48Vixlpl9QZuVQx4nj5DFPweIQ4nQI4l/+JyBSgM=;
	b=mvTFfXZeCBUAyG2LQ+PBWuR5Maf1CDtP9+0Sdv4ru3AuGk+FwHlDPuMJcYCqGOxhkMLa
	 iza7GVgxpOZlFaaAvrmm4D3NaMF39Z5nZm0n6yCwPl5g+1N8NMiU57QnBK/T8mlqL8OCe
	 GJcOUxrojJ6slTMHwrojXG0RWsUjh2WoysBxPWD3Bn74pyUI24+GeBYrY4B+v+UxHx9xx
	 ujo4yq7oQXAZXMUR3q0aI5Dzvon6/5UZIr7Vxaht65z6FQbIwx/XYESELeFhL6EWV/bIM
	 kkgmGvCRlsrlj/jGJjGCQP3vH2eU0y6prgQuZ9Nbde8GAHXx2vwtl/Dtl/Nz80GwOYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9C606A331
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 10:35:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18E9C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p549216fa.dip0.t-ipconnect.de [84.146.22.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C39302436B3;
	Mon, 23 Nov 2026 11:35:42 +0100 (CET)
Date: Mon, 23 Nov 2026 11:35:41 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com, 
	suravee.suthikulpanit@amd.com, Mario Limonciello <superm1@kernel.org>, 
	Alex Deucher <alexander.deucher@amd.com>, Akshata V Unkal <Akshata.VUnkal@amd.com>, 
	Nathan Blomquist <nblomquist@gmail.com>
Subject: Re: [PATCH] iommu/amd: Mark v2 page tables incoherent on Cezanne
Message-ID: <awQW8HufA8Ig7MXL@8bytes.org>
References: <20261120152308.76894-1-vasant.hegde@amd.com>
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
In-Reply-To: <20261120152308.76894-1-vasant.hegde@amd.com>

On Fri, Nov 20, 2026 at 03:23:08PM +0000, Vasant Hegde wrote:
>  drivers/iommu/amd/iommu.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, thanks.
