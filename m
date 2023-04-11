Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132915A2
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 18:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoBbVCIvWuDp25C6SLrCxINuOfuV80mRH+1J1FFgx8veB5Y1Knwk623vVrT7C+9XVNmixxpFpAPwSXXoSYtnjkTAYF2sAU1zBZj8YdYII4/KQHa7FMwNx2HsnGnesxH6TEF7X+a4fbLGSHaRHNOfUv2Ip9ffbcUexIYXtCLBudBwupg9jBLFC6uvLlpDqvliyv1TrqyerJxv41BNmokFia5KLqFx9iSTP2bGmzZ7jrERD6bbCSTUPhRdRqj9XBThh/N6Xm5XkO/Rv1EACR2xhsUDdFuC48hjl125/Qt9Og0eDt5Ssn60vTHlm86G6TvIOuGKuWkWAdgFeZYZr6WYLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvRdkzJdSsSEP+91MOzJYY2plRyu6bd6nyc0Ol5LgeQ=;
 b=W9+AsVn5r4L0Ei7KsKe+NQftOiN0H5kQjhl+iX3gnWM783rYJLV2PAd9Xf4b0bvdCiCOt2t+9sD+da7mp8XFzI2w22WYUqxY9okmlWB3tVrxSv66aiQeZCoYawCNfujansR98C8PAl+HnLGoW1ulr3hOPcQ6vGG084dfLephLD9EXuQtFsMBYS4+lDRazjlyL33kYwAAyRKfufxoyg5CI5UqF/TsZSF7hgCv/mWA+g7pA0MMyxzMzM7+X4FdQJLZ5w7Gu/La4EaC7IXhYO60cKtdgURcJ15kvogXJd7/NN9rppCM5zipFeGiRM8iQEORTnjL7lKnblQAtfr/+H612w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvRdkzJdSsSEP+91MOzJYY2plRyu6bd6nyc0Ol5LgeQ=;
 b=tVKZu+W/HAggKqWeZwctU/Fcd8HgQ7RtmOKHtSqnhso39ho407pXYvsltfJFS8Kvwi+U70Zo6K7kWIvs7BbHki5f/hSuTxAgJgphqtSazTHHeCm6yH+osCqEAchILw6lvWZjk1eesBMiB0iKK2VMt+1LvRL2OHJdeKmNVyp+kMnA7qDdeSibJREBPUJjo+d6/NfxIkn3vKarhR2hXPHDY0LIwce0rf9LYRj2srIZEnfu6C/gUD9L32zVyM+XloaKLsPpe0Xn4T6EunRH4IG0jXkW2SxxCyvvKVLPTcMRpWl6i/wiVONBunuFthEmufsJJffAsS1OGX9MeYPkK++NDA==
Received: from SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 18:41:11 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 18:41:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 18:41:10 +0000
Date: Tue, 11 Apr 2023 15:41:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>,
	"yi.l.liu@intel.com" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	qianweili <qianweili@huawei.com>
