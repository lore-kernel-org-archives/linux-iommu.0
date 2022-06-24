Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89823FDF
	for <iommu@lists.linux.dev>; Fri, 24 Jun 2022 18:50:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1y9ZhOUzsljFmJZmInHMIS7LryDiG/RvdV5P7aszFqIIjk9IvARUOkrRdfgR4PrdZD5nVN+bf6XITcedW9AZI2xdnhNb7lYjw4UVtZCTSEqchhT2nWyxRS+W2qg3ClSXPIg/YLxj4nm1vzxDzSl3C6JkFnLJ5Bmnkoda++1IZah8nQKhV/se4vlkZMJYjiriRRFT0Rep9HSQ0mxwA1NUPckJbzwl+LC0AlgqAzLb0nSQ46gfToDMqJ4UnRCA9rKxiczPtFXvfVw2We97rL6IFPGZ/ezs41OtRIuqM8OGsC3FKe8l0nikwfnJXuPtTHctbiiMWhxgsyHQ41zCj1jxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8UHC+DKr4QBta628hMhU0vHHVY7AoRK+LKInTjhlSQ=;
 b=bqVDT9ID1nQj09iyJJnmYhUDmv3IcAM0nLCW/bn2krHAYZfuS61cPnfVu9MrvI9JY0+PbmI0vS6RwozIBgs9tN2qH8wipSw+RAbDk2T5jWt1Se6ygYzCA6YOWYsiFrwnX6Pbws2NJCHjqPaO7AdiZcKTk7awwAjApsu/hk4HwvK9aedPs7fxg7Wl3VDc2YqTwCBeRGmA6z8wgopYJC/zHKeBrS56yuQ79baLkDWHebSh18UznSqrJBvk0Q5XNXNLXQz/5xnHi7T/l8j4opwwxzNOE58hU4ZnCa4lM61G7EfdL6Qv9A67+Gys8feG45EprtCvZlr/MTfOTR1xd+jDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8UHC+DKr4QBta628hMhU0vHHVY7AoRK+LKInTjhlSQ=;
 b=IfFufLNTdYzNo5XKiOArs8LvOBl/bthqHt9NWOhd96PcgesyEz1Kc4qQzB5tUe3YvtpDnlP8ahuffD9VixRKRDtyXo6qjftGydwuVuItxQ2puF9cz64PVJ29Ut8t2EWsORQa4WklwOYpUBC1UH0ku6kJbe2vb/dQntMumLFRrsZrU7a3kgH1DFETFo2J+EEwDfm94Cv5bukSf28GhqX9/dRzSyVOn3aSCdpfONgSfNHBC/6fA5xg9V83YE3hUGv5I9BQ8JzUMvdTwEiysD55Sv9Drbr7SkInI/5tO1pP2aRfPKkr1+u4mVm9cMjG6BX8akXXSrzjJmmsvYZwHbDSLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4643.namprd12.prod.outlook.com (2603:10b6:a03:1ff::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 18:50:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5373.016; Fri, 24 Jun 2022
 18:50:14 +0000
Date: Fri, 24 Jun 2022 15:50:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: alex.williamson@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	baolu.lu@linux.intel.com, iommu@lists.linux.dev
Subject: Re: [PATCH v3 2/2] vfio: Use device_iommu_capable()
Message-ID: <20220624185012.GA4147@nvidia.com>
References: <194a12d3434d7b38f84fa96503c7664451c8c395.1656092606.git.robin.murphy@arm.com>
 <4ea5eb64246f1ee188d1a61c3e93b37756932eb7.1656092606.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ea5eb64246f1ee188d1a61c3e93b37756932eb7.1656092606.git.robin.murphy@arm.com>
X-ClientProxiedBy: MN2PR19CA0056.namprd19.prod.outlook.com
 (2603:10b6:208:19b::33) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28145868-a448-49e9-a02b-08da56125fa0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4643:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kljyVdBIy6iH8jodWe8gMCyf+ktdSD594CWCra3wpeHfrNg5ZgUvcFqcWy1RV58Pm3jXDcLosh2lj8yP7oD4JGvS6V/vpM6JRwhVnN7HQirmJy9i0NFDYACIFuTogQeGtt983u/UDtDIJyRmjtpei19Y0fqqZfGFC9qF4qRfA/xdRjAULLdcd9O5z5OES1JihTJx7OkkwA5GZj4Qaacz3u5T01GaeJTQuyiCH/XwJNmtrp/vD1ONS1xKqqPGjSR0ifGX1V3614sIYwAygntgJodonNkxBbjswxRGItnLpM3Z+h0v/zyFtSkgHtPtGOWU4QGKESaT7UgNsh1Nx2MLVRMmMKvqxQktFiUb7Z0IxMv+6LkzyXonJ1Njcsb7/yFxyi/MkNUoTm0HRveU2ELSyQwk6f5tmm8l2ReWzFpeyUWFJgHR4H48JtDTTq76PVNiHTbesxUsRQ21g9jbS4/iEh0enDlkuPqqmiqlRZwMDl0qjabJLLU0yxrTw8WaRErskp0HMhrV6HHmyJro53s9WuNoDMJbhLHhIojQc+WkoiExPqitL10MIcGGGDVPwlmr5AxxCAxuTU5ADn35pxy2hQjIogbBUcbPVUOpnk+ZHaRwWnhtv4gFcAMS045H0PHQ0WSzO/OFLWtvC9btHeZ4kjxy0wfM55l2micTJ2OtyHZ1mWO27GS0S9DYIbRZwkEICFqjPMMPisW7z6Db3o/SKRRFiBI6q4BbAqel+1PxlOIaU+sWo7WSBHLrB+WVNmp4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(86362001)(478600001)(26005)(6486002)(4744005)(8936002)(5660300002)(66476007)(66556008)(4326008)(66946007)(8676002)(1076003)(33656002)(2616005)(38100700002)(41300700001)(186003)(2906002)(36756003)(316002)(6506007)(6916009)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vEskCp68KblpO3bivKi6I9xMib17LMSuUq94FS1WSsfiIgsQLeJxPTvPFaIh?=
 =?us-ascii?Q?j1KO1TSUxKgeHeuDlhMTidm6kMGrvHXgRqJ/QaCr5oJ+34ws1bMYXPu0ixzK?=
 =?us-ascii?Q?bZ8jmketAr/UquJGnN8ECRiKnYQi3pZL4hU1PHva64Lh3pZDDPqfX076WtTP?=
 =?us-ascii?Q?dIYetbGCSflHvjGr9LCtOQXNC7vmW5HzWHbIWk6c06DF4cEHzhwH3jExGJ6a?=
 =?us-ascii?Q?JI3sOJIsuPC61HNJvZdp8gBkgiOhDflfVgRqDZgrwpi4y83ijGMSNCmE/cUe?=
 =?us-ascii?Q?likvDvRNtzeUFIwUZYflowiJEgGlyG9FUs7wXucYszLlyg04iZIzk+aP0gAf?=
 =?us-ascii?Q?oqprlEr2CZcNyvk4exAbpVt9e8IvGM2kq9DGwFMTfAYUVeLdwS1Bz1ImdQg4?=
 =?us-ascii?Q?bWQtfUxfPWV72ORQ/eB3SeesYtwNvIZUV2qyh+2YCyFhTIoblm/dcmeDTPIT?=
 =?us-ascii?Q?OQ9MnQR/1cn/TRm5iM5OK8z0BS9Kk3IawMK3iC/cs4nrP0nprFMwmYH8MXDe?=
 =?us-ascii?Q?TcOIXsIokuj5MEKeoyxka0Gb8M078pWwih3Sc2nn6X/ODrLeK7QuqzS7fJke?=
 =?us-ascii?Q?RtXDGUEYYpnHQSDSO2zDk5bx0SNgW0lDTY4VTKOQwz/UcZ82kfXjQ6242Lmy?=
 =?us-ascii?Q?S6kxukpLma9iInmSWnUtYma/F4gvyeUTQyJ/hFUXUUpBGrP5GnK1hzgaQ73J?=
 =?us-ascii?Q?rsl6tbB+zNybi7g3K4Tsrfpc7adXhNQKH8iaHDejLz3EFvgqUXhsTmoxYqSD?=
 =?us-ascii?Q?9xXus6WeRlfsBtX83tGulIWtkKX3pJiG/ujAyy5fw8IE16DMtuQuBM0tU1/G?=
 =?us-ascii?Q?viGSjuGxxeaOLBpKyPAc2qJiq+2z9eMeSEkgAETvtBLctdhR7Vboiuy4g76f?=
 =?us-ascii?Q?IfK8xXnmuQknzfwm3FTbJ/a+S2s8cpMYOYOefmzX7qeen7gYLOyc93NaxfKN?=
 =?us-ascii?Q?vHhKbnXc7YwkYWy1TedZ27X/6S/1YNqa6mPYURxsLKV8BSceZI1RN2ZQUMFN?=
 =?us-ascii?Q?mMGlsuRm70OuygBrYvkozjjG7Wd1/a92NQbaoPONSKW4Nx7f748D+x4EHrYu?=
 =?us-ascii?Q?nuNiz9msdcca9SfUWAx5r8YjfGmPG3KwWzcuvXMqQtKbbpiOcK6tkbUxWkvR?=
 =?us-ascii?Q?wTBKrBLseh9Na4HTcGDgVC8U6W8tSupwOdJcPHaMSTZQ3OePBSBF4O329g5c?=
 =?us-ascii?Q?GFwg8wWPtvLvUuA5TZcXRe72Ji26sK+GUKYpgV9KWwHQpsFEvoWV4IZsn0gD?=
 =?us-ascii?Q?apSXyvzEpSJtDBN6+FOkhHh+SgzL0U3bpuI1ZiZmfsovuZLddW00LkyFDAVO?=
 =?us-ascii?Q?wx8ZUUMGL+fOhH41Kci5iieVtWhXWRl3G1a4Aydn3sZyPaZI8u3TIuX3Wi7p?=
 =?us-ascii?Q?bDRlpt4ln9fXodbEXbTknt70FI4MidxB8srwKsc0w7XmKa83SIXFWMkqeisX?=
 =?us-ascii?Q?XpLK+mFZXOmWjaHNOIR2+VPwAlQC88zqEw4r27U9M4BIdanrnpZ9c2YeFlWA?=
 =?us-ascii?Q?OjclttJPP4512owQu24tnhmq+j9qRhlJO6C+rxrbmzASRWjz6MdEJSPKij2t?=
 =?us-ascii?Q?emAb1u44UBxyZFzZrL5xNw2OR4c0Vd1L3+FRPoiT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28145868-a448-49e9-a02b-08da56125fa0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 18:50:14.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFI+tlUiInM1FF6pu4mWJSwrDZkpGXlg3g0Pfp6Fhht47xIQBPHG5yf+s+HDru23
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4643
Message-ID: <20220624185012.JgHf0exs1gnQ3FaPsmJu4pkXu_4Yl_3DPYzGpIoXYcM@z>

On Fri, Jun 24, 2022 at 06:59:35PM +0100, Robin Murphy wrote:
> Use the new interface to check the capabilities for our device
> specifically.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/vfio/vfio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
