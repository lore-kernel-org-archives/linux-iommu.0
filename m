Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796EED516
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 19:53:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0moDDgZblJJQr74hht4aCy8urgttQ/cAlDAUSsbJHVlLggzn3jZ/zLFeA6sHcqfxzLLu7jTFfOTdv0TGCc2YYekJ5l8Lq3s7pttQXAw1jh+BwzlqCUSuJhumQLq7sNumA5TuS1RZbFZ20LDRB6dDjHQvFbg+NY2BjT6Mbun9K/IvCyzXGMzoS864LgYc0FiKqHHZD0UfZokMuIEDV6Rguu6gI/NNomSa5xsv05IyGi+rJeTfZZ/uP+kkuGHEXjvwzANr4RL9VzMmhc5Jr778ZUT1tCLZhQl60wIpsU3JJlGQ6Z375ZIt/jgINfAQnUO3hfg8ExZr1pjf3GaF6sL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Iz5GD/IV5NBFzLna3Yw3Gv1yuzIh/9zVPy+wHg7XEk=;
 b=HK0j1hpWCHw8lS9dY3HUoIUZ7l0YH66oNbsU8gavpshmplquovXNiOckW/LSn/TkbMdwCbf7dUWllGrVK32CZ1WGTNCqpNbsZ+ar8PbLdgVk/UlRw7Y2rxY/HrmH/V6iV8sPcfhw4kECgH1/N2ErBCOQ7vibgcBk9X49LOTLxlD+ypvkXQwVPt909OVXuNbt+ez3T08iBsdyE1ExCh2bKRE5jzStyfAL4+Y/qLvkHY9uVg0pAZpHfYlMSYhpMQGnIbUm8JAtnYDDZlmyp/u45Jo65MeqwrsMZLQifjeCM7C/8hwgp6RV9B+cLBXCPIO+Uof050YgOKqDsOYDVjodoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Iz5GD/IV5NBFzLna3Yw3Gv1yuzIh/9zVPy+wHg7XEk=;
 b=mROLr4LKtD/pzwsups1lT8n5MCqccy4uBBd+bkoo9c0zkIdO/DsbAx2AFUL8WYTzD2j7RVDUBu07o6UqoZIFgNandZYGQ/gmTOaktyJhLNyN4+8pFuPY+RpeprUeBeuRnpXgU7BBIhDAOpbNupZ4XmF2H3cCAWwoL0W38SS2yEnRzlQGNxBTR72BgCW5KoLnUO//Cvdgdh/WdcXWrQrUYy96D/PwKdZ2EWYdlMQfAhOaNA8yPylNfTqob7foFZJT/vWIfbxgSK8OpgLVUUOq1fTXjX1j0Rh0Swvl6R3huxLe/23LU38DqFJudx7u4e3VfHDT39QkJRqEsytkqcGbEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 19:53:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 19:53:25 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: [PATCH 3/9] iommu: Use __iommu_group_set_domain() in iommu_change_dev_def_domain()
