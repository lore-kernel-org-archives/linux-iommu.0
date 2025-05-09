Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC5B279791
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782486; cv=fail; b=RuhpZ2eUG/X6Ca6X2kaA/oV7ajYCFgGwdK8pbZDPFI3R19URJ5vQdUGXh6F8zyS6AgbbMY1186RLjr34dLRE8GwmhCgnCr7w/y5fQN9WHfG7ZAmCBU1+jvM3m8o2Pf9OwxLDrUNJMhlLcL7LO+T34DHW/o8Xvhl1OsaCYbZtooc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782486; c=relaxed/simple;
	bh=pukB8g+BtdkecVmH7mqML+98xDaVNrKUhA/+aGon0l4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WXmqYsU+j0a4v/yzR3/G23TjNLvcm+gm1fbNuTDWI3seX7d8sxCk3+OW/9uuylSnVQFNoxDjXmnRmd9d8VgGnhMnHmPgg1pWgakDzXunc8ttscnwVaiwJWLYSoBqBNOb3vY8lnc4PBj3jaiTgkLt+WOPocMfmOQbYVnuGkoM3B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9IYgC2O; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9IYgC2O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746782485; x=1778318485;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=pukB8g+BtdkecVmH7mqML+98xDaVNrKUhA/+aGon0l4=;
  b=U9IYgC2OMY1bu2MVCRHN/UkPa6N8W8k7Jy8XxO4vCN7m20bm6zkf5bIe
   agGg6WT8KAqYjkkHE2m692XRH9AazwoALK2m8vXHAQ0QmFrpUIy+Jns7U
   RtrqlkJzL+rjvBqtMllngeuJfcG0eVuA0oKEhMAT247AtdagEOl4avbg+
   geUcKSE+wAr1ho+J02mcJowQE9+Co3LgdrZ0fllUNlikSwMMh/wR4dFRm
   BeYRNpwNdf42JEqdzg1y9+vZnZuei/TPmVFHizVqkBxQhn3jKZTNoBKeh
   QalwIompzZFCgGknsbQOOglt+hAexccozs7OQjROFTVJlze27WTFf/HFd
   A==;
X-CSE-ConnectionGUID: Zg21TXTWTdmYvXKRnjQnUg==
X-CSE-MsgGUID: MyR+fzKLTzqntWe2PlF8SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48608808"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="48608808"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:21:24 -0700
X-CSE-ConnectionGUID: 6kzXMM20TxusgZVGegRmSw==
X-CSE-MsgGUID: rKp+jOrVQAaQ+p1LTt6dww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="136498721"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 02:21:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 02:21:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 02:21:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 02:21:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbylxpuBC1i9CzlushiuCgdcq42Xe7TcMBcmygNg/E/UFQNX0QN7Em1vGxayVsy/2uwMTTyb/J+J94UjVR7vJXhkhOLcn/zsVJzHW+wlOf+zcZKc6Bt44TIeELIAsH6HzoULnhJhO/u30zV6fh9HT3yKew+1VRgr79vf/S029QxrjRJBmrqt7MPQoAOPbjls6qV1ujUanukpgat2OBo6KVskerrB/jKiVr5TM7I0BMpd1AcuUSC6cH3HFu+kcJtGUOeAvVnUgaEg5bpun5EAqpbfGyWP6NBfJBOznNHcRPU3+XYTK9ipoSmoKC11MzdUn3vf0xtVZbnuXXwLhyffOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iozhlcvJ9W7C+K6u+bcoBbhOq2bL7aZ+oycyHQnGzAI=;
 b=cqPYz5TsUa+ErShX0UFtAtKz5M/lrkbCIlRllL4nIEaY7IOiPETdG5jwxZJX84FovXTSGIHR5sMwj5qGIFpA268BiUoAbX5ZzYQQNgCqNLAtwvpy1QvftGb5SQaZ136Yy9/7M3SQRB2Sy+jDDEJP+T2xDcZnHtYYFE4eGcej8f8rkBDCvmMfHd/PzK72DwYAA7vPLSo+GuFevj8MeDdKvzJ2o+Exz1UAO3Lb4HAadNCyGqWsj1SyE/3I6O1MKFSKLFymNgBKXIBfAaCHpDQbzQLdg4d5gXl7CJNfGz6lyMKJ9mNaUSAwBzsMYQxLk/EJI5c7rIhp25BfeLoG4kf0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN0PR11MB6033.namprd11.prod.outlook.com (2603:10b6:208:374::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 09:21:14 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 09:21:14 +0000
Message-ID: <b36f7eeb-c6ed-4f80-969f-a33a619b954b@intel.com>
Date: Fri, 9 May 2025 17:27:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] iommu/vt-d: Change dmar_ats_supported() to return
 boolean
