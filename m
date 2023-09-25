Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD02320D;
	Mon, 25 Sep 2023 09:37:48 +0000 (UTC)
Received: from 8bytes.org (pd9fe9df8.dip0.t-ipconnect.de [217.254.157.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 407301A21D7;
	Mon, 25 Sep 2023 11:37:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1695634667;
	bh=OtjJ47/Iz9/BMTcRSKjjdHPzJhezGBu3u57/qDes7rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oqVvz+Rol/QT0zwOgQ3cRQyvMJ2S2rbyE0KeHJiOrqYGtFUgr8nIsKuhCGeQ9wz09
	 l5NA6UCuahz8JKpvayo8QXFEoimfrhk3UaqejDG5yhPBRRej6uFkOBuWWUGQs3hPtE
	 HIPxkrQA7TwFCB1kL4PT/NoIFaSKpqA6W2I77hOVyQrgLJy1No80NiYiB6wGARzqgZ
	 jWKPS8h8zJHfZDkZ7gTKIgBjA+WEa51cc6utPdMBHM8cDUtXdoE8HDIi2BU2MPwW2b
	 Vqh1I5+3ulHBc4DD5i3742qd8/9KTwMK0/mmgxMce9DXdvVKPhyCQdmkJ09Bcojpq1
	 Zvgr+kLVUetsQ==
Date: Mon, 25 Sep 2023 11:37:46 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Hector Martin <marcan@marcan.st>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Joerg Roedel <jroedel@suse.de>, Neal Gompa <neal@gompa.dev>,
	"Justin M. Forbes" <jforbes@fedoraproject.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH REGRESSION v2] iommu/apple-dart: Handle DMA_FQ domains in
 attach_dev()
Message-ID: <ZRFU6vd1PmKeSivz@8bytes.org>
References: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922-iommu-type-regression-v2-1-689b2ba9b673@marcan.st>

On Fri, Sep 22, 2023 at 11:55:23PM +0900, Hector Martin wrote:
> ---
> Changes in v2:
> - Fixed the issue in apple-dart instead of the iommu core, per Robin's
>   suggestion.
> - Link to v1: https://lore.kernel.org/r/20230922-iommu-type-regression-v1-1-1ed3825b2c38@marcan.st
> ---
>  drivers/iommu/apple-dart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied for v6.6, thanks.
