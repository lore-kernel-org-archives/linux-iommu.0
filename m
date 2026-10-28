Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793184141;
	b=KSUOHJc1DfamrvqLYQUv8lJgkqROHL7z6z1kF4Rj5gXagqZir1yVIV5z5KYZOj+2tm4q
	 sFLhOIUzNyvW1tWxXWNKXwvQWFqMEiISneb0RrhJPrEhJ+hv1vAf/KOPlC5B6JrS3brdB
	 TYNZEnxhvWdkHrRwfKaKIjWaEzWePKOIjqWdnn4A/IJsvQUrHg9+Y33izHQz23oSTfI/d
	 2I3rn8qg3NIIWwCA0ht0yLpFN8L/BJbTM0m80UzI97yIhR3oGrJ+ZbSabu2EVF9bIhxax
	 qPN+yTmVFqT1sLxl7lYPhK2W2PlrKzAQPx+ZFiDzkexQ99XLtSS2fVVkc2BkIDsxV5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793184141;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=o1odbR7AByuz0MPJO9e8ZGzIE8wlB6QU/eOA5BRYDus=;
	b=4doTAynNTib6q3QYJM/M/Ikk283KHCc6Uv+o17g7OqKu/FvTBaCiMVfPa1ofuWIwFS6/
	 f3IRtsg2nMewL1/quICt8Po7R/W5PZxdIsKCI+p95NTi9puFrVgEcqmlpgJzsZAlWY/SR
	 nv8WCIrqRTkWShDeZsQYsczbhftT2bF4vHbMPR3Pp97RBioWRd0PH5MPbPAIHBhAz8a7D
	 g7/PBoYCPMBAd8J+hXpzgrRf4PnFwaFTtOvItavzUpJosoZ9O/degHakBEWLNX8iIKm9l
	 Hr8AjHnsyA7eNZ6rto2Mlenr4OO75d1wVOUymZRmwz62j2AQmjM8x9Fe7OilnCf08Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Qv2c/90y";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.28
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E36E606A31D;
	Wed, 28 Oct 2026 10:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E36E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Qv2c/90y
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kA4+ZWNfVQUMp/4MAEL9mbJBRQf2LC5ZgkY5t6EDZRNf2Ke0M7vda/QZnlRqgR4X+3HCEIyamMTND7q6TnZg+LOnYRIPYg/u2LeqmeKSkNZpXaPcSaLHm8t/7oXKdSbAycDOS5t1Fa9VhXXpJ+zToqb+3yWgYxeFRrY2SYZtz38kOBtpp0wY3ZU2pobZRbZw/NpfFdn9nICkW+kgMr6ZYEPSMAGLgBD9j+S+Y1lxmscRQkqxvYaGQ9MggLngaUBrCM3K10nXyxP0Kx/DNgRd5R7UzRA6/3gUxTuiccAIHS4AcgsJh6TtsEcITJ6PkxvBqveEu4Rv+JNe4DXb+KJhog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o1odbR7AByuz0MPJO9e8ZGzIE8wlB6QU/eOA5BRYDus=;
 b=wXiLoSW/u+Ce8Rabn0oVrG/TwY10asuveUnbV6tWM9TwqcvKwNQEG5hFz7CqXHWcN4SnRE4QuUZaK2IIxA1gs7hxolsnQZv33kaKQLjaIEbY9qm+vRB1ViRoxdIEvXQ6F0qiu3bYK0cMiuSmSz4bsl6gmhuu9JKeUEFhjaxZtbk4NjJmNtLRbwiQ1TcNMkiBhvzBJOsntKM4iyv6nD1dDeYJgwC86DUd/y1sWNq/N5xRb7qVYUynERs8oXWikHBqb/TPBwDo2jpCRnVgCybrmEUoWfWAlGki9SvCh0rJHW2vlYni400+Tc+042r0VBdhIHKECrbPDV+jorYZaq4roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o1odbR7AByuz0MPJO9e8ZGzIE8wlB6QU/eOA5BRYDus=;
 b=Qv2c/90ydSvIqQfOssl99kDaKkvCxXbmrSmOlkTpE10H8NvaRCOzicF0b8bG/GZKkaktKHuSkKVXytLadXOCbmVJzBBTod49iXfAqhTMFRbQcYhLFaHyry5d1xW050aG5tuWaUf79XU7H1xK3AcIfHE31+TfgsHSkJdg6ewRJDNy7x/SMPDc4zXbcM2iZro55ZrfgZtQal/qZ8u2+T/+gC5UVdXrOeaA3J9/1VzlwmHOhs7MEiclRkBs/TGM6M9iGywOmVKFaMNyqKBh87wD4ZEuu+Cla+p4yXZ7CwMMW2ZtOsGvJGfXGEoSmBXr/bu2lGeu4BGI8eMveM3Pxhr1AA==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 10:42:15 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 10:42:15 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>, Anshuman
 Khandual <anshuman.khandual@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	"rppt@kernel.org" <rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, Marc
 Zyngier <maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	"kas@kernel.org" <kas@kernel.org>, Kohei Enju <enju.kohei@fujitsu.com>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>,
	James Morse <james.morse@arm.com>, Steven Price <steven.price@arm.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>, Jinjie Ruan
	<ruanjinjie@huawei.com>, Sam Edwards <cfsworks@gmail.com>, Douglas Anderson
	<dianders@chromium.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
	Chen-Yu Tsai <wenst@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, Pranjal Shrivastava
	<praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "driver-core@lists.linux.dev"
	<driver-core@lists.linux.dev>, Sonang Patel <sonangp@nvidia.com>, Ankit
 Agrawal <ankita@nvidia.com>
