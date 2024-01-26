Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082461F5E4
	for <iommu@lists.linux.dev>; Fri, 26 Jan 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261242; cv=fail; b=ROLREyQtked/ah5RFDY4Bf0BBnlqpAcemzvY+PEcjqyM/oLDWhkOfY9p8zSd9v5ijn8anKA5TQJvgwzEom0DxYnmq83+e7g11oA6/I5eSvaQGzHHKQFhvG52VCo45MsfQ5tzDKRhiqiYFDo4pKF4GzKjxthksx84rCMbZEx2d0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261242; c=relaxed/simple;
	bh=zXNXPThZBE5Iql/hTLv3bu9Wr44cBbNE7B8+f+lc7zk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gVm1/ami8JlSD0G57Y1t9QY1Y1TZTJAN3Qfnp+ub3bQm/LPMZkUwAHyUQOPcuAo7cvSfWAqJMplCd1bVS/pPkwoNlsETkR2feVzXw/ApagbaF+RCsK6qH3cYLel8lWX258bH0Hs0O4A7EpfYxrwXjaLUHaEOad45naI/W2SQEfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGmwCewm; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGmwCewm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706261240; x=1737797240;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zXNXPThZBE5Iql/hTLv3bu9Wr44cBbNE7B8+f+lc7zk=;
  b=oGmwCewmKWrJ5KspWj3usTi+arjE3Wu+h9z6E8yAlAPXWJHGDLCPsDRs
   dpAqN3CMRJv+tKiZ71S5BIHtjAdOdnsi3NqLoZmFkt99NAcYHhu8axfYs
   vy0Ntvcrtnk8+f9fl7aCA5ql5DrYHqc7djWJq3fa4E9jYVA2fG3W+uy6e
   ZUGJs5tEXOq24zmjPamvAhx/5+/CQWmm9fQd1UpNt6KVBOVC8hbCNKcpF
   G03ocUhsDrS1ThwzcsepmvRUn3rb4VvG3+tMlHLvgjpv58oJ4v1ZdJ9xq
   V1S+iRVGZLDMmcxBCQZMTgl6pKLhQrW1b8mMI5vHP2vCzvShvW/ZwX4H+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2312784"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2312784"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 01:27:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="930320138"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="930320138"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 01:27:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 01:27:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 01:27:17 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 01:27:17 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 01:27:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccpOT3K7BOwpGur7J0JAAHnSUMUcICxBfVgmIKgkAYIt9Ec/SWJiRCXbmWQPUatdrsA38mCeeD7MupzK8+AjOFAdiH3ywWv5qV9ocp6uZoKGrr9qN+4MYer0HM9H2xExA8euzN0eq7ZTMk3iFx0dysBkdYNEVHespd8ZJutuiiVYo3wHrgrkTmJ9yw2uXdaMoLiqPdvc4n4FtRBzZCyk9BOoInt/MvvXabybhCZHKJgczHR2MDB2rnF7T4HfwL0AIqNfsL1cHiey/wM7oXeYPtxzWD370oXCpYY5TTH7mVI8n42VKvuEqmnWuUGseBKwp8maijFG/ZKJ38wHSbxHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFxXlutzrgOIyosc+znIc6CgjmxySt6yLFLSZs8Zqgo=;
 b=Q6JToAMLngSDfEzBI1YeIwczw9uCZiWS2qg3K/awdcxNO7dyGZX/AZKCuoG/btP1OgkdOF5+NBfuoU1PMFdQIFH5I61TBetNaAM2AamXJVlXgQlvTFUA+N89uPCjZ0tlQwd367YC5s8al+3puPHvk9thyp5pkThAArq+DJd3h+AgnYUu8PQ4sslTN3IplhvgRRr9sr2ANuSWoiBsWxiFNzAWIYLsdi16xIt96Ksze4CGR+GnS2oSS53ZT6uBZwP4xSXXOv6Cnfg1eMGv9BzTzzeVBuhR2bMaNyJaJCaZIy6z1O3yGvdTSa1ecEElzkCMYZQqAX9MCFcZO7SbzlUirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB7112.namprd11.prod.outlook.com (2603:10b6:806:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 09:27:15 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::b877:93ff:2217:eb13%7]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 09:27:15 +0000
