Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C58418340
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159694; cv=fail; b=cOCsGAxTRc2pmyZ9uXHxv8sMj3Rv0Z+WT9CFNwktlfLDvNx9yUiMg9fAT3+Lc4KpNTL7DoeIQdtvYjVupN5C3v+d68M/+OHNcy7fcZgW1DfEhr+wsbFzi2+vYEl6a0i2dm+cb5W6krXXhbvGGwupybc11/Hrl8mcDit+veZCb8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159694; c=relaxed/simple;
	bh=K7sc7MyiLVZQ8xC6PIEcvvB5KO23NsL69HYOts+oYsg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=peIj0PAoL5O3s5z5mkse70jz+m3wOgezQxW/4LBw4zKImH+Ii4ALHbHlScc1su5oCGyAq3RhCO6lHeHKROnXnAwFDVLxcZlbthYETUZxjzL2g6oETjRVv7Yz2qn6QWHI1YI+6feVbabBo1lnUx+GPtDP1mKb47LtkG0F9e7a2p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=KbtQhInz; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="KbtQhInz"
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69GDSVOw3508732;
	Fri, 16 Oct 2026 14:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=K7sc7MyiLVZQ8xC6PIEcvvB5KO23NsL69HYOts+oYsg=; b=KbtQhInzYDUt
	NN5DzG5Ivkg/5mp1YRgoWhkp81XddiazN1OiA/o77+CR20gBk1CBe46f6PK8wfky
	2T3moQdSyeQDV1Xvb0LWS1Fg+aJZdY974bu8JRXY4Bfwy3bOFAElylO0knGZ5Ih3
	s3AsCPfCc6vzNydoei4Qo/UuhyG5ugdJtAalBzYtASJHcdledeIt4k+bL9fBEa/H
	+3AeH3JFfpqEWHROIy3nFzYsZRSRac6XjRhWcJZmAF74tPlomfhoOuTFOlZ+x4Gi
	LJeLZGEdX4P7Iy4uN5z0enjceEkCO9/IH+oGvyPxChR7ctBBM0OsNhwf7u3PedU6
	dF1dA8fmqw==
Received: from tpzp295cu002.outbound.protection.outlook.com (mail-taiwannorthazon11011028.outbound.protection.outlook.com [52.101.110.28])
	by m0355088.ppops.net (PPS) with ESMTPS id 4h82hs3d08-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 14:07:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQO4XfeTUhEzt4VGv6o0D1Qv/Hn3qw8Khg7hGecU6t4LYr4Zb6LER6H+H5nM+VxbLxX1ARmfH8jJfED5F9x6NbgaGIOmE+FVCBs3rj5QFUafNX9JD7O3mkz8IbhizMK3WSkYZDpfK2XmwS4d/14irrUIWMpKyE+vznW3kkTEjmXnS3/PbUA0vFwodrf01d6cgg/1nbUyhSkQwMeK1odXehaokhFvgya//vEeUhlquToRU3lAckCDJH+arMAzPhnphUKPn32d65pz35LIEWhYzCQsY9o4UX0X9I4IiHXHLW7rG4brYX/LQPlPw+s2l40iWQ+qoKR+qwd036sjWZtzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7sc7MyiLVZQ8xC6PIEcvvB5KO23NsL69HYOts+oYsg=;
 b=DJ5AlE2imyXrI0+sMSXrR8zuG0qwkq67dwwtPqBJbKzqxgf/XhoB8qD6CeNETb08NqwaNrLASTYR2c8N6GBMAVAX8roU5KW9mKi8Z1DRQzApLsRJsmapVBgWYHZiDQ1iW3YJFditrcXc+HZ6Y8GgmdlRQ8y1VcY/lg2vP0jaf0dMPF2AsFvAFK6tXbdqziVfDKnLGey1kSwnSFy8ot/ibolEUOFy1e1wbpAwJRt5SYvXeFnOiQMXUftxd5bym5PKaCODvIEro1/qA4eteEjT+vQ+WeHcQua8M/RyiuoCG+oIPInhAA4BlCGrn0dGUut/svG0G8yhmyoIP4S5c3S36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:b::13) by
 TP0P295MB0082.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.12; Fri, 16 Oct 2026 14:07:34 +0000
