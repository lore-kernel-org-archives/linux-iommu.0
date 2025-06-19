Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C04B21CA18;
	Thu, 19 Jun 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333017; cv=none; b=jgzifRyyJFpt1hm4YY/9daNo6ERKFNt+gBUrz11h2QMp6oTam+wZcm7ImyqAoEYFNgqKT1FeA03of1A+puHFud4RNFVlkVs7vUK2pHHIsHaMrVvv/T/s4dOaZnExdjQXV2NlCCXlRuQIPOj6b3xUWPjhXf2sRLhE0AAMLDccvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333017; c=relaxed/simple;
	bh=Gri7/g3bAHx7LWfhuIKR98Zyl/ct+4pGh1unbJ/Tpcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEoTj/1znnk2Or7pa3EmBtCOFxtIw4gZ/8dIyZ07tNQ1PJ4CZE6XLEnknyAiCU5RZUs+lxFre0gYOnyWim12kIbytQAhcccFKw0F/9zQmvesg/DIMOAqdBYVOik6rF75tKe8sZmA0AwtXalRCl3aYbaSWqC5HbtB7DZqySFFGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D254DC4CEF0;
	Thu, 19 Jun 2025 11:36:51 +0000 (UTC)
Date: Thu, 19 Jun 2025 12:36:49 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, will@kernel.org,
	jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	james.morse@arm.com, broonie@kernel.org, ardb@kernel.org,
	baohua@kernel.org, suzuki.poulose@arm.com, david@redhat.com,
	jgg@ziepe.ca, nicolinc@nvidia.com, jsnitsel@redhat.com,
	mshavit@google.com, kevin.tian@intel.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 3/4] iommu/arm: Add BBM Level 2 smmu feature
Message-ID: <aFP2UXFNoLiLUpo8@arm.com>
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-4-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617095104.6772-4-miko.lenczewski@arm.com>

On Tue, Jun 17, 2025 at 09:51:03AM +0000, Mikołaj Lenczewski wrote:
> For supporting BBM Level 2 for userspace mappings, we want to ensure
> that the smmu also supports its own version of BBM Level 2. Luckily, the
> smmu spec (IHI 0070G 3.21.1.3) is stricter than the aarch64 spec (DDI
> 0487K.a D8.16.2), so already guarantees that no aborts are raised when
> BBM level 2 is claimed.
> 
> Add the feature and testing for it under arm_smmu_sva_supported().
> 
> Signed-off-by: Mikołaj Lenczewski <miko.lenczewski@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
