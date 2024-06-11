Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA84EBE
	for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 00:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065727; cv=fail; b=CuEBXdvs8i+Sc7XeMumugSU9c+b2t88sVnvh6C+R8BDtj1yqrMGG+PpJzbduztKKFviSHn6U9HMIdbSnu4DWUA0Ojxr1KwqryDacsVpRMct92Q34kvj3yazlLfo1RxK72MTSCdMRwRnB2WguQcuAxhl/gpBt3vLl1MEPituVV18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065727; c=relaxed/simple;
	bh=zbKhd7ItzKJAzJM/4Py5Y8zeSc2SUEw0H6XQUR0ZAiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WicNZpm+esjzNqGTpja1wik9OqRrVm1nCYrHMghV1M5qm/PptxrcjR5zOukSV1JlK6dHFs013Pw0Pu0BaFhxtTYJjyOZYsAVL5A5ATNAds1Ew3/fKc7BI7X8PZzZcduYLS3l8u32ARjbKw5I9Xe0avEReAXYc1J4na/MqTCGyes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YpFqA0Xm; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YpFqA0Xm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr/+/PuwhzKeFMMqfsCgf1xoYfNMLLtke81s+Gy6ezvLfvEJkGpHldhBbxDPE4XljGLDkZfIYAW3Mc6yXhyJeUNMXAoQWH7sqD/qrT+GeIXfOjALspYB+hZwtnDHNDmFpIebICMHCO1hV1gvlpXu6QnVd6XCvBrZY0bcpNwIGMpOglhhhHOgB54wIVKv4Qp4nv4CtMy/J4/UGrUu+b7z1ZYNtohXxTDW4glJrm6jiZxNwPQQkvqVB+6Hlj0YU384SHx+xuRV6Z1Wa/2mdbZZ8NWp7nhLznvFQ7UAmrTly8WzfVvGv8CPOBKhktu6Pf/uzvbfmUujCqMsUGiD9V/PXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/fkboRB9aqDVnYobjSDW2v5sdX07FI5DTLk0iSYBfc=;
 b=Msj3RtM/IcSUNKOQOrOm0LntIPXKEbojexT58ojP9icwtJ0HscjLhlrRGvNlZymGnPzrIVrBfaFHCVyhEAp0HW+VatVwTqgozRI+mSmr20cR00W9NOctwLivG8zmeveRabrkaNoKbjRegGkQqy8yIh8MbSO9lCfHlLdG49tNkDKHD58385rNq7cOr9hxIF5zyfOH/sdiYv4EgHxHAGkeYENpA9JOjMWFOCqfoXcDgS8iyKdaS82vBkiZ3n3B086JXbUOqd/aOKG7+8W2PlJBBFQzvIcb3lD6c45tLxTqtacQjKN9W9Ud5z+Ckw94atzrjQKyGk3fBFhPZHho3877jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/fkboRB9aqDVnYobjSDW2v5sdX07FI5DTLk0iSYBfc=;
 b=YpFqA0XmZIjI480V0Ga0egNaiy/ojVuoF+fprlV7KdwHV7ZnweZSiPJ3XbWZZ/gGIlTdBW48YQ5y+TIXuS88Mng90yznXU0swgh2Jzke434M6S4lODV4mTSAkxFg4z2i5BrxAP5unbSOVzna+XOvVSSA3v1z6rGghFgO4T6Ef+lrAhBbf/NIKTu0PX2gXs2hsoU+VbWb+hRoyGiZSAQ79Fp7dimr1FcAv4RJHInoUhPW9dDJr4TFGTFroVg6NdQYddJXGQ3zCnjrYybCraK+zllebNzpNx039AoWLs6fUQXrC9RAZf3DAMCgR1qvj7TOaTd5w9qbJ/XzCBQRFHIVqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 00:28:42 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 00:28:42 +0000
Date: Mon, 10 Jun 2024 21:28:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>,
	"Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <20240611002839.GS19897@nvidia.com>
References: <20240606182423.GF19897@nvidia.com>
 <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
 <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
 <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
 <20240610120446.GP19897@nvidia.com>
 <ZmdbnGnp73yR36N5@Asurada-Nvidia>
 <20240610220110.GQ19897@nvidia.com>
 <ZmeGfqp26c3sGBmF@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmeGfqp26c3sGBmF@Asurada-Nvidia>
