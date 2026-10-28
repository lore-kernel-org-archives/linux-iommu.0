Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793197166;
	b=oKGQRIyyG8NguRnBxeVSpCXdE0/qnX0ztXHpI+hXSqxsUcB0gEb6nNveBrj17vexgPfT
	 n/JRni4lISxHZZ+rcJqivtjVtnXNFeDpirBOb3ZfnnajNHwEtXdjF29WlAQpjr5vbqVT3
	 wX9GKTbWEzAMDRVyhhVvsZ2Yq2nozKr3XzREbmwR0GICyLpW6NtVoypCYVI6jv3XGAItr
	 gZokBPIc8+FmHrKMp3NursfBDpy+fDBKiYrc/gsOYf8oV6iA6zIVXli0OEWJjPmePmyMA
	 fHSyaGnu/mtxSKFdQs65T9fobxoI7huH1QqyCg4zHbfttwe8Qdh2k0V2lzoPFOo/0fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197166;
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
	bh=402DHg2gWrnziKcvELGyUogx/pxVdZr183tfFQx6Fto=;
	b=cQ6FrnmAViIAAbsa/+iyfqASxTXVkimiLQ5CxqA9oe5o8cpX5bqEcvN3YZqXInGepySC
	 cnCob6CDlnGCDqImqxO1mw4DX9pTy5iLdvwjJzjPqzXq9YZVUB10fH9aXSVxMStryUmjI
	 4CB5LRNncE3/laWTu9wZ6/pQB2nVQpNLiC2cHXFJVuQCbH27tvx8HVz6u1adtKMG/hiD5
	 KMyY8/PIu9Z1zthhrHrptb1tMC6LBIfTlVmOssHWV4TXUtbTXg+2+CK976/BP4yEuG8YQ
	 VUor0T7VR+kVhFwJ7q3Hj9Dym6C5//76BVbbizZmKrByH6l9Kc9+kcXbKaS6tMIrFUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K7tRupHG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.40
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012040.outbound.protection.outlook.com [52.101.48.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59D60A2615;
	Wed, 28 Oct 2026 14:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B59D60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=K7tRupHG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKB4eKbRjH8P066G9rcmIGoDL8O/wfcjlL5GulEq80weJ5DgrpDLmB1OgkyOEIKy3f4Ay9+Bo5vdn7qfKSvTIbSpWm6UckXM4A+vFrK1FnZucPFIp0yLB3BM5AXsLH7GaA5LksKEllss/b9T9kiMgmrFtA38TxmPEFMM99JJjt2QjO9MsMhkPowrXvnVDqMflaf6lZSS728HWaOw17JAcVqIznLoBao9WC0ayADCaycW0d63o2CSf7+rLh7dDjr49q1yU0ixazBMhtpT86YdUJlK0k2cy9IjTZo/E8PrAgCU2vUL/wUfbpyvENYO2rnxaDb4nBplKuHd8oKNz6QbHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=402DHg2gWrnziKcvELGyUogx/pxVdZr183tfFQx6Fto=;
 b=hjqGd2R4vqCYFv8rtBjYZNMLOzq/DXcQ2s6k9imQdctRIZIMl4q8/AAvKY1+SnuUoI3EzNSs+6a8G7IgDZJ636s8VxTnTjx20aKuv6SSp8fTPm5GnWcBa2HwgHQAdSHrRKM8zmDubywaYh5g5SL93RpR0KvvdkpXYeNAuKuPL9YwK4/nEPpPbDNuVqVGGLRSR3tZSlIehIKYPOpRYec/WdfY5PThbYCENi3zUn3Xwx3vdUs2h1UFaWZWOidBhy9JDBdN7bEVLzBkDelR4idROefChsJakpd9x+g8EgeKEdFa4gVl6yMhsmcQVv7YyWC+f6ykSWDYJtzzGRDlrreu8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=402DHg2gWrnziKcvELGyUogx/pxVdZr183tfFQx6Fto=;
 b=K7tRupHGjzzfY+Z0nKx0q5/XytfoiS6pcHMdZR8v0Cm4AFmKKw9EnI5iYHQ8RjMnNkRchvVwv+V7s9ZGhz4/rWxdQXEsH+aSI1KgP5p4ZvcqRTr4pI73p65gnbDHKHf+9ihLadaDFd0K3d7a3EmBqVlTzfTDAO5UGsVH4Q+EYowrbIe7+1p8dsUSSIQGSFtEE/bIbnCpfdPekYMRemTlio/XNKdX17c76xbUcmIG0fWDbhLvsLlknXCDYsdv/821BP0na5xMtQmz8kLdt0+QfT/Ip5C/Qgx9KH10RiywQ6C0X5AQRjlu16mtY+vOEYX0yPs/9aquPo2NTY5Lhl7lYQ==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by MN2PR12MB4078.namprd12.prod.outlook.com (2603:10b6:208:1de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 14:19:17 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 14:19:17 +0000
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
Subject: RE: [PATCH v1 7/8] iommu: Park TDISP T=0 devices in the blocking
 domain
Thread-Topic: [PATCH v1 7/8] iommu: Park TDISP T=0 devices in the blocking
 domain
Thread-Index: AQHdQNVJsIEcU7+R30ubkYzGNAOtD7cTTLzw
Date: Wed, 28 Oct 2026 14:19:17 +0000
Message-ID:
 <SJ0PR12MB8614232EFC74C584CB44AD28AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0d57c59aa3cae891e9d3e07e939e13918a4e99a0.1789010941.git.nicolinc@nvidia.com>
In-Reply-To:
 <0d57c59aa3cae891e9d3e07e939e13918a4e99a0.1789010941.git.nicolinc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|MN2PR12MB4078:EE_
x-ms-office365-filtering-correlation-id: ddae15b1-f915-43e5-a6a2-08df34fe735e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|921020|38070700021|11063799006|4143699003|56012099006|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261021135927099003|261022075727099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 SNL/2U+6LZBx4p/dsDH3aXNOUU/lDzNxuxXiuc4q9h35CztBAQ7z7VHsR/QpIU4kHfER99bR4MMMj4A2Swpl2iJ08MbaUXiEaMA93FUy5JyYYTkElDGOlJs/bVkdHZHudTCE9ejgNGXcIxz7DyZfj821CgK+E0fxrgKIBhcJaBfu9rvlEcssxtkqriG1IfWMpN/r4mnE5woZE/KOm9ajILt46KPu7yH3TuESiRnrY2YDqMcOrKdirmfhEh6Yl4EkmhNTWVq/o5aYQwEdJcFipgy84qyTdLzowhDIie2gmv93Id2oqbc/5C8FhdzfkISslgIqFaulJI4kcRmN35bZ5jY5XDNSKuBiiGTJryvPatd7BJZbkqT4/2EuqIbKoXT4esq5+YWd0dVfkwWv6Gqz0wLcWtJs+uJAvgWJnO1NcwC8hMclEi6/qoUg2fk9ZXUZw7dJuVbF3xHOQkWnOaS9ebnSpbke2HrjLA9pcV6X3NX52HXJRgWj4cYGUxf9cTP8t7xtudCaAVNKhEWC1qSBtOVa1S97xkbcZ1j81yuENBka+jD5mn/mak5KummFRLYLQtVNjgzTTdXUU9JMYjjobD0sYJVVqf3skr2hzhT9q30BOuPspdxsSwirzPXa+I5xj1ifhAuV/Daxb/rGL67SbykTVRctY4WguBMajLUf9qcx/y57w17beF/nf29qrTTkE5AIJQRiYB/OCuIqI3X1ave/RarWNw8pkZ7YaU6EOEq5Up6MiePeKy2/cfqXALw0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(921020)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261021135927099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pbFRXyOCu76o/P4zz5umYHVPrY/XeQ1BFg/ACkkgCfNIf0okHI2RUpGTCoZU?=
 =?us-ascii?Q?BmMOSgdr5d3tN88bR726LU9d5qY6BXEZNR5vRTDpRYaDSc+v87UuypqZbK2j?=
 =?us-ascii?Q?d36VsMdGdG0JFu+eujggxlRPpcpgFsTg+2J/Vn9gfFTjTs+fiP14F6J78MUZ?=
 =?us-ascii?Q?Hw4w1Z5o9qqVcQGqM7FPcQAZM1EcRq0YrWCNzT8W6asuZQNdyrkPPRa8xrHl?=
 =?us-ascii?Q?VtCbuUv9h6VeovzZWejoMEC7oGnn8p8Xs4kGItc7Zrs2LL8ihCROCFN8gRF5?=
 =?us-ascii?Q?dOYPjzt3J/N49aCTeND5xGjlAud8cct0HV8M+RjvkUNV572XRL7ActDr9X13?=
 =?us-ascii?Q?QHDOcjq7yKP2f0D6y+uKxWvj8Ncg+lMYAPCCwT4haGCLmsF/TiADojAptqZH?=
 =?us-ascii?Q?fCMqRg7n6Z5ufAKIkWhxjGcjwYpOpVbDfPjpfiDeeRc4WINAJA9chAxaj84K?=
 =?us-ascii?Q?88hCeDuueBYVt2qfaNC0FtnnxE/9WSoQGUcyDZjZLX1nltAVTXwcedLo5mD4?=
 =?us-ascii?Q?IzuQBK+wqQXdx4k8n01NFYrvxJxvMQ6ht50fj5zQDtzeYXgcN8WRqkwkvhAv?=
 =?us-ascii?Q?1EHEWQajjW0TyIfJswODpzNpqX3coQlXmOYxJ+W1dfev3QeAs7Zn/0cz+taO?=
 =?us-ascii?Q?At0R2He2sSlZuHOAR6oyo6kOQunRROsDtvUftacLwcx3XbI5RZwaA56L25/E?=
 =?us-ascii?Q?K9mQRlFB/Wr88hZeUBgbhT/tB/aDmzeVGOPWXO/w+9t9KCPKWKrZdxkgXsor?=
 =?us-ascii?Q?tEwKVxMv9s5KMPEarrnP+FNs3xKBC0D2ylAQ0PFY0spJgAbXIe3Z77ZOO/xv?=
 =?us-ascii?Q?IRKIyAmUbwlyCQwZTE8SRTsAYz8UhofD5YYohBDMS0EqD3tsJBR1ZCFZzSZL?=
 =?us-ascii?Q?B9aEn+GoQy1VY7XQgvrJXJ/92FYJKj1pD6UnhGi+Cv2T/uzkcfKvAz84RfXj?=
 =?us-ascii?Q?lz6caxTiWUAjpW+68Bm2KY9CVbMERArExgCdHuYKfzjK8GmZfLwUQUCcJF7j?=
 =?us-ascii?Q?qoV5rvnhPGTSabmYDj7sleOto9T5yO1I8n7ogsRHBBcm0FTWzw0WLyACI3mi?=
 =?us-ascii?Q?VxfFjqapESJtjD93BtQrbBEA/gqG7nUgSm4jWZOQJZvAWWWGkw+vljFJ/cEQ?=
 =?us-ascii?Q?r12BzeUB2jFlH0lSeyFlNl7jU8+mCoNt+mmx8Ufgz2KIQt288NR7feK/uQd0?=
 =?us-ascii?Q?hMUk3rdeOo9yFKI03FyqTwt0B6uaWvCZZ1Z745fJVQpPnFmo3XENZcNWN7WQ?=
 =?us-ascii?Q?v1kRRmOC011ZkPckRTQTbgT5bmF34AlU3wwWrwrccsOG0uNMmeqngm8+cIBG?=
 =?us-ascii?Q?5gn5RIRIIfvfaduG16raYytYqiSQ/hc8x7CBbzucdAbHbPvN6F+YDKDkE95u?=
 =?us-ascii?Q?uBTT3T71L0Fv9q3v98L1cTudFOpI5hyMjIfBMycJrjf3owahMGzsRnghyiL7?=
 =?us-ascii?Q?2CbjPFOXK3CACdD5pgjIKAMMOPC8xELa9mBXUPN63yv+hFrHyguYHUGU02H3?=
 =?us-ascii?Q?fUkRPj1bZrC49MAi7QV22Y0gO0MadA+yBfbhwAPY0sgi2QRhCQpPSib1dlVv?=
 =?us-ascii?Q?EnLKjGRwwMVIIivZJugIf7B7aWgSx1+tYFTjP1meWCl8LpSSMVWtTu1y3S8V?=
 =?us-ascii?Q?inI3z/m9A21LxEajbRzT5qWcoz41/6oRce5VZ0RJlCTp5LkkjcYW0ManVLjw?=
 =?us-ascii?Q?i0IcDFHAMOkq3C1L+rRkLNUjJNmXQQ7xeTQlRtV81c5d37WNmfbiaETQ/y9+?=
 =?us-ascii?Q?421fd+eo8A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ddae15b1-f915-43e5-a6a2-08df34fe735e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 14:19:17.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JscbrpawtEr55MYsvM2Wyh5SXfI+iX4hs4nlG0WL+Asce+hgn4s2GuyVfCR1XfDCGvW7P7V5coInl4/xmGnpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4078



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
> Subject: [PATCH v1 7/8] iommu: Park TDISP T=3D0 devices in the blocking
> domain
>=20
> A TDISP T=3D0 device stays associated with its guest T=3D1 vIOMMU, yet do=
esn't
> use that IOMMU for DMA translation. Instead, park its guest-visible strea=
m
> in the driver's blocking domain.
>=20
> Linux's model requires a device to either use T=3D0 or T=3D1. Aside from =
MSI,
> it cannot use T=3D0 for normal DMA once moved into T=3D1 mode, since the =
device
> will have IOVA's that are not valid in T=3D0.
>=20
> Select the blocking domain before normal default-domain policy is applied=
.
>=20
> Direct-map reserved regions are still fine, because the T=3D0 stream alwa=
ys
> goes to an identity mapping. Skip them here, as recording the request wou=
ld
> only refuse the device its blocking domain.
>=20
> Reject sysfs domain changes, driver-managed group attachment, and any
> PASID
> attachments that would install a translating domain. The state is uniform
> across each group because all devices on a confidential IOMMU start in T=
=3D0.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommu.c | 49
> ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7ac6569af6773..d6b00e0373f5c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1238,6 +1238,14 @@ static int
> iommu_create_device_direct_mappings(struct iommu_domain *domain,
>  	unsigned long pg_size;
>  	int ret =3D 0;
>=20
> +	/*
> +	 * The direct-map reserved regions are still fine because the T=3D0 str=
eam
> +	 * always goes to an identity mapping. Skip them: recording the
> request
> +	 * would only refuse the device its blocking domain.
> +	 */
> +	if (iommu_using_t0_stream(dev))
> +		return 0;
> +
>  	pg_size =3D domain->pgsize_bitmap ? 1UL << __ffs(domain-
> >pgsize_bitmap) : 0;
>=20
>  	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))
> @@ -1790,11 +1798,22 @@ __iommu_group_alloc_default_domain(struct
> iommu_group *group, int req_type)
>  static struct iommu_domain *
>  iommu_group_alloc_default_domain(struct iommu_group *group, int
> req_type)
>  {
> -	const struct iommu_ops *ops =3D
> dev_iommu_ops(iommu_group_first_dev(group));
> +	struct device *first =3D iommu_group_first_dev(group);
> +	const struct iommu_ops *ops =3D dev_iommu_ops(first);
>  	struct iommu_domain *dom;
>=20
>  	lockdep_assert_held(&group->mutex);
>=20
> +	/*
> +	 * When in T=3D0 mode the T=3D1 vIOMMU must always be set to
> BLOCKED to
> +	 * release control of ATS.
> +	 */
> +	if (iommu_using_t0_stream(first)) {
> +		if (!ops->blocked_domain)
> +			return ERR_PTR(-EINVAL);
> +		return ops->blocked_domain;

How is MSI allocation handled for T=3D0 devices? The ITS calls
iommu_dma_prepare_msi(), which appears to return -EOPNOTSUPP
for the blocked domain. Is that intentional?

Thanks,
Shameer

