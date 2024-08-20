Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41EB18E367
	for <iommu@lists.linux.dev>; Tue, 20 Aug 2024 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137495; cv=fail; b=fzLn/jNHHLAJeIx4wzu9d4QzXnidNptiajCHLIHc7qfNj56IrYbr+gcsi6iuKCTpMxl7N1pQJRPE2DN66PC1RfFKkE8N4qmNhEiGg2GBzgM6jnVFoCoqUTKZIApMugKEhN2pVEJ3LFN/c6jcxGxNrZURHdgK/pC/9MeyMbDniCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137495; c=relaxed/simple;
	bh=gc3pSq/B/ZlHYSs1lVeasQE5c4aHsJDPfWzMup4NMmQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kir2rLt1aam0+wWNyzVNAI3Wgn9vPJ9/3k+WkomeJKXJFj5qelolozyDKmkG7dCRFwMkrWeAPhbMb70Pqov3df/6GgT5nHhR9+Fu9mOUqWgFbmFs0w/xGI/pVApvVp2yOLbKLZ6fual1Bb1PR5mwkxuK/AbreEcqcVPgFsJDj5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j9SYENIZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j9SYENIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724137494; x=1755673494;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gc3pSq/B/ZlHYSs1lVeasQE5c4aHsJDPfWzMup4NMmQ=;
  b=j9SYENIZRywQCCl9Xp5IVHJ5G6t7kX+GnzTLs2dBDsZGn1hqO7h5rx8l
   dZZNYl42q56GxdiiwoAOmIQmQyheOoUpy//qH46XCYa4TcaS2cIfLc/vm
   6alCVRe6vTw/vRe0oW53SzBKCdj9708FDTp4SXKKP+uozv4pSf0DkoYEB
   /GOXWnjmhVMN392kVufWkOXAE0DprYCY3K+yoaVKpniWFAQ96cVdtU+1U
   wKS6IMBvGdhkaq7X8xJkiRWJET74dCZDwQJeZ0uCOiBL4GHpO9GBIupe6
   ovjg+OQjhgL7oDXBthBstOG51GzpbIOEeO7yfYBvTN3aTuXty3G5QQXky
   g==;
X-CSE-ConnectionGUID: GtIEuf3USz+GTruCtkSyiQ==
X-CSE-MsgGUID: 1mbQu4XqQPuyjhcLvHU5tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="22301419"
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="22301419"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 00:04:53 -0700
X-CSE-ConnectionGUID: wdx1Lah4SdCiQpWyERJ1fA==
X-CSE-MsgGUID: CwhO1+rJR1q6d/K70iJz1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,161,1719903600"; 
   d="scan'208";a="60947900"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Aug 2024 00:04:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:04:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 20 Aug 2024 00:04:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 20 Aug 2024 00:04:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 00:04:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE7C20joDEUr6RI9UNrCAjcUscbYjtT2vUhOCzAuCMwPOn0jQpd+ufCA+7htilgXE8MqKecuMl10wIHkMi3ckZ0aVZizvz9Rx/Mu8Lm9G0AvSjs7/QfCBMbOe9xJ+HiXUzxKv3bk/QifI8oFS9RE7B1OQUTkmk+VzK1x3SbdlbkhU5XlkHv77SIeqjk+E8ALDNgeZKdOmXWkgOp1CyvNVopyDQrafevvU6k9WKhrRWKbPRCWCLwSVUKFQ5pT3YAQCqTfmNL8UdsGzj+vKGRnLOeC/eI90x9R8eeRbtQ4vtlxzSJD+ezjBVFHdqagFiATyD3T6PITv9Oe8qr9no4X2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z4gF38IbfLsaxPQxucvbDB4r1CrMi9h6hed7aK28RA=;
 b=cj1psNslAk1G8k+G0wHJM+F1CoSdUoaqJ9ZLRNDON1SToyT3jz9OGh6VlILNUqSKRGl0b4QAF8UHWJpyuwvj+TI2p4616BSx/F2TpfKOFQ9yRuzrawalAHb6pfATogynWQZrIRp9KYtCJtOcCtB2d5JG2ofF8R3oMvmx0sc2/A8yiOXIN3qzhwnvaIuz5QyA0I2u3pOguK7smFlmZfCI4DYOPWYJ1hjE0eWPlKyeFkTyp8ZXdzOLNSq1IVrSY9mXdW/s+FQYc2o8TaEX4J/SZ3VJ5MzWIGyxH9xCLtq/YTlfylsMjat1iJBPONZbJgNYRGyWiDUvnRbV3og5ljIHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Tue, 20 Aug
 2024 07:04:48 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:04:48 +0000
