Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0B36C0CB
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382538; cv=fail; b=PfflSWuOIp7Q8sj0zX+g0ye41S7s6Odv6siFVRcE7dVrnq5ghc+RwElPojTlQ57Wbl46gCqcCoLEO7xLXplB6npXBNWQ3IiGPBNCoMymuTuJ2VsWFpPx19x01CEzzW2IkDg6dWRidgd5OlBEgEkCdKQ41+fAe5er+CjB8MooaiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382538; c=relaxed/simple;
	bh=cbtk/6YZh1W6lbvAZwSLHtYQPzQWd8UU7dznpko991E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWVgxXB0TainNe213q/az5QM+AU1kXPcIDi3K05ySvO2J5AQLKdPf59pYiHwPQQkgMUa69g9m6nl/5P4fFCFknClq/OAwahJpiQogddpG7x5apdU4TuGXHWxGO+vDmGLqPHzguE+6LqDA3zVOcb51bYiA3DXu7cMQL39KL5U9ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UwqhZGd9; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UwqhZGd9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqAH4sfKh/zcJT1ftIi543pgzumZDUxs33c8CL6qzymdSXeP1rEcT13VAWe/n79lHHXHoEdP/5eUBAM5nfw2Hrq/ErQzb3jCFed1tpmdoBWI4qTAAS4XACmC9D9EpVtNoOMsK0bvzw+UZ347Jxts19r+RH/mt+YBNsPtVcpg5K13njoQ08KlJL98+Dby0gvxN7sOjiNcYG3MQ35qmr82qaFF05vDEY2NfOilitzgAJNpGaBWKWRsjKBGhl1fqzkw8IbiDbTnkyNoOdcnLpGFot1lhehuDNf0zcFyWX40wjbS5ZhTWMXtdLF9SlLIH69WZhc8GhXnQIT2pczaoRSBAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udzWFtsE6qTwor2FAZ2/vI1IVqlawgkVRMukh7/+c54=;
 b=fbHv6U+X/YHme0mrcfC1jxIx0N3QDBD7IbhyJ/TpuBEvZOMD8sUoI/zoS+6bCpha9/MSpG3w2ARugnqvqNtt+clyED6jpnSwKm4uMTAAKseJ2mVvvUqNroLgiBIRSE9wXQu7lJDEPPdjojebqla+jnlO0wunRqEW23f7DEWAXX89ySIs4IxJmm0oeXfQXTtimjDYnETOj+9t5HOxZAw+zQWkZ3s+rQgC81ptbffBOknMZ+mewfyjZAcWVnASrqtB1ne5qjqjhYdtmvLoMF2QCnvC8dWxb++P8+zWY03P9Uqmu54weGFBDHYmepmTCGGTgWdp8VfXrq1mNwBYPvdMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udzWFtsE6qTwor2FAZ2/vI1IVqlawgkVRMukh7/+c54=;
 b=UwqhZGd9qRyAmv3zkn6NhqJM3ltzXpYdHYz15f7WFDTc5P18+UTbq6h8x2t8zvs/W14XgntDCAxH2l9JUyIXNq/9XBMrzB1V8oJO/T4Ux5oxVhbQJuyUApeeEVdt0ZdpLXHRTA7nskWPtCzsbquKkog5lWVwc+OK2SpO2AOVMbbqBjQRlOR9XQbrPx2K9bGzvGKevP9W8kmhmrlithPaL4ujJDIXoppa0N6oCPyLj9oyJb0iJgqPEULOWz3N1s7I2c9XaRLEOq6ykLNIvQ0NXF3zEaB0zo0SHtGuFQCihlY/2NKJpVg+D25Lcp55nRyBZnbqPVmFcamzFmQ9lFLOlg==
