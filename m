Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0D8241665
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 22:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440274; cv=fail; b=Df6IeTE9mp13ZZoXgX1Nb8k8p4IuS+gHY29NUKc7SFkbDZ8QFkazZyayPjKJfONJPway5Mh9r1rsbQJLnwDowNVhk7h/3de2Y7NYj0SrD4A44HEAbWPqiQKfbQLEhgO3VsZOHPaPOofWTaDK/5cUJEaZKg1p66AkaVpV++Hnrwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440274; c=relaxed/simple;
	bh=gK9kV1zh6lZ7ltPhVX2JQ59iyHwIl+ZfdyyUKp9tbYg=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=tEadVRiFSA3anA/oX3Bsdy0vYwrc1QPMd9Q5Ga340wRXgO3EpSW/liV7pLtSlpOk/KtgjTXuiKRAjzbNPgESFocXipEtp0kLtzoi2OlSBV1DBsUum/Lrf1FPyNexxGpr3juv04E7gm75FO0Os7+6Cyrhw0xYPctm3oLne7CINjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hTKh8Tt4; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hTKh8Tt4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773440273; x=1804976273;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=gK9kV1zh6lZ7ltPhVX2JQ59iyHwIl+ZfdyyUKp9tbYg=;
  b=hTKh8Tt4s+7mxds8EhCnSMij2LW+eOVRJLUVba0KHYiKnH8Jk7yOaiIc
   PxrcI6EswwRbLJZAJeRY/4sUFYCLmXHj3h0exDAaDvL0lnZqLrIdKrKpF
   4YEFRyyiojATPBSReljcRaHlkNiocJ0T/k0uTpSbdMymtWqD1OcBwYAER
   DT7JVlfi5SDw0nNXQ3CKAi6GM+0dqAkF0RUy01glfYf5tO/0z53YCovFy
   gbhDXj31gYZkIq+CxjJV532/+Sk+eJwUPu3Er0I4qrroslMtZEZjJ4kQd
   vBebFinS0M1b1q3MvXAZ+FMQ8/hEjkbTlwPqP1f2cHD0oVgr4Jj/7BblD
   g==;
X-CSE-ConnectionGUID: pEUc8es4TuKstEx2Lvpkvg==
X-CSE-MsgGUID: 68GX+MwJQJKMATZUZL2DRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85909367"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="85909367"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:17:52 -0700
X-CSE-ConnectionGUID: fDRul27+SIOdODpNtBZ/jQ==
X-CSE-MsgGUID: ofEzsMjzQ3Sq2t3+jmidzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225407275"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 15:17:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 15:17:51 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 15:17:51 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 15:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a/U6eAKmeFWvnHry360+8jsW0sEcoEHwSDtxlaweYXFkMjNqDM/un0FE5Gj81lX9jsvLyIuF14uIYOIhx+lCzx8CdCBZEavuhPQNoxUPXeCRU3ZQ8T3Uv0peVrJj+WDhX1e/i2hdrHUMbN+uJ9QK3l1tKcYYEWUTK1FZLi/VqOONK7FWLmcrI21/+CfzDVTMDnvyPbIkzcEr+QVJMosaiilB/n4UD99ziqYyIjqkw4JiLrpynpOZcvePjglIfmQSGjaq5GXRWQd7cbtXTubycKtlWLwzbuw06Chnv+qD4bXyxG1KUeenx6Oy1fQXorppFvCrsMSBf82hN0WTiObz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDOOjL7UL4Kj+QEmk4viQLwuRELtEiApnVzc4K/9bkY=;
 b=Aa3es6R0HEogZMj2OXjuJ6wW6LVxSZDdHtQN++plDtulcDnInoE2kwVi8wgbfhyj+8tTfRI0LpDT9K4VxKlq/tzG7QyyC/2Lgi5DFfH7eEXTX3WOsqmrVjRx2jJUMukqlQnK7Itp8HSXoX0rScnXXQAF959SBXHoJ13U6Y/yzDAiiQmpssy5pi6X4EZz2GuZc31DcIuBfg/wTyyl1zWxGbruj4EzzuR1LvXeJvXdmagBqQKJ4D6YokZsSxPWAmJWaRB8drbaplQL/2MFElpiEcgUhvIMF/MoLWP5x1LfJovYFO3FRfw2o/EB0JJOFemNBRYuHCzALwrKy0ozb+8pYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 22:17:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%3]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 22:17:48 +0000
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 13 Mar 2026 15:17:46 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V (Arm)"
	<aneesh.kumar@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Bjorn Helgaas
	<helgaas@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Dan
 Williams" <dan.j.williams@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
	Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>
