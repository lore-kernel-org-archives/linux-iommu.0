Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CE13A0E97
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005970; cv=fail; b=S5vz8IhAdhVP+xCCarv+pKHztQtA027o8rILj7bV7dXarCszufli4hZsCJZ1ejnYCMFbSkj6txwma3xXLcrxRhoEf4LS9KxB4LtuxkSMFkw8QIbpJdv760/0DWHo6DqSihCW1HhzUZ9G/g9CFmXAZcie6MRE/75Lkq/NCAL/tjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005970; c=relaxed/simple;
	bh=xS/hfvoQ52vytA1uhYDUY4s2qtL6Q92v2dCWIHuZFBQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hkn9u+04WDjBM9s+WrQB7cohS3hdY13PodCAFCEZEMot0Z9P988ReONUr8WiG9+O95dFoYADwJQu279klV2m7HA9MppHGVVWnKgbwZP5792TbIapLU7tKuDeBfYTAy1yII0Q7hR9h4e4nI6t8CgQppyKBpPv/bBEZ1fUSaj5HUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com; spf=pass smtp.mailfrom=qti.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y9xktN5D; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qti.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y9xktN5D"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEbFvG301180;
	Wed, 14 Oct 2026 19:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xS/hfvoQ52vytA1uhYDUY4s2qtL6Q92v2dCWIHuZFBQ=; b=Y9xktN5DISzFZScZ
	NwVqpBKKPFtUQ0A5HIpNHioeVRtZbrOKu6sSuCBN4Qxj3wAUImWt6xxtL1vzkIRh
	3BY6mcnTOmRn2qa6lAPnL7vMWSCsWbZwO+u2IqiJwMeKhZmW/LKa6zqfNh7rDBnb
	tYcFDTtXgTB6znZDEon9gDg2dF6R1FU6lbl1KYveSRrVTVrHbEgbxlQSMppnE/GG
	Hq2JGcYTd/mQl341jhan87dC4fsuY5iI3mgfyCup61BwQbAtlCOStulqu0nlzm1a
	x4Be9xmqagMYkhSENID/sj4yWkPDQxdp43Vn4xI0qCrjEjUhH2nWJ/q1qVr5PqKi
	jABZuw==
