Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8D6315D43
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.197.217.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117610; cv=fail; b=QP16evddngAZpqltRNVSAiefNjOHtCNh96VNE6+O0rv7tXOw9fd5XG6iWCtzhUF23EQ2HRW+JgHI81fbwXq6J59J49CotBWrpztjDGtfivShOSqHo6eo4uTWrjsiQiLKuWC6NrqPT/1pLBDHC8e9FrRVuGuDPrSq6S0YqtSP0oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117610; c=relaxed/simple;
	bh=0Dn0wpjwm+15rIqwf1ZCBBKD+pr64TLDeVjWnN8N668=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Q3cfKb1y0hWGl2gweLUyW0noKofeaAzEWXSCwUV5rqJFocOikK8yhfSVWvK6Qj1ppQL7dPxjKl0EgIENg39TOin0nN3misjgAFFrhPb4GxGZla41QH3FECZIpBjcCvfq5f2fpAYxLu6jbgldeA9UKPmeCUvOue4OG3kf4Iuypgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=IJmVl8UE; arc=fail smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="IJmVl8UE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1779117608; x=1810653608;
  h=from:to:cc:subject:date:message-id:content-id:
   mime-version:content-transfer-encoding;
  bh=0Dn0wpjwm+15rIqwf1ZCBBKD+pr64TLDeVjWnN8N668=;
  b=IJmVl8UEwC7GrMv4My6nA/FErgLM6SA1VMxI9wV/8/ur/AG17n7DM3J4
   Hk40sehpSVRqycYiY1FXJ0aVlLjte+Gyogd+39Jxrajx/quQc1gOfInfm
   B/T5ilO3DjvJMKenKlEmKzrzGQZHXvJ1xKXYIvZC0ohy4vMxxl+wsuxmj
   xtdPHQhmhg2wx1ObmdUwBmO+T9fB+tesxvoVZA36zeqzl7zqn4PX3K5Zu
   5T7KyUCpfGI0m7xeAadPMPp80trCxzlD1MMabPRRVxslCMmUJI4dcYoBu
   HR+4ODkytZ5Tx/dH2a1Qnxsvax6BZlPGbB8NV5n5xsZu8kQA836D8fEAg
   w==;
X-CSE-ConnectionGUID: bFXkZ65KQByU5F6bARwvjA==
X-CSE-MsgGUID: G1TE8FN3Sd+Az9hKVeUibw==
X-IronPort-AV: E=Sophos;i="6.23,242,1770595200"; 
   d="scan'208";a="14045238"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 15:20:04 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:11969]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.11.20:2525] with esmtp (Farcaster)
 id fd213588-2689-43c0-ba69-e71ed6fc83b9; Mon, 18 May 2026 15:20:04 +0000 (UTC)
