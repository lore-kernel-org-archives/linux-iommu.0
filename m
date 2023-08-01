Received: from mgamail.intel.com (unknown [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBA19BBC
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 08:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690877306; x=1722413306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q1oU9OOG7i1ioNKUbhQdLup4UWyNlh69N03f5lG8wko=;
  b=PQViqvj15mRo1QaglCQPk3BlHKuSA9oT+6KarVQrh2OBRlBf3aPWkn7K
   mRhgKKl26/fsDl8m5MqKfnl9iMYVpaQupAcfYo5O6mlRk6LiusGJiNBIJ
   8MusP3MWaZ3CgcTSc1nfaIqtLeU1++HepyRVwwSjeQ2kN0r9QYnVjyjzv
   lW3zDxckEnjWTA33TkDs1FLraEy/tsO80Epth2nd+SHi9sRPTaUueqt2Q
   z4dXacebPPaxJ4D3uV3ux8P/LVAlhMpWDA5L/Vd5aMfPBay1XUHr8WTgH
   cHjQQ3xij9GFAxxtJMM5OODiIxv+Ua2X/iizpiY1NvFAzQzcia8RqwpAF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="455607961"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="455607961"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 01:08:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="758255484"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="758255484"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 01 Aug 2023 01:08:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 01:08:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 01:08:02 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 01:08:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noACVuFW0nlEeukW80d7gg5JvOrHx1vCORIq6Om+b+loUudJTtlm7MKmfqtgrRnN/Vgab+MUoRumVbsOLCkyVc391zfX1B+uVt+h7o3aalbqY8DadgR0KG2DG40mR0pGzxNBq1Q19QmTDuXoFVhO7Vj4XhHzl/+RrzcqNZAKgryCmVPdgDd4vCeb4q5hwI0TS5H4Ge2CraxZ9oqdyGorcooqqSLtieAojPt+AI/uh+EOCQFL1zHkHsaJbSe7YBo1WMAYU9NoX6bbiB9pzB3HlzcYvtbQ3zPbWn/BiCrt51hcFIcsE73Xflh15AtDLdrWsl2/WSgCWvjfCPdZ6lSB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1SUH5W9yJWgJVU/bcai+py3yfeKrmGFuxxZ52rYeeA=;
 b=DwWhmi/SXsFSXPYtLNE+tyKPU1CNakcq91dVHOEGtT6eFe5SyConpM7BoFN+k2BDn74ryibbN6QQGiOLdHBGx9VxaocQ9bVZnIK5nzL+1gQu8r2qIBSCeiV+17WNxYJqcbQKu9FQmKrjp7mq8VEHsaSu/8qg3ddMoWh+ju6JcV7u/sA972W0ydf7ow7/tIu+FxFNslusxLWTNsFueScKnq76fk+4LQcXN1XK4T3dYXBWmebLn3A5bP5f8HXP3psb431sp5YEOsy1bE9KMR1gPbtDQHkx1YXPQ+iua3e3kkjbmzxq48dBZQzw75wTCEC9vRD7dHifoRTLoUOLeEFcAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH8PR11MB6904.namprd11.prod.outlook.com (2603:10b6:510:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 08:08:00 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7189:7f8c:5b00:edf8]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7189:7f8c:5b00:edf8%5]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 08:08:00 +0000
Message-ID: <1254d61b-1f4e-2ef3-c3dc-95180f26f08c@intel.com>
Date: Tue, 1 Aug 2023 16:07:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] iommu: Move pasid array from group to device
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Nicolin Chen <nicolinc@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
	<iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20230801063125.34995-1-baolu.lu@linux.intel.com>
 <20230801063125.34995-3-baolu.lu@linux.intel.com>
