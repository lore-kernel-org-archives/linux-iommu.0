Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793268311;
	b=U4ogKBnVvimoFcF/c1n2qzO885liBWK9hMx0cUXSMP08Ejl13I588zn2J3cqM9x2gU6I
	 5FSFhea8hfLIYJ15wvF+eUKkExIsf0grKhxiRBz1SoO+a6G76QK11WmiKK8FewbgmGfVJ
	 sUCieVM3MWYMK977ZTpjunNwaqxMEBeKsxD5sUyjR1mGxSUcLFWVG6ZDJBWLNYcVMsf4R
	 gqflZBrAyV7u5rQu9Xze5s4Qwi5wFloLquWnB2zB6QYk3LZ4zWP1Owag9GE5IVhGcywqG
	 jDpoKxyjsOyxOWDys+TIUOIxV3pqZIj9tfzbwhS12GvZtemt7/gJ6lwB+ZvF/JSGNog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268311;
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
	bh=w3X7l2x0wE8sUhK97eSrVISFacNHJWzooslkvugKGt4=;
	b=ognWM+b2hslIOXZKxRVnRBnVt2mGZl0NSADwGsf01aqE+xiYDPbYqXpjZLD9oasvCSNc
	 LB2rbrWIR6gRwv5UwlxBSRVyJUx9VVog5Me1UREN/2T0XkP0uFrUivXDslT+DcjcTKtRx
	 jv6+67MAVhG4RpVjWtbCeGHJHY1cD5LtG2vn8uPmX6kmB63szsKJRKelLpTgNWqvwSmk7
	 oDXM9hXmu7ht91tsSzIs0wpiQx8FyJejuP2nvuPPmVmhqX8sIF3KybXEk3CLEl6aFY//I
	 OQc6nLf3T4AEkEnpA+CpDX1DVPvA7YnsYNuYc+NTK3vYkl7yTZZ9JNBWgCkKYEnSLHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="g/sXfpDV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.28
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA522606A331;
	Thu, 29 Oct 2026 10:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA522606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=g/sXfpDV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rx7q8oytfNuOujyrgUprIqqsqSXUmUdSqGcVJRyoMQNAAeiquLrF4kFQkJyFFTERaANAYW+sKWxPVOXBOafLAiczcH/wtSGKBoQgRzcXIibs2bmPS7UdEOx9Wdt/B134PmnZnIjY/EH3CN3Iv1uxmqlfCx9Lv3CLVmO2Va77LW689MMtg36Jdfe8VRj54VpXXb0/TR60TegRhn/eUHDqofLgtgG11zyAGxuTXNj7Zk7yGOsFEQbW6kcqgEkqUenmVHtL/gRLkWTT0Vn5QibAQLL/318lMGjm/1ZbI3uLkeNSiXV1S8gVhyW8daOEZmSjSexD4iTKY4djBcKEmWuykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3X7l2x0wE8sUhK97eSrVISFacNHJWzooslkvugKGt4=;
 b=BOjrWG+DWIBUIiFHR5BDtbH3us6LTCKK5hcZkFAMAHcrpZHQ+13vMkaUTA2C5vOjf5iFcP9OJB+3dAOwdVVDeb5RB5CjXbruRjYhHGxYtuW0LuGw8APigeyRL5M0Kmp44+CxfqEkuA+Qx8zoPat0MVb/9veAzEHfXhtJPwNGPC4ZAq6vCl4dvDYk2lWHexzliNllpG59EDWI8M0Oz4Ew+ijrm4nQ/kIG5Yn0PqKiiuM96o7Eywv3R8n9nx/IkW33QwgPIbnVW0Yvw3s1Ff5JX/pG6l1hOxC/0sRPK8N771UmUwrUHeW/Kp+UqsDDJt9D8ftxttP289fatvZoYo/LvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3X7l2x0wE8sUhK97eSrVISFacNHJWzooslkvugKGt4=;
 b=g/sXfpDVCFf7AmfFuu8hPSga2CXDFs+qiQ6eaym9SVzlpa32FI0L7biCAno436Xa0jvZglxATIpLLNhOIRTbK7QZjMxqFsSybaUftwO0jLtcS/jN8bMLGqeIlNc58sEbmh+18EOweweSlq09oNgUHBFB0wG8lUJL1uAPk6hbJa0M7K9fATY0TC3vYzgVJSOOcEzSKINmgbKWRAKX4+aRxxjhPWRNhxFbHO89oXuU8gak4aYs+kUwut7Wxx2kDyrf81LHiliIELi02fTVUc7VWybEPUmLowdAH/ANl54/BO1Na/Ro9Q55o44C9M4n7B9QlwwGV+ZrxPdExEINVMWxpA==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by SA1PR12MB6774.namprd12.prod.outlook.com (2603:10b6:806:259::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 10:05:05 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 10:05:05 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	"rafael@kernel.org" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, "aneesh.kumar@kernel.org"
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
Subject: RE: [PATCH v1 2/8] firmware: arm_rmm: Add VSMMU commands and fields
Thread-Topic: [PATCH v1 2/8] firmware: arm_rmm: Add VSMMU commands and fields
Thread-Index: AQHdQNVBJHsoy5DyiEqk6ybDR0p9tLcTADyQgAAvooCAAGVzgIABAqMA
Date: Thu, 29 Oct 2026 10:05:05 +0000
Message-ID:
 <SJ0PR12MB8614E6DE095441E52698D7F9AB6E2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
 <0623345baaf550da1339e040b59f1fda902e3390.1789010941.git.nicolinc@nvidia.com>
 <SJ0PR12MB861491CC7A4C567D01F9B951AB6F2@SJ0PR12MB8614.namprd12.prod.outlook.com>
 <20261028123509.GA2541714@nvidia.com> <auJBF+hDkx+uKixe@nvidia.com>
In-Reply-To: <auJBF+hDkx+uKixe@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|SA1PR12MB6774:EE_
x-ms-office365-filtering-correlation-id: 1fa0b0e8-ed62-40bc-2a71-08df35a41ad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|38070700021|11063799006|5023799004|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261022075727099003|261022113327099003|261021135927099003|10067099003|22082099003|18002099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 3NUSHqbU/6uEb+EBhoLbAo4/Y8go/BDEhkCF7/YQZSTxqDuCGzM5HopZn+aa5J7ilaQhCvNxEDG4vz/oXmz+9sCG3czAzV+OOUAZ+W8jnHeg/W5nngJzbMD8y6+aI+I/XpreK02cwj4hsYnDOfg5R6mbCGrf/eZ3m1nMwO6JGABzD1waKPFulEs7xyK/ilahYhWIXIZ1ElygPoHJk6MnN7JLz1k6cHZ0chM1We1okOo9fI7OdU4uHFl8IsavgceZN5nNHHUMI0CwR/yVK+RdwwIyOQdHwQJko4lYv6SZDLstIF2MNi2mLf3EazZuAfIiZOFdEltRMF2aQf8FPaarqXS66LfFPLG6pd62LBfHFt92s/Rkv2JFZnPiB8LF5ONUOJDgW+KW4lsUV+9p3tAC9POR2bbbkGiCcws2Mf4GvuDdFIbh4xGKPE5ln27No0H2FvnFn/ztzM7DNQieJhK8+aeq3VLh3Sog1A4FM405K9VYRXQkqa7+Asr6iFuFZ4sTTqB4AP5IjMVbGcYteNMKXE1sK1WpvsD+zIs3g563Kdj+qwznLsTgWHj5MWIpmU4xUWxcRzR63DQNfQbbqwjelzTucUzjCp+E6vQOzGd0rvLREXash83a/lwXcik0+tM6AH1OwzFKOcx6FTQ1bo9NOquFX6JEdqkpuWJB2JLgG30/dnUgV4DlyZ2V5xQvsyEjZ05LM8gN6jUpjw26OGJzFQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB8614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(38070700021)(11063799006)(5023799004)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261022075727099003)(261022113327099003)(261021135927099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QvxSrsYbqLtBv764i/7ktSnWnlh27LdPeKzLP9q3tYZUpX7WHYSkhIBV5CAA?=
 =?us-ascii?Q?QP2livMVLWcF8gYl2VmP2kHOttZFyzkX8jArvK/EMbABPNlr+3sVvf9Q/gPr?=
 =?us-ascii?Q?673eyyW43jea3lUEyEeo0N4Y7d3+P0aHg1ioKvJk+MCpdZyYyPC9yXUMVjL5?=
 =?us-ascii?Q?g1PLvUKBCT9uFnNKZO2KgT0dxP87fhzx6GSpMfTPn8a4YCBjZSbuAg0UKKKk?=
 =?us-ascii?Q?ECL0DU23o/xIZ01GwmTPIusy7td24Z0dTdBUO81xAR5uyqhuFoxbF1nRURV4?=
 =?us-ascii?Q?QCEGSNBCC/end93O9NaCCyD1jrtXUDTlKRkOnBwURlNoCIKFtqO4l36sdnKd?=
 =?us-ascii?Q?tqxPvNTxPL/X5zD8dKuaQpmPsDjh6tb1MrJZkVt8uW0NpTB1mN4AH59JQRJx?=
 =?us-ascii?Q?tLsB0IsyfNbQmLaKA/yifqehYB32z3sW8Z3vuZ7X3TDvv/O5sODvY439QC17?=
 =?us-ascii?Q?xRnja0/Cib9YJHyptpqNoEkOWwlDCNUpHndMijZUfEaGJuTlHfCiH/hUqdUY?=
 =?us-ascii?Q?BLwpmjjJNSWt3jbuJZWoEKX9z27mDeH2Rw2wWhi/eJjdyToTenOEEgyf1nsP?=
 =?us-ascii?Q?KbD9Qy/3PFnSBdi71hiuleumQWKR4Rl8CmO2xX67m4MzYWCUfNi/Owd6K3GL?=
 =?us-ascii?Q?aE1FxFjxuONecmBgGLdp3JVQi3QQmMOKd4eZYlF1pj5s71ZuMWdN+Sa5SSiS?=
 =?us-ascii?Q?pEMzzWtTGJ9kTxrXP5xMsVKpeNcxdohewJ407dHVmU19B5EoGVBOzA+VHJo5?=
 =?us-ascii?Q?HCo87EsGLuSS3x2/4yVD5zdAMe3VuCkaVa0W8gWE3/NUj2Q1b/3MpbAidE24?=
 =?us-ascii?Q?Q9ebagH4hDpziszg35mdnuQLw9Up4IBP7rhI04160cIBLIfRSScew5ni/DFu?=
 =?us-ascii?Q?oTvGUVa24/o+RFF1xmqh9R69LYxAeX2s6cHmtwozqY87ei/XuLHJR1Z8F+21?=
 =?us-ascii?Q?gp6CybtlLWEHHzp4zDiWnLn/x/AUlRTcbqS/5o1s05+/4WfRTS97rKCLHC6j?=
 =?us-ascii?Q?6qJSIqxpr/cdmVZeT89UcNJkmAOt8YQqxtVDUTNpxHG3UQUpKKAr1ZqDDqM7?=
 =?us-ascii?Q?dwOpDDiqhOKz5c/FAhPhQ/uT1WJE5Nq7HEGRyIYGX5HRnNbDNuNtiEKBOQmo?=
 =?us-ascii?Q?VRYwV+Ti4KhvmjYQKg+eVnx0Xn0HIOQyjAOnFMA+8ilzLLK5IZnASJJqgqsi?=
 =?us-ascii?Q?oC6UWk0y8TMfkgsoV1VyHj3jznq9rdtNauKVRjmsWSFm4z5jKesHmUGEcOhH?=
 =?us-ascii?Q?l+UNVRwqPtQc6GNr9fj+8GM0DobB+f3+1QBm8EOxfqLqV+1WTe6osyJr7e9w?=
 =?us-ascii?Q?wG88BBNcmXLySMTYebDY6awZvkPLDe9hG8AJkRQsazE1bZOGXPcevz/XHkqg?=
 =?us-ascii?Q?YO5uQaGj+dJNjs25XHbz1LWM0inPrpieMwTuD09E/Po7/TPhU2tconMkXxkl?=
 =?us-ascii?Q?dVCGSnFcGNA3dLrTZ9ScT/HCCI9KyR725DZQzceo1oFm6cio7+fQb+b/rJK0?=
 =?us-ascii?Q?YYq+YP0yFmzanQtfsn8LD0EthfAI4utKREiYf408hEZg2eSsvdmvK0Ax/WZB?=
 =?us-ascii?Q?LIPCPkCJhTJ+xnSCNiceH2wltFA6BLTrpZ6an88jf4R48g2R9x8xR3RlvYcP?=
 =?us-ascii?Q?/3Bwp51eXFQS5Iwbt4aQ7K1c+WoB2tqDdXaI15x04vryqSlyHE0XXxuGKjAQ?=
 =?us-ascii?Q?AXMm5p1cFR3L4EkxPKvKaS0vcdRYtaj4pnUCMKmB6Lg+Z2937jutpITF66vL?=
 =?us-ascii?Q?5lTMediLSg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa0b0e8-ed62-40bc-2a71-08df35a41ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 10:05:05.0555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9MSnh0MCJBqnkC4+tki6ht3sapeaDv+ob+zHeNGW/TCPWEIHEEsp9RM4RrY/guhvuZU3tSTbFHocC0Vm799l2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6774



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 28 October 2026 18:38
> To: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; Catalin Marinas
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
> Subject: Re: [PATCH v1 2/8] firmware: arm_rmm: Add VSMMU commands and
> fields
>=20
> On Wed, Oct 28, 2026 at 09:35:09AM -0300, Jason Gunthorpe wrote:
> > On Wed, Oct 28, 2026 at 09:49:53AM +0000, Shameer Kolothum Thodi
> wrote:
> > > > +static inline unsigned long rsi_arch_dev_activate(phys_addr_t base=
,
> > > > +						  unsigned long dev_type)
> > > > +{
> > > > +	struct arm_smccc_res res;
> > > > +
> > > > +	arm_smccc_1_1_invoke(SMC_RSI_ARCH_DEV_ACTIVATE, base,
> > > > dev_type, &res);
> > >
> > > These calls leave unused input registers unspecified, whereas
> > > DEN0137 bet3 B1.2 marks them SBZ. Could we explicitly zero them?
> > >
> > > "On calling an RMI or RSI command, any of X1- X16 which are not
> > >  specified as input values in the command definition SBZ"
> >
> > That seems too broad, Linux doesn't even support the x8-x16 inputs in
> > the macros. I think the spec has errd here.
> >
> > Requiring zeroing of x0-x7 is sort of reasonable. Any future use of
> > x8-x16 (including outputs) should require a direct opt in of the OS to
> > indicate it supports this bank of registers.
> >
> > Otherwise you probably need a new macro helper for this protocol..
>=20
> We could probably replace it with:
> 	arm_smccc_smc(SMC_RSI_ARCH_DEV_ACTIVATE, base, dev_type, 0,
> 0, 0, 0, 0,
> 		      &res);
>=20
> This should specify those unused inputs.

Or we could use arm_smccc_1_2_smc() with zero initialized registers, as
rsi_attestation_token_init() does. I think that would cover X8-X16 too.

But other RSI wrappers don't do that consistently, so it's fine either
way, I guess.

Thanks,
Shameer
