Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469E46FA1
	for <iommu@lists.linux.dev>; Mon,  3 Apr 2023 14:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXXNuhnrtCv7Cp8DKUA3m3pQ8+bBw4gcHlXAPYw9pNGvzMLRnHkFq0K0c6PyvgRIzJ/lJfNshSBtOPgC1VowxLXapzdaz/FS+Yx81IrJYeft4+Qh0IUOiC9KqnZWFaYtfDchhUNZo1JFCkz4rtVVMhU1/RQhj3d9Q7boaOllhcKw7e/D135LMmDIG9gCSIJPPhQ8KBME1efP1fkawbaPJZdBnNl+nRgUT1gKIkrArm79aldqTdWVluqC8qe9xZO/mtaR/SQ0RRKuKxxnb8U/ODjYZLwjUu54NO3GrnSsdfzXawFxWCJ/ASPIdxH/7qf5DZvrNyaC7vz+I27Rwg7sJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU1KhdgZmgBU2HO+5NWYSzqnaUuSfApssEGlXe60fnI=;
 b=YbwJZjNzn1UV6Nx2600Zk55aXHxXtgWYZSbelW5aG+hDxcAGtK35G28yM+ChrJ480wt8F+9O/WPRrKTCz4BLcI/2zFI4i6gvPFgsBJXQtxHJT9eeTTjJ4ZZk9AJ28ztBGto2og4SjKSyNKYJ2bEUPPHYE0ik9nTsBUQGlxYOtXHV+mihKIFGyhrxpi05Uqbs1Aplz+jmmz79eLq2k6ckbPNTDMXeiOWwkiFZW7xZM7YUg6Bsks5MiZk66nTkQ5d4SjKTyHRblqtFuKXx7V7VD7Qiae6vs7pC4wVIrGslWc7o62tfTFi7G1UEAAFB6AMVkLdGBiPj+s8yZjhdDqCNeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU1KhdgZmgBU2HO+5NWYSzqnaUuSfApssEGlXe60fnI=;
 b=IEcBeolYULhnKn9axsc9/dJgXk77crca9DhVcocdxl64Fj39RrgTSvPCFXAAkvdIVyt1tlJBaKM3IxAEl+mbtEcgOBWRqRuKxScFMOGQyh/Cg8k78ZcZJ5DlemyNX4APebCUpQw0BlmCtMgaUl7PpbkyOVxe33let89AIwjXg8KQ616NjBiG16w/9tKVUe9FfTpHImBbNM5Uibli9xX5xw/ThybdNNq8XVmX7jDTMUemDBssSEbrLj8Tw5pDsAkS41HRBeSsMxCNgTPBsRlm8j18oxKvg8M0DDOowbbZMKYzfz1SwW3qcZ61eqQi3Bz5fQkyT8MO28uWMmN2tv+l6w==
