Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CDFC433F5
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 01:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 09D1440335;
	Wed,  6 Apr 2022 01:23:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Auy5_I0eNl7; Wed,  6 Apr 2022 01:23:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 640BA4032C;
	Wed,  6 Apr 2022 01:23:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30783C002C;
	Wed,  6 Apr 2022 01:23:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86690C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 01:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63BC840B10
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 01:23:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9AMNTkGi-UT for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 01:23:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::604])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 44E2640B0B
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 01:23:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eorw/CDiAIl4U0fr/ogCwOfafaYNBUwK3ue9u6YCsf3/YiSnjZOULLFdKq52O2zb4NmWLQ9bjiHmDvjFHymAisudB2Dyz8ru2Rt36Nqd+or43pBufsfamCTCjgg+7unDjpWKcVLfaTFyCAs0POOlNKLyGeocOcXktLu4T375jlFwo+QstcxEm1c3k3cDYVrKWpndz7RMDTUKtS9wzUgyWCoTwIC5wU+4BkMjdXXanW9kSLMtJdV9ovl8/1wjjQCF8AeS7bjIWteOmbMZ8IqCR/oH0zPG92uE5UfwiVO2zqZY6lVDrnRn0MagQk3/6UObklWG480II6if57BRJTrLaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX7nY/maTs39c3y0E+mRpnC5bmYRevtZdC0o0y0MuR0=;
 b=AfpXln2Mb3GZxPqlwGBbZ8+65YT0VG5T1atFhZTdaL3e0EsRPib2WAjjNWCVrfFOALRVz+G1qKQtTHvdxy0JAGvyGiSQ5XqpnFCcd2j9zNRKFwEyLV2dI3F2do75BWyZiiuzfmc27/0KRtu2ckqyaJ9d/43qWgq6XoG7iPbnATfVPSL72a447p6sgCIafuznwSCt8rw2ncpqeMJ68QxxGB+eWP/++87HqyJOvea22Sc/RSCv8qC9XqRb4F2wQdtmwuyzR6YukC+nsgBrm+tisRvijj+6m+wExDSuQZiHpMz2FDyZknJgBqg9lFL0MNqZNryMPSxEcBO4wMRLrUhm2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VX7nY/maTs39c3y0E+mRpnC5bmYRevtZdC0o0y0MuR0=;
 b=G8CBcKUJIEnVmPrZkiz8P1sv/GK/ovuDZ3G7zdNCVC+AHIR5ICx38I9AgREpKxweZ52pdkKVdZK4BM81u2KZjrNqPFI79bmkpUbyF8EPuSWpl1QWBTD5KQoWtXUx+AmhhLdUI3HVkpBSpS1TFPVfTIDHsgehJ8VBEBudpxaqpZDAfhS6/ZOA3rlG3GnFKmdto2PmsrLnWlQfXZbyUlUyDTAq+i/ySpy2el76hMXzP3s3iMvcijNnzjLmYvNYwXGikPARk626HBmtzDD7oomY4FaxLmkdbtHT6wo1xmYForgRY14NCI2vnWj5/OXY6Vzouc7SqEYfNBfzXJmlYdzvaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 01:23:37 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::cdfb:f88e:410b:9374%5]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 01:23:37 +0000
