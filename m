Return-Path: <SRS0=ynGH=LB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1727CC47094
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 14:14:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B7C6109F
	for <iommu@archiver.kernel.org>; Mon,  7 Jun 2021 14:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B7C6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F763606CE;
	Mon,  7 Jun 2021 14:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HwVUh_71eJ0C; Mon,  7 Jun 2021 14:14:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id A2D3D605D9;
	Mon,  7 Jun 2021 14:14:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79DCCC000D;
	Mon,  7 Jun 2021 14:14:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2754BC0001
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 14:14:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1A9A582A5D
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 14:14:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1IZ26pc4Glz for <iommu@lists.linux-foundation.org>;
 Mon,  7 Jun 2021 14:14:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::62e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BB85829A9
 for <iommu@lists.linux-foundation.org>; Mon,  7 Jun 2021 14:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbjd/s9wcyqUkd67z0Iv82eXz58DZka0c6XrSoLLke3iEjg6BN8vGYnsTm8vzCaBoggfCVV1BLDYu+GpHObIDBvjMWzRKoJAe1Q29/LDGtHOIKsMS3Ep029GBw/otduoB5ITch53mzMHIlcASlfMpIbPqRYh7FcMg+M3H8MYDhO6nAVSHbG1YdWABFD+GTK3ONGv2UxClpYBQwtV6Kh50M8CQ34TqNP2KqiOxXubtcBCF7i1mUT3j+UqJMufAVmU9B0zsfjFIlWI9jYt5Mqd/Gu8qwITiq902jQVjNsTL4fbRtNX1pX0le4Z7LRckl9IO+kVVXXYddJukb7NScVkDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDnJJ0Am3hEXNxkbD56bK9p/aVD/JTaQDz/oN3zByPs=;
 b=DCh31y56gxetbMgw2ta/y6qCsMDoGkWyAoE8vJHg7aF/18s5qYGOcbwzmegqIMdvDCiRNpVu4QNBumH3lgG/VMkSjRZVu1QXPEZqiukid0pXV/9tpTflcQaCm4VzdkJxwmJ1jjXdPMTTYQdnyrBiyMS+hmL4FoSlN+Zd77LlZLd+2wgiPJZHZY/t+8Qm8aa+1qVY243vswbnZ4JxueJNs+6nnl5KtBvq09ra/yGJGwJ0B5d8/IHzagb1W7cETo/jqHuS4Cu8o65Fd1v9YLk4e78ZE4UMhmYETMYVDI8isEcXkOSt8Cg79FwzFUzRcKzfmUsskIDibCznsIhPGNyEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDnJJ0Am3hEXNxkbD56bK9p/aVD/JTaQDz/oN3zByPs=;
 b=cy7hK8wCcfKliQgtQ/F1hAE3pT/4HfAUUUZflkhKJW7a3vDGFCKOyrV+YZPggzkotl4Gxw5cBTGpLey0yO2OioKFarMwKfjbxRLJPSy7JDzBWK7A78FcBLdvqtLFOAK8cnyAFu3y3mb4oqHBgX4Us9eDJvAzouu1uKZXjIzTjnFuxXr0XAP5ASZGm/EqvzzQxLSzwOGzSaS26GlJULp2IUqr7pMUko8YwrVwug26qmj/rOVjTh+ap+G8k+4sxRy0sGue27QDL5sF0Mqk5gU5KnakmSAqLr5FK5AXgaGy3xUteVs8axIBdjMAt3bLbJfZnCsnFLm/hCsCfxVxvKy3NQ==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Mon, 7 Jun
 2021 14:14:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 14:14:26 +0000
