Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1184D26A1B8
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851171; cv=none; b=piQZFlWyH6IrHoSskGjkKwxzafDnyW2OQvb74iCic5x9CGrqzIMc8vB2lb44KWIKJPZAXna3xWdHDot8DcqXNMVx+b2ly4bn6OZIZC+wKu2i8TFws8c7XnhZ8noWSBv4Vyn4IV2/vQk4vf1xE3+GprcNTXMg8qxK8ynB6Fxp878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851171; c=relaxed/simple;
	bh=kA2Cql7VEaq1esamKrRKVS7LqD2Pp0ytpgO6nYFlafU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDNTWfMcUbhIh0+g0j6SIgry1c4HA2J2JBX5g6xh3Fi2Ohre2jkm4N9vnst2VtsZ4xZn6uQ08TOmWAAo6NlwxpkmNYW0aiahvpSt/+p1mm5WjHPZjL4XSdIfEwXD+cFKxaiiGf4aaDqz1+AZFlBYA2uCsp9Ij/Bob4PdJb4g6WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD63D1516;
	Mon, 28 Apr 2025 07:39:22 -0700 (PDT)
Received: from e133081.arm.com (unknown [10.57.20.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F5013F66E;
	Mon, 28 Apr 2025 07:39:24 -0700 (PDT)
Date: Mon, 28 Apr 2025 15:39:22 +0100
From: =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>
To: ryan.roberts@arm.com, suzuki.poulose@arm.com,
	yang@os.amperecomputing.com, corbet@lwn.net,
	catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
	robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
	paulmck@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
	maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
	oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
	ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com,
	mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
	kevin.tian@intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v6 3/3] arm64/mm: Reorder tlbi in contpte_convert() under
 BBML2
Message-ID: <20250428143922.GA348493@e133081.arm.com>
References: <20250428143352.53761-2-miko.lenczewski@arm.com>
 <20250428143352.53761-6-miko.lenczewski@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250428143352.53761-6-miko.lenczewski@arm.com>

Embarassingly, managed to leave around a stale patch when renaming the
commit. Please ignore this patch, the correct one is "Elide tlbi in
contpte_convert() under BBML2". Am considering resending...

-- 
Kind regards,
Mikołaj Lenczewski
