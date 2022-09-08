Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E833222
	for <iommu@lists.linux.dev>; Thu,  8 Sep 2022 13:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cclf9UAJEYb1UxMBTdnjK9LvjtF97ONf5BBoy+u0rkg5g+Qz9uEYermoMaHGEydCOGxvoD/Sjsga2uhmUNyZx8e9gOOzBOhKmWD638ESqJI4VmtXbKDCKDqCNM43Ghmh1NTUi9jbCGLsLNMNEArGXGJJeYottT/0BeYfH7sjAk8K/ypjzQWFk+xWyucIWoHYRUAEFFyBsIt/4pD2Kmw62OlQiyYRZ0MuiPbjQhsdg2rEGyhKTWlRSKxQWwKUN0OdTLRXQJHPutR68MtIUa3ne6qB7216/itpRuN1toL8gULU5km2CCJIClvNP2QIXAR3K//gkhKhyozQwpHecCjgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeEB3NEeJv/wfNrhyYAVVvN1TJoR4Y7mOXZpuTA86mY=;
 b=Jw5CWcwQc3TDkqf1ak2SwwZ6XbK++OSuMr3G/R4jrvd8E0pqSWNCxeX4GdEl7kn7n/Q79vPBoQYF+eMJIjQ1jj1XlTUeyC3pZfwpQRivB00VLA16q3YZmrbDjBtk0YwjOoBoUB7uGS2js24j8IU/1yUGSX3Bo3PodYuubpu+tB16/sXWuZeB4GQ1nLb73Tgf95qPAW0BRc9lpJy/MYLYmbklFMFtXeQjGzVqmbb3YXAbWEydmBjjS47fdig3C2sTL9Tgw3i6U7xqr/IPMvbqJh4jLPpRHr3RlTFEzg9byk6opuSKb8+SmVZBq+ZufyIkHrDekmDCeoQeSTDmpbxhIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeEB3NEeJv/wfNrhyYAVVvN1TJoR4Y7mOXZpuTA86mY=;
 b=Yfijb8j+rVeKDK+b6tldCAeBCBkCbZ+illJnZetzD3Wmyd1l5gGyQpMiQeBdbzmg0DyHciWzE07dGhBeB8FhxhLrKGNag3b9brnEOPkSFQMp2Sa7wc51OlYpBCig2aB4FxnSVSbgjiC8LjaEa8QIqecnousiyosKCftB9AWGuth9CH/pJbeJURdmtZSCpNS6ITM8gNuNn/9Uz/HV4CULxQvLXe+CzuRfwe3LgZ0v/2fUCRiWoCQ2CXv+UKlq9rDQLMKZMtTnqx6yyIRBza7zGJ4LJe6Mv6e/h84VT8dYKuxRv7IkEho/Yv6hxQicq9T0NGHIrb5NRFs0aF+FsfPOxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 13:58:59 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 13:58:59 +0000
Date: Thu, 8 Sep 2022 10:58:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
	iommu@lists.linux.dev, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Message-ID: <Yxn1IcWk+61ddiCn@nvidia.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
 <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
 <05f9784b-15b6-2a9b-2d9e-19e1430f74e2@arm.com>
 <YxintMDEmzSXJUl5@8bytes.org>
 <YxjMQpGYaHfsiuL+@nvidia.com>
 <YxneJ2RqaatKmoYT@8bytes.org>
 <c11bd109-65cd-39b3-6d7e-2b29208ca2ca@arm.com>
 <Yxnr1gBIGwdinIkr@nvidia.com>
 <YxnuYTrkC5yoHH84@8bytes.org>
 <c48211fe-00b1-e679-21b8-00a85bba599a@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c48211fe-00b1-e679-21b8-00a85bba599a@arm.com>
