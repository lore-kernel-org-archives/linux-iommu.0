Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A83C688
	for <iommu@lists.linux.dev>; Thu, 30 Nov 2023 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AjbYyt5O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M0Yy/MYuFyVWbI8xZLpP7tXROoaQ91pz3nF+xOEcvV6TZBC26saC9fsENXla6sqJqG0cwULcvg5ohNXk3q2XNhXgP4fpNT72veqHWLtU+eTXigo31tVVFUpWBAwsUQLoxuiiiuggkME9pGcvWPnzB+yBG0PTcn6KdPue1pILmEXjVtetGp1dN63Ycb+Y1dez+FQLqHXcufVcbnYVQegKufn/Z+aDG8VxZ+eQNB5eCRM09em1AyboQamN6y63fj7FDpxMoHPbbzOlJutRHFhB1t5bCXjco6DRqIk49VJT4ayVZdOrIZObrVyaMASzoO+XAjketytFHJSIXNRJFJzTOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOgAY9HFQroDepKrKbsFZi34fcMGDCPm6ZYY0uuaxUU=;
 b=YhzHx5a7MorhKoc91DvoH2vvmvbKXcwn97fP/gu9xHbPv6iZ4VqvjLUDxgh8tzMqxTa30HMXhut06D4i1i/ZQ9No8x6Q6TkcirwIOrF4UA/L0EfWLoojPikdu469R6G2PI8VUjmKMU4j9DpuWFwjohDn1cnuzEHa5EIfoZn624m6qlMoNYoVGfzwRgVQGhyqJJo26AxMM3a/OPgcuP3dTEO23o+onKBlLfcMeJ7O/dc99ug1Ve7DWA0S1mXsT6mYcX+kkoqzqeHNprAYWIQXHsqFrMJkleTyx3uVNIKCxTy0Z6Oemc+tI3S9EDvNleTqSa2d2OTJdUdEzdCBB3vPEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOgAY9HFQroDepKrKbsFZi34fcMGDCPm6ZYY0uuaxUU=;
 b=AjbYyt5Oqj5keOkEgTWs5XCNBb+3kgvi0j2q0IyLP6jvoSmHgRl6hQVO4Jjpvc2+TvxY+4a/kfEGL2qhlehkLGllxUNqLCcseUiFT97awA1vF63281WfwNEMWlqMFVLB6M6wUA9qRW6FzOQBg3D4Nw7AqM7LsYemzAFjQTGaX50bHnESyTkhjtjuyeZmla3J9wH1z/H8zS2fR7A02TrN1ic+XfGXPXvURObfOGHPfpvlfIuC6Mp16uWIIFLsGNMTaU8gkC5yrGYxrK8rr5okqxh4/xkQFVJ8eBXJRlTHAmZ0qy11YCfveUmrh3p/U79n3T9Pv4NAQKY6H3Ml526ZXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Thu, 30 Nov 2023 12:03:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 12:03:42 +0000
Date: Thu, 30 Nov 2023 08:03:40 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eauger@redhat.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 14/19] iommu/arm-smmu-v3: Remove
 arm_smmu_master->domain
