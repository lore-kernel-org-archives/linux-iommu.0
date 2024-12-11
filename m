Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C91D5ABA
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905956; cv=fail; b=fRInLrlT8D8krHRiwx0oomtpOj36CfgusRB0qPyyofi7aVBmcIW6IFMXiXAG/PfDj1M+EopJgL1O1xP0rokDkSWa+XqaduZ7TI4sAvkusLBcnQkte++Fl8/uDYtNIactkusXfpCc20UjVciUgPe+xTehDGSk0NXJk0fMQUfd00c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905956; c=relaxed/simple;
	bh=5BudpKB5yCp3Wwix1eRAnDBAAdTPjsmr4hdmedZU1YI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xbdr0NJymNg6www+oL0I7optYzaugVpXsw7K3z4mSKV66YRvEhZNDG5BUUnzi7damFkITy+C11m+XVuTxBEyj/pxXEbKgtMAWUk4lYHPklN17mbCU6q1I8Z9lpY+QYSdSJkQy1YYOpfKYHn+qN/j8du0NRK4KaHR/2XctP2ZbGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyPeL/TU; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyPeL/TU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733905955; x=1765441955;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5BudpKB5yCp3Wwix1eRAnDBAAdTPjsmr4hdmedZU1YI=;
  b=YyPeL/TU7Ylk4mltk4kUhlzs0+3EXl7Zzd8ski/DQ6VX9xyFCprfVY1f
   hitrThFpWswhfQxRRxMaUQlQZZc0z/zYSuZwrXcOzZjeC0ovhazqW5WB5
   tmDoa2+z2ilz38BFhIHSICReRCqVU6TisuWRd9pqSqNfF0GBu/xD4ddV7
   0dvs7BQwoTZ4HEVaFnNOCRKvwFuToqSrIA5NETuTFYbJ2IXiM5JR4POAm
   6z8krTh4BEUlRIRLsTNqaGvP/kZwEnh/Eg5IreRXopzh0DiqLS9OpEj5F
   Pp3QHfblZFKZqi+rJbNHz2SmvU0BfNV4dHzfVntmiE6eNLHBuZLSqzkzR
   w==;