Message-ID: <69b48d0a374a_b2b6100eb@dwillia2-mobl4.notmuch>
In-Reply-To: <20260313184957.GP1704121@ziepe.ca>
References: <20260309111704.2330479-1-aneesh.kumar@kernel.org>
 <20260309111704.2330479-4-aneesh.kumar@kernel.org>
 <20260313184957.GP1704121@ziepe.ca>
Subject: Re: [PATCH v2 3/3] iommufd/vdevice: add TSM guest request ioctl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0031.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::44) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb2e1a3-1dbd-42c5-0ed6-08de814e5c15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LDGDmmVHXob5pA2hdDoEqNnigRygx3XgD8KOG/Sd/cFrLQto3n7USYP92FjtL4PaDT1CNl6vz4vMofvz39ltXcFU0r73Se7sfaNnXb9AWZ+GW4JyX9FT4+vjwoSjwLD9qrE02wwICbUua4nx3c4dsbpUQLsetafnsSUBY8wK/QHnItAJ0ADDincrGqIzxMkbtAtIrnnuh6bD4vmV9PWGi3Hhg5svU/OZwIyPgEGyrhCFJQJkWgt+2VCMk7P1GbUq0Uhrnjv5ghS73q59kReOdHNK+1se9DCes35/7l11XG9zlXxiAsHqlwSIw6sC+ZdkOLCRjgaAIeOofoJR2apdBmBWsXXfmjQgMmgkjk2JtLBS+RfKEpEFhwTvBoUXu5SUxc7BOzIc+KO+/OfX1LdiSZAY+UKW/dQFZao/AyDEeLqH0npvK5nk4CubkLlWPUrpMfCxD3urszvzX0ptCZPcp/nGQL0HKX5GbDngySHo/pxZUPQPOUYSQGjiJ7DpOcZ/OX5VRKVpPkhAbwP3DdnCXy4d3EV1Dkn6k+xJWAdcRGZABNV7M5YdA1XmMyg0G/KfNpF+1BwNjO6qz1hHqlx5H/t0eY5JhjNBvp30iVysmM0vvLn8gr3Ke+wStPqd7Wyk+f05+sdSECDnRiE9a1/C1AMIOgGHEPtXe/fSLNYTua4UVAqfKcoPrHW2J/2H3yyc5PbiRpfr6O8b6axaTVH1i5KqaiTjZ2vdYJhGhRB/w1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxnL3JJNy9QdURYM1lYaU9zQ0wyUTVCSnIyMlkvYjBDS3VZbDlpemJxN0tn?=
 =?utf-8?B?UmZqS3VlTWwwRDdHbnZvL0MybjF2d290RzZCMyt6OU1KOG56UHZKRnkyY0Fp?=
 =?utf-8?B?WjFDQUpFZVRkTy9kb0dJeWhaYm5ZVmlTQ1EzdVVzVDd5bGdIZ01wblpuTUs3?=
 =?utf-8?B?a2pBWUE2M0Y4cHE3dm9BUXVrSnorWUE4MXdDN01TMElKYTNPNCtLZTlJeGpY?=
 =?utf-8?B?UUQxbmFCQVd1NVc4dWJPaXJ5WE1RU0loUUNIM1NOaGtNTTlsMkVpZkJxZGZh?=
 =?utf-8?B?MzJaS2pndGJuOUQ5YklDaFkyd2FvZ1IrSjNBWVdFdUxkK3hKV1oxU0J6eFly?=
 =?utf-8?B?WWNyNGpvSXdnVEtVS0d4T3NyVm1xNVZhSHFILzc4YVI3L3cydDBMdEs3T1Jq?=
 =?utf-8?B?ditmMkpSWHRFTFNrSVdmOGJQYjhoNlpKTkU0SENTODcwdlAxMlJyVFZWKzNW?=
 =?utf-8?B?dHpQWUN5N0VCK1BxQjBaTnJ4ZFVaMGZleGdaUE5ncGErOXdKaVhJTGZKQXNp?=
 =?utf-8?B?KzVmckpaT0FBeHlNSWdlWGlEYllFS25haHFxVENSa2dRa2tUYTV1eFdxTVNY?=
 =?utf-8?B?SjV1aHlkZGI1S2dzNVNkazJwRmJGdzRwekxGVzcrdWpzeFVKK3dSeXRYZFhu?=
 =?utf-8?B?K1puMHR4Z3FvOTZnSldmZXFuWVp6Wkd2MmZaM3lXK0p4Q2dmQ2ZTazl0YytV?=
 =?utf-8?B?MFNWd2MvV3lXb1RkUXR6OEFFc0FhYjdiMkdoZnJ2a3VPY25XdDFKWGdFTU8y?=
 =?utf-8?B?R1JNYTlvdDV6TkpTdnIwK3dwM0Q2UHkzRWFLWFlsMDVTSEIwVU92QUtDMlph?=
 =?utf-8?B?VURVYUFiRWRpY3p0QVFzam80WmVNTEtEMlBSZHJsdUV2KzN5OTVieTc4MWFY?=
 =?utf-8?B?NkhxOVljNGpISGduOXhIaklCanl3QmJ2MGgyUmtkNDV6VkpCSk1xMlpVQ0xp?=
 =?utf-8?B?d1dMUWxNQXA5aERNN1YvQ2hQaktBbTM1NWhGUXZ0Q3lNdjIvdzJQRG9OTmpD?=
 =?utf-8?B?K0RNYjNZS09ia01kMGRVUTk1UTIvTjdEdHV0Y2xrRmdvMWJMeWcxUmQ4UzNY?=
 =?utf-8?B?RHpNUkVlMFR1WWtQN3ltWVdpVncvb3ZPZFBxRVNLMnh0NTM4NFY0U05ZTzA2?=
 =?utf-8?B?SWJyVWN3SklnMGswQmw5TFhqR2ZweUlRaDYyV3hmUGF4b3RJTDZOTldSYzlj?=
 =?utf-8?B?eVowQ29ndUk1ZXJZQTNHVlROaEh0MDdBVGFreVFNN2N3ZW9leTFEMkVmVGZi?=
 =?utf-8?B?TFBncGVWYUh5c09mdnFrWFp0WmdVU3Y3TE1nY0ZhS1pTS3NOWGMwKzNkcGQz?=
 =?utf-8?B?NzVQb0lYbHNtaHBhWDVRWFp2K25XZUJsbXpDNlowdW9obkYwRm5KdXdFakUy?=
 =?utf-8?B?TlZtNDB2NGtTdmhySi9wWEcwV2g5VExDV0Njb3Y5RjkzajlaQkU1ZzNucVNM?=
 =?utf-8?B?SHBraFRzK0ZUYjRtYTRPcjdVTllsakVJYktoV0tOR2dwQmhXMVFlU1FGS0pM?=
 =?utf-8?B?NDl0cDBrRi92NkNPVmRsN1pXSEd2VDNPbGVtWmxYNDdBM1FUT3NNWnNjTXdl?=
 =?utf-8?B?MFk0c3JSanJMVGxESDlTVSt1OWxWYWJBdW5JVHQvRG5obHU3MlVTTFBRSmtH?=
 =?utf-8?B?MU9RMkRGQkYzRzBoNXZNRkExdkFZbVNKSTRwSko2bC8zSDdteGV4ckwyQjBR?=
 =?utf-8?B?WHdFUmUxUkpLL3ZpaWk5V3E5TTlPMmtqZU50azdxWXZkYVE1NmgwVEF0MFdS?=
 =?utf-8?B?VDdkNnhIaWdjcGVGT1d2ejRhL2RJTDdRU2xNc2RnZUlaTndxMjN3azdVNGkz?=
 =?utf-8?B?ckw3OUFtbjR4ZTcwaVhkZjlZbUtkZDZFVzRBZjg3andMRWdlcmdOY25MSFBI?=
 =?utf-8?B?VDIyVVpJbHVtYWRuWmxGbmYzWFI0NVIvQ2E5Ylo2TFNGM2xGWEhPWEgvanBj?=
 =?utf-8?B?OVlxU3IxOEIzNjFKbWNGdElVWlVhaENaTzBQazdOaFVYZDFOZnArL1hWR1Ir?=
 =?utf-8?B?NmhkTUxlOHdRS0U2VlNESTY5c1lYNE9aT1hseHljckFiNEhvc2FZTUM1c0hq?=
 =?utf-8?B?SHgrSzlUZVpYb1FzN0tPUm9HWUFwQjAyUEdHTGdqenB4ZWNuVXBHeXV6ZU4y?=
 =?utf-8?B?UkE3dHQ2bFRYTlE3UmlYZ0FlNmUxWWVITm5oQWlYSE9VT0VLZmI2VitUbDQv?=
 =?utf-8?B?bzBFWHkwY25ZMis1dkV0b29kR29oTS9BczFKMU1XM2pHdFBBa3JqL0puZkxk?=
 =?utf-8?B?MW9leXZ1OE9Vbi83ejNROCtCRUdscGdVdXRDMnJkYmpmTTVYSGo1MUhKQm56?=
 =?utf-8?B?ZTZJRDBDemZDMDdSU2dzR0EvOXh5eDJYbWtTcW5hZ2VqeFpVemkvRmhySlRa?=
 =?utf-8?Q?0CVrHhJyEME80qVs=3D?=
