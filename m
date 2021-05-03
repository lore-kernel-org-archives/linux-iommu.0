Return-Path: <SRS0=N1FY=J6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D76CC433ED
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 23:40:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28A761208
	for <iommu@archiver.kernel.org>; Mon,  3 May 2021 23:40:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28A761208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 73D2C606A0;
	Mon,  3 May 2021 23:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R8sMq_U2xhTT; Mon,  3 May 2021 23:40:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50B45605EA;
	Mon,  3 May 2021 23:40:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3557DC000E;
	Mon,  3 May 2021 23:40:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD8B6C0001
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 23:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3AA4605EF
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 23:40:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gw4cQBm5aGsq for <iommu@lists.linux-foundation.org>;
 Mon,  3 May 2021 23:40:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750083.outbound.protection.outlook.com [40.107.75.83])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E5603605EA
 for <iommu@lists.linux-foundation.org>; Mon,  3 May 2021 23:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdRvlycAt8Qo9tsgR8vef7Tuf7J7QeDVYA3QcJDR7vCG0/NkdIPEBTDawYII5CWEk9+fe9X6VQ7qdvy79PWDJ1Od5nDljfB6dt7LXw0cIH17JP9v+3gI0mklpER538k/TLpJPjAUdioIMOmMvxWE7TmNEpvhFArYTSm1kCe1+ai84UoZlF0FMoUbG4+au4vyfjtQczsp8rWpzf3zkSbqkfxx9hJcNJw4pQ/J4Whq1AOr7seU0wIqJPQMcIGOZzi6vdVxZhlmLJcAgcN3DgrEVzvlojEjUmfRGhKJOMlX6BBg9k05aHGl6HZBW9Gd9OIZxI/LnZGGiOpBs4fid579/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2/v8sQ+foN7EfgbXRGyO4z/DRjMsu88P/bA8qiPNSQ=;
 b=PBeKoXypR9g9CiFUHLTy2tsyahjMRaQZn6H0/Z85hRofcPnQYMKaW6naNMLzFCdbu0fSIGbce/42euX1Qv0/bWUM85r34foR5jXYLdpAEQBZ2LdlzzMrBezq+7UfYkGuriVovQTkTQVR826Opzptd6Vi1yszQVnJKTdGm/o5z4ICCkzA83Jfz7DHruibyQJaRG9MhfCAIWXnEw5zFvCIu4WNr0go6WkrVtEbTR9YS0gKw7Xv/nSrkGk/boTpN1Bg7Gm+8/DUgj5pEdPw5qGCpfmlXBh//OqQYqn5oNEvzLcW/+vypW1fQyz0025uQxpXhjapm84YoXMSxMwHPIcCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2/v8sQ+foN7EfgbXRGyO4z/DRjMsu88P/bA8qiPNSQ=;
 b=dt7H9XSKBav97EJaF5Zc+JDm3Vd4x8Ct1AIT6fpzLcxx4ieo+ukqGKNPX0bxoC7C3UXMCpZ1n2bOP7A4wIo8f+oHItWTdcWcK46O2VtrzDfHz3v+uXCI5Ewdp5l/5zEXAPoJIPWk/fN8kr+k8jedYZ653w5/MphKjpMZW3bCsBFaJygSBEvx7bZoljoN8E1Io4yNT5j0rFk/Wz/mNM1IqgrgXe1+DxsB6YvWJPE3hl3sQP3GcivA7uK7ByWpC11IXfOAHD4Ol2g+x74sRnvOSlb6tirej5bUT15UX2H7EaW6XoqJUO6y9/hVLwLJDf082xPNuglhOecfgq/IUpkvJA==
