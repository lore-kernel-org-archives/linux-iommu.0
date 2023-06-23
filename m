Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DD156DF
	for <iommu@lists.linux.dev>; Fri, 23 Jun 2023 22:10:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7ZPHvFPSuwiUxALUZZI8Prm/T92JtCkAxkrxvtV3ouN55V3rjinziC3WHsJd9dBOU0hncgQIoErxg46k4YT7fpo9UCOKzG8LwRK4vHT6X78QcGsIEHC5eY4Vp1Tzz1AttiwqAFP+SiDldprcHYNrlz9KqJYi0jD/GEFg2AWCfuiwHY1RzXGeC7Vc4TUIUK1D+i0DaKKmqc7kbXFUHrVemrqzNzzHKClhJOSRJ9ihCtEcSYqXrFuNq90AHdKs49Kox77PpswCUnhKbnURO6pZAUB+UvfHjDTgNYw9567S0QsqZaNBKVN0m9rBlKOmd7bj41ZGv3WkntoXkR3EX2XLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVI/dc7OSd46JBBatBjbwlwvBwy8SP5lQApzgN6ttKo=;
 b=EgisDus7BcGFrc7HaBNWur0BWsRc6fdSmJrXDx/Bm+I1sqzJaC0NAlzRwZt+/9guqGsSiwIVHYpQrjE2fZOn19+sVkNBoxxtucX5WcdweZggobC+6DB0qSlrmJ7k9ENEZeKXZPe+/SroZgPi6P/acRfHVN+kV+7FwBG4hoXAqReJpcgIzQuP67Z/6VPM9WecMfdYCOGFk5Hy5NZMNCYXi611tZrecRI8ZNzrzY4SNhX9tJnV7uoyMUkY0/zmh94RIywVbafi2EAo+c+z7J9QIc+/n6U47KbQBc5H3JOkUggf9bjQyiFwWPqhfjfzLShKQQqeRt1268uFhQ8PCinxkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVI/dc7OSd46JBBatBjbwlwvBwy8SP5lQApzgN6ttKo=;
 b=GboOI3iOjxRZote4bwAK0lRIJR920zxBtyfJq8t+8wSzxH0W190TzLsh6WUrimwBZo+Uget+U4wvylm2sUaFdva21sxu9S2zntVEvEsr/6jknj5y0FeC5EnzHbr/Wqg+5+hmogRKZQ8eQtK3XAZAOVtb+6naTV9oN2pd36relolBDVQDWSQCOPtGKErEExVd47/tqV/ABcEapKFYyu+3U2fg1xrN3pbgyjr24VwPTnT4iAR3OEJAZuo2jEIz1wEeu1W48KsY4ZWMRm/THWAnVS8xiKHRCmF62ut7b2e1jEuhUbjGs8mClUZ7j8N5MhjbAuEk631JqqodGR1fSbatHQ==
