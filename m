Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazolkn19012049.outbound.protection.outlook.com [52.103.66.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF32221F26
	for <iommu@lists.linux.dev>; Mon, 10 Nov 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756146; cv=fail; b=oTD2QAdyoY36r7TZHLj+Ia3R9Yojo0B1OCLmD8UVHP2Kz117Ht4xCpUw+F2m2IrsjppDNAB8ujRKA1qhDZR57wH+XtArvzbFVrd9ElAQ0RV3q//5xRLrE67lKJtkjJMa2c0S/29abx+JRvHcrkuvLdK61fWDZnkKcTX0E3fh1r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756146; c=relaxed/simple;
	bh=Vg5LKTj29B93l9p7w2u4N2bK7Q8Uii0ULXLS0P84MKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X97FgsTSPlpif6k03G68zm4WAPXbTY4ITBOVUrO/mjtk9N5TROjfnjFWgAZz95iDh9josXQiB9zwvAjRmPxXRsSpInRvKhK1yw3u2RtCOOlgYlr393nr0SJ1yRvzj6PhQBu26iLGW+JTyNziKXkScx1Kq5W0Pzgwl/DtxepKHTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ivwaK2QX; arc=fail smtp.client-ip=52.103.66.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ivwaK2QX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzrpBeLNhV9hWrBkoEAV56OtfNWWPtzrwzLrNqu2fofuk4h03wZRR/5lzqh+9fFDMbLhlbIwimnRKIRhCEPUEl6SCuKIUyurJjrOE3MQ4BNpkLsj2NaHCaGBssc/KsMIKiYK0+Q+igzTCDHcyBmLrxV9w9GLJ4woRTv64haTzRtsd7vTN9oG6wvHzJ3u0BR1Opqeck10PY6H3otNepH4svoOyR40OFlFqnpu5vTX1wV+uCxlgzqBE8cQ8MUffepmluigJfELiR1M7+hP4sprcCnjuK0+2OvhLvQCjHzuf3W9tDw97RZJO0kI8v6XflxTKSYwFuQksbdydhW+FMTvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vg5LKTj29B93l9p7w2u4N2bK7Q8Uii0ULXLS0P84MKs=;
 b=w18BiaDo4Cg8U/Dx5yDj1yOlZyTTj4gQvDesCKpRl4EPET/jIGSOfZraZSEGQx1RfamRYcDtgoL1LXbOmWrmPlBrrxAMmLw/dUVgKqvq24cgZUO2HRBFwqQ7ucWWB8Z7FakDMQouxU7ADXKP0XbtMBqV5aW/XKTY3VSpgSN4Ft5HG2H3sB1vIISFfjjgEFGFzK3KAH4T/kQeN+sWnxrZ7QiqZZJn+o9YlWyg1TZowVolfC4VBmfMe19isrDGF8bTpG7RX6GGAU8fZbn5rn9m8VwZXvdwQH2JJsCtblH4fLJDB2rjRKUUFyokMDRf6cis/pOXJk9Px9tWpXv0xxyVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vg5LKTj29B93l9p7w2u4N2bK7Q8Uii0ULXLS0P84MKs=;
 b=ivwaK2QXx4IfWRDVUcr7vUYZ79LmTb6KMw5RuCYPpTmNvknxfSP+Dj9I8DUmGbHLegz4B73of2Joz7ms1ty7CoxgIiEYmvcxa/wy/MO13D3IOQyVx/82tIDhJpygqgBEaHygLFG0zsrSDNaVS9wsWQYKHTG0b57uXP5P8thx+WGvTOyMzzjvcvxNMgeY0CGG2IkbGo3H3ssa5sgWnZn03zWPb+8YgEQOONNMJxmXDIViP4bquO5wcnugbCaVLqFKnnuK3xYIHk0zDM4sUYmnhA3/NZG2sGjUwuKqk6CZUF8kzzylHv2s4dxNyoHnIt/JuA4IZ3bSDy3VvQnACGkCRg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by KL1PR01MB5271.apcprd01.prod.exchangelabs.com
 (2603:1096:820:cb::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 06:28:58 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::5e86:f04a:37e5:64f1%5]) with mapi id 15.20.9298.012; Mon, 10 Nov 2025
 06:28:58 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: Tom Lendacky <thomas.lendacky@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Alexey Kardashevskiy <aik@amd.com>
