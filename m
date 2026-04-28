Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A734F25C
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777361855; cv=fail; b=LJ/nIWEmFVb4IxKGxr7499xRmZKKEBirKlz5PDqrHnR3bMGCt9ImksKl0/juEOayNCLSJLqFVJM9xL/QBIAcMP1tpxgecDif5va5VDZ8Lb+oA+LJtjjAQwxGrrcd83D8U4x6vvUlAvL1L7B/inYvGqlT9B17cXrUDovNhz6lChc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777361855; c=relaxed/simple;
	bh=WSnjuyMRQGpQrZxt3iy/kiwPyspuhWOpg7sknhICPxI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GUbSJ8L5Z+hzhEDZxjaWdoTvyYxfhyJrF3xWd5zCJkHjBb6cjq2RNI3d8e1+gkuStaxHrnOV/8uOuYLUJuUhCWnQ4S0kmRmnfe8E/MrRA+Eg42qVmIWFUBMPhmGf67u7n44v3i9TWcD914s0efflAdWQqEe7ZRUDEa0MU/R5a+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmiFAgYc; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmiFAgYc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777361853; x=1808897853;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WSnjuyMRQGpQrZxt3iy/kiwPyspuhWOpg7sknhICPxI=;
  b=DmiFAgYcMbvLoamOhh48Jkj9H3NgvlW8z1+3O7fPoygUtIrXloarNETn
   rU+FOhc8PPI/j25KgyQLl0Pj9cFsij4WPGd9buvrrQcGIfPhqbHBuz5Kc
   fhMRtuw4uW9R84o4bwyT40UP0T0++0Q24n3YkgSQMKprnJ/JXvss7Ersd
   JYheRQ57O78QnT0umhmBEdHdTpI/Fz54DlREepZaoRO0sPSoD9IAlqNSi
   AjaP78mzJKxl5ZXb/C2Yv9s8Bg1BjWWngMWWivZLbDzBLacaqtrQXFOWX
   1nEMoJoQAIxbpNLpUsTvqy1bonuseOcLyyj919HBUMb8+h1Zs3/giYLlU
   Q==;
