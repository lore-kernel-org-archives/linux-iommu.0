Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5606A1A01DE
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 16:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553570; cv=fail; b=NsgcqxGgcDe5n/99ZKrYWIMJAX/pZMGFKtnUp1GLi4ANCGkxvdaSDIJC9/qUcN5HrZaVBRCfGzOThSBoMtK1ESgxsSHwWIqEjGow77VDnLIEiFIfQXY/jPpKb7Zom56RnD+ViBXNYlSpe5394zB8FOU0ZkNfbJVPGwec20D6SsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553570; c=relaxed/simple;
	bh=/ixGasgCs9X8IIZZIELzbPdqxaTfenTvVOoR/VxF+34=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BoOIEiV2dNuVGrO6Vck6VZVloS213nsD5NxUrY8zXCw4p8+TfccE/FLbXFijQwnsSwz03g8wdMN0s90UrfsKPtbRToNqXOv8+vsJS5jj2z6MScBNBSVz07LjUXf80N9vKBEI/f0bXPoufIA/R9TXmeFjE9rw54N0YKCd+v6KZtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T54R9czQ; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T54R9czQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saaEO8YGvvqhWXBAb3+wIl9OQ5xcOPM73UYj0yRDJlQyPjUbdcGvGFO62CDBB63ksDD//PmfrjQAgvJkMQ771seQPDPjijbkrsyBW/0UyYWLof2ORk8kvV/ACH2jvDRzvoGnK3tqzdu7vMo1bZODTI7CV30QZan+il1Hr3WoYNee4Hd7jVd5Qw1Pdv142sIvbmUQjaluCIQ3TWt0tp0+y5brJ4hzE15/yxbeXtYQy9YzW8Z9dvlMjdtYappZJ19bjxNLn8wQHu+gQs+TuWHLXl7+cJb/Ih34jxrj3WaQiDxWwTOq2fgmPu+Zt3rO1rICJFpLZuot0VT1maoKh6M5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ixGasgCs9X8IIZZIELzbPdqxaTfenTvVOoR/VxF+34=;
 b=bqVxJsISyTCFpk0wjNF30m87c+hC2SfomVYqEZLGKKG9uDkK+uaxpT0r2zGHrvKQUbBdJpuZmy0zJt4FrvAhWMkdasOd8Zuh26aRMMUD6HanaSRJj1fLaHMvUCTNXbbM+paeGSStPspFxzRHnuRP07AY3TD2CBXlgAa02uVjJUhCl2d8Vn+N/nQpifx23h+PIi8wv+QqLRL6vKqxq8GO5tv2qmQGSA6rxXBYxZKLDCUVEQsar5XDtG2djK7Rccb/sunl1TAOtfdyUdazlLgyVyW+RPrT7A+c4IyfRD3Hrw2GzTf4SSykVc4cWwJJf//QEgxjSpyWWIoDHT0xYbZk8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ixGasgCs9X8IIZZIELzbPdqxaTfenTvVOoR/VxF+34=;
 b=T54R9czQeB6ReDFUBT3EPz8WTmralHfy2SIEYTO+Swa1kggQn3Wnd3NukA4nMbVvvDDNbNA/YpfmEV3BJsRZGozneT5ozZbPj6iOE/IMkipYiI5Ypycym9hszzofbxlEuYdAZTbkQ+2sYLXoXiDi31UF7prGBby0Z6fiPbkrWJrmnLHNzy7q/sLp8qOXbGBBtPWDl3XsLE1qL/zy1W9eSlKyITPgk1r/6teiF3o6VKpR1M6wbKPEbkJyipIBp/bAJQEtx+HxINBpP/rRPHdM5BqKOXSWUlsaI5OvQiJ2gRNn7OnyCr/Hq4qMMoK/dKhP7B0BClUDNWorqpX/zohc4Q==
Received: from MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Thu, 5 Sep
 2024 16:26:03 +0000
