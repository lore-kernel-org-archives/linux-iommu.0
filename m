Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E738355F42
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261141; cv=fail; b=ADi3CnzqBaHhT5dvFqvt5ZGL0blVRfGukM1TA/XfJdEGYo/WKbWAFtX2FrbeFuvEqtmD7IjSMIg7mq1AEeRId7+SgzGuesnkBuAnrfb5wJNGZoTR+MDLJa3BJTl8Z7DrnOi09HSf75NsMALkDRIQ8XBE61pW5sfhWULesCpXLlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261141; c=relaxed/simple;
	bh=YR+qhBd7+97UEfG6/3dGrv7lLhGlidHKsNhQurNEQzQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YzN7MIYh20lORn1H6pcIumnYqN5YHGukQQG0m9Pp3dmWaBb50EPXnsdlQgpkSTRsVsPzSD26mp2qD06VYXwww0qk9Z3M94w0xt8zdtORIkfHIvof9j+U2M8juOVxHyNd0xEoIoHlAsItGui6CRiUVLxb3wJfipJxult87qnUvdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aoD93M0L; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aoD93M0L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779261140; x=1810797140;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YR+qhBd7+97UEfG6/3dGrv7lLhGlidHKsNhQurNEQzQ=;
  b=aoD93M0Lj5xpb9pDNSDxh2k3B3J2zoHpElaQ1zb6ZWl91kYcUr40hwut
   DZaq3pKT2eoGo/bese0xp4p8VpXuuErva+FxfQZV2KMGXwf+/DKVg0xps
   cQeVT6lAXXpjjCSg3+WbxNj68mKCznpXNXGPGYCae966fUfYkoPGVJ6KZ
   2BTXa6RlUUyt3FOWJaRbh86lwamArSGZYTPKZkxKlfu3XuLkmlhiSakbH
   S5/h7ZobClozTTYiJpzkuS4ZfLGBCxsF3njR3iqeHDL40By8NrzoIBCgh
   8awUyaEuSI8lcEjDya9h1FKUbduroOVLkWa57+lqC6Vme58CiGgzwGJ/L
   w==;
