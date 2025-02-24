Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974BAA32
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374577; cv=fail; b=l0kEAVVkjAJ6Da7NAG17ti0aKUUQiksw42IjfMt14eU4r1hOdaEiQ6Thfd3CQ047U+DReHes848XXJ7rlUXqg8SMkjlh+ukHhrA9kVuPs4V4rxX5dLn5F/EctG6mvgCrbJ/cbTRQKgPgj81Kz3Fl2V855g0MqAnil/xHUqsfo50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374577; c=relaxed/simple;
	bh=KL9tVUb3QsIDgV1qQ44wYgLdSM//8cp7vLyjOyB3fg0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GhzMmbN1qPYmVKvO3Q8teqww8wBdB94wBlRLx5TAs5EUNqOwlVGbWk/tnMkJyxjAGFgUrOXtEdb1RdOPYDm8SQdPLFxZaCQzFsUD78hbqH0649wM+s/5ti+4lxXHoirZ/4tla+v3GY8Gx+/diOgktcAsZkoXdmYD3OWkmBbTOQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJVcEsES; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJVcEsES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740374576; x=1771910576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KL9tVUb3QsIDgV1qQ44wYgLdSM//8cp7vLyjOyB3fg0=;
  b=VJVcEsESzcDoni5l/lJ0+wXSUzS1fgaQzmsJ/Wcl8FsrHvLYfHvaN8AL
   g9/I+WQa8RWzoBNMsdVrOtdZawq1CsrvOdmw6nhwL1mxH6X+uqf7tvoAs
   01MK2o4G0de7QUeO3SFPXUp+WRdI2C35DhVWORybvEd3NZ5BncyULuA8e
   g5GxD3qXjJXDZBxVlVhCJUlUe1czcJvBkSfIpUZod06d7XTj+nmB9LRap
   vJfTZlihi53H9RL3zZCPnLzEOd47RZTVztknqmZ/mBbYPR+oUVTnV6o2K
   tFDC8uZRNixCD9ZOTx/ADx1hfQo9qxoappW677av7MGMP5YxIiC35qCp/
   w==;