Subject: RE: [PATCH v1 4/8] dma-mapping: Keep DMA memory private for capable
 devices
Thread-Topic: [PATCH v1 4/8] dma-mapping: Keep DMA memory private for capable
 devices
Thread-Index: AQHdQNVFlKCpF2QRPE25WRHsftJeD7cTDVtg
Date: Wed, 28 Oct 2026 10:42:15 +0000
Message-ID:
 <SJ0PR12MB86145DBCF2ADDF3B85719531AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <abddd433493324a6bfdf8ba9710e96d90f0d1ccc.1789010941.git.nicolinc@nvidia.com>
In-Reply-To:
 <abddd433493324a6bfdf8ba9710e96d90f0d1ccc.1789010941.git.nicolinc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|CY8PR12MB7435:EE_
x-ms-office365-filtering-correlation-id: cb95cd2d-1068-4243-c1c0-08df34e021c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261009223027099003|261009221727099003|261009220027099003|261009223327099003|261009221227099003|921020|38070700021|261026121527099003|261026140227099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261021135927099003|10067099003|5023799004|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 lIL0pTjYxW5SfQXMIMRaebY9+njk4w23gD1XG4OdnuHLjBNL3/WqpsMUoEyR07PIXfZB2wfCvD5Ixj/n3NqOcp2Q+SM1TFtVy/tL9jJ3PsWwMDXVf0cU8AfwBhxuCW6vSb/Ah4drkl3sCPbsjTYXxwewYhkPYQSzAJkXokxrcu43BJPR7Vix6Q0c0JmlwfBRnu1Exitc5g1f7DWdqBSza9KL8pCV4u8GUKqH2wry00i6WX4MbB7TOSvkyQGt+PVYn6NA04G5TYa+imBXOHsoyOjwSEO623pqU9CVicVZiGoWi9b7g9wRls9G3izc0PFVNV7fQeoaaX2DrLBH3ChiEJH6JcJpGM/NJnw7bsAxevVMr0gheJmBE5vnlE5AZZUvhSi6bQ3jBqqzQBwUkK59g5wR9fD+FpnJ/LHE+BIjkZSgpImRK7Di5mxkQqGDhCdfhsi30dIWrldH4t48ZZTFbRR9hZGINilZ22aWgeqlo5nD83oiIuGxOztL3z1CE62uFH0TZvLxcTdmnEkTxWCwsTg/yPCqbNqbmctYbApIUBYNNhuBQrosP2Ntq01qx/LQUBfcKFeZ6r1H/TNW5/xnDZzW21DFcaUnio7E1U6i30uweKTd2wup86t5LbMnR/2RwKNDGne3qEAWglexiGX6CeSOKTC7AM1Es8I5j98CSAPtuOQHiz+CxLAknp71kDi8SClqilLe1Gjoom+T+mAHmyFUE12/DG27c8R2JqHqrzN1p/zwkfGhSrEUKFH/kXK4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261009223027099003)(261009221727099003)(261009220027099003)(261009223327099003)(261009221227099003)(921020)(38070700021)(261026121527099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021135927099003)(10067099003)(5023799004)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+xx5NCsUFU7pR1fiFowTCohveoTw6JsNya6MilscpJ81nYs/VDYgXY5WVLET?=
 =?us-ascii?Q?BbxDV5mOV1nqADBoxShjSlEgrFccChEEzNB1spiwdWV0uhrjZl/2pFlOOaRj?=
 =?us-ascii?Q?8+tJBiUBQhjW/qJx1dIljygqDLhdHzn+HTCgja+soT3o/u/8DDnpuiu+Oo0A?=
 =?us-ascii?Q?heJ+5ZTokfcHlovmStYQNz47lTuSgDlPCqKcRJXX5iewitSx3ANQXXRrHhuJ?=
 =?us-ascii?Q?M2xW6BK891sl1FLf4QPjfl8Lc2tKjJcQKZ3y/SfttHdmo55jTuOJ+tv+LHFV?=
 =?us-ascii?Q?m/8TdMHWHkXfhZoqiuloaWirZNhJ+tV3qNof5kjxMAYYTi4GD9Rt+PQx3dPq?=
 =?us-ascii?Q?NTETKre1DV0CQGXKm0Lh73nBmM1//D1561fwXYmCmBrZjyRTxG/RZl50Y4q0?=
 =?us-ascii?Q?Z5CQkc0ZMtofHikLEqnThiInA1AelHkb4Sg1GxUImxJR7hDgfrkbaeOhXGDc?=
 =?us-ascii?Q?RUrTP43WFGl9hHuZP32VGtPmB10dr6UHi+BqC2bIJhAN+ykCqZkt3kyyRU4Y?=
 =?us-ascii?Q?jVNe1PkXOvHMhgSsgZbVHFr1n30bRkfGodqYe+ov1VngNjsAAA3Oa2pWZ/Aw?=
 =?us-ascii?Q?bQJBqTt/GPI8ypArZl6UzKo+rZUrNJ2wNYCrMGjlahxAfq4duN+r9/ye4NS+?=
 =?us-ascii?Q?L0oDnu6ZEBHSKJbPq340cut+34dxyd5gEjyL7nW1GmCK/e4eJofWa/nnYLl1?=
 =?us-ascii?Q?3Jz+S0ljZqR9Xch2LR0UGTWcXGCX2M5e6KKVE1DpsMg45JOGsAHZLmx9qbMD?=
 =?us-ascii?Q?8sPpZEVWlSuRtosh0l4Y2eVBiEr69b7SjfIdZzsOQBXFHVgMHu0sy5edT0Tx?=
 =?us-ascii?Q?YlghvVPRmfH8Nfvt7vEe/v0fh6Pvms0WJooo2vBXHNlptqZjJ4riPoLsAjhP?=
 =?us-ascii?Q?d5C1TEyNVBgka9RyMLo9UsANRUCOPEVJPov6C2hT2jT05DbDTwRNa7CwuyF1?=
 =?us-ascii?Q?D4SmKo64DY+3kqK5YfMwsWF3nZXxwWySgjvy3Ep/EVTZky2PyVl0oZl0TN5v?=
 =?us-ascii?Q?eLWUgladEEJIyUkWrvrc2nzcWMIhUu7Qo+191vPuqae6VVsuKIwggQzA6HSt?=
 =?us-ascii?Q?tXvpHA03H87SwgvCJOG2uCc9Thxh1Q8S0cF3hwJXZ0iHypxkF3o9bJc0gZ3g?=
 =?us-ascii?Q?mJvqHzp56t/+smx3w+OFolBRtWAgPAhfN6QSP+7CWovS0HLlB+Ri8DU4uU5A?=
 =?us-ascii?Q?o4RsgVeLnHCnZVuLoDTtdId9MIsN960/MRvbPklDNRuHewCGMyt9OSIYgjBg?=
 =?us-ascii?Q?t3PjiDiGhbYdvrzJq+AZGMVQwEKKzaNl0kTRn7aRabHklgtQTdQNjVe+jJ0y?=
 =?us-ascii?Q?Olq4t90iGTW30fjSCjln/s9oq7XZvtY3ELcz3FyQbS93/MgJvEIzP4k7Skfv?=
 =?us-ascii?Q?rkBSxtQ8gnKLXN99y9Ne4vG4CW9cxdQpIlwitvR/PJ71332aMYYVDsGSkyBr?=
 =?us-ascii?Q?0weUFSKBDeyf/uN6dsf6kwMaCqfi4g+YqctZp3ItruJ2iUR7YhJRR9q2HyEu?=
 =?us-ascii?Q?Ekv1y5bF9KPoKCAQpRnPadqwSly9bPVpmEbWXyfe1luJI7T0V2fOPs9YtO7r?=
 =?us-ascii?Q?5Mu89H/3cc1grACxwHeAMfBF9hY2ueGKZPL32LWbaAHGfPdeAIY/vzskNlu9?=
 =?us-ascii?Q?nwfEqsTUebaNcTwszBsjSzZLTp7Uq3z0ophoJiKeD2HsqCZY7IEoPiUGTkQt?=
 =?us-ascii?Q?vYK+SQSA322OAzQDsHCRbyFyodZN+gQ+6lftNCJi0pwUw+LucHgvNF69rDWc?=
 =?us-ascii?Q?ldAbyy0+QQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb95cd2d-1068-4243-c1c0-08df34e021c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 10:42:15.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ur98Aoqv4WmzRpXlC2R20PDPxXgWCfwzJqtnETI6mGmq4K9TRSSk3IltKgttQo8MG12pw9s/qY4zUiKLisZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 10 September 2026 04:33
