Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345891AA79C
	for <iommu@lists.linux.dev>; Thu, 24 Apr 2025 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745471566; cv=fail; b=bzWpzGcqgidPezGakhMLIaKd+UPs2TAhBhWPWpxSPh6uPHyMqiYCP4Afnw9h/rSTws1KCLl6sGmaKKV39lsmWXqKww9e5qimR1Cy9sdO+Eav+cleQ3tJSsfLx1PztYIFgWvifUeNV8qOI7wK+T+wO3lboNo0RO8eIrVMlRbYo7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745471566; c=relaxed/simple;
	bh=s0GrKxeFHP3xs73BYbZcfa07mK7uN7GMDsBZ4hwRFBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qvxMnHQ15zOcORfJ6P/hBi4+k9/N9QLIPDocrnmf9D8eQRgM2iHygYjS70Eqlr8Fh3jDv64ONpBVtnoWFRb51BR9lTEk00mZyV5wyiANjEIY88ofr41g4XXdzJ4XTOW9vQ9JO8VikbOKcRcj3EaJCuCi/q/hd4AtpPLsIHFg+lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Wuc1VPnj; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Wuc1VPnj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HU8xMuYVX1985GuZX5OF3HQ56N/xpoWSrk+3KMH0AJy6Nyw5O3YctUecPn4bHwhHuu9HpoPpLMocr8gUuYbM2CVxgx8lCP4eiMqpb9jUuyxLuYW0Imicdp5ET6nJu94HaS/tbdDjW8KZLaNaYTEFkkCas715/qAzrYQBCRRB1Gz6rppIAlmSTWcQv/5Cedslbn1TSzYsKgeD8DWkipmk1H6/nyaaUkuDVer0RM1rv1dd8K/1DtyP3xw7Oa/t+1aNaOgJhrnKBXlJrPgOhDLYJN6HhymjiBjSv17ynGdk7hToKx8o8tIJBJO4MzmMC92fQ+XXuK9hzWjaTgr8/eZjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0GrKxeFHP3xs73BYbZcfa07mK7uN7GMDsBZ4hwRFBw=;
 b=nDr+D38EJhVR/AORCjDrF5cp7gId/YTtHIzYBcM7+k8N/1UsIryk8eTIqpS+ceEATXFX1nUn6Ynde9a5FDpTYMIEO90/twhf7NIsBkvc4xU87jYunr0bm9hD/g1pV7pd1r88jiQpGeXuO0BVZsV8BzqnBT60o/1HRkLFtViiXjQ/Sa6dkWAOG3EZYX0QJEYth21BolN6k7a9FPKeWOIF2eTi7HdPbYavXy1DBCxQuE84Qj9mC3ceebx77xGTTyU+L+FGdKSdCTPDe8GKuRLtXIKAwIctH09TUX2sJnOhuLXSidVoUBNNKD6GLBqsXwYgvRjYN/wri708FyAVNrqLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0GrKxeFHP3xs73BYbZcfa07mK7uN7GMDsBZ4hwRFBw=;
 b=Wuc1VPnjMyRLswoZNuIJeizdNuPAEAgtBF16ZdEpcTMo8qv9DESpCgsX/E1tDmOgl6ylds0CEanJlTkkqGhCsGIgTc3O9FExQK/K0bWdfdV7d7jzXDaPQKIp5tPdI4GOJRax7W0o4KmQjkpRyByzjg9kukdEPwR8Ncwz5R/f7VOPTI4Sqa9j4RMFVzd4QJ6dBPcjVFYQAGNKLVsAXKhB+j9fXXoIN2/kpgunGO+GF+hYyPG8zYefEjvucd//qcChnu7ZfzqshY0z8QCZbz4QROiyfGYKVylV4jIS3jTtrLYD07tutXSKh4e8/zb1iMrCBe9L4espLYG3Tw1u708HrQ==
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::10)
 by GV2PR10MB6455.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Thu, 24 Apr
 2025 05:12:39 +0000
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4]) by AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4%7]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 05:12:39 +0000
From: "Li, Hua Qian" <HuaQian.Li@siemens.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Su, Bao Cheng" <baocheng.su@siemens.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
Thread-Topic: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
Thread-Index: AQHbs1EG0or5T/N2b0+7TKULFbRAc7OvsGeAgAKX8AA=
Date: Thu, 24 Apr 2025 05:12:39 +0000
Message-ID: <dc6f299b18f7870c7bffecca25cee9e436a32c7b.camel@siemens.com>
References:
 <CGME20250422063734eucas1p2561ad6f847f6824c9c79a842fa458e41@eucas1p2.samsung.com>
	 <20250422063719.121636-1-huaqian.li@siemens.com>
	 <fc2e30eb-2ec7-4795-a2a4-077b7fde7fd5@samsung.com>
