Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5C1849
	for <iommu@lists.linux.dev>; Fri,  8 Sep 2023 08:58:58 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2B8068B05; Fri,  8 Sep 2023 10:58:54 +0200 (CEST)
Date: Fri, 8 Sep 2023 10:58:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	quic_pkondeti@quicinc.com, quic_tingweiz@quicinc.com
Subject: Re: [PATCH] Revert "dma-contiguous: check for memory region
 overlap"
Message-ID: <20230908085854.GA12056@lst.de>
References: <1694073836-5125-1-git-send-email-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694073836-5125-1-git-send-email-quic_zhenhuah@quicinc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.
