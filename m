Received: from smarthost2.eviden.com (smarthost2.eviden.com [80.78.11.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA16C1FBE8A
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752222438; cv=fail; b=S5wvQZNfaqjrk8a3CpQdHYC4wPyYfQrTkqLJgrKQLI8H8Wom53iYB5A/dxFWL+ByjlBzF9roHpo+R5dZ3lf8Rs7hw+0WIvgOCw8T6RZXkYm6O+rtJ4z5VRtnki+oEBywsU/gUqmPrn0A9x+cLmqu1C20e93nABBLU3/swbdn2gU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752222438; c=relaxed/simple;
	bh=CEdy7sR4jXBMjmwkqrLV9CJ974O/WzB6jj2+ZwRgKaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IgZr5JsJETOJY3Td4P4hMUwGijsBP3WbEN8YQYK3NKTJzqB2iUTYJlSZoZFgIgYiwuNG6WCcrcGdLCsbAaKXIXb0hbNu3YS5k2VhZg4CFIVPxrClwarr0Xtt1A8NRb3+Vkax5o2Ko5QapxR0RC67usStG1CEhhOL25YWZM/xZ80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com; spf=pass smtp.mailfrom=eviden.com; dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b=KRRayKiL; dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b=G97IStUe; arc=fail smtp.client-ip=80.78.11.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eviden.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b="KRRayKiL";
	dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b="G97IStUe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1752222432; x=1783758432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CEdy7sR4jXBMjmwkqrLV9CJ974O/WzB6jj2+ZwRgKaw=;
  b=KRRayKiLtB+lCWkJrf1qrIiRR7hZzqifmj/7pEWZQkFNQIDfmnVXALiM
   zueERJYWjD5mfr8AmFDeqiaNM6TrT7FxhgjHE4GPefceVJwF/u6NtJUJH
   tHHZVdJypfFmqxj25CqkpFvFd4Odi/3N2h2/JamdOmFkXezAdOP81GUlT
   fti/LPnqDRrGj2ZDQVXVfBa4hM6bL5VuYcyIP/YE3zi5EWrUA2mElp3YZ
   OHdLWQ1HOIVLZLqXeWKkNhsXKXBF6MYTH2T37dZ7h+CnEp5wEtL1bwup7
   9YhcgMaPQcfFzAcbAAj8J2CnUp9rJFzN2vsWUXCmoJVFuOwotmyRi8D/1
   Q==;
X-CSE-ConnectionGUID: dUCzqHCjTHi7CZ+ezf9l4w==
X-CSE-MsgGUID: VSGRSjieSL6CJ32OL0lDzg==
X-IronPort-AV: E=Sophos;i="6.16,303,1744063200"; 
   d="scan'208";a="40180683"
X-MGA-submission: =?us-ascii?q?MDHjQJPWL7G5KtoRjfaG0PJXXH2a271j7d/S5C?=
 =?us-ascii?q?y35dqCG1/u6eqBPJBynsaPZx0eVYqyso2mD67BxpBXV9wYTTyX2PYtS9?=
 =?us-ascii?q?sepRJr8UeU093+roHclU4tIwXIcc688ykbn4GFTwM7nsOq1I39MdZUwY?=
 =?us-ascii?q?d/KKYjFGAKL7co+MaASUsPzQ=3D=3D?=
Received: from mail-francecentralazon11013044.outbound.protection.outlook.com (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.44])
  by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Jul 2025 10:22:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxPiQw59mZr6E6krJ6XiX+DWT5p1Z/WlreilP5JGwF9yh/nKdZ/BiPYdx7hnV4yuOZpmiRA2YNzxRgp5X2wczYVCMNobAuzV4ng4kz2ON6WHybXFWD5luh5hpAMmb3plSJhC1qW9bm+z1Xfz6un3npIm9iNfz4/0KhY/hwr36GGd/DBvikYUvT4PaRZG9PMlF8HEGTZQsAyA0o45kowOcn2CsZWqOWfAh6ZrpfwLWIMRYmK4MwVvmLQrlil7gu+Gy3/AH749ckC4tZkkVXiBi5p0ISTpLCFhvofS/uJmvpzBW0bx+F+9YcuN7vstYO6iuuUmKIHo4cd1bTcqoCLifQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEdy7sR4jXBMjmwkqrLV9CJ974O/WzB6jj2+ZwRgKaw=;
 b=tlyn0iRhCr0njQm7wykNEX2JVqaE5lGbPlvW7Zy+URxKekHJBvdHfgwFA/Qzu6hPCS+rvYVzvYTd2tW0L2vzYDRkD47nAqxaJ9K6TZBO3Mojfd45AVDL6rLWCFrDaILzNAv6b33UOBKoKqPBx4fODF2lxyQYsa2Z5mPIkD3SSM9hShexB3YIm25bkHziSRq49geF0Yjah6SQx4AVkhrY0oRexnAqcwQLYM/lRM/A7yglMT/cQPuXQh8GaAujLvjR7E+KologetukWJ5O6rFacfwTMWdF+nk9UzpaOUfOTG2FgkEdFXLAIwKBkn5C8kB6rsmt8BLSIcTCNfb2C6+rTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEdy7sR4jXBMjmwkqrLV9CJ974O/WzB6jj2+ZwRgKaw=;
 b=G97IStUeeZlBGA2L47lRgGML/hVVh+RsDfkt+MdH9Iyysv7a5wRPCJWWYyE+B8DDvJAmzB+ufXWqq2Amx83MfSnf5thJZCgM7li/CwRqE1Q6ciwyJ4xsFt3UB6N4EDWKP/7LmWzrofQnv+gnClTtMqSV/WYDl7i3PkFUAZgO1bujWKSdbXVXJDplIsTNAKGiuUkmPruZfGqIrr+fdFGga1yGe/CeYp20VVabt5gT5dWb6ROgnDYBjaQpDiLT18nATayFXtg3M2HnccjEJPcc5HzO1n0hKMjIop3vVrk+ugrqFaCFeSYMMRQVbSY4Ewaavklj7DzWVXhSMNBh1k9BCA==
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 (2603:10a6:800:2b4::11) by VI1PR07MB9423.eurprd07.prod.outlook.com
 (2603:10a6:800:1c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 08:21:58 +0000
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5]) by VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5%4]) with mapi id 15.20.8901.030; Fri, 11 Jul 2025
 08:21:57 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: David Woodhouse <dwmw2@infradead.org>, CLEMENT MATHIEU--DRIF
	<clement.mathieu--drif@eviden.com>