> To: Jason Gunthorpe <jgg@nvidia.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> joro@8bytes.org; Robin Murphy <robin.murphy@arm.com>;
> rafael@kernel.org; Danilo Krummrich <dakr@kernel.org>; Marek Szyprowski
> <m.szyprowski@samsung.com>; aneesh.kumar@kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; Suzuki K Poulose
> <suzuki.poulose@arm.com>; Gavin Shan <gshan@redhat.com>; Vikram Sethi
> <vsethi@nvidia.com>; Anshuman Khandual
> <anshuman.khandual@arm.com>; Shanker Donthineni
> <sdonthineni@nvidia.com>; Mostafa Saleh <smostafa@google.com>;
> rppt@kernel.org; Thomas Huth <thuth@redhat.com>; Marc Zyngier
> <maz@kernel.org>; Ryan Roberts <ryan.roberts@arm.com>; kas@kernel.org;
> Kohei Enju <enju.kohei@fujitsu.com>; Shaopeng Tan
> <tan.shaopeng@jp.fujitsu.com>; Ard Biesheuvel <ardb@kernel.org>; James
> Morse <james.morse@arm.com>; Steven Price <steven.price@arm.com>;
> Sang-Heon Jeon <ekffu200098@gmail.com>; Omar Sandoval
> <osandov@fb.com>; Andrew Morton <akpm@linux-foundation.org>; Jinjie
> Ruan <ruanjinjie@huawei.com>; Sam Edwards <cfsworks@gmail.com>;
> Douglas Anderson <dianders@chromium.org>; Florian Fainelli
> <florian.fainelli@broadcom.com>; Chen-Yu Tsai <wenst@chromium.org>;
> Huacai Chen <chenhuacai@kernel.org>; Thomas Zimmermann
> <tzimmermann@suse.de>; Pranjal Shrivastava <praan@google.com>; Ashish
> Mhetre <amhetre@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; iommu@lists.linux.dev; driver-core@lists.linux.de=
v;
> Sonang Patel <sonangp@nvidia.com>; Ankit Agrawal <ankita@nvidia.com>
> Subject: [PATCH v1 4/8] dma-mapping: Keep DMA memory private for
> capable devices
>=20
> Architecture code can require devices to use unencrypted memory. This mak=
es
> the DMA API use shared memory for coherent allocations and bounce
> streaming
> mappings through SWIOTLB.
>=20
> A device marked with DEV_FLAG_DMA_CC_PRIVATE can reach private
> memory
> directly. Add dma_require_decrypted() to combine force_dma_unencrypted()
> with the new device flag, and use it throughout the generic DMA code.
>=20
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/dma-direct.h |  7 ++++++-
>  kernel/dma/direct.c        | 16 ++++++++--------
>  kernel/dma/mapping.c       |  2 +-
>  kernel/dma/swiotlb.c       |  2 +-
>  4 files changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index daa31a1adf7b0..fb35ca27941cc 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -134,6 +134,11 @@ static inline bool force_dma_unencrypted(struct
> device *dev)
>  }
>  #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>=20
> +static inline bool dma_require_decrypted(struct device *dev)
> +{
> +	return !dev_dma_cc_private(dev) && force_dma_unencrypted(dev);
> +}
> +
>  static inline bool dma_capable(struct device *dev, dma_addr_t addr, size=
_t
> size,
>  		bool is_ram, unsigned long attrs)
>  {
> @@ -146,7 +151,7 @@ static inline bool dma_capable(struct device *dev,
> dma_addr_t addr, size_t size,
>  	 * requires unencrypted DMA addresses. Treat it as not DMA-capable
>  	 * so the caller can fall back to a suitable SWIOTLB pool.
>  	 */
> -	if (!(attrs & DMA_ATTR_CC_SHARED) &&
> force_dma_unencrypted(dev))
> +	if (!(attrs & DMA_ATTR_CC_SHARED) &&
> dma_require_decrypted(dev))
>  		return false;
>=20
>  	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index da665ca22d5c0..fbddab9740162 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -41,7 +41,7 @@ static inline struct page *dma_direct_to_page(struct
> device *dev,
>=20
>  u64 dma_direct_get_required_mask(struct device *dev)
>  {
> -	bool require_decrypted =3D force_dma_unencrypted(dev);
> +	bool require_decrypted =3D dma_require_decrypted(dev);
>  	phys_addr_t phys =3D ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
>  	u64 max_dma =3D phys_to_dma_direct(dev, phys, require_decrypted);
>=20
> @@ -72,7 +72,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device
> *dev, u64 *phys_limit)
>=20
>  bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
>  {
> -	bool require_decrypted =3D force_dma_unencrypted(dev);
> +	bool require_decrypted =3D dma_require_decrypted(dev);
>  	dma_addr_t dma_addr =3D phys_to_dma_direct(dev, phys,
> require_decrypted);
>=20
>  	if (dma_addr =3D=3D DMA_MAPPING_ERROR)
> @@ -208,7 +208,7 @@ void *dma_direct_alloc(struct device *dev, size_t siz=
e,
>  	struct page *page;
>  	void *cpu_addr;
>=20
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |=3D __DMA_ATTR_ALLOC_CC_SHARED;
>=20
>  	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED) {
> @@ -368,7 +368,7 @@ void dma_direct_free(struct device *dev, size_t size,
>  	 * If the allocation used decrypted/shared backing pages, restore
>  	 * the encryption state on free.
>  	 */
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |=3D __DMA_ATTR_ALLOC_CC_SHARED;
>=20
>  	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
> @@ -436,7 +436,7 @@ struct page *dma_direct_alloc_pages(struct device
> *dev, size_t size,
>  	struct page *page;
>  	void *cpu_addr;
>=20
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |=3D __DMA_ATTR_ALLOC_CC_SHARED;
>=20
>  	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) &&
> dma_direct_use_pool(dev, gfp))
> @@ -480,7 +480,7 @@ void dma_direct_free_pages(struct device *dev,
> size_t size,
>  	 * if the device had requested for an unencrypted buffer,
>  	 * convert it to encrypted on free
>  	 */
> -	bool mark_mem_encrypted =3D force_dma_unencrypted(dev);
> +	bool mark_mem_encrypted =3D dma_require_decrypted(dev);
>=20
>  	/* If page is not from an atomic pool, dma_free_from_pool_page()
> fails */
>  	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
> @@ -649,7 +649,7 @@ int dma_direct_mmap(struct device *dev, struct
> vm_area_struct *vma,
>  	const pgoff_t pgoff_end =3D vma_end_pgoff(vma);
>  	int ret =3D -ENXIO;
>=20
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |=3D DMA_ATTR_CC_SHARED;
>=20
>  	vma->vm_page_prot =3D dma_pgprot(dev, vma->vm_page_prot, attrs);
> @@ -798,7 +798,7 @@ size_t dma_direct_max_mapping_size(struct device
> *dev)
>  	/* If SWIOTLB is active, use its maximum mapping size */
>  	if (is_swiotlb_active(dev) &&
>  	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
> -	     force_dma_unencrypted(dev)))
> +	     dma_require_decrypted(dev)))
>  		return swiotlb_max_mapping_size(dev);
>=20
>  	return SIZE_MAX;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 11c127ad45370..e7c48a925b7ac 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -673,7 +673,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size=
,
> dma_addr_t *dma_handle,
>  		return NULL;
>  	}
>=20
> -	if (force_dma_unencrypted(dev))
> +	if (dma_require_decrypted(dev))
>  		attrs |=3D __DMA_ATTR_ALLOC_CC_SHARED;
>=20
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle,
> &cpu_addr)) {
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ded7016a46a71..d08a3643ded14 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1552,7 +1552,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device
> *dev, phys_addr_t orig_addr,
>  	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
>=20
>  		/* swiotlb pool is incorrect for this device */
> -		if (unlikely(mem->cc_shared !=3D
> force_dma_unencrypted(dev)))
> +		if (unlikely(mem->cc_shared !=3D dma_require_decrypted(dev)))

Just wondering, what if a device with CC_PRIVATE set has addressing
limitations and needs a private bounce buffer?  Or is that not a use case
at all?=20

Thanks,
Shameer
