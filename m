Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9615570974
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iBdpTBOB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEzEb4qwCEavKQXcrFMHbjUCukkcvZK8TcTLHjJum5MrngERGfVEo8mKkSuyTYOPiXjtFgQbCn0PIAoUhRJShQb+P+VPHkHWveHKIxH8axp7dDxOEnZZVuRt+1CuY4P/1bCzJelTvdhlceo/ddRCzB48c6rLAv7LGkBSGkggI//oCumf4cD6tDf5c6jRUqBskzrmOnOT86SwiryA+d1BpVgQDVRdbON5/FG6+YDui8dDWx0OA8oyeMmm55GKQjzwVXGUCelNFw+t8GuJgvQ3TX3Mr0Ft4TCucRUu/JecBOmKWpDBpagYKDhzKmlzapOvcXWa2AR19jsOuWDXuSyTyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMqYiCE/rM+5h31MKg0GWrzoN5VftsEUV3/Hzmdymsg=;
 b=FHZ24a5Ae4h86zhVRxDStqij1uWrnPni8pzQ6K/8FG/ZPW65APMGzCHRAYRBzxuPMURMgeJ8F4+86wiXFEbi+q+RXjGQ0OLMfh0ZK0Hr1V9ahxsi1MWowErA8+1WyJneDzE8YMxJo4smmm9Xx1cX7Y+5LRqBlUijiv/Pw01rukGXlycGY3dXxEoyH0yDYnOIQBUoNuBE6Qr08QOpudmdX+edkRwZbtL166Bm2+RmohrbUP3pVfL8HhLNoe3bHoCPboZsM8ImB9TbsqH0h94XdC2zozv+mS5RN0SasOiRk2cjClhoIl81ZVxcqudnzZQEZ3R8/yD5+Lk4wtLeGSpx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMqYiCE/rM+5h31MKg0GWrzoN5VftsEUV3/Hzmdymsg=;
 b=iBdpTBOBfdh+NcwRUN3HYYr3AiuCKo+bBiiUilc2rBhzvD46t6b4LbEl38xSsS7czNmybawAYHuaci+EWF1kTnTT4Vs6F7apvrIqHDv3CD6taxE3p4p0cpdDaBhVQfBuXALbiQ3FhAiOBZoZaF0o+I4QKKwohZO7kwrsT3WGKWID+c9Dg0wWuv3fJUJD6MUauHCLl2/qN1OWMLLMmsmepU1zKhaKjzNYvTqNY/HZWF5FKdaaWvIVttTCR5deaKo5fmCIJyZYjDG0HtSzEZ2zq8wr5D2ewvJ4JVURRmdza7aY7B1SArFMOKV/PWofAV3X6XzrAE+bbJ48jKucfrL79Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 14:03:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 14:03:08 +0000
Date: Tue, 12 Dec 2023 10:03:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 5/5] iommu/arm-smmu: Convert to domain_alloc_paging()
Message-ID: <20231212140307.GD3014157@nvidia.com>
References: <0-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <5-v2-c86cc8c2230e+160bb-smmu_newapi_jgg@nvidia.com>
 <20231212132651.GA29569@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212132651.GA29569@willie-the-truck>
