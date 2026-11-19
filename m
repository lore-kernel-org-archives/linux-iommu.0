Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=18.158.153.154
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795091242;
	b=mVswV+lOymMKLnIy/xoup4UlKivTgTVGI1Ah3w1DfdH4/huQJFmsno3eCZ9ZbQdKmVQz
	 v1u5FxQUbJadYeiS83gPP0iityATH96A0lFo60Q3FIL3hpy27oiVGcr+71tPFlOPuhu33
	 DCOmJAcjLnqMCf7u9eRploYfUZ91nVBuCDj9BV7esEu61po9JF40ruY/uQriuGA3KuhTr
	 QbjuzAHBqjIvj+VBl8AW2hEghbi2ub9/Wpqy1k58OAtDB88CrHQds0dMJq4bnUSVZGaQp
	 PgAQn33mqgVnQoYM7REyOIk8FhRu+lK2zLRqp/TEqm3KL5IEOz7emA/frGtGvVdTB/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795091242;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=/R/VpeLN3pbU7BPC6gwoQbwCGvwbKwmvdLMCnVmc56w=;
	b=YhcHm9Q+sLXKq9y8cXfcE8W6XRbUGdsZd2Kcprg5lW63qJ8w1NgyvRWo2DER5tHMbnCy
	 yE5LTIpcQspqp6F1FiEoNksPQpsk0wF4dzApbq+NykKNgC4ohLqGsE6f+FTqlFVSY7/cU
	 tvvx3fXlvZV0LQAjKTNK6adAGi438oXCTDUpGgcNV+FfTkyJihs/iymbxDIxX63pKFwvR
	 m5Ull2rP7tCxsHoH8/uGuX4fh9suGPxJR+UFcdj0UvSkUmlcbFnx4nrApYUDQNtOzFJMc
	 UIN77OtsPGQ3ufJY3HgXq29nAPPQwjAkP1fe7EMf/dDqsb9Zta9n/8Q0OtF7AtikqrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=FKHDTDy+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=18.158.153.154
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87D1606A333
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 12:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C87D1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=FKHDTDy+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795091238; x=1826627238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/R/VpeLN3pbU7BPC6gwoQbwCGvwbKwmvdLMCnVmc56w=;
  b=FKHDTDy+Fz0i+kF69iom8jPQE69bUpMTber9MR05WczCEYvpOjcYaNXi
   5x92952jsMm1eyUtw6T7rZ4ndz8tWU/NY5tuo6aWVCIsqxNn88DuizSpY
   mUje0X4poBiZHNahcEZOlmgwVMzTebhTNpIYOm+PCXrniB20a/t3MaJdI
   aWBASAJ+xBafHQnOm46u9qFgpTAEQ3WOlp+N0iz6Lzt8UwF7Q1Xbmbo5t
   33aM0Fse0mICGpA5E7ZG4YGd1GUsbP94CHLFuULCTVWAdCp1EiDFJX4pC
   mJLffEZv0Emk0URCAIVU2QLKdlQ+QrmM8dTRzkYN1yJ9UlBnfwRp/VGe6
   g==;
X-CSE-ConnectionGUID: vEspxkZeS7eD9hkdah3mDw==
X-CSE-MsgGUID: McR4CrK8RWiy20gmsMAyTA==
X-IronPort-AV: E=Sophos;i="6.27,220,1787011200"; 
   d="scan'208";a="23095631"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 12:27:13 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:12439]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.156:2525] with esmtp (Farcaster)
 id c66ae11f-290e-4893-b10a-93a0a493fc7f; Thu, 19 Nov 2026 12:27:13 +0000 (UTC)