Date: Tue, 5 Apr 2022 22:23:34 -0300
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH RFC v2 03/11] iommu/sva: Add iommu_domain type for SVA
Message-ID: <20220406012334.GZ2120790@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-4-baolu.lu@linux.intel.com>
 <20220330190201.GB2120790@nvidia.com>
 <BN9PR11MB5276A39F481E2E31B0FCFEAE8CE39@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220402233210.GM2120790@nvidia.com>
 <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527660D99D154F922B0A628B8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:610:58::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f87a791-54dd-47d4-49d4-08da176c12e0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5030FC15C765F50152BA0A0BC2E79@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pd15dthn/j+rvXK5Hml1lQDpGAmO16+GzEDvK8awvj1U5EDg51Va4EAY7nTK5AFzj0YuqXslMTPuWvHN18t9pP4r9DseDYSDxBfHMevUj/Zlimbu/N9dsYuxQf1uciDdSTIGgW9AI8WjqmGJNVa3/FD3i0UG7ZXgOjVvOIGiHrCXKd3DIAOX3+XMak2DCKMU6ZAUfHOpnYCBdho2H1GEylWYPGcFGqNZHkxiY2JbJWDaVls14pySX60b0FuxvFxvrsm8ipRPkqmYv0O84RvgITOICtM9+DtVe/yCfMF+8QHp7zpfwbMBnmBxCZi8q9lNl2YbH0rI8TawVRC0dYxJHBTNJbtU+s04+VyyPI01YRmdCYt+gS5eauiMfGveW8hVkS0xbRuwMZLgqIp7FbmZZNfpoG8cWFOhtwjXQvgehCcIAAK3PKSLAUFerNnwqPDZ7yslokSUq5lR6/Y8hXTEQ7chpYw/3RKgio5A+Sr/YNywNLXeBhvCVBieUicXWUQp9rvGI9otSvvDV71F0MKgjb+jiOUM816I6De6Ql5m2rGSrdtJeKvtSpGvCn2fLtp2iQzo9HhxzbPmVRqLv5O+WxQ84qprvL12l+32nm4Lwykn4r7IzDqHuBhTKmzttJU4GAlxwQ38peDESLLRgMrl7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(84040400005)(54906003)(186003)(26005)(6916009)(2906002)(38100700002)(66476007)(66946007)(4326008)(66556008)(83380400001)(8676002)(6666004)(316002)(6512007)(86362001)(6486002)(33656002)(7416002)(8936002)(4744005)(1076003)(5660300002)(508600001)(36756003)(2616005)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?INVuSyJMcG7Qa5E00EEamJn1isgpVFjkr4did4xhEAHiPzjvhP476PmHgff0?=
 =?us-ascii?Q?l8Gr0GM9y7SoUsRUc6PpLNcNmZrj2kB3G5DyGWWXRjoTgyo1DT5TUXcLrw7K?=
 =?us-ascii?Q?5+KKj3qYfGFybhXrmczsUr2QhmmkoNXkK8sfrqAVlgRRDTwj3x2B91cb/FA6?=
 =?us-ascii?Q?Jt0cPlbA3imkyg0fV2jDHlrf5xNmT2aaFDzDdML6a/j5RNF/94HnFSTmgMYq?=
 =?us-ascii?Q?tHjlvF1tKJASRSUvpdSonHb3mVilxevCegeFmlTptOhNQN0hVdgxDuKcqKXq?=
 =?us-ascii?Q?bDcrOZwyZliHmv3wYCre0XAkx/PdycSKeRuphzuQpySKZ6Sbwa05EvHpKhGy?=
 =?us-ascii?Q?tL+AsU1AfaIvxj++otTXS5OTAl9i7Oj8oSJc0qWru16gEz9aL8EbAWr+eJ7h?=
 =?us-ascii?Q?c5WHD9rmRbMEag121xx2EcBWmZI5rxbOVrbs1nwfkCHLq/fsgxpl6SceJT//?=
 =?us-ascii?Q?eQP9zVDucZ34naKW/k/rvyTJCfNHCScN9riSyTjaEIKi3oRzrtomRRlip9+k?=
 =?us-ascii?Q?gQAGhsUkWxljPYXbAHZ93JBmgJhVX1x14/6Wx7ZXeTLRGCXk/NkIYG9lXfe0?=
 =?us-ascii?Q?5+d9eYSOeAErc12thKFn+YzYALVo7TVEZyoIoDWJOcjkrcJy1UtwWyEkM2sI?=
 =?us-ascii?Q?9ITbfONLvZUjA+dPbAfTGh4yJVhFnuJpg9y3gI0ufJATUA/eEdCWkOJ0W0fq?=
 =?us-ascii?Q?DQMtykNyaIfkwiQYjXmuze1xphp/E4Nlk6N9A+wRrhsfNUZt+S4HU/wdibXh?=
 =?us-ascii?Q?NbaMIhGXj0pJ4VNoLlzrKWeJYT9pG4uLBMdyEuJItdMoS6/StS4AkC7Wk5B1?=
 =?us-ascii?Q?XPH+/ASjzZuep2+gJ6uPT65Yymgx/azKOgKq2V4E96D587GwyGvfVWDIMpz2?=
 =?us-ascii?Q?Xihk5rxT84lnDGm3AStEOYlnQDjqNuRl9EgpyjhFtpOhCBcxkHTbIFeNgc0C?=
 =?us-ascii?Q?dIul+7IgAfajSQ0mzAYulqAbSPA23Vp+zRIkbnfi/DOSNhDRvTgFoXhI/TI1?=
 =?us-ascii?Q?APa9m4JYupWwKwRuSqomlHVxp9iKbk5DyV9nzdL7GLhExEYjhw+/JEIl4SlJ?=
 =?us-ascii?Q?eNBADM2eGg6xWamMr2GD10jYQwglNGgkzFDjULgqc1bQp22L/XVU2+zkAB0z?=
 =?us-ascii?Q?bFje1MeMB5gRNCzdPQNMhh5f8hHH2hzcPLDyNtluAQMlI+pLReVUv6XWOXXS?=
 =?us-ascii?Q?cSbOo5Dd9PLVHxJNnyuNQs+v8iUk9AoQDxtunWsT/6WO9rfJDIPLXW6ifjUF?=
 =?us-ascii?Q?A+VMBcY7aNjIkk/gH/+6B16xGzuN63Ns7dXLs0WonTLCCQMZjWLcqdgptU0U?=
 =?us-ascii?Q?4dcnzns8RmrwXKcpI2jFiGzuZg8mi6dFZ0zs5HhxyccgQ9sWP6WIxB9zLL4D?=
 =?us-ascii?Q?W7EMXJtjMG2p7nwl+eOTJOzCEhHpWfDeBtfRB0/6iirEv7H7T5lCgvIs61aX?=
 =?us-ascii?Q?u7sL/IF2TMMws+nqL9aG4o+nR7PVjE9POas3rrI8cqSmCIbJmPBCY8T9tL+k?=
 =?us-ascii?Q?s6H3b8nd6VJnN14fydmoJo8mvFzDe1O8zPt2/m5xI4cdCCiBkiO10tbeW1WR?=
 =?us-ascii?Q?Yz/f/J9lpMN6lC+M7HxYRrCZQyEQoMlECcMRZcHSgYhvzWNWV/Tf1yoqSEPf?=
 =?us-ascii?Q?EZ4DIzS3oJfRBruc4fBMHe8Q5F8DbIYhHuZirczsJmThlaTH567N08tm6Nn7?=
 =?us-ascii?Q?JI6Rdrv11bSsjtz43/QTp78JvOq5/ZZZPjEzkJ/0CQmMDYh5TgQKlQPXN2VT?=
 =?us-ascii?Q?2fNU+TGYyg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f87a791-54dd-47d4-49d4-08da176c12e0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 01:23:36.9285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5mWF1cGdSlbwuVb5enGYF7EWLtATY+GVBrCo14EpNOUmb+Qh8+fwGosRdHQ1gvn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, Robin Murphy <robin.murphy@arm.com>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 06, 2022 at 01:00:13AM +0000, Tian, Kevin wrote:

> > Because domains wrap more than just the IOPTE format, they have
> > additional data related to the IOMMU HW block itself. Imagine a SOC
> > with two IOMMU HW blocks that can both process the CPU IOPTE format,
> > but have different configuration.
> 
> Curious. Is it hypothesis or real? If real can you help give a concrete
> example?

Look at arm_smmu_attach_dev() - the domain has exactly one smmu
pointer which contains the base address for the SMMU IP block. If the
domain doesn't match the smmu pointer from the struct device it won't
allow attaching.

I know of ARM SOCs with many copies of the SMMU IP block.

So at least with current drivers ARM seems to have this limitation.

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
