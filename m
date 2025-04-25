Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010007.outbound.protection.outlook.com [52.101.69.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523DB228CBC
	for <iommu@lists.linux.dev>; Fri, 25 Apr 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745559148; cv=fail; b=HJcT7c3LiYtseCYR64386If1OFdamnyb4D5VzCdyOi7SNrOw138HReE4zDYNEYQLWNhGkHv6dGnbQ7qdmZOo/P8Dz854GQF5rno14cxvgwbM4NJFoAZqyTqbcAZwA97mnYhfV+kL8q4w+rxisR2KO+IPZfIgbc+2mOb7wntZjxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745559148; c=relaxed/simple;
	bh=Te/bLmoEaGFKTzml4m3HBcmgGoGeLIo1OVfgKS17PDw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O83FmlWjaXIxS5RuaMrWLbUgDN36ndHZwfCjJ9QVU25yFTcGeKvot9nPGWfb+fzo9yMIoMSqkpOZnAuSGfV6ZmYDIRSwnH2LcOrlcGrqnLX8MvfidbJaB+wkvTYyuC9UW5R9SkEv44g/4HYne8b+z426zh4FgObeJS+CLTS0b9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Rn7tIbUu; arc=fail smtp.client-ip=52.101.69.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Rn7tIbUu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl+DLOQWAZfdKwgADe9t3vUAmVibmZwFODMdpy0uKLGfvp3Z/TucLX8h+EeYWdT/i5XtjfTJObR7hN72BTOUJxl/GMOcuGu3U/ui2f/4VBvk09aerU4p/V0lzEghIiJelITPFLBhqLU/JCnhAloS7USke7Mwg1TP3oRWK3B+HK5ifO7qTxjCZNHCP+3tJ5U3SscMSEmOgHcIN5B6PSc9EDoX0ZJ0Omw57tVFZLuME0OssG5KZPUbhgSD8KivAcRXGp7w6kdEtA0OKQFXZHouP+bnQpUzyY3X2aeno6qR+ndEW58xBZnHcHSMoncNr1AKggSELGbkAZ0cH+qhw0BOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te/bLmoEaGFKTzml4m3HBcmgGoGeLIo1OVfgKS17PDw=;
 b=QGJei84Scocn6InhT1Vo7NAaItqrAok99PNLoyzF0wCNSc39JP7k4N1PtTFsyXIicM16tMatQQ2vbQnMFV799FsmdLgpspR8lODcMQ1ylWZAuvbv08pzv8b5eSA1l8nPQQLZV1rbyNweQUgDrp6o2YRysFsEJyB0U97baOZ964ONZDKTnAJLOcAoIDGTpFPTHujYS3PFs1K9TjLJsthnH0DK2zctg7pIEoKxO2VE4BlWPIHUhDe0VwCn9NqFsFApQJD0HvgBiTGlCsFcjhVRBDYPf627Hmjr6Z4pKgfAzWAfvcxYekH5f4DIADNw3cUXyhoBj6j5IvO/UpXc1c2cQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te/bLmoEaGFKTzml4m3HBcmgGoGeLIo1OVfgKS17PDw=;
 b=Rn7tIbUu2tmAqYlQkSjiSpSBzvfpfDthlxLpL1P5kVobEM+/3P5kLQoWd+yIXugZaWSq4mbW/qA87Ucd2OQnUs5h7lEARExILh7UBD7y3XRxCGHmUQomEnjWktJWUiB5RGnJUeaYTegbN0d2IwiH2M8+IxISKGmZWexKdbqorBjbXQUMi3dzuQOc3Jwhx6cvyMqfsg3V79Za66wxpA6ruHC4lXjy4wmyDH8nSLRMrR8QW1Xf8YHYKfaW/Rz7mGNmf7S4ujzM0ynwfVYKGHc+NvBZbbkJY+15J2x8Wcc16T47QUIk0RrK/4rLZ1eOd7PzsqM1xUI3u8pugV8/uaSmsg==
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::10)
 by GV1PR10MB6707.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:85::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Fri, 25 Apr
 2025 05:32:20 +0000
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4]) by AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4%7]) with mapi id 15.20.8678.024; Fri, 25 Apr 2025
 05:32:20 +0000