Message-ID: <9a01febb-c823-44b6-97c1-03648bb29cd5@intel.com>
Date: Fri, 26 Jan 2024 17:30:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: About unmap pages and set dirty tracking on nested parent domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <92f8aaca-093d-4161-b8f2-5ab1680df769@intel.com>
 <20240125140331.GQ1455070@nvidia.com>
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240125140331.GQ1455070@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::17)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: fcac2742-097c-4120-3bd8-08dc1e50fba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwb86KNCz+9kCSxfyn8C6vhscGv0T8uWtV0twkpwjJ3KRH0HXBX9oMfODt9dwBsRRAZXG2YZmGoiL9y4WaVu94NvE+P4KxMm160Rj1DzgFSBrqdZOMwXGP7hU69uy1nRVi+NUP5c6JJqJZkl5fWbF+jJywkI1b3/SUgi1OhR91cPfzFvig9yG6uQPED+sGqxyxqc1OqdhtvTKT2jaOqpGsdMu4EQgHNabes7PBRWwED8CuXbSMT+cFHaH5W5SrHBPE3f7BUmKXmvTpwzWOSGE3Z5IdNrDo8EA1hlPBmsvjVniFRr25zKWqtYFZhI6M43bsXiPjE1ze9d5as99cYyRluice/39ZsiJj6Ns4onvYzDG4Ou/uLkZO+l1iuA/vcyq6nCSW3Mp3M05z8THxJP6v2MGp2ziEi6bVFZKtHLrUDOU9pVcwqysvbUkNGWGVOCzToOrJkBbXUqGY5bG/K/zvTeVUxEkdTKp22EqOMmvXQhVemUJjNXBq4xbCsFbSjt9QChBo3XbysmXNXWVpEMVp/oFYCPDnUNZ+H9jnK9QPvGPMn5Snaf533i7Em9UvFHFLnnQyHmhVH0oZcvZrjx/v08gCqEvmH4F9Ph+ktua6iKtYo6ZMR3Tt7cue86UGgAvD3Syg7nQx0iZ9goy470XhYqT11UMxilcuv67+3bE9A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6512007)(6506007)(26005)(53546011)(83380400001)(2616005)(36756003)(8676002)(4326008)(86362001)(66476007)(316002)(54906003)(2906002)(66556008)(8936002)(110136005)(66946007)(5660300002)(31696002)(478600001)(41300700001)(6486002)(966005)(82960400001)(31686004)(38100700002)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVRNVlE3eHA1UkVIY1NDVlNrbnhjS3hXOHM4UFNFVXJCdFZObTliOFRVUkNi?=
 =?utf-8?B?MDRYWCtGRWtIZkhod2pHR3lJZnpURmkyYWlZSjBoTDBuWjJMM1ZDMFVJWnBa?=
 =?utf-8?B?YkpVVmU0c1Z0cHhnRndLQng3d3hnbTlMWi9SMWV6MWxjUUJaUHZoeVlPb0dE?=
 =?utf-8?B?K0tHNmFwMC96NzVYUzNUeFFoUnU1bjZiTzMvcHk1T2lrNW0rdlZMRDhnbzhh?=
 =?utf-8?B?cTJxUWJqeGtWNDFYeXBvdXNQaGxIamhmb1B3SHpqUW5VQVZNOFY5Um1XOFRs?=
 =?utf-8?B?YlFydVhBd0hQMndXNFRCTThxbzZGb2tsb0YwdFk1QS8yTE1PSDZhZzhSa3JB?=
 =?utf-8?B?T3dmbGRnV3F4ai9aMTNzejNNUXF3a2NXQWpSVk1RLzNxTVN0NWcxVHRtRlJH?=
 =?utf-8?B?bDRHMHpRTTU5YkZJQ2NUWjNTMCtHUk5QRmdtbXlEam9qVldQRmtwbTdrdW9n?=
 =?utf-8?B?dFNkL08zaSthZXhtY0tuL1VtQ2p3bnJrdkdkSE8wcGFIWGdMb3lmUGU4OElw?=
 =?utf-8?B?em83c1MrbWdpLytjd0taSzJIM0ZublFDeEpRWS80UjlKckxNSDJobFVyM0Fw?=
 =?utf-8?B?a240VVRBRFQzVGtXR0hrRFhNbFQ2aExSbGZZQVNpTTlLeWUvVHJuL2kxM0Zw?=
 =?utf-8?B?d1M4ZVFrcncwdmpiT1ViMkI0WmZiYzVod1dTTElsaWlFcGlMZzFoTU1oYlFC?=
 =?utf-8?B?T0s1V1h1cFJaa2NsSXFPRk5LUWRhWEMzSDNKSEJHUUYwalFkZzJEMFcrTDdz?=
 =?utf-8?B?b1BTdXdnS2RFdklTZGlhZmpkTitkWWEzQy9IK1dBNVY2UjZ6TlpzdHEzL2JK?=
 =?utf-8?B?bmczTmlRMnA3OUtRMytuT3dOV0J6ZzFlcEJHcEczSGpCeTlmeG83K0taY3Z3?=
 =?utf-8?B?RDcwUkl1YzE4dCs1bVdTWUFYR3NnNi81a3M5ZWJCOU9ML2hYcTMxL1QvV1Vs?=
 =?utf-8?B?VTV1bytVR1pPT2RKcytRS09wZ1FSZzl1M2FNMXB3cnV6eFJiTExSY0RBN01N?=
 =?utf-8?B?dXBPWis3cUNlNmQvTEtLVUVsa3ljSzJVMFJxQWVFQjZMTjZlVHVxdjBQSmkv?=
 =?utf-8?B?VCtQTEVvY0h3QWtwYlZyenQ1R0ZXc3VLazg4NSs3cHMyOXZ1c0J1UFcrL04y?=
 =?utf-8?B?RTRDa0xnRW9MNnFOWGowVU9RcVlSN09SNWt5MzVSWWhpeDRtaHgrYWwvNU0x?=
 =?utf-8?B?NGNndmV1cnRwRFo3Q2hvV3JQV3ljazczYUorbS9XdkYzcXU2WDE2TkVER2NP?=
 =?utf-8?B?UjNEdktmQm1tVldKRXdoZENSWnhEb05venlyMWZSU0d6ckh4bGlUSmM5bWRl?=
 =?utf-8?B?aGpUTlhJeG5INVBCa0NVaDNFTkh0OTNGMStXRGgvTVZXNG1rQXJwbHd2Y3o1?=
 =?utf-8?B?cjJ0Zmt6RWE3WGdTUWY0ODNWWFRXZmphRlRka0VrYTJWSjBSdng4T3RjREZM?=
 =?utf-8?B?bXh1TmwrTDJONWlKdlN4elFSYnJicTJIU05lM29rVEYyNnQ1YXhuRGs3UnhJ?=
 =?utf-8?B?dWY5RFlibnhNRmhJWnUvS1hJQ2JrRmI0aWh6R0lyWGZMdTJGcUNvUnlqbTdy?=
 =?utf-8?B?UWZnQTF1M2JqTlVnR2ZOdEF4UENhTnBtcHpHSmI2ak9Pa2VpYjByalV5L1JC?=
 =?utf-8?B?eVBYZTN3TzBpM0RLRFNQN250eTA5YU5iWXprK01SQ0k5YW14TFJZc3VUckF0?=
 =?utf-8?B?QjdRQU5zWDlrTVBmZWc2Z2p3TzI4cFFHZGRJVFdzVEZzaUVCOVBuSnViM1Ri?=
 =?utf-8?B?Z0xZcmpGbmJEaGpFaC9UQmRDejZDM3JHQ3NrSjBSakI0UldHS2Z6bTJHdUZS?=
 =?utf-8?B?TVYxWW5yRVNvRmdxSWdibmZ1SmlPeXVVUEFKZzRqdmg4aU1SMzBEMnlQMXdV?=
 =?utf-8?B?VDJFWUlqdDFsM3RYTktXbWxnOTBRY2FiUU1PS2plWkNod1VFTjd6SUFONGlm?=
 =?utf-8?B?NzM5MzA2akNTTit6dS9JUS9LNnJUbFM5VmdJWUx4WEhBTkVkSG5jUlI4dEla?=
 =?utf-8?B?M2tSNDJnK2hkWm84cUlHdjF2Wmh1QzYrYWY4T3pQTjdBRWgvenFnNFZmMzZo?=
 =?utf-8?B?UlYyV3NVWXRMeWFmb2REREpsREV4YjMvNCtyNHJzNXBtYVZ0STVOWCs0eUFY?=
 =?utf-8?Q?B77XXUl+XokImTISv/l+Zj1B8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcac2742-097c-4120-3bd8-08dc1e50fba7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 09:27:14.9365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+fV18/dP7iCyRwMOT/u+uxgZ+ICzHfF8/vqQQoaiApLqO43VQtJpS+41N/qFzy5NGBoMecI9vAJhWiYXVe80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7112
