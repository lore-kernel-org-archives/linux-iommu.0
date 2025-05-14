Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412D01F3D2C
	for <iommu@lists.linux.dev>; Wed, 14 May 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747201972; cv=fail; b=F3Ypg9XiLeuiLzp9FiP+Nt2oks4hksGK32UK4Pd+J7xp0uI+HePx9fdWWdnewP5RhqIVPsbOrZkSPADvtPBf22pcccvkaI6naHw4zitfz4GIF8Y3w2fzrxOf7wwzYH4fWD+HE9CfnC5gFRz8kMt77Ol0NyNOBYTfX96RWVw7kzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747201972; c=relaxed/simple;
	bh=Br8nz4ic/u3+X1W0/P+UcB1tUCBGrxw6tCRPDySGdQ4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K+xOCspmJv5+aWgK8Xm6HfAUeJP5/xwzsnuCjgQ6iv5SCVd4TGmsIC0BkumvODPdoYaKJRClalCJ/vG2rf/SH1uJpVrUyg0PyQM53b8N1JW+6wnkhY+g26vUJjGPWe9f5bKfii/C+rdKa2ZycFbpgybvnijhBC9kjWfWHMlk3hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cbC/6JPC; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cbC/6JPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzKHmvTNe13/O/7znvUaGD2vCIr1Z+A1jc5X5JsCRFAAbvLG2BCM9TGQjhMcdOe43befycl6sdQ6oJfzBeY6nhmrB3ZlUlU++ZREOq01yVaNtBGtrl4RqFXUUNsY/2BwEO8WbQcao9q7Fbfx+Q2PKvGn/82EbYGyPyECdFCH8TjpWqfOhiZE97IfTr0V/pmfzUQz5D1fbz3c8z7E6KCmut0u3UqP72NiDvdDvlhO/0NaYwCccaewkPgv1afges0UfhmsWAcQ/CLmFYREFCGf69OXkOQfoYTctSZfJhjswd3xvIhOqIiNnJVqi1ePRhPa60srRdVAwj5W/MUa4bio6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br8nz4ic/u3+X1W0/P+UcB1tUCBGrxw6tCRPDySGdQ4=;
 b=BA1NfAFiAQT1tJaPi0eUqVDKyFYTBaevCdnfJraS5qzTDio0fI7m1twv+q4Zong48F/YRA3FXBGVjLvDukmT8M3v8GK5epQJhznoHT51DrK7/V5bZ2xaisjEm6J0nU9GUMouF7OL9/QbhPZMRcI8dCbBKYz5vmTmk+fOEIjwNrqgwu2IcWNXEB0KBH+VeRypo3oTZ5gc8xl7uVtOiObPrLXjD7jIh3FZiaw+yrl/dxF1NbxqU9KEPwjPN0L+IeDWG5uQavj/AuIatcxTPOTZcdHf4s3eKvz8A8jhUcdpO4pH0/IbDb6vaNeVdk2V3AVhnYJclTzkgpkRTYvTvVp3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br8nz4ic/u3+X1W0/P+UcB1tUCBGrxw6tCRPDySGdQ4=;
 b=cbC/6JPCBnMXGqlSZp4apUpd74CKWv9BZTkWZ9+b0PpVM1CRJR7f/bTL/6aNuQ4ZV6YptzqQEBD2r8Q/aziAFeWSYZuGJhuXmE1wDQt9filc/YYcqMzumCS3PCu4F3Tbah45XXBqI1CyQecIGERhHvOB5K6uhkBf5Sai8OaHT2Ht+pEVx2eXo5H51qvwPMV72iS4e0CaN7GNMJOBvXsjx/AzIWwl+GCILsyv6ybfK+5YIO2CaDAZdttgCViI4yRXYaZpP0RILIrkiMoRTHaqRH3Su9B2IONKGP4DbexKDS5tOFFJthaN2XR5zFag0KHQ+Dk+7bUPAklUQPzkFnwW8w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6584.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 05:52:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 05:52:45 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] iommu/vt-d: Restore WO permissions on second-level
 paging entries
Thread-Topic: [PATCH 1/5] iommu/vt-d: Restore WO permissions on second-level
 paging entries
Thread-Index: AQHbxJRqUiHP2/xsvUKaG+aLdkkj7g==
Date: Wed, 14 May 2025 05:52:45 +0000
Message-ID:
 <PN3PR01MB9597D59895582119A2F56928B891A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6584:EE_
