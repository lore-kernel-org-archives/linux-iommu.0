Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589C5EA4
	for <iommu@lists.linux.dev>; Sun, 25 Jun 2023 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687685310; x=1719221310;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=d82rZrmAXho3aSHW2zJEXiYU/GaUL2tLUhHzZJfey7o=;
  b=gjI3mL82GBf9YNZAzJga6ZUFXl+PhdNzZSsm6Jz+CVJ3+U30s7d+cy8l
   sdG9UityYmqOm4zJfcvL+dRo/kRNwNRqfXMFhBAnC+5xmE6VW0PBqzMfU
   cVOs2rxX+MD4Q5A3cmptyIrN+zApOQ+CayMIg9/ttwq1gTPjC6R9+ww/J
   RBKZAMCAVf9rzA4qavQnVhYNjLHVLlJ+y5gU/1DhkuKJ5iFEiH/qK1z5y
   T76LLmXQ7/oRxlnWfLLrh5RLTdPfegoQ59gsc8QDm5yLPy+FKasMu+6Bp
   K+vWd61xcZ9wzp0hG75VhhGFcAZ+QXT1CR+3MvHk20gvq+pXKACnNJ8r1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="364493618"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="364493618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 02:28:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="745455979"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="745455979"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 25 Jun 2023 02:28:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 25 Jun 2023 02:28:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 25 Jun 2023 02:28:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 25 Jun 2023 02:28:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NifUwWydj3VPwToCg+jtVjKuQhIf+hoe/iDBvhNjhhzXntbuu34yme4EaD6fT5UYj7XpuSCPq/IwRp6hD6pkddF77EQ2TAF9W0Nla41asdE4edvqdZ027mEa9rOSolN3LY7dMY+6pFRA5Hd1HkQkwzink1828HHsbliNpr0sewTKmitALwlNvanLx8Z5N/jXCYvwmEsSGICVD1bbwQkt5OjNPw/GcJo78FIwHmdvo0HsCAhr4Ko5PMSPs+X4UCsVfTRLsjWndSEdLE63hZxFizrnE8WPa+j7aMxUFejInd2P+TN6aEcQxpZ8fkcd2wfLRka9JC2GIKtamwa5ER7XHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+iMzl4MFeeIG9UqP6TLPz2o30is715GAkAWni08js8=;
 b=VxOzXjPbCoVbUgotATvEMNFKCJ7iXBncFioFtwNDzxVZsT2BIe/wOlfGy75N20JK1gBt9cnOaBSZcpoQsuXtcrubSCTNn3iH7569UdDSoSW6wypI2Ys9Q2lh2WRoBkyqV+vQ5u3TMnihWze8Kj4fj3s0oQRc2Xx9i2jDSY2ixGVFAHHKyie10SvM2ekh4nCwdL1v0m644EnTRUlZbQX4IoeGCEx3iPcMPJBvGQZqyBau0u8wSHQDa1ibBGW0LWlH7Chamm/x0sv1JhBU5ZAEdwl+RGBkAhDd+tQ5bD238uuUXzc2HGRD8T9B/GzgWVoE/8ugn6ZTezJbNWwmMsB5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MN0PR11MB6158.namprd11.prod.outlook.com (2603:10b6:208:3ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 09:28:21 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34ea:3910:8a1a:6a8e]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::34ea:3910:8a1a:6a8e%4]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 09:28:21 +0000
Date: Sun, 25 Jun 2023 17:30:32 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <heng.su@intel.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING in iopt_remove_access in
 upstream patch "iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS
 coverage"
