Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644CFC4332F
	for <iommu@archiver.kernel.org>; Fri, 27 May 2022 15:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEE36616EB;
	Fri, 27 May 2022 15:35:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yly0sdKSMi2p; Fri, 27 May 2022 15:35:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C2026616C9;
	Fri, 27 May 2022 15:35:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9AE28C0039;
	Fri, 27 May 2022 15:35:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0439AC002D
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 15:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D765E84BD0
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 15:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=deltatee.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7t5IwZSJDtFB for <iommu@lists.linux-foundation.org>;
 Fri, 27 May 2022 15:35:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 81AA384BCF
 for <iommu@lists.linux-foundation.org>; Fri, 27 May 2022 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=iVJ9fBLNdTiKEt9G340BRFfSyp3FLS4feBnXCUGEiYw=; b=LK0tOmWxLk3f/jP34DJDcVbw9k
 7FkvN62gBPKgtF5GHbzQjRxhicgPqm2Y0f6rnJC1wzsiq1VPMUwE7lbhyg2Wb2wmOtwdosFsCyBev
 C+pH6Z+zfZFV7DK2Lq/L4Fx9Tzo2Esnbtf4idNVxuPx/hUdAsdtZJB+bGTuxqU8ZC6esYn25HCHlP
 C7mzMuI1d9VM5EbOwJRlj828gX7M9YfiT/tDp8fR8eVX8rPBMx/i1jYJg8S3l83aYSY8Rbxegbl79
 BKGvmLPOAVF+yorF40Wo/OhfP9diUw8Y3r/R2PGBoTMq+LtTE3+tHiLIwGLa7GSO7vvraU/8nFe0e
 5weL+HIA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1nubze-0093NF-Rc; Fri, 27 May 2022 09:35:15 -0600
Message-ID: <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
Date: Fri, 27 May 2022 09:35:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220527125501.GD2960187@ziepe.ca>
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 2022-05-27 06:55, Jason Gunthorpe wrote:
> On Thu, Apr 07, 2022 at 09:47:16AM -0600, Logan Gunthorpe wrote:
>> +static void pci_p2pdma_unmap_mappings(void *data)
>> +{
>> +	struct pci_dev *pdev = data;
>> +	struct pci_p2pdma *p2pdma = rcu_dereference_protected(pdev->p2pdma, 1);
>> +
>> +	/* Ensure no new pages can be allocated in mappings */
>> +	p2pdma->active = false;
>> +	synchronize_rcu();
>> +
>> +	unmap_mapping_range(p2pdma->inode->i_mapping, 0, 0, 1);
>> +
>> +	/*
>> +	 * On some architectures, TLB flushes are done with call_rcu()
>> +	 * so to ensure GUP fast is done with the pages, call synchronize_rcu()
>> +	 * before freeing them.
>> +	 */
>> +	synchronize_rcu();
>> +	pci_p2pdma_free_mappings(p2pdma->inode->i_mapping);
> 
> With the series from Felix getting close this should get updated to
> not set pte_devmap and use proper natural refcounting without any of
> this stuff.

Can you send a link? I'm not sure what you are referring to.

Thanks,

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
