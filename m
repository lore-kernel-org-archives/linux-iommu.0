Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E63FBC433FE
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 18:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91EF981D3A;
	Tue, 10 May 2022 18:32:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L82fjYplweNW; Tue, 10 May 2022 18:32:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 70A6A8186E;
	Tue, 10 May 2022 18:32:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58B9CC0032;
	Tue, 10 May 2022 18:32:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C397CC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 18:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A244C402F8
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 18:32:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VaTG5QGRXlC7 for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 18:32:00 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::606])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4939B40280
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 18:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHHgnItlIsK4Sdv5Znmax5t8bS+5ZjDO+R3JQtCz1TRZm+hPpgA9PlcjRCiIr9VtFMKWWsltd1Lq6QWpuSPi07bXFHRNIVrkVY8FaRXf3o0m+JCl+nqZgv7QxWPjaTOxvS8FKtx6/ZuwibRUIy9d6GglUnQ9gqutWfkiJC7YI+r7bN4kb/KUtHUOOKh4U+HhLf7P3eUU7aSzNAofayOyJFPeJcBGASswPJnUny/QCTA0agJqGkvRLhefpfF2ThedIh/a8ZkKbqOpy1dNzBor5rKT8wVXeX0Re8SttuAqahiqduvqVvhswcJ/AA+ZjG3T989r+7HN4ZrCvrirqMw46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgkVXEpbwaNzTkNXlPWgmdnBz+jnIz2vj6h5lgcR7Ro=;
 b=nYFgJuFLXJOP3fg/jAnMbhqjouzaob1tSTQaMnG0eHEsUSAQfaeZTbmnpPF4xN/qgjuhMevmwQRn3XQBNxwMhhtYN9unRteBfTy81aINR8mGjddwlc17/wQnpx3aOWLmqVjqmoztb1cGO6mW6mJUcwnE2wsYxt+GvCXXZdWTcEmA3VvrHQkMiUtbaj3JE1zBVgBVv5JKCZFww41XUe6vzAzpcfAMnVUdJohQiLvayJ27EX/RxFGFFGU8xbfyJCx014JIuV9J8b30FUpCOqQc9UOhdz1twYtOKF+xmIe07cheor30wZ5nnYiXQzHd+zxqmrrLGX83ug3Gq1pvwXLUjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgkVXEpbwaNzTkNXlPWgmdnBz+jnIz2vj6h5lgcR7Ro=;
 b=siZFvqPxSboc0z4NNnKJA+V5ndlLdA7/b9P/BPZrB1ihVJDhYcQq0CcusVHbxwcoWs5dwMiWw/FtXk9Sdj5m/e0U6dZrY4oBMPTUnK6WmJqOrgF7VK+u4wmIUwhg2EEyzyXMIGqStnQzkiJLQJpvZXnjNzIFslXg95xelx/W1OiHLfdPu53TfhfMOIuvRQsCNRlmP42GV0AopzhPtkZmv5xGA3e4ThhXOh9nMatwRx2OiHZjHNeRrUwZdxCVG7hFiwjsi27hnoBnlKdS024mTWEu+Pb4qIHgbJ+azAZp2z/AE4MiplklA3WI7vwVo7JPDefeHPSgew+k3vIDsCDkqA==
