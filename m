Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83C4A3C
	for <iommu@lists.linux.dev>; Tue, 11 Jun 2024 00:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718066666; cv=fail; b=mtuUy2lksfH/euc7ixWOilfBUqIERgjf1eBtmpE0Ln53tz15Rdfad1bGHdyIwHk3ARGEDhUtBZSr/BoUbDpZHHpMNyYY5N3CBXOzndkvDnZyOdZCpKJpOzK/tggPnW0g+u0pk4xgFoX1bfHS1aJWu+otg4CaARA3dqFIHyupVo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718066666; c=relaxed/simple;
	bh=z6cRzR04BsxTYB5H+MKj3lnD+n07MgirDUHhcz78x+A=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGoxeTplkyAoqaUBOgt2652RjYDbQ28AcdTWJ5iP+GVAEmNo4cyCjXNJKTERSO4kiePST4zAQdJn0o6xOHAWVi/2mVt3Ui0v4C86lhiBW+zXW/Ptud6lokxTgsx5ttu/HQjJFkPTy/TvXZeWnlfYBTSvmCy52/EOt5G29a/8Bb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZpDUzgVN; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZpDUzgVN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzAwnyGY/kThhDq4rkTcm/w0JA6BLKbCzwJOilLWhnG7K5Cpz1lLBHzzvZEkQgfOkV9ljSspxZKqSmRgS5+XP50ysy5r478VJfHPxIGWQsV03lmByzXM2bXVL9IydUDBEAHCpFJ071jJy4ykBZLv6aA3uRnGW3W+6BchvNNDWQ32HYzql7DNq4xNxV64X+KoDAd3h62oqe5glkxZayrer7dXwL9Z+THwNf0jROO8O7MNnXYYd0dJcXPB4Km2tj+PlilAgP38Oy0dXrMiRZ5Q6oB/kyaUyH0BQDvtGmD1ug/I7wwvummyr9JrIMr1ocONH9XwoQCwAnJjEI9NcTuM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzkT1zxDp4tl112WeeT8NsZq3lzEskZqMEmKEJWnL4E=;
 b=W3273b0ZiooVvS/aHKUwB2sGaZ0YG/qN0CGpgnLSIQn9yahcGwjzdEDd7Foh4KB/rygvhEellYa1utX+0oadG73XnV8YIgAmsLekCR2BQaJ3Z8+df7df7Gk/UKeB8I1veroP2iPWMVv0XWV2edQV7wNnY7Ca3E//5r9Yj6rkS3yjf3CI1QsMxpgd7az+F+5uub3iSMK0wDSWY4A+bEyfoIQLshgFXjLtMo0rLS3GeL0So/DLuudJNLKxfnFOKjGgMO2FbaJpF3PpUs403wPrjRu6zb68RfLiwSm3mJWwlhTuLW3wV/HhdV96t9la+6m9DAHdnoCcOcyqX78N0yifdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzkT1zxDp4tl112WeeT8NsZq3lzEskZqMEmKEJWnL4E=;
 b=ZpDUzgVNpKSMBIb944TULUmMikM+JTGLTVgxzXrPRyso9NTj3Z17BmsbEV8lXlcugmP0Ubrc+Pk9WExc2FuBdQobRTVZ9GIU+eZhtG2CjGiN+n2/VmSS43NlTHtdUCDEVtqm+rrDnDyvOFrmpXqEwS9WLBNkYiVQpYl6nk0lH/CDP9bdTqCltb+ix84aSRJ74IAznbB6T89idtaT6ZetN83cVVtn3wh299UXH4JkGzDPQaSZEaseTLTYaBdZ+l88XXO+c6eftiBLQZDq4YOltv3gELcAF0BfTMb6UqDzr4Zc0011b19nY6c2P1LoaVV9Xa1jTHY4708ytFDJt2ieHA==
