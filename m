Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FCDFC17
	for <iommu@lists.linux.dev>; Wed,  3 May 2023 23:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTK+PUqDi8/0hTCOmHepeifUbiYTpcUvBqXpzUmcj929vtBBvW1gFM8Hcl9ZXkzp+9khE+W9MhMS4EsAYSKaWzbZn7NCnuTG0x3VC8PH7DSuPeWw96fd3pyiurTrV3iudMS+Ju1mkTg6W6J6igg/dsw+5F2Csxe3unxlILyT0MQDLpZ43OHz52EmcsjPHw6Ba/nKYjSnergBPGK4KiB4yS/yL97fTE6ceBalTGP9t5NleNY2T7dBABiD6B3X0kaB8GaXDYEMHi60W0dY2yY+rh51Phfygr2pJehTBkQuZhrMfJT3DDcgnnZ8IQzwGBYEe+/4Aeu3c/37jm5uBRg82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpA9+/bUFhdbbE0lPxLYxVyhahoxySX+tljB/AMmCkw=;
 b=UXIAO1AFd1JhwoRFFIsxwfFxYDdfVGcjGf4Jg0avjYRyGHFiTFesL3oXK7qDgznpTqrIuHL4ShKFtRccZKdqC4uQCYhbik5UbR0lHdqbCO2b9n4XRL21FFhLr4LOOJi9GBElBYAuvjBBdJ51W0PhqKRYafWkmWWXgVdBW16f+YSgRKlhsNKdi/BNolQHmYYXoYOslZTwtxyg+KV6JKtXa46xF3V/oXMmmwefMIkWVlu3JA4GpQfyfXse1rU+J/uYo3p9TvjaAhy8qvqArpWo2s0Vfv3OkkXepc8yXw7C4X+4Xz2AOU6KiD4DIJWvo7AVP+D/vZyIT3RyNZWVKxHHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpA9+/bUFhdbbE0lPxLYxVyhahoxySX+tljB/AMmCkw=;
 b=M1pA7vKcsNma8yBKHoA3Qz2pVXa//uVqWwqg2OJeyVbR6OvDLL3SqySo31hCD2n0S9e6yk20+TtlwZ88weJpLctQmgcfeYwsh0jUTzM+KbGm0t7rutlqnQSvEi8KafLDBn0VKHAOgESa2vK+EJpbzKx46IsmCPhbv5Te/gpY0XClYhfZ2FkS/239+r8sNr4bDAB7oAbx1SrWUciogD0KUqCXy5GpeQOFJACADuAFjxOc7laDmQs4Otgmdm/G2F7cESBy7u1VllvIklhm0V2NojZ1zhbOUe5e12IXnLFnrSQPc+pAJC9fQDJWjTPxSiNkYtyDzBBU4Rnm5Amf6hsRFA==
Received: from DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) by
 DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.31; Wed, 3 May 2023 23:45:06 +0000
