Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308E34EB55
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 06:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719901279; cv=fail; b=JGRCI3LbaRbb8cAPD/KV7f7+lKepExQAX1To3M08NJuDq9Waa8esyKKgEJvILf+/b7LrST1az1V5F21VlpsCLPCu6jtpSnJ1y9P3qEXnFFjvs0n3mhdYXcq4tVUMWq8zYTY+jQVjf8ahB2AA9lTp0ySTa0NEX2CtlM2ZnNaBgkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719901279; c=relaxed/simple;
	bh=brC0O0Pc+4FCt1S6/+vUSiNOgOb50rDQ0cqw4RtGJDs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IrN6PvwnRxASMMpty7x94WEeMvO/AD5s3mN75zAyl87Pl/pvS6b7C+TMyzkNNSoZQTRt7G67WA/Lb9rfm42hHCi1tvGvV7Rfq6fUevsBhVAO7s3fyXlQnIsXk2cwJQ0Gc4hlPBqRLbJj8E+PvBHrIa9L1YkroWFUAbb1YWzqGgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lcu2AvO7; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lcu2AvO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719901279; x=1751437279;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=brC0O0Pc+4FCt1S6/+vUSiNOgOb50rDQ0cqw4RtGJDs=;
  b=Lcu2AvO7k+d5nV5lm+gsbcwX9PhoIAgqcnPq93tWh3m7qm+EU0nJBITj
   BhUdigYmSMcuBl6zjoCosSj+hPc6jf0IR9T2rqmE44o+T6njN1iQqFcCR
   O9Dx3+ikXXFefcz5UED6Hm5QH3I0Uyn/k+QHVU5CLbRBP7G1C7kK5o1Eu
   dQn3xr0FC+PQiqpDehen3Ufr3iUdF9beGZVJDuqNjUMu1YtBnMItS+Q3e
   JFM0n047A+jztMtaEr/1bQaZQgFxyo3Fjly/Y00TOKuhM6sI03YpAKzNi
   VPXvYcI2fFhNbYhvA+DLGLE/vesBJ5ySDqU9QArKIW/OQbp2ZhD0BVueg
   w==;
