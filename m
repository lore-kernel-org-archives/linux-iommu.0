Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F4F634
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724037015; cv=fail; b=dFVNCbLzGOsAA+7UC3DbzcEev54fFbFkyQjC3SoTjKXzIovu9DvesqJTAcjamzhLh8k5UFWzr4KmabwND1SHei4M8MxLwAc665ydRR5EbktCcXbr1X8rgDFc9BT0G9z67pcNqwd35UTAe8WUSeJ2NsfNZbrtUb+RgXJfVjmSGSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724037015; c=relaxed/simple;
	bh=jGGPOUpXGVUiCjcJ2Z37+oktF/zT26+1RU78HCfTC+A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XQYnervLC9yQiyrBfxRiNq4tGL1GK8n61VRpzoG82vzaNF2mGNRuKbsz/aLuGM5KB18MQcFGIk51pVCk4FAo3bWuvNy3joPOvOBtpwNtreb4eGktTbeZ8gRGsdHeymAoUJFFjCkbVm0+WRw0pB0pq/8cCqqeERcX3T4OJwExTyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DagfHlRf; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DagfHlRf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724037013; x=1755573013;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jGGPOUpXGVUiCjcJ2Z37+oktF/zT26+1RU78HCfTC+A=;
  b=DagfHlRf+0KrjEaBsQgt01d1AC2ljDjf+13vLo6kqFoU8I0csro6RdCa
   S0SFLUV4QoBtTjPP9TukMNw0jVdMqZ+rS1XX2gPjZgVHftidgJzUhXVer
   GbMtUXv76JRsFbK8QiPLXjWiHRDYshpEseUdw77/EBoBI8CRRTVvQrP6a
   pRZV0DVGAiaibMjCxcaoR2vmGXfOs0DhZfZi2Jv8EpFojeUKNFJDXyrvI
   O1YOizNh8oqO7xtQNwithVSlbOU72F7kle/s70toM9C2+e1rmXZt83pNE
   k0p0AaS1K9n7IsXOzAHVRZlYkPGeZN5TpW43vNRilP/x734+/DN2boz3e
   Q==;
