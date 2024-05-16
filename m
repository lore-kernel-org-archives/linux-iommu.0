Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EBB145334
	for <iommu@lists.linux.dev>; Thu, 16 May 2024 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856253; cv=none; b=N+xLtVYlj+3rA2ZYCNX/DsTIoUNN5LX23oHv0GQCovau5NbUg00s/PHdj958yGNsWN4n6UgqzOxFd14g9WKwSCEHD6BXdbMkXKc6afi2zpw/FbMneOgSQ3cC1XNlsPeZwfdFXg26Q5ow57jcKHdiBPXkqcYy24/dFjWgIKRdvy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856253; c=relaxed/simple;
	bh=S4/6fMot0IIvuBHOvTWsbFm5x41qkoolMUSi+NhgXHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwcpQaqQn39Hn64iKpkeLfla+iQ3QVYj7TwkXfTgC55fG4p7hxrYSFEq/49SMlKkZbs9ax3ysdj6b1NJ7+tY30ZQy8uwoOVcmv79irkvMK+oBHp3qrscu9fPuUOtrmbM8leEsHCruK/pfDtZUVlqMEaHhLBU75HRNeNLBmnRtAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15657DA7;
	Thu, 16 May 2024 03:44:36 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC8F3F762;
	Thu, 16 May 2024 03:44:09 -0700 (PDT)
Date: Thu, 16 May 2024 11:44:07 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: will@kernel.org, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, liviu.dudau@arm.com,
	joro@8bytes.org, robin.murphy@arm.com, nicolinc@nvidia.com,
	ketanp@nvidia.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: fvp: Enable PCIe ATS for Base RevC FVP
Message-ID: <ZkXjdzLGH0wy1SJz@bogus>
References: <20240429113938.192706-2-jean-philippe@linaro.org>
 <20240429113938.192706-5-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429113938.192706-5-jean-philippe@linaro.org>

On Mon, Apr 29, 2024 at 12:39:39PM +0100, Jean-Philippe Brucker wrote:
> Declare that the host controller supports ATS, so the OS can enable it
> for ATS-capable PCIe endpoints.
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