X-ClientProxiedBy: BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 81437f83-072c-425d-2ef3-08dc89ad7237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UjABrzzXC/AiKqQm6tq5E2oUMRm7UoP5BAGRAKS8uXr4mwrE4MbdARYtB6Ql?=
 =?us-ascii?Q?6K9FQ88Mw8qMlJ7PZC3d4IJBeWxD+CAD6YAQH5h79W+hUZSNDf2T0IfSxVHS?=
 =?us-ascii?Q?oPEf46aWC27riyqBCdiBcN2nR66+U9Mi79dx0KAoyLA3wkl6P507bc7aFApz?=
 =?us-ascii?Q?jLUXYaanQCXIxyjQhFTLSv5a8UoxvTRIvDQF73SvgT1KprRmjsf6fwGHaDTo?=
 =?us-ascii?Q?MqVw6mlLnFjA85STCQDbQpKSr1oZ1ZtmuGxM/BwTS7XVqCuZ0+iy16nTpq8A?=
 =?us-ascii?Q?vhOfcYyskO/xaHl+trEnrPYlXx1+IHbastqsV3zWrfsQLo5fJc0dJyqS3HZ2?=
 =?us-ascii?Q?gVCsxCVGDXQDtw+VRTOunoBqcKz/a7wk7lpPT+XNHekoOuz5x7/6FBBcM6dW?=
 =?us-ascii?Q?5NsE/nS0TMBP52yAr6lsagYUctx1dcRKZgyjTDafohcVBkiemEWgmCycrQBV?=
 =?us-ascii?Q?5Fmer7Vg31wsZujk/sU63F+946RPDzz/ItDFuors/KSZkRxwXF82oRFBNNGt?=
 =?us-ascii?Q?S57DcJ2RPrPWalYW7MItcXne52dYYIu31z2wPi5vwwPQJPOzhle9TXdiDWaE?=
 =?us-ascii?Q?yn0Eiilw/6KEMt0QWXoaDboE1m+i/TcmjaHJKCxdyOtX1xSFL6UMWI36JjVF?=
 =?us-ascii?Q?N+AxxOocDsDwD9pGHMHQri0gHhnXve+lT7lkEFEhxVFoDZKrPFVu7WPXxNUD?=
 =?us-ascii?Q?T1aox/QkWcDcukSkU8VL2u30skzIaBZcfMauVkKH7HvV8UI5CKFjY1kptvcw?=
 =?us-ascii?Q?5Yfu6hl5WjcKCiQkP9vex9bGFH2yHK+QC7nNxE5pNDmpUKNEWchnpYQe8yzq?=
 =?us-ascii?Q?OwKfFXc1MyD5qIKiD7NM44FlfAhksK+9pqVGdPJn7OrlGlcGnBYcStGR0Lz5?=
 =?us-ascii?Q?ZdtzBTKEFaTCK7ULBfqdFRJLzEvlQV0hWs+45bU+FifCbWBQvWKrMvTAR0qy?=
 =?us-ascii?Q?SZ/ZT/1rVtMQ2U8GNkCFF6j6sGM1SAFuaTv3Kx7qZktCkRx+pYmM9mcmKHkT?=
 =?us-ascii?Q?4X2N4HARCfNlrML92syDehtYl0eV+CrbgrkNUgMzkDXsKy/pYTzHQFix9AmN?=
 =?us-ascii?Q?X1m8zlbe4MynVlSFRMDOpALgEvcS+qm4K4oZyMB0mXvwn9i+Fi/6vqBpNglQ?=
 =?us-ascii?Q?9AfsSSDHi6gEpSXzu531+I1FMEv7ddLcdPs9Pq7PyTlNZuhb/AB5LCm7YOOR?=
 =?us-ascii?Q?ZivNKkFdTdeOLbLYSJ3yW2kh/be1jMoTVkKp5R0Z7wzysgMQ8wUP5P2N/Gek?=
 =?us-ascii?Q?yBMJrKubtG1/isMjXavWgSGB+JR7ztOXrQrTmlHVDAhC2UL2C0ZimJWIsHIe?=
 =?us-ascii?Q?idX2mhGdLpWlUwt9mjde5mIq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PUcuk+8P+zgVB+u7eb8zceXN4wytP7/ueILOK8IQDSvjweL+LPf5JxBJjXxY?=
 =?us-ascii?Q?GPsFvppC2RGR5ZBTXwKE4E443YhrDlvfpSmtgAf34MdBZjnd53JVV0Gq3NT+?=
 =?us-ascii?Q?jSlLb1xEVhlretr1Yz20+Ppez/WnJL2D8IqRluchLJ3w6kObgmLolqGO0KEw?=
 =?us-ascii?Q?zD7uuj+CegKLJLrzLZCgsZncu6DcDuTXu97TOhJjowd2RKedTaH5YZCuA9sq?=
 =?us-ascii?Q?yrf9d13UQNI+TVr3IwLQ/JZloXdlYdNvG0/MYmm82ythjpfTE8ltPOld6eVE?=
 =?us-ascii?Q?ib3qBjOxLMVsDacDBjx0A0ipEhudA7PiSD+OoWsyceEaHvaUz4bGXhZ0D9yc?=
 =?us-ascii?Q?i0FtRhmCkj/oSbZ8qfx/zD/HcRd0LbsFTMr0F/a9eqXtQ4AoNFupSAPE3RNo?=
 =?us-ascii?Q?q2NiQYEPQALH4YnHz9BF2uyw/CX7cbU1MkV+orydSXvhyBn1EJhK30CW3wHL?=
 =?us-ascii?Q?3BuLAEpZGKgNybKpvktnlQZicDFhp+0TbAET9FQ/Chqov3wgz2fAYv/ECZMi?=
 =?us-ascii?Q?zOthg3PXr783WBDCpNvbOFdDFCMxYZVnfoYr/t7owSc5qDiyUcT8Jx8oFfCg?=
 =?us-ascii?Q?hwHwW5Y1UFOVq8/Afc/5+ImZAK78HcLZpgGGCfi6Thx/x5Bm59OxhWKbVbfi?=
 =?us-ascii?Q?DYSbVJZKZUT9xyE4ZBDh3cGKtGJwFBPRNfJqCnrGA/2h4m1m60iH8YxMJJTX?=
 =?us-ascii?Q?Fh3WRLW+1OgrgwiMq9VBa+e/6BaBNbskT7JqEnM53Z7LfvbwEYznbtE47nFF?=
 =?us-ascii?Q?gacYYyJWRy2sbOx5BP03cn4BaxMFQfBrTOVx7x3tdSV1tr6yAQJPaShtXjea?=
 =?us-ascii?Q?r+VltQe+8EpI48rXJoxeDDuERsWGZAYKKqACkP7DSrsJwJxiaipRrWwGdR+U?=
 =?us-ascii?Q?X5+ClkVCHDRW8Jweovq0sjb/8WxWzyHFVYqJ0BLDKJ2vAzSAZDATlpr+Hiqf?=
 =?us-ascii?Q?16OoKduQkZti/C5rKbdiagPsTSoqjh/5HtyTed6URQrOTnk9/CMKtNN5B7wR?=
 =?us-ascii?Q?KeRHo2kXiWgDB8kGZ5Gov2VWtaXJxBpiRoRugXZdJFGJmaxII2yqD1cOAkaN?=
 =?us-ascii?Q?JaGEbh3XFsujl0uhRtwzMB96t+jCayPpDC2Zdt77W0Iw4LFgt2pB93sGjpQh?=
 =?us-ascii?Q?1CqlyXd4orBgXc6L0sTtGsT1aa93uVol78UYu+uPo6evnWN+mHzQAilYwSH0?=
 =?us-ascii?Q?nFAuqH0SbZeSjx7PCuSQtwrsChmjfmlOKGgg2sV6uVEvyTVxmv0bUrnWktJA?=
 =?us-ascii?Q?yHgi5USDAvKD3FNrEgg1HR+nyhrAUArxQ8Bhu+W3EOtJVnn8NbEtA1rMuxSg?=
 =?us-ascii?Q?l1AJTd8WrEJvfbXkbUN3sBgceZMmv/Xa8Xhw4ieuw3pmq3GhjOUZGO2xJ9zj?=
 =?us-ascii?Q?M6HATrU/CFK4f6vmfY/ewmfzHEYMDSyLC6qQQ2tCSkb9mqa9bZwuhVhyhGDI?=
 =?us-ascii?Q?ht5JaE0o4HowHml9h8a3YXTxeEF4Pee3NI7hq00DmGgqVvv0UhxR2GvAMu9p?=
 =?us-ascii?Q?NP4Ch5fP1FyWF2caAmz/A2zvjVYz5nHdCpHlBc7G/x8xruCG1fYIGV5ZiZ0m?=
 =?us-ascii?Q?lEMrWxH5sbP0KhmGlmw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81437f83-072c-425d-2ef3-08dc89ad7237
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 00:28:41.9629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZl4atCQUIJOesSlW+mELE+tyzpo9Te0SNZPxdIaZKlasLYfLf8aAC8vqlYkkdtB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

On Mon, Jun 10, 2024 at 04:04:30PM -0700, Nicolin Chen wrote:

> > > Actually, even now as we put a dispatcher in VMM, VMM still does
> > > decode the CD table to link ASID to s1_hwpt. Otherwise, it could
> > > only broadcast a TLBI cmd to all pSMMUs.
> > 
> > No, there should be no CD table decoding and no linking ASID to
> > anything by the VMM.
> > 
> > The ARM architecture is clean, the ASID can remain private to the VM,
> > there is no reason for the VMM to understand it.
> 
> But a guest-level TLBI command usually has only ASID available to
> know which pSMMU to dispatch the command. Without an ASID lookup
> table, how could VMM then dispatch a command to the corresponding
> pSMMU?

It can broadcast. The ARM architecture does not expect a N:1 mapping
of SMMUs. This is why I think it is not such a good idea..

Yes the VMM could walk the CD tables too and build up a bitmap of what
ASIDs are being used by what pSMMUs, and that would be fine for the
VMM to do, but I wouldn't necessarily recommend it :)

Jason
