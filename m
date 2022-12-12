Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5123BD
	for <iommu@lists.linux.dev>; Mon, 12 Dec 2022 11:06:41 +0000 (UTC)
Received: from 8bytes.org (p4ff2b8a9.dip0.t-ipconnect.de [79.242.184.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 47E902208DD;
	Mon, 12 Dec 2022 12:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1670843200;
	bh=Wx/FQOa0twYM0J5vE2YN6rDdN+so7uRjoO2kTY5Jbi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dW4pqcZewOZIBby4X/JgUMfAZGaEUzvnd6vMsAkbBHkhFy+Ob6GJzF0jf7dAi/rpk
	 NFHRYkUI7faJCB7GChDJX3aCOGeNFuDgOyEqsKieXlFO2M0gzpTn5NI+POC0fhZASL
	 auv0ddRDic9vhY9c4mqkpM1JfvccQUCTCArArvyfsVgAmAK74J3/eQlQRXuIBtaQHd
	 Y667DXckjktnMd9xO172C3U4nEDHIOl7BoIQcr5eHtceKXgt6FmGj/QfdJPpLP/rUs
	 28pCd9MX2lyZOOaUlGzDAWw6Wls7GKT5enuhfaJ48OeHc4otRH7bjYgbtHNh2xud6X
	 DKhQ/4Wxp4jRQ==
Date: Mon, 12 Dec 2022 12:06:39 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Dan Carpenter <error27@gmail.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iommu/mediatek: Fix forever loop in error handling
Message-ID: <Y5cLPzaQzMadY4Yk@8bytes.org>
References: <Y5C3mTam2nkbaz6o@kili>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5C3mTam2nkbaz6o@kili>

On Wed, Dec 07, 2022 at 06:56:09PM +0300, Dan Carpenter wrote:
> There is a typo so this loop does i++ where i-- was intended.  It will
> result in looping until the kernel crashes.
> 
> Fixes: 26593928564c ("iommu/mediatek: Add error path for loop of mm_dts_parse")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/iommu/mtk_iommu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied, thanks.
