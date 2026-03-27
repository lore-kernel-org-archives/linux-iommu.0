Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8863D6CB1
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774600721; cv=none; b=MDiXXkGUSv4kdDh8evXVRBe52sSOzcDFzHP64k0x/8Hj/h8kYUt7W3hbzx6IMrbV4FL3Q/NI6uh8byReFkXGSPurArK+Qjk3fWIPENvHgwjQS7362Nb5IKKzl+0eAJzFZMsGVqL0UI2pSd5sG6rnXqL6Pp7PH+XowhQNWw2P98Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774600721; c=relaxed/simple;
	bh=mpjbeFZjU0nzZl/xJ1J82VdObtBiZik7cjaYeahZE38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGvr8r2s7Y/4HDpLElNpwrAKtE3lQH/aMjcqG27eiu9rlBUu+2qIYb6N2hH6p/h1/M3o7pxt5mUk0DxTKDJcgnuyy2SBnoyRdnjDh/sT1HM/nzFl/NcB+5ogm04D7s8ZpDjRwWS6IEhgSwdhOlWByMqDZbz9FDHPD4JFkT6jh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JAASfc70; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JAASfc70"
Received: from 8bytes.org (p4ffe051a.dip0.t-ipconnect.de [79.254.5.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id F1ABE1A6A21;
	Fri, 27 Mar 2026 09:29:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1774600198;
	bh=mpjbeFZjU0nzZl/xJ1J82VdObtBiZik7cjaYeahZE38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAASfc70gWcLRQhl6fOopJqvjwFDOcgKKLEs2hvyVzJhE3cLeB3di918IF3eSI5Jc
	 XK3Rch5PNmSe6jlUt7nDgwGHWV0phqwViHbrbPMTMp6jpfNgh9cum0EXg7LZ8qOiqW
	 2itpLDFJAu4PsrtEGmbkZJwYdKm9CyZ2ebJzsfHirK6FaXC6HfJWdjILLGykJDSqEX
	 /BemA7DqSXSeZMyrahqegzc7GyaksJU97SIcp9/ky1EDJQD5SrrAFFHVY1eX4oMizv
	 b62X8my5l0uVWyHPeUCG23PzVZSVuwE6ltwfiFWrEF1d7f9wBzqJG4LCjS2hj/WKbS
	 9MAtRg65HYnBA==
Date: Fri, 27 Mar 2026 09:29:56 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>, 
	Vasant Hegde <vasant.hegde@amd.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, ming.shu@amd.com
Subject: Re: [PATCH 0/2] Fix illegal access in IOMMU debugfs
Message-ID: <yrbucydywdvk5zsvbnmxvz5dtmomw5p5vmnbs7prarffqsmgn5@3twhzcpcyxlv>
References: <20260319073754.651998-1-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319073754.651998-1-guanghuifeng@linux.alibaba.com>

On Thu, Mar 19, 2026 at 03:37:52PM +0800, Guanghui Feng wrote:
> In AMD IOMMU debugfs,
> 1. set the device, address, and other information to be accessed
> 2. After verifying the legitimacy of the device, address, and other
> information in step 1, access and obtain the information
> 
> However, before actually accessing the device, invalid device or address
> information might be set again after the legitimacy verification in step
> 2, thus triggering an unauthorized access issue.
> 
> Guanghui Feng (2):
>   iommu/amd: Fix illegal device-id access in IOMMU debugfs
>   iommu/amd: Fix illegal cap/mmio access in IOMMU debugfs
> 
>  drivers/iommu/amd/debugfs.c | 63 ++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 32 deletions(-)

Applied, thanks.

Vasant, this patch-set fixes pretty serious issues. Can you please further
review the AMD IOMMU debugfs code to make it more robust and secure?

-Joerg