X-CSE-ConnectionGUID: qUjw44jpRw6W6cv7OMQ6ag==
X-CSE-MsgGUID: Bm4ou+T5RRa/1r+sSCe9kA==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80268302"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="80268302"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:19 -0700
X-CSE-ConnectionGUID: W3UvsP9CRUS2WtO1R7mn5w==
X-CSE-MsgGUID: K+JRUeiIT/q3pJHrWpTRww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="237070989"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 00:12:18 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:18 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 00:12:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.28) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 00:12:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PMuOjEHl/VjhFJ8Adp9Egux/mFkf0WBLZozPRlc0oCJ6ExCwic1INHCPLZXb6D52WLs4VXQ+3G5HeUpETyxItEJmk7tpfG7n+Ut6CMQPdTXdBE3RDWDmEnke+1cavlyTQ4SSSPfPgjtO7/GDLdwwCkP8HgrkgiVwtSJKb6HWsYq3cGk2uq2ybTQAMh5jGhwYoa8gpc1zeW/fZ3IPd6vsSortZAVUBCQWuVqm32HTV0wI7Lyy1jxlnThOyjC8Fubr5VU1IulOLS6eYAOuZCRx55mTv4CdVqQ1w08Ur8d11kDdz6/0g6m8wJaERw4jiXW2ou5eTLBJLtuf6ZTigNoMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUSCFu5fVq6NlTjgqAoxmAupJhg6SCvr0Yz2LSas64o=;
 b=GMkDKkk4b7/B3raBn0rZlxVkU7JFNpoWQlpQRn+tPQoYk9mSzxeqh2zTEm6ysytn2ywtDN/6ebtH7gbS+nI4VdRIDZ8rZwFdW9X0J4i68LioeWBwtlKvSkx4P3Dk1FOWipgkXEesPDHQygGYqJ0Z0jBsLfqA7K1tHhcAPFxADgku92S5B3nOO5PEJjSHGcSiYOjrrWsxzWQRcPkoCAs4hYZJ8yTRhrDwcLnSrQBC0GKZ3jyicMU3zKwsdY4+Mx40FUdxa79CiYO6G9MqFAPjfCsdjKBQL/y7oA1t3CF1BNcGU+ZOHMt6rlZip+h9hlSV+PW3IcFEkQ15HrDupwyjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ2PR11MB8424.namprd11.prod.outlook.com (2603:10b6:a03:53e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.14; Wed, 20 May
 2026 07:12:15 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0025.022; Wed, 20 May 2026
 07:12:15 +0000
Message-ID: <95235a41-f9b3-4b5b-9a34-489a9ff7eac5@intel.com>
Date: Wed, 20 May 2026 15:20:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] vfio: Enable cdev noiommu mode under iommufd
To: Alex Williamson <alex@shazbot.org>, Jacob Pan
	<jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
	<joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
	<dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
	<nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, <skhawaja@google.com>,
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
 <20260519214613.167e8d5b@shazbot.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260519214613.167e8d5b@shazbot.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ2PR11MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b38b39-fa8a-4aa7-1235-08deb63f1ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|42112799006|366016|376014|7416014|3023799007|22082099003|11063799006|18002099003|56012099003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: XHtNMWX3U+FM3IlRo3Hx95wd8X/O5JgOt6b6GOPSxRAOn/mTsgXtqDPbwf/5w8fmrWCuz8+MBxt3ilXnrq0aCSbtwQX1FXsDb2ngthSsr+mRVBLuEayh+NscrK7cpaAme4w6VYnffe3GAMbBQX3zdfMoh0tLqYllasH9H1BwC2DreEq/+SvZYfGaFZLpAG/K56E21NDUeqsc3BFZCOXutD5BKIeROwZEPqMw7JvfyplQHoxkVee+DUyZNnpCGgmewb56hWYrAvwZXkqIwqRL6UdPaUFVW4Ref9FX6iRNxp1loEBHyQLy1JfULAd9IDMl4G/YmX0fWyKpqLzgG3fuIfIPrisWql86WaQ8kR+0ET9RsvAu0twb5X7mk0jQnAiYrP96GvIH5tIpiMuRWR5yevMieO4viU0k7+zDVUO9JUH8/oHtaNhbOJW4s6Exrpmn8iDgPzVXosWwh61xsZZXfkbV/nOzwWq1C3FNjQCN90ma2Y//X+l7clHx9ly6C7+ug0/SRtIGkbScg4o/b8Vf7WHtLs8MV9Sx2+IS+We1hBhqPDCoNr5xYfy+B9RZi2GxThXleuRJ2Q0HghkZQRjlqCKOjDs+e24RwhMaT1zFFmO05K3GMfBYrjJtp+91OFZCpYZMqwulEHXYIb7TMowAspMUrPmfxgDi/h78OymSqNGLoi7mc4zl5SasugYSjVK4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(366016)(376014)(7416014)(3023799007)(22082099003)(11063799006)(18002099003)(56012099003)(4143699003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJYczJ0WFhZOGhkNDMvUGdrY3hxbGtYTDJHZWp1ZXpLbUJReVlnbjZhT0xn?=
 =?utf-8?B?VjlleTEvVEQ3OHUyRENsYkhXWFBZajJTZElURzVBc2ZmZkk2TTVBL1cwRnpq?=
 =?utf-8?B?MmZRRXlGKzdMSWRZbWh0Mlp5dzk2SU96WkNXRXhwd2ZkZmpwUFIrdC93ekRG?=
 =?utf-8?B?KzQ0UlI1L2xWTHd3TmtIWFJhOG9rQkU2QUZyWEdOMTFyTW1iSXNVcEZVb3FC?=
 =?utf-8?B?WlVHVWZHRm5TUndVaTRiRFd6UGQrWVFUdHQ3ODAxN2RNaXV5bUhPR3cvOHc3?=
 =?utf-8?B?OGl4WU16TU5Tci9nOGF5SUxyYWhKdmcxaXlPU3lwR0FuN3BWZGJhYXdVRHJw?=
 =?utf-8?B?NitkaEhvK1V6eU5BZ0dLUytDa2ROcUpKZVo1YTdvQURUSHRpejRRN2EydTJV?=
 =?utf-8?B?T1JOd00yamNLUUhIbWlDVTMvOFRhZFRMbUFoT2VrRGZ2SjZQVTBhVXVmbkQw?=
 =?utf-8?B?enVIL0IzMDA4T2EvUXU1WHNsWE83dWZIcXRSWCtrK0ZsVFlvczJraXR2VVNx?=
 =?utf-8?B?UmNsNHl5S25ZL2N4ZFZtVzgvSW8weGRadXhTVnRWWDRlVlFNV0FwM3hZWVhC?=
 =?utf-8?B?cG5OcEt2TXM0UllQeWROU2JTYlFNZ1hUcWdvY3IrdHZ1Y216Um0rUm45WHgr?=
 =?utf-8?B?OWt4Sy9ZOWg1dTh0WklrS294TlRmajdVdVV0Uzdhb1Fqd2pUcVFhb244WTNk?=
 =?utf-8?B?dzBmbkIwREJjalhlTGdNWmhPK2MzL3JXTEE5aHpTdDlaQnBuYm1Pbi9qc1JK?=
 =?utf-8?B?Nkc1cld3WElBUFFORDRoVFFpdlQrbnlock9WUXZvTVJZM1c2ZThObzR1clU5?=
 =?utf-8?B?MHNkVmhlTzA3d0x3VTZzVXU2SElvTlViWWNxV1JoTnhEcjVYcVhYcFhCc2Fj?=
 =?utf-8?B?b1ZYVG1ZWmdXWUNZOU0xRlc3a0N0dU5WOHBXR05VTW9pRDBqeXRTMDdBMllS?=
 =?utf-8?B?cHU2NnlRb2lCYmxTaWNOdlkrOVE3S1Q2dHp0dVl6cnQ1bkhtS0VaVTdWNitF?=
 =?utf-8?B?cTZTMDlSVENRcGIzTXFjSWhiK2UvbG5XeE8zcjNncVFuaytzVWlWbkhuem9i?=
 =?utf-8?B?dGdIOVZBVExHamlXQ1JzRVZxUXlFeWxrb2lpbFdOMzNOcTN3dzlWamR2VENS?=
 =?utf-8?B?bmc1YTVXeW1kZERNYTVTZ2NKb3dDV3lNd0hIS1hUdElUMXBLV0JTaUpnemov?=
 =?utf-8?B?NXZvdExTMjh1TGF1YWpseUhhc1BIZTNQbnQwbkZ6cFo4Nlk2d0Qvb1E3cjI1?=
 =?utf-8?B?eVI3YzFwRHRxOStzeHZxRmhmVm55bzkveFRYeHZkclZDSVRSbjRSY0pPd3lM?=
 =?utf-8?B?NG5xa1pocUJWSmpjNWo0elZIblNDWmZ3U1NVc1Jybms2WDZFWDhIUkwzRjdu?=
 =?utf-8?B?RVpWcU5YK0dWRUhDVmV1QWdIQlRVRnllelNaZnp4WE5HUm82YW5FSU4rWnAw?=
 =?utf-8?B?QjN5OVJ6QmZueTJuRjI4RGczdGlkTjhDUlRiNzlLZW56dUphNmpibGVaM0w2?=
 =?utf-8?B?eXc4eU55TTF3aDgwbkE2VGNieXRxWFp5TVZLQkJxWWhnUFY4cCtvbFBjcllL?=
 =?utf-8?B?aEVia0JtZE0vSUJZOHoySmJHRzhqUExHRm9Zck9VS1VPMjBobitwa0hxUFdS?=
 =?utf-8?B?QWlkcVllamlwa1BwZDI1YVZ6UzNXZDhGbDRHaitJOWdxREh3RVcvUFpxUGtm?=
 =?utf-8?B?VDZuR0tKL2haODRvR0IzWmJZQ1BjZ2dMZGFMMTJxUS9vRHJqNHdEaGtBaTZC?=
 =?utf-8?B?SVA3M25GVWFYVWR4Sk5jdGxRNVZNUG5BakhCVDRjL1dDTFpTS0RnWXhGbEE5?=
 =?utf-8?B?SW9SZ2ZLK3BjbGplOW95eUxNTzFyWFlJeGsyUzlLSnJ5QlNmbERvY1hXczZk?=
 =?utf-8?B?RlYrSFNZQjJ6R2l3OTBQTllSRHVDZW5YbGpzUHM1dG1XVlBDaFdreU51d2Vn?=
 =?utf-8?B?dzdBQWd3NTcxTlJiV3RxSGhIZWpXcDhkdkRLQkNva2RDK1BBNm5DTUdSYzN2?=
 =?utf-8?B?eU9iMENlQXRkUktjeTFDR24vdGFMZ253TGpFNWp1R1d5Y0lEQ3liVVZpMW9z?=
 =?utf-8?B?aG5rZnF3Mm1TUmthdnFiRmdaeU1PQitmL0dZNEFhczIyLzBDbjgwTVorNys5?=
 =?utf-8?B?UEtaUXBDbUdBUTBZQUEwNlQ3QkN3SkxqV3NTMHgyNUpWNnB4TkhnTVBGNjF3?=
 =?utf-8?B?dGNaNmUxZmFIYStiRlRBdjhmaCt4MlJ5elZraTFFMmdzbTZUUFduKzlwVEdP?=
 =?utf-8?B?VGdpekw1WUUzajFXYzJtSURVL3JkUFhxUVFxdDdyVlFQNEl3aC9SRXlWQW9T?=
 =?utf-8?B?eE5mQ3ZRVGs5M0ZGZm1pdnF0dkR4bm4rdFdVZUIyeEJRMTM1K3dyQT09?=