Message-ID: <9047e540-a993-473c-9d24-8359cec67b5b@intel.com>
Date: Tue, 20 Aug 2024 15:09:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Unconditionally flush device TLB for
 pasid table updates
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <20240820030208.20020-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240820030208.20020-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0123.apcprd03.prod.outlook.com
 (2603:1096:4:91::27) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA0PR11MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: 5235cc0b-6305-4475-9947-08dcc0e66110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFo2bjlROThvOGdsbDRFZVhmWjF6alkzSUpta2RxY0g4MjE5V2cvYlM4S0tM?=
 =?utf-8?B?bTlQZXRyWi9KNllGM2NYQXIrL1cyaTdORGlpeEZPVncyd0lqeUdiN0NKWDF4?=
 =?utf-8?B?TTR0RHZybkNWUDZsQjVUL1h2ZGI0MFJHRnpHNmlIVm91N1lMTWJNQWZ1Qjg5?=
 =?utf-8?B?L0xTYit2elFtTUpBYmhWc1Jodnh1VVRjcUt1RTVudjBHWU5xWGd2ZUNDVTVR?=
 =?utf-8?B?MERMQkVLYnkrQjVLL0ZFZHRNenRYdFJDMU51YUxIYSthUFV6QlhnaXdaNXJ3?=
 =?utf-8?B?Slh0Mk9ySVZ0NXlVb1FCVGFmbGNVdDhoRkdaNHgwenZhVmREbXR5LzU5bkVH?=
 =?utf-8?B?NGtDT0hZOEw1dk5BMVErb2F0VFVEL1prWUZlV2ZjeVpITG9FMlQyZS9GQUNn?=
 =?utf-8?B?UHJsdjJHNVB5MlU4Q2NlRE9hUDBHdkhQWE4xTXZ6NC9oakpaYUJuOTVUK1pN?=
 =?utf-8?B?Q2xVYTMzaVF4Q0dDZDJscE84T0RVVzZVVXNRMm40MGFXMVRXNVl5MXZQcDdm?=
 =?utf-8?B?dFpCUGNaanl5Q0RTeTBsMlNKVzl5THYvRUYrVHhMVk04UjROSVRlYURLaWVN?=
 =?utf-8?B?LzdnMWFiRGhVRUd6U0hleG44aEg3NzFDU3NVNG02ajJmZ0VXTWRwRWpCemlH?=
 =?utf-8?B?WEJyelNmR3VFTm1sdXZHaExpZkh5ZVdtMzlaMGNEUXM1cUpZOEtPUWRhWGh4?=
 =?utf-8?B?NUQ2ZkdWdHFLSk5hV0JtMk9QVUVBd2FpOGVvTVJwTkd0cXFYV0RVcjhRbDlk?=
 =?utf-8?B?cjhmL2ZnQkZWMTVCalFVa0thME1xZ1RaM3JmdkczWWZ5NnJ1bzI0OVNMNmRK?=
 =?utf-8?B?TGdjZ09sR0ZRUkRzdEh3TzFsdWJaK2JuR2M4b2xKUEdtZzBTanFsRk5HL0JH?=
 =?utf-8?B?N296cWNvc3VVTTFDbFYxRzFwVDllT3pXaHBUMFJXbTlzL0ZvVXlRTWxOMUgw?=
 =?utf-8?B?QUhyZHNuSTZ2UGhQWmJFMC9UeWUrL3hKbkgrQUxJaEprdkYzNmVoNk9Wc2hK?=
 =?utf-8?B?R2lKT2tHQ0hqelgrNkZXVlRYbk54MHV6dWxuamh0YnE3aTIzbCsrei9BOXZy?=
 =?utf-8?B?YnBGbFhaSGl0NkhudEFOd1NBTkNlazU5dU1tVlFYeWgyaHBjSGlZdmpjMVBY?=
 =?utf-8?B?a0VHOG5VOFd5WFoyS3c2NU5BV1RGNldGRWg1Qm1RamFQWlo3MlpTQ3loZklP?=
 =?utf-8?B?SEM3VVEwMEtoTjFRd0NvekZKRit3MlR1dG5XWjBUdzkzMGtaQmJkbCt4VTJI?=
 =?utf-8?B?UUZpUEFsMzZOcHBBM0swZDhYaXVZOTUvREd2bzFadHk3K0dCNGh3azJtb1B5?=
 =?utf-8?B?YXhUd0tUdzNROHMyVXplcVRqckoyZUFJd1l2WHVGNDVGZkhsN3huUGNoNTBj?=
 =?utf-8?B?cjFtaHRKeFZBc05nK01rVy9kdk5CcHlnWXZDck9wWUU1c2Y0bG9RUE11YXFX?=
 =?utf-8?B?ZHNBQ094cWIzV1RwdjFYaTJPRlhWQkozUEpJNVlIY1VFM3hpRXBYVGpBTDlW?=
 =?utf-8?B?SHNBbkxyRTBCbm5MelBscXh5dmN5d1FYbVd4VUZYM1RFdjQxK3ArNVh5NTZC?=
 =?utf-8?B?KzFtVFdLSGk3Rlp3eUtIb2d5Ym04K29wV2w3Tjg5bG9ZTVFJVTVlM09yOGoz?=
 =?utf-8?B?TjNFK1h2TUI1MTAwQ3ZmQzNvYVd4a0ZPUkFuUTlHTXhjTnE0UTM1WGhQNWp0?=
 =?utf-8?B?MFgvVm05Y1RXdVE3Y0ljQzdUUkNzMVM2dkNic0J1b3NmRUx2WklXdW8wYW1V?=
 =?utf-8?Q?f+zxDuBP1tXKIWYrwg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDRzMGFYQmFDT2JLMXNXcCtZTE8wQUxydDl4VWEyUmJ6cy9HbzJxWStIdUhQ?=
 =?utf-8?B?dk9tWnN0RDRjd3ptZkVRRkE5Z2oyWU9DcnM0ZENkcGxydWh4TnpZTWlHRWZU?=
 =?utf-8?B?QWVpeThwbThRVWVaRitObElDZUxRQW4ydE9pVEQrQ0RVUGNVVUVQcnE1NUpD?=
 =?utf-8?B?QldEZWpOOTlRTCtyV0MwQkpDL3FxQS83QWY2b1phS05SbjNTZXNRNnNLZ3FX?=
 =?utf-8?B?ODRvZGsxZUZETlhnSkdnd2lMZEQwcW1nM282WFJpSEVPcUFHOGpCVkRjQ2dK?=
 =?utf-8?B?QzVUazN3ZFdrNkhHZWJVTitVbnlFRTRBa09sS0lPVFdTbVMza1oycldCMVYx?=
 =?utf-8?B?WW5KdXBwNXVPSTZreUF2bUtVakpZcERvbnQ2OWJKQWRNcHhoUkJHSUc4Rmdw?=
 =?utf-8?B?L2VpMjREZFZBN0pZcFZueitROWl1Vi9SL3M3TzgvZGlzYjNBU294ZkQ0TVhp?=
 =?utf-8?B?aGRPMlEyNlNXY21qRmlmVXJ2Qm1weUlkditSZjMzb0txUUZoVmk2aUZxS3E4?=
 =?utf-8?B?dXh1ZmJJQ2NLTWpOR1RBZUZtL0x0QlRJN0N2RzRPQUhhT2dLTEtQNTVwTFJH?=
 =?utf-8?B?NTBpNTZhU3VqdHBXditwc0VBODVob3JYaS9MVVN3d1pOZUZQaUlUZktWNDBL?=
 =?utf-8?B?MTVDNW9NSzZEUEhKNEVqR051cEh4dmZYeGlwMWR3Z2hKeWhXRHhVeE1XcUMv?=
 =?utf-8?B?UTZPdmNyaXUzbFJSdHRxTVpXZ1o5RlMweXZpZ0RDRElod2EwVUFma0tJZ1Fy?=
 =?utf-8?B?WTVrWktYaDlRTTVoQmZYSVYzMW9wRmFIOUdjZlpNbldOaFBQMFo0NWhBbS9x?=
 =?utf-8?B?dnQ3c2d0Q2hhbUF4UTVrM0thRjBnbnZ1YXNkZjlMT0RTVHRDRGZTdXlBTnhO?=
 =?utf-8?B?am5hMkJIUGozYW04VHF6emlOSmVGUXhBdTBFSTgxeVFYZWdBRTNOdEQ4dVNw?=
 =?utf-8?B?SlAvOGppcTdKZis5NVlGVmFQUUFZNFVxbUhiajkwSzlvLzBFNFM0UWpMTVBF?=
 =?utf-8?B?MXZZUWJ4cUR2Z0kwejRCRkRuNjY3dTNRQ0tqb3pkbjVQcnkyaFVWOXJDZ01R?=
 =?utf-8?B?cjhoNmN1OGhMblRsdkRja2F6NWZSKzIzbnU3TnluLzJEd3FZNjZHaVpRVGE2?=
 =?utf-8?B?c2o1TGtuZE85d1NqRzdlbCs3c3F2QmxuUGZpTUNSRG15aFY2SUtaV015VmJQ?=
 =?utf-8?B?SjJuS05Ib0k5TkFQU3NYQ2pZd1V3YXVNbldnOUJHNEM4STZ4eG9qaGxhTWY3?=
 =?utf-8?B?aFIyeE9HaFZJa2pWdDhQdlpkWmpsck5LdTN1a3c1bG9manZtYzE2ZDA1ZjBR?=
 =?utf-8?B?TVlYRDczR1h5SnVuYldPbk5LaG1EdlZGQmFkMFJCMUNzSlE4Qm9pOEJVUkFT?=
 =?utf-8?B?eG56UXNwY2pVdDluOVErVFg1ZTI4bEVkRWVPemNmaFpWWlp5TXBWQUUyUWtF?=
 =?utf-8?B?YXpEd0dSSG9qYnU2NDZ4ODZuREZZSUZyVm1kYzZHeWUvWFhMcGdBUHlrOFZa?=
 =?utf-8?B?VGpwc2xYMENWN1RyQTNUMlVKNFAybm1CcnoyRHJRT2dXUTVhV1ZxeEFtZnRy?=
 =?utf-8?B?aXZjaVZXZ3RXUnJtcFF0YzFvY2xaUW1JSjlWcHNaWmw4OW9TcGpmaVBuS2R3?=
 =?utf-8?B?TFlQSE5qM01kZWNHU1A5NEVLcEk0eUxRc3NKTEhnUXBBWVFraitINkhlNVht?=
 =?utf-8?B?UURUMk9sSGplQ094YW9BbXNiVXdnM2dCUGtTKzk2dExkZHZYSG5kWUJNY1dX?=
 =?utf-8?B?amsyNisvYXIrZzVhN0ZZV0syREFVZmRyRW1YU3FIWUhNdHpITzYzMCs0WXlp?=
 =?utf-8?B?Wnp4VUYrSHZlNFRkbTVLeWFNL05TcGtxL3pzWWl4QU9NeDZUdGZpRGErTTZQ?=
 =?utf-8?B?Q2V2VmNhVzhVSVBNWEphN0hweksxRWJLckhveDJOc0hTS3MyaGFIWGFHcks0?=
 =?utf-8?B?dUtNdGcxWml3eFgzU0MwaXpmb2w5QzVuTU40VndqWHJ5czJQanNDVGt6Mldy?=
 =?utf-8?B?MXhXbU1ZbnJXd1UzWEJXcUY2eU5TZkpHL3VHYkdsWm41KzRoZ1cxTUZvTWli?=
 =?utf-8?B?WlNJK21XUk5uVDV0NHg5YXBRY0JPYmpMOFdiNm5qL2JkSUV3T1R5S1Rya2Qy?=
 =?utf-8?Q?FAbz4EX5LpEF7zCB8foxXBDQG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5235cc0b-6305-4475-9947-08dcc0e66110
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 07:04:48.6169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+N8zJQn0+4sbU1K/lA76xc/x58x0yw/ndpLteCcb+szRqbR9KKw8FnUQ/26vUr1xHEQHwb89niD+5iRETi8ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com

