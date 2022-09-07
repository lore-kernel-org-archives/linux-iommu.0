Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F467E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=; b=hfd8sybGfMqbmQOjE0SfaJqlSM
	ZW8dYkd0/wA6tNB6f6D+D6dFo/tZQ/xyHlXU9Wl7O+eKpEKnxzrVwTMX0vxxkwukEfTNq5ABh3HcZ
	FwcJPcC9RwsEC894NG/JLt1qPdTX/JrTk6ETN/hzZOCOvaLVFGQMeQcmJ+5vswQPYoj0G5KxnQfI2
	foT/7Z/dxx0URlv9xjUC1aP7c5/NAHlRwMX4AuL++2cPD5TB++YGh4IUMuPUSQqCAbYunWO75mhq6
	eZ5npMO1MQ8FunZnOPjYGzgRXtgqBUe6Ag/OoLTnjUZ2VBLJzRIHVlzDqM+lOMVubuqESbo5X/guV
	0yTZKncQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVqak-004Nu2-82; Wed, 07 Sep 2022 08:39:26 +0000
Date: Wed, 7 Sep 2022 01:39:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chao Gao <chao.gao@intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, hch@infradead.org,
	m.szyprowski@samsung.com, robin.murphy@arm.com, jxgao@google.com,
	konrad.wilk@oracle.com
Subject: Re: [PATCH v2] swiotlb: avoid potential left shift overflow
Message-ID: <YxhYvjpDyTzlnWnN@infradead.org>
References: <20220819084537.52374-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819084537.52374-1-chao.gao@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks, applied.
