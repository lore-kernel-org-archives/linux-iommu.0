Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BBEC433EF
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 19:27:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3622E60B9F;
	Thu,  5 May 2022 19:27:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WzfCZrBcPeMV; Thu,  5 May 2022 19:27:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1C09760AB7;
	Thu,  5 May 2022 19:27:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB5EBC0032;
	Thu,  5 May 2022 19:27:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EF15C002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 19:27:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 590D460B8A
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 19:27:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GLoP-PEVLsf9 for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 19:27:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::615])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C12160AB7
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 19:27:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMNf0Ox0qmXERgOGc1L+bFMgsY3b7Gyf/6IG50VMB6a84RLZvtxGZXraVjjtfKowjVwwAYbFSiCUuFUHwEi0TdiVljn3cXKqZsfU0B+AzFqns+TNLJ69o+D6gOkp05a/hBQ4REjbeEuV1WWm7aFzhsGWfWJMqx8bOZk9lgTFjNWDBoFmkZI/hE4hMOUWY7Cu+TjBnEG1hqikJV8Jpj1YlzSs+rCk61EtBVkNK5zIlH1QAIQfSdsc90jy+VBBXhsiomdEkQC+Rh1Tv5bPdgovhPxXJboBSyQM+iXjwcMoUuDbkm3FVkTinhYkx7F9BVAp+AGIY4UiHfgzEQPaWIAoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br4oDPLRk2IE5PW4/5aBhi0n2zydEGCrVpd13ziib+0=;
 b=bMX5iY7TSzbqpSE9vM7iW+UPi0brXAtdsVr9/ccoQqoe6GS9UIYPWXnRhF52nIJtd3lREvupUjki0ShrCFaesld0pTbaX6DxCCyLMl8tEJRv4mVe7CjcMSns1KWkPE/ZuVnftgFhoJsGb9CuW0bukBAY6I5XAb6eLfLwTcFRM6ttZwEZ1XI2V8BPHwfBonT/zmgjrr9hodXbYTzwRPcaw4e2vuTbrqYPOKuwcHlh8kf/qfrHsbo6Xr8/LTkI/18GmbRXA1+hj1LK+DWUtGnp+qxpR2lXdt0bUHRf3Nq9i2GTa3hxXgC3gCEpANzoj/6LEtijXTcn0fupVaQuRq+d7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br4oDPLRk2IE5PW4/5aBhi0n2zydEGCrVpd13ziib+0=;
 b=Mo1/5hRmwoJts3eHnxy4dxdpApKhqOCIwr+lVJmVnGDUYqgt23kR4TIichdaTbRVUFrR3sQ6ZQRdyNwl30kmIn87pVmsaJ4CpAToIhQD2yHPqCvn+4DTe7b8DQ+SyCj9MFikmix1kdHqGNkr+1m5Cw45oBCzo4EwgYiQy4ZGOSqo2EhIELdkmESGwymIDcZcTx9ffzFPfTJ63/r3JKMyWXBjxFNB3vQkCeeGr1WXTzaZQL5+Pq1OQillf5U0hmIYp2c1YvvANcCqCx04/IlnwNoGXZTchAG2k1nzOpGmJBG9tnRPuthG+HNpOelwwzWQ8grAxr3srCopq7AphQWl1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 5 May
 2022 19:27:22 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%6]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 19:27:22 +0000
Date: Thu, 5 May 2022 16:27:20 -0300
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu: iommu_group_claim_dma_owner() must always
 assign a domain
Message-ID: <20220505192720.GW49344@nvidia.com>
References: <0-v2-f62259511ac0+6-iommu_dma_block_jgg@nvidia.com>
 <BN9PR11MB5276504B448C715527AD5F3F8CC29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220505153320.GS49344@nvidia.com>
 <1b8bf74a-cafa-822f-8843-0d1caf3f56ac@arm.com>
