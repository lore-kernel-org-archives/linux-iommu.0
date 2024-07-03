Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D124DA04
	for <iommu@lists.linux.dev>; Wed,  3 Jul 2024 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719989640; cv=fail; b=iJikaEWOESwgDq+bMISFm/l/yAhP58BZXlL65Ndt47P2NWdNDEtq6AF68e14u+0r9xbqkOy6U32kU9XZT1F6rwtw+AcgVSkKzHxqamZhPuz+h/xquwSzCLlwjDshOYq5B3hcitW3GcCb2SjZU7lvVayVeNe3ODKcAMezIPCMfew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719989640; c=relaxed/simple;
	bh=fdcimlfdPuTQUhJAB97j0zsgAuLK1qMmjHYOIx8KsZQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CRZFMO2oaobV2+XH6a05J8FKUztYrLaxawHrJEWgmTsXtybY07JXgR4YjplxCSfR8059fr2UNlc46q6ncRMQju23ZKi52YtO1oCtV9rUMLkrebMpdhpQf6IxNrvM8sAPTHhL1islKWjqMJrXDNsSXfV3fjrBUZcAxvryM4CS2J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NIVPHVHg; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NIVPHVHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719989639; x=1751525639;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fdcimlfdPuTQUhJAB97j0zsgAuLK1qMmjHYOIx8KsZQ=;
  b=NIVPHVHgzyF+79CUNcKS5m2oVnwcwZSid6VV3DjVh/zQCS1JYjb64fJF
   jDjs65Ui04flUIcWGeoDPbsoSeNBP7e4wbrP806S4u9Oyg1e5P+GLeCqz
   4b1o8wuSvPDzP89xUKdDAucCI14f2rdbSsmxBDcKllARMcsQ9hOcnbSZV
   Rhg1Qq2HeZDAvwmR0Fh/HJbmp4ovAT2TV33qVnkw9bPiYnfrCm1YPLqVI
   fttBY4nznCUZYF+7buIzWOIUEUY0tfuyLhOpTpNrDI+JtOzcoqthUglH0
   wYa3MjC9UGgpVX3qpYq+UBXCbDQecSvJXwBqtPa+cdI7fjh0vXZqSlTat
   g==;