Content-Language: en-US
From: tina.zhang <tina.zhang@intel.com>
In-Reply-To: <20230801063125.34995-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|PH8PR11MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd62af3-9583-4e57-182f-08db92666bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFeSw89IKT2RyrejOPL7/wp10qX06Hxz5fY5dRhyQ58TxqAHv26BVNOy3EljyMy3izL68A+YUMuZD+UtAb6W2d+XU9LB+aqMuWeSi22Qu0jDdg2m4yBtbvEADla50+80AsLkDA/v7jphSKP3pZJxzEVJ1bVhSbdHoBKo+3DKbNWGh670pwKXIuABiykxq1N/WxsWXcd0cHm6/UajFnLOI6ySaRigvio81JrumbhLiDQn0u6hkvztvfrB3hH/LMBGOQIb0kRZa2JmmCxoz+ZNpzpGxLvKny1T3uihWRIEDjIEfRAG+iwY169mejA3F6fZizxo7KesL4EDEg4jhSDaNgWQv/25IXWVwIt5C8/iMzDKR7dbiXBPbwLoiuX1EDGvqTAC5USIginbavgs8kSy2hL3LhoYmEd5p23I/DOfRppqkz2qylsHM1Ngs4SrvFBw4QW6KtrqaHVmJpRUIm7Ir0ze248Rn5StgAY0uv+C9o1Rxe5kwYS19xeu6yx0OgGo8X8brli4njKxpqK9HumaLD+XcjA6gjn7ffKchu10UEnYWtaTkioOgo6lCyvmnK6zY9JH24dog70IyywBWTeijyVJWpJXxDlKL9V9Vz7VeHfRK9BCgOs5OZbMZEODbOWKL12ONsXUwpvaNclKSWsU7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(36756003)(478600001)(38100700002)(82960400001)(31696002)(86362001)(6512007)(6486002)(6666004)(7416002)(2616005)(53546011)(186003)(26005)(8676002)(8936002)(6506007)(31686004)(5660300002)(4326008)(2906002)(66556008)(66946007)(66476007)(41300700001)(54906003)(110136005)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhaWCtENFMwbzBBL05CeFhkajVjZ3FibXJnUXJkV3FBakdnZ00wVEZPVE5l?=
 =?utf-8?B?TERGdnNweTJ3ZWltVjRRNWcrY2g4S1RBN0tqQndoajVuM010bGdHOGJ5djlU?=
 =?utf-8?B?UjZTOHo1Z2Y5ZnY4TzcyaSt4Z0JiUDJxTkRMQXI3UUZhdGR3S0I4U0dYR0Y2?=
 =?utf-8?B?UUtWSFdTOVJZY1lDTkpBUy92V3RKYVE2SkhqZWkxdGFDajhwZk02Z2s2MDh5?=
 =?utf-8?B?UGw4b1JZbnArMzVEbEJkaUQzVmNLYXN2ckM1NFViUWVMTmpRL1A4MGgrdm10?=
 =?utf-8?B?eGFyMkdPWitwaDFoeG5NUDRiamF2eVBzeHlITU1sRlI3SjVIdDB4R0p0RUth?=
 =?utf-8?B?TWdNWm5ibk1QVlJmMldVVlA0b1RtUG53WTVIZ0NORCt6eWhuZ0NWY1A5RkRX?=
 =?utf-8?B?TXhoclN3SXJRS3ZtYnpuc3QwbGdFRFo3b3FVL05EZ0F4Q1BlSzJSZVJVMEJF?=
 =?utf-8?B?V2JTRDAvOFpyNnkwbWZrQVpseWpBeTQxWXJIWHBCNENXMTdXRlRnNVRUME5M?=
 =?utf-8?B?R1Q0MXZUOXR3V3pHUU1ZQzBiZ1lkYXh5Umc1WDJCbG1mOTlpaVdDU2NFd1lz?=
 =?utf-8?B?VXZrVnhGM1c4eUhBZ1FNTUhpcWRacTlUL0NhVUd6N3FWQ2dUOFpWMDRBZldV?=
 =?utf-8?B?YkZGTHZ3L1luVmxVQllBdUd0aDFDczhaMGp6YytxUXZyUlVTZk5tdlBTZytp?=
 =?utf-8?B?YS9oNU5XNUhWSnhGV1RPMkliTEgzS3U0YjBYdWlZOUhianAxb2dYMVE3T3Qr?=
 =?utf-8?B?UmRMZU1wclhRMjBKcTNJL0M0SjJxSzhLTXc2Q1lvbXFLY0krbDNzN3BkWDhD?=
 =?utf-8?B?ZXRyTGI5VWNBYk50N2dXRjd1eXEvUUI1Vi9keUlGeU10NHpkSk5kdGFBYnBk?=
 =?utf-8?B?MzdBZzZBQXV0VFNsQzVzMEZNaTRVMjR3Lzh2QTVTblM0b0luc3laLzlxZ1dV?=
 =?utf-8?B?SVFYOEtrNTZJNWZ2TWZjNms3VmVqcDdUOFBTLzhpa00xVTdEQkFyVDJEN3JP?=
 =?utf-8?B?clJYWlJCaDNMVXNnNGF3emFwbThEQnBQTUJWdU5mc2o0SFVNUW5kbVVtT1VB?=
 =?utf-8?B?TmlyQjdCOGhVcTZxQXNKV1JtMEIrZ0NDU3I1RldkZCtFa2V1SVVOVzd5bU1V?=
 =?utf-8?B?RkN4ZzdBemExK1lZdlMycE9wTUwwYW9ncnRBZ0xydW5lalV5aHBNY2Y2NURB?=
 =?utf-8?B?RjRMa3ZQbHprakVGOUNhUmQ1MDBUWS94T1Q1S3EyWkpkMEE2bEJNek5EQ0FL?=
 =?utf-8?B?YlU3c2hra1dtOTh2L3R0TDRSamQ5SWlVTGdCMW1NSGpidWdmWFZpNXBPTlBP?=
 =?utf-8?B?SjNiV3VlMUhiKzR0aGNsTVg1cStPOG43cndTaTVwVkZsTTF5NExzSFd6V216?=
 =?utf-8?B?RTRZQnlVdzNuRXZnZmFlaXI5SGJmL0U0UnhndVpoZW1EelVDQlZueUR5MUJH?=
 =?utf-8?B?MWd3RGhSU2R2YlFVQkszcjM5djdZTXZ1eXhRbVA0NVhrcFp6K2FCTDJ5RC9y?=
 =?utf-8?B?YzZHakwxSFpmaVZnOStPR3p4Sy9YQ3pFQjdBR2NNcWc4SXFVRVBiMzJsQUw0?=
 =?utf-8?B?QmxhK0xsSDBJOFI0OGw5aGxOQmlBWkdDK2p1WHQyekY5a2N4WXZJaG45WDRT?=
 =?utf-8?B?RUNITGFWNEdOeDB6YXpsS29JM2Y2V2R5T0RldVAzbG9DekE0L05YSFZnTk5H?=
 =?utf-8?B?WFh3RVNCNENqVzViUzJxVk5lNWtkQTZLTmc1Q29vR1FkaFRRMXRiSVlJK3J4?=
 =?utf-8?B?b1YrZTRqdkNHaWgvNWZadjhYUGJLdTJIZFNNbTdIQ3VGdng3MkcyNWV6eC8x?=
 =?utf-8?B?TTZWVnhPSkVxYzErT3dRZHM2MEJXZG1PS0U4SWF6c29tZDdDdEdYMksvNWZ0?=
 =?utf-8?B?OTdYdDBiS1FjazRRMXBudlljQUZGb1RYVHlGVzRjdVpUNUpQZ1g0WkFYQUQx?=
 =?utf-8?B?bWlOSmVDa2FIdEt3WFRxZWJuLzBGRFRzbHJZeGxpbDhES20veFhXemRQSmpI?=
 =?utf-8?B?TzBLQ3BLNTdaNy80MDlUZU5kLzFHRlhsbHAzWnN0WGoxYWZLbHNDYm81MXJn?=
 =?utf-8?B?RGxsOXBIazcvTC9xRWgxZkY3dmdCai9pMkxuV3NQblFNbWhMMkZ3MkErWWFN?=
 =?utf-8?Q?hXXVAbnMuoX4UHNqpglAz9Uqr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd62af3-9583-4e57-182f-08db92666bdb
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 08:08:00.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjBIfaEtUe0T5Wdqh3Iv+smu1nQoPYiff1lnoRrbOdmQoHA7rYOnb+GKNe33b1YtubXrOZW75+8DuxqimELIwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6904
X-OriginatorOrg: intel.com