Received: from MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971]) by MW6PR12MB8897.namprd12.prod.outlook.com
 ([fe80::7c55:5a45:be80:e971%4]) with mapi id 15.20.7897.027; Thu, 5 Sep 2024
 16:26:02 +0000
From: Matt Ochs <mochs@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Will Deacon <will@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>, Jon Hunter
	<jonathanh@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH next 2/2] iommu/tegra241-cmdqv: Do not allocate vcmdq
 until dma_set_mask_and_coherent
Thread-Topic: [PATCH next 2/2] iommu/tegra241-cmdqv: Do not allocate vcmdq
 until dma_set_mask_and_coherent
Thread-Index: AQHa/z0QP8tKbUv57kiVLC8PsGSJA7JJYhAA
Date: Thu, 5 Sep 2024 16:26:02 +0000
Message-ID: <01093474-ECAC-4302-B405-4127269CDAB0@nvidia.com>
References: <cover.1725503154.git.nicolinc@nvidia.com>
 <530993c3aafa1b0fc3d879b8119e13c629d12e2b.1725503154.git.nicolinc@nvidia.com>
In-Reply-To:
 <530993c3aafa1b0fc3d879b8119e13c629d12e2b.1725503154.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW6PR12MB8897:EE_|CY8PR12MB7436:EE_