Received: from SJ0PR13CA0045.namprd13.prod.outlook.com (2603:10b6:a03:2c2::20)
 by MW4PR12MB6801.namprd12.prod.outlook.com (2603:10b6:303:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 06:15:31 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::86) by SJ0PR13CA0045.outlook.office365.com
 (2603:10b6:a03:2c2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Fri,
 13 Mar 2026 06:15:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 13 Mar 2026 06:15:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 23:15:18 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 23:15:18 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 23:15:17 -0700
Date: Thu, 12 Mar 2026 23:15:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"Jason Gunthorpe" <jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	"Steven Price" <steven.price@arm.com>
Subject: Re: [PATCH v2 1/3] iommufd/viommu: Allow associating a KVM VM fd
 with a vIOMMU
Message-ID: <abOrdFR4L2n334MR@Asurada-Nvidia>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-2-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260309111704.2330479-2-aneesh.kumar@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|MW4PR12MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 6330ab7f-bd7d-49e4-2861-08de80c7ee1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XtfuCB9QBzjSJFMOZ6yipvR2dMrqbhx05fh2fEha+KxHYMfnBm1/7++r63XSeyO9iFhQT3m913WCowO5lesnLSdBQuh9IFCurPqWd5gb6sjYPEmQCQmXOEbxCsbrzxQuH/7joFesqB/ffRpxhM5uBvg0boqAu2XlQJpkJk+q9bHOJtv8qQa+nOvMSiE+mfU1zV5lOrWI/vj7799p4a7GJWUE/RVAHWHLl0/guWkw/hNWTsFJQYedjW2NwoCySfLSTdqVuuUq5zBNGZSai8xJ8jSVvkHXBCbIBqEsp5OTZR5bg0mBPmST0uZmtDcVdB/DliS+sJPPbX9u6HKWEzxjEXiYuFa+GojHRCqDCAtugOROj+yEklkc+ePWr1HKeaLAzYglJdyUq02s7ikd5Lg9IucpcvscVOQ/Qjy+reL6Al15tgEH8dQI639cFv4txl6Q6kcKD/rpgmtl6WPSmYQIeRr8+com9odTSPbuuGnqlrtu9pU/6cJvv7WIj8RyDHhFcWiizrZYtP20XBQWC6FVZWs0NuMccSRa0MrC5MoxHsMaFZ7X0I+xJlXT8icZCcHzjvMZrqkZKDcYzsaSK1Teywn+ClBJExffJ5oyOpdIFAyH3jYvJcI8IfUqAxXIJH8qtKZlwzmoh8XUpoA0IOt+IlLJn6K7PSabn1fEoPvk7kVA/FqYPJMJmdxGvaBFDrta/xM8ofcFgxV9SJ/b2WpqrSfxhFz1zWxYPFGJIRVvIW11x3PY5r4Ar9MRinhUmQEn3WPi0YjPDPg95PWrTKo7Qg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YtAOJ3n497EgWwcWR9ULhkjeybMDv6EIYKh95h4qte+JKTKaeHg5R0J1owRNPWuUHQM5VYDNDRiWSSFkmnS//uXC7utSpjGGTwmGTFn4iFNJ8TmQ/K3oEg4zh6N/dZ/egBQRCJotGZHRgVnTGjcLWOzK8xezdyvrDwwUwdpFqxuK/9xMkNs0RiIDsz2cntX9dXBUWJS9RDX31ynIdkazYpATpjvRJ0vC65M6V9Uof2JrzQwPpONMqOZublaYTHJEPXn8HEmI7vPiFwbG2LDtv33X27iYSTcOh5Hko9o5sWoNmmRnPOCwsi1+MMfMnPjIR+Dz5NguJv/wOppEQ23t909PS89FD4wwbNKA8eUobuE2lyV3813P3KcX9z+GBrH/pq3mTFTDYa0T0HigDFS2a2DHlWs8ilxD1DqAtpgkAw3suDJX/7hVg9DZyBqrnZxW
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 06:15:31.4301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6330ab7f-bd7d-49e4-2861-08de80c7ee1a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6801

On Mon, Mar 09, 2026 at 04:47:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Add optional KVM association to IOMMU_VIOMMU_ALLOC by introducing
> IOMMU_VIOMMU_KVM_FD and iommu_viommu_alloc::kvm_vm_fd.
> 
> When the flag is set, iommufd validates that kvm_vm_fd refers to a KVM
> VM file and stores a referenced struct file in the vIOMMU object, so
> later iommufd operations can safely resolve the owning VM.
> 
> This is preparatory plumbing for subsequent patches that bind TDI state
> to the associated KVM VM.
> 
> The patch also switch file_is_kvm from EXPORT_SYMBOL_FOR_KVM_INTERNAL to
> EXPORT_SYMBOL_GPL so that iommu module can use that.

struct vfio_device has the kvm pointer already. So, I think it
could be forwarded from VFIO side v.s. via userspace ioctl.

Shammer had two patches before and Jason partially reviewed. I
took those for a side project but haven't sent anywhere. Would
you please check if they for you?

https://github.com/nicolinc/iommufd/commits/wip/viommu_kvm

Nicolin
