Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E8E14D439
	for <iommu@lists.linux.dev>; Wed, 18 Dec 2024 05:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734499374; cv=fail; b=kIiHH5t0PHt0E62wmP0H1OVRAhHi4lD2FLXOePu6rSElziTB4bxdy7t6R4E7lefYVCwVgeMK6scZHNeDK2DyVjgMYOYumfE9QJccAse5B/b6CqxDCB3vrJOt0o9K3cqcgNqu0D8GOu3uMgbqnbgQoDjWmhlKrHGqTZQOE9cze1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734499374; c=relaxed/simple;
	bh=NE2bjtT7q899d49LfvaV0jNVub2QFdbVvx8dudTiEYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eowo5RzRr/QbhyhQNvbA6FSZeUXE5RwQLvfEA7QAxekHtAutd1IzE9k1nUU+djRHYyp9lCqU0DDQc8u8EcVQQvXymdR6r5IKUZXRyInXPOBZPX2nyomaG0XexRnB7PSIUfGOvTvLuAvyYJW2ZbtGcM7s6IWFVLjq+HRdgRV3ULk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNKKnzC4; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNKKnzC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734499373; x=1766035373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NE2bjtT7q899d49LfvaV0jNVub2QFdbVvx8dudTiEYk=;
  b=BNKKnzC4eqTt/95J7yX5n0oscRMtLwYzowiQL7Z8jPRt1+tB+twqGQ14
   M9wdegQYE5VIK/0nWLAgRn3b7pUWP/yKJNY73yJbGxF0q3H6jGhJ+t/cq
   xzhwmsJNRE/pEStBZvYMivXQPQAE+le5gLupbu/qpt5IdiLoFyGJTdQkj
   x7i9znjHcBw9ttbLIlNG4fPQg3cI7Qmj0pTCmVVAG0t55uCJ7P0md2dk5
   LZCDrsCmxQlRIZw1hxloCCf5vkVqjphVKOuZYHiXtCL5EnEBjjZQmgfg8
   OcVKCA+o4E7hhJKKtqieKOnI41jKlMIq1QkpkmXu7zKS8vD4BTETwMtCq
   w==;
X-CSE-ConnectionGUID: uabUUu/hQfe6X+olnLzWjA==
X-CSE-MsgGUID: lKHM0X47Ro6uxjNgZWocgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="52364755"
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="52364755"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 21:22:52 -0800
X-CSE-ConnectionGUID: Wv4R8lOKQoWNNcJGiR9NeQ==
X-CSE-MsgGUID: Ph7j43aZRX+2shJcHx/vNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="98329234"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 21:22:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 21:22:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 21:22:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 21:22:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrTb4Z/NCBcbzkJ5+u3H/MwBx82Z+H24+UoM7sABAUD6KbZVKjaDdE/rHXVs/1y2zxeSmGVwd1yqsZk/RCUHBYRe8a9d9EZAL/AeS7OCDHu8csvRxDnY0cdLlXsW/jwM/iNRVu4RSu19Yd60hCyDe0sn2FuzwCX41xzPZ4PxsBDcUv/OZaCUSYuhHw8OP/lY3uthSO5pzLueC0jqZHVNlL4SKFoxg9sskwj7/1kaQ3xq2er7Qhmru9dS1HbFqPuru+l629MVqt6TC3S2n8Nn0p4307oXQumRmbDmz5ADGinV3m85wN9qy2tftRh7waDyYoQK6jMq+cDRijKzOe1XHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NE2bjtT7q899d49LfvaV0jNVub2QFdbVvx8dudTiEYk=;
 b=P9iu6qUrU725uP+rifiOSRgaMzCee3obwDSWq5nVDKrRtrFZzEBmstyeska74F6IoGgGa46TzK9VxUPXkIC6Ii9QiwMxTwaAS+tuKOurECAWc9zc09e3Ept1uk12h+ZS6oPhDrfK0wnXSY+dtM38uNFYn0GNxD5sFiXvxiDPy8UCE7aHG4B1VETJpTCHKaIXJ2lvsc54sLSQqV4KZKzk03AgFnMvNvpwIKdcBZs5xr8aTS6MWV27Q4o2U6XVh4/+b/cBRIcl/yqW21abnBKq8twoobc+TjPdh0EJHrmknzXyQxajzu+vcP3WI+4OY257IE8A1YhhNq5uHkeTb6fT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Wed, 18 Dec
 2024 05:22:48 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 05:22:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
