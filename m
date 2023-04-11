Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94F15A2
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 18:39:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhFwFGvpx01BVI8L71mi2QTvidBBxKcahGkFn8ndYlD2jRUJeYaNDjCckZOdQoYeu0BtJw+lZLp9kpgM6e26sr7P8pOLWoGo0c1wigNnmHGImxSmIx6pG3BGacnr1kdlHJlu37IIyE6Eq/EVW2koatjPUXCWCL9VNYEe64gjFPQLt8mckWyH0aGUCcZra0bxXTGe0OV6k/6bloJyOOFoNlbrvfWx065M6QJGP81+e7XdT7WX9+v+qriRrfLJImPSmvyCp/oEBGGeTgb6PFM00vpg3Xv9Eh2635C1V1xGIMbDuaEhdbZGQk7/eBPr8bA3XRsrIGNz4WPEoxLa/JuF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQAAcCt6WbyGVkIMPUhLOl+7AJfc2Of+1cGMLk5NgHw=;
 b=mcYeiQBMXB3DQMyfpg2ggPWJCDNuoIY7KL9Vw386cZdEgViPNQc+Yg14kIpUrhMGi4nBFfIABN7qHGDmCBVcMoN8JD+UXTkT2JkUDesDmiYUi3VLLB794/IFEaKRQOhcs0P/UNPblWAqiqic+OQCxXnIVhDVl/dA72n/RB8MMoBRjsvUMlKBCcBKBz84Cc1s7/17Ch/IASKe/PERh4opNUSzd7AZCmhFXKvSW2R+PnyrnCAGe9rU/LH72jz07s7FPjZOGOnxmX7a7Vzlh63M9U70HjJ1YQBydjSOnxa1szEFt4y+jyoW/4+uzced56z4Tx4GzCwrp8K8HtCoImUKaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQAAcCt6WbyGVkIMPUhLOl+7AJfc2Of+1cGMLk5NgHw=;
 b=qaTgx7wQ5UX9gfMn/LGhnfQeKisAXl4DpAoCH7qkRexXlmdP5PiA4lyUKtvKteDuffWl0I5s9oXzVYeiMdwW4/H4Z327zrYSWXQyh9Pqe22Res3f6I+YyfbwmRuoGc1T/Z72PbOKHsd8lhgPDRkwjywjwbxVy8yQe70HwD8Exu/jtAyQkcm6PmTYO5VLOhvsjj9wMOUqOq5AgmvsqruRs1nlcnXDYNqOoqYKPoMyZAxk+qEGdI9OxUB/w1bCVqZskYsKXztLG1YPhs+rsR0OT5f0vg/x42WVAEyFfFFdas0sCjrbhPF7MKmZFEcAirWrS1/use2XnzQK85jcqXavZA==
