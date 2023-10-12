Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2977527EE7;
	Thu, 12 Oct 2023 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pWfYEmox"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAmRDM4FZ3zIBW9jAbI06KeIDl7hxSVieG/WWbRGuSo7EILdQvldJX5QIvSVtviulvcbTUhZjGsSBMxbh6R7UCE9ONz5lykKpY+wK1boHOPqnIMW02+G6yWR7nd+K+RhRdibL+cXLcZAhhbQ1q5+5Q8f6TonvYEH2LfqCBkQAK7IE+fue07/hjHr1fQX3gv4TouZrmUUwXiZmWJL7JB+usfKh1IaYWfdtzFO0k1igvfX2pKaPAYnBWG85uNwKwb2xwbGx6Xz86xtMVNbwjVs2YfREYu8hMtDBGnmuGICZLpGlNhbeO9f+uCIBDztNBgiug5UiI0BLSk2C7+fozzlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOoifrypWLSz3iB9dqrps0iT16ePgzoxoAOXeToVO/s=;
 b=m/oe94IZhyajcOe2kSWQtrNGd8qyheQSwc2Le4CasADIOGTU5MGXL+B11B0wRFzVklD+gOI9j3CHo6XRBqJBV/7PtAjI/qBjaueZVsGmm+W0NzMZh1rYMuOPKaRAjPOU16ZKyusxQFb2MSxQ+lXNEvHiEhL0shiLGjJBWLWQc7gVV2Jf8lqhtgpG8p4XbwvJuYOnRgfgJn4Dwi3bCczdRcHova1Fh7dkHrKUGe5mO5MpkbvhXOovkXKZqKy+m/SMxBUYzkjwtTBCfYGC1vdb9EUKHImjlxPMOHXLtiZtWS3rvbggUlpWMYeqZx3DksD0T68X+kML4BQxtphGwawB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOoifrypWLSz3iB9dqrps0iT16ePgzoxoAOXeToVO/s=;
 b=pWfYEmoxqtn4jxPQSax9AD1AmI4Iwf+07MD7mZeqjPhSn1u51RH/jEBSDlqaH2Qn7kj0lQsat94+sgTtT0moVlTUsmBOXO7Dw7GmMkZ8ne5vYwPj2aShSQBeP/TG3YDhM+0fAKq+LXrA80088RMBgQuyboxnQZF83fAb9D2KPBUw/ORs1jlCvHXinSX1F9pIF+xvEvAX+WeSDN6SRTrO/fBX2UYopu8dJdaXZnp51cOTQHqu8XEI56TDSvvfrgYULhzvVCKvmWFH15Ng48M2b3+Lkq0z9fEJkgY1ytfktkFPlwsTc7O+FBxHVW5beqZtmX4purUFcf7JSm4DmC63xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 13:21:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Thu, 12 Oct 2023
 13:21:44 +0000
Date: Thu, 12 Oct 2023 10:21:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, Joerg Roedel <jroedel@suse.de>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [joro-iommu:x86/amd 16/19] drivers/iommu/amd/iommu.c:829:21:
 warning: variable 'entry' set but not used
Message-ID: <20231012132144.GJ3952@nvidia.com>
References: <202310071103.BYatoc0b-lkp@intel.com>
 <f8163afc-858e-7830-d6dc-79c6b60d7c2d@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8163afc-858e-7830-d6dc-79c6b60d7c2d@amd.com>
