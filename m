Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5FC7B
	for <iommu@lists.linux.dev>; Thu, 16 Feb 2023 01:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iasR2W5xH+iWU9FhL93Gudu+lDgXxk2Uy8HiF7WVoAh/HNKSitID5wRJn5pdbZUducjEPdqb6JMf3jxoE0FjIOdoEtKPz5DifqJoZ4xLgKw9DUY6t4zf28zXpi1jL+d6ujtmk5euh9UbNn2ewB97ah6jorZEAuQjA4FZzRn/TeqteM+MUouwPt89099tdZGkgzWf/9sHHvuut1gRzhT2hUl+ogXIxqZxcPSyOSwskod7warrjXFc76ROZqHAmwKYPcuPmLhokILdSEHI7I2TzM+O/IdcIWfTEiyx2RzIyKMI3eFa2iepArJZrJNfefdeWhUrkRUvlXRJ5jlIYwIyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omXJln9WkJOmPSvuLyAfjgkkGDViGyCpWosVQ/n+krc=;
 b=mMWwQ2GKShOjwFQdS1/WdyIQJOxNfHB4O8HbqnOloRGEWI6W5FW+JI1xAaFGPl6MQnJPnWYs3Ard1J9rsHtTkFeia5IIoqQoSlxobLalf/k4XEOledPW2qRkWXIKmwRFw5V67nWR8GKiNw7mQtfgsSo/hV68/wDp7JKFeghBR5mRLaLRMTFMZG9XWBQ6jv3DW525ZuuBzyqoEr5eNPHD6I9Rbb5wwVviylNh5geVj3c8se7i8zCVx/fj+X2vYnIEgjFkIPjlo0Hho8FUBntgWvyx8JqS4ptC/NKiefLMwoJcQitJMIXyG8hhZwJa6IhJ6a+GFZoSzFCGJkJxhhrdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omXJln9WkJOmPSvuLyAfjgkkGDViGyCpWosVQ/n+krc=;
 b=aB5mqFfmHr5CNKRM3HGe2DLzhGxzS/vzQvuByvUAtzYz/Mu0V19UOQ1sQCxYxXRSHSDwXK7LhMahMpCxVtYAonWbGSKd1xG8uODKYe/3amhtcNeK6C7XMnA51to76zOG4cTlJO/GIvcJGjCJFEkckXv1T94fUWXq19l+8aUaawtQkT/7Rlmz9w8PoDUb9iMdhuVwJtHCFD1gzyEGi0PgClSSPOQhqVGKOVsdyBTTqvD5e37rH2SaJ8tgHGddi9iHUVSLCbZPSIWlTF5mbIeoAJzrAmP5V3tActHHLFSB1Eqe2W4PIrsiggcTk5+husjE4JRT7cFlcWfeQgqQuyLgzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 01:36:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.024; Thu, 16 Feb 2023
 01:36:51 +0000