Received: from DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 18:39:50 +0000
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by DM4PR12MB7743.namprd12.prod.outlook.com (2603:10b6:8:101::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 18:39:40 +0000
Received: from DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::26) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.28 via Frontend
 Transport; Tue, 11 Apr 2023 18:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT115.mail.protection.outlook.com (10.13.173.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.28 via Frontend Transport; Tue, 11 Apr 2023 18:39:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 11:39:29 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 11:39:28 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Tue, 11 Apr 2023 11:39:28 -0700
Date: Tue, 11 Apr 2023 11:39:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Jean-Philippe Brucker <jean-philippe@linaro.org>, Zhangfei Gao
	<zhangfei.gao@linaro.org>, Shameerali Kolothum Thodi
	<shameerali.kolothum.thodi@huawei.com>, Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
	<yi.l.liu@intel.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, qianweili
	<qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZDWpXqR9tpSzq/t/@Asurada-Nvidia>
References: <ZCrn8PPPyEJ/VqFU@Asurada-Nvidia>
 <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com>
 <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
 <20230411090740.GC2040385@myrica>
 <ZDVLL6qcTxfIMT5g@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDVLL6qcTxfIMT5g@nvidia.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	DM6NAM11FT115:EE_|DM4PR12MB7743:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 572e06cb-034d-4831-faee-08db3abc1b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G7ze8ItFFhL9YlzqhfEsZ8hZfZoSE0qyIxotVCFXAgjseATDYYTY1UjbwmgufB0gb4/CbMNdNR5I5Qn+MhNhkW96kPfZ6HyNG0ofCH1xtwNMYia4S8mkT96fWxSPYBpFW0oFtOi2xDp/4fRwuljiuj/vuqG67OFXvIf9Kxr6waJe9Va8JWdMLLbeiH9BJTxeyuu2YacQXng3ewLlaRSE0rE348GbGZeJLvOaQ1AZ+/LOM/JnLgOXQ4apDzFqClz0S5huiuuqXFQidnoYe3Eor5yjc9xjxZ74B9vH8rbXZD344djVJPMPilb1o3Quy68rN7x+jxTI3ltc6KfoIEZ8L5gvePwZWOsdZPet1A45AQ0+Z3j0g/0XfHzV+NjVu+i6+Hi/oRdOzh1C+ZvRJO4nOC/iUkSN0MPv2scxY6RCqDWqBbck9Wke6feLxev5wtDvjYk3xtk4IwABtnC7QSyoSmSZI4SF0hXDSxsaMKoD6NMMM7twE4MnMKb3GoXTCm9S6lhgBK/T4YFjI0yHVJQXMy7rNpH0i6wyjpxXtcTC/49jjbWKrqXRWifOZM7+iKDOm1BxifXyDFxO9jvRPJqgtKIsKHgJ7j91Rt5w4qYX68nO7zSZy1sqB/tw7wKIZasOFwuZpzUA8LLaYwqJZQQpCUa6STZf1I8GF+kbMpwJrc2HV2tAWEevRJI54qft4VPUgjZxOqK1sbUuH1kHwJpPaWP2PSlIeoSV4qo+lTBLOJ99PM5oik3Yn5gvOggJist0Lmf7K75Gq4gsbyJowiCMYPBTsbX0NdTW9foVypJFA8EiVLtGVBpwgUGTr0E1sTak
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(86362001)(26005)(316002)(9686003)(186003)(6636002)(54906003)(966005)(2906002)(336012)(5660300002)(33716001)(70586007)(70206006)(7416002)(8676002)(4326008)(6862004)(41300700001)(8936002)(82310400005)(356005)(7636003)(82740400003)(47076005)(40480700001)(55016003)(40460700003)(83380400001)(36860700001)(34070700002)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:39:38.9123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 572e06cb-034d-4831-faee-08db3abc1b5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

On Tue, Apr 11, 2023 at 08:57:35AM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 11, 2023 at 10:07:40AM +0100, Jean-Philippe Brucker wrote:
> > On Sun, Apr 09, 2023 at 06:08:25PM -0700, Nicolin Chen wrote:
> > > On Thu, Apr 06, 2023 at 08:40:04AM -0300, Jason Gunthorpe wrote:
> > > > On Thu, Apr 06, 2023 at 02:23:17PM +0800, Zhangfei Gao wrote:
> > > > 
> > > > > We are using ioctl method now.
> > > > > From the testing, the TLB miss impacts performance a lot, so we use
> > > > > huge page method.
> > > > > After using huge page method, guest can achieve comparable performance
> > > > > with host.
> > > > 
> > > > Looks like these tests are not stressing the MM, just measuring pure
> > > > BW of the DMA, so they don't get into the invalidation regime..
> > > > 
> > > > You need to measure a more real application that is actually using the
> > > > MM (eg alloc/free memory, fork, etc) while it operates and turn on SVA.
> > > 
> > > Would an iommu map/unmap benchmark test be useful here?
> > 
> > You can reuse and improve dma_map_benchmark, already upstream. It supports
> > multi-threads and reports stddev. For some comparisons the report
> > resolution (.1 us) is insufficient and needs to be increased, but for
> > comparing guest performance it might be alright.
> > 
> >  https://lore.kernel.org/linux-iommu/20201102080646.2180-2-song.bao.hua@hisilicon.com/
> 
> I'm not talking about kernel dma_map/unmap, I'm talking about MM
> activities like mmap and munmap that become slower once SVA is enabled

Is it about mmap/munmap() calls or accessing mmap'd memory?

If it's about accessing the memory, the test can cover via the
invalidation pathway. Otherwise, mmap/munmap() are called in
->domain_alloc/free() respectively -- mind elaborating why it
should be concerned?

Thanks
Nic