X-Farcaster-Flow-ID: c66ae11f-290e-4893-b10a-93a0a493fc7f
Received: from EX19EXOEUB002.ant.amazon.com (10.252.51.83) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Thu, 19 Nov 2026 12:27:13 +0000
Received: from FR4P281CU032.outbound.protection.outlook.com (10.252.50.44) by
 EX19EXOEUB002.ant.amazon.com (10.252.51.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56
 via Frontend Transport; Thu, 19 Nov 2026 12:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXIkiDqPjH1+vTonF+VgRkKb/MxTrWh/KFJB7xrllnqVlTjmkWUlf0jKZOguTcbfaIoayu8e7noG2j5ZqfQ+mhLad7AZaODihpqBre59vNkUKVUX3ztIcwQaDnd0rR00tA+LC/yehfU0WRrIVb4uFFaOtfJ7Rw+IVd0BGUhsI/hiwaRokpjpQTmpNihSk+hfPhb2CSbvrM9UVi7/1bz408gVUVlrXylSeZRrQ2Z58kOy++e7S8oMce0H/zEJIYjLfixCCo6NNHlln125mjTMOrhSWdS1NumB+Hc4Tb55rNddn6Z9upgnURMegBnCgTZRWy9BQwbZcT0TDE24DOx4cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R/VpeLN3pbU7BPC6gwoQbwCGvwbKwmvdLMCnVmc56w=;
 b=na2evdTThiLce0qqMhYbGFXIKRFvrta3PCl+YL+61PO7agUu8hsKc+ufO84dR4L4c9hCx2Zs+/Y+vUWoFlemUNT1F49FGKY150CFu6H3w4SbtoGEZDxZsXLdYaG8y4ARhlgFBhb62lAZ9a2I1C+eBG2pQnD26pZswLA9WCiat+rSU7saeyboCbm4lDhts6LFJEma8A3NH/vdTa3kVscm2tr80b+nrYNSBFL5tQeRB567fFq4WuCz01cvZLSE4tmEOJCwM3IvReezAIxfdLz5HznLXwSXFS9Znhxd1J01qmkNbW0u6UuS73NYYuwkMYEZKIVHz4xaBhP6rZnh1xG6vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amazon.de; dmarc=pass action=none header.from=amazon.de;
 dkim=pass header.d=amazon.de; arc=none
Received: from FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:20d::13) by FR3P281MB3069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:5a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.17; Thu, 19 Nov
 2026 12:27:08 +0000
Received: from FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7b1c:7a5d:c405:6c4d]) by FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
 ([fe80::7b1c:7a5d:c405:6c4d%5]) with mapi id 15.21.0615.017; Thu, 19 Nov 2026
 12:27:08 +0000
From: "Graf (AWS), Alexander" <graf@amazon.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Robin Murphy <robin.murphy@arm.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, "nh-open-source@amazon.com"
	<nh-open-source@amazon.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "The
 AWS Nitro Enclaves Team" <aws-nitro-enclaves-devel@amazon.com>
Subject: Re: [PATCH v2] dma-contiguous: support percentage sizes in
 cma_pernuma= and numa_cma=
Thread-Topic: [PATCH v2] dma-contiguous: support percentage sizes in
 cma_pernuma= and numa_cma=
Thread-Index: AQHddEf7tYtxXLjQ9kue1WbqibxY3Lc1R0IAgAASw4A=
Date: Thu, 19 Nov 2026 12:27:08 +0000
Message-ID: <28a0f946-af4e-497f-a923-f11b79d94930@amazon.com>
References: <CGME20261114145340eucas1p2f7699b88eae34f7904cf68109dc3eb4f@eucas1p2.samsung.com>
 <20261114145328.1307-1-graf@amazon.com>
 <fa38a878-1735-4682-b208-5de1616f7e4f@samsung.com>