Thread-Topic: [PATCH] iommu/vt-d: Link cache tags of same iommu unit together
Thread-Index: AQHbT2xqZZ8n3WRerEuUJDS85GVzRLLrVXWAgAAj+TA=
Date: Wed, 18 Dec 2024 05:22:47 +0000
Message-ID: <SJ0PR11MB6744DB1AE24115FD44B390B492052@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241216033809.170366-1-zhenzhong.duan@intel.com>
 <897738ba-5c1f-4d42-bf10-402d59e3f430@linux.intel.com>
In-Reply-To: <897738ba-5c1f-4d42-bf10-402d59e3f430@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW5PR11MB5762:EE_
x-ms-office365-filtering-correlation-id: 626d2138-b687-49e8-ac17-08dd1f240297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bFp0UWlzWnZpaWpmR0paUG1mM2dTZEtjcnBVS1I2U2c5NjJxTUQrVGtMNWFm?=
 =?utf-8?B?NlFNWTA0b1l5VkNyUXBZcjA2SVhXblR6eVhid1ZrRFo4RFFPWmFDa2Y4Si91?=
 =?utf-8?B?dmtzTC9wZERJMEx3MzB3L3hHVi9YTlJUUzBoOGJSMjlwd2NFUjRuSWZFbDNr?=
 =?utf-8?B?KzhEUWhLY0M4ZGNGSlJOOXFua1NJcGNaZ1VXUzFkUWZBTmN4UG1uc09kMldt?=
 =?utf-8?B?YXhJUkdvZnRheGZ1WVN2K0dHQ2VITEFtRFRzaUJqcU9ud2NkZSt6RTI5bVZZ?=
 =?utf-8?B?VUFFY3RpV0h1Vzg4Q2tJNjBFc25CVTI3VjBxYU5iSGdTWTFOandOZVBXaFpu?=
 =?utf-8?B?TGFUcFcvNUpSZHc4Ung4dnNVeVRyNGoyN1BwYThEc21nT0pkTzhmV0VKRkZC?=
 =?utf-8?B?Ymw4eXo2WGVEbXNQa0VZRjloMjhMYmh5MGlLTlljR3dPS09tQUwzdEd6ejBi?=
 =?utf-8?B?TXA4bTgzQWIyWFJMSkEzWXFLRkFGeWw1WEhJR21tay9iQ2ZsbmtYblpxNlZH?=
 =?utf-8?B?NE5aM2MwQnJQcXROa1JTVzRqcEtpbmR1MUo5ci9heWRNWjRLY0RBVU51aERp?=
 =?utf-8?B?Ym9xTFQxYWdvSkhXNmRlcW5sMFp2RDM0REhOTldQUHVSYmp3SmFONC92cnF0?=
 =?utf-8?B?TXJZZzhER3lZYTlFTDN5YmNTYktCLzAyZVNMSEJLWFNzYTNUNURFUGZBOUs0?=
 =?utf-8?B?ZXpXb1FuT2JGcXFtSHM0SkFoUEFsVjcxMVNiL3UwaTJwVTQ5VUpheG5pcE1q?=
 =?utf-8?B?M1NrR3JUc0tVbnRHSjdKZHpSZHFGWER0RGp4VURCanpFbVdWQVlHQnM1c3l6?=
 =?utf-8?B?NTk0ekxja2x0VUFlN1JhY3JLeG9HU3gwVmNBYVdWL3pYb0tlZkZFck4zczNl?=
 =?utf-8?B?MDVTWkxGTEJuZDVWT0lFa1JQZ0d2N3ZvbjdTeW9NUEI1Yk04OW9obUpMN1NC?=
 =?utf-8?B?Q0Y2ODQxL0hQeW9iTmZMdWhieXhGbEpQYTlSQVNMaitwVVNlRUxZbk92SG8y?=
 =?utf-8?B?K3luZEViNmVRQjR3TkMvcGdDVDVYUkhid3NVN09zTXNQTmF5R1RxK0pjNm9O?=
 =?utf-8?B?N2hDcmk4MHBBbkZ2N1h4TDVYNGllT1M4d1IyQm9iRFVUS2IvRUllSmphSWJZ?=
 =?utf-8?B?NzdCMTR4ZnZ2aHNHOXYxVWRURFRLdFJ6Q2F5Q0NqTFg1ZnZDemdKV1pIQTNN?=
 =?utf-8?B?OUF5dDFMK3A5TUpmSHJudXZZeCtlSnh4S2pBVVVYTEJ5T2VzL1J0MU14eS8v?=
 =?utf-8?B?M1pzVlkvZ2hSbnNrWitHbUx5d3B2NlQ3S1N2VDdXSm96TytmSzY5dWVSSVZZ?=
 =?utf-8?B?NFdEeDJzTnI0WS9TZWhyNVVyOXdzMkxpS0VLbXNvVFRyU2lla0R2TVZNZk1C?=
 =?utf-8?B?cVdyRmF6WjNKUVdVNGxRSHByTXZHOHNVeWtVMlQ2MW9RTlljTVBDQzNjUkc5?=
 =?utf-8?B?YVhoK1ZlZXVUdEpyWkJRYXc5K3JmbmVENmNEOFVyblVOSDNTcDluNTN3YzJP?=
 =?utf-8?B?RFRlcE0rY0g4OWdBSzh6UnZyZWZQSzhlK2pUQmJJMEZ4eFFjTkNYQnpiQUVi?=
 =?utf-8?B?MFJCajRzZXFKTzY4Zm5xVGVDcHl5bDZOd3JKdGVFQ2JzYndEd2JCM29TbUJD?=
 =?utf-8?B?QWllTERSamwxK0lnNjB0c1RvZHFzWHEwcENpRlVLTGhtdGVRR2VMQlhwQkhE?=
 =?utf-8?B?WjB2SWlVQ29RbWptSUYxR2EwSnlGbjJ5dHJZT0xHQlN1NCtVeVB0QmpGSmox?=
 =?utf-8?B?OVlzNVJkQ3RmRUJQM0tkWmlSOEtES1pBMEM4T2ZoYXhUcE96eWcwT0J3V2Y3?=
 =?utf-8?B?eFR0emNUR3gvcUJEd0p1WHVJa1VIWEhlbmplUGs5RXdjZm9GbmtER0g0ZEFv?=
 =?utf-8?B?NUhJT1JKbDd6NUVyQzdjS1NCNzJJR2lmL211VTFpMGt0SmdiRGNDSXBsSWlE?=
 =?utf-8?Q?6dcJoo+qGg99PbUemaUUMIF96ACxZLsF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1M1UmZseXhCdmY2QVB2QUhqM0dSUU50NEs5N1VDMTNmdmtVbEVJNFpzWVFj?=
 =?utf-8?B?UGZSYWZyeDZrRElTMHdhdkh6U1lXRVAybzQ2UU5SaUxqNDlWVzBHNE92TC9Z?=
 =?utf-8?B?TXYvVlNQbGIvMStETmx5NDR2SFZoN1NtUCtoemgzTlVSbmxvMklRc1ZVNFdP?=
 =?utf-8?B?bW0xak5zZmpKcHY1QW9MclVVSTNFYzBERWRBQUF5Y1NSYmpLSjlCY3hPSEE3?=
 =?utf-8?B?OXZlS1NJM1phMUNQemxvWEx2bmJWYzM4K2k3Q0xlN1Nrem1TVGhQZExrdVRo?=
 =?utf-8?B?a3hIYVRyTUU2NEgzTDZSaXlJZjhMK0lidXlSQnRoNTlSdDA0RzNCR1R5TWxG?=
 =?utf-8?B?TC9qUTRMTll4YVIvbkJxOHJPbWF2YlpqRmNRaDhvWTQ5d3AwUllJWjhxUldn?=
 =?utf-8?B?RERpaHExTGUzVUEzL2dlR2tiTi9SSEVRWGtZV3oxbHdPbnREcnBFZmNBcXFW?=
 =?utf-8?B?OXBoaTZJaUFIbEw3S1pHRVBERDA4OUtFMjRmL1ozRUdoSzFxSGVjRU9vMzJ1?=
 =?utf-8?B?V2ZOT2luNkJrS3ljVnYycjUxN0ZYZGQ1L20xU2FMai9oWTBDOXJ1bUxMRmZE?=
 =?utf-8?B?T0pZY3c2Snl6YUM1STBKZmQzNkFYSTcrK3VVL1lUejlER1FUdzZqeVViRVlK?=
 =?utf-8?B?Q0JqNnRQak4xQ1hHK2kyYjdCSTdSem8za3dpYWVCRXJWNkNMTnFIOW9WV0ZH?=
 =?utf-8?B?UWx0VHhoTUdjVDFub1cvQTh3UWxaZzU4MVo2eC90d1JIZThIU2Q4dUkvcE1L?=
 =?utf-8?B?djlGR25DbXMvejlFV08yL2ZjVUJOZzYzNHdnRERjN3Exai9ocy9mb0twV1NN?=
 =?utf-8?B?bloyNmxrc2RLS21lU2RDaW1ZUWV2NWFYV0Y5R0Z5Uk1RY3ZsZStFMG9iYXBp?=
 =?utf-8?B?aE51aVlReDh4TWphdEFDdnk4QTJnQkVKREc2NFgwZG92Q29YRHNDRnRleEJQ?=
 =?utf-8?B?S3RzWUdEbTlCMGtjdTQ4UTF3MXBZS3NYcFZyTk9xdHZzVkVrUWF0cXRqWk5K?=
 =?utf-8?B?aGNhOWJUZFpFZExOUDVheEd0QmNNLzJDa3NUN1dwT0FvUHlVckZBdFgvNkM5?=
 =?utf-8?B?dTBHK3h4MHVqUnRJemltTWhpangzTHlxbG5xL3YwTzNJTy91UTlMZjVBYktX?=
 =?utf-8?B?WmhtbERnOEtGWm15ZVVEL1R5b3dSQ0V0ZkdQaUZzSUl4SDVVSVUvTlN6ODZY?=
 =?utf-8?B?Zm12dTV0OTlVR0VQRjROYXlucDd4ZjJ4bTNkaVY3dDVadm9DNHZRVVNzV2ZC?=
 =?utf-8?B?R0doaXkrLzBzd1NQZjNwVm4ySzBMd2ljam1BdUhuRHdzNXJ5VngvR1JjM2xP?=
 =?utf-8?B?ZlhNaWtyOWFMQVpYaXNxMlN2RVp1Kzk3T3E4S1hXbDlVZWJReUp5aW41MEtB?=
 =?utf-8?B?a3poUkpVTklLeHhGRFZJa2toVGFmRjVuNW5YcUk4U3BJQk12WGk2YXRMcmJv?=
 =?utf-8?B?cEF2NDEwbHFmcHMyZmNadW5ndE8vZ1hwblBwRVZnQUVkaVdZVlFTbkcyWkxZ?=
 =?utf-8?B?R1ErclU3QzNzaC82SmwvTDBPUXJrYW1Kb2tDZHRsMVRTVXpDTjhPcUlpenVE?=
 =?utf-8?B?ZUtFdUNlbmRqL0pmYy9vbzZ4ZEpaNkplYmR4bVlPTzJwRG5XSDV1SEdvbFRD?=
 =?utf-8?B?RzFSLy8zcnBPaDJGZ09LenF0cXFFWUd6RVdCUkZjRjk4emdwdnJlcUprZzh6?=
 =?utf-8?B?aWVIT0Z0Q1hmWHQvdkRTS1hFYi9lLzd3bnFrb0ZTOGZPV3U1cnpIa1lHL0hp?=
 =?utf-8?B?aTUvMG01K0JSMzNFb014VEhKSVJ5eURmb1R3UXJpaFA5WmlGZ2ZBVjJERkpv?=
 =?utf-8?B?TWxHUE9UMXFSOFAreWxSdlZ0cFp6VTJuRUp2eDhaODBVVTJwVVpyQmJ4cTJ1?=
 =?utf-8?B?WEdaRHVsem12ZVJobkxoMlBEVFBUVThtNmxaT3U1NHJOMkRhNGZySWN5alNM?=
 =?utf-8?B?a2E4OXFyMmI2ZUtqQnV5WW9jRFJmMlQrY1NtTmlaaWdpMzNmYXpoc2RqaFBw?=
 =?utf-8?B?VElMUWlXVTFWd0FnT21XdXg2S2dJYk1teGNPNjIrWHMrYVlLYWtRbFo0VSt5?=
 =?utf-8?B?WVFmbDFCRFpPZFdwSHcxZ0VsME04WldSWXRYcW1xcDJWbkdkRWtHREIyU2tI?=
 =?utf-8?Q?/2SKL7uc090gJ1vpeA+xW0d2f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 626d2138-b687-49e8-ac17-08dd1f240297
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 05:22:47.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hrTr53ZGMNgEY8pjHmSKWiPL9K3bcAaU+WmRvCdLCqEGJc/jLmpn8kxr6t9Z6KoImt0FPuGeAzTelOed0BnzCApcOgffvwvvtS+igfSQxO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJhb2x1IEx1IDxiYW9sdS5s
dUBsaW51eC5pbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaW9tbXUvdnQtZDogTGlu
ayBjYWNoZSB0YWdzIG9mIHNhbWUgaW9tbXUgdW5pdCB0b2dldGhlcg0KPg0KPk9uIDEyLzE2LzI0
IDExOjM4LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENhY2hlIHRhZyBpbnZhbGlkYXRpb24g
cmVxdWVzdHMgZm9yIGEgZG9tYWluIGFyZSBhY2N1bXVsYXRlZCB1bnRpbCBhDQo+PiBkaWZmZXJl
bnQgaW9tbXUgdW5pdCBpcyBmb3VuZCB3aGVuIHRyYXZlcnNpbmcgdGhlIGNhY2hlX3RhZ3MgbGlu
a2VkIGxpc3QuDQo+PiBCdXQgY2FjaGUgdGFncyBvZiBzYW1lIGlvbW11IHVuaXQgY2FuIGJlIGRp
c3RyaWJ1dGVkIGluIHRoZSBsaW5rZWQgbGlzdCwNCj4+IHRoaXMgbWFrZSBiYXRjaGVkIGZsdXNo
IGxlc3MgZWZmaWNpZW50LiBFLmcuLCBvbmUgZGV2aWNlIGJhY2tlZCBieSBpb21tdTANCj4+IGlz
IGF0dGFjaGVkIHRvIGEgZG9tYWluIGluIGJldHdlZW4gdHdvIGRldmljZXMgYXR0YWNoaW5nIGJh
Y2tlZCBieSBpb21tdTEuDQo+Pg0KPj4gR3JvdXAgY2FjaGUgdGFncyB0b2dldGhlciBmb3Igc2Ft
ZSBpb21tdSB1bml0IGluIGNhY2hlX3RhZ19hc3NpZ24oKSB0bw0KPj4gbWF4aW1pemUgdGhlIHBl
cmZvcm1hbmNlIG9mIGJhdGNoZWQgZmx1c2guDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpo
b25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBkcml2ZXJz
L2lvbW11L2ludGVsL2NhY2hlLmMgfCAxMSArKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2NhY2hlLmMN
Cj4+IGluZGV4IGU1Yjg5ZjcyOGFkMy4uNzI2MDUyYTg0MWUwIDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9pb21tdS9pbnRlbC9jYWNoZS5jDQo+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2Nh
Y2hlLmMNCj4+IEBAIC00OCw2ICs0OCw4IEBAIHN0YXRpYyBpbnQgY2FjaGVfdGFnX2Fzc2lnbihz
dHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwNCj51MTYgZGlkLA0KPj4gICAJc3RydWN0IGludGVs
X2lvbW11ICppb21tdSA9IGluZm8tPmlvbW11Ow0KPj4gICAJc3RydWN0IGNhY2hlX3RhZyAqdGFn
LCAqdGVtcDsNCj4+ICAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+PiArCXN0cnVjdCBjYWNoZV90
YWcgKnRlbXAyID0gbGlzdF9lbnRyeSgmZG9tYWluLT5jYWNoZV90YWdzLA0KPj4gKwkJCQkJICAg
ICBzdHJ1Y3QgY2FjaGVfdGFnLCBub2RlKTsNCj4NCj5JcyB0aGlzIHZhbGlkIGZvciBhIGxpc3Qg
aGVhZD8NCg0KWWVzLCBpdCdzIG5vdCB2YWxpZCBmb3IgbGlzdCBoZWFkIGJ1dCBpdCdzIGludGVu
dGlvbmFsLCBqdXN0IHdhbnQgdG8NCmF2b2lkIHVubmVjZXNzYXJ5IHRlbXAyIGNoZWNrLiBJZiBJ
IGRvbid0IGRvIHRoYXQgd2F5LCBwYXRjaCB3aWxsIGJlOg0KDQotLS0gYS9kcml2ZXJzL2lvbW11
L2ludGVsL2NhY2hlLmMNCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYw0KQEAgLTQ4
LDYgKzQ4LDcgQEAgc3RhdGljIGludCBjYWNoZV90YWdfYXNzaWduKHN0cnVjdCBkbWFyX2RvbWFp
biAqZG9tYWluLCB1MTYgZGlkLA0KICAgICAgICBzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11ID0g
aW5mby0+aW9tbXU7DQogICAgICAgIHN0cnVjdCBjYWNoZV90YWcgKnRhZywgKnRlbXA7DQogICAg
ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQorICAgICAgIHN0cnVjdCBjYWNoZV90YWcgKnRlbXAy
ID0gTlVMTDsNCg0KICAgICAgICB0YWcgPSBremFsbG9jKHNpemVvZigqdGFnKSwgR0ZQX0tFUk5F
TCk7DQogICAgICAgIGlmICghdGFnKQ0KQEAgLTczLDggKzc0LDE4IEBAIHN0YXRpYyBpbnQgY2Fj
aGVfdGFnX2Fzc2lnbihzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwgdTE2IGRpZCwNCiAgICAg
ICAgICAgICAgICAgICAgICAgIHRyYWNlX2NhY2hlX3RhZ19hc3NpZ24odGVtcCk7DQogICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCiAgICAgICAgICAgICAgICB9DQorICAgICAgICAg
ICAgICAgaWYgKHRlbXAtPmlvbW11ID09IGlvbW11KQ0KKyAgICAgICAgICAgICAgICAgICAgICAg
dGVtcDIgPSB0ZW1wOw0KICAgICAgICB9DQotICAgICAgIGxpc3RfYWRkX3RhaWwoJnRhZy0+bm9k
ZSwgJmRvbWFpbi0+Y2FjaGVfdGFncyk7DQorICAgICAgIC8qDQorICAgICAgICAqIExpbmsgY2Fj
aGUgdGFncyBvZiBzYW1lIGlvbW11IHVuaXQgdG9nZXRoZXIsIHNvIGNvbnNwb25kaW5nDQorICAg
ICAgICAqIGZsdXNoIG9wcyBjYW4gYmUgYmF0Y2hlZCBmb3IgaW9tbXUgdW5pdC4NCisgICAgICAg
ICovDQorICAgICAgIGlmICh0ZW1wMikNCisgICAgICAgICAgICAgICBsaXN0X2FkZCgmdGFnLT5u
b2RlLCAmdGVtcDItPm5vZGUpOw0KKyAgICAgICBlbHNlDQorICAgICAgICAgICAgICAgbGlzdF9h
ZGRfdGFpbCgoJnRhZy0+bm9kZSwgJmRvbWFpbi0+Y2FjaGVfdGFncyk7DQorDQogICAgICAgIHNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJmRvbWFpbi0+Y2FjaGVfbG9jaywgZmxhZ3MpOw0KICAgICAg
ICB0cmFjZV9jYWNoZV90YWdfYXNzaWduKHRhZyk7DQoNClRoYW5rcw0KWmhlbnpob25nDQoNCj4N
Cj4+DQo+PiAgIAl0YWcgPSBremFsbG9jKHNpemVvZigqdGFnKSwgR0ZQX0tFUk5FTCk7DQo+PiAg
IAlpZiAoIXRhZykNCj4+IEBAIC03Myw4ICs3NSwxNSBAQCBzdGF0aWMgaW50IGNhY2hlX3RhZ19h
c3NpZ24oc3RydWN0IGRtYXJfZG9tYWluDQo+KmRvbWFpbiwgdTE2IGRpZCwNCj4+ICAgCQkJdHJh
Y2VfY2FjaGVfdGFnX2Fzc2lnbih0ZW1wKTsNCj4+ICAgCQkJcmV0dXJuIDA7DQo+PiAgIAkJfQ0K
Pj4gKwkJaWYgKHRlbXAtPmlvbW11ID09IGlvbW11KQ0KPj4gKwkJCXRlbXAyID0gdGVtcDsNCj4+
ICAgCX0NCj4+IC0JbGlzdF9hZGRfdGFpbCgmdGFnLT5ub2RlLCAmZG9tYWluLT5jYWNoZV90YWdz
KTsNCj4+ICsJLyoNCj4+ICsJICogTGluayBjYWNoZSB0YWdzIG9mIHNhbWUgaW9tbXUgdW5pdCB0
b2dldGhlciwgc28gY29uc3BvbmRpbmcNCj4+ICsJICogZmx1c2ggb3BzIGNhbiBiZSBiYXRjaGVk
IGZvciBpb21tdSB1bml0Lg0KPj4gKwkgKi8NCj4+ICsJbGlzdF9hZGQoJnRhZy0+bm9kZSwgJnRl
bXAyLT5ub2RlKTsNCj4+ICsNCj4+ICAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRvbWFpbi0+
Y2FjaGVfbG9jaywgZmxhZ3MpOw0KPj4gICAJdHJhY2VfY2FjaGVfdGFnX2Fzc2lnbih0YWcpOw0K
Pj4NCg0K
