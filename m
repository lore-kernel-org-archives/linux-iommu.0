Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9C41C2E8
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 16:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.57.120.243
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122002; cv=fail; b=t5ag8I9QWeG4yyDM2uaJtKtmZvAhd41vMt/rKMAjic+NQ53IHLyQD7RozsrKYGt1VLGSuutbeBV51ZylYj6Inhxow3X6rw1pb9+2OGoZlIjjhRwlE+Qs9Y+esjvf/LG84WIsrrMxAx2C2lnHhVgVuxFdwPNm/QRcxV/ZZ6EaDgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122002; c=relaxed/simple;
	bh=1sbXdQUTzWfo+fDUuUtgtit/XQ/tZ3stRwhAjw83D5E=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WjyLETuahKiJJ+pBwlggkww0BtgTPVJG+7Y3uYW4OzTxzFQKHPhtxrLufduG2UBncCgrYOJKDyefxC9SPWp6Qi5YWFdowHE2PZ9tItCgEgtBQj0AUObcjZggJ0W22hhEengeMBf2vqMLQ7EDEElXnDrmu/U4GGAzlV36xB0fL4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=rK+zmbH/; arc=fail smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="rK+zmbH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779122000; x=1810658000;
  h=from:to:cc:subject:date:message-id:content-id:
   mime-version:content-transfer-encoding;
  bh=1sbXdQUTzWfo+fDUuUtgtit/XQ/tZ3stRwhAjw83D5E=;
  b=rK+zmbH/QGFm1ZWZr7hXQt9OX8iX+5vdpOMffuAj8wFOsb1j9/DDCcX8
   V/w/wS9tjV6HkHA4IUj1rQMLPHKbR5f0AgHsAR3i+lmxS/3s6M/hVZIsG
   MGcm8p3wy0dsc9zp3naEKilcEpnHCQ+mGNKoy0HEpdGAzpUB4UbaV/Yll
   YHc8DISwX+VIEHKnx3BeUn6K+zMOennCYh10Q1Dwd+VBI4KMQxQeHq9TG
   ARy8MXaCEUW6vyCsvxYCuk1wi0R6IG+PbfPYWZZlw2ERVOptkh0m5LsYk
   YCLGBSx9LhpQhHpOz7erER6L3hYXV/iXVzLkdGoW7ACwZjdlKTUTOlPpa
   g==;
X-CSE-ConnectionGUID: JQvUytP5Sf6tmFrVayNVGA==
X-CSE-MsgGUID: wYzYUEY/RMCqxjlFtHd/OA==
X-IronPort-AV: E=Sophos;i="6.23,242,1770595200"; 
   d="scan'208";a="13971237"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 16:33:17 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.236:2073]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.17.141:2525] with esmtp (Farcaster)
 id 2c0d38d0-c5df-492f-bf05-ac0c51e477f6; Mon, 18 May 2026 16:33:16 +0000 (UTC)