To: Wei Wang <wei.w.wang@intel.com>, <dwmw2@infradead.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>, <jroedel@suse.de>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
 <20250509140021.4029303-3-wei.w.wang@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250509140021.4029303-3-wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0193.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN0PR11MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: cac63337-ab62-4771-66f8-08dd8edad87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M21MQXRCZEdGSWptOEkyZnNpMWU4ay83VUQ5dTNYbFF3ZGN1aks1N082Sm5t?=
 =?utf-8?B?UHFwNW0xbVMzMFJndURldU5WVENwRjRhMjY0TURoRWxuRUYrZDY2cHl5WmRK?=
 =?utf-8?B?dUxVU3JVbnZjZEtYaEFGa2Z6V1FkZXdSQzhiL29sQWRZTWhWSmhyaDdRaVpU?=
 =?utf-8?B?S3ZGK1NNWnFLOUdRYXhrWjUyYmp4S3BCQ3dIcW9PblJTZ3p5SE1wVE4wUnBy?=
 =?utf-8?B?djFZNGE1NzNDVDVJZWxrUmQxVWVuVExDSjIySStubTNYK1lScTVLOFhjSFVu?=
 =?utf-8?B?VGFsTk5tNU8xU0hYMlkvcFZMWDh3THNoS2VVa3Z2NXdkdjVqSWV4Y3BtYS83?=
 =?utf-8?B?b3lwQXRsY3hlY3dUOVlRQ01HWGFYRzkyQVM2S042dlZWSzlNTUVWSm5Bem9J?=
 =?utf-8?B?QURnMDM2TGN4d3hVR2gvSEs1WEdmV2lZMlNiYktEZ2lOMVhJOEx2ZWdGbERm?=
 =?utf-8?B?QXhkcmxxa3luU1c0WFdjNzkvdHNsRFpmZm1MYmpyZklCMmZUZjB2TzJFaE9B?=
 =?utf-8?B?a1hsejR2NU9ZNkdqWEJPTFRueEVlUjltbDg2T2UwbS9RWXorYkFaRDZ4dWsx?=
 =?utf-8?B?OWRBU1AwdWNJdUErQnhnNEVTbXg2UjhPcCtzRVlHSWNIMmhFNXhPa3owOWlz?=
 =?utf-8?B?cFhwODl0N214V25NMGo3SUVLazVYcDdDYVBieVpYRFI3R1FraWhEMmRjcmtv?=
 =?utf-8?B?aFR3NWFsQzNJbE5PSDhGb0VVZFAvQmppMmlKS2JPM2d4M0dRUUV5UjFocDMy?=
 =?utf-8?B?OVlsMFJaVmhaMjFBTEFhOXd2K1VyNlBadkJTWEV6akdnU1RYZVlBeDRIMTlQ?=
 =?utf-8?B?STczb3hBUktwdDN6NVdxc1ZUMThadm5RamlvNjhtQ2RjZEQyWGQ5NGhZajlk?=
 =?utf-8?B?V2pDN2ZoVStGeVFzTlJ6WTdpMThwMFRyL0NmNU4wZkdDWndPZWUxSVk2Rk05?=
 =?utf-8?B?M2dkMlM5R25MM3RnRWd0WnRKV1VtbHo0OWg1V3hXSE5hYzIxOXo4TVNwaXpB?=
 =?utf-8?B?bm5vcy9JenVGbXBzQXY5R3VpbWRIbE4vUTFrMCtLOVRVemQ3WEhsL0xSR2JK?=
 =?utf-8?B?YkNuUjRCeE5Nci9VeWNEdVZKcDFKeEJMM3pzSDF0WUQyVDJDaU1XZXVFbzNm?=
 =?utf-8?B?ckhRZ2ZPRGYzQ0JXVDBmQ0MxUnVvMU91NFA2Tzkyc3hPTXFVNlk1TGRXdmRw?=
 =?utf-8?B?TGhkaHd4MGdQcWdDRlN0Z05OQmZxQzVmQmN0SFhxbXo4YWdrb2ZVRCtQcmFm?=
 =?utf-8?B?V1lDUXFFTlg5Ulo2dDg0enZ6cUNCL0hXZ21qQ2szdmtSdHB5R0pyeFJ6Qnl3?=
 =?utf-8?B?UUE4WkU2dFNCdjEvamtlZWZKR2YwakxEOE1RczNaalVNbk5EaWtGR1lrdGFR?=
 =?utf-8?B?TUc2WnBGSENMVVlrVUltR2t2d2hhWkVNVEZSbFV1MFZJM1BPKytFVm5uV0sx?=
 =?utf-8?B?c1FOLzhmeWpJRFF5NDlNYUtDRm44MmtzRUJOQUg1d0dTemJZblFKREJHTVZh?=
 =?utf-8?B?UC9BaG1zeW9RKzgrNVdLNmFac3pBbkpScDFKVERuZG0vTmd6WEJ0VHNmU0Ry?=
 =?utf-8?B?cWFkSGd5MWNyT3I3UHpjZ2FOaW9qb0pWUlhZa210QTBkU255MHJMOGNYQVRS?=
 =?utf-8?B?RlVqaTRtRG9GNW1sYUpWZnpoS2Nyc1Q2UTZKb1o5aGhTcGZjMlBnQ0J5akhC?=
 =?utf-8?B?K2ltN00vSGZYeldnbWFnZmVUdHNlMmZta0VheUJpamY4L2NkRGxubVZDTVc0?=
 =?utf-8?B?VGV1TFBSTys2T0lXSkdEMW5UWTFOcXAwQmxVcmZEeFhOWjZpWk5INHI4RERF?=
 =?utf-8?B?MTJ0RndKb2FMYlhWbjJSbk10NVd5NGVXUFZBVzM5QnBiOHYzcHk1RTM5OUoy?=
 =?utf-8?B?cHZyUkVNblh0ejBOVk82UzRpbS9XYUIxVFIzamxxMTF6QW9BTFMrejNwTHpt?=
 =?utf-8?Q?Duj8vPw/GS0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K05GU1dRczN3QnhEMkUvNHZXeEUzaEVDc0V4Z2lQUXNjZ0krYlprMHVUT3Zn?=
 =?utf-8?B?NWVxT1hTMnEwYkd5K2RMUk5GdUV5SVlMYlRUbkhGU210VktaOFJmaGhkdGVs?=
 =?utf-8?B?TFovMlJwb1N0K3ZhbmVGQzZoSmpCYjZSSkYrNnZ4RzBBQ1J4ajVPVjRYNGw1?=
 =?utf-8?B?WDBhYnRLVTkvRE9XTmVKcE9xemRJTURwT1U0aGorVVk0bUJ2SGZUTjVrVnF5?=
 =?utf-8?B?NU55TXZjRmJ0YWV2OEVBdzdiR3ByeGtQUUoySE1UVlV0L0pQNU9VdE1lVmF2?=
 =?utf-8?B?SExUNlVxTDdtS2p3Y1pBbkkyWUtEcjNqT05vWERQRVVqMFlUeUhRTkdXWW5K?=
 =?utf-8?B?d1Y0dEFObDlXSW5zQWJWaXlJYms5NHFxelhkbTJBeFlyT0ZkUTdPNEVhU0VG?=
 =?utf-8?B?Vk9GS05ESUFxTkxUTjR0eVFsamMvSG5NTDlZb2k2MVVMVmliTW1YaW96LzJh?=
 =?utf-8?B?U1V6U2IxY3VBZkFkTlFyMlFuLzluazBIbDJuYnAvMy9kRWFMRkJmWDczazFL?=
 =?utf-8?B?SjN0ZnZMREd5di9rV0ZnZTZ1YVY1TnlrMU1xZ0wvSDg5OFRicTd3aXlTTmY3?=
 =?utf-8?B?Q0wzUXRRZWlPdWp2TkI2cWZxSitzaEp3UGVVOHl5R2dDMExVdG9xRWhQQVhl?=
 =?utf-8?B?bEk1RUF6aEpkRysvVnR2c0h0a3NiQ1BoaTF4WDFpWGdDMUtZcW1ZdUVrdzRJ?=
 =?utf-8?B?TDdRUklYR29ReUpYendqbWJyMjdkaUVOSEV2d0xtZ21EUHJVVHNXS00xMkY0?=
 =?utf-8?B?ckpXVTVjSVU3TEk5NTdYakRnNTFvRWVpSlh6TDg2bit1Z2tJSW9pbXV1Q01y?=
 =?utf-8?B?UjVjTndwR0lLalZSUnpWUjg2bzFwQnk2VXBNYjJJN1NTbTRicUE1Y29mRENx?=
 =?utf-8?B?b1AzZWlaOW03c2x3WW5CRnY5YTUzcmliWkRJWXZHbHAxVEpPN3R1MzU3V0ND?=
 =?utf-8?B?QjJ3VHBrZS80K1hmWDBkMGl6WW1nSjV0UEFHNVZLMUR1S3ZhMU5EekdHRlpT?=
 =?utf-8?B?eC9uNHMvRThBdjdRam9jU2JvL1M3UkdQeW9HZzBTTE1BcGxIaVhSZXE4QWxI?=
 =?utf-8?B?Y2NsUVk5Y3llWTlVbFBROHQva050Zk9RZlJuOFdUaTRiVFdLUHdPU0xSQWhz?=
 =?utf-8?B?d3FPeG82akt0d3V1OWhXcWhOeTFJc09lOEg0NlBkME1jUk8vMnlCellLVWZk?=
 =?utf-8?B?amF3cXo5dG9oQzhucWZtdmxVVEErczlxV0RzOWhDcmtrK2kvbVZsVjNoZ043?=
 =?utf-8?B?YVpiZ0VISStUMFhTNStWcTBWRjdrME5icmw2YTl2TTFvVmUySmY3T3V6MVlW?=
 =?utf-8?B?amdwREZlVTRJODdzU3dTeldSM3FIUDhlNzFqVkF6OVdWZy9VODFUdk9uZUxr?=
 =?utf-8?B?TitXT2V3Qit3SDRQMlozclRWZm9tTXZ2Ym04YlJGZ0x1N2M1L3BLSndyRW43?=
 =?utf-8?B?cGFUdTZtallrNy96ZWdhNXRmaVRDVjFuTGc3a1NBZVBSZmIyWjRxNTNBU3Ez?=
 =?utf-8?B?K3E2bmVsN3U5WkI4K3BudmFTN0RDQTJyT3RyOHFZRCs1bkhUdGNhblJROHBo?=
 =?utf-8?B?eC9mVGh4QTF3SEVZV0hoZndlS3pYdlVOdFRzZXErLzRVZUdncVFQdEkrT0Q3?=
 =?utf-8?B?U3ZleDlVSlVsZjRyZWpvemYwc3NyQytBVWJRK3UvNkxiQXdUOElicEVwOFR3?=
 =?utf-8?B?cmt0eEo2M3BjaTVpWVd1YS9CN2lmSExOVUppOFRHdWR5REJxQWFPd1pHVVlB?=
 =?utf-8?B?Q0kwSzdVZHd1REJZREpkMDR6WS9INUdJbVNuU0lEcXBzaUI3Z2RhSmpqUURq?=
 =?utf-8?B?NVJJQTZyS0NLaENnYWVQbGR2dG5xYnJHVlp1Zk9lcXR6ek8ybmcwU29VRHN6?=
 =?utf-8?B?bDN6cFJ6VUx1eWdjSEViT1BkZzZySlJSUGhSSDUyVTg3Y1dlczVMeFUvMHRW?=
 =?utf-8?B?UnpoT3V1OGc1Y09zUkZiOGlJL2lZeC93SnFlbDNFazlBMmJmQW9hNDZRSjcr?=
 =?utf-8?B?Q3czNkZVdXlJalBRamRweTQzNWpmUGhMVnBxc25jY2dYMTE3SSsxT01qdGlx?=
 =?utf-8?B?dXM4Q0JzdTJIQmd1Z0EyRGw0Ymd1TEZseDQzcHd5UTNhMjdjd1h1M1JoOFRn?=
 =?utf-8?Q?LHiqpE75DtiXr8N2SsO+mH2pl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cac63337-ab62-4771-66f8-08dd8edad87a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:21:14.5490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP0lvTLdg8uqq0kdaW+nMJb+/SSz9YDZF540tUkpbIL307RGN/KZUGvdDabwvKS+7d5aSM4yu/LTDBZwTbo+LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6033
