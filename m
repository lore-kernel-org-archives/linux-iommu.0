Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43C5392
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 12:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLlmuS0EdSfVUpFx9LQDgWFgorELR4Y+AfTSPHIcoUXYh6j2NeBYp1MHyOKI9RoEksA1y8GxfGLQU3E73n4WxOioI1XrrwlPMqYLldMXvFDVmjRs+KVj5z8qRKTbK1A1JvFnO4nqy/6FmxLIa6X3zf58FaB7+3qBIHxWBHPlwuk6RbC/F2XWHUPBnTJoim+HcPnrK16AjdVx1kpp8HpAnD3KEoetQdXTL6l68tjCZ2GkAl+KKm/3STe1pPpd7uzGmMa1lQZD65p/EIEaosT1GUOqOwxOKVjryE+rN+jcEahjXikRtBEMffx1Gy2zUXS+N474RGa/GwluigKUY982Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=411iM4NAONxi92haw3isDKXWKWUPBgkcvrI4ihV6z7Y=;
 b=h35Eh7FuB+npJNvjCzFAWdII5fVVNiY/0bL3Iu/8e6GBNvn1VmFLm3E/t0A1WN16cjsB/F4WVtZYKd7kc2SdaweVDWqh001T1ok9qiD389BUsdKeHxCZOENNEowgmO69fIaesIAZtyz8Os4nuILJtw8BvY5OVG+8f97M8lfVswj8xsSanfdo0ec6R9miA+Vgre9YakXthnCJ8ynovHlSzLAThcDT3OWspRLxspzjGTFYLCmkfvn5NfZ364g57BpSrIAABElJpY1qyMSoH8J8udosEE74P8BZMilddk8as0D9BxEz00oGe/9Cz58IcvEHzqOkvMh5Wmf1j5bUp44idw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=411iM4NAONxi92haw3isDKXWKWUPBgkcvrI4ihV6z7Y=;
 b=sXYLpyd5UDcdtyLMCSz7+ADaOPcn7MC8elQAlGjt/tu5Mm9Ja3hcA/YBCKC4R/6IU7VwJ9UqThvU1LaF5lFcrtUW69aIpj68bKe3GgwNQrPyUCsQcMviq9qibmhfbXwzDJmvfAaiGfV49R4mDMXX9h9V62EutajJxBHfxqPsfczytX+ASKbxVC5tKSnawtRsyjWP/hpUF6jXk7879oipMMwDFKN6AVWAp1pD61JdzQVSPJwY95fk/riTHS2r3zdlGGrfH6p1vcjDkXSuCz6gJxntxBu9PmYXOxYpnPUKDYWIozWHkLY+AfEAP6MqY+P0nzGk7nXHNFA96409gjKoBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8269.namprd12.prod.outlook.com (2603:10b6:8:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 12:43:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 12:43:31 +0000
Date: Wed, 22 Feb 2023 08:43:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"Yang, Lixiao" <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 0/4] Fix hwpt lifetime and detach bugs
Message-ID: <Y/YN8jsZmveoFVIV@nvidia.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <Y+2Isu/aAPm6PfeX@nvidia.com>
 <BN9PR11MB527647F6F32BA61775F348E28CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527647F6F32BA61775F348E28CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:208:2be::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5fd4e2-0b42-4e47-7c61-08db14d26772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ReUbSGYN4I+RnhTEiuEkND9pn33zkccoSkqe+W/qrcAB/R228HU8qjG1w7n/6viyNNs54tF4P956YpO1S//CsuYnI04yID2gTWQZ2iRbwazJEcp5BErZcdCGhkKUfbS9V9S8XtjYnWtrSq9P0Mgo6WkHtXjwe7QnvumHG5xn8ThycTT+LK2MS8ZxcJskoUjAnO47xeP9+wSY5OJ54jI7uuFj23RjoDIXjwBdXdtvsxgbXCHCQv96Qks7M2gmzX63uMFnw2fPurj6MRLjWfeKbWLLTxN75gCnHehcH9k26gKaRwhPTwKqc0mTpaYeDRu3zVuXy28YR/Px6si5WJKkuiHTZvXt/SCo4gXIbanuQrMMKLYrYH5+ApYkYADpPRtOM6MgVKrHhmDS9PYBZZFfI27NAMeUDfGUppLYTPipOrE0ldsU4Z+wHvuZGvZz7eERa5So77Eiwuo4p+MESEgdsGUK+H2Vcq+vyppgq2JDU9uK+mP26REubtYxqJPWBkwgydSO9FJS5RsZj5I9dJJDvjgteIzVEbm/pgPrHLZqoK5qc1Vmk8Lu3B7K4ZC4uuAEjyMLu6QGccqMTtNaJuQHdSS1YLuu4UEQFDYv2OJWTwtc9MK+RseQN4bBMHZYwjA2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199018)(38100700002)(54906003)(6506007)(26005)(36756003)(316002)(966005)(6512007)(6486002)(478600001)(86362001)(186003)(2616005)(66946007)(66476007)(66556008)(6916009)(4326008)(8676002)(8936002)(83380400001)(5660300002)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IGYF4NKAq7XxVd2kyStVoujlI4jauX77Z/dE568UDetLNbzzFb2iQP/fOdme?=
 =?us-ascii?Q?WD5yhbhAhyhNmbrMDzwdRsY1aLf2up0aeIxA4dOcNu0g/GDeQyuRKt+AFpcz?=
 =?us-ascii?Q?xV0sV/DYeYAmp8y0h2IkHal4fbjofXaYIrGKSCP470RUypeiHbvjj8UOd15k?=
 =?us-ascii?Q?fCBSeIFEM2wQ8gx+f+dw/VwfUhdpPM3cOvN4hPa6fMdslDljHA+TrBaeMTYi?=
 =?us-ascii?Q?22sTftWrTXkucTZUbvlA4hSLd/dTpeP+623G0XLGb32XBPyecP7heBKfar25?=
 =?us-ascii?Q?a6KRzrDFKjaSqQ0pFjvn+ny7rAAzfTZQ3ZDl/3fLPH/dkYRK2FDk2ymKZ461?=
 =?us-ascii?Q?GCldBbs18gOFbHUua9/CTBr0t8azKXCiYwOas6bzDYkpdelJwJKXhWiEv3Cy?=
 =?us-ascii?Q?JSH1VpFAI0/Wae/SuK8+Mg9o0hnmQfrAEdKS7vy8wCrRrvQPmADNQBa9UVBh?=
 =?us-ascii?Q?MmvlUcZpMrW3FA64f64J/q8bYW3hae0BNECY0G9x9N+rdoxZ2+WV3U75uWPq?=
 =?us-ascii?Q?JPQgCPBpWVtgUaLWd4rSN1Ij4qofZhH8P3U7HH9PvgyCSTEsi5Hko9oAG9T9?=
 =?us-ascii?Q?yrWn/TT/gCio+Qs8U6fWg8pPO6cisYRpZnCxnMxWig66oCVrHARNQmb5qf3P?=
 =?us-ascii?Q?h2cu2NLQR2KguYaJAlDLKWJaXpNCm5HyCrkfKhB5QXlZpX34/lwlr9XlroUJ?=
 =?us-ascii?Q?52QnZo8GNaoF8w0ZtGtKdCyNNJ7BvoX06WqKD3wyBRv7oNWQaoLVr7YN5rrq?=
 =?us-ascii?Q?Ic8vU4AruQuNvwFED9Pe2epBAEZHioA62prExn0TqeIc7FPrPI8PnxuuaM/+?=
 =?us-ascii?Q?RnqVgmeSMzae0E8eGgNzmPmKw53cAz3p61beEkiL7+rWac9gDg1K1xZbeAoj?=
 =?us-ascii?Q?EHcgkPeRGyb9J5rOSCYwJFaBBh+IcSr5HGIC7ysUYWW+mN+2/gqhOz6HkstS?=
 =?us-ascii?Q?NzBTrxRbgzS3NuUgmqLxZQvbQ/E5QjJr1CEuj1fsYuFAvP4VcbDmnFA2ku6Z?=
 =?us-ascii?Q?6dw6z6/hrkKBIJn0Hhtpajao4SwFCDRpn6ZQOi5FQEcfxHCKFi3RGhWovJWH?=
 =?us-ascii?Q?plUxOPYvYeWe195a9z3+VwW5NXsQkwGsXkJ7djvDZqwSVsihKmVvt9E2Q1h0?=
 =?us-ascii?Q?G+Rju5CD7395yE2d2DGUfIvky3UgVXTzijhbRPex7naAhKOC0sTaxSuQt1lT?=
 =?us-ascii?Q?1nxqLN/YRGqlGWk4rrq/ZO1IMC2OR5n5u7c8DBP1YSEhcsyFFG/FWaQWGzXM?=
 =?us-ascii?Q?XB4R/H+lJDYuHQkBmiymwmvyu6BCIaDwDQxPq1ndHHx7fzPDlqUfD7JdkQxy?=
 =?us-ascii?Q?dzOm8yRkIf045qJAD10nqXW++cGdySJrjAAmrlD+pR/1Xqn7AOcN9sNOqDBA?=
 =?us-ascii?Q?+mNloIMHb0ogo1K5a/yvenb4jV0I9096InUISF3s7uQQpAhCv2e5TiuSYlbX?=
 =?us-ascii?Q?zBEac8Zh/IQdxXxOcIFprchHvPaBB0pannM3GTpPXHkcd2+an8oZ3OAu3VtK?=
 =?us-ascii?Q?ZhqRazn1k1JQND8jQH7u1sopllzutrXCASiOa3od7KMpufZzAR4Oc+XbqFnI?=
 =?us-ascii?Q?G2817/+aaCI/3UTZ4c6yf6PsAxcfg55fPkrX1Xft?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5fd4e2-0b42-4e47-7c61-08db14d26772
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:43:31.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mW35y++QYy8OCFHU9LoOW8WRKOR6Vc9RfEGaksZoY6uDnKb3Z9o/TEK1N0l/C+32
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8269

