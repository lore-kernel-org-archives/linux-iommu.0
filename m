Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A5EC433F5
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 13:05:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C273082BEB;
	Mon, 16 May 2022 13:05:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ZBhzzLq70XR; Mon, 16 May 2022 13:05:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C109982C9C;
	Mon, 16 May 2022 13:05:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71E58C0032;
	Mon, 16 May 2022 13:05:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD89C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:05:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 112EC61065
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:05:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WpSCNeU_VzWX for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 13:05:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06B3D60625
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:05:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZkQY7yHNDv8xyzG9wU0K7kGWfMfjrAej8nUBD1e8MVRLA5jLJjP/JUn2+tHESd+ihAiByQZnBNFn/ESeeyyg9xDqMJIeDPHR/Ovz2z0t76kVhPZzN07EiLzIDw8pyqbJkLRuI9q/0+yzdAak9fMbUFZUwoy3FSMGFz28YcxWBhGeb3RGjEjj/IGyv68GFlNviR05XdpXzGFMgr5h9zGnourB4wQv9CPVmujEEENqRn1k/E0SAiBMwkZ7x0HX71PVPXjKKrqCrzTjiGqI2zznMXSsnvG3VWu6ps5Xk/hr7LZgDYBgRC2os8+tlOV7jcCTWa39+q6Hy8ur18rY6/WJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTr6Qicmvul/EyPzmm1wj5t4Md4qU/MN5JVdmK1s+Tw=;
 b=DLD4VFTgjPdXAB0Ln/yMIN1qk/caorRRHMdYVZrRzjFa4NQrL84M8rRaKZzDKv5eb9MZtCjjUolWTNqpzHROXWipLQ8kDT5swKtJWgXJmYCMBmWS9wTQBr2MXDEsBOssCr6oQbi1gm7bHZVqmHgUAv1IsCtzr3kk7Sp8OPrbf5P3ikfFAjjYDfk8gU/+VxkiFhed8+3LqStp48oDCTEz1koEWAK21a9ZYSyW3fPWrosB3MKsN94Hrto9weoFrJjI/ItMaFQnR5WLKF7jpYyGzzjQb8FCYMyWg2D6sAblyk6bhW/ZWwWfEO4FRPFW8DO+htJV+Pe+AfdRrA+5uQWnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTr6Qicmvul/EyPzmm1wj5t4Md4qU/MN5JVdmK1s+Tw=;
 b=Kzj+Ku3pPV5f6uPHjLpLdjq0euL1T8lFO8Az7MLVLeZ/tRWd4ITNy2UJz1emcHWJ8fEhpfEmTVVeoYQD/Sz/vgclpd/BD5/uH42i+rhRYgmPhOpsaDba/9MZjtq289x+Cl50QRrrltBF2FYiv0RVk1rAXEOffFmzJ/um5Xds8rxl+YzrosI758f3++O4gqKhg9crv8jIaq2sYWlFHAsOJqnHcQbVoYp2RmVjQR0k80vxFmZk8Bb9ybSqC5vQX+/l6KkrWFVcPPVWiGLKN4Fez+lqoJi5/aqmpDvGDUkzVp5PAUzkdnf9qJoSKMoPjVec0K0wd5IQr6Sw5a48yv3WGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 13:05:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 13:05:31 +0000
