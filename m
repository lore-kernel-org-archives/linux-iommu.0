Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30C9C2F6
	for <iommu@lists.linux.dev>; Mon, 22 May 2023 15:21:09 +0000 (UTC)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 84C7D24807F;
	Mon, 22 May 2023 17:21:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1684768868;
	bh=G0waLHG5OzkHmHsByb19/HH2n5w6/SygntvWr76EeV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7HW82lECGVngPPNrBZzaAtWGZKjnkuUkqWCMLOeo8n3jIN/fjBQnpcQIvd0I8XYn
	 BAmmHCv+7gLSkHWv8dodSC/yEIOpiNQ4fG9xovoaovk4syMzkqyGujV8PUBJ3PngO0
	 wwj6DM9BgkZk3lt46wEh63LHHDTnVu2gACcbHEuiADCrIRv5oEIXdWMkO0WjFqqvqf
	 4rl9PRDM5n0cT8aAQldx6h6mrjd1ScGeDUOhFoPL+Y5H3ZSeT3vefseDS1TAUFHUML
	 ItJm3w1Q/IJJSuwM08K58rUjPBc/cYykONURgf1wZ5OIe+EuePz2m3it/D1XaKtFMn
	 L7Jb4uZIe6FVA==
Date: Mon, 22 May 2023 17:21:07 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Carlos Bilbao <carlos.bilbao@amd.com>
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/amd: Update copyright notice
Message-ID: <ZGuIY_mr1AMy1BdO@8bytes.org>
References: <20230420173006.3100682-1-carlos.bilbao@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420173006.3100682-1-carlos.bilbao@amd.com>

On Thu, Apr 20, 2023 at 05:30:06PM +0000, Carlos Bilbao wrote:
>  drivers/iommu/amd/io_pgtable_v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