X-OriginatorOrg: intel.com

On 2024/1/25 22:03, Jason Gunthorpe wrote:
> On Thu, Jan 25, 2024 at 09:55:46PM +0800, Yi Liu wrote:
>> Hi Jason, Kevin,
>>
>> Today, Intel iommu driver only tracks attached devices/iommus in the nested
>> domain. While the nested parent domain does not.
> 
> Heh, I was just looking at this bug on my ARM implemention too :)
> 
>> This makes cache flush on nested parent domain be a nop if it's only
>> used as parent.
> 
> Yep, this is wrong.
> 
>> 1) Do we want to allow unmap pages on nested parent domain?
> 
> Yes. It is needed for memory unplug.
> 
>>     Today there is
>>     no PRQ support on the nested parent domain (stage-2). That's why both
>>     VFIO and IOMMUFD pins the page in the DMA_MAP. As a result, VMMs like
>>     Qemu cannot not unamp pages in nested parent domain after VM is
>>     running.
> 
> No, qemu can do an explicit unmap command to iommufd. PRQ is not relavent

Indeed!!!

> 
>> 2) If answer of 1) is yes. Should the owner of stage-1 be notified about
>>     the unmap event on its nested parent, hence owner is able to flush the
>>     corresponding stage-1 cache explicitly?
> 
> No. We don't support "mdev" "access" operations on nests so there is
> no reason to notify anyone. If qemu hot unplugs memory from a VM then
> it should already have some idea that the VM is not doing DMA to that
> memory.

