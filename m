Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517EF1382
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 09:56:46 +0000 (UTC)
Received: from 8bytes.org (p200300c27724780086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7724:7800:86ad:4f9d:2505:dd0d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 27A952A00B1;
	Sat, 19 Nov 2022 10:56:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1668851805;
	bh=+LkBA5xXUv0mQGGgdcpVe3FiMO4UP+xREbBFZkhR8mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtWKPdGByDoFolXT0n9wyZCdnBXQqJF+m7/8w5N4QZeFp4ji5KeYVCP5FAnM6A1Tr
	 MiyfsZpeoYYIhEpiF/WZIHt4NbXhzpfUF6xprm3Pn9MyuoQgqWdd6F2GtZNQVsJetX
	 0r9bLjKuhdkfNI0H/Fld4tFvD72Yka7yRHWung2NaYavJufFezjmvKzFZk512Hz7T3
	 fafoJG+/SVeHcFoCnHyqlIeNFbXvfqWdl89g4Z8fItvDWRWC2CbDiahjeCm5YAjx9B
	 DDRSYnmsPBJrE3b3bJJfz5Zt+l/5JcWax48KNTClbYxKx3cggFEUqINymv2+gqttDb
	 5Sm/28/7Bck6Q==
Date: Sat, 19 Nov 2022 10:56:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev
Subject: Re: [PATCH] iommu/amd/iommu_v2: fix pci device refcount leak in
 ppr_notifier()
Message-ID: <Y3ioW+E/J2aihv/C@8bytes.org>
References: <20221118093604.216371-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118093604.216371-1-yangyingliang@huawei.com>

On Fri, Nov 18, 2022 at 05:36:04PM +0800, Yang Yingliang wrote:
> As comment of pci_get_domain_bus_and_slot() says, it returns
> a pci device with refcount increment, when finish using it,
> the caller must decrement the reference count by calling
> pci_dev_put(). So call it before returning from ppr_notifier()
> to avoid refcount leak.
> 
> Fixes: daae2d25a477 ("iommu/amd: Don't copy GCR3 table root pointer")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iommu/amd/iommu_v2.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.
