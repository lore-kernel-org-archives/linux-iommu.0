Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62122574
	for <iommu@lists.linux.dev>; Sat, 29 Oct 2022 16:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vyd8Mnl7IfBdLpL7eq2P/FIy+w4QyceCRIBWB4SdEnBABxxyPrmf4vNOjdB8qB9lvPtWcxYD/DZdXT0fp/vIYOCpdPfahMFv4PtRKOaBXezOidONJPJPI9tu9DQ+xqI+7x0zr7Ix4dDbOVr4lID1JF06uF1sJfBa3zF87HVMz8VM/89+43pE8AzQSmZRbNnuLKDOIWn4UiziKFVyww7132CApMCtxwdm+mdppzBb3AEM6Ww3GP4aBRrLFq2zx4T37ZomVZleqzcID5cX96nxB2zWZWVT1vBxX104RmPOWJID+Eyqgm6o8zWfvNjYIkbeKYeBtBKAd2ObbijGIn7XzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sk31oPnp/w4eesv+FWaUWCiw9gk59HsZqbJfEtqRj/A=;
 b=ThQsDSIbQfjdB+7oV4RCu8G1mTXtPh4EDz/hx21iBGJfuPFvXM4ftdFosirM7QTEl6VjaG3yboeipPVVFN5OElisbwfB7WRuFz0DaR7OCdtMHvROHgl9YP9otB4Liq9J9eB6KZmUrKOfnv4F8ZeLdqekEFUW/DwkMnN83G9bD+2dibT4CoQ84Q7DhzD1xGx4NQj4wjGZqZRAZO8rZ1MMXUMd/p7c5rlWOBHtdJIyPn05TlvzVIH2ulZb9u6JU8Z7jopLiOxYntvoguVWot57F/RxaIifnF5CI9yan7fYGTVhg8OBszbZekzZ/UYKkdfmuyivBKfDHKZiFprkY0rxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sk31oPnp/w4eesv+FWaUWCiw9gk59HsZqbJfEtqRj/A=;
 b=JMLEtzX+pudJFHR4UBni36J4xdCcrQBGoyTK9fv/t6A05ux4+WIVMNW04Duj0L+gZ3W4oQC8MsCZUzQ3dmWrRxFF5wKcOzDZBATTu+K74abgxn0SAh57e2T8ZL+YQ32ibR7syMyazSsMrAiHNenpReNrrlxzkXKQEbnfuULMxODeAti9pdF4h3INDAb+pFPhVujBLx2i5ZNkLIh1omuUJNY5udNtgfglHfDD78lVvAGs5Soq4CIgBo/on+AkUSPlQLjRFviOllxkaF8zLtx3waEiGPqrxbKVx82KG+KcmiFvUi0I90aflgFXENB1va19I35znPKJzRPztBmioRL9vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Sat, 29 Oct
 2022 16:06:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Sat, 29 Oct 2022
 16:06:46 +0000
Date: Sat, 29 Oct 2022 13:06:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: lockdep splat with intel iommu
Message-ID: <Y11PleKAgldyfKCi@nvidia.com>
References: <Y1qOqBXgll9qa7Hm@nvidia.com>
 <cd727ea9-32f8-cc6a-a070-74e039b725f5@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd727ea9-32f8-cc6a-a070-74e039b725f5@linux.intel.com>