Hi Baolu,

On 2024/8/20 11:02, Lu Baolu wrote:
> The caching mode of an IOMMU is irrelevant to the behavior of the device
> TLB. Previously, commit <304b3bde24b5> ("iommu/vt-d: Remove caching mode
> check before device TLB flush") removed this redundant check in the
> domain unmap path.
> 
> Checking the caching mode before flushing the device TLB after a pasid
> table entry is updated is unnecessary and can lead to inconsistent
> behavior.
> 
> Extends this consistency by removing the caching mode check in the pasid
> table update path.

I'm wondering if a fix tag is needed here. Before this patch, the guest
kernel does not issue device TLB invalidation. This may be a problem for
the emulated devices that support ATS capability. The cache in device
side would be stale. Although some vIOMMU like QEMU virtual VT-d would
notify the emulated devices to flush their cache when handling the unmap
event. [1]. But this is not required by VT-d spec. So it's possible that
other vIOMMU may not do it. So this patch appears to fix an issue, so a fix
tag may be necessary. How about your thought?

[1] 
https://lore.kernel.org/qemu-devel/20240805062727.2307552-14-zhenzhong.duan@intel.com/

> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/pasid.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 5792c817cefa..dc00eac6be31 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -264,9 +264,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>   	else
>   		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>   
> -	/* Device IOTLB doesn't need to be flushed in caching mode. */
> -	if (!cap_caching_mode(iommu->cap))
> -		devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +	devtlb_invalidation_with_pasid(iommu, dev, pasid);
>   }
>   
>   /*
> @@ -493,9 +491,7 @@ int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
>   
>   	iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>   
> -	/* Device IOTLB doesn't need to be flushed in caching mode. */
> -	if (!cap_caching_mode(iommu->cap))
> -		devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +	devtlb_invalidation_with_pasid(iommu, dev, pasid);
>   
>   	return 0;
>   }
> @@ -572,9 +568,7 @@ void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
>   	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
>   	qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);
>   
> -	/* Device IOTLB doesn't need to be flushed in caching mode. */
> -	if (!cap_caching_mode(iommu->cap))
> -		devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +	devtlb_invalidation_with_pasid(iommu, dev, pasid);
>   }
>   
>   /**

-- 
Regards,
Yi Liu
