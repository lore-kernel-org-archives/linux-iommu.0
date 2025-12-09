Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE45C35959;
	Tue,  9 Dec 2025 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765253227; cv=fail; b=az9+7AV5dnY+NWZm0ff8Kgx3bIEPxc/71qffi4Kq4n+vUKncH0OdGx9yAfafROkcM6fnPNCBjokoe3Hao/7ZL2EMvoNqdD1mC0ZmUFU1hQkNDPBNgTaUDWpw7yF6y5atdeQZHnQ1uGNqFa9Ju/xIOCgNOj3By3CQVWVi/lx574k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765253227; c=relaxed/simple;
	bh=IqwDNSqrWmpLVL8WrasFgbI7+vMJNTCNFM5MvFkzs4s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EznxaDuevu5i0lTf9OCSiUal22/BvEfe8gYSZFWxFoS6Un9Xa26xHh/8DiIkSWfYJbC6AO0b1oyTBt3AKQXlUpMG/BVRZexwevJvIbsuq2fk3C5V+Tqn8xYFfYIK505ZvfpBVN0PFSIM3vBeoq9+befgsLLn/QvfQQwUUPsw6lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2K6Sx7m; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2K6Sx7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765253226; x=1796789226;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IqwDNSqrWmpLVL8WrasFgbI7+vMJNTCNFM5MvFkzs4s=;
  b=j2K6Sx7mT2t20K1/L+z+hHRdIn13gdg2bb4NyFBuSjDMtbFbW7zI32iR
   x29y3A/kJ9zmQ9FhVAEtjZj6M78E8Ut38d18OCLjrnB1nixL1RdHkgG2d
   ue+RtZTyGs+ERiHWjj8psjT3zLfPpjbb5k6G3Gu7aXoVSpjbflbgu0xam
   3qMPC9U15hO9yKSt+LXgNin85VkoKEocxxFP8JJ6x/7Nh/Jvyvd5gA+Z0
   nvDZNKuYCFBmiD9kaqoMTGSoQsOq3TLiDI1yiv8CnsQyl+QnQoXHpWHoc
   5LSZ8Ijx+i2mhh3Gc8p7wbYGtswN6Nt5hIPS6dfyyuhTW85+sk/zqZyEF
   g==;
X-CSE-ConnectionGUID: barzXQHySOiPJbmZNxazXw==
X-CSE-MsgGUID: cz7lInAkSTCoGbUAYgN/Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="71059997"
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="71059997"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 20:07:04 -0800
X-CSE-ConnectionGUID: phaJpN8GSj6nSJ8eFO8w7g==
X-CSE-MsgGUID: Z6mBM3cPQ6SYrNLb8I2QRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,260,1758610800"; 
   d="scan'208";a="195395200"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 20:07:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 20:07:02 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 8 Dec 2025 20:07:02 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.8) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 8 Dec 2025 20:07:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tP5Ghen+4q9sZeabn/GuptDnewSqOJm5vPtNbWsCfmAY8NBDAvvio24dhm6+d3egXnajI9z8gaoCDt3WEuTKn912mLRvB+b0O3fTxfvoxlEt6i4Wk8/FyuhWluXwMdECxynRD2J5K+I4St5htlQ2vExOdctoKdv771N2QfC/9JXkt3J/1p5I4QeNZ4nlzTKo0pDLBw6+keBRmmJM+RRK+3W7qvvlHdMiiarsQIMG1frS++MF1AJNK+2iJrnFIBYERB81ikBs6Ctcm636MEjLDGf/2R62XDR5lTb8t6XmWo/ahZ+y3xVCfAKSqGwzmk7QwUpRhOrZLOmBlkGn26ZDqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs5PixjU2AvOrNZITZ3ZLS12qTBQb1xEJarz8D5IUfc=;
 b=HuAK2VebD6BgNZ77kaCukjXUFuFN0OR6hyF7abKm+4pkLcPQIU/Comomq7rVPKPqDU4wxRJ7SiPSrw0yk6erwvNPrFcSAx76EnSV/DwNpiZQXH3+ycIUFQveMabGukCBzbqj4ZoylVD/jqFiReXLRzF7ST/WiBroHLt/Jn/zYC6k/KvpO5V8v+5biV7lohXKTdRuXU/+hiVII8YiUQI1mgo9IxAW2tA0ks0iZQE0yYCqTxK3/hqnHJy308TqdhhfCBDkTRC+I3h/Q+3X9eOZcovTior9jEZi1a5QSO2aTbhTAheAFqNWHeNIc9J4CXBfpOna66ZivwtVPdm40L5zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SJ5PPF0D0CDCDB9.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::80a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 04:06:54 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 04:06:54 +0000
