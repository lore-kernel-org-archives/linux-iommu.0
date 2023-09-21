Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A20B676
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 14:14:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVEUcUNKKYY/xxW8Aspdh5M081TDrZv12e0yUasvUTYgd0DH24ZzPKhghUgxbPJRN0PVDc9XOgvUXo8oMBCBQlm0FqR7AYPFIQ6di5BnOFBwR1h5cgttslGm+DrYAWwhHT+3mQMBmWolZPdvVH8dc4F4/YFMSwA/3mHL42YTcvnCwuE29RqdGvPScurIMRuTFPoHToMNKB8HQs6zHOQiPdX0MV+HN1PvldR5wSmfJak9XD556PUzLKzfqGZ80ybVpg5BS+P6sfWRLOs7tzPKf61ywOmaQW8kfGufQkdg3zwF3Su5HTfqAbavzuBXLWsKUzNV7zf9h+x7QLN0XVpNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42yBRZRUJgEnuVexE1pC0FyGwrC4aGR1atag8I/FhQg=;
 b=lBxmvk/DOW5Sf655FXesbDhXHmlmph7FgCKrFcXGZ9kqoOuMBpRnMqJM0aVWV1/aazlSIK3aacrQyloG3RyhtfTGY6MnYowQl6M312vUu+n6ojew9QRtGnQaJwluSWs1ypFUDj8EKAzmNNWZyla2HnLhW2N2hKysUhQsHikSA+a8PKKuiTjUIwZU/6KICqzcHMGkLUl7IOjEXWvmzz7OL742IKNoE/dbNP+2YXrHqk+1RGRs10XgOqindhSyL5awJwimL+pVLTqwcAVxbcDJvWk/evo3CTRnYikxIAhmLnhr//2sM1N6QR2upkf2+Jq3Ill80ad8k5gWrVDcQjVbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42yBRZRUJgEnuVexE1pC0FyGwrC4aGR1atag8I/FhQg=;
 b=Fo5jAz58AoHQAwO4AoGTpkrmga6QkWxFFPpmE7grawjnHO0Okrb8WRWA12icnZdhm4Gh8gfPCPsycwTodf1/iMn+Ce2EgiMqaWQ6bT34KU0zDpoZfz/jhJH+c0Jql2/Uy+gL6Nd7otU/Djtyq2QtHBgjq12x84X4wHYzkV5XPX1Js4+2TLdeQYh7uzDkzb6WZsqylXTofAHdIseuuBPH1dZUzSycThWkwaBg4Nezp+LS5FetCHHRXVzxEovaXTSOqY4ORyLLb/oJAHvA1iY/3veW+3m1WjfNs9+62c77Hk8gGSO6bRjW5uOBupUYTnJg9nraq/ysW44qy4i6VTvrtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5096.namprd12.prod.outlook.com (2603:10b6:208:316::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 14:14:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 14:14:16 +0000
Date: Thu, 21 Sep 2023 11:14:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Hegde, Vasant" <Vasant.Hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>,
	"Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Message-ID: <20230921141415.GN13733@nvidia.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
X-ClientProxiedBy: YT4PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5096:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e3d692-b9ae-47c6-8e7f-08dbbaad0a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hM8x6e6dGV5DznpYsv2f28DLlTE9zTP3/Adha+ADZ8C0ojBkkIFmGxUdBGeDL42h9BOrSJa49/d6rgm/obUNXZfK5GoPAAMrOQA73et0ifY9+dxcX9f0pb7b3W6H4HI4zztpodKYkvtf4JegNUYWLLsx47QBOtKPPfYvVjUWfKj2tifod3N0qbacH8CcwMGahhs7jssqNvPFsZJm/VeOyEvWFgiS+O++Y0yxPwXZV4PDrh8MY9eI2pZHVXbrkEg1Ekm7ziKBT81jrTDKuzbhAFitgp6XvfxYr+3fG6vbm4hYLkrxrbx+uU3vJfOeTJl1a6F9r8MQVou6Bv8So5m4b273TRgy1xKGw4+uno95wCpMy1YdabRgx72XPC9lMYs12Ma1c4Ink7WfmrPKUSRJZUgm1PMW9GoaY3eCviK0LddbNzCaaevlCn/v5WRpG503bfTpB0C5SxFyJPw6FQ22A+X+QjbkW2xDgOyFSgXZj4rj3sEz4ZTZm3ZYgEv8KCLdmrf68WTgLwd7AFJlGY91sTx2mQ/neouipXlrA6gCEuWEfLFMUKqI1Er5MnoVRPup
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199024)(186009)(1800799009)(53546011)(6512007)(6506007)(6486002)(83380400001)(86362001)(36756003)(38100700002)(33656002)(2906002)(2616005)(1076003)(478600001)(6916009)(8676002)(5660300002)(54906003)(4326008)(8936002)(26005)(316002)(66946007)(66556008)(66476007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1li3dY6OSEYtuNvybewKUwWgqmpEh34kVH4os/ocEcIfcSedURcE5vZfLmD4?=
 =?us-ascii?Q?sAoQv/5RnmbCAQ/zR/uMZyJ9sVZT3M0OS3w5ed+GxOPV/7cea5r5BoQ7a/Am?=
 =?us-ascii?Q?wetAvbRDaDgD1hDQjjJgpVyb9uKHExpO5P6zfU7ZasCDhginYk/I7WkdiDkq?=
 =?us-ascii?Q?SHhb2xFajOjTvSu2H6h5ZmUO2JepHKJM3qMRxYP/QGNvCEkXjLxEqJ7q+syu?=
 =?us-ascii?Q?nJbls5CCMZaNQIt+0dYioA4hYmw+Z1MX9TKao7pP8WC7CfTb3MFma/TWLDOV?=
 =?us-ascii?Q?z/nom+F3gqtx9gMyH1qEzRU0gZSMbP6dK1Mz7lCPxjLD1OUCXHbULqkV8wyS?=
 =?us-ascii?Q?RNcwytaq7WEyPb2lEoO1jX4mrUIAdpTbxb3wOreIWe73lAN61jMY2yUA2jWr?=
 =?us-ascii?Q?nIDOKWpCbh5O5bfe65wZKGcVvOPtYCtuAQUs+TkuC5WmA2qHZg/+OMhVPlKI?=
 =?us-ascii?Q?etze5+P+nH20lAwyY9FGx/rzitsZbpf7MvcHzkEzq7RpbZKfMN62Up70h7yQ?=
 =?us-ascii?Q?z0zFRFIazAqJ6tRq3e1+kUFrJUTnEulDavniqkKohKG1U0kVXdUEggLDysW6?=
 =?us-ascii?Q?wTDtyKFNjEULpq/JH4Y7J4OOfdMjVA/vfCmGvZSq1UOQPtRR6GxCN6z9DYSf?=
 =?us-ascii?Q?wTJKcABRhsVpHjZqNI13HXzM0ojYBgdyaCAiWTZ0rsCasvfTkh6BXgsNuLN3?=
 =?us-ascii?Q?XYIpUh8XtnzH9GL0cK/yBCnBNzu8HRcTs3w8rFI80vyxifBY4yv4+t6iddtk?=
 =?us-ascii?Q?8IDiliENRnZZGV+Sj4hwp8OgspBivdsHWKTen9Rfr7Fbr9iK3EUD43YMc4TC?=
 =?us-ascii?Q?6a//nmbBeGxK0QHfl5FVZpwxvBpik715PvrBPlOFI7gAIISbetQfdzrGNCxX?=
 =?us-ascii?Q?WwbToguB4ilA2XcJKVaiexYVnFkDK4aOn7FZZuUiBDudDlkI22ZCuUplQIXH?=
 =?us-ascii?Q?ojYWcLRjtPHaHBaD8Nr5P9ce8uLifznrK+VQK6nLk+CXC7lO7YnIi0O6PUwx?=
 =?us-ascii?Q?JLWvpccytnRtq83kr5Kp7TEcwtNvAZovfQTUkaEbHcKobRu586bELdJFDEvw?=
 =?us-ascii?Q?yxkB5Dt6sA66eP20SKwFc2svvix3NwtovWyL+fIWw/REpJDWmN6wX0hXX7m8?=
 =?us-ascii?Q?EYG+TBipNMj4/E49uQb/qR7Y3zQFczRFNEkZ3iD9rDYu6mIBPVWmNzRk1lG7?=
 =?us-ascii?Q?KR7pVU/x/aLFYfrIOXr+nyuZgzK/IGw5o9k2uU9j3ietkJ8tmLLqXTO/DShf?=
 =?us-ascii?Q?z1KlBa/5OdWrLV6Ju6Tc/bGSenusrGuSJ5bcwJyXuR8OkHZ6xkqjMvBblEJN?=
 =?us-ascii?Q?mpJxQiAztThxJFqkDjEoACBEPjtOA1MRr30OTgmYfU0YvTrYQD2ZIbKU6QSO?=
 =?us-ascii?Q?DrssuwjZznt9DJGwvYhLA/YrwfCanm2WY9sM4o607vZJgik0M5u89GCLkQi7?=
 =?us-ascii?Q?guvBHlWqbl501v/O6He/BV6cZT4NzZdf7ugObTGj6Mk/CSOUfVvkOL+uUsYH?=
 =?us-ascii?Q?ao68TDfueyPUIS2sRqkmK9e3TFUAQzk3BKoGVGoSE0kS4NaV1o7iXjrcYeY1?=
 =?us-ascii?Q?xC18yJUtZoZDS7DwowDDDTqyRkFyx10okkhB5stc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e3d692-b9ae-47c6-8e7f-08dbbaad0a27
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 14:14:16.6538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyeP+IE8UCR7CLTdfH2XZyhHMcrZqBvjd+GnJWZNA+Zi1ZDSUjVqfIz5btgyWheS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5096

On Thu, Sep 21, 2023 at 02:05:37PM +0000, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
> > -----Original Message-----
> > From: Hegde, Vasant <Vasant.Hegde@amd.com>
> > Sent: Thursday, September 21, 2023 5:32 AM
> > To: iommu@lists.linux.dev; joro@8bytes.org
> > Cc: Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Huang2, Wei
> > <Wei.Huang2@amd.com>; jsnitsel@redhat.com; jgg@ziepe.ca; Hegde, Vasant
> > <Vasant.Hegde@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> > Jason Gunthorpe <jgg@nvidia.com>
> > Subject: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
> >
> > AMD GPU driver which was the only in-kernel user of iommu_v2 module
> > removed dependency on iommu_v2 module.
> >
> > Also we are working on adding SVA support in AMD IOMMU driver. Device
> > drivers are expected to use common SVA framework to enable device
> > PASID/PRI features.
> >
> > Removing iommu_v2 module and then adding SVA simplifies the
> > development.
> > Hence remove iommu_v2 module.
> 
> Does this patch or the following patches make any functional changes
> for devices?  E.g., devices which supported ATS would have been put
> into an identity mapping mode previously Is that still retained?

Huh? Why would we ever want to do that?

Policy for the default domain belongs in the iommu subsystem except in
extreme cases, the AMD driver should not be doing random things like
forcing identity for ATS capable PCI devices.

Jason