X-CSE-ConnectionGUID: UymuNJdoQeqbxbngg7PPag==
X-CSE-MsgGUID: mnWEiqNBRDy4eyesAQlOsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27652383"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27652383"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 23:21:18 -0700
X-CSE-ConnectionGUID: pfFQWP4LQPqfv5PVZe0FPQ==
X-CSE-MsgGUID: n5fX8FtZRtCqy4Am2zxG2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45790013"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jul 2024 23:21:17 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 1 Jul 2024 23:21:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 1 Jul 2024 23:21:16 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 1 Jul 2024 23:21:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MS/7lBmOXNcBw3erb8skxuM1KkWcYs2Warhc46ztc2IClgvX+hUx3a+vNTY1PFY44KAFnqnZ0tm6JcrhaYIKD1uXVkiHfMAYeX+hl9e+0EOMZ8RsAmsOLq4CEJq+gje5eDuMTbGDPV1R/roTAwRJCIIyCLJa74sLM8jLx80w+MZqyZbSSlLyQdBCk8MK1TqyT4FTGNyKRSYlD70amoYvt96EHxIQY45NM61Tmuu1/OG2OdTaTBeESJx21iAsfn+/5pR5yyibZAqdrAM19vbMsyABqZ4tIUz8+eNlgwIpAKFxhdDsnsEZq8Vu9eboFTzPGDnBLHV1Tz66yG87YGjsFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRla240qtIxdwJ5bEYMH6EYGI/xXG8qNLG6KWqsBnx8=;
 b=JCXQRCVK8mjVdfOy0aG1nRLlKot5VVKOLqup6lPp2BEfgnoxV0Du+1TZo/9Usa1C8XIhgbKXuFZYZKcbZCTnrWX+eTAL5G7R0CI0qGZmZtLGUvJSfE0c3ncRzvumC3VnKunIikOBLsho997F7eDGB1vR7YMHcROUuOpqodS3jMDqULS9vXpLajYz5qoEY9JnsdHtYILRqgS05NefzAlCCcQ1+B0S4LyNZC9nD765G9JE1cruo3CPmmNbQcM49YVdn5gFmgUwXfGBtEo9vKkxQ6CMp955jQKI7dwBxZkfWpt5InTQzd6m6N5iNaBUs9rW/i2KW0dtICLyNBqOW1vdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7248.namprd11.prod.outlook.com (2603:10b6:208:42c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 06:21:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 06:21:09 +0000
Message-ID: <d74b2f95-2105-4e25-8c86-b5d5204798f6@intel.com>
Date: Tue, 2 Jul 2024 14:25:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iommu/vt-d: Add helper to flush caches for context
 change
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240701112317.94022-1-baolu.lu@linux.intel.com>
 <20240701112317.94022-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276502F9B5AB45EE9BF28628CDC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <14a7db3a-663a-4e3f-b29c-a733e98efc32@linux.intel.com>
 <5a8802e3-feda-49bf-b11b-2ba6c236305e@linux.intel.com>
 <1c9204d9-d9da-4785-b375-368b5ba9ec78@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <1c9204d9-d9da-4785-b375-368b5ba9ec78@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c5bb9b-feef-4dc9-4eb0-08dc9a5f29a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2xOSXFQanZuc00rMFRkMWJSWGF1L2NlQUtzZWt1Z3EranZVc203Nm81a3A0?=
 =?utf-8?B?VUMwUXcvdlFlb042NWZXSk00NFlZYTdLOXR5c3k2VlpsWVVOZHF0Y0wxYi84?=
 =?utf-8?B?QkphM0JXRFZlbkdxTjA2S0JNeTZJUU0zSVJGMGdjVkVIM3hYQUo2T3lnWEVx?=
 =?utf-8?B?bTVRSDhpWEFnNUVoNlVYZGpiNmk0MDR6UVg0SU9PbHFRcUpOWldCaktITXRW?=
 =?utf-8?B?cDJqMjBJMlVDWDczWU1yOFA3eGNkbnZuYmlIVldzTUFCbitXSDBrVmVtMnJp?=
 =?utf-8?B?WGt4WFBnaUNWeHpQdm0zc1ZkKy9mclNXM2tYYzNqYW8vY25Ra2pKZUN1WENy?=
 =?utf-8?B?LzVKdUlLMUVOSWNWcGprUlZPUkZZSWpQazdKZVJWTW5CRXg5SzRIcTVWSW4v?=
 =?utf-8?B?YXd6eEpsMU9YOHJ2YnBrTmdTREl4N2ppb0MrOG5lSlEvUExNVExPKzdtc1Vm?=
 =?utf-8?B?Q21tSS9wc3IyOHBoK1NvdlNVQUZFOCtrUXI5amZZNUo0ZzZRQmRBdy9jN2pl?=
 =?utf-8?B?Z2l2OU40NWIzTGc0dGFqYmY5ei9nNi8vSGJxQVlGWHVWdkI5TlN5eXVCN3NN?=
 =?utf-8?B?VmpubEp6a2Rqa0cwdWNsNE5QZTNBd3dTeFAvdHNBeUMxQlJOZFNrYWFhaFRQ?=
 =?utf-8?B?SG5BcHNaVVJEVjNvY3Q1N243bmd5Mmp2RVFQaWt6TXZUa0JWWXl2dVJCSjJs?=
 =?utf-8?B?Nk16dWtIeDNFWldNdk5SRjZLaXV5TEloSzlMVU9QZ0xsUVkrRE5MU290LzNS?=
 =?utf-8?B?N1duWWxlK21WYTF0aW5oZTdPenFaSFpYSU1aM3IvMTFIR2RnMDBvT0dFMGxC?=
 =?utf-8?B?VUJ1Q3B2cVVacFh5Vnhtbm1DWis3a1JGUU5EajlOQjNPVTB0RkQ3amRoSkor?=
 =?utf-8?B?THQ4eG5IeGIrRUJuYUtycHhtOVpZd3Zma3F1NjlDOHVUYk9BdHBjTEN3U3hZ?=
 =?utf-8?B?ZFNsakUzSkpYaUI0b1NOQmZNdlprSDNjVFZCUU1OUENvMTRBbW55dlZWc09G?=
 =?utf-8?B?MTRhTSs1YUpldXkwMTFJY24xT21jZnFtVWF3STJ3UXNXbnhZdEE0ODhFbHdo?=
 =?utf-8?B?N1RpN05EQ2ZKUUpnN1Vac2NiOGdmWHArQlZ6NW9OaEk3RTcva0JHKzhmWTJm?=
 =?utf-8?B?ZTZ5RmVvTnJMTUc3VmU1UjBUN1BrSUVuNE1DRnhKZHV4ejlGdnIxdmk1c1lC?=
 =?utf-8?B?bndaZzZGV2pnWllIQ3M0Wlo4VkRVSzV1U25POXR5aTl6eE5yRGJoK3A0SEQx?=
 =?utf-8?B?Y1VsSDRVdFp4OUJuV0dMTlNndXhzUjJQUVJZOWlqRGRtUnFSMU9zWW9rRHBs?=
 =?utf-8?B?cGsyZmNCRzZ4K2lLbUFwbTVVeFg2L0NEclhCamgrRHBua0c2eWdVZlNnb2Rl?=
 =?utf-8?B?Q091UlRXREtZQTFDNDNIMlIvaHVvckdzYjQ4bVdNRHFKelNqNnptR1psa1M2?=
 =?utf-8?B?ZElEQ1UxbCt4OTRuY3BtZFJoSVdRRVBjZll5Y0tmSmlsZGFuUm11ZGxiY2M0?=
 =?utf-8?B?OXI1MFBiTzE2OTlvTlVVWW9YZ3VuK3FucHNhNFYvK3ZHT3FRRTdCbFpFLzhR?=
 =?utf-8?B?NW5yU1ZXOXVjSHJTUEtiNjEvajB6N1l3OTJ3Tm5CM3J0cTgwNisya3ZRRXh6?=
 =?utf-8?B?RmwzZXRPaW1aaDlUZkErU0J5RXhmc28xSEJNVEpwQ3lyelVLVFprM2hZbEx1?=
 =?utf-8?B?bi9rMFlCRVFqb1pXdWhTcXFtSUpOS2dBa3NyNDVkeW15d2xnV29KcDhtQ2hi?=
 =?utf-8?B?TkdKdStJQk9zZHZ4MU1UdmxmcWs3ckgrdmx6WmVWSWdPK1pBeVV1dHIrTDU1?=
 =?utf-8?B?UGFDa2hPcFVzNjd5dVcrQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhvbWxPdnVIV081SEV2ZVZ0N1dvK1VSb01rclIzZVVUbVhqQUowMDlpMCsw?=
 =?utf-8?B?WFpCTEgzdmo0YVQyRTRFdVZFakdNWWJ3NGpMN0kyVEtBZUpJd0FVUUYwVEF4?=
 =?utf-8?B?S1pFTmxRdEUzTHB6QkdWRUQ1d3lnUXcycGtoVXcyWERtT3JxN1dpODlNOUdl?=
 =?utf-8?B?WTJrdC9iWDRjdTdRay83VGlHZzlaS0hJajVuVDl2SHlZOUgzOXFQNTFDQ3hF?=
 =?utf-8?B?Y0Q1QnJSNG9CZ0V5RCtnNHFhaHFsTUNRT1VtNVR1MHprQjIrQ25wZ2lnOHl3?=
 =?utf-8?B?V1c5VDNRakhoWnp4Vnd2bGtWcHlqY09weFFObGNnRGtJVUNyeW5tMGtsK1Nv?=
 =?utf-8?B?TUMySEEzVnRWRXRQNDZLUHdoaUlOSXJnbE9jRjRwNEdaR1V0RzRqQzZONWZm?=
 =?utf-8?B?NXhHY1BuQVVEMXFsR2dZS0pVZktvdUtpWkxwOWFsTU0yd1RoWm1MNVZscUhD?=
 =?utf-8?B?WE1lTGpzSFJ1bU9LeC9WcDc4U2JwMHUrbWsxVmF2Q2RQQjF0aFN6UGNwQ1h0?=
 =?utf-8?B?YWM0TG13TzNEQjIxdGNmSC9tNkhvQ2NNR1RmWGdUT1RaV2NJNXlFcmN3U0V5?=
 =?utf-8?B?YUhwN213Szk1aGVRMXN6WjZXL0dZVjFnOGMvMVpCQVpqMWR5WUFrQkVySDFT?=
 =?utf-8?B?THlDRTA3UWlVOWFLQlZONTgrYzRpNytOM09TQkRMREVqLy8zaTdIay9scmdl?=
 =?utf-8?B?V0NoZXA3bjNCWW1xTXZPc0hEN1c2ZEhOcDA0MVhuTkVLYTlhcC9heEtnamFW?=
 =?utf-8?B?dlVDQmN0dlN4OFZCMitUeld4RFVwbWgxaEkzU25XSG90STMyQnJUaDhCN2Uy?=
 =?utf-8?B?WmZYQ1AwYjdIbTRidFI3c3BNSXlsZUVaQzRITFRJRGJYaUllQk9wbGkvazhn?=
 =?utf-8?B?cE9iOXNjbzlOa3k3UjU5UlQ3WERpcStYa2hhaXlGL0ZoVDVRL3BWL1dscmJp?=
 =?utf-8?B?VVFrMVVScDRxU1JHMFZYRk9ZZkVwM3ByRk42aVVSR3poejZZaGVvMHlMQ25j?=
 =?utf-8?B?WUZzUWdWeWdQWVo5R3l2SlpuTi8rYjhFVTZldXlaS3hLSHEvbm1mZ1BiNlBw?=
 =?utf-8?B?MEFwY3k4VVRPaytjcU1JVDhsM205SUtqeDQ0UzYwc01BWC9pNmM0VGlMaHNn?=
 =?utf-8?B?YUtnbFI2K2JYdTdKTk92cU0xQWRJOHhjc0FPOWtYckliU1NmOE5RWHZYNmhx?=
 =?utf-8?B?SHVFMkF3cTBFQmN3aklQRFpLbWdmc2ZTR3RqSGMvb3l2S3lXaEd0ZitQK3ZW?=
 =?utf-8?B?ekVnRmNoNXQvK2JHcWNuUG5XSFhHMy9hRHNGZVRiYk9sQjNpMVhEekhPK0xL?=
 =?utf-8?B?TUZOeHNIVlJ2UnlKZWpvbzQ2OGJVMUJVa0s3NVpMNDYwYVV3UDRFS1ZpOHcy?=
 =?utf-8?B?NGZuR0NTdHJoTEVoUWlsNW53UmhtOGRnUkdFM1E5TFoyMWNtYjhCWEFUdzZ5?=
 =?utf-8?B?Mldmb2lXZ0EvaW9HMjh4QkRNUVNsZnFMOUs3RnZxRm1CdWljQnJ1WTE2SFdz?=
 =?utf-8?B?R0RrZUZNdXBXWWUzdG94YkVkNDR4VUk1NWxpRkdVa2tGTFA1NzdnL0RseWpD?=
 =?utf-8?B?T3lDbytmS01TejVBRmMrWUM2elJRMXJxcm9sVm1iY1V5RWNYZzB4aERBMzZB?=
 =?utf-8?B?WnArOFJUY1VaVFpzbDcwR0VKbW9EZHoyNjBUTVhTSzlReHJvYk1OQXBXTHJR?=
 =?utf-8?B?U2libTV6OUhSRVdPcElKVVhMWmt5SEVaNG5oZkE5NklzMXd6MWRmY0Urdmx5?=
 =?utf-8?B?WUhZMFlMYURPTktNcm10TjZsTTUyYW85UENKZUw5VDBpU3RHRUVVNWp6MVhv?=
 =?utf-8?B?blQ0QzZ3MEN3c3UxV1ZmbWk5Rng4SVFzWEp6SWU1emo4M1dBOCtpYWtqSlJJ?=
 =?utf-8?B?RE84dTkraVhudDRwNVozemUyWk9XaTNyeGdFcjM0dUlTMlBmaUkwT3ZnWFJl?=
 =?utf-8?B?YVQ5V2NxY0haaG1JV3NkcmdRNmhGeXJvcTdVQnExQXR6MmZBTUUvMzBkQ0xa?=
 =?utf-8?B?Q3FhaW5oNXdqaFFxZjlXUDE4VWsxNUFWK1Z3Yi92T0lFb3BQbWtIMUJFQlc4?=
 =?utf-8?B?aStkOXl2Z1FXT0gyaWh1dnhuWkI2MHJYR3hkMEJZa3Q1SVpsQW5OZlhDN3J3?=
 =?utf-8?Q?cy25k0iFAUWwzrooIKNOH6TPI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 68c5bb9b-feef-4dc9-4eb0-08dc9a5f29a9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 06:21:09.4488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IytwppnV3O7CSNtCNf4KPakVHunOwX8QnJzs3gmu9Thk6FvaN1Qt7nA7GULYCKYtZWwwKdNfGlR0idF5ieg5UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7248
X-OriginatorOrg: intel.com

On 2024/7/2 12:51, Baolu Lu wrote:
> On 2024/7/2 10:43, Baolu Lu wrote:
>> On 7/2/24 9:47 AM, Baolu Lu wrote:
>>> On 7/2/24 9:11 AM, Tian, Kevin wrote:
>>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>>> Sent: Monday, July 1, 2024 7:23 PM
>>>>> +
>>>>> +    /*
>>>>> +     * For scalable mode:
>>>>> +     * - Domain-selective PASID-cache invalidation to affected domains
>>>>> +     * - Domain-selective IOTLB invalidation to affected domains
>>>>> +     * - Global Device-TLB invalidation to affected functions
>>>>> +     */
>>>>> +    if (flush_domains) {
>>>>> +        /*
>>>>> +         * If the IOMMU is running in scalable mode and there might
>>>>> +         * be potential PASID translations, the caller should hold
>>>>> +         * the lock to ensure that context changes and cache flushes
>>>>> +         * are atomic.
>>>>> +         */
>>>>> +        assert_spin_locked(&iommu->lock);
>>>>> +        for (i = 0; i < info->pasid_table->max_pasid; i++) {
>>>>> +            pte = intel_pasid_get_entry(info->dev, i);
>>>>> +            if (!pte || !pasid_pte_is_present(pte))
>>>>> +                continue;
>>>>> +
>>>>> +            did = pasid_get_domain_id(pte);
>>>>> +            qi_flush_pasid_cache(iommu, did,
>>>>> QI_PC_ALL_PASIDS, 0);
>>>>> +            iommu->flush.flush_iotlb(iommu, did, 0, 0,
>>>>> DMA_TLB_DSI_FLUSH);
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    __context_flush_dev_iotlb(info);
>>>>> +}
>>>> this only invalidates devtlb w/o PASID. We miss a pasid devtlb 
>>>> invalidation
>>>> with global bit set.
>>>
>>> I am not sure about this. The spec says "Global Device-TLB invalidation
>>> to affected functions", I am not sure whether this implies any PASID-
>>> based-Device-TLB invalidation.
>>
>> I just revisited the spec, Device-TLB invalidation only covers caches
>> for requests-without-PASID. If pasid translation is affected while
>> updating the context entry, we should also take care of the caches for
>> requests-with-pasid.
>>

hmmm. "Table 25. Guidance to Software for Invalidations" only mentions
global devTLB invalidation. 10.3.8 PASID and Global Invalidate of PCIe 6.2
spec has below definition.

For Invalidation Requests that do not have a PASID, the ATC shall:
• Invalidate ATC entries within the indicate memory range that were 
requested without a PASID value.
• Invalidate ATC entries at all addresses that were requested with any 
PASID value.

AFAIK. A devTLB invalidate descriptor submitted to VT-d should be converted
to be a PCIe ATC invalidation request without PASID prefix. So it may be
subjected to the above definition. If so, no need to have a PASID-based 
devTLB invalidation descriptor.

>> I will add below line to address this.
>>
>> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
>> index 9a7b5668c723..91db0876682e 100644
>> --- a/drivers/iommu/intel/pasid.c
>> +++ b/drivers/iommu/intel/pasid.c
>> @@ -932,6 +932,7 @@ void intel_context_flush_present(struct 
>> device_domain_info *info,
>>                          did = pasid_get_domain_id(pte);
>>                          qi_flush_pasid_cache(iommu, did, 
>> QI_PC_ALL_PASIDS, 0);
>>                          iommu->flush.flush_iotlb(iommu, did, 0, 0, 
>> DMA_TLB_DSI_FLUSH);
>> +                       pasid_cache_invalidation_with_pasid(iommu, did, i);
> 
> Should be
> 
>      devtlb_invalidation_with_pasid(iommu, info->dev, i);
> 
> Sorry for the typo.
> 
> Best regards,
> baolu
> 

-- 
Regards,
Yi Liu
