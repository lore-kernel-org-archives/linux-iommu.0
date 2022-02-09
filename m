Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05621C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 13:34:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B0E124046B;
	Wed,  9 Feb 2022 13:34:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y6eABVRVOFXt; Wed,  9 Feb 2022 13:34:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 610824012E;
	Wed,  9 Feb 2022 13:34:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F50EC001A;
	Wed,  9 Feb 2022 13:34:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F012C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 404FC60F2F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:34:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70Zs3Sd3GET4 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 13:34:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7589760BB0
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 13:34:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1KMu9kDZ/h4wZ9rE+RL07XjPRaguIq3G/4wHughg3iA6WUZs/ofLxn77IwlxAx+Tnh44LPnZ7XcC+Ae5jJ2BRE1f5wd5egajcXk0fenPUuyCLhqN1a0bS38p2bX7sh1LFmh+89E52haTyFyctovovBKUJ8orit6nxAaRmSU9/7+CHVtGmCzZfb9fRzCnser3eV6jwCGQHZT8mI0XIyxDUr1KZ2VOJD3Jeke3arYBnICFzA2L6QRSH1Zr1r9OujFIifAmlpVBQ9patY2U1YXN9QL8qGUkpy8aaYKekOkyM3NYhadpEM5HTKXpn6yRvmXhS7ibtZBzJFuc+AkPJBDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrLkPO2BnCtyvGUH47nUdzHSD9JfiqKMiQdZ6uJHVmE=;
 b=QET+r1JgRXVYqeS8mUAaVR8i6OuiSZurQd9oE8z8oCtPC8EJBWXrIWTnAnP4OaKxMcEVZTs6l4geCIVAQCebm40kI1TIfAlCBNLtvAOeoxTtCvcUM5oJGEDJ2LmExO2W1Gv/OQYkqK8O5ndTPw7LbpvnS/K6vbimsfTA6jJpRW3fhF0HsY5I8dC6fOu7Hzpo3qrDib4+i/2NmhKQeM26WHtcBJfq0p7NX3mRkwfyKJH8NkTCi+WO/ri37EVIk9kYH02U/0W5ZZpjHdwm4azfBqRt5Yvsw/TcItkWCmiPqDE3U5jooTGpQrJgCgcrxZsih4gplo8CXhpBt8NcOxOpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrLkPO2BnCtyvGUH47nUdzHSD9JfiqKMiQdZ6uJHVmE=;
 b=IkfMztKuOzAZBle6pKhLNw70BPFV1TSU09HWcNZq9L0cxIQDWJEeEmQZnwy9/rKUdyl31gC1ydxmo/nuaHayWPnZjvQQS+ZUX+cPDLyiKeX5pjW2fM5aAx254vDhUkI1hnWnlCbHv8Us55nAvkOK5QsQIPvdChr81UyXLRt3f76WbrwuEcatGgEqDbz0CWkeHUlVsMcMbRQTUL5dJQaFuHk8qMd4qIf3UZNWblZ0iCQ+32kuwNF1yuJgttq/W6NVuAiTGPlPcfM3NbVIx28s/sEcHfALbZRpWQhBV+kGejP2QnpYLS55PdFNk4q0YSznFWZXzT5QcyfLRBP/trzJvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1582.namprd12.prod.outlook.com (2603:10b6:301:10::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Wed, 9 Feb
 2022 13:34:13 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:34:12 +0000
Date: Wed, 9 Feb 2022 09:34:11 -0400
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 08/10] iommu: Remove unused argument in
 is_attach_deferred
Message-ID: <20220209133411.GZ4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-9-baolu.lu@linux.intel.com>
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-9-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR02CA0031.namprd02.prod.outlook.com
 (2603:10b6:208:fc::44) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 828d6d4b-3ea2-4afa-70f4-08d9ebd0dc18