X-Farcaster-Flow-ID: 2c0d38d0-c5df-492f-bf05-ac0c51e477f6
Received: from EX19EXOEUC001.ant.amazon.com (10.252.51.133) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 18 May 2026 16:33:15 +0000
Received: from EX19EXOEUB001.ant.amazon.com (10.252.51.80) by
 EX19EXOEUC001.ant.amazon.com (10.252.51.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 18 May 2026 16:33:15 +0000
Received: from FR5P281CU006.outbound.protection.outlook.com (10.252.51.94) by
 EX19EXOEUB001.ant.amazon.com (10.252.51.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Mon, 18 May 2026 16:33:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBOipJep7hVPdEB422mr1zfV6+w659YRifijuNfmM4xZTCXa893pyhpFuAR/4PITs4rfAYFlK3ahcr+cal5bR1h7vM6hQ3tJYrz4ze1jOEYO32kZi8p2pYLlmbfvRm2jRbq/miO7oCbwlR8sS/HCCztuHT5YSO9gBzdzI1wELTHzMUU4kbSrKB/wflmQKch81o74eYVMCbpJAbRw2r2DbdGMAWth1hZC+ldc9a9t4z+atgtoxjP6rVa7eCoht4BFMWTgY8ucOyEzahw4slOwWczwLgkIAkWAa8qzCqzVr9yEolSPxZOXLojZce0vmc4NvxkxKhbZif++jJpvQSJWBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0oK/sMePQX5IZfNs0UG3lRXjTuZeG+m5gzinwfvYgc=;
 b=GdZuD+u9Z9E63mfzhMT3kYw36HfETUiNWUMO1z6AJxZ/62IH/eJxIRb2gkE7xEqesjiFTuWrt5BQ5u7jK96QbNNF7IXQY/RqC548y8m0DZd3HLtVBTJtCKJs2Ht9PZd/rLEnlSXDeu0xxRS+KrN2VczLoI3EDqi3ayl1x8TKrkUqb4SVqALvX9+6IBcTEtn0fU23uESmiX3H0FxTkEietjoEIv/jS626NRdBGIv7qFifxrZEoDiek9Qp4HWENFnpgMN1nQY9KjDn8iSyYaBrNwy2cwhH+mneuWRxngAcQ1efTf/b6D0uJ4RIDIQcfOSITBUddI3jjdwsq2WcK3YOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c6::18)
 by BE1P281MB3111.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:60::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 16:33:11 +0000
Received: from FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e6b:4993:1367:d027]) by FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e6b:4993:1367:d027%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 16:33:11 +0000
From: "Oguz, Yigit" <yigitogu@amazon.de>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iommu: Add PCI vendor:device ID to IOMMU fault logs
Thread-Topic: [PATCH 0/3] iommu: Add PCI vendor:device ID to IOMMU fault logs
Thread-Index: AQHc5uQEA9WD3fkfGUme+bXfTyH09A==
Date: Mon, 18 May 2026 16:33:11 +0000
Message-ID: <29DF095D-5C81-47C3-8C41-62BCA4AB899D@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-05-18T16:28:32Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=f6c12c3b-ccf5-4ab1-a225-0c704fc57e69;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRVP281MB5782:EE_|BE1P281MB3111:EE_
x-ms-office365-filtering-correlation-id: 201c1010-9fab-4140-48b3-08deb4fb26b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|3023799003|11063799003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: OQhfccucuf+zKNehurABYS3YFwoOKC0pQ2M60K1o+/Jp1GeWoxDHt8/Q2Jsqiakr7UGBYpIophvDbuDgeU+1hNKPR09//iHAvuaIhE3yzt7CUTtHZRYuPybsA5XffIs3gPA6k6GqB3eE+ywOVLKVSBqdunb3L8YDqUX1SnrOtQVArN32eeMjmfGUZZB5EQzeyTNcPSbDNaqgIMi6Ogn2wmGT98T1MGgyaOT5MoQCarX2jug69fc+JH3PcbYtKn7bp5GazqJEnHK9RCWEP+jZJ4RvmV3Pe7wfr/WYRbihqz6NK4iNAmBPIRSUdo3SYsoMuDLIrBGeAXtjbT/Tv8a+R6TiMABdUg5/6SgO0I8ZZQKghHns7Ck/+ZY2n1wfC2LyV0sWwnz+WBNEYtVFefSPN0+rgvHEheH8UHaeOHaqUNI+7zl0e3zXs/PLSqh2CSqf+zSZHOf3zl0ipYek9pnO2QoCbt6sZMxAMVWbhBIwOVTPepcgXRbKZBkrHavW8r/jx/HMMnYxh0gBPjEoGUYlB5wBP+3+Qjtop4vlZ5LPk3rpQJZ7lR0F6yLujJv31CJRSYexUy61zRe9194AoNsuNBgEMhW7+L43YuhDeAu2Sx5iZBOwDGPAnGfT0xYLS+zTQowA6wBhJdACyoV2Rcc1D88bC9fe87PxI37uPfonkqfZrs1pBuCo/p9qIyrf25xThKtyHlNQgfZkmhpd0xtmJtnSOlxkCUuIa4wPSfB2iHibovbSN/Ls88QpIgY8E5tO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(3023799003)(11063799003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDJYY1dBTk9pRmRwaDl2dk9JVjN1WGMyZURwS2M2YURxNEwwZFRCaCs5N0or?=
 =?utf-8?B?Q25VMm1Ua1NzYnZKRllXMEJhUUJBVGZrYkVReVVxUkMxVzdrWnBDVkZPTFRz?=
 =?utf-8?B?SHQ4TGExbkl3eE80bWtTdzdtUVhGc2c1WGlMZDBpTHFoOEZQZ3ZCUVZhSzZk?=
 =?utf-8?B?a0QzcGNqWnJYSzV1ZXVOUkEwcGgvZWhxbTVrbldEUDRrbTF1NUxhcmc0NzRm?=
 =?utf-8?B?Wm1YbFJBVytqMnZHMWFHelgyZ1FqTDFXcklWTjloSk5oN252NENpdVJpekxR?=
 =?utf-8?B?ajFzUXMrV1picVNwQytyT0pmb0xtUWZyR3ByQ1ArRGIvckdaUmJYZFFHTXZQ?=
 =?utf-8?B?clhMTWZDbENLMzFXMWFXSDkvWGJROGRBRlhLWm1ZSjVNRTZaam5IbUVBalZz?=
 =?utf-8?B?Vk1va3RoWk41cDRhbnFKWmJybDhLaVBJR2E3QkUvc0ZaaDQ5L0lEZG51ZnN2?=
 =?utf-8?B?QWdMTDdTaDFhRFN0bTloVHVDYkNwSXRIZEV6MU5LRHNQd0dvNVJjUEcweE80?=
 =?utf-8?B?andXa3J4dUExc05oRkg0R0dEZzdBeFZicEhjOU4vUzBJWVA2Z2RjRS9rZzhk?=
 =?utf-8?B?RWI0NHRLUnhsN1VzMWdXYnY5VHY3N2dHRW9QSFBIazVzR21wbWxxNk9IT3c5?=
 =?utf-8?B?OFU0QW1XLytXQjR3M3ZLYUpZUnVlZnhqSTFFZlVQMXFVellNRGlPRTJOVUZK?=
 =?utf-8?B?Y0dleEVMZ290aGdpVjJDZ29KdGFKVmZqeFgvU1NKZGZzS0VEWXUvakFZRW03?=
 =?utf-8?B?ZW54Y3FSOVRKaHFOR0ZrOEt4UUdWemdXM0J5WjZobTU1RTdHTUQ2ZVN5bkpM?=
 =?utf-8?B?SklDcXNOcm5WVnZPYVd6alA0ZHlnSUlyS2tJSVVKVElLaTZLU1pHWnlxanlk?=
 =?utf-8?B?MTVZWW1iRHdvajc5K3dmMThNWnl1OHBvbjQ3aHFmeG9ibkFoRU9UUFhGempE?=
 =?utf-8?B?QkIreWZyK0QyVDdMczlRYVMxaCtLUktRbHovYkJCTEUvS2NvZGIvRmsreTg4?=
 =?utf-8?B?N2l4UDN3aXdzRVFIclBoOElQWXdHK2VTUTdqRDBaZFBPRnk0d2NKYUtFYk50?=
 =?utf-8?B?VGxpWlNXajlnWUFZT1A4M3liaVVabHA5NXpWZ0xxSEcwOWd5V2tCUG9YNXJh?=
 =?utf-8?B?cEdWV3BFRDBqV1lmellLZ3pyNkZ4K1dQemJCMWp1emtzOVNBc05hblhhZDhs?=
 =?utf-8?B?V205VXlJNStjeFZ3VzlYTDlwTzVkb0ZrR2d5NEhkOXhRQmV0MXdDTHFBYkFx?=
 =?utf-8?B?K1VObTZXM3VPMEF4dWFIb1FqbkdpNDVONHpUcUNoalVQemU5bkpmMHVRZ0hr?=
 =?utf-8?B?T3g5dFJ1d0diQmd6TFU1Z2FaNWVCK0RjNzZIN3pWVDl5R2ZyMTVvcXA5VHJI?=
 =?utf-8?B?Z1lNck4yVGhDKzcwK04wQU1IYVdncXdQbFdCZVdocXNEYTh6WFdVOVVPUllK?=
 =?utf-8?B?ZTlHVEE2TzBzaU9Uek45NjRXNVovcWcxNitnQjdGVUdYOEhSeHJpZ296SDBC?=
 =?utf-8?B?NzNIUmdqK3dUS1ZQWHN6NUJrcnpzVXBQTVllZ20vQ0N6UGl5SS9IVzJpTDFp?=
 =?utf-8?B?WWNpVHBhaURmWUQ1S1JMcmVsak5LSXdyci9nU2pZR2ZKRHo5NThYZFFXTHAy?=
 =?utf-8?B?UStib3NHYk9uc2NCYlc3YkJzZWdxbGhvRmt5Q2R1ZzJyTC9scjNwK2RRclJ4?=
 =?utf-8?B?YWQyNVFCb1VneFdkWCsvY3hKZjBrR2h4WThBV29TemcvTDUwYkR3MVZVYVUr?=
 =?utf-8?B?SnhqMlJjSVZITFRJYTJ6azFiWi9UMnhob3REOCthTDlLUWNNVGJFMnV3blNU?=
 =?utf-8?B?QktYQTFrYlh6clA2RkhxR3MzYzZwTjY4T0YrSHNrUUJMWnpXdVdxNHJJUU01?=
 =?utf-8?B?TVdidHU3QlpLVEF2N3o2Mml0MXFiaWJJSzVaQjlzWFcwQlZHOFBCSEdZN1kv?=
 =?utf-8?B?MjUwelVEWUVuMU52Q2RTVGx0M1ltYkZyWks2YWNpbUE0eGpObWJSNVVBcVlW?=
 =?utf-8?B?aVNGSlMyKzh1NFV0RjYwb2h0Vk5BVEcyWkRXWWRPeitJdnJIQmFsSTY0d2t0?=
 =?utf-8?B?UkpZTWdlR0hGTHFaTzhvTTJFZEo1bzVDN0ZkNzAvQWlnWEdjTFJsL2NIdmFx?=
 =?utf-8?B?QTNpalRNTW9OSlgzN3BMQ2lHa29xN1A5b0pldnFURk5DejBUVVRmWStaYzF3?=
 =?utf-8?B?NGZXVlFmL2NRdkp5Q0JBV3pTcVJkanV1UDMvN202OFRJZEQyRElDK3BuVXlr?=
 =?utf-8?B?T3VkTUpkeThFVlN0RUE0dmJHVFZwaFV4bU5TaUFaVGlUVm9mQS9MaUYyWk5J?=
 =?utf-8?B?Tms4WjdHUVdFVkpLVTFRRVArNG1HbitFeTgwanNqQXpWWVRwaUlTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A8A4634E53A1B47BFFACC70EFA9E761@DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tONrkzDdITweQKxWMrUhg+vrlmyb/OCex6lDC4xpqk8DIpSYry7VekciNj1yMc62SIwpUfNeG7ovKZzBHE3bntkeULy6o3opTf5WV9B8lsfuXXHh39oPY3bST3J6vBfRsCuQFKpJyCfkoaqMJo09s7xSlp5rtDuHquTqzgTSi1BuEr3qLTIryurUSjy6m7auicwNE4XQKQRVJWwBs5BPLOX/Stp1Rn1Q5fX2wURzUt6ehVPfEW+J0dsKlD8ZX3zme9nLyRzcsGQL6cHOCG9hrUdG3yXlw4rfUS1tQ/Ds0U4kS/sCgBLG1qAa77e0zZBQOmHkt4WDeWAD2PTsH7gh7g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 201c1010-9fab-4140-48b3-08deb4fb26b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 16:33:11.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OHPal/ZSaE0UhUegFLs3z1OqUlPpTgMcNCA/Yr7hh6mM8n2R8GL6iaZCE1tsDiOHLbzNnCxlkcF15PiLfW+3vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB3111