X-CSE-ConnectionGUID: 3/3vJ1i/RwCC7F4lxM/wRw==
X-CSE-MsgGUID: tbsgzdKMTGqq2opoIT00ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77966378"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="77966378"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:37:33 -0700
X-CSE-ConnectionGUID: ZoriVbTPTbe0dccZCSsgAQ==
X-CSE-MsgGUID: GpWVrpWCSCawzlYs71iymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="237833800"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 00:37:33 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 00:37:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 28 Apr 2026 00:37:32 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 28 Apr 2026 00:37:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7+gd1ajSGXvH9nzWyVDRL+KwgV81Fb1YFPufnJBODyhqs72hEhdfTj5eexT7OOLXb5J91vte8ZXuYUzI/u1GDXzYECsDBPqW4bWAJQH75bIjqFIJYUNRIwsTeAlW4waQFCWKnu0MaN/deTsnw3T05Zc4czpbMRAGFBh9okpjlgyv/8ZURAnPsawcKahckB+M0yvip/OgAiRCvnY9lUblMpbOdQB+otKHibhDDnJuOxCPfvWlIwbT2VLbuqXDLbszTGCMjQvTkKbjOntvpGQTKMJCAK6tft0I6JPkmDvGn0F4IDFDj0P5eYIujRReSBHFZrZmo8M1DDskrgOi2wNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a23DBNsTRDOFoSSQfDQy0I1gbko0A6MHJ5Lsa5SeMfY=;
 b=WWpeq8smvp13O6z8VFmT2r9VVf0k51+8UscgtlYTPUyiRcLUW0GBHm6EUEwLjLpQkmuGh5J8VsrvBeaE+LwPJe2Vz0zvvNBuVO3AyPDpuC7Bazs7c83xeimwuhAuCpSQVmwoB5U2jgbdLbqxgpLaHll2IFluT+h6AauNNifNRdtFXaHlcJcW1RuGcc3br+99GvrFy2QL+slY/jZPLQvvyJtiu0hHHugVgUsZsGe7lkfa+RhKSVFn0dgikMflXrf/u9qBdX1PSYsejh88vN24CR0sxfpcCBE9CynVzC7yRerSvupAYWfjadKFsc9MK1QJudIxoRWXnpQ8/FwXdwc2Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ0PR11MB6696.namprd11.prod.outlook.com (2603:10b6:a03:44f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 07:37:27 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9870.016; Tue, 28 Apr 2026
 07:37:26 +0000
Message-ID: <b0bf1e99-d7d0-4e62-8a97-114e8e990b58@intel.com>
Date: Tue, 28 Apr 2026 15:45:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
	<jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
	<will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0013.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::7)
 To LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ0PR11MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 68fdd3f4-ebd6-4b8c-c203-08dea4f8fe8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|42112799006|18096099003|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 0cL1XPkQKkCo52udAulMRI5dISLuh8w+xI0X4b0POoW8S0JgWan5UxSixLJMk5HX+nLGqUbwZZqrSmT6HWHpX6icVqM1UOY7rKBq4JejqSPKI2lZvRp80ZcAZfmgF5hUQdPh0pgyjLWtcw2Xkgpdrcrz69pf693rGJJ9JxtVJuhBuGCNRcR7dWPUAjyhnU+AS8h265bgDmqbX73bJZ574KQGO8wBnvMUr57jFMg8SiJmfE+W8qQaQVGvQPjj1mWnaRvFyAxFYpP5OjHlC/c5DrHTppo40nzwzeNufMYXe5CsTQBlauU4T7jzpobmoDGqgS9aXvjnn0EanpGcPyBWHO3+P1Hv1NpZ0l8Rsp1i7NLhQo0kW8fJTLHvzAI7hN0QcLoTv7XnaQp4qchoR9eFP/42Tk5YW65CvFFJXd5QDKfkiq5ehRBKq2ZneewQ3nx3KBAljP/I5a+/dMrcVuv1v2OB5pIWmuDhPNO7YbpnCIkiSR6fn3GRuNLCY+U0tMMZagLO7COTCxpFJs3E6mP7mHmXZ0rd/6/hbDl6uvDM/fyqLWudsksnBV+o7pEdBGHec2bedpVPOE0Xstd1II7DIoE5z3mJuMo904NoQEaWAmExkmlaT3FxLTHexx2iBNTZDPjm3d8FlIPyECO4idDgNiZWSL0cK900YkTATECF1Qr96W7YtB9oMNmEOVPLmPRtCixjghBsfcDnnc3f367+R8poy3ErafZ9VlvWu+OwxUd29YpTLi3tONJxluMjy67bdvJmKVhzMmtUsvHUICOr9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006)(18096099003)(18002099003)(56012099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3BCM21lMUtKTHlFWVFrbG9PQ1d6RXpObFN4QmN4Y0V6cXNYUWZJa0JqeTZE?=
 =?utf-8?B?OFZKUXlZRmVTa1J0QTR3eFltWHJ1OHhNcW0yQWNVWTBvbkdDOFo3R2tybm9W?=
 =?utf-8?B?QUZXU0hIbkVWQVhVNCtCVWdWMDhweHdaemhVTG95MHdScXBwbGZhZEpFa3F1?=
 =?utf-8?B?am1SVnJyUkV0KzE3UUt1Sld4L21qcFMyQWVTMlplaEZTU1BLb1BLU2YwU2Uz?=
 =?utf-8?B?aWxaRS9lTDErbmVDaVc1T1VGdjJ5YVBYdkxMSnJWME9pQm9tMTgrRjRoK2Z0?=
 =?utf-8?B?MnFMMEhTSmM2Tmx3YmxNajN2Z01adXlkME0wOGdodlhJdkI1UFVuRkR3SnRq?=
 =?utf-8?B?WXFab1lkcGE1Z3dWZmltTzlwd2Rud0pjVXJYZk1kcnZaUVFPYXJNc0FpbHFW?=
 =?utf-8?B?VXdRRzdzQU54bWI2UjlMWjZsWk94UVZZeHJjVVN1NVl1L0Qxc245WXRJeDJY?=
 =?utf-8?B?VDFYTHNjUVBzSS9ONVJoYnVoUlZZMlFKU3U4U0JqTForS0VncHNTVDJEVW9n?=
 =?utf-8?B?V3Zxa0RaOElCMWhUa3pXcFVhV1RLaWU4N0MrKyt1RURnUmdTYnphTldmcHlL?=
 =?utf-8?B?dTg0N2Q3QmlnTTY2THVKYzJVYmEvMCtic0JtVXpSQjZWcEYzOVd6czdadGtk?=
 =?utf-8?B?WUwwNWVncXZEYUdsekxSNjZCbWxVaTl2ekRzWFJTODZTdExHVTV4S2poeDgz?=
 =?utf-8?B?VnpBaTJqM2Y2VHdVUjV2TUlmaThFeXYwWGhKNXZNeFIrU3pEcERLRUozWkUy?=
 =?utf-8?B?ZTdISXprWnJwRjU0ODU4cWNtUE1jV1FkSURYUWE2SENJQnNhMEJCbDUxTUc0?=
 =?utf-8?B?anNxNDFKUWZpMTg2eGs3L2lhQ2lBVjQvaXR6TkZQaVNUV1lhN1J4Vm5MNk1m?=
 =?utf-8?B?VXVnU3hIb0tIRVFGWFp1QTQ5TW9nRzBlVXJsbFBlckhjSWFDcVRmQjQzYTZZ?=
 =?utf-8?B?L0dBdTNDdDN3aUpwZDJhRklwZkRKd1l1K0hnWFNqeG1BSlN6QzJlQUlCNU9k?=
 =?utf-8?B?Z1hla2Z6TFh0azR4akw0dmdVRFd3QW9kY3NMdzJxczd6cGtNQUtyRndkZjEv?=
 =?utf-8?B?UWh4Skc0M3BJTEdyOHoyY28vZUhMclBxZnpvOTJWNTNrZngySkFoVllZK0dS?=
 =?utf-8?B?cjc2VVNtNEQxK2tjcGdtM2pVTkNjU3lXcFg3MmNpeVMzaXRnM3B0MlVONElj?=
 =?utf-8?B?aExUZm1raHVhczIvQlV2SkRjMm96NTRyck5pbGFIUXJZTlFZcElhc3F3VzFF?=
 =?utf-8?B?dVJVK0Y5OWlGQy9LTHRVeEFIQXIzQTM3RmZZOVlCL1lKbzNvZ3dlaTIzT2lP?=
 =?utf-8?B?MExwRzIzdGlibjNjRmtianVYRStFYXA4SkpyUmtpc0lJREYyTThVZmxzc0tW?=
 =?utf-8?B?b25mRWNIdS96aDlXYUxEelhlN2tPeUdqT2xLeHMrMWV2TUhxWGRqdk9ZRFRY?=
 =?utf-8?B?c2ExZXZMT2EyL0MzcU5wWDN6dk93dkZ6bE5ObDd4Z2k3QTdocG5oaUJzYURL?=
 =?utf-8?B?Q1Q4SXVoMEhlZXB3dzdSY0MyT3VmdlhuT3RNcStEUU1rVitwRDk0dCtYRFdE?=
 =?utf-8?B?bkFndlZveGpjOUxxWHFndDRvRm5pbDB1dFFnZW83bG5GZkZTc1lXYW42Ykwr?=
 =?utf-8?B?K21BenpPSytvMnUwVHFyMlkzSFk5Z2tzUHQxbEdSSVNhTnYyMWN0TEhqV2VO?=
 =?utf-8?B?bTkwSzN4cnJuTFhUU0dJSlRQbmhWVG11TzVRZmpPdW5EOXRPRkNwaVhQUDdG?=
 =?utf-8?B?TUg1NkpFcnpwWUtBd1ZyTytLWTVvUXd4SDlyYnFNVnpyZTU5bERVYVhZRUUy?=
 =?utf-8?B?UW5wV1VNTXoxWTJCUTB6aXJrcUsrWktiQUFDSWZYMHZIK05tanZGVExwMWla?=
 =?utf-8?B?OWRieDhLdjd2T1ZRSDljbU1YZVJyZk5mQXMxQXBVanZwTFFRVXliak1RMVNV?=
 =?utf-8?B?NmtEbE9McjBFYkdGSml6LzBUYmlTenRSQjBoS2Vpei96dEo5Tjc2dFo5SXpC?=
 =?utf-8?B?L0JJWWp4YXVKdSt2SXIrRUxzRDN2NC9jckZ4MXcva1B2NVE3elVzcnRwME1J?=
 =?utf-8?B?WE1CTnJGYW1KWkM3am8zVExDWGVObGpyaHN6S2VoYUM1RTExczFCblZIU3ZT?=
 =?utf-8?B?bklWaVB0OUFEV29kcW4zNWVqK2VLSmhnN3lpUXJoWENsVFYwcWFjK2VHWmEx?=
 =?utf-8?B?YVJGN3BkTkdpdVVyejFOd1pvemp2aTkrT0dOWUN0eU1POFR3ZVROUWpZdUow?=
 =?utf-8?B?TDFLUy8yTVZ6NTgwZysvWi9sMFBlb0k3alRKYVhaU3VHRVd2R3hSYm0zcnBs?=
 =?utf-8?B?MnlvekRJbDdvVDVVekQxUWRFdVlmdEFnVXVBVUtValkxenJHMUpFZz09?=
X-Exchange-RoutingPolicyChecked: UUQRRT+lz+U0KvXfe8H/phDo5s1bhDa0TT/poJF6wgLDcOArfS0ronWJXJhyYm9KMtrIjZFS2dsXt6YD2L1UIsAAbv9bajq+rWUPxNKxQYXZ4WAVg5+T4BCcWP3rQiMI8HcUpf0pfGrfW7/yYWD7Ed5WPgedcz6FQBAJX1RejZO/tD6dKVEgA1Fk6dmRX30ef/tQ/StosXxPz364f6mLhMxxt7gf4jypQxhBmziBBupYGay11e3BE8WDC4V6Y51AvG/84OjFJp/hz3F3YwHtDxDrYT3ztfuVmjTI02eLB/gzHIA9wUewcuQb7Rh+pBB3I1nu9EfgcT0dcaJfWDDISA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 68fdd3f4-ebd6-4b8c-c203-08dea4f8fe8e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:37:26.6304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/sAxvFuoBMxRQMYf9HRaxji+gJw5X/ZcEH8DhPpgjArSzd2Si1hQtQnZsUa8sbdz5wO1RPPIsQrPYQNtbZ1xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6696
X-OriginatorOrg: intel.com

Hi Jacob,

On 4/15/26 05:14, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Create just a little part of a real iommu driver, enough to
> slot in under the dev_iommu_ops() and allow iommufd to call
> domain_alloc_paging_flags() and fail everything else.
> 
> This allows explicitly creating a HWPT under an IOAS.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> 
> ---
> v4:
>     - Make iommufd_noiommu_ops const
> v3:
>     - Add comment to explain the design difference over the
>       legacy noiommu VFIO code.
> 
> fix const hwpt
> ---
>   drivers/iommu/iommufd/Makefile          |   1 +
>   drivers/iommu/iommufd/hw_pagetable.c    |  11 ++-
>   drivers/iommu/iommufd/hwpt_noiommu.c    | 102 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |   2 +
>   4 files changed, 114 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> 
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 71d692c9a8f4..2b1a020b14a6 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -10,6 +10,7 @@ iommufd-y := \
>   	vfio_compat.o \
>   	viommu.o
>   
> +iommufd-$(CONFIG_VFIO_NOIOMMU) += hwpt_noiommu.o

is it better to have a separate kconfig for it? Also, VFIO_NOIOMMU
depends on VFIO_GROUP, this does not sound good. For one, cdev's
noiommu support should not depend on groups. For two, this means the
iommufd noiommu support is only for VFIO. It closes the gate for other
userpsace drivers. Perhaps a IOMMUFD_NOIOMMU kconfig for it.


VFIO_GROUP | VFIO_DEVICE_CDEV | IOMMUFD_NOIOMMU | VFIO_NOIOMMU allowed?
-----------+------------------+-----------------+----------------------
      Y     |        Y         |        Y        | Y (both paths work)
      Y     |        Y         |        N        | N (cdev path lacks 
IOMMUFD_NOIOMMU)
      Y     |        N         |        Y        | Y (group path only, 
cdev irrelevant)
      Y     |        N         |        N        | Y (group path only, 
cdev irrelevant)
      N     |        Y         |        Y        | Y (cdev path only)
      N     |        Y         |        N        | N (cdev path lacks 
IOMMUFD_NOIOMMU)
      N     |        N         |       any       | N (no VFIO interface 
at all)

Then VFIO_NOIOMMU Kconfig dependency is:

     depends on VFIO_GROUP || VFIO_DEVICE_CDEV
     depends on !VFIO_DEVICE_CDEV || IOMMUFD_NOIOMMU

>   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>   
>   obj-$(CONFIG_IOMMUFD) += iommufd.o
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index fe789c2dc0c9..37316d77277d 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -8,6 +8,13 @@
>   #include "../iommu-priv.h"
>   #include "iommufd_private.h"
>   
> +static const struct iommu_ops *get_iommu_ops(struct iommufd_device *idev)
> +{
> +	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) && !idev->igroup->group)
> +		return &iommufd_noiommu_ops;
> +	return dev_iommu_ops(idev->dev);
> +}
> +
>   static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
>   {
>   	if (hwpt->domain)
> @@ -114,7 +121,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>   				IOMMU_HWPT_FAULT_ID_VALID |
>   				IOMMU_HWPT_ALLOC_PASID;
> -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	const struct iommu_ops *ops = get_iommu_ops(idev);
>   	struct iommufd_hwpt_paging *hwpt_paging;
>   	struct iommufd_hw_pagetable *hwpt;
>   	int rc;
> @@ -229,7 +236,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   			  struct iommufd_device *idev, u32 flags,
>   			  const struct iommu_user_data *user_data)
>   {
> -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	const struct iommu_ops *ops = get_iommu_ops(idev);
>   	struct iommufd_hwpt_nested *hwpt_nested;
>   	struct iommufd_hw_pagetable *hwpt;
>   	int rc;
> diff --git a/drivers/iommu/iommufd/hwpt_noiommu.c b/drivers/iommu/iommufd/hwpt_noiommu.c
> new file mode 100644
> index 000000000000..1c8cae02beec
> --- /dev/null
> +++ b/drivers/iommu/iommufd/hwpt_noiommu.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include <linux/iommu.h>
> +#include <linux/generic_pt/iommu.h>

how about moving it to the first one? :)