Received: from BN8PR04CA0034.namprd04.prod.outlook.com (2603:10b6:408:70::47)
 by BYAPR12MB4629.namprd12.prod.outlook.com (2603:10b6:a03:111::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.39; Mon, 3 May
 2021 23:40:05 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::5f) by BN8PR04CA0034.outlook.office365.com
 (2603:10b6:408:70::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Mon, 3 May 2021 23:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 23:40:03 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 23:40:03 +0000
Subject: Re: [PATCH 04/16] PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take
 pagmap and device
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-5-logang@deltatee.com>
 <ce04d398-e4a1-b3aa-2a4e-b1b868470144@nvidia.com>
 <f719ba91-07ba-c703-2dc9-32cb1214e9c0@deltatee.com>
 <f07f0ca7-9772-5b3b-4cea-9defcefaaf8b@nvidia.com>
 <ab0e4256-79c9-c181-5aec-f6869a92a80c@deltatee.com>
 <d4f19947-d4c1-451b-311f-9e31a4ded6fc@nvidia.com>
 <20210503225705.GA2047089@ziepe.ca>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <4fd9381a-d9aa-31fe-c1d8-660e2dbaab62@nvidia.com>
Date: Mon, 3 May 2021 16:40:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503225705.GA2047089@ziepe.ca>
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deea838f-aa53-493e-1b57-08d90e8cc6a1
X-MS-TrafficTypeDiagnostic: BYAPR12MB4629:
X-Microsoft-Antispam-PRVS: <BYAPR12MB46293D41DB25DD3AFEF874B7A85B9@BYAPR12MB4629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lWIvGhcUDMoJJKp8U0LDpIZvWFN3xY3S3rTHkvXU9sHi4uPyibrkvRYXFkHIuFa5pX7tZ/PXuz5WGSZSnogLfpgE/qYVAiVU/LrfWBLKEqMh5XU0RfxLJzyLUEE3n3cZCPjxo1Gd4LmRi3mggwEb2l6Sle7BaWOnYDqB9d0SKvxGFlgAIV3/vkozHY8NLjsxtren4qmfUxerJT1T2eKR7mdZ+1S+tZcA/a/xk24WKwXNaD0dPLSwcgc4SNYE/9Ccs6ujtpop/BUFqmzgeTcmaTgK/g7dGO9N9WXZbVd/LRH2GG/Eg71gJrymKk0Mn1Dlb9raIO1lN/FcCpbDEcdGPYF+MsUp576O/G/VFmBb562ELt6b4nQCSbWs5ywp1YjH+XOCQwVs2jA5vVEqJ/YFcK4sExgtaqqo12fanwnPMXjxPPhh/25ZIrphTrXvfOOkK1+iXiJHkymBJ9ac5N1P4WdQAAajXumriIXE8pe+U30C8kw/Rw/jYweLZNTnHw9OtvgHCYMKRBsm5IzXfmcPwR6alZu7cl9P7B2KxPLmgj/3f6GY+WMLmec38rl4RuztqDVxcU+nlMHv8s0C2zXIe1oM9OdbOu5rfSV+whdgit7IPlj8IsYgtklAEGJpYuDLzy/e5kEjYGs2MrUuvVzURtxx0JQiq9pmyOrVLd4QaST8k7JRZVWq92Q9aSoJJHsP
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(54906003)(31686004)(86362001)(316002)(7416002)(82310400003)(6916009)(36906005)(31696002)(16576012)(70206006)(70586007)(2616005)(16526019)(26005)(4326008)(36860700001)(336012)(186003)(5660300002)(4744005)(426003)(8936002)(36756003)(356005)(47076005)(478600001)(53546011)(8676002)(7636003)(82740400003)(2906002)(43740500002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 23:40:03.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deea838f-aa53-493e-1b57-08d90e8cc6a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4629
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Logan Gunthorpe <logang@deltatee.com>,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 5/3/21 3:57 PM, Jason Gunthorpe wrote:
> On Mon, May 03, 2021 at 02:54:26PM -0700, John Hubbard wrote:
> 
>> I guess my main concern here is that there are these pci*() functions
>> that somehow want to pass around struct device.
> 
> Well, this is the main issue - helpers being used inside IOMMU code
> should not be called pci* functions. This is some generic device p2p
> interface that happens to only support PCI to PCI transfers today.
> 

Yes, maybe renaming a few levels of functions would help at least clarify
what the code can do. Once the code reaches layers that truly are
PCI-specific, that's where it should transition to using pci_dev args,
and that's also where it should return -ENOTSUPP back up the calling
stack.

thanks,
-- 
John Hubbard
NVIDIA
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