X-Farcaster-Flow-ID: fd213588-2689-43c0-ba69-e71ed6fc83b9
Received: from EX19EXOEUA002.ant.amazon.com (10.252.50.139) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 18 May 2026 15:19:59 +0000
Received: from EX19EXOEUC001.ant.amazon.com (10.252.51.133) by
 EX19EXOEUA002.ant.amazon.com (10.252.50.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 18 May 2026 15:19:59 +0000
Received: from BEUP281CU002.outbound.protection.outlook.com (10.252.51.199) by
 EX19EXOEUC001.ant.amazon.com (10.252.51.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37
 via Frontend Transport; Mon, 18 May 2026 15:19:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdcqI3CkE91MOK2krji94bI/CsUcOPqXufIPufvhyIvWiJa0N+jo8dwaB0vk1ygm4A9pYfMIjMbwlzk+dZr74/gY12KJla0+4QIakY6/vofy9paZa+nsK0HCT63wDXgZZM3zc9b8/HBgSgHj4f6Hy3gqFRQ5VhwG+8Pj5DILTfgwPKqteZrH50OLLDk8hEBiA7X61GKzWmaSyELlR17xqDhA1bONBEgFBz33KdQN4+SCryQ+bFCkCEx18+Xbyehy8OfsCTyzmpM4YMIB7yDdx3n5in324FUzQ1ZSp8GYgvfoT5LbnUrbquSBtHaOE87GcMFp/YCKBGgsGzauSlC7Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXVte/GfP9zUPC6LS3T92B42TLFd8xxTPJViDfri2dY=;
 b=Z5NxaRFMXa/at+h/BkWCCySzC342zFcGYk637neQCFYWvJcRJtOdZeiNX0npvJ1ikExtAVm1aTBl8zYta7papbO4jHTHFCjVulbDD+xDdt1q35cDU30PXpBo2FMOtbW2GeWajYPsZWtKGGfzn9xPeGEk8DNMp7ZWb6gE8zVEhRMo+uG3uhoDPmC9QZiTCDlnfbfsD5YH6eDzwHaQZ//wUae7gToDOTJDGId2+h890V21TuHWX5NsU10MQI70EAsb5AwZ3KnE0/xRy3zr2DaQEiBNfrjJADd7hEg1IX+EVsTL71JVvuiYD8XrGuZZ/SkRJyZ7e+AJc0Gn3QWjar2fXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c6::18)
 by BEZP281MB2309.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 15:19:56 +0000
Received: from FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e6b:4993:1367:d027]) by FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
 ([fe80::e6b:4993:1367:d027%5]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 15:19:56 +0000
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
Thread-Index: AQHc5tnIfhE6tyXqCECo0fsStu8t9w==
Date: Mon, 18 May 2026 15:19:56 +0000
Message-ID: <C1C278E8-E5F6-4701-9127-DCDBC64636E1@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SetDate=2026-05-18T15:03:46Z;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ContentBits=0;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Enabled=true;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Tag=50,
 3, 0,
 1;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Name=Confidential;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_ActionId=3361a9c0-2833-4eef-9fb3-67907bdec65c;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_SiteId=5280104a-472d-4538-9ccf-1e1d0efe8b1b;MSIP_Label_19e68092-05df-4271-8e3e-b2a4c82ba797_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRVP281MB5782:EE_|BEZP281MB2309:EE_
x-ms-office365-filtering-correlation-id: f22b73b8-7636-41e8-213f-08deb4f0eb14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|3023799003|11063799003|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: 45Gsms4ePSLV3QRbp/crHL8uIOygDKZDRETgORffca4dOrzQd2zBQDbS40EZq/cVv5yzCtZdrhfHCEFBWvMzJOrQXXutRrsjSf2HycEYPoAgmRGK3dqMb/2Jpb/2tG8pKT7fILnEb/h3ieoAzn9IJHnHTDg+yWyOQohqSAcAdl9+3nsFXJ8I7xQo6lsPfR7EORVqjHThgdR4IUpvB03EutIgvSmGROwTKnUegmjg1JSIQT8TFaNd7BpScK9VrWOvMRjKhUp20+JdaF4GrRdfvRcsK619agfGpDURxLBQkCHzaLcYvielxOpRwI7qXjsFYsYMl3gTD6hGXai26t6gQcypKYxJg2Ypoi69Vv8akNF24KXQK1ffSItNPwyYyZaE2gHsrwXy7tlGKkjG8UUIkrK7QYiOL8zLGW4HUeJ/B1TZK1b8zqgsOrk9xsMr1qXVGN+SWYvMWms3jNRqwjf1AF3f8+X7UwPPm5oJZJCAMTu3ScVLgWPmq2R1il1yeKNgzF8i+bYRxgAO4YZYU2TZ11U27YhBxfjy3uVjPwSLjxxzkoPombSjQWHaTHPzRLVZv1nFe8DigeWp/3lQVHTAt0+p6nVqHiTT+ghVhFrncr3/l+zXQyVPv6ZhYPYE0Jg9l3vih8uYFeDppRexgtjVCXmSglf7VpNRmKFXqTJBxA/N2JGRCpCv0B29b4uQgsDC++jbqjMh/b+7dVKiZLlIo9ksIS7C4sKEQnIsoG4ywNYotB7d8jvlQH9kADWfcCW3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(3023799003)(11063799003)(38070700021)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGs4UjJpd041amtNamtjZjJNRURYNWpiblZVcVdjNG0xbVhLQ0VtRXhJc21Z?=
 =?utf-8?B?M0gySHZHRGU1eFFkTFlqanpubkE4MGNmKzl1VVVvT2ZDTTQrRndSWnpNa3hu?=
 =?utf-8?B?RXBFQ3c4cG1hYW1ZMTQwL1ZaWEFEbTV3QWJYUlRMTzRrb0tCbXZBaTNla3kz?=
 =?utf-8?B?SUxpYnUzWHN0Qi9hcXVuazZlTnIvazEzY2tMa3QwLy8rODkvREExRGFZNW85?=
 =?utf-8?B?MkJ0SGNaRU0xNlJDVGZ1dENpa0F6eDBDbnhXdXFwL0t2SlFZbU95czRUSk81?=
 =?utf-8?B?V2hwNWx0MU1aaW5nSnVMZFc1ZWtmUjNRbGZEN3NjZ3V0TTRJeHA3eFpSMXNh?=
 =?utf-8?B?R2E3Z0d0cFdVSmFwUVJDOUlNa0R2cHgwWUpLUjMzUGlKZ0FhTHdCQmJrTDBC?=
 =?utf-8?B?ZWN1RmxhUElTNC9SOXhyamhwNlZvb1doa3NEZVFzM1NSOGl5N0pQMVU2eVNh?=
 =?utf-8?B?K0liYVhwbmlvcXZMbXZXTklwL1hMNmM1VDd2SmpHNzBhNklEcVIvZmNqMHBr?=
 =?utf-8?B?OGFuU3ppQUxTektxUVpuLytMZ1Nvd3JHR1BqN3hEaFdkVDNYT3Q2REJwSFF5?=
 =?utf-8?B?VHE4YVdKQkxFYlVDMy9WRXZGSXFBaVc0RFNUcmdwdUcxay9kck1qUWs2MmRZ?=
 =?utf-8?B?QTAzQWd1NjA2UnJEMHVsajlQcG5HWklXaTV5alJESlZhQzhoeDBmTDFGV2Ux?=
 =?utf-8?B?R1VwV3cyU3o4L2JEVFdMb0NHK1IwZnhldGlRVEM4V3ZlQVYvSEJ5YVEyVXI1?=
 =?utf-8?B?ekUxVUVGblVVYVFzOWNMb1BKNWNsNHJaVi9Ga0dtV1orU3ZYa1RqYnRoVVV2?=
 =?utf-8?B?K2h3b0ZIZStXcnh4Rk9VU2VBZlE1eDVZSFU4THk4cThpRjFGT1hNNXpGTXI5?=
 =?utf-8?B?MXRZSnM2YnptQW85ZWM4SEd5L2ExY0RublRaUU9DRC94bEhpMjV5clVjV00y?=
 =?utf-8?B?eWNydThtRngyNVA0emo4bStvK094WGFWTEU4WXNkdmN6VUo4MVMzZFBDYWU3?=
 =?utf-8?B?eHhhNW9qTnNSbGN6SnNjbVkvWmVQWTZibE10Mk1rUjI4WERFaDkvNkwwamZJ?=
 =?utf-8?B?Tm92cmR3bHNheUR1VExyeUhvdTJ0TlpzRFNMRUdyWlliRjRhVGIzY3BpZFow?=
 =?utf-8?B?d2xPQVVtRWJPVG5tYWNCZWpoVXpsQnRvcXZPaG10ZkdPUWtkS2tsSnFtYTZh?=
 =?utf-8?B?bFZxQWczT2RSR3FsU09IaWZpbjh4UGY1d2hQL1U4Z2ViWlRLQkNMZy9mSTNv?=
 =?utf-8?B?dHRqZWlDUnZJT2VGY05WZkJFcDJIa3RtUHZIaStEWUQ3M2ZQR2FLVzc0cHly?=
 =?utf-8?B?VHBRaitaL0FVNnZPNk90NE5pTENQYk5KMjRQWWp3RWw5YUtoSDRuY0Q5UUVi?=
 =?utf-8?B?Z3ZkZk5PdWxsandoeDNLY1JWNnpnRVBLVFFlMWw1dU56YnFTRnRZQVkzMUph?=
 =?utf-8?B?d3hTNmp1YVg4aWxzUWI3ZGM2QnpYNHNzbDU2VGhJTUZwVHI1RHNmcmNXaWly?=
 =?utf-8?B?WDZuTVZob3F5UXNPaVNaVSt5ejZEbXNncitDS1RlQ0liaGZuQTc4eTJPYVR1?=
 =?utf-8?B?ejNJbjVLemRySVpaY2dmSEJYb2N3WVdsZ0hwRkFEUExpNVdYRk1EemplVFFS?=
 =?utf-8?B?UC9xaDNmZWtNQkF4ejlqbTFsVnpBZldNNnNSL1QxOUhTSFNzMnRCaXVHSVU4?=
 =?utf-8?B?bGZPYmVDbUxRYmxiMWxjTWVwcW0yY3ZVaDU1TUFjcTJwMC95dlJRWTlqcEhD?=
 =?utf-8?B?dlcraytMQVpUcENUOVJyUHhrYVE1cUZUYW44Y0pGOWg4T3hudUxJdTNrZ1Ev?=
 =?utf-8?B?YVd5SjZqM1BkeGdQSWVtcGFYcFhNdUJac2dmOFVmUHFlV0NvZGM4MGd5M1U1?=
 =?utf-8?B?SS9nWlNSdXlpNHJtZi9kSks3WUtDbUpXV3JxMUVpYXZpR0poZ2JQN0tUdzVG?=
 =?utf-8?B?aUxQb2hVSWFBTnA0Z2dONzYyR2xPSzNQY0k5OGRYNUJyUjJYMVZGYkVuMmFo?=
 =?utf-8?B?blZPV29TaWNZaHU3VndmQnRxMVRzc0Jxd3VlNnV3UHEvejJ4SzZBb3NlbWl0?=
 =?utf-8?B?RllIVHVWQ3d5ZkFyeVRkZ0hZWmFNNVVXQ2QveVhnWWRqVEFleGErbDlYM1ds?=
 =?utf-8?B?TytaRm90eW12N3NBSS9zWHdvNFFpeWErN21mNFlLNUpJb0hMMmQxdWlUSjB1?=
 =?utf-8?B?T1lXWWdRZzlyaDluVmZBSEIrazFUaUJrOS9lNzdFU0ZZcVdNS3ozdnR4WW83?=
 =?utf-8?B?dWtqRW1kMVV1aDNEM1lpaUJGSzc3RFk5SHJiNnhiRTZhTU5DeFliR0hYSFpP?=
 =?utf-8?B?SDJicVo2aTNCeUNzTkw4MWVxNFBWczhxNCtEQjVOdTVxUHExaWRIUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEFC2E8B8315BD4797E5188C83FDCC80@DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DcLtQKbkbs9t8715xt2yJEn8RRzjy4LxG/t0UzVTJR3bnEhFD2yy6qSH92vJzE1/EGoKTlJ4U7OPQQUpJ/64P7h+PODz9AX4RVuuIGXeFzkJf4owwYY3KFModoXZ1kiPEZyFO1i6oSC5CnhGuz8enYTOullCoAt4+q6e/M1ey7eMzcxntqq/HFQp3CPxzmnQTujXKVjQ1m1xf1lAldYOCjFm/70aQZBPxYjQ26+ZiHkRi6tugP7cfU4a5EnZUsK9oeK3SaxRQ4KKbO7RBSmf2l26IKIldiglhCarXeVyaYzWjtzRpbDCAWQ02YDotTrLLCznozkOJWWe1fbZOYQgFQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRVP281MB5782.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f22b73b8-7636-41e8-213f-08deb4f0eb14
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 15:19:56.2283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: raszpQ4Nj+2MzEPTB/Xt+LoeqzqWYcmkRAXta0qkvgWlEnnfcMf8upZYFOOIzLaqLK3LJKcOtbmYNVFAAIOk3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2309
X-OriginatorOrg: amazon.de
Content-Transfer-Encoding: base64

T24gMjAyNi0wNS0wOCwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPiBTb3JyeSwgYnV0IHdoeSBhcmUg
dW5leHBlY3RlZCBETUEgZmF1bHRzIGhhcHBlbmluZyAiYXQgc2NhbGUiIGluIHRoZQ0KPiBmaXJz
dCBwbGFjZT8gSWYgeW91IGhhdmUgc28gbWFueSBicm9rZW4gZHJpdmVycyB0aGF0IGRpc2FtYmln
dWF0aW5nIHRoZW0NCj4gbmVlZHMgaGVscCBmcm9tIHRoZSBrZXJuZWwsIHNvbWV0aGluZyBzZWVt
cyBmdW5kYW1lbnRhbGx5IHdyb25nIHdpdGgNCj4gdGhhdCBwaWN0dXJlLiBDb252ZXJzZWx5IGlm
IHRoZXNlIGFyZSBkZXZpY2VzIGFzc2lnbmVkIHRvIHVzZXJzcGFjZSB0aGVuDQo+IHdlIHNob3Vs
ZCBwZXJoYXBzIHJlY29uc2lkZXIgdGhlaXIgYWJpbGl0eSB0byBzcGFtIHVwIHRoZSBob3N0IGtl
cm5lbA0KPiBsb2cgYXQgd2lsbCBhbnl3YXkuDQoNClRoZSB1c2UgY2FzZSBpcyBWRklPIHBhc3N0
aHJvdWdoIGVudmlyb25tZW50cyB3aGVyZSB0cmFuc2xhdGlvbiBmYXVsdHMNCnNob3cgdXAgZHVy
aW5nIGRldmljZSBsaWZlY3ljbGUgb3BlcmF0aW9ucywgbWFpbmx5IGFyb3VuZCBkZXZpY2UgcmVz
ZXQuDQpXaGVuIG1hcHBpbmdzIGFyZSB0b3JuIGRvd24gYW5kIGEgZGV2aWNlIHN0aWxsIGhhcyBE
TUEgaW4gZmxpZ2h0IG9yDQppc3N1ZXMgRE1BIGR1cmluZy9hZnRlciBGTFIsIHRoZSBJT01NVSBi
bG9ja3MgaXQgYW5kIGxvZ3MgdGhlIGZhdWx0Lg0KVGhpcyBzZXJpZXMgZG9lc24ndCBjaGFuZ2Ug
d2hlbiBvciB3aGV0aGVyIGV2ZW50cyBnZXQgbG9nZ2VkLCBpdCBqdXN0DQptYWtlcyB0aGUgZXhp
c3RpbmcgbGluZXMgbW9yZSB1c2VmdWwgZm9yIHRyaWFnZSB3aGVuIHRoZXkgZG8gZmlyZS4NCg0K
PiBJJ20gbm90IHNheWluZyBJIG5lY2Vzc2FyaWx5IGhhdmUgYW55dGhpbmcgYWdhaW5zdCB0aGlz
IGNoYW5nZSBpbg0KPiBwYXJ0aWN1bGFyLCBidXQgaXQgaGFzIGEgc3Ryb25nIHNtZWxsIG9mIGVm
Zm9ydCBiZWluZyBzcGVudCBvbiB0aGUgd3JvbmcNCj4gdGhpbmcuLi4NCg0KRmFpciBwb2ludC4g
V2hldGhlciB0aGUgZmF1bHRzIHRoZW1zZWx2ZXMgc2hvdWxkIGJlIGFkZHJlc3NlZCBpcyBhDQpz
ZXBhcmF0ZSBxdWVzdGlvbiwgYnV0IHNpbmNlIHRoZSBrZXJuZWwgYWxyZWFkeSBsb2dzIHRoZW0g
dW5jb25kaXRpb25hbGx5LA0KbWFraW5nIHRoZSBvdXRwdXQgbW9yZSBpbW1lZGlhdGVseSB1c2Vm
dWwgc2VlbWVkIGxpa2UgbG93LWhhbmdpbmcgZnJ1aXQuDQoNCj4gKEFuZCBldmVuIHRoZW4gQUZB
SUNTIGl0IG9ubHkgcmVhbGx5IGhlbHBzIGluIHRoZSBzcGVjaWZpYyBzY2VuYXJpbyBvZg0KPiBo
YXZpbmcgb25seSBvbmUgb2YgZWFjaCB0eXBlIG9mIGRldmljZSwgb3RoZXJ3aXNlIHlvdSdyZSBi
YWNrIHRvIHN0aWxsDQo+IG5lZWRpbmcgcGVyLXN5c3RlbSBrbm93bGVkZ2Ugb2YgaG93IEJERnMg
bWFwIHRvIHBoeXNpY2FsIGluc3RhbmNlcyB0bw0KPiBrbm93IHdoYXQncyB3aGF0LikNCg0KVGhl
IHZlbmRvcjpkZXZpY2UgSUQgYW5zd2VycyB0aGUgZmlyc3QgcXVlc3Rpb24gaW4gdHJpYWdlOiAi
d2hhdCBraW5kIG9mDQpkZXZpY2UgaXMgdGhpcz8iIEV2ZW4gd2l0aCBtdWx0aXBsZSBpbnN0YW5j
ZXMgb2YgdGhlIHNhbWUgdHlwZSwgbmFycm93aW5nDQpieSB0eXBlIGN1dHMgZG93biB0aGUgc2Vh
cmNoIHNwYWNlIHdoZW4gY29ycmVsYXRpbmcgZmF1bHRzIHdpdGggZGV2aWNlDQpsaWZlY3ljbGUg
ZXZlbnRzLg0KDQpUaGFua3MsDQpZaWdpdA0KDQoNCk9uIDIwMjYtMDUtMDYgNDowNSBwbSwgWWln
aXQgT2d1eiB3cm90ZToNCj4gSU9NTVUgZmF1bHQgYW5kIGV2ZW50IGxvZ3MgY3VycmVudGx5IGlk
ZW50aWZ5IGRldmljZXMgdXNpbmcgb25seSB0aGVpcg0KPiBQQ0kgc2VnbWVudC9idXMvZGV2aWNl
L2Z1bmN0aW9uIChTU1NTOkJCOkRELkYpLiBXaGlsZSBtYXBwaW5nIGEgc2luZ2xlDQo+IEJERiB0
byBhIGRldmljZSB0eXBlIGlzIHN0cmFpZ2h0Zm9yd2FyZCwgZG9pbmcgc28gYXQgc2NhbGUgYWNy
b3NzIG1hbnkNCj4gaG9zdHMgYW5kIHRob3VzYW5kcyBvZiBmYXVsdCBldmVudHMgcmVxdWlyZXMg
YWRkaXRpb25hbCB0b29saW5nIGFuZA0KPiBtYW51YWwgY3Jvc3MtcmVmZXJlbmNpbmcuIEluY2x1
ZGluZyB0aGUgdmVuZG9yOmRldmljZSBJRCBkaXJlY3RseSBpbg0KPiB0aGUgbG9nIGxpbmUgbWFr
ZXMgZWFjaCBldmVudCBzZWxmLWNvbnRhaW5lZCBhbmQgaW1tZWRpYXRlbHkgYWN0aW9uYWJsZQ0K
PiB3aXRob3V0IGFueSBwb3N0LXByb2Nlc3NpbmcuDQoNCg0KU29ycnksIGJ1dCB3aHkgYXJlIHVu
ZXhwZWN0ZWQgRE1BIGZhdWx0cyBoYXBwZW5pbmcgImF0IHNjYWxlIiBpbiB0aGUNCmZpcnN0IHBs
YWNlPyBJZiB5b3UgaGF2ZSBzbyBtYW55IGJyb2tlbiBkcml2ZXJzIHRoYXQgZGlzYW1iaWd1YXRp
bmcgdGhlbQ0KbmVlZHMgaGVscCBmcm9tIHRoZSBrZXJuZWwsIHNvbWV0aGluZyBzZWVtcyBmdW5k
YW1lbnRhbGx5IHdyb25nIHdpdGgNCnRoYXQgcGljdHVyZS4gQ29udmVyc2VseSBpZiB0aGVzZSBh
cmUgZGV2aWNlcyBhc3NpZ25lZCB0byB1c2Vyc3BhY2UgdGhlbg0Kd2Ugc2hvdWxkIHBlcmhhcHMg
cmVjb25zaWRlciB0aGVpciBhYmlsaXR5IHRvIHNwYW0gdXAgdGhlIGhvc3Qga2VybmVsDQpsb2cg
YXQgd2lsbCBhbnl3YXkuDQoNCg0KSSdtIG5vdCBzYXlpbmcgSSBuZWNlc3NhcmlseSBoYXZlIGFu
eXRoaW5nIGFnYWluc3QgdGhpcyBjaGFuZ2UgaW4NCnBhcnRpY3VsYXIsIGJ1dCBpdCBoYXMgYSBz
dHJvbmcgc21lbGwgb2YgZWZmb3J0IGJlaW5nIHNwZW50IG9uIHRoZSB3cm9uZw0KdGhpbmcuLi4N
Cg0KDQooQW5kIGV2ZW4gdGhlbiBBRkFJQ1MgaXQgb25seSByZWFsbHkgaGVscHMgaW4gdGhlIHNw
ZWNpZmljIHNjZW5hcmlvIG9mDQpoYXZpbmcgb25seSBvbmUgb2YgZWFjaCB0eXBlIG9mIGRldmlj
ZSwgb3RoZXJ3aXNlIHlvdSdyZSBiYWNrIHRvIHN0aWxsDQpuZWVkaW5nIHBlci1zeXN0ZW0ga25v
d2xlZGdlIG9mIGhvdyBCREZzIG1hcCB0byBwaHlzaWNhbCBpbnN0YW5jZXMgdG8NCmtub3cgd2hh
dCdzIHdoYXQuKQ0KDQoNClRoYW5rcywNClJvYmluLg0KDQoNCj4gVGhpcyBzZXJpZXMgYWRkcyB2
ZW5kb3I6ZGV2aWNlIElEIChWVlZWOkREREQpIHRvIElPTU1VIGV2ZW50IGxvZ3MgZm9yDQo+IEFS
TSBTTU1VdjMsIEludGVsIFZULWQgYW5kIEFNRCBJT01NVS4NCj4NCj4gQmVmb3JlOg0KPiBhcm0t
c21tdS12MyBhcm0tc21tdS12My4wLmF1dG86IGV2ZW50OiBGX1RSQU5TTEFUSU9OIGNsaWVudDog
MDAwMDoyYjoxMS42DQo+IHNpZDogMHgxNThlIHNzaWQ6IDB4MCBpb3ZhOiAweDI4MDAwMDAwMDAw
MCBpcGE6IDB4MA0KPiBETUFSOiBbRE1BIFdyaXRlIE5PX1BBU0lEXSBSZXF1ZXN0IGRldmljZSBb
ODY6MDAuMF0gZmF1bHQgYWRkciAweGUwMDAwMDAwDQo+IFtmYXVsdCByZWFzb24gMHgwNV0gUFRF
IFdyaXRlIGFjY2VzcyBpcyBub3Qgc2V0DQo+IEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19QQUdF
X0ZBVUxUIGRldmljZT0wMDAwOjQxOjAwLjAgZG9tYWluPTB4MDAwYQ0KPiBhZGRyZXNzPTB4ZTAw
MDAwMDAgZmxhZ3M9MHgwMDIwXQ0KPg0KPiBBZnRlcjoNCj4gYXJtLXNtbXUtdjMgYXJtLXNtbXUt
djMuMC5hdXRvOiBldmVudDogRl9UUkFOU0xBVElPTiBjbGllbnQ6IDAwMDA6MmI6MTEuNiBbODA4
NjoxNTMzXQ0KPiBzaWQ6IDB4MTU4ZSBzc2lkOiAweDAgaW92YTogMHgyODAwMDAwMDAwMDAgaXBh
OiAweDANCj4gRE1BUjogW0RNQSBXcml0ZSBOT19QQVNJRF0gUmVxdWVzdCBkZXZpY2UgWzAwMDA6
ODY6MDAuMCA4MDg2OjE1MzNdIGZhdWx0IGFkZHIgMHhlMDAwMDAwMA0KPiBbZmF1bHQgcmVhc29u
IDB4MDVdIFBURSBXcml0ZSBhY2Nlc3MgaXMgbm90IHNldA0KPiBBTUQtVmk6IEV2ZW50IGxvZ2dl
ZCBbSU9fUEFHRV9GQVVMVCBkZXZpY2U9MDAwMDo0MTowMC4wIDgwODY6MTUzMyBkb21haW49MHgw
MDBhDQo+IGFkZHJlc3M9MHhlMDAwMDAwMCBmbGFncz0weDAwMjBdDQo+DQo+IFBhdGNoIDEgYWRk
cyB2ZW5kb3I6ZGV2aWNlIElEIHRvIEFSTSBTTU1VdjMgdHJhbnNsYXRpb24gZmF1bHQgbG9ncy4N
Cj4gUGF0Y2ggMiBhZGRzIFBDSSBzZWdtZW50IGFuZCB2ZW5kb3I6ZGV2aWNlIElEIHRvIEludGVs
IFZULWQgRE1BUg0KPiBmYXVsdCBsb2dzLg0KPiBQYXRjaCAzIGFkZHMgYSBkZXZpZF9zdHIgaGVs
cGVyIGFuZCB2ZW5kb3I6ZGV2aWNlIElEIHRvIGFsbCBBTUQgSU9NTVUNCj4gZXZlbnQgbG9nIHBh
dGhzLg0KPg0KPiBUZXN0aW5nOg0KPiBCdWlsZC10ZXN0ZWQgYWdhaW5zdCBtYWlubGluZSBMaW51
eCAodG9ydmFsZHMvbWFzdGVyKS4NCj4NCj4gUnVudGltZS10ZXN0ZWQgb24gYSBjdXN0b20gZG93
bnN0cmVhbSBicmFuY2ggb24gQVJNIFNNTVV2MywgSW50ZWwgVlQtZCBhbmQNCj4gQU1EIElPTU1V
IGhvc3RzLiBUcmFuc2xhdGlvbiBmYXVsdHMgd2VyZSBpbmR1Y2VkIGluIGEgdmlydHVhbGl6ZWQg
c2V0dXANCj4gYnkgcmVtb3ZpbmcgRE1BIG1hcHBpbmdzIGZvciBhbiBpbi11c2UgcmVnaW9uLCBj
YXVzaW5nIHRoZSBhc3NpZ25lZCBkZXZpY2Uncw0KPiBzdWJzZXF1ZW50IERNQSB0cmFuc2FjdGlv
bnMgdG8gaGl0IHVubWFwcGVkIElPVkFzIGFuZCBwcm9kdWNlDQo+IHRyYW5zbGF0aW9uIGZhdWx0
IGV2ZW50cy4gVGhlIHJlc3VsdGluZyBsb2cgbGluZXMgd2VyZSB2ZXJpZmllZCB0bw0KPiBjb250
YWluIHRoZSBQQ0kgdmVuZG9yOmRldmljZSBJRCBvbiBhbGwgdGhyZWUgcGxhdGZvcm1zLg0KPg0K
PiBMaWxpdCBKYW5wb2xhZHlhbiAoMSk6DQo+IGlvbW11L2FybS1zbW11LXYzOiBQcmludCBQQ0kg
dmVuZG9yOmRldmljZSBJRCBpbiBTTU1VIHRyYW5zbGF0aW9uDQo+IGZhdWx0IGxvZ3MNCj4NCj4g
WWlnaXQgT2d1eiAoMik6DQo+IGlvbW11L3Z0LWQ6IEFkZCBQQ0kgc2VnbWVudCBhbmQgdmVuZG9y
OmRldmljZSBJRCB0byBETUFSIGZhdWx0IGxvZ3MNCj4gaW9tbXUvYW1kOiBBZGQgdmVuZG9yOmRl
dmljZSBJRCB0byBBTUQgSU9NTVUgZXZlbnQgbG9ncw0KPg0KPiBkcml2ZXJzL2lvbW11L2FtZC9p
b21tdS5jIHwgOTQgKysrKysrKysrKysrKy0tLS0tLS0tDQo+IGRyaXZlcnMvaW9tbXUvYXJtL2Fy
bS1zbW11LXYzL2FybS1zbW11LXYzLmMgfCAyOSArKysrKystDQo+IGRyaXZlcnMvaW9tbXUvaW50
ZWwvZG1hci5jIHwgMzMgKysrKystLS0NCj4gMyBmaWxlcyBjaGFuZ2VkLCAxMDQgaW5zZXJ0aW9u
cygrKSwgNTIgZGVsZXRpb25zKC0pDQo+DQoNCg0KDQoNCg0KCgoKQW1hem9uIFdlYiBTZXJ2aWNl
cyBEZXZlbG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJIClRhbWFyYS1EYW56LVN0ci4gMTMKMTAy
NDMgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0b2YgSGVsbG1pcywgQW5kcmVhcyBT
dGllZ2VyCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhS
QiAyNTc3NjQgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=