X-CSE-ConnectionGUID: jn+N/Bc7RTONoiyXp50fhg==
X-CSE-MsgGUID: 4g8cWM6wQg28d7Rv1ffrkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17338439"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17338439"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 23:53:59 -0700
X-CSE-ConnectionGUID: dKp+za2DTnS2ungObmENnw==
X-CSE-MsgGUID: I8ohyKUfQ9mTHZb2npWHYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="46574462"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 23:53:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 23:53:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 23:53:57 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 23:53:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 23:53:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWjucoCc48vDiug5BJgvAwAlX5PNnGF4lj5L1+VtjWvFNLNEBd1nXXAeq57XPEymabNPYv+b4uGQhq5h/KHkryGwNLnJj1iIBcZfwF7FPbQjyNGs92OitLRgbzIVBKE/a3V/hmNdw5LDf6zURJM+F4ZFSV12UVDMOlUAUC6NQp0WWl5tpG8O3VYafKTZq7l7iu67tHB4qMSjqsuyCWPh0co/sNYPVZyGcb09D1sDIT4tGQoZMpy3cFAkxlRVgHpJKCwKAaBKI+jThEpXFiaBlrt4PYwioORaFKFyYpMXD3VwLUhXuYPLbK2CAni2Ptz7pF1v7t52pt1L47l9oDxsbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUsQM/o9Be/m7/3+LD2FY6t8wssFxViapJv/7T7PfNE=;
 b=GmNPPMi89EtnLESGJgv0Wehrcc3l6NaXWfWfrtSOr2i2Uxe9r7OXnO3/awajJF6SSdgPBuKLrJ1LRAXZxe6LPwqy2goGeCws7EqCVvjrqJxaWMYTYzKidBraf09WnVHLrW2IjzmfPyNQ4yK3DHtYAsgjrGTJ3Y2/L3R6xjGEb3eEN2PcPZdH50aFUVy4EFy7l7CVknLqq7v6C7i4q3BfhGv5FLYG51pV2KEsoiPn1jFAzNzOJPWiSCEfI7LgVltOYlniEnsoVtov8tvdlpGfuTi7j8bbjEIUu3UdWE9DzRFGFiba3+LvvcWoFXCblWuLSdJ4aJrz6DRN9/by3wxkHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB7367.namprd11.prod.outlook.com (2603:10b6:208:421::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 06:53:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 06:53:55 +0000
Message-ID: <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
Date: Wed, 3 Jul 2024 14:57:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: c1baddf8-cf55-4a0c-109d-08dc9b2ce7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekpSL2psNnV2eFVYOTBZRmlGZFAyOUJsSWhRbGNOSHdUSWt1RW9zbWxTcHp3?=
 =?utf-8?B?YTJDSnZ4eExTRDBUc3h6NkFlaEZsUkxyamIvWmNUVlJXdzVIbXBIaGdVdWk4?=
 =?utf-8?B?Wlc5V210VHNrRUhQYTRpUzhDVUpJZG1uQXQ3QWQ0K2RYVndVSGNBcWJCWTg1?=
 =?utf-8?B?dk53VTMrREZHZkJ5SWRoSlIya1RtR1pNUUFuZDcyNFVndEF4NE1vejE4Z1BD?=
 =?utf-8?B?cTJ2K3p3Z21BUXQvR1AxcDlZa3IwWFFLbXRIYVRDdy9JRW1OSkozcXNGbXp1?=
 =?utf-8?B?VFZXc25nQ1hSeURhTjRBcVd4aGJLQ0RmRTVKbzJ4U1ppMWhjM3pycmdQR2Rj?=
 =?utf-8?B?Sjd6UFQ0NWZjbElieGR0MDU0bXNVa2MybndsSmNxanRueXRTTWZxTGdxblFs?=
 =?utf-8?B?eldmR25HUGxxdWdqMWo0K1NPbm1GWExHazZFV1kxL2NTOEZoKyt4RS9rUjFp?=
 =?utf-8?B?a0xKRG1YUXhzc0wyOURBeUJBNVpzMGV6UWd4V1oyN25MNUltUzg0SEhIWXdT?=
 =?utf-8?B?TDZ3eXU3Q09lQjRwV0dXTG1QcEV6M0J5RkdENnVWRnVZNU01UmlhR0U2enhZ?=
 =?utf-8?B?YWgvblRmQWdETGIwZUtXUlhTMXhPTHJYUnluZDMydlZCN3g3bm1veVJoNk1V?=
 =?utf-8?B?QlZleWVsdnBEdXVuVWJienljdmU2YWhKOEw4WmN5VkJxVDBjU083ZDlSNGlM?=
 =?utf-8?B?ZFhvQmJCZ1BQOS9GQVd0TVM3OWl3OEdtZVovUDJUYmoxQzdaU1pka3VTbDMz?=
 =?utf-8?B?RmtSblY5cmZ4M0JlZEQyS2RxT3lRYWNWeXNLbG1SMGY1SHhpbzdwd25kRjVH?=
 =?utf-8?B?S21KL293UXlOOFEybEszZVFDLzIvMjE1bDVWb21HL3AreTdIcG1FeUNVTlJ1?=
 =?utf-8?B?SlAwdUFPTnRBZVBBTFJhbFJWOGVMZ214blVUVGRJNGFzVVZma0d1eW5RSHAw?=
 =?utf-8?B?eVhsbVJUY2JCRjBXWW90WmQ2SitIeHBXM1Q0cXVyK3p3ZTVaWC9KY3BQNkRT?=
 =?utf-8?B?ekkwZEM0YVM0anMxUWJhRjVuUmVmYmtudEMrTENPOC9MVFhDSUkyem5OOXBy?=
 =?utf-8?B?QzYrZXBiYU1VbTRUdnRMdlJoNGdmNGdrZmU2RTRHbzVRY0hUMDczaHlZdzlC?=
 =?utf-8?B?d2Ura1N0YzhIaHJsZnByZEc3TUp2SzlRZGNFWVUwSGtRSlMwWkN0akVYQUFo?=
 =?utf-8?B?Zm5vdmFsTE1IT3djelNMOUNYSmFzRGNadjhLR2plRTdicDczYzBJa1EvemFQ?=
 =?utf-8?B?K0pRNmJuS0d1YlJqRlVvVlpmbXE1NmpXTEFJamFmM2VyVjFUUEdOUVBPMXRZ?=
 =?utf-8?B?Z2tnTnNYL3NVQzA2am9ZSTlZTzc2NnVzaldFNGh5QzV0djhhSTJnbTQzK3RF?=
 =?utf-8?B?Z21lTGIwRERzRy9uOTJFTXNsYjhaZkVPTmxwYkhubEtIblpsdG1ZaUhzY1Y5?=
 =?utf-8?B?L044VVlGbjA3K0pITVJYRUx1Ni95YTBiNzNIc0NQNzBKYVNjdS9RbDhBZzNo?=
 =?utf-8?B?Q1E3bGRlbURSczNiM1BHY0daOTJZVVlnTWZNZzllaDI2aG5UNXFLRURGWjI3?=
 =?utf-8?B?Mm84ZFV5ODd0dlZBSWxER2FGRDVEQkpCUDFOZGhDNXNqNVZjMmN3VGV2YjUz?=
 =?utf-8?B?ZFVPelRGMFlzVVo2WThaWGF3OFUwd3pGTThFT0poZ3lJUDk2TEJvemdCc2x5?=
 =?utf-8?B?eWkyemxOL1dkcXNZMWNCeWl4RXQrYUpTRjB2ajNpYXdpeWtZQlBxRFg3c3lK?=
 =?utf-8?Q?wtz5DdCxeGxPeZYgbMmjSkp0GiWLLSlE3OwUsRz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1k1aktBdEw0UXNyTktPL3RmZmtMZUhMM0JQSkhTTDRFTmlIQ2p2SHlTS0pn?=
 =?utf-8?B?ejdnS1k0R2grYng4WlJucDBGcm9SMGpzNEgyS3dFUUpwSjV4dkRKNmJMcHZZ?=
 =?utf-8?B?ejEraitXMUlFSnlEV2NiM21NSFJzMWRYRzRxTEsrT1FTTWIxQzVEQUZMRXdT?=
 =?utf-8?B?U2RMc1Z3aFltTmR0azNqQlZIWFYvcTgxb3lCbUkrT2YwTXkrN1cvU1phRDhK?=
 =?utf-8?B?emh1ejlhUWNPYVJpWHBTOG5TSnhBRTFRL3VQSGlHVnJmRnF0TTE2UzdMc0g0?=
 =?utf-8?B?Mmk4aS91djdLdFJ4Nm1YY0RlOHVEbUdETEhsQnQ5b0NoUS9jNDhnM3FJTjRX?=
 =?utf-8?B?a25JRkt0R3JwZU5WZE5uYmwrUWR3cmtsWkVNNm5iTXNrZ1AvNjc4cmNraE5L?=
 =?utf-8?B?a3ArN1ZqWWs2ZjJtM2Q5NVFJbVVNWnIwby9VQTc2VEsxa3YyejFWK2p2TE8v?=
 =?utf-8?B?cWhqem5JZkRXdlVIdXVrUGgrU3g5ZTJUVUliazhXTmRTcndheUZCbTVNWGEw?=
 =?utf-8?B?OXVKbXFoQUYzSXZFcVhHS2pUWTZ3WXRaN1ZDMENRMnJWNmpQWC9FQzE0dTZF?=
 =?utf-8?B?N2h0cmV0UDBMVTk5U2FkUUtjSmJuT3lPd3JQQzQrbGV3WFhLUlBuUnI4SktD?=
 =?utf-8?B?VXNsUW44RThycmZ2cTBJcHlCejRKWElYVjdRN1pDMXVJQnZRWVV6b3NhTERu?=
 =?utf-8?B?TUtxbnlobTRreTBZdEdzNWd0NFpBQmJxVnJPem1uYWQzVG0zL3E3elkwOFBi?=
 =?utf-8?B?Q1A1Sit2S1cydmlkOTZuc2tjNThqeU5wT0gvSGo1RVMwNlBydXVoeUFLbjVS?=
 =?utf-8?B?aGRiMkJ1ZDczYWhSeXU0dDZ5SjgvL0RHbTJEWVRaUzM3Nkd3cy9ITWIyYjg5?=
 =?utf-8?B?RFVCVnhFQlRWaWJHZUJHcVpsZU5YMnJYOS8wQVVSc05BU3lEbmdEemZ3NnJu?=
 =?utf-8?B?MG15QnFoYWwyVUthaFV0VmxnY1I2N1dPOUtDb1VLY3JEVzlJS1V1enl6OGM1?=
 =?utf-8?B?MTJTbVRsajNHV2JnQ295SWRveVBNVGQzUml6aEQ4NGF3dWUwYytPTEdjQXdq?=
 =?utf-8?B?OFdMeUFIaXlQNnFFczBvalAyUFNiRWdwUEd3M2FhWjFua1pPOFVsSjRXWWht?=
 =?utf-8?B?V0xLSFYrMXRrWkVPLzFKaTZKOXVTZkJCYTJJdE5xci9kS2ZTUnFFWHFOMzBo?=
 =?utf-8?B?UWduK0R4bVU0QjQrdWZrckd5cEVISXdGa29WQThoVFZpWGFuUGV4Y2pQN1ht?=
 =?utf-8?B?R1VTbWpuRFVyWlg3WXI2dTJyUmZORjQ1cnh0RXhmaXp5N1V4ejhobzRGK1RW?=
 =?utf-8?B?a2llRXdTeXhua0xJMWszZVpGaS94RnpoWVFhdVFEd3B1cWp3cEJFejBvU3h0?=
 =?utf-8?B?aXFjaUg1dVRJVis5L2JxZ0p5VlVaa1FWWk0reHVNNnVNU1NJeXoxVXh3eFhK?=
 =?utf-8?B?bEo2VllWYUFpWUJRQTZkU1FSTTFXUW04N1BJdFRsc2NKVHVTTXRCWno3RHA5?=
 =?utf-8?B?bUh2Zk9XRDJCOWhwV2hRWmlqWEtJd3gyR1JKYjE4YXBoMkVyeWdXT0I2Vmtx?=
 =?utf-8?B?MktOdVZPVWtwQVJRaGUyYXVham1EYUxVSXNFaTdiY21Sc3ZYdENKN24zMEx1?=
 =?utf-8?B?NW5qRlpPUTlYU1JhcUdEcUcwNkVOVFBleEF1cjhBWHRwWjl5RkE3YTZQMDZt?=
 =?utf-8?B?Y2pYUXNGazhGQUxvNDZCdVpzT0xzQ2xMSDdJQktUWE1CcytEbjVmT0F2bDZK?=
 =?utf-8?B?UEdNS1MyVjUzekp3d0h5UHJyZVQyMEdaV1dIeG9NSEpkNHJrek1LWjY0QU5j?=
 =?utf-8?B?NWE1Y2UyVmFYNVFzSHRjODIxNUYrNXhCNHBUMGFvaDRDQUg3OGh0WFk2YlNF?=
 =?utf-8?B?Z2ZTT0x4VGZiZk5Wam5uS0FFbmFOSjQvdEJVU0U3dytoNmdRY3pyWkx4WmYx?=
 =?utf-8?B?OS9TajVCK2RPOWdGNTNuQXo3Zm5tTzc5d0xCUHpSNlZIY3FnWGdybDVzZnFh?=
 =?utf-8?B?cDk5NlB6YkdoWVlhZXpoWGJ6Zm01MVRmZ0lUbGlxYzFiTUJlUUEvdTVTby9J?=
 =?utf-8?B?ZXVzNkI5Ny9YS3dmOHdDcXZkaFhINVVZUWlqMTk0THYwT0Z0Y04yaGtPK2I3?=
 =?utf-8?Q?PZQBxCpj+gUOH7hca3VgGZl6l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1baddf8-cf55-4a0c-109d-08dc9b2ce7e9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 06:53:55.4160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0IK2irGW5iU7IanuQR2TSnZrbMunW3QZhYDmK0Z5huFY89GhaVG6hC/n4+sXUrKHnzIEIQFn/M0ZtHvpOhs4Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7367
X-OriginatorOrg: intel.com

On 2024/7/3 13:42, Vasant Hegde wrote:
> Jason,
> 
> 
> On 7/1/2024 10:56 PM, Jason Gunthorpe wrote:
>> On Mon, Jul 01, 2024 at 04:18:01PM +0530, Vasant Hegde wrote:
>>
>>>> Then VFIO will just request the V2 domain anyhow and you are right
>>>> back to the starting problem again.
>>>
>>> Let me see if I can put together here.
>>>
>>>
>>> - Basically we want domain_alloc_paging() to explicitly tell domain requirement
>>> (ex: allocate PASID capable UNMANAGED domain)
>>>    If we do that then we will fix ordering issue I described earlier.
>>> - Fix attach device path so that for 'PASID capable UNMANAGED domain' :
>>>    non-PASID capable device will use AMD V2 page table with GCR3[0]
>>>    PASID capable device will setup its GCR3 table as well and it should work fine.
>>>
>>> Net we need a enhancement to domain_alloc_paging(). Otherwise I don't see a way
>>> to reliable implement things.
>>
>> Yes, some flag at domain allocation time is clearly needed
> 
> Right. I will try to get this going and then we can fine tune with Robin's
> suggestion.
> 
>>
>> But you need the whole story, including when will VFIO set the flag,
>> which requires a uAPI someplace.
>>
>>> But these two can go independently?
>>
>> If PASID goes with a default-on uAPI then you loose what you are
>> asking for as VFIO will always request PASID.
>>
>> So the overall plan has to be sorted out now..
> 
> Is this the Yi's thread you were referring ?
> 
> https://lore.kernel.org/linux-iommu/20240628090557.50898-1-yi.l.liu@intel.com/

This is part of the whole work. What Jason refers may be the below one.
It includes how VFIO report the PASID capability to userspace. There is
an open to be closed though. I'll loop you in the next version. :)

https://lore.kernel.org/kvm/20240412082121.33382-1-yi.l.liu@intel.com/

BTW. For AMD, can a single device be attached to multiple V1 page table?
IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
is a PASID table which has multiple cr3 page table pointers.

-- 
Regards,
Yi Liu