Received: from bn1pr07cu003.outbound.protection.outlook.com (mail-bn1pr07cu00306.outbound.protection.outlook.com [40.93.12.6])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46236r9-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 19:26:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7XQkbFwykU7dYPuT6c0wxCCF2b+/NghsTRACe9jSAt9DEUleOCQTSiI3ZCyK2IDH5Xt9j6H/3qShaVy4QKe4aovHWe1IhkcSCs328gcQxGEz4TjGZ67ji1RKYHwmCyaxr6zQb5vGxrwndQ5deZ8LzJPzrO2rZNRhM5jdpkCzU1PCckDKOruya5+BM291bbmBGOYCHMvlQEIXaiMx8kXAoIHSBoTUV2b0IektEcajx4e0ofPh4oUPskQnOZPUKTAW6Z1sy6yctcBmj9heHvaCF4MA97c23/I+bd3ZKCqReVow5ZZeDd59iAD+sohkVIwy3GQs6dISXGcQCwAX68SNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS/hfvoQ52vytA1uhYDUY4s2qtL6Q92v2dCWIHuZFBQ=;
 b=h/8W5e0PPhQxFCL/7kD8iAa9a3JMbr/o3QaQGfr1bXHhoglhyJB4RN512VyZJg7APIuHUPMLR/ErpauBbZAnRBzZAXIr3phZIFR3duRtZFfRF/q2QeM5u36wODfN/bjuR81ZaO9mwzbrU1w5lLmAQ2xfFJyD1dcN5jpczKuImOFqa+95R4HGYaSwblN5EX7/b3GPNYvMUgFClc3ygpIlvnReA2B+cgqBNxXXFN5yggiwPBbj6aIstLJGqAUAc+tmAjHEeFrjThz8YpKwFdBjJPQQ6JgZOsMejYD8UdfFQJFR8HCcqJUg+tsLQ+GB8NV6ujOc9feDt2sQxYhX0HZjGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from IA1PR02MB8970.namprd02.prod.outlook.com (2603:10b6:208:3ad::8)
 by FT1PR02MB190376.namprd02.prod.outlook.com (2603:10b6:170:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 19:26:00 +0000
Received: from IA1PR02MB8970.namprd02.prod.outlook.com
 ([fe80::1240:56de:1459:af68]) by IA1PR02MB8970.namprd02.prod.outlook.com
 ([fe80::1240:56de:1459:af68%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 19:26:00 +0000
From: Sukadev Bhattiprolu <sukadev@qti.qualcomm.com>
To: John Garry <john.garry@arm.com>, "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC: "tanmay@marvell.com" <tanmay@marvell.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Patrick Daly <pdaly@quicinc.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: Support for ARM ECMDQs
Thread-Topic: Support for ARM ECMDQs
Thread-Index: AQHdW/IVufeBNcmk8k+S6q/VrXf1t7b9NsIAgAAwUoA=
Date: Wed, 14 Oct 2026 19:26:00 +0000
Message-ID:
 <IA1PR02MB897091EDACBBFA6063EE1F8AA49D2@IA1PR02MB8970.namprd02.prod.outlook.com>
References: <as+Mh1Ah3FFpCZlK@hu-sukadev-lv.qualcomm.com>
 <30683c6f-08d5-47a9-ba0d-24622c3a54bc@arm.com>
In-Reply-To: <30683c6f-08d5-47a9-ba0d-24622c3a54bc@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR02MB8970:EE_|FT1PR02MB190376:EE_
x-ms-office365-filtering-correlation-id: 04787343-5a88-416c-2a94-08df2a28faa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 lCLoranDxY0tbtsogeaMyDavrmK1Hw5+M3M2ILDp11Y9paiHWvIQzm2WPzRjEhYI6GJeBgcUE6j4nBxpYoERdRU3x6w8FeVUbwNMrxPa8+TiZ2UCz88D8OGzKXb4/LteW6F45ir7jJi0Xonwr6ErGR4lSmlGJuvKL1Vwo+ms6NSWp3PlmphTzCZZfiEi6iPTc6I9ccqYTsAKoXymu6j2Zhde/Udb+K1QO5AM+A+wpaOoNo5nnyMnImZO/98cS2KS9dCrlJGKywp2YO3bplVz9TBbcNDBQavf/mv41ErlJ6r8kfn3sOCxLWn2Ycu5CkM+hgNaLVs+n9AoQ9bcwibBwcghiXQ6V4hbrEgUtBtrGEnQR094DUt3W9URi8B5zBIo57a/Stm6MgsiDqazN2AJYkA6CGSea6nYUon4shDbp5e5rMIYTcOWoBzSVWASo/FIie5QVBKFn80Q9+xiY4Wk2C1Oixu9BIKtuwt0FxjsauhQS6DqUU6fI1bDsjkYE6pbGnO8nBxE5Z20DmQe3EOHYCV8/Fs7w2ONzqjq2JcmXgEMOuuKFr2v+zvd6XFE6mTC9RIuiHbdLUYhSBWEw24WzyUw2YY1ZkLtwUhn01QcJVY/MrLC287rzu2nnEzJFNY14lCBIav5qTlqjmf0iHprHxVNHY5zovfEOf564co33wJmWn8q/2iQO2R7wfSMuuK905q3SeWkdmjCfV9WhSEQFueETkBmnKfO3uTxFgJJGsk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR02MB8970.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzMyYy92dTFMb2RmVGhydEw5NTNPRGQ2amVDS1I2MjY2QVJiKzhLVFZYc3BE?=
 =?utf-8?B?UmFydk9JSzhoOWN0bmJoeW0vYUpRbm9scmYvTlp2U1hUemkweTJVVk9WTU1p?=
 =?utf-8?B?dWs2NENZak5TR2NCbmo0T2tSQ2JMS0JpbC90eENLcE9CdDNXVFhDdE41aEhh?=
 =?utf-8?B?ZHVsTFdJTnRMN3RldENlMkZKOWVycTFXYlAxRHh4dG5wREYvQ3NQTndRelk5?=
 =?utf-8?B?bEJxT0pSTksvOGZLWmhoOVVkREpHK1RGQTBnc0tNWFdKWmFJak5FVVpXUURl?=
 =?utf-8?B?M3J0MlQzOE92VHZONTBIN1NobUFhY0w2S0plcVJ6M2duOTFCb0Z2VkNUR2Mv?=
 =?utf-8?B?anI4TVkzcTA4Yy9RTk5rUGZrU1JxQkEvMGhXZEU5dDdYVzRUWHAvMU5TYStK?=
 =?utf-8?B?SWpFSFhaVW9jZlRhZ2t5SFRmQ0RTY0xqMUF6OGd4ZEk2aVZuaEtZb1UxaWJp?=
 =?utf-8?B?Mnc2em1KdmV5RzZ4cTladlNFUUV1VWZuaDk5RysrOGx3RDljQ1lQQzE3UEM3?=
 =?utf-8?B?RVJ5SXUzeHQvYjBDSzJiVm1KWUhHcDVwNUdueWFPYmNCUkxFVXR2WEhSc1lz?=
 =?utf-8?B?ZEwvdlFoSWFBV1BOUCtVdVBHN0pGdldCQUw2REdId2RsMXJuTkNCNmxUeFBv?=
 =?utf-8?B?SFVPL1RQRWZ6KytvbmgvZ2xadFRPQ0hEeCtsQzYxZ3k0SS82OE5va3hTU2tU?=
 =?utf-8?B?NXgzM2lrR2t0K21xUUFUUXZFWmlRUFdlTFdDRlhpNHF5L3FiTzlWbThVMWht?=
 =?utf-8?B?VTNXOFFnZ3graXNvdlAzdzlPb2srSXdrZTRUQ28vWVZjTGZGZDRycFI1Y21R?=
 =?utf-8?B?UVUrZjd0T0d3VUttQnMyWjRiajlHL1ZZRTJaeFQyWlR1aEw2R0wwM05KRnZH?=
 =?utf-8?B?YTg3OHdSVzJwRUkzR2M4N1llUHE0RS9ZZzV3L1BHeHVLcno5WTV5b1NpV3dw?=
 =?utf-8?B?ZVkwcXBWMEZhblFMSGpxSjBoV0lERytvekxNQXhlbldoVkJ5RGN1SVo5OFBJ?=
 =?utf-8?B?M2dTbFBFK29OaitOOGl1c3hQWGtpUExpb0VFdkU1NkIxV1F6UWI3WUNUNXBX?=
 =?utf-8?B?U015TE1KVko0SVJxd2RFWHRqbG9xMlhUaS9qNEpwTnBmZWFXOWZmRlJhcE9M?=
 =?utf-8?B?a1o0MWtEK3lBeHdWa1E4OFVNWWQ3eWFxdTFGVmsvNm5VV1p0WWZCSzR5bzVr?=
 =?utf-8?B?akJ3cGI4MTlRakFaUUpqcTVSd2tYeSttUVJoRXA4YUdMcGo3OTBjUE1DQ3pC?=
 =?utf-8?B?U0NVNmxuY0VlYit6ZHBVbEhYb0F1Z0FaT3NvZzBoTjI1WVZRNzRtQUZGSjdT?=
 =?utf-8?B?Z01nc3lmVlcySm02dlp3bVhic0pkcDRMUHBuWnZUM3Y3amJLdG9qVHJRNkFj?=
 =?utf-8?B?QWNaV2pxNzFTZ0RwQTUzZTZTaElnWlpnQ1FJenU2ZlVKV1VEVFFuR2lpcFQw?=
 =?utf-8?B?Nk1BTjFKT2kyRHpMT000bXc4Rkh3bURMMFdCMUlaRUUzbzQ1RGxTNFYvbXVi?=
 =?utf-8?B?UDVmTy9hMDRxM0d2VmViZW9aamtTR3gyRm1iY1ZwN1k4ejFDYnd4TnVkclJm?=
 =?utf-8?B?S0IzSDZwSWdtamtjSUkzdGdwQXBnSDFkT3VPZE8wQ0dUblprTVRENitoYXlk?=
 =?utf-8?B?TXEvZU1jQ2xCR1dVQUhxa0E1TnJ5ZkxiSFVNM0U4bWFpZXZNbG1PYWVCVDhl?=
 =?utf-8?B?QThUM0wwOThrYmpoMTlwTmtNTUxHUkVqTVdOdm10VE44QWhYQ21sdWdCdjg4?=
 =?utf-8?B?MTNJT0lTd21hY0dkd2h6ZjJVY1l5K2V3N3J1cVA3YVBhUG9yNVRyYlBaVlVx?=
 =?utf-8?B?UmpVMlJPZzJ3KzZzS3A0aHJIbjlpcGVSWnNWR1RlMERhTkZmSzF2RmVFRm9i?=
 =?utf-8?B?QlIwb0lmRk5MSEtzVkhpUkEweDd4Uzg5ckE1Rjd0UERpQ05PREZMUWExdWJo?=
 =?utf-8?B?di9wNDR4aHV3eE1HVVYwMUtDaXAwOXM0bGlseVZrNXZuTS95NVIzZklVTU9N?=
 =?utf-8?B?YTNzSEd3aWIrQUw0L3dheEZMaDRsUUNTa3ZqTHJTVUQ3QnhYdUtrQ1grczJr?=
 =?utf-8?B?aExtSWpwNXNEY1c1azlTdkROKzV2eXExd3lxWFhzTmlFdjRkdnA5NW1CcTN0?=
 =?utf-8?B?RGp1cWFrbGpUSkxkZHRjSUkvYlNvNnBWWVlCbHFYNE8yZnNBZXFaQjNUTXBX?=
 =?utf-8?B?Q1FOb2ZFT0NlekthLzB5eURrakwvOTAzVklDVmE1eSs0VjRWbHNFNnJQbjBV?=
 =?utf-8?B?eExwMVhyK0tmUEN2NmU3M0ZZYk9XQXRvR0xDNEFTTVZWVXVtTW9sN2grOEJw?=
 =?utf-8?Q?UormJBjpv/817H1FVe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	O/jtNqGUR+muVRGXubrxqpYZUvPtTRvN1C/ysU6Nu7JSpA74mGwT2qCVF8F5Xfuar6mPKXmScyYH9KK9Hf8lQehcGRMtdf0B2JjSEH+UEg92nMiqN17Y/dBoYw7iJlQmMzi8XFaw4I9SBSjD74qRO4oFI/XzTb5UCEApYpwlYYZ8OczYjLUj7nxxPXUzaRNr8tb1ww3BvzzT9JlCi9+Z42qpeYN2Bm6BMLK/IqLVK7lOgj6v4Gt6avCUq+2bWq5LCa8z62zivhpRHAWqqU0QWeiYeLiKaBU3/mHcC8Qtu2vW7NOUdl73KBU+guR4iXlwT6jFmeXzcg40p0SR20oBKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/mHAUhqle6dd8Urrjh/okWf76SG2P8iEBXJMS+sPl7d5fbqDCi1kzfvkHcJCad6DVBC9kNdj++oXhWRmMhGxW6u4OqeK2LJ/bT7I6hrIRcffqhVpHt1NCcs6kHWGz+gH3+TaaAH0ZY/podJbEK6pIdisXfm359oOKAk6Q3kI/khPMzZpmo7d/L3CE6gSIi1CR+pYNHYHF4KX0njAZDkgwi//PpsnfLpsKBVCfZ3D80/SE/Y6eyntIU1WO891sJmOhh71wJ60ueivqzxUTlixrg8AAlGdscHOG04GmnzK32eDJd3koPCVO+QFyjr+/HigM9BoCNRvRt1CMQZCGuEAAGJDzGD1Bg7YLPqBUdxMee4mVhVf7JqXGyTcUGhTeAO555J+yOD358uFjzohGm26OvPUiI+FhffeozlBOmAZpWKUyPa/tBCz3kf4lf3p+XDnKtO55VZWE6/hxdTkhyGwJhBoawIOkA2sD6XDJWfcED+ecCDw5BO2/q143z/3bBrnS5cMrZNi4BqJPS8WefJqBSSfwgJTS17T+rXyHa/K6XOY9tekY6VZlpTO3LJQZ3fyeoXkFCn87VX4abMF/TdrtBKbxwFCd/+ygrC1xEucJo8+L5DnUjtltdrNVBalZ2qJ
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR02MB8970.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04787343-5a88-416c-2a94-08df2a28faa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 19:26:00.1309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ujg9ttdn5LDqFIrkeCR0OUl5NuP4TgHHZe1BjtaGVPT5Hw1taMQIPWrS13KYff6ZDTdQz5TVYEY1UnF8YA52oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR02MB190376
X-Proofpoint-ORIG-GUID: Hn4Ol7nSty8C2eN4n6Mxsf7ko1zYgtxD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NyBTYWx0ZWRfX+ljWZsAlajZR
 PSDagDqWAKML57lnTaAYp2IdLMnE7aKYvgGm1j0qA7b/gMPTYz5prhFI3im+oB1Z5bGF+wRMAHV
 or/Y40kcyFwaK7LsKo7bHT5vTxKMSgTyMk+51bPY3Kj6UCbjLnBhdY2/2rUtYwyibXIThgZqh0w
 YmdJxukLRY5L46a+0dywrjIQdikzXDLKIjG4WbBSV2Riz7sUOftelk1Yv4mVVvN7ZCzb4LCom6z
 cExQb/VNugcv3hKn8uH3NSac+oTPgfdO2EXl3tTsm5Ei45MCfegNhR3aMTyQED70lBIJqo5jUL+
 +f/7yXa/Q6zLOHxpIX/G2FJ2xy7BJkYlc6jPOc2DKnUSq1JwvMHruDlRj2VjUnct6hEs5lF4Vpi
 p/ajJadlgmvB5z97weur4COLuFHoOy/XQ3ve9d1V5zER+ANeQog7YBjCL18+zKaSPbJTZ3xnyEH
 OjzkHisnaKntpEhkRXA==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acfd74b cx=c_pps
 a=vyniI6In/5XBr/U1JZq+ag==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VPW9pYw8AAAA:8 a=sayeJbNLbkiLeJ_H_-oA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NyBTYWx0ZWRfX3UlxzCCDtPOD
 6BsVF06y96EGY8tWpaengCbgIa0bmhrCpVv+V+Rf8gGaeNxGe7gWSyNBWObB2B1hpA2fEO3/AeI
 KvkHkawQWIp8+UrpNeb5NmMXCHacU+4=
X-Proofpoint-GUID: Hn4Ol7nSty8C2eN4n6Mxsf7ko1zYgtxD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140077

DQo+T24gMTAvMTQvMjYgMTU6MDcsIFN1a2FkZXYgQmhhdHRpcHJvbHUgd3JvdGU6DQo+PiBIaSwN
Cj4+DQo+PiBXZSBhcmUgdHJ5aW5nIHRvIHVuZGVyc3RhbmQgdGhlIGRpcmVjdGlvbiBvciBvbmdv
aW5nIGVmZm9ydHMgdG8gDQo+PiBzdXBwb3J0IGVuaGFuY2VkIGNvbW1hbmQgcXVldWVzIChFQ01E
UXMpIGluIExpbnV4Lg0KPj4NCj4+IEVhcmxpZXIgdmVyc2lvbiBvZiBwYXRjaGVzIFsxXSBzZWVt
IHRvIGhhdmUgc3RhbGxlZCBkdWUgdG8gbGFjayBvZiANCj4+IHJlYWwtd29ybGQgd29ya2xvYWQg
ZGF0YS4NCj4+DQo+PiBBbHNvLCBhbnkgcmVjb21tZW5kYXRpb25zIG9uIHBvbGljaWVzIHRvIGRp
c3RyaWJ1dGUgYXZhaWxhYmxlIGVDTURRcyAtIA0KPj4gb25lIHBlciBDUFUgYXMgaW4gWzFdIG9y
LCByb3VuZC1yb2JpbiB3aGVuICMgb2YgZUNNRFFzIGFyZSBsZXNzIHRoYW4gIyBvZiBDUFVzIG9y
IG90aGVycz8NCj4+DQoNCj4gSSdkIGV4cGVjdCBhIHN0YXRpYyBzcHJlYWQgb3ZlciBhbGwgQ1BV
cyB0byBpbXByb3ZlIGNhY2hpbmcgb2YgdGhlIGNtZHEgbWVtb3J5IHN0cnVjdHVyZXMuDQoNCj4+
IFRoYW5rcywNCj4+IFN1a2FkZXYNCj4+DQo+PiBbMV0gaHR0cHM6Ly9sa21sLmluZGlhbmEuZWR1
L2h5cGVybWFpbC9saW51eC9rZXJuZWwvMjQwNC4zLzA3OTg4Lmh0bWwNCg0KPkFzIHlvdSBjYW4g
c2VlIGluIHRoYXQgdGhyZWFkLCB0aGUgbWFpbnRhaW5lcnMgd2FudGVkIHRvIHNlZSByZXN1bHRz
IGZyb20gcmVhbC13b3JsZCB3b3JrbG9hZHMgKHdoaWNoIG5ldmVyIGFwcGVhcmVkKS4NCg0KPkFu
ZCBJIHRoaW5rIHRoYXQgdGhlIHByZWVtcHRpb24gZGlzYWJsaW5nIHNjaGVtZSBpbiB0aGF0IHNl
cmllcyBjYW4gYmUgaW1wcm92ZWQgKGRyb3BwZWQpLg0KDQpBbnkgcmVjb21tZW5kYXRpb25zIG9u
IHRoZSBkZXNpZ24gLSBpcyB0aGUgYXBwcm9hY2ggaW4gdGhpcyBwYXRjaCBzZXQgc3VjaCBhcyBh
c3NvY2lhdGluZyBhIHNldCBvZiBxdWV1ZXMgd2l0aCBhcm1fc21tdV9kZXZpY2UgdGhlIHByZWZl
cnJlZCA/IE9yIHRyeSB0byBhZG9wdCB0byB0aGUgY21kdiBpbnRlcmZhY2U/DQoNClRoYW5rcywN
ClN1a2FkZXYNCg==