Subject: RE: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Topic: [PATCH v2 2/2] vfio/type1: Set IOMMU_MMIO in dma->prot for
 MMIO-backed addresses
Thread-Index:
 AQHcTMpHV8D4LumdDUC0Htj3DzPtVrTmayuAgAAJP0CAANQ9AIAAEaB9gAAKdgCAAAEiHoAACdAAgAAWhoCAAAndgIAAGEQAgAPMPLA=
Date: Mon, 10 Nov 2025 06:28:58 +0000
Message-ID:
 <SI2PR01MB4393C9F44A5A94D3DC9C28D4DCCEA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References:
 <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393DFDCB2788CB823DAEC64DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107010349.GD1708009@nvidia.com>
 <SI2PR01MB43930E5D802B02D3FCD5ED9ADCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107141632.GL1732817@nvidia.com>
 <SI2PR01MB4393E04163E5AC9FD45D56EFDCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107155704.GM1732817@nvidia.com>
 <SI2PR01MB4393E3BBA776A1B9FC6400D4DCC3A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <20251107163614.GN1732817@nvidia.com>
 <087b3567-5c74-4472-827d-e5a47761a994@amd.com>
 <20251107183209.GP1732817@nvidia.com>
 <a63411aa-6590-4bae-a7f7-01be8ba27eea@amd.com>
