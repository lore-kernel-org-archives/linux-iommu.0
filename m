Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8C69457
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 18:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTmCtTxWaW1YK0392RFG7kasmMqdI9ZmNeMQDNLoU9qynoFo6R0V9l+qdJmXMhytXPLjc3VpoRfoCHTDGoojNakxmhpeTf1KjbyzAIrGU3tmCSJwmtnp4ONguU2MLT8Je0MzT3ZfwKr45cWD1hv6dK2gWdqj9rwLWocX2Gv1s1M2tN6pvbkWieQO/RmW1w3BrPTuh4y/RLKqpzJOsy2MPrlXFHy6xFLpFd4MrgJPUPIAPJabU0iaGr21SwDl3ejftf0sHUsr7nGrEBtkjoCf5pELQY8UVu2QmBVglGmEXwzxfLX+8QhD3ugzVTrSuz5Ac5fXxCskLSr6s+QhHQUyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGopi5TDmwVg4H0kiyj8eo2sZ0mww1thX8iEmnZLj3g=;
 b=oG+IA0+Nh9aMx+g8C0FGQ4a8wy8yLi9KTSxmp/Q18y9IQomHB+Q3D9Q3JAqnIMA4pvtrKhyviBoGDOF4dXCF8CUYAjT++fQqdAwtond48kZVixKcLwN/Vwy529ZlUBrSal5dVFAK9LhbsmrXmEyrHmuZBwx4CR/skVM74jFjzy8NmlIyTilYaW3gFvc8CWJu85IZafUDmCBF3/KILsyZMuclcyXr1BI9fDMZXVjOclWml/GDsfVgEEYoRBbq0BvYRS65Ozu+YTomxRb6U0/nUVJgSyS0+j1RC5t9Lgse8UuiN+Yqic4ujCwa5eO21rBmtvPmkhvUqed6L8sz9E07fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGopi5TDmwVg4H0kiyj8eo2sZ0mww1thX8iEmnZLj3g=;
 b=S+ZtFHlJ4UyCxuEzoK3kIgkVG7JgSAuRnNiO1abXG3kyQHk6yYWFe1ptvRr+67Spf8+8F707jtCai/X4ymYit0RgeiQKFFmMarJIMcvj/3KBTB5ax53W8WeWrlcsWd4i0wjeSGp9khf1HY/wq8ab0v7f2arxs+yPYElXOmi/AgRjJnqJar5yYbp4UBh1DOYX67Nl/MyYfu5kL7jk73SHkvJm69YFjHEs2vVn0kD5Vt7fl7H9wq5otwS/ZzYlBq4TXIl9yHn9YOODtqDaSHeJnQ9Y/HqmiEccEa02NrS3EjPlPu8rAn8Y23h/niwvz1Ga9SuY11coussP1VP56q5rBA==
Received: from DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 18:43:43 +0000
Received: from CY5PR19CA0019.namprd19.prod.outlook.com (2603:10b6:930:15::25)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 18:43:40 +0000
Received: from CY4PEPF0000C969.namprd02.prod.outlook.com
 (2603:10b6:930:15:cafe::5c) by CY5PR19CA0019.outlook.office365.com
 (2603:10b6:930:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.40 via Frontend
 Transport; Tue, 11 Apr 2023 18:43:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C969.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.27 via Frontend Transport; Tue, 11 Apr 2023 18:43:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 11:43:31 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 11 Apr 2023 11:43:31 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 11:43:31 -0700
Date: Tue, 11 Apr 2023 11:43:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: Zhangfei Gao <zhangfei.gao@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Robin
 Murphy" <robin.murphy@arm.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	qianweili <qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZDWqUbUXIprRDFDs@Asurada-Nvidia>
References: <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com>
 <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
 <20230411090740.GC2040385@myrica>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230411090740.GC2040385@myrica>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CY4PEPF0000C969:EE_|DM6PR12MB4483:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 51ea4289-21d1-4880-6498-08db3abcaae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cPY//mE/z9YN8pYa0B12LHcHCizmfWeXUv5NjmJvGIydhVZX3qA2Ykc+Hq8Bdp/vd1nPfN2ruOJzSddIY8u2ZkxdCbuSD50g3OAUGxwsch+9kaMiEUL8Gt8/NaKbZaUacOWL/uDycU8InlFl1xTUrjUjAonkD+VAcIJKNWSHiVkmqw15we/PBvR8y1hylngp/7VzUlxu9lMUGuCUdlBI27Xae/JCyMQAKapjCqUyn3PYuo+khydgkOigns9c1ICqgGfsT1DWYUv1VgaM/LwCQhKMLJHtX2L6z8hmuAyveof+LfNF4AJ1aD2cutv4THRiwhu3Y91vdA+z+S6CqzaJDZuH4aZdBlzZC/jJDTInXMmJ8PuR4HYkuA8K+w2qxqD4O2nNTQJW1+/e57a0Yg1VMWbGuxnNPUjdpz3Il4n9SnqmVgBIY+ZTTNiH766LpfCttOy5pbmtHUoAuitsr+W7tWpxe8iSI4pKr2EvAzb8d5bMaEZc+tyl29MARJUeVilgBkxL0Nb4nhMEZYiW96IX9jGwD3+OQPT1H+DKuDBOZIrtIDZsxf5PCY3Rt3R8vp3/+iptwtxapldLpIx9poH0sUE6zEL67D+gHBm/8e7GD5Vj9KL+8RUXACyhh/UpEyHz1SJ3yX4Xecj1ZlXj5cjWdvzYyZjlPD1+u+aQvOIR39pjREVAe5DB9xD2Pwg5A7a/NhfPr1P+b+nL1LhUaFxdJbxTjr0UGcRKjWnTtor4ysf4fUG6RH+oPrlwpAO8Ly2v
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(478600001)(356005)(7636003)(40480700001)(9686003)(26005)(86362001)(54906003)(8936002)(40460700003)(82310400005)(33716001)(186003)(2906002)(36860700001)(55016003)(316002)(7416002)(4326008)(70586007)(70206006)(6916009)(426003)(47076005)(5660300002)(8676002)(336012)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:43:39.7517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ea4289-21d1-4880-6498-08db3abcaae7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C969.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758

On Tue, Apr 11, 2023 at 10:07:40AM +0100, Jean-Philippe Brucker wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, Apr 09, 2023 at 06:08:25PM -0700, Nicolin Chen wrote:
> > On Thu, Apr 06, 2023 at 08:40:04AM -0300, Jason Gunthorpe wrote:
> > > On Thu, Apr 06, 2023 at 02:23:17PM +0800, Zhangfei Gao wrote:
> > >
> > > > We are using ioctl method now.
> > > > From the testing, the TLB miss impacts performance a lot, so we use
> > > > huge page method.
> > > > After using huge page method, guest can achieve comparable performance
> > > > with host.
> > >
> > > Looks like these tests are not stressing the MM, just measuring pure
> > > BW of the DMA, so they don't get into the invalidation regime..
> > >
> > > You need to measure a more real application that is actually using the
> > > MM (eg alloc/free memory, fork, etc) while it operates and turn on SVA.
> >
> > Would an iommu map/unmap benchmark test be useful here?
> 
> You can reuse and improve dma_map_benchmark, already upstream. It supports
> multi-threads and reports stddev. For some comparisons the report
> resolution (.1 us) is insufficient and needs to be increased, but for
> comparing guest performance it might be alright.

Oh, didn't know about that. Thanks for pointing the test :)

Nicolin
