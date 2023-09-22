Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC6D171D5
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 17:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDqDE/pfORjoJO8V+lWpbdMswDlsll5iwHztRlJe3wv2sIOC6rNWo/CgnLbZYZiDbkEJkENTYOCWVZHcKOKo8rEb6xPs4Mz/cC7ZRlHRGqRS8YRoxNA6HjDM/P1YKfgAZKEW/WlNKdJ3sUqcZxUl5ZTMsVPx0hH6pVSDt0Nn8UGl4iMkwFosFjoEFMEMG/ViE+KHKD+MF++IwGZIFTec7OqeQLAq7aeSnF0v/1fKtJI7d25bFNJ8NKVzvx8wtv1f//DeSuzJpEz6cdf++jjBzFYCfHlrRTCWFjsbRiWAuX8carGcWYDAXD+PLTb6ES9EDT2YZvCe9tQnJ2ID36cx5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42ateOxURQubuYjek7Y7vCy+PzyB6zmFbxxOhHo/6Ag=;
 b=hoo4FZa8Jog+Lt8kRvBaB1MCIwA2OeHcbPqlHVwa3c+uWFG7oVEl+rqa0aU45zDHNdEu04y3p8mMXhfZERggSjbRQNDoOvGIJId3ovg1jpD7KiuqBSarBnWwRY74xNsiEZlQdRgbgJopalovz5ks0PZahzzuLwI73vD23P4s9GSR76xfArkWY4hK/A1x4qtJqtYxtOgEmpSXZ5Db45ar4WOZ/YLI1KQPDQe7u2Tf/sgFQy5MMOZXR9rufLBamyd1ufd8wOgx9vrOSzQL66X2WIQZRGrmxbz5CSF56uxvelRp4KqI16U+cfpKz8avhROQ/mWtuIK9hpRDRGoX1k2YHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42ateOxURQubuYjek7Y7vCy+PzyB6zmFbxxOhHo/6Ag=;
 b=ED52uw1go2dEJmekkDM6S5uKpxJO7vwKf28Wa2U0NfI0qKjUkERibGi/BJCtWOnlmE9gUsd8AG5PmLONvgZaDjt2aPJg+Jf+0Mcjige8XT7h9szR+0aYyh2fXEIVoVMBBciNIoC+KO8u239x6Q6t+c7X7nVPCjTqhXrFuQPLZNskusBgJPPHlF/4porKKlSsJ5x6XOiyUS+E5xBmA7+i5ILJesWr7mSIDdzXlStue4cnLjyud84AdQfWdX3LfV7+ozWiooB3SdbVT8wfStSJPqi0EeXtLJy5KroTPXjEpfzTOZKNert/xSMVBeREURvw3eD+MXVEHFc8echectWy2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9344.namprd12.prod.outlook.com (2603:10b6:610:1c8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 17:28:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 17:28:34 +0000
Date: Fri, 22 Sep 2023 14:28:31 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
	heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: Re: [PATCH 8/8] iommu: Improve map/unmap sanity checks
Message-ID: <20230922172831.GA145934@nvidia.com>
References: <cover.1694525662.git.robin.murphy@arm.com>
 <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>
 <ZQHJoK0Er/nekjL6@ziepe.ca>
 <8c8451aa-d0d7-058e-cfc2-7402f9002234@arm.com>
 <ZQMBLFB20ke4hv9t@ziepe.ca>
 <e37085dc-cac4-b7f4-8c2e-e51e56a66887@arm.com>
 <ZQM5WRzyQkk7sq+t@ziepe.ca>
 <fef0b304-5a19-b2a3-c399-7f21c05623bf@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fef0b304-5a19-b2a3-c399-7f21c05623bf@arm.com>
X-ClientProxiedBy: YQZPR01CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9344:EE_
X-MS-Office365-Filtering-Correlation-Id: 655abc14-2569-4fb1-01dd-08dbbb9158c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EZWogItAuQTadvpxMpbCUDngyVOUaVRQOMjJBGasPhrejQ+mKmG0BRr5JdO0mpdOuvTWnonfBK9CpwvDLjzaHGaTwsbyUEkGphJ6BzFrHPukAQ9t1lwrSQqD8QthlhoWe1u8q0XL2d9WUX1IbtcywiaFRVi9H/wfrkuEGAUbgnbVNSxVfnd4YGD7l/o6JDGBNMM6dFRKxAFM5BiVrD6Kin/76LorQAkCOSRn8gGPo8sBZFN6jwn0iwuzXfv3lEVDY6xAVsupIj+OYlAXGfVsP7c3bqIevzNkVP94xZ7vvH8IljUX+SQEDbJJAPuvcDPCFcvJvnQncRzA2L6bCjKo7qJxHq3nbnSisfUkdAE7a54AsO7rrhPsSCvkcW+Uj2sGZj2Fi9AkEjselRAeqBNPwRxDBO3eWgbI9bDJw/VyBN54bkBOQpwfpe+65i/NQe0cRpSYtK8F/ObCx38r2u7SbAaDCgYPPx5NUJQPrk08UV10nee5/KazkmhFnFHRVhfnIBIEs/6nvgH9LNRWX6++a98xlYjGQaYRNwG9IAEyIGpQOKcUsuiZXxoAsXOPKGzDySKqMA2QKRFx+9Y+/2772kYZdSBoYo21r/a6ixLrGxyTtwFVHyAvfC/mZONy4ULm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(1800799009)(451199024)(186009)(83380400001)(6506007)(6512007)(5660300002)(2906002)(4326008)(316002)(6916009)(8936002)(36756003)(8676002)(6486002)(41300700001)(33656002)(26005)(66946007)(2616005)(38100700002)(86362001)(107886003)(6666004)(66556008)(478600001)(66476007)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PkMfkq/MCvVJCvRF5v5bUw570KhE2ckpZcr7/lIGFCPt3o0hn9fyEUYSZ14u?=
 =?us-ascii?Q?rXFXCL6w8lGraMK4B2pv/G/olAR2d/1Puv1LfljgiTai+x79cVYdyn/joPzl?=
 =?us-ascii?Q?m1WeX7/PPQ9vhtZfEQ8AbaxGA6s1dcRxxb0bwjQUMhz3rVbF679Mw32O69bk?=
 =?us-ascii?Q?hEig8G3Wr4PvJjGutUvTf0Pq4BcHJvS11lLbRMAZw9OyHztsfbx06g1AEPjx?=
 =?us-ascii?Q?hDwc5kXJfzw6eG4a/D0lS1G6soreGWUHxbmIliWikQsZ1fkzblRjEKyXQJzc?=
 =?us-ascii?Q?FfD4Nof2ncx2+/RluMU1yq8dhFysbgWhqC+rQ+O9VJ+87kM+K7PfbvhtaRbq?=
 =?us-ascii?Q?p5JkvV5qPNdiUUOXHnvIh93C1BcvCxdP30SoBM+UZfwmSy4c7tlL6w4Fd2G8?=
 =?us-ascii?Q?pLR2IjT53k400XF2OA9YUzN9l8DLqyayLkO8hI4ssYTfrnikTBavdPlA6d3r?=
 =?us-ascii?Q?iF4vHWdODsRBHzr27TznebpBS/IwnrAGlsqHO9EnqlogLU54dX1t3ExkGqbJ?=
 =?us-ascii?Q?8WIyo3yQ2oZu03cCPdosYfZp7p3PFbLafqUMQTmfzAS9VC1f8Lt5PeHXgsl4?=
 =?us-ascii?Q?VbsPY29p3A22qEuLlyg1RaF++riPW4g9Mgnm/lljswgNp6ThToQz58i07m6/?=
 =?us-ascii?Q?0g4VUijtkmCHbed6SeRPX+HPO8plmHQXCt3GTWX2NDwRFjb3ORpWpSuA3zJq?=
 =?us-ascii?Q?zAD9+34TJIQcPcnkC8ewJpNoHL+g94tb03CR5dwjMlz+oXLhW+gF/hwm/moC?=
 =?us-ascii?Q?n2+y21ymGTguCLptXCtjLeD2XFwKVouAFCR/z+eqrTuHW3afB+tTziUlOQQx?=
 =?us-ascii?Q?Rz/JasvvY6CqJ/y6UiR2dh16xq33M0mdqgyox1n2I9A25qvkMKKUy5oIz9jJ?=
 =?us-ascii?Q?iZokanU453jD9oa9djaKWcZL9NM57Oyq4A7JtWDAq6svPqWO188Kt737+SPO?=
 =?us-ascii?Q?wBesQvY0TMEhfKDAjpv70H29+Xp8SDMvQYKDxhA0rHhbdk9qzYEYtZbfCt/R?=
 =?us-ascii?Q?yKZzXcsNdm0UZBAD0VrsSU17jngg4+ZVZvaWOsD/RlPssoEOXQUjkWwpJtsC?=
 =?us-ascii?Q?0/zT1DXnvNEdG2myQcrOZ6hHIIfQmyYJxnrQtOm0CfAF9W6GP1YXRX+sPR/n?=
 =?us-ascii?Q?tELW+vbyKr1I4dwS4RYtbV6xhWrBmtprnii9YsqwnIfNq89Yokui3N36XYqG?=
 =?us-ascii?Q?FOCznUwr+jODvah8L+uKE8vd5TUhS6Kmz7HM+A/vi2i8slB77q+MqMol2Lgk?=
 =?us-ascii?Q?0O6Y1No4xrlqtYR0Vq5PFAOKK71ryUHpLAxqIxzYMynx0Ri8eSShGlQECmS5?=
 =?us-ascii?Q?NIvQ2JHaT2frg9wqXv3r+T5sEbtC1V9iW1WVzz374iOw25TW3+QC1gSX683r?=
 =?us-ascii?Q?1kpIok2s/3bDAABHv09zPyQAOCQhFyThOgTtgfGOKrPwesnW2CFpdvLNAuIc?=
 =?us-ascii?Q?2NOV44/0EjltjNgOrLtjAj6VXOSp8dB3gegh0iGTgPfBMrVnS9r8mfo0v3uT?=
 =?us-ascii?Q?fNsxxFDngvfnrYVcQSDCMHKRr8CMu+7jqFWw7t+nxfMXxZ/OP9yJw+uZMn78?=
 =?us-ascii?Q?kR47/ZeSSmW1NZBwaeGO5qc2K0N/FMtaqkw7rb3o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655abc14-2569-4fb1-01dd-08dbbb9158c9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 17:28:34.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIlRvXoUD0iKx66WnHZW30rQQ08xtVY1kc9vx2Fh7zc4rVBwCvocjRz4ViuR1l6I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9344

On Tue, Sep 19, 2023 at 01:18:31PM +0100, Robin Murphy wrote:

> > This is not a theoretical question - does any in-kernel code actually
> > do that and expect it to work? I didn't notice any..
> 
> I was hoping to have to say I'd only seen it in unmerged (e.g. [1]) and
> downstream code, but then I found drivers/net/ipa/ :(

Aiiie, what is that doing? Mapping something into the dma-api owned
domain!?!

See this is why I think stronger invarients are a good idea, we can't
police the entire kernel but we can make the entry points explode if
someone is doing something WRONG.

> All that said, I don't mind if you want to propose a separate patch to turn
> certain external caller conditions into noisy warnings, but I wouldn't want
> to tie it up with any other changes which would risk getting caught in the
> crossfire if someone does then hit a newly-introduced warning and start
> arguing to revert it. And I'm not going to do so in any of my patches since
> as above I don't personally believe it's a valuable thing to do.

Ok, that make sense

Jason
