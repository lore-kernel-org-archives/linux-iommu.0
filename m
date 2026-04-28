Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742863E6DCA;
	Tue, 28 Apr 2026 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777367105; cv=none; b=Z0SLFjqR1y2iRX5lUVbwPvrLzHnbBHB3f0mo1hPgZTEMZUx/yKBhCGC0nVWmwaE8WyeN3CkPFjVF+GeHHpe21lDt7hV+4aWYu9GJ965P3Jv/ogFB5xEyCA0uIMPPMKyGF5PndkLe7vHzZE7BThjmIs4zH0EbEaHRx+RG1giQvCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777367105; c=relaxed/simple;
	bh=avdBPaIwZk7NkKkTLLHF3tk7Md9yMqY+C26UoHu11cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do3xp+CnBWQUMOj6u5Mc81VZZ8vheqcaDMViv0mlDWUlC56GIB4882+Banxen0nvRwauII2aghHVKOvGtLxPYu3yahs13OsfyAQU3+Ry03N6N2PlJhIfIdN/V3v0v910nkvyg+MqSgjmhtE09tKHrkVk5H3lXvKKVUa3nrJTgl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY55H+Lx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY55H+Lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F96AC2BCAF;
	Tue, 28 Apr 2026 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777367105;
	bh=avdBPaIwZk7NkKkTLLHF3tk7Md9yMqY+C26UoHu11cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mY55H+LxwhQCzaL+eZPT2a+NHi3q+LDHzejJWRa2EyNn2Us5tC7lLg9skNg0BzBZZ
	 DdU4pfFsQSKIBW6WTfavxFUt+lOMnQ40qbpdtWASKwActV+QHreL7yOvR6N62rgUc2
	 hL9/qNiFvU5dnvKE4URCV1RIQ2sFV7ddkdov7dqhNFOr/jXSvgqXR7FKz35/zWJ/Xc
	 nHmopaRESLGWn4hWd6GzpFD9b8o8uqiMq0YG5q3tUoDwsw3d9BnGSN75WV7D/6CkSV
	 CgluCWbAK5Yx3p1JjrxwZNbzWsYguIT12/29tMlYKnnI/1UEdI/zvugqKuZ24ozjfN
	 WiMFWeElnBSyA==
Date: Tue, 28 Apr 2026 10:05:22 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: Joonwon Kang <joonwonkang@google.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stimim@google.com, cychu@google.com, hhchung@google.com
Subject: Re: [QUESTION] Is the ARM SMMU v3 implementation designed to always
 ignore SSID when SSID_VALID == 0?
Message-ID: <20260428090522.GA3048463@myrica>
References: <20260428073859.1502047-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428073859.1502047-1-joonwonkang@google.com>

Hi,

On Tue, Apr 28, 2026 at 07:38:59AM +0000, Joonwon Kang wrote:
> Hi team,
> 
> According to the ARM SMMU v3 spec, I believe that SSID should always be
> ignored when SSID_VALID == 0 and the current ARM SMMU v3 module
> implementation in the kernel seems to comply with this without exception.
> For example, when handling an event from SMMU, the implementation checks
> SSID_VALID(SSV) first and ignores SSID accordingly. If there is any
> exception to this rule, I believe it is a bug.

Indeed

> Is it true for all the current and future cases? In other words, is it
> **mandatory** that the ARM SMMU v3 implementation ignores SSID when
> SSID_VALID == 0? or there might be some cases where the implementation
> needs to refer to SSID even when SSID_VALID == 0?
> 
> Asking this question since our HW may not be able to clear SSID when
> SSID_VALID == 0 and so there might be some garbage value in SSID at some
> point of time(the HW will have a correct SSID when SSID_VALID == 1,
> though). If the ARM SMMU v3 implementation is to refer to that garbage
> value for any reason, the result would be devastating.

At least according to the architecture, SubstreamID is ignored when SSV=0.
The SMMU is allowed to propagate the garbage:

  7.3 Event record

  * SSV: The SubstreamID validity flag
    - 0: No SubstreamID was provided with the transaction and the SubstreamID field is UNKNOWN.

But the driver will ignore it.

Same for PRI queue but in that case the page request wouldn't have a PASID
TLP prefix.

Thanks,
Jean
