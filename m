Return-Path: <SRS0=fY2N=J5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB7C433B4
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 23:32:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF65610EA
	for <iommu@archiver.kernel.org>; Sun,  2 May 2021 23:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF65610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 86E884192D;
	Sun,  2 May 2021 23:32:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uCM62bY7Rb37; Sun,  2 May 2021 23:32:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EFCF41923;
	Sun,  2 May 2021 23:32:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C12ECC000D;
	Sun,  2 May 2021 23:32:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 522E6C0001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 23:32:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43B534002B
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 23:32:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4-SEBVo8liCy for <iommu@lists.linux-foundation.org>;
 Sun,  2 May 2021 23:32:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CA9F40001
 for <iommu@lists.linux-foundation.org>; Sun,  2 May 2021 23:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B36hyR8YzFAnS9eeRK/hQMlEukXxjhAhT/fGfsQ/BZBEBB5WwtDf34WwXumw51ZAEbrvEMt0OKvTuGiGr65VLFjXRbGe1tt2RrI5bPPDlJb62AwZsZ4dGG0sUN6qaP+x5KsWFHG4MSHU1d0WWxvbXx8o+ffqgGuzJBip+2dYhdfzDPEjHP1Ob8NbE3YyiTaEeQ1zaL+BRQBpkrfV//fI+x5sniHfDnnkDevC5WBE4qPp775x5pSpXAW6hCxMwS7F9ZRfDTc3a7qntHpkLrTUWQQeFO6YcAOxW5b8VT7TnzlfT3P7a9yNUkIgBGXe8eA3IpMqRXvKQIJp9rjsx72aYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcoB9rLGkprvKPLH+bPA/60/uq/DD31cxgWYpuQaEP0=;
 b=Mtfruyn3VdNf+q0uNVf598At+bo/m1vxcYRgvsZmYfA5TAKP4MYNt4XIKK7P0DXgfnW+ObiIGjCYxxV5Z1Muvt4DG6MzmW2ZA+oBEGXHSDpYT/RSaYnsvv4ZGzcu28R2QG+AQrdYSRt171j68ob0dUcelTxRJ/hoMQUoeOXooCL3haTxS7ek8wX+c614DjDC6Safp4lAzG3xV4sANFX5XA5oYrZsWCJ7uamVdBQrNSIdtMMtZOZ4LkXX4xoJAx14DMCm9lpn78je6UWG5yXOkHIJ3QkE54wTpyDOKJfiVPr6txXSB9NiEod7I9YTRGeF+qJ35meY9QJQJSlk1/t/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcoB9rLGkprvKPLH+bPA/60/uq/DD31cxgWYpuQaEP0=;
 b=MO49TZfxcwz4GnwbvoWMD9EDBonrifyetwJ/FLyO6IaYLe/k9nq0+UQQ1Hc+UponK6YQn53KvznFwjaa1w/MB7BnVAPMsvmhswVZ8O7dRCSNvGDF+EZaLf4OeEDyRV5lgiLOMU4I+3/iudNgl/uktyqmkCBZemTpeYZ3MtWLgHMedRpJ+47VkTNGkKGPxvmsFIQLzjgue9poAem4OuqHYUKtnfVipZo5kHYK6+Gp/zH+94eFnM9R796elY15tZL1LMn44N/F2ts86XP0Y59MfOm3octFgXORx4Yx81PwKS1eWStAhI7JwBhSuS5WbNoA4No8lDCZfnzRxlnLBVQI6w==
Received: from MWHPR22CA0045.namprd22.prod.outlook.com (2603:10b6:300:69::31)
 by MW2PR12MB2425.namprd12.prod.outlook.com (2603:10b6:907:f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Sun, 2 May
 2021 23:32:51 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::13) by MWHPR22CA0045.outlook.office365.com
 (2603:10b6:300:69::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Sun, 2 May 2021 23:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 23:32:50 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 23:32:50 +0000
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
From: John Hubbard <jhubbard@nvidia.com>
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
Message-ID: <f2ac9584-6133-cd3d-e9a0-bff20adfb23e@nvidia.com>
Date: Sun, 2 May 2021 16:32:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccf9cb84-36f7-42fc-2b50-08d90dc29a1f
X-MS-TrafficTypeDiagnostic: MW2PR12MB2425:
X-Microsoft-Antispam-PRVS: <MW2PR12MB24257AE763276687633D91BCA85C9@MW2PR12MB2425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE84jnW6G0vqJjT7yu4KVMnQyR3Fss9I7iTg5tFhdTUcYDwQZ/DgNNTL8ZvKQyP7a/FOe3OVGfWhMSFyHtig6uHa5P+k3bE0PyAfqBdltC7KaT338ZYBp/dBlHWAnG0Yym29oLv6XzteTXNhXpXX8eiM7qRYJFu0fwLcVZ30cVtew0xF/CPfIcCBnX8U6YEutzZQjch4RqdEJwSSgsdNEsBBHiru577OLIXjdr1KylHTFnWZ3cITF5NRy8ryEIaWgWLpXD2ojwJ3k9sducOXfU348cGJ3Xoe7CVCaxEPN2ZoCtaw10uq214a9MUh6mNAbdp3GVuq4Oz7pASwca5p7YNY+5XsC5ICF7RwEjPVD/2lLcCmEg+RVD56j6+NBfAXGsUqCir36WdZ8TDyZ/XSi/hCK2N7Jaa59tGPpAEBaXnE5ZosiNGa1IutHXuY87NbmDCj3pSCtoi+BQ/7D6in62XgdgpfgR7V86gg366TeWazHZr6eiOIUntKjXxTxMxwv7r8KFQTGSBtw71779qkqBcjJGrMXs+W2OojeFbFzFyzF6QOA45Tnt/GtcScf3S15J2ST0lICokPl5xsLRrEZw6KZfTGAdXUvAGznTJDKC7X1EFFaBT00qUfw/wTN60eBxn4CM8MCIKq8NAPz7QcrnBLpHsOEr7EOCSi+XRK0ZAFuwcmRCgiE1VfKPLLJKlWuyGf6PXU7yp2AlzMqxr/Nw==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(8676002)(186003)(36860700001)(4744005)(47076005)(82310400003)(336012)(426003)(110136005)(53546011)(478600001)(26005)(31696002)(31686004)(4326008)(70206006)(36906005)(54906003)(82740400003)(2616005)(7416002)(356005)(86362001)(316002)(7636003)(8936002)(36756003)(2906002)(70586007)(16526019)(83380400001)(5660300002)(16576012)(2101003)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 23:32:50.9216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf9cb84-36f7-42fc-2b50-08d90dc29a1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2425
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

On 5/2/21 4:28 PM, John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
...
>> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> 
> This routine now deserves a little bit of commenting, now that it is
> doing less obvious things. How about something like this:
> 
> /*
> * Unmaps pages, except for PCI_P2PDMA pages, which were never mapped in the
> * first place. Instead of unmapping PCI_P2PDMA entries, simply remove the
> * SG_PCI_P2PDMA mark
> */

I got that kind of wrong. They *were* mapped, but need to be left mostly
alone...maybe you can word it better. Here's my second draft:

/*
  * Unmaps pages, except for PCI_P2PDMA pages, which should not be unmapped at
  * this point. Instead of unmapping PCI_P2PDMA entries, simply remove the
  * SG_PCI_P2PDMA mark.
  */

...am I getting close? :)

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