In-Reply-To: <a63411aa-6590-4bae-a7f7-01be8ba27eea@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR01MB4393:EE_|KL1PR01MB5271:EE_
x-ms-office365-filtering-correlation-id: 190c3cc9-eae7-46d7-40c7-08de20226e49
x-ms-exchange-slblob-mailprops:
 Om8TgR6f4EA+wY5dTqkCaj8GWTVLO6Z0jz9ayaY95t+Nvai+UoTKSDOVjbVxvBxXTBsK6AoRDYy6aZ3QuZG5xXvyFgapUwMwdup9DBCizVk+ps3C2jCaqRZfEMWJkJDwp9+oNqjt+7n/4qZRaqSevtKYSyKq3Whh5ZKK/6RPeB2V5xa6RK+I/0FNMZshMP2Qz7qZMqAm329eN3DYnt87dvbTxJFVwO2VRs2VIhCgtqq/0/fnm862VC9lnKZB0EhJ2mqM7JX7L0sD+mIPi0nI40uFzFfMW5w51YuFP21iOwEJrGd6Hg99zplcxvP/EuD6JqYATmWDcPIdamPYvi5K+TCMjQcGdUthXlPdGyRDDiup3Xka+xcwwKrfj425Sv5pWQ+bl1/lOjvuSUpNz5bJoM5HRmWOnZEJJoz9fk6OO31TOpwdt11uCgrYzFyYWG2Iru/W8QiFAixu10dbXIWyhMza6FE89kOFfL1WvzdxZaSIKfIWdfIy/ttnRSt3NZfhVxw45v3pNst5DE2PA16L1aZwZcIiV8j7FVkuTzqnl1WSZ0qTOaiajfJjKXqrptC5SVgXx26+17bTKpxrJrYSg2iFwxQ2hB2TPxMWrl/HIsA7qpUfbdGsqmLhpFiKaXm0f3CSoYo13FaYK9phboGnqLs0VND2BZjC7jHe692bwjp5ZiTQjTOJPiodIyMEJ9l/4qNfWnoOzVCPj3jL9SNHYZfwtgXfE6QmFORyOFY6oAVbbO+58NbRizaPfwktroKZjLWtZ42MD84ImQbzUqW030TsjX35FmSjJeFLMP0hRuNCkseaJwkR2OcDLFDZMVdCIuDcYz3xAlQvhVGYDe0IDy7iDB1v1W9n
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|8060799015|31061999003|41001999006|19110799012|15080799012|461199028|51005399006|13091999003|10112599003|56899033|1602099012|13041999003|40105399003|4302099013|440099028|3412199025|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?a21YMzFKckRaTE1HNlUwTm81ZFZXcjVlQld6bWYxZUo4dXNuODVYdlBuWUR2?=
 =?utf-8?B?Q21DQjh3eXEzbHRRU05DSlhtcVEzcThoVmFucXpoV3BaZ1c0aWxvcmhZTDZU?=
 =?utf-8?B?QXJJTlkyRjdFMGxmcDNNMW81amppQUZrUGhETndaK0gybWFxYTRhSjN3aTVn?=
 =?utf-8?B?V1BlR2VMZnh4NTl6U1JNejF6Y0NHaXN0ckFGYVBMWEEvMG9OZlNNdlRJTmly?=
 =?utf-8?B?Ry9RUEVHZDNZM3p4U2pZQnBKRE5wQ2VYNXhubi94SVpKRzQvczZXQ0NTK1FV?=
 =?utf-8?B?SWpldk02VjRXeUxjMkRkTGJTOEVYQnZPczZrRnQwb1pPWnlGb1lXSytITDBO?=
 =?utf-8?B?R0ZDNnpObTFGVXVLV2hCQmhpNmZVMlZQRW0wUlJDTDhldmt3bTRaN0RhSmwz?=
 =?utf-8?B?TDV0UWlLbzc4UzdLbHhTaGNrR1lqRWx2VDZEdUlBREdjdkdkNmRSZVFYWVhj?=
 =?utf-8?B?QlVxb1B1NmN5NldSMUNXdmwwZnMzSTBYRDgwS3NrSlFyNldQdDl2c21vNElt?=
 =?utf-8?B?SXMxWWo4ZnhwWCtXQ1VNVDNKL001N2NCc0dqSTRUdk5DSS92SEN3K3J4d0c4?=
 =?utf-8?B?YVlMZXBDTXpXR21sTVFQdThYT0tWdnBabkJZenpKbWRoMzBpbUtsaFVDVVhq?=
 =?utf-8?B?N0UwL0FwSzFUNkRSZGl3RVdISkFjQ0o5N3MxRmQ3U0N0ZW5jUmVlU1pBRmE0?=
 =?utf-8?B?RmRUS1czVFVKM3RSZk9MMm82TjZWajlMM3NWb0pmVkZ6cjFjUHZsamt0aDEw?=
 =?utf-8?B?MmZUNFZDelE5VndDL3d1TFh4YWtCTXVqbzluV1VJbnFCT3RKMCs0dGtSYWtY?=
 =?utf-8?B?Y1A4TVN0amd3dm5Salc0ZklkU3I1ZXBheTNZNFo4RFFPeGVjQlpKb1hCT2dI?=
 =?utf-8?B?RlJid3IrNGllbHoxME5BNmlWSTREU21Lc1pZRHdGS2JqdTcrTWhjN0szWmls?=
 =?utf-8?B?Vzg3MmEwaU90bkw2dmZrcUU0Q0dYZzdGa1JxSGZEQkVEVkwvZENuZjJyNUZo?=
 =?utf-8?B?WmJBdEdnWEF6elN4dmxCTFRFa0dtSDBmbDVlcDhKNkhEMWlOellzclBNYmNi?=
 =?utf-8?B?SWZNYUFnRkZIN0tKRmJmYlpLdWVDUmJqSHM2QnFoUHIwdGEzM2dFb1FiRnVr?=
 =?utf-8?B?QjB0N3huYURMRndNREdQbzBtSFFFSytYU1IrY0JlSkVFcHprUFFhQTFIdkhE?=
 =?utf-8?B?Q2FkdlVTN2VjVmFsV1pnQWZETE4rclJKNXg5ZmpYLzRsMWxwZzk5czV1Zmxr?=
 =?utf-8?B?WVk4NjNIWnIrbmdqYnFhWENvNmI5Qi9aTUJxN1BldktSZ1F2TitYNTNLanpx?=
 =?utf-8?B?K0ZFV3BwY1ZYMzR4aHc3elNWY3I3dk5qQVlibUZuWk0zZXRkL2NrMjBVbTBs?=
 =?utf-8?B?aWRuVUwzT0NFTVcwakcvREtVTzVvbmgrL0Zybzdhd05KNXRzUXh4L0RmbXRC?=
 =?utf-8?B?WllrRjQrTnJsaVgxRHF4WHdTeUNQc2M3QTlxL2RneCtNQ2tGK2N5UUxJTGMr?=
 =?utf-8?B?amVIb3M1TzVzcUZDdDVGN2NwR0NsTEhjQ0FrL0VoTFpOVmx3Z1ZMcU1pMU1w?=
 =?utf-8?B?RnFBWDdwQ09pbU93ZjVXYVRhSUFGdDFITW0rQzB5cms1MlBCaFRjRFB2Njdm?=
 =?utf-8?B?bEE3emJ2RTlrUmlLeEpJYjUrWHQwcktZRjJ5MnJ0Tmlxcy9OWE4rbUhydEt0?=
 =?utf-8?B?Y3ZtVDFWN0pBRjZ3c0pMS1hTNG1QMXFlUmZ6VmdxNW1ocXlXdlVEQnNlWUta?=
 =?utf-8?B?ZncrRUZieFVtNE5CTzYrMnRXMWpCYjFCdmY4OUxYTEF1Y2EyNVJaYjlMU1Ix?=
 =?utf-8?B?aVhYdDNKcFpVU0dxeDhqVFNrb2d6SnJxT3JSUXUzU0dFSCtpc1ZzdnJhN2pJ?=
 =?utf-8?B?dVk2SG0vaHhiMFVSZ01CK2JDSERBbnhpeTJweU5pdHp3bUlBeXlyYUJxMHdR?=
 =?utf-8?Q?ei7Nl5TbJSk0eFDgHaEr0Y8euyD/46K/?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlpIRExMQkdBVVd1RkhuV21mSlpjWnBJZWVoT1BMZjNtaWJVeko0YXdSNHFU?=
 =?utf-8?B?YkZ0Um4ySEZzeW1OMHBWSkc1ZHpZaGkveUZITURHL0FlTFZ2cGpHQ2dHL0xF?=
 =?utf-8?B?enRtOHJrMHZFelRyZFEwWkxMM08vUFFqQysrcEh5dkdFeWNKazM1dkRRMmNx?=
 =?utf-8?B?SFJZc09NWVYvSEpIOEJUdDlZaWZYY2wxMkVEWVFQejRydHFER2F2RW5ZNkY1?=
 =?utf-8?B?VWVCOUJUQ2NqRUZWUTl6VWh1ajBkU0FHZ0ppZXRaRVFrZzh6NnpEdUMrQ3R5?=
 =?utf-8?B?MkFaaDNBL1ZUZDVveGdoa3dKMlFUZmtXSE9PejFRNFpVT3VaMFEwWTZCOWI1?=
 =?utf-8?B?SE9hRmNTSXYyQ2d6b2dmVDk1ck5OM0h4ZWdEcjVpWWlyU2VEaVhTZ0M0Sndv?=
 =?utf-8?B?Sk5PMFVTT2t1TEwzcWVRdEtpT1BhUEV5aWZTY3NENmVvelZwa2gyRVltQTg1?=
 =?utf-8?B?a3d1UVM4cXVCRk9KdGY2Q3Z6Z0RWR0JkaWlOTTg1ckdTR044ZUdrM1VlUXQ0?=
 =?utf-8?B?b01taTFkWW5kaE1NUGZ2TVlkYXlTc3p6aEJ5cmV2T3RtYUdra0JhQXluZG9D?=
 =?utf-8?B?c2loZGhIWUIzbkUydTJLRlBQems1NXdwRnh2aW4vKzJPUm02QlRJcEhzT1hr?=
 =?utf-8?B?WFRrRFIwQWpWZ1RBTGR3MmhDeitRY2Q1b3piUkdLWFVvRkhPa2tEY3J2cE5X?=
 =?utf-8?B?SG1LdnBrWTFDUVlFTkUzN3M5ajFMNklnSlFUbzFQY3pJNDVON2I5WEFjVHZW?=
 =?utf-8?B?c3pjZ1NCU1ZjbkVybUZRUE93YXVZcDB3aHk3TEcrT0ZEaTl0RG5rQ2RFeE9C?=
 =?utf-8?B?RGJ5THBwQzBSVlJ5NjJSVU5TcUpNOG51cm8zU01UdVA2ejJvdUxDUUdTV1Fo?=
 =?utf-8?B?VW1ld0kyVDBIZTh5VEVhMmFpZWlWNG4xMFp6VzlINHEzQzZrc3lENFZNLzUx?=
 =?utf-8?B?VTlUajh6eUFzRFZzUDdtdld5T1JXdVJaNVpjV3FYbmRiRldMdmUvTWQrN1Zq?=
 =?utf-8?B?TlZzMjdKMFozeXlkM3NJRFhKazNBV2lrdTJqM3pwVHhwN2sxanZEOHA2WmRS?=
 =?utf-8?B?aXRsU3ZXYU4xbjd0Tk1IMjdCTDRCY3M0a29VN2U1NDl6RUZKUytPZS9HeXpH?=
 =?utf-8?B?dS9qaTNqMU1iTzlCemxQbGMxMFJ4NVF2TDVHcFBKNlRGWVNKeVhMc3RQSlk2?=
 =?utf-8?B?dTRYZXdIY0NGazkrdzNjSnNaTmV4MHNIS2szdUJCdFl4Vm9yUkVOK2FSemQ5?=
 =?utf-8?B?Zk1rNUxPUjRKRnpHWnZ1ejVKb2hzUjFSWjhuVzR3VUtaUU5JN2FkeVcvQmVo?=
 =?utf-8?B?NlJidlJKZkgrUHFWeTNYT0VmNjRBK2FhVzNhaHh6SmVEUTVsbUFsSWM4VjJN?=
 =?utf-8?B?WW9rZ3IrZkYwczFyNDVDOTdDeGxXdHFGL2huNCtZazhYdW93SVI3czlEMXQ3?=
 =?utf-8?B?aitaa2ZuWlU2RWtoNjZ1WGdzYk1ZckhRUklPeVZxanYxeEZMY3hqc2I2VnNU?=
 =?utf-8?B?REh3WmZaYk55VVZiS2JMVGZTTGRFZkdYdnhZZStRckF4aXg0OVY3YmJFNHpi?=
 =?utf-8?B?c2tBZWRJcjBJa29idUxnU2RsQnFZdms3NXcwZHNsWFVoQWx4aENDYjM0RlZz?=
 =?utf-8?Q?O7ctGAXt182rLqYyozEuKaIKIcTX4cV1Gux26JWwxSuI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 190c3cc9-eae7-46d7-40c7-08de20226e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 06:28:58.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB5271

