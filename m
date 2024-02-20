Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5C535C6
	for <iommu@lists.linux.dev>; Tue, 20 Feb 2024 05:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708408370; cv=none; b=EAq35zISZTd08EbMOthoWQHotyiGHtVIrjjsKN/oZxqWGfro0KZxLFPO7Mncs5z2WDAB2N0xsNueee/vmEoNpflnHGy4F+oxxWbMvsFPM6AkecrBR81roN6njqI3idB7Kzv5TMT89PEg1pN5mLCzRNqZEtmeB/PVuKI9TKmhjAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708408370; c=relaxed/simple;
	bh=QGwDArMulqmomAgnLZOZXS6F9kSP8omhCh7Gh9khW/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K08lvC3n8/3mZY7oiiK15++bi/Ibk/MgFqrwGS3SGK2RYn1TN+ARVwbCU6C+n0hB35/klqpeZhjHwl1FvWWtMLr2ZqId/P3dZYYEfap5i2frqnWjmiKnB4bjS9JXf4NZCGIfQzuVUgOx7nOluTp5Y7HjRCFsBgvFWsvYdp2Gne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFAAD68AFE; Tue, 20 Feb 2024 06:52:41 +0100 (CET)
Date: Tue, 20 Feb 2024 06:52:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Howard Yen <howardyen@google.com>
Cc: Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
	robin.murphy@arm.com, gregkh@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, rafael@kernel.org,
	broonie@kernel.org, james@equiv.tech, james.clark@arm.com,
	masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v3] dma-coherent: add support for multi coherent rmems
 per dev
Message-ID: <20240220055241.GA7554@lst.de>
References: <20240208152808.3712149-1-howardyen@google.com> <20240213055426.GA22451@lst.de> <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJDAHvZGnzKPLaovRcq_Os1Fcixp2o1kY9GFV8VXztrmKahejQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 19, 2024 at 07:12:18PM +0800, Howard Yen wrote:
> I tried to upload the patch to support multiple coherent rmems per device
> because in some system, the primary memory space for the device might
> be limited, so that add multiple coherent rmems support per device to satisfy
> the scenario.

I'm not sure what the means.

If you have non-trivial patches you really need to explain why you're
doing in detail as you need to convince maintainers that it is useful.
