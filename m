Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77C2168AA
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 12:43:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ow1LgAjtYgIb51NGQvPT0SBxA7+3+8tc9hDTuKBLol0rGcKOP5qtEus+wEo5jNbgfvakGeSC//P9YunPuv9groarWrm8U594ojBwWdXWCFKkTYTdMwIaRrDTej9RZzGsjy8tfdkcPW2+Q2jt2cFGm828UhOTDgZigPHrD05luK1D1gEW7ut0gH1j9TRo2GCU/cq2i4WXA322c2DcPHEgO1NJwCzW89HZblIK6UMntgK7FHmBNpfFjIDnJaHeCf6ze7gvyCfGbgtftPZBYEsGozVEhQDBED7kp9RwGSbiTle8N0NCaDV0Nx9GFiKCPIODP3TSStYjkjAkBpdadhpI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCMphRDgfKOurVoD/wauVUzv2GYZu8w+fsgrAY0/XW0=;
 b=fJXv3OpJpM5iZ89lYMU6SwbVTK8sxgnu1r/tPFszlbrutQZUii/G2T+mZE1jabIb8n19fhhe1rCpZjQJrlHSX4HYvzl5lMcAxUH9iGrZOS+pBgQEoovipnyloF13lV3tjh9oNKdTLWH8CgFgJMMtt78wHzXrsUo7igyCgmjlEI6Kp2MC815OzKYnOtcpzm1uee5vVPGpN5VEgTYlw8s91bKjcHdA+Fuw5oAvpTQdOQBIMk3VDo0JivmS2mTOHaoYyboZ4F3Y0pTn2bX/gUiAFnJ3umsgWRaIUTlb0z0gXqZoVLRsZ1yM1IRRjd3kBIq43P2X8k9vY3hoTht8InsLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCMphRDgfKOurVoD/wauVUzv2GYZu8w+fsgrAY0/XW0=;
 b=SKfp/OhvGcgBpfyXXuxRCSQyxbmmZo60F9wlasSwzzYlheR2Lx5W99zKX+6IZjwjp9jCAKKnUhk9tVbmB5NTA7U/KDM4YX7y0mPDUAXyBRymHxsfk2JIunDZhr9n+RLPTyZ1pDjwhGODWHDQrytgfJxpHvaA7FkKgGPGj0i5JMpf2z8nLridEnVf4wMzM+ZMF2Z21QFISK00AW0HFYAncIF+7jtmL+MexHDGMc7KHWiai4zCC6pM5pWlUdOL/f887eRheCf64fgNR+LGkZidX/cz+/qBZ7zAPvT52yqBKMwJwQugwzrabfNlB8Dzqeh+1K0n7xl5YrtVLdG5E1ILug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4500.namprd12.prod.outlook.com (2603:10b6:5:28f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 12:43:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 12:43:51 +0000
Date: Fri, 22 Sep 2023 09:43:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <20230922124350.GQ13733@nvidia.com>
References: <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <20230922115927.GI13733@nvidia.com>
 <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
 <20230922121812.GM13733@nvidia.com>
 <3a52aaa9-8fa3-6d99-363e-0620e538f2fe@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a52aaa9-8fa3-6d99-363e-0620e538f2fe@linux.intel.com>
X-ClientProxiedBy: BLAPR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:36e::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4500:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae48f5c-aaf6-46fc-50f7-08dbbb6992ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D+BKFVKXAjMZIr8Khch7FbcgK9YimyhmDBuZq3hOCZigTGhIxz+uR4VN8HBqXkl9K5Y8Abq/nyphehmkd5pktrz33meBlPZ5ybHjdemgGXJxLp782wXvQ2q2pCdNVHsaswRgdEOFmoc9qO1BtQFExe7p7N5haPZaLeeDuBilpp0Ybg7VGm5FEj35h0W2cfAGd5j3w6JCZuyCYO5Fzuf4TkdvHIEmN4YAguhz+/UnPCoGtCmsCDa9UDIQNe62kgCSM+tW9IpvFfEt49p7VEPmAJt27G3+dYqD1rrYZiisPWVEmQnWqZazfBtHCBrT1pD3wEC1rIx7Gke5RtsXANSrUm16D1PZvbgO0I6olT4smEh0zWBJq0DJO8FPDijwxX1tnKDWxttMR9P67sJ10w86o6tp0ggmLX9jUOujD+Kj+j8aQ9udIWTjfO859KE8w2rAV0kgyDYvkunWrF00ShrPuFdfRvwMY5gY6rESiupak8s6J7GgNjxfqYcuOIPNxZoZLfn+dPeYW5sFx0UzN84SYEJar9utrptvTtO1yA4oWsSK1PCTrSSJf1rxjBk3YNIm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(186009)(1800799009)(451199024)(33656002)(6916009)(6506007)(66556008)(66476007)(66946007)(54906003)(478600001)(41300700001)(6512007)(4326008)(8936002)(26005)(36756003)(6486002)(2616005)(5660300002)(8676002)(1076003)(316002)(86362001)(83380400001)(4744005)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AiHSNZ6rU22rv2GCEIlwhj6X1xB0DsENaVcKBdVjYs3LaGx+zDL3AsY/U4vm?=
 =?us-ascii?Q?qpGhn9KlZUlIR2I7GeQyY6H8EiR911yYCTfsxbJ6h2YTho9471qn8/KkE5QE?=
 =?us-ascii?Q?p1i+eYc8+XGK2+bg/1dggnbO4Cujrd4AqGqk1O98ElSEmy5y/Hcbh5ChTYRx?=
 =?us-ascii?Q?DxZzwsID2T/iWbYV76PONqt48LQDrahO39b7QiuCga9ZkCPH/AeHm9qzav1R?=
 =?us-ascii?Q?livyC0wimz2UN/QbdsECZ/pp7PjJEMKM2uKQ861iI6Fkh/C58ouBbYGcHpn7?=
 =?us-ascii?Q?TEN94vRjCC4hmbQqFO4mBex062uC+rglVuKYPpxdLnu+AGl3sXeY2oH1DIW/?=
 =?us-ascii?Q?dski7RQVMYUSDskzySbLKBMM1sA2+eWnfWb+Mcxz+2OeJ3f8R4N3tIzJSfQh?=
 =?us-ascii?Q?2hTa3qneSyjDAElLE8/5ptsP5gwW7EjB5fp7QWhPqslG9XO7/spYnO2QCeCV?=
 =?us-ascii?Q?/j4gazY0thnTbOIM5lSYcLlWtBHx0Z+sNoiVN/xXFjGIG0gDoJZyN+l23Z1h?=
 =?us-ascii?Q?rjgNoKCLdoOV3Li+qtEd/I3tyjkgVaarLWaL7LR8304+/MKGXdztam9eIjHf?=
 =?us-ascii?Q?1qSbSKpwTAEJVD8xqTscJmzkng+I64cy948TPbQnUpfgXlxVie4Z4Pw5p8sx?=
 =?us-ascii?Q?2ag178+uyY+WMQSv7CczkTRwaYAr0Ff/MMjj1n0xJF+1xu1QXcuP2PYnCM0u?=
 =?us-ascii?Q?5Q9FuEJ5YDCkBwU0fLmOc0DmesZWVQawj1tNsUXyNuIVUk1z4Fe0D3kiz6cx?=
 =?us-ascii?Q?hAy/9OrYPGkZiKz6moFVeDv6EWti8HVPnXkVSyE2H/bW146nkJJXmNsMFymf?=
 =?us-ascii?Q?qlWSJb7vprqxiVC0hrM4Of6uRpNs5DwQYQpFCjsO0BRmS+TXDL0pvpSmN0v0?=
 =?us-ascii?Q?3e4OLTvbhIwtwax7EYN1/4YBTXJTRIga6yGTCtqRZW8w248GtZB/nYvc9XSR?=
 =?us-ascii?Q?6tlOM1kGKOrkcO+kjNYqusHMPYzZP/GuoHkDNplJDbCPSMdZB0TjydJ69XW7?=
 =?us-ascii?Q?goz3U2GKT+3M0W7eoFNLsNEyiKa4GTs0MFECHkAmIbGZHU00fp71MBX7YaLB?=
 =?us-ascii?Q?9GPDvDNhyABlxP8kuEysq3d0K2vZfvUzRaX+Dyo5lBk5Mr457cZfYCV6/aKS?=
 =?us-ascii?Q?ZI+WBKSbEWF+YwsqkpX6IJKV6Pvm1JmmDC6ngjXvTr+LMPB8NvE5jp3Y2cg5?=
 =?us-ascii?Q?ef1HVPlFK8VfSBLXPY4mrsmZ6n3nZUyMREAqjTyT6qsqOmK12wvxfEc8D0xB?=
 =?us-ascii?Q?OD1oGOdY1LUVtqRvKgfFB6HGDMK1///BkPB1THdfCgA9UkXOKe1pIABoyjy9?=
 =?us-ascii?Q?6wYtYX5KQKdeUZmkuz5dgkKqQKcJiS3qZ3SrQJwnyyETq5Rzz83WwUJ+1SYv?=
 =?us-ascii?Q?jhJzVdeV7sZMKzyZr/S+r658Tib7SmkQjmG/wA2CJS4aIdidsp+MiZUiSmF+?=
 =?us-ascii?Q?+5oCfR3vZ+t0JYWD8Aj0sobUvqrTnBfGELEJWok7m8l9K6FEoN31VqMsTzvf?=
 =?us-ascii?Q?g2LivUwDu+baH8NfYes0FEauUId18zz5xAau7p9mHFPw1g6ryIBPcc5ui8Kb?=
 =?us-ascii?Q?5PK6El6lS8bOIvnQ9HOIfF05mNznl8i1D36CFAG0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae48f5c-aaf6-46fc-50f7-08dbbb6992ef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 12:43:51.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85U3fU4mTW3S2TT8EKLI/vbuitnhUwn+6Gnu+XzeA96Cz7rbiYQ6DP1ZaLJ6Uu0G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4500

On Fri, Sep 22, 2023 at 08:42:04PM +0800, Baolu Lu wrote:
> > IMHO iommu drivers should not override this.
> > 
> > I think it was a mistake that iommu drivers could override to identity
> > domains. If we need quirks then the core code should have the quirk
> > list, similar to how PCI works.
> 
> If I remember it correctly, you have posted a series to address this. Or
> I might misunderstood it.

Ye,s I have one someplace, waiting for some of the precursor stuff to
get merged before I revisit it

Jason
