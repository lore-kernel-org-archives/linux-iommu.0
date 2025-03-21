Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9D5684
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517613; cv=fail; b=Q3L16Ksa3vZlGF01fKGgYliUb1UKB9H+oiegY1ULqn1Q2GtVlBR4Fx4pVBT/8ZeiFkSKLDXHcZw7cTc+vWcuWyfzLqpCOjffCqwVrGgMvu77LoZ/iMfXFSPiz3B4UOlp6m4QKfOUaHUABbWNnafT9Te3GJ/Ei4kCkJ02pMwQ6vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517613; c=relaxed/simple;
	bh=jMM5SZrmDoWfORRKvY9e4tTwNkiIA3HM6m6DTn/Z5Sw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M23MRp6l5CqB0zb7IHQw2th8HtZCrXLs4N3WLWqVteVNs+9XWUhTVwRBv8GC0jAB3/azRA9J2Zy5BP4elRk3sVk2MKqNdKfos0/B7/hF8rlGBMd+2eID/32kRX+mobdWeWxugfH7Fv0hLFv52c3oTZGvROcCJO/zAJ62S1I5hIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BONNS2MX; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BONNS2MX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742517612; x=1774053612;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jMM5SZrmDoWfORRKvY9e4tTwNkiIA3HM6m6DTn/Z5Sw=;
  b=BONNS2MXqoZbgkAege6gCohIS2Lu/IbVMpZ9qzJ9UhTWnHryEcPjLU9d
   EGjCaR/fI7+9SXkYYiiLvGCjtKvDrP5Nn86BtEynzxG8Pw0V41kH5+Y3u
   g80GVXzZ8PBsESUGF6VSpz3mLaCL5D5RAF1kKAewJevcaVUG3xfFgSxdi
   HEoZrgF4vbTStK65oQWk3RekG+fZyLgLR7Nab3Wz+JCJbUOp6nEYV2hd7
   Gv9rw9i4uko7jP6yZBj6cCp/xsp/gqjHjAFYy0VwGouBfBoZmwqt8pcgW
   c3NU+VOpShXiSwjUdlzfUP8lzPCDK69LxqjEDRb22EEokNUHSkY10+8Y7
   Q==;
X-CSE-ConnectionGUID: 32uUUoNbSLu/kThU8+FcaQ==
X-CSE-MsgGUID: 7KpmrpMuRfGG6asZ88DjzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="54770299"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="54770299"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:40:10 -0700
X-CSE-ConnectionGUID: DwlpxG4KSfGuIbpkTf2V9w==
X-CSE-MsgGUID: ohrc4r6NRlWVSnCtMMSV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="123426756"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Mar 2025 17:40:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Mar 2025 17:40:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 17:40:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 17:40:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMnT5nd3y/C+c4CUo+XZXfF7URxuulFPjZ1PsO6Ncxao6G1JdNqsAntMPnWIXkh/GrENs577K9lAovP4kdLUGI8B1mHtygXxjG4V+e1Mk2+HkVGR95hkQ1aXf9vRuMy8g19QIXfOjeENVdC7idQfv8i0dHRNs88LlXA2pJhs0cnsrycOiIYP897Risdgr+YpqhyNFM7IgQM49+I4XgC9RCBmvLzD9FZzdaEWfmt2JRHSvpFr/8zHwdyV165VYJcRLPWgkeqF4N34s4fj40VMWHVmmFEvhV7ZMcDfHf9irrFtXvCHJLEjZijVkGReFcdvGtPIRfJmgoYhDpMSzpqypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSa2Yt2OdF4WUV+xhLfFkuEdcemJeSedSfzuv0sWMPI=;
 b=Zb/Sj40aJ+JNymM3jJHoaPELcCuMkAZVwZ7oG4JW4rwtvHPz72vNrFXIhZp3qyAm4NH6evxH9rzs/pDUQqchJCFoPvmf2EXwbv2R3/i5vv/+D+4w8MZyqE7y+UJiJ9R6kKL4IyVCN5E5HV++j3NxMnON+ehyAjLzy7xeq/5ylm16qvB0uXlcTSrTuR4+4T4a/t4T1sVmVmknauGh2xTkiqYL8IYTWoXDmDaQxDQvYWZJHJJQYQqi7h8CROGgI+3vn6r9Z33BDBIINMDbmrRY44BzRMCq37CNJ5ZH1XD8CnNQl64FIRtQMObMFwSXuaERVWhoz+VckoYSMPfrH19Jhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 00:40:06 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 00:40:06 +0000
