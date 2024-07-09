Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC58152E06
	for <iommu@lists.linux.dev>; Tue,  9 Jul 2024 08:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720514140; cv=fail; b=X7WuDPxWo5z5/IGAzPAWkC84IgL4jf6jqhsPDAuaJyODP+RgO+uavVZh1YJrNl3vTcrJqJ34JM9zgBaivZpOBwUZfv3KXSQTW7nVLrf1ATpPWo24nFIJGyLEsz1zU3rv7MCAevubF+kewcFFR9N0eYV1alLL8p2tMuhZY4frB+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720514140; c=relaxed/simple;
	bh=H0i3NfYIyMFPNV6tvBbgE7jt6ZVMX0KevmXigq0pgOo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=quAC2rJmcIYuijRdFw2Bb/GP9drKMcrdEDEWcOc20X0AH6PUU++I2J3odp9WAsCB7lfS1JCxZU76S+ZnaCCT4dN3BPfk9Ichy0lyP3rxBgmAQtPg8+kz6lpHsEg4AJmz6nnTyEcYpXE3OXao+cvmRJqKrNSlIsWaFx/oUy4O5e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pj3egXIn; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pj3egXIn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/XB62hwT/WRUBZXIVcqC4lrY801hK1hggWhMBinypWxH6ANAsp+OB3SXji5Dy7Zbirl8CffVYUxaoTIyhLTJ3kmt773MtFxqbvi6BKuAF3xy0k/v2qTPnEGF/XtazLBQkOcfy7mQlR47a+tOoy6dV/3vYBtoqixW9mksCCCreehktKjs0AMHFbuDnZjPDdokRJwtGz4KSnobnBWs5FH68a4R6Jtv5Lxkubi6TESTx+3t7A7d2Lmh0Rj1ltEXBu/uvHLnMpJRDgYwvmPywkbklUjdO9/nzR2FgVD6eKqjfykJ7ZKblE7KipK/aL3Iu8gQnOtO8Xr0byDMFKcd5TzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0i3NfYIyMFPNV6tvBbgE7jt6ZVMX0KevmXigq0pgOo=;
 b=RX4xPkEqmGqryBnY5iiUv1Tkaj4Y08vyO2dqG40nVmINEgUs3XVUwq+KXmle+oZ3c7HtIwQx4nA6esMXCKjFMV1jS8rWurKyszu2wuFats0KeZzXFnn5c9vxvxsZHRxaNrX4Wd7VUp+tysl4e0VstKlXcpU/P2Vrf9IXHLclejuqf5sXvIR9DlpHk2KDk2yklFjAAa8Pc9EW0fKvF9gj20aqc/K0u//K207dDUsQHtWj2J7DgYQlzpV1QvF9JHQ8eZnD7cX3nxRpuH6vhW3BZtAgERnbkA+67K0RdjolkO84p8DLyrhW2iugUBOzACsDg+ciibdnD5ktJu2m1NBf2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0i3NfYIyMFPNV6tvBbgE7jt6ZVMX0KevmXigq0pgOo=;
 b=pj3egXIn8Ns4B7QRVEdvpXKdIlKqX4w/o65ruKHxDtqW2HRB4gJuYnIuo4HwO7bZG+fvhUdaNxv2LUWFhDoOkScq4ZODIbUHXsAaVKWvVLGiG309oX/2ob6o/kGrzkJb38KT6UARmzrDTCBVSGULZe1g6PtjRT3W5HDI1odpPfs=
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by AM9PR04MB7490.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 08:35:34 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427%5]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:35:34 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, "robh@kernel.org"
	<robh@kernel.org>, "saravanak@google.com" <saravanak@google.com>,
	"klarasmodin@gmail.com" <klarasmodin@gmail.com>
CC: "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "will@kernel.org"
	<will@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"kernel@quicinc.com" <kernel@quicinc.com>, Jason Liu <jason.hui.liu@nxp.com>
