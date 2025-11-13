Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E890337681
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046850; cv=none; b=lVEDodNxpWtkdyKLs+ZIz+5FA4Xn+lzWT50A242bDzP55AK5oDVI0QGne1YT1h+PCSSG34VNZ2Zdh1KeztkzQ33sPTN5+F/UjQoT7PRLy7krLmSfOi8XQbkFFrQQqH+lfv3NqYVqkrSQMA10cPbW57n9lPdeoeGvCHhediLutis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046850; c=relaxed/simple;
	bh=Fn7BM+iRiXSh29TtHYGBCDJ6QYtGrsMiOm5xLqDv/Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWbRasCNkYaKw0EgVBCfK2JxYapbb+JGT6WYvxFqUbtMqQ34FiHqQNGeKgXQqKpQ5+4cVtvVYrAsrQ4DAy/AwNQuOWD7v4iBrHyEMQ3hkgR3Z9ozYuKnHXKw1Hw/g7a1F4U4CJqp1Em5F0Uj58RRfVo+OVokBr/ve+QBDAXyyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=GcbwwR/P; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="GcbwwR/P"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 2B90359E1E;
	Thu, 13 Nov 2025 16:14:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763046840;
	bh=Fn7BM+iRiXSh29TtHYGBCDJ6QYtGrsMiOm5xLqDv/Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GcbwwR/PcRO7MEJKX/lZOPldOj83mHjEyoXqw6YPiB/332vq9Dhvg2QqgS9TH9CBk
	 Y47zNDgkEJRbnrUr1PYetg7qExo9CiiYFTjhwt4BhTlVLDQWn74zAnSYMOWjxLgGRs
	 sr/CbDrkP+7zuRw5XUGp4efvZKWSrdhFYPeSyQFmiMFkRDExZKhy7R6/AcUM6j5cmQ
	 m5FQMIp6EDFRouAZZM5Ugwy68nIdBLqsg7Q46Fy/+FFVZQT3NnSpSTJ7ZxoUnScMYs
	 ucox9ZK1vWxdJU39KRI+PKNU61RHpuJLUQca/KyZdAeJBAaWh8sRAMBXdcJ4gSvNlb
	 95/i6DausuqbQ==
Date: Thu, 13 Nov 2025 16:13:57 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Cc: will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com, 
	Santosh.Shukla@amd.com, Ankit Soni <Ankit.Soni@amd.com>
Subject: Re: [PATCH v5] iommu/amd: Enhance "Completion-wait Time-out" error
 message
Message-ID: <oj2duepunogk6zr3aicvh4dlwt2tltdq3kh4ke5nwuae2k7v7g@4jo2qsfiobhs>
References: <20251112211350.894-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112211350.894-1-dheerajkumar.srivastava@amd.com>

On Thu, Nov 13, 2025 at 02:43:50AM +0530, Dheeraj Kumar Srivastava wrote:
> Current IOMMU driver prints "Completion-wait Time-out" error message with
> insufficient information to further debug the issue.
> 
> Enhancing the error message as following:
> 1. Log IOMMU PCI device ID in the error message.
> 2. With "amd_iommu_dump=1" kernel command line option, dump entire
>    command buffer entries including Head and Tail offset.
> 
> Dump the entire command buffer only on the first 'Completion-wait Time-out'
> to avoid dmesg spam.
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Applied, thanks.
