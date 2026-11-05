Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892324;
	b=EzN/AzoTkzgOKtfUlaLvXkCgHqNhCCCp4rZnGoOmacMQLrzBD9vxO15iLS+hLO1CgH/f
	 EaJMRm2D8IVQ4uLABsvs0z7zSHb0jG7kQFgJ4FAkLxpCcWN+aHRZQ4ceFV2E6HedsP1OD
	 odo0UdTBcE+wEL5zBZoTbSJm3j16XVzyvscH1aJiHfk+g6tB5DRJgwetsWzZP9t502YAE
	 1h0Y7KpGjRwgO4I/BaMF3d0bksHQBi8p99KRsCPtb3WuJuPGKXOu14gJWXYT+4hhuVszc
	 bkrfm3ezCEDKJu/kJYOyOAW1oUmd/0vsFDgEBOIe2RBSeHratpwoKigvFNG1sdKujwg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892324;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=chjfJQZa4Uo3UU2FoBTraFnHNUmZRP0LNaNiqz59ONA=;
	b=M6dg7V9m3PokCiGzuZoWw8A5zl+3fhYS2JqY0ZvTmA0+Skllj07Glo/Qi3WSND540wM5
	 Fj079UHCWi0nc5yTEjpqxq6fCnDOvRWY+xUoASnZ/+Pf+F7+sKXQcdTP6qwJJqi5BqFZp
	 f8x3KKla4Qdvrj/E64y43HMdv+RwvRwM/c29PDy+LFMSHDQ1fGLxgOKw8kTWwFrRldpYG
	 Ubq8YWyJN+wHkGv5es2h0Idy25nvzwoNowOkbJmJhr8tZvyrACGcrJ35v3Dj8TdkuFyGP
	 gua+A3ipTIi8d1GSfav75Mpa2Gxp0REIshbKzNu/8lv/Y5VEoJvBU1qIXgpVybHTw4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0t4Pg01f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.27
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E99606A329
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 15:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E99606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=0t4Pg01f
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oavxZ7Ftjr7KcqqX47OrRcSs4vwDfTR76722Khy8YE4UU7yJUD/Ub3qrbzSn57iPXV9AxwcWGdMMZZ702kjK910rSUT2RZTDxU3L0zeEB1Iw3Ca/kBbujqHfPA+11JFWtRHLY7JHekfqscYOhVbjo1iUtoEo0VtzxkXvOvLB3S29pU4CZtx5L9qgEKyRM/zpgqboH3x+uxOvlaqIXMRsA0rmJFlcVaxAEa4xzvHNfZig9eredxYRrcefXePRuwSlYyrBYgqbWYUmTmWA2x/wgZ7jfdccfYQKjLU//MZg4UAMvFUYF6v5r/jgOLxdoe71zH8H7pfCMITwaQjN/Zx53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chjfJQZa4Uo3UU2FoBTraFnHNUmZRP0LNaNiqz59ONA=;
 b=KdN7HstQljBoW6y2kPgMwS8sBzWubm3bWi1iFRQ3283KwzR2K9wCfMjunKztDffB0BG9XRrNQg+JmAgqdoDZ2hJJx9aKeNqFp1sArU5UvcJK4fswnOSGYYvx5kSk3CjIe70RykOBkURWCpmJsM+zB4HHNRUXKTMjA0CN9PdkpHk9jI6BhBFD9vN4kLROWNcLnkDXNLStSj4g8FfAqZEl1+RtAtttgKPe8/2iiuJbj4ejhbdcebe5Q+1SFvXZ51+JrL+MRFNDMSH5nnaziI6r149MVegiG7/QILoL3khtJlh5aX7cQC9M8f8XSVOBGlBWqOrslZt5QIA+Le6Y8J8uLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chjfJQZa4Uo3UU2FoBTraFnHNUmZRP0LNaNiqz59ONA=;
 b=0t4Pg01fCON84C5VbOl2mktyMfRpP4LNsGXvT7Ugeg/J+vxkwpO3diTPl2zSnMdksSXFtwZx/uNtBvBR7Oal2Vo9NE3kKBosCR6T0CJ1bS5LMYilAcEiR6tYcfx9g6DqIr/jOx97ofAwoOaGZGaH38t6psdqznH8GP/JVFSRHTM=
Received: from PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:25:18 +0000
Received: from PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069]) by PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 15:25:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hegde, Vasant" <Vasant.Hegde@amd.com>, "Mario Limonciello (AMD)"
	<superm1@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v5] iommu/amd: Enable PerfOpt automatically for integrated
 GPUs
