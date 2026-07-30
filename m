Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F6837EFE6
	for <iommu@lists.linux.dev>; Thu, 30 Jul 2026 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415910; cv=none; b=fjEPqU/fF5RPrnHNQeWcLFKjIlX4iBl090gpzJLq0B6LeN/NToVxkxTidTb4ZszDI2t+f7i+Jq3VkoprdaDJcJE8xShIGHLGrLk2nVn1VzIG2/0p/Jl1iBy3EjcjpU52KibxDXMY5zmh48ovumUkautp0QBRDqT2lElnorPAQCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415910; c=relaxed/simple;
	bh=YvKIhTHwy/wh9ih33oqTW/PdrY5QuMazrL46CkyKvu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=st9GtY4zZzPtwzjktZGyyQaYZHnA3v9WMI9AQFvuO2ABygD1c93Kz4QFaubSd6DxQSlnlHzDGRp3cWqmVX333+nA3grjDDKYxjsd5mRi8PHjiZN2mQVliWKOAS4hI9sVL04bzIANwXueGkvKmyTTZwqpSbvl7fEBvHS2rQfB6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af4fc50014f63e0f2a030593.dip0.t-ipconnect.de [IPv6:2003:f6:af4f:c500:14f6:3e0f:2a03:593])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id AF928240AB9;
	Thu, 30 Jul 2026 14:51:42 +0200 (CEST)
Date: Thu, 30 Jul 2026 14:51:41 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, will@kernel.org, 
	robin.murphy@arm.com, bhelgaas@google.com, oliver.yang@linux.alibaba.com, 
	zhuo.song@linux.alibaba.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Put PCI device after handling PPR faults
Message-ID: <amtIx3U8r3OoBOM2@8bytes.org>
References: <20260727030212.51759-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727030212.51759-1-xueshuai@linux.alibaba.com>

On Mon, Jul 27, 2026 at 11:02:12AM +0800, Shuai Xue wrote:
>  drivers/iommu/amd/ppr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied, thanks.
