Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D04414A83
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 16:37:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyzWODAeR466ub8DXhPTPDH+6VA9/bd/PpDdTLONlbzZcVKUSXD70Wi0hUnqCwE06W6feXCAjMenVgDrtPJCP0YZYarg8kQoMlb4EeW1RsEcwRCrZXKp41KtC7jnbJW7KnNWXWLSKo9IaKpchkOkG07QMzGyWGcpbdEMS+BzkX6Fn8SWDkPwfhBpIk3hi5blFvbsUvOoTkB0zXo5UGHKS8L59eOlKTZsG9Uj3fw/QkA4Ha0f7RqAAmq3F43v4dr4pc71rMT7f+Nk9z0AYFbgwKhj+QYVg5X5wWQAcyXul9AMD0yKzesvqoy0gWVLnW4PPkqBNpA0ZZumrHsJOU9Y+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1WlwFQ1bv3/kMsnErqWRyduA6yPCco2lMyscBSJI+0=;
 b=fnMgydbHRWMAMhCKUeh8bjnAMquQBrMJUiPnQ2dWR2GdAQm5s0s78s1f5cwpAZ17vDiu+JavTG2tecOpkPtrF7g55Iqm/w+uAS74M+7OdcPhV6YRETX9QPtuI0wQu/wXqAMknttRCwXk+dTWXjAAZW6UZCcdWUlUiLrBLSEfFLuX2AKtTICFcKiM3Dk0n+SMizvQ07utZIbDj6If3JwU2Es1cypCKg3ew5mGAhMFvHh9RYlq3l/9do+OTBXBzN4HjDLAtfCrnIt7R3zo+CsQkyldk1mlnH13OL+g9Jvdjik/jsBPWwRhij1qFD5eP3Ac6PMPiqCbZZ0GaQ/pMunrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1WlwFQ1bv3/kMsnErqWRyduA6yPCco2lMyscBSJI+0=;
 b=Qj68k9VlsXJKYZJYddZDrRZkt9JyEcsBHrsGGymJb9wyTiubu3kLqCrB5z9n4rjYovFKSUZNv7L3bqNsllZ2Y6dTJ5k9vfxHa6tDXH8pGJMI3JCuGfHfHIKlqwniJ+tTSByJZMdHj95eORD+Pw36XZGFTnlSckIGEoJGq8xi5nSXXhbk2fxuOwARY4AAeHN33ZZus716pRSZUBAtaKAONvYUvg8ooB4qQh34n1FnWrbdXvdnd7ldvyMCMtNQJZeQTXfGuynjdMPAqHaA1KD2IUJvxYJh5ALVxwcAlej0vz8rTIii190kAfnJuGwIvgxRuU+e5/8TQs1g5BfhZm1pEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 16:37:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 16:37:50 +0000
