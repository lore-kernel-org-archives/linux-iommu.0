Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8233929BDB5;
	Mon,  1 Jun 2026 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329767; cv=none; b=eAqjfhTfnVk4iwOrkH53kJja5SuvFGm3NCcIGn9BNhaZvahwXWx87BJnzUTmXvRjpktdFXU4kl5odWxeHxyK+1E/8YGJV8U3wT0QRpCyTh3OoL2ha8JiTEoOkH9dYtVKqAAL6Bhyor1quPMXgQkwpPEYOJIgMwYaZM3aAdqTevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329767; c=relaxed/simple;
	bh=XwXaBy7eLMVDvdp2vKiEICl2LxNB+LZ/zcEEoNKVLFM=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:
	 Content-Type:Subject; b=QR1m7f0HrB0kEpAWS9vpiSZDspOqX/3l8WxqXzLbabckCcKLMF3TDVJxDzOvB7tNMweHq+RlyWArHgbv2RVfV0oAtfTc7BDOO7At/W1dA8AUd9Gshv+erzyeWGNHDLf7wJV0lpADowVrC02L+0ZgmtZXFdR4lGXwgrq9lTaeIKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ROvl2zl8; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ROvl2zl8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
	MIME-Version:Date:Message-ID:cc:content-disposition;
	bh=7vBaZtv7BBkFGYWf3wqp7S/gBi3+eiCEAzetVCeRUsU=; b=ROvl2zl82MWFiJV7CRJo1peecS
	UDd7IfLO7YEaheotGHoNSKPiqnAtyKOxh2YvvazdvBozotG1dKE+SQmmqSDo9r/Zt3E7oXAIxcca3
	6V9MYPBYmFDgDom4OZeegyHNBaspWY3ksDZM38TUBmXNzUqbWpPtLj8VEZ1+YN2ok5QHmJfXVZqbm
	uvFcH+wNH9zpFw4UG3koZkrejEuf7Z/BfwI8BVVyPsTiZ/C/S3++78C6Zwb+IxP8MDURKf2xBLf8H
	MYYxqN1xRLpsyxUGqYzs4geXn+ZHZVV1W7BPksj1khhupkMquu+KoiYU6w4WaHa/ORgRWrw5eRko8
	3J3z92mQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wU565-00000005R1Q-1BOA;
	Mon, 01 Jun 2026 10:02:38 -0600
Message-ID: <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
Date: Mon, 1 Jun 2026 10:02:33 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lirongqing <lirongqing@baidu.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260530112852.2321-1-lirongqing@baidu.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260530112852.2321-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: lirongqing@baidu.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com, mcgrof@kernel.org, leon@kernel.org, bhelgaas@google.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH] iommu/dma-iommu: Fix wrong scatterlist length assignment
 in P2PDMA path
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-05-30 05:28, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> In iommu_dma_map_sg(), when handling PCI P2PDMA cases, the DMA length
> of the current scatterlist segment `s` is incorrectly assigned from the
> head entry `sg->length` instead of the current entry `s->length`.
> 
> This typo causes all P2PDMA segments in the scatterlist to inherit the
> length of the first segment, leading to corrupted DMA lengths for multi-
> segment scatterlists.
> 
> Fix this by using `s->length` instead of `sg->length`.
> 
> Fixes: a25e7962db ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Hmm, I thought I had tested this stuff pretty thoroughly so I'm
surprised I missed that. But I guess seeing the users of these
specifically don't allow mixing with anonymous memory the vast majority
of tests would only have one segment.

Can you confirm that you've reproduced and tested this and it actually
fixes a bug? Not just seeing something that looks strange. I have a
vague feeling it was intentional but looking at the code it looks wrong
to me too.

Thanks,

Logan