Thread-Topic: [PATCH v5] iommu/amd: Enable PerfOpt automatically for
 integrated GPUs
Thread-Index: AQHdYmZ/b1aiF5PGn0eipOlHvFviBLca7+4AgARrLICAAFO0UA==
Date: Thu, 5 Nov 2026 15:25:18 +0000
Message-ID:
 <PH7PR12MB68124D930415CDD469C4F56EF7772@PH7PR12MB6812.namprd12.prod.outlook.com>
References: <20261022-superm1-perf-opt-next-v5-1-dfef0b78b7b9@kernel.org>
 <4206ec86-c6aa-447a-a5d1-4d2e89a31b5c@amd.com>
 <efd2a9cc-dcbb-4f45-8dd7-7fcd713830ec@amd.com>
In-Reply-To: <efd2a9cc-dcbb-4f45-8dd7-7fcd713830ec@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-05T15:24:58.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6812:EE_|PH7PR12MB6657:EE_
x-ms-office365-filtering-correlation-id: e6b2f040-3e74-4047-c19e-08df3b50ff9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|38070700021|4143699003|11063799006|261026121527099003|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261021123027099003|56012099006|261021121427099003|261102130727099003|261022105027099003;
x-microsoft-antispam-message-info:
 68IJMo/bMJGnHMz511aDJAWHIdB901L+Eg5FW6NZku8qsv7Ut/GaQvCNZrU0/6WtgvARUeFUD/zalFkyeIvPOeU0+vUTsGzXvjqfw+Pw9FCMxWAJmtxzcQ+KeYHcb36Wgwkz7Y88D93tzUBv1ErSfnvN3QOszjS/vpVt57Zc8Ya4Vyx++YE7/Nh5hZcD6yhm4gftHMrw/GgXsYr7+wededNPdx2zkQTZiTmyOgCBCab3r2vqIJi6wPHZDnaw9gtymVcV46GFHmLlFp71hROEVR//rr8E74YRlklU86eJ8xM5B4K5bgTfz021J5IvXT+xIDrY28ClVZXaVY26p90FhMw3ub07T6tQuv2vqUfc17KotSE91jkKgUmBy8fXdYeMBc+OUIXeqgBYXTsjy4+FIcYSnOV3mHZtCRrkv6S4YGJvyaAZAlazwawRsYVorFbfQcNc5mC+hTc9d7Ak2xvSB6wq3NnmSRkbziFUQX6kxEq1jWFgYlb8T6kIt4QlQHjwEKXYwz9s7ccFFhppRXd9unGFbAbiJRigfbR15BeI0K3Nh2ciFq/IlktunvFjBb204Vzl4Eh5wPlvyMhWPnK4M0R+R4p8O0sUk6QRqMmUqSlim8QCyr/rCvfmRgzrLaG6Lwmaw3st0bjJ8JiGzRK/o6RjjlIS3f87zSqdgDeKn2g1zfyBzr36J8WaxlKjIZ7fuARshGODmTXFJRauTCzbrWesG5LJixFIff7o8V3Jwrg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6812.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(38070700021)(4143699003)(11063799006)(261026121527099003)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261021123027099003)(56012099006)(261021121427099003)(261102130727099003)(261022105027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGthOVNHTFovcXkwc0NXV3VYU01iZ05CWjJlYlpJejlwUlh6SnZkbTl1R1ZP?=
 =?utf-8?B?ekhyelZWd1VrQndLMlZIdTNEdmZDL1pTOXhNYzRvZjhVd2JSeEhpUG1uNDQ3?=
 =?utf-8?B?ME5YYkRZNnpCenhyNHhZS1ZVMDJ0NXpKdWdBWHdEUzdsMDYreHdQMjlxekh2?=
 =?utf-8?B?bzNMK1BuWUxBQkZWZmp6eGRGc2xrWkxhRlhlY2t4cGJmK1dOWWhoWTNmY3dz?=
 =?utf-8?B?ekhGMkgzSWJucjkyMzV0V01SZmcrOHNydkZOUkRodmhlQWViWlVKQUY0LzVj?=
 =?utf-8?B?QUh3RzRVRm91cDliUjVlYndBSllEOFFQZW5qbEtGQXBCYjlPTW9vZXc4eTZV?=
 =?utf-8?B?WkVQb1BRVUN0UXpxcFZha2dVVXpMazBuMzRGQWdiazZOUEY1aStaRmdFRmVO?=
 =?utf-8?B?N2QvcGhKd3dNNFM0SlpVR0VrR0tpRmJRcEh6cnJkTnJ2T3Fia2hzamdVYmt5?=
 =?utf-8?B?RkgvOEFtVUpDZXJHaElyZ2IveXJUTG9ybytPNGxCSFp3aGlhUDgva0UrMXhk?=
 =?utf-8?B?RkQrc2VIdy8vMkRvQzZ3QmVnbHpnRWlPQUNCUmMybXBPSEJhRnZraWs0WEM0?=
 =?utf-8?B?L1o2d3ZFQitMdUIzMUNINDFoK0hpL3lNR0NFYkMvVDA1QUdLcmQ0WFFTb1ZH?=
 =?utf-8?B?L2NXQ3hXWlVEYUNHWng5LzRSQjlVME81NFhXZFlmTnhJa0hQRFVZZjFqdlUx?=
 =?utf-8?B?TDlqamY1K2xrR3FvTXpWbXBmWERUQzc2NGZna0VjTEZFcXRiZ3VmVFVKdVZB?=
 =?utf-8?B?Tk96RVpzYVdSQUx5VFVjK24zc083Uk9VQUI0a1pyYVI3WGthRFltUGxSVG5N?=
 =?utf-8?B?RkFzTEF5YXR2bDNnd0pNcEVQNjNNWFVUTXFsVzkzMExpRWlGSSt0ZDhGNGdy?=
 =?utf-8?B?QjFsNnpqbTJKRUZQTVlQRnVVT3hVRm5mbVl5UGU0ZCtpNU9LU3hZa1dLVVFP?=
 =?utf-8?B?L0xPc0JWRytsZmJqTUZqUm9NaU40TklxU2x5TXhVcUU0L0t2T3laMURCdVYr?=
 =?utf-8?B?YlJHL0IyNDhYUk9ZdFl5ZUhOTVlpMmdhNldlc2wwbHc3bG9Ea0JyOU9CSVNq?=
 =?utf-8?B?MHRNek1Zc0ppL2lPMFJQWjl3RElxS2NxdndZNm4xeklheGtDTXhZWTduR2VG?=
 =?utf-8?B?WFI4QS8yTkdwL2RRRUhlcXNXWlFtclRRYWNXT3VXUjVaT2ZKc2ttdlpkTGVS?=
 =?utf-8?B?NTZWeUorVWkzV01JQldTNVAvQ2lqeEFzRDFuM2daT2NpclozdzlUOSsrTmFm?=
 =?utf-8?B?Z2U5WURhSnl4aUxzeGFzcW5xK1Y0ZVB0cHNiVTR5d3MvZ2JPbVBNd2hCaWxv?=
 =?utf-8?B?VzNZazNHZFlFRnp0dm1DeVVIRzU2c2hVRm9YdlJGLytmSGlxNExPa3dxeS8z?=
 =?utf-8?B?SDNpMHJDVEp2aVpIc1p5YjUrbld4NWhDdmNJczh5Z1cva1pvSmxKaUNWS0hD?=
 =?utf-8?B?aVhTZStzQkdiNS9Nc3RKc0hUTzUwWVFkZk1EOE9ERzdXZHFycFF6VG4xTWlu?=
 =?utf-8?B?RUVVTlg3VlliZ3lxTUpZZHpnbXc3bHVuK3plZXNqS3NNdXB4cktPM1puNXBF?=
 =?utf-8?B?Qks0OVRaUGxNdWlEUm1tWHp3WXg0RUdaS2VmcTBpeFBRK2xUaFZGRldQdjlE?=
 =?utf-8?B?c3BLc0lZSGRnbzR0MkFJYlh5QTRkcjc5Q1ZpMEFPUW5lbnFOYVYxVk9rVDFI?=
 =?utf-8?B?eTdLTWZqcDhvY3RKdnFtTWpDSnA2MDNPWUc4VjhrNnNXWlo5a00wVjZFWFZM?=
 =?utf-8?B?dTEyK0d4cGNuR0JpWmxGTzFDaXdHWnA5RHF5Nm8rVlZ5YUUvd1FmSldpeVAv?=
 =?utf-8?B?bUtkR1JFeG9FYVJtK283YTFxLzJDekpHVi9zK000dnRvSHJ0Szd6aXlPU051?=
 =?utf-8?B?RG43RkcxREFjN3dDbkF3bmJnMENKVFVES0dNREV4M1FhVitZa2Y0SElDNkZt?=
 =?utf-8?B?bmZZck03TkxtRTZQOXZzRXB2ak5lVmVLTEhMYTA2ZloxeTBCR3J3VzRyQmdZ?=
 =?utf-8?B?RmgrUTBnNkZVUWJ6eWZENlYvQlhCZVJsSEY1WktldlMvYVhQOTNUdlJYcFBO?=
 =?utf-8?B?Z2FlVkpLZGg1QzhJWC9jbEdlUmNiMVdVY0szblVBOEliZEl6MVI0M0ZWc0dz?=
 =?utf-8?B?T2luclFqTGJyYWJoOGQwd2xIWElGemNWRzZkUE9oWnZscWtjS2tOQXR0TUdB?=
 =?utf-8?B?enZ1TWxJclQ4d3lQNVJ5MHkxcVVwanBjaEhnTm1xK2NEdXFGZFFZZ2U0OXlV?=
 =?utf-8?B?VWg2Qkpuanl3ZTFrU3RzRFY1eU1PTThVc2UzWmZXck9XS1ZBMEVoeE02cnJa?=
 =?utf-8?Q?TPrT3vay/jpdEGicN2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b2f040-3e74-4047-c19e-08df3b50ff9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 15:25:18.1431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n824AFzTJyDlESGpR+1w2EZA+mzJ0n75Qs5CrjW+9HZlLbhP3EAGmnOSB94bfJJ2La0HpP58HdteiNBl/q7QjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVnZGUsIFZh
