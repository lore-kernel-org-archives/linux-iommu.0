Received: from smarthost4.eviden.com (smarthost4.eviden.com [80.78.11.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035AF24290E
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752011656; cv=fail; b=YKDyfoFDlEzfcbFEM9Xyu7vx8rVXRBdAuAK4H+z/2xjWY3tlZmR+NsVbnKAZbOF2UG+ac0S6g98XjX4LwPZpwVcxJT4koBmt/Z2eWFlo4EDehVdiS+eUG+FtPPXtzKpYY5uRgpfc8vcQg2p/hyyffZlRvRQFYFyaKZkDpmh7utQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752011656; c=relaxed/simple;
	bh=ZtQio+AxQ8AGr8P5tS0YjHNEHDz3BDlxr58693dgWms=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gO3pAZf+N3iozrPT675nWG8Iz1JNAtjw0eM5QHM56sg58RddEWd4zwWZX4p9z5w5bHdgN1faVgHcUekQgw0gw3u9aNLiwvsWA2MfmGLhmJCOaPZeFvt5s1tAHsgSsBBPqkxkYL0mOMS8e/DnxVlD05r29ZEDEVJ17MAO7D/uh4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com; spf=pass smtp.mailfrom=eviden.com; dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b=QclHv4ij; dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b=r1QLZ+YY; arc=fail smtp.client-ip=80.78.11.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eviden.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b="QclHv4ij";
	dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b="r1QLZ+YY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1752011653; x=1783547653;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=ZtQio+AxQ8AGr8P5tS0YjHNEHDz3BDlxr58693dgWms=;
  b=QclHv4ijlVzeUlPxiLQk8d5/zX+ZW+yo8qcXqV8/QkqYBHrjVvYN12xE
   1ouO9UDstn1JAAIfeWvZQpfg+n3yDlbBQ3dFn6N4uyA0kXemLq8hRFACJ
   RLJmm2fLgAzBubmsVWnMpFnOo1eZcMz0aawDagRSoyokuOFxYb4nuU0uA
   NvFqv5WnH72bMmiTjrwmelJKp29WUheVb/Yv8xu33UmxKyDFALJMPC4GN
   2ee9enTvMFnZkLFvNLR4WPAmZCxaG2AZazuJ+K81H99B1vNQfz7ZqahUN
   FOaHso7okneTrEk0zXvF4KDlU7P9+lCux5VEPar0lnnsw1trhgAXZ+RRJ
   Q==;
X-CSE-ConnectionGUID: i5ALg+EHQUeMcpBMU0PBOA==
X-CSE-MsgGUID: jop0El7/SiyH3mHvErqlbg==
X-IronPort-AV: E=Sophos;i="6.16,298,1744063200"; 
   d="scan'208";a="42156495"
X-MGA-submission: =?us-ascii?q?MDHuHm6+8U8ziW5U7rOAZ3FDSTUzUIOKLUHB9h?=
 =?us-ascii?q?PyK1pb63EPcRLsxCUPWA/MM6D7C0AkkXhALme8baT04lrvn/t8ZPmn6O?=
 =?us-ascii?q?zTH8w+Ha2yGyoX1KU6QGX74J7hbhV3qzvgPg98XMSUWItAibr90uSWVn?=
 =?us-ascii?q?4S4+MzHTVSPPpDKmuF1YWogw=3D=3D?=
Received: from mail-northeuropeazon11012031.outbound.protection.outlook.com (HELO DUZPR83CU001.outbound.protection.outlook.com) ([52.101.66.31])
  by smarthost4.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 08 Jul 2025 23:49:01 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0Ymte34KMvGUwsadkKdIRIUHZfhz6eAfQuntVhAcUkroD8r2aRZIfT72jH4NZLL/ghe4MH2hgCvCk7/r+V7omWZBc6S8I95vuZV9BDfFtKUkj3w3/w2WkDAZ0ItI/wehd3UbiptJH5v0KKdHf9ZEWw6kMPWikbhuhwo/SWHPgZYhDEB9pO3iHHbFcZWixGQz6Z+pMO2K3g8cq5/iB4T5okJ5qQvE0RGm1TtTrD4fwOtS+fy6biMezRwk2uLNlTprERJplXFAKhDzodLVPix/wWeQPrKSe3neYc1RXtSBhWQUvl2DFDCyde7Wq04YnJWcH4yxB6LAvlCCH9mu//77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4N87mlYq1MF2by81bZu4p2pUnA2tf7KFHpVKktIZIco=;
 b=JLPdLIxvCdtjo3tWsjTLSxk/qZP1gVONDAXAQYthWRhW/uZRN7nAEuh184tzLSro/09kUum8pMZh51wgbSSPF2tBFPhBJCdUxlEEBN93NATye/gh+4b0FbCF3BiFUN1EPy+o0RhTQFLVFykqHNqshFuWBQ5fOY0FLZz/5mf7jQS7N9fyXxGZfXuMnstRm34nFcnCy2Qfdl2+yA461irqewhwHo7yP0fs/oJT2I4M9YGJPe3gaP2x7RafIQhESNlu9vKB3hIJjFKdj6frW1QY4hJfHYVjgzwlsEDrvp2O3LX1mcB2Rh7WsOtlcfc0BJAJq1RI9biT2uLWsge7AlmnBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4N87mlYq1MF2by81bZu4p2pUnA2tf7KFHpVKktIZIco=;
 b=r1QLZ+YYR0y32S+e9bGi0YG0Zer4/PZBPa97aAcX/BrxVdCmHY514l81MVNKKyykoxQxzK20gFZCframUtIjgHiYu5+tjgpkKoT9ZorqDMuuldEUkggpCI5FZwiCvmnxAUOGCwWTACLDMNx1eDuDx+xOvHavOk1NnqxA8YViOqxOaXylRGAQlQLwojluH3vGTH/BEO/zNjczSsH39nAyXuqw+8yfh0vr9lJjNz6m+NKK4sd2EzlvH0jcl2oRMki34P0ZiL74Z9ElO4z7GfVd95LFigVo6T8DkfYoJ1sHW8njnKQYZXjmTsnkZRW7QAAS1lUiVg0fw9O+G4j3zOfLew==
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 (2603:10a6:800:2b4::11) by AS1PR07MB8456.eurprd07.prod.outlook.com
 (2603:10a6:20b:4dc::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 21:48:52 +0000
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5]) by VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5%4]) with mapi id 15.20.8901.021; Tue, 8 Jul 2025
 21:48:51 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, CLEMENT MATHIEU--DRIF
	<clement.mathieu--drif@eviden.com>, Ethan MILON <ethan.milon@eviden.com>