> +#include "iommufd_private.h"
> +
> +static const struct iommu_domain_ops noiommu_amdv1_ops;
> +
> +struct noiommu_domain {
> +	union {
> +		struct iommu_domain domain;
> +		struct pt_iommu_amdv1 amdv1;
> +	};
> +	spinlock_t lock;
> +};
> +PT_IOMMU_CHECK_DOMAIN(struct noiommu_domain, amdv1.iommu, domain);
> +
> +static void noiommu_change_top(struct pt_iommu *iommu_table,
> +			       phys_addr_t top_paddr, unsigned int top_level)
> +{
> +}
> +
> +static spinlock_t *noiommu_get_top_lock(struct pt_iommu *iommupt)
> +{
> +	struct noiommu_domain *domain =
> +		container_of(iommupt, struct noiommu_domain, amdv1.iommu);
> +
> +	return &domain->lock;
> +}
> +
> +static const struct pt_iommu_driver_ops noiommu_driver_ops = {
> +	.get_top_lock = noiommu_get_top_lock,
> +	.change_top = noiommu_change_top,
> +};
> +
> +static struct iommu_domain *
> +noiommu_alloc_paging_flags(struct device *dev, u32 flags,
> +			   const struct iommu_user_data *user_data)
> +{
> +	struct pt_iommu_amdv1_cfg cfg = {};
> +	struct noiommu_domain *dom;
> +	int rc;
> +
> +	if (flags || user_data)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	cfg.common.hw_max_vasz_lg2 = 64;
> +	cfg.common.hw_max_oasz_lg2 = 52;
> +	cfg.starting_level = 2;
> +	cfg.common.features =
> +		(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> +		 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE));
> +
> +	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
> +	if (!dom)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock_init(&dom->lock);
> +	dom->amdv1.iommu.nid = NUMA_NO_NODE;
> +	dom->amdv1.iommu.driver_ops = &noiommu_driver_ops;
> +	dom->domain.ops = &noiommu_amdv1_ops;
> +
> +	/* Use mock page table which is based on AMDV1 */