Date: Tue, 21 Mar 2023 16:53:15 -0300
Message-Id: <3-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013E03.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1b) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 896217a8-f2e4-41b4-c039-08db2a45eda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0a2aX2o8UznW2SUPNKa9CRXq1dyEJ4KKzMAEarl8SSxCiGyrC9YINsAWksbx60ZBXmRco2XkGiafMPIBlzY1RjYNS1k9KuCzrFz+wQ0wNmBoKOxZuYannB4preQVf7cpxH4YYwqqCxvySk1vumFlNhzZkDJ634/3zRstFGBnOsLan0tKyHcXdjRmuISogtccmIge4kcaalfakBm64N7KE3Nqd72+sMIFeUzPrWLWXOYKgIkB26cYBZoR295Tu+rBhjBeffoOWa+JD4FYfQunHI4QnL3858DhvR3Y3IJE+PWlAcD4O5K1eKZY36Qj1y479tuHg/wRKrYVBBvwhl/OctlImobmQoKeFlmZWM5WvzUSrqenE7WPOZte8dR0idxBF2+C7uGsyQN5jvgax9DHoNEBfYl6GXgaWmhJKjlc8CQSsE2zosIHxO7hW7gS3KyvOwfMkwJNUZF+SRVzzoLPzGo957hEjKcRyBGxXgswHKtXzG0qfD4ObZXGtIlt4EEdu+BgQSH7lN+CJrKJUtoyu2ScKi+7Gjqq2AYhSt/L+FTQdm0Wn//8F77ozu0Ulb5RVeV8s6fZ8rtZVf1dm8GTvNIIYXyewXXa+Es9WMeDGZMFuJV/7rfOskCcPn8Ae99b/U/l/UwUUE9UeTptd7d5g+Sg+391uHSfHnFUsO5wcycY3mIdAZN5ObTlNZayCp3+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199018)(66556008)(66476007)(66946007)(8676002)(4326008)(6486002)(2616005)(8936002)(186003)(5660300002)(2906002)(86362001)(110136005)(83380400001)(41300700001)(26005)(316002)(54906003)(6506007)(6512007)(478600001)(36756003)(38100700002)(6666004)(107886003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DdVSXDxgYg2/+tCr6pJJ+oduu4mKc9ssEuQQHH4ZiUjUywecD6lHkSNkoHZ7?=
 =?us-ascii?Q?eVuoAwAB1ZZsc2GVNc19E2vWvHPfPfFHFxghH61XAgpCA3SIyVIXPP0gVGdF?=
 =?us-ascii?Q?NfrCvdbsnGj5e4R98q+m8pCiOJg8Wty5Olb0jm4dNmuzFNOed7OH1PemZStW?=
 =?us-ascii?Q?iRtHUKsx1Lg9Rzfu+Q7NjzytXnh9jXCG8LjzUP9HctCMp0sfxmehQWHTXsmC?=
 =?us-ascii?Q?/Tl6seBenwPaEy8kfzlt3sjiWplVVSdmwbwhfcpDyC1NQ6+kvkXBRSQdNyX3?=
 =?us-ascii?Q?rwPcpvDxYFrStF3Q3ZSY/S9CBYrlaTl1KkZ4NwrVfFf44XmkhbAFqrp0xW1H?=
 =?us-ascii?Q?ffmHwoeJWDj41a6ZFIlfeBS4Ae1ryUMpDMtpnDOr+/mewx66sGqdOBCPk1nc?=
 =?us-ascii?Q?crM8HOZ1toC1GJ91YGDgntz9GO3OXMvP8D9eMz5jYxxiVoIhLENGEl2XTHrH?=
 =?us-ascii?Q?M4I2la27/0Fd6SGldOcUGN+CmAqMwD/8RZIyp2XeDlZ0ZFfvIpUIoyAJ3nqS?=
 =?us-ascii?Q?wJkVBk5vD1iT5UtRdBgVOxa2YC3qZjppZlolpKknF+XV+aROP6ou/Nx4Avbw?=
 =?us-ascii?Q?s7hjK9/D0rqzaSrbIdaIpNjrUg+mQqK7+Teki3FOoHBt3rZphXcmyfhicjvd?=
 =?us-ascii?Q?ugmXuN+ftXjs4+M8A1/rBZ1Clb36naDnmg713Yfz2N+14n396y8HwhMmIS6j?=
 =?us-ascii?Q?79505vg7XevbnFJKcF28ADkcZWVSXNabV9PU8ohWZM2fRQxuBAFS8epik0Fb?=
 =?us-ascii?Q?Ifwit8QDFm31tTsla/EPtL7fkiLqXpTYdoxN335QyTX1Pl2WVBjDaF90UG93?=
 =?us-ascii?Q?IRLR5UfieLOUOsTQKfn+XqQylZTHEVwfktS8S85heidl0dJCQhrV3JVYwBkQ?=
 =?us-ascii?Q?f3R3P3h+jhqlIp1msIW2NQ1kVhfGmIS2rxUnOqjtlAbq/7HHBr6/TKz3Uqyt?=
 =?us-ascii?Q?bmuUc9ZUH6+x4pidqjySBWS3698neyL3QomfUoeX3vZV3yTE30+F5I3lRrAw?=
 =?us-ascii?Q?uIg6HAMAZ7Aoytp+4QhAJ0EovXhsB1FpPu1d2YOgf6ioZInxjqg8PdfUzvCP?=
 =?us-ascii?Q?UXQ2ks5lK2Ph/eYpxnRrBy2PmkaLvxfElpWr0phHXxI6k3Crf9mbS7H1w7Bf?=
 =?us-ascii?Q?6zId5gHFbzC2WCkAN9siZnyffP2iP2u8h+Em/e+kanAu3+Zd5WSGETALbW99?=
 =?us-ascii?Q?NYLWLd1I7HE2XhIcuubStpS8bSCkfVHGAdxYA8QFkEXBVlxXWgu14m+oiQP9?=
 =?us-ascii?Q?leJZWc34TXXmPrmHtT9+Z9jVGHo787+Uoa2plNads0oEQMovLbx/Wms9lWVE?=
 =?us-ascii?Q?LXCUe1zzh9PNF8hkqTuVIN13wgv8kJks2fkK7O0Pzx7V8um8NbYvn825UF5X?=
 =?us-ascii?Q?+2lj+zXB9Cqa/2Sx9UXGWHoiDRZ6QDYc1Il2HNV7qJ9PAXEFGKCjXVi6XS7P?=
 =?us-ascii?Q?yf6tVAlZe5iGs31ufbSYuu7EEUHInrhV7TN5j4+q0kNjBt6TVcYm8b/dKSFY?=
 =?us-ascii?Q?9liCMIReDBKtJTH4g211BUi37LigS0EkT/X7eSWj4aFZdEqQIsgEbl4igou/?=
 =?us-ascii?Q?d88+nC1nrevnDgytdw8fiC3WwuwngwB8NRDV0XY3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 896217a8-f2e4-41b4-c039-08db2a45eda0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 19:53:23.2933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWywAMjOpI0Lr1TfolEKg7KTZqHrhZM3h24TllDwQ6MRTaNCqc6jv81u8oXeR0mu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

This is missing re-attach error handling if the attach fails, use the
common code.

The ugly "group->domain = prev_domain" will be cleaned in a later patch.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 96323c8cff0168..ed4d792f4bdb68 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3005,16 +3005,15 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 	if (ret)
 		goto out;
 
+	group->domain = prev_dom;
 	ret = iommu_create_device_direct_mappings(group, dev);
 	if (ret)
 		goto free_new_domain;
 
-	ret = __iommu_attach_device(group->default_domain, dev);
+	ret = __iommu_group_set_domain(group, group->default_domain);
 	if (ret)
 		goto free_new_domain;
 
-	group->domain = group->default_domain;
-
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
 	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
@@ -3031,7 +3030,6 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 free_new_domain:
 	iommu_domain_free(group->default_domain);
 	group->default_domain = prev_dom;
-	group->domain = prev_dom;
 
 out:
 	mutex_unlock(&group->mutex);
-- 
2.40.0

