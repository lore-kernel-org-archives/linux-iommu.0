Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2111.outbound.protection.outlook.com [40.107.215.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E9810F4
	for <iommu@lists.linux.dev>; Fri, 14 Jul 2023 03:21:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrXPDr3J6xVJwsFbQxFySFQ0q6lzoXrdX0+EeQFp+mbRLlshg48tLMIX5aptTaHjGE359impRioQDJe05jydD3bCM390tNzMgzqc8xKGjSkTN1AdNEDxl9/08UXwU5hYYzo0PBBP/nimToQAm4tqIhqKjwAUD4G0K2+bnI6q/n4Fgr7NrwQqQ2MzkslS5UtYacfRLM98cPeTCICl5TFulDQJKLkIc7tPNYU8RT8uUq1C3e2Z9Idb+g/VS+0W7p4rMMpvMNkRWoYr4YKSsS4h6tfpkXa5MYsyM9SS4UTyywzrFS95xn06fe/rsolN8yxH27qSj0W1/9NfMLZWwBHVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBwY+uzB66jHj5PgeH/jGL1ctej/qvXyW6BqwZylsoU=;
 b=YqIMMLXfjpx8Gbh6c+pOFiAPZGJrHeBUOzAkjfkLkbi2B5vSJRs2F/N6Z5Uig82/EKudHE97DFmyR24s2xdV301s5+vRz0CInIvAqVI1CbaS0oCsRfVlvmq5fjWHaR+iutNcGtAVvkvlMZ5GuvLFvqdHSe3KbkxjWtGzZbofnFaRT9F9YhM71R+nerhQwkPsvRo+sTz+3xSlF/mkXJySiYRP8MoLnPxSRl0p1cQbZHF9viXpxBO2nqT9Dy2HcLVq6i/ZK4qvqvtWGm3/Xrcrc1sRiuCqsOFMvEYZgujbPX+XSeJo46F/PoqpZevsx4aOf0YSTK/kCUe0JWnUa0tXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBwY+uzB66jHj5PgeH/jGL1ctej/qvXyW6BqwZylsoU=;
 b=lJd8Z5nyrCSUfzcjb9I7GMDWFuWevYUweHJJih7iQYGC63wy11UWzIPJjPoJGHlMCk/9nOimohbm8PzCNtpYPf9dm1svAfEGk19HHKwtVa47Uu+4sMZrm4wjIenFSIs4D8o6LN0qjMovRFE6BQVH1HTuxZ9K67BGkCM2OMG04UhljJ6OiWzK2SCGTpBQQ4LQkh+owG9qDwcevcEPPn7Df8bOoeTClG7SyWB1tdb67WWJ9/LhQPoV8u22KtahZWHBYoweexsvcKyIN/uWHgr2e1lTXvOLJD7Oz7TZKd4eypKJDHF9vduB5S4WIN71aNytMRhYgGTYnSIx3F0m+eLzBA==
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR0601MB4436.apcprd06.prod.outlook.com (2603:1096:820:67::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 03:21:47 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Fri, 14 Jul 2023
 03:21:47 +0000
From: =?utf-8?B?5p2c5pWP5p2w?= <duminjie@vivo.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Thierry Reding
	<thierry.reding@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jonathan Hunter <jonathanh@nvidia.com>, "open
 list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>, "open list:IOMMU
 SUBSYSTEM" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
CC: opensource.kernel <opensource.kernel@vivo.com>, Thierry Reding
	<treding@nvidia.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjRdIGlvbW11OiByZW1vdmUgcmVkdW5kYW50IHBh?=
 =?utf-8?B?cmFtZXRlciBjaGVjayBpbiB0ZWdyYV9zbW11X2RlYnVnZnNfaW5pdCgp?=
Thread-Topic: [PATCH v4] iommu: remove redundant parameter check in
 tegra_smmu_debugfs_init()
Thread-Index: AQHZtVulTt9Be4N5d0ejJ/S/NfzgtK+4ky0AgAACj5A=
Date: Fri, 14 Jul 2023 03:21:47 +0000
Message-ID:
 <SG2PR06MB5288ED578DB3CE7DA2B25AB5AE34A@SG2PR06MB5288.apcprd06.prod.outlook.com>
References: <20230713072825.10348-1-duminjie@vivo.com>
 <362e4343-dcf1-58fc-7ac9-756c65bb0df6@linux.intel.com>
In-Reply-To: <362e4343-dcf1-58fc-7ac9-756c65bb0df6@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB5288:EE_|KL1PR0601MB4436:EE_
x-ms-office365-filtering-correlation-id: 0c2ab84b-9f1e-4f07-68a6-08db841974c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vv54X3yooyfB8r3Prl4Z7krwa5uIubEt8lx66ZxDmqHP1Pe28XlmEqSTuGe8AXkdT+0gBLvri5b0DxoQS1L2m8ezHZEPfZQgjeIOFnWOzV74gKMVhYqhGcVTrU+Qm6z7+G3WUyv3O8XwcIg7Ja6aLmTiXvEs29aYg4C/gxHaZbv5pPKJrmk3PSSohUHWO3S+I0clBtpkoqhGCDJ/gmcnFMPeOqtWVjzfLo8FetjRICwUu2wLb0y1m3Dp7AGRX00E+5QKtvzStV3psCsVnCc90pz3ZD3yWWpZMASAlO3v3p/VpNpNgA6PdgxjWP1HDk8BArQ5FSfdslW70rLR7SIgvxH9AY/c3yBhiKzSvPNMD8ZGkF+6T1XO1YmzIOZ3BdtD8OM9NqggZ1GhdowqpACM6iuWfR76eQvD6RslvU3SGe8P2SeLFpWhxS2FFuK40KzDtSn8WnWsfPspPQZ+z09C/oftlBfUkkwdzDulKvoP1mlvfPrdFIPgsnuZWo+fowZUxBljW1IRmKXKvivgx6yO6EWQzxX8vUUhDdSvyPjrrU0mkOBqrD0EhqCtxm607ngP/zMv7NUqiG/iGnDhUD8iBn9d820bq+zaR7AYA3nQkPHQKOf7gA7wR/9W+Ln5SITNvsFQiGxatoqMU+vvlzLPLA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(55016003)(86362001)(85182001)(33656002)(224303003)(38070700005)(122000001)(921005)(38100700002)(478600001)(2906002)(71200400001)(7696005)(110136005)(4744005)(9686003)(6506007)(53546011)(26005)(966005)(8936002)(316002)(41300700001)(66946007)(66556008)(76116006)(7416002)(54906003)(5660300002)(52536014)(4326008)(64756008)(66476007)(66446008)(186003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dTlmWStudEc3U0RYc2FuZjROUXJKMk9ncnAzRGJ0TC9Bcy9maWlhTHQ1enBK?=
 =?utf-8?B?OGJQNWxTUlVPcWEwRjVUZGdiRCs4aDZKcUJkbkdWdXhFYlBIUGkreFRmY1Rj?=
 =?utf-8?B?aXg0TWwySGM4VG81SkQ0aWZid1A0RE5pN2doNFhmbHZJbDhsWFpFVG1GSk1m?=
 =?utf-8?B?eUtjSTdGVjNwTEZvNUFtR3R5WWtsc0hKZDZHaTB6VGZySktpOURlUGsvWnNN?=
 =?utf-8?B?Y0kzSk45cktUVGwxN1c3bkQ4elI1SGNLdEpFL1JmLzllQ2pvSVhoYVM0bzNJ?=
 =?utf-8?B?OWpmb3VUc2wyZHoyRGs4bFQ0bE5OK25SYkJxSDNLcGY5d2RSTTQ3bTZ2L3pH?=
 =?utf-8?B?TW1aZSsxYytPT1NBZmJhVGhURHNGTGRXZVVBcThBaFd4S3AvS1E1TlZBVkhy?=
 =?utf-8?B?TUV6L09tZ08vUW1DK3pabE1VUzhkT2xZb2tOdmV3bFVqVWl1RWlyTElDeEhs?=
 =?utf-8?B?MmxpQTlSMjdpaytSNjNMcWVnd3Noc2lkY3ljamlHQnlaVmxiSW8vbmM1UkRh?=
 =?utf-8?B?S0wzRlV0YWtiUWZ3R0JvblZCSUhjKzVvd05VR0xTU2NQRUxrRlE2bnM5ak1E?=
 =?utf-8?B?TERSTy9TQ3k3b3M0UTBhcjFmOU1nMUpwVHZVL3hYZUF1S1ZJcXIvL3l4Vkpp?=
 =?utf-8?B?NkV6T3pJc0p4WmR4amwxR1R5dHZGRHgrUlcwb0k5SmZUWTNrOUlGVDRuMnJi?=
 =?utf-8?B?TTdOcSs3Mm45NkRHUFF5Y3pSWHBRUVM5L1J0eDNzdzZpQnd2YlNtb3hsemdq?=
 =?utf-8?B?NXdmYkNEcUxaZmo0QVVNMVNUaUVsQlBDQUFLY2lZdjhSMnFNQkRIR1RmcXhF?=
 =?utf-8?B?NzFxcEhzN1RZV0pRQTdWSDM0ZGY0YjdLd1pVMlE1UGczWXJYMjlyMXFTSW15?=
 =?utf-8?B?VFdWQ2NvWFEvSWE2L3FlbFRrYVJoTWUyRVgzWkJPR2ZOZWpBbnFudmEwdEpK?=
 =?utf-8?B?NjIyQ09hUkhWVnlDZGJrNFM1VGpNV3R1ZUg5K0YyVkxqdWdUUXZ1WEo2WlFZ?=
 =?utf-8?B?azQ1UGZlSjBoajR6a0ZEdytNb2lmd3N0Qy93K2Z4aE56NGVkVU5lMjU4THRV?=
 =?utf-8?B?c3BoQnNRd29ZNEZLNjVxOHN1Z2I4MlNGVFNqY1pRTU4zejBmVnluT3Vxa0hU?=
 =?utf-8?B?UGJmZWpUeVhXY0FUdzRmaXpyOHN2SENHWUY2VEM0TXVMRzlsV3ZQNGZ1VUZi?=
 =?utf-8?B?M093Y1Nxa1lJYnZsa2VTMXpSMFdHcEwwNmFRVVJOZnIwVXM2OXFPeFd5QzJs?=
 =?utf-8?B?RnhITG90UlBiRjBzWHk1cnR4Y2lPVFlyWkRrVFhxOGk4VEtMSElJVFVCUnU4?=
 =?utf-8?B?STA4bXRYNEJJOEI1S01rMHJycHEyWDNBQmwrQVlDNVd0WElmWmhKYmZGaUtp?=
 =?utf-8?B?M21KTUw0RUw3MFo3NW5ITHp5aUcxWXZkc29rcVNkS1NqdDdBZldzSys4aFRV?=
 =?utf-8?B?SW14Y1BxSVRJTi9xcVdnbmp0bUZnZ3h5QjJrQUpleW1Nb0oxSzJLTXpRdlA4?=
 =?utf-8?B?R3hPMHF2SDhMd2E3emFmcEtiYXowTGJGdHdEbmREZ2ljcGNHbmxSN1FnZHZI?=
 =?utf-8?B?U3ZTSWR4MThvMHpLRENQNGlMd0FXZjNWTjZtOUFBWWttZXZOWEdsSVFmNlRy?=
 =?utf-8?B?cFhkZnBrWW9oVjdiRGZLZ09xLzM1T3UzeE93dElBbjA4WDRKb2ZBWWgvcGRV?=
 =?utf-8?B?NnpicEN3U3BidVpNYUJZRHBva2dBclQ4OHV2SGZQVkdiWmtDWnJOK0gzWDVQ?=
 =?utf-8?B?VDNTVDVNSDQ3U1VTQTRyUjNFRVhaUzM2U2Q3RXhDaUFDTkhYRU9SaWcrby9W?=
 =?utf-8?B?MGV1RTlSVUtHY2xnOFpUNEdxd3NaWEhocXpZQXo5c3pvNGdXZmo2TTVyRjRz?=
 =?utf-8?B?dzZ1OUxDZHQvcDV3Y1FTU3U1akxQTHdDYW1jbXdGTUQ3T1NCN05FQlNtZ1Fa?=
 =?utf-8?B?eFA2ZnJrY0VWWWVmb0xuam9zMDhVWCtKM0g5Y3AxeFppcE5wbTFRN3RRTEZo?=
 =?utf-8?B?WTVPTGFpM2pJKzVpWVRBL1JBWDR6Mldwelg1VjRnQWxCdW1weHROSFpYbDZ1?=
 =?utf-8?B?TnlHYzBwTkwyaFVuZ3R0WGtjRFZpa0xTWjRGTmFqZkdPdW0wYzY0N3pNWkh1?=
 =?utf-8?Q?lNeQ5mD2ClaGpqVZP2vEjCQmr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2ab84b-9f1e-4f07-68a6-08db841974c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 03:21:47.0913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7GBO0ybdv65BV7rvwvSgzYSaXww/ZCdWgTulFFlyYRL1VvtUo0SP05VYrTg1gwedfZH5z3GQfe4Sugpm+o4aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4436

SGkgQmFvbHUhDQoNCkl0IHNlZW1zIHRoYXQgJ3NtbXUtPmRlYnVnZnMnIGNoZWNrIGlzIHN0aWxs
IG5lZWRlZC4NClRoZW4gSSB3aWxsIG1vZGlmeSB0aGUgcGF0Y2guDQpUaGFua3MhDQoNCnJlZ2Fy
ZHMsDQpNaW5qaWUNCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBCYW9sdSBM
dSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPiANCuWPkemAgeaXtumXtDogMjAyM+W5tDfmnIgx
NOaXpSAxMDo1OA0K5pS25Lu25Lq6OiDmnZzmlY/mnbAgPGR1bWluamllQHZpdm8uY29tPjsgVGhp
ZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT47IEtyaXNobmEgUmVkZHkgPHZk
dW1wYUBudmlkaWEuY29tPjsgSm9lcmcgUm9lZGVsIDxqb3JvQDhieXRlcy5vcmc+OyBXaWxsIERl
YWNvbiA8d2lsbEBrZXJuZWwub3JnPjsgUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNv
bT47IEpvbmF0aGFuIEh1bnRlciA8am9uYXRoYW5oQG52aWRpYS5jb20+OyBvcGVuIGxpc3Q6VEVH
UkEgSU9NTVUgRFJJVkVSUyA8bGludXgtdGVncmFAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0
OklPTU1VIFNVQlNZU1RFTSA8aW9tbXVAbGlzdHMubGludXguZGV2Pjsgb3BlbiBsaXN0IDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0K5oqE6YCBOiBiYW9sdS5sdUBsaW51eC5pbnRlbC5j
b207IG9wZW5zb3VyY2Uua2VybmVsIDxvcGVuc291cmNlLmtlcm5lbEB2aXZvLmNvbT47IFRoaWVy
cnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+DQrkuLvpopg6IFJlOiBbUEFUQ0ggdjRdIGlv
bW11OiByZW1vdmUgcmVkdW5kYW50IHBhcmFtZXRlciBjaGVjayBpbiB0ZWdyYV9zbW11X2RlYnVn
ZnNfaW5pdCgpDQoNCltTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0
IG9mdGVuIGdldCBlbWFpbCBmcm9tIGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbS4gTGVhcm4gd2h5
IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVu
dGlmaWNhdGlvbiBdDQoNCk9uIDIwMjMvNy8xMyAxNToyOCwgTWluamllIER1IHdyb3RlOg0KPiBk
ZWJ1Z2ZzX2NyZWF0ZV9maWxlKCkgd2lsbCByZXR1cm4gZWFybHkgaWYgc21tdS0+ZGVidWdmcyBp
cyBhbiBlcnJvciANCj4gcG9pbnRlciwgc28gYW4gZXh0cmEgZXJyb3IgY2hlY2sgaXMgbm90IG5l
ZWRlZC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogTWluamllIER1PGR1bWluamllQHZpdm8uY29tPg0K
PiBBY2tlZC1ieTogVGhpZXJyeSBSZWRpbmc8dHJlZGluZ0BudmlkaWEuY29tPg0KDQpHcmVnIGtl
ZXBzIHJlbWluZGluZyB0aGF0IG5vIGVycm9yIGJyYW5jaCBmb3IgZGVidWdmcywgc28NCg0KUmV2
aWV3ZWQtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQoNCkJlc3QgcmVn
YXJkcywNCmJhb2x1DQo=
