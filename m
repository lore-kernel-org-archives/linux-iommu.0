Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF4078F5E
	for <iommu@lists.linux.dev>; Sun, 27 Apr 2025 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745716910; cv=fail; b=BVKk7F2COdsl/AiJs7EYzVUqmt006A5Gk/8II3am+kuzcF2ZRzbo1zN0KVgT6cz7CNDuzBiXc1LTtNJe1C3U3BOFybZjmOuReyDKEGtkYwtazFUVIBH71Ar+zOpBzW+AQLUCsDUIyrkEdVhdTZrtBp6I87uT9Wgav17y3PWSDjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745716910; c=relaxed/simple;
	bh=AKZ63j+v6h3PZXuIW6rYvXteoMqkt1ePwNvATnO9N0c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFTVM4Ykg8gQx4NUP5qcI+uKZI+g1kL2XcoZ49zqBwBnPI/3FM7e9CkOULkHRCfaTVXZJLUriHk0XsLGVs5TZx6mo444hB15VBbmVdrr9oXeMAvQoSxny+x1AXwk/h5BHfgsnU1V+vqEzWPnH6ptasTQosulcjAeOHHMR00VrW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BcNb60/G; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BcNb60/G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbZzliQj2dkhspns2U1Jgwun4+fI2LRSxeArXmHh5DlB6sX2/qA32N1B/ykkEFEZ2+EDk6f5J/8BGVFP7w5iC892ankOz3+N+pmmnWuMpJOCkMYiLdZfbmhRFmHWerM/5VXuSB0rHAMV0P1YT7qnGeym6VbEDV0cQucxXbAnR3UqVVUIGTIsSDhc613WuJX2JrAnctNIC/E7gnoEvxKU66UOATwTbCTFAQIWd9oOtprKUj4dhyR0RwwJXuCX5kc+NbF/LtlnRNvezI5VBnGTZgsAKT9QXJOY0I4BwExn52I67gau8WRCXzVeBMRwUMjJeeHXP6aJlEa9au42M90wRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKZ63j+v6h3PZXuIW6rYvXteoMqkt1ePwNvATnO9N0c=;
 b=TWIZ6ud1Z8VvpjIW6pK/RQrHEp0Y1QAiMY/Jq0+ymGPipJqwqs+dR8wl8ycwGNGUaEhaF8UKBASbNVrVjQ16JTZT4Cfp/9nzGGsDUvBJBqQL9hmYB6sf4ez+M3X9LmDoMGw8R16RE3WtTn4eQH1rlO2qTubxFleqgcGIp2d9wXjIIF9jRr9IsWWkYtaStDToHSDbfoiEio7SsMpuewb3aeXo0+zOK12VUZTkaTBBYHv1HA9LTEMBOp1bxpsWSkTxB8eZzcEf4+dEONBZxRDhA8MECGC189X1RTMNdzS0P3q0J7cNTRvwDesiliVZ9URdlU33d6FPKAa2RWLYWtT+qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKZ63j+v6h3PZXuIW6rYvXteoMqkt1ePwNvATnO9N0c=;
 b=BcNb60/GfX5B2nlj914bXPPp1sHMmGtnilCkxg5n9YXgBc1xUNz6MfyQZnHxMCdFEK9UvglfinV56voWKGdzBER3JXUqFvehUX09gIDtEicOGCYTvcR+CifnrnQHkdQ2TSmAVunEjbuFyjknmBBzm2EMGbcyoAlTd17I/5iGPFuU3wiEiHNkAM664gQRji2wZk2SU9yeH9xh1qZ/wdufp6st0DeTyy/lB8NkmRoje0xlDrMsBPEK6QW6e5nvH52kTfEObUhIysEEgoD7gc3Xs/rXQ7XTA26EZvGPGH96wudrvynG9MmZ+OGodXrXw/+4aO9D9zWgeoaJJIiw3lWppg==
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5a4::10)
 by AM7PR10MB3525.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:140::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Sun, 27 Apr
 2025 01:21:45 +0000
Received: from AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4]) by AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::380b:e782:af48:75d4%6]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 01:21:45 +0000
From: "Li, Hua Qian" <HuaQian.Li@siemens.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Su, Bao Cheng" <baocheng.su@siemens.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
Thread-Topic: [PATCH 0/1] swiotlb: Make IO_TLB_SEGSIZE Configurable
Thread-Index:
 AQHbs1EG0or5T/N2b0+7TKULFbRAc7OvsGeAgAKX8ACAAIIzAIABFaAAgABWqQCAAof/AA==