Content-Disposition: inline
In-Reply-To: <1b8bf74a-cafa-822f-8843-0d1caf3f56ac@arm.com>
X-ClientProxiedBy: BL0PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:207:3c::45) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e4e9622-ba81-4fd2-d43d-08da2ecd46d5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4076:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB40767F7C4C069383FF6F771BC2C29@DM6PR12MB4076.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FknQyuHrxeP4+ZkoarI3F3xNJAbeaMdtMnH/WqxJ4NaMH5I6ReyzpYM/hsqkr43nBeKlt2VuWZdZ68KSIHzmugXeUXUmHu/dNqw4eP1vJ/zHLM+vRZ7MGzCuqOy7z1nxjrtgaHKi6hT1z7ZQfYi6dpuOcwUGsB9Zb9AjCOr7UEHeGqwEkzoSCiRUAOm5vAWHlHGzFecmFUiQrwronmWuiSpiPcSgyQAK8n/GfYOtVPYbfOz/wBKafuA3Wln3dIkClGCCzvbLkjAcL3e9LAsdxB0jXwqz7pVaxEU0msoW6YZ1s/ulnjDMmJJZjPy53LmWM/UxWYmSO+CyaLNKH7qxwTrguzXpMZ/d7S77f+T6g08nQY1i0YuEQACAZwHj4/G9X2w7Gi2PQBf5bHxejx1YNHupRFpCzRhWWS26e0RCBkTXd/u5cbt5yrftt5Q7RiV1Yovmi23fRlPsayhRimxrF+Q/r0BRFxVIiGNo/7BgOt6Q4UtVYpFv8p/7g7soxWPuzPtMsUqU1cnBil6gK9QxWrdynRjrz71qb62oDUdCA9LLbSqBDIAv6nzrYJiH4jL6fIzR3Q/4c1/aWMkSAqRnTxlmE/RrgxOwnoh2O8cbyCEuWpFL6puhb9bp7c76ztOJEJHvkZtWwdVcAJnYJWMmug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(66556008)(66476007)(6916009)(38100700002)(66946007)(8676002)(186003)(2616005)(4326008)(54906003)(1076003)(316002)(26005)(86362001)(6506007)(8936002)(2906002)(6486002)(5660300002)(33656002)(508600001)(83380400001)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qqna8vLxzR0cT4m0n71NuYMZUrq/F7U9Phgx3uLO+q7+UHJ5YolGoxUAxrN?=
 =?us-ascii?Q?OXf95xrbP2K5lLcttbP+hs2HsvsKe/vmrmcwnmEWoQxLz5bU1+qcZ3QVuCgJ?=
 =?us-ascii?Q?Egh9SuKCXaOLrTkCS+bZnIkrclMHy7MvZL5n8UisHJ/JgpCwvzHMzUUWO5KI?=
 =?us-ascii?Q?hsORtVCrfuB5gHBo07eYtni1QDQ36xDdse6R8OAmHDgwK8PafF0MWVHDF7fj?=
 =?us-ascii?Q?Xah3InuKUbonth3WLjDh5wNST11k4xKrR99YzN1OJBlmncUbzhyLkHk0KQK0?=
 =?us-ascii?Q?JVu6wkaxyjKz8CRlmIQdEGgRfkLsUtVdfMw+Cksrc/EDVBgoD5tYFGY+xoXu?=
 =?us-ascii?Q?tnCHokmvIms9fj+4TKzg9Nekm5V/4y8HhTWdqpOPRtHnz2lPDYIerjRmh3NB?=
 =?us-ascii?Q?uOFiSB7YJY5EWpYxo5roWUHHJaT89IEp/SfumP2JLiro+Cuo3qgT5Sc/QYxB?=
 =?us-ascii?Q?CSxDqEQAKSOv4XWDsir9zMrutOayytSDxKGG4Mb37aN41qGKtuIEFx1FjEre?=
 =?us-ascii?Q?YyIx7aP51BRYSUZxy5CsR4WAaJkizyOFC7zATOnV8tuzMe6GyHQlec0wE5xO?=
 =?us-ascii?Q?io/n4QdgRptLQ/pGGF8fyuHp8Vjo5Qhz7DJsPuTfg2HMx5+R6s08ZEpLe7zy?=
 =?us-ascii?Q?DxlJuck+qydyYcQvg4Avve67FFjIB7F57M0pUlUTN3xVd3Avg++jfd414g8A?=
 =?us-ascii?Q?jwgMyXsrBrnavSgRF01dDhw+f2BEI+qWog1MwICsNMCyeXSImvdtdmOAaw6Q?=
 =?us-ascii?Q?sNAvDMVB89QqgcyGrfRTbV0fYVz3/b2q40QPHQYLK00v+g6ShZpii15UZzTC?=
 =?us-ascii?Q?hMWCw72HKaHWd3pt14ir+r4kzmTCbIM5fbNzeiUnuxy5Gb0t3pR8CZcdKJSZ?=
 =?us-ascii?Q?ah73WB1pcRMbHcPZTX077itrb0x1yyVww7wDredjw/NFJ7D4iLYOyM6yUgUK?=
 =?us-ascii?Q?uedKSZzh7ScEfFdXkTijpaJ8gV4ocO2Z8pGHM08sk9uJ0LxCyh3rbZ/HkYQv?=
 =?us-ascii?Q?2QnS56bLJUuFeHSMB20aB+/GjSO9pB5rVq/LbksbhHQkzNx5ewMhppVOYOWb?=
 =?us-ascii?Q?Tw47BmAdc94TML8Y6ZjZD9NBqHEFkBUwHDBG+G5nKFHxsb/Xhx6LO1mACmxE?=
 =?us-ascii?Q?aflGjxoP/mrYdxeI7/Y/fUOvwoCPy54CAfIb/GYarI8muLXqR/oAnJ+Ah81a?=
 =?us-ascii?Q?y9RgB42CXW/C+zh19qo5o3tW74KdUykRF4IK3YdIW6AmHfEqranIEBjnC2m8?=
 =?us-ascii?Q?LCFNGZRJMjxs0019So544fIeI6yymPwkgnZmK7F3MdV3x8isz2g9hyQZIGR0?=
 =?us-ascii?Q?YoL5AsjsqkDiQhfJw0pFnVbgz6N0Y6sf4FSeHoKzcecu8sAC91EuzYX7869u?=
 =?us-ascii?Q?uqb50X2SIo/IZcGuEP/C/8rT7IS4112m3chhCl+zTVfEmbzG+JwWMjQiBmEh?=
 =?us-ascii?Q?7NTBV1etULaCBgsmsGWwrMpmaMxXqxXY4l2daTmPwiga4QjnG+YdufDUDqwb?=
 =?us-ascii?Q?pJ3oOK7hZMQWCRD020XdO9lpHJp1TDxIlvb4ckgPSHsJiujKWtmMpaVQOk4s?=
 =?us-ascii?Q?cNsnJE/94M3B6pjVIYgAHDeKk8zcqLavZQrGWp9k2TVu+nVbAYbyAY1xwh/0?=
 =?us-ascii?Q?9rRKzIrBu6z+7yaylzIPO3C3/Ia2o31au2lPtP9K1xwWZDY11tjPa44T6fFc?=
 =?us-ascii?Q?guWkwiTzwTGeIFRzxsnMyrMDQE1VfJQACyIf1Mlbu0uaF07uDHjlNvHjNmTs?=
 =?us-ascii?Q?EXP8AQ6mGQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4e9622-ba81-4fd2-d43d-08da2ecd46d5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 19:27:21.9500 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83ONWB07+x0ia6dyzQiRb5XHGUXexaR6zbNwDKCiZpwx4XBiJcK9ldDm44DqrzAL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Rodel, Jorg" <jroedel@suse.de>,
 Qian Cai <quic_qiancai@quicinc.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>
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