Subject: Re: Cache Invalidation Solution for Nested IOMMU
Message-ID: <ZDWpw894UhnTBm1k@nvidia.com>
References: <ea6fba01-b483-94e6-8c84-d096dcb64b5a@arm.com>
 <ZCtpAYn76u499p6G@Asurada-Nvidia>
 <ZCxOMSvR+6rYbIfy@nvidia.com>
 <a3bbd5422897475d8bcd4c110c3722ec@huawei.com>
 <CABQgh9G_Xa6h7ujRJkCogp02N87OAugBTEuXyccQREw28VfZCQ@mail.gmail.com>
 <ZC6vlI7onlUgBidX@nvidia.com>
 <ZDNhiVZN9zNLGjcj@Asurada-Nvidia>
 <20230411090740.GC2040385@myrica>
 <ZDVLL6qcTxfIMT5g@nvidia.com>
 <ZDWpXqR9tpSzq/t/@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDWpXqR9tpSzq/t/@Asurada-Nvidia>
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|SJ0PR12MB7033:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: a7749cc5-dd26-4822-e2a0-08db3abc519f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s0kLI64H5MP1hCPoSMWyLxGqUiyRcAzyP/eYXxh82g+bJSCoAWhs+f4STPMy2njsuZhEZ/bociY43bA+4x8O4mDH3YwtjSEv1V3n2S/xK5NeXh/tdKraszEMZiU3605rY7VUYVNz2BZW3vMFX30lHuQCA3H4O9YNLAm/LJN86dGuKosa8Dkrcn2+tFP25DhDNp5HS+w3kytwsnYoredt5ffgtCdFwl5rKOT614MoCGkgy15af3oDG/RgvBGg/FMcP31SY+f1LNg0Eod/25+8v55tKVsawRovK4yGcbPpAAj2YP6davpHch11pE3G+lL3h9WaHlMPffSeFUQGQNS796bUOKhSTUIO+T3F68QxAYfmBNHACl9TypnWH3R28PLLBM5L12THqNNvfgdqLigM+5ozPhYnZAbjXrOAAqQ9RGKihBDzEpabCI031/Wrd7mtgz2FajlUnipCGQy6fFV0b9DOM8hiHBoOWGds8w8r9bvsHiG/p3+wYtr5BH5H66zqy5tCGoHymoZn20oFUaS62LgOwUx61Loj6ToSK1pxe7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(451199021)(36756003)(86362001)(41300700001)(316002)(37006003)(6486002)(966005)(6636002)(478600001)(4326008)(66556008)(66946007)(8676002)(54906003)(66476007)(83380400001)(6862004)(5660300002)(7416002)(2906002)(8936002)(38100700002)(186003)(6666004)(6512007)(6506007)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lm9xvHt6UaEYILZ0o9L5JBqlhtJ6lQylTNCY8u2IujwqX4FdYu88tHaWVUxd?=
 =?us-ascii?Q?g1BCDjDTXlE36vySA8RtoViGyE1aDE4cvuLLyC65Z671zB78OVpAIJ9zyjbN?=
 =?us-ascii?Q?yZoSc7IgqP7Kp5opR1kOYhPG7r/nzxJnh9lhV8s0isQTPN5zMTvUTvqVV8Bs?=
 =?us-ascii?Q?GogrKJE6bSZ319yCwH7JohaV7jL32BixLKfO2bhNL43OX52tGPIA/jP3V9uv?=
 =?us-ascii?Q?v6an1wBi7B/l9Crmu9Quwogz3PaiJmsqZ4619tJKMTgp9SpbxccdzzBbkvj9?=
 =?us-ascii?Q?x0XcJTDxHFstczqDMEBifXdWDYzn/auEbsh3VJ5LmdvLqP0cVy2h/qbKZTbY?=
 =?us-ascii?Q?3S9CHa0FHgDWpS1J+tG1UCVm7S271ISdqZsjFG7SNZzB44uAgQsq2It6j+p9?=
 =?us-ascii?Q?4bzn0j+ebsNafTZSAvS36r4lVO7gBkvovM8bXrUZzn108J7/FBIRxfv8s1Rc?=
 =?us-ascii?Q?tmjvs8ZXzmq1NNwM1xrSQGWFww5ipBWQk/WXFacKHxSJH7ovBIVIVyXTLRBi?=
 =?us-ascii?Q?MiKUv87SWgTNqko0N2r4asDffl7AmEO9qbS3xQa96ZIIVLwsM2dGA3199zOT?=
 =?us-ascii?Q?w5qgDLBtW9/PH3wAnq0URVl3mkzNsTSoQh16Tf54NQmIaYlTvFnIUhpSXyjC?=
 =?us-ascii?Q?1/buSxBYVyfe9UQcmHUeklQvQ0B5Fftjo8rer+ux9VfWWXxzmFhLYqar4vKV?=
 =?us-ascii?Q?yZrn3Chhplxy7oDe/ce74BF09yAY6dt1aU2oYONFQ608AcUz0rRvl3M8nb1C?=
 =?us-ascii?Q?rJ9zTn2HwjvRGaDR06hhRMxu84Hk8QCppU/DWJH7joPCHiIj0MQQ+qYefuui?=
 =?us-ascii?Q?n691V5oEJoJGEsPHyPXSctvEkRi83g9NffwGwg6ycVy2CH/U9YpJlpG25xVa?=
 =?us-ascii?Q?5up58l8oakyliMQ19W2/92L0hDqKLkPMQGpN6194+hb9M7rDj4L4wfTAnOzx?=
 =?us-ascii?Q?HepqAbLIMXR89DecpQgcmmY/V2TFMKXqzxpre8gi08qf9LY1jh5EfEB9Y9Qt?=
 =?us-ascii?Q?VATgb0g7NVtNESClUCwZ24ayqSOcP+nRmIkcm33nRkIizUI9jd32ivLmS4UW?=
 =?us-ascii?Q?HDd7Yye65kcn4QLUBC2nWCurdSZKjWJONDw9OygaRnLMX279LCfA9AGEkSTM?=
 =?us-ascii?Q?qNJWM0pNFkYtSm1q7rZaw3TH9qdy0hwp8VcmSe6aw+SKkML7mru/SEyfIkDT?=
 =?us-ascii?Q?JPi/3VHInW4b05PttrrQFnOM9PHFkRd0kvof10k9rYg1kfnkX06qEYn9dzUw?=
 =?us-ascii?Q?PovWTqS87hXZJKx8ayfQsaRY1N7JVP0wmlGpRQU+aGfyJDnlfc3EruDWaXYX?=
 =?us-ascii?Q?yJj0ruVO9mubrshEopHisaAAdXvbD2Vti7LosUf5Sp2ijPbVa64DgnGAlNdU?=
 =?us-ascii?Q?2Tz3yQs2DqtkDX6QM6nDIiUpETOU7H3vOkAg890jon/frJKIYPfL2AHwN3uB?=
 =?us-ascii?Q?ezvWAoy6uvyshPiqs3uyUp5LUDnL8SjLc9UC5Qka4mevw3Q9ybuMQJnE/fV/?=
 =?us-ascii?Q?M+Q96GaQ86C3L0RImtnknNmbh3J4WtMnLqoJzmI/a0mZ7hBre975RXwAm2Zj?=
 =?us-ascii?Q?nBpoKmo+PXKmumwoM5+RuwLGGsft/54HmfL9nX4o?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7749cc5-dd26-4822-e2a0-08db3abc519f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:41:10.2069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laLrexWlr3TWPYK9HF95RS2asUrQ1fN368kn7SR7i7fpeiDyWcg67R7tf8qElQRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337

