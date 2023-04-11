Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4982F29
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 11:57:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lbuH/TfICtJwoZjhC59APaQF2NwN3EnoeCgd0M87v8Uw8z32zCVm4HhpiOwG/7K81mk2dYC5AVecUPD63bnVpa4uJbRGFA6t5LwOkw77zrdI/zKZWKmXkl0wc7MJnXvAPnyvaY9qgSkcFy+/TPSQN7e2CVF8a688MOegl7oZM1EFAkyIBLoKFLR01WszOiNoU4OwKmlaaAFL1816SY83AG0IUN+2puSpcP+WTlEi7/PSIrdQRDlEmr7H4GA8B48aewOJpkVxFIqT7K8tC0BddKlYncVR2FiUkWzksKdE0IBYuIqeWxEt7frncUpVYBVVg49CoUmzNlWGvj4IzIuvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+7SSPR2VAkQ9ZPmLeXgn1DyMvpPUyT7SUwgI5pi3ZQ=;
 b=V3zTFoCvAC+slWEv08C1KmvE/3gT655EWhpI7DuEzMXtjZ+/Opx3kuwoxtULkTz60At5arwJdhcCfQSKiRBzTlL1WoME8ZtrTWWu7LAUkRgtRE9vHGrZFg6JOUy4ZhBQGJRmRzqQ+S+FK/AO1RCgs89LbWrMcfO2OOo13GeusyMw3KKzI7HkCZGW/8ap8pBKprGata6sQ/yy/fLk2+EE837Qz6tbUPGFYri2jc+s6C0BmGwLi0WYiSqmnFabkGgKVGKe5n5UqJwPySmesAKoCv/8nxlHDBpzyrpukKGEh+iFfPox0hEmsc6atSN8QrU4xAMDZ0iWI8kLcdLe+LziQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+7SSPR2VAkQ9ZPmLeXgn1DyMvpPUyT7SUwgI5pi3ZQ=;
 b=GHSvEquj8/4xeaTWuzcHW38qdnvMBFSxa9FifZ6IAPWwJW0BnHmoV9Xi6Yfd4SiGcTGmArWSbTUF1ES3kIdzwm7mebwHuB2R75edD/jkRq60IlJJ04goXHj4s4RormnMgyh8rR7e1dw1yb/n3oW4aqpPhSfhxnAerQsiTeeVv5S2jo0rqKogGELzRGN64RO1Lj/JTNgy904YZ/Mcq6ci/9lchMUwRzwvv1b0HhEqmWAfNeaYedluyxipWp+98Z/iUMxQH7kgNdzQXI5obbNl+o7eX7XWXTuF9IbpjfLfSOR8yGcoP5+TTkBHyVSycMbpNMo2G20HYkQ9XkJJVo65VA==
