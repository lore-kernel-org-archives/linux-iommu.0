Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573C8C433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 21:42:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0356061528
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 21:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0356061528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C005760780;
	Wed, 29 Sep 2021 21:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3gEgZI-2yt_e; Wed, 29 Sep 2021 21:42:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A6E896076A;
	Wed, 29 Sep 2021 21:42:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FF24C0011;
	Wed, 29 Sep 2021 21:42:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F35B9C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DC0566076A
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0nfgQwGZRrsx for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 21:42:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 504FD60762
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 21:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=3WA1KpyUg4a9gkCdh4NdRSTCNhCxgDrQHUyIFuEcPKQ=; b=YQ7Pgy3UA4s4WDhJgR56ldVLZa
 aarTUnhSWeZoaQ9XqoPtb8J4kCHbW5DZWtfpd6kiFewgouwOGQmyuMkSarYIcMeXLTQt4tDJSPf4a
 s3Cles1vcGAIVK5HH+sKtExXol+X/LJ0ITXpylU2RUjtAfnFitq7egHhPN+vnbLfsjBT727eeJJYW
 H7b2kX4EmNJ56lcfRB71Eg53F9hf8LVdioB4nnhm6Gm5kaDhd+o1XSlQkhJU859u9pc2Kf8Ej5LEB
 QjScyz4JhjwVsjawSaxV3AQfZ0qXHixKZL72zEfKVQ17MznS+q5nLDZ+sbw85NHk2exob1mrzGBrY
 X59623ew==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVhL0-0006W2-Fd; Wed, 29 Sep 2021 15:42:03 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
Date: Wed, 29 Sep 2021 15:42:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928195518.GV3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
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
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
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



On 2021-09-28 1:55 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:
>> +int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
>> +{
>> +	struct pci_p2pdma_map *pmap;
>> +	struct pci_p2pdma *p2pdma;
>> +	int ret;
>> +
>> +	/* prevent private mappings from being established */
>> +	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
>> +		pci_info_ratelimited(pdev,
>> +				     "%s: fail, attempted private mapping\n",
>> +				     current->comm);
>> +		return -EINVAL;
>> +	}
>> +
>> +	pmap = pci_p2pdma_map_alloc(pdev, vma->vm_end - vma->vm_start);
>> +	if (!pmap)
>> +		return -ENOMEM;
>> +
>> +	rcu_read_lock();
>> +	p2pdma = rcu_dereference(pdev->p2pdma);
>> +	if (!p2pdma) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	ret = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
>> +			    &pci_p2pdma_fs_cnt);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ihold(p2pdma->inode);
>> +	pmap->inode = p2pdma->inode;
>> +	rcu_read_unlock();
>> +
>> +	vma->vm_flags |= VM_MIXEDMAP;
> 
> Why is this a VM_MIXEDMAP? Everything fault sticks in here has a
> struct page, right?

Yes. This decision is not so simple, I tried a few variations before
settling on this.

The main reason is probably this: if we don't use VM_MIXEDMAP, then we
can't set pte_devmap(). If we don't set pte_devmap(), then every single
page that GUP processes needs to check if it's a ZONE_DEVICE page and
also if it's a P2PDMA page (thus dereferencing pgmap) in order to
satisfy the requirements of FOLL_PCI_P2PDMA.

I didn't think other developers would go for that kind of performance
hit. With VM_MIXEDMAP we hide the performance penalty behind the
existing check. And with the current pgmap code as is, we only need to
do that check once for every new pgmap pointer.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