Date: Mon, 16 May 2022 10:05:30 -0300
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Message-ID: <20220516130530.GU1343366@nvidia.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <YoH87WKnqtGgVCHt@infradead.org>
Content-Disposition: inline
In-Reply-To: <YoH87WKnqtGgVCHt@infradead.org>
X-ClientProxiedBy: BL1PR13CA0306.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9acce8d-6215-4338-5d2a-08da373cc1b4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5121:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5121FD9CDAF369C2415F1954C2CF9@CH0PR12MB5121.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNXnZP75TMF92CKOd5i2LRMfcV+EIz4R+yjFHDJzzw3dWXuMyVvp9zJVWOzMMlxsEWo5b3sWbqHqUcJKLeXW3HfYsUvfzJmQAPgZoOG3HEzqoqARVHSQxzPD3+I8shVLkWfH2PDPNKZ87PkXZ8ai0Rlq12Nrqw8uPLYxRLPwGD7jGqZ6KVOWHy8V8j7bwxtWA6zR/iqTqVQuuHxgclX/ZWYd/VnJRm9BGB8m7KLhfR2eKAORfNurzYHtsu+Serd1xXVFsRQjSnquGaIKlFvdfD0lQqU23A1gvdSkUhxqkdk2i0BpQKDkP/qIeo7Gn8gD+XCQFPboztRNtNy9+xYsZWfUL//NC2NCS29QJx3d4NiecLTbYGOcwWrWa/giyS34Jov4XRGWsiq0PHc4mv0k7kzycZR23QwTA47OKuuj0m5oMg9GxdnRDa1utlSvDlHy1epbJG6qg8T8QxKmI2TPgse/cIAsmDOearFgW1nVuOkc3oUeFUFQd3zeXh1Mu3eEmUgL51Rn4e1+Nx3dd4JvXq/Kbzm+KAbYqf206O99YahFl3vOuZ5zp80uw26JVIwk8wLP/zeCouvBS1O6jEsXbys914m1Czh5hVSA9lD66Jk50MvKx96dEvi/G9N/EsgaeppBdNSkMgorojGI5UFx9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(86362001)(33656002)(83380400001)(38100700002)(2906002)(508600001)(66556008)(66946007)(66476007)(5660300002)(6486002)(36756003)(54906003)(8676002)(1076003)(8936002)(6916009)(2616005)(186003)(316002)(7416002)(6506007)(4744005)(6512007)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBLxYEDf6LFTMSzef1Z1mm0wSNoB7NJvKCBAP7jTwGDk7Io3n+5y4OjIj8OQ?=
 =?us-ascii?Q?dwUd5WWEk5PTc+4Lf31hCVoxLUj+cAOdo+dK61MYpWbbRtFHkMA7EJsah+0y?=
 =?us-ascii?Q?sDB3kOeHTN0u6VyGOOgzb3c/BMIcWI2Od1D3fIPsYpOdM8FHlEDaZXDPFAlo?=
 =?us-ascii?Q?G2DHmOe90+3RLJh1izSdl6zHn/9bHBwHj5JbUTpiXkKvVOekx7y6SZk0qlf2?=
 =?us-ascii?Q?gcdNxOjyLiUGUAb09YpTE7UiTkF/EHCxIwEAUS+8YOO+1ZFvdXvTw5k4vFng?=
 =?us-ascii?Q?1mGHsgxwwSM3zeRALgi/KZjnr3pJ/bsIW01zdyUyok34guXR+ekeILmdugkK?=
 =?us-ascii?Q?5Ptzrs+NSCTpcCYDD6DZToIEKlF/Dimjni3Z62u69pybTb22KzxiZpWFV3yj?=
 =?us-ascii?Q?43ImBNrJf/+P4h9ejP0lYm8kUoi/pyfm9JbOakGsnO5HSQKpzeTMkGrROeaU?=
 =?us-ascii?Q?GrvOXhw+Obps0zhhK9vC3rw0sM25WsKKwItUkACoZLaaQDkpCrwjbG45T+OQ?=
 =?us-ascii?Q?RKaR/F1Qbe4zDhIS//lotu2UncEEvpM8W/VarPljP7PTtCglxkkmHcoGCom7?=
 =?us-ascii?Q?NJnd3mFTynJLdtn98Zlly1VygnbMop3cUhc383we95IG65tDwoxE+bZhKx/b?=
 =?us-ascii?Q?lgkjmr7NUG7yrUE2EE9FCxxEt57Pga4a2J7NXvM2FhWWrV529vsNzy0EILrh?=
 =?us-ascii?Q?y82v7MZtY1q3XjfMWVLXZjNUE+FUV+0J/dMMVXBzTjQ575tnpklCaFUdmyOf?=
 =?us-ascii?Q?0Pc32YGdh8BOIOknGaSPcCRVueG/j1Kih0EzJtrBheqXWb/DEKeQsm09eSf3?=
 =?us-ascii?Q?HVNgEJXeW1K8H7RuQ5epVZq+PFr6Kmfoqd9w3Y/5cJDKkuA4ZqJXKtaFL6WE?=
 =?us-ascii?Q?N0/7uMS9T/nEtpKcCQa2tMs6i0U2tKLokvB1lYjftTeGvxU52GD/6AXBIoqC?=
 =?us-ascii?Q?/mj6YVgaEYbusbUv4C6eMKjqvW7aBcTPhq/v1UF0Ptx6e8s9Ton2Sz9jmYAC?=
 =?us-ascii?Q?JdWzaq7ne71VwCJ0L8GDlONOQ1fCqtGlsMpOff9WgIE/ofODkCsfa++CJsAF?=
 =?us-ascii?Q?/sFXa/gFYhlIQ1xR5cyb0QpL1/uteKtY+Iww/SjNC2w3yPCqNhK32S9fpQ3t?=
 =?us-ascii?Q?aX1bgICDgvgVMUTVMvy395qq+sB+WLqqipVqJ3bb0s47I4HFDytzU6ff5Cw+?=
 =?us-ascii?Q?kcMPWvWya955rFCK8ChKdk5weKs5mTow82lPrxA4uKNCaULHz/7rX4I420ly?=
 =?us-ascii?Q?RZqR2xO5jeU6CIxpVw8NWRgFfNZ0RV688wBhnqrOq8xiWbvtFrymBUwkI5rH?=
 =?us-ascii?Q?XnFLQvSG/oaiNzfg6vZMn0ZwKUAKuGJ4KmM8tmaUUUxljEBblKI1k24Z4FSS?=
 =?us-ascii?Q?52izJ2Pp89L+Tmhw7yYH64Nn32AVuc4Kpdf8N101zleSdsZ1dX9YqOLY+25i?=
 =?us-ascii?Q?dsYVE2YDn+1iWazyfJuPpNmx2bj59ClI0G1jUUTEpdkO9HgMSb4Kwb/AnhF/?=
 =?us-ascii?Q?GWIOXoB8Z/Lcuvy52OnTrCThmCH8IfY+lY1gre1RVEI/pWTfkqNkzIOXTZoI?=
 =?us-ascii?Q?0Olo344YB9HB1H36Jz9QOMF4ps6XJmZ702PTfjkkRRhZiBSX7qQbw1vl7lTK?=
 =?us-ascii?Q?JbeH5fp5V1tSGZxczui3WpbAtrZTRQ77pUTj3OZmFX0rzKc92iAT+Y41VhtS?=
 =?us-ascii?Q?axS6rauDLpsG5b5MWKG6OXSATj4TYZGhG70Lix6mZrVAfN9hzyS+UK7cs1Hu?=
 =?us-ascii?Q?ERMlSDG/9w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9acce8d-6215-4338-5d2a-08da373cc1b4
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 13:05:31.5765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upTIiSPqtMw+4U14/LRVweL+wUeHAcseIe68pHfpBLCW3Gy/eFzbO7CyV6gZPUNV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, May 16, 2022 at 12:27:41AM -0700, Christoph Hellwig wrote:
> On Mon, May 16, 2022 at 09:57:56AM +0800, Lu Baolu wrote:
> > Each IOMMU driver must provide a blocking domain ops. If the hardware
> > supports detaching domain from device, setting blocking domain equals
> > detaching the existing domain from the deivce. Otherwise, an UNMANAGED
> > domain without any mapping will be used instead.
> 
> blocking in this case means not allowing any access?  The naming
> sounds a bit odd to me as blocking in the kernel has a specific
> meaning.  Maybe something like noaccess ops might be a better name?

It is because of this:

include/linux/iommu.h: *        IOMMU_DOMAIN_BLOCKED    - All DMA is blocked, can be used to isolate
include/linux/iommu.h:#define IOMMU_DOMAIN_BLOCKED      (0U)

noaccess might be clearer

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
