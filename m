Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645F8480;
	Thu, 30 Mar 2023 15:42:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLj9ytmQbVsTWc/gYR2oQEnVyuR3MXZUc9VM+uZp24IxpIpxSoGrReSI5/+svvUAy34AEs2qBQDgLAUollILbwgiqo93GphuPFJDH8N/1Z04vkyIgAjLMkSn8xE+dSJaJFXfsfkpBld0jo5QQlgfqmp2UlY2fZ4K9YHFqMeff5FLOqgmvDtr8ErV4N1vM8XBR8XnYUf8rBuWiJuZNrRJ1HmMPY0QJ2zMuIYwexnu80zxjfajhvpsQAG8aB2lqoVCp5i34N8Y4O+M5skGJb+Q9A/7yTz6JQT5jz/ZSffe0/U9Ny17R/uexD+SngsBpzsXSlOllbhGL2Ny8+a3Y383Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zy9mfQugxMg357+mSWvSZ/HxS6grbY6KvDwAaG0QTag=;
 b=AjD+Zb9qvRgJd1NGdx8CEgZNDxFfsFjl0dFSgePNRsUBPKjA/zag/7u1DIppHE3OQ2/vfJ01LCFdmDej5FbS9N11qSb54XgrvOLXYU4t24QyxHKcoKsAbhmyXOaypv0pZ7+x4PsVlOoWAjEiMPgHRJC7R3YhRQFHCXsGBeG9VjxbXLeSu/v05iZnnq5HiVNUiVQFqAERfb/WJhpi4aH1Ah39NhJqos64nPQOpn7e3l/85ktIVT2UrAk+MFUiU5rORiB1W8db3ep2dzSpsa6StztWbvWtN5rMeVRVT20+10p/ZeOIGaErIKgLaHS5zYvw9PGFIoZRYMQiYX/f9hmWGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zy9mfQugxMg357+mSWvSZ/HxS6grbY6KvDwAaG0QTag=;
 b=LYXacRJNIQOY5CmBpGCbzomNNzTwYoyKzEJUnuWGuMyrdeFXGOnASQU9yAT1DbEbiQ+z9oxtbF81cAVPL9vrRlFNJJlJSkNx1APbpLCgGxPQYiiORfZzDF3W5undHjki27FFXhJu9tsDjEAB3aguVMzwjgj39lrqBqqt7GHlIZpxwBYd2EeBSfGagOMHun6OIwWdzkGsWFb9ZkMWWpxY9402WvHhX6kHQwxKAtRuGuBY/xw1Z34BcTtJs5bflhRHtkgCXIMr3RIAfZnFFAYqRECkK2MjOvNxSvUGTAXDJGGlIA9StJoF+eJsn+4+gDjXEzGT4xoMbOa4vkMorGoODA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8341.namprd12.prod.outlook.com (2603:10b6:8:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 15:42:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 15:42:08 +0000
Date: Thu, 30 Mar 2023 12:42:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 12/14] iommu: Consolidate the default_domain setup to
 one function
Message-ID: <ZCWtzjHIYWq6/zvg@nvidia.com>
References: <12-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
 <559f8b71-6636-b4b8-27c4-bd0764baa741@arm.com>
 <ZCWgdiT12RixU7wU@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCWgdiT12RixU7wU@nvidia.com>
