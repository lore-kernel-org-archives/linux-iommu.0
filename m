Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088BB227BAD;
	Fri, 14 Feb 2025 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532165; cv=none; b=cWNQbFg+WCqQ8ZCLjzn9dCzu3p4C9MAdBCDqXdTp0Ucq5S0zD+o+e8+mZIeExf6O95LBDYblYqdpseJ/SXqwzwwqqHtqeRATgQIX3v/kgjpiV++UT07NzHFbupiQg/JmqZfGVBGEBWgQIoZzpwfguj3Eq9ygJFsD0HN87RILmw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532165; c=relaxed/simple;
	bh=9+0ZoEndEpBrKl5s2nEdbdRyI7h4b6Ex8uOQ1/FEz7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEHtiqsQcMc7yQQJg9uwBBN8qJW3fpz0+trOd9K5dD911Tnwe0VxR0CLUx9OxXr50w7fUphQc1wCaTHH6hseVMbrzYPRRsW/pKG68U68n09Rg9zyqSe1ZkGeboeqwjPpIflgLQMs/+smJLhhm4YkBrH0KXmo9LBxMfKnEAjJVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCgGNzKf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCgGNzKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00F2C4CED1;
	Fri, 14 Feb 2025 11:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739532164;
	bh=9+0ZoEndEpBrKl5s2nEdbdRyI7h4b6Ex8uOQ1/FEz7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UCgGNzKfaYo3RkW7ZGTGlQUou0TLmA2RhcWMqzxjRRvssD1c8ImVD3Xh+AUeVXL23
	 mG8hPg+HvvRWYhkBYeYy/HVPHAPw/zMnOD4+j3yFSCjrkgyt010lXDE+qd+ML0UTGh
	 ImIQJgdVyMlufEv/qiJ+u9kqMkEMRv4VW8OLJgHMIpCiLNuton1h/8J3uRtt0138iY
	 UO5W0oVsrpDfs7UJ9y6ZcFn25zvluOiAm4TOgp0Ox7Qvm0nV9mufKxfG48MnrLPwtP
	 U+ZtW7DnbKNyVYC+EaaJAjMJTjxYB3BkmfQw/6X1rRXXBsNTAV77EFZyg0yulOleKg
	 6bdIfBDy9pZDA==
Date: Fri, 14 Feb 2025 16:52:40 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
Message-ID: <Z68ngMQ7iJJhOZtG@vaman>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
 <20250214061104.1959525-10-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214061104.1959525-10-baolu.lu@linux.intel.com>

On 14-02-25, 14:11, Lu Baolu wrote:
> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a no-op.
> It will also be removed from the iommu driver in the subsequent patch.
> Remove it to avoid dead code.

Acked-by: Vinod Koul <vkoul@kernel.org>


-- 
~Vinod