Subject: [PATCH 1/2] iommu/vt-d: Fix missing PASID in dev TLB flush with
 cache_tag_flush_all
Thread-Topic: [PATCH 1/2] iommu/vt-d: Fix missing PASID in dev TLB flush with
 cache_tag_flush_all
Thread-Index: AQHb8FIX+VwT35YevkGxfPjX/pFNPg==
Date: Tue, 8 Jul 2025 21:48:51 +0000
Message-ID: <20250708214821.30967-1-ethan.milon@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB10776:EE_|AS1PR07MB8456:EE_
x-ms-office365-filtering-correlation-id: 85e1fd58-a5a1-4f07-6c47-08ddbe693a72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DxXGgGHH00J1exUGc8WQAzIGo474myJHN+7RxeHbTtjo2i2JbadxW0H3r1?=
 =?iso-8859-1?Q?mqWDNM5tR44nGALsz6MIWP/5Q2ceykJjYX8hjDjZyKihaa9bNvzovRc7j0?=
 =?iso-8859-1?Q?fzaKMaFgB9Mx9Zi6ZM0FBL2yUCKhXhrQK6x7njrD7dCxM7z/3pHQBNaIwr?=
 =?iso-8859-1?Q?x7uo2wb/gs2C7Ye1tb+NhGTGIuDxiyHqL9AYOBA2cNdNpGhywyJ4Ylmbsa?=
 =?iso-8859-1?Q?KX3nRRRRSnGqynGWGyVm7M968AVm9yi+f223sGMQHqSP7LvtkqI0Gm74UV?=
 =?iso-8859-1?Q?KooZBOc2nrY+NQ8ClvDmyZjMaE6qj3HJxiMZUvEtl8+9nt4TWKQWSsSw+Z?=
 =?iso-8859-1?Q?QdY6JJGRN9QTusbaPKlPev0KheSK2SBbohVDm8Am2v0JUjIDJ7gRnseJo1?=
 =?iso-8859-1?Q?JNPaE0iPCy7j7BH/3TWfigxAyz4JeNJlRrlMkIVeGE78qwqqYLoTjPyKm5?=
 =?iso-8859-1?Q?RAlFfNjwyUaoqK3BKA48fjrCsrtgqMPvfLo1T/qj/9K176W2VMsZ2a+u6E?=
 =?iso-8859-1?Q?rFCuTa0wIkO0t6OUX4df9NWiLl2RoHFCcryatb5ur710nZy5zi6/US1o/f?=
 =?iso-8859-1?Q?QibovbcdvPDgJ3qOVgsD+p445jJ8dSfwkMPbHCEK2XHCvI21bol6eKELF0?=
 =?iso-8859-1?Q?KVQJ12hGe5p13V+k60HrsMk6wd0V+QiEbt+4NMvXTeQGJOzf6JDypYQ2uP?=
 =?iso-8859-1?Q?VjWfkMv9lQx3J7pPVy5XffvNQdODdQKk0P034laA2BR9tQL82DVuuXsLNg?=
 =?iso-8859-1?Q?5Jz1hZZZOxET9j/u45G2wi6XCATKPZi8PqcDlTVkCTOoV/NO9/wUrwi3ff?=
 =?iso-8859-1?Q?ymylqcpvvwvs0+SFKMz5+iO6Aaw0gv+3y+tuLD9N2Jrxhrvh3PAX2H7AAJ?=
 =?iso-8859-1?Q?pgEQ2nEYI7wp1EAnUcyninnlFp0bZjeVIZmxwC3WIM+1flyJ46dc0BEcRa?=
 =?iso-8859-1?Q?zbMo1HFilYz1aw+L+olKwlEA6layZaeDpuNZWNpOx3Td18wcOWgXZliAUw?=
 =?iso-8859-1?Q?rzTJqtuZZfiVQB7Xu+0FxRN77M1RFu2qG0635a+ZDHjf0TspCwqrHF4isx?=
 =?iso-8859-1?Q?qmOtNT//0ycQX/GBHAqfNv+3+0CO78aICx79AL7awVWOeDL5tSnEm2N8Gf?=
 =?iso-8859-1?Q?d7wWdzZyzXn37mMbTYSZmTFomi5fALExdLe6i3EodyGcX2zkZiTW8aMfVl?=
 =?iso-8859-1?Q?/Y48/JocK0bDKGvj/fS0kt4RPge94XpBC16+TI4aMsLfFFr8qu4UwdRRlt?=
 =?iso-8859-1?Q?E9PSJR8qZnneGV/qf1F/vO/DNeZkmUJdVDdGk8QW0Jd/BjAgn8Tn5I3jgY?=
 =?iso-8859-1?Q?dYOV/TWoML5NrX4lfjKt5kGXXvuC6YGAfS7RIoyU4Z8V6+RWIZHn7zjuDt?=
 =?iso-8859-1?Q?fLz84y8UGmRm0B7RKpYQTvX0Hb4WqTY6M0PDDuWPQ/sIbxINpuRG54LxcK?=
 =?iso-8859-1?Q?WmCIRNpw6K1pDIySZMxTKT5phWVkA9YJaOy8Z3tIIgVFNU0ZuReLjiepyn?=
 =?iso-8859-1?Q?a6orjVRcsEfs6HJ+nHRYXDiWdSpR8CzEUVH6b5/2ufxA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR07MB10776.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?rc7Xdbxrm+woyFrFWJK6kPWRCcNPkByFd/ae+D1JWGrjkhgh1mvDnQfP9w?=
 =?iso-8859-1?Q?r8sVDvGh4F2QBC+kMwra5HJGYSKrqIYJZ3q2isSxcztIe0H+hB+sBUc/0V?=
 =?iso-8859-1?Q?IVdlj2isjd0uJfmAtg5N74RT07Wm9NekEvODeh4whGWM5+gMSsbBHYiztJ?=
 =?iso-8859-1?Q?INVMJjnRw1tEKTkjZeviUMCu/YuFS9rBsldkUjMeVRIx1LNu2r9fvbtp5i?=
 =?iso-8859-1?Q?KZnt+9gMs0CfNQim7hvM4yWBWlutiOU28tbwhz/OIkqxeSxzWrU+ivJdwT?=
 =?iso-8859-1?Q?zRyb2+fs2HFbPD+HKzWAGrFoI0UoatV5vS8hVJ6VzFN7r9E6Y6t2W8BHYm?=
 =?iso-8859-1?Q?CDWhwYuvIJUAnDjOMZWa+PFIcmirZmZ8QINJUKEoZAkrBCAREGBhd51Ok0?=
 =?iso-8859-1?Q?/10knxM+77mXrP67Ax661EDpSo3W4kObr6N5E2SfBHPvUbinI9Sw28sQJB?=
 =?iso-8859-1?Q?u/1qdZZzLvodRzLGRCV90+wtPPgEmoIi+3kw21FouF/wbDzBtHBiQRiKhf?=
 =?iso-8859-1?Q?Ec7Qu1psHq+dKY6gZ9ymhvn0IZKLa+tAxYV1scwWCZ++dichp0+VscThOv?=
 =?iso-8859-1?Q?/b67sPrRdgxPXYHLAC6585CUOtH2XhwWtys+adqdMr5COcxuXScZDTC3wJ?=
 =?iso-8859-1?Q?cKUyY6QyM4zDyJx6WL84SyGuDkOjPvZwhIMZjLXqHkYgkD5HJ9PTJAMBr2?=
 =?iso-8859-1?Q?byQ0LTgZAfKHIM4UaiQBJuaARjPUvLBFBGtsqtKPxAOXDqSbUO2UmRpXvV?=
 =?iso-8859-1?Q?GMdN5fyjkhkS7OhKFodnD3SoXwFzvY4TXjXLSUOHfCQ1uWGxmyhELzzvko?=
 =?iso-8859-1?Q?9L7oggGZRhQg9FE+mPl1T09SNidqqZ4NnysvyImwcpLTMQBqTmjGkg/YuU?=
 =?iso-8859-1?Q?2feI3z0JC+dbzs1oE8UQ9buhINvnxiRuZWSbTdZhzCiuM/Ad2jEWWvtUDi?=
 =?iso-8859-1?Q?x8trp+sV37yR8cnWeYbZ0D9CWiZ7ktpzRxkfkmES/h9GD1altoEJUCopr5?=
 =?iso-8859-1?Q?955FtFOnzDfWIrQHzs6ocfsdKVpYSlGq9f7u9u/nTEAeXieAzVEn0WjGdU?=
 =?iso-8859-1?Q?AGUStc3mJHjlSv5G1yichWLp8UfjOakychtDyYMoTlAtoY7DfU5qH7xHLt?=
 =?iso-8859-1?Q?KaM8SON5JfYNrIJTMRkUN8MbTa8bEW3pl8OTAmMEOJgOd6HSbQYwZQAtsB?=
 =?iso-8859-1?Q?Epv4VZ/bQ2ivv6wdbZWl5hkdIfNNs//22P8JGDCDHoVblikqKFD4hsGcDr?=
 =?iso-8859-1?Q?cdvZ38CQfCjSOd95xlB0q409Vxd0p7yBlyszuJBR3OJN1TmzqIjmHW8/+r?=
 =?iso-8859-1?Q?oKFkik+W8foxuA+AD1tRPSsUxdQt7+t07NjYFhRfgZzcfE0tSxe7wrAWE+?=
 =?iso-8859-1?Q?4JrEhpDvr4Zyv27wEJN55Ey24Wg3zVwCjkUzjFN05VtZ7YjkoJ5QtrmuSs?=
 =?iso-8859-1?Q?VC0mQDVRT3DXMxoTozruxV6riTY6azbNijeTNWujjfE0P+AJUQnFUj5rTN?=
 =?iso-8859-1?Q?TziSlh2SVknAom3Qx1w2PIFOC7URiYMxQlzWkEl4hMdDHOtKLSDh36zvBW?=
 =?iso-8859-1?Q?Vs+IRdSkWubtPO0rnuhTpj8Of+vmlhxK5gDXKNpW9ThYZ9dEllTeYvI7wk?=
 =?iso-8859-1?Q?cKEflpo77z497kZrM6VdzRV08BC16gkb6U/m7bDupEkJco2lfV+Ajo3g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e1fd58-a5a1-4f07-6c47-08ddbe693a72
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 21:48:51.7523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnRX3G3RvzVr2dVzAwnG08LNw84Rlwlw30icuBvXB2t9HH3KHi8FG3VW8ac38NOPVDfJLBz8gXMuZ1GKD8VCkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8456

