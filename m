Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852F6CCA47B
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 16:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1030F4091D;
	Tue,  5 Jul 2022 16:42:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1030F4091D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=K6XgjV5z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HWL6hvqT1beR; Tue,  5 Jul 2022 16:42:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4FD41400AA;
	Tue,  5 Jul 2022 16:42:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4FD41400AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C6FDC0032;
	Tue,  5 Jul 2022 16:42:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 553E5C002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 16:42:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A0FC40178
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 16:42:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A0FC40178
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com
 header.a=rsa-sha256 header.s=20200525 header.b=K6XgjV5z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EoDvq15iWyuK for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 16:42:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BAE7400A8
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BAE7400A8
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=C8Lk5zmtX8e6o/NFY86TvQ45i0l4+E0mfisBAA1KmfA=; b=K6XgjV5zJgzurqFOh3H10ZC+lZ
 sUOdc71G0WJz5hTQAbh6bf2AcHhJclo/g4AOwGPkLNfCmRojltAtRExhvHJnoH9avPf8waMiFwdfR
 6QfEUWvhSAqff6L/H0Hg4F7xEVNd+PGjGUzrlqyRDBPkMnt61QaopxIJ9uchDWmlJA7qsH+OIR+Fd
 pLimKgtUIBwdevI9TLxxwqXaUfrqq5GmOO+kWs84rj0e+uugVEPeqnUGI/rZ9/9lzs6c4QbXv5MML
 z1G4DBTFmxGcsqb2cTCmQ6DcD8WjWnmt6IOZySclbQ+N0osicOYOzPz+sx+SlezlGNGG4gwbElr4t
 eTgsjL8w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1o8lcb-007Svi-Gn; Tue, 05 Jul 2022 10:41:58 -0600
Message-ID: <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
Date: Tue, 5 Jul 2022 10:41:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220705161240.GB13721@lst.de>
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, jgg@ziepe.ca, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com,
 dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com,
 jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com,
 robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com,
 rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-block@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>,
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



On 2022-07-05 10:12, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 10:51:02AM -0300, Jason Gunthorpe wrote:
>>> In fact I'm not even sure this should be a character device, it seems
>>> to fit it way better with the PCI sysfs hierchacy, just like how we
>>> map MMIO resources, which these are anyway.  And once it is on sysfs
>>> we do have a uniqueue inode and need none of the pseudofs stuff, and
>>> don't need all the glue code in nvme either.
>>
>> Shouldn't there be an allocator here? It feels a bit weird that the
>> entire CMB is given to a single process, it is a sharable resource,
>> isn't it?
> 
> Making the entire area given by the device to the p2p allocator available
> to user space seems sensible to me.  That is what the current series does,
> and what a sysfs interface would do as well.

Yes, I think Jason is assuming the sysfs file would behave like the
existing mmio resource files where the process doing the mapping
specifies the offset and length into the BAR. That is not what we want
here, but I don't see why I don't see why we can't do the same thing in
sysfs as we do with the char device with a bin_attribute->mmap() callback.

mmapping the char device was convenient in user space, but it's not much
more work to dig through sysfs and mmap an attribute from there.

Using sysfs means we don't need all the messy callbacks from the nvme
driver, which is a plus. But I'm not sure how we'd get or unmap the
mapping of a sysfs file or avoid the anonymous inode. Seems with the
existing PCI resources, it uses an bin_attribute->f_mapping() callback
to pass back the iomem_get_mapping() mapping on file open.
revoke_iomem() is then used to nuke the VMAs. I don't think we can use
the same infrastructure here as that would add a dependency on
CONFIG_IO_STRICT_DEVMEM; which would be odd. And I'm not sure whether
there is a better way.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