X-MS-TrafficTypeDiagnostic: MWHPR12MB1582:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1582BC19BC91333D1F042119C22E9@MWHPR12MB1582.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:345;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9zQslt8KdvzLKGz1pq3E/ifeCmroRQQ4Rv+IIV7TZbanyCIPNXVLIAlVJIz+ug4KwaLPsA4jhyjV9efYGLiso9Ih+Kj9YX9uASGhTWvjtbf3Ale1ZkglmCZRZwb3EfUcBGq16e2122g+BdQN74D4rVICv1EeluVqc/uE9/oPdZnYAxjpjyOC8oNuPyYsgii6OeWJNcU5txm4fQs+ZBuZGC44s8loysjjAwUmjP/oViCbuBJE7o2m6QgENSTcZCOYhekBQ8J2Ai4fcMhZn3AOOBX34JQwEPHdu7Csyn0AMp81l6hkY0cQJET839xTfknmVW9nl2sDwWcn2Rd/WsZvffaa7K8sY6hY84JNkgLD+xdD5fCK5ucoJB/rZ612LIiOc8rKf2/gGQn1qW8PSKKeQdXko2I1JBifKUZDazEJvvH8BfMe7sEuQOES2oXVd8bi9QUxBa4pnjN8etNhoPddJoIn4nbshVJUm1VjW1nNmcT0MGsWgbJ6nvlNXDJGt1CU64WY0jvVyPMkSI4dXIaGA6uDfXa8ZrWiFWbsq2uv1SljPhF0ZnLqTwKM/IoeRzHsA+13pT/mLvcjg5rf3hDOGCuKoejuTRIauqo1KOOg3bly//CbjC0CQxodUgJU5T+hamziKBh0H58CN0pSwddQrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(2616005)(1076003)(6506007)(6486002)(26005)(186003)(36756003)(86362001)(6916009)(33656002)(54906003)(6512007)(83380400001)(8676002)(66476007)(66556008)(66946007)(5660300002)(4326008)(2906002)(7416002)(8936002)(38100700002)(4744005)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GZQfXin+ZLGeY4fNHy9aaQRmEye4eDm1rEmbk/x1Y3L91xKNvKV6SAm7B/3H?=
 =?us-ascii?Q?8XDyQZ1gnS5qTdnk5YhlGCO81EQwxatKZazI38usZD9xNoX7IyVeEjFwzjkd?=
 =?us-ascii?Q?Gb2NfcayCVUA6v34oYWv4lAO3cQjgN52FW8QRBS2r6tN21D+0ngM/a7rxgtQ?=
 =?us-ascii?Q?sIqnxMtQyeqWtZQlcdSm7ZhUCWtoMerUQiEiGBsUdez2JTxdgYVBNGHkkFUK?=
 =?us-ascii?Q?D9xr7KnofuQfEIub6mBqw7oY1inpRR6smWtACjgLw7NpDwBVAzkP+rjBzDZs?=
 =?us-ascii?Q?7aq5UjClTZBqA9IofMAiVQgess2owxyFWemzfpainqgyevLb9Z9DYNwxY3p6?=
 =?us-ascii?Q?12Pop80itlMFL74WEwgWNbPXsWnpeerFLR1nO1O/REPGMKuYg/X5f+E4yGN4?=
 =?us-ascii?Q?eUL8xzMSCx2D5tMkZHGB+E/gKnK7oALakuf7km8Nx+wpsDFArqblwj/WWeQR?=
 =?us-ascii?Q?SrmHenMhcZVIpPMdPXR4+14Dx5qESNiN39fJNROeimLShqX1Q1HRCSp/eR1i?=
 =?us-ascii?Q?koppGygU8cv2H8wT7dB/x0PctbWBJJJ996Azc14SpC0t7QFhMa/RKNn9voYN?=
 =?us-ascii?Q?lDMkgzUrvCsSrMDzk5n06katvndl5/HsJ3iIvmj+pT9p57tIoHNneY2+1EXw?=
 =?us-ascii?Q?0DeFNArN0qhNpEGnG3DJQ+TRGPN01ucB8Ze+9ir46gJYdxIorMxBHEIeeZsB?=
 =?us-ascii?Q?p9KPfVNoZha0nn6WlvFP2Wr/9Bg1mdJLAXtz4ss1PjR+MQvUqOaHvxCREo8S?=
 =?us-ascii?Q?ujhbFPBEh1fTWtMNTKgIXc6Sf37lvNaAcN3MtLQLceARWJSb77z8GtuXLywg?=
 =?us-ascii?Q?nghHS3Ad3fRo5ZWorxP3Gpaq0MeISmqCfCrZxjkUTHK6HGCs1ZKZwaaibrJ6?=
 =?us-ascii?Q?C1kPhE4omgp5+A9XGr24RCOqOdBphzsofaY3E7/KTF439QZJjl2TMtccesLK?=
 =?us-ascii?Q?EwKbTFOE2x1pDn3bDKC0PGPTCTs2+AqgzxQ1oQXQ8C/EYmLB/pygukVTjdZn?=
 =?us-ascii?Q?ZiPAZXcBcHcbSfPCXcW15jxPg2CfJ3rWWmiRPXn5Sq5yIQTprHRVzmGTw3Fq?=
 =?us-ascii?Q?yMHEpU6tURUAnJJVyWO4yWvsV0DIoEWiGFNh+dtLphT9JBvdQMURJfVzFPkS?=
 =?us-ascii?Q?NEoffld8yPDEUYxtixGxKjKESFf6ojKAtMdNdl2kYWjR7o/DF7cB9v7ia1jQ?=
 =?us-ascii?Q?9uPeNXWGNXOmuRXar09+JjvyfZ9+lJS2QUki1UutGF9ChHtYaX6GrrOEsOs/?=
 =?us-ascii?Q?7PiNyPBX5lZHtCFzcIkNW1IT8tmm4CkgeXwsrA3tWe/RT3DlzXmfLZk3F1qV?=
 =?us-ascii?Q?ha7Cfqq7Z12AoQz0DXG63kOvpW8O6xUWhv0vL45dhIrKvepXcGDCRPm+7rTX?=
 =?us-ascii?Q?ySGIG9tTqnf/CDNHB7D3UPxkzrrT6/uOgG4yXmxA+v2ah4RRR6oI2xzPFt3j?=
 =?us-ascii?Q?P2ntio24xYp3wWoCuCBt44wXuyjkXzmogi+4z5JcbqOh66LL/dTGcsoYF1FB?=
 =?us-ascii?Q?I13yxXB06UIcgnMH+RKwMC3QIl0RAmVH4vrZjWCNFMk/MryogSj4THr/AMQr?=
 =?us-ascii?Q?I4vUzrPKAeFP3wdwiGM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828d6d4b-3ea2-4afa-70f4-08d9ebd0dc18
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:34:12.8731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esqyUeMu3eMPShI7S6KOSgvgR3Bx3xacXr1yuuw5U1CFUqDnJ/HfRS36XI5PO/pz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1582
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 David Airlie <airlied@linux.ie>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Jacob jun Pan <jacob.jun.pan@intel.com>
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

On Tue, Feb 08, 2022 at 09:25:57AM +0800, Lu Baolu wrote:
> The is_attach_deferred iommu_ops callback is a device op. The domain
> argument is unnecessary and never used. Remove it to make code clean.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         |  2 +-
>  drivers/iommu/amd/amd_iommu.h |  3 +--
>  drivers/iommu/amd/iommu.c     |  3 +--
>  drivers/iommu/amd/iommu_v2.c  |  2 +-
>  drivers/iommu/intel/iommu.c   |  3 +--
>  drivers/iommu/iommu.c         | 15 ++++++---------
>  6 files changed, 11 insertions(+), 17 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
