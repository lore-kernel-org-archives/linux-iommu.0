Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11020097.outbound.protection.outlook.com [52.101.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1188197A81
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 12:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598530; cv=fail; b=cIireaHjX/cqSbuyE7FU6Uj+D4yV7/PpZcYnzY7ciCez4+tTyx6Ig998mIlhR50TtdB+1oGv010s1dC4zBHt51/5eBJ3f1I45UJzUYlyHXN/EPpAAWmxnyPFL3W7UeGj3pZEpFdwlQFeqOcHepYah4/rBfjJKr9f+2vfnJiO14I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598530; c=relaxed/simple;
	bh=iGn2d9B/mOVijZB7toeF3NZGN0DDGe1yjLe7D7wncLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g0tqNfIoyHFxQ/lKXyJYxGYCssHblWLCaUcqUpq5N4TE3xJn5j9jSKKfIrB2ngd8d+cPb6VZrz8zuTfK25T5SGjt4qmmDRj+nq+TQ1h8KM/6VN1VlppUyiRHDrw8n9oYcft+HcqxgDO80metayM05rWpoT/smps/q6KNZk0vYrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=Mx1vU2lT; arc=fail smtp.client-ip=52.101.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="Mx1vU2lT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oy3c+64IoQ3SnlzLzaBLYHLCX13C0X2CBkCe8Zxslva78/3FLvk9A7PsaGuSBbPLPTIXVze/kswZWEmlr0o21z50W/3y5hxVZy6oy96kARXr5gqL4lK+3onJLMi1YcMWrJ3ZkaVu2/lE12b0DvgcihtverFkFgxqjpXnVhMTGC7/+R3tbVZWaC6ZWGsOvU/bnLpJephsyZSrniSliiySXF8axCU7/Jd6wk5c4cNWFNKysqJdN0rRhrTZrmcYVWf8LF2fpXPVCzfj0LnPXrr3qGwp1/dx7TicM38pD1V33QYGlkcZ3Iu6TB/of2/l5oi2qEkmuPJqsALE0gi3QcJfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGn2d9B/mOVijZB7toeF3NZGN0DDGe1yjLe7D7wncLY=;
 b=ZN6dUHNMsIhmeRH7kVLNFq+yBqEt/6tqmMtUvejc40yPh5eVMlYDsfeO6w6vYbyIIrtK+L93aHYVHBdHLSXkcr6hDTMfwLhBFLofNV5hUV0NBB9bKedZLci5kHJOlEOTU/nd9Ca+u1/RA1xi+ML+CsbR8SVV7XFxKKvaBCk+dbSaIJwvmtJqhdl9Vu/GnM0Nfk9vhAn9BVeXmJjQgo4IK8KegfUHAh2dncvEbe/OAfvpxGf4a70RAjOC8ZNWkfu1wn98AZE0xqUPSVdj7xhiVKidFeKxDHjSl+uXvaty6l9/oZB2PQPyru1sTGNqoNqdF8VfTfz0uRkqngCS4XZkuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGn2d9B/mOVijZB7toeF3NZGN0DDGe1yjLe7D7wncLY=;
 b=Mx1vU2lTk5qnnGcwd5Czxg/4RmhkWal0LvHeCwRSV7rNNOc0kABux7qtRx74e+s3IL5Q5LVCgW07YDRH204mHreKKebEYJJHOOiF6PN+N1qVohX/dff6rjabLvPdmqcSZ4plY4W+5y+iibzdfMV/tp9RZlMXUjUTjWOyPXcP4Z6dWMz9SvlFa2UskKq7Dls/SIB6v5C/DT4KBFjqjLwsfUNA4SJIShT0mnLrtPmddFTf8W76fTCkm6cno+mLMFXIo5nvzFMe2NqSzoHoOK9+Qz344rjhviRilgzOTX4KZaJ3NcThfg4ufGO73v2NO75vtHZPikrLxk3nuA7QRfsNCQ==
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com (2603:1096:400:1ac::13)
 by TYUPR06MB6244.apcprd06.prod.outlook.com (2603:1096:400:35c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Tue, 22 Oct
 2024 12:02:02 +0000
Received: from TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4]) by TY0PR06MB4984.apcprd06.prod.outlook.com
 ([fe80::d3ad:fd6a:a537:55a4%4]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 12:02:02 +0000
From: Angus Chen <angus.chen@jaguarmicro.com>
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH] iommu: Distinguish between sw-msi and msi
Thread-Topic: [PATCH] iommu: Distinguish between sw-msi and msi
Thread-Index: AQHbI61F+sxyMb0HqEqDZU1Pjmf6abKRGdqAgAGREwA=
Date: Tue, 22 Oct 2024 12:02:02 +0000
Message-ID:
 <TY0PR06MB49849D564F3FFE2E1957F4AF854C2@TY0PR06MB4984.apcprd06.prod.outlook.com>
