Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA57ED
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 06:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKd/xIJfPue0fXZtOUUiaTlYilodsra0tuIx7U/smnrPEVaHMWZWXWfpmFkPTOmqgQwOtQWzWnKoXYGLJSL+clPGrncosPQzFcDuQGmNcA7eh6jAxJ2ort/2L/2qYYnbO85pcsJSHQo1s+DQEEK5huUDV7WjilwBUUhmCKHk2IAuwvZTwvJ5GkGH8JIXeKmCavupW53zLEyAZwt03QMq2nrvlAw1H30y+RgIEzXEKzUt9aZ+dnJl4gT+sjsjHZroW5KxmqjJI1XTxo/Wutdg70oyxk6REmzlwUAzzwdvE19x3dvsw/8S38EbtTakcYs2JWP/rVYKwE+xtuvxWaR9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkH8+Z/NpLGGzll9s+pjRfdamIT0uYTWQrwDynXLXmM=;
 b=cZ0NRnaK4Hm96RWxZKluQ60l3Tu5u7O3OfivNyQgXHJGkuCb7lQPkpg5b1JRNzMNwSfA+pxeRFvIqDYINTA+n7rOWPhM55lXeNZ5jxIVtufEmprgOVz654lrga3GrseFjFdl8DdBjbmEvxs6K1QfTPwTmyP4emlzI+BTif56YiyRluWao0+m1D1oX3GcVY73Lu44Z4VZWabUIQfGqWy7qcUaaVtQ19Ha7wLnj3FWmYHeHk1g/1P1OqA7PSPkne0OMso/ZETfnuEfUJlGr6Yp3e5jkmex5HFDydOepG+0+dgPxXv37H/pi236W30k/wxGrs5ap1NtG/EYgLqHEyhaCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkH8+Z/NpLGGzll9s+pjRfdamIT0uYTWQrwDynXLXmM=;
 b=g0Wo21N84ZK1Xe1kRj+RtaJ4zSbNecSQO2HIdgoI1DR4IPTw3GcZXQ7mAl9nBCaRowBC60pzJPuhrjzUcKc87s61dweYl1He4wTszc+TCnj1EttXMirQX96KMI1THVPnulWCzeVHHgxbiZGxi8dl90VyOa7ba02//MEl/IIQ8X5sW79Ngr8gj2M87o/hVo6XmKr7cdc0xhjfbqhL1CJf/GD6ECajcIPdIJnRUtisUBfmFoBRRBoWkQdC3nATE7kopMNBJjPLNDWK76euVNsswfLQCtVnNXFCB+Qjk/rACrcXtiiHapa6m0mhcN3hEagtvCVYzECN7Fu1B+Xdqxivsw==
