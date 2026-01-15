Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2B27732
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768456166; cv=fail; b=j7hrpPclQMACslospAUBuyBZ3qmyu1gjaK8dU/2mn9brMFQ1dJ7DAhS5nrASX/UxdSVlzIg+vJsreMLYocx3mJx9kBQ4sc9akoUw79zOxHGAMHme19dqscg9Jcyq5yjukCNe5yup4mxYTZQRxjiIQ1xHLQm2uN9DiDKUdfne7qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768456166; c=relaxed/simple;
	bh=ryhTUhpvNP8AvXV0EmibUVSEedeZFKMDO2AMLY1y3x0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lxj4TCzj2pQT2hNuOkfMYC+k3Km9TQQqm3k5LCQlarKJHHW9B2Poz+4PmL9jWZj/epTyLKvLZbBwA9cGZ691zFH20OCrqFACdXUO2Hf9HUD9KZ6TRhZdQ2EWlbI6D5LXlC6/QvIaNGXqm/VVHGYxnhbwuGG5WFOjtDnT1ut/lpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqiis5hH; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqiis5hH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768456165; x=1799992165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ryhTUhpvNP8AvXV0EmibUVSEedeZFKMDO2AMLY1y3x0=;
  b=jqiis5hHJdtXXHUKLVJIK9vpwWMqCjuqMyOSBxLZjRxpjaAlrgzOzPiV
   FDoK+yW3lmniYwYfuFe0yq9KnVJTgAI2T0UvtOiQtHxbGlUqM6qKjTGZ0
   vZdcUqlTMDaAk0lnqiQfRUj+vdhpcL0XgVPuK0BKEYPJ6qs28FDiOKpLB
   P2n4OOy+vzQ3YxNXCg6sZr6QnQ8NZi+hubStJCwzcaiQ9xcThwiGucMbz
   h7pnv5Y1JudOktQIGeM8Tzt/ylvhIMRprgmYhunt2wbqPKnxL34qY1gJ7
   g8LEUfszy52TghDJhjEiMXl+mAUkeQ6VyeDFmkgGWAv+uSyvWzt46apZR
   A==;