X-ClientProxiedBy: MN2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4b1fe7-ca57-4192-6567-08dbcb262e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3eaVAerXNTomEKBoD28HapyftXuUmPX2s11WUmGENbAi5zgGN9VoCL2uE3bXqdLIUP6vs6hQhEwZlvTVzPW0ML7ljNypGCJ5MoeNYM02is/YAZFMDIiKhQOqZ0H1FCiZOuEax3d3bWVRDfSaTJTwDyvTCJxgP992j1P6zEn+AM+VtOmZdNzJKju9+Wvn4qtV1ypStybw07MUQ7q9si2xmaD02VUEbGCLd/5t4+IdmpmUatThnwrDU1dcusqrEGSIVRzaOvjP4z/10ocVv1Si9X0Xy58UWWWDHnR/GEzU2CvTfqcexaOmsJalDdInSpn6G4V6JbOHQ3zXKUZLvH6p0hqMnYCOZUfwUIlFQW7GYM7OluD/5370FVkkUHZI5D1VsMdb0+aTjEYy9bv8VENMqpMQb3Da7ZI4WOTRIU7+5TobS+oLYGGE2YqymAVwjjheHrhv2Ly8lBjk2aBSd87NFWi41xIkw31C5BmpNEysUEIvnm3kWjSre6670blZ1e/JULlwrkWuCrxEPU3TFuligHnFIJdy1Y5d+Lafo4TsxqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6512007)(53546011)(2616005)(1076003)(6506007)(478600001)(966005)(6486002)(26005)(2906002)(83380400001)(41300700001)(5660300002)(66556008)(66476007)(54906003)(66946007)(4326008)(8676002)(8936002)(6916009)(316002)(38100700002)(36756003)(86362001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Eg6OA5xGrtX6YQNl5mE3hn3IGfhNuYM7rZ/zwGIEP/j9T7sd9MrdiLpleLij?=
 =?us-ascii?Q?iCFyyp6e0oUo6zH2UkC668+BbKhad2lkZYx9A6vn5WBu8HfX2c08eRuIEmDS?=
 =?us-ascii?Q?au7yVDK1iK6TgDvvzXH9z6dxQBJ0XDHXB+Qou6P+nDr0jFZEkOAhnkuRO45v?=
 =?us-ascii?Q?oRmP1G8ussMIgfhG07HimPpHslt6OAl8TDLHr6YJFdm/EGzADd0fKtr47BrG?=
 =?us-ascii?Q?pndyKMqowq+QVWC4M0HV43rpH5Lwr9YkP9FZq44YWkr1Ya4+QAl3L95a+PZy?=
 =?us-ascii?Q?deUcb430A5P4gPV0nbRmXFbHGqY0Po60VAama6e938TRrPYkff2AuoZQI2pK?=
 =?us-ascii?Q?ADe7Ld3IAWp5TNuifD3feu1rNcZQ5OEF7by80dVhYOW8KibIfQqPXp6j5Nli?=
 =?us-ascii?Q?+w9RZRp5FrwWiT42QbZURWAV1IiNOEn2SJPfMCGv658u4VZdJvT5dusWHSMV?=
 =?us-ascii?Q?4/L12Fkk3JBuGYJatpb/b2iS40ZWP+31KWrToRSgWL6ZfFYU6wL8F/V4CA8w?=
 =?us-ascii?Q?p22oIZIU3Yr/woD5XvYwb2qBmpmWNmFzo2nHTBADelfFacCC8oWKZ4Y26K1/?=
 =?us-ascii?Q?xhBKGqL12dZ8SK3lsmuJ8QmlIilmqxBC5xTV07oMkAgRk7IlvwN5Qh6Nt3LW?=
 =?us-ascii?Q?W2PyoU6RyOWjZmWIgGGnFdkNIYFXfLO/dVHjBDDecm70+JTVcI2l+KElZkT2?=
 =?us-ascii?Q?qEz/+s0JkTPhqxwaJFoTYd8egXIkRM5CMpLuky9++RJjTJ1ssJroPSouP+zd?=
 =?us-ascii?Q?iZlPOA97qh+ZaADOhyN9zf97MTveFZAGrEnuphM2vx3z+wtdCKY5J9fqQZFV?=
 =?us-ascii?Q?ZtyPUwQF+YIpoxRuQDmzJ9t62dYZIaFOt18p3Qt44ETPrkWnpOVF13MIVvEm?=
 =?us-ascii?Q?eTQNbsapBsYBlZG67qNJXOtuhs3ueG9U+q1own0GC+mxi9Zpy9K6sIb2fjZk?=
 =?us-ascii?Q?7ZR6qxK8KxPJJdqxQorPDgrHB54CQDcOSrIFmcEXSfzpliYR4s4Qmnu7Bb2b?=
 =?us-ascii?Q?/mYxJHprAOeFyRA7MxO6bcHfF/K6Ne6jdhW7/eZUqS1hv6w8w7lkZXJebHtq?=
 =?us-ascii?Q?1uDfdI29FvFTo3PDDx8UvoHUpn/Ut+izOtXbusmVkaeLZO8wfaa2a1Npu0u9?=
 =?us-ascii?Q?WEWUCmV/z+F7d/uimG1DEKfWEnux9qy7DD4m34rDWs8vwP+v4MCnDiuqcz4o?=
 =?us-ascii?Q?hX7Q9Q/W+JCmtErlt1COGaV0vDDhiyqTMhIh9GrdA9onnUcuuuAiYuwVBW9E?=
 =?us-ascii?Q?RAN5f/k+v29YwjRYFTqGa2FpBAwexwMycm9GbYoKFWbpFUq5VTpuwLgtNRbZ?=
 =?us-ascii?Q?R2jjtB8yE95d88SJgWr4BcSBxwDoKtDFj3sSMAKSmU1hbiCG1+GIbVPLNQ9K?=
 =?us-ascii?Q?aYlNRX5wdA9FI2so8hDeRqnUwulwPpzEX1qdwmag1EH04Pc161H4XN9912vJ?=
 =?us-ascii?Q?hafc7qEfrLl86dw96zUng+OdBcEYB6z/oVZ+zLfv8aS+mWL+Eqz/njDVarWo?=
 =?us-ascii?Q?QmqE+7PDDcjC+6VlVM1BaY8jbRltaxGUxSSCqPBuugqY/lCtYCS9Bckk2TgH?=
 =?us-ascii?Q?6i68tnIJE9rhHwgyKjk7pbvoRXkFB0ZFzAcTaAdB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4b1fe7-ca57-4192-6567-08dbcb262e2a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 13:21:44.8201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKQbavbjcdUo1NwWiYtG884FPza3o1y6ppEBzzmRzkF9jjlq6/0B/9IKJcT7p/Y3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6395

On Thu, Oct 12, 2023 at 10:56:27AM +0530, Vasant Hegde wrote:
> Hi,
> 
> 
> On 10/7/2023 8:50 AM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git x86/amd
> > head:   189116d5ad54eee2bab82c5f12e837912fc0b4c4
> > commit: d55b0d2e075ad32d560cdd35a2016973fda52ed6 [16/19] iommu/amd: Remove PPR support
> > config: x86_64-randconfig-003-20231007 (https://download.01.org/0day-ci/archive/20231007/202310071103.BYatoc0b-lkp@intel.com/config)
> > compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310071103.BYatoc0b-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310071103.BYatoc0b-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/iommu/amd/iommu.c: In function 'iommu_poll_ppr_log':
> >>> drivers/iommu/amd/iommu.c:829:21: warning: variable 'entry' set but not used [-Wunused-but-set-variable]
> >      829 |                 u64 entry[2];
> >          |                     ^~~~~
> 
> 
> Commit d55b0d2e075 (iommu/next branch), removed PPR support. Hence this become
> unused variable. But soon we will be adding PPR support for SVA [1]. Hence I
> just added comment and left it as is (instead of removing and adding it back again).

You should remove it, best practice is that every commit compiles
without warnings. People build with -Werror so this will create a
problem

Jason