Received: from MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 14:51:59 +0000
Received: from CY5PR15CA0110.namprd15.prod.outlook.com (2603:10b6:930:7::29)
 by MW6PR12MB8733.namprd12.prod.outlook.com (2603:10b6:303:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.29; Mon, 3 Apr
 2023 14:51:57 +0000
Received: from CY4PEPF0000C97E.namprd02.prod.outlook.com
 (2603:10b6:930:7:cafe::ec) by CY5PR15CA0110.outlook.office365.com
 (2603:10b6:930:7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Mon, 3 Apr 2023 14:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C97E.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 3 Apr 2023 14:51:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Apr 2023
 07:51:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 3 Apr 2023 07:51:30 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Mon, 3 Apr 2023 07:51:29 -0700
Date: Mon, 3 Apr 2023 07:51:28 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Robin Murphy <robin.murphy@arm.com>, <kevin.tian@intel.com>,
	<yi.l.liu@intel.com>, <eric.auger@redhat.com>, <baolu.lu@linux.intel.com>,
	<shameerali.kolothum.thodi@huawei.com>, <jean-philippe@linaro.org>,
	<iommu@lists.linux.dev>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCrd1wphkCp8uFt0@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CY4PEPF0000C97E:EE_|MW6PR12MB8733:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c0c6e4-823c-490a-259a-08db3452f90d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g5hz9/Or/VgEQuVxSiONa++OKlnzmYPKa/kL0QJ5yq7MyZ4agcwZYA5TKzRtq0q2UXwhMnWlTFPlvoIX6b/RDr4C4BFIJAdMGryhNOvEKwhs9aHP8jyd4I5iSFpkHxvy5TxqPkp3odKRY0L8nbkD9SOUjjFt2NM5NxIWav81lR3rIRYiDPAMz1mVDa5VNQmEAaphYOP1gbpd343Uoka8L8BEDMd+ve/s9xuDLrbi1d1G7FVJr1gUfnxIZs3ndLnN5IIRghfPmuG21xUayyyy9dslk5YV8yIPbrKSLgMmf4UzC2bug3nosEQNzr92fGtXx8Gu/4pAGyMlb9Dh3WsByDuyeDKGu5Vrkkh45oTMnmFHWJBYcTG7w7EUCSVezy/+Z68lZoJWUd6gpXPaI12AEemMCnqoKQreFalIc6qEQCZp6NfpH992EBXMOIddmYJ3dHkyOS9J/Zyls4gFaIJjQd2mDnJk5JuiC3mimlC5ZTPRxrZpE6k+87Lx4BwTWf9aC28tqrPnoT9TlPARl3IMeGXhBctS2bmyt3kKBcN0UhVz4Mz18NWS4JSi5U6L/kPnH4VDTD9wn9s2/UZZkqNMzP5ia+uGB5euvblekekpWINaw8B0VFT+sdL8/JzWLu+GEyAbewSrO9g4Sne5/mOd8O5HBQKSRZmSFOWHiOmpjYQd/i6ePl1O/vVPbjAD12VcVa/FUgFm1L6DdvP5KjWWlhSLzsc2oYSpFVF1Ytcwk3ri+knycK7R0sbWzG5f2d4v
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(86362001)(82310400005)(33716001)(2906002)(40480700001)(55016003)(336012)(426003)(186003)(47076005)(83380400001)(9686003)(26005)(8676002)(70586007)(70206006)(36860700001)(40460700003)(41300700001)(356005)(82740400003)(5660300002)(7636003)(6636002)(54906003)(316002)(478600001)(6862004)(8936002)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 14:51:57.1220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c0c6e4-823c-490a-259a-08db3452f90d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C97E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

On Mon, Apr 03, 2023 at 11:08:23AM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 02, 2023 at 05:33:35PM -0700, Nicolin Chen wrote:
> > The first version is simply to individually forward the entire
> > command. This can save a few CPU cycles from packing/unpacking
> > invalidation fields of the commands via a data structure, v.s.
> > the structure in v1[2].
> 
> The kernel must validate the SID for the ATS invalidations, we can't
> just blindly pass it through.

Yes. I didn't go further with the first version, yet leaving a
line of comments in the handler: we'd need set/unset_rid_user,
to validate the SID field of INV_ATC commands, as we discussed.

> And this simple path needs an explanation how errors are properly
> handled, eg by making execution synchronous, or someone guaranteeing
> that errors are impossible.

Yes. Both versions here execute in a synchronous fashion. The
error code will be returned in the cache_invalidate_user data
structure.

> > Then I added a new mmap interface to share kernel page(s) from the
> > Driver, to allow QEMU to write all TLBI commands as a single batch.
> > Then it can initiate the batch invalidation via another synchronous
> > hypercall.
> 
> I don't think a mmap is really needed for simple batching, just
> passing a larger buffer to ioctl is probably good enough

It wouldn't be a must, yet can omit a copy_from_user() at each
hypercall? And it also eases VCMDQ a bit.

> If a SW side is built it should mirror the HW vCMDQ path, not be
> different.

The host kernel has the host queue, while the hypervisor fills
in a guest TLBI queue. Switching between two queues at one SMMU
CMDQ (HW) requires a very complicated locking mechanism, v.s.
inserting the batch to the existing host queue. And it probably
doesn't have a big perf improvement by doing that?

If SMMU has ECMDQ, it'd allocate a free CMDQ upon availability,
calling arm_smmu_init_one_queue() and mmapping q->base, then it
can execute the guest TLBI queue directly, passing that q ptr.

Thanks
Nicolin