Date: Mon, 25 Sep 2023 13:37:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	Baolu Lu <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <20230925163749.GI13733@nvidia.com>
References: <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <f738e94d-1c1f-94e1-c4e3-752671af3c90@amd.com>
 <20230922120002.GJ13733@nvidia.com>
 <c7014abb-2c8e-fc3f-5cae-75060c8dcaf5@amd.com>
 <BL1PR12MB5144CE1D387F3903D121AAA9F7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144CE1D387F3903D121AAA9F7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: MN2PR20CA0062.namprd20.prod.outlook.com
 (2603:10b6:208:235::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c97a9f-9d49-4405-87b3-08dbbde5c22c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SCO+nsP5RXpvKQVjvkp7eoYh+1c+eQN/DKCNpc/P05ofyjVitzSsOIEtGSZU63m9jQkkzSDK9iPutUBDJZSVHg0T2D9t26x9mi0zdNK/V368MzylWCWEz4GnBiRVs52mfj3Mba5FkZ9iqRQTJoXJRpOjZPDEFEBHLHRnzz0V3wIH96EijL/QQuSOwAk60QWO2VefIykVwcn29YfDWd8QCXcz6bDSpkjw0gGyy3Axwh9mNGbOdJ9zJva1lkC3IVMqD7rZ/VL97CGmnKV8icuKVOAkBILYnLRyeFKvMUT6fQOzd3MGmVlW56kYKVC7rk7lItbh8JapayjXGe5NKPdc/7iIM9ChnpfjRqAT4Y3OpQWKcVaSbPiuDHvobXdscAPm98QsAGnBU48sSJMEODLE1JuXDDaq7tFhSatZit5x8CfeMS0zMeJkMSMGQ9yp8nSG/yTC1yYyMRbanmMt9n6TYxFhDuXt02MxijXjf9h22NstCOKJd0bZyrDNBPrZ06tK8arOGEckXoiHTrGsQ6KeW/4hccARcQNAeeu8BA1rHPZGslDpdF/9lTQzSCw5/Ukx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(1800799009)(186009)(451199024)(6512007)(316002)(38100700002)(66946007)(6916009)(66476007)(54906003)(66556008)(41300700001)(1076003)(36756003)(478600001)(6506007)(53546011)(2616005)(6486002)(26005)(4326008)(33656002)(2906002)(83380400001)(86362001)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mhMAziScQhH8KCQStXlTmFBdDij5GK+OSQQUD4jDgc/QkjA5nX8fN0vEJrfc?=
 =?us-ascii?Q?AcuVIkBch8zR89JUvwqqkpT+p3azA0gKAxAHw7jGqRh+1RdZV+IwN7nv3itq?=
 =?us-ascii?Q?hofh60ZZC27dmWo3yaIhNx0DuykPAHihIs4LS1ia9V7xbCfXWtWQ4jn/8kHU?=
 =?us-ascii?Q?ILCQjM4xONMENShfUVnx5Bfg+OdQGGS3wxFq8U39bvoYHZCLQ+vyJsaZonsN?=
 =?us-ascii?Q?CSF2eacdzTXKvi/AeF/Y0q4irL/5f5Y1b/OGJ/+VuvJeD8I7bvbchD47+w2t?=
 =?us-ascii?Q?HwU2cL8/QT/aatKtD+six9OC77Cmy41jpaWcvrtZRJlq/zt8HHCpixbNrflW?=
 =?us-ascii?Q?ejhP25UTjUnBv95uI2AH0AH/GPZUWkvd/11rlTMSSpCGPnI91bX52iJ4eZuY?=
 =?us-ascii?Q?QUKqdaYKsBVpZK1Yn1WP2WSrVy4Bh2l8aF0SM6Ans0uJMP3LgFoCVJ4TC4qW?=
 =?us-ascii?Q?b/88k7h7vN9vfrk1p11rPH8I02BwqCJJR/8OxQazSLS5i11iBq5G7z1iSzyg?=
 =?us-ascii?Q?OSoD3u8eeGNbm1zLO0lPRikyM3VQiO4BKPhl+gQDTbOm2MvHTsfDgfLIO9ec?=
 =?us-ascii?Q?qOFCCIc5FJHqna/1UQpDELKiIaXZ7pZ0iPg+tMbwNeJAj/6tu/jbmbCYdFXV?=
 =?us-ascii?Q?EQs7cNC3qzK/YHwzHlwmkgeIlMvTkTDcX0yxVyeH+eMKslOOzXIDCtLaN+g3?=
 =?us-ascii?Q?I6J98BtaiemkBYxrKNwxuk8Yx8P6ThrBCOu0G+mLBI1EDv7SOXaMPPY9Agb4?=
 =?us-ascii?Q?K2xtlVZlmcc3VqphV7C14kqHMW42m1jG0PKVZp5XUjM/On2KPBIk/ovLD8Ta?=
 =?us-ascii?Q?VKNdshZd6k6WMZEcBDcZdoHGuTLhqSS9NG1tydwYcJtIBvSeD6Sn2ALKyeCQ?=
 =?us-ascii?Q?9ZWD/C7Gim8O1OEX9QGS4z21bdq7gp7edyj3OzJO6DwL0Wh8lYG8NmgmaiFa?=
 =?us-ascii?Q?zpIJUleJ7vxt4vaUkcdxni4NK9suxrXf06sp8iHYWo7QLMKRO51USRmVB5+h?=
 =?us-ascii?Q?HQuZdtyU/lBJuWMuUr2bYGxWYscSlB+z2Qofyi0pSv9LWxkuhr620y+xIv/S?=
 =?us-ascii?Q?u05c2LG/aFyb7aO+w7C5DlZUMHzrgWUmEm6Z8x6Z2/3B3yTIf7YopU3hqFF3?=
 =?us-ascii?Q?UvVelO0CP+clJCf76cSnh6xxfTgQr02gV3vJXCeNdRCp44xAWALkf3DhWDOz?=
 =?us-ascii?Q?DQsjfbfONDQI0ExZMwPV0shsmR3bj+qPoF0Y2y97UbsaTfwenoZJQjNlN4xx?=
 =?us-ascii?Q?gxIcgLq0eYkRj2Sx/5A1SoiCaWV94VKIJfIEPhjpbspAFntYcotvh67yeRJP?=
 =?us-ascii?Q?OYt62cwY/sKnI9RLtQlGYnQ6GDaOV3dD1jFgmfpwiaVwhOF35COm+NYSr4vL?=
 =?us-ascii?Q?JiakGZnX/SldOJgzefo9O8a9W7e4sEBKPRhta3c2HCzDUZ/2EHyw3BJKeofi?=
 =?us-ascii?Q?ySIdXIWPkPwonw5Lok6oWrWpiKAI6PeHyLslp3Wk4LKY7CXWLUqy4vGmM+9/?=
 =?us-ascii?Q?jMnCpyciRliiaQRF2rjYg+W5Yv0SXlc08UdjtHoC3XTe4BBYMdSCvQKnGLob?=
 =?us-ascii?Q?r8mklC3eFbv/VuZBooJhl9RWhzicWX6amG8stdDQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c97a9f-9d49-4405-87b3-08dbbde5c22c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:37:50.7461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8AJpOapC7Ei+ybImVyyS3BdWC5J/xEzjbhtFGvmdJfdCjqWB/7awIhCRmHXpHdF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

On Mon, Sep 25, 2023 at 04:31:50PM +0000, Deucher, Alexander wrote:

> > On 9/22/2023 5:30 PM, Jason Gunthorpe wrote:
> > > On Fri, Sep 22, 2023 at 02:22:11PM +0530, Vasant Hegde wrote:
> > >>> 2) PCI device supports ATS and PASID
> > >>>    In this case, ATS is required for PRI, so we should enable it
> > >>> even if
> > >>>    the default domain has been configured to PASSTHROUGH mode.
> > >>
> > >> IMO we should enable ATS along with enable_feature(PRI).
> > >
> > > Definately not. ATS is valuable and importnat without PRI.
> >
> > I get that. But I am not sure whether I understood the usecase when domain is
> > in passthrough mode. Do you have any usecase to enable ATS when device is
> > in pass through mode?
> 
> It should still reduce latency.  Even in 1:1 mode, there is still an
> address lookup that can be cached.

Oh, on a lot of devices the ATS bits just enable device's PCI to issue
ATS, it doesn't mean that *every* operation has to be ATS.

So the non-SVA transactions can freely run in non-ATS mode with 1:1
while only SVA operations use ATS.

IIRC most IOMMU still have a lookup for a translated request to
validate that the RID is authorized to use them. So there is no
savings, just overhead.

Jason
