Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A122C43462
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 01:37:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D4461376
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 01:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D4461376
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0219360ACD;
	Mon,  3 May 2021 01:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i6j6nKZHmj0r; Mon,  3 May 2021 01:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4D3A60A55;
	Mon,  3 May 2021 01:37:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C158C000D;
	Mon,  3 May 2021 01:37:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EBECC0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 01:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07893843CE
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 01:37:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WPa8MiMxliSR for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 01:37:25 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C9A3A843CC
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 01:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvln6nwnei3kekDhiGnQZ8T5nTkQKCHMpRxxuCP63HMhRdWFSmYSH0pSA1FTrkhR64Pr8n4CsJnz2t0LZITVVdMlt1WYnlu4ZbVEXO0MTY6yVdWoHpi4cppZVLYV2rY5M8oV2f+B7OzfbwX3v0nWg5ZChRGHLnAxoFe9vEzdPaO+D3WhbQ13Bt9RQiOGut3xS/5mrne8eFXbCcsNULhAHhLXEJC2qPysnTOozqUNGW3ejrH09xrMzvYJaKDabyS4YHiI5aUjKokwCIFfFb3VTrekam3M39fU/E4/OHV6ANzThXcHoVaq/+POXDQ8xgjy665HO12jsp6IF1g6y/uNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAq8ZM+zwJCfBI9UjlkdFmrDi2YX98u23Wk1SaBQ1sA=;
 b=S3dYVKTYsxLSjATrGS92gXZCgZjjqypo4cxOgedauApo/TR/cZqrjdsNRed9+8S2si3xzVQYqr0wAIphL8ozhQzjLd5jah0I26Pgc3f5ZS3yCzBrMeuNWWT1Pv0GNgrF8+Ez3zWEc/o4WNsBnDX0KafB/M11bapp3EiRMCj103GXKmal+atrs5Mw3MEBAeeuWjK9y7KM6Imdq4sSBpygyVXuI6bG0OHeWSOvlBFF2G27kVqrQiql44KHBEkaKxc65xDw3LmAR6hiVtz9ve9SubqE0Avhn/aNZHcDGkY1nXpxPZPsdS0omYz7ovb7X0vy8AntV++srBD8qlgawD2PrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAq8ZM+zwJCfBI9UjlkdFmrDi2YX98u23Wk1SaBQ1sA=;
 b=T7YI2NTbs03YJiQAvH/f1XL3Tz6XGs2xfrxnKJK4OCxATg8GF1AM/czvVVrNhc7A+hkqzlspS9I4o3CUrFIKw0kf5h9SMzGsCXoAYoqKMY4u2f6DraQSSkLk4xqeLyr4Bi3V9cQgdoZWxaXrZgot/7F/OJjhgEFhS9W6nYjY3pBDM5eqj4w4+VFJUd7XKryzpdUYeO6AWRGRAmLKCpGcrjcPWea7ElncVRzDV3Hwfa7Bi+zj8ZejZMo3OsZnygYeNbxo9EcI88IzhpvcGTt6iBC5znjfACFG6x+GLrO5k2JqyGyGHHNZBRnc7sYG86u17sVIAdvrkiQB4VvDTOK88g==
Received: from BN0PR04CA0050.namprd04.prod.outlook.com (2603:10b6:408:e8::25)
 by DM6PR12MB3209.namprd12.prod.outlook.com (2603:10b6:5:184::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Mon, 3 May
 2021 01:37:24 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::2c) by BN0PR04CA0050.outlook.office365.com
 (2603:10b6:408:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Mon, 3 May 2021 01:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 01:37:23 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 01:37:23 +0000
Subject: Re: [PATCH 14/16] nvme-rdma: Ensure dma support when using p2pdma
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
 <iommu@lists.linux-foundation.org>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-15-logang@deltatee.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <9715506c-5aa6-d83e-6467-b2e02ce60f22@nvidia.com>
Date: Sun, 2 May 2021 18:37:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-15-logang@deltatee.com>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f548d05-01ec-4289-3100-08d90dd4004c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3209:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3209665178FFF163F8CC32A1A85B9@DM6PR12MB3209.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EPnD/x7bFJX3aVO6YPHOM+KHmdgIb6CKZFQ7IEk8LTGMQBzXNk0eG0DL4vaZOR38iSKg1bKHWLTGNlkgBzuVtArIk/gv1IDB4Ri5oDRQoyaDReDWioeJtJPMBJrx4oZo/zsgwinLnHLJhpG03Sjqc/PKe7ST3e1e/Yk9CU6onP1yxIl5MDqjbgAGueIvc9Eu4hP2fi4uChGDpipcsMXv1qn19p7bmj/qcFpY/wBrdu+ov8OzcR6YxVp867ZNQgdg2rskd72dQ+3OzHLvldxFsOHxkvjf5ExcpQAQ35Hf3f5E0WLZeMKrWg50k70/32DwMnQtmgYBXLYEGwvdOm74+mgn+IkqZZncU5tctEM19C+czpXa3tSE3rD8Ninhrv+ld4b3SuCMbaTVV9lgX2uGY8pMO+XDbPhkjnM2+uVyvtnGGAJvWneZfRnO3TPsxQFKh/tgbcfYU65SkFP5F2WusbzLnlXaamlu9ovSH1VqdXglnQj49fkvporpSIwWAX8u+9wpTBQURxVLx0FLX+2FucSN/FFVMrxe9B5GWmacJkBL1kqFYE231mIl3q7jwDo+ms9vfTFExH6bKvC6919a8dZhSbO529sBXOWkpJFexMwG0etYJl+hXCOPco9OU4dgufg4+qh3mj3r3aEibodflwRz9e3kyr8W+gcOvu1hg2QtvJKfrfM8uNfnlv6UDWSIe6aJO4S13HW1Aib8KMwv5g==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(46966006)(2906002)(47076005)(36756003)(26005)(70586007)(36860700001)(31686004)(16526019)(186003)(53546011)(83380400001)(70206006)(8676002)(82740400003)(8936002)(336012)(5660300002)(86362001)(316002)(7636003)(31696002)(7416002)(16576012)(36906005)(478600001)(2616005)(54906003)(4326008)(356005)(110136005)(82310400003)(426003)(43740500002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 01:37:23.7107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f548d05-01ec-4289-3100-08d90dd4004c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3209
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
> Ensure the dma operations support p2pdma before using the RDMA
> device for P2PDMA. This allows switching the RDMA driver from
> pci_p2pdma_map_sg() to dma_map_sg_p2pdma().

Tentatively, this looks right, but it really should be combined
with a following patch that uses it. Then you don't have to try
to explain, above, why it's needed. :)

> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/rdma.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 6c1f3ab7649c..3ec7e77e5416 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -414,7 +414,8 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>   	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
>   		goto out_free_rsp;
>   
> -	if (!ib_uses_virt_dma(ndev->device))
> +	if (!ib_uses_virt_dma(ndev->device) &&
> +	    dma_pci_p2pdma_supported(&ndev->device->dev))
>   		r->req.p2p_client = &ndev->device->dev;
>   	r->send_sge.length = sizeof(*r->req.cqe);
>   	r->send_sge.lkey = ndev->pd->local_dma_lkey;
> 

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