X-Exchange-RoutingPolicyChecked: ZdKbCZQUmKWtnl9/PLfCGoNAoTY5TwWqODkCByxLrNsu6RZspbFRWcR9loneapcTYt8KAa/Bgu9oDa3zK+jFUQi1r5lnv//+cRhlA5FUk1IiIS9ooVvo+OFwAyxPBfsZ4+BoSddLMgVNNB0jox/JJN3tfSkGRE1Fyvolsf/5RbA0j1NpcK9pX9dWyvSomG74IVALiHI0fOiVLiXIqbqrf8LBxEIfGkdkzRpX+v2BDFC613TC5bUleQcNqJi8Jfn+M5vJwgxrMjrti7KZQZGnt3zslueTliPpOK+u9g0WHZdg/6UIWOQU4MjeQtc9R984/lXhQ4VGC0H0NYkucCVpOg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b38b39-fa8a-4aa7-1235-08deb63f1ea6
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:12:14.7969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ph0XJeiEVdt9sFM1bLoBabUezovrNywCpnaxxNgcWHvoEOoFi76/TwBEXsxEah3qBfpUb18X4+uEbMx+7fE9Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8424
X-OriginatorOrg: intel.com

On 5/20/26 11:46, Alex Williamson wrote:
> On Mon, 11 May 2026 11:41:12 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
>> Now that devices under noiommu mode can bind with IOMMUFD and perform
>> IOAS operations, lift restrictions on cdev from VFIO side.
>>
>> Remove the vfio_device_is_group_noiommu() early returns in
>> vfio_df_iommufd_bind() and vfio_df_iommufd_unbind() so that both
>> group and cdev noiommu devices go through the standard iommufd bind
>> path. This is safe because iommufd_device_bind() now handles noiommu
>> devices via its own iommufd_device_is_noiommu() check.
>>
>> Add CAP_SYS_RAWIO checks for cdev open and bind under noiommu to
>> maintain security parity with the group noiommu path.
>>
>> No IOMMU cdevs are explicitly named with noiommu prefix. e.g.
>>
>>      /dev/vfio/
>>      |-- devices
>>      |   `-- noiommu-vfio0
>>      `-- vfio
>>
>> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>> ---
>> v5:
>>     - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
>>       and its dependencies
>>     - Add comment to explain vfio_noiommu conditional definition (Alex)
>>     - Removed early return for group noiommu in bind/unbind
>>     - Use consistent wording referring to VFIO noiommu mode (Kevin)
>>     - Update unsafe_noiommu Kconfig help text (Kevin)
>>     - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
>> v4:
>>     - Remove early return in iommufd_bind for noiommu (Alex)
>> v3:
>>     - Consolidate into fewer patches
>> v2:
>>     - removed unnecessary device->noiommu set in
>>       iommufd_vfio_compat_ioas_get_id()
>> ---
>>   drivers/vfio/Kconfig       |  3 +--
>>   drivers/vfio/device_cdev.c | 10 ++++++++++
>>   drivers/vfio/iommufd.c     |  7 -------
>>   drivers/vfio/vfio.h        | 22 ++++++++++++++--------
>>   drivers/vfio/vfio_main.c   | 25 ++++++++++++++++++++-----
>>   include/linux/vfio.h       |  1 +
>>   6 files changed, 46 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
>> index b1b1633412a9..b1a260b6054c 100644
>> --- a/drivers/vfio/Kconfig
>> +++ b/drivers/vfio/Kconfig
>> @@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
>>   	  The VFIO device cdev is another way for userspace to get device
>>   	  access. Userspace gets device fd by opening device cdev under
>>   	  /dev/vfio/devices/vfioX, and then bind the device fd with an iommufd
>> -	  to set up secure DMA context for device access.  This interface does
>> -	  not support noiommu.
>> +	  to set up secure DMA context for device access.
>>   
>>   	  If you don't know what to do here, say N.
>>   
>> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
>> index 54abf312cf04..46a808244398 100644
>> --- a/drivers/vfio/device_cdev.c
>> +++ b/drivers/vfio/device_cdev.c
>> @@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
>>   	struct vfio_device_file *df;
>>   	int ret;
>>   
>> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
>> +		return -EPERM;
>> +
>>   	/* Paired with the put in vfio_device_fops_release() */
>>   	if (!vfio_device_try_get_registration(device))
>>   		return -ENODEV;
>> @@ -110,6 +113,13 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
>>   	if (df->group)
>>   		return -EINVAL;
>>   
>> +	/*
>> +	 * CAP_SYS_RAWIO is already checked at cdev open, recheck here
>> +	 * in case the fd was passed to a less privileged process.
>> +	 */
>> +	if (device->noiommu && !capable(CAP_SYS_RAWIO))
>> +		return -EPERM;
>> +
>>   	ret = vfio_device_block_group(device);
>>   	if (ret)
>>   		return ret;
>> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
>> index 39079ab27f92..bc80056c74d3 100644
>> --- a/drivers/vfio/iommufd.c
>> +++ b/drivers/vfio/iommufd.c
>> @@ -25,10 +25,6 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
>>   
>>   	lockdep_assert_held(&vdev->dev_set->lock);
>>   
>> -	/* Returns 0 to permit device opening under noiommu mode */
>> -	if (vfio_device_is_group_noiommu(vdev))
>> -		return 0;
>> -
>>   	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
>>   }
>>   
>> @@ -58,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
>>   
>>   	lockdep_assert_held(&vdev->dev_set->lock);
>>   
>> -	if (vfio_device_is_group_noiommu(vdev))
>> -		return;
>> -
>>   	if (vdev->ops->unbind_iommufd)
>>   		vdev->ops->unbind_iommufd(vdev);
>>   }
>> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
>> index 602623cacfc0..ac79b1a2fce9 100644
>> --- a/drivers/vfio/vfio.h
>> +++ b/drivers/vfio/vfio.h
>> @@ -36,7 +36,7 @@ vfio_allocate_device_file(struct vfio_device *device);
>>   
>>   extern const struct file_operations vfio_device_fops;
>>   
>> -#ifdef CONFIG_VFIO_GROUP_NOIOMMU
>> +#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) || IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
> 
> Have you considered what happens when these are y/n or n/y?
> 
> I think in the former case we can create cdev devices for group-noiommu
> devices that are not labeled noiommu, skip the CAP_SYS_RAWIO test, but
> will fail to bind.  In the latter case, I think we fail to setup an
> iommufd_device and unbind will segfault.
> 
> We really don't need to support independently setting GROUP vs CDEV
> NOIOMMU, the suggestion was to try to get NOIOMMU from depending on
> VFIO_GROUP.  We can do that other ways though and I think we can do it
> without the rename in patch 1 that will inevitably result in some lost
> config options for NOIOMMU on upgrade.
> 
> The Kconfig may get messy, perhaps something like:
> 
> config VFIO_NOIOMMU
> 	bool "VFIO No-IOMMU support"
> 	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
> 	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
> 	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
> 	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
> 
> Sorry if the previous suggestion sent us astray, but the subtleties of
> independent support look tricky.  Thanks,

