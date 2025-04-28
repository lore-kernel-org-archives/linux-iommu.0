Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900F920A5E5
	for <iommu@lists.linux.dev>; Mon, 28 Apr 2025 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851237; cv=none; b=Jp2IxdyewTIB6Va8JwIzsFRUwpO1Yr0O2ulmqJIdmMD2zIyAFMsp0LqTHzugugAOQgN2NtB0yHL/Sc7jfCePFDJNVHSQ11In6MYFTmtnzvUgng6fU9wmlGD4FxraMLoXtKyIUkxqn/Rnu7fogeefv76wFzONK8eTG6mB6t3/Bwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851237; c=relaxed/simple;
	bh=mVDX6b5VFdDOPlZtntaoawQqn4fr3Fu5oJXEjK9Dd5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jBfDAZgHA5IjaivJ5fFYXKBuL3A69Nxa5FL0YZRUPtMMB24I+xHEiQK9x14gWcsrp4pyGlvlX/qAxeSxtMlt1oIqimQ89DJBTljwZYGJDI3G5Kwvr25t8KFhaifIBC1nddSEp7GNNlCt3Pu9omw7jXy/UnfC2zeCSZmJCEyW2G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BF821516;
	Mon, 28 Apr 2025 07:40:29 -0700 (PDT)
Received: from [10.57.90.155] (unknown [10.57.90.155])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E66763F66E;
	Mon, 28 Apr 2025 07:40:31 -0700 (PDT)
Message-ID: <8d9d9d59-8fd1-47db-88fb-39bb791a4b8b@arm.com>
Date: Mon, 28 Apr 2025 15:40:30 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] arm64/mm: Reorder tlbi in contpte_convert() under
 BBML2
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 paulmck@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com,
 maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
 oliver.upton@linux.dev, baohua@kernel.org, david@redhat.com,
 ioworker0@gmail.com, jgg@ziepe.ca, nicolinc@nvidia.com, mshavit@google.com,
 jsnitsel@redhat.com, smostafa@google.com, kevin.tian@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20250428143352.53761-2-miko.lenczewski@arm.com>
 <20250428143352.53761-6-miko.lenczewski@arm.com>
 <20250428143922.GA348493@e133081.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250428143922.GA348493@e133081.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/04/2025 15:39, Mikołaj Lenczewski wrote:
> Embarassingly, managed to leave around a stale patch when renaming the
> commit. Please ignore this patch, the correct one is "Elide tlbi in
> contpte_convert() under BBML2". Am considering resending...
> 

I think it would be clearer to resend. Otherwise people are going to get confused.