On Wed, Feb 22, 2023 at 02:14:42AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Thursday, February 16, 2023 9:37 AM
> > 
> > On Mon, Feb 13, 2023 at 02:02:41PM -0400, Jason Gunthorpe wrote:
> > > As discussed here is a small series to address the confusing lifetime
> > > scheme for the hwpt. This was some leftover from prior rework that was
> > > never fully cleaned up.
> > >
> > > Make it clear that the ioas and ioas->hwpt_list are associated with the
> > > hwpt during creation and never changed until it is destroyed. A
> > > post-finalize hwpt with a positive reference count is always valid for
> > > device attachment.
> > >
> > > This should simplify the nesting and replace series.
> > >
> > > Jason Gunthorpe (4):
> > >   iommufd: Do not add the same hwpt to the ioas->hwpt_list twice
> > 
> > I've applied this patch to the tree
> > 
> > And my v2 of this series is here now:
> > 
> > https://github.com/jgunthorpe/linux/commits/iommufd_hwpt
> > 
> > Which is completely redone
> > 
> > I will try to make the patches to do replace and alloc hwpt on top of
> > this, I think it fixes all the locking and consistency problems.
> > 
> 
> with group now explicitly tracked in iommufd presumably iommufd
> can continue to use iommu_attach_group() instead of switching to
> iommu_attach_device() as previously planned?

Yes, it seems necessary.

The only other option I could think of was to expose more of the
core's iommu_group struct for owner usage.

Jason