Message-ID: <b6c62df4-18fe-4aac-8e96-e377fa387ecb@intel.com>
Date: Tue, 9 Dec 2025 12:13:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Flush piotlb for SVM and Nested domain
To: kernel test robot <lkp@intel.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, <joro@8bytes.org>,
	<iommu@lists.linux.dev>, <jgg@nvidia.com>
References: <20251208091907.74719-1-yi.l.liu@intel.com>
 <202512082342.IdZjYepb-lkp@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <202512082342.IdZjYepb-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::20) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SJ5PPF0D0CDCDB9:EE_
X-MS-Office365-Filtering-Correlation-Id: 624328f4-37fc-42ac-a4a9-08de36d86327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|42112799006|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q1VYejJJbU5MNDdoVFIrR3VLRElDMmhtUDRCMVJVMEZ0VmxkM0ZSdDY5WTRm?=
 =?utf-8?B?OHBsZFNBcjJlYU5JY3M0YW5VS0xES2hoWURVaSt4UjZ5aUJST25sTlJsWnNY?=
 =?utf-8?B?a0xqNVdvQmlEdWFvbjFCYzJMZ1F4aE95ZFpHUkx5cGJLNkIybUlNekxVQTM0?=
 =?utf-8?B?b1hTNDF5clUrUFJVS1JqYjNwelRTMlhtbmdvdjZHQ282RDNPTDNwRjNXWmtp?=
 =?utf-8?B?OGlQV3lkS3NJTE9ZWFFWMVp0WUVCa0RWajVPTk5SeFEvQkY5eUJ1NU5FeFQz?=
 =?utf-8?B?UFNRblBQNjhHdkNkcW43aXVFTmNiaHBNQVRpZVdOalcvZzU1S3FnWk5ma2xv?=
 =?utf-8?B?SkNPL3g4V1BVL045cFM1cHlaZkZaRXUvc3B4TTZ5NWhydm12bGNSWCtHei9w?=
 =?utf-8?B?c2hZYU9NMkdLTjFWQmllNmFPUnErTmhkNWRNTVdFc29QbGx0RURvY2dPbnN2?=
 =?utf-8?B?L0xxbEQvT0FIYmJEa200RjMxTlZrZHZRMjFrd0o5Wm1JZmVKWWhNMTFIZyto?=
 =?utf-8?B?VVc5cnUyODFVaUd0R1F6RWZIY0dtNkkyemcxdVhEODk1Q0hQWHN2QkdkeHZJ?=
 =?utf-8?B?Sk52SGNvZ3AyeUszZ01FSXk3b2xwYTRVOTZqTDZNMzFrZUJoeGFCQ3VYUkZu?=
 =?utf-8?B?R0FBcTZmblRwU3Q3Qmd3WUFtYUJjSUM3WElPSTg1b3BFU0NqaU1TZ0k5SjRM?=
 =?utf-8?B?NDZ2cy9jN1ZyRUwrdHN2MldHbzlwamEzZjhCYXkvdmp3U0R0VFJieHk2bzVl?=
 =?utf-8?B?OEdRSmQzRGwyZjFwbzBGeU5lMzFCbldrTFhkTXliazNNeVJLL1ArMC9CakZm?=
 =?utf-8?B?QWJvWDhEaEJUK0Z0VmRQbnpTUGx1YnN5RkZ4VkJaKzlFY2dZS0x0N1dNTGRt?=
 =?utf-8?B?TUxjdHI2WGp4K1hHazVlVFFodVVoWVhFLzRiOWZlbzVtdmhiWjBuVUJOYXA5?=
 =?utf-8?B?cTF2SHM2UDVVbXpQY2h5OFVqV3FyL2Q3bWlCWGJYb2VxT3BFRlhvQWhMWFlr?=
 =?utf-8?B?VG5PckVEZmsyMktoVVdzQzNFVWZjMWtRQVlZUjdudUZMUlFUYWJJT1Y1TmRU?=
 =?utf-8?B?MGxmdlF6UVVaWnBwNE96Nkt6TkFsMGZSUlB6ZjJFUVJsdHJ1VGJ3UmZXYWM2?=
 =?utf-8?B?bmh5cjN5MTlWQnFpZ1M4N1dFRXBKaTQ4SStKUGp3UUp5b2h2QnNXaUJtTTB0?=
 =?utf-8?B?YVJpQjVOWkE3SktLQlBZSWlxM01pNjYrQWZJalAwNTlnU3FuQTNueXl0dGRK?=
 =?utf-8?B?L3dpWnU5UmhSQlpxaU4xUTVZeVd2M2k5SU1INW1CNVliQXRhR01YbWtpSzZk?=
 =?utf-8?B?YzZyVy9ydW5nSHRVM3UrbGRhMDhBRDBNTVZSMkhqR1RuQ0phZ3pPbjFhZTVU?=
 =?utf-8?B?VnNSZEc3L0ZWandCNjZPUFBlc2NLS0VBV0ozNTJodGIxeldIUzNudit6SXF2?=
 =?utf-8?B?YkhKbEZmV1BvbTRLM1g2Z2JzSVdSNnB5NkxvYVZQQi9nUVQ3Wlp4NWVHNzZT?=
 =?utf-8?B?Qldwb2VMVDJ3azRmbUkyejlTKytlaWgxQTRhZDVib2UwQ0FYQzAvZ2lDUFdp?=
 =?utf-8?B?WXhPamFBWFg0aTY4NzNtOVh4T1FFdUFFN3Fwc3hYSG9ZZGl5Z2lIT1ZBUzM3?=
 =?utf-8?B?Yk4zOFN1bXBqbG9XNTBxcUhCU3VNd3JFSGFSNG5hREdqaTUySStHa3lYby80?=
 =?utf-8?B?bUUyMzBSa0ozNS9iQjkyTTJOU2F5MnVheHZzSHBsRUpNTElkQTIyMkNDemt6?=
 =?utf-8?B?YjRXTDRLN0hSb3hvWFRnM3pMdkdTZlJVOSs1ZGVoMjJMSFp0WlVWSFA4R2tt?=
 =?utf-8?B?SWtaa3RxQzg2allFM3FUMDRlYUQ4RjFzV2l0NVlVcnpFRVFoaDE3SXB0RUZ1?=
 =?utf-8?B?cExyaXdnVUpIY0l1ektkMkNKZWJFT2VidzFPR2tKOGZCaXRlT00xdXBKeXNt?=
 =?utf-8?B?SVQ2UVNCeXJWWFV1cmpZZVd5dmFkNDVKUUFjeEp0VGlCUkRjMTZ6Y1oyQkxo?=
 =?utf-8?B?UUhheDB1aUt3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4798.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(42112799006)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGI4VHUrUjIrc3M0OUs2c0JwWUJKek5HTjJ4eUVMdmFvbHhTMGRlVW84cG9v?=
 =?utf-8?B?RzZqYzBHakZkSjAyYWZUaXRZMzUrL1Z2VndPWVRMcDZrRDMyemRLeFloNUdG?=
 =?utf-8?B?YTdXNUVmRXBLakVidEVFUmo3RDJLUVBTcGVTa1FCRytDbk5qSVRQVXk5UVpY?=
 =?utf-8?B?SGlhSjE1Vjd5RzVoWDVUbkltNnZ6WEdmN3ZMN0Y1MnRiQkpVcUJMUWIxdHR4?=
 =?utf-8?B?ZlVjcCtmeU5yVEpVam1taG01UkJKd0syNWhOUWhrM1MrUXRxRWFmNk9tR2dX?=
 =?utf-8?B?UDlnTlRTY3ViUEl2Sjc2UHNCQndiMmY5L2kwVG1lcW9ybEJzelJuUmdVUFoz?=
 =?utf-8?B?Lzd2cmZMaFlBd2dkaUhLV3VFUG5jb3Z2VC9ob3NIQm15Zk5ZczVHQkZCRm9o?=
 =?utf-8?B?bUtuMUtJcUpkZjl2cTEyOWN0T2FyWWRSYzdBM2tUK2Q1eG1tMzVDZGtDczdw?=
 =?utf-8?B?Z0haSjJCZHNiaUpjRFNtTENNaExXSHFWNmtEakZOdmxEUnZ1ZVh2aEN5WDhj?=
 =?utf-8?B?RldNendDMzRQTEIzV3U5VWZwTFlsSWJ6ZWQ0ektwVUdOQmZkKytFV0JCbW9S?=
 =?utf-8?B?Z2pmYVBldkJOcmRFd0lFaVZDTG1WRExvVnFENXNtUmQweEttUVZWdi85OEZr?=
 =?utf-8?B?RDJoVWF3bUZ1QzlMRURUUjQ2c0N2Nm5qRUtTa3g1ZnpDdm1xS3hJLzdYSHhL?=
 =?utf-8?B?bGluczE3M05DSmxJK1Z0VGtvYzQ0ZVFpT2tFNGUrTHZtYnFtbHJxSTd5WUZS?=
 =?utf-8?B?QWZrRy9qN1BFRWdjUWhGYlArUlpRY2NJaVNHMm1lbHV1OG5ML2ZHQUJYMGM3?=
 =?utf-8?B?UDl2Lzg2ZHNTZFRpMjBOUEp3c3lLREV4MU5jYndobDZTb1Q1QVNLUVhQMXpm?=
 =?utf-8?B?QjF5U1JDbFY5Z1pIekdnTHBVL21pSkV1QjZUcFRBKzNGSUNCc2RkYTVyL2Jy?=
 =?utf-8?B?VmppNCtiRkJ4YXMwQ2xPYndjZTFnY2djbGFtYzZHRllpcHdTQ1ZoUXdqVlU3?=
 =?utf-8?B?MVFHcmVLd0JYMXowczAxSlpHMzlwSU5SdXZEV3A5MUw3c1cwQmlNWnNhZ2Ev?=
 =?utf-8?B?cEtkU2U4MVVTWEVielZ4Y2FoK0RNemRDVmFqT2lpMjRBTDh2eEozcFVOUTlD?=
 =?utf-8?B?bjVsbmlHeExEVnlSZzhKM3c2ZE0vOU9PcS9wM0NmY3FhS1pJcWd6RXAxb1Qy?=
 =?utf-8?B?ejI0OVloM1lwWE9LR1UyQk9jYjYySVpPbGd6dzdZV3dwZ2JoTFkvNUI4TUNH?=
 =?utf-8?B?a3dJeE9JVGJLREh5VUFmS2dQblViYVRhR2U2ZldMdjhZdXhncUFVU1RZeE9W?=
 =?utf-8?B?NXNvZkJGU09MSUNaaG1sTGluVDV0MlhYSzk4V3NnWkdBemNUUW0vK1N6aG5w?=
 =?utf-8?B?TjZma2R3N3RKakF3MVIwU3RidEFKb2pXdFBkQWtQek5jeWtPVUEzQWVwcXpq?=
 =?utf-8?B?TVh5SUt5TzFGWFQ3YUlLOHBLeCtyMGZmOUh0NFNXNEdTY0hNL1lwYUxBeUla?=
 =?utf-8?B?NGNram0zVEhQNnprVDRTcWZ2VXVGU3d4aGpwTmJ6ZHlRdVhhY1RreUlpUlht?=
 =?utf-8?B?UGdEblk2SjJGanlHS0t2clFiVHJIMEdDSHdPVmFJeTNzVmNaVFJXYk9Oem9h?=
 =?utf-8?B?OGg5SHhHVytiejl2R2VOdDdSUWpQOTJLSnRycGhYODJvNlV1T2FULzhWVXhU?=
 =?utf-8?B?cnlHMVFSOU1tUFdyZDdxQ2taKzBraEZJWmo2ZEVoNkpNd2k1YUVWSlNNODJ5?=
 =?utf-8?B?anMvUmV2UGlpa01kRjlLSWxmWEZ1TFU5TlRPL296VTZMWEVSQXdxSmJDWXV3?=
 =?utf-8?B?NGhaNy94dXlGRUR3bnlsTS9EK3pYVStLS0VrdUdueTl5QklHVnVjbU5EVVNP?=
 =?utf-8?B?d3hpZXFkRmlLVGM5cGROQ3F0UzI2S1JGUUFyUGJFNWhvTWtTbGFmVHcxanA1?=
 =?utf-8?B?dWlxMzlUZ2xnUHRBUiswQldkZWxyMEFVVE9vT00xb3NiWnVISGx3NGdDaFNO?=
 =?utf-8?B?UDBHSmdkMjl2Z1MrN2NubjlUU0VteEN3K1BSaTJ3QVpEWDcxV1VTRXRUN3gr?=
 =?utf-8?B?Nml1OHJSbWoyR2czY2JPbUp4b2p5a1dyUjJqZEhoaEJZN3ZDVXphSnMvWkI1?=
 =?utf-8?Q?Ze/3n9dwppBCHGDR19pQf9DOb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 624328f4-37fc-42ac-a4a9-08de36d86327
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 04:06:54.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUTM3SMDThuH6mCGRriYUb5WHiKCT0ujhJsl9u/6FpdRTWs/vwAwCgsxLwnVxambOyRWtlG31ME/4JjopVJo6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0D0CDCDB9
X-OriginatorOrg: intel.com

