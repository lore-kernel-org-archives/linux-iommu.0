Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA85383;
	Thu, 17 Jul 2025 02:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752718256; cv=none; b=P9Dq7Yy6VhckQM8/VM4aFDwNENygGDcEc6hdfqgLCMeJz5HDcgFQgDVa+LTmwZPW1HVrdc+1K0pqcsEME7RjMA9U0dl+Xkovuj2+86cxBXTb6ssaXoyAeL4UWuCCUYCyENp895UixLFJg3TMnWn4hKKgJGAbEQdxc3i8QwYy8Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752718256; c=relaxed/simple;
	bh=E3P04Zk97V1KVNAa6A19+AuiHhE4WdUG6JK/+ixB8JU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OycDUrBpInIXCHj9jm9EJ3z/2YNkLVwe/ai5D03JdixK/LwM7VHvlSw1oHi3Gajm20Lc8j8s5y9fI2Ob9Fv3hG6z3/J0UFtmK/nHdh5frqGJ9oWIlLH4BBL3mqqlve5q72G0nKQLCobbuwPAK4L4/huNi6g+JLj8WuMbs8f/E5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X1iEtJcq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X1iEtJcq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GBcZdsaYhycHmmpGcko2jxY5iOjLzHLcpfJfli6A5+I=; b=X1iEtJcq8pTGZ7jmZEb11JZLDx
	VlLa3qlqLeuqkD4H0GhyTzrcwZj8kWOl/+KH2Te15HE0OEJOvN4uvA9WutTv2C9JLn9wt/pt/lGLr
	+umGHe+RuUydIpO1l45PW/MomPb4ZMxFBgoKLTrUCllTz9KIGGeg/52mKG1D7uPHHZMS+Vx325/s+
	+hQrsxHpRqKtOS3KnS23hP5XknqRwLDemP1k23dNHrKQpHZPeBr4YW6SdVVxSNdqaxm69nJscLwZK
	EEhGrRxhCB8u0h9ultkqEjBCv0RkoXkgaOr3fcrLFNwwkJWFgpyDhhhHlAp9dB7gTTuPqUYF8w86w
	59EE+GwQ==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucE5E-000000092fy-3nkv;
	Thu, 17 Jul 2025 02:10:52 +0000
Message-ID: <c8fdeee9-6421-4943-9c79-f3a48441488a@infradead.org>
Date: Wed, 16 Jul 2025 19:10:52 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Wrap debugfs ABI testing symbols snippets in
 literal code blocks
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux.dev>
Cc: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 Will Deacon <will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Ashish Kalra <Ashish.Kalra@amd.com>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, Stephen Rothwell <sfr@canb.auug.org.au>
References: <20250717010331.8941-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250717010331.8941-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/16/25 6:03 PM, Bagas Sanjaya wrote:
> Commit 39215bb3b0d929 ("iommu/amd: Add documentation for AMD IOMMU
> debugfs support") documents debugfs ABI symbols for AMD IOMMU, but
> forgets to wrap examples snippets and their output in literal code
> blocks, hence Sphinx reports indentation warnings:
> 
> Documentation/ABI/testing/debugfs-amd-iommu:31: ERROR: Unexpected indentation. [docutils]
> Documentation/ABI/testing/debugfs-amd-iommu:31: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> Documentation/ABI/testing/debugfs-amd-iommu:31: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
> 
> Wrap them to fix the warnings.
> 
> Fixes: 39215bb3b0d9 ("iommu/amd: Add documentation for AMD IOMMU debugfs support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20250716204207.73869849@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/ABI/testing/debugfs-amd-iommu | 125 +++++++++++---------
>  1 file changed, 71 insertions(+), 54 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy
