Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50B3CF04F;
	Tue,  2 Jun 2026 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415503; cv=none; b=aeitw/W/0GlzGiZC7EBMVSsiqiUxddKNXbhZZi87uC+GkZWEcgj+SgosQjNWaML38RTPeXlKSSilxP5vNuu4kfGT8sKiBc8mAINVO3Wdf4wUt7ZKRI0+8zKesO1rce0cBrmXK9kfCCWjj5dbfKR1Me6S+USNYz9I/4O96jtajvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415503; c=relaxed/simple;
	bh=UjPf1nAshjO3E2cCuBq7NnWanKG5qEjcIEFOmljMn1g=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=ZzTEokFmOH3TeOFdlv5cxJg08zm7K74TJdCcTC6l9E5TSWW5yG8sl/gSRiJKopIbajT3yrKj9UQV4fnmO2wKz6axx8E3cEQetnEM2FeRh7jqpL/5TJAT6moepILtXu5p/swfIjO5EKy32aufHNcKzNIp8kBdVbsaCwd4te+Vtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=aEo3JsOd; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="aEo3JsOd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=FwOu2JH+urIbOccTOMlvKDY+Mtkq5JlU7qhK8pW0xVg=; b=aEo3JsOdl0cLUh7ix9JNZr0Jhz
	+gAmDxfJoJhmkK+IAyzqgiuUmXdF5bokjeM7EO3LRJ0uwxya2bkETrzTWda6gDDiPDnPp1sfoVFsA
	8EM7694GscSS9BcvnTKEVd2Qb2FU2afPGs7dd/Y5fXOiykIgdpXK6Nf6f7IfQcdPcj2Ub1dOY0Z07
	drmyBWpxUzgqV0xe2IgSljXkEa5xZbckfuzbao6K6uIwoWhYIxbW7IlWL1v3eDBVE7qWVOa/xoH28
	7lCk4XcdggATscob25wtbYBDgnEQefcxZBgo9dBXdsLow4/Y0c1/aZd9Tjpq613ubX6dBmiFPhJvO
	w2pMWpFQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wURP1-00000000oQd-2O7w;
	Tue, 02 Jun 2026 09:51:40 -0600
Message-ID: <ec790b7f-d6ac-45d0-af43-556ed93a6f97@deltatee.com>
Date: Tue, 2 Jun 2026 09:51:37 -0600
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Li,Rongqing" <lirongqing@baidu.com>, Robin Murphy
 <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "hch@lst.de" <hch@lst.de>
References: <20260530112852.2321-1-lirongqing@baidu.com>
 <c666e384-b365-4891-a01d-736948b995bc@deltatee.com>
 <5e2f30a4121e4672ab309460630d011b@baidu.com>
 <ceebcd436ac44548a299ed7b44cee4c8@baidu.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <ceebcd436ac44548a299ed7b44cee4c8@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: lirongqing@baidu.com, robin.murphy@arm.com, joro@8bytes.org, will@kernel.org, baolu.lu@linux.intel.com, mcgrof@kernel.org, leon@kernel.org, bhelgaas@google.com, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW+WklumDqOmCruS7tl0gUmU6IFtQQVRDSF0gaW9t?=
 =?UTF-8?Q?mu/dma-iommu=3A_Fix_wrong_scatterlist_length_assignment_in_P2PDMA?=
 =?UTF-8?Q?_path?=
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-06-02 03:48, Li,Rongqing wrote:
> AI report this commit a25e7962db0d79 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers") has other issue, sg->dma_address is uninitialized in case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE in kernel/dma/direct.c, a possible fix is below:
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 583c592..4391b79 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -476,7 +476,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>                          * must be mapped with CPU physical address and not PCI
>                          * bus addresses.
>                          */
> -                       break;
> +                       fallthrough;
>                 case PCI_P2PDMA_MAP_NONE:
>                         need_sync = true;
>                         sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
> 

Yes, this looks correct as well. Not sure how we missed that.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks,

Logan
