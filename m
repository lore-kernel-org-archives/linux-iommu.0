Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEC28F5;
	Thu, 20 Apr 2023 15:00:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ha5Ze3SvQoZs5RkG2fSdZqjKi2XOdyVM86HlEHrMFQOP8VbsI8gC0/8VqFTlPrxwA7Lh+Dofiv+g8Mm1oxMaMIHwVdKBEkVW5mDh+nq7v3rN7D4s58ml88aUvYJUKE7GJLHFW2FreK4ChPMoaoFUgcKd1NPsXM0z+EFk74mYDUZzbd/Rk2XE1rR4t/76nNzLtqeiOwlHMxFPEbqiLzbZFOfAQsoiYpr3dmQjCPVWsJH1Tu0TmH1G95KBB+SzXvg31Nr53g9eA2yUYbFVBk/uycy9x7z19miy5Jo1k7iRT++igypejMo7VkIf2UayYy2BuUqHLrkbuPHwMPfhSYxpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWK2Nsg61ru4/cWDCY0KypG60z3r3dYR8prP+i8kCb4=;
 b=RVD7bMRxczM1dgwIFxQcAZ02Kv/nKfxrt93Q1p/loNf9CO18t4MUQnrjnPl4DsfUPOvvrmsPDfNF67H2lbIXZprnmxv9+9DvJybVNBZXxbBB40951eGQHoBwX1Pa+N0MZu7HGO6/xMAxF/1dEz1dzqteK46Bxj4K5+b7hQH8i/dVeihsK95E5/RwgNEuU2mNJ5XDivAeQ3uLrMqSKw4nEbKOK1M2DwjpiiMCJqJG1E7xzIykQLlFPojtZJq/nsvCyZBMRSOPudo2fwqKBOjDPFfBlk98gsaQ08s0eL7t9zmc/nxFSiLlLjGdGOAJaranQXAn+pZC3xxZXmAprnRrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWK2Nsg61ru4/cWDCY0KypG60z3r3dYR8prP+i8kCb4=;
 b=csTfrxqO6EyLL1KleEepZEJW20GZP5/dN/7UjmREB45ZH28+7jmv2ud2sMZQxDGP4iMUGmRzEiCt99t8dnL51pfQiSDeTxah3D60Hvheavjn3I4X1thnotOOV+qbRDt+epCQsae7uYO3gC7fngu6Td0WrP1/Tj+wbkeYxXsd4wsBgisYtjnLL+SCdClBV/fm66gwmsjFT3PijYRmNQoxQ2dmJRJXrL0DHZmoAzfHF1veGjGJgy5zcgm6q1o2R368pEuKOdIpPicUFzjvCwjjr3VXyj+etjxTNnmGUo1D1lVj2F9g0WXDRG61dZ2QqOZuIB+nlzdrlfWd7EQ+3f0Rww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 14:59:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6319.020; Thu, 20 Apr 2023
 14:59:54 +0000
Date: Thu, 20 Apr 2023 09:59:03 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Joerg Roedel <joro@8bytes.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, "Rix, Tom" <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v4 06/17] iommu: Replace __iommu_group_dma_first_attach()
 with set_domain