Message-ID: <20231130120340.GA1124924@nvidia.com>
References: <14-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <6fff20dd-46d5-4974-a4a5-fb4e7a59ce44@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fff20dd-46d5-4974-a4a5-fb4e7a59ce44@redhat.com>
X-ClientProxiedBy: SN7P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: f54cea61-8dcc-4a67-e5e9-08dbf19c655b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DGNGDiKcrLW8kn9Yf7W4VgR1aRlAavdkSMrTOUIj5XJ395HQzvS2AA3Vo79tDXVukUJxkVokmdOfClX92o1qXq8r0Ytz+6+s8SxFDo7rabLnYAsditCwmiUvV7K5JrG3/H6i9G6XkBiLv6uX2AE9Zob9Kh0xiZpy0oVPUsq9ilZtFh6goD5CXE6u2jbA0EtP3Y6AZ80zxsYp03HAKywq3ab7MRGwOY22BXP+1OAuA0jc3Eu5WLPYY3cOQic0niiELi4AerW94ygECPN/25BwSq2eOEa0nnb5oW7H8rllixxIutwm8ZNiS73iTcnQrvAQCVNCUwGyWcUz0hvSguFoTitHFRnE1PywsWIKPycSrkmwLP1jE7LbZ7oYUFrXHw8jr7uTw3BkZHoPM592stEW9J2Di4gkU4r5Bpq1JNfqN5d0KPzD5mdOMhtin+nllI8IDw3C4RGoV0Lx1cCdeLcnJfreWooOJfglgefTgaGVVNQ3u7rOM7o2qPF22Uoo+HGEJox+duLJ1QeH1MumGERPG2ATSRrY449NSBUw+TphDZaDJaqX6DIBsyn2D5noZGWT6rMPuFgjbUd1CAd/Wyuk/zFkMIJXQoxxwkR/j3N7O7EVaD+ntpxILzw2I7Radnt0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(1076003)(26005)(6506007)(83380400001)(53546011)(2616005)(6512007)(6486002)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(478600001)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(202311291699003)(86362001)(33656002)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yR97jYw+WqcDgTg/uQwjTQlDD+PxPpM3ypK26XzwJF1Nz1jqucJCcu94h+Gj?=
 =?us-ascii?Q?qURiGnrkLDJNy4e9ertS4Bs3N/Lv78OUQBZOKybVZjlfzpSUPcT/cyHvnuvo?=
 =?us-ascii?Q?SbWgcGQJ96Mebxb1V7awma80XnJEQTYxQi49jKMbsA6PZEy3kuctxBtLC4dq?=
 =?us-ascii?Q?Bl/6MagAyVMb/Zv+Q2teOkSm16Lyekji09lF4k7vwzJcQ5JvO7SBsqWm0Aul?=
 =?us-ascii?Q?uHxeZqCubtyFa5QYx+yYhJ+RAJrOIEO7heimnY+YRGQVh6/kzpFaEBsN30lc?=
 =?us-ascii?Q?nnrxQaZMKfh2zC/Vg5/u0ZyheqYfF1DDJjdWcRrsxtGICi5sLke+/1pg9CU1?=
 =?us-ascii?Q?jW6OlMqgAFyJtOrwaP7z2K281b+51HTGfEx+l8LuKb1JI/NT0GO22u5Nio5o?=
 =?us-ascii?Q?FzMjSRcTkOlTmJ3mqq+Eidab2LKdvdN+fQmVWM8fxJWJ/3Q7LOPf7Gf7w83f?=
 =?us-ascii?Q?mn8KJCNn+5kUzg2UWWpqhv30sjW9RccnwRHtRLxwBC6t5OaN5WIKpHgczJg0?=
 =?us-ascii?Q?uVEpX+Z99JEMbQmpALXxMoD3g50qzUb8QqwnMI+fZOKSxH/5NSXPB3n4XTRM?=
 =?us-ascii?Q?3CIruQhB2KPguGV2EG/R6aywPzstNWsS+qqG2nFqjna/F85k6K5SFQs3iYwu?=
 =?us-ascii?Q?ir+z5XFkZ7VtETYWxU43LCI5CAOxKrGlQ6Y8wmNEUwLZlQapKAwmF7LrzsGT?=
 =?us-ascii?Q?Iz1NoNSunsm7el1FsTMfz02ZCbCwSBxzjkbKpEwfKAzsy10e/AjeknQfNceR?=
 =?us-ascii?Q?uA82Hi+XDek3EKBS5xODSZORFLJhrVJR+vmAH1AqPbaHqwdg+klq6kkB7WLd?=
 =?us-ascii?Q?frep5c/srlMyW9/5IRMlJd++R00YgW0bsCPUf5YXfSCtHNkpY5jIdY6YLOsM?=
 =?us-ascii?Q?HpeDvsIDWYflzzfF0ea4DGJ/uqtS2XSlF/86ZE4GyASvZVKn+4f/Q5wcz4+Q?=
 =?us-ascii?Q?1cLcjrUJVnqyLle2fO0eUiX67T/qRnKL8o88UNMUPJWvrKtIru9ymOX2vLMA?=
 =?us-ascii?Q?dzmLFx9ztxgC2Gpy6ADVvMvUXfncD7Nzen6EEo3tjC7J6Dp/jbPWJPCsuNeV?=
 =?us-ascii?Q?xcgA91DE7r0F1TUnAtvUbhpXGlO5Y/piSfGL+VfXIO76r1Xflc9sWSpUmDfh?=
 =?us-ascii?Q?daDXMWgVhfn8CYLro/BYpEsIbO2v7KhUGPvgwNYdnyX1DM78v55hIru1fnR3?=
 =?us-ascii?Q?Ob9ZmpqR+fDmNIlNMraThA4j1J54BH2Ht91BgRzgLrQkamtDpQjV3I88Ej41?=
 =?us-ascii?Q?IlB7ml4j7X1NIJ63VnjcPoYWRs6Gn/KcsDnAA6T5zuAsdE1KFrcLqjjqC7wM?=
 =?us-ascii?Q?fpWg/9bIxVI6qlFyc7bpxsrM8LGeYrcAqc1KifqLNEC+w9lZ3p7T7ykHS26x?=
 =?us-ascii?Q?9gZa9YpNN3b6g8gzGR3+pEt2GpKrYw2XViZsLhuHnD5gU8g1AJi7v+fB/+T+?=
 =?us-ascii?Q?hW9Ld7WuQsfxigjp1LYybP7iOVDJqI+awtWRvvkiQLe9RiOaKH36PQQieuqp?=
 =?us-ascii?Q?tSbRf7KZTSekHJSXY3RLmnVHurUVt+nllvtl8xXpHZGaEu56x7I6RUvPLKg8?=
 =?us-ascii?Q?KdO1YxeGUxawhEr1V1oqCvqrvhIJr8CHWkK+8TKD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54cea61-8dcc-4a67-e5e9-08dbf19c655b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 12:03:42.2910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nd0v2Bo7pJxYlf6xzUM+EgspcB6uvw4SvDtb1wBqAHgOt8VQEZ77KWCdCpoKhKrz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413