On Thu, May 05, 2022 at 07:56:59PM +0100, Robin Murphy wrote:

> Ack to that, there are certainly further improvements to consider once we've
> got known-working code into a released kernel, but let's not get ahead of
> ourselves just now.

Yes please
 
> (I'm pretty sure we could get away with a single blocking domain per IOMMU
> instance, rather than per group, but I deliberately saved that one for later
> - right now one per group to match default domains is simpler to reason
> about and less churny in the context of the current ownership patches)

I noticed this too.. 

But I thought the driver can do a better job of this. There is no
reason it has to allocate memory to return a IOMMU_DOMAIN_BLOCKED
domain - this struct could be a globally allocated singleton for the
entire driver and that would be even better memory savings.

For instance, here is a sketch for the Intel driver based on Baolu's
remark that intel_iommu_detach_device() establishes a blocking
behavior already on detach_dev (Baolu if you like it can you make a
proper patch?):

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index df5c62ecf942b8..317945f6134d42 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4324,6 +4324,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
+	case IOMMU_DOMAIN_BLOCKED;
+		return &intel_blocking_domain;
 	default:
 		return NULL;
 	}
@@ -4404,12 +4406,25 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	return domain_add_dev_info(to_dmar_domain(domain), dev);
 }
 
-static void intel_iommu_detach_device(struct iommu_domain *domain,
-				      struct device *dev)
+static int intel_iommu_block_dev(struct iommu_domain *domain,
+				 struct device *dev)
 {
+	if (!device_to_iommu(dev, NULL, NULL))
+		return -EINVAL;
+
 	dmar_remove_one_dev_info(dev);
+	return 0;
 }
 
+static struct iommu_domain intel_blocking_domain {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &(const struct iommu_domain_ops){
+		.attach_dev = intel_iommu_detach_device,
+		// Fix core code so this works
+		.free = NULL,
+	},
+};
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot, gfp_t gfp)
@@ -4890,7 +4905,6 @@ const struct iommu_ops intel_iommu_ops = {
 #endif
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
-		.detach_dev		= intel_iommu_detach_device,
 		.map_pages		= intel_iommu_map_pages,
 		.unmap_pages		= intel_iommu_unmap_pages,
 		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,

Thanks,
Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