X-CSE-ConnectionGUID: 1gT1Uv6iTXye47coldSusg==
X-CSE-MsgGUID: 7LG3TRA4SSu8TTpIOrXR+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51681820"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="51681820"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 00:32:35 -0800
X-CSE-ConnectionGUID: hFn8q/m9RUGcuLgnkpq49w==
X-CSE-MsgGUID: aoUQH8JyQjS9xQzctGX54w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95777756"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 00:32:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 00:32:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 00:32:33 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 00:32:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x5lKjJWPCRozxYGJNQaYoEm63Wiu8vfUEg8gNXeKb6PnsQqEDgBHe+7PF58DFp3iN3+L/2+kaK2m9agiJv17iBqmOgUvcHsJtyeepj9/CG6dNSDeXUh8TXgmsG4xfzqoIiFK2bLtba6Qp/JOt4T13r69is4MIwQ7PyT2200VOhZ1H5h7sUleTMnKg23VETcHS4xzgUMlbgrXHAP0K5z7dH1VS3+VXfDwFHCfrjKfx5Db6n2sTST+9OjcT+gyDkXYTqKqU44HyfsXGlvjQon3JGohfoIslrnDn2tza281X3H8mmD/7LUqwhVvfAZMFjvR1DBvdxn/JEqZ4qAjMf9kQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5BudpKB5yCp3Wwix1eRAnDBAAdTPjsmr4hdmedZU1YI=;
 b=Hyk6+jX75pkIjVUHmlgHM4eVyjWtgZ1MdtE01Li4zglkwgrTxbvpgL6fqnqUpMGDGZrdufUesedtaD9+QUYO8b7rvO1QrmSQV7X9JTmZ2gbFNdHaxW+1gSi62xpgV4KkmTolYmP/9O8Lg0wq6mgVVr2Q0ve7f0xF2F3f5e62ADbiV7U8NMau91L2BznSAYwsJ0KlwgkHhAKqYHuJmTHVmaYvQSxlxBaDQWRrF45ShlI24s0myaslpDIY73QkQDRaFlkkAgGesfUYIjnkaKI5pKwiupythQsGIUWnLICpJ/Id2fNCFctDJA7uBxBeHzY+AXXPWI+m6igKVFp4flMTSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6343.namprd11.prod.outlook.com (2603:10b6:930:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Wed, 11 Dec
 2024 08:32:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:32:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>
CC: "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH] iommu/vt-d: Fix qi_batch NULL pointer with nested parent
 domain
Thread-Topic: [PATCH] iommu/vt-d: Fix qi_batch NULL pointer with nested parent
 domain
Thread-Index: AQHbSKACT2cllE2X/kmT5E3vhOsCUbLdJS6AgAAYeACAA37wgA==
Date: Wed, 11 Dec 2024 08:32:03 +0000
Message-ID: <BN9PR11MB52761F40C3A1923B78478C0D8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241207120304.5710-1-yi.l.liu@intel.com>
 <ce413d97-ec46-4cd9-932a-af804cd531cf@linux.intel.com>
 <b25901cf-6483-4434-804e-62bda4385796@intel.com>
In-Reply-To: <b25901cf-6483-4434-804e-62bda4385796@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6343:EE_
x-ms-office365-filtering-correlation-id: c8439b03-65cc-42e2-afde-08dd19be4a03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THgvbVJWWHhSL1VSNmtjTHlIeVhOK3RQSFFPRUR4MGFlaGdoRVJRdmNhTWU3?=
 =?utf-8?B?dkdKbmMveGNQcENIdndjVzUxbnRzMGFMREdheXlCSmN6SjlYOUtVOVBYaE15?=
 =?utf-8?B?UTNJL2dMV1REOWZCUGIwcExaNzNPWFllOEx3bko0RHNadHVSMVp6TVBuS2FM?=
 =?utf-8?B?RW4rVUE0STNpaE11Sjgrd0FVMHBQcXZzdFBiQS9FdW10aDBuRDVLSytrK2Yx?=
 =?utf-8?B?dFM1RGtjMVg4RU1rRGl5YUErNEg1SWZ2aU9Obkg5UGNoQTZKeG9XSXhEc29a?=
 =?utf-8?B?TkppQnZra1krSEtZR21JV0ZIM08wTkZxWEV4ejV6RTVURmhsbWU1WHJHczNz?=
 =?utf-8?B?SVYwM2g5ejJMOGZSOTI0OG9pcU82RUV1SC8rTVN4T2E2TVhSUlJvcHRLNW1w?=
 =?utf-8?B?ZERKNGg0MlFodm0yeU5EWVRJcHg3bzRIS1hDb2QwalZXZHdPRm5WZ3EzVHdW?=
 =?utf-8?B?cEJhbWlnRFA0Rm1lWStEczhsZFhJTkZGSWVzWXFkRUx5U1UrbmV2aG5GKzFy?=
 =?utf-8?B?RHlLT2tvQnBuMUVUYkk3TC9OU2lTNjRsUDhKb2loVmlyeVdGSGxVYXBwWTFU?=
 =?utf-8?B?TE95SFpEY3RTbmFVTzhlM1FrdC9tT1JuNkxuMjJaSlArRUEzZ3Q1MHk5d3NV?=
 =?utf-8?B?RXZFOTVtOVlwbktRYkw3NmZIZ2lDbndSa1Z5eSs0bG40UkF0cldGeWd2bjZZ?=
 =?utf-8?B?d2cxZHFjdE1MYXdMeXhoTXVnRk5oYko3K1dNVUZwZUU1K0ZCNVZXdUNlTmV6?=
 =?utf-8?B?SGdGQVVkTmxNR2JnRDduUXYrYytSYWpGRFlQcUFlSDJKci9rVTVSemhqd0ky?=
 =?utf-8?B?VDgzanBIMktYcGovWEpiVzFZVnFnUEtUcWM4ell1MnR5TWZ2emlyeUk4aEJ6?=
 =?utf-8?B?YTZJS0xoTnJmUHk3ZkIwclFUSEJYWis3UTk4SXdUMGFzMUQ0Mkc2NGxXSEJo?=
 =?utf-8?B?THVhSEtVVkJBN1hqN0xjQ2tHMHlORUNLbUFNV0w2VVpsOWFPWnp3VHIzdFJC?=
 =?utf-8?B?MlloWlZQdUV3ZFFsWk9IbXc1NnNScVVnZzJqSjdkeVFIZ2dhZVN2UGQxS0Nq?=
 =?utf-8?B?cy9pTm1VRDd3M1lDSWVSc0ZiY2xhaStoSHhBaG9zVzB2elBKVXlQbU9ZcVJY?=
 =?utf-8?B?QnRUQlkrUGs4cHluRkVCcERqTWdac0YrYXl2dmxCYklhZHR4RHRKNUEvQkt2?=
 =?utf-8?B?aW51dEgwa1pXZGVmUmFHR2FYNW9jYUo4a3prZWpiOTJKaE8wMEFaQnpTN0t1?=
 =?utf-8?B?ZUl2VmRlbkM3TDQ3QmZMamxXczZhUTVFdGdIcHpzTnN6K2lYOHoyT3p6YVc4?=
 =?utf-8?B?bFlRdDRUUTNESUh0UVBtbUhWMENTN3lLNEdPZmU1TUFoU25SS2VSOE5RNFlE?=
 =?utf-8?B?a0J3a2l1OFZsSlcvRFZLc1JrbllacHlkMWNwblo4bWhtTDFTNUFRNHJ4L0l2?=
 =?utf-8?B?SlhDTCt5Ym1uc1g5dyt2SjB6MStXN0lvOHBvVFlqcTgvUUlnYVRMWXF1Visz?=
 =?utf-8?B?dEhzY1JWaDcrdVRndmlOUm5paXRHWVJ3SGd6bnR3NXlsYVBCTVNIRDN3QzNr?=
 =?utf-8?B?ZGxuMVpaSEIxUVVFZ2FNWlRKWUxGWnIyVmF6MGNpTUYrbkVNU0Z2L0Y0WS9R?=
 =?utf-8?B?Sk94ZU1UUHlGS0ZQcVBXZ2tnWS9UMjFCa2FIOGY1ZVhwZnBKU0xwN3ZNVGJT?=
 =?utf-8?B?T3hBNkVDWXBERlNHT0JNRXFOR1BmOVBCNjRqZEg4VWU2RHA3SkJOZjBaT1c4?=
 =?utf-8?B?cmlHZzR3NjRVdCtsYnh2aFplSkcvZUhDQ2FoMFEwTmtyR2xCODZDYTlwaUw2?=
 =?utf-8?B?c3RZSVlxVFFpbXRKelNlT1NFZ3hOT0k5UG5sMnQwSVJ1WUtXdmxqUW5Qc3Vk?=
 =?utf-8?B?bjNMZ2VMS2hQclp6d0U2U3Q0Tk10bW4yY0hwWUVPNlBpVWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW1SWVRSNkJsTG53cTIrdXBkMjY3RlRSSVhaNDFHeGt4QzlMMkx4K2lNbW5k?=
 =?utf-8?B?SUVUemxmOWYzZURLTnRCZkl2S2haaXkwNTlOaDVKenNYTmJCdUxMdWRxc242?=
 =?utf-8?B?WHlDeWJ1UTY1T3FNd0sxSFNrTFhERXl5YzhlV1NHcXVKN1NLR2dHUHlsZm0v?=
 =?utf-8?B?VklYdlNVbVpGcTBjYWc0YUI0Q0dqVWg3aUN1Q1RtUEppODBmUkFRVWhQa1Fu?=
 =?utf-8?B?REZtSVVsZFlOQjhZZXBudDRtZnhpbWhhb2drMXFkRHFlV0dHQWpZNE12eit1?=
 =?utf-8?B?Y1JiZlo2bEs2cmFHd3p4OWV6b3A2S2UxRjVkM29jUWhQU3JEN1pGdjYwUFVI?=
 =?utf-8?B?LzFLaDRWSnlRVS81YnNQb243OWdWaHNmRWZGSHJ1WU1YMFFoc2JxQ3BBYlBW?=
 =?utf-8?B?UThlVXJ6aExEcyt6Z3kxcjB5VFh2VW04WmFlUTY3TVRycm9IM0RaYkJEZDRE?=
 =?utf-8?B?OTUxc2poZnNWTlV1dVBROUxvN2pNVm04Slo4RGM3UXpxcUJ6Nm9hZUJqZU45?=
 =?utf-8?B?QlBrekNLS0FGWG5BczBPcG1mVGVIVktUdFY2aVc1SlRZUHJBZ0NqYm95NHlr?=
 =?utf-8?B?ZXE2N1lxNXRBZ1Eyeko2M05kdEhDNEJXc1hSTE5EQ1dQM3ZWWkV0U2o1UXk0?=
 =?utf-8?B?N25yaE5zelpoWDJUWENWOFRiaUdBQmFKb21WQm1VS1B0R0E3Y01qVW5uMFpD?=
 =?utf-8?B?MVBLKytwL1JkVVkxWmY2Q3ZLZUZCNTlqd1FQb2RObmtVWWJld244NGRqM2ti?=
 =?utf-8?B?ekVzUTdERDhXaEJJNW9MdEZkZi9Ic0lkTjN4V085TE9xbFlVTDB5VEFVd1Nv?=
 =?utf-8?B?dWRIc2RObzVhdk5HODBpTC9yOFN4V1RMRjVPeEx2OS9BSUlrblFJbDNWS2g2?=
 =?utf-8?B?NVdNTmgyNE9Rby96cjhnWVZ0NFJwSElGV1A5VTl6MWQ3MGZGUGJoQ3NPZXZK?=
 =?utf-8?B?NFBHc2xCdlhTclB3bi84SkhMM3NwRjVXaDhycmdicVJ3T0RBRUFQZE54Qno3?=
 =?utf-8?B?VGxjNGI5RnBuMldBd0ZpYlBaZ0Y5blJMazg0azZJRDVnQWljOG9MMUc3M2th?=
 =?utf-8?B?a05qeVZ0K0lHRTVOclArcVB2b2VPeXcrMGt5ZHhpQnNKL0pyMUN4RWFFdVQv?=
 =?utf-8?B?dnhTQ3cvUWFwdXNZOUpjQ2U4aWE3SERzU0JSNlpuYXptMUIycndKODYzUkpL?=
 =?utf-8?B?RXBSK0hmQVpmRC9kdUtOeVBuTEljMjJQQ2U3RURhcVViRlAxdUFzTmdqZjZl?=
 =?utf-8?B?YVVmejBYRFBSbitJR1RLV3RmN2t0bUZ2c0x6eXRmQy94d2ttVmhoTkdRM2tJ?=
 =?utf-8?B?dnlEWUdIK0doRVNpeVdmSHBXdXFyemlOSFJ2ejR5cmNMbU9pT2UzL1hINzcy?=
 =?utf-8?B?amhTZTQ4Q2UwRXpaKzNlR1JUTHN6RXlJdEdncGpib3JjT3hFMnZlWmhXSHQ5?=
 =?utf-8?B?UkQ0N0ozaURuLzRIdEF6MFRraEJDVkUxdGlicXdyREo2OG92RUJCdEQ3bW5Q?=
 =?utf-8?B?eXJrV2IvaEI3T2Jic0wyVGNnNFR1dEpieUZuT2NOWmt5WU1oNjF0RXYzNk1J?=
 =?utf-8?B?WFVOZU5QcXZ6YkxlUSt5SHNOUkFrQU5jaGFON3hyZkltUXNwd28rREtEYlV6?=
 =?utf-8?B?M1dwVmdaWm1tUHhON3IvSVlmNXEvMlY4SEsvVmxLZE5SbWk2UEVkanNOZzZu?=
 =?utf-8?B?TEVCMGpIZFJXaHpLVXhuUk44VVRCSGt0OHp4WWlIVTRFek5BSE1rRXVjRkI5?=
 =?utf-8?B?T3dURWRiVzROaGZjZXg3VVN0N1RTMHpiVmdkRVJBYTJZV2NaMVpHOFZENEFE?=
 =?utf-8?B?d2NxWENlS0JLZmVNbmlGVzM2elRpYnlkWE1IUU55b1N0dlYyOS9JSnhMYWwy?=
 =?utf-8?B?Tk0zNytKbGpVL3MwM3ZNdDZJRWFqS0wwMHlQbzVKbTVxSGYxNThTZXZ2bVU3?=
 =?utf-8?B?YkI1WUM1UkN3WXp1TCtyMVJPQzZmNVllYU03OHE1SzBUSnJXOG5kRytzT0lP?=
 =?utf-8?B?aWptYmV6b1VqZENUbzYyb0RiU28yMnh6aHlLa1FmOTM2TWNjZVFFdEpHczZi?=
 =?utf-8?B?b2JqUUpzUUIxWldMdUxpcUF4a1VERXJCSmhQY3lubnI1RUswdUhjdWVPZVhX?=
 =?utf-8?Q?OrhLeBaje0016g+oKihmja99y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8439b03-65cc-42e2-afde-08dd19be4a03
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:32:03.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GfJwuqvN9YcCexK71gYQDR0lVepanrLrPd8fZ6xhGTrIzIKQ4oxgyS+U+dci1ovOQnkasS3TfrR2IMdIuX9peQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6343
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogTW9uZGF5LCBE
ZWNlbWJlciA5LCAyMDI0IDExOjA3IEFNDQo+IA0KPiBPbiAyMDI0LzEyLzkgMDk6MzksIEJhb2x1
IEx1IHdyb3RlOg0KPiA+ICsvKiBkb21haW4tPnFpX2JhdGNoIHdpbGwgYmUgZnJlZWQgaW4gaW9t
bXVfZnJlZV9kb21haW4oKSBwYXRoLiAqLw0KPiA+ICtzdGF0aWMgaW50IGRvbWFpbl9xaV9iYXRj
aF9hbGxvYyhzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbikNCj4gPiArew0KPiA+ICvCoMKgwqAg
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiArwqDCoMKgIGludCByZXQgPSAwOw0KPiA+ICsNCj4g
PiArwqDCoMKgIHNwaW5fbG9ja19pcnFzYXZlKCZkb21haW4tPmNhY2hlX2xvY2ssIGZsYWdzKTsN
Cj4gDQo+IEknbSB3b25kZXJpbmcgaWYgdGhlcmUgaXMgYW55IGRpZmZlcmVuY2UgdXNpbmcgdGhl
IGRvbWFpbi0+bG9jayB2LnMuIHVzaW5nDQo+IHRoZSBkb21haW4tPmNhY2hlX2xvY2suIFRoZSBS
SUQgYXR0YWNoIHBhdGggYWNxdWlyZXMvcmVsZWFzZXMgdGhlDQo+IGRvbWFpbi0+bG9jayBmaXJz
dCwgYW5kIHRoZW4gdGhlIGRvbWFpbi0+Y2FjaGVfbG9jay4gV2hpbGUgdGhlIFBBU0lEIHBhdGgN
Cj4gZG9lcyB0aGUgcmV2ZXJzZSBvcmRlci4gQWx0aG91Z2ggbmVpdGhlciBvZiB0aGUgdHdvIHBh
dGhzIGhvbGQgdGhlIGxvY2tzDQo+IGZvciBhIGxvbmcgZHVyYXRpb24gKG5vIEEtQi1CLUEgbG9j
a2luZyBpc3N1ZSksIGl0IHN0aWxsIG1lYW5zIHdoZW4gYQ0KPiBkb21haW4gaXMgc2hhcmVkIGJl
dHdlZW4gUklEIGFuZCBQQVNJRCBwYXRoLCB0aGUgZG9tYWluLT5xaV9iYXRjaCBjaGVjaw0KPiBp
cw0KPiBub3QgaW4gdGhlIHNhbWUgcGhhc2Ugb2YgdGhlIHR3byBwYXRocy4NCj4gDQoNCndoeSBp
cyB0aGVyZSBkaWZmZXJlbnQgb3JkZXIgYmV0d2VlbiBSSUQgdnMuIFBBU0lEIGF0dGFjaD8NCg==
