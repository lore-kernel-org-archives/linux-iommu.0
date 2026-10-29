Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793260747;
	b=V/z/H1PyM3TNkNZ2NlPe0DYHqTSneamo+wngFpo8uBooMyaugrksuy2l0JFPNS/HnQh+
	 dafen3F1c2I7jfj+7GAHbKvoaGMLDTyDg19MQVYjPBfxiMEE+fRqNhxCUmLneJEA363AY
	 NsnzvrXI+lxVHwpbde2igqkmdQqFfcTj+lU+XPGow4fnjEMhRRFVOhPkZxGxfeBFXInTM
	 WFjIa6QxyuMj7t/h+l7y1jAHw9VY/p3TABtw/CJwspF8JMiahTrvWwx0WhTNsA2TifVKW
	 I19Xf5wk1m82PYv4KCIDXwW5TjcSYT6X3FkCTDaSwusAzbZsIjdzFl3v5jj1m9CZkog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793260747;
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
	bh=h4SPeF3XTiM31B1zYroX9U/rQmkVAUVORfo85C3IF98=;
	b=oF2otNAAk9IyefZvphaKdtJ9RPWUmGufSpk9IzHvDKNpjF2zIgwzLtHh2Vw6ic+xdvSk
	 KvkJAZkgrRwMlYP+T6I3366ZpHparRxR6lWdCnJshZI1/nIehSCSOkjGmY5JVcH6E5xaU
	 CTG5jxvsiuZx60+6BJ1R0MKdbfksRN/H2aml33tsj2q/kSRZ5CEHHvmIU1bv7g+qDNRWt
	 Acn4wq8ZFD/oCfEULzZF6EVdgxPfsklpYmuN6soNUsa5anhOeTsKVoNCMKzzHxzjaZ3Xc
	 cMViMi7wEVoTHWKFkhAAa2iVahN9g+BFhE9hhui8NY/Tp1xE6HEG0EUh2zXV4/JYCww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hv8BcknV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.0
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013000.outbound.protection.outlook.com [40.107.201.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4A606A31D;
	Thu, 29 Oct 2026 07:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA4A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hv8BcknV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQ8JeLJ3wAIFH+z7htOsdczlBIZbVEtBlbD3Odcle028FU5ricscjO02iTglvvPnR64sNbhA3m8oEIYJMKEKr3Efl7WoNu6q2yd0gkTu5VQXbxXViaJRD5A/WEX83cL8DnpqnFN2nXWlCLwWv774oU6EjcTJHD3e/MVHFLedDnXqn6odgPJ996p28ubLC87L4ZORgooediANuhQ8ug+fK30/eAkKnpDw3dKtcLpek0bnFjyvp9zWyJT5Qv7hlqWB1NtawvJDnH0NpuzO+nVvGeUMQ0OWe+QPzXnk+rtT9IyrC9cygTUiSvPT1VvMfOfyS1qh/R/VRmsF3bwOJoQo/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4SPeF3XTiM31B1zYroX9U/rQmkVAUVORfo85C3IF98=;
 b=FmN4k9C9x94yBwOFwvIzVsmo8cxIGp9wXDof45Aiu631Zz3CNdnyIY/DZfx+oRSBW6avlytFd5PfFIV+9VAWSODqMhA7DKjW0eWdA7J5yxVMVPJpRorrg9TCucauVcewDmlMFZZcfmVLufXIfoFBKG6YDYYzrFvPoaSltK7AdITo6zOMzZnqY7ZqGKF+BsIL64GX95Lcc9MTtkVn7YCbfiqaRLnYRg5nYRhFMIuwTtuFNvL9XzO3sa8gnhvo76SWoaoKawUuEiGg3XPAI4jlutXCF+T1GSpHOvFCkFPyWxqPl6mnq9lR9LYbqJlGabJfACCbyKnBlzc1YFikxjIhaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4SPeF3XTiM31B1zYroX9U/rQmkVAUVORfo85C3IF98=;
 b=hv8BcknV20sWdNImNZoXj4ple1UtPx8zzBwKVV8xOw8tifvoQa7cdLO+Jc3yIZBKvcFP+W4YHSmGpfkoQemMwIOFDZTW08C1soR7KrVXqKJlzaFLKB/5xAUWk5VRWU6SBFaqavDSsEgnM+x0SCADCLEnNUc4+xLtgkxpvJfDft7NpTZBc9IH+7frxFSojxVB6ejVVboFLquwwImvgM72kwktaph1t9/eYT0UVVnAyAAGnE32z1Ke73fvJaol5WcwI0f0q+GB9uV55o/Su3VYqUUpO3/2gVjFJyvHE8hd1ai37rXK8/KV8fzEpd56TDUsJuCpfA100UNn5sze/2Hwfg==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.20; Thu, 29 Oct 2026 07:58:56 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 07:58:56 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "joro@8bytes.org"
	<joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, "rafael@kernel.org"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Gavin Shan <gshan@redhat.com>, Vikram Sethi
	<vsethi@nvidia.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
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
Thread-Index: AQHdQNVOuiO7B+HXKkGq3lGx7D+HHLcTYs/QgAAqUQCAAOQrkA==
Date: Thu, 29 Oct 2026 07:58:56 +0000
Message-ID:
 <SJ0PR12MB8614BAF8E35987533269CAD9AB6E2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <df25452641dc126eb334a1bfbe5eee16cc8a8953.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB861403B542B8D63B2AACE18EAB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <auI6OGDh723S+6Dh@nvidia.com>
In-Reply-To: <auI6OGDh723S+6Dh@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|DM4PR12MB6232:EE_
x-ms-office365-filtering-correlation-id: b43e837b-e7f0-485f-b26c-08df35927b61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|22082099003|18002099003|261028144727099003|261026140227099003|3023799007|10067099003|38070700021|11063799006|261022075727099003|56012099006|261026121527099003|261022105027099003|261021135927099003|261021121427099003|261009223027099003|4143699003;
x-microsoft-antispam-message-info:
 25qy3dXPqc/GrolmKIUa0MDLk/hoTH/3WbNW8ITVSrnRusNSlOqntjdRA1miI1oBfaLJIDT9eG7u74l0DiUdbXbyjQb2qAJvmID1I44WQU62rWmpCR2ZnoWcXBgCD5USVyItH4y6Q06Np+WzTX+6HQM+jxsRrLrprPvULu909DXh+ZIoaZ0iznBpEYGrjuPup0BYnppFqclHdJ5b+kt7y7Vy54jdURg5e7HwSTi0XSTvVbTqg3M3ZoJF5in0Fjr/z0GJxfLmXo/0yuoPF+EUbPbXjdcmU00fBeKVJFIyNya8/HAD1nLeZo63aS3wjNDe5Um8on4LNh23viIURsM9iH0/4gFp4N0cDPYv/OY7o4Yzb+WO1jQ+BUj324BNthV1o+X7C4sWqaHPeNPBwHCTAeFR4rAhItLeI63xa/4YQBOWHd7P0iim1CiCWiOkhQUBgC6qBCwgPpx79EkcfhLIsxYZZ8R/nuKj3agqN/allRjXvGPILY5xDy7uMdOmpzd9tam/hzQhs8IxzTBRw2iLyFb1e1xIB0tFUmtMFHUHg0V7zmbrP6/mEAgXQKXD0PnbxFf1Z8kHx8hPWONnJVxwlrE3331DlWLpt77suZZNNIdI+h2qTdfXmCD4pQaecOEt/T7IvfSS7IKlhvuF1iBFZN/TE8XfucJFvAuYxjAsQfPaAScCKpzTmeFRGbxGF0SoTultssxTFZFqBmwXxO74ix1Sbz1gHA4sTy9+ENMUgqs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(22082099003)(18002099003)(261028144727099003)(261026140227099003)(3023799007)(10067099003)(38070700021)(11063799006)(261022075727099003)(56012099006)(261026121527099003)(261022105027099003)(261021135927099003)(261021121427099003)(261009223027099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4FnAMSpNII5rpZ+cRzti5RqAhYqSqjNjzL7OniXJ68AvhSlWvRAzg/wpQwGh?=
 =?us-ascii?Q?J66CtJ8Aj361F5TA9U6EJJidlxHz8haypAut0Ghrj7BAJ0RjgX2CxVqPvitD?=
 =?us-ascii?Q?yUDJHhPXNpa3cDHNfbxKvNrdML15Znmk3UdWrUh39Qttp+Ed+bKNOTGC/NYn?=
 =?us-ascii?Q?Cr45w/8MDX6AFWM2wttKBygzrvOMQZWKoYieBHOqzoyleQeWtNcRq/6E0QDv?=
 =?us-ascii?Q?N86Wc/A+oUwVBt3v4JnTUjpXxaxIT/2bD812Y+Hkzet+JIrqTXY6DZR//mHl?=
 =?us-ascii?Q?X6fRpV4gSmGnqIq4dYRVetlxQlcrXCFGrvXNsujsrIUmkCl/uwfOn2WvOAKh?=
 =?us-ascii?Q?3vGAJ86N3yf4tqcPNi+i80Vio+WSGKS+8UF9QXhFEdkFGFJJaEzUJ31CjrCY?=
 =?us-ascii?Q?6rTnVKeFWBeuMtHdygP6UxP6ID/rHs/AH+Bb5CjaxC9qW5CwUyxl1gOiLRUT?=
 =?us-ascii?Q?WWRRcyzfBrr6g2mj2y/KMiZSzzwqRfAm/9ZDZWhepQOLaATHp3lSqFwiKZex?=
 =?us-ascii?Q?Sc2F1WQk3IYVOdt8aWuRJ22GYHv0ZTi5Swe3D/IXD07MxwDDLA5eOImFlrZs?=
 =?us-ascii?Q?kqh4yUYbXxzyx5x5xf1F+Rhgv29kXzWKRjIVKGFc2vq7hAFLYVGi6gNCvz7j?=
 =?us-ascii?Q?QaOj/QJcorD9yWPUFKCl8WScMKmAh7glhWHw3QqNoJ+LkqaaLgssq8mKhkn0?=
 =?us-ascii?Q?29PGaODTsbWmipJbSE1mEHu2BLL1oeoIXOAc4J7rp57zF80H1qFFMoiyJHOW?=
 =?us-ascii?Q?1cfa6b7ML3ZwzrqGrVT6MVIWwBTGymDTaShNf6m3boqat5w+7yCerQHzu4Re?=
 =?us-ascii?Q?8nxgfDNlzfLxskoGTSHO/bCgeghvYSLMjCRqb4b4eOWb5Ney1gBm4ajPajAm?=
 =?us-ascii?Q?HzqP8NBGXMcBGubrTTgoVk6DhCZT8V/uM1a//J8o8BoLoCDurmcKLfrjvv0g?=
 =?us-ascii?Q?c3WLOv02im7l+ChhJpAT5bNs6yVbzlZlGIqfV1tW5Bdlpco7V6gdCg+qiZHy?=
 =?us-ascii?Q?qjWezbgF7Co+tIwWj2MgBHRWGgoBXyAYDHUd9hCbw2J0L6eVs6itLUW+YkIf?=
 =?us-ascii?Q?rAHTbdiZPDdqL2AGnoeQA2SNiAaTqrzvVDnQ+zv7TwCMF7C0kRmA/nALIhRf?=
 =?us-ascii?Q?cwRvdNH5T7ulTo5594+cALq+ILWqbvUOjT40gxHL46o7FuDAKjZzIPbjkbLx?=
 =?us-ascii?Q?DAqO9TbCAVvO7N1Ulpot8NLCpUEkguN2ncDJh9JHQE4L24zVyxBVM48UDMUZ?=
 =?us-ascii?Q?kkG9xe0NMoJPd75Ulh//V45IwE5puaL11unFz1QjyhNw5AFBBFLSM3BllGt+?=
 =?us-ascii?Q?Fk95gSmKWBroaZEuOYSBEo90s1mUP3RLI60F4L6hOKfVy0pR+B+A8Uv9E0g2?=
 =?us-ascii?Q?gOUFIOvA3BGyUpDNVVl1oZ2XUBCFBF0JMIDAvq7jMhFoBgpDXc3Th32XAGis?=
 =?us-ascii?Q?F8Un60J1heLFmahvZlvP27CrHkXxVeyHwf1JAcONJ8yFh/UL8qYD1KzfGbq+?=
 =?us-ascii?Q?htMoQNrbr6DZKqLVAahIUQVvfSWK7H8fVslzYC1WuDhiZuv9Jm/kEquw3aP3?=
 =?us-ascii?Q?lmn7+bPaDzfhwfoJ2MJCiOfK7WOc1Ct9G6OEQJPBC1ecLtXSOSBCa9rw9wcx?=
 =?us-ascii?Q?34vcarBOkBXA5hepVls3N2K0V9J5qSDxPP8maqK7Wg62Rk4jXYerxu4iVEBN?=
 =?us-ascii?Q?DIYer75y6e/xf0kCZD0yDAp2MRgwd4RBgCz2dzZYyiB0Igy1Hi2wM+nN3NsU?=
 =?us-ascii?Q?umLO1avYPA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b43e837b-e7f0-485f-b26c-08df35927b61
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 07:58:56.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nhu8uiTdv+8JH26pGSHGFIBq1jn3AhSCus6NEirc2LoHPp1wRsDzEmgHNWE6RGQDPhaANCdvCu5xCByWXOxjlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 28 October 2026 18:09
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>; Catalin Marinas
> <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> joro@8bytes.org; Robin Murphy <robin.murphy@arm.com>;
> rafael@kernel.org; Danilo Krummrich <dakr@kernel.org>; Marek Szyprowski
> <m.szyprowski@samsung.com>; aneesh.kumar@kernel.org; Mark Rutland
> <mark.rutland@arm.com>; Greg Kroah-Hartman
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
> Mhetre <amhetre@nvidia.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; iommu@lists.linux.dev; driver-core@lists.linux.de=
v;
> Sonang Patel <sonangp@nvidia.com>; Ankit Agrawal <ankita@nvidia.com>
> Subject: Re: [PATCH v1 8/8] iommu/arm-smmu-v3: Probe a guest-level Realm
> VSMMU via RSI commands
>=20
> On Wed, Oct 28, 2026 at 08:41:13AM -0700, Shameer Kolothum Thodi
> wrote:
> > > @@ -5542,6 +5591,12 @@ static int arm_smmu_device_probe(struct
> > > platform_device *pdev)
> > >  	}
> > >  	ioaddr =3D res->start;
> > >
> > > +	if (is_realm_world()) {
> > > +		ret =3D arm_smmu_probe_realm_vsmmu(smmu, res);
> > > +		if (ret)
> > > +			return ret;
> > > +	}
> >
> > If probe fails after activation succeeds above, wouldn't a module
> > reload hit RSI_ERROR_DEVICE since the VSMMU is still ACTIVE?
> >
> > B5.4.1.2:
> >
> >  pre:  vsmmu.state =3D=3D VSMMU_ACTIVE
> >  post: result =3D=3D RSI_ERROR_DEVICE
> >
> > How is recovery handled?
>=20
> There is no way to undo an activation. But what's the practical
> use case for the SMMU driver to do a module reload?

I was thinking of an allocation failure, then onlining more memory
and retrying probe. Not sure how realistic that is in practice.

Any idea why guest side deactivation isn't allowed? I couldn't find
the rationale in the spec. Perhaps it needs additional synchronization.

Thanks,
Shameer