The function cache_tag_flush_all() was originally implemented with
incorrect device TLB invalidation logic that does not handle PASID, in
commit c4d27ffaa8eb ("iommu/vt-d: Add cache tag invalidation helpers")

This causes regressions where full address space TLB invalidations occur
with a PASID attached, such as during transparent hugepage unmapping in
SVA configurations or when calling iommu_flush_iotlb_all(). In these
cases, the device receives a TLB invalidation that lacks PASID.

This incorrect logic was later extracted into
cache_tag_flush_devtlb_all(), in commit 3297d047cd7f ("iommu/vt-d:
Refactor IOTLB and Dev-IOTLB flush for batching")

The fix replaces the call to cache_tag_flush_devtlb_all() with
cache_tag_flush_devtlb_psi(), which properly handles PASID.

Fixes: 4f609dbff51b ("iommu/vt-d: Use cache helpers in arch_invalidate_seco=
ndary_tlbs")
Fixes: 4e589a53685c ("iommu/vt-d: Use cache_tag_flush_all() in flush_iotlb_=
all")

Signed-off-by: Ethan Milon <ethan.milon@eviden.com>
---
 drivers/iommu/intel/cache.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index 47692cbfaabd..c8b79de84d3f 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -422,22 +422,6 @@ static void cache_tag_flush_devtlb_psi(struct dmar_dom=
ain *domain, struct cache_
 					     domain->qi_batch);
 }
=20
-static void cache_tag_flush_devtlb_all(struct dmar_domain *domain, struct =
cache_tag *tag)
-{
-	struct intel_iommu *iommu =3D tag->iommu;
-	struct device_domain_info *info;
-	u16 sid;
-
-	info =3D dev_iommu_priv_get(tag->dev);
-	sid =3D PCI_DEVID(info->bus, info->devfn);
-
-	qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
-			       MAX_AGAW_PFN_WIDTH, domain->qi_batch);
-	if (info->dtlb_extra_inval)
-		qi_batch_add_dev_iotlb(iommu, sid, info->pfsid, info->ats_qdep, 0,
-				       MAX_AGAW_PFN_WIDTH, domain->qi_batch);
-}
-
 /*
  * Invalidates a range of IOVA from @start (inclusive) to @end (inclusive)
  * when the memory mappings in the target domain have been modified.
@@ -508,7 +492,7 @@ void cache_tag_flush_all(struct dmar_domain *domain)
 			break;
 		case CACHE_TAG_DEVTLB:
 		case CACHE_TAG_NESTING_DEVTLB:
-			cache_tag_flush_devtlb_all(domain, tag);
+			cache_tag_flush_devtlb_psi(domain, tag, 0, MAX_AGAW_PFN_WIDTH);
 			break;
 		}
=20
--=20
2.50.0
