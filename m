Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0EA4A07
	for <iommu@lists.linux.dev>; Tue,  4 Jun 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496166; cv=fail; b=FZCXC3XCCYd2ytoIuIvCydMMUAHNZwSAr7oXzprRJ1ljcOxRLK/wvu7qlPafeeHC4cntY1aXe/MQmGf5eeGN6l/x5iLTG1BW1K35lnMcM8xeTKpsRrDB2xF+BBMloSWROce030qImG3LNQZSabeZzF738aMLw6pp8BD+yz5hvPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496166; c=relaxed/simple;
	bh=/vXv7+3bodQ9BCYEtgpGfnLQaTSf+CZEZSpllf/U+oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u6IwR2/6Gbgq4Q9aI+22j/iaLPv3HB+HxsApxgAEzblEre20Bam7UNZwPGEpWz2/HIbhUczkdkt5XVzraHWGHgQY31juTJn5qtn7jGlo4B/qPLwr39Jc57gFKzJJ8AQAGXfZMWwjZSSoUqOlGlTs7zd/iI2R/bFhzMCS48l5Rug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDnDckao; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDnDckao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717496163; x=1749032163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/vXv7+3bodQ9BCYEtgpGfnLQaTSf+CZEZSpllf/U+oc=;
  b=mDnDckaoDbld/QG1BFpgKXq4Uk6rmG/99Gl1n4tkoVIblE3L8n5ypT7h
   ZDcGmOUtyy/GLBdiNfoSE66YSg498gqQuaTQwzPDd66ovOPV7W64tKTFV
   vfM7bCWnn2t6j21n4lzoqq7qCeGrc/zq4SelJ9NL3D1l1uiKANeZaj7+v
   RymqcONJcI40fx6FmMxFk31O1RgXIZSOWMd60Gn8h//hcD5yhcxZa5pAU
   peYx2Zjml27ih/OoX83LMNF01eZ2hXWXuU13nSL6mid0WiL6f48CoD9QD
   7gepFE3/znpVrI/HRQK8LGL883vivQYhgsyAURTLl2Os0pixz5/gRnVG+
   w==;
X-CSE-ConnectionGUID: ixT+0bZ7ReWsXRPznTE5Kw==
X-CSE-MsgGUID: iP34NYfIR6SiQuOWYhptMg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="11891799"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="11891799"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 03:16:02 -0700
X-CSE-ConnectionGUID: VC1B895+QemVWmKWw36Odg==
X-CSE-MsgGUID: mjfq5hFKT+muaP3+mby0VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="42143989"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jun 2024 03:16:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 4 Jun 2024 03:16:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 4 Jun 2024 03:16:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 03:16:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgsS5OQhoa2p2Qomta2LjbG+FUZ2tzmfOznPQU6mKlQKJq43HcZ8QPs5MnklD0rf6lw4C21yBS0f2eKvkab+Kjj8xTi64F8YAezHmF/pTprdwiOXGOOJPoyZmqJWaY6jk/Wy+XePbbwvulae7WIixhWx7CS9RDJ3YVBnDHRkz5uoUh2Y/QClTJhOFAqTJT5LmWNBHv/HPvZIlw8JW2zvTfr7Z9/ldT2vfyc5q0fh+1rySxPxTIrGhpfWzp2GdbdT1vLdDEH6Evzoj/KxAMBMQKY7tshXU4APcNjoD01swoc/Pd+IA4ca8HjugHgKFaVcyjyZCZGLP2H0mEs4+tNnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vXv7+3bodQ9BCYEtgpGfnLQaTSf+CZEZSpllf/U+oc=;
 b=IWHQzeLgGBB6BmpP+qpxSJOAjq1ZfwN1rABW29vU2Wk1QnLtu8wD0t0pGT4a9wiyuzuisuNGR+VIN7CULKpJiHN/lG5T/PBxwaP15csCbRhKN16amMwXPJqzN5c0Vb9L1p4xuIe/kabA1may7iZYAxQ9ZSo8GLyeLcji4dZBYsl7B+wo7WeSw1ISfVQ0bh6f16MltEmhZr9ktae6mboZsMroLfDN0tGwxaANDD3T6mzKvjMNCwAoelt5gVKYjKwmiM8W+9R61ThpPm4DhZtg+V1QuoBBcuFgzMI3116xvUdRY4loVS6RGF8rzp9XcJok91CymKO1LTRLtF006qhYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by IA0PR11MB8302.namprd11.prod.outlook.com (2603:10b6:208:482::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 10:15:59 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::7b5e:97d2:8c1d:9daf%5]) with mapi id 15.20.7611.025; Tue, 4 Jun 2024
 10:15:58 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
