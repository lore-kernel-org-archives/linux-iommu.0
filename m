Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0739E3C0C
	for <iommu@lists.linux.dev>; Fri, 31 Mar 2023 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680274605; x=1711810605;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6VMmI4hvV1wuN9/2Rum/q3y+nehfVSD8fX6Y2ba4XlE=;
  b=Hni1eLlWTJv8271yw2ZtiZ4dBjMGFmr/e6DONjrkeg8CRl8rXEph+3Ye
   nNOLzOi0FWKtgtprg44OboOjiAXOGs5cB6fgCOyoRDVYEaQv97fSn4858
   ZIPCAlRpNjA6OWZx5uKsyIl+RSBHcBEGVNTnTAIJOswyHNSQmll8GM0if
   poZsAnKsxHweX5ouueq4pfQhYm+3ANOcSTrSED4GoRyvUCROpXH5SmKWT
   VdC/fZ2b7SFUzGwW1vRUnBzzBehr4T8/45FX8BWnAB9IuvZMOX+gsEVsy
   n4uNkjUOQAb5b1hZEIm59h5V0paIZUzVcV7KKCPMrizlu/tR4HulhyBKV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="321123099"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="321123099"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 07:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="774383999"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="774383999"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2023 07:56:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 07:56:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 31 Mar 2023 07:56:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 31 Mar 2023 07:56:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHogziFNQE1nIZe1G5rWUDP4s+bkGs2ueS2FU9DMprOJtZ3jJM/CjQchLrflHrkaYmC6D27DeybfBX8dQFO6Kc6KLDOJ8RYZiM5PzBBvf21jUjBiVHzPjT19x+7iIYzetxOzygubTLfjEqmBOWLs6/n6lrmH+KrIkz85DjDKUlMInQimPJN3igCEyVEMY4EsDjidD40Q2lAiuHJuzZhGGAoad3qkIyvhxhfMwACLJAaIIq+uLAeUWNlNKQY0UJkVWrYYzZ7oJEV3cpkNQTeNFfS4HfsE2sErw+KUdXnuFV2tIyN4AwWnD4adeQkALnZYtzEdrDt0eyBfasdQ2Vi9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OI31ujsPN4ddPpHBGz93NuANX6KXt8mp5wcB1xNHrtY=;
 b=K6bW5dd8tNA2WXD0QWELtekTbnhRH5C8S4Td91YLXGIdImiVw+fnzZW/A1bGEaU5D8ZaPvY08MD9FXqz85yOIgi17rtO1hb6fLoJmRGi3e6j5+QzCY4x0ILE8e5Ap1inrHBrIlIbuBlWpDlfmlaPoXRlg/PxWzavNrLn5o2rXY5uMYhom0DpQqIS8s/0U9PMJ/BeZWXgZPWQbMfIIMb7vLG2A1pZqShxjCyQ1rtPHySTmReunEvzCnfJhzxsKNsti0RO6B7ZHBXNXxCnv84PklCj2DZ9W0dZPC091qq2xGkloLEhy2ib2xiFoIFRBN3DaKm3LbwlxnX0ap1pXKlpXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Fri, 31 Mar
 2023 14:56:25 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::60e0:f0a8:dd17:88ab%6]) with mapi id 15.20.6254.022; Fri, 31 Mar 2023
 14:56:25 +0000
Date: Fri, 31 Mar 2023 22:57:54 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<heng.su@intel.com>, <ying.huang@intel.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is "try_grab_folio" WARNING in
 v6.3-rc2 kernel