X-CSE-ConnectionGUID: a/lN0C16TYifvuETE5gL8g==
X-CSE-MsgGUID: 2KWh4TngSoqyxpZCyC2jSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69668864"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69668864"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 21:49:25 -0800
X-CSE-ConnectionGUID: rly+eDboS0OW3FNf3yQJLA==
X-CSE-MsgGUID: tTL9W2o1RGyklxi/HU1MkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="205388713"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 21:49:24 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 21:49:23 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 21:49:23 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.62) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 21:49:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxpBiToU0RdQKL+uBorBmC5AXKWEip7FWCsdtl/+eVandK5V9oR72B3gwjSkp3bVNtT9mTqOFZzIJ/VThSoP+xnLuPe7uKSEjqqMixQoVDyGNKREgmnFVkRRxy/L/clhjXDjjrYbcFoIBI2ph04IjUQqeBoRqw+Z1Dc9NNQr4BlDsBEBL8UP/kcxHJPgUp5+ILIGrwxqsrAIjd2yrGAUu1Mkp1wR/zYkCHPbRUC1K5317pIcxsdnPwGcHguWHTAGy5VwB/FzE6U4jnpMuwE9hM7mh0eZn7bNwTjpxbNx3cS5bl6xS0DnTA2l5EzWsZgJYBjqaHP8pk6+EV4cZipVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryhTUhpvNP8AvXV0EmibUVSEedeZFKMDO2AMLY1y3x0=;
 b=ejwovMSDbE4XQbD4kDksNs5lkZkNLHF7SfxA5UDHr+s/UKBpIaixxtrsbWn441gJWmgYGHMuUc0w1A4enzdfdOTI0/Awpw7L9WVIKQUuzQdoLXES41lftCedcYQ0G/FEMIt9D5I3YelWU/KmnpsKb/vjLKYglqNuv3IHvTq1zzMfzMBscsil88/mvJ8STDLerBSVg4dEcLJJCX8Q2bgRPqB4pbCLxEkJf7K+uj8vM9qtrtcOKNdRWp2ifobvrfsMdanGqnO2WhiPBLIzFleLrbxy5SUpKyL5PDv6AVXT+aCo9E612cwfs/MwAJ52cne6yKLfC/lskqh8XYOXf0RQeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8372.namprd11.prod.outlook.com (2603:10b6:a03:539::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 05:49:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 05:49:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
CC: Dmytro Maluka <dmaluka@chromium.org>, Samiullah Khawaja
	<skhawaja@google.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Thread-Topic: [PATCH 2/3] iommu/vt-d: Clear Present bit before tearing down
 PASID entry
Thread-Index: AQHchDk99dS8zYs1cUWZyJOSO2CkmLVRRyEggAAPqoCAAWU30A==
Date: Thu, 15 Jan 2026 05:49:21 +0000
Message-ID: <BN9PR11MB5276502A0844AD64D761B9DA8C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52765D0E2B4A39CA857900ED8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b27918af-dfb8-4ec1-8d54-3fe5919ba0ed@linux.intel.com>
In-Reply-To: <b27918af-dfb8-4ec1-8d54-3fe5919ba0ed@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8372:EE_
x-ms-office365-filtering-correlation-id: 15c764a9-c762-4f81-e32a-08de53f9d4b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MTVXZE9xdHdrYlRyMnVCbmp6YytndTV0S1FYZnNvNXN0dVovdkliVVdpbWNN?=
 =?utf-8?B?VTl1MS9iemNhaWRLMzJwMDVwbEVsd1lFcEIxWkp2WjhvcEdyT3BJRHBBcVU2?=
 =?utf-8?B?cUgrcjdraXQxWHpvTWJPL245cjBmUEV1ZWl0S2U3T2xOL3RxZEhKZUVoNTZo?=
 =?utf-8?B?M0UrUmhnbDlRMnNKWERaY3FadEQzbVhJU0NmcjFzdyttRGd0QWRqeWZoUXI3?=
 =?utf-8?B?WEo4b1JNd2xOSVdlUm9kNW4wN2MzWm1JRXhYeTRzTEZyV1Q2RUFrbThkaSt2?=
 =?utf-8?B?OEZmdkx5T3JQVi9FOG9qaFY3T0liV1d3aGJFeWJiVVgxanYxREZYTHJON3ZC?=
 =?utf-8?B?VGFhUm5NSE1XRWVPOHlHbE82WGJoQWdBWjhSelhSVFVNeGVGbUt1N25iVUk0?=
 =?utf-8?B?TDI0Tk5lUDgraWpzMWhGWTRZRmtnSHhhT29XTGt5RkZQZHBWamVGTEVoZVJK?=
 =?utf-8?B?VWhsMWEwZkp0VjM4dXhjMmxDRUVXT3VyQk5BN3BZTGEyN2lZVWl0VkJMRDlk?=
 =?utf-8?B?TVhCZUN1RVh0MWRPczJqdHA2R3ovUTdnM3pETXorcW4yUFNUWG4wNXVtNXYy?=
 =?utf-8?B?cm12TUJwQXpjY3o3NEU0WEtyRFBkSTBqdSt6OFJlTkJQQnN3OGFoSjdZOVdh?=
 =?utf-8?B?YXJsUkRUYkh1TkJycWtyR0VKRTVJNHczZjZoRnU3L1BiYnF0RktoTFZOWGth?=
 =?utf-8?B?cFdyWWR5cUxMN2ZDb1lIeTBiU3NXaVlvUDhhbHNKeFdRb1BaSEpQaFhMeHpC?=
 =?utf-8?B?TGJVWnVZQ1pWS0xuZE4vbDRycWExL0ZBZFFyaEk4S0Z0amgvLzROYXVtMGM5?=
 =?utf-8?B?c3N6VjR3ZEFqR1BzaUo4MjhGT2htVEZZbWpKRXBSZHN0UG5oWmRjZi9hdHZW?=
 =?utf-8?B?R1c0dnhxWStLNjBsRlNtQ1VUOFoxeHl5ai9pbUcrODRaZ3hrclI4WUVtMnJt?=
 =?utf-8?B?eklOWUpkL3NhRlB6RUZzanRnYUdXcHpTQ25WSWl3U2psYkpWalVGUE94enI0?=
 =?utf-8?B?MEhMMGJmcjhOdWZWRkJ3K25ZWFBxekkxWTM5OVozVzdCZzdlMUcrdllBYUYx?=
 =?utf-8?B?R25Uc2JHVXozV01tOE5XaGIxR2pwVk9keEFZSmd4TUs5ZmZhVmpVOG04am1Q?=
 =?utf-8?B?NHI4UXNpaTNoNnhxbllHaU9ST214Q3FsTnhHWSt5L3d1K0JyNWlnSXBBTEJu?=
 =?utf-8?B?QnZtUlI4Q0dlYUE2NTVPRjY2Vy9lTExBMy9aNE1uSThqTk5sR3BFN3NzblYw?=
 =?utf-8?B?ZjhLWkxFRjNLZHdBdXQvbTFWRVQ1ZitKa2twOTZTamJTRm1LOGVJOUJpNzE5?=
 =?utf-8?B?VmQwRG5ES0EwTTIxT2JqOGpLZW1zL3Z3SENnQjc1WEtOenZvNUVBT3hLa05C?=
 =?utf-8?B?SUlPZ2hFUzFmOFk3RVliSGttSnd3K1dkUS9vdi95MHJteTN1MWxnc3d6OURu?=
 =?utf-8?B?bVM5S3BwNDJLdktuVDhCdUJaaVVvZ0tMcGgzTWNHNXVWdzdkT1RnU1RBUzlz?=
 =?utf-8?B?U2JqRFIwaXBOQnRzWFV0ckJzSVFYQVJBTW1UUlV1RXVxVk9Vbkg0ZkY1KzY4?=
 =?utf-8?B?M1Q0eGQ2RkJ4Sk4vQmVwdm1UUXlJYWZrNGpaKzBkb09EclJ6ZzdaL1FlK1pk?=
 =?utf-8?B?a1Q3R0FkQWZOajg2MzJoVk4zOTQyNzFiSkZLMUp3M1AxbWtEV2FINVFKQVlC?=
 =?utf-8?B?YnJHY1VCVUJjSE43Y0JMS0kxZGsybGZlRFVyRnpvdkhURStUS0hxbEFSSklK?=
 =?utf-8?B?K2MvNTFPdSs4VFJuN0tuU0xGd2g2Zk4yZjV2bSs4bXpLRzBPVlpCMWdoeDJX?=
 =?utf-8?B?bm9NQmFBeXgwdytxTWlDWUpoZVpNWXgxYXJCajF5ZkJLdXJUbzhzaU9vK1FQ?=
 =?utf-8?B?NWIza2JuWWI4bGRIbWYyWkVPSnE3emxBVUhxMTV3RXVaSlRuRlJrbWNvUWlR?=
 =?utf-8?B?dVF3RDF6SUxKZnlVZm1LWmNxNTVhWFpEMmhKTUwyaUZVL1FqSG1KTXFWSnh5?=
 =?utf-8?B?azVUanN6WklxZC90VTZmNXlVckNsR1pac0s2SkJsdGgvdU51Vyt2NlVPQVJr?=
 =?utf-8?B?ZzNkMkdna1pxcENIQ3QzamxnUXc2dzE0eXFORVBqbkwrd1g4elBHcEpwYnBa?=
 =?utf-8?B?dDBRaWN5MHcxcFRWTGtMUjZZYm5jMHgvTGFwU3hZc0tjTVZRdE5lZzZNTmpr?=
 =?utf-8?Q?O3Nv7FIMjiAXbNj0E8o6u+A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEY0U0lWbFlSNmhzNUI2TnU3RGVSUDN0VmRTblMyTXc4TUEwR05yZXMxTWVW?=
 =?utf-8?B?ang3ZmN3ZVhHR1JHdFZCY0xnV2xxamNaWE1neUdWSGdvcEJYdzVTbEpHQTZj?=
 =?utf-8?B?N0h0TVovOWJjQzM2WURWbU5UQ0w0TWsreXlxYmlHSVpkc3VPSTBSWG1FWWlC?=
 =?utf-8?B?eEg1c0RFdzZIdjJkaDlvamlPcmNVYjZqRVV2cFVqYmozRGRzYzdLMEIrVVBt?=
 =?utf-8?B?VnZRc2tLVGVqQVc1NURxUWZwN3N6cXB1d3FqL3J1U1BlZGdkYW9XZW5ZTW1S?=
 =?utf-8?B?L29Mbk11dXFyRVJQeXlRYjZSMkNXejlqN1Z5a0VPN2xWdFE2NEU3dk9iZXNE?=
 =?utf-8?B?NjhmNmJjejFEZEYrOGZjL2RhYUpSK2NiS2l6QzdMSktGL2gzZ201NStJbitT?=
 =?utf-8?B?M01NZVF6ZjlselIxWWx0R3g5M244VTg5Y3RaeTEwZGsxSWx6cll1QlV3T1RK?=
 =?utf-8?B?QW5lUldCakFVU0JzMTBlL1NONkdwSWlzSGptdXgyK1hpZTZzV1laTGRvZC9y?=
 =?utf-8?B?SGtmSS9Mdm1vRSs3Wkgra1JiOHcrY3Eyd21GNTlRaHRPbkVQYVBOOW9ETkh5?=
 =?utf-8?B?aFR5Uk9zd2puWFgweGpiaGNFMVd2YUZ0TUdJRUtVY3dkQk9GT3FabjlWMzhn?=
 =?utf-8?B?WjNQTEhGZkI2bE5aanNzalVEa254Zk56bmFUOE1PRDRJQndKZXJ6ZENtVlBH?=
 =?utf-8?B?RGszSmxiVUJLT0EyMG8zV3czYlRNNThYZEJkaGQwemhCUC9heUJ4c2dMenUv?=
 =?utf-8?B?dXloYUd3elhEQVhVeG1GVDhqRDlDMWo1cVo3Zk9HK0JqMXFzT3Y1M0pCVmJa?=
 =?utf-8?B?ekppVFgxaUorNlo4K2pRK3dIOUZCQ2g5MUoySm95Yk9vUGJvaHdCRzFHR1Jv?=
 =?utf-8?B?dGt4dkpicEp4bGlQS1Qyd3R3SWRyNFcxdVN2WmJQNjBMTG9IQWZ6N0pDYjlZ?=
 =?utf-8?B?OG5uMVhtYVFvTVRlQ3ZjalNCK2xYQ3F2YWd0Mm80ZlAyam5vN1BuaWtYU2Rn?=
 =?utf-8?B?MjlRUVhtODlmdUdLaGdmM2luWWVLSy9UODRPdVpwWEp1Z3VxcksxaHBFOWlp?=
 =?utf-8?B?MTZ6YllzdUVLWUVDdkFOZEp1emg5T0JmNmd2WTZqaGl6U1FHRzJHUzVicXRM?=
 =?utf-8?B?cnAvcERsOWIveGtTRFNxYUdxS0wrcy9mM2pHT3FQeTJyMno4bEhhNks3NHFX?=
 =?utf-8?B?SUhTQmtVWlI0b2dXSTdZWDFYcmdiTDYrVUpYZDkwMlpNMHhvT2R3S0dEWHpn?=
 =?utf-8?B?QUY4WTdVS29acE91YnB5ZGVrMjlCRkNJWHliVTFjd3k1WDVuTldqVEo1WE9k?=
 =?utf-8?B?VE45SDlERURGSjRnWFBlZEkrL3Y5N3dOU1hhMjRYSkRZTkhtbVdmSFY2ekpL?=
 =?utf-8?B?MW1VcXFhUytTS3UxdWZKZ1FCbkREMUo5V1RqZmkrVmxrRUczUzB4eWlVZnVC?=
 =?utf-8?B?eVVmdjNXZXVpWnRIK1RNUWM1K04zeU5mM2Yvc1R1SkIzNm45UHcrT3ZkWGM3?=
 =?utf-8?B?MzhUZWNQWDltMHBUajlxNFJCYXRURHNUYSt6RURERmVCUURMamFJcmtaNVJz?=
 =?utf-8?B?SGxFVWRqamh6d0tBdmpqN09ZdWNPbXg3elRGbVAySXRWeWFYS3pPT2JsbzMx?=
 =?utf-8?B?OUgvVmNKOFVzVUwzRDY0Ukw2WWUrT05xWHVOQmo5WmtncXZ4Ulo1SWRqdmZ2?=
 =?utf-8?B?cXZ4b3NwZkczOWl0OGNDa0J3NDY2KzM2YVJQVGZSbWsyNXBMc0pWUVc4Q3Vy?=
 =?utf-8?B?S2FLdU9id2tXRXBiUElNc3N3SGJKYTNodHY5bStKbzFMNXp3dUV6Y1dKTU9V?=
 =?utf-8?B?TkpGTUs5QjQ3bHMyOVIwdFAzNFdVWXVYdHpka0JNNytyY3JVRjdRVG1uZFN4?=
 =?utf-8?B?K3VXV1VhOEVvb0FhamtSV0NzYk1PREdlckt5UnlFaHBmOWt5Q3BxRHBieHBx?=
 =?utf-8?B?dkZ1djdyOW9qQld5VTBJM0tFL2FkcWRMazVGVFdvcWxNdDFkRHpGVExPeU9M?=
 =?utf-8?B?U1V3WHNIdis1VkFpdms0a1FrVG1GOVJQN1NXT3pTdmFsaG1TaWwxWEpKQmp0?=
 =?utf-8?B?UlNRb3VSc0V1WHQ1NWdrVTVaQStGZjNjQmNMbzB2a0k4ZkJraVZjYzI0dU9O?=
 =?utf-8?B?WHNsbjkyMCsxUytPazFKNFd5MTNRNVhCeVM0Q0lvODRaSVh1T3NSZi8zK1pO?=
 =?utf-8?B?QlNDN1RlZGJnSVNGazF3cy8zTFVwUDJUbHV4NUNTWWZmdDdmZEtNZUY2d3Fz?=
 =?utf-8?B?bXJWNHBoaUFpU0EzZ1JUS0JSc1RMUmxLZzVJUFpoUmhOWGxsYlBzcjNMQlEw?=
 =?utf-8?B?ajVhRHR6a29wTmJrRi92MVF4cEpMV2M2YjlsKzZrSGNQbE4zVUUxdz09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c764a9-c762-4f81-e32a-08de53f9d4b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 05:49:21.3731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36sYHO9NlAI87G7Pe3ARvO2lXcPjRSGHkOE6KM6LjFjiBkaV01i9V3DC5gKEL6t7iBATmOZcXXiM8QfRquR+Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8372
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEphbnVhcnkgMTQsIDIwMjYgNDoyNyBQTQ0KPiANCj4gT24gMS8xNC8yNiAxNTozMiwg
VGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5p
bnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTMsIDIwMjYgMTE6MDEgQU0N
Cj4gPj4NCj4gPj4gVGhlIEludGVsIFZULWQgU2NhbGFibGUgTW9kZSBQQVNJRCB0YWJsZSBlbnRy
eSBjb25zaXN0cyBvZiA1MTIgYml0cyAoNjQNCj4gPj4gYnl0ZXMpLiBXaGVuIHRlYXJpbmcgZG93
biBhbiBlbnRyeSwgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gemVyb3MNCj4gdGhlDQo+ID4+
IGVudGlyZSA2NC1ieXRlIHN0cnVjdHVyZSBpbW1lZGlhdGVseS4NCj4gPj4NCj4gPj4gSG93ZXZl
ciwgdGhlIElPTU1VIGhhcmR3YXJlIG1heSBmZXRjaCB0aGVzZSA2NCBieXRlcyB1c2luZyBtdWx0
aXBsZQ0KPiA+PiBpbnRlcm5hbCB0cmFuc2FjdGlvbnMgKGUuZy4sIGZvdXIgMTI4LWJpdCBidXJz
dHMpLiBJZiBhIGhhcmR3YXJlIGZldGNoDQo+ID4+IG9jY3VycyBzaW11bHRhbmVvdXNseSB3aXRo
IHRoZSBDUFUgemVyb2luZyB0aGUgZW50cnksIHRoZSBoYXJkd2FyZQ0KPiBjb3VsZA0KPiA+PiBv
YnNlcnZlIGEgInRvcm4iIGVudHJ5IOKAlCB3aGVyZSBzb21lIGNodW5rcyBhcmUgemVyb2VkIGFu
ZCBvdGhlcnMgc3RpbGwNCj4gPj4gY29udGFpbiBvbGQgZGF0YSDigJQgbGVhZGluZyB0byB1bnBy
ZWRpY3RhYmxlIGJlaGF2aW9yIG9yIHNwdXJpb3VzIGZhdWx0cy4NCj4gPj4NCj4gPj4gRm9sbG93
IHRoZSAiR3VpZGFuY2UgdG8gU29mdHdhcmUgZm9yIEludmFsaWRhdGlvbnMiIGluIHRoZSBWVC1k
IHNwZWMNCj4gPj4gKFNlY3Rpb24gNi41LjMuMykgYnkgaW1wbGVtZW50aW5nIGEgcHJvcGVyIG93
bmVyc2hpcCBoYW5kc2hha2U6DQo+ID4+DQo+ID4+IDEuIENsZWFyIG9ubHkgdGhlICdQcmVzZW50
JyAoUCkgYml0IG9mIHRoZSBQQVNJRCBlbnRyeS4gVGhpcyB0ZWxscyB0aGUNCj4gPj4gICAgIGhh
cmR3YXJlIHRoYXQgdGhlIGVudHJ5IGlzIG5vIGxvbmdlciB2YWxpZC4NCj4gPj4gMi4gRXhlY3V0
ZSB0aGUgcmVxdWlyZWQgaW52YWxpZGF0aW9uIHNlcXVlbmNlIChQQVNJRCBjYWNoZSwgSU9UTEIs
IGFuZA0KPiA+PiAgICAgRGV2aWNlLVRMQiBmbHVzaCkgdG8gZW5zdXJlIHRoZSBoYXJkd2FyZSBo
YXMgcmVsZWFzZWQgYWxsIGNhY2hlZA0KPiA+PiAgICAgcmVmZXJlbmNlcyB0byB0aGUgZW50cnku
DQo+ID4+IDMuIE9ubHkgYWZ0ZXIgdGhlIGZsdXNoZXMgYXJlIGNvbXBsZXRlLCB6ZXJvIG91dCB0
aGUgcmVtYWluaW5nIGZpZWxkcyBvZg0KPiA+PiAgICAgdGhlIFBBU0lEIGVudHJ5Lg0KPiA+Pg0K
PiA+PiBBZGRpdGlvbmFsbHksIGFkZCBhbiBleHBsaWNpdCBjbGZsdXNoIGluIGludGVsX3Bhc2lk
X2NsZWFyX2VudHJ5KCkgdG8NCj4gPj4gZW5zdXJlIHRoYXQgdGhlIGNsZWFyZWQgZW50cnkgaXMg
dmlzaWJsZSB0byB0aGUgSU9NTVUgb24gc3lzdGVtcyB3aGVyZQ0KPiA+PiBtZW1vcnkgY29oZXJl
bmN5IChlY2FwX2NvaGVyZW50KSBpcyBub3Qgc3VwcG9ydGVkLg0KPiA+Pg0KPiA+DQo+ID4gYmV0
dGVyIHNwbGl0IHRoZSBjbGZsdXNoIHBhcnQgaW50byBhIHNlcGFyYXRlIHBhdGNoDQo+IA0KPiBB
aCwgdGhlIGNvbW1pdCBtZXNzYWdlIGlzIGEgYml0IGNvbmZ1c2luZy4gUHJldmlvdXNseSwNCj4g
aW50ZWxfcGFzaWRfY2xlYXJfZW50cnkoKSB3YXMgZm9sbG93ZWQgYnkgYSBjbGZsdXNoLiBOb3cg
dGhhdCB3ZSd2ZQ0KPiBtb3ZlZCB0aGUgY2xlYXJpbmcgbG9naWMgYWZ0ZXIgdGhlIGNhY2hlIGlu
dmFsaWRhdGlvbiwgYW4gZXhwbGljaXQNCj4gY2xmbHVzaCBpcyByZXF1aXJlZC4gSW5zdGVhZCBv
ZiBzcGxpdHRpbmcgdGhpcyBpbnRvIGEgc2VwYXJhdGUgcGF0Y2gsDQo+IGhvdyBhYm91dCBhbWVu
ZGluZyB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gbWFrZSB0aGlzIGNsZWFyLg0KPiANCj4gT3IsIGtl
ZXAgaW50ZWxfcGFzaWRfY2xlYXJfZW50cnkoKSB1bnRvdWNoZWQgbGlrZSB0aGUgZm9sbG93aW5n
Og0KDQpsZXQncyBnbyB0aGlzIHdheSB0byBoYXZlIHR3byBwbGFjZXMgY29uc2lzdGVudC4NCg0K
PiANCj4gaW9tbXUvdnQtZDogQ2xlYXIgUHJlc2VudCBiaXQgYmVmb3JlIHRlYXJpbmcgZG93biBQ
QVNJRCBlbnRyeQ0KPiANCj4gVGhlIEludGVsIFZULWQgU2NhbGFibGUgTW9kZSBQQVNJRCB0YWJs
ZSBlbnRyeSBjb25zaXN0cyBvZiA1MTIgYml0cyAoNjQNCj4gYnl0ZXMpLiBXaGVuIHRlYXJpbmcg
ZG93biBhbiBlbnRyeSwgdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gemVyb3MgdGhlDQo+IGVu
dGlyZSA2NC1ieXRlIHN0cnVjdHVyZSBpbW1lZGlhdGVseS4NCj4gDQo+IEhvd2V2ZXIsIHRoZSBJ
T01NVSBoYXJkd2FyZSBtYXkgZmV0Y2ggdGhlc2UgNjQgYnl0ZXMgdXNpbmcgbXVsdGlwbGUNCj4g
aW50ZXJuYWwgdHJhbnNhY3Rpb25zIChlLmcuLCBmb3VyIDEyOC1iaXQgYnVyc3RzKS4gSWYgYSBo
YXJkd2FyZSBmZXRjaA0KPiBvY2N1cnMgc2ltdWx0YW5lb3VzbHkgd2l0aCB0aGUgQ1BVIHplcm9p
bmcgdGhlIGVudHJ5LCB0aGUgaGFyZHdhcmUgY291bGQNCj4gb2JzZXJ2ZSBhICJ0b3JuIiBlbnRy
eSDigJQgd2hlcmUgc29tZSBjaHVua3MgYXJlIHplcm9lZCBhbmQgb3RoZXJzIHN0aWxsDQo+IGNv
bnRhaW4gb2xkIGRhdGEg4oCUIGxlYWRpbmcgdG8gdW5wcmVkaWN0YWJsZSBiZWhhdmlvciBvciBz
cHVyaW91cyBmYXVsdHMuDQo+IA0KPiBGb2xsb3cgdGhlICJHdWlkYW5jZSB0byBTb2Z0d2FyZSBm
b3IgSW52YWxpZGF0aW9ucyIgaW4gdGhlIFZULWQgc3BlYw0KPiAoU2VjdGlvbiA2LjUuMy4zKSBi
eSBpbXBsZW1lbnRpbmcgYSBwcm9wZXIgb3duZXJzaGlwIGhhbmRzaGFrZToNCj4gDQo+IDEuIENs
ZWFyIG9ubHkgdGhlICdQcmVzZW50JyAoUCkgYml0IG9mIHRoZSBQQVNJRCBlbnRyeS4gVGhpcyB0
ZWxscyB0aGUNCj4gICAgIGhhcmR3YXJlIHRoYXQgdGhlIGVudHJ5IGlzIG5vIGxvbmdlciB2YWxp
ZC4NCj4gMi4gRXhlY3V0ZSB0aGUgcmVxdWlyZWQgaW52YWxpZGF0aW9uIHNlcXVlbmNlIChQQVNJ
RCBjYWNoZSwgSU9UTEIsIGFuZA0KPiAgICAgRGV2aWNlLVRMQiBmbHVzaCkgdG8gZW5zdXJlIHRo
ZSBoYXJkd2FyZSBoYXMgcmVsZWFzZWQgYWxsIGNhY2hlZA0KPiAgICAgcmVmZXJlbmNlcyB0byB0
aGUgZW50cnkuDQo+IDMuIE9ubHkgYWZ0ZXIgdGhlIGZsdXNoZXMgYXJlIGNvbXBsZXRlLCB6ZXJv
IG91dCB0aGUgcmVtYWluaW5nIGZpZWxkcyBvZg0KPiAgICAgdGhlIFBBU0lEIGVudHJ5Lg0KPiAN
Cj4gRml4ZXM6IDBiYmViMDFhNGZhZiAoImlvbW11L3Z0LWQ6IE1hbmFnZSBzY2FsYWxibGUgbW9k
ZSBQQVNJRCB0YWJsZXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmggfCAx
MiArKysrKysrKysrKysNCj4gICBkcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMgfCAgNiArKysr
Ky0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmggYi9kcml2ZXJz
L2lvbW11L2ludGVsL3Bhc2lkLmgNCj4gaW5kZXggYjRjODUyNDJkYzc5Li4zNWRlMWQ3NzM1NWYg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvcGFzaWQuaA0KPiArKysgYi9kcml2
ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmgNCj4gQEAgLTIzNyw2ICsyMzcsMTggQEAgc3RhdGljIGlu
bGluZSB2b2lkIHBhc2lkX3NldF9wcmVzZW50KHN0cnVjdA0KPiBwYXNpZF9lbnRyeSAqcGUpDQo+
ICAgCXBhc2lkX3NldF9iaXRzKCZwZS0+dmFsWzBdLCAxIDw8IDAsIDEpOw0KPiAgIH0NCj4gDQo+
ICsvKg0KPiArICogQ2xlYXIgdGhlIFByZXNlbnQgKFApIGJpdCAoYml0IDApIG9mIGEgc2NhbGFi
bGUtbW9kZSBQQVNJRCB0YWJsZSBlbnRyeS4NCj4gKyAqIFRoaXMgaW5pdGlhdGVzIHRoZSB0cmFu
c2l0aW9uIG9mIHRoZSBlbnRyeSdzIG93bmVyc2hpcCBmcm9tIGhhcmR3YXJlDQo+ICsgKiB0byBz
b2Z0d2FyZS4gVGhlIGNhbGxlciBpcyByZXNwb25zaWJsZSBmb3IgZnVsZmlsbGluZyB0aGUgaW52
YWxpZGF0aW9uDQo+ICsgKiBoYW5kc2hha2UgcmVjb21tZW5kZWQgYnkgdGhlIFZULWQgc3BlYywg
U2VjdGlvbiA2LjUuMy4zIChHdWlkYW5jZSB0bw0KPiArICogU29mdHdhcmUgZm9yIEludmFsaWRh
dGlvbnMpLg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgcGFzaWRfY2xlYXJfcHJlc2Vu
dChzdHJ1Y3QgcGFzaWRfZW50cnkgKnBlKQ0KPiArew0KPiArCXBhc2lkX3NldF9iaXRzKCZwZS0+
dmFsWzBdLCAxIDw8IDAsIDApOw0KPiArfQ0KPiArDQo+ICAgLyoNCj4gICAgKiBTZXR1cCBQYWdl
IFdhbGsgU25vb3AgYml0IChCaXQgODcpIG9mIGEgc2NhbGFibGUgbW9kZSBQQVNJRA0KPiAgICAq
IGVudHJ5Lg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jIGIvZHJp
dmVycy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+IGluZGV4IDI5OGEzOTE4Mzk5Ni4uM2E4ZWM1ZWJh
ODNlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL3Bhc2lkLmMNCj4gKysrIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC9wYXNpZC5jDQo+IEBAIC0yNzIsNyArMjcyLDcgQEAgdm9pZCBp
bnRlbF9wYXNpZF90ZWFyX2Rvd25fZW50cnkoc3RydWN0DQo+IGludGVsX2lvbW11DQo+ICppb21t
dSwgc3RydWN0IGRldmljZSAqZGV2LA0KPiANCj4gICAJZGlkID0gcGFzaWRfZ2V0X2RvbWFpbl9p
ZChwdGUpOw0KPiAgIAlwZ3R0ID0gcGFzaWRfcHRlX2dldF9wZ3R0KHB0ZSk7DQo+IC0JaW50ZWxf
cGFzaWRfY2xlYXJfZW50cnkoZGV2LCBwYXNpZCwgZmF1bHRfaWdub3JlKTsNCj4gKwlwYXNpZF9j
bGVhcl9wcmVzZW50KHB0ZSk7DQo+ICAgCXNwaW5fdW5sb2NrKCZpb21tdS0+bG9jayk7DQo+IA0K
PiAgIAlpZiAoIWVjYXBfY29oZXJlbnQoaW9tbXUtPmVjYXApKQ0KPiBAQCAtMjg2LDYgKzI4Niwx
MCBAQCB2b2lkIGludGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShzdHJ1Y3QNCj4gaW50ZWxfaW9t
bXUNCj4gKmlvbW11LCBzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAgCQlpb21tdS0+Zmx1c2guZmx1
c2hfaW90bGIoaW9tbXUsIGRpZCwgMCwgMCwNCj4gRE1BX1RMQl9EU0lfRkxVU0gpOw0KPiANCj4g
ICAJZGV2dGxiX2ludmFsaWRhdGlvbl93aXRoX3Bhc2lkKGlvbW11LCBkZXYsIHBhc2lkKTsNCj4g
KwlpbnRlbF9wYXNpZF9jbGVhcl9lbnRyeShkZXYsIHBhc2lkLCBmYXVsdF9pZ25vcmUpOw0KPiAr
CWlmICghZWNhcF9jb2hlcmVudChpb21tdS0+ZWNhcCkpDQo+ICsJCWNsZmx1c2hfY2FjaGVfcmFu
Z2UocHRlLCBzaXplb2YoKnB0ZSkpOw0KPiArDQo+ICAgCWlmICghZmF1bHRfaWdub3JlKQ0KPiAg
IAkJaW50ZWxfaW9tbXVfZHJhaW5fcGFzaWRfcHJxKGRldiwgcGFzaWQpOw0KPiAgIH0NCj4gLS0N
Cj4gMi40My4wDQo+IA0KPiBUaGFua3MsDQo+IGJhb2x1DQo=