Date: Sun, 27 Apr 2025 01:21:44 +0000
Message-ID: <421c32e740cc6e186362a2e35fbabe80ffc1aed0.camel@siemens.com>
References:
 <CGME20250422063734eucas1p2561ad6f847f6824c9c79a842fa458e41@eucas1p2.samsung.com>
	 <20250422063719.121636-1-huaqian.li@siemens.com>
	 <fc2e30eb-2ec7-4795-a2a4-077b7fde7fd5@samsung.com>
	 <dc6f299b18f7870c7bffecca25cee9e436a32c7b.camel@siemens.com>
	 <841c417b-c61a-4c3a-a9ed-236634d78331@arm.com>
	 <824c8fa6acda7c840f856430b5d898c7fcd4702e.camel@siemens.com>
	 <0ec4d1f3-feaf-4c48-9e0d-ac3f872bcccc@arm.com>
In-Reply-To: <0ec4d1f3-feaf-4c48-9e0d-ac3f872bcccc@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6993:EE_|AM7PR10MB3525:EE_
x-ms-office365-filtering-correlation-id: c8352b12-7688-45f2-5f66-08dd8529dfb0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|13003099007;
x-microsoft-antispam-message-info:
 =?utf-8?B?dUo3YkFsMXhWMkcySHJjdmYyc20zV3NVWWRWSGdRcTRxcnZmTFh3eCt1UVBU?=
 =?utf-8?B?RmZydUlYdTQxY1FDRmpyQzZOL2dNTVFBMGl6Z3lnOUhZd296bnRWR0lqSzgw?=
 =?utf-8?B?VEl2NjU5YTdZdWRMVk1vZWcvY0hMNFFaU0xHUnQ3ZFRqSlBoUzM2ajNaaUVt?=
 =?utf-8?B?V0VsRE1qTmQzSUR5SHc5OVNGOG9tUmtWVHZpeFRDTmFrTDlHcHdyaS9nSlNs?=
 =?utf-8?B?RC9PNEdwd2I3Zy9zeFdsb1RPOU1rRTNOSXAvRWpvMGJONjJRcVdsTXNYL0FL?=
 =?utf-8?B?QkMwZzhCbUFwam44MzNhUGw3aXJvZlFmc0ZRRG9MQ3J1cmY0RU8wZWQ5Wk9m?=
 =?utf-8?B?N1VZRVFXU2lqRGRyRldwaWxLSFhBcUxPT01wUW5oTklMZE9Uck1WUzYySm15?=
 =?utf-8?B?dS8yL01KdzNncElJWEp0bFRPOEs5VXVmTWVCeEo0M0tWbzhtNjNMdFdmbE92?=
 =?utf-8?B?dy9PNEJqZkMrUEpBL3ZiT3QwTno3N0pHbkZBc08xdG85MW9kd1ZCSFZUZVlw?=
 =?utf-8?B?R3UxdjJvOEcrVjk5aG45dlRDSnhzeUNkOFVwMlpaaW1rZWFEZHRDWDBocGMx?=
 =?utf-8?B?NGk0d2YrTjZRcE96aTZocjZwek9XVjE0U2hLc203d1dKOHJrZkp2ZmlMVS9F?=
 =?utf-8?B?SGR2WXlnd1JNc2tJTEliandkVElwakd4S1F4V2lzZXdaU3g5dXNxOFlnOUVk?=
 =?utf-8?B?M1V5QkNNaEcyTlYzcXBFYmRjNXVXelFUSk9PZXhxNjVXd2dyS2pyTXU0K1BU?=
 =?utf-8?B?S0Y0YWE5SFZndjV5NG5kQXpwcFF0YXRwNys1NWYzV1ZQUnN0U29UQ3VxT0gr?=
 =?utf-8?B?b2l5SzZzdXdWNXZnK0t5bnZYNFFrT0YxVm1HdTBYaEIrOGdSdThwSTNBcm9C?=
 =?utf-8?B?NTlnMHpIcjFLUFNteTNNMEpQVWxBTEtkUC9CT0RhYUF0L215eXk1RmFsYlhU?=
 =?utf-8?B?OC9UOHFhK0tIOXpaMWFlQ21NOFZGbXlQa2FRTm95dWRyMFZWN0VPTk5JL3Vh?=
 =?utf-8?B?Y2RWeGlxcGxSODAxZ3hNU0c3QlRHZW13a1NRaEN4NCt3ZGh1NjEyZGFobkw0?=
 =?utf-8?B?Rnd3Z2hLRUdhbUJmZjdIckl3ZFo3SGJUeTgra3BUS3l1cTBiN1VGQi84dndV?=
 =?utf-8?B?M3R6WDJGVXRNMkdBVGtadkJBcldPYVkrRVlNWENQUTgxUTF0OGNWdmNlR2E0?=
 =?utf-8?B?dVg1WWgxUXAxRFFwekJDWkk0Q0dETkM3SU43b3FOWU5Ia3NrelRvMjZOem9M?=
 =?utf-8?B?RWVDK0xETXYxVTZJaGluNXJubmlaNnExbWFvM2pVT3RrNDEyMFgxak5LN2Nk?=
 =?utf-8?B?eWg4bkJaeXkzczU5eC9RN1JYUzlyWWlVM0sraEdBZ1B0MlV3WXRwUlZKVU1r?=
 =?utf-8?B?NDRZM1M0WWZTU1dLUDV5SGdESTRhRnhhdjBNVmFUc25PbjJMTGFSSWJaMVJz?=
 =?utf-8?B?VGpUNlBHTlpTcFVNblZzbjRtWFc1ZE16VXU3eFpWUzNDQ1c2SmNJRWVHcUtl?=
 =?utf-8?B?dWU2S3BHRitVNVBzdWE3bFZpVGtVcCtnQ1ArSGRnQVRBUXN0RXhIaTJKcXZD?=
 =?utf-8?B?ZDBZUEZmQ1ZaNXQxMzVBb21CMkY1OUk0TktvYzdoSHhqRjVJM2ovbmxDVEtF?=
 =?utf-8?B?azlUNmpuVXdodlUxNUxYYUZ5bzlDcEJmUm9lVzZqUEdnZGxYcklFckJxQmU5?=
 =?utf-8?B?ZFFGT1YxYkZZVExLSDV5akNoVyswMUFNZWdUc2FSNnhmTzBlNzlIMGtUY1p6?=
 =?utf-8?B?NXhicU1OQVM5djBNenVTa2JXeEo2RnlmcC9NN0RDVVhZUjlUR2NOakM1T1JG?=
 =?utf-8?B?NDRWVGhEVXdENS9RWm12azZsZHVIOEV0b3Z0R0FkaGZBd1BhTk1aTDRJSCtW?=
 =?utf-8?B?Q1J0cXo5dGNnNHpTWm92N3NjNUpyKzJnbS9DdWpCUGRzTGtUV2pFbkhDY0RL?=
 =?utf-8?Q?Z1QEzdMfgyhITtGg+OPlSMJuZjwJIFpL?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVh1ckVOMVJCSFAwK2pXYmRKMEd6bjhYZkdDc2FidklDRDlGV2dNZlZUWjE1?=
 =?utf-8?B?bTF2SGZZRzBWL09SMDlCNW4vV21zWWY0eWdrRjJNVTQyeVg5UXFsNTJpT3g5?=
 =?utf-8?B?cHJwK0xzQ0ZYY3VNOFNoVFRpTzJ4MGdqMXlnTGNMZTdEWlFNOUNndFdWelNY?=
 =?utf-8?B?Rjc4N3c1bUZNcU9sc3ZaZmszcjZRWVRWalBoUk40VmZ4Q1RlN3Y0VklQWGd0?=
 =?utf-8?B?QjRwNjJCN29wbHVWUk93aVJHMStMdFZUVGIyeGNVTDFmZTRhUy95ZU9lOUhj?=
 =?utf-8?B?eEg4UHRqdzZxVWpLZ2dGZmZ4N1l4N2dwQWdhRi9ONEJvaHdMRXgzWW9lcHBJ?=
 =?utf-8?B?cDNYKzNSUzRqZTFkclBPdmY2dXM2VGttcEtiekFIcEl6WUNPR0pjU3FNTUFT?=
 =?utf-8?B?cjJCRk1WNkhVMGRoOWJmcmYrNFdCLzhSN1JyOWdrQXkyZlZMUUpoakN3S2hG?=
 =?utf-8?B?djVZaTF3RWhvUEhWU05kTWhWb1pSWGlWSmRocC9pVWp4a3RMRllVRmdDWjBU?=
 =?utf-8?B?eXlUS1lJODlaQWNMazYxNWg4bk02Z1M5ZHRsRTlCQk80NG9Ja2JnUnkwb1Mx?=
 =?utf-8?B?RG9Wc0FORG5tNTdKTEpNWThqcUMvNUZNcS9pRFoyZ0grd1pzZThEeHlqL2E1?=
 =?utf-8?B?VU84VTcxOEFJVVhVeDRHTXRrdk14N2RydUR5enpvYi9OV0hIenZNeHppeGZH?=
 =?utf-8?B?NFNOMWtSdTNzMHBhelZ5RTNEM0JMT1N4Y0lzNDZXd2dYZ2l4RXpZbExzMWZT?=
 =?utf-8?B?b25YK2ZXcUlWVFFkWmx6N2xMZUtvWEZVY0NvWmFsYTRaTDVOZFdXbWgrYWhG?=
 =?utf-8?B?S3ROQ0g4RFJaQVl1K2Y5RmorTk9vQzBXUGhVSzMzb2ZNUzdUTStxa2UyWDhP?=
 =?utf-8?B?OVlPeFkrQjYyaHg4Y1lVeW9vUlluS0FIcko1a21CWmkwTEZ3OXNDU2x4d2Nm?=
 =?utf-8?B?Qm1rbU9zdzZoWWlDNC85TEVNRkd3ZzhVSG9TQkJQQ09DTEYzUlc3NWZYRGFo?=
 =?utf-8?B?SnY3Wm5pN3p0U1JXVHZ5ZmIwZ29LSyt1QW1FNXVLL0hyM3ordnJhaWVycG01?=
 =?utf-8?B?bTlJM1FNeDg4NEhpRWJ4M2VIend0VWVQbjRzWGIxZEMxc1hsU05laldLTXRq?=
 =?utf-8?B?cVVVM1JPbzZGTUw0eEJzYW5QOU0yKytNdE1xS2p2d0ZzMFNPSU1aRW96ejZk?=
 =?utf-8?B?OVFVQk4vWWQ2TjVLcWU4Um9TOGV4eG5RRGN6Q25tVzdPbXZiV0lXUUhBYzl2?=
 =?utf-8?B?ekt2dW1FMEdkdWR0OW9yc3ZIWGJZdEh4TVdDWHhYUWJxUjZ3Q2NxTXF4N1B6?=
 =?utf-8?B?SUZsdDNSSVRnQVBWTWpnazdUai85NWhMMzY2TXBUV05xV0E5dTJTNnVRYWNk?=
 =?utf-8?B?VXpoekp6Zjk3bVYxRlQ3cEhwUjFNeGV1SDFlbUFqdGU0TEJvdERQb2d5ZUVr?=
 =?utf-8?B?Z2ppd1RocHBQbXk1WHFGb0U1U25LeWQ0NkVHRUhEaEQ2enc1WUFMR3pHVVBn?=
 =?utf-8?B?ZTRTNFU2ZHl4ZWw4YXc1NysxN1dhdTVxWDgzRjQ1NlR6UStMczMyV0ViNkQ1?=
 =?utf-8?B?SmFVZXFIOEt5eEROMnp2RkN2a3ZmT1V3cm1nSFV5SDFzWFlVVjl2dEZuaWJW?=
 =?utf-8?B?WEEzU3RCUWlWQlhNMi9MZTRSTTgrY3BEQjFBTTVFdFZ5NTQxMWpHa3JWaEZs?=
 =?utf-8?B?ZnFMRGlhTlJtSWFUOE54Z3ljbFBPN0o4dTdLSWViMVZ5RzRZWXZZWmRLdXFV?=
 =?utf-8?B?WStyZlZJWWVXKzE4TU9sNUxVV01XZlJwdVM5clE1V2dZNzJ3REFpSGoyN1oy?=
 =?utf-8?B?R05kcERiZkt0REtORHptQzB0UlMycFlWU1gxc0xURC9TRzFzZnp2aGphT0hE?=
 =?utf-8?B?WTBNMm1sR1BWYU96SGRiUnZCZGFvRTBOMjF5SWZXWE9GS0tqaVJZV1dRMXBs?=
 =?utf-8?B?Rko3NW1hc1Z0aGh2Q01hNk52YVNBeWRiMzFST2NnUGpMVHVpY0MrV2VaaFlB?=
 =?utf-8?B?ZWM5NWhQZ2VUVEwxeXNxY3QzSjlmdE9uMmRLR0VoL3hNaHYyYzZkNVdCNDM2?=
 =?utf-8?B?cDBxSUxxaXRvczV6TkRMejRya29HejNiekVTV2lobWpLY3hsS1UwcFV1VndN?=
 =?utf-8?B?ZWRldERBMWJGSWRUTitKT29lemt1b1hxRHRCYlRJS0VMd2IwaXRxYmJuMFRh?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EB1F84ED1FBC245AD9F42CEF5F7E2A9@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6993.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c8352b12-7688-45f2-5f66-08dd8529dfb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2025 01:21:44.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rx/MS9Oi7qp4voFrCv2zznkp3LnIaEStMndoY2BMFlxrmwvh4VJffxVIp2ds1MPomVZkWuIZK2VVBRKd9aodgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3525

