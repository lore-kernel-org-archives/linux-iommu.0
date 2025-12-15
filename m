Received: from smarthost4.eviden.com (smarthost4.eviden.com [80.78.11.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A03B8D5E
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792044; cv=fail; b=VonPm7OLPxi3gbvuyu48inIKa/jGDbmyn7eZqCRGEYYnZI2D+QsKCNExgbYVfGRs/QPM7nE0EPLwO3w6gRJN6GB5di4WxGo4jRW5UVTI7u4Ozr/QYKAJm3S90Au6xdNHl9jaXrFGFXI15h+Sm3lsaOvPzwEOGWNSnTv2ztH0AS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792044; c=relaxed/simple;
	bh=6/JVEHGjoeKclQtgADEoiGR1xfBd7R4/gAdFbd9tSzU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a5GirghjY81hMqZ8O01JWOUeXH55pzQHDoWXsMhJjpEUKrklofy+D5nAKCL00lvevfVif/hNZa53hf5zFDHwPIUC50+w0RTZ6PlWMD7zBDppEQ7lu1b+aL2pkicScHaCOLPPmbyVt/EvGg5nhz4NGXrP9WopRZkvULtl16a8YOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com; spf=pass smtp.mailfrom=eviden.com; dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b=LbNm7trp; dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b=W+/xmShn; arc=fail smtp.client-ip=80.78.11.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eviden.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b="LbNm7trp";
	dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b="W+/xmShn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1765792040; x=1797328040;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=6/JVEHGjoeKclQtgADEoiGR1xfBd7R4/gAdFbd9tSzU=;
  b=LbNm7trp+bf5pxfGcZQe9Xh2h9GA3htFGAD65skjcsMd1lzppgBWozBp
   yYv2gFneefzpN5t2NfGL0t72HlVZFxqeyJFn4kkAboX4PEMIIoK5qba0t
   Maiu0u/E074eBY+XK6TZPFZ+spX7o2ViVGtr//RuuVElAu2Z8ovp+ChKE
   VcPK07/h/PwLj4dKhxh+HcRJHdFn+jcbToNF4Z+EhIDp2y2hKGuwHcs/k
   LbSQIWLcCXz8dt2FuishwjyvWQsmesJmtNdpuUCLBuk8YTcefWOolsCRI
   nGVDYxp09hiRPFKt115f4Kn6Xuc+f7y5YVNk6piY3VJcdNefrCjkXqJTb
   A==;
X-CSE-ConnectionGUID: KRgnvq8IR2atV+P1kRfomQ==
X-CSE-MsgGUID: kBAVp2scRQS1bkkkT66uQw==
X-IronPort-AV: E=Sophos;i="6.21,150,1763420400"; 
   d="scan'208";a="47414848"
X-MGA-submission: =?us-ascii?q?MDHuMqr0MQtMdUnn7UDFHD0F8a5g8KlL6l+xn+?=
 =?us-ascii?q?ACF64+lpYinOceLEedmfDSBG3AVIXe1cqUNTMyUw9eLfTr+4n5Tvenuj?=
 =?us-ascii?q?X7FN0MYPiXlR+8Fl3pauaCXD7ZIi7D65EQ6ZrU+ol0KrC54jrqJnZM/j?=
 =?us-ascii?q?rO4LWmhwFx/UpV6Q0U7JT7OA=3D=3D?=
Received: from mail-francecentralazon11013025.outbound.protection.outlook.com (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.25])
  by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 15 Dec 2025 10:42:08 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wB+pXQuULmyi5pHf4x+jtza0wMeo4NLoxh2jjwqXZhaBnlmbG7zRd68hqqsr5bViYVveEzLaEC3iWnLOd0ejBKZiwQIgUdVAG+a/wR/aG+HsQnVnJMFTTzPQu+lAu+bsVX4m9GywRpIegaMgrZNWiPDEcIk/pIRxCDsdq38sMvz3+RLTheY97JMVu0CmZqisd5SkIDRPvi7kfLMS8wwX1dj5T3XXWbSgeJrfTICNaTSmSIXMSX1jfzMtddBZr6bYrgJBP25/5pQUIPu7hpc4ahBLboCr5QRwhu+0tQazpR0wuJsjxStABmSm4LyVOyP3BVT9DF3zMxeNCUsWCnz2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/JVEHGjoeKclQtgADEoiGR1xfBd7R4/gAdFbd9tSzU=;
 b=lV8REpyiQIOqEdIHO7opXeAWVlIPAtugRVwLyRjtVjKUFFkSRm583/VSd0L6jQi7lQ55lS9ZSvtLkWBNP1+Wi6fdO5RSzzQFJQhUWs0hCisAoymYzm2TYsitEjczRQmFQ1Hek2yICDurS5aWSK3ZDefEEf59WUqkT4b1LYnfayAXah0ezoAEwsgX5troiplQWX45W+o18BIBWUz4ujgjweG4wZH1yBys5DkEFkDFhrIFdBpTTaB68CDShj+AdL02f534gopv6aZ+uRrwy0qNjUPZcm42cqT4VflcIT48MQvl0pWMy8rjk19jOwjo9ro2QGT/AIwJNiMKrmbodmYXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/JVEHGjoeKclQtgADEoiGR1xfBd7R4/gAdFbd9tSzU=;
 b=W+/xmShnFnqZlXOI2y50ssFuiNIrccIQ4+hJk6QXkLm0Z8PbNCDLWUmX/IUxr5GmN9dL0/hVpKTH8vT+iMrhxJA6pwQQYCS8eywrx0OGu+xsZpzQHDCh+3On2+35DTBq1b0wo4ODkn8ILlZ1NQR2E7VsgYbT7/mR+yf0S0v0Q/ZxepyxBjoLIhsf0kds6O6Sy7tNsrubutWo7ZUBsYqVnBXEUt2fq2SKoAFbQiHT8SwlaC1psCPYHhFkHaAAvlswb2NBlQG7Sno4ZP+OXVR40NajZ82ulCsNaqqDRXACgwn2mSDxz1k38OAFUZisMbx1hYfKf79KZyC/ATUySvdx4g==
Received: from VI0PR07MB10691.eurprd07.prod.outlook.com
 (2603:10a6:800:2ba::11) by GV2PR07MB11176.eurprd07.prod.outlook.com
 (2603:10a6:150:2b0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:42:03 +0000
Received: from VI0PR07MB10691.eurprd07.prod.outlook.com
 ([fe80::d426:820c:9ccf:a61b]) by VI0PR07MB10691.eurprd07.prod.outlook.com
 ([fe80::d426:820c:9ccf:a61b%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 09:42:03 +0000
From: QUENTIN BOYER <quentin.boyer@eviden.com>
To: "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Userfaultfd and SVA
Thread-Topic: Userfaultfd and SVA
Thread-Index: AQHcbacReF9g+jq1e0mqJcewYW5RHg==
Date: Mon, 15 Dec 2025 09:42:03 +0000
Message-ID: <DEYOXAZNUVTM.1IUE1CLSKP26J@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB10691:EE_|GV2PR07MB11176:EE_
x-ms-office365-filtering-correlation-id: 7f0690e3-dd6a-4a23-641d-08de3bbe3417
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzlpdXF4eGpubS9odHJSdTBnampXaS9wWDUyNGpGYjRlZUhDKzdLbDBWbmdv?=
 =?utf-8?B?blB6dnRKb3M5Vkh6S2pJcW9LSVJ2bDNJakN4Rk9BYklvQVd5T1poNUE2T0ZM?=
 =?utf-8?B?azRmUkR5Vnk0OFNKeW5VQldaSEVHWHNkWFVpV0Flbk94ZzlrRXJiN2NqZVNG?=
 =?utf-8?B?Z2ZTcFRGdTBDd3owL1JRckF5UWFleWFtMVFOK3lpWFJwdTdqMDMvdDdtQ0tV?=
 =?utf-8?B?TU8xY0thcyt6VWlmSGdpL2E1OHE2QmhHNkFEUWpjWFdINkxJenlORzNlOEtS?=
 =?utf-8?B?SVNuVHVSVWVNZVdtMUZvYUpIRUVxd2lqSEdVSEFIdE1obS9VdGtabmlwdjhT?=
 =?utf-8?B?VUVOTDM4VzRiNFR0L2VjMTU0dXBmaldXYmxXVzhQZG81TlA2SmVwTkcxSVcx?=
 =?utf-8?B?M3JsUWVTV0hvV3d6bFJPaFBjMG5aR040T1ArMVBvQVN4ekxLeHBKd3Bmc1Z2?=
 =?utf-8?B?R0FrV0wzaWR5b2I2TFV5UkVrWnE1VTBoZmViNldHTE1nQmFEbDMzSVFmTmNh?=
 =?utf-8?B?Ull6R0dDNCswVEVsc0ZROGdseTZmdVZPNE5uaVhrUkNlTGNjMVFTdmhFdTA3?=
 =?utf-8?B?V1ZpOGhDYUJUOWNRQ0RFYWJNWFdNb1JXZnRudmJPbzI1TXFQMlNWamxWOXpr?=
 =?utf-8?B?U0hSdVZJNEZkMFFHeE1QRk5WdzdUN09BdzhYM1lwWCtpRWYwQjNadFJQMWpB?=
 =?utf-8?B?WUtuQUpPSHJETmE3VXFvb1diYTdZSmYrUTJ6YzJpYXpleVNtdWhhSllXSHk5?=
 =?utf-8?B?Z2pmRWI2anRXMFNvTENHOFdzOWJmTXZtQVZpK2lDWGFvcHVMOXBJWHZSUEVX?=
 =?utf-8?B?a1hIUXRUb3d1Umg5NnZyWjhzM1FNSVRtWURqeWVIQkpMay9abFlJN0NQV3Bj?=
 =?utf-8?B?UzN4QWVzTERtOG4zcmVIQVpKdU0wb0RXSG1xbC83MnQ1NkVQSFkxV3JnaUdC?=
 =?utf-8?B?R0F0MklqWmJYSXZtSmtDdWFkM3RRY3lmc0U1WjlsVFp2UjErNlcxYmNlNkJH?=
 =?utf-8?B?MnZzSTFYT1kvckdlWDlINWZkQ2VGb2VLUXozY2hNeEd2UWExOXRDcHp6T3l5?=
 =?utf-8?B?RHB6MUZvYkxxZE5JbEQzdEdpUHZUeStkWXdSNFNvV3RUa0RFOWJiNWFxb2Jp?=
 =?utf-8?B?MmkyWTBic0RaYTZzWWozWjdoQWdmczBhRFZDaWExMVF0VEtpemVVTjlDUjMw?=
 =?utf-8?B?NElKOWhPUThQUTRSR1JldzdCTkZ3OTAxOW5TNzZnaXdOQkYvOGFPRkJyQjd4?=
 =?utf-8?B?WVc3MmRHVnNuTG1VQjVodExweWRhVVdlaGYxT0RGZmd3S1Y1d2x0UHdPOFJk?=
 =?utf-8?B?NVQvaUJJbnc5ckk0UDcvOXh4dlI3djlndk9UNHovSnhYVkpNaDBZRXBGK0M2?=
 =?utf-8?B?NEdWdEhEOUJ2Ymc4R0YySTAvay8raGh2cjQ0ZjBESzBwV0NQeG55bUxYOTdr?=
 =?utf-8?B?UHhqZVJvZzErSkdtdlhTeUowZUg3UklLV0QzSithM2dPUmtCZmtPWTRBbjdv?=
 =?utf-8?B?MWYvMEVWSUxyTUxIZnFwMzVEbE5XR3hCL2FwRlBtcWlPVmVwc2RsMzhJbjha?=
 =?utf-8?B?cWZtS3ZKZXJJNS9QT3lCVllsR1FhaE5iR2dEazhGQ0gwdjA0M1orSDcreUVa?=
 =?utf-8?B?YXFEc0xVL3VJTjIzWXZweWZwS29XV2R4cXZqN1FwYWsxeU43S0ltWkRrNUlH?=
 =?utf-8?B?aTA4UDVOcjhFRmduR2tnSGNRckVPbnY5eU5lUnNKM24wdFlyeTJEMStoaXdO?=
 =?utf-8?B?clR0WUlhZU9OT2FheDEva1NjeklmV2o0MWsrKzU0MzlaemtRdnNSVU1KQ29p?=
 =?utf-8?B?VUkzUklqTFZOR3FYaTcvVlYwMGVxcXB6elBoRFJ5dXgyZnlmbjZodmdubGxi?=
 =?utf-8?B?TlZKQ1BTN24wRktXQlpJajA1ZU1mWlc2QXR0U2RadjEyR3A1bURPNE52Smph?=
 =?utf-8?B?M2ZDaHZHWUpINDBFdlBqdVlaSW1ReGgwaGJTeGkzRUxYckxGQmxNVW51ay9P?=
 =?utf-8?B?d2JqZy9MRkRadUY1TFFiUm10N2w4clVDYzlqOUlocEEyZE9BTFp4TVVMeXdN?=
 =?utf-8?Q?//tosN?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR07MB10691.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjRwR05kMHVnOTkvT2JRNllLZFUxNm1UV0RGUTRVUUhibUVzZVdPazlrRGd0?=
 =?utf-8?B?dlc1a0k2N3NzeHRVY2loTkdyWDUwTHQrUUd6T2tUa2RRcGg3L284NkQzbElh?=
 =?utf-8?B?T0R4T21aazJVWEFLOUNmWFdULzlqY0I2VlJlellCM0dIeVIzdVplVk8vT3Z5?=
 =?utf-8?B?b01pamgza0NQZyt3S0ZINWpuWWxZZmdJYTNvR08xRlhkbUg3WW00aEtzVUJo?=
 =?utf-8?B?NnJqZzZkaEdYSXpoWm5jUW4zQXdjaUQ1WURiY0hmYUxFTTJIU05Fc2cvaUNq?=
 =?utf-8?B?b05IUTMrcHdKSmk4a1hnZTZzUmpkYlJ3ajJuYUtyK0tJMkZHeEpWSHdVMnZ2?=
 =?utf-8?B?YWNDdmwvdkQ0MG5hM1RuRzNENXRIMkNINzlKc2dNSFFKQXp2ZUhWV1JyNXpP?=
 =?utf-8?B?VUFoeEExSGZjalIwWjliejRUWUJMT2dxbHpiN1BIOGIrZ0p1L0VPMUg0U1oz?=
 =?utf-8?B?TnROUWV0ZDdzTGdFWUJibjBPZnduenhjc2FVeis0bnArOWhYZWREV2hVVUxU?=
 =?utf-8?B?NkJIbjJWV2pJV1Q1YUhVNDhmVlhYdWtHZ012dldBREVOdHhDc1JIVzFKNDdp?=
 =?utf-8?B?djhYb0wzQ3l1ZGJwZEN0M2xoTFFST2Q1WExjcWxCMmdGeUYySTRjMXBacXl2?=
 =?utf-8?B?Q24ybURUbEtMUVlpZVJBbHpoM2hyenpkQXRvU2NSUWhJYnZBZWZQeHJHcTNT?=
 =?utf-8?B?NkNVb3E5Wkd2dk9pNGhEakZZU3hKT1VPMnZGV2ZJcmFhNnNLelltRXlvZ2Jx?=
 =?utf-8?B?L3cvbkoybHJJVXFCZHczZWhUVkM5ZVl5WUlHYk1ld1JyUzdRUXJuS1FFWnNH?=
 =?utf-8?B?d3kydGlEcHR0bXJWdmc0Sm8vcWFXZGNkaXk4T1Y5TjEyeVRJWHpTNmlwN25y?=
 =?utf-8?B?b0pRT0ovMUJpTHFMRjBjM2tDRDlsUTU5VlhBZUllbkxSVVJIQjVXcEJBR21M?=
 =?utf-8?B?NU1tTlFPR3NZQW9VZTd0eG9CYnp2cG5HbW9tZzE5a1R6NzJnRXlkZ3BaQ0lI?=
 =?utf-8?B?MnZFSmFNbW12ZjJFVC9uRlN1STVXWmtMZUl6SmJnYVByRmtURHBTL3FpelNP?=
 =?utf-8?B?c1U1QzdOOUdUamVnQlhPUjIraW9aMmRtSnZOZUNIMHRyMkIwcCtsVzhtVFV2?=
 =?utf-8?B?V0wxcGVWdjRsMlZsaFYwSDlMK2dZcFJ2KzFjQUpqNWE1dnN1RllVNFhJQTho?=
 =?utf-8?B?dGl3eDNHTG5lZm5hRXVkc1dUL28xVzBiTElqeU9XQXZtYi8zWjExVkZxLzhG?=
 =?utf-8?B?YzdWdEc5VFlxZnV2TVJVYXpRZkhHSDgzeGtzVkpUaG8wQXpQSERIWk9EUUlQ?=
 =?utf-8?B?WUpIUm1HWVVIdWIwRmx6RDVCQlYyemxNRDlqS2JhZlkrVndoQkJOODZpRU9C?=
 =?utf-8?B?NXUxQ1FQUnFmb1c2NXlYbHVIb0ttUmZzdENON2ZSbVFTUGFHTkhBK1QwTVlB?=
 =?utf-8?B?eUk5Sjl5YWo1aVdaeGROeHRZTWI0Y29ZVzhHK2xNb3ZsMUcvQUMrNEYwbG9L?=
 =?utf-8?B?QkkxYmlZWWdBY0tGNGhHSi9jdnNRa1pJdVMzZVhiaXp0bmkrYUJLTkxQcXFF?=
 =?utf-8?B?SHYwS3ZhZDBuLzBCYlhRVjN4M2lDb3BueldXVVRXb0dCbkVUQitVbHlRMHp2?=
 =?utf-8?B?MnRqVFJqa052QjQzREo3ampzZktuWksxWml6N2tsTFkyaEFQUkMwUTJRZ3VQ?=
 =?utf-8?B?MzRoZkZTazJUK1E1S1lhZVVWMENidUZSais3VHdGd2I1MGdDY2lLaUdFd0Yv?=
 =?utf-8?B?VDB5THVEQWljek5TL2g0QWVHb0k4Nml6cjVjVXVCTC9CR3BOaTFDUlB4a2dN?=
 =?utf-8?B?TzJjL2NxOXVOblR2cDZob1hVRHhzWHFkSlJRL3RPOFlLMVZORGFsWk5qdnkw?=
 =?utf-8?B?TEk0RE52WEs3d3ZDbEVZalFFdFBwcWpUTjAxRDBuY1gxaGpxaUVYdllEZE5j?=
 =?utf-8?B?VHhwVWo3Zkh5bWZldlBybkc2bFZhbVRqREtQZDRFWEFkTUFxMHAzK1VXdVlo?=
 =?utf-8?B?alVjQzU4MVZWZDUwUHErdzBxYWQ3dmNRTnU5cVlyM1ZYbGFIWXFVVmVjQnVz?=
 =?utf-8?B?dG9uYW9Da3JYeGhLYTJtNkNxSGhYbFEveWhJRHZCeWJoS2k4NGZqM2p5aEZY?=
 =?utf-8?B?a1p0d1EzNUR0T25lNEZ0OVRXaE9aWk5DMzhvaHJsTGV6RHFnRUcyVENBSUoy?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F292F9E1D1FD94596AE8918A9024803@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR07MB10691.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0690e3-dd6a-4a23-641d-08de3bbe3417
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2025 09:42:03.6893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i2qcCuiT6pIPTL3c0RpW5EEwsGbIJLHbP6lRobtW3SUEqCrisG3w5XysfGDRVkgSG7K5gB40NDx082V0nCCwOSpJUvP+7x9a4xGjbk2xekc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB11176

SGksDQoNCkkgb2JzZXJ2ZWQgdGhhdCBmYXVsdHMgaW5pdGlhdGVkIGJ5IHRoZSBkZXZpY2UgaW4g
U1ZBIGRvIG5vdCB0cmlnZ2VyIHRoZQ0KdXNlcmZhdWx0ZmQgbWFjaGluZXJ5LCBJIHdhcyB3b25k
ZXJpbmcgaWYgdGhpcyBpcyBhIG5vbi1nb2FsLCBvciBpZiB0aGlzDQppcyBzaW1wbHkgbm90IHll
dCBzdXBwb3J0ZWQgYnkgdGhlIElPTU1VIGltcGxlbWVudGF0aW9uIChJIGJlbGlldmUgZm9yDQpl
eGFtcGxlIHRoZSBmYXVsdCBoYW5kbGVyIHdvdWxkIG5lZWQgdG8gcGFzcyBhdCBsZWFzdA0KRkFV
TFRfRkxBR19BTExPV19SRVRSWSBidXQgSSdtIG5vdCB2ZXJ5IGZhbWlsaWFyIHdpdGggZmF1bHQg
aGFuZGxpbmcpDQoNClRoYW5rcywNClF1ZW50aW4gQm95ZXI=
