Received: from smarthost1.eviden.com (smarthost1.eviden.com [80.78.11.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30123ED6A
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011655; cv=fail; b=mbBtAqdvpsk96U73KWVKQs+8f/dgeKaxA66gL2dLgSBoDLGDHdYA4HQzpUXVCgI4EOXDK8agbmT/oVZFtcHJyfF7awkvGi48/3l6Td9G42CK+xb3SqAmPsiFd/p6QvC+Sob2IT/XG9DZbiTGnr75W8u2yjjvpN2yw2ATz6Cy11Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011655; c=relaxed/simple;
	bh=mkg8034HY40R38QqgJr8h7szsiO2YzrZd6Mkf/a+g9k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tgOI3Fw8Vl2zH86/BSmNK6ZVErYH3VRn0CVl18OZdZyIH8QAxf4AvH5r6FRkUI4zYPgybRbeuVranqvGmSHlVoZMXXmuY+dfymIAos1fswHvu8edVRGDqIZBMsU5Wnefoml9euSV6U/jJFftPijcGjmlOq1yCzzei65oweabz3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com; spf=pass smtp.mailfrom=eviden.com; dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b=E3uvusJ1; dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b=Er9hsyFd; arc=fail smtp.client-ip=80.78.11.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eviden.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b="E3uvusJ1";
	dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b="Er9hsyFd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1752011652; x=1783547652;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mkg8034HY40R38QqgJr8h7szsiO2YzrZd6Mkf/a+g9k=;
  b=E3uvusJ1Yp5y8m6RQOqVlyxKR3dQFH0Gss6iUJXSRZlLS2/FT8oF5oBo
   +JUxIZBotDHLzmn81HZ6ekJ2976ofi15+5/St4las+0qffP1gz4clf3TZ
   3cjC4Ahn4P2gSQn1RHtJdxWFCfEhu5WD3ZDN4/7tvCUowudWKXYcGQwt9
   jdR5mWZA8Ipar3Z4lVfT29VaWoWMOda59su9YUCZFWTUYGfjBswW8a2DF
   4WBCCOGk/u41OzvU0aEK68EAiVc9QcIaJJ6DAb+BUd6CcxHuhTihB55JI
   V2aKwpzlPPfdTuqLp8JeNSXH2wuXgedg2heaKvB5YuuIudJhrjmb1yroy
   Q==;
X-CSE-ConnectionGUID: XEG/tFQmSTKY0CtzTDJOTw==
X-CSE-MsgGUID: z7JsSrmLSmapXB4Wik5lxA==
X-IronPort-AV: E=Sophos;i="6.16,298,1744063200"; 
   d="scan'208";a="40047425"
X-MGA-submission: =?us-ascii?q?MDF7kXZ4xUBPRQ/8Vaxd9KPl0Msed6aPL4wIhl?=
 =?us-ascii?q?QpdT4u2Rz2F4OYDPmmypf0c+F6pd7lVN20/iQs8sD2tfZt5uxYO3cCsQ?=
 =?us-ascii?q?GqV1jyEbi7UCBbX2zvNZsCLgCxpuOFilvTuqkuQ/r+wlqHduNpnkT/op?=
 =?us-ascii?q?XRvN4n+L2VnI8JfcffCBMa5w=3D=3D?=
Received: from mail-westeuropeazon11011035.outbound.protection.outlook.com (HELO AS8PR04CU009.outbound.protection.outlook.com) ([52.101.70.35])
  by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Jul 2025 23:49:00 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nsw7r/4Qel+NjkMZfd6R6RV2hK1oIbTAC6whdJ+a6Z4GZ7Sl8ZyB7/xe/d5iXPb7fpJaXB4WjjLGDQSz+qtFiEsUSencQoqm1Y+w7yPbvli9e45Sk0aBSz1KyQEJ6/Etu5D6WOiMWLeTsatwDLuFnsEBVOOyclhKxnHz31jCfguUwzIqm61AfYG6pHRACYtdfR7uvyezKoADa9xgROryhJ1UYVCMwOQQHoMiVN0UG/zDPlurs/RnSQYXTjvpR+cpLxjUeT+8f6r25DfF+W0g19fuWrZLhoCSDpqxRVDEJTD7U1sNawQbuRyJqjjPBju788zGT3e6fIJaO3Qwxmlz7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdcDRcowWlbzRROcQcBK8Psycxt69rKRJoe+efy2o8w=;
 b=cIMRjBKryLGqljRtj5eWfc3w9/ToW+bNfpV2noN0tZ5a+0I0fMmyOt8D5hhB4zW8UWFSM1wes0aX1hkLIt8s/bYTKL0KgoPBdXQ2JlDEhrTOS4ftajx9y/FdervGimQAvKYy/OHE1SYTeIzNCaAnH6YWDy0UTfmqdIIIcbkCAEloj6uP8Lv93hLIQsxnF9oEJC4alpskvFNcKQ6N0kmolWVuKMhnO30rn9/G/J9WMN6uSo6ELyWh+DljHIW9qTwAKDi+kB4/KKJPsLytruEeQCVW7ayhkgUCBMMwzfLPKhcu5d0uCFx927CvLt/1dMoj8IcK+M15tv9410is9Q/b7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdcDRcowWlbzRROcQcBK8Psycxt69rKRJoe+efy2o8w=;
 b=Er9hsyFdoz9TfXLShFMMzlughhhD0HmwCAdmx2AA4EgMhd/beyXpvWhu0ouQJ6E4I9ELIGqLaLNmP9OfYYDWkhfCyWt54jRuoRCwvHiZL7m5xRVQysMMvkGHMvH5fH8ZBa5IidYYPvrA+hxc4P4557/BCAuhatQlGNTIgt+v+C6hvwefCrYYrmfBYbLJ/O+c9dO3492ea8evxZadbqPNQI/POPPCPnY0bCbKktMC1WxJW1YyjMkNDiugk9VVV60PjG7q93KqkKeSEr3SfCEs8ykZXruCgfxImAWRBpS6cNpG2HuPxEBhRJpKkEtHTKx9p0eF4i9J1JC1qogzZZcT5w==
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 (2603:10a6:800:2b4::11) by AS1PR07MB8456.eurprd07.prod.outlook.com
 (2603:10a6:20b:4dc::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 21:48:59 +0000
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5]) by VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 21:48:59 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, CLEMENT MATHIEU--DRIF
	<clement.mathieu--drif@eviden.com>, Ethan MILON <ethan.milon@eviden.com>
Subject: [PATCH 2/2] iommu/vt-d: Deduplicate cache_tag_flush_all by reusing
 flush_range
Thread-Topic: [PATCH 2/2] iommu/vt-d: Deduplicate cache_tag_flush_all by
 reusing flush_range
Thread-Index: AQHb8FIcrKLxrDextkKSlHvtVWu1RQ==
Date: Tue, 8 Jul 2025 21:48:59 +0000
Message-ID: <20250708214821.30967-2-ethan.milon@eviden.com>
References: <20250708214821.30967-1-ethan.milon@eviden.com>
In-Reply-To: <20250708214821.30967-1-ethan.milon@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB10776:EE_|AS1PR07MB8456:EE_
x-ms-office365-filtering-correlation-id: b443302c-59a2-4e4a-e039-08ddbe693efd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?vw493FmS6UytgNx09cjsMCrMiyRQhQ29JXhdZrg6z3WZJ+5gzSg+irA1EU?=
 =?iso-8859-1?Q?4GUfifwNBa3z8/3dqXwCmDfb/IQ4kXxvGg5ERf2TuFYX8RU2u7Wqqb3kRj?=
 =?iso-8859-1?Q?Heh27i7gQ4Xxtzp6Wm5I8zc9Ddb+BIowHD0IPjbTvfS7rlWKst/NGE1IwC?=
 =?iso-8859-1?Q?lecN0qmpEIXLOqSRt0xGiaLU5Owya4cvM8okOMLu8+UrrgMCzu51luFqGY?=
 =?iso-8859-1?Q?6eH1eytSvAdklHnu38dnCZEFEFPK1fePwORqM4cNIIhpOfHAkukajnp+eD?=
 =?iso-8859-1?Q?mQfPiLxw06CP5r2St1ubT9PJxu3uMLP0wTfaGVQt/ZP45bj70uw8/8TyOF?=
 =?iso-8859-1?Q?oEBJRGvINYGGDaftoR49hjsKM+Mp6Mh3mJfJxT2m/fBl0h/RksXutooogb?=
 =?iso-8859-1?Q?3TBfJmPmV2VybNhxi13xSatnF1kMvHS+fRWnOMStL565BDcGKNp00Nbavk?=
 =?iso-8859-1?Q?NTbtm1Vw36PIbfk2yGSw229dXfnGBwtax3Ek6+rdxLaxOS25SaBfnZ9F9f?=
 =?iso-8859-1?Q?EG7cFO6iEh3ppiHShMFHw61CaeoZ+YItJTG2gaYSE9GKqawZn4W2BK9dK1?=
 =?iso-8859-1?Q?Z+kNnZCyQycE5MgWvQYRQBvfJN9XdNDXnkDnLfVsl5fyCNWhhiDhqXQuzs?=
 =?iso-8859-1?Q?EALO/8ei64dXnyptwD5CRgNFHQVxg+c3anXA1KfSrN4txXLSNGuswf++Y8?=
 =?iso-8859-1?Q?8o9VRoGSMXmdfAzZ4F5l4O4NOYUh4RZsNEm7PWSpEc2l/lFe354SVIN4DU?=
 =?iso-8859-1?Q?CGSL0wYtIs+Z9GJdDTiakicUzdKBQDHLXM1+CGg91rsBpZYYacdogcUIM7?=
 =?iso-8859-1?Q?FRL9b2EKMOA7sNUSe9EwOuxWo+S0LCJiEQShuCM0kdK7GYNT46JW3n8AAE?=
 =?iso-8859-1?Q?1sU24g/YHb8pqQjv0g7EEZFSzoQCZ0+xgvf1F0mOHowptoilZaH7cLjDSD?=
 =?iso-8859-1?Q?qPi/t1Dtp8FtqwwsCrafWxD2AimozROGolSF2X/9i7XTeHE33vjzpr90JG?=
 =?iso-8859-1?Q?tieAKU3MgPCP+RBc3zNfXl54U85BIpuyojs3VwcqZBZNmlLcoStqcJR4pp?=
 =?iso-8859-1?Q?6QLbecu9vCIG1JvZLAQpoY62b+jcCQaKKRF7GWzZaSqXwFwJ6iEjA+9XGs?=
 =?iso-8859-1?Q?Ky8CtMYBjHLl5eLDqIh4+9dtsN54Q1tM2u7I2Yo0fXsA9W7expFgvDhAf+?=
 =?iso-8859-1?Q?3z6daI7ZEcYJHLVhWWbCUjWnX/viUE02i2IA2EflZQXGbKD0Tpqm38BIlk?=
 =?iso-8859-1?Q?hXy90EekvNYQMqzJE7OTb24GGfFuhSXppDEmRdRjKj9ab49HSytw6THE9V?=
 =?iso-8859-1?Q?qDFf0WcR23KyBdxrT/DCpmTC5uiI0eYD8zWuWpEVnq7QfEvcjTdpCD8Wjf?=
 =?iso-8859-1?Q?vvaYXYGsxJI2y0C8ZAuulNenTeL1einzqU+1m1FV/cWn88V1Kn3l1CaBxU?=
 =?iso-8859-1?Q?bsxZ08uy+2oYwQoJAqKk3Mo0+xHI00GT5Zi2xovR74jal7mIwoAq+wKQ8f?=
 =?iso-8859-1?Q?zCwOTJTwKJBHRbWxnPV13wqR9fMfQJT4Nws/XFRog1tQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR07MB10776.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yBVtOf9AQAU74A+HwTMGXdoQtpU47EbZaNXW/dRBEP2SRlhFDjXxWSKGs0?=
 =?iso-8859-1?Q?k0akv0NTN7A9n5IhHtpc3YD5FvDhG0CVR6mcIZFZ2dZrtSQ9MJ8gWuI/zT?=
 =?iso-8859-1?Q?IQRvVcLo/q6HV8aQn5vpvGM2WPzIHnzU80rw6ZtNuOvUXK8AG2UxBWaNGc?=
 =?iso-8859-1?Q?mKF0gUB1gVgBNFU/5HR32gpGKJF1pTNtQClJqH5RUTclow2HznMuL8sA0S?=
 =?iso-8859-1?Q?uH+/LmniMklT7u6BdAC9GNtPlELK5Uk4UheWHupMWEnHxkuekYqmPyHdSQ?=
 =?iso-8859-1?Q?zvbwwQNLoqZfEPQ4lAPWKWyd26reP7eNTlHVxIeCrAFvC9PBWrduNg4dwF?=
 =?iso-8859-1?Q?rIy9F7MWsaKxk++pkhJ7ypJVatjpAgc9UkoAJGaQ5vnKxpMT1ZcYDodUwP?=
 =?iso-8859-1?Q?FAPk528LsBU+Z5HPA/jzUpe0LlDyXGPDjqzAPYHqK7J6e3ULz+/wWftfNa?=
 =?iso-8859-1?Q?n0Bwd+LTNszVOMI80HV6BzCckgKZyfeNJgPQ6+AH7oWVhG4plOXAr8gfZB?=
 =?iso-8859-1?Q?jtyaP5fWKnGugF+nvj2V9X8nR1IYIbYeuVHKcWmDq5mkV0bpicR66WXDJN?=
 =?iso-8859-1?Q?rMOTjesbTdSVTkk/gTDQrEmc/ceqP+Wefqi7mi9t98eUHsini5t/NZICC5?=
 =?iso-8859-1?Q?JeOrZwWQqlwCx8yI9tL6alTZcgGxQiKyG5Ix1jvGkJzjN6zGAJbF97ag0d?=
 =?iso-8859-1?Q?wB/xIDrx+FAQr6QZdLuLgxaX+Bf9JqVv8+v0RCVeeVKvgLbFL1yRi7tEwv?=
 =?iso-8859-1?Q?wsnSyJtgiGH8HpJo6gekd+rzOTL1TH5KbwBsUDqXmY8aW3IbwT9shJDiFV?=
 =?iso-8859-1?Q?Ki0lxGYGz8RYiKp0C/Ycl5+WvTMxFtpL+k8qYKYam6KK2jZbDIh0vwTJcZ?=
 =?iso-8859-1?Q?6WPLx0cGZ4U/2PqRNYaGMlq+3aVqEZtLUUHcUF5YBs/JNKs6XiWMXf4pm0?=
 =?iso-8859-1?Q?L6q5mJ0J5WbG7vCwsPdGxuJ+jphHTvtv7IWTXXEsmemA6bjqkd5cv78XWw?=
 =?iso-8859-1?Q?8WX0YdC4lD/lm97BRGJSIqlZcLBJHeCRwSdMZjIJW+7dPimjdWHoL7oXMB?=
 =?iso-8859-1?Q?cYgqjjwGCG9820Tj6Wv+oHYdQA7EpWuESrRnZsrVIprhaoQ/RgvIo6l3fY?=
 =?iso-8859-1?Q?dM4r4At3x9W6kv3iGfWkQBIA3AThpkA5ekXS6kYoPD3VFxscYlOHKjz6ct?=
 =?iso-8859-1?Q?Ro3RpbjuAdbosKHFcgOPuRckszexpY1ZHDMKht/Xp2CKbLYng5TZjgso4x?=
 =?iso-8859-1?Q?LMyACT9jyiDuYzM1ufQ9JuoXGZ1a28Ue6NGYqDQ2ZOlGFErewLaDF6efVF?=
 =?iso-8859-1?Q?bE++8P00DkabahxgY/3o8fBTPQLYtvotZarQ3GrUR69bJWtDuY4Q5MKo+O?=
 =?iso-8859-1?Q?3LeSvgqXDs7Q8S7MhSOAc14oFBGKdBAVDWBEkzo6XrzBK2ZoDNAeZuwxF9?=
 =?iso-8859-1?Q?Qu8QFHMQKTdSeX2K794AHdU2vVUDipfe7tMemqnILx8UFw2ccYNw+hkZWu?=
 =?iso-8859-1?Q?Dy3x9TxFsLQhnHisrdmxQr7jaN7pTsLoGQtXqVnhRSSYBZQRSKwMdx6rDK?=
 =?iso-8859-1?Q?9JfMUtZgNnRNmIz5LVrd7kObFK58YJVGza4o4jyKMnFADCF3995UQW+HkL?=
 =?iso-8859-1?Q?V6Y0YLer8VYmITRNTvrtRnp79aI4zPcQf52hlz9xNaopb4OWZYEpm+Fw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR07MB10776.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b443302c-59a2-4e4a-e039-08ddbe693efd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 21:48:59.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8aNVWmZAmYfMudK/F4+liTIKizhorPs8boId6csWkjMe5q+OFsyegFWIdW4UZ2v3kzUtQX0lgK7oegxWo+gOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8456

The logic in cache_tag_flush_all() to iterate over cache tags and issue
TLB invalidations is largely duplicated in cache_tag_flush_range(), with
the only difference being the range parameters.

Extend cache_tag_flush_range() to handle a full address space flush when
called with start =3D 0 and end =3D ULONG_MAX. This allows
cache_tag_flush_all() to simply delegate to cache_tag_flush_range()

Signed-off-by: Ethan Milon <ethan.milon@eviden.com>
---
 drivers/iommu/intel/cache.c | 34 ++++++++--------------------------
 drivers/iommu/intel/trace.h |  5 -----
 2 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index c8b79de84d3f..e69f04bd54bf 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -434,7 +434,13 @@ void cache_tag_flush_range(struct dmar_domain *domain,=
 unsigned long start,
 	struct cache_tag *tag;
 	unsigned long flags;
=20
-	addr =3D calculate_psi_aligned_address(start, end, &pages, &mask);
+	if (start =3D=3D 0 && end =3D=3D ULONG_MAX) {
+		addr =3D 0;
+		pages =3D -1;
+		mask =3D MAX_AGAW_PFN_WIDTH;
+	} else {
+		addr =3D calculate_psi_aligned_address(start, end, &pages, &mask);
+	}
=20
 	spin_lock_irqsave(&domain->cache_lock, flags);
 	list_for_each_entry(tag, &domain->cache_tags, node) {
@@ -475,31 +481,7 @@ void cache_tag_flush_range(struct dmar_domain *domain,=
 unsigned long start,
  */
 void cache_tag_flush_all(struct dmar_domain *domain)
 {
-	struct intel_iommu *iommu =3D NULL;
-	struct cache_tag *tag;
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->cache_lock, flags);
-	list_for_each_entry(tag, &domain->cache_tags, node) {
-		if (iommu && iommu !=3D tag->iommu)
-			qi_batch_flush_descs(iommu, domain->qi_batch);
-		iommu =3D tag->iommu;
-
-		switch (tag->type) {
-		case CACHE_TAG_IOTLB:
-		case CACHE_TAG_NESTING_IOTLB:
-			cache_tag_flush_iotlb(domain, tag, 0, -1, 0, 0);
-			break;
-		case CACHE_TAG_DEVTLB:
-		case CACHE_TAG_NESTING_DEVTLB:
-			cache_tag_flush_devtlb_psi(domain, tag, 0, MAX_AGAW_PFN_WIDTH);
-			break;
-		}
-
-		trace_cache_tag_flush_all(tag);
-	}
-	qi_batch_flush_descs(iommu, domain->qi_batch);
-	spin_unlock_irqrestore(&domain->cache_lock, flags);
+	cache_tag_flush_range(domain, 0, ULONG_MAX, 0);
 }
=20
 /*
diff --git a/drivers/iommu/intel/trace.h b/drivers/iommu/intel/trace.h
index 9defdae6ebae..6311ba3f1691 100644
--- a/drivers/iommu/intel/trace.h
+++ b/drivers/iommu/intel/trace.h
@@ -130,11 +130,6 @@ DEFINE_EVENT(cache_tag_log, cache_tag_unassign,
 	TP_ARGS(tag)
 );
=20
-DEFINE_EVENT(cache_tag_log, cache_tag_flush_all,
-	TP_PROTO(struct cache_tag *tag),
-	TP_ARGS(tag)
-);
-
 DECLARE_EVENT_CLASS(cache_tag_flush,
 	TP_PROTO(struct cache_tag *tag, unsigned long start, unsigned long end,
 		 unsigned long addr, unsigned long pages, unsigned long mask),
--=20
2.50.0