From: "Li, Hua Qian" <HuaQian.Li@siemens.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Su, Bao Cheng" <baocheng.su@siemens.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
Thread-Topic: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
Thread-Index: AQHbs1EG0or5T/N2b0+7TKULFbRAc7OvsGeAgAKX8ACAAIIzAIABFaAA
Date: Fri, 25 Apr 2025 05:32:19 +0000
Message-ID: <824c8fa6acda7c840f856430b5d898c7fcd4702e.camel@siemens.com>
References:
 <CGME20250422063734eucas1p2561ad6f847f6824c9c79a842fa458e41@eucas1p2.samsung.com>
	 <20250422063719.121636-1-huaqian.li@siemens.com>
	 <fc2e30eb-2ec7-4795-a2a4-077b7fde7fd5@samsung.com>
	 <dc6f299b18f7870c7bffecca25cee9e436a32c7b.camel@siemens.com>
	 <841c417b-c61a-4c3a-a9ed-236634d78331@arm.com>
In-Reply-To: <841c417b-c61a-4c3a-a9ed-236634d78331@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6993:EE_|GV1PR10MB6707:EE_
x-ms-office365-filtering-correlation-id: 665d7cff-b4b5-4e4e-25c9-08dd83ba8c73
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXVyYUpLem9RazYzMUFtTkV6R3NxZmI5eUxDYkNKQ2Vic0dkT2hNVkFQb09k?=
 =?utf-8?B?WHRQYzBoS1gvTTdkQjhpV3U3WWRWSnFoUkNYd3lFaW9UQlpndll6N3cxYjJB?=
 =?utf-8?B?bTNoOGdiQjdxM3NxdjZPWXp0NWRJL3hDUjh0NEhuaVpQdUg4c3RvVEozNlJW?=
 =?utf-8?B?N0dleW44NFZEeW9WUzd1Mm1FbklZd1huNnFZR2xwbjZtVnVHRDlHRnpiMkFs?=
 =?utf-8?B?aHZnUEtMMXViN1lITERxLy9neit3OE1zUFBVanBJM1NBeXg5U1NaeUlMNHlh?=
 =?utf-8?B?ZU9SSlhmZi9HTkhRWG1nQm1iMXR4NkNGU1VHRnZHZ3lMNC9aOU9Vdjk2UWdU?=
 =?utf-8?B?SzJ6aHBWS0dQNDBBYjJmY3BFWnhlS2pQR3Btc3FVTE8zRGRXc2FDcWQ4dWNN?=
 =?utf-8?B?VGhpN1QrV2F0Si9tdFMzN1hKZXJhWmt6dU5VWEttenpVUyt6YlNMVmFEaXVy?=
 =?utf-8?B?OUQvSDNvTk9oTVpQTFAwWVYyeUZaYnlCdnVSQmdPK0JCRnp0Vm41V3J5VWpu?=
 =?utf-8?B?Tk5sUGV3UjJEVzUzRnFaQ2psZ2VRRzRSdytsb3RseHQxaDNnMUZBWXp2TjNR?=
 =?utf-8?B?dWtXUmJ5WXJDN1FrenhRbmJKQ1FWM0ViUzBMWmFYNWRaaDNWdkZXT21UTTNK?=
 =?utf-8?B?ZUcwZ0ltT1RtV3pHWUtTdmtXYXI1aXBrMlUzOUhEOFkxZ1JSZmlPOEh6T3Nz?=
 =?utf-8?B?NG41MnB5anlNQXpOc0locXRWdldCK1pGaE1MYk1pakFyeXVDcHJUb0NYbXh4?=
 =?utf-8?B?S0VvWlZJOXQvaGlaVWVQM0I0MDRtMlVMVmlULzQ5TkNycytPNEZlR2pseXlp?=
 =?utf-8?B?N2xUWEVLNlYzbUdKMWVZSkI0bzZkMUc2M3BONURqNGZnMFN2c1NzQks3NG9R?=
 =?utf-8?B?Z1ByUGNkTUlOT2JueWcwb3BNZUVuaTFOV0wyUUdUVzRyTTJpUWJXdUlLbVQy?=
 =?utf-8?B?QlZFUWxVVk1XK3AyS1JqNFN2cXdlZVZnYnhWUnNhQklBa3IvdFBSY0U3S1F0?=
 =?utf-8?B?Z1kyTHdqSGhzN3NyUmdBZ3pkM0VIVEVqcjBkZVhEemQ3VFRBeERWeDZSVFhu?=
 =?utf-8?B?bFkyVitueStyd3RNVXN0TW9NZG5xNENuU3ZYNUtOWldpVS8xSzdlUVVnZGVQ?=
 =?utf-8?B?U3pMKzdoUE1LYWVtWi9pZWFCaFdha0crckQxNU5xV2NmdDhMVE5oYmZEZ2NL?=
 =?utf-8?B?Q2ViQmFJZTNrQmdKMWNRVDJLREpBZUp1bmh3QnJsMTVrWkxRQkdCL3k3RTFo?=
 =?utf-8?B?bFY4QkRtenY0SmJnZG96Sy8vSm55bStIQjFGRndQYStMM3Fva1N1bkRiTzJX?=
 =?utf-8?B?YVlESGRiMnR3NlNQOUFKMS9XaXRDWUpWQko1bUpUQ1RnR2h6cDRCWUUyQmJJ?=
 =?utf-8?B?cG1GVUNRbDlha1ZVKyt3NGpRazNlMkY0YWw4MGtwU0puQmNoRkFYRlVWWklQ?=
 =?utf-8?B?NWJhR2Y5a0lUMG80SWljZEtGR1piRG9Hd0N5dkY2NXE5NW9FNEFaM2tCMEFZ?=
 =?utf-8?B?RlhnUTNvYUNoRUhHN1dQT0tFNFR0ZzZHVHFmOXBqcmhQRkVXWE0xck5VNlNK?=
 =?utf-8?B?NUE2WVd5YVdwZDhYdXE0TlJSUmx1ZGR5RTZyWSs4aE1IK29UOFZ5SDNoZ2Rv?=
 =?utf-8?B?b3JSWXBWaWRCMldpWVpRZHlwcEh5dG52MGxNRUlyS0Y1cWoxTkRJb0NiNWla?=
 =?utf-8?B?QnlTcDBpUUM0d0RWd1RkKzRvcFVtME1ZNE40d1ZmUEVHUzFwcTUrRkVUSy85?=
 =?utf-8?B?b3Rqb01Bd3hlY3owNDFCa2ttak1ma3cvajE2OHV5KzNJdmtITTVBKzlIdVYv?=
 =?utf-8?B?MVpod2JPbGI5N2dxRWxDL3FDeW5IT05LbStTakJvUUJwdmhES2hIWGNseDJr?=
 =?utf-8?B?OW1UMUF3WTRndUtGN2J6UnhrakF0SHpBRVVwbDh3dmduRW5RaTh2MGsvdGhu?=
 =?utf-8?Q?++6znmY7nlHwYUzoKtlMNUwKS/t5tvdZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anpPcUZXcnMvd0tCUWtueWM5MUtMZVJUdXAwNm1XTDhYYjdOVkhzNERLZGVn?=
 =?utf-8?B?ZU1jaGZpK0cybzZnQmJSSmhDNHlWdGI2ZVZOMW1tLzVCZjJEakpOSVFIRUZk?=
 =?utf-8?B?UCtsYWpCLy9qVGxic21tclhYc2lRSnlEdmtsUlZhV3hFWWxubFJ6MER4R1lF?=
 =?utf-8?B?OUtBZEFmanE3bFNZa0NpUWdoSk1zOThiVEFpbGlmbWxVWEQ4MEtuQk1JQncy?=
 =?utf-8?B?eDc5K1AvNEpYOWpHci92aEZvemZFYm1MQjFRaU16bDk3b0o3TkI3MVBEVy9a?=
 =?utf-8?B?UlhLVzVtSmIweG1qTGM0aUtJT1M3eFp2V0F1V3YrWXE5bE82TWxuV0FFM1lk?=
 =?utf-8?B?MzVjb0RPSE1semJQRzhhWWZpWFV4SFE3NW4zTnc1ZExlMkFCWWtWaFZHa2pi?=
 =?utf-8?B?ODF4Yzc5VmEyWjQvWmNVWG5XMmliWjl0dkhIRVNJUXZlMndoR2doeDQzL2lS?=
 =?utf-8?B?RytKdGVKSUUrYjNRMkc2M1psWXUvN1hRbW1oV3l3ZG1RYm5OTzhad1VsRHZ1?=
 =?utf-8?B?YjVlZlFBa3A0Tkd6VnRpWStMeG1UL3RqOUp5cHFsUVdvdW1CaklMek9aOEhB?=
 =?utf-8?B?TGxsN3JBOTJvTkJhbTE1V2RvcGp6dUZ6aWJDMWtPNW5NNFBJT1Y3SmpnREs0?=
 =?utf-8?B?dVYwMFgxNFFKTmhaQW9vVCt3ZFgzUCtxeEhWZ3JPTHY1SWdHdDNrNUI2Z3ps?=
 =?utf-8?B?RmhvNUtZN1ZNd0x0YkdZNGM3T2R5aUdVUlBsOUk5OTBNV0RKZ3FrTm9mR3p3?=
 =?utf-8?B?MDlxUFFaYWtKeG1OWUViWjJNNldvR0UySnlPd2FucEF2VlgrbzBpbFViQjhy?=
 =?utf-8?B?bmpxLy9SbCt1R1JUU1pvQk14d29zd2FZWWZrR2NjVGp3TFRpclBGMklQYVBQ?=
 =?utf-8?B?V0ZqeTk1L3EyQjY4REkzdDl4cUhtT2VjY2lENjFXbktybmt4UDdIa2dmOTl3?=
 =?utf-8?B?Y25UK2JsdnlHVUxDVGZZUC9xYVpqSEgrV3RDZU9vZHdaejJ0Q3puT1NqT2x2?=
 =?utf-8?B?Y1RpTnE1TmFORk5jTFNjQlVGOVY0S2hoRFJOWEtTNWRPVVcxdG9HTCtHTnpB?=
 =?utf-8?B?a1d3L1pQVitnalNKSkJwVjlWMm1JY3BrZnVaakRBTmNjU3lWaDVVUkFtTkZy?=
 =?utf-8?B?UjhjR1ZUV0cwNHhEQmdFYlY4S1NIc3JQTnBHOStJdDdQZkEyNkFyZGFQWi9M?=
 =?utf-8?B?SHdHWUt2Wk9BRzQ2alhqcHBEKzNRMmgxZlpLODYwRGFCM3YvZFoweDM1Vkd1?=
 =?utf-8?B?NTlCVHhHN2l2bS9uVTdINjJiM09NZFlBcDRhQk9maXBhd1NmRFVCNm56SE0x?=
 =?utf-8?B?YmVYTnB4dW1PT25vMTN0MlNXcHhPOVh2THp4REF0VGRabC9BeWRBQ3VtdWJp?=
 =?utf-8?B?V3VpUWw3RHhvRzdVRlNGbmtvcE1laWczZ28vMU9zdVIxUHEzSGh0NWc4bHpz?=
 =?utf-8?B?VlZLOCtnMy9EdmZ4RWlPbkZoWXNWSWRJRldPbFBwOEYwcFBndzNWbjhOL2s4?=
 =?utf-8?B?UkFXUTVSY2RrL096OUU2YXYyd241aHpCTlFOUVhKVExMait1WWltVDBETk1X?=
 =?utf-8?B?Y3VxUGE1TXJTYkMzcmY4bk5mR3FZU09ZeUI5VkpzWDMzVUVndXRXclE0cUw2?=
 =?utf-8?B?TERoRTNoNldiaW94dlJieWlzdW5LNnNUSjJBbC9JN25ReGVmc1ZnSXZFSzN5?=
 =?utf-8?B?M3JQK1dxbWJ1bjdWSlZEWTBmcEc1bWI3N1ZDNW9iN05YaExNbjNHc3JHK2tz?=
 =?utf-8?B?c0J1UlIvY2RNRnJvdkJOeDQ4dG83SDJVMWtsWFZqK1RuY1ZUc1BhbFFQcklO?=
 =?utf-8?B?dGNvcVd5VHFVNlRIS1hBYkxhTGVqK3h1R2g5aVdnZmY2OHFUcm9ySTdRdXhj?=
 =?utf-8?B?cElLTFhzWGZoUkNJM202ZE51azBzZWtFbHlJVU5HMU14VnFWUnM0Ym00RGs2?=
 =?utf-8?B?L05Mb0VvYzNYTUtCYkhjcGxnNUFaK3lHTzBJNGliUERKa3dweG9aOFFKMHBD?=
 =?utf-8?B?N3BBWmg5bFcyOVltbGJrNHhnOWtOQnhlOWl4ajlGdG9xajhPQ1ZFNHdWRVp5?=
 =?utf-8?B?ZTZtR3lrMTZBdmpPNjRSeG5JZElsMUtuc1hsM2x4MWFUdGxLaHNlS0w4VkhL?=
 =?utf-8?B?RjNWUjlCMFptTUlpMnV1bWE3VTZob2RrL3NIRWNwbG16N05JYzRJWjhoY01h?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4BE713ACE0D854696A17FDF5B9BD7C7@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 665d7cff-b4b5-4e4e-25c9-08dd83ba8c73
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 05:32:19.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HFGCg3qen41CJcjYX3E966pOWLP4v+u3y7sYaLzb34qDIQrEZSxMbUR6qenmOYh6vLHafhaIjBIzDq8kqPjKMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6707