makes sense.

> 
>> 3) Is it enough to fix this gap within iommu driver? or need to be handled
>>     in the generic layer? e.g. let the iommufd layer to track stage-1 hwpts
>>     in stage-2 hwpt. In this way, iommufd can flush stage-1 cache when
>>     unmapping pages on stage-2.
> 
> I think the iommu driver should fix it

okay.

> Notice there is also an ATC requirement here, when the nesting parent
> changes it needs to issue a full ATC flush on PASID 0, not a range
> flush.

right. I missed this part. Thanks for pointing it out.

> Also notice the iommu probably has to zap the entire IOTLB for any
> nesting child if the parent changes, unless it has amazing HW :)

VT-d seems to be the amazing HW :) It can flush the stage-1 caches that 
refers the stage-2 mapping during stage-2 cache invalidation.

> It would be really awkward to try to lift this detail out of the
> driver.

ok. let's do it in iommu driver.

> Lets add Suravee to be sure the AMD driver is aware of this detail
> too.
> 
> My plan is to have the nesting attach add the device to the parent
> domain's invalidation list and have a flag in the master_domain to
> indicate this attachment has the special ATC invalidation.
> 
> This will allow the S2 to be used normally as well, eg for the
> identity map.

I've considered this way as well. However, this means a single device (say
device_domain_info) at least needs two list_head to link into the
stage-1 and stage-2 domain. It may result in some inconvenience in
the existing single stage (e.g. stage-2) code. Also, this means we
need to track the iommu in the stage-2 domain as well. This means
in nested attach, there will be two domain/iommu association. This
will get some extra complexity in the domain ID determination. Need
to ensure the two association uses the same domain ID. To be simple,
I planned to have a list tracking stage-1 domains in its parent domain.
When flushing cache, set dirty tracking, the helper should loop the
stage-1 domain list and loop the devices/iommus accordingly. While for
the device tlb flush, just flush the entire addr range (0 - MAX). My
code is in the below branch with some other fixes. Need more tests.. :)

a3b8450962b6 iommu/vt-d: Set up dirty tracking for nested parent domain
85879c330286 iommu/vt-d: Add missing cache flush on nested parent domain
ac22f14b2612 iommu/vt-d: Wrap page selective iotlb flush for domain
7311a31614dc iommu/vt-d: Track nested domains on the same parent

https://github.com/yiliu1765/iommufd/tree/wip/iommufd_nesting_fixes

-- 
Regards,
Yi Liu
