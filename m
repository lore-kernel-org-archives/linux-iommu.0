Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B6DDB8
	for <iommu@lists.linux.dev>; Mon,  7 Aug 2023 12:56:13 +0000 (UTC)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 9C0CF2802C0;
	Mon,  7 Aug 2023 14:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1691412972;
	bh=6Xy2YS2W3qgRvHtmtu9Lpdsks7qVo10Gru1ffayWzM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIWY4otYAViQBjh6/KLeMMqTKBYnq8otbfD4bQzLWO/xEPlJTewjO0BNknpNnXy5o
	 j7kpVKKcLDoTEsEFDWeXbsOouY6fNL0NLuy7UGvX82EVum2Fhtaz83hZNiE5TC+5pO
	 ki53ua5JyLT0XiFSsAeRuOmf7HsP6guxutu2t2suOluvUkz38xs0Na5jd3+QK43wDA
	 rPZyubg8wCjj+UU1WAvlQvUIR8EtekJ+Z7PKqlX1YudYaQa0be7WIxS0E23eLbfxfm
	 iV8TWUG8pzFUgJLwFNPOpOkXvRpV86Nh9eJUSPEG/xURFb9nxjzbbOUSRD2+VzC8Vd
	 4o/gorM2edJWQ==
Date: Mon, 7 Aug 2023 14:56:11 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/amd: Remove unsued extern declaration
 amd_iommu_init_hardware()
Message-ID: <ZNDp61liCikysQGf@8bytes.org>
References: <20230802133201.17512-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802133201.17512-1-yuehaibing@huawei.com>

On Wed, Aug 02, 2023 at 09:32:01PM +0800, Yue Haibing wrote:
>  include/linux/amd-iommu.h | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.
