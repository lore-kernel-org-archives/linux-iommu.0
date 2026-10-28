Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793202203;
	b=DVIsqHGlyHMl4gdlejoAmJ18dJoE77peHpYnC+i6T/oHL0NzeKDCux84b8+2O2EXbqZg
	 0KFL05UCSDekxeffYcpPeCeUA1DZlvgZZl2zXf5IbYtEIF5XUUXxeYMnBqwzXVGZ3XBDP
	 wB0DzaaBcZPnI+Hm5xyVQ+6OdFKObJztbgwbF9SCPl5bU2D2abMSFQHkGObgH//T7Sw+l
	 AtC2PCxLm0LEjfiGM/ZPZzfx2k5ATJoMtrxypIh4RYrUbEnKUk1LqO0Z/YRNaxzLsEVBs
	 WeLQWaAx9k4JzYVzs4eA1nAMEocGvvQlIgMTLFO3OD/X+uHU+5cAQDClbz5gkNGrehw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202203;
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
	bh=XP9DNJhWnSw/ila5/SAedN6TNLUFT4zaUayC8XQPi50=;
	b=yCKojju3mroObA6EZ/x4V37kUitnXly3zqCLIEu9oatOMQVXJfKcHOaioO63KwcBwerr
	 xSNeCNQ17P70NbTnhgDSk2xkcJ/q9sHqErljugmIMLGKWMvTOYFxuOD6K3bjOrRS+RFHX
	 PuLQAuWLCQQyoNOXGHrtjnz3syrn+9Sqv4Qa4nw3g55IZg5uAM56RyRMDIsDyJxSI+vnW
	 qx4lFMPsujHk6ReZdEJ09bsBmQHA/S7hxsND9QmNSd9eZz4zvjGfkMPRN1r1/gZ8sPgZx
	 03NKBqlSKN44NGE7YTfrrC4xONtZCTDdvIEEweOIYkueLhglKPA3PFOlKW5D4GHLGXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="KbE6/nSc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.0
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A479606A31E;
	Wed, 28 Oct 2026 15:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A479606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KbE6/nSc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJl144M/FBeUmoYgkhQPmConcyJNEBpkI3Sczhx7GsLmxDyzoe51xr+6cU8M6YKfPkqWQ/2ix3lQusNzKj6ZXwGhU3SIoxhMUHZ2hRJofqqG2RkkgtA67LNcvlsHZZEaCwmgQorjf+UVHTWziRa8hIDxRwVPAtOZfEHbbP5nwsktNkl0Ji4BGMdK3XZHMRZfKI57TNvkiUG4iNkDPBU5IMc/Zk8Rhy909WA8n4ueZ11aD8TiqCny970j3s99V295bcE/94xxf0sP4a2j+aqckPs/g0Kzi92TLLA2nUvNk2yVqFMx82mILE+NoQ0LbUjmgcDYwwXM+eRuv7ksC15ptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP9DNJhWnSw/ila5/SAedN6TNLUFT4zaUayC8XQPi50=;
 b=hG1UeW8ONwXonm/8PeeBcN+5cCw5RZeJnlWCTCNkkn3YenhvbxfVGtpl+t0f2wb9IJcuEcLxb7bAJsoizhq3tqcypkeypsbLdiQ+hBaT2SNxAWo0zdRFewoocALD5rypSixm0DaZ7Dj1Ot4GKZWYBcftp4UiINeUEnqKTdeWeuIAsizE5ahNkQIFHnl/aTa1y+COpPEnCSB7890O0MtPnXSI0z3wfXzSdJ8gwzY2PUnblzzc1cctBcSTeSgoVatv3zzJgWNbRF6isnfzkuzk98n0nDRt8r81dZh1lIbuuH9BKri2cK54CU7lPoGhEhGvP7pL2tShXwdK7oMKPaixVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP9DNJhWnSw/ila5/SAedN6TNLUFT4zaUayC8XQPi50=;
 b=KbE6/nScUsvOexQCNL/5UXaVi3bgd+AtGEi07U6ARRTJQ9MFYP42foEh/CRnxxyqf01zRSP6ckCNk0kwyCqKgkRuBT4z/RSRPuf0uneltT6Y5Y4qLDmv0IVpSXutCNfUz5Ryh5Fq+tjiFZeGxOKQtr5c2NpNVVNZ3kVZ/nNmYnbsy5n9M9sUEq8hHprfEcGUr0M5tB5hqr7/Q4ZKN3nnSP9f2D1UAfEid7IB7VWmLH9ll7NZ8OjW+bBr0PqaCe3/wLrrjbrC/7deunt0fkuubd96x6il28jpZlTdkZLyebxxsSm7T/lY/7JgWr7xsUw/KumjIOhNdj3RMbbfjpvhYg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by SA1PR12MB9545.namprd12.prod.outlook.com (2603:10b6:806:45b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.24; Wed, 28 Oct
 2026 15:41:13 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:41:13 +0000
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
Subject: RE: [PATCH v1 8/8] iommu/arm-smmu-v3: Probe a guest-level Realm VSMMU
 via RSI commands
Thread-Topic: [PATCH v1 8/8] iommu/arm-smmu-v3: Probe a guest-level Realm
 VSMMU via RSI commands
Thread-Index: AQHdQNVOuiO7B+HXKkGq3lGx7D+HHLcTYs/Q
Date: Wed, 28 Oct 2026 15:41:13 +0000
Message-ID:
 <SJ0PR12MB861403B542B8D63B2AACE18EAB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <df25452641dc126eb334a1bfbe5eee16cc8a8953.1789010941.git.nicolinc@nvidia.com>
In-Reply-To:
 <df25452641dc126eb334a1bfbe5eee16cc8a8953.1789010941.git.nicolinc@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|SA1PR12MB9545:EE_
x-ms-office365-filtering-correlation-id: 995f8c23-38f1-49e2-552a-08df3509e591
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|921020|38070700021|4143699003|11063799006|56012099006|261009223027099003|261022075727099003|261026121527099003|261026140227099003|261021121427099003|261021135927099003|10067099003|261022105027099003|18002099003|22082099003|261028144727099003|3023799007;
x-microsoft-antispam-message-info:
 rd4TjKjz76rG6gO1BMzTOtt8nJvSFsycJVb/aQAM2roonL5DgJ2SSzN+4YlrDCYn0LK4jmjIlgqZ4l87eNFAm0xD/UnnReEJZFLxIOAvKVEwO7isbyUhOT4kotMomnjH4in/idOOamQFNk4ZO08JF+wMsAYqAZ1HKVLyanqBZsj2btxCQCsdL7IVJvAE45pAWLRPbDZrR4g/y7swQhI6gynZjIlFOZQRiIg9EI1X3ar6tAUwcHWfN5d8HU/oLnOu8MlwQRcTs59FolkHvHWrM27pQ7wo5JMV1cw+hMVlPrkfK7PQNIc9mINKZ3VanV/i/fiT43Q0NeXTGVXhMaCVAkX7bTgGp1Ob0G3ognmAqCiY1bRb1wDq0K6jM+8FE3N++wxQ/fa1mGErxFU5YNa32mHVvzV0LQlZG0Ard/+vku5HuL/JTaCETiu9ZIL4vt1dtD/g5VxJjapN1DhHAZcvif5wpmY1VmaJU5NIjcC5vm1u6F5VWOyPoqa/Uvof3GG3LCqy+fraA0flNJk0rnCOy1qajMBAiHL3Iy8LWi3223YDEprHeObrNiLP3yDbVXKTzVaCtH8f/WmxVkFmb+j1J94/LqTMZ1Iu7P93bZBsgpqZj0Bispr3D50vvvxBQhWtnYbo08tJ+xdBXSt/yXhD8CtDya07TtIGK14Ar6yHQDJMDgo/ptREsma44BHMQe3OYgoXebeVH2h5mdpMJjzXQVXfsIJim3/YpWh6MBjgmNWpeTBI/pA/EcUchBa8Mncg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(921020)(38070700021)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021135927099003)(10067099003)(261022105027099003)(18002099003)(22082099003)(261028144727099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v4bG4gS79jhPZWi/WtUSoA6KlPeyfGI+HKfz4/H3UnT2SYkAB2BN0O3AD7FO?=
 =?us-ascii?Q?EhI9HQTyRR3A7LBEEyqjxT3aUocTlkHHCj9WbSMkoKViHi8Q8yyfuSuodoUS?=
 =?us-ascii?Q?7CjqcYgMklq1jsFcXblYbyFzJ+GPlGU8kttFlrxNYvRF9DVbFFHHZWQJndyH?=
 =?us-ascii?Q?XIuL8zzwRPk2IZyGaXduD0V4YZnntl0SmaTng8UVc9/Pr1zmRm1Yh5IgqTyP?=
 =?us-ascii?Q?YQx+VeXyVWaGJsf5w09O6k8rmENEF2neKKM2vQYpAC9QngMHhXlMcTVSFSE/?=
 =?us-ascii?Q?bL31tKJvHpT+Ig+7Tn3kc8d2RVEUQHRDjRscWoAkfpHwK1ca10qn+fN7Wt0g?=
 =?us-ascii?Q?lFpShFtoenm3EboXVMtMDbGnMZghTCes2mYhO2mC+WV+Fx5CvE3nhQGcvHQd?=
 =?us-ascii?Q?l0UWfx+38ZEeKdSluRtzHrwfFltyeQiRsOEArVpCOAxQygUR7O2rKqyPEKrt?=
 =?us-ascii?Q?ss3pBs784Y+827d0PqiG8m87XOpQGVZKncWxA8Z/L5jd95+D8bxUztb48YKW?=
 =?us-ascii?Q?Xifsnhv4SN0qYucgnOE84lNOEJ69HZxeHJWl+HQqu9izU/6spg+KMDOwZMGG?=
 =?us-ascii?Q?KQcTqGKgEHomMHO3uSvxh7PSz5Yvaw7EqLaSLCnq7gG9NQOi5i7uDxX9Pe1v?=
 =?us-ascii?Q?T5Tga5XRc1Jx0pBbImvSIp2sd876OAJOIWyaxtlNwUUGi361RxIqWRpvggE4?=
 =?us-ascii?Q?siKYk23+DgkeD6zRYWURlsrSGkaXCZxgo+s0y8jI4wEi2kyIQnoIylytx3n9?=
 =?us-ascii?Q?C58K1gdROeerSRp7+qYnKsYBbfMfWeBduSADoy5DnxY35b4ivuL6s9hwYkHL?=
 =?us-ascii?Q?pc8vREBlQEftnX+otu00WgqE9o+ozqgNt7HJJqTm+Vg/Hfzi+DXlAzXa+VfT?=
 =?us-ascii?Q?N+ckxHN/00oI8Eefz6pgS4EMv3hA61yNL+FlYLt7O2I2dqdyQtLfLinedoFO?=
 =?us-ascii?Q?LjmQ4JXHFE8t2UYJBUJNtkLighNjedFOQRmmJ6DsOJBd+lRn8TjULpEVgdbm?=
 =?us-ascii?Q?nkwa7Q3qSv8o+pXX7OITN36/7xziYR7u99vc3KHzoypUuIhgimKDTEaWEPH1?=
 =?us-ascii?Q?vspaQ/Bfdx7AAu6hhnMCCbEs0+ATpoHv5OlgF7H1VW7q/PXMrJADOCKWJCaT?=
 =?us-ascii?Q?QxWnkf/sIIjfYdk8TeAcLtZeeYqxINqLEFQe5ntINMRDA4s6EsqzhY6s1Jnh?=
 =?us-ascii?Q?XgC/9J1P7J8Qrd5ee1PXHGigEzCF5zEGgpPumil9/7nNI59IffJfPUBDUkwC?=
 =?us-ascii?Q?Lc1i4ksFqgxw5FwXNI0bBkGacotwkqGmhSJisqGZY/YvVNE1rsf92/a5OPiy?=
 =?us-ascii?Q?1C5Nhgd87uPOaVLgSTLwSFzV9zecY9hjzX4zzk7DkuA9EAq8+lR4RcJSeY+M?=
 =?us-ascii?Q?LdRqh2gz8qik9SHJhWIOwtPdqa6pN0XdeqqKyXIB7u/gbXZy4KsstZ9wd+F0?=
 =?us-ascii?Q?rWKbCLmLggNeTpdSsbY90cQYuXB63gT6FleO6ha2JfAmXW2IjpZSz20NQQ51?=
 =?us-ascii?Q?aw3UqR4ox1iTt7I8ipYQkw3ot5jYxxTmfCyhrQQ378voWJWD7byQqxfXpMXW?=
 =?us-ascii?Q?VLgFW7VS/uJldpm4Lx5wvOoEiWIx8Pg9DSrDSaBY+aWKVf2LcXGyXYhwfo1g?=
 =?us-ascii?Q?YLxQXcnGQHX0d7R5MDbU0FV1hYPcaTZiLLQxlBMiaRdtPUKk9anSE1vqkcsD?=
 =?us-ascii?Q?rjz4egz5tUflsCsx9ddFMsUrtgUZ0DuWSFPAOhRHFljnNG2iXkci33SC2sX8?=
 =?us-ascii?Q?mjChOV9WFA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 995f8c23-38f1-49e2-552a-08df3509e591
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 15:41:13.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5H+1vouI/furMd+mxiCUjqSelr0slzen+Fbs45W1u7e037MZB4OEQPdH+Dma5eg4W9TYZgs2SpKROFEpDhHisg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9545



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
> Subject: [PATCH v1 8/8] iommu/arm-smmu-v3: Probe a guest-level Realm
> VSMMU via RSI commands
>=20
> In CCA, the ACPI/etc doesn't tell the OS whether the SMMU is a confidenti=
al
> T=3D1 instance or a normal T=3D0 one. Instead, it has to be learned by is=
suing
> a trusted RSI. Before the kernel can operate the trusted T=3D1 IOMMU, it =
also
> has to validate all the information that it gets from ACPI against the tr=
ue
> information that it gets from the RSI call, to ensure the ACPI is correct
> and prevent substitution attacks.
>=20
> Use RSI_VSMMU_GET_INFO during probe and require the returned register
> range
> to match firmware. Then use RSI_ARCH_DEV_ACTIVATE before mapping
> registers.
>=20
> Currently the driver doesn't support a T=3D0 SMMU inside a realm. For exa=
mple
> it doesn't make the page table allocations into shared memory. If we are =
in
> a realm reject any SMMU that is not T=3D1.
>=20
> Once the SMMU is activated, its DMA will follow the
> DEV_FLAG_DMA_CC_PRIVATE
> rules. It must set that flag to ensure its coherent allocations for its o=
wn
> structures are allocated from private memory, not the SWIOTLB shared pool=
.
>=20
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 55
> +++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 5732f3ba0122d..972815c54b11f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -11,9 +11,11 @@
>=20
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
> +#include <linux/arm-rsi-cmds.h>
>  #include <linux/bitops.h>
>  #include <linux/crash_dump.h>
>  #include <linux/delay.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io-pgtable.h>
> @@ -5507,6 +5509,53 @@ static struct arm_smmu_device
> *arm_smmu_impl_probe(struct arm_smmu_device *smmu)
>  	return ERR_PTR(ret);
>  }
>=20
> +static void arm_smmu_clear_realm_private(void *dev)
> +{
> +	dma_set_cc_private(dev, false);
> +}
> +
> +static int arm_smmu_probe_realm_vsmmu(struct arm_smmu_device
> *smmu,
> +				      const struct resource *res)
> +{
> +	struct device *dev =3D smmu->dev;
> +	unsigned long rsi_ret;
> +	phys_addr_t top;
> +
> +	/*
> +	 * Currently the driver does not support a T=3D0 SMMU inside a realm.
> For
> +	 * instance it does not make the page table allocations into shared
> +	 * memory. If we are in a realm reject any SMMU that is not T=3D1.
> +	 */
> +	rsi_ret =3D rsi_vsmmu_get_info(res->start, &top);
> +	if (rsi_ret !=3D RSI_SUCCESS) {
> +		dev_err(dev, "RSI_VSMMU_GET_INFO failed for %pr: %lu\n",
> res,
> +			rsi_ret);
> +		return -ENODEV;
> +	}
> +
> +	if (top !=3D res->end + 1) {
> +		dev_err(dev, "VSMMU range %pr ends at %pa\n", res, &top);
> +		return -EINVAL;
> +	}
> +
> +	rsi_ret =3D rsi_arch_dev_activate(res->start, RSI_ARCH_DEV_SMMUV3);
> +	if (rsi_ret !=3D RSI_SUCCESS) {
> +		dev_err(dev, "RSI_ARCH_DEV_ACTIVATE failed for %pr:
> %lu\n", res,
> +			rsi_ret);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Once activated, the SMMU DMA follows
> DEV_FLAG_DMA_CC_PRIVATE so its
> +	 * queues and tables are allocated from private memory, not the
> SWIOTLB
> +	 * shared pool. It only translates for a device we've requested the
> RMM
> +	 * to put into T=3D1.
> +	 */
> +	iommu_device_set_confidential(&smmu->iommu, dev);
> +
> +	return devm_add_action_or_reset(dev,
> arm_smmu_clear_realm_private, dev);
> +}
> +
>  static int arm_smmu_device_probe(struct platform_device *pdev)
>  {
>  	int irq, ret;
> @@ -5542,6 +5591,12 @@ static int arm_smmu_device_probe(struct
> platform_device *pdev)
>  	}
>  	ioaddr =3D res->start;
>=20
> +	if (is_realm_world()) {
> +		ret =3D arm_smmu_probe_realm_vsmmu(smmu, res);
> +		if (ret)
> +			return ret;
> +	}

If probe fails after activation succeeds above, wouldn't a module
reload hit RSI_ERROR_DEVICE since the VSMMU is still ACTIVE?

B5.4.1.2:

 pre:  vsmmu.state =3D=3D VSMMU_ACTIVE
 post: result =3D=3D RSI_ERROR_DEVICE

How is recovery handled?

Thanks,
Shameer
