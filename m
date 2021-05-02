Return-Path: <SRS0=fY2N=J5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B481C433B4
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 05:35:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28552613AF
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 05:35:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28552613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CABDA41E6B;
	Sun,  2 May 2021 05:35:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jz-rbuUZ7Yj9; Sun,  2 May 2021 05:35:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 342A841E65;
	Sun,  2 May 2021 05:35:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 09B35C000D;
	Sun,  2 May 2021 05:35:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 280AAC0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 05:35:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 032B3403A2
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 05:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9JfbW5RMKwYY for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 05:35:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 45E1740002
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 05:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqeDImTHLhprcmnZ0LMmvnUAMTvjzp1hBtXZxCGw0WBH1v+AIbQqxudy56NfFftFnjNeD34aESTE5Vgd7vCv8aDksmbazykEzqoKGjnmTTnelA0Zf8d3NAbpv+3iDaHeWFzbn2XM3dFmgxcMbdWDgE4NdShpm0QHybcMM5hqSg2eL5IT8P3Z4XG+E9Ab0xShygyt2Vy0kYlYzqgkGo77zG91nUfUVjvMO3oTkwOeiythNeMfH/+LB33ig/bB6TYsXRTP+92Ra42tKbNKGsOg2IMWY0Bwky/Qgcz2hLrKMPwU0c2OwBlwHu5d+cLbRAmeVauuBqSAYl0mCUw2TJBLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BVgsZiw/Vom1e13dBuF6TbjjtCEi4hPz9JEIHaXRZo=;
 b=EIcxaO5mDovdERLVeSjoz80zcI6pNxzRrEaf0v79A7O365LWybpZeRHb8eH6tZ9/US56eAibOd2W/wYp9aBInkIESqlLjMsUYH4ChkKuGaLYjcgDyCgHQvJgpWWA9K2AKUiewxM9GqdkbHPdcFHuTqwpGxX4gbFESfAKNAhAcOwe70tOnOujNNchu4A6QdSMhUiKz2kc7dG0hz8PhMHPGcaSucGN86R6fkfjE7lafzIbe4fAAseGdP1fapPSpzkfflwwzI/M9BcZlt0atVx+e8NLhNCta2U40HyX1ew2AQVlGRdtW45fe6+0tVLlBHLPY09lr9wPU2gI9cuxZ09G+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BVgsZiw/Vom1e13dBuF6TbjjtCEi4hPz9JEIHaXRZo=;
 b=MbFyrZ2041UOgtM9YRYHbNVSo1O6x4UKEU2iUVrF43nVBAcSwUuPzzY/M+gGEVr5Cmj1aKsxtbCLTvdFuD4FeQJSpqCptX9zvGZjyYizDDQfB0SZSoZL1yr2VkdAXU8NSC014u/PJ2frNV6y7WUsLzLK8rtK1hPst6gLyvBTqLaQnC9ROkTgFPAw2eGvqRCCxMzo6zHFKkLmCCEB2LKVvPH9COsQQrjb7aK4gkiwSsBjohgRr2RMJ3M0yqmant6F98c08RXXy0IoSjOdFWZa9OhS/WYICr5Guva6qr1wP/tY+JzyFmEjxJqhZASVW59G4jhaDCK1QOQOM3dYMdpRcQ==