Received: from DS7PR03CA0083.namprd03.prod.outlook.com (2603:10b6:5:3bb::28)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 22:10:51 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::1d) by DS7PR03CA0083.outlook.office365.com
 (2603:10b6:5:3bb::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26 via Frontend
 Transport; Fri, 23 Jun 2023 22:10:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.11 via Frontend Transport; Fri, 23 Jun 2023 22:10:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 23 Jun 2023
 15:10:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 23 Jun
 2023 15:10:37 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 23 Jun 2023 15:10:36 -0700
Date: Fri, 23 Jun 2023 15:10:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pengfei Xu <pengfei.xu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <heng.su@intel.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING in iopt_remove_access in
 upstream patch "iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS
 coverage"
Message-ID: <ZJYYWz2wy/86FapK@Asurada-Nvidia>
References: <ZIp2DZQp/xLMarGi@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIp2DZQp/xLMarGi@xpf.sh.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: dfac193a-5758-4c6b-f8ec-08db7436b46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bFD3KmiuLXhV+u6ay65WseUcC641mv41qoGoi0I7tncUq5JqBkGQDgXnetHCDhzvGELo1KWDGrKSz3lQ8oxhWuHGshKc32FGj7BDBlhT6CnOc70ynjkwsIrOzlX8hYsFD43OOmNhwHMTjmXJkxDzDPe5x7wQfWVFMDPMrjAfCz2rwsZ/HUUNi4fT75CHKNASrUaAEtH2WEjfJcH6M7Wj3SmnLmSOCGZlfoWraOIAPhVeG0mfiG0aC7ll6+ejakAIvZrHn9G1R79WJjuZWj65LW3cP1luxuWKhxIj1Rn0UV3lWWsCrtrMjlNahB9IgIjdTjPRXtGrN3nOrM8/agOsvLUF1nsl1MNE+4PnBbigyKnjbYtDxxRJajO2z/alclnUIH8IWBMZjJ1/sbXYB++AUFhj7WxQg5wzLWQOwt7Aieg3bUtAhJKvsYq+dZFney2M3HqAo7uqo4TA0UHk4aU+Uxo6bC8Aiiwemj+Dg+z9DC9LxUQ1OcLeP4ghh6fglbbNl/S5kQhp5av6b0ahlw0lNBXNJdKqvJsS0wR5G1CCIKxjJ6025uzffCG7Wm2+WmFnPDO9GufrImUp229YuH2PRwXKcHwwfgMO7fyxIJkgpD166LnUzMQARV7lFrIBauVYKXuLRKtr4XkiegaiTg6K5l3gnwLvNrghuGfBXXapiEvroRtI1CZWPfWxC2UB0vbPWF/SoVFeuqDYn4EemybhVPjTxAQgJz/DdorRzolqMRbTsutWnMsMVcC77lKtHd3p2KrIxkln7MFRmEkGGMCXDRCFWZKcN0lIdfI+sKyuBIVr+cwc2d0gqmPdaasSiBGD
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(54906003)(4326008)(26005)(966005)(9686003)(70586007)(82310400005)(2906002)(33716001)(186003)(8936002)(316002)(70206006)(8676002)(41300700001)(5660300002)(6916009)(82740400003)(7636003)(356005)(47076005)(86362001)(83380400001)(426003)(40480700001)(336012)(55016003)(40460700003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 22:10:50.6085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfac193a-5758-4c6b-f8ec-08db7436b46a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998

Hi Pengfei,

On Thu, Jun 15, 2023 at 10:23:09AM +0800, Pengfei Xu wrote:

> Hi Nicolin,
> 
> Greeting!
> 
> There is WARNING in iopt_remove_access in related patch:
> https://lore.kernel.org/lkml/e93964b04d5b0f45344931fcae0e8696dd649988.1683593831.git.nicolinc@nvidia.com/#t
> 
> I tested Intel internal kernel and syzkaller found this issue by accident,
> I checked that internal commit:"e93964b04d5b iommufd/selftest: Add
> IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage" was same as above link patch.
> 
> It seems that syzkaller accidentally filled the syscall mutating parameter
> during a long fuzzing time and discovered this issue:
> " *(uint32_t*)0x20000004 = 0xb; // IOMMU_TEST_OP_ACCESS_REPLACE_IOAS=0xb"
> https://github.com/xupengfe/syzkaller_logs/blob/210a8d4069655735cc2bc2756981a944857a734c/230614_070652_iopt_remove_access/repro.c#LL187C3-L187C32
> 
> All analysis and detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230614_070652_iopt_remove_access
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/repro.c
> Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/repro.prog
> Kconfig: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230614_070652_iopt_remove_access/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/bisect_info.log
> Reproduced bzimage: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/bzImage_e93964b04d5b0f45344931fcae0e8696dd649988.xz
> e93964b04d5b reproduced dmesg: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230614_070652_iopt_remove_access/e93964b04d5b0f45344931fcae0e8696dd64998_dmesg.log
> 
> I hope it's helpful.

Thanks for the report!

It turns out to be a bug in the new iommufd_access_change_pt()
that does iopt_add_access() prior to __iommufd_access_detach().
However, iopt_add_access() overrides access->iopt_access_list_id
being read by the following __iommufd_access_detach(). Thus, it
triggers the WARNING.

A fix could be like this (will integrate in the next version)
-------------------------------------------------------------------------------
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a106f7c655d6..98fab19b92b9 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -796,6 +796,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_detach, IOMMUFD);

 static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
 {
+       struct iommufd_ioas *cur_ioas = access->ioas;
        struct iommufd_ioas *new_ioas;
        int rc;

@@ -805,15 +806,20 @@ static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
        if (IS_ERR(new_ioas))
                return PTR_ERR(new_ioas);

+       if (cur_ioas)
+               __iommufd_access_detach(access);
+
        rc = iopt_add_access(&new_ioas->iopt, access);
        if (rc) {
                iommufd_put_object(&new_ioas->obj);
+               if (cur_ioas) {
+                       WARN_ON(iommufd_access_change_pt(access,
+                                                        cur_ioas->obj.id));
+               }
                return rc;
        }
        iommufd_ref_to_users(&new_ioas->obj);

-       if (access->ioas)
-               __iommufd_access_detach(access);
        access->ioas = new_ioas;
        access->ioas_unpin = new_ioas;
        return 0;
-------------------------------------------------------------------------------

Thanks
Nicolin