Message-ID: <ZJgJOClwU+d78rji@xpf.sh.intel.com>
References: <ZIp2DZQp/xLMarGi@xpf.sh.intel.com>
 <ZJYYWz2wy/86FapK@Asurada-Nvidia>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJYYWz2wy/86FapK@Asurada-Nvidia>
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MN0PR11MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 6079b9f7-c8dd-40d9-cad3-08db755e8439
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+Ri89kS5CpOC+Be380IjLqFEDLTP6u8Eh9KmYV4meJOJTf0/RSJnXwBP06TR7SgkukT1hZmfa7eTab58ZkJOoIrSwEFyHMzPbmmaB6mUlYODPr4YENH/rWLm7E+i8fL+JuXFQxt5BOjMHOtp/fGH9Og9R4+FA+e0EA2TkuCTkWjZ0BwUn3PTHVR/DpgBlgaP0pyZNwJnMFzj7rhPg6c0DUqDHIqibcAvotdATAodmPRJV27NhHsp8jxIpe5RUVErdTFz77/AKerSoAISLAGxc3q/NsDzXP9hjU5hBEsvg03zPtRrVZ4g+O141BVqSfxgxQWmui+y4elQUGVKrOEmjibC/1Wpapvj7Kq367a09mQrar33uXZT+BxFpUxyoY7U8BFV6ganDTq27mmsP+HoISD8mr1IGmkc4GLWstMxY25OBkj/8+VOVfztbMdKSd+6/dQs7d6KZhs+0CFadtEpwbqFlbEC+auJEy+kIEqLNIRIlgipqHkMpSXltqIDLReOSJJ+En7ko9ZqdNSZpHbNDVejti5I0NxXdzEXL9TgLiZceqZ1oSnRScypmgJQ9ojrzOGcFptZkEwyeB1Y39HYUUIJ4AxtJ6iyZ4cFVjLOrI/ypmdYNkMUK9jTDkmVlgVx24vQTX518hdDNaVpGCMLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(186003)(26005)(2906002)(6666004)(82960400001)(8676002)(6916009)(316002)(478600001)(966005)(6486002)(86362001)(4326008)(107886003)(38100700002)(41300700001)(44832011)(5660300002)(8936002)(66556008)(83380400001)(66946007)(66476007)(6512007)(53546011)(6506007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hCJChi+lgyObfpnbEA+nhjiEliRxrM5kI1LauYmCFE4BLCV2H2VFRnBmOx6y?=
 =?us-ascii?Q?NzPz7evtzZMCv0CZNGvQ5ISwBaN+6p+qWRIwvOtGCUGiumehkousfUCYJ24C?=
 =?us-ascii?Q?PfAkRX6ux4gNJt3QsqO02Zxh5V0OrSK3Fl63J4ODcKKlhgGKG+H/kSNFm3Yw?=
 =?us-ascii?Q?jtDRLnLVQyC/t8jXDuNuh09cqat4Q0eaBSOYMtxk0sra5nGedqJdDaDgsWfe?=
 =?us-ascii?Q?4SiH0hdbd+WS+PVyAe+hZO9nHF0uOo/wEBN/jimHPV5HI3HWOMpFZchz1N9T?=
 =?us-ascii?Q?O3PsfJgkm8qZchjyZNmxGofazP1iIGQZ/toFlFBXWJ7mtq1W1mKPuypkshyh?=
 =?us-ascii?Q?OUYKsHkSlnW+IQcaxTPGBpCr+KiTgJ67cvdoCJ3KSXCiYuMyqCFAg79BDdiX?=
 =?us-ascii?Q?SWFXlUED4yWIiXE0tMdX/T0Jz5gWgKA3CTriwvKkn71E3innpJrAI5p8aeeg?=
 =?us-ascii?Q?eK76ijoT+mZBn2fGKQV2/LFQQdoZ4tU3MqnpfqO6qjwIzA+i8+IPd+2SAZ8k?=
 =?us-ascii?Q?1EOWAvEpvQJRFmPP9nM7RAHHaarejsEy8oDxIM1AiFBGt/0gudES4bIsfLH1?=
 =?us-ascii?Q?0BvkQwOEW6PMRAcMq2xC0ozwn/PgRyA+uTHjESgj6wvlNfx8fLWLXGLJDM9+?=
 =?us-ascii?Q?tqJII3ApNKD8v1cGAILn1fRX7fbLhkpNVc6Y2Rp3DuthyANdP+72dXy002ku?=
 =?us-ascii?Q?7iGlhyvEkaQrm0IzuwE/XWXdB6MgaPnCBYKU6KoEvPEbLw5nk5Srm0AI+92Y?=
 =?us-ascii?Q?EuKwLBWcjjqJeoKvNxy6I0X+dUTSNLmBC/Z8A5PX9ntic95GJGOBZECOqxGQ?=
 =?us-ascii?Q?1BELBOPK3OWpLZ4KQqpIqSqlwYqK+H7rM+h0YkSt2iUPyebpB+rZoSOTjYkz?=
 =?us-ascii?Q?/sojACQsp2lcL4LQ0hHsWYny9ya+F4mRY3JkRyjAbuDCu/5IcEUSbSA9jW5P?=
 =?us-ascii?Q?lpoOjpyqBVJjEBNWmoK7JeWXSarUlZcihxV9i2ZJh+9rsqo5+J1wnadEyZzv?=
 =?us-ascii?Q?GzCvFXCeXssue1NEJIcpMZFrnaZ+LkdXqspQ2SW2pglFPkwGAzXmFO1uJj3t?=
 =?us-ascii?Q?nyeV9fxLWJ6lTrjfRYmETRL4kLaj58Q5JGGlDDNhYJobM6YBpV+LFCoOOcg5?=
 =?us-ascii?Q?G9Mx8pYkqxEzzNFR30wmfrqyQ8IzyZiRVWkF8R1vHEQnnK4fgUwTjQApAZjP?=
 =?us-ascii?Q?HAv8s0vRtEjHnIAsl6ibpTwjcl8eG0fATb4LQsefeUbPMxPhsI6HMvxPjJBg?=
 =?us-ascii?Q?6rvtoASGurvnhdt82mBq9AeIz2ywXcMDgEnn9TNsHFBQI1kJKL2bgh5erRAd?=
 =?us-ascii?Q?eC3gsOuw35goSOCAvfDy0U4IyOY39mMdDRBHz8jdSgwuX/eD+l90gfokrBp3?=
 =?us-ascii?Q?6m0jcrdPhunppZ6S1ZIXwEZgdggWXZf1tXKpoYKgBguEzsQCIE7zxmSQuYlI?=
 =?us-ascii?Q?+nYQyaJrFbW6M6NdLxvzIyktr1gxFWHi+fJ4WcwabHbiAcLUHHMI3VMDFyNd?=
 =?us-ascii?Q?7rlQDXMwSN4xkQEK5txmoEzOizVpLERrNSm8t3pgPW0J4TN70vNBlo5qWmUz?=
 =?us-ascii?Q?VJE1veVvdxR26k87vUCqbm+ULMIQ7BhVSTyRNKsi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6079b9f7-c8dd-40d9-cad3-08db755e8439
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 09:28:21.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DDdtrGX/tAbjnYzU9GoIrqIOft5+4QTC62qVyAzWww3/MBQ5F4FYGI9V8yDppn2yy1Qq2DaZGl5UeGcEodgCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6158
X-OriginatorOrg: intel.com

Hi Nicolin,

On 2023-06-23 at 15:10:35 -0700, Nicolin Chen wrote:
> Hi Pengfei,
> 
> On Thu, Jun 15, 2023 at 10:23:09AM +0800, Pengfei Xu wrote:
> 
> > Hi Nicolin,
> > 
> > Greeting!
> > 
> > There is WARNING in iopt_remove_access in related patch:
> > https://lore.kernel.org/lkml/e93964b04d5b0f45344931fcae0e8696dd649988.1683593831.git.nicolinc@nvidia.com/#t
> > 
> > I tested Intel internal kernel and syzkaller found this issue by accident,
> > I checked that internal commit:"e93964b04d5b iommufd/selftest: Add
> > IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage" was same as above link patch.
> > 
> > It seems that syzkaller accidentally filled the syscall mutating parameter
> > during a long fuzzing time and discovered this issue:
> > " *(uint32_t*)0x20000004 = 0xb; // IOMMU_TEST_OP_ACCESS_REPLACE_IOAS=0xb"
> > https://github.com/xupengfe/syzkaller_logs/blob/210a8d4069655735cc2bc2756981a944857a734c/230614_070652_iopt_remove_access/repro.c#LL187C3-L187C32
> > 
> > All analysis and detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230614_070652_iopt_remove_access
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/repro.c
> > Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/repro.prog
> > Kconfig: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230614_070652_iopt_remove_access/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/bisect_info.log
> > Reproduced bzimage: https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/bzImage_e93964b04d5b0f45344931fcae0e8696dd649988.xz
> > e93964b04d5b reproduced dmesg: https://raw.githubusercontent.com/xupengfe/syzkaller_logs/main/230614_070652_iopt_remove_access/e93964b04d5b0f45344931fcae0e8696dd64998_dmesg.log
> > 
> > I hope it's helpful.
> 
> Thanks for the report!
> 
> It turns out to be a bug in the new iommufd_access_change_pt()
> that does iopt_add_access() prior to __iommufd_access_detach().
> However, iopt_add_access() overrides access->iopt_access_list_id
> being read by the following __iommufd_access_detach(). Thus, it
> triggers the WARNING.

Thanks a lot for your analysis and fixed patch!
I have installed your below patch on top of previous reproduced kernel.
And ran the reproduced binary in previous VM more than 1 hour, this issue
could not be reproduced, result show that it's fixed.
The bzImage with below patch is in link:
https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/bzImage_fix.gz

Thanks!
Best Regards,
Pengfei

> 
> A fix could be like this (will integrate in the next version)
> -------------------------------------------------------------------------------
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index a106f7c655d6..98fab19b92b9 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -796,6 +796,7 @@ EXPORT_SYMBOL_NS_GPL(iommufd_access_detach, IOMMUFD);
> 
>  static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
>  {
> +       struct iommufd_ioas *cur_ioas = access->ioas;
>         struct iommufd_ioas *new_ioas;
>         int rc;
> 
> @@ -805,15 +806,20 @@ static int iommufd_access_change_pt(struct iommufd_access *access, u32 ioas_id)
>         if (IS_ERR(new_ioas))
>                 return PTR_ERR(new_ioas);
> 
> +       if (cur_ioas)
> +               __iommufd_access_detach(access);
> +
>         rc = iopt_add_access(&new_ioas->iopt, access);
>         if (rc) {
>                 iommufd_put_object(&new_ioas->obj);
> +               if (cur_ioas) {
> +                       WARN_ON(iommufd_access_change_pt(access,
> +                                                        cur_ioas->obj.id));
> +               }
>                 return rc;
>         }
>         iommufd_ref_to_users(&new_ioas->obj);
> 
> -       if (access->ioas)
> -               __iommufd_access_detach(access);
>         access->ioas = new_ioas;
>         access->ioas_unpin = new_ioas;
>         return 0;
> -------------------------------------------------------------------------------
> 
> Thanks
> Nicolin
