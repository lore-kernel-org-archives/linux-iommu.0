Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4F16F0E1
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809446; cv=fail; b=kpwmh8dgmg96b2jO+RM8i5ybQW8UD792lJpZpK58Dlhn4eaCwQP2QA9xnRIKwUhx73YQQgqfbD01pLy3ZA2v1/R3X+TCObbxuErWBP6jFda2KVuDabScx9XoaLTvvEoBxIBtcfaAHTiEbWWZDupZXTKHSeCQU8ejXyUJBWdHohU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809446; c=relaxed/simple;
	bh=fVYMeUA4NCUeJW8b650hWPt8sAsdJiImJZLIg/kwb2A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rqSRiLwsRl25RVDFXt/vFPXl32HIVEWtYTWeaYDu1ywqzO8HmIpcdmKW/VZXTd/qrMxuREHNkAHOXsS7kN2QoKYy4DtefdZ4k2u1El23X5YLUQ/jDUghC7+ipOGeSxCP01xRynKgwsVUMdcPYPDvqIYjTTa/cz8PlrBdbl4RBQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H80FyoPW; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H80FyoPW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723809445; x=1755345445;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fVYMeUA4NCUeJW8b650hWPt8sAsdJiImJZLIg/kwb2A=;
  b=H80FyoPWZ4BY1xfE5ohGCkayrSi31GoY+BJaE01WB+nuyymz5PQ94pgi
   LIt5Fw9ifiZlBndYNfi1seogMrruosscNv0wWmygSmIxbtg3S79OMD8Vo
   aoef4/Q3eK7KF3kqEQ4azowqRzkmdfcN7NnM9QJVhWEBWZodvRaD03cUp
   IUzL1INnhzeU/oRfz5Pa4dLHkf0r2IjHiC00gw5hzrGVZRANQUC+omHd7
   xuqZv3T7fg4dnPThqAGgZHjbXRg+h8Y5/wgdYml7wwNMpoQuDsZ3lU0d1
   rd0CnUpTIo11n8L05NX30YaDluWjJZXQmM94P+T0fqyVddXeMk9WM3u7c
   Q==;