X-ClientProxiedBy: MN2PR14CA0015.namprd14.prod.outlook.com
 (2603:10b6:208:23e::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: b47fa3fc-5884-4977-b52a-08dab9c7944e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BqehU2rncBtPtt9aTses+vsQUq7bHyZgWdut2EzVig9l/zsV6J93h2m+nOQrS6dn0NNjLHS9HutKKNsOK8qAig8/1eC0IVKs1vBM0eVN+FLiwOMIMdOnA9kOlTkxdSuoibpK0S5osdTNNS/aRBQVttcZx+hG0d9KWf7BKZk3N4uFrj/V+2TV/MfCDbZs6o4YCV2C2N/IvZVIDfDANFJwW045MTvHSZbIfMk3ifUCWUvcLR3M0nsFJKexgK/jlbO14RNRHXBuf1cWEllZO96Npi9uLYKQ4ep+7NUFOiJo02z+hVSY9cI9GtkmhHpB99153uOTx6ofSgv9vlFk/y5lJ7kpy3Cat9I+D+6PDb1WdUESnS56xuWLt3alpqE2r1eLlITyVvd4jTrsYAM0JAwCdUVt4kpAD8Dtp+gS9QcfLGyieDq5VrrW8359z94vEZ8967H/0vpaUoPjTACx9X4hDn9aHQN2lUBJFD2m1jKvJoRAyPl0JQgGrRuj8tsWq9F4nD80N3q2J9/WXUbC9GDGx18MGh2qrbX3xZJuUdg2g9V6cSHipHFuyqaPW41FjD0Hm2Wvo6Z1JAwt9iV2WCzrftoHFJ4PpFYKWMvp+GkLTuv3dSasN3eHb73t3aksLY/aZHG2TqmnLbhM1JoDByIjjEYJHYZ7dei4D8GzCHzwhLBPmEk5QiXGCCppnJcF8IXAOH4hgm/xpSwXiMOFpei1dMCdPLuSdB0z1TjACS3HTck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(2906002)(186003)(5660300002)(36756003)(8936002)(4744005)(6512007)(41300700001)(26005)(53546011)(4326008)(8676002)(66476007)(66556008)(66946007)(2616005)(6506007)(86362001)(38100700002)(83380400001)(966005)(6486002)(54906003)(316002)(478600001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HZURFu2wrJduVhBHLhEySfp9NNbw50x5EahnuFFAqbugXctvTBkZNZiyxQzJ?=
 =?us-ascii?Q?YD5sHvFzX7LThp/zROsbW2PCW29MG3MJJAvMt1PwxI4hkvJTlgE1jw+Zk3/E?=
 =?us-ascii?Q?V+KdA2ZX0IwH8ykiTZukoGzOZ9MKC/42BbLkNeORqVReFOpu7ETMeEDLJJOv?=
 =?us-ascii?Q?C/79+WLeyB4+wZHsB+5Uzw7v/KOF1cbU7p9RgBmNQ7hiIflA6txNupx6eL8d?=
 =?us-ascii?Q?7jcg0jTdQDJXhPOo8fzM1679zHy+NS0UCo8lu2UxDjxPiaLuzlbUACHo42rp?=
 =?us-ascii?Q?3vE678PD75jvfDbugI8KOpXWdPLRID2ITxepuC86nhrIyF8LI72DLvOgpepd?=
 =?us-ascii?Q?myj+l+zEmBGd6XNq07BJ5oFJ0ZM8V1kfqJIax4sgqdDiQBhHTAQVEcsIjZ9t?=
 =?us-ascii?Q?x3+8Wx+0yivuffC7qE6JBuRF1L0yucx2SrytXV9YOvF5SNhWuPw2RdI9idhH?=
 =?us-ascii?Q?hOzgRX4qbgzWY0SOHLXzmB6sV2WPWYFHGGy/BNKABQjopBhZ0Qi942X6dczX?=
 =?us-ascii?Q?rSRSE/ZIXEdBSE+KhbrL/D8hm7U4mpPBMzByw1/fWeSEgVmKv7pV53YL+dLt?=
 =?us-ascii?Q?R1N8fveMXMnLB33zXJNZ44UQZSJo4sfgieZuCO+o865Uh1x1dXDEeM0/X9VI?=
 =?us-ascii?Q?eqFg2ACzHdDVyEJwQCwHfUNxqDEUMB/l7AJ3aUg6EUWXZ7Xol6ZvbTowzFbY?=
 =?us-ascii?Q?37rpa4VloX/xya3ovUtqPvntQtEIFwQb39IOLlsDibjHxXDfoDW0dYNkWKEu?=
 =?us-ascii?Q?oEZ7xipcEv4M3gLSN4tl8JaEfwbJnmkC37POmioar6oS9Gy7thCR6vxD3uak?=
 =?us-ascii?Q?7Kt2s7HGckKU/S6RZzy56cYHli7SDjrb+1R4b20plSsXCOL388Yx6obl/Nn9?=
 =?us-ascii?Q?U5CXxwpilV9zLA5wLlvuqoB/+Kgz6rsRBVbgRlPa2Jhl8GPJnm9Ovx3KoNQJ?=
 =?us-ascii?Q?O45fZOI9uFacKp3+RJD62S1R9JmaQgjSNOQ28FhJYk0cmLO2hbdTadRZL1Ri?=
 =?us-ascii?Q?0NZnc/AneB0eF7/TkZqMbp9ZwTTgPR8wIRPqQ12/p/LJdP2Rya851C2LBTeM?=
 =?us-ascii?Q?VeL5oeBQaptJBcHVIPbojdymeSzBbs1nUa4aSSIYz9wxeF3EBTni6QHciEun?=
 =?us-ascii?Q?xI4VkwoSYhmVbuKLlObn3YnQTdK62Q+bIHfJLHpwhxudxYgNco9rlotDeXOK?=
 =?us-ascii?Q?PHKm2XKlbAMYJG4s3dC7l7lODCwKOmSzJk5zaADiEgy0wsTfM/Neb7h+4ZQb?=
 =?us-ascii?Q?GLFEV2g7X3ckxv35e+c9m1G+OPo6mUAr/TrqIuLx8BeOk59b4ClVzjYvenHT?=
 =?us-ascii?Q?TqlO8gk0K7QSsTVzhlL5K8wFFRyyBZVDMout+uv+58VsiD+YVPoNI1Cly2L7?=
 =?us-ascii?Q?7mze4NuYhd+kryyeBaJJuQBTC39qTkzupa37YgouA1PiOpmlJ44yWS9OYMpG?=
 =?us-ascii?Q?LuwFvevEvfrJ5uJn8ZTwLNL37mqryFYby7q4I5Gtjj6W/QsNoQjCVcXnav9a?=
 =?us-ascii?Q?cJmqDnJ7WhaArRCywAiII5uEVWMQPKtNeRExQEkzTu+ojCHso6/Q+kHljhf2?=
 =?us-ascii?Q?kTyFQCeE7eoGxUaaWWc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47fa3fc-5884-4977-b52a-08dab9c7944e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 16:06:46.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7yUmJMS6g1qamLvz4V7AN08h/omgCMm6cg+SPhL77RrUMoVKdr+tZzjgrJ/QT7D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873

On Sat, Oct 29, 2022 at 04:22:32PM +0800, Baolu Lu wrote:
> On 2022/10/27 21:59, Jason Gunthorpe wrote:
> > I'm seeing this at every boot, on v6.1-rc2
> > 
> > I've just realized it means lockdep is turned off for the actual
> > testing I want to do. Very annoying
> > 
> > Lu, is there a solution yet? I saw some patches for a different
> > lockdep splat but not this one.
> 
> Hi Jason,
> 
> Possibly the same issue as this one?
> 
> https://lore.kernel.org/linux-iommu/20220922101036.87457-1-janusz.krzysztofik@linux.intel.com/

No, this has nothing to do with coretemp and this one involves irq_domain_mutex

Jason