X-OriginatorOrg: amazon.de
Content-Transfer-Encoding: base64

T24gMjAyNi0wNS0xOCwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPiBUQkggSSB0aGluayB0aGUgbW9y
ZSBhcHByb3ByaWF0ZSBzb2x1dGlvbiB3b3VsZCBiZSB0byBoYXZlIHZmaW8tcGNpDQo+IHJlZ2lz
dGVyIGl0cyBvd24gZmF1bHQgaGFuZGxlciwgd2hlcmVpbiBpdCBjYW4gcHJvcGVybHkgZGVhbCB3
aXRoDQo+IHJhdGUtbGltaXRpbmcgYW5kL29yIGVudGlyZWx5IHN1cHByZXNzaW5nIGZhdWx0IHJl
cG9ydHMgZnJvbSBtaXNiZWhhdmluZw0KPiB1c2Vyc3BhY2UsIGFuZCBpZiBhbmQgd2hlbiBpdCBk
b2VzIHdhbnQgdG8gbG9nIHNvbWV0aGluZyBpdCBpcyB0aGVuIGZyZWUNCj4gdG8gZG8gdGhhdCBp
biB3aGF0ZXZlciBmb3JtYXQgaXQgd2FudHMsIGluZGVwZW5kZW50IG9mIHRoZSB1bmRlcmx5aW5n
DQo+IElPTU1VIGRyaXZlci4NCg0KQWdyZWVkIHRoYXQgYSBWRklPIGZhdWx0IGhhbmRsZXIgd291
bGQgYmUgdGhlIHJpZ2h0IGxvbmctdGVybSBmaXggZm9yDQp0aGUgcmF0ZWxpbWl0aW5nIHNpZGUu
IEJ1dCB0aGUgdmVuZG9yOmRldmljZSBJRCBoZWxwcyBmb3INCm5vbi1WRklPIGZhdWx0cyB0b28g
KGRyaXZlciBidWdzLCBmaXJtd2FyZSBpc3N1ZXMsIGV0Yy4pLCBzbyB0aGVyZSdzDQpzdGlsbCB2
YWx1ZSBpbiBoYXZpbmcgaXQgaW4gdGhlIGdlbmVyaWMgcGF0aCByZWdhcmRsZXNzLg0KDQpUaGFu
a3MsDQpZaWdpdA0KDQoNCk9uIDE4LzA1LzIwMjYgNDoxOSBwbSwgT2d1eiwgWWlnaXQgd3JvdGU6
DQo+IE9uIDIwMjYtMDUtMDgsIFJvYmluIE11cnBoeSB3cm90ZToNCj4+IFNvcnJ5LCBidXQgd2h5
IGFyZSB1bmV4cGVjdGVkIERNQSBmYXVsdHMgaGFwcGVuaW5nICJhdCBzY2FsZSIgaW4gdGhlDQo+
PiBmaXJzdCBwbGFjZT8gSWYgeW91IGhhdmUgc28gbWFueSBicm9rZW4gZHJpdmVycyB0aGF0IGRp
c2FtYmlndWF0aW5nIHRoZW0NCj4+IG5lZWRzIGhlbHAgZnJvbSB0aGUga2VybmVsLCBzb21ldGhp
bmcgc2VlbXMgZnVuZGFtZW50YWxseSB3cm9uZyB3aXRoDQo+PiB0aGF0IHBpY3R1cmUuIENvbnZl
cnNlbHkgaWYgdGhlc2UgYXJlIGRldmljZXMgYXNzaWduZWQgdG8gdXNlcnNwYWNlIHRoZW4NCj4+
IHdlIHNob3VsZCBwZXJoYXBzIHJlY29uc2lkZXIgdGhlaXIgYWJpbGl0eSB0byBzcGFtIHVwIHRo
ZSBob3N0IGtlcm5lbA0KPj4gbG9nIGF0IHdpbGwgYW55d2F5Lg0KPg0KPiBUaGUgdXNlIGNhc2Ug
aXMgVkZJTyBwYXNzdGhyb3VnaCBlbnZpcm9ubWVudHMgd2hlcmUgdHJhbnNsYXRpb24gZmF1bHRz
DQo+IHNob3cgdXAgZHVyaW5nIGRldmljZSBsaWZlY3ljbGUgb3BlcmF0aW9ucywgbWFpbmx5IGFy
b3VuZCBkZXZpY2UgcmVzZXQuDQo+IFdoZW4gbWFwcGluZ3MgYXJlIHRvcm4gZG93biBhbmQgYSBk
ZXZpY2Ugc3RpbGwgaGFzIERNQSBpbiBmbGlnaHQgb3INCj4gaXNzdWVzIERNQSBkdXJpbmcvYWZ0
ZXIgRkxSLCB0aGUgSU9NTVUgYmxvY2tzIGl0IGFuZCBsb2dzIHRoZSBmYXVsdC4NCj4gVGhpcyBz
ZXJpZXMgZG9lc24ndCBjaGFuZ2Ugd2hlbiBvciB3aGV0aGVyIGV2ZW50cyBnZXQgbG9nZ2VkLCBp
dCBqdXN0DQo+IG1ha2VzIHRoZSBleGlzdGluZyBsaW5lcyBtb3JlIHVzZWZ1bCBmb3IgdHJpYWdl
IHdoZW4gdGhleSBkbyBmaXJlLg0KPg0KPj4gSSdtIG5vdCBzYXlpbmcgSSBuZWNlc3NhcmlseSBo
YXZlIGFueXRoaW5nIGFnYWluc3QgdGhpcyBjaGFuZ2UgaW4NCj4+IHBhcnRpY3VsYXIsIGJ1dCBp
dCBoYXMgYSBzdHJvbmcgc21lbGwgb2YgZWZmb3J0IGJlaW5nIHNwZW50IG9uIHRoZSB3cm9uZw0K
Pj4gdGhpbmcuLi4NCj4NCj4gRmFpciBwb2ludC4gV2hldGhlciB0aGUgZmF1bHRzIHRoZW1zZWx2
ZXMgc2hvdWxkIGJlIGFkZHJlc3NlZCBpcyBhDQo+IHNlcGFyYXRlIHF1ZXN0aW9uLCBidXQgc2lu
Y2UgdGhlIGtlcm5lbCBhbHJlYWR5IGxvZ3MgdGhlbSB1bmNvbmRpdGlvbmFsbHksDQo+IG1ha2lu
ZyB0aGUgb3V0cHV0IG1vcmUgaW1tZWRpYXRlbHkgdXNlZnVsIHNlZW1lZCBsaWtlIGxvdy1oYW5n
aW5nIGZydWl0Lg0KDQoNClRCSCBJIHRoaW5rIHRoZSBtb3JlIGFwcHJvcHJpYXRlIHNvbHV0aW9u
IHdvdWxkIGJlIHRvIGhhdmUgdmZpby1wY2kNCnJlZ2lzdGVyIGl0cyBvd24gZmF1bHQgaGFuZGxl
ciwgd2hlcmVpbiBpdCBjYW4gcHJvcGVybHkgZGVhbCB3aXRoDQpyYXRlLWxpbWl0aW5nIGFuZC9v
ciBlbnRpcmVseSBzdXBwcmVzc2luZyBmYXVsdCByZXBvcnRzIGZyb20gbWlzYmVoYXZpbmcNCnVz
ZXJzcGFjZSwgYW5kIGlmIGFuZCB3aGVuIGl0IGRvZXMgd2FudCB0byBsb2cgc29tZXRoaW5nIGl0
IGlzIHRoZW4gZnJlZQ0KdG8gZG8gdGhhdCBpbiB3aGF0ZXZlciBmb3JtYXQgaXQgd2FudHMsIGlu
ZGVwZW5kZW50IG9mIHRoZSB1bmRlcmx5aW5nDQpJT01NVSBkcml2ZXIuDQoNCg0KVGhhbmtzLA0K
Um9iaW4uDQoNCg0KPj4gKEFuZCBldmVuIHRoZW4gQUZBSUNTIGl0IG9ubHkgcmVhbGx5IGhlbHBz
IGluIHRoZSBzcGVjaWZpYyBzY2VuYXJpbyBvZg0KPj4gaGF2aW5nIG9ubHkgb25lIG9mIGVhY2gg
dHlwZSBvZiBkZXZpY2UsIG90aGVyd2lzZSB5b3UncmUgYmFjayB0byBzdGlsbA0KPj4gbmVlZGlu
ZyBwZXItc3lzdGVtIGtub3dsZWRnZSBvZiBob3cgQkRGcyBtYXAgdG8gcGh5c2ljYWwgaW5zdGFu
Y2VzIHRvDQo+PiBrbm93IHdoYXQncyB3aGF0LikNCj4NCj4gVGhlIHZlbmRvcjpkZXZpY2UgSUQg
YW5zd2VycyB0aGUgZmlyc3QgcXVlc3Rpb24gaW4gdHJpYWdlOiAid2hhdCBraW5kIG9mDQo+IGRl
dmljZSBpcyB0aGlzPyIgRXZlbiB3aXRoIG11bHRpcGxlIGluc3RhbmNlcyBvZiB0aGUgc2FtZSB0
eXBlLCBuYXJyb3dpbmcNCj4gYnkgdHlwZSBjdXRzIGRvd24gdGhlIHNlYXJjaCBzcGFjZSB3aGVu
IGNvcnJlbGF0aW5nIGZhdWx0cyB3aXRoIGRldmljZQ0KPiBsaWZlY3ljbGUgZXZlbnRzLg0KPg0K
PiBUaGFua3MsDQo+IFlpZ2l0DQo+DQo+DQo+IE9uIDIwMjYtMDUtMDYgNDowNSBwbSwgWWlnaXQg
T2d1eiB3cm90ZToNCj4+IElPTU1VIGZhdWx0IGFuZCBldmVudCBsb2dzIGN1cnJlbnRseSBpZGVu
dGlmeSBkZXZpY2VzIHVzaW5nIG9ubHkgdGhlaXINCj4+IFBDSSBzZWdtZW50L2J1cy9kZXZpY2Uv
ZnVuY3Rpb24gKFNTU1M6QkI6REQuRikuIFdoaWxlIG1hcHBpbmcgYSBzaW5nbGUNCj4+IEJERiB0
byBhIGRldmljZSB0eXBlIGlzIHN0cmFpZ2h0Zm9yd2FyZCwgZG9pbmcgc28gYXQgc2NhbGUgYWNy
b3NzIG1hbnkNCj4+IGhvc3RzIGFuZCB0aG91c2FuZHMgb2YgZmF1bHQgZXZlbnRzIHJlcXVpcmVz
IGFkZGl0aW9uYWwgdG9vbGluZyBhbmQNCj4+IG1hbnVhbCBjcm9zcy1yZWZlcmVuY2luZy4gSW5j
bHVkaW5nIHRoZSB2ZW5kb3I6ZGV2aWNlIElEIGRpcmVjdGx5IGluDQo+PiB0aGUgbG9nIGxpbmUg
bWFrZXMgZWFjaCBldmVudCBzZWxmLWNvbnRhaW5lZCBhbmQgaW1tZWRpYXRlbHkgYWN0aW9uYWJs
ZQ0KPj4gd2l0aG91dCBhbnkgcG9zdC1wcm9jZXNzaW5nLg0KPg0KPg0KPiBTb3JyeSwgYnV0IHdo
eSBhcmUgdW5leHBlY3RlZCBETUEgZmF1bHRzIGhhcHBlbmluZyAiYXQgc2NhbGUiIGluIHRoZQ0K
PiBmaXJzdCBwbGFjZT8gSWYgeW91IGhhdmUgc28gbWFueSBicm9rZW4gZHJpdmVycyB0aGF0IGRp
c2FtYmlndWF0aW5nIHRoZW0NCj4gbmVlZHMgaGVscCBmcm9tIHRoZSBrZXJuZWwsIHNvbWV0aGlu
ZyBzZWVtcyBmdW5kYW1lbnRhbGx5IHdyb25nIHdpdGgNCj4gdGhhdCBwaWN0dXJlLiBDb252ZXJz
ZWx5IGlmIHRoZXNlIGFyZSBkZXZpY2VzIGFzc2lnbmVkIHRvIHVzZXJzcGFjZSB0aGVuDQo+IHdl
IHNob3VsZCBwZXJoYXBzIHJlY29uc2lkZXIgdGhlaXIgYWJpbGl0eSB0byBzcGFtIHVwIHRoZSBo
b3N0IGtlcm5lbA0KPiBsb2cgYXQgd2lsbCBhbnl3YXkuDQo+DQo+DQo+IEknbSBub3Qgc2F5aW5n
IEkgbmVjZXNzYXJpbHkgaGF2ZSBhbnl0aGluZyBhZ2FpbnN0IHRoaXMgY2hhbmdlIGluDQo+IHBh
cnRpY3VsYXIsIGJ1dCBpdCBoYXMgYSBzdHJvbmcgc21lbGwgb2YgZWZmb3J0IGJlaW5nIHNwZW50
IG9uIHRoZSB3cm9uZw0KPiB0aGluZy4uLg0KPg0KPg0KPiAoQW5kIGV2ZW4gdGhlbiBBRkFJQ1Mg
aXQgb25seSByZWFsbHkgaGVscHMgaW4gdGhlIHNwZWNpZmljIHNjZW5hcmlvIG9mDQo+IGhhdmlu
ZyBvbmx5IG9uZSBvZiBlYWNoIHR5cGUgb2YgZGV2aWNlLCBvdGhlcndpc2UgeW91J3JlIGJhY2sg
dG8gc3RpbGwNCj4gbmVlZGluZyBwZXItc3lzdGVtIGtub3dsZWRnZSBvZiBob3cgQkRGcyBtYXAg
dG8gcGh5c2ljYWwgaW5zdGFuY2VzIHRvDQo+IGtub3cgd2hhdCdzIHdoYXQuKQ0KPg0KPg0KPiBU
aGFua3MsDQo+IFJvYmluLg0KPg0KPg0KPj4gVGhpcyBzZXJpZXMgYWRkcyB2ZW5kb3I6ZGV2aWNl
IElEIChWVlZWOkREREQpIHRvIElPTU1VIGV2ZW50IGxvZ3MgZm9yDQo+PiBBUk0gU01NVXYzLCBJ
bnRlbCBWVC1kIGFuZCBBTUQgSU9NTVUuDQo+Pg0KPj4gQmVmb3JlOg0KPj4gYXJtLXNtbXUtdjMg
YXJtLXNtbXUtdjMuMC5hdXRvOiBldmVudDogRl9UUkFOU0xBVElPTiBjbGllbnQ6IDAwMDA6MmI6
MTEuNg0KPj4gc2lkOiAweDE1OGUgc3NpZDogMHgwIGlvdmE6IDB4MjgwMDAwMDAwMDAwIGlwYTog
MHgwDQo+PiBETUFSOiBbRE1BIFdyaXRlIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBbODY6MDAu
MF0gZmF1bHQgYWRkciAweGUwMDAwMDAwDQo+PiBbZmF1bHQgcmVhc29uIDB4MDVdIFBURSBXcml0
ZSBhY2Nlc3MgaXMgbm90IHNldA0KPj4gQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFV
TFQgZGV2aWNlPTAwMDA6NDE6MDAuMCBkb21haW49MHgwMDBhDQo+PiBhZGRyZXNzPTB4ZTAwMDAw
MDAgZmxhZ3M9MHgwMDIwXQ0KPj4NCj4+IEFmdGVyOg0KPj4gYXJtLXNtbXUtdjMgYXJtLXNtbXUt
djMuMC5hdXRvOiBldmVudDogRl9UUkFOU0xBVElPTiBjbGllbnQ6IDAwMDA6MmI6MTEuNiBbODA4
NjoxNTMzXQ0KPj4gc2lkOiAweDE1OGUgc3NpZDogMHgwIGlvdmE6IDB4MjgwMDAwMDAwMDAwIGlw
YTogMHgwDQo+PiBETUFSOiBbRE1BIFdyaXRlIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBbMDAw
MDo4NjowMC4wIDgwODY6MTUzM10gZmF1bHQgYWRkciAweGUwMDAwMDAwDQo+PiBbZmF1bHQgcmVh
c29uIDB4MDVdIFBURSBXcml0ZSBhY2Nlc3MgaXMgbm90IHNldA0KPj4gQU1ELVZpOiBFdmVudCBs
b2dnZWQgW0lPX1BBR0VfRkFVTFQgZGV2aWNlPTAwMDA6NDE6MDAuMCA4MDg2OjE1MzMgZG9tYWlu
PTB4MDAwYQ0KPj4gYWRkcmVzcz0weGUwMDAwMDAwIGZsYWdzPTB4MDAyMF0NCj4+DQo+PiBQYXRj
aCAxIGFkZHMgdmVuZG9yOmRldmljZSBJRCB0byBBUk0gU01NVXYzIHRyYW5zbGF0aW9uIGZhdWx0
IGxvZ3MuDQo+PiBQYXRjaCAyIGFkZHMgUENJIHNlZ21lbnQgYW5kIHZlbmRvcjpkZXZpY2UgSUQg
dG8gSW50ZWwgVlQtZCBETUFSDQo+PiBmYXVsdCBsb2dzLg0KPj4gUGF0Y2ggMyBhZGRzIGEgZGV2
aWRfc3RyIGhlbHBlciBhbmQgdmVuZG9yOmRldmljZSBJRCB0byBhbGwgQU1EIElPTU1VDQo+PiBl
dmVudCBsb2cgcGF0aHMuDQo+Pg0KPj4gVGVzdGluZzoNCj4+IEJ1aWxkLXRlc3RlZCBhZ2FpbnN0
IG1haW5saW5lIExpbnV4ICh0b3J2YWxkcy9tYXN0ZXIpLg0KPj4NCj4+IFJ1bnRpbWUtdGVzdGVk
IG9uIGEgY3VzdG9tIGRvd25zdHJlYW0gYnJhbmNoIG9uIEFSTSBTTU1VdjMsIEludGVsIFZULWQg
YW5kDQo+PiBBTUQgSU9NTVUgaG9zdHMuIFRyYW5zbGF0aW9uIGZhdWx0cyB3ZXJlIGluZHVjZWQg
aW4gYSB2aXJ0dWFsaXplZCBzZXR1cA0KPj4gYnkgcmVtb3ZpbmcgRE1BIG1hcHBpbmdzIGZvciBh
biBpbi11c2UgcmVnaW9uLCBjYXVzaW5nIHRoZSBhc3NpZ25lZCBkZXZpY2Uncw0KPj4gc3Vic2Vx
dWVudCBETUEgdHJhbnNhY3Rpb25zIHRvIGhpdCB1bm1hcHBlZCBJT1ZBcyBhbmQgcHJvZHVjZQ0K
Pj4gdHJhbnNsYXRpb24gZmF1bHQgZXZlbnRzLiBUaGUgcmVzdWx0aW5nIGxvZyBsaW5lcyB3ZXJl
IHZlcmlmaWVkIHRvDQo+PiBjb250YWluIHRoZSBQQ0kgdmVuZG9yOmRldmljZSBJRCBvbiBhbGwg
dGhyZWUgcGxhdGZvcm1zLg0KPj4NCj4+IExpbGl0IEphbnBvbGFkeWFuICgxKToNCj4+IGlvbW11
L2FybS1zbW11LXYzOiBQcmludCBQQ0kgdmVuZG9yOmRldmljZSBJRCBpbiBTTU1VIHRyYW5zbGF0
aW9uDQo+PiBmYXVsdCBsb2dzDQo+Pg0KPj4gWWlnaXQgT2d1eiAoMik6DQo+PiBpb21tdS92dC1k
OiBBZGQgUENJIHNlZ21lbnQgYW5kIHZlbmRvcjpkZXZpY2UgSUQgdG8gRE1BUiBmYXVsdCBsb2dz
DQo+PiBpb21tdS9hbWQ6IEFkZCB2ZW5kb3I6ZGV2aWNlIElEIHRvIEFNRCBJT01NVSBldmVudCBs
b2dzDQo+Pg0KPj4gZHJpdmVycy9pb21tdS9hbWQvaW9tbXUuYyB8IDk0ICsrKysrKysrKysrKyst
LS0tLS0tLQ0KPj4gZHJpdmVycy9pb21tdS9hcm0vYXJtLXNtbXUtdjMvYXJtLXNtbXUtdjMuYyB8
IDI5ICsrKysrKy0NCj4+IGRyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jIHwgMzMgKysrKystLS0N
Cj4+IDMgZmlsZXMgY2hhbmdlZCwgMTA0IGluc2VydGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQ0K
Pj4NCj4NCj4NCj4NCj4NCj4NCj4NCj4NCj4NCj4gQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZlbG9w
bWVudCBDZW50ZXIgR2VybWFueSBHbWJIDQo+IFRhbWFyYS1EYW56LVN0ci4gMTMNCj4gMTAyNDMg
QmVybGluDQo+IEdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0b2YgSGVsbG1pcywgQW5kcmVhcyBT
dGllZ2VyDQo+IEVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVy
IEhSQiAyNTc3NjQgQg0KPiBTaXR6OiBCZXJsaW4NCj4gVXN0LUlEOiBERSAzNjUgNTM4IDU5Nw0K
DQoNCg0KDQoNCgoKCkFtYXpvbiBXZWIgU2VydmljZXMgRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1h
bnkgR21iSApUYW1hcmEtRGFuei1TdHIuIDEzCjEwMjQzIEJlcmxpbgpHZXNjaGFlZnRzZnVlaHJ1
bmc6IENocmlzdG9mIEhlbGxtaXMsIEFuZHJlYXMgU3RpZWdlcgpFaW5nZXRyYWdlbiBhbSBBbXRz
Z2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMjU3NzY0IEIKU2l0ejogQmVybGluClVz
dC1JRDogREUgMzY1IDUzOCA1OTcK