X-ClientProxiedBy: BL1P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: afd7394e-eacc-4acc-dea8-08dbfb1b11e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y23xPwP0tXWhf9oZMFIoug8yfnkK1K4L/SCuHU2hy/GQeFmBZ8uHWknpm/ftw4dPVDkMqbnbnrHUMD2whZZRg8JASXa5coZtxKluOEGCgDGSWGHNmfHxs0xW0OWF9Hx3ZBNxVV3JNgv+47TjOYwwZDgE4E6gw0CM1aZuR6OuhJ0ZV7UGxpMqhE4NUCHcB8egmClrSk6YuI1jgSCX3pkFRWg5ntTA7nsEL54lKsHvSUUrH8w2po4oc7QdYX3y7NBeh7s+P9hXv8wThWIrDMj4DQxidC8CYMZQvx93aSWUz9odI9mrZdEfH3+8AFBXav6L7u4CTQZ6iJH/90/ZccyTNChQLM1BOKDeVgb/5Lc1BuGdu1tONp2pclJzooacIyWUK1mQfsjo+dobUrndfLNJO3ExZGzW/7vWxIcH7uqgBSgafVjUNku/7NpCBk/oMHV4Q1lHpG4nTPZn7xk143abFk2JUjKK74IZZHrI73TvImkFZatLCG+V/rL7yZbTT/RZk6jNht1Q/xVjSnI/2UW9eVBh86c26zVPp2okSUlmiGN1xjlTyEDZfIVodvC9cMRa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(107886003)(2616005)(1076003)(36756003)(38100700002)(86362001)(33656002)(6916009)(83380400001)(5660300002)(6506007)(6512007)(316002)(66556008)(41300700001)(66946007)(8936002)(8676002)(54906003)(6486002)(66476007)(2906002)(4744005)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mrGAsv/D2H7OH3tiz9Sa7wW2yMx26bz6GvCDJmXIlxlV15m4VudcUY09Qrnn?=
 =?us-ascii?Q?+b2L2hcRXZTlsGR5/S/SoRWdqmKbZgzrzLveA3GNLDGaMNC3rLfeW5IgxwOL?=
 =?us-ascii?Q?+tDE6EbgNbMdTOesiv8AzouhNjcJFfV6pPSm8Jyc2xzCCJ/AtmrmMGcElW0B?=
 =?us-ascii?Q?ZUkBeAzDY0Hh8U97BWYGRQjJGqEW9rAaoHYvSIUlKeQHJWHd0UbapDLOWE48?=
 =?us-ascii?Q?H3a7868ghEzNr8F8UFnZDl3tFOJ6qDldTs3M0k9Sp38Knw0q9+DehFWVcYI+?=
 =?us-ascii?Q?jHdB88kexRZbVe2Aw/1zu7dfSypPmkwIf+YD0w85EJWePp6OdpiwpmCahfIR?=
 =?us-ascii?Q?Y5qa7LRHBjghEksGa7qtP61Kp0HfIUFOsihKK1RqxTj0JLURQDQL4onXK0K0?=
 =?us-ascii?Q?rppxKyH3RMkbeuYOV1y69vXZAQklv4eC6lMt2KtXP9YulkAGDS/B5e3SF8Nt?=
 =?us-ascii?Q?j4iZiut2mIgDhIFj98Ei7cJ114jRQ+veK0HvBz9kzm0Gy0poaNhrfBrVy6Y5?=
 =?us-ascii?Q?Ilb0cjTV0P1HpiTrUf0gsg/+rXdLLIDiDZSHivgS1imBn+4Xjhh+xba+uE7u?=
 =?us-ascii?Q?jOWxOFQmd3LHR1ym8egGhUERPzxYm6IIoOnougseke+gyJEhIx9qvYvB/ykV?=
 =?us-ascii?Q?0SvZQAve0LmCrVU4llm5z+XnZGY8RL1QQyfvD+KoJ7CY0CGI8AahWYyU0qeu?=
 =?us-ascii?Q?IKrMpDADOpab7JAXUX2lPvrh9PMhvHmvXRjHWmYuehUPfwQ8Hb3g2eFex0Wz?=
 =?us-ascii?Q?aBEa7SgC38EXA9COHmnnwIpnkwKki3tkYmygd9fIbjD6fA0SERHfumff7dDa?=
 =?us-ascii?Q?47OknU/I2Rof+Gu06ggJv0n21PYYXm11KgY2PnWrZ0Ox8gUPFU/hkZPo73gH?=
 =?us-ascii?Q?JIzmlkCECnOzaYTYJxIADAvpFhFq+dLEFw0MOJbw+c0Lig8kNBU960Ra6eig?=
 =?us-ascii?Q?hnyr4PFVN/MVPSqZij7uPoRkaPmlYwW768R3z/d1Trluyp5ZE9XGr/zReswt?=
 =?us-ascii?Q?innMUcj3U5NkYZ4qLuG7GN6NhkdENa5VqYJsODMx68tnbCU2pkmbPLEcP0eA?=
 =?us-ascii?Q?NNTLxMX1ZagP5W7+VwvUVTGXhcTW8puy1O9e6FF26roQ7dZfHHgFThy4d+xh?=
 =?us-ascii?Q?B5RgXZxnsr3tvuU1JlYLsOQKqoTHoHilJqJ+8S0iToZWrCIYmTzG8IIhRQCt?=
 =?us-ascii?Q?DTAHcNeYs5fMOZe8hmfT5Z8+vQ1YFfkYW/vGqUs3d2woEf/ZZndh5kj+5zNC?=
 =?us-ascii?Q?HItwCUrz20X2jSTMrwCpEBGi18FvyR3xFwqpRoduQGhFLN9juaWB0oM5xo25?=
 =?us-ascii?Q?09XOPlTBwfW8gu7SdYJ/zlTBUDUM7B4RzKQ7uBP5zwrZCIpS0sQh/ewd6P1v?=
 =?us-ascii?Q?OeOXk+kawXPYDHKRSQBjMDceRPbx1CSLrz51aN2B1ZDu5TwEMU+AOHZcaZWg?=
 =?us-ascii?Q?tE89BnvhIihUeW08vHs+9JVnCYCOCJ20tR5TfLNwAtJ6rXq+xAEPF2tToIM7?=
 =?us-ascii?Q?zKqQIHwJaedFynew6kf2GjOyov2wYZL1uhL+66uIJDWEcWSy9G4mrPbqzVB+?=
 =?us-ascii?Q?jxHQcOzNq+eZ0i0rBw0o0CbFdv9RXqKWI+Kt15HQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd7394e-eacc-4acc-dea8-08dbfb1b11e9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 14:03:08.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoMdk13tMMssKtr6G4ALn5492HvR5bHb/MwCX2t9dD17VAhfCexUKQpLhKTSbz0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

On Tue, Dec 12, 2023 at 01:26:51PM +0000, Will Deacon wrote:
> > @@ -862,6 +859,18 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> >  	mutex_init(&smmu_domain->init_mutex);
> >  	spin_lock_init(&smmu_domain->cb_lock);
> >  
> > +	if (dev)
> > +		cfg = dev_iommu_priv_get(dev);
> > +	if (cfg) {
> > +		int ret;
> > +
> > +		ret = arm_smmu_init_domain_context(smmu_domain, cfg->smmu, dev);
> > +		if (ret) {
> > +			kfree(smmu_domain);
> > +			return NULL;
> 
> If we're just returning NULL, can we drop 'ret'?

It is waiting to be changed to ERR_PTR. The dependent patches are
merged to rc5 now, so I can fix it in v3.

> > +		}
> > +	}
> > +
> >  	return &smmu_domain->domain;
> 
> Why do we need to handle the 'dev && !cfg' case here, instead g
> returning NULL?

dev && !cfg is impossible these days, so we can shuffle the if and
then just crash on that case like the other drivers do.

Jason