Received: from MWHPR22CA0045.namprd22.prod.outlook.com (2603:10b6:300:69::31)
 by BYAPR12MB3430.namprd12.prod.outlook.com (2603:10b6:a03:ad::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Sun, 2 May
 2021 05:35:44 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::4d) by MWHPR22CA0045.outlook.office365.com
 (2603:10b6:300:69::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Sun, 2 May 2021 05:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 05:35:44 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 05:35:43 +0000
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-3-logang@deltatee.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
Date: Sat, 1 May 2021 22:35:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-3-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1384d45-8260-4ab7-56f8-08d90d2c21a8
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3430BB139193DDE5CA5BB2B0A85C9@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6/wPuhl3mu0i3UT6+x9GjIg+qc2a+qbJ5jz93dc1scRogUhWe/I8LQfFeL+/kZcdCwh92QIgd5vgi8IIwD9B6G/kzXLBfjc9JHTSE42O2e4c0JjbZL3Agz/cc5YzNzST/Lbjc8UHuhNlDbu2+812H7eUhINAMxnuw/QYft/ehXRd8jYws5/4VpwetqSaPswrJD6CAPmLCxxapm529wUc4xC9jj6X2a6SmIv5gYHPKhzB502zq7eS2uDNXCxMCegvKXCfhw5NEPQ9knl8QK+1HHB3UyU/mBMbJDi+XQkT+LxN6kIFx5TgiPqHdKto/XwlnNU6/W6L3e6mkTXjo0A+qSsTvbRQzUyUSCfhgaSeGaMCqSoC4NlhiNUBvM5VMIjlqeHKuTfB+m6YKH8S/zCH4bNz0sx2egPZGZm+bisSYV+DYxbXLlTXEf+6l4Ik28PQsZ1581Sf4aJHsHdOnyZa5cCPXspHWsb8f6yk5UIdGnYmMaNw3NwwQ5ygitFcx8YsNCPUTk/pXbaR1FA7/RfYf80uFYtVPBlKEeR6R/FbNoOCgiqPS+nDfrJa0Bbf5H5FgKo5e3ghfSksw4g+TXMLoioEJ1ONilbm+zkWQHIIAjQLPA6T48c18BETBNQ9fb+7439H9v9J2K4GPERfsJP27ziwumhUE1vo1J/njCGD4boQC9vc1yMs+d9IQEHRydZjKcn/+aNgt7JwW8G4SGU4g==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(82740400003)(47076005)(336012)(70206006)(2906002)(356005)(16526019)(4326008)(82310400003)(86362001)(83380400001)(70586007)(186003)(478600001)(26005)(2616005)(7636003)(316002)(36906005)(31696002)(54906003)(36860700001)(110136005)(8676002)(5660300002)(426003)(8936002)(53546011)(16576012)(31686004)(36756003)(7416002)(2101003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 05:35:44.2968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1384d45-8260-4ab7-56f8-08d90d2c21a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
Cc: Minturn Dave B <dave.b.minturn@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jason Ekstrand <jason@jlekstrand.net>,
 Bjorn Helgaas <helgaas@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 Stephen Bates <sbates@raithlin.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> In order to use upstream_bridge_distance_warn() from a dma_map function,
> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
> might sleep.
> 
> In order to avoid this, try to get the host bridge's device from
> bus->self, and if that is not set, just get the first element in the
> device list. It should be impossible for the host bridge's device to
> go away while references are held on child devices, so the first element
> should not be able to change and, thus, this should be safe.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bd89437faf06..473a08940fbc 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -311,16 +311,26 @@ static const struct pci_p2pdma_whitelist_entry {
>   static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>   				    bool same_host_bridge)
>   {
> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>   	const struct pci_p2pdma_whitelist_entry *entry;
> +	struct pci_dev *root = host->bus->self;
>   	unsigned short vendor, device;
>   
> +	/*
> +	 * This makes the assumption that the first device on the bus is the
> +	 * bridge itself and it has the devfn of 00.0. This assumption should
> +	 * hold for the devices in the white list above, and if there are cases
> +	 * where this isn't true they will have to be dealt with when such a
> +	 * case is added to the whitelist.

Actually, it makes the assumption that the first device *in the list*
(the host->bus-devices list) is 00.0.  The previous code made the
assumption that you wrote.

By the way, pre-existing code comment: pci_p2pdma_whitelist[] seems
really short. From a naive point of view, I'd expect that there must be
a lot more CPUs/chipsets that can do pci p2p, what do you think? I
wonder if we have to be so super strict, anyway. It just seems extremely
limited, and I suspect there will be some additions to the list as soon
as we start to use this.


> +	 */
>   	if (!root)
> +		root = list_first_entry_or_null(&host->bus->devices,
> +						struct pci_dev, bus_list);

OK, yes this avoids taking the pci_bus_sem, but it's kind of cheating.
Why is it OK to avoid taking any locks in order to retrieve the
first entry from the list, but in order to retrieve any other entry, you
have to aquire the pci_bus_sem, and get a reference as well? Something
is inconsistent there.

The new version here also no longer takes a reference on the device,
which is also cheating. But I'm guessing that the unstated assumption
here is that there is always at least one entry in the list. But if
that's true, then it's better to show clearly that assumption, instead
of hiding it in an implicit call that skips both locking and reference
counting.

You could add a new function, which is a cut-down version of pci_get_slot(),
like this, and call this from __host_bridge_whitelist():

/*
  * A special purpose variant of pci_get_slot() that doesn't take the pci_bus_sem
  * lock, and only looks for the 00.0 bus-device-function. Once the PCI bus is
  * up, it is safe to call this, because there will always be a top-level PCI
  * root device.
  *
  * Other assumptions: the root device is the first device in the list, and the
  * root device is numbered 00.0.
  */
struct pci_dev *pci_get_root_slot(struct pci_bus *bus)
{
	struct pci_dev *root;
	unsigned devfn = PCI_DEVFN(0, 0);

	root = list_first_entry_or_null(&bus->devices, struct pci_dev,
					bus_list);
	if (root->devfn == devfn)
		goto out;

	root = NULL;
  out:
	pci_dev_get(root);
	return root;
}
EXPORT_SYMBOL(pci_get_root_slot);

...I think that's a lot clearer to the reader, about what's going on here.

Note that I'm not really sure if it *is* safe, I would need to ask other
PCIe subsystem developers with more experience. But I don't think anyone
is trying to make p2pdma calls so early that PCIe buses are uninitialized.


> +
> +	if (!root || root->devfn)
>   		return false;
>   
>   	vendor = root->vendor;
>   	device = root->device;
> -	pci_dev_put(root);
>   
>   	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
>   		if (vendor != entry->vendor || device != entry->device)
> 

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