T24gU2F0dXJkYXksIE5vdmVtYmVyIDgsIDIwMjUgMzo1OSBBTSwgVG9tIExlbmRhY2t5IHdyb3Rl
Og0KPiBPbiAxMS83LzI1IDEyOjMyLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gRnJp
LCBOb3YgMDcsIDIwMjUgYXQgMTE6NTY6NTFBTSAtMDYwMCwgVG9tIExlbmRhY2t5IHdyb3RlOg0K
PiA+DQo+ID4+IFdoZW4geW91IGFyZSBvbiBiYXJlLW1ldGFsLCBvciBpbiB0aGUgaHlwZXJ2aXNv
ciwgU3lzdGVtIE1lbW9yeQ0KPiA+PiBFbmNyeXB0aW9uDQo+ID4+IChTTUUpIGRlYWxzIHdpdGgg
dGhlIGVuY3J5cHRpb24gYml0IHNldCBpbiB0aGUgcGFnZSB0YWJsZSBlbnRyaWVzDQo+ID4+IChp
bmNsdWRpbmcgdGhlIG5lc3RlZCBwYWdlIHRhYmxlIGVudHJpZXMgZm9yIGd1ZXN0cykuDQo+ID4N
Cj4gPiBTbyAiZGVjcnlwdGVkIiBtZWFucyBzb21ldGhpbmcgYWJvdXQgQU1EJ3MgdW5pcXVlIG1l
bW9yeSBlbmNyeXB0aW9uDQo+ID4gc2NoZW1lIG9uIGJhcmUgbWV0YWwgYnV0IGluIGEgQ0MgZ3Vl
c3QgaXQgaXMgYSBjcm9zcyBhcmNoICdzaGFyZWQgd2l0aA0KPiA+IGh5cGVydmlzb3InIGZsYWc/
DQo+IA0KPiBOb3RlLCB0aGF0IGlmIHRoZSBlbmNyeXB0aW9uIGJpdCBpcyBub3Qgc2V0IGluIHRo
ZSBndWVzdCwgdGhlbiB0aGUgaG9zdA0KPiBlbmNyeXB0aW9uIGtleSBpcyB1c2VkIGlmIHRoZSB1
bmRlcmx5aW5nIE5QVCBsZWFmIGVudHJ5IGhhcyB0aGUgZW5jcnlwdGlvbiBiaXQNCj4gc2V0LiBJ
biB0aGF0IGNhc2UsIGJvdGggdGhlIGhvc3QgYW5kIGd1ZXN0IGNhbiByZWFkIHRoZSBtZW1vcnks
IHdpdGggdGhlDQo+IG1lbW9yeSBzdGlsbCBiZWluZyBlbmNyeXB0ZWQgaW4gcGh5c2ljYWwgbWVt
b3J5Lg0KPiANCj4gPg0KPiA+IFdoYXQgYWJvdXQgQ1hMIG1lbW9yeT8gV2hhdCBhYm91dCBaT05F
X0RFVklDRSBjb2hlcmVudCBtZW1vcnk/DQo+IERvDQo+ID4gdGhlc2UgZ2V0IHRoZSBDIGJpdCBz
ZXQgdG9vPw0KPiANCj4gV2hlbiBDWEwgbWVtb3J5IGlzIHByZXNlbnRlZCBhcyBzeXN0ZW0gbWVt
b3J5IHRvIHRoZSBPUyBpdCBkb2VzIHN1cHBvcnQNCj4gdGhlIGVuY3J5cHRpb24gYml0LiBTbyB3
aGVuIHBhZ2VzIGFyZSBhbGxvY2F0ZWQgZm9yIHRoZSBndWVzdCwgdGhlIG1lbW9yeQ0KPiBwYWdl
cyB3aWxsIGJlIGVuY3J5cHRlZCB3aXRoIHRoZSBndWVzdCBrZXkuDQo+IA0KPiBOb3Qgc3VyZSB3
aGF0IHlvdSBtZWFuIGJ5IFpPTkVfREVWSUNFIGNvaGVyZW50IG1lbW9yeS4gSXMgaXQgcHJlc2Vu
dGVkDQo+IHRvIHRoZSBzeXN0ZW0gYXMgc3lzdGVtIHBoeXNpY2FsIG1lbW9yeSB0aGF0IHRoZSBo
eXBlcnZpc29yIGNhbiBhbGxvY2F0ZSBhcw0KPiBndWVzdCBtZW1vcnk/DQo+IA0KPiA+DQo+ID4g
OiggOiggOigNCj4gPg0KPiA+PiBJbiB0aGUgZ3Vlc3QgKHByaW9yIHRvIFRydXN0ZWQgSS9PIC8g
VERJU1ApLCBkZWNyeXB0ZWQgKG9yIHNoYXJlZCkNCj4gPj4gbWVtb3J5IGlzIHVzZWQgYmVjYXVz
ZSBhIGRldmljZSBjYW5ub3QgRE1BIHRvIG9yIGZyb20gZ3Vlc3QgbWVtb3J5DQo+ID4+IHVzaW5n
IHRoZSBndWVzdCBlbmNyeXB0aW9uIGtleS4gU28gYWxsIERNQSBtdXN0IGdvIHRvICJkZWNyeXB0
ZWQiDQo+ID4+IG1lbW9yeSBvciBiZSBib3VuY2UtYnVmZmVyZWQgdGhyb3VnaCAiZGVjcnlwdGVk
IiBtZW1vcnkgKFNXSU9UTEIpDQo+IC0NCj4gPj4gYmFzaWNhbGx5IG1lbW9yeSB0aGF0IGRvZXMg
bm90IGdldCBlbmNyeXB0ZWQvZGVjcnlwdGVkIHVzaW5nIHRoZSBndWVzdA0KPiBlbmNyeXB0aW9u
IGtleS4NCj4gPg0KPiA+IFdoZXJlIGlzIHRoZSBjb2RlIGZvciB0aGlzPyBBcyBJIHdyb3RlIHdl
IGFsd2F5cyBkbyBzbWVfc2V0IGluIHRoZQ0KPiA+IGlvbW11IGRyaXZlciwgZXZlbiBvbiBndWVz
dHMsIGV2ZW4gZm9yICJkZWNyeXB0ZWQiIGJvdW5jZSBidWZmZXJlZA0KPiA+IG1lbW9yeS4NCj4g
Pg0KPiA+IFRoYXQgc291bmRzIGxpa2UgYSBidWcgYnkgeW91ciBleHBsYW5hdGlvbj8NCj4gPg0K
PiA+IERvZXMgdGhpcyBtZWFuIHZJT01NVSBoYXMgbmV2ZXIgd29ya2VkIGluIEFNRCBDQyBndWVz
dHM/DQo+IA0KPiBJIGFzc3VtZSBieSB2SU9NTVUgeW91IG1lYW4gYSBWTU0tZW11bGF0ZWQgSU9N
TVUgaW4gdGhlIGd1ZXN0LiBUaGlzDQo+IGRvZXMgZG9lcyBub3Qgd29yayB0b2RheSB3aXRoIEFN
RCBDQyBndWVzdHMgc2luY2UgaXQgcmVxdWlyZXMgdGhlDQo+IGh5cGVydmlzb3IgdG8gcmVhZCB0
aGUgZ3Vlc3QgSU9NTVUgYnVmZmVycyBpbiBvcmRlciB0byBlbXVsYXRlIHRoZQ0KPiBiZWhhdmlv
ciBhbmQgdGhvc2UgYnVmZmVycyBhcmUgZW5jcnlwdGVkLiBTbyB0aGVyZSBpcyBubyB2SU9NTVUg
c3VwcG9ydA0KPiB0b2RheSBpbiBBTUQgQ0MgZ3Vlc3RzLg0KPiANCj4gVGhlcmUgd2FzIGEgcGF0
Y2ggc2VyaWVzIHN1Ym1pdHRlZCBhIHdoaWxlIGJhY2sgdG8gYWxsb2NhdGUgdGhlIElPTU1VDQo+
IGJ1ZmZlcnMgaW4gc2hhcmVkIG1lbW9yeSBpbiBvcmRlciB0byBzdXBwb3J0IGEgKG5vbi1zZWN1
cmUpIHZJT01NVSBpbiB0aGUNCj4gZ3Vlc3QgaW4gb3JkZXIgdG8gc3VwcG9ydCA+MjU1IHZDUFVz
LCBidXQgdGhhdCB3YXMgcmVqZWN0ZWQgaW4gZmF2b3Igb2YgdXNpbmcNCj4ga3ZtLW1zaS1leHQt
ZGVzdC1pZC4NCj4gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWlvbW11LzIwMjQw
NDMwMTUyNDMwLjQyNDUtMS0NCj4gc3VyYXZlZS5zdXRoaWt1bHBhbml0QGFtZC5jb20vDQo+IA0K
PiA+DQo+ID4+IEl0IGlzIG5vdCB1bnRpbCB3ZSBnZXQgdG8gVHJ1c3RlZCBJL08gLyBURElTUCB3
aGVyZSBkZXZpY2VzIHdpbGwgYmUNCj4gPj4gYWJsZSB0byBETUEgZGlyZWN0bHkgdG8gZ3Vlc3Qg
ZW5jcnlwdGVkIG1lbW9yeSBhbmQgZ3Vlc3RzIHdpbGwNCj4gPj4gcmVxdWlyZSBzZWN1cmUgTU1J
TyBhZGRyZXNzZXMgd2hpY2ggd2lsbCBuZWVkIHRoZSBlbmNyeXB0aW9uIGJpdCBzZXQNCj4gPj4g
KEFsZXhleSBjYW4gY29ycmVjdCBtZSBvbiB0aGUgVElPIHN0YXRlbWVudHMgaWYgdGhleSBhcmVu
J3QgY29ycmVjdCwgYXMgaGUNCj4gaXMgY2xvc2VyIHRvIGl0IGFsbCkuDQo+ID4NCj4gPiBTbyBp
biB0aGlzIGNhc2Ugd2UgZG8gbmVlZCB0byBkbyBzbWVfc2V0IG9uIE1NSU8gZXZlbiB0aG91Z2gg
dGhhdA0KPiBNTUlPDQo+ID4gaXMgbm90IHVzaW5nIHRoZSBkcmFtIGVuY3J5cHRpb24ga2V5Pw0K
PiANCj4gQEFsZXhleSB3aWxsIGJlIGFibGUgdG8gcHJvdmlkZSBtb3JlIGRldGFpbHMgb24gaG93
IHRoaXMgd29ya3MuDQo+IA0KDQoNCkFsc28gc2hhcmUgbXkgcGVyc3BlY3RpdmUgb24gdGhlIHBy
b3Bvc2VkIHF1ZXN0aW9uczoNCg0KSW4gdGhlIFRFRS1JTyBjYXNlLCB0cnVzdGVkIGRldmljZSBN
TUlPIGlzIG1hcHBlZCB0byBhIHByaXZhdGUgR3Vlc3QgUGh5c2ljYWwNCkFkZHJlc3MgKEZZSTog
dGhpcyBjYW4gYmUgY2hlY2tlZCBpbiB0aGUgU0VWLVRJTyB3aGl0ZXBhcGVyIGFuZCBJbnRlbCBU
RFgNCkNvbm5lY3QgYXJjaGl0ZWN0dXJlIHNwZWMpLCB0aGF0IGlzLCB0aGUgQy1iaXQgaXMgYWRk
ZWQgdG8gR1BBLCBub3QgdG8gdGhlIGhvc3QNCnBoeXNpY2FsIGFkZHJlc3MuIFNvIHRoaXMgY2Fz
ZSBpcyBub3QgcmVsYXRlZCB0byB0aGUgdXBkYXRlcyBpbnRyb2R1Y2VkIGJ5IHRoaXMNCnBhdGNo
LCB3aGljaCBoYW5kbGVzIHRoZSBDLWJpdCBmb3IgTU1JTyBwaHlzaWNhbCBhZGRyZXNzZXMgKHZp
YQ0KaW9tbXVfdjFfbWFwX3BhZ2VzKCkpLg0KQWxzbyB0aGUgImVuY3J5cHRpb24iIGJpdCAoQy1i
aXQgZm9yIEFNRCBhbmQgUy1iaXQgZm9yIEludGVsKSBpbiB0aGUgTU1JTyBHUEENCmRvZXMgbm90
IGFjdHVhbGx5IGVuZ2FnZSB0aGUgZW5jcnlwdGlvbiBlbmdpbmUgKGUuZy4gU01FKSBpbiB0aGUg
bWVtb3J5DQpjb250cm9sbGVyIGZvciBkYXRhIGVuY3J5cHRpb24gKGNvbW11bmljYXRpb24gd2l0
aCB0aGUgdHJ1c3RlZCBkZXZpY2UgaXMNCmVuY3J5cHRlZCB2aWEgSURFKS4gVGhpcyBiaXQgaXMg
dXNlZCBmb3Igb3RoZXIgbm9uLWVuY3J5cHRpb24gcHVycG9zZXMuDQoNCkZvciB0aGUgWk9ORV9E
RVZJQ0UgbWVtb3J5IChtZW1vcnkgaG9zdGVkIG9uIGRldmljZXMpLCBJSVVDLCBpdCBpcyBhY2Nl
c3NlZA0KdmlhIFBDSWUgKG5vdCB0aHJvdWdoIHRoZSBvbi1kaWUgbWVtb3J5IGNvbnRyb2xsZXIp
LiBTbyBTTUUgaXMgbm90IHVzZWQgdG8NCmVuY3J5cHQgdGhpcyB0eXBlIG9mIG1lbW9yeS4gSWYg
d2UgcGFzcyB0aHJvdWdoIHN1Y2ggYSBkZXZpY2UgdG8gdGhlIGd1ZXN0IHVzaW5nDQpWRklPIHR5
cGUxLCBpdCB3aWxsIGJlIHRyZWF0ZWQgYXMgZGV2aWNlIE1NSU8gdGhhdCBieXBhc3NlcyB0aGUg
Qy1iaXQgc2V0dGluZyBhZGRlZA0KYnkgdGhpcyBwYXRjaCwgd2hpY2ggSSB0aGluayBpcyB0aGUg
ZXhwZWN0ZWQgYmVoYXZpb3IuDQoNCkZvciB0aGUgQ1hMIG1lbW9yeSwgd2hlbiBpdCBpcyB1c2Vk
IGFzIHRoZSBndWVzdCdzIHN5c3RlbSBtZW1vcnksIGl0IGRvZXMgbm90DQpnbyB0aHJvdWdoIHRo
ZSBWRklPIFBDSSBCQVIgTU1JTyBwYXNzLXRocm91Z2ggbWVjaGFuaXNtLiBTbyBpdCBhbHNvIGZh
bGxzDQpvdXRzaWRlIHRoZSBzY29wZSBvZiB0aGUgY2hhbmdlcyBpbiB0aGlzIHBhdGNoLg0K