Subject: Re: [PATCH 1/2] iommu/vt-d: Fix missing PASID in dev TLB flush with
 cache_tag_flush_all
Thread-Topic: [PATCH 1/2] iommu/vt-d: Fix missing PASID in dev TLB flush with
 cache_tag_flush_all
Thread-Index: AQHb8FIX+VwT35YevkGxfPjX/pFNPrQrER2AgAGH+oA=
Date: Fri, 11 Jul 2025 08:21:57 +0000
Message-ID: <2125ee10-7b23-4890-a80c-d561ba06f23d@eviden.com>
References: <20250708214821.30967-1-ethan.milon@eviden.com>
 <015a0eba-d26d-4565-9cbb-d4c9e700501e@linux.intel.com>
In-Reply-To: <015a0eba-d26d-4565-9cbb-d4c9e700501e@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB10776:EE_|VI1PR07MB9423:EE_
x-ms-office365-filtering-correlation-id: 0afd6c1d-ce31-4b45-448a-08ddc05400a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3UzWFVDQU8wK2UvTEt5ZVIxY1FIQUtxWFVWdk1LeEQzWEF2Q0lSSWp4c3VU?=
 =?utf-8?B?SHR0K2NtdmoyOHlSVWU3SWtjNWpxRmVwSWZ4akM0U04rUFZZZDIyNlJVMS9H?=
 =?utf-8?B?WXB2WkpkSFhTbnh2dFVhOThwSktUOGRkUytLRmQwUjZtNkdjUHV5RTNkZlJx?=
 =?utf-8?B?UE9NOTNycUJzOWsxeWxCS3lRQXoyUktOek8zV1VoRk0wc3RqTGtVRERFZ2ZI?=
 =?utf-8?B?Zi9EYnRPcUY4endNYmp5NjFMK3J6Z29GNzBscDJqMXUySUhYejlSeUFtTGY4?=
 =?utf-8?B?NGZGdlhZOGwwTENMaWRtVkxUL3FZYUJFbHRUMnRaamxpeG56Mm1ya2c4OHRN?=
 =?utf-8?B?a0VmZFN1dzY4L1gvR25XWlZvclF0MjJXRkUzNUpjRi96cFJoeExERExjTHFw?=
 =?utf-8?B?NGhob2Fybmt1ajQxL3dNay9DWElsdWc5SlJ5V2NDWEtTaWZUbWdxWUFjeGhi?=
 =?utf-8?B?N3YxaW5IcW42QitTdkdraUNiUGlkS0RLdlhIM2t3SEJkYklCc3c1UkhvUXlJ?=
 =?utf-8?B?NnowZG9ZdmVyT1RuRUEwOW1DYysyY2JFV1IxSTRKdEdPYXp2UHVGS3FDQ0c4?=
 =?utf-8?B?bG11cThsVGFuVXh5V0VVcnZ0MG1ia0dpYzlWNnZZMS9LWm5NNk4zViswUmtJ?=
 =?utf-8?B?WU5jcEYvRUhnZWowTHNTbU9CRXFoSGI0NGtnRjBaNWpiS1BzbG1FVkx0c0Nr?=
 =?utf-8?B?MTFRN2dpVmF1NkpSdHdqM2xvTWFNQU9KdnZPNUNmQU1IcFkrSHhSb3Nlc3VJ?=
 =?utf-8?B?YnNWeFVib1A4UG9ZM3NnN2t2OGZUQWJkcURnYTFQZE1kTFFLOHVOb2pkdkJ0?=
 =?utf-8?B?aHhWdE9IRlhjbzkzRWhXTjFmQ2JIbjVtNTBJSFN5ZFFMTmpzVEFkRHI1SHZP?=
 =?utf-8?B?ZTA4TXVZRGgvbS9xeHhid1c3ajJYYjByaU14NVhSTWRCVy9sWEI0WnJLWkU0?=
 =?utf-8?B?N29SSXAxVUNnRjVWRG5kSE9rT3ZVdURDRWE4amkvUXlOY2ZoandtZlNTSW03?=
 =?utf-8?B?OUcvNUpZWFRHcDdrYjlvSXlYRkVFaHFnTU9DU0h3UmFSRUZYSDFXRmNzRUJN?=
 =?utf-8?B?YVBWM0dWeU5mdnlTOXB0a3Z6Z1JNaXJoMkM3Y2ViQnRTU0ZGdlc2cEJtZU1s?=
 =?utf-8?B?dDhRNk0wOEc3ME9JWG1aN2Jsc29naTZoWEo5NzdWYzA3TjhzbnJQdFNiYWtP?=
 =?utf-8?B?UncyMnN2T1dhVWNYVkoxUkNSVUpKSUdWOWkyUmlTZFZwdGQ4TER2b096cUhH?=
 =?utf-8?B?VWVJU2ljSVZSNExEaW00Z2V4dG8xa2tBSDB3dHI1aWN3VUpEbXEwM0p5Sm4y?=
 =?utf-8?B?MzFkWk5MY3hwa081QzArNHh0NFNSNlppeXlHZjF5cExyTGlBeXZjSVp5K3h1?=
 =?utf-8?B?dWVCRlIzZ3lLWG9YSVBkQ3M4V2xja0hDVmNrVDA3QjdTenVwaDBPaUduOEc3?=
 =?utf-8?B?LzFEQXE1OWRMcVJJVERFWVNVbURsLzM0ODUrdTRmQnVoNGxyaDQ3aUZxOHM1?=
 =?utf-8?B?Z2J6Q09yNWtoVVFZLzEwVlF2dkpJQzBtN1lIcFI0MXlDQ0hBSERsQS9VT1Fp?=
 =?utf-8?B?b013UjFCNlU0aWpaNmZ4L3FwTEZlOFNCMnJ1V2hnYjFYYVE1SEF1UER4L1lX?=
 =?utf-8?B?Z0pBKzB5eVAzZmdxeUdocTR3YkYwTzJSNG9lNVZ6WnZvbzErazF1QlpQeHVP?=
 =?utf-8?B?OWU2ZHltVTlJdW5rK1NKTDJPaTBHNGVOVWZwK21QeDJvQW9JS0x2Z2dQaWFM?=
 =?utf-8?B?WDBjM0xzVVhOMERPTS9qMFYyeTd2RWl4cXJaSnJSbWpMOStJSjl3cVpaZzJt?=
 =?utf-8?B?Um1Zc0tZWWFqSjlHRk82YS9GOUttQ2VGZzIwRjUzVmJPNkNrWUtuQXl1dGNF?=
 =?utf-8?B?SUd5c0FKcGZndElOVFhHTUtNcmFYd21LSU9yRUZ3bWdETDhQdDRQcngvUmRI?=
 =?utf-8?B?d2p0Z0hYVUxnUjlGZ09wd3dxbEx1b3F2dTJhdzF4dkptRE9vU2JNbmgxZ1la?=
 =?utf-8?B?Yjlub3JSczRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR07MB10776.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDZFQ2pSQlAySEJ6UDAxZGZUZ25xaUptdENIWERvc1BMSElnWGdzRW0zRHg3?=
 =?utf-8?B?OFkwMW1ybjhzWXFjL0pnemZVTi9XWWlOVnNOVTVZaTRkcHlIRC9QTEEyZWRz?=
 =?utf-8?B?TjFnUWVMT0J6M3R0WFpQYzJnN1gwSm05d3g2dXR6ZFRrYnhUVGw4V0taanFm?=
 =?utf-8?B?bnJlQzRMUTl1S0VGRmZpa2ZUM1JTb0p4bkpwMWF1WXJQdENHSmh1cEsveGkw?=
 =?utf-8?B?RGVXY2NVYUVpcUdHYTRZaDl5S0VFSkZaTWlDbVd4Y3VuR3dNbHcrQldLQ0ln?=
 =?utf-8?B?TTlzbVUrTldTdWlqd1dTcDR1NjloazlVRGIvRkExWVUrOWtFM05OdXBxK1c3?=
 =?utf-8?B?WElobEdRclI0T1QxemNXVDcrK2lUb0ZId0dCekIxTUo1MHJ0cTNSSldNelBy?=
 =?utf-8?B?Tm9JVUJORlVVSFE2K0ZUS1Y2ZnhUQXI2WHAzdWtvTEFkcjUvem9TYkRSdHdv?=
 =?utf-8?B?aldoaFJHWk8xTHFpWk96MlNrTTFZREloanhyaERpL2RaclFJdGROZnJhZmFM?=
 =?utf-8?B?MlVYeVBpUEVpNnF2U2c0eDhiVmRsSW5WalF3c1gwM2RCQkxDQ2ZtazVWNWtp?=
 =?utf-8?B?M0JuaGpJSmtDbmZpa0F2dEZ6NGkxRmRjdWdEVXNPRUdySTZKS1NDQUlycnhO?=
 =?utf-8?B?dW1JaWY0Z0xXbG1OaVo1ZlhwMW9kNXNDNGI0L0VjUVpITmdDazMrbFVidnU1?=
 =?utf-8?B?WjBQdFA3YlZ6Q0RndzFyaW9uQmYzamVyNVlIWXRPTUxabzZzbVBBTi93Q3ZJ?=
 =?utf-8?B?OHE4RDQrUDU4QWVUUzJRODNHQk1PZVhjUGFsOXpTTDBrSVBGTlduaWpZbno3?=
 =?utf-8?B?Qmdnc0ZqUGR6NlEySUIyMjRwK3haQkVJdW9LUS8vYzlycHJYb3VwelZQQ2RG?=
 =?utf-8?B?RWg0bVFDY2NCTXpoOHBOL25PUnpXUUVlR0NpOUc4ZFVxbDZucEQzMDFCOTlT?=
 =?utf-8?B?bmFYQWcyQmQxMVJzdmVxblZ3ZENwVHl2Y2Rac0w1RERRM2d6Ti85RENGa3Fr?=
 =?utf-8?B?QitjdmJOTUptYnEwbGJneEpJQ0hXQUg2LzBOdnBtWUFHd2VKd3FldlYyZEJO?=
 =?utf-8?B?TVBvdjMxb0pjTlRFMEFvbVk1STkrYzZmNlZxNERSOHhtRU9EV09ucjRGdHRh?=
 =?utf-8?B?NWpEaXVTdWVhdFJFaGNsN2NoVE5HSUtJRFVKOGtUaXliTU1paGdtNGtsdjlG?=
 =?utf-8?B?UjB6NElMNXJvWTJvUmUzcjk1dHplR1JQU1NYenBBL0hhZkd4OWxscUFBNHBK?=
 =?utf-8?B?Zm9Eb2tkN05FMGRxc3luYWJIQm9QNnlsL3ZETVZvdGJuMVZid0tRelBHbkhj?=
 =?utf-8?B?ZTduQSswb3F3bjJpSzF4Z0tGZjlMMi9WTnJUNmRxZ0RiNmZ5bUdYMCt4bDgy?=
 =?utf-8?B?NGZ4U05UWmlQcTMzVERiaFk4bzlCeUFIY0ppWE1VK2dENi9WVUczdlVHKzh1?=
 =?utf-8?B?Ynp3Q3RxWEExS1ZtaDZnZ0h1M2hNRWJ1dFBwV1lRWDZMVjkwMGxUZ3FnWWlx?=
 =?utf-8?B?aUw4L284TFIyRzBSN2s4Rk9VRWhXOHdwWWJIbHgvaGFoYW05UlRqeDFwTEpG?=
 =?utf-8?B?VmhZdXRDS2YzUTFCK054UlRtRVVLZE9YL055blFHZGJMSlVSaHgxNDE4d1R5?=
 =?utf-8?B?cUNpWFNTODVyTWgrL2IwcDV1Um0zLy9IVW5tMlRZWS8ycVQ2b3BRMEo2eUk2?=
 =?utf-8?B?Y1hKNE9VTW5MbzI3aHVXMnQwK1RjMzU5K0grQ0wyb25relVmTStxa013RVdh?=
 =?utf-8?B?R3BqR3NoNmNUZGIwRkFsSWY1NXNwSjRxd091c014VlJ3N3JXYndFVGx2Q1ZP?=
 =?utf-8?B?ZU9ENnlJcG9GMys3VUNBanliYS8raUV1Smd3RjczeGpLdGZzazVRa25pV0I2?=
 =?utf-8?B?OGZGTXpyVkU3R0wycFZpVmNRYXljUTd2SmZrOG1OWGdCeThXL29NemZZa1da?=
 =?utf-8?B?cFVTYVZsNzBSRWNTOFlHZGNORnRJanVDb0kyRVBsRENhWGxZbzh0aDh5dlQy?=
 =?utf-8?B?a2ZGeWl4Q0pzNWNkOEdpV3ZLYmFQK00raDNlQko2QmlZN0lCQk0vNmY4Uk1Y?=
 =?utf-8?B?YmdMTlRNT1VSSU1xbGRzM09PcHNRTEx6Mi94NDArYlN1b0MrdWJBNHhLK2dD?=
 =?utf-8?B?cmxLSTV5NTVsOG5tY0pQajgzck4vUU9FYitqNjl6QVlNNGE4QmVrWFdKYUo1?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4EE2C40C19CD9D46AE76A0576C18FADE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR07MB10776.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0afd6c1d-ce31-4b45-448a-08ddc05400a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 08:21:57.6351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUN0WBOWBw14XLH2W5wv2sFxSjG2NgMn1nqkikQgus71Wh9WqenG286rkBKVziVIZCpob9Aae+rVfrDQgcSZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9423

SGkgQmFvbHUsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KT24gNy8xMC8yNSAxMDo1OSwg
QmFvbHUgTHUgd3JvdGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBh
dHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBh
IGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0K
PiBPbiA3LzkvMjAyNSA1OjQ4IEFNLCBFdGhhbiBNSUxPTiB3cm90ZToNCj4+IFRoZSBmdW5jdGlv
biBjYWNoZV90YWdfZmx1c2hfYWxsKCkgd2FzIG9yaWdpbmFsbHkgaW1wbGVtZW50ZWQgd2l0aA0K
Pj4gaW5jb3JyZWN0IGRldmljZSBUTEIgaW52YWxpZGF0aW9uIGxvZ2ljIHRoYXQgZG9lcyBub3Qg
aGFuZGxlIFBBU0lELCBpbg0KPj4gY29tbWl0IGM0ZDI3ZmZhYThlYiAoImlvbW11L3Z0LWQ6IEFk
ZCBjYWNoZSB0YWcgaW52YWxpZGF0aW9uIGhlbHBlcnMiKQ0KPj4NCj4+IFRoaXMgY2F1c2VzIHJl
Z3Jlc3Npb25zIHdoZXJlIGZ1bGwgYWRkcmVzcyBzcGFjZSBUTEIgaW52YWxpZGF0aW9ucyBvY2N1
cg0KPj4gd2l0aCBhIFBBU0lEIGF0dGFjaGVkLCBzdWNoIGFzIGR1cmluZyB0cmFuc3BhcmVudCBo
dWdlcGFnZSB1bm1hcHBpbmcgaW4NCj4+IFNWQSBjb25maWd1cmF0aW9ucyBvciB3aGVuIGNhbGxp
bmcgaW9tbXVfZmx1c2hfaW90bGJfYWxsKCkuIEluIHRoZXNlDQo+PiBjYXNlcywgdGhlIGRldmlj
ZSByZWNlaXZlcyBhIFRMQiBpbnZhbGlkYXRpb24gdGhhdCBsYWNrcyBQQVNJRC4NCj4+DQo+PiBU
aGlzIGluY29ycmVjdCBsb2dpYyB3YXMgbGF0ZXIgZXh0cmFjdGVkIGludG8NCj4+IGNhY2hlX3Rh
Z19mbHVzaF9kZXZ0bGJfYWxsKCksIGluIGNvbW1pdCAzMjk3ZDA0N2NkN2YgKCJpb21tdS92dC1k
Og0KPj4gUmVmYWN0b3IgSU9UTEIgYW5kIERldi1JT1RMQiBmbHVzaCBmb3IgYmF0Y2hpbmciKQ0K
Pj4NCj4+IFRoZSBmaXggcmVwbGFjZXMgdGhlIGNhbGwgdG8gY2FjaGVfdGFnX2ZsdXNoX2RldnRs
Yl9hbGwoKSB3aXRoDQo+PiBjYWNoZV90YWdfZmx1c2hfZGV2dGxiX3BzaSgpLCB3aGljaCBwcm9w
ZXJseSBoYW5kbGVzIFBBU0lELg0KPj4NCj4+IEZpeGVzOiA0ZjYwOWRiZmY1MWIgKCJpb21tdS92
dC1kOiBVc2UgY2FjaGUgaGVscGVycyBpbiBhcmNoX2ludmFsaWRhdGVfc2Vjb25kYXJ5X3RsYnMi
KQ0KPj4gRml4ZXM6IDRlNTg5YTUzNjg1YyAoImlvbW11L3Z0LWQ6IFVzZSBjYWNoZV90YWdfZmx1
c2hfYWxsKCkgaW4gZmx1c2hfaW90bGJfYWxsIikNCj4+DQo+IA0KPiBSZW1vdmUgYWJvdmUgYmxh
bmsgbGluZS4NCg0KTm90ZWQuDQoNCj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBFdGhhbiBNaWxvbjxl
dGhhbi5taWxvbkBldmlkZW4uY29tPg0KPiANCj4gY2hlY2twYXRjaC5wbCBjb21wbGFpbnM6DQo+
IA0KPiBXQVJOSU5HOiBGcm9tOi9TaWduZWQtb2ZmLWJ5OiBlbWFpbCBuYW1lIG1pc21hdGNoOiAn
RnJvbTogRXRoYW4gTUlMT04NCj4gPGV0aGFuLm1pbG9uQGV2aWRlbi5jb20+JyAhPSAnU2lnbmVk
LW9mZi1ieTogRXRoYW4gTWlsb24NCj4gPGV0aGFuLm1pbG9uQGV2aWRlbi5jb20+Jw0KDQpVbmRl
cnN0b29kLiBPdXIgZW1haWwgc2VydmVyIHNlZW1zIHRvIG92ZXJ3cml0ZSBvdXIgbGFzdCBuYW1l
cy4gSeKAmWxsDQpsb29rIGludG8gY29ycmVjdGluZyB0aGF0Lg0KDQo+IA0KPj4gLS0tDQo+PiAg
IGRyaXZlcnMvaW9tbXUvaW50ZWwvY2FjaGUuYyB8IDE4ICstLS0tLS0tLS0tLS0tLS0tLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDE3IGRlbGV0aW9ucygtKQ0KPiANCj4g
T3RoZXIgbG9va3MgZ29vZCB0byBtZS4NCg0KU2hvdWxkIEkgc2VuZCBhIHYyIHdpdGggdGhlIGZp
eGVzPw0KDQpUaGFua3MsDQpFdGhhbg0KDQo+IA0KPiBUaGFua3MsDQo+IGJhb2x1DQo=