On 2025/12/8 23:50, kernel test robot wrote:
> Hi Yi,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.18 next-20251208]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Liu/iommu-vt-d-Flush-piotlb-for-SVM-and-Nested-domain/20251208-172359
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20251208091907.74719-1-yi.l.liu%40intel.com
> patch subject: [PATCH] iommu/vt-d: Flush piotlb for SVM and Nested domain
> config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20251208/202512082342.IdZjYepb-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251208/202512082342.IdZjYepb-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512082342.IdZjYepb-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     ld: vmlinux.o: in function `dmar_domain_attach_device':
>>> iommu.c:(.text+0x70aa38): undefined reference to `intel_svm_domain_ops'
>     ld: vmlinux.o: in function `paging_domain_compatible':
>>> (.text+0x70ab8f): undefined reference to `intel_svm_domain_ops'
>     ld: vmlinux.o: in function `intel_iommu_set_dev_pasid':
>     iommu.c:(.text+0x70b487): undefined reference to `intel_svm_domain_ops'
>     ld: vmlinux.o: in function `cache_tag_flush_iotlb':
>>> cache.c:(.text+0x70e74a): undefined reference to `intel_svm_domain_ops'
>     ld: vmlinux.o: in function `cache_tag_flush_range_np':
>     (.text+0x70f2d3): undefined reference to `intel_svm_domain_ops'
> 

hmmm. this happens when CONFIG_INTEL_IOMMU_SVM is not Y. will fix it
thanks.