T24gVGh1LCAyMDI1LTA0LTI0IGF0IDEzOjU4ICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDI0LzA0LzIwMjUgNjoxMiBhbSwgTGksIEh1YSBRaWFuIHdyb3RlOg0KPiA+IE9uIFR1ZSwg
MjAyNS0wNC0yMiBhdCAxNTozNiArMDIwMCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToNCj4gPiA+
IE9uIDIyLjA0LjIwMjUgMDg6MzcsIGh1YXFpYW4ubGlAc2llbWVucy5jb20gd3JvdGU6DQo+ID4g
PiA+IEZyb206IExpIEh1YSBRaWFuIDxodWFxaWFuLmxpQHNpZW1lbnMuY29tPg0KPiA+ID4gPg0K
PiA+ID4gPiBUaGlzIHBhdGNoc2V0IGludHJvZHVjZXMgYSBjaGFuZ2UgdG8gbWFrZSB0aGUgSU9f
VExCX1NFR1NJWkUNCj4gPiA+ID4gcGFyYW1ldGVyDQo+ID4gPiA+IGNvbmZpZ3VyYWJsZSB2aWEg
YSBuZXcga2VybmVsIGNvbmZpZ3VyYXRpb24gb3B0aW9uDQo+ID4gPiA+IChDT05GSUdfU1dJT1RM
Ql9TRUdTSVpFKS4NCj4gPiA+ID4NCj4gPiA+ID4gSW4gY2VydGFpbiBhcHBsaWNhdGlvbnMsIHRo
ZSBkZWZhdWx0IHZhbHVlIG9mIElPX1RMQl9TRUdTSVpFDQo+ID4gPiA+ICgxMjgpDQo+ID4gPiA+
IG1heQ0KPiA+ID4gPiBub3QgYmUgc3VmZmljaWVudCBmb3IgbWVtb3J5IGFsbG9jYXRpb24sIGxl
YWRpbmcgdG8gcnVudGltZQ0KPiA+ID4gPiBlcnJvcnMuDQo+ID4gPiA+IEJ5DQo+ID4gPiA+IG1h
a2luZyB0aGlzIHBhcmFtZXRlciBjb25maWd1cmFibGUsIHVzZXJzIGNhbiBhZGp1c3QgdGhlDQo+
ID4gPiA+IHNlZ21lbnQNCj4gPiA+ID4gc2l6ZSB0bw0KPiA+ID4gPiBiZXR0ZXIgc3VpdCB0aGVp
ciBzcGVjaWZpYyB1c2UgY2FzZXMsIGltcHJvdmluZyBmbGV4aWJpbGl0eSBhbmQNCj4gPiA+ID4g
c3lzdGVtDQo+ID4gPiA+IHN0YWJpbGl0eS4NCj4gPiA+DQo+ID4gPiBDb3VsZCBZb3UgZWxhYm9y
YXRlIGEgYml0IG1vcmUgd2hhdCBhcmUgdGhvc2UgY2VydGFpbg0KPiA+ID4gYXBwbGljYXRpb25z
DQo+ID4gPiB0aGF0DQo+ID4gPiByZXF1aXJlIGluY3JlYXNpbmcgSU9fVExCX1NFR1NJWkU/IEkn
bSBub3QgYWdhaW5zdCBpdCwgYnV0IHN1Y2gNCj4gPiA+IGNoYW5nZQ0KPiA+ID4gc2hvdWxkIGJl
IHdlbGwganVzdGlmaWVkIGFuZCBkZXNjcmliZWQsIHdoaWxlIHRoZSBhYm92ZSBjb3Zlci0NCj4g
PiA+IGxldHRlcg0KPiA+ID4gZG9lc24ndCBwcm92aWRlIGFueXRoaW5nIG1vcmUgdGhhbiBpcyB3
cml0dGVuIGluIHRoZSBwYXRjaA0KPiA+ID4gZGVzY3JpcHRpb24uDQo+ID4gVGhhbmsgeW91IGZv
ciB5b3VyIGZlZWRiYWNrLCBNYXJlay4NCj4gPg0KPiA+IFRvIHByb3ZpZGUgbW9yZSBjb250ZXh0
LCBvbmUgc3BlY2lmaWMgYXBwbGljYXRpb24gdGhhdCByZXF1aXJlcw0KPiA+IGluY3JlYXNpbmcg
SU9fVExCX1NFR1NJWkUgaXMgdGhlIEhhaWxvIDggUENJZSBBSSBjYXJkLiBUaGlzIGNhcmQNCj4g
PiB1c2VzDQo+ID4gZG1hX2FsbG9jX2NvaGVyZW50IHRvIGFsbG9jYXRlIGRlc2NyaXB0b3IgbGlz
dHMsIGFzIHNlZW4gaW4gdGhlDQo+ID4gSGFpbG8NCj4gPiBkcml2ZXIgaW1wbGVtZW50YXRpb24g
aGVyZToNCj4gPiBodHRwczovL2dpdGh1Yi5jb20vaGFpbG8tYWkvaGFpbG9ydC1kcml2ZXJzL2Js
b2IvNzE2MWY5ZWU1OTE4MDI5YmQ0NDk3ZjU5MDAwM2MyZjg3ZWMzMjUwNy9saW51eC92ZG1hL21l
bW9yeS5jI0wzMjINCj4gPiBUaGUgbWF4aW11bSBzaXplIChuc2xvdHMpIGZvciB0aGVzZSBhbGxv
Y2F0aW9ucyBjYW4gcmVhY2ggMTYwLA0KPiA+IHdoaWNoDQo+ID4gZXhjZWVkcyB0aGUgY3VycmVu
dCBkZWZhdWx0IHZhbHVlIG9mIElPX1RMQl9TRUdTSVpFICgxMjgpLg0KPiA+DQo+ID4gU2luY2Ug
SU9fVExCX1NFR1NJWkUgaXMgZGVmaW5lZCBhcyBhIGNvbnN0YW50IGluIHRoZSBrZXJuZWw6DQo+
ID4NCj4gPiBgI2RlZmluZSBJT19UTEJfU0VHU0laRSAxMjhgDQo+ID4NCj4gPg0KPiA+IHRoaXMg
bGltaXRhdGlvbiBjYXVzZXMgc3dpb3RsYl9zZWFyY2hfcG9vbF9hcmVhLA0KPiA+IGh0dHBzOi8v
Z2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibGFtZS92Ni4xNS1yYzIva2VybmVsL2RtYS9zd2lv
dGxiLmMjTDEwODUNCj4gPiAsDQo+ID4gKG9yIHN3aW90bGJfZG9fZmluZF9zbG90cyBpbiBvbGRl
ciBrZXJuZWxzKSB0byBmYWlsIHdoZW4gYXR0ZW1wdGluZw0KPiA+IHRvDQo+ID4gYWxsb2NhdGUg
Y29udGlndW91cyBwaHlzaWNhbCBtZW1vcnkgKENNQSkuIFRoaXMgcmVzdWx0cyBpbiBydW50aW1l
DQo+ID4gZXJyb3JzIGFuZCBwcmV2ZW50cyB0aGUgSGFpbG8gOCBjYXJkIGZyb20gZnVuY3Rpb25p
bmcgY29ycmVjdGx5IGluDQo+ID4gY2VydGFpbiBjb25maWd1cmF0aW9ucy4NCj4NCj4gSG1tLCBk
bWFfYWxsb2NfY29oZXJlbnQoKSBzaG91bGQgcmVhbGx5IG5vdCBiZSB0cnlpbmcgdG8gYWxsb2Nh
dGUNCj4gZnJvbQ0KPiBTV0lPVExCIGluIHRoZSBmaXJzdCBwbGFjZSAtIGhvdyBpcyB0aGF0IGhh
cHBlbmluZz8NCj4NCj4gSWYgeW91J3JlIHVzaW5nIHJlc3RyaWN0ZWQgRE1BIGZvciBhIGRldmlj
ZSB3aGljaCB3YW50cyBzaWduaWZpY2FudA0KPiBjb2hlcmVudCBhbGxvY2F0aW9ucywgdGhlbiBp
dCB3YW50cyB0byBoYXZlIGl0J3Mgb3duIHNoYXJlZC1kbWEtcG9vbA0KPiBmb3INCj4gdGhvc2Ug
KmFzIHdlbGwqIGFzIHRoZSByZXN0cmljdGVkLWRtYS1wb29sIGZvciBib3VuY2luZyBzdHJlYW1p
bmcNCj4gRE1BLg0KPg0KPiBUaGFua3MsDQo+IFJvYmluLg0KDQpIaSBSb2JpbiwNCg0KUmVnYXJk
aW5nIHRoZSBzcGVjaWZpYyBIYWlsbyBDYXJkIGNhc2UsIHRoZSBpc3N1ZSBhcmlzZXMgZHVlDQp0
byB0aGUgY2FwYWJpbGl0aWVzIG9mIGNlcnRhaW4gU29DcyBvciBDUFVzLiBGb3IgZXhhbXBsZSwg
bWFueQ0KSzMgU29DcyBsYWNrIGFuIElPTU1VLCB3aGljaCBpcyB0eXBpY2FsbHkgdXNlZCB0byBp
c29sYXRlIHRoZQ0Kc3lzdGVtIGFnYWluc3QgRE1BLWJhc2VkIGF0dGFja3Mgb2YgZXh0ZXJuYWwg
UENJIGRldmljZXMuDQoNClRha2luZyB0aGUgVEkgQU02NSBhcyBhbiBleGFtcGxlLCBpdCBkb2Vz
bid0IGhhdmUgYW4gSU9NTVUsIGJ1dA0KaW5zdGVhZCBpbmNsdWRlcyBhIFBlcmlwaGVyYWwgVmly
dHVhbGl6YXRpb24gVW5pdCAoUFZVKS4gVGhlDQpQVlUgcHJvdmlkZXMgZnVuY3Rpb25hbGl0eSBz
aW1pbGFyIHRvIGFuIElPTU1VIGFuZCBpcyB1c2VkIHRvDQppc29sYXRlIFBDSSBkZXZpY2VzIGZy
b20gdGhlIExpbnV4IGhvc3QsIGFuZCB0aGUgU1dJT1RMQiBpcw0KdXNlZCB0byBtYW5wIGFsbCBE
TUEgYnVmZmVycyBmcm9tIGEgc3RhdGljIG1lbW9yeSBjYXJ2ZS1vdXQuDQoNCllvdSBjYW4gZmlu
ZCBtb3JlIGRldGFpbHMgYW5kIGJhY2tncm91bmQgaW5mb3JtYXRpb24gaGVyZToNCmh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDQyMjA2MTQwNi4xMTI1MzktMS1odWFxaWFuLmxpQHNp
ZW1lbnMuY29tLw0KDQo+DQo+ID4gQnkgbWFraW5nIElPX1RMQl9TRUdTSVpFIGNvbmZpZ3VyYWJs
ZSB2aWEgYSBrZXJuZWwgY29uZmlndXJhdGlvbg0KPiA+IG9wdGlvbg0KPiA+IChDT05GSUdfU1dJ
T1RMQl9TRUdTSVpFKSwgdXNlcnMgY2FuIGFkanVzdCB0aGUgc2VnbWVudCBzaXplIHRvDQo+ID4g
YWNjb21tb2RhdGUgc3VjaCB1c2UgY2FzZXMuIFRoaXMgY2hhbmdlIGltcHJvdmVzIGZsZXhpYmls
aXR5IGFuZA0KPiA+IGVuc3VyZXMgdGhhdCBzeXN0ZW1zIGNhbiBiZSB0YWlsb3JlZCB0byBtZWV0
IHRoZSByZXF1aXJlbWVudHMgb2YNCj4gPiBzcGVjaWZpYyBoYXJkd2FyZSwgc3VjaCBhcyB0aGUg
SGFpbG8gOCBQQ0llIEFJIGNhcmQsIHdpdGhvdXQNCj4gPiByZXF1aXJpbmcNCj4gPiBrZXJuZWwg
c291cmNlIG1vZGlmaWNhdGlvbnMuDQo+ID4NCj4gPiBJIGhvcGUgdGhpcyBleGFtcGxlIGNsYXJp
ZmllcyB0aGUgbmVlZCBmb3IgdGhpcyBjaGFuZ2UuIFBsZWFzZSBsZXQNCj4gPiBtZQ0KPiA+IGtu
b3cgaWYgZnVydGhlciBkZXRhaWxzIG9yIGFkZGl0aW9uYWwgZXhhbXBsZXMgYXJlIHJlcXVpcmVk
Lg0KPiA+DQo+ID4gQmVzdCBSZWdhcmRzLA0KPiA+IExpIEh1YSBRaWFuDQo+ID4gPg0KPiA+ID4N
Cj4gPiA+ID4gTGkgSHVhIFFpYW4gKDEpOg0KPiA+ID4gPiAgICAgc3dpb3RsYjogTWFrZSBJT19U
TEJfU0VHU0laRSBjb25maWd1cmFibGUNCj4gPiA+ID4NCj4gPiA+ID4gICAgaW5jbHVkZS9saW51
eC9zd2lvdGxiLmggfCAyICstDQo+ID4gPiA+ICAgIGtlcm5lbC9kbWEvS2NvbmZpZyAgICAgIHwg
NyArKysrKysrDQo+ID4gPiA+ICAgIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gPiA+DQo+ID4gPiBCZXN0IHJlZ2FyZHMNCj4gPg0KDQotLQ0KSHVh
IFFpYW4gTGkNClNpZW1lbnMgQUcNCmh0dHA6Ly93d3cuc2llbWVucy5jb20vDQo=