References: <20241021113448.1894-1-angus.chen@jaguarmicro.com>
 <a25451b8-b898-4354-acd3-2826a340f9fe@arm.com>
In-Reply-To: <a25451b8-b898-4354-acd3-2826a340f9fe@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR06MB4984:EE_|TYUPR06MB6244:EE_
x-ms-office365-filtering-correlation-id: e8382d72-28c4-4e90-e7a3-08dcf2915744
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YXpYOUkrbkp4cW8zMWpiY2dZS0lENkJEaHdLOFhDVzBrWjlzak10RjFmbTVo?=
 =?utf-8?B?SkorVkptMDdXZ2FPVnQ2QVV2cnErU1Y4R1gxMGM4ZTJ4cmw0bzJ2ME0wZE1w?=
 =?utf-8?B?T1RPbmJIMnFvZXBXT0gvLzg5eHUyYzZJbFFEdTVCNEdxdmYyT1JhUVNuSk1C?=
 =?utf-8?B?dGtyUmc0bTVqb0hrMzQ0L25SK0hHYmNUZmNZaXhPTVd3R2U3bVdocGtzY1Ri?=
 =?utf-8?B?TFhUR1dtREN0czc1azQyb2R6UVNzcU1XdzJiazJucUs2UkhlWXU1Qm5ndDhv?=
 =?utf-8?B?ekl0RkdqTkgrZStMTjlZTVp3RmhuTEFWZDNJWnBGb3ltWnIzelBkVXV5cEdX?=
 =?utf-8?B?cGZxcWpqRmN4Wlh4OU9COWNaSWhDY3R2L3BzcDVVTnJ0MHV0SlQvdzZPckRX?=
 =?utf-8?B?eUhQcW5PZ3I3cThML2xzbU9ITFpDbEk3dHlkakh0VVI2eXhLSlVuUmNla3R5?=
 =?utf-8?B?TjdpdzUyK3JFaS9HY05VTG95YmlLT01uZXZHb1pzalAwWVJyQ3g2VTFxQzI5?=
 =?utf-8?B?bkt2bFYvUVBnd0Z6cWFBUTUxOWt1QVg0QTMzcHpGbzh4VkdwVldRcmJKYlNV?=
 =?utf-8?B?d1lJOE1abkFmUEJzeEIwMGsxbGpleXljdkV1RDlWbFR5M25rUUpZNnlaZ1Vv?=
 =?utf-8?B?OUZqbWZKVkRvVk1vWXJOQ0p2NFlPT3QyWktDZFVCTVZ1cWl5Skc1Q2tlaTR2?=
 =?utf-8?B?RVhieXNISEw1Z29teVVWM0xQRXJBUjAxazJHYWVCQklWaVY0NElWeHFFT1RF?=
 =?utf-8?B?TWlxSjRTR1AvdC9EY1U0VTBCTW9PcVUxb0dvVU9naklrQUxVaW4wcHllQnpP?=
 =?utf-8?B?cUtTOTVHUlB2L2pUNmNYcUlkdFBYN1R0Z0RjMUlZLzJrVUoxTzdpVWhSU1kx?=
 =?utf-8?B?Q2Iyc0k3UmdMbS9kUm9ha2xObXZTZ3dUWWNISks1N2VIY2NsWTFoOXJKb1lw?=
 =?utf-8?B?NzZOaGltZDZsMjRRVnp4V21wQStTeXpqVzBTUlRYWVFSQ1hqQlhPeEpqZ0Ir?=
 =?utf-8?B?Z0t0R2d3dWFCWGMvMXdhYjZkelFSTnpFOVlzLzlBNW40TndXUW0zZWVSbnRX?=
 =?utf-8?B?THg1czFmMy82MkZ0c1RtVUlFem5DR05sWnV4cGIyOGVlYkdHNzNhdVIvREtM?=
 =?utf-8?B?VzlOanBvZzcwUWI0UHV2eDRmNkV3ZWd1a016R1ZydnVGTG1iZGpDKzBXVE16?=
 =?utf-8?B?Y3hieHJVOXZ6cElEbmREODRkMDl5d1p2OC9nZlY0Nm9wcnBUN1FQUGY5K3Fl?=
 =?utf-8?B?T0puNHFBQUdYU0JINlo1Tys0L0VyQm5TNWFZZFMrRE1yYldVUHpDelE2TzF5?=
 =?utf-8?B?eVJnZGhBNTVrNjZnYlQ0S1FGZDJpbzdBMExuZEtCdmQvY2pxR3NjMnpBMEYv?=
 =?utf-8?B?MWpTNFlOZUxMRWxnL2ZkRnV2dEVtcDFuOWI4WTVnZFhhQzZsdWFYc0hDL1Q2?=
 =?utf-8?B?enpsMWc4bCs1WTFiR1NwN3lVcFdXTy9MZ2dkTTlMMG94L1lMeDRvZjdVaXNx?=
 =?utf-8?B?bUlCTi9kZTUrRVFLTXJuYXg4S2pPMEVZQ1MyS1hxclRHVGEvd0FtSzNPVGFH?=
 =?utf-8?B?OTlSenRMUGpNKzRyTFRoSWp4TEVBZG00N0RXd01JSnFGczgvcWNyUWMvUTZG?=
 =?utf-8?B?STNTRkkyTWtiRE5yREg1M3ZiU0Y3VDRzMWdidzBGbEJrN254WEhiUkVRZXFi?=
 =?utf-8?B?aFZJMUVXT3BRN1lRMWl1MUhDMlRPSitNZzhqdkxlVGtBcStWMUhwRnIzOExR?=
 =?utf-8?B?V2lXa1JBZHJ0WEZCemJ5aWFmOVVVY29Mbnc0SGpMTnA3Qzl0UFpGRWVGSmt4?=
 =?utf-8?Q?ds4VaVY+h9ihurTV1dUqi3fsBFZ3UpUlna1W8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR06MB4984.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmNsUG13bEFnTEUxeWlqdTcvTlNBOFNpQ0E0ZDFqZmRhUC9xMlZtcG1DbDBM?=
 =?utf-8?B?MjZEbUhYTXJlbEV5MVNKdmtvUS9rZGozbFhCSTB6cnE4bE5GeEh6SjFUc3R6?=
 =?utf-8?B?a2hkeUNaSXFsMW9GZDI1ZHErUmoxODhKSmtGYnArOVFXOFE4NlFMNzFwa203?=
 =?utf-8?B?cTlJMEt2eFUvazlSMWlubzEzRnVaTHFsbU1FMW1NM1d6Tk10VVpLTWtjQkJX?=
 =?utf-8?B?TUgwNjlzNTl5RkZROHVkMWxQbGozLzVldXhEMGcyUWZRVVprQjc1M1VRYjVo?=
 =?utf-8?B?cnlUbGYrUUxDcVI1MVFKZDJwWm1FaUNiN0RmNE0zTDdHSjB0RXAzYmk4SmNr?=
 =?utf-8?B?WjhKSW1nbTkwVGdUOXFGYU16aWVZaERIS3IzWFFiWVprQTh4cUMvLzFVb1F5?=
 =?utf-8?B?MlRBdDIvbm9UQ0NtSjY4VXlQajZRYjZUUHp3UW9iN29uRHE1NS9saHVQOEZm?=
 =?utf-8?B?Qkt0K0d6VGMyWlh2MXhVVy9ycERKcWlXdU9SM0paVy9naW1RWEtpZEEvVHJ3?=
 =?utf-8?B?N01lTkg0UWVrTWUxSEJiTDdFTEFlZktGS0YzRUh5RG5RMnNYSjdEQWI1UGx6?=
 =?utf-8?B?U1dueXc2c3VJb3NwV3JDRWtHaUZOcm5mWEZ6eUx5MXhQTThDNUNSeWhkeTlD?=
 =?utf-8?B?VmY4UXBtUHEwcXQ2eFZxdEdGdjlWQVB6ZDVkM3NvdmRveCtkdmVqYVU1Umh4?=
 =?utf-8?B?TmJPaHUrU2Rwc0RZTUFldTN6MTZ5UG82clpJU1BFSk05QW4rbFZRR2xZNDNL?=
 =?utf-8?B?dUhFckpPSHMrVzdQRmZ2cDU3QnZYR3kwL0FnWE1ha3kxYVFQYmdDcm9ZWGJD?=
 =?utf-8?B?enZ3WjE2emZBZFhhbE5lZkVzOFBqMlpWRjdzaHFRbWxzNUwrU25BQVV5L2s4?=
 =?utf-8?B?SWI5T25vb09SOS9zeFNBTGN5R2xML3ROV3ZzSVpnT1NEQUJLN2ExOTFRbmZs?=
 =?utf-8?B?OEk5TjBObGJXTGNQMmFEajd1WlVFVWxUNWx2ako4bE8rV2FuOUhuMWY3cmRV?=
 =?utf-8?B?a1JjZ2xqZEFTRVdNMlVMb3grSDFxTmYwbFlXUWxFbDROZDBVSkhTVk5ZYmxq?=
 =?utf-8?B?MVBYMjVSOVJ0Zm9UME9kUkRaME5lSFoxZm9mUWY3bHpCSTA2Z20zZDVVZEF0?=
 =?utf-8?B?dXlHaWxzTitPL1hUb3BmcUlkNjM5SHNjaGIyNTZHRG55ZGRFditKanRlaFV3?=
 =?utf-8?B?aklIeldnTUIzMWk4RlRMSXJ6RU85NTRuZmpscUI4THNhVTg2RmtIU0JTSUJO?=
 =?utf-8?B?dEZrL3NHdGs0bS90eHdKZlVML0VjSHF4eEJGYVJVNHRqbUZFaytwSmR5WVJX?=
 =?utf-8?B?bDFkZTBKVFlRUk5ERVlkSGtZZTJ5bDNUbG5USm92MndVN0MxdlpWT3o0bjBH?=
 =?utf-8?B?NE9hL29yZkZ6R3RxL3hwS20yT2xjeEVCK0dtMDlxdU9TNXhRd3d6Ly91aEtn?=
 =?utf-8?B?aVJOdmxhTVFQelJUakp1SHJMb0s2TVo4cmg0NGVuTWNaMmZVQ0RDTy9iS2N6?=
 =?utf-8?B?RTE1ZHhTOGNCNTIrZzRWOVN1aDk1ZjEwcGJiK0l1WU1tcU01ak8raFNnQTBQ?=
 =?utf-8?B?WUx6UXRzOGZtd1FqeVBxdy9ONWtVOTUvN0k2dXhCL1JkVm5SbXZVVk5FaSt4?=
 =?utf-8?B?YzExazgzK0pJOWUyck9oeVlURS9XSlNkZWJqSXI4aUNaWFp1Yy9PQ3pNSHBE?=
 =?utf-8?B?UXk1K2ErbC9aMnFPVUV5Ny9GVnNQWVNqNlY2ZUVXaUQyYnhjNFhlbmxBRlRG?=
 =?utf-8?B?L1Rvd1Z4S3Z2Vk5RQmxuWTJSUkNOMFVrQWdsc1VNZTBlZ05LbC9LZXVkVG5Z?=
 =?utf-8?B?WGxESHE0cGQxNDNUNjVIdGtzZmF0eGdQREkrUDUyMDVZd240Yk1CaFNZUmdq?=
 =?utf-8?B?QmpmMFVnZlY5SVl1S2RFL0JDNEZmL1Q2YmNSUDUvdEEyVkNXT1Bqc3Jua2FR?=
 =?utf-8?B?UXhKSWdmamVJL1lzdERHRnJlNFhKR3Rjdi92U1d5OWRFU3NlREMzS0JPS3Az?=
 =?utf-8?B?ZmlnTmsyY1A3WGJMOHQvYlBtSDRGdFNEdy9MREkvdm9hRmhWVFNJRGY1SXhJ?=
 =?utf-8?B?V0l6aFhxQjBuSFRXT1VZdTBIRmJMVUR2akFPQkhPK1cxWkxrbXhDOXk1RGJG?=
 =?utf-8?Q?JIG4aEbRh8deyvdM/IFFJDn8+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR06MB4984.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8382d72-28c4-4e90-e7a3-08dcf2915744
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 12:02:02.7599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h3qvDcKi/KvmCvupR+zztx6sjuWT47g1zAXFNQ6VLFLmjH3B/3+4W3ANtcWl6I38WRXzvPTTX61vhjNGQoxwY/sLsd04j+R0o7BgnV/tmPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6244

