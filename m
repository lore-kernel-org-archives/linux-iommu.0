Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3351F91FF
	for <iommu@lists.linux.dev>; Fri, 17 Jan 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111128; cv=fail; b=UJZIQjH6fCC8XSHCXT2jf2BkjYPYMMWxkQksHg8uCFXPyB6V1RZwiOocQx1bkuPrpNDvp495CZ3ArJl/ep6uD6oj9rVW61CpcNVuS5ZNtF+JIugcNBtW38AFHLvXH9S/yKsr9XAlmiAG0barCevG6F9+03bEbLWNMQ1g01yG+D0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111128; c=relaxed/simple;
	bh=yH2yDepAOIL2v32BRMvKKJN8GCcUyoebJGWD5PhLZkQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BvBjKM+5kNgI3LKvMM5qIkCBHmFr/EapyNBaOBGbwiCHic0n1ZlriMp0yY8nqsDhb3y/bjOXVAIkY4clrpct2Q2dPin6dvkxs/DrgIUP8dafM+sX3Xz+lHOIcO6VuuIZmn2rLp9KU7CD6xiEOvApQtAZmM6ZE/sjz4lDL18UD6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEm6dzi3; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEm6dzi3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737111127; x=1768647127;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yH2yDepAOIL2v32BRMvKKJN8GCcUyoebJGWD5PhLZkQ=;
  b=PEm6dzi36rKKbhs+uPe7Dkks0KfLmDJZYaRrqM8hk8sUzZwvvVObsHnK
   6WlGazNHX+5Ksyfo/LilX9QOuT8HwOSwttCnukqReb0E4sSZ9zSEgOmix
   PdhCp22GNg3M1RnKp+YPl/791/gC3BpqlLHUdnmX9vL8PhSQMKL7/hipe
   I294P5UVY21ECsNgqamUNqfl7YZFMElkTtJJTJvfH2j+SPT7lsyoreVRO
   tG3eb04jRyugN6F9ZtFrfAKW5a84fgvkoyVkwHa5k9izW+o8Cyc/clrgi
   kT9i6EXLk4/C8RhT4WjSk32bBKqVxdZMeeF2euZVgDv+Xxe6FDZBaWjPe
   g==;