X-CSE-ConnectionGUID: 8JLM3iAfQNeu6sBx6saEeg==
X-CSE-MsgGUID: 4YlCbUvoSjiRRDuFlabvYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="47506199"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="47506199"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 04:57:24 -0700
X-CSE-ConnectionGUID: gNpM/S3PSjGPMZy30ODqOg==
X-CSE-MsgGUID: dS+45ee8Qqev1SIWlpNktw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64600852"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 04:57:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 04:57:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 04:57:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 04:57:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OJuNg5I70RhshQYIpyZOXTA59Mw/4pQy4gjn1eOeLGQaIT7qbULu4yU6HcghT27/+lofwmhUI53TmyzBfWOg+dnORGeiipluDdtifpDwnsGzMrb8obM1L3nsIvIuz7ZBWpMHVoRZlL0hJf/EpTiKCbKPBqktPuLJbhf4cNkoWDdCyw+uk31yNo8W+xgDwvmHng7oDcyfRi/Ub3zypTpopvVo5O1Xlh7kN5y7jSfwoo1tnwOZisuMtsW57ENK7evc7SAu2q2aDQUvN96C9UvFZnLqyI7/vf5H7VRuG0xdK4NKUhJ6ddV2u7q9jCfMQTmAkPKphFkcWsS+OMYEvPou3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VLX5f7tte6XXe9365e5DrEFGBSsV/cbEROOEnoERzbU=;
 b=Ycb0cPNidNLAQFE1uhV3TgUAcwjDHb/YrdJZrI22CmBgs8e2yp+1wZn6LlSAa9T6uuoYxeqqkZb4Up6rj5O3UVtZzLG2ruE1H9YgVp9JoUXvw6PouLwdwJi67tAfM5gDp8sgJqbrcq8H57AxwGsFTXC3P/lxDro0rvSfU3BSsVpWDk7NxVg3xXU94exLVxm8sSDLMt3NAmAfWpjFH7w9zHD036Hllytx6TgjuSByn+GqREZn5YCthbzWsQpf2jlwhh+7LVOczHWpBaxM44usiSpKYE7JQR9EjFITMHcRkao444E5DQ3soA8ILjueZvVAR7WabJmmjwN1pFrYwyR15g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH0PR11MB8144.namprd11.prod.outlook.com (2603:10b6:610:18d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 11:57:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 11:57:21 +0000
Message-ID: <dc07364e-cb10-4b23-8fd5-1ce0c3aff1ec@intel.com>
Date: Fri, 16 Aug 2024 20:01:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Baolu Lu" <baolu.lu@linux.intel.com>
CC: "Tian, Kevin" <kevin.tian@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, Alex Williamson <alex.williamson@redhat.com>
References: <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240813162044.GI1985367@ziepe.ca>
 <BN9PR11MB527654EBEFE7CBDD37B7B4068C872@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240814224045.GC3468552@ziepe.ca>
 <ad009d03-9a38-4b0e-ac90-13bd8ea0b191@amd.com>
 <60778628-2b2c-4671-b1c6-276db3cd42ea@linux.intel.com>
 <20240815134737.GK3468552@ziepe.ca>
 <29a16f7c-6193-4753-b547-74c5bb9363d6@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <29a16f7c-6193-4753-b547-74c5bb9363d6@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0085.apcprd02.prod.outlook.com
 (2603:1096:4:90::25) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH0PR11MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 171fd231-ac69-46e1-31d8-08dcbdea955f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2JWVzFla3ozbk1IZVF3U3dZWklZdGNGaXRFWHNSOUJMTnNoTmpnV1loaWsw?=
 =?utf-8?B?aTN4MGpLREpIRGlWZXQxWldEcG1OYkxacmRnQkt3RzNINEtVUEcxcDN2WnFz?=
 =?utf-8?B?NlJnWkdLanZldTRaQWpyTnpVYTVicW41TlpWNmxWQmwvdnRQY2psTno4MFBu?=
 =?utf-8?B?SEwxNFljS0cwRnhWQUdabXZYQkw5RjUzRkhiYkNvcjJVZTBrSE9aWUt5MUpR?=
 =?utf-8?B?bmpCcmV4Yk03cW0ybGpVcGdZT0wwMDlUdWdubG5aQ2hwV2ZzSmdIenRZd0d6?=
 =?utf-8?B?QTczTG95TTJkUnVtUG9TYXV1VmxDYTBEMFFTcyttdFZWMVZpUmNxRElkTEFC?=
 =?utf-8?B?Y3FMc2JqdUQ4V2lVQ21pYXJ6QVQ4eEc4MkFVcStrMnJMWGJDSG91ZnY5Sk91?=
 =?utf-8?B?RkJvd2p0UktPRXJQdW9rQjFibDJ3OS9OWDVkZkhmUGU1cUdrNldhZktvck93?=
 =?utf-8?B?Z1VERVpvM1p6dmUvN3A3RUQ1eTZuenc0MEx1S0FYTThVQVVSdk5zdWRjNlRr?=
 =?utf-8?B?RFpqZUZ6VFg3dVBhM3RzMitkTU0rSmNNMnFKRzZyUHMzbXlYZkFsWHpGOCtZ?=
 =?utf-8?B?Wk0xSFBqYm9QTDJnbHI2MjlyaHZXaFQ3Q3htOGMvWU5lL1pjK3U5ZHFUSDRK?=
 =?utf-8?B?WkdDOEVPTHd1RXJQZzJhM3dIeVNMOVdRM2tVN09KWlRTRXJVeWtqLzAyRFEz?=
 =?utf-8?B?S3VNUTk3NFNhZmoxTTU3aHRCdXMxcG5SWG1EWlQwcURDWEk5R3d0TEJKbjc0?=
 =?utf-8?B?OFpqb3c2bTdrcWN5dzBwdzlRUDZRNkg1QVZ3eFkxTkZuSmVXMGV5eHpXUE1Q?=
 =?utf-8?B?RDlOdGNXRG1HdmkxeXk5T1g5QVdoamlNZDFjQ0xGdlJHb0g4MWFYYTNHOTQw?=
 =?utf-8?B?MlZIU2cxWU1zc0xIZU84N2I1dDBtY0RTSVViRDNEbTFVTXZLdHdRN3pBL0tW?=
 =?utf-8?B?cUFQeWlRUUdUN00xYkZiUTMwUGtEK003REhFM21XQWhoR1J4b1AvMCszbGtP?=
 =?utf-8?B?R1V1THpEK3NqQWZiU0pJUW9YZk9JQUFNSTJlckV4akNOaGVTYXp6Y0hTMW9q?=
 =?utf-8?B?clNtdFg0ejA2S1ZoY3JGZGVtK1crU1R0U1hJN0dpQjJOMUJYVkZkaTVLV2lG?=
 =?utf-8?B?TzdmUk1weHYvZkpTYkh2aU40L0t5VU40M20xTjNDSnJLVkZTRFpJVDQ0VW9y?=
 =?utf-8?B?UmkrcXZlNmVTczRvQUNVRU5Odk5Pd1Y4N0VRYTlvbFJEd2VzOElKbVBuRWZM?=
 =?utf-8?B?RmpKZ1JrdXlZSmRLT2VFZVQ5MkJ4QTZPQTJ2YS92NGNJekFpQ1N5aCtGYkE3?=
 =?utf-8?B?T0p1RGJNS0owcXl6S1IzNVc1K3M4SUN5Q25FeUgwRlVGc1F5WUxlUzF1Mktm?=
 =?utf-8?B?RG9aMFl6WUxaZWJaVzFSOVdoa2xBL2xvY3VIRGE3WnYwbk9IRFFjZ2pZRHFK?=
 =?utf-8?B?SkhCTjlubzFDc2ZLbnVNT1JXbzM1bG5nS2gxZDJUVVZJV0VER2o0ZEhTb21N?=
 =?utf-8?B?YWlHK29TZXpOWEF6em5HZDBzNm5wblFWT3JaOHE3RDI3WGZ1WTFKUWp5TEhD?=
 =?utf-8?B?MG05V3dkQ25semhYRTArRFpobXdFZFVYeFNtT3JJb3FBRS9CRFBOczZ6UlNT?=
 =?utf-8?B?Rk9zMUFiY3VVYlh1cThVTDhNcG95bG5DNVBLMStEQTh6RWVwaEpKK3NySSt0?=
 =?utf-8?B?L0hTSngvSkdacXZ2eWhHNTQzaWIrMlFEK0Qzc09sMFBCSXo0V2xQWHFQdEYz?=
 =?utf-8?B?WWhCQUlZT0pzQ3NIWGlCRVpsM0ZoS1hsTDZzcFNLcnRzNEZFc2QzaVR0SXF3?=
 =?utf-8?B?S0NiZlloWHhzKzU0Y0V5UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlFGeVpQTG9DNWNsMjBMM1pJK2lINjYvSk9GN1lncUJQRk5ZZjJrWWRGM3ZY?=
 =?utf-8?B?UFFxQWFmRjBvZHdwZXVyTllIM01DcmpxYjk5aHNXZTBqZGgyUjM2bTErZEZT?=
 =?utf-8?B?NXZxOURQbmcvZjRKY2YyeGJjMGQrSytRK3V6cFJnbE9Dbk1YUUE2OVg4czRU?=
 =?utf-8?B?ZEhRdVMyZGp4Z0JJbnVYanNhM0RQTlpveis0UWp1NUI3Mk1jYnJIbGtOWG9T?=
 =?utf-8?B?K1RBcEVqUFpNTlVOblV4MFowNEpBMTRUSTkxeEdMV0IxekVPZ1h6VVIzUCtr?=
 =?utf-8?B?Sy9EN1BUdUFxdStNKzcvNE4xS09pL2QzVWpEYmZDdWVWSkdabDhLemdXakVy?=
 =?utf-8?B?TFFNbEJaTWp1L0JxSWwzVk1hUkV3STZQdVZaKzBzYjhWb2tFenJ6RlNtcFdz?=
 =?utf-8?B?b2gvNnpsMXhXRGJnWVZuS3lIRlA0QlRQTHFlbUZ5Q2NMT2FzYUZ4aDJyY3ZF?=
 =?utf-8?B?YUhOdVlKNUhlbEZXWlV6QTNrYWwrdVRabmxHSTIrWjRXWS9HenRKYXpLaVY2?=
 =?utf-8?B?SDZZaThkRWc2NFFvYjcwTDF4ZlFyUXhYdnlhTCt4cS9JQ0haakFwYVRWcUxq?=
 =?utf-8?B?NXNCbHpuSUVjbVUvc2h3RDdRTTVGQURoNmY4VndVZE1GMEROQzMyNi9qQ1pV?=
 =?utf-8?B?b1lhaXRuQUZWVE1TYnJ4RDQ0MHpTNk5rSVhoTkpmN3hUdlVxWVlEdi84WHl4?=
 =?utf-8?B?ZGpZSGUreEhBQmhoTW13b0k2NGkwcjJaQkZITHk0OXZ5VEJ5Q1NTbHhDbWx5?=
 =?utf-8?B?bUxnamp2MSs1OEdaajNZR01mbjhBUDF2WnBXUDA3N09MelFZREdVNDFWZ2k2?=
 =?utf-8?B?WlFIV3VlU2pSbDRqa2FoWTRxQVh3NFRaaDZGQnN6WGp0VTBpVXVwaFNwQlJX?=
 =?utf-8?B?Zzk0U1VhZjFHR0ZsT3d1cDRTK2U3V05zTFJyOUFMY3FORFBCdGtoUnRnU0tU?=
 =?utf-8?B?OVRhOFArWjdsSUxMbm1iMi9kdXJrdDF5QjZvb0dzZnJhNG5kNVNpNkpsc0x5?=
 =?utf-8?B?eHZXa3Fma2hTenIxaWhFOXF5dm82WTZ6OERiU0EySTZvTUlXbjNxNXBmSHlU?=
 =?utf-8?B?MUlCdStQNE9uTVJDNkg0RUVwN0VFVlY3L1dVMHVpZmRidG13cHhWVnJjRXV6?=
 =?utf-8?B?bHBLUDdreTdBYkdDcENqMU5wTDV6d0tIa082MHBMRnJQZHFvN2RyYURkSWZF?=
 =?utf-8?B?TGFURDZERk9kY3owa1ZWSk9aUCtOL0dXZkJ2d1JQWFA2QVhFN2czbTF1L3Ix?=
 =?utf-8?B?T2UxeUJSWDlvRG5iaGJ5TVNZZWwzNFFNM3VrYVZiSUFXU1VUdzE2azJBZlRa?=
 =?utf-8?B?L1lJTDA4c2o0Z1J1V3lNTEdyUE9Gcy9wUHU1UWJLSU5KQjhUTnhKMzNUdnlD?=
 =?utf-8?B?QnhGRTVYbWN4SmFhSi9EbHdZMnloS0JqZE5lWnRoQmhGWk01UVA5ZE1DZTJS?=
 =?utf-8?B?TWloN0FNU3l3WmFzczdjWFdSMVc0a3B3R1ViU3NFaWlPTTBMR2xIYjMxTTVz?=
 =?utf-8?B?cldaVWFuTUR5OWNPaDhhM1V3TVdUdTlkek9ZQW11ZG10M0xXV1NZSEREa3R4?=
 =?utf-8?B?T0NaTnI5aXNxUk0vcytoWDFDQWdtVHE5MzNraDREMUlSbjA2T2w3QzczWE1C?=
 =?utf-8?B?d1hGME82RGFQYkdWRFJJc2JkNnByZWFrdnc2WGJ3NEVpN3VIZlR6TkVCTG52?=
 =?utf-8?B?bjdvZ1M3VmY5UGNabXk5NjVMckFzWE9TNThrMHJZS1FkbzZLZ3FsNXJiMCtO?=
 =?utf-8?B?ZW1XVHpxZXE3WmVtOWtqWUc1Y20xa0xXbnpyekdtYXJKczkvSXNObVBwNUla?=
 =?utf-8?B?M0Q0eEZlUXM3NW9BY3ROQS9adUJQanBuS3hTNFlGWkk0ZHMwYXJmRmFwYkNL?=
 =?utf-8?B?NEVSa25tN3JxQzZudHR2bUVPSlp4OG10L3g2VGtadUc3MG5yQ2ZYcGkycjJD?=
 =?utf-8?B?bmhzOEg1MkErdkowc3JXbzhSUm8vTUdjdjBiL2NGWnRUYXVqa0FSdnJVZ3Zm?=
 =?utf-8?B?UlFhNnpZS2trRlZWbWpOMFdyV2hxck1Dc1VlVnVqU3Rjc1g5cWtBcW5ZMU5D?=
 =?utf-8?B?eHVkRWwrSEhjYXlEbEZ0MlpsdEJhWWhNNHpYRjNlVzNXR2NEQlAybWFNcEpO?=
 =?utf-8?Q?+ZKQIjZml1/Ev/rnHdxXFQu//?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 171fd231-ac69-46e1-31d8-08dcbdea955f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 11:57:20.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r8cXlfZmmk1Ak84VrFSjZlVnmmA4dRXLcMmFY4V8lOpDiQQk4++obwjh51Yr9v8oqMvlThMWJna/dcWEv7fwkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8144
X-OriginatorOrg: intel.com

On 2024/8/16 16:17, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/15/2024 7:17 PM, Jason Gunthorpe wrote:
>> On Thu, Aug 15, 2024 at 12:59:13PM +0800, Baolu Lu wrote:
>>> I suppose that this also includes converting paging domain to user
>>> domain allocation in VFIO (ideally vhost-vdpa as well), right?
>>
>> Another thought is to add a flag to iommu_paging_domain_alloc()..
>>
>> Maybe like the below. The small duplication with
>> __iommu_domain_alloc() would go away when iommu_domain_alloc() finally
>> goes, then we'd be able to directly call iommu_paging_domain_alloc().
> 
> This will work. But we have to define NO_PASID flag and pass it from vfio.
> 
> IOMMU_HWPT_ALLOC_NO_PASID
> IOMMU_HWPT_ALLOC_PASID
> 
> is that fine?

this flag should be set by userspace. is it? I don't know how to pass it
in the existing vfio container uapis.

-- 
Regards,
Yi Liu