this also looks better to me. Less kconfigs. :)

just one nit: current VFIO_NOIOMMU only depends on VFIO_GROUP, maybe a
separate patch to extend it depends on 'VFIO_GROUP && (VFIO_CONTAINER || 
IOMMUFD_VFIO_CONTAINER)' first, then add the cdev path noiommu
dependency.

> Alex
> 
>>   extern bool vfio_noiommu __read_mostly;
>>   #else
>>   enum { vfio_noiommu = false };
>> @@ -358,19 +358,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
>>   
>>   static inline int vfio_device_add(struct vfio_device *device)
>>   {
>> -	/* cdev does not support noiommu device */
>> -	if (vfio_device_is_group_noiommu(device))
>> -		return device_add(&device->device);
>>   	vfio_init_device_cdev(device);
>>   	return cdev_device_add(&device->cdev, &device->device);
>>   }
>>   
>>   static inline void vfio_device_del(struct vfio_device *device)
>>   {
>> -	if (vfio_device_is_group_noiommu(device))
>> -		device_del(&device->device);
>> -	else
>> -		cdev_device_del(&device->cdev, &device->device);
>> +	cdev_device_del(&device->cdev, &device->device);
>>   }
>>   
>>   int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
>> @@ -420,6 +414,18 @@ static inline void vfio_cdev_cleanup(void)
>>   }
>>   #endif /* CONFIG_VFIO_DEVICE_CDEV */
>>   
>> +#if IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
>> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device *vdev)
>> +{
>> +	return vdev->noiommu;
>> +}
>> +#else
>> +static inline bool vfio_device_is_cdev_noiommu(struct vfio_device *vdev)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>   #if IS_ENABLED(CONFIG_VFIO_VIRQFD)
>>   int __init vfio_virqfd_init(void);
>>   void vfio_virqfd_exit(void);
>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>> index 4d940ce6f114..1ba0f282d746 100644
>> --- a/drivers/vfio/vfio_main.c
>> +++ b/drivers/vfio/vfio_main.c
>> @@ -54,7 +54,7 @@ static struct vfio {
>>   	int				fs_count;
>>   } vfio;
>>   
>> -#ifdef CONFIG_VFIO_GROUP_NOIOMMU
>> +#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) || IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
>>   bool vfio_noiommu __read_mostly;
>>   module_param_named(enable_unsafe_noiommu_mode,
>>   		   vfio_noiommu, bool, S_IRUGO | S_IWUSR);
>> @@ -321,6 +321,20 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
>>   	return ret;
>>   }
>>   
>> +static int vfio_device_set_noiommu_and_name(struct vfio_device *device)
>> +{
>> +	if (IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU) && vfio_noiommu && !device->dev->iommu) {
>> +		device->noiommu = true;
>> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
>> +		dev_warn(device->dev,
>> +			 "Adding kernel taint for vfio-noiommu cdev on device\n");
>> +	}
>> +
>> +	/* Just to be safe, expose to user explicitly noiommu cdev node */
>> +	return dev_set_name(&device->device, "%svfio%d",
>> +		     device->noiommu ? "noiommu-" : "", device->index);
>> +}
>> +
>>   static int __vfio_register_dev(struct vfio_device *device,
>>   			       enum vfio_group_type type)
>>   {
>> @@ -340,20 +354,21 @@ static int __vfio_register_dev(struct vfio_device *device,
>>   	if (!device->dev_set)
>>   		vfio_assign_device_set(device, device);
>>   
>> -	ret = dev_set_name(&device->device, "vfio%d", device->index);
>> +	ret = vfio_device_set_group(device, type);
>>   	if (ret)
>>   		return ret;
>>   
>> -	ret = vfio_device_set_group(device, type);
>> +	ret = vfio_device_set_noiommu_and_name(device);
>>   	if (ret)
>> -		return ret;
>> +		goto err_out;
>>   
>>   	/*
>>   	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
>>   	 * restore cache coherency. It has to be checked here because it is only
>>   	 * valid for cases where we are using iommu groups.
>>   	 */
>> -	if (type == VFIO_IOMMU && !vfio_device_is_group_noiommu(device) &&
>> +	if (type == VFIO_IOMMU && !(vfio_device_is_group_noiommu(device) ||
>> +				    vfio_device_is_cdev_noiommu(device)) &&
>>   	    !device_iommu_capable(device->dev, IOMMU_CAP_CACHE_COHERENCY)) {
>>   		ret = -EINVAL;
>>   		goto err_out;
>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>> index 31b826efba00..45f08986359e 100644
>> --- a/include/linux/vfio.h
>> +++ b/include/linux/vfio.h
>> @@ -74,6 +74,7 @@ struct vfio_device {
>>   	u8 iommufd_attached:1;
>>   #endif
>>   	u8 cdev_opened:1;
>> +	u8 noiommu:1;
>>   	/*
>>   	 * debug_root is a static property of the vfio_device
>>   	 * which must be set prior to registering the vfio_device.
> 