X-CSE-ConnectionGUID: MRPFb7FvST+x1hKgnU1Tqw==
X-CSE-MsgGUID: aS9gjJNaRIuQ362EW1Ojyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="48202810"
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="48202810"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2025 02:52:04 -0800
X-CSE-ConnectionGUID: bxc2SH1VRcGRmhZwL21r+Q==
X-CSE-MsgGUID: xYhBh8dqRmiSsQRn5JJj+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,212,1732608000"; 
   d="scan'208";a="136613678"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jan 2025 02:51:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 17 Jan 2025 02:51:57 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 17 Jan 2025 02:51:57 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 17 Jan 2025 02:51:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJhrI/h0CgIVGmxrivUcYM7mmocaNkQr5BtOzacvyNrEd6AWwN6xK5DZ2LwA0XQTBZI7eMZAgvMnepM8xkcC7585PgQT9lqjCPx6u1ncDp+aR1kDj5tWtIO7qQeufyOaasRHua64JQQssxk+BE/cdHC3zbkvrkEnML64tHnR1DANvlY69hV4RcJYUy+yky164XTDLDIuWC74jUGArmRN5lAvbgygY5/cECB5p33+Sy+nkiSwW/hv5UuTyvH1loJJJESdwogT9G3BeQVUshZOFEfQHuJ/Y6vmh7ui/+rlceGes3o//35TglBk2oct4qay3oaRIkDzZ6XtcrwOmzbcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRdv2HbP3MqKEW48kdzbkF8PDEWCyykIiV+RxLCS+6w=;
 b=R7K1dk+2V31TO/RDXUdY4/vtCQZ+SzljCoAA6CRpyDHK3TS/Gbjlna5jMjfcM/V8xrYLr7MLO/yfa/RArWH8EUSM3g8I++xrZ4uRbUh1yDUdElbj7yNTnCJqLV/LmTg7PXYuUPMW5E1mMat7fV7q4KRXslSciY9gTEWR8Y20gp1hQCpP7P+vdthtoOvUT5AhS5qm3Z84CnFjoTZTleBd3vDBSQn00r3Nz9hJvZNifilV8ydD254rKk3gSmaDfnbHwa4Y4LnQKAEeCSlKOAgbRNFafT8Do6dUyhZvDi2ytQmWjZGzcTPLx+fvZbcwyZovhQGoQYm4inP+518teOxgCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL4PR11MB8799.namprd11.prod.outlook.com (2603:10b6:208:5aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 10:51:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 10:51:55 +0000
Message-ID: <072b7319-0dde-4527-bf11-dc4accb29317@intel.com>
Date: Fri, 17 Jan 2025 18:57:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "will@kernel.org" <will@kernel.org>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <20250109152713.GB5556@nvidia.com>
 <c907f620-6f83-4c01-ad50-cc369763b8cc@linux.intel.com>
 <BN9PR11MB5276257158B2BABB90CE4AF78C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276257158B2BABB90CE4AF78C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL4PR11MB8799:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3fba1b-18f6-4aa2-ec39-08dd36e4f536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?amR3Z0plSW90WXJDWVZsUUk5VHFpaGw2SDAyWCtMM3RPaHE3aG93TFFjbHh1?=
 =?utf-8?B?K0ZmYWZvTDh3K2RXbHdiTWV3Qlcwd29TbVd5d0VXWWpybXdYdFM4VUhQd1B1?=
 =?utf-8?B?aWVxNmpxMk0wWXlsVHBuYnY4Z3NHZ29FK2R5MG1GQ2FjUnhmdFBwRXBEMEVS?=
 =?utf-8?B?aXBtakFyVGJUbGY4Z1NHUEIybW9ZeXBCa1ltNWwrNUl0SUtlejJ2K3R5bzlk?=
 =?utf-8?B?SFFGb3duM3FBUGNkbmEwNk8rZzBOMWx5eHZQZ3Q2ZlN0QW9iSXg3aTRjWmpq?=
 =?utf-8?B?RlVtREhVN3hLTEplWU9KcENTMVFiUThBaGRCWHRPZ0h3UjFiYVB2TjJCZUVY?=
 =?utf-8?B?UmpiRUYvR255TDR1OUVjd1JlNCszb2QzYUFINHlxT0h0QTFXSjBxRHpJT0lI?=
 =?utf-8?B?VkpNa3NwUDZxUXFSQjJyWWpndm5iS3cxSHg3cFFTVnVRbnRzZW9HY2I1MmIv?=
 =?utf-8?B?TXFOVXY2cHV6cjk2Qm5WQWZKUkl1K29oOVJqOXhGaXFxYWVrcW8raFhyK3FC?=
 =?utf-8?B?RXJUSmNOOE1qSmJkaEtlcFl0bW1ZR3l1SjNWcmIwbWdyYU5abGtZekwwbi8x?=
 =?utf-8?B?a09UQVd5Z1UxdDFFSVNSckF0ZThoSVRsMCtURzgydVhtNHdTeE1PYzYyK29T?=
 =?utf-8?B?VzBBQ3R5dnpnYW5sTHNNR2ROYzFJQ0MzejMrUE1yYi9GR2hPd1NWalZRTXZH?=
 =?utf-8?B?U2tOWmZZelR6Tko0Tzg3N2dSVE8yUm84YmlkendwSXJ1dG1kSzZqa1IvUUxT?=
 =?utf-8?B?NmdyM1U3bWtCQ0MzMlNlbzdrL0dENDNFc2t5RERCTm9EMUpOYTJ5UlU4T3Bi?=
 =?utf-8?B?UUQxdFZFbnVMRitTUk5QR3p2Z091VUowVnJNRFM4d3d4TkpkdkxtV0JBMC9v?=
 =?utf-8?B?R1J1R0FUWFJRa2RXZ051UGZ3dHBLUFE5NElNZ01mRWFZa0F4aEZpWURjMElJ?=
 =?utf-8?B?K1hETFdiVXpIVk5OK3ZaMlJNa3dZTG5hbGR3YzV6cFArUW9GRmhSQVByNnR3?=
 =?utf-8?B?NEpTd3kzVEp5YXRvT3hybmlTMUhCVmgxRkhIOUFBTGpNNjVub08wQWg0cUJD?=
 =?utf-8?B?NGczRXZrblpJc0MrVDdKTTNmak5nQ1dNeitHYVRJR3ZnYkl5T3VaS0oxZkJn?=
 =?utf-8?B?VmpYM29pMVRBSmZPSnhsZ0tPN1NGaDZlNmk3SENZTHd1dVF0bXVhNUxPay9n?=
 =?utf-8?B?NmZzQXRRK3lhWVdYbEkweWkvMytmSHhrMHJhS1ZWN0NMM2VsdHBBV2doZHRE?=
 =?utf-8?B?LytyTXFXNkRBNk1mWVJDV0QzbE9oQUFFa2JOcmp1bGpQazUxS1B1SkEyZ2dT?=
 =?utf-8?B?YzFITmFQRTROdnBWcWMrUk9VZVhoTG0yUGV5VWVwaHJZbHJEVkR5U3czRFNQ?=
 =?utf-8?B?eWFnSXkwWkNlaDBwNHhMYWpGSGpteXBSWk51aGwzOUhLRlBYQkV6UTVra3Fa?=
 =?utf-8?B?eGhyREYvR3ZocWtOcE96RGJaSDR2bzJoK3Q0N1hpZHpZUnJLempobUV5SEht?=
 =?utf-8?B?MmxxVExUdjZUUFVxaE9UMzJab1dKbm5NWDAwQkVzdmFHM3BLQTZRR1lVa2pD?=
 =?utf-8?B?SkRIS3lCQ2FFZ1F4dTBjTDd6NzdBaTNWanhzQ3cvRVNPZHN3VTd1cTFMTG1y?=
 =?utf-8?B?UjN0ZEFLbW5IMlRiMXBIeVZmSVBnM0dUVEF5VEU5L2NkZlZDcitsS3NiL1Yz?=
 =?utf-8?B?cWRGcGxiQWt0bTB6VXZhWllsRVJlK2FvQktSaE5ZQzVhTms2R01sSnJSVXZG?=
 =?utf-8?B?L2dFVEVwdlhHRjdteDZIRGxVRk5JemZGdU45QXRMckMwaXd3cUNVbG54K20w?=
 =?utf-8?B?NDBjaUM3RUZHYUZvQ3RmdW9Vak5rUXVxdEEyeFZPOFNPK2NlR1gwZFp6Rmdy?=
 =?utf-8?Q?moalzf/vJgFug?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlRsNlo0eUdYRk43eGtJUm9WY0h3N1BJU2d6bWdFY3BzQW9QK04yMmtHYmJ0?=
 =?utf-8?B?VmdRWExFbkN2alhmQzd3UTg0dG5IMWlSeCttWmxSUXkwQ3ZNVUVFZDNybWZj?=
 =?utf-8?B?Q3VuK21aRWpza25MUGgySHJXMFhWOUpsUkdGT0w2UnlueUxES2VmUUViaHd5?=
 =?utf-8?B?dnNYVk0xYlI1dGowdzJmWTBsUWI0Tjk4cEw0RkRCZDhoM1IrZVFhRVZodGJ2?=
 =?utf-8?B?VUVvZVBXNlpUOHRnc1hDQW9Uakt4alB0UzVjOHY5cUx2R2VpZ0E1WC9NVVd2?=
 =?utf-8?B?M3V3ajA5RU81NnpoVzR1RHRZWGRpR2dodEJKcmcyeHR5a05PQkN3K2t2SjBX?=
 =?utf-8?B?L0tEa2gvUlVmVnJYck5qTVdZTzBabGVjNFNQekhVNW5PemIwOHFPeWRXVFNm?=
 =?utf-8?B?ZVB6YS9URGR4ZWNuNlBCOS8vRXplYmR2cGxyOEtDNXNaM2lOOUlIVXFyeHFU?=
 =?utf-8?B?bUl6enBBckJqMkZ3MHdsUzRLbnRBWkI1SXRTSVVyUGhBeGkxTDdCYTNmQVVK?=
 =?utf-8?B?eUNoY0U5b2FzN1RZdEhiRmdiVGdCbUxwWGhLekVPaU1DcG5kWldUajdpQVZa?=
 =?utf-8?B?MXN5eGFLdjRJSW4xdlRZRlFQdnRqYkg4a01XN1E5QnA3R3NaeVpRdlhWVXdT?=
 =?utf-8?B?SE4yVmMxNXc5MUVON09uL2V6ZkpoWEhFRXZXTEllRkFIRW9XTWdIOGFUYU5k?=
 =?utf-8?B?d0Jxc3ptUUgzMTEzSm5HR0VmU0JxVG0wWGg5ZFl2STVIYitVOXBGblhZYWRw?=
 =?utf-8?B?ejdwS2ZtZWZIRnZmdFBZbkFXMTVTNjNodVNhWllMeFAvOVBkTGs1eXRoditr?=
 =?utf-8?B?L09QK2d1NFN2cnFwN3lTS0EreTF3RFNaSDVBWmp2VnJsc1NVUEV6U3hQM1Vu?=
 =?utf-8?B?ZUtpNEg5b1p6eXQrR2crbWNhS3c4NHg5bnJDK1JyMkhoMHVZajcxMlRIemJi?=
 =?utf-8?B?U2UrdnhhNkJPdTVEdThneTJ4dXlrTjFvRDFjbVNURVRHbnNSZGQ4OU5CYVFH?=
 =?utf-8?B?RkVtNmNyYTJGVlJ6RHFFR1JpNG1YVDJudHlaV2QzSEs2amhQVzduSFZSSGF5?=
 =?utf-8?B?Y3NoOWZIa0lCWDVVbmhKTHgvQmd4TmZHZmJhTUoweWNEVm9PSlA3YTVDSGZr?=
 =?utf-8?B?TnhLdHA2U29FMjNVdEdNNmtHendld0FhTFVTb1hMWVZERFVqWW5iY1RrNDdO?=
 =?utf-8?B?aUwwNjN5SzlYUW9ONVdIYUU1d0d5NG81V2prWlJrRUJvRjBncXJHaVIrT0NE?=
 =?utf-8?B?S0puSStBSlN2SnUrZm96dGw5TkFza010emduc2ovL1BXeHlBM1Z0T28zN2VU?=
 =?utf-8?B?M1NOeTBEa2NHUkxWcWxRU2VZVFF5Q29RSjlKNnIvRDh0aVA4Z2l5MmIwL083?=
 =?utf-8?B?OHc5QWFTMGdFWWNtUzF0UitvdzJEYnR6dDRNNWVvYlZQRGQxVDhkQldoaVhE?=
 =?utf-8?B?ZEZrVHhRS0xjYlFKaXE1L1FEUGQrUitCdWUrQWRNbmVFeldIVU9vUzd2b0tY?=
 =?utf-8?B?cHFQb0ZkaHljSjZNVEg0WDVYV0VLYmx3dVBnMXNGYkdMUkMzajRpOXZhYlJj?=
 =?utf-8?B?cVl5N3JZM0lBOXBhRDNYU3FKWGFoR2xISW9PTkVzd25Rd01oZmg3OWZwaXJt?=
 =?utf-8?B?NDkwdTNSMlEzT1FGUlJ6MDdCSmF3LzdPN1ZlbmMrNklSUzRsekhSYklFeHF2?=
 =?utf-8?B?MEpqOFNwd0lSZ1lISUJjMWRvbmtEaUVjUU55UjlpVDM4alZtRmxjeXpUN0ow?=
 =?utf-8?B?bDR5WWdRaHR3WGpra3AxZkxvaWxQUUFYT3ZwTkVmTXgvb2l4VXZNZ0l3aWNu?=
 =?utf-8?B?VHRCMStxdGRqWHhaUGhWYWI0QnVweHBHdTgwbUkxaHVONjM5eDN6M0pZbGNy?=
 =?utf-8?B?VDE5a0hrZ3hqKzVrYStTSWF1Wk1IcEJEaUpXejBhVVVtaEpNTVB1N3k0Um5E?=
 =?utf-8?B?UUJWWXRjaXJ4UzdyZ0djMDE0MHFYU1dSVVlwRXRMTWx3clhlMUFiVVdDZTJr?=
 =?utf-8?B?dzU4SDNZdlVjQzBLTXBYSEVReU9pZ0tsOEpjMGhBRXVhRFZ4U2tNWnYydmtI?=
 =?utf-8?B?NFRZQk5rQUMrSFp3ZDF2cVp1N1A4Uk1WYXFLb2xCeDcvTGtTWmpmYnQ5Umll?=
 =?utf-8?Q?i889NBJp3ELMim9BN6BFjPhWd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3fba1b-18f6-4aa2-ec39-08dd36e4f536
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 10:51:55.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yaxhDhJJes7iga++xilC8/ac7ql9XZA2tgw6fM06i+ZcDOzQ4kA9RN5EWE4nlDTt3xg3lPRfP98d65TjMEUy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8799
X-OriginatorOrg: intel.com

On 2025/1/10 15:34, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, January 10, 2025 10:41 AM
>>
>> On 1/9/25 23:27, Jason Gunthorpe wrote:
>>> On Mon, Dec 23, 2024 at 10:51:50AM +0800, Baolu Lu wrote:
>>>>> @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device
>> *dev, struct iommu_domain *parent,
>>>>>     	struct dmar_domain *domain;
>>>>>     	int ret;
>>>>> -	if (!nested_supported(iommu) || flags)
>>>>> +	if (!nested_supported(iommu) || flags &
>> ~IOMMU_HWPT_ALLOC_PASID)
>>>>>     		return ERR_PTR(-EOPNOTSUPP);
>>>>>     	/* Must be nested domain */
>>>> It's better to abort and fail a domain allocation when
>>>> IOMMU_HWPT_ALLOC_PASID is set but the iommu lacks pasid support?
>>> With multi-instances of iommus in the system you still want to succeed
>>> creating a PASID capable domain even on instances that don't support
>>> PASID since it may end up being used on an other instances too.
>>
>> Okay, so this flag is just a hint that "this domain will probably be
>> attached to a pasid of a device", NOT a requirement of "this domain
>> necessitates hardware support for the PASID feature".
>>
> 
> And note that pasid capability in VT-d just decides whether to serve
> DMA request with PASID. It doesn't change the format. It's legacy
> Mode vs. scalable mode for deciding the format, which is always
> pasid compatible once scalable mode is selected.

yes, pasid compatible is more about page table format. And I'd prefer to
treat this flag just as a nop since VT-d does not have the
aforementioned pasid-compatible limitation. So I may not add too much
words here. :)

-- 
Regards,
Yi Liu