On Mon, Nov 27, 2023 at 06:14:30PM +0100, Eric Auger wrote:
> Hi Jason,
> 
> On 11/13/23 18:53, Jason Gunthorpe wrote:
> > Introducing global statics which are of type struct iommu_domain, not
> > struct arm_smmu_domain makes it difficult to retain
> > arm_smmu_master->domain, as it can no longer point to an IDENTITY or
> > BLOCKED domain.
> > 
> > The only place that uses the value is arm_smmu_detach_dev(). Change things
> > to work like other drivers and call iommu_get_domain_for_dev() to obtain
> > the current domain.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> This patch introduces a crash on my machine. See below.

Ah, your system must have multi-device groups

The master->domain was subtly protecting the domain_head to ensure
we don't touch it unless it is already in a domain list. This issue is
solved in part 2 (iommu/arm-smmu-v3: Make smmu_domain->devices into an
allocated list) which removes the domain_head.

This hunk should fix this patch. I updated the github

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 23dda64722ea17..102e13b65bcdec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2491,7 +2491,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	arm_smmu_disable_ats(master, smmu_domain);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
+	list_del_init(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	master->ats_enabled = false;
@@ -2606,7 +2606,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 out_list_del:
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
+	list_del_init(&master->domain_head);
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 out_unlock:
@@ -2810,6 +2810,7 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	master->dev = dev;
 	master->smmu = smmu;
 	INIT_LIST_HEAD(&master->bonds);
+	INIT_LIST_HEAD(&master->domain_head);
 	dev_iommu_priv_set(dev, master);
 
 	ret = arm_smmu_insert_master(smmu, master);



Thank!!
Jason
