Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A4361974;
	Sun,  4 Oct 2026 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791120243; cv=none; b=EUHHgpWCkzUkQh3z67SxaT+Uqdh9hFkPkDHBOCc8oZvDZSekBPHfAAoULu0MxBKqDDD3oYv0U0QpjJ3eKI06YbtJT+2Q0KSBnmuUxIGPLrQn4FvCM+hcqsQabuUrm2Uaa+lwzkaLEDPTJIZlSY3Ms8RjMdUE4c80fF5t4FzU9WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791120243; c=relaxed/simple;
	bh=0EGOF0AAHrjlT6Kta7nhPbKRzE5tqCkIGUGExR2GhOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjIdg6rctlrrpNCBwNw2mQZgiZGUuBVLhnvlfYQeFH7XwyaeVIG1/160qJNMCzXxKUVc/ytcSp29KU+7dsJ3fm5gvRlO+PRSk3l9Wr7S8DYW00SgdrxX1BjProJcAK1UzOkhBRSQp+IVWaparqjrpzAiP6TqJCR5QzKIej5soOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvVcxO0V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvVcxO0V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3134D1F000FF;
	Sun,  4 Oct 2026 13:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791120241;
	bh=hcrir+g3vTkBKXXW4cwammW/9LshAbzsNVNZiUPPreM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mvVcxO0VFB7fHrYMpf/mmT14Q+zq2eT30yYrlKWtkHp4HdzAu1/Zh7joOZ9O5ktes
	 gyTFXODD3zmenNVGO86zG0YJGf8NzP3JMJGRhgVuqK/h7dftn6RjgId0sV1/k2ftL6
	 7HUmVwZeBkQvfPiqvEVHR/+9yIfJvbrrZo27xwYuEhHefMO4XSpEy8WVyCWz1+/i46
	 Sg7MvOnd4oXBdWt9/E6bbmKHV6le4nw4AQTaSwVD4nu1RRcEMa6O7cTU7EuqcUMa6x
	 tFjf+vjvEhkoSPXxIuqNuIEt0iPDioE1pknwOfvtWbBsyjVEOK6JZyI0sMUIgiGzHV
	 vQw0X79UXL26w==
Date: Sun, 4 Oct 2026 14:23:55 +0100
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, praan@google.com,
	kevin.tian@intel.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org
Subject: Re: [PATCH v10 02/13] iommu/arm-smmu-v3: Make the ASID space per
 SMMU instance
Message-ID: <asJTaw0lU9cRN4Gk@willie-the-truck>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <782e24224c916ad0f48de1a49c139e71c8db0ef2.1788130528.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <782e24224c916ad0f48de1a49c139e71c8db0ef2.1788130528.git.nicolinc@nvidia.com>

On Sun, Aug 30, 2026 at 04:18:03PM -0700, Nicolin Chen wrote:
> An ASID tags the TLB entries within one SMMU, so two instances can use the
> same ASID without ever aliasing each other. Yet the driver allocates them
> out of a single global xarray, which makes the instances share a space that
> the hardware keeps apart, and lets one instance exhaust the IDs of another.
> 
> That global space is a leftover from the BTM support that shared ASIDs with
> the CPU. Now ARM_SMMU_FEAT_BTM is never set, nothing looks a domain up by
> its ASID, and a domain is pinned to one SMMU at the attach.

We probably need to figure out what we're doing with BTM. Over at:

https://lore.kernel.org/r/20260907184513.GA2543240@ziepe.ca

Jason was talking about bringing it back once the remaining invs stuff
has landed. If that happens, what is the correct sequence to allocate
the same ASID on every SMMU instance after these patches?

Will
