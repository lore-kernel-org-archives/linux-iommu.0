Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224971DFCE
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 19:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rHTcdNG5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDq6pMsqtQv272S0AHm1xnXMwsyrEp6v2dWxbfGZJtJfHVJ2Hcz+5TYvNKH9QQP8RcrG7k4tT1tMvSy/J0v7VU5J0P5gDGGvOj7DLinrloBPER4F0aEkAHsbuonuKp36kUTPQu6Q+NsX37kaHEs7s+ayaWtnyDVJa6NDLIC1E3Efr7oFDhnw1QgwT+Gek8EP9yvyO+4iJeId8zN37fWEZneU9s0TqY7B6EfWys7/zAzLN5ch4YL/4Jun30xhLjBqMiRQ+WCLiRbHJqdK8+ZzVgFFowoFt6prDN1ol+K5s+mVn7QNs/7ic2BlFGv1oPDqbceOBwKdqGb0GH9oX7VW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOqa6nmIHYbHgLeyZhLY1gt81ZPTp3BA/VxqX7ZSg3Y=;
 b=eINvkuyCUIIqV/HnPBnYKrysOV6tg6pahDv+h4GeIahuF3CcGAKbhIAXhjdmH4tW/SvpyL4rLGLiSaXRSrvthAoIpPWnLCrvD1EEHnsKtvIkT3OUIzGSL/FBuWauFKWUrazMnUYOXVQj0HZJ/TEBmsqAcVHVNf9+/0yIAv6l5iXWHaSXxZKJLiOZa9Mvi9jZctmj+BbyTM5IaN0WSF7h5dXsy/BdCJ/tnyNTYK+rb1YhLz2Mhbz0AuRD5Z/MTfbSyIYQ6IKZdIhDzHQqRhzQAJH0rZZ5nf+8ozuJ1b8zGo8n+QJ/S+xtnKCwIQ4CEPRxgwb9yYNwxSJBZ/ZxclbK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOqa6nmIHYbHgLeyZhLY1gt81ZPTp3BA/VxqX7ZSg3Y=;
 b=rHTcdNG5/y17nmgT3XChUv63Q4GD8fXqE01+2rvTr5+mqvqzXqKAB2AP58LfkagcOMl5rnH9Kxm7FCC3i2XUz8HgGOJc6d/216DnRmMpVhAufgFG2GerRD70BpgsG0z/HlLFwyZongIEomt0L1Adjs6wlIb3zA4qA4U8PGi4JyRQa70lQlYWQ555nr6a3PDSVfVpf8LGaymum0ebRQpyOylQoaVPIfHXAp2O4IYrYqg8PBI47k1uA0MliRTB0fAlOua91mbNMJ/+RyjdbBSuw7H2Qa60Mh5/eCSQZYPAP51Nnv8NL3i1UQv2qAlHcc+jG99k3LVgxhxVndTXpXKSNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB8803.namprd12.prod.outlook.com (2603:10b6:806:317::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Wed, 29 Nov
 2023 19:49:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 19:49:12 +0000
Date: Wed, 29 Nov 2023 15:49:11 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	kevin.tian@intel.com, nicolinc@nvidia.com, mshavit@google.com,
	eric.auger@redhat.com, joao.m.martins@oracle.com,
	jiangkunkun@huawei.com, zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 1/5] iommu/arm-smmu-v3: Add feature detection for HTTU