X-ClientProxiedBy: MN2PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:208:236::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: 4807aa20-6d06-444e-514e-08db313551e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VBD1Zem1U3E66wji7OxkwqCTmPa+0jPavrzEUufcA7jHFQRVDOBInrT2RXRvj+kBeeXak9C9bBZJBcYicDeCkoWY/wlCqXYNRYHtYJqoM1x9+14AV+dqwv0SfBJQN7m6RjGfWBUniqQRmouTTol/TOGfVI45XoWVI2RI+I/q4wkr4FCmWOwgJeodEUlATdCqTLRA+sIDsGOVEujt0GqjOhlkGMzGaAKurO1tGhA6u/FF7Rl+6YH460nAHAJuKB4AwPGAheeqE9moLIUwvrG21yx3AoFJlxKoQz7c5cW2doXyKOMTiyFJv+W4bG3mOM9fJckAo0erta0Mxk/fkOSLLR8UTrFK5bsjBP4QM6MIAUkqZX+4qtPzzFc5neGFxG/YGW2PnU4rKujPNHfLsAT4grsQ2wGH6Ie2iNoTE/HtV07LqiSyzk7gGa/RSeH1zBqzdubtOc20PcBspliGNAx2BVoZHz/VZl6E0OUs5WYmimNarQckI04j1uAbwOOzK2VHsVH6UZelaUUX4rWCY5Z67cljqas065AHJv7WBXRl4lwXlnI4W8zI0lhoCV5P0y6K
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(83380400001)(2616005)(6486002)(54906003)(316002)(478600001)(186003)(26005)(107886003)(6512007)(6506007)(2906002)(5660300002)(4326008)(7416002)(36756003)(6916009)(38100700002)(8936002)(66476007)(86362001)(8676002)(66556008)(41300700001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWE+GA1TnxyxVqVlMyhWO/7YwFI+yFwRW2FzQHFr4r3ay0VfUy1BEt21/W7G?=
 =?us-ascii?Q?1oT0APEwU+FEjRXuAS38K9lMEHMrzksdO84MLMG/OtqS2SaiMIS4i7GjhEkz?=
 =?us-ascii?Q?f8nHDOqLUVoZZXE0yiN+X/lQmYM5FvjYJx4/vNWmfndQaQ1JvLyRBA4ywiVq?=
 =?us-ascii?Q?h6uEPDQMJp1ub/kC9SYoL8mHaiKc8krwyKQ9O/2OIEbkQS2I/iWzXDuEAMit?=
 =?us-ascii?Q?sQaXtKBC0kRxIif5zIcIJM+XmdJ5HV2G9ppJuNE8ZBXZTrAV+FrykrfK1gvl?=
 =?us-ascii?Q?9Kgc0jguwfr27b3BCRKIMvTN/OcwXzdARRNZ8C0aaOzX4u/sAuNen1NB0odv?=
 =?us-ascii?Q?RIGVQ2hER/82dXEBwrNp/82YqMFHUDkulLFoUPBGpJY+9RrvyA2cWc1YtKOS?=
 =?us-ascii?Q?egHXuakL20Ajy0BnFgrxDPmMnIW+CM55z8Re7+DMbbD3MtX0SiXZ/axyAWxZ?=
 =?us-ascii?Q?7cKKn1ZC8QF9QPfFTxp6dhYqhQShzIYDmUXKmQcRlrpqbrsraeN6clpoVJSW?=
 =?us-ascii?Q?DfKgal435XG6k8uWJxxlIyhjFCpGBfXhyA/OUmcBBk5Pp3j518Isi/SvwWh6?=
 =?us-ascii?Q?Q3M5KPAU+JcFPE3mIjlticghBlKke3/ePUp4u2xwd7Xb/ozGICsC7VN0eHaT?=
 =?us-ascii?Q?p3gu8x18hjDZYCtMJOOB+JxURHNGIpawdb84TpJDXUDn8ekJLQinQgYZyb+r?=
 =?us-ascii?Q?awTZEy8SRwRSUOeQJyO7xCaZzjaw7/FpocMbHjnomscAN9X75fvtwCXa5TqR?=
 =?us-ascii?Q?FUWPiU2EO0stoM6XFNMvTzedGRkQy26+L7bWfQfr/ONtylmh2kqHZrVkrCZz?=
 =?us-ascii?Q?jvDq8XD0tehAZ6k4sYO6j8GpD/FojFHbtMOmy0xvWmYKbv3F0RDCaSxFz/zX?=
 =?us-ascii?Q?X4B1AmEHQOO/SHS4CbqGYMI9H+dy/svwGuB6H2c2HNrbWUk1zUpcDMgzi+0P?=
 =?us-ascii?Q?VRnB0yG0hafHWxm4Wt6FQurJKhDPBjx+BQlCRlbFXZAWneD4tNpKrFQ8Y3yw?=
 =?us-ascii?Q?cmpO3Yip+5CSh3Ts1TyBmP1oA7+bnUl0jm9H3I9xOhToEteKWKgmViW5b+7o?=
 =?us-ascii?Q?MqHOlQnNFbxERBgmmrXJfqyX1Q54c+Km87QaPThk22FzLqNgnYE5whmQUkq2?=
 =?us-ascii?Q?TXFlUCPawhUTOLEGNQ/pS4hKkeaxTjx2nOG/u7rNcIi1VcR2QufBeAa96zLV?=
 =?us-ascii?Q?sc9UPjYrPA/2cD7O06unVIV6kz/3GtXPzAmOZm5aTRmsVznwzES/HetqBuef?=
 =?us-ascii?Q?9Pve+QEMOu8cJt2ff8BOYQJa+xMhusQo3bEkJJii1nRuEUoqOrETIvwbYZ4q?=
 =?us-ascii?Q?cj9ud1mEZaGDnRQrIDM5z0U8PZeJFPKRRzAu7+F1Sc4PPH7X1FBtSPBpbB7R?=
 =?us-ascii?Q?tp9c4dl9EKve+MrB2SXGursqPoaLGADYCsM9jyRbCTrudi/rtsQkDxtXvfmR?=
 =?us-ascii?Q?I3gBZHpSQNz27fIiHJVyE7Vq/t7ITl0u2dsFuLRQo2MpiqOqKKzBJL4VkGs4?=
 =?us-ascii?Q?By/7sQI5AfYa6iTMMuqMEgllyo2GFFq2Euvk3MAjUxVQADerVBwTWeukDhEB?=
 =?us-ascii?Q?Miqw8dzgXDOV4VTzuakCByyC7nqc1SswUsW+GGrU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4807aa20-6d06-444e-514e-08db313551e9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:42:08.1892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uTM+0MZ7LYvT5mije3soa1jtMq6hBGXRq6O6gGK/7AtyWFHwT8chhtMw1RJSNSkF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8341

On Thu, Mar 30, 2023 at 11:45:10AM -0300, Jason Gunthorpe wrote:

> IIRC the existing code had both orderings :( I'll add a note about
> this justification

Robin, would this be helpful in the short term for ARM?

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c31c5d6f913194..39c923e71e625a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1778,6 +1778,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	struct bus_type *bus =
 		list_first_entry(&group->devices, struct group_device, list)
 			->dev->bus;
+	bool direct_failed;
 	int req_type;
 	int ret;
 
@@ -1824,8 +1825,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	 * mapped before their device is attached, in order to guarantee
 	 * continuity with any FW activity
 	 */
+	direct_failed = false;
 	for_each_group_device(group, gdev)
-		iommu_create_device_direct_mappings(dom, gdev->dev);
+		if (iommu_create_device_direct_mappings(dom, gdev->dev))
+			direct_failed = true;
 
 	ret = __iommu_group_set_domain_internal(group, dom,
 						IOMMU_SET_DOMAIN_WITH_DEFERRED);
@@ -1845,6 +1848,16 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 		goto out_set;
 	}
 
+	/*
+	 * Driver's are supposed to allow mappings to be installed in a domain
+	 * before device attachment, but some don't. Hack around this defect by
+	 * trying again after.
+	 */
+	if (direct_failed) {
+		for_each_group_device(group, gdev)
+			iommu_create_device_direct_mappings(dom, gdev->dev);
+	}
+
 out_set:
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