In-Reply-To: <fc2e30eb-2ec7-4795-a2a4-077b7fde7fd5@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6993:EE_|GV2PR10MB6455:EE_
x-ms-office365-filtering-correlation-id: 37a0bbe6-780c-4cd0-ed35-08dd82eea25f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFMxS08xNHNpMGhYZGJra1pvT3NCVHM2ZTh3bHliRWRhSG1GYzl3Z1pOeU50?=
 =?utf-8?B?RHM3UXhvVHRXcWZjSlRIYUJ4ek9ZclZqejFCTUdCYUhhdHNzMU40Ykd5VmYw?=
 =?utf-8?B?UXRxMWd4ZTdQTndNYlZ2cWM4SE1qMndYU1pHeWd4UHdXT25VZmVaZkNLOHZp?=
 =?utf-8?B?VTZGcHBVUmR6S0E0SVF5T1VIR1U2bFNNN2htMzY0S0diWjY2Qmh5MDBPa2NK?=
 =?utf-8?B?bWVOUkppTlRVcHZtV25raUUxSUltTzlmVW9nbFQ3WE50bDV1QW1hb2tCcGhk?=
 =?utf-8?B?QTZxSG5HVGhWbTYveGlGQXhieFpscm9yb3MzQzlITC8yRFUzRVBzRGFVbUFF?=
 =?utf-8?B?aTdXY25QaHZPM3JQbkVjK0thWkxlbjZUeFZuTm9ac2dBTnZNWmtaSUFZb293?=
 =?utf-8?B?RTNiSzJZUVJqcFhOV3U5MHQzRnFDSE1kYmFIU0xYZTk4SjR6ZGUxUG4zcEpk?=
 =?utf-8?B?NEFiU0lxSXBLcVZIUGdLRXQ3UFd6ZnBud0xHeXJ1K0U3NVdqWTBzaTF6YXRO?=
 =?utf-8?B?VTRtVHpnRVRLZ01yeUZIU3BNaE8vZVFNTklENHhkeHZlbmorNmRBU2RsUDNj?=
 =?utf-8?B?WXVDVFZCQjBXTkhYUWpwSmg3NUhqdHFEa3NjbEcvSHp1U1dFdzFTYVRiaERw?=
 =?utf-8?B?c2w2YTFEMUxtOXZ0MkZyRkx4NmxCZHMyblpTYWtyM3h4T2h0bzU2T0JQYVMw?=
 =?utf-8?B?SDJnRGhSRUlUa3VWZllYWXEvaWVNbzgzVVJnYitXN0I1Y1NLZ3dIOW1MZjdE?=
 =?utf-8?B?d1ZscURmbjF4RWFRZE9hNWxsZlN6amE4R0JBQ0RlcVhBeGd4VzlJZmRJWkFN?=
 =?utf-8?B?emVHbTVOQVRJeWo0Sm1pL2t6S0c3bUhYMVg5VFlxQzVSd0RZTFl6S09vRlFF?=
 =?utf-8?B?VzNpdklhakg1aTBLOHcrWDFIL2ZZMUV5MVNaT3dOdWVCc1NlbXhCRkFSb0hN?=
 =?utf-8?B?SG5SRFo0MnVDSTFURVlzRFRmTTBYVG5uZnpYMUt2RW4wSDdUeWZibE9vRkZx?=
 =?utf-8?B?R1hqYUtrdWxZQkt4dXZRaExXams4aERDOUc1VDdWUVkzVmNMZERaOWM1QUth?=
 =?utf-8?B?SlhNVDQ4Ly8ydlFSRGZjbjlUa3VYRDJ2WEEvSGJQWG1aT2hia3A4eTJQb0Z3?=
 =?utf-8?B?dkFLdm55RGpmeGI4OWNGdE1Tem9jRTgxVXR0bTdyVTlTZUpFdGluYnNXbHRx?=
 =?utf-8?B?blY5QktVd1RnWXpqUXBzQkxUTUJWSDZXSFFMdmxjdHBiVmFBSTFqNC85WE44?=
 =?utf-8?B?YWVDTW5zaitPUk5pQzdydlpoNW5lM3FBTHpGblV0Z2NMdy9TRnFOdHJJL04x?=
 =?utf-8?B?WHBjRUJpSmdDZk81aEVHcisvd1dlWmR4cTlYRWhvbkNZVVYxZ1BmWHVNaE5H?=
 =?utf-8?B?bTJuWFcwbW9NaWRpRFFxNFJ3L0lWVWpmcUpOb2JZY1NaNVVBRGxOYTE0TjF2?=
 =?utf-8?B?d0VGajk5dmcweS9ZaXJnSTFGZGp3blM0QWtzbkZYWGxLZzRNWEVtRUZaRjVK?=
 =?utf-8?B?NWZLckxOQzNCOEtwQWlzSnlPdTF3TDEvdUp5R3YxOVJQSXFMTmticHdGVmM1?=
 =?utf-8?B?WXNMTm81eGdqS0tHUjNsbkhtdkd0TENtMzJBeWViRjNkWUdIdnhpbks5dmRy?=
 =?utf-8?B?Q3hHdmg1c0JPRStseFVCWm1ZWW1sMWVjcTd6WU56VG44b3M0SlRpaVlORU9n?=
 =?utf-8?B?b1JmUVljQ2Q1OXNlOTJ6R01BUk9keVRzMFdPZjNnbXhzWHYrZEx2R002OXdv?=
 =?utf-8?B?QTg5V09wMjNob085SFVBQlIyRDFCRS9ZeGNiTFlvampEVDZaM3BGVDlkaTMx?=
 =?utf-8?B?WUVidkpadmdad3Q5Ky9yemR4dVUrWFo2Z1RPK1hCR2ZhdkFnbVdCRGs5b1c1?=
 =?utf-8?B?TVc3WUFGSHBhT0JkUVV6VU43Mi9BOGpta0gydndUd3kzSk9vTnJHUHVhNEEy?=
 =?utf-8?Q?kCQPa7RtMRq88JsL5dMA06JBhKJH2eHA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WTdyUzZqV3lmTDd1bXZsaXBndDRsT21iUHp5MXlQQVBzaWJ2elZCNXg4UGtx?=
 =?utf-8?B?ME5CZEFEeGxmUTd0TkQ5OGNDb3BzU2szbXlQVUw2V1hKTlBqZFhnVjNZK1NM?=
 =?utf-8?B?NFNzTCtraWI0TWlsdlBkNG1JMXd0U0NBMkg1L0hVeWJueHplREwvdUpuZGh5?=
 =?utf-8?B?cnovaDlWMUNLbEorenZYWTVtbzMyU01DWmM2MGJlNEpIb1FyNzJnSXJ5RWFL?=
 =?utf-8?B?TXlZTkFuRm05eS9IdFBPS1ZtRlA5Y2czTGRuMnBCQTYvMk5NTGNLWGIrWWFF?=
 =?utf-8?B?dUJzV0NMcXlJRW15THFnVFVOUTB2c0k4bXdabi96dTd2VFlod1ZNZjdFTlNK?=
 =?utf-8?B?YUluQVFQRDB5VEV0YzVOa0g4TUpXVnFzZzFtWndUNmtKM2pjcTVNaFRaZ2xk?=
 =?utf-8?B?bzExaHVURXhqSnRUbEQ5TlBINFk3OElMbFNBOU5PTnc2enZZNU9uaE1tMkJE?=
 =?utf-8?B?OEJHQm4xU1dDQUJYSGozczF5azRwMWx5Vjh2NjJORzBFSFFlZUtZSXBBS3Zt?=
 =?utf-8?B?Vk54OVEvWlJDamxhMGVxWk9iTjcyOGVhL2YrQUI5SXBzZHFhc2MxTTNxYTJN?=
 =?utf-8?B?aStNQTFXaWFxd2pYekwxbGRWS0RwQnQ3dEF5UHcrV0dmVDc1ZEgvWjhKY05n?=
 =?utf-8?B?dSs2VzJ0Y3d2QlExVHZlWktuOS9KK1JlUDhybGJFZExGV2JiTzVaZzVIazZh?=
 =?utf-8?B?RmFQUndqYzFlK3d3bXFmTXpQUjgzQ2JJTEJjamo3WklmQmV4UjVWRnMybGFw?=
 =?utf-8?B?RGpOQVlkRFo3ejhMSVdEQ3BSak5DZU9WcWwzU2dmdUd0ZEpGNGl2aHlFcW11?=
 =?utf-8?B?VHdJTlRIa3lOY1U1UHBiR2lzN1JKby9GVHNVSFNvSlVUaGc5bTJYajd5d0pp?=
 =?utf-8?B?Y0l0NmM0cEpkaCt5WEhCRzFEbzZMSnNjVm1uSGQzMWpMQldwdlNlb2NDeWtp?=
 =?utf-8?B?TDlkL1liYWRlV0gvM1BHVjBuYnNNTDZ3WjN3TDZoNkJiQ0FudlYvSnlmWEtS?=
 =?utf-8?B?N3VGMVptUFRnNWNqdEFzdWFjOXhUcTNmZDVJMHV0UGdaWU5lQ1BlM1pRTzNW?=
 =?utf-8?B?MFNEd3k3SmFWcTFKcnd5UFlnMUtLc0l1eXhITE9jclFGTzRrVUZGR0ZuTHhp?=
 =?utf-8?B?bCtBTmFzeStTTWhyZm9CQjlkREZ5M09mUEIzSTRTbzRVV2N5d3ZQM0FydkY5?=
 =?utf-8?B?dHVNWlhBczVDaytudWlsUEZtUXNnbkJyWW41Q29rd0FReHluUlN6d2tPUVA3?=
 =?utf-8?B?Skg1UWVTZmtyWVU0NEloR3M1UHlmZGRiWm81UW9scWpqS3RkMW5ibk5qeWc0?=
 =?utf-8?B?K0EvalpvQW9PZGhJMkI2MzBqR0p2c0ovQUphRk16TEl5QlBwUFBHdktaRG1p?=
 =?utf-8?B?T2pLejY5S3NPQWlyakJ0UGJJb0ZoS2ZyWWxhakFnRnBtTHVhWEhzU3U3WHJs?=
 =?utf-8?B?aEpOOEdSbFVCQTBmWjVFYmxwUk0zbzZkeHBSckxOTVdtRXVOR2VsM2gvQjVW?=
 =?utf-8?B?eGxvb1hQOTEyNFh1aWt0aGNJU3E5U1NXbytOSHZYTlY4Y2NEN2cxSG8xN015?=
 =?utf-8?B?QWdhcmNHZ241UjNMUURTMU4yUzVBN0JEWHJYZis5cE1oK0lYREdTNmZ6QXE4?=
 =?utf-8?B?R1QzbEdodGYzR0w2RmM5b3htdVdmVTh5YmovejF4M0hNWWk0NUZUd0RnRk1V?=
 =?utf-8?B?L2d3UllwTXU4eGRDWjVHZ1lYSzhPYmN0UDlnZXp0UnpETmxIZnRJenhieVgx?=
 =?utf-8?B?UDNmNFBoVVByUzREY1BHWHZsc1oyMmRWckdMMDhwUk9HZHRDUTluRFRhN3RJ?=
 =?utf-8?B?WVphdzFzMGx4NGpIV0syUlNOeG5aRW1JVTQ1S3NHSkJCTjA3dUxLVm5RanF4?=
 =?utf-8?B?TVRwRnA4eUx6THlpZHN2SXk0ZUxYN0xMZUFPcGlDVnRxZG94ZVp3U1ZETGc4?=
 =?utf-8?B?ZURkelpsMExhdFo5S21wRzlrQWZNdWQ4TGNWQkZGQThlMjdWbCtFcktKdGxj?=
 =?utf-8?B?aEYybUJhV2FjSGFTVklLR09CckVnZ1pBTkRkR09GWko0aFE5NTVoOUVEazJV?=
 =?utf-8?B?ZWk2MW1PSmgzVzh4MmY5S0lxam16Q0RpeWROdWI5Rmh6YTM1L1htUUNRWEhR?=
 =?utf-8?B?UmtvUk1oMDM5OVduQzdsT09QWW50bFZwOTN5OE9wOVVGV1hXYkc4VmZrOGdi?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D25428C9A2834242A4A72A7E0D1A131C@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a0bbe6-780c-4cd0-ed35-08dd82eea25f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 05:12:39.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4akNsCYAHN7Mnnjbfe+aKwZhNKThm8w6r5ZaQUNJeP6hta/scAqsj5VSyTLsMg52/YalCL7znoizgXdAA7JFYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6455