X-Exchange-RoutingPolicyChecked: MT/imE/qkRU97/BWAPc6OH2VjBvM6+OFBhrM78pUtV4qkjUi2XG1KUaBOeS9+Yru6HnRr6ovunqEtEN+34eckP7U52KJAlXZ+RbUlOmF0WzD1QbT2LC+IaffZGs5KeJny9nvohjw3jabDqc08/0DdEoGNflQ769RedOKDN9AjHmY6run87m90pdkgHxm+tDZVMaU/YSdxFmzuZINzakD2Sdd3HKmK+B3r3ScvzpZzBRIPMW4ZdbowYzixXQoCOefNnJeKhBzIY7dzwSOJ0Om5kDcz3W4WG9AMjS/zvJH0llibKKsmBk6t3jyrib9joeb56QiVkJPbH42dZBgaGSl+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb2e1a3-1dbd-42c5-0ed6-08de814e5c15
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 22:17:48.7435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftBoBCxzizPknMnCARWv0JGX4iPV9W5mM52bcpxmXTP/Zdf7FFgcJ/wPul2HVV1rE0FgIgrgUGrOq48gYN1NLLi+QL1Acf1wo4WtGOnga0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com

Jason Gunthorpe wrote:
> On Mon, Mar 09, 2026 at 04:47:04PM +0530, Aneesh Kumar K.V (Arm) wrote:
> > +/**
> > + * struct iommu_vdevice_tsm_guest_request - ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
> > + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
> > + * @vdevice_id: vDevice ID the guest request is for
> > + * @scope: scope of tsm guest request
> > + * @req_len: the blob size for @req_uptr, filled by guest
> > + * @resp_len: the blob size for @resp_uptr, filled by guest
> > + * @req_uptr: request data buffer filled by guest
> > + * @resp_uptr: response data buffer
> > + */
> 
> This needs a much better kdoc.
> 
> Refer to specs that define this.
> 
> Explain WTF scope is

I proposed @scope, yes this needs more documentation, but really it
needs more discussion first. It was inspired by 'enum fwctl_rpc_scope'

Guests that are moving the device through the TDISP setup state machine
need to ask for host services because only the host passes messages over
SPDM in all of these architectures. That is, one SPDM session per
physical device, not per assigned virtual function. In the AMD case
there is less guest direct access to the TSM so it needs to pass
additional messages that the CPU mode based TSMs do not.

Those requests are varying degrees of: host kernel cares, host kernel
does not care but can see the contents of the message, and host kernel
does not care and can not see the contents of the message beyond
envelope.

As far as the host kernel security model is concerned this becomes a
opaque implementation specific passthrough. So the role of @scope is to
have the TSM drivers declare the security model for various messages.
Put the explicit onus on the implmentations to declare that the
guest_request operation being executed in response to a KVM exit is
contained within a given security scope. See 'enum pci_tsm_req_scope'.