Received: from TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
 ([fe80::788e:e9ec:6aac:5820]) by TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
 ([fe80::788e:e9ec:6aac:5820%7]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 14:07:34 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: John Garry <john.garry@linux.dev>, Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me"
	<sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Jiwei JW10 Sun <sunjw10@lenovo.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
Thread-Topic: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
Thread-Index:
 AQHdVvfRmYb5vg+eQEGROWicjtk3c7bzlZoAgAFVUlCABLJBAIAAPDgAgAAnrACABHF9gIABgpTg
Date: Fri, 16 Oct 2026 14:07:34 +0000
Message-ID:
 <TPZP295MB001311997DE1101F69FB0F91B39B2@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
 <2007f03b-2c76-4c36-a0bd-0ce99d1a01a2@linux.dev>
 <20261012121736.GE29954@lst.de>
 <8894307f-1042-497c-9c16-3fc1312486fb@linux.dev>
 <f4f48392-4181-456e-b3d7-907a30b13825@linux.dev>
In-Reply-To: <f4f48392-4181-456e-b3d7-907a30b13825@linux.dev>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenovo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TPZP295MB0013:EE_|TP0P295MB0082:EE_
x-ms-office365-filtering-correlation-id: 415ecc2f-80e2-4206-51d0-08df2b8ed39c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|38070700021|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info:
 s0crlAdovWxjQBju5YIz/ibvLC0PF1Vh2snPRR8Ai5j9GSoGAsnvK4tKV7x97WBrs7+phk/gTI5oJOgqYclc2jacZKefADtsEUfGY+A3oEtjagjgrP5Z9tLihfeD9qsjB8j8+iLjaqrILv9pQREVaF4eSIt7i7be8pbtv4km63Q34GaJgamXNOJa4EFHv6/1qlo2G027K30K4W6UhFXXogkUBvGuFbm/AhI9sNkK+kDsZtsmZtbeYfLcHqF7+u/Z93kvyidqdONzPdxjEwY+YX2q3Potl+dT5avaaYMlXE46kfrxf1/0/89b6RgcWwwpJg+9qYxPk7VOLQRaAryQ3qFuqNYTbFjxZnUKlYuNjTb0b9WoxfFtYZkIfwL0wdjH/a/damOh5MSACQFMlzwROTU9i4W+3TgKxFISoAn7F7AF4/S8YMJPgFl1KIheKWdn5bzoMuz2Ws6mQ0HrZTW9KUZ9eVENlo74As2yJEC0KN4EOp3KnJ0IQCXmqFx0nSylTG9LobfVpVaPtPHPLA+ygZBZiPYVmzk/c5bD49Fx2I5x8EDXywC0kiJ6ayvk9t6YWlSdMPybif5sSSOfu7sNdob0i5r/6shH72Q6wIOAVOEZ+X5AfwA8Wp+GGAQGqOcsyWPvxKPa6N8Q7kdddsOxhGS+6HfnkWuht+2novIhh98=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ny9wclJpc044U1NPQ2xhWVhEWWZGdzBuTVBDSDhwOG9jWnE1MmdEc3pwQ3Bt?=
 =?utf-8?B?NnVRYVFkeUZyanlncUdoalNDbk5uZmJWamozbFdlODQ1SG1kNyt1a01nZVdK?=
 =?utf-8?B?SlVJV055TXV4T3NLcXlRaGE1Y05SVG9KZHoxL3FCVEpUNXkwZWRZaUhFWUJN?=
 =?utf-8?B?TGt5a0dhY2lTYzZ4OG14VEpSV0N6L1FHMkRRNXdTRGk2U1JWTlphbWFJTXcv?=
 =?utf-8?B?dUl3SjVVL21pQlBRRFI5dXp4VkRVamp2ZUNmdWhrek9pQzlicjhIMEd4KzZM?=
 =?utf-8?B?b2RBdnhSUkRwNmREZ3JTQmc1cm1zRzdqMzJOY3VxalBXT1kvSkRjSFpCMTZR?=
 =?utf-8?B?S01pdDExSWNKSTR0dm1hTGQ1cEorbDNTTFVMUXY5Yytzek1aejVZRUVDajhz?=
 =?utf-8?B?b3FDMDNNRml2WE95MU0wN0daYjJ5Yk1EVERyVFVrRmc3L2t0aXFlOWFjUkpm?=
 =?utf-8?B?anE2eGZGUU5UMUZOV2ZhUk5naW0vRDhmZlBkUUlUVmVOVEdubmZ3VDMvMGtz?=
 =?utf-8?B?YXY1Q1dUN2t2ZVBJME5md2IwYTNWS3dzT0R4b2JaaGpMSS9kYkU4ZDkzNDVl?=
 =?utf-8?B?NGJ1a1RUa2JlVmwrNVRqSEZ3T3JqV1R3TU12SnRmbmVhaExOU0l3RmJaelVj?=
 =?utf-8?B?TDk3SjE3OFBnUnZsMHdnRStYbWJTa25ZQS91VXdWT2tZVTIvVm10ZWRFQjds?=
 =?utf-8?B?K0Q5Z0pLeEt3cmwvVG5jdU0xN3Y1V2ZqR21aL2xvbHFHeENPc0V1VE5ERVZN?=
 =?utf-8?B?MzZ0MUxXY0NKaFJxZWxGd01oTnN5clNJTjEwQlB1eVdyRTNtczN5dysyc1M0?=
 =?utf-8?B?RWpTZ0xTdG9WazZTUTN2dU5uL1l5c292MC84eEg1VUR1SUJjZmJkMGk4OU00?=
 =?utf-8?B?VmtUVjNDOFdsMzUzS0pzRHdqMktEdTU2TkUwNjdRWEthS1ozUjVvT3V1b2pK?=
 =?utf-8?B?QUtrTW1rNklheGNUS0FSTlVTeDlKTUVFa3pmcmhLNjdRZDRUNzlSY1RZNzVp?=
 =?utf-8?B?SnEyUVdBUU5hWlprTWg1U2RTRUw1NFdIbSt4NGJ1TkpONk9wbVNjT1dheDBS?=
 =?utf-8?B?Sm96UGcwblRDdDdMbUVUbFZBN2hqV2xQd0RaL2diZm8vTjJZSmQ4N3VrSTE0?=
 =?utf-8?B?amdpaDlMbE5HTHpLdkZpSjVVV3NvZ3V0ekg5SVNzQU0xVTZrUEhsL09lMGRW?=
 =?utf-8?B?WkVoMDNGb2ljenprUUF1TWsxZkR3VkR1VlRXQWRXZ1lVOC9tU0ZraFJWK1N5?=
 =?utf-8?B?WXNsSHEvNTBQSW5oNEw2NlFBOGlnQldZMVl0MWo2YzZOdDdWTGdsNmpFaUxH?=
 =?utf-8?B?T0FGRkMrYVlkMEh6NlpDa3drUzZLTUxqSWpmMk5BdVZsV2J5R3l0VTFubnl3?=
 =?utf-8?B?eHVneUptaEZoK1IyOXB2Y3YvRVFoeGR5b08zSTdkOUNXMHJyTmQwRzZKalBI?=
 =?utf-8?B?NU9idmpORkl4cnJMbDhqWitlRTBTSVRKbjBkOWJNdTgxWXR2ZzNqN3A3Uk5i?=
 =?utf-8?B?QmRoZndnNkRIZjY1aW5NNFBMaW5wUXlZaFZtSlRmZ0lFTk1SOFhON1BXWGl4?=
 =?utf-8?B?U2tXeHo2djZhU3JVMFY5cDZoSXk0ZXVLd1d0TUl2RjFkem82Zk1PSkxncVFU?=
 =?utf-8?B?MzdGcWQ2cDdWNlVsbUdGcTEvNXRHYm1xdE1Tdmk4SVJLQzV6c2FsOTJpM1JT?=
 =?utf-8?B?dTd2dWF4TUQvNENVWEJnbm9TbGJtSU1SZi91b0NYeTAvcGQ0aTJsaWxaS3My?=
 =?utf-8?B?ZkZtZ1lqQktXZ1lRVndhUDhnN2RNUnBKdVBQNk91dWpnc2ZqVUdqYm5jVmFO?=
 =?utf-8?B?Vm81UWZ0dUFqalAvcWYzVVBibEU0cW5UTUh4aGROOFRiY3d3ODB5ZWpicGNx?=
 =?utf-8?B?aEluTlJsVnh4bUVlaTBWQkg3N3NxTmRCN3hIWDVHYjlDWEJzLytBeHhYQ0tQ?=
 =?utf-8?B?ZTZURXNmUTJzVTBIeTgyUG9xK2xyWHlqZGpWVEowR3V2RnQvNjd0Qy83dDdZ?=
 =?utf-8?B?V3pnNlhWZ08vcVY5dDRZWXNPUmRmZzRaUVJwblU1RkM5UXQvT3dQd09mS1k5?=
 =?utf-8?B?ZTRlTi9ibkV1aEJCMTVsZzFxa0xrTEg1RU1nb0lDS011dDhqeE00SXpLa1ZE?=
 =?utf-8?B?WitKOTE5MzVPcXltMTI2YlZKUUlFNFhuUzhWOUpzNHhUWnBTTFdGeEtGZkI2?=
 =?utf-8?B?MWlXUHRKVVQyWFozOVhDQ1h1RkRjay9aLzVQb0Z3MklRdEJPazI4NEtSdG1P?=
 =?utf-8?B?WSt4b1ROdUFpTXlLbXV6bVU1RmRvOWxQcUVBNVcxWHQraXNsb1NZOFh4VEl4?=
 =?utf-8?Q?c0TUa8sqLMkreYJad4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	bvfaQuR9MZMv0+WkWc/t6+46L2RH0MaL+4iHM+KxEyxHWCpZ1GYq7rkSyhN5/8gskYCQIBKogVnwRF+D+1HWz2cCQ7c6yEpODz30X+ARA94qQQE4NoET9rK1qaytEbPDo1D0y2/wiJMFZl97wY+IdA8nB8iSzT6HQ9k6BfyZiLQQ2aP/lYnSB8J2exHp+3woEQE/Kjo9aOS8tdkiunwgKG3AdGDgjcsO+X9UutZhQnPu2oTWC3BnO1ePUsFLcFpyfrY6sJjej3E3XjhvPsxuYSuBsUFD6apVj12dXT7lrvksTpqKthTrERUBwsf5FxZjPUzY/H9NELUkqPG1YMuWpg==
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 415ecc2f-80e2-4206-51d0-08df2b8ed39c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2026 14:07:34.5080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XluSuK+2V7rL74BPeNwe1KBQiSLDB4+kYiMLeeuiG6E5RpiGfYZLpnbDRwoBPHIr8okjgoILb3iHSuelQV2YNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TP0P295MB0082
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NSBTYWx0ZWRfX3U6ksO4J1EwI
 WuvF4bdQY+Rh2317Bvlv3q+CZ85FdCqo1yzZuwVgQPLEHb4iAVwnSR5B6Jchh1IGKSEA8MpX0FV
 1FgO6DqezQc5M6Hseyrd+/p6GPESNRs=
X-Proofpoint-GUID: GOxqB2ndOfH0C1vs0F-WCOZcV86utL3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NSBTYWx0ZWRfXx4toM6DLRFK7
 xBvvNliFw0tQQ5NuvXJSW3rznW4fkqtJ5tSe0da/dSN9tKFbpgvFdTeDugFIvXrWV2Rgz9fxFkH
 Io0D7UOyyw8+fqM1TH1tGJoSGgfHyn/n/PjyknYjTP8qX6qy97xVAtulfXCXrPd8q49HsbCHIXh
 eWrMEBzfWffqeuo4tW/XV02YBL1pdtvfog+/XvoOFWFYGVIVzCk78bSKkUolc+GSiTW/aRrslp0
 bkWeSsVGq7SDO1lXzbkHVqiJoFlemtEPQs2tzMXkNnoDnV9x7MJ4hpWB9RYIR2TNoxE2Huy7HdB
 APlZ4yord8CuqNrmcHAtIawQyjn5tu//AGxCj24GXZf0m34T29T5rQZ5Xr7f4aS3SIv4IMBN36n
 bLMeG7EqydiwKU4mhZGwuj8EKRISgB939Ax/NYTuFkhsDahMIWdfmItb4fCmRdjl6puOPG01ISM
 cdgsHbRNgCceNgq1ocQ==
X-Proofpoint-ORIG-GUID: GOxqB2ndOfH0C1vs0F-WCOZcV86utL3l
X-Authority-Analysis: v=2.4 cv=bev+w+PB c=1 sm=1 tr=0 ts=6ad22fb0 cx=c_pps
 a=ArunfCgiQUwhkF77BEL9og==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=2RTuljz969oO5usasWGy:22
 a=RP4W769tehEb9jLPIooy:22 a=B2nsQV9AAAAA:20 a=8k6WQxmsAAAA:8 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=ksfZtnthxXANqCnuSncA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=-20
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160055

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIEdhcnJ5IDxqb2huLmdh
cnJ5QGxpbnV4LmRldj4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTUsIDIwMjYgNjozMSBQ
TQ0KPiBUbzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+OyBBZHJpYW4gSHVhbmcxMg0K
PiA8YWh1YW5nMTJAbGVub3ZvLmNvbT4NCj4gQ2M6IGtidXNjaEBrZXJuZWwub3JnOyBzYWdpQGdy
aW1iZXJnLm1lOyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IEppd2VpIEpXMTAg
U3VuIDxzdW5qdzEwQGxlbm92by5jb20+OyBpb21tdUBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVj
dDogUmU6IFtFeHRlcm5hbF0gUmU6IFtQQVRDSF0gUmV2ZXJ0ICJudm1lLXBjaTogY2xhbXAgbWF4
X2h3X3NlY3RvcnMNCj4gYmFzZWQgb24gRE1BIG9wdGltaXplZCBsaW1pdGF0aW9uIg0KPiANCj4g
T24gMTAvMTIvMjYgMTU6MzksIEpvaG4gR2Fycnkgd3JvdGU6DQo+ID4gT24gMTAvMTIvMjYgMTM6
MTcsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiA+PiBPbiBNb24sIE9jdCAxMiwgMjAyNiBh
dCAwOTo0MjowNEFNICswMTAwLCBKb2huIEdhcnJ5IHdyb3RlOg0KPiA+Pj4gQW5kIG5vdyB3ZSBz
ZWVtIHRvIGhhdmUgYSBjb25mbGljdCwgYXMgQ2hyaXN0b3BoIHdhbnRzIGJsb2NrIHNpemUgPg0K
PiA+Pj4gSU9WQSByY2FjaGUgbGltaXQgYnV0IHlvdSBmaW5kIGl0IG1heSBjYXVzZSB0aGlzIHNv
ZnQgbG9ja3VwLg0KPiA+Pj4NCj4gPj4+PiAyLiBBbm90aGVyIE5WTUUgd2l0aCBtZHRzPTUgKG1h
eGltdW0gZGF0YSB0cmFuc2ZlciBzaXplID0gMTI4S0IpDQo+ID4+Pj4gwqDCoMKgIDIuMSBUaGUg
aXNzdWUgZG9lcyBub3QgcmVwcm9kdWNlIHJlZ2FyZGxlc3Mgb2YgdGhlICdicycNCj4gPj4+PiBj
b25maWd1cmF0aW9uDQo+ID4+Pj4gMy4gVGhlIGNvbmRpdGlvbiAnMTI4IEtCJyBpcyBpZGVudGlm
aWVkIGJlY2F1c2UgdGhlIElPTU1VIHNjYWxhYmxlDQo+ID4+Pj4gSU9WQSBtZWNoYW5pc20gc3Vw
cG9ydHMgYSBtYXhpbXVtIHRyYW5zZmVyIHNpemUgb2YgMTI4IEtCLg0KPiA+Pj4+IDQuIElPTU1V
IHBhc3MtdGhyb3VnaCBtb2RlIGRvZXMgbm90IHRyaWdnZXIgdGhlIGlzc3VlIHdpdGggdGhlDQo+
ID4+Pj4gJ21kdHM9MTAnIG52bWUgZGlzay4NCj4gPj4+PiA1LiBUaGUgaXNzdWUgb25seSBhcHBl
YXJzIHdpdGggaGlnaC1jb3JlLWNvdW50IHNlcnZlcnMNCj4gPj4+PiDCoMKgwqAgNS4xIFJlcHJv
ZHVjZWQgc2VydmVyczogNDQ4LWNvcmUgc2VydmVyIGFuZCAzODQtY29yZSBzZXJ2ZXINCj4gPj4+
PiDCoMKgwqAgNS4yIE5vbi1yZXByb2R1Y2VkIHNlcnZlcjogMTI4LWNvcmUgc2VydmVyDQo+ID4+
Pg0KPiA+Pj4gSG93IGxvbmcgZG9lcyBpdCB0YWtlIGZvciB0aGUgbG9ja3VwIHRvIHRyaWdnZXI/
IFByZXR0eSBxdWlja2x5LCBJDQo+ID4+PiBndWVzcy4NCj4gPj4+DQo+ID4+PiBEb2VzIGNoYW5n
aW5nIHRoZSBudW1iZXIgb2YgQ1BVcyBhZmZlY3QgdGhyb3VnaHB1dCAoYmVmb3JlIHRoZQ0KPiA+
Pj4gbG9ja3VwKT8gQXJlIHlvdSB1c2luZyBqdXN0IGEgc2luZ2xlIGRpc2s/DQo+ID4+DQo+ID4+
IElmIHRoZSBpb3ZhIGNhY2hlIGxvY2tzIHVwIHVuZGVyIGEgcGVyZmVjdGx5IG5vcm1hbCB3b3Jr
bG9hZHMgaXQgaXMNCj4gPj4gYnJva2VuLg0KPiA+DQo+ID4NCj4gPj4gV2UgcmVhbGx5IG5lZWQg
dG8gZml4IHRoZSBjb2RlIHRoZXJlLg0KPiA+DQo+ID4gU3VyZSwgYnV0IGl0IHdvdWxkIGhlbHAg
dG8gZmlyc3QgZnVsbHkgdW5kZXJzdGFuZCB0aGUgY29uZGl0aW9ucyB0byBmaXggaXQuDQo+IA0K
PiBCVFcsIEBBZHJpYW4sIGl0IHdvdWxkIGJlIGdvb2QgdG8gcnVuIHlvdXIgdGVzdCB3aXRoIHRo
ZSBJT01NVSBpbiBzdHJpY3QNCj4gbW9kZSBhcyB3ZWxsLCBqdXN0IHRvIGdpdmUgYW4gaWRlYSBp
ZiB0aGVyZSBpcyBhIHByb2JsZW0gdGhlcmUgYXMgd2VsbC4NCg0KU29ycnkgZm9yIHRoZSBkZWxh
eWVkIHVwZGF0ZS4gVGhlIG9yaWdpbmFsIHRlc3Qgc3lzdGVtIHVzZWQgdGhyZWUgeWVhcnMgYWdv
DQppcyBubyBsb25nZXIgYXZhaWxhYmxlLCBzbyBJIG5lZWRlZCBhZGRpdGlvbmFsIHRpbWUgdG8g
YXNzZW1ibGUgdHdvIG5ldw0KdGVzdCBzeXN0ZW1zLg0KDQo9PSBUZXN0IEVudmlyb25tZW50ID09
DQogIDEuIDQ0OC1jb3JlIEFNRCBzZXJ2ZXIgKDItc29ja2V0KSB3aXRoIGFuIE5WTWUgZGV2aWNl
IChtZHRzPTEwKQ0KICAyLiA5NjAtY29yZSBJbnRlbCBzZXJ2ZXIgKDgtc29ja2V0KSB3aXRoIGFu
IE5WTWUgZGV2aWNlIChtZHRzPTEwKQ0KICAzLiBUaGUgaXNzdWUgY2FuIGJlIHJlcHJvZHVjZWQg
d2l0aCBhIHNpbmdsZSBOVk1lIGRldmljZSAobWR0cz0xMCkNCiAgNC4gSU9NTVUgbGF6eSBtb2Rl
IGlzIGVuYWJsZWQuIFdlIGRpZCBub3QgdGVzdCBzdHJpY3QgbW9kZSB0aHJlZSB5ZWFycw0KICAg
IGFnbyAoYW5kIG5vdykuIEBKb2huLCBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBtZSB0byBydW4g
dGhlDQogICAgc3RyaWN0IG1vZGUgdGVzdC4NCiAgNS4gc3RyZXNzLW5nIGFuZCBmaW8gdXNlZCBm
b3IgcmVwcm9kdWN0aW9uDQogIDYuIEEgMTAwLXJ1biB0ZXN0IHdhcyBwZXJmb3JtZWQgZm9yIGVh
Y2ggdGVzdGVkIGtlcm5lbA0KDQo9PSBTdW1tYXJ5ID09DQogIDEuIFNpbmNlIHRoZSBvcmlnaW5h
bCBwYXRjaCB3YXMgbWVyZ2VkIGluIHY2LjQtcmMzLCBJIHVzZWQgdjYuMyBhcyB0aGUNCiAgICBi
YXNlbGluZSB0byB2ZXJpZnkgd2hldGhlciB0aGUgaXNzdWUgY291bGQgYmUgcmVwcm9kdWNlZCBv
biB0aGVzZQ0KICAgIHR3byBzeXN0ZW1zLiBUaGUgaXNzdWUgd2FzIHN1Y2Nlc3NmdWxseSByZXBy
b2R1Y2VkIG9uIGJvdGggcGxhdGZvcm1zLg0KICAyLiBPbiB2Ni43IGFuZCBsYXRlciBrZXJuZWxz
LCBhZnRlciByZXZlcnRpbmcgY29tbWl0IDM3MTBlMmIwNTZjYiwgdGhlDQogICAgaXNzdWUgbm8g
bG9uZ2VyIG9jY3Vycy4NCiAgMy4gRGV0YWlsZWQgdGVzdCBpbmZvcm1hdGlvbiBhbmQgbG9ncyBj
YW4gYmUgZm91bmQgaW4gWzFdLg0KDQo9PSBEZXRhaWxlZCBSZXN1bHRzIChCb3RoIFN5c3RlbXMp
ID09DQogICogdjcuMy4wLXJjNyArIHJldmVydCAzNzEwZTJiMDU2Y2I6IFBhc3NlZA0KICAqIHY2
LjEyICsgcmV2ZXJ0IDM3MTBlMmIwNTZjYjogUGFzc2VkDQogICogdjYuOCArIHJldmVydCAzNzEw
ZTJiMDU2Y2I6IFBhc3NlZA0KICAqIHY2LjcgKyByZXZlcnQgMzcxMGUyYjA1NmNiOiBQYXNzZWQN
CiAgKiB2Ni42ICsgcmV2ZXJ0IDM3MTBlMmIwNTZjYjogRmFpbGVkDQogICogdjYuNSArIHJldmVy
dCAzNzEwZTJiMDU2Y2I6IEZhaWxlZA0KICAqIFZhbmlsbGEgNi4zOiBGYWlsZWQNCg0KQmFzZWQg
b24gdGhlc2UgcmVzdWx0cywgSSBiZWxpZXZlIGl0IGlzIHNhZmUgdG8gYXBwbHkgdGhlIHJldmVy
dC4gUGxlYXNlIGZlZWwNCmZyZWUgdG8gYWRkOg0KDQpUZXN0ZWQtYnk6IEFkcmlhbiBIdWFuZyA8
YWh1YW5nMTJAbGVub3ZvLmNvbT4NCg0KQWxzbywgbXkgYXBvbG9naWVzIGZvciBpbnRyb2R1Y2lu
ZyB0aGUgcGVyZm9ybWFuY2UgcmVncmVzc2lvbi4gVGhlIHJlc3VsdHMNCnNob3cgdGhhdCBjaGFu
Z2VzIGluIHRoZSBJT01NVSBzdWJzeXN0ZW0gaW50cm9kdWNlZCBhcm91bmQgdjYuNw0Kc2lnbmlm
aWNhbnRseSBpbXByb3ZlZCBzY2FsYWJpbGl0eSwgYWx0aG91Z2ggSSBoYXZlIG5vdCB5ZXQgaW52
ZXN0aWdhdGVkIA0Kd2hpY2ggc3BlY2lmaWMgY29tbWl0IHJlc29sdmVkIHRoZSB1bmRlcmx5aW5n
IGlzc3VlLg0KDQpbMV0gRGV0YWlsZWQgdGVzdCBpbmZvOiBodHRwczovL2hhY2ttZC5pby9AbFFC
RVByWXhSb09WVjJNYXRVWXVzZy9CMTRYUmJaMW5HeA0KDQotLSBBZHJpYW4NCg==
