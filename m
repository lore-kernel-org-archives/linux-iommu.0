Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F71367
	for <iommu@lists.linux.dev>; Wed, 28 May 2025 07:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416722; cv=fail; b=IYbyFC0HLxADAvY9+ZUmvUSKtU7FDhd9YUgCd1h4T3O/xQXjfE47K0uaHBEdBE5IEB/Xhyq6g6Q9cid8w19DiPEOKqVW2OGRTkvXcXjOtsNY7OutnxEIadOFZVm6y8yAd1xUoLq+XGNoJgmcFbXCdM8V939qfAh9Ar1GAiRZsqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416722; c=relaxed/simple;
	bh=hqBaVDI2wppEjuR/x6VMpmSMPtW4pAI1xYDS5XhWa00=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rJpP01tGD48eiXu6Gzkz6wI5KAK6n0aGdzcyOxG9ffelbO8xEFdo0LZ+HO6YuBcepuEsUklo9UcYWZweB/uipUM1hqZ3bk5LzE51vQffzoQQd6re/2nO5BNw2yyv1IlMn+p2s7lDkyHg+J+SwhdoGeFJ4pwgt9xZt/TPfHkCbys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YbNvk06X; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YbNvk06X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748416721; x=1779952721;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hqBaVDI2wppEjuR/x6VMpmSMPtW4pAI1xYDS5XhWa00=;
  b=YbNvk06Xy+XqMTynfpMl90FHhcOCj2KPIojhSBodYwXd5mWmypnIkwOd
   2eMlIS6fT5tIAyhY3xkAHCDzzEoR+6I+wLfgA97MpaFEiNgvRPyDbrfzI
   hVWE+A6mXW2z0ewTwUQNBzMzd/6RT285PYwKMaOvGw8NxiHnErGAY8JrD
   sPRonlib9w8qL2/DTQAW6kjAIjFZ1rLnBtXLnhciLN5RrB56DXu59vtAZ
   CZn3ouoYTGXiIJPA2hDJeD/1VRln4mq6A55wh562MEXiXMMx4pLqVeoNd
   MCSfuWtN8Fvok9smaVcUfHVWfK2WXs2VxAsqcXIsZqwWhQbWBUehFe5Mi
   A==;