Message-ID: <ZCb08lL4ISmEmanj@xpf.sh.intel.com>
References: <ZBExkEW/On0ue68q@xpf.sh.intel.com>
 <ZCbRCvQrzU8jdLlk@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCbRCvQrzU8jdLlk@nvidia.com>
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW6PR11MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: c7088c41-b701-4fe2-2719-08db31f8196d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bxJK8IUgbdunmT+jbhj8WqG8Dv1iTggkBDnoGkxBGrk4w81CwXzQT6CWqPFmqmGxNRkVf/2UguWo2bSqA3EdnP65J1sOjp4ZcL+qViOBlQR79K0HwpLxrH0MPL6WtuKxt27Ruinlzx9pCnJz3xpBjzRD6b/pkowiJKNInuUC7rwQcKgd/CRWQ+2giZkKFI9BJaljT2iHpZhjTextGDXMFeD0Z5Yxm2uSFluxn6Jpv9Z+IdGee4WsvjeDw8ALYf/5BIWk6D5zlzjCt1v7ASwbhtmr6A12rnbpp+kFTOFG7by3zU9k7u9LBVQSiTQQg0fy+/yARwl5onX/7YQUNDVNvpQXQlUO/3pi1KpmT9cQzfEmqwngDec+2fGDEanLHIcGFSUVUu1d3lo1Lz6uTn/79g1rxGEf9ivnKOplpnGOr7I/dWQtoz3WpCdJMttIhPLASQuxORikOoCsiG1FEadgzUT63CEjcReFOkz+d0suuD0dkENR2+a8ArmaPfw61WauLaNpduJMxosKsBdVxmVBdUQJrd4sbUuEa5ZBkNKgiJcyeix30xjuiDEsZw8lyvqtHKbXUyTI7B5TuKXScYN32E9Y0yrIhONk1jU55utXdWHAjqIaU61lEnOcpB77v2E5OYiplQhIu0e3T2dSo/G2vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(83380400001)(186003)(107886003)(966005)(6486002)(6512007)(53546011)(6666004)(86362001)(316002)(478600001)(6506007)(26005)(6916009)(66556008)(41300700001)(4326008)(82960400001)(66946007)(66476007)(8676002)(8936002)(44832011)(2906002)(38100700002)(5660300002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nmL1YPp5rm2boGifs+A5bKvPLJ+gs76IwmwVbxOFZXRF3noKbv1UF7EVZuYV?=
 =?us-ascii?Q?H7oeJBySk32f//vxt7VJkch1baxuPmwBuozb714ZhRhmrYufvE7MPAi/tH9K?=
 =?us-ascii?Q?oN9syzY8t2/9qWMurMfF+m7UWEp3gwRZAYDNfNzhJOqu6uAYfww9Ihx9RWkT?=
 =?us-ascii?Q?U9Ys2kqltD10i7/MmnFdQD8YlRbcBp239ogjYHwK3PzrFV1Ed5mn07t2XdjB?=
 =?us-ascii?Q?/hJ+OtQzDesOUEOvZDF2NQOzfJMmLSpy7jZ92RlEg4sljAC/0vTNtzuZLdtX?=
 =?us-ascii?Q?tygrm+xH/f5WA9S0UWd2k2w3pVZeHIB2//YzlK+vuE9THn4PO1o0xQ3TqgTS?=
 =?us-ascii?Q?nV+bFwhI6GGqLdOIbnjrd5ioEz1KNSVkkZMwpQ+Tj5LiBdQtLDz55oHyVok3?=
 =?us-ascii?Q?YUjempSvSjMXUx8s+2dJng91TNV1lWhgKbvNaAanMpN/QfA/iT6hJ+zzX5B3?=
 =?us-ascii?Q?1X76MYBLwsP0PXvfuD2Xe1+rjTQ8DyD0qcYRRTBLMv3EP4KmfssOGfmLzdyq?=
 =?us-ascii?Q?lSibkdN1PLtl3VMz9cBa1BMzSwRYilRnbPWuiv4mW37wcwTSP1jwtQU8gRqL?=
 =?us-ascii?Q?ryedu9CTeG0GpMjJbk4Pfu7Wii0BZQL9GdGOhKE9CdLICag0GScjYr7L9r6u?=
 =?us-ascii?Q?gUiol6spifAA1Uv+jIFYHYXK15SmsSRJRHRGt7tBV2R6qiz/yhbl0ADqevTZ?=
 =?us-ascii?Q?QDhc5mtTh5mCovzaSymMuD3NVSXYmizlFWxOslmQKBaliao6+CLM1cuIppVu?=
 =?us-ascii?Q?VREmWeoANp/wb20hKL6dHggPU+2EAV2u5YKGO933qKYH957dpnTZx8nuwhyY?=
 =?us-ascii?Q?75fRBK28F+qV398lpepGO/8DSjyXwoVNfdpSobqTMvO++ezDZ4ZlSIUFehp9?=
 =?us-ascii?Q?krCKQOTQLDE3Ruw6A4zGq3i+WndLLM1Xn8anoMRql2KAsOA477MNIVRrFveE?=
 =?us-ascii?Q?04mK5mUcSiHK5XfcOLUgJvQg/9uRlY2FloFBjPCROfTgLvTxjC9ry3RUy3Lh?=
 =?us-ascii?Q?1idR5b9GVn+rtmKsBtIwM9S9WxTswK2T/kTYeWkNiNLfZKMDy1Z8TKSux0h4?=
 =?us-ascii?Q?kuJvROYi+HTXdGGGsYeGVA5FjymYEW2csDF0q1JnjwSlRv6wkleurHU1tIHY?=
 =?us-ascii?Q?bMYkf095TCL/HBCiPINgco0AKAVirBYNsySQNWSmWojVntLdN8JZGQwDdbcY?=
 =?us-ascii?Q?7F9bcp6xQM7TMa3g9O8aRzWMF6Z5ZX0LooW067hTEW70E6EGQBTsHHZuzrBR?=
 =?us-ascii?Q?LnO9FAzN49z12eniKVQhedrLtFIlcHFKQz8w2LaDxgyZBn5PT9x454vv6Gfp?=
 =?us-ascii?Q?dXeyrMDfZT6rAVRbsfv9qulO/Lb+kpbkXfvNA0zqHs0Bdd8/8EAYH+qOAVvH?=
 =?us-ascii?Q?Db5d7iiXQupWr57ZX1lthuo9AgNKwwemRRBW+VkcUn/3ij68748j4mxLH9We?=
 =?us-ascii?Q?u3azz6G/KU0mSBmopnOs72gydwe9b1hYaRkeXTUPcUDo3fWBvBUiB/Hkz/5N?=
 =?us-ascii?Q?3dBXvwwedcg1m3rKyxIRs/Xxih0e3dV0u3NhchlizRYV5mdWt+WQLugP10yd?=
 =?us-ascii?Q?A66l6RXVkeYeDPtVzVoFDRw+U8JhcRV4R8XQsE5m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7088c41-b701-4fe2-2719-08db31f8196d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 14:56:25.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6efYIXor/Whr1kd18AF/fT8w/dzABTm0FsPhfm/Ta/wEnqKxojl78wxM6iANfQv5h6QOgSJympcYGHGFp/SGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com

Hi Jason,

On 2023-03-31 at 09:24:42 -0300, Jason Gunthorpe wrote:
> On Wed, Mar 15, 2023 at 10:46:40AM +0800, Pengfei Xu wrote:
> > Hi Jason and kernel experts,
> > 
> > Greeting!
> > 
> > Platform: x86 platforms
> > There is "try_grab_folio" WARNING in v6.3-rc2 kernel:
> > 
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/230313_234302_try_grab_folio
> > Reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/repro.c
> > v6.3-rc2 issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/eeac8ede17557680855031c6f305ece2378af326_dmesg.log
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/bisect_info.log
> > Kconfig: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/kconfig_origin
> 
> Do you have a syzkaller format reproducer for this? It is often
> informative.
> 
  Thanks for your suggestion! I will add the repro.prog for new report.
  Updated repro.prog in link: https://github.com/xupengfe/syzkaller_logs/blob/main/230313_234302_try_grab_folio/repro.prog
  I also new added machineInfo0, log0, report0, repro.report, repro.stats in
  link: https://github.com/xupengfe/syzkaller_logs/tree/main/230313_234302_try_grab_folio

> > If you don't need the following environment to reproduce the problem or if you
> > already have one, please ignore the following information.
> > 
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >    // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >    // You could change the bzImage_xxx as you want
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> 
> These instructions did not result in a reproduction for me :(
> 
> Nor did the reproduction work in my usual test VM.
> 
> It must be timing sensitive?
> 
> The trace says it is touching a page with a corrupted refcount, which
> suggests a double free, but it is weird that it would trigger here and
> not at the point of the double free...
> 
> I don't have a guess what this is
> 
  Ah, seems to be related to platform independence, I can reproduce this
  problem on RPL-P platform vm in almost 3 seconds after executing bianry.

  And I could reproduce this issue on ADL-S vm in 3 seconds also, seems it
  could be reproduced on ATOM and big cores platforms.

  Thanks!
  BR.
> Jason
