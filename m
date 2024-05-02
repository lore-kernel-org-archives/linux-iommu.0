Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2061629A0
	for <iommu@lists.linux.dev>; Thu,  2 May 2024 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629542; cv=none; b=dDTpAZTr4lVEl5ZIUh25ci+LQyLqk/5wKoooQZ6FouAdjXYJzq5UkwGFBe3xSU/7FFvlmM0v8b6MHm9Xdql/qBGIVFjurWW5qdloVwOrBgZRY4j6j+m6VfmYOL7crfCN3q7pCM8Sr5K2FOEq6IuQetWiFD2/RMc/CmZxHF8Gs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629542; c=relaxed/simple;
	bh=uO81lYAhJsX1xz8NuGgOK/Z1HciAOq/uegd6DHWh3UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYLuJOqMn2BFQ4DlPpyz2gH9ix+PzFoY7wGyUY9zli/qsL13Uwfv9tvb7NeWxf4HLNfcLtmejFdt1wFPHYxC8DAqi36PDs7j7iIP+Vq0Olti1WQnHcbRK82TDZA6T2TwRWABfLUjoktAqQiwcJmpINGBefM8HTOdZn7ca6ZuQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83154227A87; Thu,  2 May 2024 07:58:55 +0200 (CEST)
Date: Thu, 2 May 2024 07:58:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut
 earlier
Message-ID: <20240502055855.GA28572@lst.de>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com> <20240423135832.2271696-7-aleksander.lobakin@intel.com> <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com> <20240426050229.GA4548@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426050229.GA4548@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Alexander,

do you have time to resend the series?  I'd love to merge it for
6.10 if I can get the updated version ASAP.