Message-ID: <20231129194911.GE436702@nvidia.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128094940.1344-2-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: SA1P222CA0192.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: f16a3e1d-4e84-4531-8d1c-08dbf11442e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pSFPufELQMcZQotBBRvw42uDidHPrI6go6tVtYAtON9vIoc4qRj6/rEDX4PdTwFvQ0qSI5hYtbopyQ78JoLDf7fX1Ddys0MnoqFnL3QV2HA7fVsZPGOmNZDJ/V4oEVfPJfdw5F2eetK2SQxaEKthoAdRad+m9zVSs2YWvPa2BehX6YIc9QbW/SmmwbvNm0Ix0/5a9e7Kg3iccIGoM/W+FXQZnhlbsQr7HtzV+Fdu8fWk34rON87Ehijm9WytTQc5siRvSxr7FQOrwfBPZa38wDtWNje/2HsnKs8xSNJiiLqAz808nVdf1XldIUIthtdPpnV7BAA+L9ofrOVBAGtaThKETrHfQ2LvgRVpMm2JIODW/pP0HkVYMBDNGaPtPTkNG6SJ5oq+0hlgvl16aZNd7LfZTteAWaYWnSJ2pBK6EAKtA8ifHyF7+OjgUx97x28ZAoVUJudrlNl8JFlSw6SuPxHhADGAvqJNfS9tFmXUEuV72H3fWAygzp7KgzmLc08KYQohiV7W7G887cTGJNeTzHEBFeggtCWWLkJHa8B/UknUYtJUMjSQrJUIlQdeC7xridQCw8zhdJYimTk4skeul9Y7aMkEWYjn8R6FrRW5bJDVFq7f6wWyhThqHHKnZ/v+3ha8WXHSbsYAroy3l0JaySX/WpqVuaP9HmfjrsyL22ly6gQc6idr+3hwzEp1nehY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(5660300002)(7416002)(4326008)(8676002)(966005)(6486002)(8936002)(66556008)(38100700002)(66946007)(2906002)(66476007)(86362001)(202311291699003)(316002)(1076003)(26005)(33656002)(41300700001)(2616005)(6916009)(6506007)(36756003)(6512007)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Z1J6oTffwWJVW2U3phhu6Q1PIit4nVAjui4Vlp1j/IceeOXUOMaaBLY6bJj?=
 =?us-ascii?Q?mVQ1lmGt7LoVXY2071vByd6n3l0qt+CYpgxDSnRuGy1f8eE2/KgxOD3dUqSF?=
 =?us-ascii?Q?xH6/lSA7FyjNYSGnPZ1iz8RtXgXOZwFlb9o6/c8sCLbTIWkvd5vmIHh0UpyH?=
 =?us-ascii?Q?0ZPNc/DU3U7sy4qz9Y3jYMSSOEqj/wcpcLohCKynuzOFFxN9kP+4GnhE4xR8?=
 =?us-ascii?Q?vKXdlAt1YhF0mBQJ51G8I01l7jUAcYuSK+a64ThysfFPUiAkgMdcxHG4HyIz?=
 =?us-ascii?Q?At1Aq6DwZhJkaMyB/bsa7IVB2DgLBZwub+J2m6XFbw0BJc05UYoshFJ7HdEs?=
 =?us-ascii?Q?wRU8ItZ6Mn3bF4ZndOhexaed6cxcIyJCa4pZ5/tr8nT7HPSbKJIFhOzoHCGB?=
 =?us-ascii?Q?HeQmbQ1lcMO/dJ4zOS0XKEhLTtYh9G8oq1+wW968dIaS9fzzXo9T+iMu6aQQ?=
 =?us-ascii?Q?yxEbjfjvtbsL5nT5E8PlbNR8q07gUwZJXCX+6db4a7g/ufoX/Pp6K6Hs8eWT?=
 =?us-ascii?Q?BsT11uRhi0E9ew8ng2j4ID/36yBCaBT2JioV9SNSsRoZab5dn3hEZy6jCwoh?=
 =?us-ascii?Q?prhU+RAmbq6/zmSc8l+ETo6srzosET1Ayvv9+g25wM/wbVOD0q3WCtYeRFzx?=
 =?us-ascii?Q?wwBHlcqeAgtHl6/8tF6MLFpArKV+J/2fk8Cils20x/tmlIHPywtAbC8a4cwd?=
 =?us-ascii?Q?BFnNrVGMxY2z+ONDYDnCjMlo3bDRHt27ReBYDOC3VljYKacYDvHBrRaVZvFd?=
 =?us-ascii?Q?hjmk7WQj7UcWFtKj2WZzhBOHdeXdTXWEWs7i9qdTZBzN9FoT0vp50XNPNvFh?=
 =?us-ascii?Q?xHEa6yqUJi22XEfB6Cq7QoREa3Bixa6JsvJtwFWi7uGRIi3uYPeIhXR8tpjg?=
 =?us-ascii?Q?0gqbFdHqMXGSOw1wBxBeks9Ige9gI8IJyArgQxZuwGTloqsNCdXy63oZeuUn?=
 =?us-ascii?Q?G4Ak1AHIv466mUuuR7KwQZyOnVjVGO7blMeWFquRcMie72/JnpI1eAqvuWWr?=
 =?us-ascii?Q?mGrbtPrOfalDp59BxIXDAa5sGRUGND7xAOSdpshVR4X8S8JCnl+6uqfjjIJe?=
 =?us-ascii?Q?LwEBXkEK1KgkhToRKXwl5KIRo8tQAEnhbIxH66tRETy+bDc655lJLnfdBsJ1?=
 =?us-ascii?Q?JIRppOyrZjyZCPYoLP0mpMGACwdhtdeWEF4usx4vSP2BD8nko9bzuas+dbp8?=
 =?us-ascii?Q?xgo/kRJcJnM0Tk3AIs7GFqftw+SL3gy77PABMI4uRH4szEnibyJ+3pqON2f/?=
 =?us-ascii?Q?SbJod5RFyKxEnanvMxWDZbihiZpFT6CMBJE7AHVgz/zvmuNTNUQe4lniw1Ov?=
 =?us-ascii?Q?I3/2YtJW5/9uJzDYsxiADoSGdV/4Wee6TJV8BtdDlrFHp4oYyWVX4siM4gal?=
 =?us-ascii?Q?J8ddBIy5LkYeQx8rwEEngrHtIp09fyUjVcRB5LT2whdH14361fvEjaajGGrX?=
 =?us-ascii?Q?TeeLOynJqJp852P5jjq8Y5TsA/Lhwpomi6U0nL+iCjcuujl7wrDxu+PDfcFV?=
 =?us-ascii?Q?OA1kYUKrqtF03UGVnw4KaEDVS1hEEx53MIVYNNPQ208oLiF04Pi9Z/jDrXOo?=
 =?us-ascii?Q?zIXwX/lWNaqx3JQSJoivOjB7gG56KSY8p+HlXL9J?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16a3e1d-4e84-4531-8d1c-08dbf11442e8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 19:49:12.8609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HjetjTGZ4xnzk20t85eoqeEgtfQku/EiHTTdINvm6R1cKMSW9mTcUoOyEaEFDHvd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803

On Tue, Nov 28, 2023 at 09:49:36AM +0000, Shameer Kolothum wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> If the SMMU supports it and the kernel was built with HTTU support,
> Probe support for Hardware Translation Table Update (HTTU) which is
> essentially to enable hardware update of access and dirty flags.
> 
> Probe and set the smmu::features for Hardware Dirty and Hardware Access
> bits. This is in preparation, to enable it on the context descriptors of
> stage 1 format.
> 
> Link: https://lore.kernel.org/lkml/20210413085457.25400-5-zhukeqian1@huawei.com/
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [joaomart: Change commit message to reflect the underlying changes,
>  the Link points to the original version this was based]
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  5 ++++
>  2 files changed, 37 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