Message-ID: <ZEE3F3aAIKrHjhji@nvidia.com>
References: <0-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <6-v4-79d0c229580a+650-iommu_err_unwind_jgg@nvidia.com>
 <BL1PR11MB5271C0E78AF1343E1D6ACA958C639@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR11MB5271C0E78AF1343E1D6ACA958C639@BL1PR11MB5271.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 4edf7fd0-f173-49a4-87f3-08db41afe662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q18oBVsEwiVW0XOwIGghxHd1LSssWsLwt8tShefYkqscUdkQ4EOeiclVWDyqYbLtfoeBPnA+P2tfPt0wtPuJobQ+7FnEcx+4rKyFilpD85qtgIV5BexQLF6gU70bXMymFhKbbGlscHG77j40269ZwakJb5g0ZQe+VQYJFVj0icFOfqE/vDTYYIY2OBLBp/syF/7C7jJqheBudUiKcLgoT8ZZ7zQpbaWs3ffqwSLkqKAH+/WG/hbXJ4XJ43iKrY/ccgGrql/QqBzfQ5F7x/tIqUC2Hv5+1pbDyoXw6i24ZdBAOoeip3UxyX0e7gL2SXMouMveDtIH7V2AZQio3nEEEPxsv0CgCH/Lcyxcoa6t3kTOX94SA+Rohq6Go3syraD7Ps7TheKSybLrZmwhZpzrdrG9MSJQ8+hbu3x2JgZUukWm8OMeGEF2wms7i505K3pkxN0NhKEJ5PVtnR5AI/7xfcMSTOSJxVe4T8BcYg9tvh7+VLQ7ztFs/9D9Tq5R1BGrPpqN86OM5ytuE0SxgVdd+P4Z1S+PNWT82PMmol9yCWUJQ+NaED6gOPd3fylBY32W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(36756003)(4326008)(54906003)(6916009)(316002)(66556008)(66476007)(66946007)(41300700001)(6486002)(478600001)(6666004)(5660300002)(8676002)(8936002)(7416002)(2906002)(86362001)(38100700002)(2616005)(6506007)(107886003)(26005)(83380400001)(186003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eLCacypLlQSJKtmiupb+RN4feZGK3QmLaVu5Cl72Q+qPb/Y7V30TNl9rO8L8?=
 =?us-ascii?Q?kYrL30BwkTCQDeKxzVt30xPj9w/rfpNd1KOMgLZV1vWlXJhN5e+typEcFNDN?=
 =?us-ascii?Q?i2yepdtXxxz437Xy0XbqRm82iQFiOcFKtzks8EDKlotaHQ8wBdSYZIqHgBP6?=
 =?us-ascii?Q?RXiBuL6MZdtiV+ndVy7ZEG4uHXDLaP6+kFdk40iCKIwBxipXgIZCa9gEhzcM?=
 =?us-ascii?Q?cuojkbPCeaTtVPB02Ji7jmCvWnqD6QyhQOmxTwfcMgVRZT//Ny/5UtPDySSw?=
 =?us-ascii?Q?3uraY5Tp7eKq9dNw8K7rb6tmzq4RniF8W7P+AhqOIT6JXYiSjsg6/8IDQKGp?=
 =?us-ascii?Q?bm4xiBtN3oOvrnUvek0paYAoQdgl92vFKzw1Ux5RzG8n3RuDkTcNUZdgheJQ?=
 =?us-ascii?Q?3L3uTV5m4AbbMQzSPq1TbU4pP+/RO7LY10TSPeJOTL9lVOvWaKkne3dOdMnd?=
 =?us-ascii?Q?1ZxS4KSRS5166hwj+H1/KxrIwjBz62rLuQjEj3XEDRHewD06yT8XFAVrQqem?=
 =?us-ascii?Q?87TJG+gPrKwKGgsgMSaoYch23HTotKGh/qH7J54COUeUoO7sj9c/LN1ApE4D?=
 =?us-ascii?Q?v0Y3VOFc3IRTrxnY38cODHuXdv7cMKp3gh0zGR/fBXewK5RvWpVREPy0nDLN?=
 =?us-ascii?Q?dEgNP5jhITNz37NGbwroOQZMP/ul8HE7AIuOdFtDEg+u8VEWpl3LYNSXaEf2?=
 =?us-ascii?Q?KJJdwDCoWojz+oZDTyA8lK/62Cbw7ROx3dfpWGMfUUuIb7GRrsHcWA3y33GQ?=
 =?us-ascii?Q?8JX5cGc764GCnrrkIFbCCbZ48NrFoEeQ0azAPnJTgC/nT+UTpCetJq+bwHFF?=
 =?us-ascii?Q?OVMJ61QmtaqGunKbxUUsEPzhea32FzYuI75VrvN77JinkWbmK/y0x092rJXR?=
 =?us-ascii?Q?IxCo+Z62T48eSg84+yXWRdMiM/wWycNR619KLDJ0XRFgznQZuyibr/CN5LgO?=
 =?us-ascii?Q?z0gG7PTIiScEQJrZMfu2peVPacAShXMqPWI46NeTDEWW+SHj31w+P7aUn92Q?=
 =?us-ascii?Q?DCTQxVFEp3QrtEpHIjjqFiIdY1FLIeqNcLwD4DltjxtkrOHiJBSimFHUjoTE?=
 =?us-ascii?Q?U7RjmMGifIQoNSqkUJhRxEjr7x4ufPlz1zW0NAy3shO7yYsugAePgMJ8YMdQ?=
 =?us-ascii?Q?pRQQ9WskELOWPXAQ1lq2jYYUTdDEZ394AED4IRlgzlZaJ/8i0iHNA3TJ7cKD?=
 =?us-ascii?Q?d0pIrzyz/lv2kEGF54W6nICj0k9QfJWDTw7aGIFD55Tr1DWycng+CawzckBz?=
 =?us-ascii?Q?ffT3YwelAXYFvFED+QEhhlvV5nrKOguHt7YUhX78NXoJhK5EnuXzSr1wcQWY?=
 =?us-ascii?Q?OPLZFYt8/9w4i73Uc2lwB+O1iI4yk9+XLklTkk9R3LA5OLY9e7HGBBQenCey?=
 =?us-ascii?Q?0UP5KsP/mUsc9ymR3SX0CFux1hN7KCG+aeWRMhnzXnVxq81x+0bi8x/I2gEL?=
 =?us-ascii?Q?BbyZwsjuHou5iW+346oxgesScrIqPR+aSGsNBTtRw0Tw5Dm5WRh3jvT6uri/?=
 =?us-ascii?Q?jhSujk0Ah+ZQXe2HxadCX9ZYLUt8K+yuWHviiREOdRSYTeYEVh+plcCgtPpA?=
 =?us-ascii?Q?ET7aAVxDfumxDIcf2scyeX9j7EnFtAUSRAQ7F87T?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4edf7fd0-f173-49a4-87f3-08db41afe662
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 14:59:54.5004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sd1zAB+I7pYpxNUgY6K5RVKcv2yYmtcn9ldajpR8I7vFe5YeinXk65yuZTkYMIGG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

On Thu, Apr 20, 2023 at 07:25:59AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, April 12, 2023 9:52 PM
> > 
> > @@ -2218,6 +2202,12 @@ static int __iommu_device_set_domain(struct
> > iommu_group *group,
> >  {
> >  	int ret;
> > 
> > +	if (dev->iommu->attach_deferred) {
> > +		if (new_domain == group->default_domain)
> > +			return 0;
> > +		dev->iommu->attach_deferred = 0;
> > +	}
> > +
> 
> This leads to a small semantics change, though I'm not sure whether it's
> important to sustain.
> 
> Before this patch the 1st attach is ignored. Deferred attach is conducted
> when the first DMA map request comes by calling iommu_deferred_attach().
> 
> But if the driver tries to do iommu_attach_group() or iommu_attach_device()
> in between it will succeed. No deferred_attach check in that path.
> 
> Now with this patch the behavior is changed. If the driver tries to attach the
> device to default domain in between it's ignored. Otherwise it will succeed.

Sort of..

If a driver is using the attach APIs then the first successfull attach
to a non-default domain will clear the flag, then any following attach
even back to the default domain will succeed.

The tiny difference is if a driver tries to attach to the already
attached domain the NOP now extends to keeping the defered attach too.

I don't think any drivers do something like this so it seems OK.

v3 didn't have this as the flag kept the different call paths
seperate.

Jason