Received: from MW4PR03CA0209.namprd03.prod.outlook.com (2603:10b6:303:b8::34)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 18:31:58 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::6a) by MW4PR03CA0209.outlook.office365.com
 (2603:10b6:303:b8::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 18:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 18:31:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Tue, 10 May 2022 18:31:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 10 May
 2022 11:31:56 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22 via Frontend
 Transport; Tue, 10 May 2022 11:31:56 -0700
Date: Tue, 10 May 2022 11:31:54 -0700
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] vfio: Remove VFIO_TYPE1_NESTING_IOMMU
Message-ID: <YnqvmrVBU2JZUkj8@Asurada-Nvidia>
References: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76244f71-0a6f-4672-e620-08da32b35dd4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB449904BA8506F91AC29C2E1BABC99@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oF2GhdIXaEo0brDkeTCccTQd3VJ2z+6a4Y8mU5amkAmxxTMvepVTa5XM/iJU3B4va83YmSvN9PrNmoWXt7iTL7N6q1nd+ScsiNOIn45XsErl54SNvwKjm3qzrv7OybdRRChRui0VPOf+84KW5uWmcsrwtKEgUq2QBDziP7g9r7EF1pXOh768TYY2ehsvFKayStXQsg+u4ZWytVluyF+r5bDrht+ultxCwoabMb0J+V/wX/Vn8bcOBkY46+r2CiQpM/ZLP3GuF+oxD2MBOLHUDtoRm9Iqxcc2KUWJb3ndlDIvEwY+3gSQRb8F8/jhRZSBcpJSaSzYJ3mfPYdrX4QpXxoKGR7WbI/luEPmyQvqO8N6kaqVvxMhLdarQTxKpbsXam/xXy7s+oIpqwAa3tKSMhelkQOULNXpn+vsqPlQYdQBZ0w8J4FCeJ9pQWVTXAu9iYGIAN6CP03v09+bi8TW/O4F91W6SJsf0ZSIdWCxwvT/Bls/Mgc8l8vVMAq3bAxAVNd+i6IqsMu8YZrkLvPVSDm5Pg2oXtII67b97IkL68t2iNQsWmxeq6CGejdW/XtUx0h5IUQpSTaFmM1O/c2mcUo6tYUQ4tj8Xn3l/bhZkruw50+S7vCdWMU/uMKWVc2CU7okZBrphQZriSUTmDaP6xG8dapED+6tR5tPmZwEK4I19Szase2DPl+hxSQJERM5Z9XP9VO5FpXkpx+ipJ0r2Q==
X-Forefront-Antispam-Report: CIP:12.22.5.238; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(508600001)(36860700001)(55016003)(6862004)(8676002)(6636002)(54906003)(40460700003)(316002)(9686003)(26005)(81166007)(4326008)(86362001)(5660300002)(70586007)(70206006)(426003)(47076005)(336012)(2906002)(186003)(83380400001)(82310400005)(8936002)(33716001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 18:31:57.9552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76244f71-0a6f-4672-e620-08da32b35dd4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.238];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Nicolin Chen via iommu <iommu@lists.linux-foundation.org>
Reply-To: Nicolin Chen <nicolinc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, May 10, 2022 at 01:55:24PM -0300, Jason Gunthorpe wrote:
> This control causes the ARM SMMU drivers to choose a stage 2
> implementation for the IO pagetable (vs the stage 1 usual default),
> however this choice has no visible impact to the VFIO user. Further qemu
> never implemented this and no other userspace user is known.
> 
> The original description in commit f5c9ecebaf2a ("vfio/iommu_type1: add
> new VFIO_TYPE1_NESTING_IOMMU IOMMU type") suggested this was to "provide
> SMMU translation services to the guest operating system" however the rest
> of the API to set the guest table pointer for the stage 1 was never
> completed, or at least never upstreamed, rendering this part useless dead
> code.
> 
> Since the current patches to enable nested translation, aka userspace page
> tables, rely on iommufd and will not use the enable_nesting()
> iommu_domain_op, remove this infrastructure. However, don't cut too deep
> into the SMMU drivers for now expecting the iommufd work to pick it up -
> we still need to create S2 IO page tables.
> 
> Remove VFIO_TYPE1_NESTING_IOMMU and everything under it including the
> enable_nesting iommu_domain_op.
> 
> Just in-case there is some userspace using this continue to treat
> requesting it as a NOP, but do not advertise support any more.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Sanity-tested with qemu-system-aarch64 using "iommu=nested-smmuv3"
(unmerged feature) and "iommu=none" strings on top of vfio next.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