Hi Baolu,

Although this patch moves the domain reference pointer from a per-group 
structure to a per-device structure, the domain life-cycle is still 
expected to be managed per-group (i.e., iommu_domain_free() is called in 
iommu_group_release()). Is this what we expect?

Regards,
-Tina

On 8/1/23 14:31, Lu Baolu wrote:
> The PASID (Process Address Space ID) feature is a device feature that
> allows a device driver to manage the PASID value and attach or detach
> its domain to the pasid. The pasid array, which is used to store the
> domain of each pasid, is currently stored in iommu group struct, but
> it would be more natural to move it to the device so that the device
> drivers don't need to understand the internal iommu group concept.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   include/linux/iommu.h |  2 ++
>   drivers/iommu/iommu.c | 80 ++++++++++++-------------------------------
>   2 files changed, 24 insertions(+), 58 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b1dcb1b9b170..90be3efd0e91 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -406,6 +406,7 @@ struct iommu_fault_param {
>    * @iopf_param:	 I/O Page Fault queue and data
>    * @fwspec:	 IOMMU fwspec data
>    * @iommu_dev:	 IOMMU device this device is linked to
> + * @pasid_array: pasid-indexed array of domains attached to pasid
>    * @priv:	 IOMMU Driver private data
>    * @max_pasids:  number of PASIDs this device can consume
>    * @attach_deferred: the dma domain attachment is deferred
> @@ -420,6 +421,7 @@ struct dev_iommu {
>   	struct iopf_device_param	*iopf_param;
>   	struct iommu_fwspec		*fwspec;
>   	struct iommu_device		*iommu_dev;
> +	struct xarray			pasid_array;
>   	void				*priv;
>   	u32				max_pasids;
>   	u32				attach_deferred:1;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1a8fb30341e6..7fd53b9e9754 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -48,7 +48,6 @@ struct iommu_group {
>   	struct kobject kobj;
>   	struct kobject *devices_kobj;
>   	struct list_head devices;
> -	struct xarray pasid_array;
>   	struct mutex mutex;
>   	void *iommu_data;
>   	void (*iommu_data_release)(void *iommu_data);
> @@ -302,6 +301,7 @@ static struct dev_iommu *dev_iommu_get(struct device *dev)
>   		return NULL;
>   
>   	mutex_init(&param->lock);
> +	xa_init(&param->pasid_array);
>   	dev->iommu = param;
>   	return param;
>   }
> @@ -891,7 +891,6 @@ struct iommu_group *iommu_group_alloc(void)
>   	mutex_init(&group->mutex);
>   	INIT_LIST_HEAD(&group->devices);
>   	INIT_LIST_HEAD(&group->entry);
> -	xa_init(&group->pasid_array);
>   
>   	ret = ida_alloc(&iommu_group_ida, GFP_KERNEL);
>   	if (ret < 0) {
> @@ -3041,8 +3040,11 @@ static bool iommu_is_default_domain(struct iommu_group *group)
>    */
>   static void assert_pasid_dma_ownership(struct iommu_group *group)
>   {
> +	struct group_device *device;
> +
>   	lockdep_assert_held(&group->mutex);
> -	WARN_ON(!xa_empty(&group->pasid_array));
> +	for_each_group_device(group, device)
> +		WARN_ON(!xa_empty(&device->dev->iommu->pasid_array));
>   }
>   
>   /**
> @@ -3281,33 +3283,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>   
> -static int __iommu_set_group_pasid(struct iommu_domain *domain,
> -				   struct iommu_group *group, ioasid_t pasid)
> -{
> -	struct group_device *device;
> -	int ret = 0;
> -
> -	for_each_group_device(group, device) {
> -		ret = domain->ops->set_dev_pasid(domain, device->dev, pasid);
> -		if (ret)
> -			break;
> -	}
> -
> -	return ret;
> -}
> -
> -static void __iommu_remove_group_pasid(struct iommu_group *group,
> -				       ioasid_t pasid)
> -{
> -	struct group_device *device;
> -	const struct iommu_ops *ops;
> -
> -	for_each_group_device(group, device) {
> -		ops = dev_iommu_ops(device->dev);
> -		ops->remove_dev_pasid(device->dev, pasid);
> -	}
> -}
> -
>   /*
>    * iommu_attach_device_pasid() - Attach a domain to pasid of device
>    * @domain: the iommu domain.
> @@ -3319,32 +3294,28 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
>   int iommu_attach_device_pasid(struct iommu_domain *domain,
>   			      struct device *dev, ioasid_t pasid)
>   {
> -	struct iommu_group *group;
> +	struct dev_iommu *param = dev->iommu;
>   	void *curr;
>   	int ret;
>   
>   	if (!domain->ops->set_dev_pasid)
>   		return -EOPNOTSUPP;
>   
> -	group = iommu_group_get(dev);
> -	if (!group)
> +	if (!param)
>   		return -ENODEV;
>   
> -	mutex_lock(&group->mutex);
> -	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
> +	mutex_lock(&param->lock);
> +	curr = xa_cmpxchg(&param->pasid_array, pasid, NULL, domain, GFP_KERNEL);
>   	if (curr) {
>   		ret = xa_err(curr) ? : -EBUSY;
>   		goto out_unlock;
>   	}
>   
> -	ret = __iommu_set_group_pasid(domain, group, pasid);
> -	if (ret) {
> -		__iommu_remove_group_pasid(group, pasid);
> -		xa_erase(&group->pasid_array, pasid);
> -	}
> +	ret = domain->ops->set_dev_pasid(domain, dev, pasid);
> +	if (ret)
> +		xa_erase(&param->pasid_array, pasid);
>   out_unlock:
> -	mutex_unlock(&group->mutex);
> -	iommu_group_put(group);
> +	mutex_unlock(&param->lock);
>   
>   	return ret;
>   }
> @@ -3362,14 +3333,13 @@ EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>   void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   			       ioasid_t pasid)
>   {
> -	struct iommu_group *group = iommu_group_get(dev);
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct dev_iommu *param = dev->iommu;
>   
> -	mutex_lock(&group->mutex);
> -	__iommu_remove_group_pasid(group, pasid);
> -	WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);
> -	mutex_unlock(&group->mutex);
> -
> -	iommu_group_put(group);
> +	mutex_lock(&param->lock);
> +	ops->remove_dev_pasid(dev, pasid);
> +	WARN_ON(xa_erase(&param->pasid_array, pasid) != domain);
> +	mutex_unlock(&param->lock);
>   }
>   EXPORT_SYMBOL_GPL(iommu_detach_device_pasid);
>   
> @@ -3392,18 +3362,12 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
>   						    unsigned int type)
>   {
>   	struct iommu_domain *domain;
> -	struct iommu_group *group;
>   
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return NULL;
> -
> -	xa_lock(&group->pasid_array);
> -	domain = xa_load(&group->pasid_array, pasid);
> +	xa_lock(&dev->iommu->pasid_array);
> +	domain = xa_load(&dev->iommu->pasid_array, pasid);
>   	if (type && domain && domain->type != type)
>   		domain = ERR_PTR(-EBUSY);
> -	xa_unlock(&group->pasid_array);
> -	iommu_group_put(group);
> +	xa_unlock(&dev->iommu->pasid_array);
>   
>   	return domain;
>   }