Date: Mon, 7 Jun 2021 11:14:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC] /dev/ioasid uAPI proposal
Message-ID: <20210607141424.GF1002214@nvidia.com>
References: <20210602120111.5e5bcf93.alex.williamson@redhat.com>
 <20210602180925.GH1002214@nvidia.com>
 <20210602130053.615db578.alex.williamson@redhat.com>
 <20210602195404.GI1002214@nvidia.com>
 <20210602143734.72fb4fa4.alex.williamson@redhat.com>
 <6a9426d7-ed55-e006-9c4c-6b7c78142e39@redhat.com>
 <20210603130927.GZ1002214@nvidia.com>
 <65614634-1db4-7119-1a90-64ba5c6e9042@redhat.com>
 <20210604115805.GG1002214@nvidia.com>
 <895671cc-5ef8-bc1a-734c-e9e2fdf03652@redhat.com>
Content-Disposition: inline
In-Reply-To: <895671cc-5ef8-bc1a-734c-e9e2fdf03652@redhat.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by
 YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.27 via Frontend Transport; Mon, 7 Jun 2021 14:14:26 +0000
Received: from jgg by mlx with local (Exim 4.94)	(envelope-from
 <jgg@nvidia.com>)	id 1lqG1I-003Ijr-NO; Mon, 07 Jun 2021 11:14:24 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c898f8a-061a-4ac8-23e5-08d929be8ea7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5160D3CAB4C8919AA05A0BB6C2389@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D3XwjBKd7iIrvdoCKsyDwTyaV2gj4ZS58xqarpxcAwIVbNOLSuHVhgNSkjXyyz7NyAiKcgvGrrS6/JeCGrjyEM520rvBO4vttgCGu86x8DVx96Gn0DoWMT85hhqdq/4uk8b5r/RRlDtGgZdQzHIluopnv0tiZX6CGzf8FwkS4vJomQHOmM8boQEvz5aUKTgslEgWVrMKHA+3beMR3ucOYIacecxcMiyGmGvKgmQaR7vyFIaKP+K9xo8t6Xhgi+L+nyVryyuMn3MXc/koIXO8B4O3Ou0ZcUBU7yIIeDxNV8gwZtCoMMz6tRFsuhK1RytJi6FdWmK6/90agLR2MKPR1CayPOfYtlgib3aGOFSHEv4ycFSVQC1EwceFFu0IjKRAxCfll5Z5Ow7Eo6FKcBwSOT/u/O9oWB2WqjeabQ3F+xmMRbsNT5aKPQn5kK8EL27Sj4A55PanQN/MOjHVd1u4hOX6Vk78z0XpqGbZFlVPTNHlaww95OSqJa4bYxU7oU8dB92sIgac8nK9ro2Sy/DR3xHKOOObyhfJ+ZEnKdopI5zNGFnBBzUymZJ4wDIpSF9NBdX+bYpNifpc/eqMgGb6Ynweb15fowkTdk6vyWJgB8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB5506.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(376002)(396003)(136003)(36756003)(7416002)(1076003)(8936002)(9786002)(478600001)(9746002)(26005)(8676002)(6916009)(4744005)(2616005)(4326008)(2906002)(186003)(38100700002)(54906003)(66556008)(66476007)(66946007)(5660300002)(86362001)(316002)(426003)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7kORgXxwQdQ1kTQtKmN650L5nKjFL5Y8Dr0Ghtcqir40z2CBhKPxLYZ+1AbD?=
 =?us-ascii?Q?EBpC4CMBVSNNdAL5c9C4xjbkN5TJVM68PnoQJvq6HCces7VTUGIxPQpLQ0vJ?=
 =?us-ascii?Q?DQAf7M+k5Fhy1olpLtsdWSuYI5rWGd88uZ8Angvc52ZtKdCSqQUtfDRdWNOL?=
 =?us-ascii?Q?s68NmoXxhhP3FMRrr8/la5wI9qOJdm098/M5PVLSnB1Sh79P4cXFyVlDqzj1?=
 =?us-ascii?Q?WkxcgcjSBR0rGCnZtVs3d3NR/jxt/49hFxGhHvYEIm6EBlo1MGQM2hJfrl4H?=
 =?us-ascii?Q?kEHeroBg7BeTyhNfNO4fUJ3vZFWaDSrNICKGkfzBj6k3osqCxwrEO6OnLcN1?=
 =?us-ascii?Q?9ZT0ishEDjsbmbeqTPmNn9/YoZYGYRw/L9TomDJfNCczzoEvC/3EvVqM33xJ?=
 =?us-ascii?Q?eR9Dzi86al/MaLUROaRusaGIrEU6tsqShxs+GTeaT6WdZ0g63Y9hDPA/GY6H?=
 =?us-ascii?Q?1ZRYrn9WgARbJ8nthDQJJ4UUQugEsavkPfK+JG+IMOhwIro34rOtFk/upBCE?=
 =?us-ascii?Q?m8kPy4BVgJeoGHQComnkRZKKAxogs0hNqXjSMz1HmH/BhCcqNcbLTmomJPCM?=
 =?us-ascii?Q?MYWDU6iAsK5HvRMdS0YF1FIBKR0a8olfFkee1bg1T9ltYBOHj5jBcjzD2ehV?=
 =?us-ascii?Q?ioDblCr8NWtVat9tXzmkCAYWvV32dkX8pJwOXNRpeMfpnEdKOhXMXCoN65y5?=
 =?us-ascii?Q?4xq4xACLollWjV1kx1920BhddfKsw9hCl8LeQWL6g0TIVR8DmMUkhy7D9VAz?=
 =?us-ascii?Q?A7JZcC1MMa9K/zcKIEmaxF6QWXKPvsSaIGmm9Hj63y4cthjJrmH6IIJZzuvQ?=
 =?us-ascii?Q?9R7RV+5mDCIDIwLQvYcayRrZom/Fh/LmB3hkFvegkua8DYI8dPHApNWWfZlV?=
 =?us-ascii?Q?F6g5qqk2AL9T4Enh6H0l1adk8dCy4aVwmmRXa4rKnMO1umspeqTcxWddhK7Z?=
 =?us-ascii?Q?iYPrEzTdtwR41jmhTJ6fqfKYJ1Pn4X+71jyT6Olauz/e2Tj7/3IbY5w6DEkM?=
 =?us-ascii?Q?Jwp4ryu2b122MXQDh5cus6MDXW38eD5wXlgpZUzi+KoxR8eiswGnbx5c02XT?=
 =?us-ascii?Q?0xK86VMDZC6eHjN3QJv/ajIe9wogqfvRhpU4sisTkN9jftG9PvAmbVmDsKE+?=
 =?us-ascii?Q?R9uUYI7dflQnFG04yN23UV1RoOZyYkLuspDPYv41d6Y/O/XefYkHJ78fL8oz?=
 =?us-ascii?Q?N73SN8YpxRP9Xpb2BhYoFqF0+BA2xP1VIHNEA1X7TLdu5b0GVTTh0FrGQwtb?=
 =?us-ascii?Q?HwoMUJ6BRxqFHFOO+XC8fMA+4kIIJg8ShccWTpK/ipYcIoayXYU8wjwXbOqQ?=
 =?us-ascii?Q?/azEKQQb7WPrR/kL0vGLczNH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c898f8a-061a-4ac8-23e5-08d929be8ea7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 14:14:26.5659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnmq9lbAc8l9AEiy8w240LeWBumtlg6/aFxrH0navOamjL3KiZi+LxYy+pG5ojNo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 David Gibson <david@gibson.dropbear.id.au>
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

On Mon, Jun 07, 2021 at 11:18:33AM +0800, Jason Wang wrote:

> Note that no drivers call these things doesn't meant it was not
> supported by the spec.

Of course it does. If the spec doesn't define exactly when the driver
should call the cache flushes for no-snoop transactions then the
protocol doesn't support no-soop. 

no-snoop is only used in very specific sequences of operations, like
certain GPU usages, because regaining coherence on x86 is incredibly
expensive.

ie I wouldn't ever expect a NIC to use no-snoop because NIC's expect
packets to be processed by the CPU.

"non-coherent DMA" is some general euphemism that evokes images of
embedded platforms that don't have coherent DMA at all and have low
cost ways to regain coherence. This is not at all what we are talking
about here at all.
 
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