Subject: RE: [PATCH 0/4] Revert use of Unflatten_devicetree APIs from
 reserved_mem
Thread-Topic: [PATCH 0/4] Revert use of Unflatten_devicetree APIs from
 reserved_mem
Thread-Index: AQHa0YuKHSsOCKnp1kOO88mCBsOnQLHuEdXw
Date: Tue, 9 Jul 2024 08:35:34 +0000
Message-ID:
 <DU0PR04MB92990AF6A62D43CCF73D7D1480DB2@DU0PR04MB9299.eurprd04.prod.outlook.com>
References: <20240708230613.448846-1-quic_obabatun@quicinc.com>
In-Reply-To: <20240708230613.448846-1-quic_obabatun@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|AM9PR04MB7490:EE_
x-ms-office365-filtering-correlation-id: c61ca758-62d3-4ec1-651a-08dc9ff219ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?ZWJDNjluNkkvSU94Sk43MVhGOXFBN0tFWHlheWdDUng3ZG1ZM2ppLzlweTJD?=
 =?gb2312?B?TGlFOGRDQU84ajlvb0Z4dWlNUTJ3OU03TkJiSW53V3l3QmYwM2drWXE1STFR?=
 =?gb2312?B?MURHRGZVanpmd2hYZVYrcDlPWHN5TGRrV0IrTUk4enpkbnU2a2NySkd6cUpt?=
 =?gb2312?B?dE9BaDlzSXNEbFZSWTBFeFIwdmpKVDllaGFXYXlrT2VQamhTUjFxTmJLOGZL?=
 =?gb2312?B?NGdkbjJ4bzBJQzVHU3dSUXE1SEJOTlo5MmRGVlAvL296cXpRT0JiRzNRQUVu?=
 =?gb2312?B?cHcvSUk4K3Q1ald1WktHWXVKVFZyaEpaU2N4TTcrV1paSUFaQU1nUHZiSEY1?=
 =?gb2312?B?MmRhWUdFVGRqdG80aWNuYjVWVnJtb0dLaUlybFl3M0JLYnR4TFhURzlLQVo3?=
 =?gb2312?B?d0szT2ZKSkpteHJnNjE3aiswOGxJbUcyZ0tFdWpXc0lqVys5WHFBSkFDVW1k?=
 =?gb2312?B?V2J1bVF1NWJaUko0NFU1azlGQ1BsT3AwYTY4NWNFOEtNSjFFSzV0V05pbCs0?=
 =?gb2312?B?d3ZlNW9VcnAvcGlVYnBuYlBNOSt6eFh1UFZ1bU1DaWNOdzBkM1F6RytGZ295?=
 =?gb2312?B?Yk4zakxiZkM5VWZuVVpYUDJJNG9Yd3FpbkYwSXNOdXkyV3pEWmwrM0VZWTRv?=
 =?gb2312?B?c2tvUEYzMW8rK2t5VW8yRDBLZzFTTmtUdW1LNFBjMGg2dllRY2JOWGxkbXJh?=
 =?gb2312?B?L1lKUldLNmtFNGduVlNCcTZyUk02Q1hFMFVocXVNeGd1K3BHamUzU0pZR2VU?=
 =?gb2312?B?elZnSDUxbW9WSXdoYTZYRi9CczZ5dG1yeThQZHZqcG5Sc1pHRVRWa0dZN0F0?=
 =?gb2312?B?MTRvTW9ENm4rK3Y2T1Ivano4bGJ1dW5GdGg5ejlDL3EzS1pDUFFYcDdxTHF6?=
 =?gb2312?B?WmNOYVd0WXpheDFxRHptQzRNZy8yTjhSbmxLS3N4TkovN1RqU04zdDZVNVlt?=
 =?gb2312?B?eGlNMGZySlc2ZEt0cVZIUjR2b01iWmFYbWh1cGorMVczSjJNQVR0UG5EbDVu?=
 =?gb2312?B?eUlKQXhTaHdTa09pQjNWTnR0M3FmSHBrNUpBeHh0UGFRYXBIdkxrZlFtWEpC?=
 =?gb2312?B?VHZucFpYNVFEeGdSUXJPZEJ2YWNKYjhONGVlVHdFTXU1ZjBYWWlkc0pCNjFS?=
 =?gb2312?B?U3BINE11QUlOczRLS3kzQ1dHd3NteXg5UGEzekVidDB3c245REZkdXBQQWMy?=
 =?gb2312?B?Ym4yREQ0bnE1R3RYVDdqTU10aEFxNnhEVzgxdFo3OFBnZi9wSTIweWJwMXNj?=
 =?gb2312?B?dk4rODFVS3FXZUU3K1NCL21YY0RFRDlYU3BWZzFzSjEvRGZvN2NYd1E5QmhZ?=
 =?gb2312?B?Z3ZWUGtIaGFXS3BRTkoyQi9mZXQrTnp5b3BXZTlRa0ZVWHVpMVJqNXBvVFRY?=
 =?gb2312?B?amVjQ09QTmRUQkdSLysyZ05kTTZXSWdUSTA3cXdLZ1ZNWk41ZFhMcGdCVjJE?=
 =?gb2312?B?TUZZSk53OTlXWmNHNUwyZ21SSmd6ZGthZkNwR25RUGo1eTBvVTMwUDh0SkxR?=
 =?gb2312?B?Z0I4WjMyRVVaaHJJQm1nLzJIOGZ1RFNvNjcxZmJia2VsdTVxdks1aXlPYnJ1?=
 =?gb2312?B?dEtZY0N5aDU5RktKUzkvcVZYVU1BZ1NCZWVJRDFSb21VQ0VGeG9NMnZRd01y?=
 =?gb2312?B?c0lIdFREU0IwV1VjWmlPakxIa25IZzd1Y1VtUTdVankydnRlb1kvNG9scGho?=
 =?gb2312?B?SzRxSWpac3JUc1lmVkVlWFFLWmlTSWF5RUtHdEFhbjVsa3pFK0xrVzJaT0xi?=
 =?gb2312?B?ZG8zd3lHaVFYWkF1ZmF0TkRSN2Y2SU1QTVBVWkNqOXNhcCtUdWg1Q3pWK1d4?=
 =?gb2312?Q?OYHPXJEEINmtqmsTqBUWQzTQmP2ADICjsZER0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?SmFQWk1yWmVDdnY4NUN2VUFNWFpTQnBSUTljNitKSTgvTHNIWS9FUlNtb3kr?=
 =?gb2312?B?dGJjZTVTelBCYUM3MThPbUQxWXIvMWZlcXdtNjVkb2RGRDZKc3BaOVlodDBM?=
 =?gb2312?B?MG9KRVRvQ2c4REFZZVRKMzdKS0txeGV4eisxL3VaYVU2aXUzd1lZbUdRT0Z4?=
 =?gb2312?B?ckdLdHNqRkxiZUs5a0VyZTFhbVZHQmYxL0YwaG1IQjJtUjNpQnRFQ0JFOHRQ?=
 =?gb2312?B?cXFjRHpPVG5IQjZxRkxYd0RHbEtLQVBVeEVaQWtVMUcvcjlEOFU2ZzVudnE5?=
 =?gb2312?B?VS90eWM3MHg0VDV5Z3BRRHJ5c2QzR1AvWnNLbm50NHRjYXNwdjNzVjhsTFMx?=
 =?gb2312?B?WHl5Sk9lZXVuZTRJOTRadE5KRXQvNnBINEdnYXdGcTVPT3BTRExVa2JYeGlE?=
 =?gb2312?B?TmdRQU1hNisxQno0NnVEb3hhWHh2YjNxU1VBOG94TndoN25zbFpqdy9ia1gw?=
 =?gb2312?B?QmwzVDBUb1dOMVptMUtwTHJXbmY3QUdvbEY4dlNKZm1YYkJkZ2pCZ2JnOTZv?=
 =?gb2312?B?dy9zMzlJRjJMUDk4Z2tzaXNBS1pRdmRMLzhEbW15ckloQ0FuQjlMZXZkaUxM?=
 =?gb2312?B?UVp1N1lkOXF4RU5NUWs1WXpMd05PSlpxOUFGdXF0VmNULzNpWTFBZFYwODY0?=
 =?gb2312?B?b0ZVYzFYOEpIMjdIZTVHdXN1NUkyMzVXNVl2MlVtdHVRNFY2TWl3WmZSdU5M?=
 =?gb2312?B?Vkszd1ZpRlFURjJVekttLzNLRWFsUitVcmlrV3RFc3haOExvNUdma3NnSWxN?=
 =?gb2312?B?VndrZ2VqaWQwRU5xbXdqRkFURitZVERUdkpDVW1ESVV0YzNOWm1FaWoxTkRm?=
 =?gb2312?B?ajl1c3ZPRFJ0TUNYNGUvVWxKSUEzSDJwazRyWFBVd0kyU0d5a0Uwa01yNFlo?=
 =?gb2312?B?dTY2aml0eGJ3S2tyRG96bVRtb2NQbHZreE9TcWRyblVEdE1WUlRpT01kT2JW?=
 =?gb2312?B?M1Y0ckthSWJrZEYxbnd4bitwNW53RTgvbUxsWDBRUUxDeGxTb0FBN3E4bEly?=
 =?gb2312?B?VmhuZzJOamZXbUlxSVFJZDNFOExpMUtnVXI1MlE0WjhNV2YzUjZtaTA3MGVl?=
 =?gb2312?B?Yk90V05LbmFPS2xjYldTSHo4Z3UyM0VmQURsM1JJcGFHOVpyeFpwaVJHdHdK?=
 =?gb2312?B?Y2MxMVhhQ0NpSGlDd2J6Tm9sTWFvRDBYeEErTkFuQklrbjk3dS95N3hUYXVN?=
 =?gb2312?B?djNzUGpBZlU4b0FpdVo1NEdObjBMa00rbDNLOC9adlhHVUdkeXFkYnVGL2dT?=
 =?gb2312?B?bS9jZlNQdDV2NmNLdUtWMFJMY3RiaWtLMk1OUWF2aFQ5Ui9ka3NDMmpDSlFx?=
 =?gb2312?B?TTlXQnFaUFU3WlA5bElIaGx6b2x1MUhsdDYrRWFLVWhpOE8wdmxjN3NSUlRy?=
 =?gb2312?B?ZWtWSTZscytGTHoyaVBYV1VxaitwNWs3Z2IxT0JHNFY0Y3lMNW1vNkdrRjJT?=
 =?gb2312?B?dmxKaXZjbW9TU1M4a0M2VWNpZmY2WUtzQmtjVE1zbnR5SU9MMVhZcm1pMTdZ?=
 =?gb2312?B?enpoSVhyWDhLYVlxdEs2RGd3dTB0S1ZGYTdsZSt2aXFIRWZzemNwRWhmY2tM?=
 =?gb2312?B?TDY5VkJNcDFLYkpMUXRFbk9OWktkY29ZMStWcmRUdm8wUCtGd0lzbHFmbGxv?=
 =?gb2312?B?SWFGeGVQeEE5YzVlMlpEM0ovdXFYRWpjdmdkczhpTU8zdGJ5N1F5R1hGVzh1?=
 =?gb2312?B?aHBNb2dEelZzdTZsdEdzMUdoRzJjekYxKzZ2d1lsQnorcGJyaDdRVE9zRjEw?=
 =?gb2312?B?Sm16YU9HOEpFTExldXV5SFN2WnVmb0hCQStObmc3MDRSV0JocklTV3QzbG5B?=
 =?gb2312?B?SlhDNHdrck9mc1ppVDhOQ0pDOFM5enJqOEFYamgwb3VsQ3BTb1FRUHRSN0dQ?=
 =?gb2312?B?OHFxU1RJdlBZKzU4MFZOMmd5bE5TTnIvVlhQWFJmVFZrb1gzbmV1Y0FPa2gz?=
 =?gb2312?B?bVNLcjdMaXdkTXk5YkVMQjZqTys2ZEVsSWFhQ0R2cjdKb2pWbWliaXZIV0Jv?=
 =?gb2312?B?bElhV1Bna1EyeGNKcWNidWNrZmNlMTVPN09tTWhvUXZLZEo2eFFoMFFIa3cz?=
 =?gb2312?B?ekRtSCtQbG1pbXEwdnZ6ZUlmNHBWTThjVUQvYTV5alNIallmcldpU0QzaXdw?=
 =?gb2312?Q?274LHacHzArXU2HMBWWjU8b5D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ca758-62d3-4ec1-651a-08dc9ff219ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 08:35:34.5047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7yxAWYsnvrj6jq2aQlTRMnaUPsnk9EhrkXrEIRH66wP8af1YOPJAJqGKEujWf+NoiA0ysSg+tKGnajj8BiUXug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7490