X-CSE-ConnectionGUID: IMVy7nt3QI2fR5WZxjszpg==
X-CSE-MsgGUID: k9f+9xRVSP+FdIvdLgndCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50315299"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50315299"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:18:41 -0700
X-CSE-ConnectionGUID: OyfnhtH7RimW9jPK+8BUZA==
X-CSE-MsgGUID: 3yoSY+kvRmegR+DgBNsfQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="174154482"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:18:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 00:18:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 00:18:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.87) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 00:18:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQoKyC75N9kk2NZrqbJz+679apEJxNR3vYFX5k4mjU2sb1YwZTnQRUM4CLQgpFL80xRwMeSAAGHkYTzVp6jvTlNKtOXMRhcZpnlSAnPQJoC+AhPDePDXNblcqvAqtj/JJvkjdgeJc3Lv8I4yJG/eCylPFpKyBZghxNjHexxoiYwAgOiTOEkcNFUVrW2/yEbDyNeVb8lpOVxPpfhchcFW2T3vVhjqcgWMV2+jyDFiVuZWslgm2Wb+Aps2xh4BirFFtMETTMhsLIq2lvakHtG7cvvFMlX3rvkRMu8uwdumBmNzsP+0/5lzGBcGLFI2UBl1e1/HxfH3t/wlZMIynz49BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVXYQcBpFk5pRA4rsFC3xLjmlF/JJ7akg4gMlwChrsw=;
 b=SngBCI0sXozkVBAct4UjKwsldk1fR7EXr1kY2mh7v6cOSh2z0web3U/v7JD/zRP3FkzJ+vYGz3pliMOFRvOEu6oHMi1XjLzehfUdMAWZQeKnMDMAvRbN0g/+nKHoh5FFIPLiM/3eWvbCoUuAL/vWgufU3fl9UY1PXslfabcNVGtRDJG7aC8f5KYa79eP/2Y9AGk9vn3Hv9HjdmZWf5ust+JRuUfBK1N0TKbRvHf847oYjMminrDfe1m5ITBljMpTjy01WqEzcFGrXlF45uSJAtzkoOZs/A2vxxEes83bNpaUOBjWFAbpw9D5wqdf5VPMO5Pugi8QEYd278+RjDDFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB8804.namprd11.prod.outlook.com (2603:10b6:208:597::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 07:17:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:17:55 +0000
Message-ID: <b1c2e3a0-f030-40dc-9b6f-e195b9aa0041@intel.com>
Date: Wed, 28 May 2025 15:24:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio: Prevent open_count decrement to negative
To: Jacob Pan <jacob.pan@linux.microsoft.com>, <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Alex Williamson
	<alex.williamson@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
	<eahariha@linux.microsoft.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
 <20250516164522.51905-2-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250516164522.51905-2-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB8804:EE_
X-MS-Office365-Filtering-Correlation-Id: dd86225a-e9c2-4c2f-f851-08dd9db7c3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWVSRFhwcWZyZXZqbU9TUkZaV1lEVmtLTTdtYys1U1RJTUM4YUliMk5iOFA1?=
 =?utf-8?B?aVUvVkJIWXpGZTg5NmhhZ21DYm9mYlZVVFlYdDF6N3hPTGJzT2VOdlkvd0tL?=
 =?utf-8?B?Mk81UytBVWU5aW1aYVltcXRKUVdGa2xCQmtpQkFGKzZBblpXdmJ2TFljUmt2?=
 =?utf-8?B?U2FwVlkvdVBrcmg5Y1JaT205VC81N3JPSm5qcnFDN1RraTFLWUx2RkhiemdS?=
 =?utf-8?B?aVMxZXExRXVBdGM5WHFtdTdqVk1iemxKT0M3UTlocnk1VXA1V1FjNy9XcTUy?=
 =?utf-8?B?TjFBbG5QZG1Ja1gveVhIc25QbHlNVTNCYVV0Q0t3MTdJUUZZZUg1d2NwUExs?=
 =?utf-8?B?S2JxbGVFL05VckVXMVl0UGNFeEp2aWk1VHV5YTY2UG5kdlBacndlSGtGeVcx?=
 =?utf-8?B?bUtlU2lrV1puK2JQRThUK0krNGNhZjlFNi9IVmhneUczNHRUcWVuU01abGdB?=
 =?utf-8?B?UTFIMGoyWitYbWdjazZEWWNvckVCcWVBOUJUcnJkY21sM3ZERGRLSnFCZ2l4?=
 =?utf-8?B?OUl4aVlsYzFwWG9EQjVRdUFEL3luTGxmcUl1Skc4Z2VnQXpWU1hrQnNMUzg1?=
 =?utf-8?B?MENkYTlPdDBxclVEWVRicVJIVTZuN1VUdXAvODJqTEpzVUF0VFE5SGYvZUpq?=
 =?utf-8?B?RnlmWmlXeUJQM2J4RXBQNWpFYXk4TXprVlliekRNeWZ2SFpaYjFHUXY1WWRT?=
 =?utf-8?B?UW9tYzN3NER4cEFSSEdWNEhNMU1wZ3VDN1FYMzdzSTd2ZmtRWHp6SFRJd3V6?=
 =?utf-8?B?RUVaSU12dWdZSFIxZSs4Q09MTUxVWkdsZkVySFFRZmpjL0dUVDZoNXkrTUtn?=
 =?utf-8?B?cVBIdHdaRHh3UkMxVmk2ZTc1M3hvaG55NFpkUUx6THgxUU81RHF2TmVpei9M?=
 =?utf-8?B?ekJwZVcwM2NjUXRSWFdKemNqVGdIc1VTbjZsS1BVNitVUHVZblNuRmFleEFR?=
 =?utf-8?B?QUZPWFJIU0hPR2NXcmhROTNhdm9jU2tJMERUT1k1V2hWckIyVlNXOUFaUUo4?=
 =?utf-8?B?OW0yS3M4dTVIMFVONkhybGs1cE5sYW9DVFo4UUl0RjIxRnczMkt5VVY4cEI5?=
 =?utf-8?B?dCtqU1hrSWhpMFVrblBnUEVUUW4xYUdmTk0rRWxRQVZrNGsrejYzVDVQNzE2?=
 =?utf-8?B?bW4xMkFHQjg1bXNpKzFPd2ppTGs0cmU3UTFaMHMxcFM1dTVzRldPK1pUL3Fy?=
 =?utf-8?B?YUpoVU9xYkRzU0d4VUw5VFV0UlpKRldkN1ViRS93S2Q0V0hOb2V3VjB4a3Rj?=
 =?utf-8?B?TUN4cnRwbHNPMDhESVl5YWpncit2MEhoUzRhWEJjb2o5WlQvVVNjeDFxVzM1?=
 =?utf-8?B?aDRUUXo2dWNCQ0xyZE1OTzBWaDk4U1ltU2NYU3h4RFNDdnRKd25zVWFsUzFJ?=
 =?utf-8?B?UUowVTh1SDZFY2FobTFRaEJxNExHVUlLZ2xKbGd3ZGdoMjdVL2oyNEtTd1ZE?=
 =?utf-8?B?Nm5SSkJhc3pwT1BDVVc5Z05qV2Q3aXc0YmR1SG1wODU0bUQ1QTBvbVJhdkFs?=
 =?utf-8?B?ZlJDaVZ4N2RWcFhYSVlhWEg4L3c1c05kMVgwTWlTY2FVeU1aaGpUWGhDVGxF?=
 =?utf-8?B?aHVHc0dJZnBUM3RRV2hFSnplMVVydStlOEtleDhEN2p6ckI0SXJpdjlsQUVm?=
 =?utf-8?B?UDM5YWM3bnBDRm41bXlpcnUxaDRrK0U2QVlKSnpHY0NDWS9YK1NHWXpaMVY5?=
 =?utf-8?B?TUlOakNTckRoRmU3SlRad20xL29ZVDNFUjZJa0hXejBPTEREaEQ1SWZZNlZF?=
 =?utf-8?B?OWNQcWNpWEkycFFrTm5uaWdHSE9xbzhGNGpiN2EzQXpwVllWQUJNY2tSWTJ4?=
 =?utf-8?B?MElyeG5jMHYzdGgwREkvY1p1NHpWNFRDNXc5bUtOd0N2VWtnb2hCR3N4TkVN?=
 =?utf-8?B?eEhzK2c5YTBWQUU4aVkzYTVGdExTRVBYSTBpMWJQNlNMTmp5OXlSNk1JUER4?=
 =?utf-8?Q?GAld7gPI1+g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWFTUVBQdWd6b1RmSTRYcEQ4VjVvTjI3YVlrdmFXV0hiVUFTb0tveDJGbVc3?=
 =?utf-8?B?Y1dDVFdxdlhQenZteERlMFdMdzl0ZXF4VzFrb2dPVGNkczdXUE5LODd5akdR?=
 =?utf-8?B?blNkQVhZQ1c4VHFtd2JaZ2FGUGhlSm1yaWJ1UURYYlFITmwyNms4OUdiVEtN?=
 =?utf-8?B?Z1BBQXVkMTJpb0tpRWRZaTNpZ2g3WUE0UXdhdFZ5OFpmSTY5dkp4WjBUK3ZS?=
 =?utf-8?B?RVpyTk1zSnVXY1FyWlAwU0hmNkxZR3FoOGp5NTluYXhHYXpUbVN1NkxEVkV0?=
 =?utf-8?B?OVhINXMvRkhnWHdlKzlHWG1XclJrTjE5cFdkS292Q0gyMTZKMkdNbGlYcUJ5?=
 =?utf-8?B?OUhBSFFFRmw3c0hUaGl0eTVwSXozMjBzbGp6SUtydkFFOWtRWktkRGUzc3dQ?=
 =?utf-8?B?MDJQMC8zbzlCSUlGNkVmMEVXUHNBOTZneTZjcytLK3RBWW8vOEtRWG1QbUlG?=
 =?utf-8?B?K1ZOU3RpNjc2ZDZVUEdlYURsTU1zbitOUjFTd0YvWHRkdXhOdTNmd2hCbGNX?=
 =?utf-8?B?YUxaSUlUZzRQSEREd1VTWXA0VnlidS9iOWlWWTNxZkdibjVNbHJPN2IzMUZ5?=
 =?utf-8?B?WHNnaDVBenpqY3BHaWZWZTUwc2dyK3JwMm13V2dQaGVXNmdFaFdoRkEwWTJX?=
 =?utf-8?B?ZkI0b09LMnBpRGxPSjJBY045VVE3bWM5cVNrcWl5a3pnaFpkK3UvQSt6bnMw?=
 =?utf-8?B?ckIrWDUyeFEvanFVVjlXSDZTdnV3bHdFdmRTSzFEUVdBNStwZTRyM3pqMTln?=
 =?utf-8?B?cnExN0tMNU8xM2RPWVE2Tk1iM0pwaVd3L1Z4a08wNjNoUEFrMU9DWmFzWS81?=
 =?utf-8?B?MGJOaVNYMDA4QjNYOFd3YVlMVFBacG54ZFZMRG5xcnRnRVliRUJHZElRcVFu?=
 =?utf-8?B?b0tUaWk1WlEzMlpnK0ZHYkkySW1tL2Q5blFMcmJUb0FpR0NOQ2JtTTdlNDFt?=
 =?utf-8?B?TmdUVmdOZ2V4dkFBMldkQm81eDdFQ1IwK0w0SHZaZ1RGMTlDQU1OM1F4ZG1P?=
 =?utf-8?B?bVhHYWJFLzdDRVZmcjRncFdEcEtnYlUva1lJSEdoNFJSektwbExnc3lvdG9w?=
 =?utf-8?B?WThIR2RXWXp1OU1tVVdpTG11Slh2bllFem1iQ2tuaHRJcGhEZmF6dC9USFNn?=
 =?utf-8?B?QWphVTVDUDIyaWVzN1h5QTBreXpjeE9pRzFLY2FYWk1pZ2dRM2xVbjdGTngy?=
 =?utf-8?B?MG9MZCswbmoxU2E4QVk2bU9rRW02RFk5YUxwbkRocGt6L3lHWFFDUW9HZnc2?=
 =?utf-8?B?UlBjVDBjRTlnUkYrcG5TU0RxZWpGMllHdkF6UmwraFpBS2VJb3NjQXdnLzM3?=
 =?utf-8?B?YW9qdG91RG54LzZ6em5NOElHMEtpcEVVTGlOOWloaW9tMFZCMTNocmdBYm16?=
 =?utf-8?B?eURzbzdnVy9abDZuYjRzMFlvaHVpeTdtajA0dThOTEUzalk5M09UTnRDU2h1?=
 =?utf-8?B?Z0xZTFVBLzl0UnZCSmd2bXlUeVhwTDR6N2VQdy9nWThlK3JlVFFCUTBWRTg3?=
 =?utf-8?B?KzNubzkreXdZTGpiMGMveVYvTzVWYXJXT3E3S3B3MnQ5ditrTWw4dHJXb0Yz?=
 =?utf-8?B?VVVieDZvUy9lWUJxbmVrWFoyK0psbzRoT2FmZ2xYZnhyT3EwVDlPTlRhbHF1?=
 =?utf-8?B?N0Y3VjZyZFJnUCtWcVJtcEtqcnNLcXZMaEg0dmN2SlV4cGVHQmV4WXVoYVBp?=
 =?utf-8?B?aXlFS2dwV2lta0N5Zm9hNktzbjRGU0tyZEFMRnFtZDBLUFRkUU94aGhaNXJ5?=
 =?utf-8?B?UDVDVG55TXllMEhSU3N4RW11WitZd0MxbXl5cmc2Mm5yVmJhSEtmTkVIc09C?=
 =?utf-8?B?bmZOdUlTQVhCVDBNbFZYTHB4eEhTWWJWUlhES0tsdWx6NW9jUHUxd1hFenUr?=
 =?utf-8?B?UHhyZktmWkRxL1NkM09JWGR4RUg0S1NicEpQQkliWWlyMEJIVUJzZTZOZU1z?=
 =?utf-8?B?S3M1ZkZNV1grYiszMXFCN2dLNDJGYkdDQWlIeXNzZW56Yk1CTGx3Rzhmdkhj?=
 =?utf-8?B?UWd4Sjl2QjlZNWw1S01HMWlIQll3MG1JNUNmMFZnYkpLNit2NnUxZ2hXVHd2?=
 =?utf-8?B?cElmeHN5Qk1rayt5MmEzS1ZTVHBETHMyWnF6NVpJc0hsdUZoN00zQVF0MzYx?=
 =?utf-8?Q?QntoB2d0wSKIcoqtugrgdHjIy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd86225a-e9c2-4c2f-f851-08dd9db7c3ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:17:55.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xm+fzBbi9/YyG30RFfSe6xkWXgvEYHzWcO3k3D/G2s83tF54tn1zHyNA1Ip2YLX3MwHtr5rCO20t3u9TnjFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8804
X-OriginatorOrg: intel.com

On 2025/5/17 00:45, Jacob Pan wrote:
> When vfio_df_close() is called with open_count=0, it triggers a warning in
> vfio_assert_device_open() but still decrements open_count to -1. This allows
> a subsequent open to incorrectly pass the open_count == 0 check, leading to
> unintended behavior, such as setting df->access_granted = true.
> 
> For example, running an IOMMUFD compat no-IOMMU device with VFIO tests
> (https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c)
> results in a warning and a failed VFIO_GROUP_GET_DEVICE_FD ioctl on the first
> run, but the second run succeeds incorrectly.
> 
> Add checks to avoid decrementing open_count below zero
> 
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>   drivers/vfio/vfio_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 1fd261efc582..5046cae05222 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -583,7 +583,8 @@ void vfio_df_close(struct vfio_device_file *df)
>   
>   	lockdep_assert_held(&device->dev_set->lock);
>   
> -	vfio_assert_device_open(device);
> +	if (!vfio_assert_device_open(device))
> +		return;
>   	if (device->open_count == 1)
>   		vfio_df_device_last_close(df);
>   	device->open_count--;

-- 
Regards,
Yi Liu