In-Reply-To: <fa38a878-1735-4682-b208-5de1616f7e4f@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amazon.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRVP281MB744463:EE_|FR3P281MB3069:EE_
x-ms-office365-filtering-correlation-id: 6f687ec0-2f1e-422c-ddf8-08df46386ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|18002099003|22082099003|6133799003|3023799007|11063799006|5023799004|56012099006|4143699003|261022115727099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|38070700021|10067099003;
x-microsoft-antispam-message-info: ySlmZE1g03SGnDSpzhD6nsD0dXqJTG1n2FBXrZ3ZzL6Cr0N2hD2Dp6zTwafQG5HwKpYF2ssaO56fc48LXwLD6sfNSuN1AvTxm+0hodmuCfWXFcCyU4Gb8H/IKZHPq342aUNTqTkZitXpwfKnnEr+KbtsxfBwAMa8ES2xbWRt/Yl0atHJ6xURhuh48r1DGvS9p6Fr5ezR25BNwuy5WKzoxth/bVl9C5oEBwrQ+xfVSljQODjgIOeY6PIrcnPwM3lgF6WM+C85OtjbF4PxH+jjyfBVsfCg5wl93BG3vNPa1ksYChJWJIjY4DmwQPu2iykY1GRQdL3xUZpDbYQ8EY0WH+a22HcJkWc0GrNuc8QfHLnwpZNh0hJuYojz9tZvMQR6WHoEn21PmfA816GcVPVZiWz8c2bdZFU7K32NMviGqPYxdUth1zVynqNe2MVYbYPl3sksp82Z10r15nfqoxa06/ustG2VeJSv6+AoGSGA0gWCN+drILYOq7vJ3leWXt2MfcbMlyn6Mo+Jxwtv/iD8oybch5ldqLozWq6cH6P9+/LxQcO1GXZwl9l61M3hPDvipZ+5gYMP8jBW3gI6aWmD8SIJw/fWyoTWDO+t0FU40FfrOX6DwiPKqE45Y8SnGBujDBVkHqri8dceA7tJLiyDlJc6/VsFaoZz8JTmA/NhXHFh2lEzOlfx43+2FE5ZPbEScmmHNmkNJ6UoYmf/fVtRq+LQsIrP7fC/0rGKKyHmNjs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(5023799004)(56012099006)(4143699003)(261022115727099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpuS3ZoekZjem1pNVM5dmdDNURxL0ZMY1BFQ0htOEhjdnN4dnBWekU5TTJ6?=
 =?utf-8?B?TWlPTFQyVlV1VkxVeHZyQjJlRUppNzBxRWh3YXl2R2d4QUZSU3VuVUVWOGZx?=
 =?utf-8?B?NFJLYS9FVndrTC9YNTArOG9OZlFPYk5NSkpDYVp2SS92Vmxob1NuV2s1ZmY1?=
 =?utf-8?B?bUVHVGJPVWpjRkRDVndOZTVSaEhnODBzOU9YRXFXMFpUbXRJOWVObGlsWXJa?=
 =?utf-8?B?OXRqdDFJNUdwRGJXSXFHam90T0ZYVGFjc1ZvUXJLRndYZ3FQRnFNUjZ1U3R2?=
 =?utf-8?B?OFlsQUdLWnZLdnh6Z1VUT01ZajNGemRDUHR3L1M0eCsyUThwd0tPeE5JYVhC?=
 =?utf-8?B?SDl2QUN1T2pQV1dOM1BYd1BXUjZmRm01Q1RNVTV3SnB5aDF3NTN1U05HeVpJ?=
 =?utf-8?B?WnRkNGUwL0pHa2lSN2hIcStuSk9iVEhMU3R6bEtpVC9tMHNFbEd6RzZoRS90?=
 =?utf-8?B?cC9yQmZ1MFVsZU9vTTBVdEcwYitaRDdCTzlrVnRFTDh0RE5UbFRGdWRoYm9m?=
 =?utf-8?B?RjFzTkZNN1B0TWllczhveFVsZzc0Vi9vNFovMVpNWDUwWnRMMUp0Z1B0TVVT?=
 =?utf-8?B?Yk9VbnVVMzh3UkVtM3Fzd0xvb1FndTNVZWxxZk1kR1NTTDhMY3NGUDZ5UkxW?=
 =?utf-8?B?UWEvYmd0QitCcFQ5ZUZxR3dvTUFhaXlLYTlLN3VETWJydHBmdUFSTVFZbVVD?=
 =?utf-8?B?UUgycHB4UTV2TU0rL0Y4cVppcVZzYWpzQ3RYNjVrRk5hUEZ4Z1c2WU9zaXpr?=
 =?utf-8?B?QUdIajlUTHhPTm9ESlZWaGhnaGJjZi9vc3ViMUZWVHdDYVR3VWlmak9RS0dJ?=
 =?utf-8?B?VnhUblNGS2E0eGJhVXdiSFhDQjZlMVZSYzZmdzcybC9DaG1xYWFwaWhycVpR?=
 =?utf-8?B?K0VtSm1UVnFKOEFiaTAzMlNGVG9sT1gxNzBqa2lGUzhUU2s3cVhIWXA1NmhW?=
 =?utf-8?B?Y0tXcUFjeGkxMjJwcTFzWks0RklaRFB1MWNLb0cyeHNJcWxFVWJFMit5Wngv?=
 =?utf-8?B?WFVpdk9PU2oweEtMMWpCME5ITyt2b1pUc29QV0luQmMxQjVRR1F0U3pxZHVw?=
 =?utf-8?B?L0x6c0Fpa2lQMGhqb1lOQVZidW52bU5WVHNRMXM0M21PTUZta1N2a3ZvUFpU?=
 =?utf-8?B?dXE4blZjRk9DdVNXZXdBSnhNOWplY1R4bkNtaVBxZEpRd3p0Y0JONDd5cjVL?=
 =?utf-8?B?Ni9QNUQ5Nmo1b3dseHR2NTFoMFBwY2lmSG9BamtaRlZET1U1Z1A1eEk4TFpS?=
 =?utf-8?B?bTdqeDZJeVJjaTZ6OW9ZUTIvT3ZlN0lTVVdvaHVZNEJHRW9PM1pjRTJDdjdL?=
 =?utf-8?B?ZjRoUW12QU8yNzdJd3dnd3QwYlQrOVdZR1FNQ282bkJMVUp0M0hZdmRaTG82?=
 =?utf-8?B?VThLazlmUHdzM2YzclpSL0FIcllodGMzMk9LdzFjZVA2d1FDUTMxRHdzZFUy?=
 =?utf-8?B?NzNIZitmdUxkTU5oWHhWeUt6ZFZrRHVHM0UxUUxQTGl0RHJ4WVlmd29RZFRw?=
 =?utf-8?B?VnY5Y1J4dlVsVk1FQVZXczVXVzY4ajZYRUlGZlVhWXU5ams4RGNlVG9wUHVz?=
 =?utf-8?B?ODgvYmtCdUc2UUMzb3UxNWlUNk8zRDE1cGNodkV3b3ltQ1hwWVZnT3JtTzQ1?=
 =?utf-8?B?S3JtV1hCVXBGWEFnczBpQlBsdTNxdVh2WkMzSVlDekQ1SXphWUROWERQcmlM?=
 =?utf-8?B?L2NtcUJEZTBTM0o2bEpueHlSY2ZzUC81WW9zdlNVRHIyRVVyWk1HWmI0d2hZ?=
 =?utf-8?B?enRWdFRMQjhxQ0kzSHlIQWZTRHV3WjY5RS81bVIxeGc1cFFFVEQwTGVJVHVE?=
 =?utf-8?B?b2tHWWx1VnhjeE9JemtXRzk5Um9aT1VMY2RVVXdNRFJZM3d1cEJxRXZmZHlO?=
 =?utf-8?B?REQxcnNQMFVNSXM1TlRCZWk3eVEvSnlIbGh2TjFEOXpZUnhXTEpPdjVIRXJm?=
 =?utf-8?B?b3Uzc3FBbWRwR1BXTHlTTDlGYWNTOG9qMGJKQXJsaEZNcmY0cEZSL0FtMUxo?=
 =?utf-8?B?Y1hBVElvKzVkRzh1WmoyaUl6YnJmRXhCM0VXbERMRWhhb2VGZklqTHhkZ2Ra?=
 =?utf-8?B?ZkRJcjRpdDN0T21SWEYrM0NLemNhSkpCdkxlTngzdjgwWG5XamR4TXk4c1o3?=
 =?utf-8?B?cTdoMDEwZ2Z6YWJKc3V0WllrbFoxOHcxQTRLaVI1ckxkRHpJWml0a1BMcW9m?=
 =?utf-8?B?anJrcDNqQVl4UENtRU9NcFVWNUhEbXJrOXNIakZIbjR1WkpiSFd1a1FpL29l?=
 =?utf-8?B?NDYxVC9NbnFFS0dHRysyYnF2SmZlS2k2a2ZXUEJvTzZCQysrbUhyUE5kOTY5?=
 =?utf-8?Q?AopLogUQNs8RRd6aOj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F572A20EAE2A48A277F05116F90715@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ma88mklnTR6DumWOAc7/R8U5g80Iitm/QAr6D49pNgBp4F0SaTgqRDubWLhU8NNBkK22h1kapLoqTGCbStihyKl+RhgTTGQw4mRsDmEi8s0P1WzMxdLXToh1fIcsNcGOCr3aTZKvhJeWP51y91SZZrz8dKvXPpLvb4LKPRM7c842lo8G+XgYnP/KVuJ89sj+65YpZld6tWJSARa4C3qw73IjJti1h1bHQKIuvYSLCo8P6cz9o7HMqQELgTODwMp//bKOu6YHN6H6llPlugJVRhMQwS3+usuUdy0vWRBsWVfyBsRBtEBdqs8/GjP3v8AevgYBNqTqIXbHGsWoA3Zkgg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRVP281MB744463.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f687ec0-2f1e-422c-ddf8-08df46386ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 12:27:08.4559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5280104a-472d-4538-9ccf-1e1d0efe8b1b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yDau6bClN6ft+IRm9Dtx6zZeqSoUY4MERdx25CYthqWsSgfqUIgf9+qYDbhkamdN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3069
X-OriginatorOrg: amazon.de

DQpPbiAxOS4xMS4yNiAxMjoxOSwgTWFyZWsgU3p5cHJvd3NraSB3cm90ZToNCj4gT24gMTQuMTEu
MjAyNiAxNTo1MywgQWxleGFuZGVyIEdyYWYgd3JvdGU6DQo+PiBXaGlsZSBDTUFfU0laRV9QRVJD
RU5UQUdFIHN1cHBvcnRzIHBlcmNlbnRhZ2VzIGZvciBidWlsdC1pbiBkZWZhdWx0cywgdGhlDQo+
PiBDTUEgYWxsb2NhdGlvbiBrZXJuZWwgcGFyYW1ldGVycyBjdXJyZW50bHkgb25seSB0YWtlIGEg
Zml4ZWQgc2l6ZSBhcmd1bWVudC4NCj4+IFRoYXQgbWFrZXMgaXQgZGlmZmljdWx0IHRvIGhhdmUg
YSBzaW5nbGUgc3lzdGVtIGltYWdlIHRoYXQgc2l6ZXMgaXRzIENNQQ0KPj4gYWxsb2NhdGlvbiBi
YXNlZCBvbiB0aGUgYXZhaWxhYmxlIG1lbW9yeS4gVG8gdXNlIENNQSBhcyBiYWNraW5nIHBvb2wg
Zm9yDQo+PiBsYXJnZSwgcGh5c2ljYWxseSBjb250aWd1b3VzIGd1ZXN0IG1lbW9yeSwgSSB3YW50
IHRvIGJlIGFibGUgdG8gc2F5DQo+PiAiYWxsb2NhdGUgOTAlIG9mIHN5c3RlbSBSQU0gbWludXMg
MSBHaUIgZm9yIENNQSIuIFBlciBOVU1BIG5vZGUuDQo+Pg0KPj4gRXh0ZW5kIHRoZSBDTUEgcGFy
c2VyIGxvZ2ljIHRvIGFjY2VwdCBjb21tYW5kIGxpbmUgb3B0aW9ucyBsaWtlIHRoaXM6DQo+Pg0K
Pj4gICAgY21hX3Blcm51bWE9ODAlIG51bWFfY21hPTA6OTUlLTFHLDE6NEcNCj4+DQo+PiBUbyBh
dm9pZCBpbmNvbXBsZXRlIGFsbG9jYXRpb25zIG9uIHBhcnNpbmcgZXJyb3JzLCBjaGVjayBmb3Ig
dGhlbQ0KPj4gYmVmb3JlIGFjdHVhbGx5IGFsbG9jYXRpbmcuDQo+DQo+IFRoaXMgbG9va3MgbGlr
ZSBhbiBvdmVyLWVuZ2luZWVyZWQgZmVhdHVyZS4gSSBkb3VidCB0aGF0IGtlcm5lbCBpcyB0aGUg
cmlnaHQNCj4gcGxhY2UgdG8gaW1wbGVtZW50IHN1Y2ggYWR2YW5jZWQgc2l6aW5nLiBJZiBZb3Ug
bmVlZCB0byBleHBsaWNpdGx5IGNvbnRyb2wNCj4gdGhlIGFtb3VudCBvZiBDTUEgb24gdGhlIHRh
cmdldCBtYWNoaW5lcywgbWF5YmUgWW91IGNvdWxkIGRvIGl0IGluIHNvbWUNCj4gc2NyaXB0cyBk
ZXBsb3lpbmcgdGhlIGtlcm5lbCBjb25maWd1cmF0aW9uPyBDYWxjdWxhdGluZyBpdCB0aGVyZSBz
aG91bGQgYmUNCj4gbXVjaCBtb3JlIGZsZXhpYmxlIGltaG8uLi4NCg0KDQpJdCBhbGxvd3MgdG8g
cHVzaCBtb3JlIHBvbGljeSBpbnRvIGEgZ2VuZXJpYyBib290IGltYWdlLCB5ZXMuIEkgc3VwcG9z
ZSANCndlIGNvdWxkIHB1c2ggdGhhdCBwb2xpY3kgaW50byBvdGhlciBiaXRzIG9mIHByZS1ib290
IGxvZ2ljLCBzdWNoIGFzIHRoZSANCkxpbnV4IEVGSSBsb2FkZXIsIGJ1dCBJJ20gbm90IGNvbnZp
bmNlZCBpdCdzIGEgbmV0IHdpbiBmb3Igc2ltcGxpY2l0eS4gDQpQdXNoaW5nIGl0IGludG8gYSBi
b290IGxvYWQgd291bGQgbWVhbiBwdXNoaW5nIGludG8gVUtJIGZvciBVS0ktYmFzZWQgDQpib290
IGZsb3dzLCB3aGljaCBtZWFucyBibG9hdGluZyBzeXN0ZW1kLWJvb3QuIEFnYWluLCBub3QgcmVh
bGx5IGdyZWF0Lg0KDQpJZGVhbGx5IGFsbCBvZiB0aGlzIHdvdWxkIGJlIHBvbGljeSB0aGF0IG9u
bHkgdGFrZXMgZWZmZWN0IGxhdGVyIGF0IA0KYm9vdCwgc28gdGhhdCB3ZSBkb24ndCByZXF1aXJl
IHByZS1ib290IGxvZ2ljIG9yIGEgcmVib290LiBGb3IgdGhpcyB0byANCndvcmssIHdlIHdvdWxk
IG5lZWQgdG8gaGF2ZSBMaW51eCByZXN0cmljdCBpdHMgbWVtb3J5IGFsbG9jYXRpb25zIHRvIGEg
DQpzbWFsbCdpc2ggcmVnaW9uIGluc3RlYWQgb2Ygc3ByZWFkaW5nIHRoZW0sIG1heWJlIHRvIHRo
ZSBLSE8gc2NyYXRjaCANCnJlZ2lvbiwgb3IgbWF5YmUgYnkgZmF2b3JpbmcgYWxsb2NhdGlvbnMg
aW4gcGh5cyBhZGRyIG9yZGVyLiBBdCBsZWFzdCANCnVudGlsIHRoZSBib290IGlzIGF0IGEgcG9p
bnQgd2hlcmUgeW91IGNvdWxkIHBlcmZvcm0gdGhlIGFsbG9jYXRpb24uIEFuZCANCnRoZW4gd2Ug
d291bGQgYWxzbyBoYXZlIGxhcmdlIHBoeXNpY2FsbHkgY29udGlndW91cyBibG9ja3MgYXZhaWxh
YmxlIHRvIA0KYWxsb2NhdGUgZnJvbSBhbmQgcG90ZW50aWFsbHkgY2hhbmdlIHRoZSB0YWcgdG8g
Q01BLg0KDQpBbnkgdGhvdWdodHMgb24gaG93IHdlIGNvdWxkIGJlc3QgZG8gdGhpcz8NCg0KDQpB
bGV4DQo=