PiBGcm9tOiBPcmVvbHV3YSBCYWJhdHVuZGUgPHF1aWNfb2JhYmF0dW5AcXVpY2luYy5jb20+DQo+
IFNlbnQ6IDIwMjTE6jfUwjnI1SA3OjA2DQo+IA0KPiBXaXRoIHJlY2VudCBjaGFuZ2VzIG1hZGUg
dG8gaW5pdGlhbGl6ZSB0aGUgY21hIHJlZ2lvbnMgYmVmb3JlIHRoZSBwYWdlIHRhYmxlcw0KPiBh
cmUgc2V0dXAsIGNvbW1pdCBmMmE1MjRkOWVmNWIgKCJvZjogcmVzZXJ2ZWRfbWVtOiBSZXN0cnVj
dHVyZSBjb2RlIHRvIGNhbGwNCj4gcmVzZXJ2ZWQgbWVtIGluaXQgZnVuY3Rpb25zIGVhcmxpZXIi
KSwgYW4gaXNzdWUgd2FzIGludHJvZHVjZWQgd2hlcmUgdGhlDQo+IGluaXRpYWxpemF0aW9uIG9m
IHRoZSBjbWEgcmVnaW9ucyBmYWlsIGFuZCBhcmUgaW5pdGlhbGl6ZWQgYXMgIm5vbi1yZXVzYWJs
ZSINCj4gcmVnaW9ucyBpbnN0ZWFkIG9mICJyZXVzYWJsZSIuIFsxXSwgWzJdDQo+IA0KPiBUaGlz
IGlzc3VlIG9jY3VycyBiZWNhdXNlIHRoZSBkZXZpY2Vfbm9kZSBvZiB0aGUgcmVnaW9ucyBhcmUg
bm90IHlldCBjcmVhdGVkDQo+IGJ5IHRoZSB0aW1lIHRoZSBjbWEgcmVnaW9ucyBhcmUgYmVpbmcg
aW5pdGlhbGl6ZWQuDQo+IA0KPiBUaGUgY21hIHJlZ2lvbnMgbmVlZCB0byBiZSBpbml0aWFsaXpl
ZCBiZWZvcmUgdGhlIHBhZ2UgdGFibGVzIGFyZSBzZXR1cCBmb3INCj4gdGhlbSB0byBiZSBjb25m
aWd1cmVkIGNvcnJlY3RseSBhcyB3YXMgcmVhbGl6ZWQgaW4gWzNdLg0KPiANCj4gSGVuY2UsIHNp
bmNlIHRoZSB1bmZsYXR0ZW5fZGV2aWNldHJlZSBBUElzIGFyZSBub3QgYXZhaWxhYmxlIHVudGls
IGFmdGVyIHRoZQ0KPiBwYWdlIHRhYmxlcyBoYXZlIGJlZW4gc2V0dXAsIHJldmVydCBiYWNrIHRv
IHVzaW5nIHRoZSBmZHQgQVBJcy4gVGhpcyBtYWtlcyBpdA0KPiBwb3NzaWJsZSB0byBzdG9yZSBh
IHJlZmVyZW5jZSB0byBlYWNoIGNtYSBub2RlIGluIHRoZSByZXNlcnZlZF9tZW0gYXJyYXkgYnkN
Cj4gdGhlIHRpbWUgaXQgaXMgbmVlZGVkIGluIHRoZSBpbml0IGZ1bmN0aW9uLg0KPiANCj4gWzFd
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9EVTBQUjA0TUI5Mjk5QzNFQzI0N0UxRkUyQzM3
MzQ0MEY4MERFMkBEVTBQUjA0TUI5Mjk5LmV1cnByZDA0LnByb2Qub3V0bG9vay5jb20vDQoNCkZv
ciBDTUEgcmVncmVzc2lvbnMgaXNzdWUsIHRlc3RlZCBpdCB3b3JrZWQuDQpUZXN0ZWQtYnk6IERv
bmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0K
PiANCj4gT3Jlb2x1d2EgQmFiYXR1bmRlICg0KToNCj4gICBSZXZlcnQgIm9mOiByZXNlcnZlZF9t
ZW06IFJlc3RydWN0dXJlIGNvZGUgdG8gY2FsbCByZXNlcnZlZCBtZW0gaW5pdA0KPiAgICAgZnVu
Y3Rpb25zIGVhcmxpZXIiDQo+ICAgUmV2ZXJ0ICJvZjogcmVzZXJ2ZWRfbWVtOiBSZW5hbWUgZmR0
XyogZnVuY3Rpb25zIHRvIHJlZmVsY3QgdGhlIGNoYW5nZQ0KPiAgICAgZnJvbSB1c2luZyBmZHQg
QVBJcyINCj4gICBSZXZlcnQgIm9mOiByZXNlcnZlZF9tZW06IFVzZSB1bmZsYXR0ZW5fZGV2aWNl
dHJlZSBBUElzIHRvIHNjYW4NCj4gICAgIHJlc2VydmVkIG1lbW9yeSBub2RlcyINCj4gICBvZjog
cmVzZXJ2ZWRfbWVtOiBSZXN0cnVjdHVyZSBjb2RlIHRvIGNhbGwgcm1lbSBpbml0IGZ1bmN0aW9u
cyBlYXJsaWVyDQo+IA0KPiAgZHJpdmVycy9vZi9mZHQuYyAgICAgICAgICAgICAgICB8ICAgMiAr
LQ0KPiAgZHJpdmVycy9vZi9vZl9wcml2YXRlLmggICAgICAgICB8ICAgMiArLQ0KPiAgZHJpdmVy
cy9vZi9vZl9yZXNlcnZlZF9tZW0uYyAgICB8IDEwMyArKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLQ0KPiAgaW5jbHVkZS9saW51eC9vZl9yZXNlcnZlZF9tZW0uaCB8ICAgMiArLQ0KPiAg
a2VybmVsL2RtYS9jb2hlcmVudC5jICAgICAgICAgICB8ICAxMCArKy0tDQo+ICBrZXJuZWwvZG1h
L2NvbnRpZ3VvdXMuYyAgICAgICAgIHwgICA4ICstLQ0KPiAga2VybmVsL2RtYS9zd2lvdGxiLmMg
ICAgICAgICAgICB8ICAxMCArKy0tDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDcyIGluc2VydGlvbnMo
KyksIDY1IGRlbGV0aW9ucygtKQ0KPiANCj4gLS0NCj4gMi4zNC4xDQoNCg==