x-ms-office365-filtering-correlation-id: efb48ae7-aa1c-4c1b-b03e-08dd92ab8cb3
x-ms-exchange-slblob-mailprops:
 bHQ38DpbEWBliItO3MnjFqexImzWs6BA1dwJW86W4JdjAY+4//B7AErWSZB8l9h8qY3Bxg7YvHPryhFkfIcEOOqrjg0cQDxOSpCLRzNa4I+4GzsuK2kB3K9StEwZaLxewvHV6i5V0tDiOSUSfymbPLzBsz1L3P/x15VcA/8OFs1wP4ZnioU5esg53rzEGNB3VENrBnTynzLv3cKrSfybtysuAIwCG11WBygXc8G8h4wjcGEMLAQbVGLUP1lYiGhfm4hf2dC8uFIoMsM9SGv1lvhZ14yegpzah9azQuVwUCYPNarbHZIqzeVAiZX5pp7q8uiG3zXpUTevxFwsDOexDE+1QFAxUruoJO7qqyL8eXrZ+IMF+HuAShi+n+rPy/kq5WaOkt7WoWvKk/qwjAbVW/Dk9FMiwFgV83uvbPeheR9FVBHStynRAryrqVmyTZi5q1tCom7VZFu76AD92IEG/80/IApWIDHiJyZGHRVZn77CGcKEPt1vca3TU9Q0XaTYXOZRY0pnzQy50NlJ4BxZnCJKyl2+0OM2b6HgPy0Qk3MGfZN0AXMtX2PnCxSkFu+a/ijyr+JurFv/LYOuaB8s63O2vaz66p2f6XzAcaOT6YiKqZz/izjdghIgu44HWMSVIOlvT89HiYHDXvEbNG13sU6dvO8QEQBeV5zShsRQqOY38/WE5dQgrA==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799009|19110799006|8062599006|8060799009|7092599006|4295299021|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tIRm2Qiq+F6m0PCKbB/Ppt+bGcNgYdlN1tH0rf2RSV5iaWnhEQs6D9nSfzql?=
 =?us-ascii?Q?yKcRLZb9Y268vOt1F7j6RGXPfRMW4XR0ab/CbVtXXHb5wfbcjzQUPx9txn2Z?=
 =?us-ascii?Q?cKsi4aDzIdEjv2cbZFduwXCj+3e43g8piebAlMXJB47k6ONmdA5jy+o8eqXi?=
 =?us-ascii?Q?n5Nct1cUehWpjGBpVqM6RkvmTea31gnpVnVwmih0bkPzvWldcYcphGbgmUtK?=
 =?us-ascii?Q?/qvHRk/EFgDmGUAArimNs85VxDEdiJAwW87MGv4e8LTYHq6x2vyldI8+v6Cf?=
 =?us-ascii?Q?ChnAOtJLS8MMwIapusTz1f0YKWD2/ywqWZL5WnEEWVVEQOOwHcuBVRG59ZwH?=
 =?us-ascii?Q?QWTlfvobRZZJ89m/JycF5b0RasbGZ8CFviBv4jKtjtKKPLeIOsodQxslPzvI?=
 =?us-ascii?Q?6ArjD9lBCIPy0Zzd4XgbZpgXS2L2ckv5Mud6RXUytMuLcYd27mI1kfWn2e6e?=
 =?us-ascii?Q?/5FrjFbzd7bOAGYP3MMS5271vLur6NdAkyK9+bWMw8f4lv8MT2KoryiPaTwj?=
 =?us-ascii?Q?3a5I5aeIwS2alEwibvaPWIHyvLUsGNaB+Dg8Lacp28LbJm7H2LysBQf8mgBy?=
 =?us-ascii?Q?inC7bJBK3Lk8BedbzdvEHtzl9WMT6InlTcmqueADeIVG/hQuKaxTMU3KYUN4?=
 =?us-ascii?Q?r4WOhc/v7bNPUStD0893nbsmeEafOLtlWQVxqRVV4rgYkITc8fX5mkDS1KXd?=
 =?us-ascii?Q?E4f1okqYiJh9vdbMfTf5j303QzQ7yXNqnPMPfPZezKfasc7kFZjhISnY7CNK?=
 =?us-ascii?Q?KgPB8vAsNLmNAulD6pf7uG+4FTD/Y1Y59cm47l2GPbPEABDW4O6/U4nzA0+Z?=
 =?us-ascii?Q?WIdpk06UpbzINW0ZqMKSWIga2GQNQsFJuRFnYv5VngBmc/SqH4KvbmxFfVY7?=
 =?us-ascii?Q?+KVs7Pv/hIQX213FgNaVlcTxBXIZUoVjM2eclStftB74QbalEdFxqsxXYMx6?=
 =?us-ascii?Q?70Qf6hVLVu9uvibBWHWA4DoPZbXhemDo+6qZ4GOLzxb+K8i4ty2dN+2twptf?=
 =?us-ascii?Q?FJp9zZZaEcwuUpOTyGiCBpP+Ladov2eW8xK0h2eAkpWW+eyghoAavln9WubI?=
 =?us-ascii?Q?FRTZhzMzJce/LUtZUZgZtafSJl4W+VWJqMK14K/lcvfsDdPVFhc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D9/rUD30FrChjX0+IIffwvjKYOyUjDGJbxWAjb1QwPTmX0QRhLlSPHdZhur+?=
 =?us-ascii?Q?NLPyjyfhXm2bKoRMB01ljWb5xFkRIxGVz0xbYbaLD9Eai8MRjJT5+83m5epl?=
 =?us-ascii?Q?Ib6LuIUeLE76UdDk0Ad8aZec96jO8p+zhevRgEp+25rXK3w+v9H3lzaA1v0O?=
 =?us-ascii?Q?bSYdP2JKvmxJBu24rBB6EKnokISh6j7F1WkgYw05BFgAEn6lYswWwkcnmdF5?=
 =?us-ascii?Q?km4BV2sY2wwlO8Z8sEiW26X8w4v+hRqOQL+BVE9ldsNpoSF2eb4PaTjr7mVo?=
 =?us-ascii?Q?WJ6JLD5XSsZTzRSfJTMgfwn1xCOMkgRrCf5/qjTTAZIFGQ0Bld/p+Q24sWKh?=
 =?us-ascii?Q?xQ1WVaivfVpweUoExm2yMaStHOV316oI2bqD6nBJTajX12cF3KBnmByQPRgw?=
 =?us-ascii?Q?pLFoef+92ThZs9kPgW1Lih48556vAyXQzTUeXSet5ha07CkmawO9z1Yb7vk/?=
 =?us-ascii?Q?ZfXhhj0viAUjQ6wyl1+sPryrFB3UG3EG1ueQCtJTx5n1AclgZf8BDywSGz2i?=
 =?us-ascii?Q?tAwnkP0pq3ZOByc6L/oY0STltsRkTY+xsjvHdWvuDeZnXXoRk+0MYD0hL1Yc?=
 =?us-ascii?Q?sfvqQlIGvIOO1u7pNO5/vvsUNHqysdaXHecIjxkBoW3gp9LMw7b/Y93soN18?=
 =?us-ascii?Q?18Ot5I1dnHpFnFNHBriXEC9sGcyG+smC7H63z6q+IPYOTJjFraHXwZR7ILKW?=
 =?us-ascii?Q?D73QumCqXX53iizrNAQ2aoapXZ8jV3AXle9hZVzZa4QpjJlchGn7AUohf/uC?=
 =?us-ascii?Q?kCxETcFza3RQFvrbojd2k9DvkaO2apxn2xZmOdnyMTfwg9lBBsZ5c1R71E6M?=
 =?us-ascii?Q?jPUiS1xkMWqo/qna1EPKA8XUC1a6S8UEHEqeqxlgOHJIP30wNzxfi2XXN0x4?=
 =?us-ascii?Q?EWNpYjotuZoF80Dnm4iNrZbNZbddwyFfYCSR5yiC4xflzqSWj6zSDSXMMhie?=
 =?us-ascii?Q?YQDIo3QdtpkfhtazEBixS9TJ5INsYTvJgrVnku3JPEBq2iOcPEBn8Z/sc3Co?=
 =?us-ascii?Q?RIuHDTO/LUw/+rCgpl3Tp1gFYKhIv1rVV2nw571r7Cv2J8494uprhhnbgV4W?=
 =?us-ascii?Q?08e4yXuUCZQJlDcQdjls4n/qKQuPTTkJrvnnpkHZhq7JmDgG0K23w12FO8Xz?=
 =?us-ascii?Q?t8LrhpzKyuaUDpxKcDRXF1O2P9bhso6CWKN1HbwQTcaTrZI1eEUaonOLY5GM?=
 =?us-ascii?Q?VhBTffJAUA8kdr6d6nTdAGCsz6PcS80it8zz4zFwMy7V2xylJQoxX1wtPEo?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID:
 <B9C268BD4D7EAB40A12D7B3AAE2FEC90@sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: efb48ae7-aa1c-4c1b-b03e-08dd92ab8cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 05:52:45.3929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6584

Hi

Since the original patch which this patch aims to revert fixed CVE-2021-470=
35, I'd
like to know how is that managed now.

Thanks
Aditya=