c2FudCA8VmFzYW50LkhlZ2RlQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciA1
LCAyMDI2IDU6MjUgQU0NCj4gVG86IE1hcmlvIExpbW9uY2llbGxvIChBTUQpIDxzdXBlcm0xQGtl
cm5lbC5vcmc+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+DQo+IENjOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT47IERldWNoZXIsIEFsZXhh
bmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEpvZXJnIFJvZWRlbCA8am9yb0A4
Ynl0ZXMub3JnPjsNCj4gU3V0aGlrdWxwYW5pdCwgU3VyYXZlZSA8U3VyYXZlZS5TdXRoaWt1bHBh
bml0QGFtZC5jb20+OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGlvbW11QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIHY1XSBpb21tdS9hbWQ6IEVuYWJsZSBQZXJmT3B0IGF1dG9tYXRpY2FsbHkgZm9y
DQo+IGludGVncmF0ZWQgR1BVcw0KPg0KPiBBbGV4LA0KPg0KPg0KPiBPbiAxMS8yLzIwMjYgODoy
NiBQTSwgVmFzYW50IEhlZ2RlIHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBPbiAxMC8yMy8yMDI2IDI6
MTYgQU0sIE1hcmlvIExpbW9uY2llbGxvIChBTUQpIHdyb3RlOg0KPiA+PiBQZXJmT3B0IGlzIHVz
YWJsZSBieSBpbnRlZ3JhdGVkIEdQVXMgaW4gaWRlbnRpdHkgbW9kZS4gRW5hYmxlIGl0IGZyb20N
Cj4gPj4gdGhlIElPTU1VIGRyaXZlcidzIGRvbWFpbiBhdHRhY2htZW50IHBhdGhzIGluc3RlYWQg
b2YgcmVxdWlyaW5nIGFuDQo+ID4+IGFtZGdwdSBwb2xpY3kga25vYiBhbmQgZXhwb3J0ZWQgZW5h
YmxlL2Rpc2FibGUgaW50ZXJmYWNlcy4NCj4gPj4NCj4gPj4gTWFyayBzdXBwb3J0ZWQgaW50ZWdy
YXRlZCBHUFVzIGFzIFBlcmZPcHQtZWxpZ2libGUgd2hlbiBzZWxlY3RpbmcNCj4gPj4gdGhlaXIg
ZGVmYXVsdCBpZGVudGl0eSBkb21haW4uIFNraXAgR0NSMyBzZXR1cCBhbmQgQVRTL1BSSS9QQVNJ
RA0KPiA+PiBlbmFibGVtZW50IGZvciB0aGVzZSBpZGVudGl0eSBhdHRhY2htZW50cywgdGhlbiBl
bmFibGUgUGVyZk9wdCBhZnRlcg0KPiBpbnN0YWxsaW5nIHRoZSBEVEUuDQo+ID4+IENsZWFyIFBl
cmZPcHQgYmVmb3JlIGF0dGFjaGluZyBhbiBlbGlnaWJsZSBHUFUgdG8gYSB0cmFuc2xhdGVkIG9y
DQo+ID4+IGJsb2NrZWQgZG9tYWluLCBpbmNsdWRpbmcgdW5tYW5hZ2VkIGRvbWFpbnMgdXNlZCBi
eSBWRklPLiBQcm9wYWdhdGUNCj4gPj4gZmFpbHVyZXMgdG8gY2xlYXIgYnlwYXNzLCBidXQga2Vl
cCBhIGNvbXBsZXRlZCBpZGVudGl0eSBhdHRhY2htZW50DQo+ID4+IHN1Y2Nlc3NmdWwgaWYgdGhl
IG9wdGlvbmFsIFBlcmZPcHQgZW5hYmxlIGZhaWxzLg0KPiA+Pg0KPiA+PiBDbGVhciBpbmhlcml0
ZWQgUGVyZk9wdCBzdGF0ZSBkdXJpbmcgaW5pdGlhbGl6YXRpb24sIGluY2x1ZGluZyB3aGVuIGEN
Cj4gPj4gY3Jhc2gga2VybmVsIHJldXNlcyBkZXZpY2UgdGFibGVzLiBSZWFkIGZlYXR1cmUgc3Vw
cG9ydCBkaXJlY3RseSBmcm9tDQo+ID4+IGhhcmR3YXJlIGJlY2F1c2UgY2FjaGVkIGZlYXR1cmVz
IG1heSBub3QgYmUgYXZhaWxhYmxlIHlldCwgYW5kIHN0b3ANCj4gPj4gaW5pdGlhbGl6YXRpb24g
aWYgdGhlIGluaXRpYWwgY2xlYXIgZmFpbHMuDQo+ID4+DQo+ID4+IEVhY2ggSU9NTVUgaGFzIGF0
IG1vc3Qgb25lIFBlcmZPcHQtZWxpZ2libGUgR1BVLCBzbyB0cmFjayBhY3RpdmF0aW9uDQo+ID4+
IHdpdGggYSBib29sZWFuIHVuZGVyIHRoZSBJT01NVSBsb2NrLiBQcmVzZXJ2ZSB0aGlzIHN0YXRl
IHdoaWxlDQo+ID4+IGNsZWFyaW5nIGhhcmR3YXJlIGF0IHN1c3BlbmQgYW5kIHNodXRkb3duLCBh
bmQgcmVzdG9yZSB0aGUgYml0IG9uDQo+ID4+IHJlc3VtZSBvbmx5IHdoZXJlIGl0IHdhcyBhY3Rp
dmUuIERvIG5vdCBlbmFibGUgUGVyZk9wdA0KPiA+PiB1bmNvbmRpdGlvbmFsbHkgZHVyaW5nIGVh
cmx5IElPTU1VIGluaXRpYWxpemF0aW9uLg0KPiA+Pg0KPiA+PiBSZW1vdmUgdGhlIGFtZGdwdSBw
YXJhbWV0ZXIsIGRyaXZlciBjYWxsYmFja3MsIGFuZCBleHBvcnRlZCBpbnRlcmZhY2VzLg0KPiA+
PiBUcmFuc2xhdGVkIGF0dGFjaG1lbnRzIHJldGFpbiB0aGVpciBub3JtYWwgZGV2aWNlIGNhcGFi
aWxpdHkgc2V0dXAuDQo+ID4+DQo+ID4+IFN1Z2dlc3RlZC1ieTogSmFzb24gR3VudGhvcnBlIDxq
Z2dAemllcGUuY2E+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IE1hcmlvIExpbW9uY2llbGxvIChBTUQp
IDxzdXBlcm0xQGtlcm5lbC5vcmc+DQo+ID4NCj4gPiBMb29rcyBnb29kLiBRdWV1ZWQgZm9yIHJj
Lg0KPg0KPiBDYW4geW91IGFjayB0aGlzIHBhdGNoIHNvIHRoYXQgd2UgY2FuIHBpY2sgaXQgdGhy
b3VnaCBJT01NVSB0cmVlPw0KDQpBY2tlZC1ieTogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1
Y2hlckBhbWQuY29tPg0KDQo+DQo+IC1WYXNhbnQNCg0K
