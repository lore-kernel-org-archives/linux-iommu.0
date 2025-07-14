Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18671E9B21;
	Mon, 14 Jul 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495462; cv=none; b=FCSh4rbEmlk7XzkgIfrdesZMy660sZxVHBnNjIXntJ+miFHVtvEPfuJyV6ea4nlbKwMdZEl9/CBxSCU9A8TumNxk4bKHcCCDCg/YGWCwq0mQrUbjsnrCVCg9R4jgN5dasxa1ahcrTCgep1swkL5IwE2b4sF52QiTKjAOogkdf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495462; c=relaxed/simple;
	bh=fDezF0nJjErwuEBNTTQi89g3s72rqXCrWgP7mRRutRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzKlXHrqjp9MN/S6FYynrIQIs71TAwPSJ+X7ssqX+GnvYFl4/Jvc1RaK1dhjxW6qMfGsAizMkJw7xN/i4cQPVC/60eU7pO6XgvqLv3QyiOndJiw0N2C//90Fc1XXDjG8L+ZJNlQyrS631/Cf/xRDj1XiHr8wJbyYJ8X4UZeMVAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShpKcoSw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShpKcoSw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA154C4CEED;
	Mon, 14 Jul 2025 12:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752495462;
	bh=fDezF0nJjErwuEBNTTQi89g3s72rqXCrWgP7mRRutRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShpKcoSwVHnio0qR8KUKWYYZV/7jGDBn38P1DwoyLyFe0fHhp1zA2qUvUwgT+YGWV
	 jEK5pdTuTD0Efwps2pfCc+I2hx/r4BqdjCerSsSjtCt7nLSSz+8DSIxH9hywlsPJbe
	 pnw3BVyLM5Ca0F7wN+mnUw/5PssyYPsI53yhRzpViXFiau+sHiWnsdnV0QXaaZehuL
	 LPZj1hTbAJqXREWBtfvgIROEhWgyFW2X3vvEjQGqh5glTBlEaobl32hyUjVDo5ahbI
	 Siq7wNd0YoXykQCCJnNZQFKOow2FlSHrqVxyD9zqeseSe9Wf2LmciNMJTiTAN6XAIE
	 OaDLJOmMtWVoA==
Date: Mon, 14 Jul 2025 13:17:37 +0100
From: Will Deacon <will@kernel.org>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	suravee.suthikulpanit@amd.com, Vasant.Hegde@amd.com
Cc: joro@8bytes.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v7 0/8] Introduce debugfs support in IOMMU
Message-ID: <aHT1YeC30-ZiyS8p@willie-the-truck>
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>

On Wed, Jul 02, 2025 at 03:07:56PM +0530, Dheeraj Kumar Srivastava wrote:
> Introducing debugfs support in AMD/IOMMU driver that will allow
> userspace to dump below IOMMU information
> 1) MMIO and Capability register per IOMMU
> 2) Command buffer
> 3) Device table entry
> 4) Interrupt remapping table entry

Suravee, Vasant -- are you happy with this series now? I'll be closing
the IOMMU tree for 6.17 shortly and it would be a shame for this to
miss the cut given that it's got to v7 and Dheeraj has been receptive to
all the feedback so far.

Of course, if it's not ready then it's not ready, but I wanted to make
sure you had a chance to look at it before I switch to fixes-only.

Cheers,

Will