T24gVHVlLCAyMDI1LTA0LTIyIGF0IDE1OjM2ICswMjAwLCBNYXJlayBTenlwcm93c2tpIHdyb3Rl
Og0KPiBPbiAyMi4wNC4yMDI1IDA4OjM3LCBodWFxaWFuLmxpQHNpZW1lbnMuY29twqB3cm90ZToN
Cj4gPiBGcm9tOiBMaSBIdWEgUWlhbiA8aHVhcWlhbi5saUBzaWVtZW5zLmNvbT4NCj4gPiANCj4g
PiBUaGlzIHBhdGNoc2V0IGludHJvZHVjZXMgYSBjaGFuZ2UgdG8gbWFrZSB0aGUgSU9fVExCX1NF
R1NJWkUNCj4gPiBwYXJhbWV0ZXINCj4gPiBjb25maWd1cmFibGUgdmlhIGEgbmV3IGtlcm5lbCBj
b25maWd1cmF0aW9uIG9wdGlvbg0KPiA+IChDT05GSUdfU1dJT1RMQl9TRUdTSVpFKS4NCj4gPiAN
Cj4gPiBJbiBjZXJ0YWluIGFwcGxpY2F0aW9ucywgdGhlIGRlZmF1bHQgdmFsdWUgb2YgSU9fVExC
X1NFR1NJWkUgKDEyOCkNCj4gPiBtYXkNCj4gPiBub3QgYmUgc3VmZmljaWVudCBmb3IgbWVtb3J5
IGFsbG9jYXRpb24sIGxlYWRpbmcgdG8gcnVudGltZSBlcnJvcnMuDQo+ID4gQnkNCj4gPiBtYWtp
bmcgdGhpcyBwYXJhbWV0ZXIgY29uZmlndXJhYmxlLCB1c2VycyBjYW4gYWRqdXN0IHRoZSBzZWdt
ZW50DQo+ID4gc2l6ZSB0bw0KPiA+IGJldHRlciBzdWl0IHRoZWlyIHNwZWNpZmljIHVzZSBjYXNl
cywgaW1wcm92aW5nIGZsZXhpYmlsaXR5IGFuZA0KPiA+IHN5c3RlbQ0KPiA+IHN0YWJpbGl0eS4N
Cj4gDQo+IENvdWxkIFlvdSBlbGFib3JhdGUgYSBiaXQgbW9yZSB3aGF0IGFyZSB0aG9zZSBjZXJ0
YWluIGFwcGxpY2F0aW9ucw0KPiB0aGF0IA0KPiByZXF1aXJlIGluY3JlYXNpbmcgSU9fVExCX1NF
R1NJWkU/IEknbSBub3QgYWdhaW5zdCBpdCwgYnV0IHN1Y2gNCj4gY2hhbmdlIA0KPiBzaG91bGQg
YmUgd2VsbCBqdXN0aWZpZWQgYW5kIGRlc2NyaWJlZCwgd2hpbGUgdGhlIGFib3ZlIGNvdmVyLWxl
dHRlciANCj4gZG9lc24ndCBwcm92aWRlIGFueXRoaW5nIG1vcmUgdGhhbiBpcyB3cml0dGVuIGlu
IHRoZSBwYXRjaA0KPiBkZXNjcmlwdGlvbi4NClRoYW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjaywg
TWFyZWsuDQoNClRvIHByb3ZpZGUgbW9yZSBjb250ZXh0LCBvbmUgc3BlY2lmaWMgYXBwbGljYXRp
b24gdGhhdCByZXF1aXJlcw0KaW5jcmVhc2luZyBJT19UTEJfU0VHU0laRSBpcyB0aGUgSGFpbG8g
OCBQQ0llIEFJIGNhcmQuIFRoaXMgY2FyZCB1c2VzDQpkbWFfYWxsb2NfY29oZXJlbnQgdG8gYWxs
b2NhdGUgZGVzY3JpcHRvciBsaXN0cywgYXMgc2VlbiBpbiB0aGUgSGFpbG8NCmRyaXZlciBpbXBs
ZW1lbnRhdGlvbiBoZXJlOsKgDQpodHRwczovL2dpdGh1Yi5jb20vaGFpbG8tYWkvaGFpbG9ydC1k
cml2ZXJzL2Jsb2IvNzE2MWY5ZWU1OTE4MDI5YmQ0NDk3ZjU5MDAwM2MyZjg3ZWMzMjUwNy9saW51
eC92ZG1hL21lbW9yeS5jI0wzMjINClRoZSBtYXhpbXVtIHNpemUgKG5zbG90cykgZm9yIHRoZXNl
IGFsbG9jYXRpb25zIGNhbiByZWFjaCAxNjAsIHdoaWNoDQpleGNlZWRzIHRoZSBjdXJyZW50IGRl
ZmF1bHQgdmFsdWUgb2YgSU9fVExCX1NFR1NJWkUgKDEyOCkuDQoNClNpbmNlIElPX1RMQl9TRUdT
SVpFIGlzIGRlZmluZWQgYXMgYSBjb25zdGFudCBpbiB0aGUga2VybmVsOg0KDQpgI2RlZmluZSBJ
T19UTEJfU0VHU0laRSAxMjhgDQoNCg0KdGhpcyBsaW1pdGF0aW9uIGNhdXNlcyBzd2lvdGxiX3Nl
YXJjaF9wb29sX2FyZWEswqANCmh0dHBzOi8vZ2l0aHViLmNvbS90b3J2YWxkcy9saW51eC9ibGFt
ZS92Ni4xNS1yYzIva2VybmVsL2RtYS9zd2lvdGxiLmMjTDEwODUsDQoob3Igc3dpb3RsYl9kb19m
aW5kX3Nsb3RzIGluIG9sZGVyIGtlcm5lbHMpIHRvIGZhaWwgd2hlbiBhdHRlbXB0aW5nIHRvDQph
bGxvY2F0ZSBjb250aWd1b3VzIHBoeXNpY2FsIG1lbW9yeSAoQ01BKS4gVGhpcyByZXN1bHRzIGlu
IHJ1bnRpbWUNCmVycm9ycyBhbmQgcHJldmVudHMgdGhlIEhhaWxvIDggY2FyZCBmcm9tIGZ1bmN0
aW9uaW5nIGNvcnJlY3RseSBpbg0KY2VydGFpbiBjb25maWd1cmF0aW9ucy4NCg0KQnkgbWFraW5n
IElPX1RMQl9TRUdTSVpFIGNvbmZpZ3VyYWJsZSB2aWEgYSBrZXJuZWwgY29uZmlndXJhdGlvbiBv
cHRpb24NCihDT05GSUdfU1dJT1RMQl9TRUdTSVpFKSwgdXNlcnMgY2FuIGFkanVzdCB0aGUgc2Vn
bWVudCBzaXplIHRvDQphY2NvbW1vZGF0ZSBzdWNoIHVzZSBjYXNlcy4gVGhpcyBjaGFuZ2UgaW1w
cm92ZXMgZmxleGliaWxpdHkgYW5kDQplbnN1cmVzIHRoYXQgc3lzdGVtcyBjYW4gYmUgdGFpbG9y
ZWQgdG8gbWVldCB0aGUgcmVxdWlyZW1lbnRzIG9mDQpzcGVjaWZpYyBoYXJkd2FyZSwgc3VjaCBh
cyB0aGUgSGFpbG8gOCBQQ0llIEFJIGNhcmQsIHdpdGhvdXQgcmVxdWlyaW5nDQprZXJuZWwgc291
cmNlIG1vZGlmaWNhdGlvbnMuDQoNCkkgaG9wZSB0aGlzIGV4YW1wbGUgY2xhcmlmaWVzIHRoZSBu
ZWVkIGZvciB0aGlzIGNoYW5nZS4gUGxlYXNlIGxldCBtZQ0Ka25vdyBpZiBmdXJ0aGVyIGRldGFp
bHMgb3IgYWRkaXRpb25hbCBleGFtcGxlcyBhcmUgcmVxdWlyZWQuDQoNCkJlc3QgUmVnYXJkcywN
CkxpIEh1YSBRaWFuDQo+IA0KPiANCj4gPiBMaSBIdWEgUWlhbiAoMSk6DQo+ID4gwqDCoCBzd2lv
dGxiOiBNYWtlIElPX1RMQl9TRUdTSVpFIGNvbmZpZ3VyYWJsZQ0KPiA+IA0KPiA+IMKgIGluY2x1
ZGUvbGludXgvc3dpb3RsYi5oIHwgMiArLQ0KPiA+IMKgIGtlcm5lbC9kbWEvS2NvbmZpZ8KgwqDC
oMKgwqAgfCA3ICsrKysrKysNCj4gPiDCoCAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiBCZXN0IHJlZ2FyZHMNCg0KLS0gDQpIdWEgUWlhbiBM
aQ0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