X-CSE-ConnectionGUID: ZfWD93TKTBi+H+FSYQgPqg==
X-CSE-MsgGUID: D//vPbPcQiGhDqNPdB7VaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="40990547"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="40990547"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:22:55 -0800
X-CSE-ConnectionGUID: QEG4ZyYVTNiEdWWzaheRmA==
X-CSE-MsgGUID: iie1kz+0QYKXL81EbWjMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="120868222"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2025 21:22:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 23 Feb 2025 21:22:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 23 Feb 2025 21:22:53 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 23 Feb 2025 21:22:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8eFNu2f9KKpqKszmc9HZTDRPi/jfTjR91bH1gqWEcp49+NNOL50GygSlh6a3d/tFRkdKro/z3DXstZd+WvXQH/3Eu1mgQJ3cFY5fihNTKQgMYI9FendJ07/VWin6mjoHZiMl+lS1JkxUchR0iOqAm8KLrX9kLoL9GujiGp5ecTtRUG/TtupLfVMYk8no6n/hOWYRhdnkPs/sBS1gyWLS4yjLux3rjhHxNlcHI+2Z948p1wgJ6EFGT1KAbmVLZZFbFDxOzb2T5uO2qH7r+o0lnTDiS6r6i4K7UCzxVkkoHuODwkC0OfTbiOkOnVAaLz7ospSrF3dYn5d8GaPlITVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JORnja7A/Gw88/iVwZV03P5Uvu5sRGsBqYXJKhUY5o=;
 b=Lu8xQhUwVSqlbVy/WpwtalRMPkgn8Nz0M+fmJYL6AAFhLU1MdSlt+uyArrb+scZEo3F20xsCHXJjdq8mtdH7GwPq82pI/t10GWv9nm2nXWQkWfBOjoOKBMV0iSx7ZXb9+ByR0XR1b52SbsgEr5zGjHMRi+Yhk+4aGQS5f+CvhN1piBWMJcZW4NP/B4qrhyqSJPZhIC2xS8BuDwe5VENW/r7dnCtDR185IfMlWZ3hTgSkLiJoX3sb5204QRGFw4xPnITPYib93Er1nd2zYLdKYfUALtZ5Ieqg7BLrs2Izcqu60owa0wdRcdVGUvgv6QqIhRnpK41JcyUZRW9w0WUbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7979.namprd11.prod.outlook.com (2603:10b6:806:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Mon, 24 Feb
 2025 05:22:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 05:22:48 +0000
Message-ID: <08167e86-9da5-4a9a-8aa3-47d5f98c55e7@intel.com>
Date: Mon, 24 Feb 2025 13:28:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iommu: Swap the order of setting
 group->pasid_array and calling attach op of iommu drivers
To: Baolu Lu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <will@kernel.org>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
 <20250221143335.49874-5-yi.l.liu@intel.com> <Z7i3dvyA/opurciP@Asurada-Nvidia>
 <ceb475fa-dfdf-4bcb-a4ba-8128ba86a39a@intel.com>
 <9ad4766e-e37b-4310-acec-dc8eb91dde64@linux.intel.com>
 <c71cb2bc-e1f0-4d42-a695-026a996e8f6e@intel.com>
 <2dccba8b-5f98-4d08-a3ca-b9028fe5d03a@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <2dccba8b-5f98-4d08-a3ca-b9028fe5d03a@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: b8648434-80a1-4ab5-f6e7-08dd549346a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ukw0bDJKdlB5OWhOYjBBWnY5NnIvUkhySmxMU0xIU1hIbEtiTXpyNkxoaWJW?=
 =?utf-8?B?ZldyQm92YUw3Q1dlaHVtMzBNY1p6c2pvUW5YbEpRN1J4TjVQZlc5bG44RmVF?=
 =?utf-8?B?b2thUHU3WTlSOS94UU9RTTJES1p3WVdzNGRSelp5NmFkcEJKOEdEdEtINktD?=
 =?utf-8?B?YmtKdlV6b1hVYWp5TEl6RXJwSURZZmxRQnY3TnUxL3B1VFRzOUNBUkRES3No?=
 =?utf-8?B?Tk5sUm9ncW1LTEg2V1p1NzNIb2Z4elROTXJZM3hwbmwzcXBQWkhTaFhYcXJi?=
 =?utf-8?B?VDhzaFhia09jalZQRVJCeUc0L1BoWGw2VW1VNmJwa1J3NzFCUVFuZFRUdXZz?=
 =?utf-8?B?WkJ0WVhGYTBRVHNIdkxVOUlQclUzbzhqTjFxWW00RUVtMlhBdDl0SWthejVY?=
 =?utf-8?B?anRjaldpOXA3OXVUN3oxYmlwS0xPc244VjdnTHhpM2xaZkNLeU1KZW5lWWdT?=
 =?utf-8?B?ZkZDQWFyTFBFMzJxZXAvMTBybW5XVHpJOTRpSE1DQ0tFRFc2VjQrdWpKeEJU?=
 =?utf-8?B?SjNtZ2J5SzJub1dRTENzcEQ0cXJ3RnA4MkMzZHNhcDNtYkxiaHJvWVZsc2ZH?=
 =?utf-8?B?MDNVcnRMYUxKTzYwOUE2K1IrVmxPaGZCMlJqNnhZcC9wUWJ5aENQMTVaa3JO?=
 =?utf-8?B?MisraUsrZ25GNCtQUTBtanR6TUdPV0lxdVhWdFRKeXE3VS8wVWFUZUlrS2JE?=
 =?utf-8?B?Q1U3REI3TmhwYU1rZFJQTmZhT2xMOGRHTmlZWnFZcHE5OFNXeXhsMTVIczVa?=
 =?utf-8?B?LzNMYnNWdmN4WlVvQUZrdGZ6TGpvRFhLUW9uSk0xelhORXExZVpCWXp4OFN5?=
 =?utf-8?B?YzAzRjFjMkR6bHpzSVhtMVBSUmkwS3Bod0cwYUJvdkxOd1R5aDZHb1ZzTzZZ?=
 =?utf-8?B?VzcyVVJjZGRDVy9Ga1ljSkZEUERYZkl6T1dKNXZaaW5KSDJib0NBYXpTWWw0?=
 =?utf-8?B?Nkkxc3krdkg2c3hmdDZRYXRncUtETmxkSnZiWmxScWFYWEkzL1VKcDQxZnNn?=
 =?utf-8?B?Mm5sZWNEanh6T2lqNGI1ajg4Tkh3ZDNKSi9QVDJVUkgxaVp5Ri9yYWs4R2Zp?=
 =?utf-8?B?dXlvUngreGV0SWhHWkc4SEZscytFMnlsOUNPelNKVVdBU1pPSVdKV0szb2xi?=
 =?utf-8?B?SUtVVUJVaS9sQVlvZ3VDNFpnendoeGZzeGNoWjc0bjJhYUlNNkxhSGFmY1ow?=
 =?utf-8?B?KzV0UWF1YkYvUHY5SDVzNHFpUDR3UGJ1OE5SUWlFQzBscG0yUjlJQWVzdC9Z?=
 =?utf-8?B?NG40c3FkZFovOVE3bkNpZVRSTWRnZmMrQ0VUYnd1MXVVNWQxNTNyK1RhaWVT?=
 =?utf-8?B?RWU4bWV5dG1NNWhzMTRRbmZVSEFrWjNmRUZYTklCUkF1VDJWWWNuTnBrRWl1?=
 =?utf-8?B?UE1McXZkcm5Eekx2bHg1b3VQdjBwNFRkOVM4NEwvLzYrV2tUWTFIa2dzeE44?=
 =?utf-8?B?M200YTN1cjBFMm1pZmpNd1NRTUVkdWxrMnRRczRnQkdOalRLdW9vMU1GbWRl?=
 =?utf-8?B?d3B5eVpWKy9LenRPTVR0NDNPdVFPaFpJV08rY1QvMUZqL3lRWWdKMnNpTHVx?=
 =?utf-8?B?ajE0SUM0Y1BCTnBtdGFlZElldk9lT1paUWp2U2g0aUNDVGRRejZPVG5TRVVz?=
 =?utf-8?B?UUd6Vlh0cnBWY0xMYStuTk9LZ255a0VzMEk5cUhpSFBEL2VVRGJZS2x0UUJF?=
 =?utf-8?B?dUFmSUhQMllRUlJRQUJIVTdJeUllZnhxMjdPMEt0WlpUSXBIL0x2VmZrY09B?=
 =?utf-8?B?eXN3aG1MQnc1b0dVenNPRHVFZFQyMll3VVBRK2IzbmJ5Z0FkencyZDIvZWFo?=
 =?utf-8?B?aWYvdS9CUkhSU3hwcVRmTERLVW9ibFJQbkdGTWMzNmZtY0wxekUzbEROWmY3?=
 =?utf-8?Q?r4HuujimW1PiX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0FxQURTbEVTLzl0MVlPOEFqZHE5Vk9TWjlqUGxvYVNWSHhWUWhjQXpobHZr?=
 =?utf-8?B?WWRmVU1DQ2VScDd2bGp2dUJKY01iRXBHT01lbUhOUWFQdEhpNkVKS1hlTGln?=
 =?utf-8?B?cmxoQmxtMWtJNlVLQWZTaWJEbjMvTE5PMTdxb1hRaFlaQ0c0MENIRTVXcGJV?=
 =?utf-8?B?cjhsVXlyTjhCWmQzS2pPc1hxS1BxQ1dzZWNZaUUxYWY3V0pCSEpsWm15NnIr?=
 =?utf-8?B?TmFNZ3k3YzJyMEN0UVRQTG1ydGwvbWREbnRnTnFGT0hxY2U4QzBOZ0RZWGY3?=
 =?utf-8?B?b1NTNFQzNHlxbEhVUXJ1UEo4ejM1eXpWeUY5ZTFMZEcvUWVFaEdNN3ZINGtk?=
 =?utf-8?B?bFJOTVdib1kzTitRVytUL0tmV2FmbzQ3SytOV01XcEt2NXUwUkJ4RFB3SVJJ?=
 =?utf-8?B?ZzVCbjdlOXRqeGxzWmVJL3kvOXYrZHR5SlRLZnBmK3pmakRZQmNrOXhBSlVX?=
 =?utf-8?B?T0JiWnErQ3prVkVJTFdCWDB1NGhwWE5xYnVwdHBjUEZ1Smd6RHR4R2l0bm9C?=
 =?utf-8?B?bzB3K0daYitOTDVYNVNtZGpwOGFzSEZWTjRTSHJhVG1lWCtweFNRQ2FkRStC?=
 =?utf-8?B?L0FpL0NteUJaR1BIQzlsaUhlY3BocUxKTTFwUCtZYVM4dTFPOTY4eVVrNS9T?=
 =?utf-8?B?TmpXaUcxTGlCVncrYkY5SGx2dm5qeWE3NmMwZm50cXNsWkhESElVT2JLS3Rm?=
 =?utf-8?B?dzYzdG5XdzN4OTNUVGF6dFNlYmxSTUVaR2h1WUlqTW1FeEp5cVBTaU9hSlIz?=
 =?utf-8?B?Q0Uzdzk1VHVCQlE4cW9mOVBRWDhJZnBpaCt4d3JjanVwRDRGRWI4dG0rOEkz?=
 =?utf-8?B?T2M4VEpyODJ3M1dDVkhjbm9YcVZUVGVkRzhIeUNTZnRCN21WbzN5N1BUeDhq?=
 =?utf-8?B?QVBPR1dXOUpHSGUvQnFxSVVMU09HeUdhem0zcVdzU214Qy9GT0s2Rm1QenFV?=
 =?utf-8?B?SHpHV2h6L0QrRVhocmR1c01USFd5SU5hc1BMcndhaTVUb2s2WEhtVWQyR1Zp?=
 =?utf-8?B?TGwxdGdGeVN6ZXRYVXpxek9BOEx4R1c5TEZHMUxvWWlXL0xzd3JqOTBtUldL?=
 =?utf-8?B?VU9LSUR6VHJVZWdlRUxuNFU1MWU5TnFrczY2OGp6ci8zU1ZVcFNGamcwYTZM?=
 =?utf-8?B?MlMwMlRyTjFvWFhrazRFNUJZc0JLWnpheHhoRm93VHdqRHJiNFY1allYVytG?=
 =?utf-8?B?dHlxdloyRmRNc2ZPaTZEZU9mZ0N6MCtTKzA0QWtveVZJb284YUh2c1l3WlJO?=
 =?utf-8?B?MXVRTXplSGxtajBDZjdtR29GUlV4YURmeEloblNUR1o2TGhYaVg3alI1T1RC?=
 =?utf-8?B?L2poa2xLNlp5b1NKcnRJTURlM1AyRlRQTE4xeDVLRklUb1hERWFUZnlyYUJ0?=
 =?utf-8?B?NVNZYTBJVFJjOUxKa0FvRjJxbm42MkZUc1dFd1FJbFQyM2pYdW9iekNTcU1R?=
 =?utf-8?B?ZlpiRTFjR3pDdDBoMEo5aGpYaHN2WXNaZUp1Y3hRdW9TdXFCN0lucWp6TEFx?=
 =?utf-8?B?azAySnVzczBEcWxrMWVvN2tod0oyMlo4YXBsT3k3c2tjL3A4cGppLzI5TjRS?=
 =?utf-8?B?YXEycWxIUk5yaXdlVktwMS9Vc2FZcjVIMjRXaUg0Szk4YlovWkx3Mi8yNFlF?=
 =?utf-8?B?dGVLcVpWVHNYaU5LTTBXWW5nSDRPZ2ZjRS9oZVRaajhhNmdqQ2YycVVsRFVx?=
 =?utf-8?B?c21KQitBaEhndXl6MTJEVm5CTG1PdnRYVGI2amlTNFIyeGtpYWZrVDM0K08v?=
 =?utf-8?B?a01qZTNzQlJEa3pScVhNRzh2b25DOEROeGtWY2ppT3RUSDZpcmVKVkMvTnFz?=
 =?utf-8?B?L1AwOFV5cGp3UHVMbW95NTBjRVppdFNRcmJXS0Q0N29LdTJCR0pDTUl3MDVL?=
 =?utf-8?B?d0U0WTAzN1dlQVMvK0UrVjZBQm5qSGVudERSZ1BTeHVJeDMyd3N3UlJSY1g4?=
 =?utf-8?B?WkQ1emM2dnlFMHA4aU1sbFdOTEdoY1BLZy9iUmZyYlZaeDhGNXhWUmJ2UTY4?=
 =?utf-8?B?UHQ2cVNZS1ZDRWkyTkhrQzBJU0U4N01vT1RZUUlrSis2enlxQ2NobWJWSDRq?=
 =?utf-8?B?VDdBVE81a0ZnK2dsb01SaWh2c3NoK2pDT3Y2c3dqMENHOEw0d1U0enlFMzl5?=
 =?utf-8?Q?UIBJ7kmrdjSU77FT/3Xjr8MMv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b8648434-80a1-4ab5-f6e7-08dd549346a3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 05:22:48.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h0bV2LgrTP8ho78DfUfXbqwOxzs8s0dzjMhukiinW6QTRe1hyv652DDN4eJCHtrvBP3t4MHQ1rPLuF2m7huUXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7979
X-OriginatorOrg: intel.com

On 2025/2/24 13:07, Baolu Lu wrote:
> On 2/24/25 12:38, Yi Liu wrote:
>> On 2025/2/23 21:32, Baolu Lu wrote:
>>> On 2025/2/22 9:59, Yi Liu wrote:
>>>> On 2025/2/22 01:27, Nicolin Chen wrote:
>>>>> On Fri, Feb 21, 2025 at 06:33:35AM -0800, Yi Liu wrote:
>>>>>> The current implementation stores entry to the group->pasid_array before
>>>>>> the underlying iommu driver has successfully set the new domain. This 
>>>>>> can
>>>>>> lead to issues where PRIs are received on the new domain before the 
>>>>>> attach
>>>>>> operation is completed.
>>>>>>
>>>>>> This patch swaps the order of operations to ensure that the domain is 
>>>>>> set
>>>>>> in the underlying iommu driver before updating the group->pasid_array.
>>>>>>
>>>>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>>>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>>>
>>>>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>>>>>
>>>>> A nit:
>>>>>
>>>>>> ---
>>>>>>   drivers/iommu/iommu.c | 44 ++++++++++++++++++++++++++++++ 
>>>>>> +------------
>>>>>>   1 file changed, 32 insertions(+), 12 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>>>> index eff5f678883b..73555e1cf016 100644
>>>>>> --- a/drivers/iommu/iommu.c
>>>>>> +++ b/drivers/iommu/iommu.c
>>>>>> @@ -3388,13 +3388,25 @@ int iommu_attach_device_pasid(struct 
>>>>>> iommu_domain *domain,
>>>>>>       entry = iommu_make_pasid_array_entry(domain, handle);
>>>>>> -    ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
>>>>>> +    ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, 
>>>>>> GFP_KERNEL);
>>>>>
>>>>> Maybe xa_reserve() pairing xa_release()? Same thing though..
>>>>
>>>> there is slight difference. xa_reserve() will return 0 if there is already
>>>> a valid entry. xa_insert() shall fail with EBUSY. We want to catch such
>>>> failures here. You may notice that the replace function uses xa_reserve()
>>>> as it intend to replace existing entry.
>>>
>>> Do you mind adding some comments around the code explaining why
>>> xa_insert() is used instead of xa_reserve() here? This will make the
>>> code easier to understand without needing to refer to this discussion.
>>
>> hmmm. do you think it is enough when referring to the kdoc of xa_insert()?
>> It notes it acts just like xa_reserve() when no stored or reserved entry.
>> It fails if there is another present entry, and this suits the need here
>> since it does not intend to replace existing entry.
>>
>>
>>    * Inserting a NULL entry will store a reserved entry (like xa_reserve())
>>    * if no entry is present.  Inserting will fail if a reserved entry is
>>    * present, even though loading from this index will return NULL.
>>
>>    * Return: 0 if the store succeeded.  -EBUSY if another entry was present.
>>    * -ENOMEM if memory could not be allocated.
> 
> I feel that it's enough if we add something like:
> 
>      /*
>       * Entry present is a failure case. Use xa_insert() instead of
>       * xa_reserve().
>       */
got it.

-- 
Regards,
Yi Liu
