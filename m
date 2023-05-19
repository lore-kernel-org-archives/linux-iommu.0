Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E45670
	for <iommu@lists.linux.dev>; Fri, 19 May 2023 15:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qtuels8XDCJqgfgBWP8C9mlDYe0F2MAEYjzwA6Z89KpPAubnNYJpOiGeqY8B1nNT6lyL/kRC2+9Z+V6ToaRzqeNtYiOTodNJolEn1svTy3vjdHTFEHd98nz9OElg+0WYiEarBVMdDgVcA2UvrhEePwjItmhN/V/PzqCSMypMiNU6LAWfA53+86qFXyVihSiU1rJJ8UROeaumWbV1lQ9CeD7hr6NAsPLn61hkSkvy4OaOx0nlHszS+Y4LwAk+l35/1witZn3QyzbqMx3naCQ5aFxGB+DFIrJBXZQLFLaIJfzAvsM65BjpmiqHMjpoj7AdfKe7WdbdiEqUrssi9mNvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfmfe01kbpnLfdKNLmKP2ZMP7CaU0Ku6Jsi22KlHWF0=;
 b=anYnRzYHHL18Q2cBfZm1zvPMHoA6flc+J7MCe4Syk6HBNHU5HnYJZgP2mbWqv0ptD5YocDBffpv0IE/PzpmM2A2n2gqyqneTk4GYktZiZWmuQC7qq+Zci/BBqq/gqacqbG9UVLbILFzMwrJ3zPIghs2DIclo1H6SuNmBO7E4Tq6rcb/rfjkpODP/IEddEbbwZXAknqfcUtUwO2te3pNzZgJRSyn5nR1Hb+Cyx3DRFJb2Xf/mnvxZpeqv3UYSo1X7pbs7op7low/yVmoU51wvtEPg0kys+DzpMlnyDV92WrC/xd6/MOq0+9sHnLjCx51gxl+P0zfoUmsFereFvrCtjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfmfe01kbpnLfdKNLmKP2ZMP7CaU0Ku6Jsi22KlHWF0=;
 b=R7fbjvf/LoRHPk5UuGvbvpFEQGCB1n54Ctj2LEfzHTV6FW73x0qWFIF+5kvcdFadpZHmALpz3+lMOtVErPzJjhPdHQTXrdi8bO1gvhcyK4GYLHxVD732tqu/1rinpzMPvyX6Fr0FO1HvQXMdTiMjmzixsa8XFx6FWf5q/ALnbwZjKkNgh5bTvl2aNgOhrSBxT7+W6xs7Yt/wp9W1+YeHPGglQRfENki1ZWBOH+8NUDr1ekZIloBxOTxRSdN5+nh33fJbWq46szY5XdBkbQHu0GtdYobhBExySlJaQ9dEUhbf3xawg/rSRkm6u1f2QxxuP0u9UhW0n5h1rrU1jRrGPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 15:39:49 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 15:39:49 +0000
