Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708A3624C4
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773163068; cv=fail; b=Tj/8t9W6DY4XeB9f86NKMn4oMcnvHQhaKxZSfiQOuS44HMEn5TDAm2RAO3cCEdoS1Ao0HV69FNFF6CDGMGmqpJuSOfXXC+VvMBpvy6C2rq4GqKq8ZHqXz+ima4DZ+pOE6kaL/CsBoCgbc+0XcVKvYI8oT63XpKFTnFE5dktiR04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773163068; c=relaxed/simple;
	bh=+JE3oZATk1z6rfTN414fJpFBakN/BS55+mTHO+3Azj0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D06/tn7J9p2LstWJB8ToGq0H+oKxKLfBtEJ2AzM4B9WMVeZIZrrEgtfwjF9TAeGfpsZ8yX03xVjx9DfGTGTK5AR3zV/W7O+r7V1CPL7SgXfitlz1GD+E2PguE5zyglbDSGtrwfsP9K8SMYpdYySOtmOBzgBxcD9I6CUmvm9XNGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZB6vJZ00; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YnIzE7Yq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZB6vJZ00";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YnIzE7Yq"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9AZ6U2581445;
	Tue, 10 Mar 2026 17:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+JE3oZATk1z6rfTN414fJpFBakN/BS55+mTHO+3Azj0=; b=
	ZB6vJZ00rfhNYmiSxsCUXhZaLI+uEVGkQVRTHGocEVsiE7aeoUtapAh+35xawBP9
	SV1elm8f943JWFAQiNUe7nS3/CBoBAGwCfvCVOKKWlQ+zVYlVJOJUSrSrvDd2WLN
	O2/RopCP8v5iSSOQB29KBPn5c17m49w6AS8mRvGu0/Ql5VguDBtC2utp6uMC6FHI
	3K8jsMJ3BANy3nWfAJs151+oYQCGoVlH84dy1MJGMQ1wFk5Xiyqw00NJYApz3h67
	bTrVgKJxFXiAyfg7d52ZIPacPnESIMvA4gu8qjtyYeCDog2rcQsH4xGZ9DGMToNW
	ANLpvd2h52jlQ8NJuNeBZA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csm9cuaf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 17:17:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62AFq6M1022698;
	Tue, 10 Mar 2026 17:17:36 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4crafadbfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 17:17:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gKNI7me+U8WHtKLQizBzmi8lcyIAA0ddwSgBctsncxAGbYHIxU215wy82VmpokMsMZLfge6A+kzdYnNfzZIQvif9x3SBdcgyXIZHhshMnPFaeNgQEyDjiUMjgjoCtbWIw5HZ9j94CYrTbBNHt1nHKJAghxlQGAs4Wnv1UqH3uip13M3bDnwvmh5hx1eYv2gDXvClgmBRrq3cKB8xoz1yf2eYzKekNiVf4Zumi0tLYuRcZk7Lpz90uTP+nl9bTTN65eRH7NUENm+vCokFdyoCDDrpC2AxGwPXuA1YCgLxDzIxu9WshCtrij91A8+lq3S7hjT4+aQOTz9Khvwd5EcOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JE3oZATk1z6rfTN414fJpFBakN/BS55+mTHO+3Azj0=;
 b=hNVQ4pio6T7nJPnoT6NPz5A6/XeJkCrjUfdflgfK9+dpanCFRtxrC0GZVEhBz+kpvWLBOGxtsROv48KFFBSR3CitKcH800hMHlEa9Oi5ozHljc/CpQzzJ0K52AvUsEF8ioz1NskVw1EFk5phQ7djf9GBUzyFnESy1u1bhVr1TVJm36k46FSnj35vBoOz7sL6DfZiDu1Q1N12L5Zb8zw2pMNQvKzphrpEtRb1c9cBaMVBrdkIzw0OcBO4kuPf3xwQ8zopJEeEcMrQzznfqLksFEb0ZNDwZgEYekmLjDMqmXITM/VLOKk6bsAAgzpS6vgHYUa1Wh4BMfMObD3OuwPL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JE3oZATk1z6rfTN414fJpFBakN/BS55+mTHO+3Azj0=;
 b=YnIzE7Yqv9I0Lxh6r4iCktIlfYgh3Q3tNb7N/KuoKmP5hltojnL5v68hHFQn+vWFv76qgXeCQsxtSyNXZwHsWfCR/xzDG2N+q/6bGmssIxQfcIwI6j59GtZjvWMbtHuxwp039OxuW4d9KZuJpV3SJ0Jj2I5Dc0cz99QTuF+FYiA=