X-ClientProxiedBy: MN2PR11CA0013.namprd11.prod.outlook.com
 (2603:10b6:208:23b::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c9ca51-c4f2-4d7e-73e8-08da91a2471b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	etmB6i8lI+GZDATpz8/XPRpNV7RuM1QHFGrAKsf02v6anykCES2hztCSP0wMsZ7FcDbnvMpgrCgToz1+O5VhzWD2k4UpfAvn6k5glpaFrv9WqMZBYaBUjIEFOu+4E7y4O+X8YiUfrK3RODfI1sNYKvuBRI7mqfDETr8GHhJlDHilnFYVgiqUCvwtyFPc60kuV/ZtgSHKISLzxHjolxdUbOFSoWLgGpgqar5D+2GIvFoOGJQ0Okjf4fpY0z6hA7VyxBiudohyWq7nU1HMsUleSm/GFWinOv8Wooi7RAeot4Pg/2BiRZo/aRR5f3vDhOVRTCXrRGqik3z6GmqrgW8zB5OT0uEpy3j9pcXsMmVD2F72jhEOItHEq57qcsIZnJV9pjExXTWGPQedIMa1rWxtW/ZB3xM0L8vpgaxTeLOtDsd38Oxte6vcP7Wn/iwigCtEg8GNwVuTvUXJI5Z1hKou3Z1iTNJ2d1kIsMhSAGvMPfv6MrPS7h1x9rX1UDLEOVlRDVCgVZFbj88ozt9A3QYteOpBgP6i+psSG+oKXzn6+B89TMCPmtyX+4SK3Rwa5jtegJoOQAbvg5IrXa7HEsz/L7X6hPD/4kytYfYF9OOZTi7+3fIZ/22aPOzKZPmjTo7YUU4cwM88/syXwVx5IApNsMkcNoTPMILgSEwKsGV+GOFgJ/T+YRTnfH5CAwMEU//dfK/Gu+ytbl95UnztS9q7N8OYt8oV4cymBN0WBWWG6w5yAz5xQ/3cfOf1SIEoyjFPIt8uAID+VyWPez3c1NvR8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(2906002)(66946007)(6916009)(8676002)(54906003)(4326008)(66556008)(6486002)(66476007)(8936002)(316002)(5660300002)(478600001)(53546011)(36756003)(38100700002)(86362001)(6506007)(2616005)(26005)(186003)(6512007)(83380400001)(41300700001)(41533002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dLdliAQvDOtIMyhDh3+4VgdOAU4PkFxd0tbPde9v9EygEVOJjs9y3/xqr71X?=
 =?us-ascii?Q?hrPxWjBbahYS3t2imtUUxz8s3BMHwvYDDpWlEb0rlRGvMhdWhU53SWT/SKY8?=
 =?us-ascii?Q?SRjcICoWw8U3ZDfn9u17zx6277wV5bO9g7+wdX/Kh7I1zdTd+Wu85nJVzIQc?=
 =?us-ascii?Q?Mjjnd/oOK+Kv669Zd8+i0s+wrkUuqyco4U36m/Akb8SPJXmSDcHv8gH643Pr?=
 =?us-ascii?Q?y16BcboCJXwBZlST/PBu1r1e70KuHHOma5alijL1xR9BbGiMJNcrVB0xdEN4?=
 =?us-ascii?Q?yPLMbgMfip0D471jx/D7TNluD432WArz7JmRN2C6W0sICcosDP6uRXjN/q0Q?=
 =?us-ascii?Q?kPxiSo2WOCBn52R0s9XgzL0dmNGFMev+OxpgPAvZSxveqGHak3KQ2WjekRra?=
 =?us-ascii?Q?ePd4N+aMd+GxwgtAhVq85LwCVy2FQGkZRm7FL+fVUSQYgTQoggz48jHq9PIj?=
 =?us-ascii?Q?WV7gCL1iE3Gu/waRk8m4CF7DpcyafbJjPIEYwhCK3bzKh+qbluH1w9UsF07P?=
 =?us-ascii?Q?SvccrZjbMSUhXg+By+bR83rWELjqM0/hqYeEyGlSkRmgwCCqW9cyQLaOatGO?=
 =?us-ascii?Q?7zLErtLQTgdYPn/MBXd/r8Sub1mJcwpmB7r1v605ysjLnk69p0TDSq5U7yGe?=
 =?us-ascii?Q?iILmx+AxxVEsoj3DR20K6/OVcZE9pVWMOfr0Z8YgA1a9yaTjIi5PsNl7kiAF?=
 =?us-ascii?Q?Ejlt+x2sRot760Gm6p4U/V9HubPQncyxysT0evd0kjoILjZSFjAlRTNZA1qv?=
 =?us-ascii?Q?fFjK5qI491qADU4WkMJj1cXTFSABg0MXSM2/g69WiyyVT8jod4NSDX5duhA3?=
 =?us-ascii?Q?K9XZ7r2kNPexqawAe7BIYlOvaco8kAxHXAR8Sz3fiVTrlrhQY3pcivsBjGZq?=
 =?us-ascii?Q?19Gkd1VVwvywNmlQDUCL++5wLmFUf5XMGj3QLSo+yKfZ2pEtay0GM7C/HKN9?=
 =?us-ascii?Q?iduD+7Y1yKOj85YCfXFI5DVY+pm34e0lgO86EcI+MzzQLsUzJbYeRDgjqZGc?=
 =?us-ascii?Q?Y7yp5miU8qwwqc+cZ3b9xI82PJruw+vqMoP/4MXhxINJX2MTWV/gVNQJnFC0?=
 =?us-ascii?Q?WQx/lDAHHQP9+VpNyl5Sihf9F3iobgji7Zy4tmFPNnpxVe47U0TSxll6FVzg?=
 =?us-ascii?Q?UdeUvbuJxFwFx1Zr/34z9skR7/N+VXBiTQc4O4Jjt/cNhSDIrgPAaZEOI7K3?=
 =?us-ascii?Q?+mQpXw4Wx++PUtWgqqJnrf19ou7ppd3V+qnC7AQmebr2iHIURYVBduJ/5E3J?=
 =?us-ascii?Q?9KUZMsa3gFnJqADgDkRNERbkg+brg2M++91BDCINhFoT7YmqwGNoYsUPqAkk?=
 =?us-ascii?Q?vWcZD0sxIRoa06wKcvHHo4El7iPWfwzMH6ZRXFS7Ay28WqrumK1yosHzB0IL?=
 =?us-ascii?Q?I3CMF/r65j2J2dU0fTqkhKK+rCeu3rFGQwOh+jDBdZDj9lRl3dTm/d3Ff8J1?=
 =?us-ascii?Q?5Il/PrS2k+HpTDFPOPBTojJdBSZJ0QATLgL9jePgLSwk3aV2rCEnaH61/sU1?=
 =?us-ascii?Q?Ys3bibU3cAH6TNV2kz4l9hCw/eNKn6SSCLB1jfejlYou11I9jCz1SNiAGLoF?=
 =?us-ascii?Q?Ys5E0FR3Kl8Ys+DmtLRNfv+PT3tSUOvjBEtBuHk2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c9ca51-c4f2-4d7e-73e8-08da91a2471b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 13:58:59.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88eNfAThi8+0dOJ2YbSPsi02CNNk43xdWcF3kemecRm5BqhdhqhJJGJCFo6R62oJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

On Thu, Sep 08, 2022 at 02:47:11PM +0100, Robin Murphy wrote:
> On 2022-09-08 14:30, Joerg Roedel wrote:
> > On Thu, Sep 08, 2022 at 10:19:18AM -0300, Jason Gunthorpe wrote:
> > > What is the use case for having PASID nested under another level of
> > > translation?
> > 
> > Virtualization. Basically having a device access process address spaces
> > inside a virtual machine. That got never put into code, but it was the
> > rationale behind it.
> 
> For SMMUv3 it did actually get as far as a prototype[1] before the iommufd
> work interjected. I believe there are cloud vendors using those patches in
> their deployments :O

This is a bit different, this is just normal nested translation stuff.

AMD decision has effectively nested the PASID under the RID, while
typically nested translation nests PASID and RID equally under a
parent table.

I can't think of a use case for nesting the PASID under the RID, in
every scenario this seems to be problematic. Glad to see it is undone
with the new HW.

Jason