X-CSE-ConnectionGUID: wh3DWNrSSI6p8QUEXQwovg==
X-CSE-MsgGUID: B95OBQ01R+yJ7u9NvSZQNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="22416567"
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="22416567"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 20:10:12 -0700
X-CSE-ConnectionGUID: EeJ1VaAhRSulE5qlCKRLbA==
X-CSE-MsgGUID: UBn5lIlVRhiPLv5xzJrWBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,158,1719903600"; 
   d="scan'208";a="97714860"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Aug 2024 20:10:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 18 Aug 2024 20:10:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 18 Aug 2024 20:10:11 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 18 Aug 2024 20:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msEYhLx4mvEjjifiDzM6r1vTiNOWz1AuPoDiGESA4JwyeJP1HYMTC+nOCoABCZgpu4nBBs5I85gGbA10SEsy8QqP4XEgf4aCKLv6+aKQ1eyuch+qsCU5s+GwdiXISuppj31MZk8yUpZTyYCWDQG+B9dVffHvIMlyLRXKOjvChNAGfcbZRJoH5VPSdkLVo2TofGhqYfzjUgsTH27KtLF7VLVEp4xPKZ1MtAncbkPsEp/WEwi+lsyGkXvRjm2V0M6J4HdpBvo1ep1Nzp5CaLh0TwiGW9x+kz4d1tdrD1kklddTMdppf/RfTWfjuDvf1HMSF5fMFEImuUBYfW5+Cks3cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7pFOrh+6LdoeXy9FNIlAJH7zwEGBrFoZF0nmH4pEVs=;
 b=WV238CoFfPFwnKlUVeARWjg/T21AdhARNMBheuWOtCozNzVGxi2CE6HZyby415fZ6r5UrJupDOK0/Rq2brlSvH7XxTMcLSOKVDnGhDzIyzeDAXLFQCk7AEonSEAXG6OHg2sO3ODFukT5xjhE5aW1Si7Sa5kYKL8/AOjLjWcn6z26iffzqWyQ1GUkSQGV1UWzxlodhDr0CE0Hw7iY8BxPmJZsvxeXbWeJ3FESF4QcTys1s0lluxxdgk3bKSLuyLyNif9g+U+fwLhfvvLyv4E7ZeL5/mfymNCNjS9QO8aOwCXRpA6o67AT1B1RCmpt7cWn40mlGGFEGmpeKnKKZDAmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ2PR11MB7713.namprd11.prod.outlook.com (2603:10b6:a03:4f6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 03:10:09 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 03:10:09 +0000
Message-ID: <511f140b-2792-47b0-b366-cbbad6e80239@intel.com>
Date: Mon, 19 Aug 2024 11:14:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240816104945.97160-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ2PR11MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 918dbc89-d875-445c-b031-08dcbffc6f05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2ZBQ3RhUjc0RzhvbXhIcUdPZFBnMkNGSWJtcUxhbkJ2ejdLc1ZsQW13R21E?=
 =?utf-8?B?NHRZN1FoeGJxWkEyOXI2eTlENlJ6RjhrUXhVMW1Za0dGd1dTd0pucEtHMEUv?=
 =?utf-8?B?YlV4aUQybm04MitrSURGcWhsVnFSTTdmaVhUWXFsQXQzWGJyUmNha3MyamF4?=
 =?utf-8?B?R01vWHpiWlhPV2p4eld2cW9BczRNNnFoODlpRzVhTUhIV1IvWUlUN0kzOUIx?=
 =?utf-8?B?ZXljSUtFb0VmcHQzL2JIbGdGZlliZXVHaWQvVE9KRUVpa0tvUk1KSjVEWHhp?=
 =?utf-8?B?Z2Q5SnBZTmswV2FpRERXQWUyNXJ3WW0wMUxPZFc3VHh3L2xCcTJsODlPUTA4?=
 =?utf-8?B?UlN1MXRRYzQyeFdxSElGTGtLbXF3a1Z0WEZBcTR4V0pucW5OejE5eUVvcUND?=
 =?utf-8?B?S1prNzBjaWIvZkQ1TlFZUDZnSFora2tyRkd4ZXVHRkVTU3Y5MVBNcHhTejZH?=
 =?utf-8?B?bGxMTHR0ZTcrN2ozZHRtOElQUUpqUUI0MERadkVIRDg5RXF0RWtzUUxhVnZm?=
 =?utf-8?B?azM2OXB2elNnOWllSEs1QjNaQWhISFJpUFp3Nkl0dTlKY0hzVzJISTJWR2p2?=
 =?utf-8?B?bk1LZXVCbElIOHNDUXZrY3ZRMjErYXFzZzJrZW1wRU5yOHZwM2JsdXdrMXBH?=
 =?utf-8?B?c09jQTgzUXVjaUY0c1B1YkQzRitpd3pXUzIyaUlLdWV6ZWplc3pzdExHcXVt?=
 =?utf-8?B?eC9pQ3RyQWcxRjgzVllnYmZBT3REc2x0THgvUGcrWTczMU8vOGE4N1FqcWxh?=
 =?utf-8?B?K2ZNWDJKTFVPSzhjV0pJNHc1eUFuM2EwUFZ6TExVZFhMNXYwZXlnMGxnZ3ZC?=
 =?utf-8?B?SFFRcnZTeThSSnpZS3hoQjJCTktKSXdyY1p5eU9jQlFTcWthVDBYNjdrczNa?=
 =?utf-8?B?UVkwRmR2T1B2Ykp3RnpRdmFhVWVKcnFWa0Y1dWxPMkFkV3NhSndKdTg2ODNh?=
 =?utf-8?B?elhKTWNreVFNSGVtM1k5NUJ4aVVKajc5Z2hTZWdWajQyQ3lKZnhIWFZBSDMw?=
 =?utf-8?B?V29VVDdqV2NuYnZaUE8vYWRHVUYrSGptM2doL3hKWldoM1BBeTcySWsrSTJB?=
 =?utf-8?B?Y3JPNUdoejM2UU85N1VKbDl1OS9wVVF6USszVXRiZWtGcDcrVHBkL3JoYkN0?=
 =?utf-8?B?aVVXL0xsVjh6Qzdla3FGNHZFOVBPMlpTQXdTbFBjdjFvUEw3ZnZvb2ppa3Z4?=
 =?utf-8?B?dGNnc1JlOCtDdWE3cS9raTNTWHRsQlU1RFJqZzlsdU5XM29kVFVSdDFYRGRI?=
 =?utf-8?B?dURFZUJ4cVYveVdwWmtId0d6anVmUFJiYWVQaW43SlRHenVwN0FEZ0I1TUIy?=
 =?utf-8?B?dHlqTU01L3UydEhoZ0Q5TGUrSnVqNEhuejJLT1dtcjJLcE5rZ00xQ2t6YWx4?=
 =?utf-8?B?ejZ4eUFpZ2VmUGtCTHpMWk1rMVE0NVBZTTAyckdRZW5KSGpNa01WNmJONjZQ?=
 =?utf-8?B?WENlaUxLNUYzSnhVR2JUdzRJaUpPRk9qNGFpQU5zS0ROc0hobXZZWmZsRUFF?=
 =?utf-8?B?WHVGTzBraG54WVRsdVUvZDJvSmw0eVU0MUJnaU53eEI2YXQ4N1VmVFRLQVA2?=
 =?utf-8?B?ZzBOZGlacEsrc2U4Qk9CbDFFTitpQXNhWlRmaU5neE5qcGJ4eFg0SVFNYVdy?=
 =?utf-8?B?K1N6Sm4xckZPNHg2eVBJU09VREhoL0xuYVhGbkRhZ1VUVWVXUU0ybnEwVHdH?=
 =?utf-8?B?MWY3ZVEvQUhVS1ZWRUVrRGJRMk55UWlGYmpuQWRKTU5mZ2VrdXhncW5nd3Fx?=
 =?utf-8?B?Y0lyZ1ZpdVpLak5ZNEczQjJwRHdDUkVrVjVTT3lDR09rMUYybWJwbG9iMkRs?=
 =?utf-8?B?aDBKOTJJZkluRG5pN1ZoQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R01VSGtobUFUNnNwMi8xVHVSNE5waGFsZWtzZ2ZlTU5lTWl0a2czU3BvYUsx?=
 =?utf-8?B?eWpEZDNLTnlBWmxaN0lzd0UwS0UxbnhrU3VhVkJRVlNkQkF3TTFHcmdGTDQ2?=
 =?utf-8?B?dnlqbzZOdjFEWGo2ck5zTm5KaVROV0FzZkNxMWZnRTdhbnpmSXRRaUtTT1Y3?=
 =?utf-8?B?ZEs4TkdZZ1o1N1g2QUlzTS96SnFFV0M1WGU4TEhCcWdlZzkybGFYRi9KMEpC?=
 =?utf-8?B?NURRd3AwL0RTNCt3NWVJU2Y0Z0xOdE5XOVQwVE1MMGZvNnJBTXZPaW9zalIy?=
 =?utf-8?B?M2hHUUlRVGpjZlQvSTN2cVpvQ2N1aWxqREs4M1VzSHY1cnBOekNMR2k0ckEz?=
 =?utf-8?B?ZHlITGN1QkMyQUxQd3czWG5yOFFUaTQ0djZCbDR3Uy85Mit4Ym1vV1VNTkpy?=
 =?utf-8?B?NWs0NzU2NG9lMFZybjBzbVU2RFlXMUJldU9tdUlMWUFyS3ppRnc0aDJhNWxr?=
 =?utf-8?B?azZkYkR4dngrdnJEQ0JPNnlGM2ljYXdLakZUNFNrU2tQbVp2WXFBLzRnVGpG?=
 =?utf-8?B?eUFDNlAwaGNTRERMdU9NMGpvZ01sQ2NSYjg3Y3hFeGVJclB2c1QxNEhueDVH?=
 =?utf-8?B?YjhVK3h1RFpYN3JGSUp5Sk05T1VsYVcvTVZ1M2hIN0pyWVFjWGw2UEpGSHgw?=
 =?utf-8?B?dEs2YnVIa1BTamNKUHFIOHVvYlk4U2N2MUdIWmdvOFZ6ZmVRYUZBTDBGcy9G?=
 =?utf-8?B?bjlidENudm1MSUt4d25iVHduT3pMMXJlVDc0YUpsRm1FMEJtZ2E4R21BRXMx?=
 =?utf-8?B?N1NXVnRmOGduWnQrTE83R1k0dnExSm93aS9kQmJFYWd2VWlxYTlPNlE4WVlI?=
 =?utf-8?B?RlFLOFNCYngwcis1U1A0Qlc1Vm9hSlI0UWRBaS9kTUF4cjZkS3Uwa3NCYzhO?=
 =?utf-8?B?cXF2eXhoSTcvVVh1Q2ovNzhPLzNxdDhSSENzZWljaFowclZ5WW9pTG53TjBR?=
 =?utf-8?B?cUVGTE9ueGFPbUVuR3FxQU5XVGVkb2s0aG5XVE1tb3plcXpaQ2dQQ3dqcHZ5?=
 =?utf-8?B?U3Y3V28vSjN3TExGN1k3SlBqM0lrTWR1VlY2OU13WG52K3cybmY1WnZwUDVS?=
 =?utf-8?B?MFlZUmRVVm9vd2FDbHBORUNyN2htRmJFcWdOQjFEazZ6aE40QkF6UGxlUVJp?=
 =?utf-8?B?bk9CVHFBVmZQY2NLdlU0a09nT0hsUmlFZmQ0b0ZEMXZFUGZFLzB6a1hhUlpz?=
 =?utf-8?B?ZmRUYlFUOEh1azNNM3IrT2d4MlQxMGJUNHVLVW41NnkrNUNBaW1Ka3JpSllz?=
 =?utf-8?B?Z3h2Qnd2NFpTS09tTFBnUE1JK1RHS1E0dE9UeE44aXFFdFZxZlB6ZmY4TFpl?=
 =?utf-8?B?cXZoUk94ajR3dGVpcmlaVjUzWVBYNEZqdEcwd2hSOWZRRlZRdmY2d1lmSzBO?=
 =?utf-8?B?QmlzYzVNZW11eGhBMVNzeVZpaEQvK1hDb3NBU2lxWWxkTGJ4cGtKdG10MEc1?=
 =?utf-8?B?S05XYkMyTDUxY2kzaXFDNW1Dd0l4bUliRGx6MkNDOG9wZDl3RFg4WHFiTU9a?=
 =?utf-8?B?R0JmamVGYlpMSTNtMEZpZjIzOGo3ZVYvYjFjLzdWR01XdEoyK29VUTFRbThW?=
 =?utf-8?B?WmljbHdsZGdiK2EwYWViWjh6THBrTi9ON0J6cllaOUVsTm92anV0U1pYa3po?=
 =?utf-8?B?Ylh1d1lqK0Jmb2lwWTQ1cnQ1VGtORTVDN2U2eE1oQmJ3ZFJwTDFEdlltMVE1?=
 =?utf-8?B?UE5OOUEzSTV0NnBoQ3hOV0J1LzQ0TVNiN1hLZE1qbitMYVIxR3lxaXJFazdh?=
 =?utf-8?B?cFdGbGxaUEZKZHd5R0xoVnJ4aHFTakRJUWNjSnY5c3I3azcrcStXVzMxbkha?=
 =?utf-8?B?WUsvK1NQYXdCQ1dDcCtXaDcyOVFDS0EyOWFjQTBpWGdRUlB4MW45d1B4SDJ5?=
 =?utf-8?B?MDBjcldNc3RsRllNOUFnRnRZL3o1YjJ6QUVnVm5NdzZiUG9BOHlYNEZlRlN2?=
 =?utf-8?B?VWtqTVNpZXRIVXNITFBjZkVDdGthUmRoR2tqMG1seGxOQjhWY1dtaWJFY0tp?=
 =?utf-8?B?eG5tMWNnUlpKNk5pNktUTWRmNUNDN2djWnNld3hTdjhxdkszNnl4NW51ckls?=
 =?utf-8?B?Q2tHU3cyYXlzZTBxaEZMSjRpMVhRSFB2RDMxem5xd3R2ZHFKK2xZTmlzSHJh?=
 =?utf-8?Q?LBVW2QMLsJQdEusvNKEj/M1ln?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 918dbc89-d875-445c-b031-08dcbffc6f05
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 03:10:09.6272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2xVhjmNF0lnq1cGsxtv24mbZt9kR6jZkjK/7KN2wg+OG9vtU6vRWGVjrc5ujly/SwusXpUuPfpjj73xNXpazw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7713
X-OriginatorOrg: intel.com

On 2024/8/16 18:49, Lu Baolu wrote:
> Currently, PCI PASID is enabled alongside PCI ATS when an iommu domain is
> attached to the device and disabled when the device transitions to block
> translation mode. This approach is inappropriate as PCI PASID is a device
> feature independent of the type of the attached domain.
> 
> Enable PCI PASID during the IOMMU device probe and disables it during the
> release path.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 9ff8b83c19a3..5a8080c71b04 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1322,15 +1322,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
>   		return;
>   
>   	pdev = to_pci_dev(info->dev);
> -
> -	/* The PCIe spec, in its wisdom, declares that the behaviour of
> -	   the device if you enable PASID support after ATS support is
> -	   undefined. So always enable PASID support on devices which
> -	   have it, even if we can't yet know if we're ever going to
> -	   use it. */
> -	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
> -		info->pasid_enabled = 1;
> -
>   	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
>   	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
>   		info->ats_enabled = 1;
> @@ -1352,11 +1343,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
>   		info->ats_enabled = 0;
>   		domain_update_iotlb(info->domain);
>   	}
> -
> -	if (info->pasid_enabled) {
> -		pci_disable_pasid(pdev);
> -		info->pasid_enabled = 0;
> -	}
>   }
>   
>   static void intel_flush_iotlb_all(struct iommu_domain *domain)
> @@ -4110,6 +4096,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   		}
>   	}
>   
> +	/*
> +	 * The PCIe spec, in its wisdom, declares that the behaviour of the
> +	 * device is undefined if you enable PASID support after ATS support.
> +	 * So always enable PASID support on devices which have it, even if
> +	 * we can't yet know if we're ever going to use it.
> +	 */
> +	if (info->pasid_supported &&
> +	    !pci_enable_pasid(pdev, info->pasid_supported & ~1))
> +		info->pasid_enabled = 1;
> +
>   	intel_iommu_debugfs_create_dev(info);
>   
>   	return &iommu->iommu;
> @@ -4128,6 +4124,9 @@ static void intel_iommu_release_device(struct device *dev)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
>   
> +	if (info->pasid_enabled)
> +		pci_disable_pasid(to_pci_dev(dev));
> +

would it make sense to move this behind the
intel_iommu_debugfs_remove_dev(info)? This seems to mirror the order of the
intel_iommu_probe_device(). Or you may set info->pasid_enabled to 0 in case
of any code uses it before info is freed if keeping this order. Otherwise,
lgtm. thanks for the quick action. :)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   	mutex_lock(&iommu->iopf_lock);
>   	if (dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev)))
>   		device_rbtree_remove(info);

-- 
Regards,
Yi Liu