Received: from PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 06:40:01 +0000
Received: from BN0PR03CA0048.namprd03.prod.outlook.com (2603:10b6:408:e7::23)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 06:39:58 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::d2) by BN0PR03CA0048.outlook.office365.com
 (2603:10b6:408:e7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.37 via Frontend
 Transport; Thu, 6 Apr 2023 06:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.31 via Frontend Transport; Thu, 6 Apr 2023 06:39:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 5 Apr 2023
 23:39:43 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 5 Apr 2023
 23:39:42 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 5 Apr 2023 23:39:42 -0700
Date: Wed, 5 Apr 2023 23:39:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
	<yi.l.liu@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, qianweili
	<qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZC5pLOjsEZUV+LOw@Asurada-Nvidia>
References: <ZCoe3+1q5ZLJsmeC@Asurada-Nvidia>
 <ZCrd1wphkCp8uFt0@nvidia.com>
 <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	BN8NAM11FT044:EE_|PH7PR12MB5928:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb82c67-ecbc-4719-7fdb-08db3669bd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kPf2LMEIqo0fuzi65AydR6gIpPtYKu3ZVLGCQaGEoLv4irLoxlYeJjzdhrAT4hc7y1mN2lPtRdt5PRS8EIfYzz+9fxJgUQhIFjXFVPxqLpeQzg7uOeMhbrC5Pmb/FQ/6Vn4SsHTTmXnu2zNSBRMgMnoiOC1QLjpc791CLSlXsGZYKGN8W2TnPsKgYQdOQM7E2PXMaC8QHqkBrW8u4BqsZnUCjjGtiq7ZmM6zhO07CpQTDilqMVZQGNV4l9i5IR9RYI+HI6zdM0FIiUy5btXBjS5AAKYQAtSMxDu2+f2kfGwd6hb4z1aGaixPWPZ+sxSjZdKuWN5bg84dtSGK093WzDg3vRsPU957/g5X0dnocZtLMHCfrXN7TtZ3vLzYytCIrAQQgwjdlfjOxGjrFTiAgxFN/Xmi6+0U+RdICnW6nwoDqdsx9vBoUCPOxMuxrq+FcYkswjx9rg+Jy9w48uAReNkUpIobARUIn6PuXf3UUf703DRbHFLtXqqv76GI3iNkZrcvoWO7TxcEmDwTN+JiNAHOVAer+UXzugVCrrlTDYTxwEf3zLL28Iep9HASyri2je5xp8XdK2iDRaZ43MyPwtNFNpjMrKdFOFr++MvdTxQbAYqDbWEdgcPKdo1BbjFiVOObEhPXZcO5sWraO34sERCEbBfWsN9f+NTKD0+B+2vnEeGRMXrED4FTHtXyrTCLt7pCo7/ZkTAq/iHiAPCA35a8s6VkhzOTcFujczcbt9xK3/cPSgXvGJjePW1IwUNwnSdsh+zRbdGhTqOUxHHT7w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(36840700001)(46966006)(55016003)(40480700001)(40460700003)(4326008)(8676002)(478600001)(41300700001)(36860700001)(70206006)(316002)(7636003)(7416002)(54906003)(356005)(8936002)(5660300002)(70586007)(6916009)(82740400003)(426003)(53546011)(83380400001)(186003)(47076005)(26005)(9686003)(336012)(86362001)(33716001)(2906002)(82310400005)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 06:39:57.7513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb82c67-ecbc-4719-7fdb-08db3669bd5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

On Thu, Apr 06, 2023 at 02:23:17PM +0800, Zhangfei Gao wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Wed, 5 Apr 2023 at 00:50, Shameerali Kolothum Thodi
> <shameerali.kolothum.thodi@huawei.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Jason Gunthorpe [mailto:jgg@nvidia.com]
> > > Sent: 04 April 2023 17:20
> > > To: Nicolin Chen <nicolinc@nvidia.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>; kevin.tian@intel.com;
> > > yi.l.liu@intel.com; eric.auger@redhat.com; baolu.lu@linux.intel.com;
> > > Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
> > > jean-philippe@linaro.org; iommu@lists.linux.dev
> > > Subject: Re: Cache Invalidation Solution for Nested IOMMU
> > >
> > > On Mon, Apr 03, 2023 at 05:02:09PM -0700, Nicolin Chen wrote:
> > >
> > > > My preference is to have a mmap'd page, so the interface can
> > > > be reused later by VCMDQ too. Performance-wise, it should be
> > > > good enough, since it does batching, IMHO.
> > >
> > > You can't reuse mmaping the queue page with vcmdq, so it doesn't seem
> > > meaningful to me.
> > >
> > > There should be no mmap on the SW path. If you need a half step
> > > between an ioctl as a batch and a full vhost-like queue scheme then
> > > using iouring with pre-registered memory would be appropriate.
> > >
> > > I feel like this is a topic Shameerali should share some insight with
> > > since the Huawei implementation will rely on this SW path.
> >
> > So far the tests we have done are mainly using IOCTL method without
> > batching and I don't have any numbers to compare against the batched
> > method yet.
> >
> > [+Zhangfei]
> >
> > Zhangfei, do you think we can run some UADK/vSVA tests with different
> > Invalidation solutions discussed here and compare?
> 
> Hi, Nicolin
> 
> Do you have mmap branch for kernel and Qemu?
> 
> We are using ioctl method now.
> From the testing, the TLB miss impacts performance a lot, so we use
> huge page method.
> After using huge page method, guest can achieve comparable performance
> with host.

Looks like the test has been running on previous VFIO solution?

Have you tried a sanity using the latest IOMMUFD pair? I recall
that Shameer has a set of branches for linux and QEMU.

Meanwhile, I'll prepare a pair of branches for you to test the
mmap solution. Let me get back to you by the end of the week.

Thanks
Nicolin
