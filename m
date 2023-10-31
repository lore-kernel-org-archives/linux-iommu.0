Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4291360
	for <iommu@lists.linux.dev>; Tue, 31 Oct 2023 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WOiKDTk4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eC4wHh+Ewo8sMMl4pVFIXaYhmkXBlDls05tDW+v5+PI/FbXdrd1JBYxNC5megnKYaS7gPtw0YFX/gJfXSo92xQWfhKpF5aOO8P/F2TUk+PFjfkRhPTPMK9rlJaCc07VAluBzoQ1KyFxU7RQJ1KsVwKWRplJ7+8Q3YEsJTeIANhN/5jTm3iWftQrlQ0FxLM+kHggnUvdYZQ0zOmYCVCSZ6oETrW441uaY6/FceK+XaEYP/Y7SDDNUEuMg2T5wtpS88FU1l+AqqRFN/D0mIiDj0NXTiSzrSdZB32x5EuJhUr/OgbBRhdo6GEJuF4M6x4VL0VIqKOZOgkmi2iWWlZBJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+6SQa95iZsbsSg4tWjQTZLTY4RZhrnhR1OgjAvgrpE=;
 b=BUObbmNoIxo3aow5frAoWE95xR9oO8hpIbQ8FcMc/BFzrHnQ/TSmWxk5Pa9cguOiAyKI4YHGFy0P0z1ZWiPaGkHdKH8LvFJsvx6y9cOSVHxJT+QJfT8EGHI9MT2Xz19xVfSuCq1MsTZ9gXDR2HIwtbGOsDiJ1gIxb5TqJlc9EwN6fRM0qBMfA8ZzX+9QulkVHwXaFd5GnU6QPNTD5o90IoRWuPCCMBqDPFtmNeEfWeYZtvdj7HE1JrHuGAI5uSWuExL+DEzSFj0DFv1Bygo5QNyMIEXmpGC+ccHRQE2gvdi/OYqI+h6cUmXmE5GKZftC5EXZ1gnTJElx39vEcb3cIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+6SQa95iZsbsSg4tWjQTZLTY4RZhrnhR1OgjAvgrpE=;
 b=WOiKDTk4RzMtKFhApvtQK3B5lTPLKrXsbGGRAp1atv4Xrk5NiWjcgGk3TheYH3z8t3vJ6q5c7SqBcI01KvVuB8Us42BXPVR8aZiB3WRdidCULCq5XBBPcOsr4FuXVdgczW739sglVNFzGtb21lDGvS3scxzjDaCQGn6tWL+CmFUYhDcI4YgrD+jCkV+l4iwVS/oXhT+WuUsO4H6gLDpGUPFOAvBHyn4Y07+Qk9mDJ6+RRXhJv1Hn3Q/YLtZdCC7ixgW0ElFQQXGE7aZSrH6Dxe7gdZBV5vQDqcBSODw8UlP9OeKbwIopC552hlB/VJIUMJykLPNJ5pUnRrm0CURBQw==
Received: from PH7PR13CA0022.namprd13.prod.outlook.com (2603:10b6:510:174::24)
 by DS7PR12MB6312.namprd12.prod.outlook.com (2603:10b6:8:93::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.27; Tue, 31 Oct 2023 00:27:05 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::10) by PH7PR13CA0022.outlook.office365.com
 (2603:10b6:510:174::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.15 via Frontend
 Transport; Tue, 31 Oct 2023 00:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.22 via Frontend Transport; Tue, 31 Oct 2023 00:27:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 17:26:56 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 30 Oct
 2023 17:26:56 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 30 Oct 2023 17:26:55 -0700
Date: Mon, 30 Oct 2023 17:26:54 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Kevin Tian <kevin.tian@intel.com>, Yi Liu
	<yi.l.liu@intel.com>
Subject: Re: [PATCH] iommufd: Organize the mock domain alloc functions closer
 to Joerg's tree
Message-ID: <ZUBJznfex9OY8ciz@Asurada-Nvidia>
References: <0-v1-90a855762c96+19de-mock_merge_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-90a855762c96+19de-mock_merge_jgg@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DS7PR12MB6312:EE_
X-MS-Office365-Filtering-Correlation-Id: f4246e0f-191f-4c8f-43d5-08dbd9a81bd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hb+hH6qwQ6PRbtvGmgbB1Q9xmx6fhKUJaTbBpccN063jky9/rXINr/vgHYwa5fICYSEmznK0klt5T8lbU7GjWzWhywr7sfFTUgbxALY1GxwSxerPfCIN2pA42cx5GLReITRyEuPCYBJRPxODnU0U5AHDFH7wT2V/HfocER8R4+PCWczGjbvi14m9xytCrcxXAoHBjaFnaIwXzhUzoxwKN0UmE+MQcS3qn0/jJs6wb+39uStKywJ1HgL3p/7piwJ6wdt8Kty+cn4EPD0Lpg5w6yVMmu9BGVSlo7J0WKHBONdwrO4ZjQDLZPtsE0Nq4Ni9gim8dvjDAsAo7ndhMEXoy+tDu8DzhB+ui0ovE6F8JlqebMpFkHyXDiiVySDmRndlUWmQtUjONoF35nIJB4Jqk+1FJw0iI63ZvGLb1klpAl8Cghds1Bm2yKRdloS3aUvePt7qIs2ntxEoMjbiRu7TQZvCQlaSj+NnPsUI6sfZGrp3eirFJ7rlxtlSSafx4uMDdDKj6y4liqLVHKtkfh/j8SlZT0+cVygs3u0g7cRIynVq6/6nzDaQAeYa89/1YeH+/Mstq+Zrsi/GVDLaVNjWuzlfmMTpIs/UFQTNYvrXLCELc7LXqBmi79KfwJWbRHJ8K4BU/D0tsvhJ0Pp5p0yUH+G9zcoVv8zRH6CaFt5y6VpByQolUh2UxK8zr6WzypdVQmQ42eLFx+MGzXWUTXk40f1J6m3o7BC0jdTSWU29vLfxgrD5LU2wBtq+/hLsLWJ+
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(64100799003)(82310400011)(1800799009)(186009)(451199024)(46966006)(36840700001)(40470700004)(478600001)(70206006)(70586007)(336012)(426003)(9686003)(26005)(41300700001)(2906002)(54906003)(4744005)(8936002)(8676002)(6636002)(5660300002)(316002)(4326008)(6862004)(33716001)(86362001)(36860700001)(83380400001)(47076005)(356005)(7636003)(82740400003)(40480700001)(40460700003)(55016003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 00:27:04.6607
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4246e0f-191f-4c8f-43d5-08dbd9a81bd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6312

On Mon, Oct 30, 2023 at 07:53:26PM -0300, Jason Gunthorpe wrote:
> Patches in Joerg's iommu tree to convert the mock driver to use
> domain_alloc_paging() that clash badly with the way the selftest changes
> for nesting were structured.
> 
> Massage the selftest so that it looks closer the code after the
> domain_alloc_paging() conversion to ease the merge. Change
> __mock_domain_alloc_paging() into mock_domain_alloc_paging() in the same
> way as the iommu tree. The merge resolution then trivially takes both and
> deletes mock_domain_alloc().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

The change itself looks good, though I don't see much difference
by experimenting git-merge with and without this change..

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