On Tue, Apr 11, 2023 at 11:39:26AM -0700, Nicolin Chen wrote:
> On Tue, Apr 11, 2023 at 08:57:35AM -0300, Jason Gunthorpe wrote:
> > On Tue, Apr 11, 2023 at 10:07:40AM +0100, Jean-Philippe Brucker wrote:
> > > On Sun, Apr 09, 2023 at 06:08:25PM -0700, Nicolin Chen wrote:
> > > > On Thu, Apr 06, 2023 at 08:40:04AM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Apr 06, 2023 at 02:23:17PM +0800, Zhangfei Gao wrote:
> > > > > 
> > > > > > We are using ioctl method now.
> > > > > > From the testing, the TLB miss impacts performance a lot, so we use
> > > > > > huge page method.
> > > > > > After using huge page method, guest can achieve comparable performance
> > > > > > with host.
> > > > > 
> > > > > Looks like these tests are not stressing the MM, just measuring pure
> > > > > BW of the DMA, so they don't get into the invalidation regime..
> > > > > 
> > > > > You need to measure a more real application that is actually using the
> > > > > MM (eg alloc/free memory, fork, etc) while it operates and turn on SVA.
> > > > 
> > > > Would an iommu map/unmap benchmark test be useful here?
> > > 
> > > You can reuse and improve dma_map_benchmark, already upstream. It supports
> > > multi-threads and reports stddev. For some comparisons the report
> > > resolution (.1 us) is insufficient and needs to be increased, but for
> > > comparing guest performance it might be alright.
> > > 
> > >  https://lore.kernel.org/linux-iommu/20201102080646.2180-2-song.bao.hua@hisilicon.com/
> > 
> > I'm not talking about kernel dma_map/unmap, I'm talking about MM
> > activities like mmap and munmap that become slower once SVA is enabled
> 
> Is it about mmap/munmap() calls or accessing mmap'd memory?

I mean literally userspace mmap() calls to change the mm_struct.

Jason