"mock" may mislead reader that this is test code... may just explain why
choose AMDV1 page table.

> +	rc = pt_iommu_amdv1_init(&dom->amdv1, &cfg, GFP_KERNEL);
> +	if (rc) {
> +		kfree(dom);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return &dom->domain;
> +}
> +
> +static void noiommu_domain_free(struct iommu_domain *iommu_domain)
> +{
> +	struct noiommu_domain *domain =
> +		container_of(iommu_domain, struct noiommu_domain, domain);
> +
> +	pt_iommu_deinit(&domain->amdv1.iommu);
> +	kfree(domain);
> +}
> +
> +/*
> + * AMDV1 is used as a dummy page table for no-IOMMU mode, similar to the
> + * iommufd selftest mock page table.
> + * Unlike legacy VFIO no-IOMMU mode, where no container level APIs are
> + * supported, this allows IOAS and hwpt objects to exist without hardware
> + * IOMMU support. IOVAs are used only for IOVA-to-PA lookups not for
> + * hardware translation in DMA.

Not sure if the above comment is helpful. To me, IOAS/hwpt operation
support is the natural advantage of using cdev. What helps here is
explaining why the specific ops are defined for noiommu_amdv1_ops. If
you'd keep it, may go in the commit message. :)


Regards,
Yi Liu

> + *
> + * This is only used with iommufd and cdev-based interfaces and does not
> + * apply to legacy VFIO group-container based noiommu mode.
> + */
> +static const struct iommu_domain_ops noiommu_amdv1_ops = {
> +	IOMMU_PT_DOMAIN_OPS(amdv1),
> +	.free = noiommu_domain_free,
> +};
> +
> +const struct iommu_ops iommufd_noiommu_ops = {
> +	.domain_alloc_paging_flags = noiommu_alloc_paging_flags,
> +};
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6ac1965199e9..2682b5baa6e9 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -464,6 +464,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>   	refcount_dec(&hwpt->obj.users);
>   }
>   
> +extern const struct iommu_ops iommufd_noiommu_ops;
> +
>   struct iommufd_attach;
>   
>   struct iommufd_group {