Message-ID: <9d6a435d-cb9c-4dd7-b6f9-805dee181cfe@intel.com>
Date: Fri, 21 Mar 2025 08:45:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/18] iommufd: Enforce PASID-compatible domain for
 RID
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-13-yi.l.liu@intel.com> <Z9yVU0GSbl+b6C0y@Asurada-Nvidia>
 <20250320233150.GP206770@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250320233150.GP206770@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::18)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: deea892b-5171-45ed-dbae-08dd6810ecef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWU3bjIzYWhuN1M2U2lscTNJbGdRN0NWN0lYdDhaS2ZPQklLSEdrSytlMGNj?=
 =?utf-8?B?RWtvUG1qUkdWQ1NFcTFZNXZvekgrRThQQndZTlhpRFBrZUtadkR6alc0c1V0?=
 =?utf-8?B?NkI1M09GRFJOV1hQLzZqV1ZwWXViWDhXQTM0WjlYZjhDcSthZ2RpWHU1OHRj?=
 =?utf-8?B?WHd6R2pvV0xvMnpFbjZxMEJmdEt2d2tQMWV6cUFFNHlBN0lqQkVEY01RRlEw?=
 =?utf-8?B?N1BjcUdHL2ZISXdPY0NndGRaMEpkNlRpalhJWFBVem1xeFoyNFBGVkNFNVg0?=
 =?utf-8?B?bnFicVJtTTYzcUNHV1RaZFJYMVU5ZjNjYnh3eHFidGxVbGNyU09qM0tkdTBP?=
 =?utf-8?B?K3FMNm1JV09zZ2V2anBhMGpxRW42MEJKeXRSZ0dtd1V3cDFoZGFibWVtMHJR?=
 =?utf-8?B?MmVUZ2kyVEdMMVBpellDTWJ5UUVmanBpdU9CTGU2QVRQNlFRREJZUjE1azdx?=
 =?utf-8?B?bURNQWs1eEVNODVLalF0M2RIVnZwTzh0eWFWTitUOS9SMUdXRE55SVFSZlJI?=
 =?utf-8?B?dFVLUDgreGVuVlVtOFBGWURsblZZTkNHcEtHaXc5RFlzaHhhZ2M1ZE1OV0Za?=
 =?utf-8?B?cExveFp5bTVpMU12VXhmSWp2WmU3cnpxQStnZ0VOQ1U4ZDBJYmxuVnUzUDhS?=
 =?utf-8?B?aThoSTRjZllmemhDN25nRSttVE1iZ1hXYTU1WFZSYVgyby9QTHp5cDBpOUw0?=
 =?utf-8?B?ajRjS3NsZ1NQalY3bGQ2d3Zyb2h5OWh4ZGMwZk4wNHN2SzN2U1VCMW9Xb2Vl?=
 =?utf-8?B?WkdEa1BIRzhCNGxPMmNuM3FOSkVjbzU4bVNJQlZDLzdTakl2cTl2dm4wbitQ?=
 =?utf-8?B?TnQrU1M0R3lUKzM1QjJrck5mY2dvODZVL1J6VlNYUENQTDVVZlNyNVpHMXF3?=
 =?utf-8?B?QXFPTFhkMVpIR3pSUTEveEVuTm9SbU1VaXZJQTJwc3VraHNrbHJaV1QyaDdq?=
 =?utf-8?B?clJDa2pnQjFnTFFKbWl1OEpQOWRTWk5hNzdnelU0ZEdscSsrM3liOHBFQjls?=
 =?utf-8?B?eU0wYU02OGc1UVJiRGY5R20yWjJERi95U2xpS0pIZERvandWSEwrcVg1NCtW?=
 =?utf-8?B?T2tDUDY0OWFlYjU3N0N1ZkpQdjJUU1RjNVBoTEl3bE16a2E4R0NkSmFTaVds?=
 =?utf-8?B?VFlxSUFUQWdLY0ZpY1Y1N0ZqODhKYmozVUlDYldYQTdPbUlUU2NnQmFhSHJV?=
 =?utf-8?B?MWJ2K3VwOXFUbVNKeEFFSGVqTTNOL0t6eEJ5WXdTdnQxWnFOZ01Pa290enpp?=
 =?utf-8?B?UjJFTzNtaWp4dHVtVnZ3elBGTHdYTndNeEJuVkUvbEJvdjlLY3hiL2pPZGJr?=
 =?utf-8?B?SlBTSTlOZWt5VWVxVGprY04yQnlCZ2NPV0I3eFJ3TVp2ZVY5a0ZvclBRT0Nz?=
 =?utf-8?B?OUw3UGhnUmFPZjYxUnpKYUlaOTlIMmRERFZKWFJaY2JhaWozTVptL05GT2VD?=
 =?utf-8?B?Tys0bGRRaUVMTU1FR1kyRk5hWU4wTDdxVkcwUXllY2I5VExpaC9jQWhsa25u?=
 =?utf-8?B?NC9nVitZUSt2RU4yR0Mrend0NUpNOTd4MGZ2QVFZZEVSb1d4bmZFcVJXam0w?=
 =?utf-8?B?TDJ6Y0lFZzBBdE8yc2FLaVFhaE41RW44dVV3NHM4QmhWcm5qc2x4cDU0L0dU?=
 =?utf-8?B?TWxleXlYWDY2QXMzOGUrVnBJYmw2WG9Ib2dZVkNnWW5GOVdIM2dxbVV3VUZp?=
 =?utf-8?B?Um0yU1AwRE5EbVRxS3lZU0ppU3BxbGxUeDd0aW8rWU1OdlZTenVvZTJxTlRo?=
 =?utf-8?B?K2w0cWlYRGI2TTRDRUxrem40T0dTcjhjdDFhRHd6c0hyd1YweFBoWVcveU9n?=
 =?utf-8?B?c0FqSmdob0FEaHh4a1IvWjQrWlRPM1gwYndrajgyVStKOTFwckM4T2c4d2li?=
 =?utf-8?Q?E8LSq/muCgtXx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTNNdDdBeFVOVDE2eGNGZHNGNkdNWnJwelo5ME9YYWQ4U2hodWQ3cWd4WUVa?=
 =?utf-8?B?bE1IMGRXakw5Y1YyY2hyQ0RBcER5UmZSUEV0MHRvWjRHcENSY1RBUEh2Yjcw?=
 =?utf-8?B?ZThONE1QTFJPNWFYRE9kdnF5aHlWd0dCdkZ5NlZIOTF6RXB3Q3pGMGo3N0Ey?=
 =?utf-8?B?NTc1YkUxS2ltVStvOFlUV3AwYjJOajlqQkl3M0RFb08yWEJIRC83SUtYcEFV?=
 =?utf-8?B?ejN4Tkk1emtTcG1SQUQ1NmNhUlpLRzJlTmthWitocTdlanNNa3h0YkQyNHJs?=
 =?utf-8?B?QncrNWtKVzVaMVI5Yk5sKzJyNzVMSURLVXcvcVNidUNBMEdZSnNRY3lvWjVM?=
 =?utf-8?B?dEk0NWsrc09CTk42TkVQUG0rcElLV2RMamNpNDNubllYcmYrNXk0VU9SelRD?=
 =?utf-8?B?L0VGS1UxQTZNaTBSSnJ6VjY0UDRBWk1aR2llbXNhbW5SN3hFa1NCeUFUM0lY?=
 =?utf-8?B?MEFJR0NURnJobU1HQTgyYmkxY1NSNEtoY1NUTy8rZGY4NVBvT3ExcWdCSWI3?=
 =?utf-8?B?dkRhQ2NkYWVsUVFRbFVkVHk3TkxpSi82TDc3MDI3OGZVTDBOUUthemtDVkdS?=
 =?utf-8?B?WlNudHF2TDFPeVA4Y0cwa1N6WXFYSUlXM0lRMUQ3dEZmNUM3U2hpMkxJamwy?=
 =?utf-8?B?NU54L0xSL1FycHZxUkJLd0ZVZmdHcHBvWFl1WmVyb3k4anAzb2Q0SEYrMmQz?=
 =?utf-8?B?S3NJWTNzUzBSWDFGcjFxU1RWVEhnRDFhcE9xTVhyZW84UVk0dmZrUkw5UkdQ?=
 =?utf-8?B?Mmg5NUQxbG9kQVNVREF1azZkN204Y0NMOU5KQnhYd1pYaUxBNlI3MDR2UEl4?=
 =?utf-8?B?UG4vcktvZ0JQWklGSkM5RitiMFYwck9iTGUrQVVNVU5IR3dJNFJZK2Y5ZUJ1?=
 =?utf-8?B?MzJGbUdCWDg3NG5uRURBTEZ5b3NFdzlTc2RDSGZRbTFzQWRMODBPbENmdk9x?=
 =?utf-8?B?Wk13cEdFRDFBQmJZdjVPZXUwZSt0aGt6OVpSZ0gybVc4cTAwV3BFVWpUSGNU?=
 =?utf-8?B?d2ZCNm9xTWNRUFMzakhZTGxweXNyNXk4Zm5ublcyTkx1RFIyUnBoK3JCZ3Nh?=
 =?utf-8?B?TlExOTlXYlJSQlNvdEtVM0pXWXVVOGlSY3VpaU5MWGVOUm9JYm5yR3Z2Y1hl?=
 =?utf-8?B?RjBHeXdsdkdqTlBYR2hpc3pua2QwMUFCTDQ5bWhQVlVaQXRaMnN2anFCd1Bk?=
 =?utf-8?B?Z0VWNG9FVmk1SnZKZlJEbjlFeUV5OG5kNWhKRFFXazhBN3Nrem9iU3hQV3F5?=
 =?utf-8?B?SkIwbHE4aEVGdlVhc1N2V3Q3cFJYZkJBQzljdmsvQUorR041Q2R6cjk0bHNQ?=
 =?utf-8?B?YlBnZ09uYU5pZ0paK3o5Y3gzSUhGZENZcnQrMXNGQzNVR3NnajVFWUpkNGtx?=
 =?utf-8?B?YUV6UGlPQjdCYWx4ZUFveFkyVXEySGF6RS9Db25UMzFLY3l3YUJ2Z3hBeHlZ?=
 =?utf-8?B?MHo5MUV0YSt6anBPbVJjVXhzWVpQOXlleGl6QW0yZ3RFemJmYUJtL0tPY1kv?=
 =?utf-8?B?aGs2UTlZTlcxWi9YbDdCWlBSTzZhKzlVVTR6QkZpbU5TcFhYN2VJQmhYeC91?=
 =?utf-8?B?ZEJXYndFcDY2M1NpQzlLQTVBUDJPRlBzTElXdTF1MEV4ZTN2aXROL3FCUkZw?=
 =?utf-8?B?R2JUQTh1aEtlV0t0V01ZRWdVMUhXUUtaYzhaaVNFQWVPNkRKYWJPK3daV1ZH?=
 =?utf-8?B?U1hwRk52TjhrektSY2I0MWFROWNPZ1l0bVdyQ0lVUUcxVTFiUE9jQjBSMlo4?=
 =?utf-8?B?YmtuWHdpMFhLekhSUThmT3VSRkYwa2Q2WmwzL29xZWtlSGZzbHNLY1VQZDZh?=
 =?utf-8?B?MG9qWk1RQm9PT1FyY1RObHJ4bWM5dXF5aDMvMm1jeUtkalEvbW1GR3B2enhs?=
 =?utf-8?B?K0FNMlVXNTFoZUZOb0ZxNlBTbk1QV2RvVTFpK2NCcVNRQVB2R3pSMko4d2VR?=
 =?utf-8?B?Y2lvMFovWmF1OHR1aVR1eVo2Y0JCeW5PbE9hVVF1NkRTbkpLVUNPdjVBZVNE?=
 =?utf-8?B?TGtZNGFEQXdjOGF1ZWZpK1hEVWlUQnNqN1JKb3Z2T2RLdGRFRHh6V1lja2J2?=
 =?utf-8?B?cHlmTkpvS3VtWFVMdWJodEFuYmZkRCtsNEw0VUhrRXNCMlF0b2VrdTNNWldu?=
 =?utf-8?Q?vjK616GNzNJmoFg275tMssTRi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: deea892b-5171-45ed-dbae-08dd6810ecef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:40:06.3778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gajB00/otPJJS2WfomlzBHeyxtpzp2xb9UxoWDl7PqMyl48s6ZdqNXzmn5oEx/hCpeitD9y6OfVz1ERvM9c1Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8451
X-OriginatorOrg: intel.com

On 2025/3/21 07:31, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 03:23:15PM -0700, Nicolin Chen wrote:
> 
>>> +		attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
>>> +		if (attach && attach->hwpt && !attach->hwpt->pasid_compat)
>>> +			return -EINVAL;
>>
>> Should we also make sure that RID hwpt is attached before storing
>> any PASID hwpt to a !IOMMU_NO_PASID slot in igroup->pasid_attach?
> 
> AFAIK, no.. If a driver cannot support the combination of blocked on
> RID and a paging on PASID then it should fail the attach.

I think this is by architecture, not need to really check what the
RID path is attached. right?

> smmuv3 has support for this so, and I'd expect the same of other
> drivers.

The VT-d scalable mode allows each PASID (includes the IOMMU_NO_PASID which
is used by the RID path) to be attached to different domains (blocked,
paging, identity, sva and nested). So I think intel iommu side should
support it as well.

-- 
Regards,
Yi Liu