x-ms-office365-filtering-correlation-id: 0871fa41-76de-44df-6267-08dccdc76f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWN3UVJkTis4QlBGS1doaE5DZmpyTkpGZVBROTF2UVhnRlZCRDFmc25ySmtu?=
 =?utf-8?B?bXVGbXQzNXNUcDZQOCszMWN1N3FrUDhaVTNSc3RaaThaSjVsYWVwSnprbW1o?=
 =?utf-8?B?UldGQ1NjMzY4M0htZVF1Z2pSZmNpNXpGSUlHTjg3YmpwczlvNmk2K0FWK040?=
 =?utf-8?B?SEJtOE5WSXJQYThhT0RoMDJ2aVZhRmZYR0RBRURzN2VaWGNDbk1xZ1FJSGFG?=
 =?utf-8?B?VzlJWWdrMXY3cWZwRW91NmE2ZmFyQm83MlBaUXhQQllKNEVCUVJVZFJISTJ1?=
 =?utf-8?B?eUxSMkhUYUNWN2R2aERFQnFBckVJYU13dDN3cUcveEhDcStBY0p6dmlmdjhB?=
 =?utf-8?B?UHZqVWE0ZFBiR2lWNmZFam15bGlMWFU3RC9EWXpBUVErbElZNjY3TjdjZGwv?=
 =?utf-8?B?eTROL042SUREbVlUUXVUV2NzS1p1ZnFmL3ZMU01VTEpVZmdaS2ZVWTR0TFFE?=
 =?utf-8?B?VlRsSGNJcC85Ti9hUkgvaUo0MWpIQkNaa1ZRd2tDdWc2MHVwTUI4ZHNveis3?=
 =?utf-8?B?bE9nRVNOdjlmdVJPaXJ1ek52cUE2QmQySGJFaXdwNEltcW56R0gzQjZOZU1t?=
 =?utf-8?B?SGx2OHJPcWNVei91T1hhYW1UVGVYZHI0ckFmd2sxLzBLbGo0Nm15eTBXSWFo?=
 =?utf-8?B?ZmhUcDArRnhhRXRQNGlLS2RaZUxJZ1RrcjNQeS9uODlsK2YzL0Q3Y0VlWlQx?=
 =?utf-8?B?L1VKQUgzQk9TM3hnRWl4OXJUZ3htTVNoaGpVKzJGdjljQkVTZ0NWSGlIaWla?=
 =?utf-8?B?a1J0aklWKzIzNGo4c2diYlBVdnJ2R28venhQZFNrWGJkY1l3WTBFSE1YRW5U?=
 =?utf-8?B?R1lWOU4vQkdDTldPVksyWkhBNG8xZXFuZDlCRXFGaHRXQWN0TTlxZUhWRHdU?=
 =?utf-8?B?cWJlWDRIeVhrVzdyVjJwUzFwNndWZWcxU1JiLzMxMHpyVmVwcXd2OUQ1Mk9E?=
 =?utf-8?B?NGdwY0lSa3kwZE93K2RZS0FuZW1BclZaUmpVcGNsb3VDVXhQQkRua1VGaEtI?=
 =?utf-8?B?RElUcmpBUWNJVUVCZExnTzRmYlZhdkpNc3YyQTN2VG9keGJNc0F5WG1tbktG?=
 =?utf-8?B?djFzeTJxMXhFdHVPdHJyMWFWWHhrU1N2QkkzNFlLVDJ0L1NrdnB0UjFRa25G?=
 =?utf-8?B?MFoxbUlwc3pObXhHNjg1RmJSNUFHWGI5eTI5Sy9ZeStraisxV2xQNThpOStD?=
 =?utf-8?B?dG9xaDJJcVBWYU56RThab0FtTkZMei9MSlBjL3k5WThFNWlTNnhDOEx1Q2d2?=
 =?utf-8?B?OXdCV1V6RW1nY3RkdHVVK1lwZDFuK1g2bVhZM01HVjVGa3laLzVya1huMHNw?=
 =?utf-8?B?Z3U2dTNCbGowbU5HR0JvRURjYTlyUDd2c0lPN1dLMThQZU1POWJ0eXR1Rkxy?=
 =?utf-8?B?NEdBYTExNGhuTVZNUG0wQklibDIxZUZWY2JwSE1nSkJHREwvRGZQcVRhSzl5?=
 =?utf-8?B?Y0tXWE43ZlJWN21ZS3gvajlyRzhUMVYvS1l2MXdHdHVJQUY4MVJtbkRyaTUr?=
 =?utf-8?B?T3NvdWgrOG9KYjAzK1N5MlZCNDhKSk9TUnpoOG5KTnNrSW5XdHcya0x5Z1hu?=
 =?utf-8?B?Zlh6Sy9FNlp4TEdvMjNxaWRPOXMvZ0svd3RaL2R3c2ZZWEk4SHdvM25ibjd4?=
 =?utf-8?B?Q1cwNmduRDd3N2tDZXhwNnprNG5rRVQwZUlMQS81N2lZTktqc1VRS2tTc2hy?=
 =?utf-8?B?cmE2VkNLWkRCbnJEd21XM2JDcmxkalpPUUhEMVU5azdVYnhwTHVaajV5RlFH?=
 =?utf-8?B?SEo5dEZQNkNHYjlGUUtyV1drRW9WR0RURmdwRjg5ZlozSXNRTWJjNUR4UXBs?=
 =?utf-8?B?aFdTVVF4RVlxQ1h0SHIvOWgvVXlPZnE3S2kzMVMrc1JNWVFHU0lQQWk2V1Iv?=
 =?utf-8?B?TGt5SVF3cVErNXM5aE1ybXgyM0UrTmpEMG9MUkwrcTVwRHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8897.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmhSZXN3WStaWC9BbjROazl6N25tZFdWNEVGK1ZrUkpwQWRGTUNzbmV1c2Jw?=
 =?utf-8?B?RTQ4c3VqQk5IU1ZWajQ0enYyRUR3Wjc2ZXI5b2RlRVM2elNlZ21RWkNZR25S?=
 =?utf-8?B?Zmsvb3FtOUJwa3hqeG82bURSUU9qN0NWeDRWV0hCQkVjcXAvOFdXUVdrK2h6?=
 =?utf-8?B?c1J2MXNlWmN2R2R5T2tMeEtsMWE5SU56MXptSG1jaWt2aWZ3anoveStIOWJa?=
 =?utf-8?B?YnoyOS9iSXZNTHIxMm8xSGU2YWwyc2MxUXdMNmtmL3lieDIrYXVneUtXRlBR?=
 =?utf-8?B?bFpNYlhQMmRpUVc0MmZCNFJxemk3ZVhoaFc5M3JFU1hUc2s1L284SUVScTRy?=
 =?utf-8?B?Q1kzR3YvWnAyeExNd1RFVS9CYkVna1BnelFOaklSYWFJR0FTZ2tBY1JUSlcv?=
 =?utf-8?B?UFB2TnRqbXpGTTJJN3p2TDVHb0hWNHYwYmhvM3Q0Y1NROUpjNTcyQU43UU1n?=
 =?utf-8?B?VE05VWUvU1paNzduMDVGNzU5bTBiSjMvdi84VFNnNzhjMnhXVXEvalphZWZ3?=
 =?utf-8?B?YkIzenJLeVN3SXBuNFhjQ3NmMHdya1QvOWFOd3NXQ3l0Z3hWdzNzTjBDSmFU?=
 =?utf-8?B?Q2c4TUVSRWNsSmJ0azJkb1RTaGsrYytFSlFhaVhkQTFzcFhsaTNuZDdSLzRL?=
 =?utf-8?B?c25BdzlhMkN3aGpVQzBsRzJzenJRaU5GYWxYMWR6QVFiWWJObTBvZ2hDMk13?=
 =?utf-8?B?L1VUTVlha3o5V1JpMk9nL2k4dllQS3NQeGdRSnI0c3lRU1g1SCs4Vkt2NzRv?=
 =?utf-8?B?WjdKaGNQdWNEbXVWTWozYmRYZk04ZWhHcm5IZExhaTcxNEVCU0FYMUpKWlNn?=
 =?utf-8?B?MlFaS0tzd3RpWitPR3ZyR0hOYkg2bnhSRDh4b1ZoR1lPMEpnRzlOT2dxODBO?=
 =?utf-8?B?Vll3dCtFU2pObW1vWU43N2dNdlNFTHRWK29IU1I5T3JnS3FFeVF5ejJOTE9J?=
 =?utf-8?B?ankyZ1M3QW1ESUFsaEkzRHVTcDcvVUkvSzRsK2tDdXB2MkpsOUROQzE4dkVL?=
 =?utf-8?B?U2ZjbE9RbFJMa2Fqc1FYajhrQ2ZxRVYzZXlSckd6UW50dnpqWDNjQmlNSWRn?=
 =?utf-8?B?ZGtHSXdUNGl4TC9nK1FLWXdPZ2VFVkJMVEFpKzI5a2NnM3owMXJoOW5SSUhq?=
 =?utf-8?B?dm1oblVkck1MaFJ1bldVTW9qSUFWczg1N3ZjVUJRZkhZT2FiZHk4RnhpZ1kx?=
 =?utf-8?B?d1ZXQlRBNVpNN2s1MVVqL2xscFBvZWY1aHhieEdUTEhsdE5QOG5LQmxFVk1v?=
 =?utf-8?B?TmZTQ0dQZC91bldoT3dJM2crUm1vVGhkUkQ3N0U1cFhpM1gxVXNEUHgveDJR?=
 =?utf-8?B?NWpxV0hlWnIzMG5iSFMzSEZnVHFXTlUzUXorVTcxbDZGbzBETXlqVVNubDVn?=
 =?utf-8?B?YlFLell5MjgwTlJ6UllZZnRiY1JQWU5vMGQwTjVXN1I0bkExU1pHVjhqU1RY?=
 =?utf-8?B?elNjSXN6QUtNUzR3ZFBlME9FTTBzTkhOUmh6aXZYNUd1eUtaTGdxRFFmaXkw?=
 =?utf-8?B?WHpnZWdTR0lLNHM1eXRFUTRTSSsvR2xWR1Z6Ynd2NzlORUNWRVZvTHh1K1VE?=
 =?utf-8?B?eG43TzdKNHgrOFNsQi9GM2lHbUxaazl5UGx4b2FNQkg4My80eW9ZSmNjN1VW?=
 =?utf-8?B?RFFqenlEczJUYkROK0VSdjQ5QU5YcHRQbjRBQmYxVjd5KzBLYU1vUFgzNVBZ?=
 =?utf-8?B?a25ENndUb1I2SnhoMlRDcDJEUlJyNlFsY3B1dU9hRnRpSXdPSENtd1pzV3VT?=
 =?utf-8?B?d2U3ejN6cjZTUmpQT251L3B1b0xpVDZ6WldZWDB0UnVLOGMyNXBzTFlQdThD?=
 =?utf-8?B?UVlQdXg3TEUwb2xlY0hUWG0zd0xVUi9pcU5VNzBTZlFqcjNZL0ptWkJMMHlu?=
 =?utf-8?B?TC9SOTI0czZYYTZJS1Rsb0RkQXptQit5QVpxSVNwVHY1SCtaMCttK2JrVzRD?=
 =?utf-8?B?bURpcmR6cEEzQnRRQlpvNHdnb3diVUF4Witha2lGUDZqdDg0RWErUU1HMndP?=
 =?utf-8?B?SWVUN0Z5NzJKeWU2N05kZld1d2ZQMnpuUHFjWTdnV016ejFJV2dHbTZROGtq?=
 =?utf-8?B?eGtCTXFvMDRReUlRTWpJVitzSzllR3o0NDVTZW55R2FuTmYzbGZZbkpVV3F0?=
 =?utf-8?Q?KcLCAf8CMQ+ODEAUULbnpcP1d?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04D75D8AD39353438B3B285D576CECE0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8897.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0871fa41-76de-44df-6267-08dccdc76f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2024 16:26:02.9461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5WK0bR1C1rCSB4a2lWn73hen7vT5WN+SvXkeGuL2RkJvk+y76VJ4vHjpRt3a9lkQR9snfQQTAOw0Sw+wiSY0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

