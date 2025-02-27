Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C62C6A3
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 00:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616589; cv=fail; b=aGoE/+9fSMQpGDZ1EYjDHjHrs/UGtaRlXZ0wXG8Jj8eAyQGWBQqY8atnAF42ZHFN+oUT2mjFIWEoKuKaQhexnlzn7yFoWfM2YQ4ukTgo0Ts/wX5gdrYlePEyqtdQ+x/ffsWqF4129tZ/zLXyWMyeCZ7bCqIHYZoIFG2TiJuoxXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616589; c=relaxed/simple;
	bh=GkkWnK+8sJ+YVVvlKExuSdeZmQkLFiWRskFV9xvHo1M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jSs3Bdp88c21MvesgxMplqyy7ISQCuE6r6VtkCBIKEg8DNc8Z/HHQHdfLHuu3eELhHZ7HAo7EDv0lp7ICUmPsrSX8BxL3QzXEzgapRX7hIkeFkyRrsC3m5iUqA7XTcSVuFvVOygWqhyEzolh5HKEQL/PZ0X2gL/3i9TvoC9SDBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H60Fj/fE; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H60Fj/fE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740616588; x=1772152588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GkkWnK+8sJ+YVVvlKExuSdeZmQkLFiWRskFV9xvHo1M=;
  b=H60Fj/fEnBanrn4b45GJVZ2lnl3D+Mp+lCVfiQsiOwhHyYxiJMzAQMC2
   KtoT2wgp/N7ECBI26k35A+YwoP2C5S3Aogv1lk0XoOFOQn9IeBwE1utgS
   CvuF7rU1n/9qzwm0YiJvPlLdWbp4Hy68dx0h/nkDZbFXsoMjiDGMCcILK
   88AqIqYawEjJnfMyOcxaxNBu3nPVLlCxR7OYbvsMMQn+VuSUBKhTUkZ0G
   pkhZXwniTNxtzNddvaXaCiqWWdrJ5kRcnwKcWvl+PeGaYPlzTS4TAlzmm
   gwJefZwRr5+25SUS6apOm6pBMlnDVodP5T4fYo63M7G2mClVtFYxbfQNd
   g==;
