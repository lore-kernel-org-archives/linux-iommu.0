Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685235B5B5
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190775; cv=fail; b=FmcRCxVYWp5IioeoyvZGP1HTnbNWh7EqsmgJENIM3W5DtEiIIJATOVB6Dx+GORp3qnAoqf4LmC8yeI/+xvcn/BI9+eVGnEc0d+rKSkoOk+hn7WrK1ya+UIWw89AwnrwVp4dZaabTjUkYQF7xNXqURPVXKqMN9IxK1ReD4vwY6E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190775; c=relaxed/simple;
	bh=Hhas44RZdNI7DBDLlZvbWP8IrsUbeQpu3BNPSn/kqhE=;
	h=Message-ID:Date:To:CC:From:Subject:Content-Type:MIME-Version; b=q8EDwGPdQLS3hOxicGISwxUGnDuvDCqgAa31mtnbb84FVuWREpuM01j3HNWSmTXrYwDsmFhBrVyUmfOcRYei0yzCuj43bnqRDgsQX+VptqTzQB40dZaLsfyO9TLmfmaWWZusoo5ITt0bEF81KgfHtKtCa8OThJ+8pNwjpWLib5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahsw7fFM; arc=fail smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahsw7fFM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706190771; x=1737726771;
  h=message-id:date:to:cc:from:subject:
   content-transfer-encoding:mime-version;
  bh=Hhas44RZdNI7DBDLlZvbWP8IrsUbeQpu3BNPSn/kqhE=;
  b=ahsw7fFM5VNniYZgcX1vdC4yjDiIE0l1+1JwDeHR5k7lwPITdiaHt1OW
   t3IqDG5c5R4f/+/NBB3yw2ypLFOQFj0nTYiBJ3QwuKxB7ivVEas2o+O+i
   5tVOD09u6s53ock56lA0WFmjGiWtIugPTKWLHVxXj1OahAblIMugOb/+u
   09Ckm+1ICYDc2XGFK/irqP+7y08ruX0wJ8MueO0Jto7EyaAYQEHj2QpdY
   b/Mv9rsomCc188LkESeXqtQHrfg8oskkHtzwCmbUxQ1AemwVIBLbc4VF4
   5/WRHKJoIL8CxogfB+SEgMoPZ7JucDtNMVEZX8PAxVjhkZI/dhe3wB9fI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466447332"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466447332"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:52:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="21061151"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 05:52:50 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 05:52:49 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 05:52:49 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 05:52:49 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 05:52:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFyPyXJShTWazJroCXUU0ra3g4tx3y+M8b2jjHGuxjbBBqcBqJrIejeAT+6jQCf2tOpwCVEhu/WuTDHq3IcyngTedM9jWtLFuBNbppTh2NUHT+nbAKwXE4Oh6NicQhSWcx2V+80cizncob67x+3BrrVPy8L8yHuIBkky7KBIJtnWBS0Ol3aQ0FSvsfmf/Vs+jQq04MuUMIQ2h+Z9sCQDu/Gt2o7R61d52GPZUdfFA++XN5TeZwkJ52fDWAR1i/mOZ7GeulbGo6FJFWSOjnxoH92sUkrpHaKfwkrdu4KbLtls1OfOLiYoZDfh7Jp2pbfVDXoHsO0ek+9tvUE7xNiswg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kla7bBhKO+wDALBEVpJlb8n0F8fyiHsFiAJkNEVIb2U=;
 b=EEe0Dmh4InBA9ULyWXlPH82CdVurLpwhKYKSL4cDb86/wX5QPZ2ayO2w/0AjWR+heo+8rQK7XaPlkKIjqfJh2Zf6CLWIwL5ZX024eBQ0RKI2XDoap+DjRpZt4sXgQEcvMTFCy02GyZOeYn+aHpPEtjzP8OREXYgadYJPu6nxoUBwllTfULwKmzdXKGOmBlLvoQHGMJHZsesNmsykhl3Az8nzUV3F+fPSOE+YQn6iYTzQfxONBuDt5r8e7gMuJWm1jrGdADJ4XJAMo5y8jCGth3pusLU5NCseWumAD+gWYNVHV1b3wzty0BMiyloCbGk4d4fHiG9TGfxhSEd9oJe4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB8177.namprd11.prod.outlook.com (2603:10b6:8:17e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Thu, 25 Jan
 2024 13:52:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 13:52:42 +0000
Message-ID: <92f8aaca-093d-4161-b8f2-5ab1680df769@intel.com>
Date: Thu, 25 Jan 2024 21:55:46 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
From: Yi Liu <yi.l.liu@intel.com>
Subject: About unmap pages and set dirty tracking on nested parent domain
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da45dc2-276b-4793-ac1d-08dc1dace69d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jeUJuYYXCtYdQVXaJGNcV/EBlEAtlJypq2ZqhI1F7PosfBLF6eZ2qP0T+k/xYCegZHTkuyMfv0NUH6kMBL9JBRVwKQDEvrwgyq4QfzXP7mqz/1WMJl7SIOlP4ugaRewV/eRg6t2EQAJ0mK+MC4kI5npjwW4vCzzRP5ZTFZGrnfcG2qYi+iD2Frefq73FmPJF9RsdFr+tFk2RSr9CZD5km1vMQX+pAr6kjMCJiKMyUl0tvfKXZo/rzm5Dzq6bCtq5k8Ach1lN0LWXtHBWmfbnJt9GxWIcWtYW3iDSKfFH8egnIYe08K9kk8QZ+VJjnUQgmG2B5G/MO6nAlbhpeBms5s67r3aWPTYsx4W6PvH1w7A4k4fPYoDZK40Vnn4QqKpgww1Nqt+Gg+e3ZnSEjARZlw90IpMLRTsjma5eNHmRKFn73UL1+cj1s6jLSilYS4E2qDj56Ffh6w21PbVA1G5Joe7cxd/nirAQSWlEyCbRov1T9kTpZcy8oDtE8Y8ssLuSyOdsFcz2ieR8v5ePKVwJutcg+XHyc56FDMG1ufJxrEuCCCIQGYT10v+Hj7cha0/Y6g3WGfWSRT4G8+bKfej4vt1Z5EeuGHRVguNuu/b4lWGIG+BtyaHs4KBALs84W1Jum4A7GVCTKheBU+nz4ZKHIH6IljP/MNH9yci7FhKrPto=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(110136005)(316002)(66476007)(66556008)(31686004)(478600001)(2616005)(6636002)(54906003)(66946007)(5660300002)(6512007)(26005)(6486002)(6506007)(8936002)(8676002)(83380400001)(2906002)(36756003)(38100700002)(82960400001)(41300700001)(86362001)(31696002)(4326008)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW1KQ2puR1pmMnltSlh1VzhDSHczRFdXd2sxSU8vNU0zMU5LSzdrTDB3Mmpx?=
 =?utf-8?B?dEZ6elpuUk44TXVsakRXTTZkRzBiWEN2ZlRrTEN3Y3ZybmFlMDIyeEhoUytS?=
 =?utf-8?B?dldkNHZFRHpaS09hbTl1ZEU3VHNoV2hQT0hUWkhJMjRJemhBaDZubEhpemht?=
 =?utf-8?B?bVJvOFdMM3dBa0d3VFl4M3VMbm1SNjBRcFlsMVVISENpQnErV0VWdUszY0xZ?=
 =?utf-8?B?ZTJidW1NeGtsNFdzRFVnVGtYaHB2N1Y3alIvazV5SUExWXZpZG14TnpJUjE5?=
 =?utf-8?B?WDR4eUdFQWJCVEhuRnMzRTFSK09XWjB6ZGhsTTIrUElZcHN2dTkrWW41NGcx?=
 =?utf-8?B?VlhuRmN5bmd5d2FrWTY1ZG1Kem55a0M2NTRxeVFGbWFKa1pZektaczBtdDBT?=
 =?utf-8?B?QkUxVjZwaFRhT3pLUnVVQlVCa1VPMFRabXp1YndXaHhaSmVyem1ZZGxuTXh6?=
 =?utf-8?B?VUFheGltTUUrNEFSbk81YStnei9MaHgyaFdMNHhuVzRjVnV2ZHhxSGZIR0w2?=
 =?utf-8?B?aGlKLzRCM3NNNkZJOEFRNWtscDNENTdFZnEyMVgwRnZHV2ZzQjkvRHQ5Zzkw?=
 =?utf-8?B?MXVUMkFoK3FFMUQvckUxUFdTbXBYZ0haRC9KZ1dxelFOajJoZkZOaUpmSlBi?=
 =?utf-8?B?WFBpcU5sZFg0bWwvU295ajN4SUhOZVBoMHRnU1l4Ri83VVIzYVZQd3dyQ0VS?=
 =?utf-8?B?WS9UR3lqQWMvWUdCY1kzUGJVODVQVk84UUdxTHF5bitBSWNmaVRGL3BiYStM?=
 =?utf-8?B?U2pSVEF1MXJHQmNhdXRHQTBoOThRNFJzbzJDbkxpMzBPQU5STzFsMGxVd045?=
 =?utf-8?B?YWU2VmwxMVo2cUVHRkhteWtqL2dwY0NVNG1sYUxyZVdta2pmRkJhRUwyM2ha?=
 =?utf-8?B?VVpXTHlSTWVpYTc4WEZiVXFmaW1MWjA0ZE04a05SOGR5bzNVR0t5bzA5aXlQ?=
 =?utf-8?B?QVRGdlY2OGdlVStiNWo0Ni9XeEtIUWEyVTBzemU3WERiWCtRUW5reUtZYlkv?=
 =?utf-8?B?aDZuUXhEd1gxNVRBY2RLVkhEVU5UeWpHWkErcUg1cCt4aUVTUDRZUitCYWkx?=
 =?utf-8?B?RUVaZmFMcXJIdHN1d29tbzE4Q0g4dStOTkEyWGFYRXFnbzNuQmZ1SzJUd21Y?=
 =?utf-8?B?RGlJZUZFamhWUU5XTHV1S3lmRzB1QXB6Mm9sSnd5eVpWcnZpK3BxQVV5cmsw?=
 =?utf-8?B?WDRlUkw4TmJ6Wm9qTWRPaklRN1gvQWlBYXJUOFRzZzhoZ1J6MTRwN09MOXNq?=
 =?utf-8?B?Z3ZpVkkza3lnbUhaYjF5ZmlvYXlXSzhkWVRFaUE1RjBuUFhFdmdkbW5PTmVQ?=
 =?utf-8?B?MU80b2tRRFMzejFQelJjVVFPcTJud0l4bkJSbXNpZ0dHTWxNalpRNXdKWER6?=
 =?utf-8?B?UWlZL3c3QUxaNlQwS2pFbHBNL3dZcFZJa1RjZy84dndtZ1ltdjRlZHhZa2dY?=
 =?utf-8?B?Qll3a0VpKy9Fa01JNUFybXBBS3owanN4N0lhMlM3QnFZMC9GaWtxRWJQbHUw?=
 =?utf-8?B?N2hRenRuZEhZWkEvUmZ4Y09DWnY0dURkQThtUWtxZWVyS2Z2Zldoa0tBTnZC?=
 =?utf-8?B?L0QzRVpzbC95eVRkWjFBUngrZjJyWUptN1J3WTBvL0RJbDNzSkt0VUw1TWV4?=
 =?utf-8?B?eGNsYUVkRDhxcVdCOU0zTEVwS3BYYW8rYSt1a1lHVlJHZEFDMjFQOWNRdW5w?=
 =?utf-8?B?UzhnVENrUlgycUVYM0RwZ044ZENMMnhYQ0xhNk1Eb081N2cxTWtLNTNGWkxT?=
 =?utf-8?B?S25UYzN3RThBWEpMSzFraDh0MnlnbzkvVlgrL3pBQTdnS0ZKeHlhMWEvbFNC?=
 =?utf-8?B?UDNzNFZFd05JVndDeUZxL2ZpNStpNTRCSkpKVStDNEFpUURPdGt0K0x0SDhS?=
 =?utf-8?B?amgySmZabENNVVZiWjhnQlBNWUhFQ0ovVTVRdXphdVlDa1gxTHZPTmc4QkE2?=
 =?utf-8?B?VzA3U25uYVNoOUE1VVVKQnRHRWdocnVGYkh6TTVxM1ZBM1hNTVdWVUI1ZTE1?=
 =?utf-8?B?VmNkbjJ3MnQ1KzE4OFNPb2tnalVwNnpNOGhvdFVTMEZqQlVkTkZMZ2UwVXA0?=
 =?utf-8?B?cGVZS1VLcFpHOHNSQ0hQdC9mMUUxMlpTM29RYXFZcEVCdEJpbXFKVlM0b2hU?=
 =?utf-8?Q?37n9z9/7+43g3Gdw6lOqkPKBy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da45dc2-276b-4793-ac1d-08dc1dace69d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 13:52:42.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/AkDwrsvITT/DqnrG6eycOCVeFDC17KfUhciYeXAFSz7WBobvvCTQSQXifTf/ZgoShwEcz7IkgMCrMW8oAjzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8177
X-OriginatorOrg: intel.com

Hi Jason, Kevin,

Today, Intel iommu driver only tracks attached devices/iommus in the nested
domain. While the nested parent domain does not. This makes cache flush on
nested parent domain be a nop if it's only used as parent. It is an issue
if there is unmap on nested parent domain. Also, the dirty page tracking
would not take effect as well for such a nested parent domain. I plan to
fix this gap by tracking stage-1 domains in the nested parent domain within
intel iommu driver. So that iommu driver can loop the nested domains and
the devices attached on it to flush caches. However, I'd like to check with
you first before taking action.

1) Do we want to allow unmap pages on nested parent domain? Today there is
    no PRQ support on the nested parent domain (stage-2). That's why both
    VFIO and IOMMUFD pins the page in the DMA_MAP. As a result, VMMs like
    Qemu cannot not unamp pages in nested parent domain after VM is running.
    Otherwise, there will be DMA translation faults. However, there is no
    architecture limitation to support PRQ for stage-2. If PRQ is supported,
    there may be unmap on nested parent.
2) If answer of 1) is yes. Should the owner of stage-1 be notified about
    the unmap event on its nested parent, hence owner is able to flush the
    corresponding stage-1 cache explicitly? For VT-d, no such requirement as
    intel iommu driver can flush the related stage-1 cache as well when
    flushing the stage-2 cache in nested translation mode. Not sure about
    other vendors.
3) Is it enough to fix this gap within iommu driver? or need to be handled
    in the generic layer? e.g. let the iommufd layer to track stage-1 hwpts
    in stage-2 hwpt. In this way, iommufd can flush stage-1 cache when
    unmapping pages on stage-2.


Regards,
Yi Liu
