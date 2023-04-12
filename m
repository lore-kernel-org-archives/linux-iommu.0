Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2D631
	for <iommu@lists.linux.dev>; Wed, 12 Apr 2023 05:47:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrtQnwrjPGpfe0OuAzJZt4BveX855wZamqR07NPL1Knaix2zQuM6ikI+7cISFs3Dho6I5P4M8JQPoPJ+EVRh7t+YgedV+tOHhFVoRpWiQlsJ/RenOg3eHAIkANHQY7YGVc/ajNBYcfWCNzgsHGAPzkHRy4Rrxec72N3qCkFIqkcM1NCbjZzv9682lof+XYA3cUCYsXHLwNhXnFOdAKggATXEisLVQEFbrQ06bhf40ypMwHtVJO4U3r/GonHjpE8LcYPNAGVdNknBLPk5camXUjjPuZdog7oWpaJMYKN0XuZILEbL8s+Bm76cFtEk5T07wHAPHv4Cc0yP524ut0fZvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4Os+HGoQJXLSkfUrKekJU1Wt7BWQ1J/LNr8ZvTB5Fc=;
 b=YL/fQCowoB/gzmz/cUdBC2pbgfUMq4O9EPVSIK7A552oQIoE5k1S9shzvQLGn7D6Eks0V+84twdYTPE2+YfYAoQzj4ThdY7F+gLiESiq0+I2KLmZZgpVUZbJGss4/doQKjq0Sm+e5GVZ79uB0oLfhm1/Q6DWN5EmuXIIOmq8dc/E36ZPaYVb+c34ZyxKflvnTFqaqsxVcCGVdt5XkvAFsm3vSswwwquVWdjZv1VHH1R2HZkdzj4/+GhKHOq74Dc0+gEa4+JA8POAMcwK9zpmTPDfNDJzCGuVys3Mp8xq5wTRAdYLryKk6dkBDZ/OGrL1s20qP0ZYmmYZ7a8XK7uX/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4Os+HGoQJXLSkfUrKekJU1Wt7BWQ1J/LNr8ZvTB5Fc=;
 b=pDLEENPUN4zUZq9AGXxiMhUD7wCMAiZ2AbGoBA8nJsIP4YoCNOM/S30l6ZhP2lGEHOJl32UIB1jaoOh49VN0J02f7W/TtRR8eBvxqtGncOqQonhVMJp7cr0L7SKjLYuDQMNPm7sE3BEHy0r1Retj5ey7+IST1+bFuCtflVmdhKt2wwZ2KC6yHuVbBAPVRVyi/tIhtVNq8gwRPZpVYpjYEaKu/JpyM2Kbc02vZ+k8JtTeHY8B1xjb1/w0vAwXcCMCVe73Hfavyym60Z4Gyhp6lm6VYO5H9Pp1JPNl8zs1V0olWQxjD/YqwoeLkTCthfE6i+33NlIXRGcbWU1jRtPsXA==