T24gRnJpLCAyMDI1LTA0LTI1IGF0IDExOjQyICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IE9uIDIwMjUtMDQtMjUgNjozMiBhbSwgTGksIEh1YSBRaWFuIHdyb3RlOg0KPiA+IE9uIFRodSwg
MjAyNS0wNC0yNCBhdCAxMzo1OCArMDEwMCwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPiA+ID4gT24g
MjQvMDQvMjAyNSA2OjEyIGFtLCBMaSwgSHVhIFFpYW4gd3JvdGU6DQo+ID4gPiA+IE9uIFR1ZSwg
MjAyNS0wNC0yMiBhdCAxNTozNiArMDIwMCwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToNCj4gPiA+
ID4gPiBPbiAyMi4wNC4yMDI1IDA4OjM3LCBodWFxaWFuLmxpQHNpZW1lbnMuY29tIHdyb3RlOg0K
PiA+ID4gPiA+ID4gRnJvbTogTGkgSHVhIFFpYW4gPGh1YXFpYW4ubGlAc2llbWVucy5jb20+DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gVGhpcyBwYXRjaHNldCBpbnRyb2R1Y2VzIGEgY2hhbmdl
IHRvIG1ha2UgdGhlDQo+ID4gPiA+ID4gPiBJT19UTEJfU0VHU0laRQ0KPiA+ID4gPiA+ID4gcGFy
YW1ldGVyDQo+ID4gPiA+ID4gPiBjb25maWd1cmFibGUgdmlhIGEgbmV3IGtlcm5lbCBjb25maWd1
cmF0aW9uIG9wdGlvbg0KPiA+ID4gPiA+ID4gKENPTkZJR19TV0lPVExCX1NFR1NJWkUpLg0KPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEluIGNlcnRhaW4gYXBwbGljYXRpb25zLCB0aGUgZGVmYXVs
dCB2YWx1ZSBvZg0KPiA+ID4gPiA+ID4gSU9fVExCX1NFR1NJWkUNCj4gPiA+ID4gPiA+ICgxMjgp
DQo+ID4gPiA+ID4gPiBtYXkNCj4gPiA+ID4gPiA+IG5vdCBiZSBzdWZmaWNpZW50IGZvciBtZW1v
cnkgYWxsb2NhdGlvbiwgbGVhZGluZyB0byBydW50aW1lDQo+ID4gPiA+ID4gPiBlcnJvcnMuDQo+
ID4gPiA+ID4gPiBCeQ0KPiA+ID4gPiA+ID4gbWFraW5nIHRoaXMgcGFyYW1ldGVyIGNvbmZpZ3Vy
YWJsZSwgdXNlcnMgY2FuIGFkanVzdCB0aGUNCj4gPiA+ID4gPiA+IHNlZ21lbnQNCj4gPiA+ID4g
PiA+IHNpemUgdG8NCj4gPiA+ID4gPiA+IGJldHRlciBzdWl0IHRoZWlyIHNwZWNpZmljIHVzZSBj
YXNlcywgaW1wcm92aW5nIGZsZXhpYmlsaXR5DQo+ID4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiA+
IHN5c3RlbQ0KPiA+ID4gPiA+ID4gc3RhYmlsaXR5Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ291
bGQgWW91IGVsYWJvcmF0ZSBhIGJpdCBtb3JlIHdoYXQgYXJlIHRob3NlIGNlcnRhaW4NCj4gPiA+
ID4gPiBhcHBsaWNhdGlvbnMNCj4gPiA+ID4gPiB0aGF0DQo+ID4gPiA+ID4gcmVxdWlyZSBpbmNy
ZWFzaW5nIElPX1RMQl9TRUdTSVpFPyBJJ20gbm90IGFnYWluc3QgaXQsIGJ1dA0KPiA+ID4gPiA+
IHN1Y2gNCj4gPiA+ID4gPiBjaGFuZ2UNCj4gPiA+ID4gPiBzaG91bGQgYmUgd2VsbCBqdXN0aWZp
ZWQgYW5kIGRlc2NyaWJlZCwgd2hpbGUgdGhlIGFib3ZlDQo+ID4gPiA+ID4gY292ZXItDQo+ID4g
PiA+ID4gbGV0dGVyDQo+ID4gPiA+ID4gZG9lc24ndCBwcm92aWRlIGFueXRoaW5nIG1vcmUgdGhh
biBpcyB3cml0dGVuIGluIHRoZSBwYXRjaA0KPiA+ID4gPiA+IGRlc2NyaXB0aW9uLg0KPiA+ID4g
PiBUaGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2ssIE1hcmVrLg0KPiA+ID4gPg0KPiA+ID4gPiBU
byBwcm92aWRlIG1vcmUgY29udGV4dCwgb25lIHNwZWNpZmljIGFwcGxpY2F0aW9uIHRoYXQgcmVx
dWlyZXMNCj4gPiA+ID4gaW5jcmVhc2luZyBJT19UTEJfU0VHU0laRSBpcyB0aGUgSGFpbG8gOCBQ
Q0llIEFJIGNhcmQuIFRoaXMNCj4gPiA+ID4gY2FyZA0KPiA+ID4gPiB1c2VzDQo+ID4gPiA+IGRt
YV9hbGxvY19jb2hlcmVudCB0byBhbGxvY2F0ZSBkZXNjcmlwdG9yIGxpc3RzLCBhcyBzZWVuIGlu
IHRoZQ0KPiA+ID4gPiBIYWlsbw0KPiA+ID4gPiBkcml2ZXIgaW1wbGVtZW50YXRpb24gaGVyZToN
Cj4gPiA+ID4gaHR0cHM6Ly9naXRodWIuY29tL2hhaWxvLWFpL2hhaWxvcnQtZHJpdmVycy9ibG9i
LzcxNjFmOWVlNTkxODAyOWJkNDQ5N2Y1OTAwMDNjMmY4N2VjMzI1MDcvbGludXgvdmRtYS9tZW1v
cnkuYyNMMzIyDQo+ID4gPiA+IFRoZSBtYXhpbXVtIHNpemUgKG5zbG90cykgZm9yIHRoZXNlIGFs
bG9jYXRpb25zIGNhbiByZWFjaCAxNjAsDQo+ID4gPiA+IHdoaWNoDQo+ID4gPiA+IGV4Y2VlZHMg
dGhlIGN1cnJlbnQgZGVmYXVsdCB2YWx1ZSBvZiBJT19UTEJfU0VHU0laRSAoMTI4KS4NCj4gPiA+
ID4NCj4gPiA+ID4gU2luY2UgSU9fVExCX1NFR1NJWkUgaXMgZGVmaW5lZCBhcyBhIGNvbnN0YW50
IGluIHRoZSBrZXJuZWw6DQo+ID4gPiA+DQo+ID4gPiA+IGAjZGVmaW5lIElPX1RMQl9TRUdTSVpF
IDEyOGANCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gdGhpcyBsaW1pdGF0aW9uIGNhdXNlcyBz
d2lvdGxiX3NlYXJjaF9wb29sX2FyZWEsDQo+ID4gPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS90b3J2
YWxkcy9saW51eC9ibGFtZS92Ni4xNS1yYzIva2VybmVsL2RtYS9zd2lvdGxiLmMjTDEwODUNCj4g
PiA+ID4gLA0KPiA+ID4gPiAob3Igc3dpb3RsYl9kb19maW5kX3Nsb3RzIGluIG9sZGVyIGtlcm5l
bHMpIHRvIGZhaWwgd2hlbg0KPiA+ID4gPiBhdHRlbXB0aW5nDQo+ID4gPiA+IHRvDQo+ID4gPiA+
IGFsbG9jYXRlIGNvbnRpZ3VvdXMgcGh5c2ljYWwgbWVtb3J5IChDTUEpLiBUaGlzIHJlc3VsdHMg
aW4NCj4gPiA+ID4gcnVudGltZQ0KPiA+ID4gPiBlcnJvcnMgYW5kIHByZXZlbnRzIHRoZSBIYWls
byA4IGNhcmQgZnJvbSBmdW5jdGlvbmluZyBjb3JyZWN0bHkNCj4gPiA+ID4gaW4NCj4gPiA+ID4g
Y2VydGFpbiBjb25maWd1cmF0aW9ucy4NCj4gPiA+DQo+ID4gPiBIbW0sIGRtYV9hbGxvY19jb2hl
cmVudCgpIHNob3VsZCByZWFsbHkgbm90IGJlIHRyeWluZyB0byBhbGxvY2F0ZQ0KPiA+ID4gZnJv
bQ0KPiA+ID4gU1dJT1RMQiBpbiB0aGUgZmlyc3QgcGxhY2UgLSBob3cgaXMgdGhhdCBoYXBwZW5p
bmc/DQo+ID4gPg0KPiA+ID4gSWYgeW91J3JlIHVzaW5nIHJlc3RyaWN0ZWQgRE1BIGZvciBhIGRl
dmljZSB3aGljaCB3YW50cw0KPiA+ID4gc2lnbmlmaWNhbnQNCj4gPiA+IGNvaGVyZW50IGFsbG9j
YXRpb25zLCB0aGVuIGl0IHdhbnRzIHRvIGhhdmUgaXQncyBvd24gc2hhcmVkLWRtYS0NCj4gPiA+
IHBvb2wNCj4gPiA+IGZvcg0KPiA+ID4gdGhvc2UgKmFzIHdlbGwqIGFzIHRoZSByZXN0cmljdGVk
LWRtYS1wb29sIGZvciBib3VuY2luZyBzdHJlYW1pbmcNCj4gPiA+IERNQS4NCj4gPiA+DQo+ID4g
PiBUaGFua3MsDQo+ID4gPiBSb2Jpbi4NCj4gPg0KPiA+IEhpIFJvYmluLA0KPiA+DQo+ID4gUmVn
YXJkaW5nIHRoZSBzcGVjaWZpYyBIYWlsbyBDYXJkIGNhc2UsIHRoZSBpc3N1ZSBhcmlzZXMgZHVl
DQo+ID4gdG8gdGhlIGNhcGFiaWxpdGllcyBvZiBjZXJ0YWluIFNvQ3Mgb3IgQ1BVcy4gRm9yIGV4
YW1wbGUsIG1hbnkNCj4gPiBLMyBTb0NzIGxhY2sgYW4gSU9NTVUsIHdoaWNoIGlzIHR5cGljYWxs
eSB1c2VkIHRvIGlzb2xhdGUgdGhlDQo+ID4gc3lzdGVtIGFnYWluc3QgRE1BLWJhc2VkIGF0dGFj
a3Mgb2YgZXh0ZXJuYWwgUENJIGRldmljZXMuDQo+ID4NCj4gPiBUYWtpbmcgdGhlIFRJIEFNNjUg
YXMgYW4gZXhhbXBsZSwgaXQgZG9lc24ndCBoYXZlIGFuIElPTU1VLCBidXQNCj4gPiBpbnN0ZWFk
IGluY2x1ZGVzIGEgUGVyaXBoZXJhbCBWaXJ0dWFsaXphdGlvbiBVbml0IChQVlUpLiBUaGUNCj4g
PiBQVlUgcHJvdmlkZXMgZnVuY3Rpb25hbGl0eSBzaW1pbGFyIHRvIGFuIElPTU1VIGFuZCBpcyB1
c2VkIHRvDQo+ID4gaXNvbGF0ZSBQQ0kgZGV2aWNlcyBmcm9tIHRoZSBMaW51eCBob3N0LCBhbmQg
dGhlIFNXSU9UTEIgaXMNCj4gPiB1c2VkIHRvIG1hbnAgYWxsIERNQSBidWZmZXJzIGZyb20gYSBz
dGF0aWMgbWVtb3J5IGNhcnZlLW91dC4NCj4NCj4gQW5kIGFzIEkgc2FpZCwgaWYgeW91IHdhbnQg
dG8gc3VwcG9ydCBnZW5lcmFsIGNvaGVyZW50IGFsbG9jYXRpb25zDQo+IHRoZW4NCj4geW91IHNo
b3VsZCB1c2UgcGFydCBvZiB0aGF0IGNhcnZlb3V0IGZvciBhIHJlZ3VsYXIgY29oZXJlbnQgRE1B
IHBvb2wuDQo+IFRoZSByZXN0cmljdGVkIHBvb2wgaXMgb25seSBpbnRlbmRlZCBmb3Igc3RyZWFt
aW5nIERNQSAtDQo+IHN3aW90bGJfYWxsb2MoKQ0KPiBpcyBvbmx5IG1lYW50IGFzIGEgY29udmVu
aWVuY2UgZmFsbGJhY2sgZm9yIHRoZSBraW5kIG9mIGRldmljZXMgd2hpY2gNCj4gbW9zdGx5IGRv
IHN0cmVhbWluZyBETUEgYnV0IG1ha2Ugb25lIG9yIHR3byBzbWFsbCBjb2hlcmVudA0KPiBhbGxv
Y2F0aW9ucw0KPiBmcm9tIGEgc3VpdGFibGUgY29udGV4dC4gSXQgZG9lcyBub3Qgd29yayBmb3Ig
KmFsbCogdmFsaWQgdXNhZ2Ugb2YNCj4gZG1hX2FsbG9jX2F0dHJzKCksIGFuZCBpZiB5b3Ugd2Fu
dCB0byBkbyB0aGlzIGZvciBhcmJpdHJhcnkgUENJDQo+IGRldmljZXMNCj4gdGhlbiB5b3UgYWxt
b3N0IGNlcnRhaW5seSAqZG8qIG5lZWQgdG8gYmUgYWJsZSB0byBzdXBwb3J0IGRyaXZlcnMNCj4g
d2hpY2gNCj4gbWFrZSBhbGxvY2F0aW9ucyBpbiBhdG9taWMgY29udGV4dC4NCj4NCj4gVGhhbmtz
LA0KPiBSb2Jpbi4NClRoYW5rIHlvdSBmb3IgeW91ciBkZXRhaWxlZCBleHBsYW5hdGlvbiwgUm9i
aW4uIEkgdW5kZXJzdGFuZCB5b3VyDQpwb2ludHMgYW5kIGFncmVlIHdpdGggeW91ciBzdWdnZXN0
aW9ucy4gQmFzZWQgb24gdGhpcywgSSB3aWxsIGNvbmNsdWRlDQp0aGlzIHVwc3RyZWFtaW5nIHBh
dGNoc2V0IGhlcmUuIFRoYW5rIHlvdSBhZ2FpbiBmb3IgeW91ciBndWlpZGFuY2UgYW5kDQpzdXBw
b3J0Lg0KDQpCZXN0IFJlZ2FyZHMsDQpMaSBIdWEgUWlhbg0KPg0KPiA+IFlvdSBjYW4gZmluZCBt
b3JlIGRldGFpbHMgYW5kIGJhY2tncm91bmQgaW5mb3JtYXRpb24gaGVyZToNCj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNTA0MjIwNjE0MDYuMTEyNTM5LTEtaHVhcWlhbi5saUBz
aWVtZW5zLmNvbS8NCj4gPg0KPiA+ID4NCj4gPiA+ID4gQnkgbWFraW5nIElPX1RMQl9TRUdTSVpF
IGNvbmZpZ3VyYWJsZSB2aWEgYSBrZXJuZWwNCj4gPiA+ID4gY29uZmlndXJhdGlvbg0KPiA+ID4g
PiBvcHRpb24NCj4gPiA+ID4gKENPTkZJR19TV0lPVExCX1NFR1NJWkUpLCB1c2VycyBjYW4gYWRq
dXN0IHRoZSBzZWdtZW50IHNpemUgdG8NCj4gPiA+ID4gYWNjb21tb2RhdGUgc3VjaCB1c2UgY2Fz
ZXMuIFRoaXMgY2hhbmdlIGltcHJvdmVzIGZsZXhpYmlsaXR5DQo+ID4gPiA+IGFuZA0KPiA+ID4g
PiBlbnN1cmVzIHRoYXQgc3lzdGVtcyBjYW4gYmUgdGFpbG9yZWQgdG8gbWVldCB0aGUgcmVxdWly
ZW1lbnRzDQo+ID4gPiA+IG9mDQo+ID4gPiA+IHNwZWNpZmljIGhhcmR3YXJlLCBzdWNoIGFzIHRo
ZSBIYWlsbyA4IFBDSWUgQUkgY2FyZCwgd2l0aG91dA0KPiA+ID4gPiByZXF1aXJpbmcNCj4gPiA+
ID4ga2VybmVsIHNvdXJjZSBtb2RpZmljYXRpb25zLg0KPiA+ID4gPg0KPiA+ID4gPiBJIGhvcGUg
dGhpcyBleGFtcGxlIGNsYXJpZmllcyB0aGUgbmVlZCBmb3IgdGhpcyBjaGFuZ2UuIFBsZWFzZQ0K
PiA+ID4gPiBsZXQNCj4gPiA+ID4gbWUNCj4gPiA+ID4ga25vdyBpZiBmdXJ0aGVyIGRldGFpbHMg
b3IgYWRkaXRpb25hbCBleGFtcGxlcyBhcmUgcmVxdWlyZWQuDQo+ID4gPiA+DQo+ID4gPiA+IEJl
c3QgUmVnYXJkcywNCj4gPiA+ID4gTGkgSHVhIFFpYW4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBMaSBIdWEgUWlhbiAoMSk6DQo+ID4gPiA+ID4gPiAgICAgIHN3aW90bGI6IE1h
a2UgSU9fVExCX1NFR1NJWkUgY29uZmlndXJhYmxlDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
ICAgIGluY2x1ZGUvbGludXgvc3dpb3RsYi5oIHwgMiArLQ0KPiA+ID4gPiA+ID4gICAgIGtlcm5l
bC9kbWEvS2NvbmZpZyAgICAgIHwgNyArKysrKysrDQo+ID4gPiA+ID4gPiAgICAgMiBmaWxlcyBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gQmVzdCByZWdhcmRzDQo+ID4gPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IEh1YSBRaWFuIExp
DQo+ID4gU2llbWVucyBBRw0KPiA+IGh0dHA6Ly93d3cuc2llbWVucy5jb20vDQo+DQoNCi0tDQpI
dWEgUWlhbiBMaQ0KU2llbWVucyBBRw0KaHR0cDovL3d3dy5zaWVtZW5zLmNvbS8NCg==
