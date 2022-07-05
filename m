Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64007CCA47B
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 17:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 769E04093F;
	Tue,  5 Jul 2022 17:32:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 769E04093F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=q0CuZBkF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UjfJwcoSQ1Q1; Tue,  5 Jul 2022 17:32:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D018740932;
	Tue,  5 Jul 2022 17:32:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D018740932
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 852F3C0032;
	Tue,  5 Jul 2022 17:32:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA2FC002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 17:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2151B60ED5
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 17:32:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2151B60ED5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com
 header.a=rsa-sha256 header.s=20200525 header.b=q0CuZBkF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J-3Rg_z48nHI for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 17:32:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7B4BF605E8
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B4BF605E8
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
 MIME-Version:Date:Message-ID:content-disposition;
 bh=uw6gGeGeVAosjqurSltbkcsr3JSl4V4C90uMFqh7wdw=; b=q0CuZBkFqjIKH3ps9CaMMTOQEI
 AFNBedKVu35Vl4VPdplPnwqDUonHv29pmmMXiYOLj70GrX4iOmi3UXGiDff/GrP/Jb2a9QSqSrbgj
 bgm6bBW0bkaIxcnhNc05TklxboL8CrZNcceGFN221zzztTfy3Lw1LCUm51Eyd9n7s5pJSQaRV9qAY
 F7GTINtcABmprfbWzFkUmDJmRES5weK1ozWd1yJ5ge7F+pmEj4FqLSILhjgO8SZRh1c21eAqLy11s
 TBYbDHVnG7okSa3WCKZUKMagr1svRYzqSdjS5IuMpapCL/+NesKI5miI0vUl7Q8AE297h6dsLOS+r
 3LTy9KaQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1o8mPS-007Tma-Ab; Tue, 05 Jul 2022 11:32:27 -0600
Message-ID: <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
Date: Tue, 5 Jul 2022 11:32:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
References: <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de> <YsRzNqmZYlgkL7fI@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YsRzNqmZYlgkL7fI@kroah.com>
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, hch@lst.de, jgg@ziepe.ca,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
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
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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



On 2022-07-05 11:21, Greg Kroah-Hartman wrote:
> On Tue, Jul 05, 2022 at 06:50:39PM +0200, Christoph Hellwig wrote:
>> [note for the newcomers, this is about allowing mmap()ing the PCIe
>> P2P memory from the generic PCI P2P code through sysfs, and more
>> importantly how to revoke it on device removal]
> 
> We allow mmap on PCIe config space today, right?  Why is this different
> from what pci_create_legacy_files() does today?
> 
>> On Tue, Jul 05, 2022 at 10:44:49AM -0600, Logan Gunthorpe wrote:
>>> We might be able to. I'm not sure. I'll have to figure out how to find
>>> that inode from the p2pdma code. I haven't found an obvious interface to
>>> do that.
>>
>> I think the right way to approach this would be a new sysfs API
>> that internally calls unmap_mapping_range internally instead of
>> exposing the inode. I suspect that might actually be the right thing
>> to do for iomem_inode as well.
> 
> Why do we need something new and how is this any different from the PCI
> binary files I mention above?  We have supported PCI hotplug for a very
> long time, do the current PCI binary sysfs files not work properly with
> mmap and removing a device?

The P2PDMA code allocates and hands out struct pages to userspace that
are backed with ZONE_DEVICE memory from a device's BAR. This is quite
different from the existing binary files mentioned above which neither
support struct pages nor allocation.

Logan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