Received: from CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 05:47:17 +0000
Received: from MW4PR04CA0209.namprd04.prod.outlook.com (2603:10b6:303:86::34)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 05:47:13 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::15) by MW4PR04CA0209.outlook.office365.com
 (2603:10b6:303:86::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35 via Frontend
 Transport; Wed, 12 Apr 2023 05:47:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30 via Frontend Transport; Wed, 12 Apr 2023 05:47:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 22:47:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 22:47:02 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 22:47:01 -0700
Date: Tue, 11 Apr 2023 22:47:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, Shameerali Kolothum Thodi
	<shameerali.kolothum.thodi@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
	<yi.l.liu@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, qianweili
	<qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZDZF1DxAYxVQEcer@Asurada-Nvidia>
References: <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com>
 <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
 <CABQgh9HLNp-cSp+KhVcgyuVioQochJcG_NyhNcDP0DF1SWs_PQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9HLNp-cSp+KhVcgyuVioQochJcG_NyhNcDP0DF1SWs_PQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CO1NAM11FT049:EE_|CYYPR12MB8964:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 3911be29-0e61-4b85-1a5b-08db3b195d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	k2Y7850Z/rf+t7pVnW5tk0F8+lJTUfCaTr80aYzAHcuMIr4HC4RYRGm48w6so5WZQaMH0S154b1C8n6I23kONZIRzVTG4Ly3b3JIxp28HMCQwqNjPMhRb35kJ0PxOGDZwy7f2txrWmVQukciEB8Eez0CdowCXTdFf1QPhe8i//zm8aoUbKlaIvFuHyBi3iIvw/AjrPF+z0jPR4lNsrO+DWTiQ+ePaURW66Q/GGtTgcNKK77C9YjD/ZsdipoziJ3MSXtTc60jt4Bow9RUHplx7qNdYBvl9Ua7I92ciRt5aFiTF19Y/YtIb3zIXgiQ5isl6OoVMnJBEAsRFmj42dqoJUfeeEr6aEo6klzqtc7q/Oqk0iY8Q86hnMOPliyr845HajAba2Z3/c0x3DeHY08eDPJ91BIPzp1by2PqSI8Vr5zAW6IoVp5KsL4/r4zBg6jTVlPRdOpx+klAE2GZa0LtidNSUo0ZwG5XA38EvfrPH/fSOnYCzJl0csB5wOwXEu9k/Zxiz0AJfNTMxs7M9ei+TIzSJnQ74nwKvm5b08JDv16OWK8d7n2xfENasESkoPC9zOW5QP5gLvGb16nldi2M6+saNgtVqLGxmQoiY7Tmy1vXtGPbifZsKLqQiqP1WNeeQdLLaSpjH+uflvnAEA5YptEODTkxrufxljWVMTTv6Y8spjf9FFUt/lxY9j8auoh38vL/FiJFJKV8XKNZN5Nf5p//JxMBMAo8oWlzlJ2ju0oGOdvp/x+6DJYQzNi8Cf25ePhLAR9JyxyFUwn/b3ZrJljd0jM8R9ppz5Fo/TkjVIg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(478600001)(82310400005)(36860700001)(86362001)(34070700002)(316002)(8676002)(70586007)(6916009)(70206006)(4326008)(54906003)(8936002)(5660300002)(40460700003)(33716001)(7416002)(336012)(186003)(426003)(356005)(82740400003)(7636003)(9686003)(83380400001)(2906002)(47076005)(55016003)(40480700001)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 05:47:12.9081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3911be29-0e61-4b85-1a5b-08db3b195d6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038

Hi Zhangfei,

On Wed, Apr 12, 2023 at 10:47:56AM +0800, Zhangfei Gao wrote:

> qemu-system-aarch64: IOMMU_HWPT_INVALIDATE failed: No such device

Only ATC_INV checks vSID field and return -ENODEV if vSID is
not linked to any pSID (i.e. set_rid_user has not been called
correctly for that device.)

Maybe you can try some prints in set_rid_user on both kernel
and qemu sides.
 
> host:
> [218.986319] arm-smmu-v3 arm-smmu-v3.3.auto: unexpected global error
> reported (0x00000001), this could be serious
> [218.996464] arm-smmu-v3 arm-smmu-v3.3.auto: CMDQ error (cons
> 0x01004805): Illegal command
> [219.004606] arm-smmu-v3 arm-smmu-v3.3.auto: skipping command in error state:
> [219.011622] arm-smmu-v3 arm-smmu-v3.3.auto:0x0060000202110687
> [219.017515] arm-smmu-v3 arm-smmu-v3.3.auto:0x0000000000000000
> [219.023422] arm-smmu-v3 arm-smmu-v3.3.auto: unexpected global error
> reported (0x00000001), this could be serious
> [219.033550] arm-smmu-v3 arm-smmu-v3.3.auto: CMDQ error (cons
> 0x01004806): Illegal command
> [219.041692] arm-smmu-v3 arm-smmu-v3.3.auto: skipping command in error state:
> [219.048707] arm-smmu-v3 arm-smmu-v3.3.auto:0x0000000000000000
> [219.054600]arm-smmu-v3 arm-smmu-v3.3.auto:0x0000000000000000

This two commands look very wrong...wondering why host could
encounter them.

There's a pr_debug in arm_smmu_fix_user_cmd() that can change
to pr_alert for guest queue debugging.

Sorry, the mmap solution might be buggy, as it's a proof of
concept.

Thanks
Nicolin