Received: from DM6PR02CA0141.namprd02.prod.outlook.com (2603:10b6:5:332::8) by
 DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.22; Wed, 3 May 2023 23:45:05 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::d1) by DM6PR02CA0141.outlook.office365.com
 (2603:10b6:5:332::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22 via Frontend
 Transport; Wed, 3 May 2023 23:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.26 via Frontend Transport; Wed, 3 May 2023 23:45:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 3 May 2023
 16:44:50 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 3 May 2023
 16:44:50 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 3 May 2023 16:44:49 -0700
Date: Wed, 3 May 2023 16:44:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Shameerali Kolothum Thodi
	<shameerali.kolothum.thodi@huawei.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
	<yi.l.liu@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, qianweili
	<qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZFLx8Ltv/3TL5eFm@Asurada-Nvidia>
References: <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com>
 <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
 <CABQgh9HLNp-cSp+KhVcgyuVioQochJcG_NyhNcDP0DF1SWs_PQ@mail.gmail.com>
 <0d41efe6b0a844878eadccddc2e12679@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0d41efe6b0a844878eadccddc2e12679@huawei.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6NAM11FT053:EE_|DM4PR12MB6469:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2b80e5-652b-4017-af20-08db4c306bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VbS5VO5bdwqsIv6y+bYMNz6Q2zpCyiTDab23xmkTqNO4JYaaa7S3mXb9K81GhxfCg0NlxbqiP7oo+FyYNOeUVE5jbbwEBQv1Z8J67c2T+XiGQd8NQWi10wDLYX7CIDKs4JnH+qltciXpmXDQzZMNZP7PgKNQF73JHnx5Z5JJHVjPpxMOqiPQbnV9WYKlMESc64EZtQdV3orjBhMY0yOVUu/o1mPHcCMLzEKUGi8LRoD2bLuZqlVRF12Nw4BcIoHlFekCTuKKUg3k+bArjlCTRjd0r22PYbLSLRqfrL08lZq8aDNId2I70zTJAUpz3k2HUIpvY/ZwksdXZ3F7a6IX3EYHoMXsaGdiYGr11H8vLnORpv+p8X64bKDGzyB1sNnP448bUPl/RVWpowwCcsq/E+33J1tHeBqOSboBCI2IjDdCypDuIVYv6zYS5UDEN/we7WxsVdtZ90lvdzRgQr6yuYqH+lPQOUTt+METUnBzfBv2W5vNtS9PUYcQqWJmc0jO6iPj5ZC77JVIDNcceQf3layp+h9Bk/eCPpiek3L9RiIjtH1VgbsW9arh6+41vWXdQLGhJr2mbL1dZrj9C6ZzGg9mr8d7LUyIiWoTVVV+GTKjUeTFkoWb36P5wqHZo5yEacFQmQLZ0aTsoBziHHnoiDpQOEPdl+ClSwG9QMs1fQzD09As/wjQUSdBlPQzpDQPEkIpzIoKlGm1lEiFk/yHHXI1jgAIF4gsftUoQPwmyEGnz1RXG1zsEDt3jv+yE04sarCj5oT2ZjnLjP1P57AqM7jQROiwKiK3sSTWeFIAwwc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(356005)(82740400003)(7636003)(26005)(9686003)(40480700001)(110136005)(40460700003)(2906002)(7416002)(55016003)(41300700001)(8676002)(4326008)(8936002)(70206006)(316002)(86362001)(70586007)(54906003)(5660300002)(82310400005)(186003)(36860700001)(83380400001)(966005)(426003)(33716001)(47076005)(336012)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 23:45:05.2761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2b80e5-652b-4017-af20-08db4c306bd2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

On Wed, May 03, 2023 at 03:14:28PM +0000, Shameerali Kolothum Thodi wrote:

> > > On my emulation environment (very slow), with mmap, I see
> > > improvements. I'll also try setting up a test suite on a proper HW
> > > this week.
> > >
> >
> > Still debugging the mmap method here,
> >
> > Status 4.12
> >
> > 1.  ioctl method works, based on iommufd
 
> I had a go with your above branches. The issue below seems to happen only
> when you assign multiple devices to Guest. It looks like when you have multiple devices
> attached to Guest, the host kernel receives invalid Guest cmd(0x0) and ends up issuing
> that to HW triggering the below errors.

I actually found a bug in my previous wip branch (non-mmap),
resulting in a cons/prod index overflow. But the mmap branch
seems to be okay, since my QEMU code copies all TLBI commands
starting from index=0x0.

You may compare the git-diff, just in case that it helps:
https://github.com/nicolinc/iommufd/commits/wip/iommufd_nesting-04262023-Nic
https://github.com/nicolinc/qemu/commits/wip/iommufd_nesting-04222023

Btw, I ran a comparison on a real hardware. But it does not
show significant improvements between the ioctl solution and
the mmap solution. So I kept the ioctl one in v2.

Thanks
Nic