Thread-Topic: [PATCH 1/2] iommu/vt-d: Support batching IOTLB/dev-IOTLB
 invalidation commands
Thread-Index: AQHap/JyA+quh6RCVk2aSVRG2G8N3LGeUfAAgBdsvICAASqXAIAARQCggAAbwQCAADZUsA==
Date: Tue, 4 Jun 2024 10:15:58 +0000
Message-ID: <MW5PR11MB58818780538810E15031C4B289F82@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20240517003728.251115-1-tina.zhang@intel.com>
 <20240517003728.251115-2-tina.zhang@intel.com>
 <2b390228-190c-4508-b98f-1811c54c9e5c@linux.intel.com>
 <MW5PR11MB588165376224FEA74A0426D989FF2@MW5PR11MB5881.namprd11.prod.outlook.com>
 <7440cd36-41e0-4705-a597-f2ce3f841a70@linux.intel.com>
 <MW5PR11MB58814B632958A5776B6C31FF89F82@MW5PR11MB5881.namprd11.prod.outlook.com>
 <74992544-de5d-40a3-a68d-7a9bcd03ae71@linux.intel.com>
In-Reply-To: <74992544-de5d-40a3-a68d-7a9bcd03ae71@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|IA0PR11MB8302:EE_
x-ms-office365-filtering-correlation-id: a247edc7-2b9b-4a0a-7fa6-08dc847f5423
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZGc2c3Y5UmVjeCtscTRZOE9GN29WZXZKNU5WSTBNVEJPRjNaUVg1SXQ3Ry9P?=
 =?utf-8?B?OENnLyt2eE02SzhseTBKLzRtY25PWHNXaDdxamV1bzRGRFJvK0VOTzVtVEZu?=
 =?utf-8?B?cm00QnpXYS9ZRWlpcUtiajBPdkFwdzFoOUF0cjVuOVBHYXRiUURJVW5iWDNY?=
 =?utf-8?B?bHBkRTFReVI3b0hSL1JMKzNUdHJWZUlSdzcyajE4RW40MFlTM0x1RnZiSkFM?=
 =?utf-8?B?NzlvZUpRMTc0WmZGcm85ZzZPTWF0NXdpUmNYUFk0SHpxQVJPZTBRZ2VBODUv?=
 =?utf-8?B?eVdpTkMvRUlSZFdFVE1RUzZjcDM3dEY0OHFxN2lxR0lQSDlyTTZDRTNyd29N?=
 =?utf-8?B?SmphaTV2QVlBZEpubmlWeFJ4NjcyQndMSGlhdzE1OWxPMmwrZXYrUHA1bEVy?=
 =?utf-8?B?SjJSbktvMEM3K3BkUzNXb1FDQjJteGs3WlYzQmVmYk9qNCsyQVUrRGtsZmtI?=
 =?utf-8?B?b0ZwbmNDR01MZUNlT0pNK3VOcTdHOElUWG1iOW9oclAxOVk2bEIrUjd0eVBR?=
 =?utf-8?B?bWdnN2NNQmxPMW9TU0VVTWZKUEpYMmdYNG5VbTArMktXU1F1RlhFYTBSVjVi?=
 =?utf-8?B?TUFmaWdpekVYdm1ZRXNrUHVrZ2tmRjAzN1pRcVNpUnI0YjRmZFYyVktGRXVH?=
 =?utf-8?B?UFdFMGRsL1pTTUkvY0RaQllHVTZLM2N3YVg5cHI0MGljRkhDZmw3OW9WOXd4?=
 =?utf-8?B?WWFsUldIbGlpTXJwR0hicWVFRElZVnM4RHFjSXYyNXVpT0JxTGxpU0VpM3Mx?=
 =?utf-8?B?ZElTMGkrSTVFSS9DbE5haXE1b2VtUlYyV2NmK2xoUUI2V1pPNEdZem5XUjZB?=
 =?utf-8?B?b2hVT0UrWnBFNWNraytpRko4dldFU0hPTVc4WHdrQXVWRjlMc1dlWEFZWFIr?=
 =?utf-8?B?RkFlb09zV2xiRVUrYk9wQ3lYWE1vb0dRL2tsZnJSbSs3T280VU45SWhFNHNO?=
 =?utf-8?B?dXYvSDRpV1JDR2Q3ZzFIYWNUc1NVU0VYS3UyYWdlNmlqMGlnU2NhSWpGS3Bq?=
 =?utf-8?B?Q0FpampDQWZUeWtObkF6Rm5IbkN1dDNIbVBEaW9MbGJiZWpoUHBHOUNVTytT?=
 =?utf-8?B?VWhuWnhSNTE5RW9UR25qcnp0Q2FDL1l6REx5YlhWZjZDWGtZVUxJU3FTK2Iv?=
 =?utf-8?B?UFUxY0FOaThGMTUrYWJZSzNRSG1lOTl1cEFsMWc4SG5XdjZaaTVTTnpNQ2kr?=
 =?utf-8?B?dlVsZXFYVjN3MUJrZnBKdkpsellKc3U5VncrNU5vOFIvc1daSG1WM2tWRXdW?=
 =?utf-8?B?RzdyZ25XaldmSDdpZitGR1FSb1Rsc1RUaFhYbHZXTTVMSDJpeVk4UlU3MzNR?=
 =?utf-8?B?MTQ0UUpXK1BaSWowOE82WnBxaHhhUU12dlhncGxZc0pKdkxrd1NwLzR6Vkpn?=
 =?utf-8?B?ZTFWYVNLZHdYZ2ZNRDduMFJBbVFuYVVJQUc5UE1iSFNKcDBTV1ZhbWc2aHNX?=
 =?utf-8?B?aGg3UUxJSEVqRVBvdHRyVWg0a09QcVREeDEzejh4NU1WSTZUaXRGVHF3R0Z0?=
 =?utf-8?B?WTZTcTlTaVVWUTIrMms1RWVrd3lvYi9VM0prVVkzMjQyRTk2bHlTbmpIdk1w?=
 =?utf-8?B?SHk1cW5EZm13K0RpM3VhMDlDTk9aQnJKTUk2ZVJDQTlwcUlKVlE4cWhhZjNO?=
 =?utf-8?B?Skg2NmV5WC95Z3orQUgxVURQNXZldDdRMFFXK0huaGtGK1hFU204YThRazE1?=
 =?utf-8?B?bWpKc1QrUXpCVzhUMDRZaUluZGIyUXpYVzRTc0NMOU5Wc3Zva2ptUUwvNWVo?=
 =?utf-8?B?RHpNaDdVbU41MmVIc1MyK1IrUUxKdnFKK29NVXJTMG1DYk1BTXNiRG5WeEpz?=
 =?utf-8?B?VTN1NzlhcWlFOTlseU1JQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVBoSm44cFFiQVd4bWxiNUhEMXN4UlU3NEx0VTJXWnhQRnVBSE1HOGd2S0xI?=
 =?utf-8?B?MGt4ZjNkdXlmcTdWTzdtMXhxa2dqQWdnUzFyOTFWTkhjZWpMNDhmc3hwM0hw?=
 =?utf-8?B?eU05KzZ0NEtIUCtNZHlwYkJ2R3NMR004UUtIL0JaYjFOaThuV0dmSjlWYWhj?=
 =?utf-8?B?SjNUbktkMVB6OTRPeC9TMzFTQWwvb1hnaWU1dFF5KzlBQnlnSlFtd1hCdWFo?=
 =?utf-8?B?b1gzSzArSm1mTVdLZTBOT2dzM3poTWY4MXcvUHBWSDl5N1pTQi9nUHdCK3BN?=
 =?utf-8?B?TjRYOG84WDlNeVJuNXUwRDNNRm5FYzcrQ2U0b2tGTVYzVzNXVzlEMVhLUTZy?=
 =?utf-8?B?U0Z0cGxxLy9kOFpjemlhbFBvK2FmZ3JGMWYrNkJYaDRiSElFbTEwUm9RSmUz?=
 =?utf-8?B?U2g5RExhTVZJbnYrQk1Nc1VucHRqc3UwalJ0NDlHK250bHpFQXdBbFVwOG5l?=
 =?utf-8?B?dFNCSGRNTCtVUTdZWFdRdVk2dGovbXdoeGlNNFdRb3o0VWlxTGpnSkJRbTY2?=
 =?utf-8?B?dXlVekFkZmlwTjhSbjVqL3c4OGdobndXYXFvYmhsWHl3THNPd2F3MjlaYkg0?=
 =?utf-8?B?K1hvV0RYdTVnaTEwQkgwRWlUN2YwcHBIUTRtekxyZlQwYzlRb2pqWkt2cisx?=
 =?utf-8?B?YitOck92b0ZOR05NbHl5Vm5ROTRjZHVqZEU3SVJod2dvVVBxbmxvTjVWcnh0?=
 =?utf-8?B?N29ISnNNVm9haEIrSkpIUkZ2c3RMVnNJLzljTkVtN09SZTZHOFZFYWlmWHRo?=
 =?utf-8?B?TUdoSER0NDdTQ2hGTHZ5RTIybThwSWZoMzNHR2EwSlF2azZFcy9NUFRVaUFP?=
 =?utf-8?B?WGRPa2hZOXJCeml6UkFhOVE2MDRySUl4NTg2N2cyenJmWHdCdEU0aTZQUTA1?=
 =?utf-8?B?b3l4amNyOU5pUi8zUXpMM1dEWG9LaWVoS2dVZHhvdU1ySHpqMlZxdURmc1Z4?=
 =?utf-8?B?NHFoRDNSWXhXTmJEWXJJODNoSXlCblE3eTBWL2hZSkpES3RKOWcvSDZ1T3A2?=
 =?utf-8?B?bjFteDRGVnAyVjl3Q2xLZ2hlYzNqNVhqQ1pLSkEwbmFDUmtKL0ZWNVhzZVdk?=
 =?utf-8?B?RkFDUnFoeU80RWYvVnpPa3BYaXZ4S0tkeWplaEhxWjZaZGgvZzkxRkRWdW1L?=
 =?utf-8?B?ZzZQQ1RBVnEwZm5BUi9TRmR5RTdTRy9SWm55YnA1WThhRTN1VE9rYXVuM1kw?=
 =?utf-8?B?NWRoZnF4OVZEblZBUW9yNHppTld4azczUm9Pc0djck5XRnBIOEVkRG9yQTBm?=
 =?utf-8?B?YytrSFpDbVk3cmR4RS84UDlkS1Q4bmErZEtlVERnc3VxTlBUT3R6dkQvQTNz?=
 =?utf-8?B?TTVvOGI1NUpjWk1QQUFqY2k5Y3JrMmU3eVJoVWpNVElMYlV3S2k5WEtlNzhK?=
 =?utf-8?B?Snhmamg0WlB6Mi83aVpDNXpHTlBZMDM5Vld3dnVveTRDczlBQnY0cXJUQWtP?=
 =?utf-8?B?VFloR2RoaUFiMG14Y3o1dlZDUENYSWhKeXlTb0FySXVTN0dvVGp4MjA1a1cz?=
 =?utf-8?B?eUd4OG85SzB6MVErVStXWThJUTJCeXhtaXVHUmNCT084ZzRjUjdVMWUraU9I?=
 =?utf-8?B?OUlxck1GaWg0TVl3UFFWQ2RtUFBUU0FLNnUxa29lclB1VVBGQTZnbG1PTlBq?=
 =?utf-8?B?UVN3S3hJYnhwZ3I5UXZyODBCaGUzcklFcnhJVTJ2cHNadkwxQ3BjUWhrT2ZQ?=
 =?utf-8?B?OUsrNWNEdmZLbjVpb1NIdWZLOXpLdjZsMHNTc0ZZNkdOUDRMRkc2RW9Ub0li?=
 =?utf-8?B?ajdGNjE4djFaVnErUEdaQXZsVy9OYUQzM2lVKzZrT0lHMlgzRUcrV0xvT1FG?=
 =?utf-8?B?VkVIS2FSTmJMblR3c3Q4R1hqTzdmb1hZYjNyd3pEYkhzL1JycG9SUVMrMDFk?=
 =?utf-8?B?S2hRd0pMV21YODduY0V3MSsxOXhna3pma1M3M2VOWG96aG9YRlpoN3Rpci83?=
 =?utf-8?B?RzZHNllBUTIxb3h0UVJhVk1NQWg2Q0lidUFNMmREdVg3ZWlCV20xSXFkdVhp?=
 =?utf-8?B?THNhcmxlNEdHdHhoREdDbEVIdnZPQUNoUG93RWx0TFBKMlNYS2FERm5oZ1E5?=
 =?utf-8?B?VlB2Ti9SZFRPMXZwcGVSR2lFN0pJbkppRzdtYVVKK3ZPLzZHSU9vbjkxZVg3?=
 =?utf-8?Q?7hfsPAB3yEhIHeZzwZy4Y9QY4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a247edc7-2b9b-4a0a-7fa6-08dc847f5423
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 10:15:58.6842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sgbeeS3y4K++PmAaYFm1c4RvUeUBdMtoX1NsG3DZdKVFqT6014tHpi4QnVnZX0L1ViZUtUrbOtLQnOPPw8gZgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8302
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUgTHUgPGJhb2x1
Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSA0LCAyMDI0IDM6MDEg
UE0NCj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNvbT47IFRpYW4sIEtldmlu
IDxrZXZpbi50aWFuQGludGVsLmNvbT4NCj4gQ2M6IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTsg
aW9tbXVAbGlzdHMubGludXguZGV2OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gaW9tbXUvdnQtZDogU3VwcG9ydCBiYXRjaGluZyBJ
T1RMQi9kZXYtSU9UTEINCj4gaW52YWxpZGF0aW9uIGNvbW1hbmRzDQo+IA0KPiBPbiA2LzQvMjQg
MTo1OSBQTSwgWmhhbmcsIFRpbmEgd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4g
U2VudDogVHVlc2RheSwgSnVuZSA0LCAyMDI0IDk6MTUgQU0NCj4gPj4gVG86IFpoYW5nLCBUaW5h
PHRpbmEuemhhbmdAaW50ZWwuY29tPjsgVGlhbiwNCj4gPj4gS2V2aW48a2V2aW4udGlhbkBpbnRl
bC5jb20+DQo+ID4+IENjOmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTtpb21tdUBsaXN0cy5saW51
eC5kZXY7IGxpbnV4LQ0KPiA+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggMS8yXSBpb21tdS92dC1kOiBTdXBwb3J0IGJhdGNoaW5nIElPVExCL2Rldi1J
T1RMQg0KPiA+PiBpbnZhbGlkYXRpb24gY29tbWFuZHMNCj4gPj4NCj4gPj4gT24gNi8zLzI0IDM6
MzcgUE0sIFpoYW5nLCBUaW5hIHdyb3RlOg0KPiA+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4+Pj4gRnJvbTogQmFvbHUgTHU8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+
Pj4+IFNlbnQ6IFN1bmRheSwgTWF5IDE5LCAyMDI0IDU6NDMgUE0NCj4gPj4+PiBUbzogWmhhbmcs
IFRpbmE8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBUaWFuLA0KPiA+Pj4+IEtldmluPGtldmluLnRp
YW5AaW50ZWwuY29tPg0KPiA+Pj4+IENjOmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbTtpb21tdUBs
aXN0cy5saW51eC5kZXY7IGxpbnV4LQ0KPiA+Pj4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gaW9tbXUvdnQtZDogU3VwcG9ydCBiYXRjaGlu
Zw0KPiA+Pj4+IElPVExCL2Rldi1JT1RMQiBpbnZhbGlkYXRpb24gY29tbWFuZHMNCj4gPj4+Pg0K
PiA+Pj4+IE9uIDUvMTcvMjQgODozNyBBTSwgVGluYSBaaGFuZyB3cm90ZToNCj4gPj4+Pj4gSW50
cm9kdWNlIGEgbmV3IHBhcmFtZXRlciBiYXRjaF9kZXNjIHRvIHRoZSBRSSBiYXNlZA0KPiA+Pj4+
PiBJT1RMQi9kZXYtSU9UTEIgaW52YWxpZGF0aW9uIG9wZXJhdGlvbnMgdG8gc3VwcG9ydCBiYXRj
aGluZyBpbnZhbGlkYXRpb24NCj4gZGVzY3JpcHRvcnMuDQo+ID4+Pj4+IFRoaXMgYmF0Y2hfZGVz
YyBpcyBhIHBvaW50ZXIgdG8gdGhlIGRlc2NyaXB0b3IgZW50cnkgaW4gYSBiYXRjaA0KPiA+Pj4+
PiBjbWRzIGJ1ZmZlci4gSWYgdGhlIGJhdGNoX2Rlc2MgaXMgTlVMTCwgaXQgaW5kaWNhdGVzIHRo
YXQgYmF0Y2gNCj4gPj4+Pj4gc3VibWlzc2lvbiBpcyBub3QgYmVpbmcgdXNlZCwgYW5kIGRlc2Ny
aXB0b3JzIHdpbGwgYmUgc3VibWl0dGVkDQo+IGluZGl2aWR1YWxseS4NCj4gPj4+Pj4NCj4gPj4+
Pj4gQWxzbyBmaXggYW4gaXNzdWUgcmVwb3J0ZWQgYnkgY2hlY2twYXRjaCBhYm91dCAidW5zaWdu
ZWQgbWFzayI6DQo+ID4+Pj4+ICAgICAgICAgICAgIlByZWZlciAndW5zaWduZWQgaW50JyB0byBi
YXJlIHVzZSBvZiAndW5zaWduZWQnIg0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBU
aW5hIFpoYW5nPHRpbmEuemhhbmdAaW50ZWwuY29tPg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4gICAg
IGRyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYyB8IDMzICsrKysrKysrKysrLS0tLS0tLQ0KPiA+
Pj4+PiAgICAgZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMgIHwgNjcgKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0NCj4gLS0NCj4gPj4+Pj4gICAgIGRyaXZlcnMvaW9tbXUvaW50
ZWwvaW9tbXUuYyB8IDI3ICsrKysrKysrKy0tLS0tLQ0KPiA+Pj4+PiAgICAgZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5oIHwgMjEgKysrKysrKystLS0tDQo+ID4+Pj4+ICAgICBkcml2ZXJzL2lv
bW11L2ludGVsL3Bhc2lkLmMgfCAyMCArKysrKystLS0tLQ0KPiA+Pj4+PiAgICAgNSBmaWxlcyBj
aGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKSwgNjggZGVsZXRpb25zKC0pDQo+ID4+Pj4+DQo+ID4+
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPj4+Pj4gYi9k
cml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgaW5kZXggZTg0MThjZGQ4MzMxLi5kY2Y1ZTBlNmFm
MTcNCj4gPj4+Pj4gMTAwNjQ0DQo+ID4+Pj4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2Fj
aGUuYw0KPiA+Pj4+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMNCj4gPj4+Pj4g
QEAgLTI3OCw3ICsyNzgsNyBAQCB2b2lkIGNhY2hlX3RhZ19mbHVzaF9yYW5nZShzdHJ1Y3QgZG1h
cl9kb21haW4NCj4gPj4+PiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIHN0YXJ0LA0KPiA+Pj4+PiAg
ICAgCQljYXNlIENBQ0hFX1RBR19ORVNUSU5HX0lPVExCOg0KPiA+Pj4+PiAgICAgCQkJaWYgKGRv
bWFpbi0+dXNlX2ZpcnN0X2xldmVsKSB7DQo+ID4+Pj4+ICAgICAJCQkJcWlfZmx1c2hfcGlvdGxi
KGlvbW11LCB0YWctDQo+ID5kb21haW5faWQsDQo+ID4+Pj4+IC0JCQkJCQl0YWctPnBhc2lkLCBh
ZGRyLCBwYWdlcywgaWgpOw0KPiA+Pj4+PiArCQkJCQkJdGFnLT5wYXNpZCwgYWRkciwgcGFnZXMs
IGloLA0KPiA+Pj4+IE5VTEwpOw0KPiA+Pj4+PiAgICAgCQkJfSBlbHNlIHsNCj4gPj4+PiBJJ2Qg
bGlrZSB0byBoYXZlIGFsbCBiYXRjaGVkIGRlc2NyaXB0b3JzIGNvZGUgaW5zaWRlIHRoaXMgZmls
ZSB0bw0KPiA+Pj4+IG1ha2UgaXQgZWFzaWVyIGZvciBtYWludGVuYW5jZS4gUGVyaGFwcyB3ZSBj
YW4gYWRkIHRoZSBiZWxvdw0KPiA+Pj4+IGluZnJhc3RydWN0dXJlIGluIHRoZSBkbWFyX2RvbWFp
biBzdHJ1Y3R1cmUgdG9nZXRoZXIgd2l0aCB0aGUgY2FjaGUgdGFnLg0KPiA+Pj4gRG9lcyBpdCBz
dWdnZXN0IHdlIG5lZWQgdG8gYWRkIGEgYmF0Y2ggdmVyc2lvbiBvZg0KPiA+PiBxaV9mbHVzaF9p
b3RsYi9xaV9mbHVzaF9kZXZfaW90bGIvcWlfZmx1c2hfcGlvdGxiL3FpX2ZsdXNoX2Rldl9pb3Rs
Yl8NCj4gPj4gcGFzaWQoKSBpbiB0aGUgY2FjaGUuYyBmaWxlPyBJdCBkb2Vzbid0IHNvdW5kIGxp
a2UgYW4gZWFzeSB0bw0KPiA+PiBtYWludGFpbiB0aG9zZSBmdW5jdGlvbnMsIGRvZXMgaXQ/DQo+
ID4+DQo+ID4+IFllcy4gSSBkb24ndCB0aGluayBpdCdzIHRoYXQgZGlmZmljdWx0IGFzIHRoZSBo
ZWxwZXJzIGp1c3QgY29tcG9zZSBhDQo+ID4+IHFpIGRlc2NyaXB0b3IgYW5kIGluc2VydCBpdCBp
biBhIGxvY2FsIHF1ZXVlLiBUaGlzIGxvY2FsIHF1ZXVlIHdpbGwNCj4gPj4gYmUgZmx1c2hlZCBh
ZnRlciBmaW5pc2hpbmcgaXRlcmF0aW5nIGFsbCBjYWNoZSB0YWdzLCBvciB0aGVyZSdzIG5vDQo+
ID4+IHJvb20gZm9yIG1vcmUgZGVzY3JpcHRvcnMsIG9yIHN3aXRjaGVzIHRvIGEgZGlmZmVyZW50
IGlvbW11LiBIYXZlIEkgbWlzc2VkDQo+IGFueXRoaW5nPw0KPiA+IEluIGN1cnJlbnQgVlQtZCBk
cml2ZXIsIG9ubHkgcWlfZmx1c2hfeHh4KCkgZnVuY3Rpb25zIGhhdmUgdGhlIGtub3dsZWRnZSBh
Ym91dA0KPiBob3cgdG8gbWFrZSBJT1RMQiBpbnZhbGlkYXRpb24gZGVzY3JpcHRvcnMuIEluIHFp
X2ZsdXNoX3h4eCgpIGZ1bmN0aW9ucywgVlQtZA0KPiBpbnZhbGlkYXRpb24gZGVzY3JpcHRvcnMg
YXJlIHBvcHVsYXRlZCBhbmQgc3VibWl0dGVkIHRvIGhhcmR3YXJlIGltbWVkaWF0ZWx5Lg0KPiA+
DQo+ID4gVG8gc3VwcG9ydCBiYXRjaGluZyBjb21tYW5kLCBJIHRoaW5rIHdlIGNhbiBoYXZlIHR3
byBjaG9pY2VzOg0KPiA+IDEuIEV4dGVuZCBxaV9mbHVzaF94eHgoKSBmdW5jdGlvbnMgdG8gc3Vw
cG9ydCBiYXRjaGluZyBkZXNjcmlwdG9ycy4NCj4gPiAoSnVzdCBsaWtlIHRoZSBpbXBsZW1lbnRh
dGlvbiBpbiB0aGlzIHZlcnNpb24pIEluIHRoaXMgd2F5LCB0aGUga25vd2xlZGdlIG9mDQo+IHBv
cHVsYXRpbmcgYW4gSU9UTEIgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IgaW4gcWlfZmx1c2hfeHh4
KCkgaXMgcmV1c2VkLg0KPiBBZGRpdGlvbmFsIGNvZGUgY2hhbmdlIGlzIGZvciBiYXRjaGluZyB0
aGUgZGVzY3JpcHRvciBjb21tYW5kIGludG8gYSBidWZmZXIuDQo+ID4NCj4gPiAyLiBJbnRyb2R1
Y2UgYSBuZXcgc2V0IG9mIGludGVyZmFjZXMgdG8gcG9wdWxhdGUgSU9UTEIgZGVzY3JpcHRvcnMg
YW5kIGJhdGNoDQo+IHRoZW0gaW50byBhIGJhdGNoIGJ1ZmZlci4NCj4gPiBUaGUgbmV3IHNldCBv
ZiBpbnRlcmZhY2VzIGlzIGltcGxlbWVudGVkIGluIHRoZSBjYWNoZS5jIGZpbGUgYW5kIHdlIG5l
ZWQgdG8NCj4gY29weSB0aGUga25vd2xlZGdlIGFib3V0IGhvdyB0byBwb3B1bGF0ZSBJT1RMQiBk
ZXNjcmlwdG9ycyBmcm9tDQo+IHFpX2ZsdXNoX3h4eCgpIGludGVyZmFjZXMgaW50byB0aGUgbmV3
IGludGVyZmFjZXMuIEkgaGVzaXRhdGVkIHRvIGNob29zZSB0aGlzDQo+IG9wdGlvbiBiZWNhdXNl
IGl0IHdvdWxkIGR1cGxpY2F0ZSBjb2RlLiBNYXliZSB3ZSBjYW4gZ2VuZXJhbGl6ZSB0aGUNCj4g
a25vd2xlZGdlIG9mIHBvcHVsYXRpbmcgSU9UTEIgZGVzY3JpcHRvcnMgaW50byBsb3dlciBsZXZl
bCBpbnRlcmZhY2VzIGFuZCBtYWtlDQo+IHRoZSBjdXJyZW50IHFpX2ZsdXNoX3h4eCgpIGFuZCB0
aGUgbmV3IHNldCBvZiBpbnRlcmZhY2VzIGNhbGwgdGhlbS4NCj4gPg0KPiA+IFdoaWNoIG9wdGlv
biBkbyB5b3UgdGhpbmsgaXMgYmV0dGVyPw0KPiANCj4gV2UgY2FuIHNoYXJlIHRoZSBjb21tb24g
Y29kZSB3aXRob3V0IGNoYW5naW5nIHRoZSBjdXJyZW50IGhlbHBlciBpbnRlcmZhY2VzLg0KPiBT
b21ldGhpbmcgbGlrZSB0aGlzLA0KPiANCj4gc3RhdGljIGlubGluZSB2b2lkIHFpX2Rlc2NfaW90
bGIoc3RydWN0IGludGVsX2lvbW11ICppb21tdSwgdTE2IGRpZCwgdTY0IGFkZHIsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgc2l6ZV9vcmRlciwgdTY0
IHR5cGUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgcWlfZGVz
YyAqZGVzYykgew0KPiAgICAgICAgICB1OCBkdyA9IDAsIGRyID0gMDsNCj4gICAgICAgICAgaW50
IGloID0gMDsNCj4gDQo+ICAgICAgICAgIGlmIChjYXBfd3JpdGVfZHJhaW4oaW9tbXUtPmNhcCkp
DQo+ICAgICAgICAgICAgICAgICAgZHcgPSAxOw0KPiANCj4gICAgICAgICAgaWYgKGNhcF9yZWFk
X2RyYWluKGlvbW11LT5jYXApKQ0KPiAgICAgICAgICAgICAgICAgIGRyID0gMTsNCj4gDQo+ICAg
ICAgICAgIGRlc2MtPnF3MCA9IFFJX0lPVExCX0RJRChkaWQpIHwgUUlfSU9UTEJfRFIoZHIpIHwg
UUlfSU9UTEJfRFcoZHcpDQo+ICAgICAgICAgICAgICAgICAgfCBRSV9JT1RMQl9HUkFOKHR5cGUp
IHwgUUlfSU9UTEJfVFlQRTsNCj4gICAgICAgICAgZGVzYy0+cXcxID0gUUlfSU9UTEJfQUREUihh
ZGRyKSB8IFFJX0lPVExCX0lIKGloKQ0KPiAgICAgICAgICAgICAgICAgIHwgUUlfSU9UTEJfQU0o
c2l6ZV9vcmRlcik7DQo+ICAgICAgICAgIGRlc2MtPnF3MiA9IDA7DQo+ICAgICAgICAgIGRlc2Mt
PnF3MyA9IDA7DQo+IH0NCj4gDQo+IHZvaWQgcWlfZmx1c2hfaW90bGIoc3RydWN0IGludGVsX2lv
bW11ICppb21tdSwgdTE2IGRpZCwgdTY0IGFkZHIsDQo+ICAgICAgICAgICAgICAgICAgICAgIHVu
c2lnbmVkIGludCBzaXplX29yZGVyLCB1NjQgdHlwZSkgew0KPiAgICAgICAgICBzdHJ1Y3QgcWlf
ZGVzYyBkZXNjOw0KPiANCj4gICAgICAgICAgcWlfZGVzY19pb3RsYihpb21tdSwgZGlkLCBhZGRy
LCBzaXplX29yZGVyLCB0eXBlLCAmZGVzYykNCj4gICAgICAgICAgcWlfc3VibWl0X3N5bmMoaW9t
bXUsICZkZXNjLCAxLCAwKTsgfQ0KPiANCj4gVGhlIHFpX2Rlc2NfaW90bGIoKSBjYW4gYmUgdXNl
ZCBpbiBib3RoIGJhdGNoZWQgYW5kIG5vbi1iYXRjaGVkIHBhdGhzLg0KPiBEb2VzIHRoaXMgd29y
ayBmb3IgeW91Pw0KSXQgd29ya3MuIFRoYW5rcy4NCg0KUmVnYXJkcywNCi1UaW5hDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IGJhb2x1DQoNCg==
