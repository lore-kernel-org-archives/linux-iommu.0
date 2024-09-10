Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89031514E4
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 04:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943958; cv=none; b=G7bfCKc5pHCZsT9oCHLBeFN+74ccTKwVB99OFPWsihcGTgd0jrIm0Bcp/BsFFYmDdZYf38Utt1enLFGMma8pDEcvXUbW8L7weu6lLtTwhxk8DiSV4WDmKyFTUCzVGsjpvgZSQT2JvEddA9j7kUhlLzW9XD8+MMKXUoskSzG9dY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943958; c=relaxed/simple;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDpqmFYbPbfFCkVnHWStJjh3QBbe08BMrXOciC2ieWSabdK9rzhRqBMrz/E4AQka1CmOJQjftYzZAXxlsX37nmkdNCB4K5Q35OkMJ3/nu2nrX/2+KIoE5aSGq8GaQAAaVGF+cd6r0qvYbCisC2sdADO87bBsa5cVwM1qrNnNY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C99E4227AAD; Tue, 10 Sep 2024 06:52:26 +0200 (CEST)
Date: Tue, 10 Sep 2024 06:52:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dma-mapping: add tracing for dma-mapping API calls
Message-ID: <20240910045226.GA15967@lst.de>
References: <20240906215435.636352-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906215435.636352-1-sean.anderson@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.