X-OriginatorOrg: intel.com

On 2025/5/9 22:00, Wei Wang wrote:
> According to "Function return values and names" in coding-style.rst, the
> dmar_ats_supported() function should return a boolean instead of an
> integer. Also, rename "ret" to "supported" to be more straightforward.
>

seems just a recommendation since this is just internal helper. The
function was indeed not well written anyhow. :) not sure if Baolu wants
take it or not. Taking it may make history tracking harder. Patch itself
looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d8aa71305509..2778bfe14f36 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2760,10 +2760,11 @@ static struct dmar_satc_unit *dmar_find_matched_satc_unit(struct pci_dev *dev)
>   	return satcu;
>   }
>   
> -static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
> +static bool dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   {
> -	int i, ret = 1;
> +	int i;
>   	struct pci_bus *bus;
> +	bool supported = true;
>   	struct pci_dev *bridge = NULL;
>   	struct device *tmp;
>   	struct acpi_dmar_atsr *atsr;

This list should have been in reverse Christmas tree order per the length. :)

> @@ -2786,11 +2787,11 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   		bridge = bus->self;
>   		/* If it's an integrated device, allow ATS */
>   		if (!bridge)
> -			return 1;
> +			return true;
>   		/* Connected via non-PCIe: no ATS */
>   		if (!pci_is_pcie(bridge) ||
>   		    pci_pcie_type(bridge) == PCI_EXP_TYPE_PCI_BRIDGE)
> -			return 0;
> +			return false;
>   		/* If we found the root port, look it up in the ATSR */
>   		if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT)
>   			break;
> @@ -2809,11 +2810,11 @@ static int dmar_ats_supported(struct pci_dev *dev, struct intel_iommu *iommu)
>   		if (atsru->include_all)
>   			goto out;
>   	}
> -	ret = 0;
> +	supported = false;
>   out:
>   	rcu_read_unlock();
>   
> -	return ret;
> +	return supported;
>   }
>   
>   int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)

-- 
Regards,
Yi Liu