X-CSE-ConnectionGUID: j0NbmBBlTru/EvjUeCn8WQ==
X-CSE-MsgGUID: X4k6+E50Te2jsnnUc9U3xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52903927"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52903927"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 16:36:27 -0800
X-CSE-ConnectionGUID: hIrHfjf9R7+o2KjT8oeZYg==
X-CSE-MsgGUID: 4RCAhkJzTMmk39OSqjUQyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="116894373"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 16:36:26 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 16:36:25 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 26 Feb 2025 16:36:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 26 Feb 2025 16:36:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWQYfLMJ/LiCgXYJ4j3rh7Pcov8u2v+Y3TvxuaOUtpJBQXBwxE8+qDuauEENOkTVJ5sOoJ/V23X77ysjpdooXlox6QfrCK2mHaD5cVfHATnHPpwfM7b0vu2WJwHg7l4AD/HXzChBt6/LzVOiEFDrmjxtSFVA6RXm2bXfcUNVdgdt45Vv3i4rJSSnXTRCJ3UVjvcV2rDNcucMrqDCMcgD6IqhIzUAJkiusYudu1aTB7EMBXai6p8FDjjs86XlB537m3NpLxOqr2YAcxutViPnnsx/BTKYJjBgKDZgzcrutsYbDjFsLPmO1ZaL3wXeYeihCU5CgW6s6/ZXmwitjIJFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcRRkpOmQGtjgU4QuHxBKup+jKQBiUgcGcEQHNNsIb0=;
 b=Orx1/LNgZsMhRdjCAMsBazS+FCVdtc4EK3OPRmp26b2ASFZQZrTdC0xRaKNiD39ywXAhOQro+Hv2g+pc5TXEfoGc1DGjdXpDy1o5kdemco1D8hBCYs7tq/rgkEn0TOgGyt5c5g8biGqtqQntd16y4kA8pFJcJMyWzG/NIXGh+X65QdDm9YyVsnY5aTzoYsXwtVu57ntjAljfnClDu8KK43RmSlqkQcv1VpRwI0ZVg10V7pia1waVvbv+9yNTFHO8os7paTx33DhckwFlhiIu1CB7jZbSMb+XilG8lK8Yz7baK9LgpzVPNA1UYCuz5OegirqxEyzZX5QNgG3tcMdAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH0PR11MB4822.namprd11.prod.outlook.com (2603:10b6:510:39::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 00:35:42 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 00:35:42 +0000
Message-ID: <c89c10b9-a7a5-448c-af93-ddde011576a9@intel.com>
Date: Thu, 27 Feb 2025 08:41:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommufd/selftest: Add a helper to get test device
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226050130.5814-1-yi.l.liu@intel.com>
 <20250226050130.5814-2-yi.l.liu@intel.com> <Z7+LbJUNVMvrJzs9@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z7+LbJUNVMvrJzs9@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH0PR11MB4822:EE_
X-MS-Office365-Filtering-Correlation-Id: d72935c3-61ae-4b31-cec6-08dd56c6aa6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0xka0lpZXN4aWdVT3RWNmJPNXBXcmcxZURKdGZRYXd6dmMyaGVjOUpzVXF2?=
 =?utf-8?B?c25NWFBtWEI5NlUrdFRIMDNrOGJKeWRKcllBSExremxPWjJXbCs3L2ZJeDl6?=
 =?utf-8?B?Zm0wbjVsd0RBcSs2TEZxbUJXTW1MNlVKQ2RtMllRZVNVZkpleXpWaEZzNjBH?=
 =?utf-8?B?M2F3UFBWS2NZVG8wNklrOGhzekVTSXVxZUJzOGJjcEtkOWlqc2lpTXVycExM?=
 =?utf-8?B?eG9LKzR4UFJXRVNEQ05QdmRybUdCMHdJWEdvM3lzQ1V6aHU5Z3ltZ0pIRUJN?=
 =?utf-8?B?YU1Zc1diRUdDM0hRSEJiUDJyMCtMUW90KytveHRxMkc5S3VlclEvalBCQjdt?=
 =?utf-8?B?WDhIbmlFVkkycStiVE5KdlV2R25rdHYxd0k5aXRQM3A3bjFRRzUzRjh5TS8w?=
 =?utf-8?B?c1A4QXlNNGR4VWdlK1JBVXZKd2RJQVFGMFJwTGF2bW9zcjhSdWoxUUVIZENG?=
 =?utf-8?B?YjU1ckpvTlBNZWdnTzdQaTdiMVZ4cWdZWVpBcnl0NG1tVG9JeSs0YkZ6ZTQ3?=
 =?utf-8?B?NHFyc3RTbzV5WU9LcTVCT3VnSjVKR2xROGE2RnI4TXExYlp6dEtKYnBMUzA2?=
 =?utf-8?B?YmZ6VVhGQktnT3dKM1RwRityL212QTRPcE91VFdkRXE1SDZadTU3L3dBalgx?=
 =?utf-8?B?L2x1SC94TG5UYzNKK1Qrci8ra3dsMGlmaStJQVk3WmNZN1djdmdWMWdoZnRk?=
 =?utf-8?B?ZDRQcUZlS3c4UmpaVW4weXB2eWI2c1pxYUdpSVJ2bC9LK1M5bmkwZzEwV3NR?=
 =?utf-8?B?YkYrem05ZE9kMS9raDNWYisvYlpRbWU5aDl6RXdqQW14M1RWbHFDcll1dm1y?=
 =?utf-8?B?enBlQW45cDlyMlliVEx1RE83RG1XY0tBaHpzS2FxL2NQbTM4WFJFYnpFOVRP?=
 =?utf-8?B?R3F1L2orVHU3WlN2NERjeC9zUENGbVhDRW1IL0RlS1NhREZxNVBsS1RtZlpl?=
 =?utf-8?B?MjdSUWZENjl4WVliQkFxSjl0dmVWbXlRbDdxNEVZYzdXTlFqa0syODZpZUFS?=
 =?utf-8?B?dWdWdGN1cjJzYytHR212U1RUa1lIYXRBSU5IdEp5LzNQWDJkYy9ybEFXVEE4?=
 =?utf-8?B?ZGFRWmE0OU01UzNiUWhhc2NYK0FYZVBzRW5oRzBhck9RVklVZnZ4ekpnTWlZ?=
 =?utf-8?B?WFJQbmJEaDllanhwK0E5TytMajJnWUtBL2c2cURjVmJtVUppRTNicEJFYVNE?=
 =?utf-8?B?T2ZrNklYc0treDdyR21TTUhoeTV4Y0xoUk05ZlM5a0xkY2YwR3N4Z2kwR3FM?=
 =?utf-8?B?a2J5Y0ZSTkhHMzVvQnFaYlRxeEFLME5aQ0NVblZDVmlFekkvdlJGK1hYWWI1?=
 =?utf-8?B?WWdxQUZTd3dmUWZTeEI5bUNNSFFIR1FtNWpDMXFmNzVaQ0p4aDJhTWtHVE4z?=
 =?utf-8?B?QWhQa2JTQ0JGSDBhcGUzZnNlSS8wRjlkMktPb2k0RHdTV1ZrRjlSSFd6UDFX?=
 =?utf-8?B?ZW1EMlp0N1ZHeFBmQkxoaSs5Wm12RlFtR01FTVlTQmc3aDlDa1E5TGx3QXU5?=
 =?utf-8?B?TEV0cCt1cm9kV1NZV01EZjE1NkMvRlNWek9pMlA1SE44NHhuMDkvcmdjUkhM?=
 =?utf-8?B?TWkyUlBYenJRdDJ2djVuR2ZtNEl2cEtjcXBGeG15UVlDdTgrL0pUS0dLSy9F?=
 =?utf-8?B?QkhxTHF0czhPam1mbXVDV3RJS2JXamtnM2pzWTNoMFZjMXZkc2kzYVkvZzBO?=
 =?utf-8?B?K3ExdVQ1QmhvZ29MM0NwZkdxaGRTUkxQRHJBUHdQbG9ab3plSzFpd2xHMDc4?=
 =?utf-8?B?R2NMcVBsNUVDNW9Dazk5eXNqUlVsQS9aclFuNXR6Ukd3V3NMMWNtQWhjOTNi?=
 =?utf-8?B?dHI4SWQrVVdZdjN6eFdhVTBQaHRRcUpWR1g0WXcwdFExTW5Dc0xZeGlvZW02?=
 =?utf-8?Q?r4dBgFVtsquJR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjFPVmtHYXBwNE1Oczk1NTY1dW5tMzY0VUtkalk2cU51VVRFZDdiU3F1L2pN?=
 =?utf-8?B?eFVpN2tWTm93L2dQZEsrQlZxYnhsdVZBZitKWXNic1BKazhtbnBBbzlZSUVF?=
 =?utf-8?B?NDFuenlHTDNXZmR1azhwbWRiS2ltWTNGdy95S1UxbURjQjFBTS9kTUpqU3dG?=
 =?utf-8?B?eWo3alVhTWUxN2F2TDJJY293RXIrZHVmeWtSQ1BDd1RzdzErTXo0TkhpWEpW?=
 =?utf-8?B?c1krbmxuVmNvVnMyOWlIY0JZd0UreUpUUGZIWVdKUnpkaldVdlhjeWlqUjdj?=
 =?utf-8?B?VXFtK25hejJ6eGxIVmZqbkh0M3h3L1hNZzVWeVRpckZiYlBmbUVVRHVGSUdp?=
 =?utf-8?B?YWpJNURyN1M4Y3VIL2xsVkhLNFloNW1wdCt6dzVOVG5sbmJ2N2VuMWkrZURz?=
 =?utf-8?B?Unl3em51cDZwaXdXMVpBMzgxdHU2dWxDOGZjNGtKM0FLa0E4RzVGaC9TU2pn?=
 =?utf-8?B?QTc2akduZzhTdkdLbkVrUk0wcjVaRVdVNmFWMDl3OXJqREdJZGI2Kzd2WFBM?=
 =?utf-8?B?MDRXL1Y4N2RmMEVXeHYxKzlRcWlKaGRKQnNJYllUaytING1vZWFjWEh0NGxn?=
 =?utf-8?B?WnRhVXBBY0lxNmFDWTRxVVN1OThIUG1HQzRYNkNGd1plbUo5a2gvUmxtWHg4?=
 =?utf-8?B?NXc3SWMrMDV1RVFUdkw4MFgyaHNvWTZ3dGtDbmlERnVPZVRpRlNFRVc1RHJX?=
 =?utf-8?B?dGxmL1FvTSs1UnFGd0g4Q2lmR1ljVGkyeUZwQmp3Qmt1dW1sZStRTkhmaHZo?=
 =?utf-8?B?MFYrNmM4WnF3ejdWcTBGZDZETGNvTWxQNmw1LzFYeWlFN3UwTG1KWFZRUzdZ?=
 =?utf-8?B?bXZwV0RTYmhRYk5zRFRtZEhkRk5SRkxHMEtaQkV3UnVqWXBOelZnZTByalJZ?=
 =?utf-8?B?S05DTmF4OFFzcXFLSHNSNlJSOWhKeEFwNkRrMzVFTVY3YWFvM2RXMlJaQk5i?=
 =?utf-8?B?VEhjNldNQmg2R0ZiUVc4WnQ0WTgwMVpKSlBtS254STZsbHJUaDhyQ1N0ZGFR?=
 =?utf-8?B?RE91YktHK0RJKzdXSVVzUVlyelFaZWtmZ0xiUUpCK2c5SFBCdXdNRGUwU1lW?=
 =?utf-8?B?WXFhdFhNU3JzcWxlWnBQaGlrWE0wMlZ2ZmNOYlV3T1BDUlhMdFJmeGRzRU1i?=
 =?utf-8?B?bW9QLzNrNHFENVQ5amlZZG9pQ2lKckRvTGFkb09NaldsMVA1UjVNSngzMlZC?=
 =?utf-8?B?N3dISS9Td1RidGtsYnJWZzRiUW9QS2ZQWHNHZWp6WWVQUEFyWTZEekJISWJx?=
 =?utf-8?B?dmt6VzU3M0dXN01vdlhoeGNFZ3UvWjJEa1hMS2lVM2RGSjd4bmc0YVhnM0cr?=
 =?utf-8?B?QVlETXhMeUE0aXg4cTRXQVpnRHl3cmJZVklwQ1RaYVU4aEFjZTJvT3pPd3h2?=
 =?utf-8?B?aVZYSlJSY3ZMR2ZQT1NkdUtiL2syTmR0eFFiNlg4Um1DcVd6dFQ2N3hOdENy?=
 =?utf-8?B?N2hSV0pycEVRWWMyeEhIM1ZyRFVxdDFETXpPcEdDbzVKT1IzYzFSblNXdm1m?=
 =?utf-8?B?d0ljbmcyVnl6YWJJei9BNHkyTkpsZURieHBBNDdXOU1nRDNRR1ZOd0o1SHd4?=
 =?utf-8?B?QUNoU2VlVkxEc0dMcU0zamVRWW1LU0pTc3lLd1h5TUs4VGYyVlJxVldIdEZ5?=
 =?utf-8?B?YVV3WWJUN05OQWE5cFpjczF6cEZWMzFubktEY29IUHk1MXdwOGpOWjdMVzdn?=
 =?utf-8?B?Y21NZVp4b0ZkSUltb24zNHdEUUZQdk15T2Q2eTNPSGJFL2xIakk0VVFUQ21W?=
 =?utf-8?B?TWliSXU0STBwWmVVeWFQQmtna29mRUZVczkyYkVLQm9zbUpQNWtNV2lYQ3A4?=
 =?utf-8?B?UFJ6MUpNdWNEVldsQWRBR1dEN3lJQ2MxblYyNC9mdlJCNVFJUWlwejUzUG4w?=
 =?utf-8?B?ckNNSHQrNVczUmR1YlBmblgyQ25jOWRiRDVCU1dpN3prUE9hVTFIWG12Sytn?=
 =?utf-8?B?cStUYlhXTm9nTDc3K1Jsakw4RnhCbC9GaEp0bm9qYzk4OVZQTkZQczBvRndD?=
 =?utf-8?B?cGpFSEFiZ2tHcjlTVnJBbVRJUkkvN2ZCbkVueG14UnpWbUlkMFlmME9Mck1O?=
 =?utf-8?B?VG1xVEgrR2VTRC9Yd095TFpFTXFob1ZLY1FuWWMzc01DSkFtak9WdlNKbHFj?=
 =?utf-8?Q?N3xhK7OlebbOQVvxzLarngPuC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d72935c3-61ae-4b31-cec6-08dd56c6aa6a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 00:35:42.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfaGnKoiuIEDdg8glfGs+70NwKNXcG2Pcr3ORwy1UpHiPsfXJ6feXjtRjErxlYFX/uCPL7IsBQnvWf+ZNsVzyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4822
X-OriginatorOrg: intel.com

On 2025/2/27 05:45, Nicolin Chen wrote:
> On Tue, Feb 25, 2025 at 09:01:29PM -0800, Yi Liu wrote:
>> There is need to get the selftest device (sobj->type == TYPE_IDEV) in
>> multiple places, so have a helper to for it.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> With two nits below:
> 
>> @@ -968,29 +968,39 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
>>   	return rc;
>>   }
>>   
>> -/* Replace the mock domain with a manually allocated hw_pagetable */
>> -static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
>> -					    unsigned int device_id, u32 pt_id,
>> -					    struct iommu_test_cmd *cmd)
>> +static struct selftest_obj *
>> +iommufd_test_get_self_test_device(struct iommufd_ctx *ictx, u32 id)
> 
> Since it wants selftest_obj, maybe just iommufd_test_get_selftest_obj.
> 
>> @@ -1000,7 +1010,7 @@ static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
>>   	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>>   
>>   out_dev_obj:
> 
> out_sobj:
> 
>> -	iommufd_put_object(ucmd->ictx, dev_obj);
>> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
>>   	return rc;
got it.

-- 
Regards,
Yi Liu