SGkgcm9iaW7jgIINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2Jp
biBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIg
MjEsIDIwMjQgNzo1OSBQTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNy
by5jb20+OyBqb3JvQDhieXRlcy5vcmc7DQo+IHdpbGxAa2VybmVsLm9yZw0KPiBDYzogbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIGlvbW11OiBEaXN0aW5ndWlzaCBiZXR3ZWVuIHN3LW1zaSBhbmQgbXNpDQo+
IA0KPiBPbiAyMDI0LTEwLTIxIDEyOjM0IHBtLCBBbmd1cyBDaGVuIHdyb3RlOg0KPiA+IGlvbW11
X2dyb3VwX3Jlc3ZfdHlwZV9zdHJpbmcgdXNlIHRoZSBzYW1lIHN0cmluZyBvZiBJT01NVV9SRVNW
X01TSQ0KPiA+IGFuZCBJT01NVV9SRVNWX1NXX01TSSwgTWFrZSBhIGRpc3RpbmN0aW9uIGZvciB0
aGVzZS4NCj4gDQo+IFdoeT8gV2hhdCBpbiB1c2Vyc3BhY2UgbmVlZHMgdG8ga25vdyB0aGUgZXhh
Y3QgZGV0YWlscyBvZiBob3cgdGhlIGtlcm5lbA0KPiBhbmQgdGhlIHVuZGVybHlpbmcgaGFyZHdh
cmUgYXJlIHJvdXRpbmcgTVNJcz8NCldlIHVzZSBzbW11LXYzIGZvciBhIGRwdSBkZXNpZ27vvIxh
bmQgd2Ugc2V0IGEgcHJpdmF0ZSByZWdpb24gdG8gaGFuZGxlIG1zaSByZWdpb24gbGlrZSB4ODYu
DQpXZSBzZXQgc29tZSBwcml2YXRlIGlvbW11IHJlZ2lzdGVyIHRvIGNvbnRyb2wgdGhpcy4NCklm
IHNvbWUgY3VzdG9tZXIgd2FudCB0byB1c2UgdGhlaXIgb3MgbGlrZSBvcGVub3VsZXIsIHdlIHVz
ZSBzdy1tc2kgbW9kZS4NCklmIHNvbWUgY3VzdG9tZXIgd2FudCB0byB1c2Ugb3VyIGN1c3RvbWl6
ZSBvcyAsd2Ugd2lsbCBzZXQgbXNpIHByaXZhdGUuDQpTb21lIGN1c3RvbWVyIHVzZSBvcGVub3Vs
ZXIgYW5kIHdlIHByaXZhdGUgc21tdS12MyBtb2R1bGUgYXQgdGhlIHNhbWUgdGltZSwNCg0KU28g
SSB3YW50IHRvIHVzZSByZXNlcnZlLXR5cGUgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiBzdy1tc2kg
YW5kIG1zaS4NCj4gDQo+IFRoYW5rcywNCj4gUm9iaW4uDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPg0KPiA+IC0tLQ0KPiA+ICAg
ZHJpdmVycy9pb21tdS9pb21tdS5jIHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+ID4gaW5kZXggODNjOGU2MTdh
MmM1Li44YTJiYmI1YzRhOTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pb21tdS5j
DQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pb21tdS5jDQo+ID4gQEAgLTg0LDcgKzg0LDcgQEAg
c3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdA0KPiBpb21tdV9ncm91cF9yZXN2X3R5cGVfc3RyaW5n
W10gPSB7DQo+ID4gICAJW0lPTU1VX1JFU1ZfRElSRUNUX1JFTEFYQUJMRV0JCT0gImRpcmVjdC1y
ZWxheGFibGUiLA0KPiA+ICAgCVtJT01NVV9SRVNWX1JFU0VSVkVEXQkJCT0gInJlc2VydmVkIiwN
Cj4gPiAgIAlbSU9NTVVfUkVTVl9NU0ldCQkJPSAibXNpIiwNCj4gPiAtCVtJT01NVV9SRVNWX1NX
X01TSV0JCQk9ICJtc2kiLA0KPiA+ICsJW0lPTU1VX1JFU1ZfU1dfTVNJXQkJCT0gInN3LW1zaSIs
DQo+ID4gICB9Ow0KPiA+DQo+ID4gICAjZGVmaW5lIElPTU1VX0NNRF9MSU5FX0RNQV9BUEkJCUJJ
VCgwKQ0KDQo=