PiBPbiBTZXAgNCwgMjAyNCwgYXQgOTo0MOKAr1BNLCBOaWNvbGluIENoZW4gPG5pY29saW5jQG52
aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gSXQncyBvYnNlcnZlZCB0aGF0LCB3aGVuIHRoZSBmaXJz
dCA0R0Igb2Ygc3lzdGVtIG1lbW9yeSB3YXMgcmVzZXJ2ZWQsIGFsbA0KPiBWQ01EUSBhbGxvY2F0
aW9ucyBmYWlsZWQgKGV2ZW4gd2l0aCB0aGUgc21hbGxlc3QgcXN6IGluIHRoZSBsYXN0IGF0dGVt
cHQpOg0KPiAgICBhcm0tc21tdS12MzogZm91bmQgY29tcGFuaW9uIENNRFFWIGRldmljZTogTlZE
QTIwMEM6MDANCj4gICAgYXJtLXNtbXUtdjM6IG9wdGlvbiBtYXNrIDB4MTANCj4gICAgYXJtLXNt
bXUtdjM6IGZhaWxlZCB0byBhbGxvY2F0ZSBxdWV1ZSAoMHg4MDAwIGJ5dGVzKSBmb3IgdmNtZHEw
DQo+ICAgIGFjcGkgTlZEQTIwMEM6MDA6IHRlZ3JhMjQxX2NtZHF2OiBGYWxsaW5nIGJhY2sgdG8g
c3RhbmRhcmQgU01NVSBDTURRDQo+ICAgIGFybS1zbW11LXYzOiBpYXMgNDgtYml0LCBvYXMgNDgt
Yml0IChmZWF0dXJlcyAweDAwMWUxZmJmKQ0KPiAgICBhcm0tc21tdS12MzogYWxsb2NhdGVkIDUy
NDI4OCBlbnRyaWVzIGZvciBjbWRxDQo+ICAgIGFybS1zbW11LXYzOiBhbGxvY2F0ZWQgNTI0Mjg4
IGVudHJpZXMgZm9yIGV2dHENCj4gICAgYXJtLXNtbXUtdjM6IGFsbG9jYXRlZCA1MjQyODggZW50
cmllcyBmb3IgcHJpcQ0KPiANCj4gVGhpcyBpcyBiZWNhdXNlIHRoZSA0R0IgcmVzZXJ2ZWQgbWVt
b3J5IHNoaWZ0ZWQgdGhlIGVudGlyZSBETUEgem9uZSBmcm9tIGENCj4gbG93ZXIgMzItYml0IHJh
bmdlIChvbiBhIHN5c3RlbSB3aXRob3V0IHRoZSA0R0IgY2FydmVvdXQpIHRvIGhpZ2hlciByYW5n
ZSwNCj4gd2hpbGUgdGhlIGRldi0+Y29oZXJlbnRfZG1hX21hc2sgd2FzIHNldCB0byBETUFfQklU
X01BU0soMzIpIGJ5IGRlZmF1bHQuDQo+IA0KPiBUaGUgZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVu
dCgpIGNhbGwgaXMgZG9uZSBpbiBhcm1fc21tdV9kZXZpY2VfaHdfcHJvYmUoKQ0KPiBvZiB0aGUg
U01NVSBkcml2ZXIuIFNvIGFueSBETUEgYWxsb2NhdGlvbiBmcm9tIHRlZ3JhMjQxX2NtZHF2X3By
b2JlKCkgbXVzdA0KPiB3YWl0IHVudGlsIHRoZSBjb2hlcmVudF9kbWFfbWFzayBpcyBjb3JyZWN0
bHkgc2V0Lg0KPiANCj4gTW92ZSB0aGUgdmludGYvdmNtZHEgc3RydWN0dXJlIGluaXRpYWxpemF0
aW9uIHJvdXRpbmUgaW50byBhIGRpZmZlcmVudCBvcCwNCj4gImluaXRfc3RydWN0dXJlcyIuIENh
bGwgaXQgYXQgdGhlIGVuZCBvZiBhcm1fc21tdV9pbml0X3N0cnVjdHVyZXMoKSwgd2hlcmUNCj4g
c3RhbmRhcmQgU01NVSBxdWV1ZXMgZ2V0IGFsbG9jYXRlZC4NCj4gDQo+IE1vc3Qgb2YgdGhlIGlt
cGxfb3BzIGFyZW4ndCByZWFkeSB1bnRpbCB2aW50Zi92Y21kcSBzdHJ1Y3R1cmUgYXJlIGluaXQt
ZWQuDQo+IFNvIHJlcGxhY2UgdGhlIGZ1bGwgaW1wbF9vcHMgd2l0aCBhbiBpbml0X29wcyBpbiBf
X3RlZ3JhMjQxX2NtZHF2X3Byb2JlKCkuDQo+IA0KPiBBbmQgc3dpdGNoIHRvIHRlZ3JhMjQxX2Nt
ZHF2X2ltcGxfb3BzIGxhdGVyIGluIGFybV9zbW11X2luaXRfc3RydWN0dXJlcygpLg0KPiBOb3Rl
IHRoYXQgdGVncmEyNDFfY21kcXZfaW1wbF9vcHMgZG9lcyBub3QgbGluayB0byB0aGUgbmV3IGlu
aXRfc3RydWN0dXJlcw0KPiBvcCBhZnRlciB0aGlzIHN3aXRjaCwgc2luY2UgdGhlcmUgaXMgbm8g
cG9pbnQgaW4gaGF2aW5nIGl0IG9uY2UgaXQncyBkb25lLg0KPiANCj4gRml4ZXM6IDkxOGViNWM4
NTZmNiAoImlvbW11L2FybS1zbW11LXYzOiBBZGQgaW4ta2VybmVsIHN1cHBvcnQgZm9yIE5WSURJ
QSBUZWdyYTI0MSAoR3JhY2UpIENNRFFWIikNCj4gUmVwb3J0ZWQtYnk6IE1hdHQgT2NocyA8bW9j
aHNAbnZpZGlhLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0Bu
dmlkaWEuY29tPg0KPiDigJQNCg0KVGVzdGVkLWJ5OiBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5j
b20+DQoNCg==
