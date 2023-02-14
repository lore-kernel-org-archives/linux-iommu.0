Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A181510799
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 10:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6+4X4drDvE7m8xR0kwajt1WCyfRGn+slmrCKDQHg2uLXm1kqgr85ii19PL06ZJEU8D+4eLbj6UWc493eotZ/Lh1vZWwO34L6Qxvyw8fWgtuekStX9lfFXgppYgcyorHWDPyf3GF68WZOUFlvSPWZcKQEHgUy/xqQM6nkIJkeD0o2NEJQHP/KzXfGVIQJcaL5fMFpS65MZDnNUwoYWTueERroyAS52URubUqjCvHmhTkOc/Gszvd3Fk1XdvdqRNucG/4rrY6P8WQj4gdvK9DEK6gJd6+il5xZx0D6aHi1so0Bz5xH5JTCfhLmdKCUTwSg01xLabW0eDw7zjrtF1U9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp1Q/zmTZEW7fvEmaJ5DIn9EuGjDZ23RockAxvPHIQU=;
 b=T+/CxVj97kpuSK8F+Nnn++/3jHeWNLZBTUfOh9NhYIm0ZCEzXOB2ZhYbkEKbv34IVw5eepVMsonChDvmebHqofyGDv/xF69F24S0naZJ0JCWNFUR1BJX9tqXtBCERwZWCI183JhMprOWVhADyOLSqAJE+F9aF23r0a/pn08wNoYusL7WlhG0/uufr+j1K96N0WiuKnvIYVPqBqriE12PEIT8c6sdr3G3muXVbAKOSoRE5I51YJ7GSYyquLx5rcN0wuEyP3LhiH94gWmxCbNfgrR1DG/my8Zpbaq5eBS7rweQcH9UqhZUeHw9FYdScJfNtK+/XkoNpHYRiZQK55d0Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp1Q/zmTZEW7fvEmaJ5DIn9EuGjDZ23RockAxvPHIQU=;
 b=EmA0yJXcD+sAtDzv3vYicS4VfsY6iCWR925YWU/cj4OMiMdXruApMOoxQ1xRmqRb82EwfvQqo5SgI0EQRcvjh5H3kz+UCAFYymVgIbdgrbbOKyCl3I4fd2osWvK3psKT67hyYpn7R0EYVGL5MLPMJ7Xwnz4mj5kH74LK/F4OCoHmVbpvJgSc0uZQ9CqYmYEIhhuFN8EOcK94j3Io0CBWpDN4eRxOf0vFP6/kggXRB501GtHic/2Hs7SOtFq1kTi4GjqnVrL3NVMqbcam0gg1tdhITpRw3OFi5nWxI4745uddCMbDKijUlpDYNgps2EwVI+xnBG0nM+f44TFQ6GT77Q==
Received: from MW4PR03CA0023.namprd03.prod.outlook.com (2603:10b6:303:8f::28)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 14 Feb
 2023 10:41:26 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e3) by MW4PR03CA0023.outlook.office365.com
 (2603:10b6:303:8f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 10:41:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 10:41:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 02:41:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 14 Feb 2023 02:41:24 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36 via Frontend
 Transport; Tue, 14 Feb 2023 02:41:24 -0800
Date: Tue, 14 Feb 2023 02:41:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Yang, Lixiao"
	<lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: Re: [PATCH 4/4] iommufd: Simplify the lifecycle of a hwpt
Message-ID: <Y+tlUyJv49l8/Zx8@Asurada-Nvidia>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <4-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <BN9PR11MB5276D5B247C1F93A5FEB46838CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276D5B247C1F93A5FEB46838CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 45f6707f-bdcb-4a51-3fc2-08db0e7805f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TT6e0Hs/EdMlGoBNQ2OfjUw9p2ztWuPxdtklmSYGUqGKg6uEg8mLbnGMq7quWgCPZiJPBLwtz+UOpx8/aymNL24FGIRz3e4bLNtvFf6dQVWwa6vFGSDs5ye62fwidfU2WWvfLeqHzTEmvaAigppVHgu8L06yHLyew6Cyn8egcwdzAc89UvLGvc8SEPHUsu2rR062fTAS7WggaDmqbrOXUolCdxuRAaCUqOXfUF/QlWcvhXwz643wL7T5/NOMJuTWN0sZ9QbXhFtkSkRbTa5woR5C1Et6mUP6J/wNzTHefaK+sa+iGEFBtfgGO8iIOtlZBqY7rpuZEdCeN+sRnU37YepzACYiigGlINAToEbyqLr1BuKsI/bpEXnAZPbnocc66nbZUh25E3OZhQJiuKpzjpZQQxY2KbOm2Ibesv2dVqzx7KiwhMNTwP2HQ+UDkxg2MeA7AZFRumvQ6rWshr3WTICc95Dj7QKYXOX5dgsvszzOBVRx8c0b9Js28J20RSV5VhBYoOn17VhCJuYCfNFFnRzC1DA+Pm1THYmmHkLeHsCfxuF9q2yRHRCUUB+E7gpQ8cMD+AIRvGxX6lyLrJivZERAqyG4oy6r87FHNndYOtnkE6/eUjXP/8Kz/NXP5yum3RfJ/YAFM3LemT7uwJd2mf2T8LHyrBp7ffWOqPnTEm3yTbTAIfbp3khUDVaidL+lwUDzAdgdriMw5ZxtSh4mZw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(55016003)(40460700003)(478600001)(70586007)(9686003)(26005)(186003)(41300700001)(70206006)(82740400003)(4326008)(316002)(54906003)(7636003)(110136005)(356005)(36860700001)(8676002)(336012)(47076005)(426003)(5660300002)(8936002)(2906002)(82310400005)(33716001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 10:41:26.1008
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45f6707f-bdcb-4a51-3fc2-08db0e7805f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046

On Tue, Feb 14, 2023 at 06:14:07AM +0000, Tian, Kevin wrote:
> External email: Use caution opening links or attachments
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 14, 2023 2:03 AM
> >
> > The HWPT is connected to the ioas when it is finished being created and
> > should remain connected until it is destroyed.
> >
> > Instead of trying to disconnect the HWPT manually during
> > iommufd_device_detach() simply use the object reference counting
> > mechanism
> > and free it when the refcount reaches 0.
> >
> > This means the ioas->hwpt_list can have an item with a 0 refcount during
> > races, a prior patch made sure this is safe.
> >
> > Add a new API iommufd_hw_pagetable_finalize() to formalize this contract.
> 
> Can you add a few words how you expect this to be called in manually
> created hwpt case? the new API requires it to be called after
> iopt_table_add_domain() which is part of iommufd_device_do_attach()
> now. Do you intend to move iopt_table_add_domain() into hwpt
> creation path so this finalize API is also called there or leave it as today
> which means again need to track first device in the group to finalize?

I think we could probably call iommufd_hw_pagetable_finalize()
in iommufd_device_do_attach(), behind iopt_table_add_domain().

New HWPT_ALLOC ioctl handler can't do iopt_table_add_domain(),
because it might go for the ops->domain_alloc() fallback path.
So the iopt_table_add_domain() in iommufd_device_do_attach() is
necessary for the that path too.

Thanks
Nic