Received: from DS4PPFD91C619EF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d4e) by PH8PR10MB6412.namprd10.prod.outlook.com
 (2603:10b6:510:1c7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 17:17:32 +0000
Received: from DS4PPFD91C619EF.namprd10.prod.outlook.com
 ([fe80::d255:3853:bca2:c291]) by DS4PPFD91C619EF.namprd10.prod.outlook.com
 ([fe80::d255:3853:bca2:c291%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 17:17:31 +0000
From: Sherry Yang <sherry.yang@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "joerg.roedel@amd.com" <joerg.roedel@amd.com>,
        "kevin.tian@intel.com"
	<kevin.tian@intel.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommupt/amdv1: avoid GCOV builds triggering FIELD_PREP
 build failure
Thread-Topic: [PATCH] iommupt/amdv1: avoid GCOV builds triggering FIELD_PREP
 build failure
Thread-Index: AQHcsKtgqEw2u6CwUk62gJ+kGlpwdrWn+CwAgAAJ/4A=
Date: Tue, 10 Mar 2026 17:17:31 +0000
Message-ID: <62EB69AA-FA3E-4820-B268-A207CCA6F23A@oracle.com>
References: <20260310163136.1179322-1-sherry.yang@oracle.com>
 <20260310164134.GA1410323@nvidia.com>
In-Reply-To: <20260310164134.GA1410323@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFD91C619EF:EE_|PH8PR10MB6412:EE_
x-ms-office365-filtering-correlation-id: 660ba6ed-6b57-4d55-80ff-08de7ec8ea08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 m6AU5XhmwdJyJ2oN59lQAFU4YYe+dwfBQKLDjkt44jq7B8sbdrXw9LCHpmglmONs7Ba9Zuxt5AnhVh6UL4FAuIIsFL3Gg8M1qLO89OJPNtRSiQu+QXGCoVLT3xzMgNFEkY85/zcAN7UivsZDRcS3du4HIX1G3np0kbd6kEl9FhM7CSFYwOxo1HQmyXgMkEXYOBlasHceT/h7Dp0c8c4Bf7BNrLyxjdyEW3WcOTEkETrhZQByerzADDkNDdQyFixZ6EAwmLGjpnDjuv9/vg5i+nYD4erjw5OkJgC45FV/QridfprPFsLbfeJ1i1V39TTnyCdhggXzlDqFWJhxvFztMwr40vZCjw/n9UHD4D/YmP+thpsk8yCWZT6j4twHbWP/DQwySZB0HGbhT4fOJvBoKMcDlZ/WxZJDr/8udews8UFualmYngJkOexv7qj3YXBsRozlYyI0P9uVaxp9KRBkOK+3/RQ4JgPC4cyn7Ee9FaqiDNUJSmlKPTm32RuDXFXeq1acmDbCLDMd0sjeFpu0KA0H9ZJPUOrCSPtkDrIb+quZ83kSR/jSCKHZQ41ekYUOubJ9IVaikuEIJmuChO9E6trGDQhrbo2vKkjKHjWo0FdNHrUlTA6nANoi0Hbupw7Shso7sAUjmfy+K/thGiyDEeKHWmTRTpoVLiRUiN/T6Sihu3r6KzvOs+H9pHq9q4e7hY/DmBZkv/lV9jcV5X8E/4KEFR1M80JIAerEOWOoD9wmIZ3f8uaIxMSyHbUHKhY4mdY+mQjX24ejV0dn+DEdzQHCgzSDLeA+gtIkRdY+Z/w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD91C619EF.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yy9hbHlQcXpRM3FBVlhTRFpTaEZUMlF1SUtMQTRzSEkzbmRWd0FxakpuemU4?=
 =?utf-8?B?L2IyRjU4L3NKempidkdib281SFp2WVYvaDVHZDdocFBxTmUwaEM1UkVlUUcz?=
 =?utf-8?B?YTVzcFZycnFiekR0QzlQc0lKL2ViWmY0dU9WREkwU0l6L1hTM0szZnNWZlpO?=
 =?utf-8?B?aHF4UXJkSm8rZ1J6SnZUa1BYK2o5RWVldUJZZ2xTM1NKRXB3bUFXMUw4Qmhi?=
 =?utf-8?B?dVkyakhkU0Y1czk4cEFHWEg2bm16dEtnSW9sTUF1aU5QZDFLd3B6dUtVbFBE?=
 =?utf-8?B?djBVekN6ejMwZDRXemtJQy9hRjRuK3VWMHlIUyt0TjJrY21oS1o1aEhGYWNS?=
 =?utf-8?B?QzR1UUtUZFlrQ2E4cFVXcFhzaGE3RHBlVzVLTTViNjlYRms2MDFUSmFGelhI?=
 =?utf-8?B?SXhFaTRDUSsrYWR1cXJFYmRpNUJEekRzNitzT28xVVdENXVNb1htcnhvTzVO?=
 =?utf-8?B?R3NybXV3ZGZVaWZLcXZaYWM1THFCT1FDVFFWRXkwdnVkcXdiM05FWnlKZjNF?=
 =?utf-8?B?WjhRTlp3WTByYU8zZkhRK0QxYmxiUEdoV1FrYzRROFM4RWQyMkYwa2NsNk9U?=
 =?utf-8?B?dkNQYk11MmpCdDN6dHRVRXJBYVlxMHNtaHBZUENFdmpuMHc4UENPKzdxenBj?=
 =?utf-8?B?TU1UbGZnM0oraFZKRWFTc2lWOXg3M1lJbzh4OW5nQjJ1enpGdmxSQyswcDZx?=
 =?utf-8?B?SnNEanVqaEMvNkJ0U0g2dlZBWkZWTjJCelBuV0IvbDk3aC9NWjZMMEpIcEVa?=
 =?utf-8?B?NklTSGhXUE13VFpVSEpuMzVWL1BnbGMyRlpjSGVSbEVvd0liMHhMUUhmSFp5?=
 =?utf-8?B?djk1TWFCdmRjY0IyaDh2OGt2YjRyeStFVHNMMndiRHJ4aU9KaFQ4eUhMRDVq?=
 =?utf-8?B?a2VaTUQxa2hzRWF1K3pEMjhUYXVXam5QZCtNeEdJQjJidG5HRFNnMGJVR3du?=
 =?utf-8?B?RFczWU9HYVRYTEtkMVJSay9sRFJCTm1zQTRmYWRlOVU4RlV5OW9GN1FQb2Jm?=
 =?utf-8?B?Y2RLTHpTUkdtYmFCKy9adG9sVDdzR1FKdWwzbHJEaGxuZEdhS2liWlJaVjJr?=
 =?utf-8?B?bUZ1dThxbjloSG9PTDN4bW85VVRKZDc2SHdublozK3NyTVlCblR0dSs3ZWJp?=
 =?utf-8?B?MFFidnFYZjRFdlp6NHJiOC9KWWlJMzdlUnVwdHNQQUNyRGhyck5SWERmQ0Nz?=
 =?utf-8?B?SUloRVpOMzFZYWE1MDg0RXFyemU0OWZRaUk4L2RJSjBUaW95emY0MSt6V1VZ?=
 =?utf-8?B?ZVpNZmdXWWJDbzJUZkRmcDA4Yno0Wkc3V09ZSXhKNGdoWDB5T1VUYVpRdjh1?=
 =?utf-8?B?VnR0OUw4ekRBS0R6eTlKd3VIcGFVSmhoUExGekV5YzNnQzFtcHBCREx2OFM4?=
 =?utf-8?B?ZFl1RURON1hLMXVBL1BUa3dJWm1nRmhHY2tuL25Kd2JBLzYyK2UvbFBmemFS?=
 =?utf-8?B?ZG1pZjBuNmpNbTYrV2sxL255cHNIbGt6OGlkaHY5eE5mVXJkWGhiSmRYd1M3?=
 =?utf-8?B?bzRLRVNaMmM5QUtHYnpVR2loZ0MwaEZqMTIvT0plWTdhK0RVaWJReThOTTdH?=
 =?utf-8?B?WmJJQm1TL2hYc1phc2ZLTzZFTDJxRURraFl4bHcyWVBINC9jMlZOYVcyeDlB?=
 =?utf-8?B?cjh3eDNwUDJIaklmUDgyclRVMjRONHAzVUNTVzRKbzZFZjQ3RU5tWGNSZFg3?=
 =?utf-8?B?ejNoVXdUaGQrTzFZRmpDY2c4VExqK3VnUEh1N1BsdTNraXh3N3luVmpseStY?=
 =?utf-8?B?cmNYbXJlMCtHK0hEWld6YUQ0Umt6NUdWeEFhOUd1RzJ1VWhpZnNJRThKZWM3?=
 =?utf-8?B?dnNHSFd2L3F6VWlaUXR5bEMwK05BMTJtYlV1alVxSnFuS0VpeUJDUm1TcFlG?=
 =?utf-8?B?WmFnYWRzY3Z2QmhhQjRUN0Z0bFB3d0FTU3V6bEJURyswQVBhVlBsRVFLWXZK?=
 =?utf-8?B?M0RUL2tVcitCNENaZS9SOVdoblNuWHRzTCt0Y09YQUgrWm92TnhDcUZuTXlL?=
 =?utf-8?B?N2FGNVZYZ3hnRTZMUGFRSXIyUkJZU2pKcVA1bWZTWkJjUU5wRW1rdVdJdFVY?=
 =?utf-8?B?YnJRd2p0T1J5RzJRWjdlTDlxempTY2RBaC8waFdHZVFQbElLdlVKNnBUREFB?=
 =?utf-8?B?NVBuQmxXNHF5RlZ3NUxzRkEzRUJjK1EvbjhBOWZLZWwvTWhDWS9HaVo5aml2?=
 =?utf-8?B?bHdQWlZCVTJRRWdXS1cyMFpUZzd4QUlHQ1dYSWpJWXVLQXAzdy9UVmpyMUl0?=
 =?utf-8?B?VXNweDc3djR0ZVFmaXB1SStnRjRZaW9HZW5yNDZ5VTRvOVl5UjFjNEs5KzFP?=
 =?utf-8?B?dXJnZStVMFNaT1NSRVg5WHEvbXZIaDBreGV3bWdtcTd0WFBCQXZFMVNkSW9q?=
 =?utf-8?Q?5f5UdkGq4REjwUPg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91E4C0AC7DD00E4A8473E4E31D219964@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	ALIZSoqkl7j9ZedcmTeRLMHrtzB40T1gIhNjisdR64ZpdonN7DPk31azobB1Izwf3ZZpuecT8eqj0meXufs8elTIeeSjxad/yQBSNHG7KBzW6VXsaPnEL5ilhS+OpPyJY/08QfwfvnleYoJsG+w0VLz5QyYX+nfDBU/kz34lzo54TEEKpTwedmtN4bGsdmMO4+aq91auWGGV3AkrZnn2jex5qY3uwtR2q5xcXe48KRwQwveVLSksboSVvFfFC8aND7J2QrwdsmG5+iKRnafh/W3DB34/s5OpkD9YtFovv4kIZyq0Vu3Y8CM2zc8eXkyu5ArJKuFO17QDSnyJSakEww==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tbbAGMplQUZlWhs9CluzfPCD6X1szO599xscc0vEyUjbFhIQcLhtVh/yXvs6HXlifpW0Gd1efHhRPCOU6rtMtkrAh5Lw9y8YqwSp/VApqpgaoL7vUxMFWbyczqR+ESVXQZ4r0ycRrbFE76T9INMiSy95QOuIsS6rk1mrVMyfziS02GPgh8vUTwyJmGEw3FxDCArqQrydmTNVY6V6BpyBFF8vrCaHwy96WiknH4Hgxb3EnlrqXkr518UhXWIsOlT3ljSmtVwtxBPfLnrFfLpyehTGYUhTzFTeMjJv2GoOYjoEuapRNvNS5y6lXv7wmFbW+0r66fbFZVKi5W4dLf8HOjyzCa2krP04gMoPxYJoKPgGKvor2Pc285sntcNkYLwZ9FlJvupcu1Q94DRObhyZhUvGG9y4rslprYSKJA8PrlP5SyqPwH1aQSWE876zhyAqjaX6V6wuJGks7VNgNa7vKDbuFox2dTgoC5HRmrYnk00C+adMXrWI9UJCHgt6TUxQWyawerMnZEJ0XDdT/o0p7urJOWKjpB1JfQ4Z+hxFUo9+h3ce4EDerNa/gIsWmnwpRa2SphMIlJ8tLfIsAVKXdYFBmKIP8f6js0/Fh6daRO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD91C619EF.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660ba6ed-6b57-4d55-80ff-08de7ec8ea08
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 17:17:31.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YaMPdCJlsuRGaNckx17973sebjIH9gV/Q669bz2oqyKjdPx81AfM+YX1O8TolRjCq03a0R3j9E1Pd+3h93L4Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603100149
X-Proofpoint-ORIG-GUID: pijyZucyGDTOwmLtcXCpf5Ng-pIfaSLr
X-Proofpoint-GUID: pijyZucyGDTOwmLtcXCpf5Ng-pIfaSLr
X-Authority-Analysis: v=2.4 cv=LeYxKzfi c=1 sm=1 tr=0 ts=69b05231 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22
 a=Ikd4Dj_1AAAA:8 a=9jRdOu3wAAAA:8 a=TOeLGyIyu6oTi87upSoA:9 a=QEXdDO2ut3YA:10
 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE1MCBTYWx0ZWRfX2vvKYjyv5Qmx
 PBK37qgmQ6SSl0N0pTSiOKcGkQIZUsy6MQgw7xWIJ+2c1t5+qODZl45osCPy3DdeswGvN6gLp/b
 723iDSiJqK4DjrVdM+dsO++pPkP6xawJPMH6A19wA20tK7BevGRnyMnYTpySOuwTS3AaAV+F+As
 bGp2c5tFUjHKyYBdzSJgN98FduBAIRT/pXx7AZZBjC7ASHivg9Cm9zTzuCTRHn81r47EApAeMkl
 VcQI/k8Eg1wWKMxVAh9V1Sdh65oH71ZnLIIm9m4uIjGmKwiy/7/XsqTKYkFKNiceTHO1eIUxI2U
 gAR5AVrurXT7E7mkFrUf7pxnCz//aC2le8btz0ZPMeGKxsfOfXb/NxyZbkEAXztKvurmiAGgiAK
 U5qKYIHgc4Z0a9D3V9ndzPDKXPcM181nkVKIMlBbFAQqymX72uwbVIKcdAfUQyKv62OKJpQgh2J
 gwT0JeqgdnBx22m/m1w==

DQoNCj4gT24gTWFyIDEwLCAyMDI2LCBhdCA5OjQx4oCvQU0sIEphc29uIEd1bnRob3JwZSA8amdn
QG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBNYXIgMTAsIDIwMjYgYXQgMDk6MzE6
MzZBTSAtMDcwMCwgU2hlcnJ5IFlhbmcgd3JvdGU6DQo+PiBBZnRlciBlbmFibGluZyBDT05GSUdf
R0NPVl9LRVJORUwgYW5kIENPTkZJR19HQ09WX1BST0ZJTEVfQUxMLCBmb2xsb3dpbmcNCj4+IGJ1
aWxkIGZhaWx1cmUgaXMgb2JzZXJ2ZWQ6DQo+PiANCj4+IEluIGZ1bmN0aW9uICdhbWR2MXB0X2lu
c3RhbGxfbGVhZl9lbnRyeScsDQo+PiAgICBpbmxpbmVkIGZyb20gJ19fZG9fbWFwX3NpbmdsZV9w
YWdlJyBhdCBkcml2ZXJzL2lvbW11L2dlbmVyaWNfcHQvZm10Ly4uL2lvbW11X3B0Lmg6NjUwOjMs
DQo+PiAgICBpbmxpbmVkIGZyb20gJ19fbWFwX3NpbmdsZV9wYWdlMCcgYXQgZHJpdmVycy9pb21t
dS9nZW5lcmljX3B0L2ZtdC8uLi9pb21tdV9wdC5oOjY2MToxLA0KPj4gICAgaW5saW5lZCBmcm9t
ICdwdF9kZXNjZW5kJyBhdCBkcml2ZXJzL2lvbW11L2dlbmVyaWNfcHQvZm10Ly4uL3B0X2l0ZXIu
aDozOTE6OSwNCj4+ICAgIGlubGluZWQgZnJvbSAnX19kb19tYXBfc2luZ2xlX3BhZ2UnIGF0IGRy
aXZlcnMvaW9tbXUvZ2VuZXJpY19wdC9mbXQvLi4vaW9tbXVfcHQuaDo2NTc6MTAsDQo+PiAgICBp
bmxpbmVkIGZyb20gJ19fbWFwX3NpbmdsZV9wYWdlMS5jb25zdHByb3AnIGF0IGRyaXZlcnMvaW9t
bXUvZ2VuZXJpY19wdC9mbXQvLi4vaW9tbXVfcHQuaDo2NjE6MToNCj4+IC4vLi9pbmNsdWRlL2xp
bnV4L2NvbXBpbGVyX3R5cGVzLmg6NzA2OjQ1OiBlcnJvcjogY2FsbCB0byAnX19jb21waWxldGlt
ZV9hc3NlcnRfNzEnIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBGSUVMRF9QUkVQOiB2
YWx1ZSB0b28gbGFyZ2UgZm9yIHRoZSBmaWVsZA0KPj4gIDcwNiB8ICAgICAgICAgX2NvbXBpbGV0
aW1lX2Fzc2VydChjb25kaXRpb24sIG1zZywgX19jb21waWxldGltZV9hc3NlcnRfLCBfX0NPVU5U
RVJfXykNCj4+ICAgICAgfA0KPj4gDQo+PiAuLi4uLi4NCj4+IA0KPj4gZHJpdmVycy9pb21tdS9n
ZW5lcmljX3B0L2ZtdC9hbWR2MS5oOjIyMDoyNjogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3Jv
ICdGSUVMRF9QUkVQJw0KPj4gIDIyMCB8ICAgICAgICAgICAgICAgICAgICAgICAgICBGSUVMRF9Q
UkVQKEFNRFYxUFRfRk1UX09BLA0KPj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fn5+DQo+PiANCj4+IEluIHRoZSBwYXRoICdfX2RvX21hcF9zaW5nbGVfcGFnZSgpJywg
bGV2ZWwgMCBhbHdheXMgaW52b2tlcw0KPj4gJ3B0X2luc3RhbGxfbGVhZl9lbnRyeSgmcHRzLCBt
YXAtPm9hLCBQQUdFX1NISUZULCDigKYpJy4gQXQgcnVudGltZSB0aGF0DQo+PiBsYW5kcyBpbiB0
aGUgJ2lmIChvYXN6X2xnMiA9PSBpc3pfbGcyKScgYXJtIG9mICdhbWR2MXB0X2luc3RhbGxfbGVh
Zl9lbnRyeSgpJzsNCj4+IHRoZSBjb250aWd1b3VzLW9ubHkgJ2Vsc2UnIGJsb2NrIGlzIHVucmVh
Y2hhYmxlIGZvciA04oCvS2lCIHBhZ2VzLg0KPiANCj4gSSB0aGluayB0aGlzIGlzIGZpeGVkIGFs
cmVhZHkgYnkNCj4gDQo+IGNvbW1pdCA5OGQ1MTEwZjkwYWUwZGJjNWYyZjEzZjAzM2UwNmY2ZDU3
MDA5ZTBkDQo+IEF1dGhvcjogSmFzb24gR3VudGhvcnBlIDxqZ2dAemllcGUuY2E+DQo+IERhdGU6
ICAgTW9uIEphbiAxOSAyMDoxOTo0OSAyMDI2IC0wNDAwDQo+IA0KPiAgICBpb21tdXB0OiBNYWtl
IGl0IGNsZWFyZXIgdG8gdGhlIGNvbXBpbGVyIHRoYXQgcHRzLmxldmVsID09IDAgZm9yIHNpbmds
ZSBwYWdlDQo+IA0KPiAgICBPbGRlciB2ZXJzaW9ucyBvZiBnY2MgYW5kIGNsYW5nIHNvbWV0aW1l
cyBnZXQgdHJpcHBlZCB1cCBieSB0aGUgYnVpbGQgdGltZQ0KPiAgICBhc3NlcnRpb24gaW4gRklF
TERfUFJFUCBiZWNhdXNlIHRoZXkgY2FuIHNlZSB0aGF0IHRoZSBhcmd1bWVudCB0bw0KPiAgICBG
SUVMRF9QUkVQIGlzIGNvbnN0YW50IGJ1dCBjYW4ndCBzZWUgdGhhdCB0aGUgaWYgY29uZGl0aW9u
IHByb3RlY3RpbmcgaXQNCj4gICAgaXMgYWxzbyBhIGNvbnN0YW50IGZhbHNlLg0KPiANCj4gICAg
ICAgSW4gZmlsZSBpbmNsdWRlZCBmcm9tIDxjb21tYW5kLWxpbmU+Og0KPiAgICAgICBJbiBmdW5j
dGlvbiAnYW1kdjFwdF9pbnN0YWxsX2xlYWZfZW50cnknLA0KPiAgICAgICAgICAgaW5saW5lZCBm
cm9tICdfX2RvX21hcF9zaW5nbGVfcGFnZScgYXQgZHJpdmVycy9pb21tdS9nZW5lcmljX3B0L2Zt
dC8uLi9pb21tdV9wdC5oOjY1MTozLA0KPiAgICAgICAgICAgaW5saW5lZCBmcm9tICdfX21hcF9z
aW5nbGVfcGFnZTAnIGF0IGRyaXZlcnMvaW9tbXUvZ2VuZXJpY19wdC9mbXQvLi4vaW9tbXVfcHQu
aDo2NjI6MSwNCj4gICAgICAgICAgIGlubGluZWQgZnJvbSAncHRfZGVzY2VuZCcgYXQgZHJpdmVy
cy9pb21tdS9nZW5lcmljX3B0L2ZtdC8uLi9wdF9pdGVyLmg6MzkxOjksDQo+ICAgICAgICAgICBp
bmxpbmVkIGZyb20gJ19fZG9fbWFwX3NpbmdsZV9wYWdlJyBhdCBkcml2ZXJzL2lvbW11L2dlbmVy
aWNfcHQvZm10Ly4uL2lvbW11X3B0Lmg6NjU4OjEwLA0KPiAgICAgICAgICAgaW5saW5lZCBmcm9t
ICdfX21hcF9zaW5nbGVfcGFnZTEuY29uc3Rwcm9wJyBhdCBkcml2ZXJzL2lvbW11L2dlbmVyaWNf
cHQvZm10Ly4uL2lvbW11X3B0Lmg6NjYyOjE6DQo+IA0KPiANCj4gPz8NCj4gDQo+IEphc29uDQoN
CkhpIEphc29uLA0KDQpVbmZvcnR1bmF0ZWx5LCBJIHJhbiBpbnRvIHRoZSBGSUVMRF9QUkVQIGJ1
aWxkIGZhaWx1cmUgd2l0aCA5OGQ1MTEwZjkwYWUgKOKAnGlvbW11cHQ6IE1ha2UgaXQgY2xlYXJl
ciB0byB0aGUgY29tcGlsZXIgdGhhdCBwdHMubGV2ZWwgPT0gMCBmb3Igc2luZ2xlIHBhZ2XigJ0p
IGFscmVhZHkgbWVyZ2VkLCB3aGljaCBtZWFucyBpdCBkb2VzbuKAmXQgd29yayBmb3IgbWUuIEkg
bm90aWNlZCB5b3UgbWVudGlvbmVkIGNsYW5nIDE4IGhpdCB0aGUgc2FtZSBpc3N1ZSBhbmQgZml4
ZWQgYnkgdGhlIHBhdGNoLiBXZeKAmXJlIHVzaW5nIEdDQyAxNC4yLjEsIGxvb2tzIGxpa2UgR0ND
IHN0aWxsIGNvbnN0YW50LWZvbGRzIHRoZSBjb250aWd1b3VzIGJyYW5jaCBkZXNwaXRlIHRoZSBj
aGFuZ2UgdG8gcHRzLmxldmVsLg0KDQpUaGFua3MsDQpTaGVycnkNCg0KDQo=