Received: from SA9PR13CA0097.namprd13.prod.outlook.com (2603:10b6:806:24::12)
 by CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 00:44:20 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::2a) by SA9PR13CA0097.outlook.office365.com
 (2603:10b6:806:24::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16 via Frontend
 Transport; Tue, 11 Jun 2024 00:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 00:44:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Jun
 2024 17:44:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 10 Jun 2024 17:44:18 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 10 Jun 2024 17:44:18 -0700
Date: Mon, 10 Jun 2024 17:44:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 08/14] iommufd: Add IOMMU_VIOMMU_SET_DEV_ID ioctl
Message-ID: <Zmed4AtFjuF7+lWd@Asurada-Nvidia>
References: <ZmIDqgfINXfB0i3L@Asurada-Nvidia>
 <20240607002707.GJ19897@nvidia.com>
 <BN9PR11MB527604637EC37B3B03FBBE468CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240607144917.GK19897@nvidia.com>
 <ZmN5WZkvDeIS7RRH@Asurada-Nvidia>
 <20240610120446.GP19897@nvidia.com>
 <ZmdbnGnp73yR36N5@Asurada-Nvidia>
 <20240610220110.GQ19897@nvidia.com>
 <ZmeGfqp26c3sGBmF@Asurada-Nvidia>
 <20240611002839.GS19897@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611002839.GS19897@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a6151f-d794-41d8-372c-08dc89afa194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|7416005|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wR81qUD8b65xPqAD+u4BcPKyzW1Ku4Zuh7cfigEqXH1OmmcpF+dfrT0rM/8I?=
 =?us-ascii?Q?a6tnW873TnVAXNIX9X/AzDpyY9vz8k8/HZT8wp6tsicF8r14NZ4PVK6EoOnl?=
 =?us-ascii?Q?WwXaATM5DuznnVh+HoLDroyFcsY9NFApkIrY1vRIXPxT3xalKZ9Lgi68X2A2?=
 =?us-ascii?Q?/vsEBCXyoehnikTJ6ewfPlWPqel6dzu+DEJR6b0wE0iYa9d35EpXOwJAFN1M?=
 =?us-ascii?Q?V2k6I9AWCs334+dzKASk1yyaDSZLuWzK4UnVMtqFxG8E450TDcRrKXzCPaps?=
 =?us-ascii?Q?O7ai22nTPQk+ZM2JqjG9Os2wo7AQl0KDZDA/VZAtn+Frxm9ZvBoCyATBe6oA?=
 =?us-ascii?Q?2QqtAdcZIAmWRYRI2qdqYapSsUJHzUJJ1eecwCpYm6r7lJssvUmJQUfO2xEJ?=
 =?us-ascii?Q?JJZridtEedtV6re1uO1kf3W+uXn+heZFDkJwcMJuoUALbEtEeOOQoKDdAGPO?=
 =?us-ascii?Q?UVnd0WhF55Wc/H+Sq6knb1iaxdot8/r6ytDIWfPdfmFOBeVFpG9a2O3JnNNe?=
 =?us-ascii?Q?MRSiBxQBbPaRYeHjnHbB5ZZj23KU9PKvS4ZnMcorw3P9e6ARAWVP6Bzsgh2k?=
 =?us-ascii?Q?QjEfp80+CP2vqUZ8jKGablNoJqRs4isjGj2WZjngBd4bX1berpu6j3DMXSc+?=
 =?us-ascii?Q?+66yIbOiAK9dJKL6jYtPSdZRQFNb/Rrg0T41c4nfq9rW8Ipb0KYRiDSkAeUQ?=
 =?us-ascii?Q?JxIsVdRXuiBuZrs+gdgu0eN+ln9W9E05v4DNOGFNMbKCEdVFOz/XOrzIS9iJ?=
 =?us-ascii?Q?Azo+RzoSKXX7voaRFvJDUzRzEQ3vaCisy15dzTcnpc/uc4DUkaAe5Pct6rYi?=
 =?us-ascii?Q?PSW/E97dNy9U1fgnU9NBM1PMrtdSoqLrC9xYgyI53bDbfF+kaEIYiG4TTpRO?=
 =?us-ascii?Q?vfbHSeUFga7fImVrXgKq6+jqjB3nXbRx7i3qy6h+tcBrrtLhm8NK6fVsv5Kt?=
 =?us-ascii?Q?B5Grp6Uy3RzP8HALGrp7RrCDFME21VNLm3VuG+gvWiZ5z5664Gp31l1UkOft?=
 =?us-ascii?Q?jJZ+aNJMISCkRnOE7hIcMAI1DZ3yVl8llyuGJF/H3giPq6lytOgyj/lScEuP?=
 =?us-ascii?Q?0JLdV8WX0sCQUgqRBr/feY8dKT6tJTYQTFgytr6cK7/5WLIKBNpc9QUOueZp?=
 =?us-ascii?Q?9zj7Dn3xtDp4N0rBe3wHDq08L12sJq1UHK9cJVroh9tWHnZNaK7Lav5Ipp27?=
 =?us-ascii?Q?XV8zGU+aZQ5DMWM1MKRByBFw7NR2VIDLmEKxlXdrdEIsNfRyIgwfdDL7N40M?=
 =?us-ascii?Q?EEOlnqZy1bB5OOzWO98NmkfozpHG5vid4hA+X1tuYKQ6UBjLkbydgKIwOU9K?=
 =?us-ascii?Q?CsCWOmq9ETqCdX/tciqidyAn6fLQdLU6yHY4aIsBx5lFCodtV+kCrE1m6XlX?=
 =?us-ascii?Q?YrsqeNVVAvvSoGJd+3XhLdTrSrm7sg8IF2ZT2s2Q6duhkVH7sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 00:44:20.1488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a6151f-d794-41d8-372c-08dc89afa194
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203

On Mon, Jun 10, 2024 at 09:28:39PM -0300, Jason Gunthorpe wrote:
> On Mon, Jun 10, 2024 at 04:04:30PM -0700, Nicolin Chen wrote:
> 
> > > > Actually, even now as we put a dispatcher in VMM, VMM still does
> > > > decode the CD table to link ASID to s1_hwpt. Otherwise, it could
> > > > only broadcast a TLBI cmd to all pSMMUs.
> > > 
> > > No, there should be no CD table decoding and no linking ASID to
> > > anything by the VMM.
> > > 
> > > The ARM architecture is clean, the ASID can remain private to the VM,
> > > there is no reason for the VMM to understand it.
> > 
> > But a guest-level TLBI command usually has only ASID available to
> > know which pSMMU to dispatch the command. Without an ASID lookup
> > table, how could VMM then dispatch a command to the corresponding
> > pSMMU?
> 
> It can broadcast. The ARM architecture does not expect a N:1 mapping
> of SMMUs. This is why I think it is not such a good idea..

Hmm, I thought we had an agreed idea that we shouldn't broadcast
a TLBI (except global NH_ALL/VAA) for invalidation performance?

> Yes the VMM could walk the CD tables too and build up a bitmap of what
> ASIDs are being used by what pSMMUs, and that would be fine for the
> VMM to do, but I wouldn't necessarily recommend it :)

CD table walkthrough would be always done only by VMM, while the
lookup table could be created/maintained by the kernel. I feel a
vasid table could make sense since we maintain the vdev_id table
in the kernel space too.

Anyway, it is still an implementation choice, as Kevin remarked.

Thanks
Nicolin