Date: Fri, 19 May 2023 12:39:47 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] iommu/exynos: Implement an IDENTITY domain
Message-ID: <ZGeYQ6DAca6ujN18@nvidia.com>
References: <0-v1-9bede1ab3a9b+15-exynos-identity_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-9bede1ab3a9b+15-exynos-identity_jgg@nvidia.com>
X-ClientProxiedBy: BL6PEPF00013E0C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:e) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1297e802-598f-4382-3cde-08db587f47ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WQOD5QeHtvPoozgQhuOd9qdaF+8WpaZ0gSOdEeHK7n07PGnqIhaxsaUCKRzSj3MFqbI/lHZBH1kRt8x9LtUXLnlpBbYLmSKSKPIH42kN/3jHe7u+REzzCLm7W94J9B9glE1teauY4dvSzLJcTpG7Y3eJw9Y+67cumISC9s89yZbBQdjvwhsCbgNJkC/8QDj4PL6PiUYOLjdlvbtIyjBEQoY5c/0/xFiKiM2EdaNAfFRJ7ChzUAkIy1U3N8Ch5KGP7U3r3HbO7WXtjPpUFkw0k/VMR5Ij25pUiHmGdBBSelJym19C+NN1khxzTIgeEHnSqkYz/7lF7/BgIHrQui3YfrG0B6MDqCRjJrllXNOjorQcMiZQApYPxiUG1JEZvk9wBtD2hax+fVC1sEmr392DVogS1M5Hu0ZZwm1tXV5vHEexaozsZcFR3E8Ts1uhaVRUdS+ZjhXvBOgWzOc4oDPnoDHNtJG8ISdJ2+hF4dVh++ThFRGcQmFgLOYHybPHmadPhQXznwZXR6Ye91YJx2gOzQ3YvbttgES4QdyphYcEA9yCavzdx/aRrxKbTlty/VTMvpByIW7+rgcVpODUcLfSOMwEo/nQNmMddZgYMJA5LgU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(66556008)(66946007)(66476007)(186003)(110136005)(8676002)(478600001)(8936002)(5660300002)(41300700001)(316002)(2616005)(38100700002)(83380400001)(6486002)(966005)(26005)(6512007)(6506007)(86362001)(2906002)(4744005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?naitvCyEloMzyFjR3tKSuHeRua+bYqwuKOHHSNJqR3ck1NWcnjQI9gVCOH9F?=
 =?us-ascii?Q?TjYqvG4afNPjO+Zdtzu6XyZRdv82GMx2+sZJwQkqxpv0DniGfJPmGHYfxRea?=
 =?us-ascii?Q?vBWD3MuUOR1+ct7UgWN50NGXf5OgYR4yHxUigdw0bem3S+k9qJEvm/VWzxhe?=
 =?us-ascii?Q?o/oR/P6KcCoAdqbJlXVpRUcYS+JYeCP1dtf7aYtYH3VvAaNtxOJmoE1dd81c?=
 =?us-ascii?Q?wKGguEanYKEVNWqPcbNrnu8B/1j9C4gEVGAEERDU8vMdDgBXtmjUquWuId7+?=
 =?us-ascii?Q?5jqWAbiWuxiYzmUPXJmnhlHCT3KOp137a2Ox1xNFF/ghJ06hIAsTisng/uWb?=
 =?us-ascii?Q?/BQXfP3FHijCdyWDwHn0CD/BkLodKeT4y7PEzlMq8HBVkxBxRmqw2emNEKaT?=
 =?us-ascii?Q?EchpshYtBEWQpdy7r3w44KkSlsMlPUKHJqUgu8aAeSIEVYnyH1CmrtIQVceU?=
 =?us-ascii?Q?PUjdOMBCYurZLrYAhHxOA3msF3VlQQxcDgqdd2NKUGL5gqkscNYPwzCMYff8?=
 =?us-ascii?Q?wsDb1pRKdcBVtc8JmuDDsvzkQ8Oun14w2us4RikyTqwPNLm7ybeX3MpmMev1?=
 =?us-ascii?Q?8s8lzahPXspffKRC8OP4V8RDr7h4zidJKrxLPdKHqaKJg9O8D25fcuoYEO/7?=
 =?us-ascii?Q?fAJ5r3knVbP1aSgRcjD+fwza+oOhvCJ/D4TXdHNdJq/C2Vh4omz4kqW9kjuj?=
 =?us-ascii?Q?DpPtUOfjAnHLU5dx8baMn5Kw1ejksqLuxPZdYXgnTudqJT3syiLCqGWLRueO?=
 =?us-ascii?Q?Yhrx57bJZpVcNQWnrIlBrLIjJFswoFKAN0OQKq2gw/GtWJBHRKiLnTLRRTjI?=
 =?us-ascii?Q?MUxokPMU4aCJT5S/OFw9yq/wIyHdEEIJeDzpTlSj+JRBcZEHhJZSiUUrluje?=
 =?us-ascii?Q?Kv3Ht945ZMCG73mF7KrUQioTayBmmEvFhXtNjKyI6e37fQl3lfnZ2HEMQSt5?=
 =?us-ascii?Q?25z4RJgHluqvr5WE/j8i8qmt71EG2wr5uL5HBX5Q7oTb0bQ8i4laSIrmgKf+?=
 =?us-ascii?Q?Vs5rY6+o8Nd4o/VuUnwDTIuhnt9WXcxlkPkLHDGTDs3opRa7ra9YjT6b9706?=
 =?us-ascii?Q?dm8bF5rYd3myWBkm+p3H6wY17qBkcF6sEc3lEG/c3kqmBPE2Pfk6wI1g8Iou?=
 =?us-ascii?Q?+3uvspG5/7KwWeB98bjzdIyEL2JK82inftfvQGbZUtUHQZDDxNzbPypdFdjN?=
 =?us-ascii?Q?/lFkv9JGjpKU8KoB5Y0N0wyMH4mMZJLLfVsxAtCWBWwcZKL8/D3cXrTHbEbv?=
 =?us-ascii?Q?n1l9ZT5prUC2k0xgh2wHfsfIizdfF8cRPKPT1KbhrYtylk+e5qA6jgyU22rW?=
 =?us-ascii?Q?uns9gOV4AqSbbGViTWv50VsBR3NiTQ8T5aC4SK51Xcnbm+SBQBNZqXNEZ6JI?=
 =?us-ascii?Q?LPuJ8FkYSbBMybJQUnylU/Yus8K306s2V2gXq8PaFQdmosW3mO/GesgTjWKn?=
 =?us-ascii?Q?zBOxKiVKSRz03IQrZggO0pM/djqIhTjZq3z7H2IxZTlOQ7IDdE16zh7TAVs/?=
 =?us-ascii?Q?aDvPZme5oll59IXRRDQxg378IfcoDiDhoRgOg9WFP6L81kp8U3kJjJQ24OkV?=
 =?us-ascii?Q?f7q0NqzJizRrDgt6miBWY7/rjAvqePWIiKZxXmIn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1297e802-598f-4382-3cde-08db587f47ad
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 15:39:49.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smAbQzxskIts6sm6LtdwEyDh17l9UQ0ehOJwpHOLYsNaN+01IqJ/KrDTE2K4Hn7s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250

On Thu, Apr 06, 2023 at 08:42:57PM -0300, Jason Gunthorpe wrote:
> What exynos calls exynos_iommu_detach_device is actually putting the iommu
> into identity mode. Instead of having a translation mode that is invisible
> to the core code implement it as an actual IDENTITY domain.
> 
> On ARM64 this will allow the IDENTITIY dma iommu mode to work, and on
> ARM32 this clarifies what set_platform_dma_ops is actually doing.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/exynos-iommu.c | 67 ++++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 25 deletions(-)
> 
> Marek, as requested here is that patch on top of your stuff that went to rc

Just for clarity this patch was superseded by this series where it is patch
10:

https://lore.kernel.org/linux-iommu/0-v2-8d1dc464eac9+10f-iommu_all_defdom_jgg@nvidia.com

Jason