Date: Wed, 15 Feb 2023 21:36:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>
Cc: Lixiao Yang <lixiao.yang@intel.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 0/4] Fix hwpt lifetime and detach bugs
Message-ID: <Y+2Isu/aAPm6PfeX@nvidia.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0237.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: f7da53f6-29be-42dc-b392-08db0fbe46f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qOUxoo5MbOnV+CS5ZAyT/N9I2WcwX4MJgsLFFnSSHW2KrusT/Aug4k1b46PAwXR72BY7eY4WdzKrOX2/1lOWVOVTmOVJTSaFuy1SZvSIxRrEQCXgGtlcLTDUyjfut10uVvBhxUyuH/ofaOWmNtstD1YPFAKnS8OX8sloXUwtzQsv6Jx5SN9JzhA14hU++4pKN5LHarj7orLbi7Jem1bJTn4wRzWotjTOoamJkHnllDUWYFfbNZWVNmCbO/fBBtrLQlcIQA49VeaebUIKh3oKO/tsjZrW6urJdT6gUui0Pr7cUWvslcS2C3Eh9su6hsnoJa9bZ0t12nZKJoIzusyn5kBON/RXu8A6YJVOaaPoD9j/UIZnPBfmmlBll2xogm1u/qdUjO1YIo+T029sdYnQaEGgN8ZakKEUbF2nh45Q55ezy/Bc4v4mBj8yY/B8rZiwgrp2kQk5qkjUMQOUe52ut7/D2YvSfhSl6Eg4iUC87VKWfOHbvT9m12iXtYilzKcrCpujf9PdcYZUl+gLpiKtrG7QX7Y1CZiHtghgO19mPDQyQlJw72ZMSe85lmshIsSfSQdBPSPaSuJKArT7FRabHn904FVJE1eF5D462nBNO33n/TfQeuRnkgZayXwe+HgM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(86362001)(8936002)(4744005)(38100700002)(41300700001)(5660300002)(8676002)(6916009)(4326008)(66476007)(2906002)(66946007)(66556008)(316002)(83380400001)(6486002)(2616005)(54906003)(478600001)(186003)(966005)(36756003)(6506007)(26005)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YqknUelyhguB88laBolF0xvfrNF+ewBqbfhlEIAZiLhlhgmqCHuo1VOMDGAC?=
 =?us-ascii?Q?bRf895IC043Sl20TGv7FrHs0FTa7Pe5HlFJNmP88X9Zg5Nz8Tr/xDYFT+Ys1?=
 =?us-ascii?Q?5lTMmbGCfPrYWrymDJ81NfnIG55EhPrdDjjnNQuF06vrJteyVGxT+rUVd4oH?=
 =?us-ascii?Q?4Jw+UIfa7wxwyW6uHEA9k/vrWK0ICWVw0qiJav+/0AQhig8B03XXq5zobReg?=
 =?us-ascii?Q?SFezHIZQOR45IZ/OHSyGkcxPU4y6O+LUNJXYZdYeArDW/chAa8IOMQx8bb41?=
 =?us-ascii?Q?78oU4q0NmJ/z3u9An2jSLg/bKSj3X/QXXPXbjvkmr34U8oIUOm+9FIS2wh3o?=
 =?us-ascii?Q?sMbpEL6LFLU9dqcBLM70I/eV3bKH39zSovMrM2LsnIshy6Ewf55LoQKznJbE?=
 =?us-ascii?Q?nrpj2FDWsbUXQZNWdzRLDEmJNrVeMdRIvm70Z3WsH9zC1gkIf/YNQBukiAMn?=
 =?us-ascii?Q?mcqYdJDdUBEH+/jfqu5rIdrb5gWxsrUORWB9UAz5s9zHIO2n+YEluNNsFVfF?=
 =?us-ascii?Q?smJodb8MelnjIHtNgvRL/qL3CtnRtpH7L2sHwrSIv+aATUiFo6hgXesi6J38?=
 =?us-ascii?Q?/hUpH2gDJaDRJLLe+XeHJX7zx1heY9uRjkxfv9aldilbBwi86UZ3WUpd21eW?=
 =?us-ascii?Q?kimWRN1I4NS5et2NGn7hMVM7p7+UmyMsKQZIHvZPH+P/AeC57IpAr0QG5Rwc?=
 =?us-ascii?Q?kZfGaxe6pR+1z2a7LZ2CJGLoPfYjuv4KOlbe3FsmyxTvZXZMXu2Pbe3p/jgt?=
 =?us-ascii?Q?pw+L5t9205+DO2AX57Ml+O7dMYOhgjexZ7z6o2mvh6uyluAjR3vW4et6t6me?=
 =?us-ascii?Q?ynMQFmhQc9kUK07q3Z7oOZE0oLs819xYnkOLbXu42axCW/C3Tkgfaw6Q2de7?=
 =?us-ascii?Q?7KiMe0jpq26xTSzOUJlAzLMBoneyoLk5nl0z8XIzRyLPp1CKUZ7TSqikZZp7?=
 =?us-ascii?Q?9qPoKXGiD9N5Gc79H339iiKKkqvYcDTQiwswGo0za/3cptetyYcG2XnbmBPf?=
 =?us-ascii?Q?KkXdar8AiRILkkBxJUj5Nyk2skv5ezkf//gBmY+SzLI7XOypmD8TnF59EWQb?=
 =?us-ascii?Q?2Y9y7EjiOoI6w/MJF13YDA49GOYJMpXqJ7Nu7qMc2lR5JZTWmmY/UO+Rk3K0?=
 =?us-ascii?Q?OR2m4TclBUpyUm78QLk84iuNRcof+CfsnTgn6dmZKddPTFVSLLcWjfsHSks1?=
 =?us-ascii?Q?BQz7QAd3E/vzeUzsXKivkGN12TNGIgRYkZDU7jsrPr5Ur/0TIWMIrkukMk+q?=
 =?us-ascii?Q?gOXQ4ixewZhkMFLplLV4necEIjP362+HrgjjhDDyWxBIR17X1BWBsj78LuIL?=
 =?us-ascii?Q?uYfL7Ism+fkaUqBatuOeFbjwHbAV7lM4RRws6iaIuaGHYXlpmpqjnK4MKQTr?=
 =?us-ascii?Q?0ZJbcO4DxaTmmTs8l3LJKLSjN3mbaptaMu2UpVYf2FyGePueuHdeNP/PV/Fh?=
 =?us-ascii?Q?tmm2lOB6JPK5eydd8V46IUthChfjZpnEBQZtGtk6k6kLcCZn/pPx5714cqzj?=
 =?us-ascii?Q?Kp3852AvoJA1lF4UzDk8z/pYkrO82/tTFlpgmcioVmu6zcmEY8rdHkwdOCf3?=
 =?us-ascii?Q?ixgqPRD9woOBdeBblvALRGVYPlAZ2LQZdliLlvtL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7da53f6-29be-42dc-b392-08db0fbe46f1
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 01:36:51.3379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmfnRs/NH+uCghSMNfLKfirocQr8vUqAkzkEizualyNlsFhpuQ/kaVn/6A7mTtfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573

On Mon, Feb 13, 2023 at 02:02:41PM -0400, Jason Gunthorpe wrote:
> As discussed here is a small series to address the confusing lifetime
> scheme for the hwpt. This was some leftover from prior rework that was
> never fully cleaned up.
> 
> Make it clear that the ioas and ioas->hwpt_list are associated with the
> hwpt during creation and never changed until it is destroyed. A
> post-finalize hwpt with a positive reference count is always valid for
> device attachment.
> 
> This should simplify the nesting and replace series.
> 
> Jason Gunthorpe (4):
>   iommufd: Do not add the same hwpt to the ioas->hwpt_list twice

I've applied this patch to the tree

And my v2 of this series is here now:

https://github.com/jgunthorpe/linux/commits/iommufd_hwpt

Which is completely redone

I will try to make the patches to do replace and alloc hwpt on top of
this, I think it fixes all the locking and consistency problems.

Jason