Received: from DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Tue, 11 Apr
 2023 11:57:42 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4926.namprd12.prod.outlook.com (2603:10b6:5:1bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Tue, 11 Apr
 2023 11:57:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 11:57:38 +0000
Date: Tue, 11 Apr 2023 08:57:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
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
Message-ID: <ZDVLL6qcTxfIMT5g@nvidia.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411090740.GC2040385@myrica>
X-ClientProxiedBy: CH0PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:610:118::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	LV2PR12MB5869:EE_|DM6PR12MB4926:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ef10d6-f804-431e-623b-08db3a83f217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iY0Hw9q/MxPr2thTIM6lv8lFgrhZlSR1VvNITp9/lDMQDDQ9CzoTZybgadWC1PZ5PInMHPnBxZ1QmVpHU4ZdQ+pkcosgbFobOg86whNWj7F7ApWea1LgXH14NgRW8Jsl9lBr2q2R0hd16Xy+1E6cRyqkr3aTZEntdqjSfa/v9T4AbATuJQiiusND4AVKXnS0cMjaD8elYHu8pv2Fdn1OYJJQwh0g8U6AztSkrLUA5DhXwwsKrrwnkfjf2bxzvBeOc0bPWgg04iOPJnRqH/ICAwhbsBQmStKRwmEPr27Zx1OJBY9+HzbSkV3WQOBVbNv8v+vuw1Zw8dmYCw4nQg9JbOnPvQ/IJ9Z6IBid6oMh5KoOYwePRSSNf9ZuRmyQiFLsbmVhzczbsH78npW3/c0M8AesyAlgHztXgnYzxQcngfyCxT+NBRHusjbGdbNsaAghz1Zcp6rbvMx8IjkR9F7CBCTtdBIYi9Xc6RxzhkGbZCo1MXwkRbd/vsjHtVrWsv+8QaAibywRyLAtUkWV6OfN4yNWF4EfmAzj5F0dWo2MK+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4926.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(8936002)(6666004)(7416002)(6486002)(966005)(5660300002)(6916009)(86362001)(4326008)(8676002)(66556008)(66476007)(66946007)(478600001)(38100700002)(316002)(54906003)(2906002)(6506007)(6512007)(186003)(2616005)(41300700001)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iYEGYdbKg5HYn8zJEAaNZX/jpLYIaz9nL8PIjnQ+BbVPMFIPh1CKbDY9IyVZ?=
 =?us-ascii?Q?DWXwUbZxKouMv2ofrbFjul65qC/90O19rmhlcsnafztHl0p5jRsTbwXCAuWj?=
 =?us-ascii?Q?cJiM85YoegJUyVzXXPfpoPXXAKYLq5XbKs8O9Sh5l2ZWKxUwDyjfXCPKkepp?=
 =?us-ascii?Q?AHzr8+Nn1MGw7wniPBWXsaFX/C5EAvs8g6J93B124Do9abAeoPU4duITwLMg?=
 =?us-ascii?Q?6yNDdBTorojgKiTOaEv6x9POijatTSB0YZY4GYEVRYjfkrEyd6DrfOTzAbl2?=
 =?us-ascii?Q?npE3NTC1e3KWUaopxnpkTz12vDh0cjCDj0w7MV/lTdfYqhSczjceEg37H798?=
 =?us-ascii?Q?TtZAvzwBUh/PZ/bLquqk2wuMIGPbPBv4r2MhYJKHWp0BSz2WsjRW8luq046e?=
 =?us-ascii?Q?GXo0k26OpeZ9yiUt/6rKpz3pBuKhG+wVyjMlbVMOxWWeDwWK31TxFi5fdA7D?=
 =?us-ascii?Q?yCd1r++dTt8ngyx0pWlsuXpk4OVQ3HYBkN5l9zLrjTesNtg839La/fG2/ut0?=
 =?us-ascii?Q?ErlbLFPQHRuheWUf+i0/khtBj+UJd6kpNEhzTLl8jSq+vSTlLmygxlEo+E1o?=
 =?us-ascii?Q?n6tEyEnxoIuwShYBdb4SSL5WoVV4SKMWaN3ffxu5qw0D0jSL5aWVwunPHLtm?=
 =?us-ascii?Q?spXYcuHxNd4muktXk7bH0j8VVNS7ZnYLa/PQOT1AsgGdqtMPJS7n/YhJYVL4?=
 =?us-ascii?Q?eps0FSzw99OBh5ijGJbkOwggwH6tLt0+inHoIbRA+mlrEGB9rUZvujDRNFuc?=
 =?us-ascii?Q?kRpScfDXXYFhLScWyE82307YhEhtaoTDmQen2XezqxWkuysjBb1f6VktO/DU?=
 =?us-ascii?Q?79H62pzfmuAEFLGYhlEBK2YXaL/gMKgHwwwwB+hOOXS1y0rPCJdYMEgHtOBy?=
 =?us-ascii?Q?mWjbJ2TgwK6/SPTZgHet5C6OR2vPj+rTqI3Sh/0DZsfdAUh3uU9+RagxEYWA?=
 =?us-ascii?Q?fy8hpoutR3B7LBTht8FjjCLKZL9CG4MLSI3GMLHUlHVekjs6KS+/C+WyHTbR?=
 =?us-ascii?Q?oTmZQ57eTkQDpsSk2K4d+eDiAjP+ZeAkLlBYVRORSNyj3PXPNSRfy3Q48nYn?=
 =?us-ascii?Q?nnqm0WveF2rE/oihqmHxmPFtD15oPZnT2UTBFPxpFYtkwcMHnt7sSvSiVwWm?=
 =?us-ascii?Q?31Rpa7E9YWZ02gOigkQM3Un+iYOQZFEU7n006qoYJcLy8yAeE1hlWJgPjygj?=
 =?us-ascii?Q?dNxHmEGeJyWi3S/0ZnC5+C0Oyc7wBDm/RXlh3Qn6q2InJaVMQdJxGjc88GNW?=
 =?us-ascii?Q?/cvubywzcJa4TO7uxCq0SzHATuHop2rlgYnB/e9532Gk1BDoWcs5f+qyQDUf?=
 =?us-ascii?Q?u8yiQZ3rtR1gTdRqFcQ/BJh7XSAFRFHtIqfA810N9W9wvScIX01hljpMgj3k?=
 =?us-ascii?Q?CsY8a8Xpjs0YTCzORKLSo8Cip63kZdDqF3HrS2ACLiUsNFt9krM06VHT/YPb?=
 =?us-ascii?Q?5qPf7FH1Gz3EN+qCrQBurDJz5CqagEyI8i8rw2141sF778fSxLzsLBYaVY/s?=
 =?us-ascii?Q?97G/2KsxuVLGvLftVPmZ3BGqKKWrSmuSIeNZ7mkInF6Qep5ifDRUG4ZzVeI8?=
 =?us-ascii?Q?fbh9tq45S4FJqF2QUpzJNnkhLvmZ/qobKBxXNX79?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ef10d6-f804-431e-623b-08db3a83f217
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 11:57:38.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxjVhRF+wopBWRxKOsVcJbyfkq8ytTeocqZwCxhhOeIwRPZ+XtjZITIlZHxK0Qkx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325

On Tue, Apr 11, 2023 at 10:07:40AM +0100, Jean-Philippe Brucker wrote:
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
> 
> https://lore.kernel.org/linux-iommu/20201102080646.2180-2-song.bao.hua@hisilicon.com/

I'm not talking about kernel dma_map/unmap, I'm talking about MM
activities like mmap and munmap that become slower once SVA is enabled

Jason
