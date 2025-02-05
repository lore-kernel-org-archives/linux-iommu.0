Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3A157465
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 16:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773142; cv=fail; b=OOD2N4x3U7myQjHyYeWinHEJ4a0yFWr4zax66yRz9ohb186ioq6G0HXCPNo5JOANYGRRDEEKNP0gBfdexAh8dP7MTMS7VBAXdLeXiUofFaVxa4VsT9TfPUFlLGIz+9UTRtujdUSzWSrdyVUxEd3Z4F6Uds24C1BuwOlqF7mV55o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773142; c=relaxed/simple;
	bh=x4pEfQcWO6ebSDHKpubhYs3XKewyIkbEkQJG2RZAIUU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X3uosN33sl6MiUpfWd1sRTIyRCdoAcLSPHaMtbCogoIp+O56wNQ0VeabSW6zZv+jd1tS/h6l5yTMvGfLixMoMUlmrQhtjwjQnSUJXKtteOb3w6Eceaq3W+rQppqmgCW7eTdTu2r2Bl4P4IoOfOcl8eetf73q/XvRnvpymitq6Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=AeLMiUMu; arc=fail smtp.client-ip=173.37.142.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="AeLMiUMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=774; q=dns/txt; s=iport;
  t=1738773140; x=1739982740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Be27FuyJ1/NoGXMFOBKcs5p+qz+BJ0du9UBYLA4C86w=;
  b=AeLMiUMupRPmEGGs2ocLR3yXcB8M9TnO/PlE1XqSF6Gy9z7wTugP6Hwq
   eqI1lE+mz4JnxgIMjWvgWsB49xAkqCGvUxf8/XnwofQHmW5FHylLJ7l9S
   YqN4DIRdHNl/CYbfuqM3MDpyWXdWJSO5wit6B0MhUkSHxhU11opOZKGn/
   w=;
X-CSE-ConnectionGUID: S9eI1iMtQJ+ksQfnOuKARw==
X-CSE-MsgGUID: Z4BFxXgXQSqP/fHrQUsU0w==
X-IPAS-Result: =?us-ascii?q?A0ANAADSkaNn/5H/Ja1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAlgRoGAQEBCwGBcVIHghJIiCEDhE5fiHeeFIElA1YPAQEBDQJEBAEBh?=
 =?us-ascii?q?QcCin0CJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Th?=
 =?us-ascii?q?giGWgEBAQEDEig/DAQCAQgOAwQBAQEeEDEdCAIEAQ0FCBqFRQMBpGEBgUACi?=
 =?us-ascii?q?it4gTSBAeAigUgBiE4BhgYghDwnG4FJRIFXgmg+hEWEE4IvBIIvSoEnAYM/o?=
 =?us-ascii?q?n1SexwDWSwBVRMXCwcFgSlIAyo2MSOBJgU1QTqCDWlJOgINAjWCHiRYgiuCI?=
 =?us-ascii?q?YI9hEOEToVgghKBYgMDFhGDJXgcg1YdQAMLbT03FBsFBIE1BZ1GPIMxgTuBe?=
 =?us-ascii?q?S3HRgqEG6F8F6pTmHwiqGICBAIEBQIPAQEGgWc8gVlwFYMiUhkP2XN4AjoCB?=
 =?us-ascii?q?wsBAQMJkXkBAQ?=
IronPort-PHdr: A9a23:PaiYnR8EqY0SZP9uWBDoyV9kXcBvk7zwOghQ7YIolPcXNK+i5J/le
 kfY4KYlgFzIWNDD4ulfw6rNsq/mUHAd+5vJrn0YcZJNWhNEwcUblgAtGoiEXGXwLeXhaGoxG
 8EqaQ==
IronPort-Data: A9a23:hOALXKO+uWpgljDvrR3rlsFynXyQoLVcMsEvi/4bfWQNrUoqhWEHz
 GVOXm/TOvqOM2uhf49/b4W/p0MOsJTcn4A2QXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WljlV
 e/a+ZWFZQf/g2MsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj684/AWBvPKgEw8Q0Anp3+
 /o/NRMkVA/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmJS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzMXwsYDUXUrsTIJs7lf2kj2PyWzZZs1mS46Ew5gA/ySQtiue0bYqIKoziqcN9rBqyi
 HL28FTAOQgic9K/0wO46U/0mbqa9c/8cMdIfFGizdZrh1iW20QXCQYKTh2/oP+kmgiyVsw3F
 qAP0jAloa538AmgScPwGkXo5nWFpRUbHdFXFoXW9T2w90Yd2C7AbkAsRT9aY9tgv8gzLQHGH
 HfQ9z81LVSDaIGodE8=
IronPort-HdrOrdr: A9a23:WlhqIquuTZxwUPCsEfc13/0o7skCOYAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRpVoIUmxyXZ0ibNhW4tKLzOWyVdAS7sSorcKogeQVxEWmdQtr5
 uIH5IObOEYSGIK8voSgzPIXerIouP3jZxA7N22pxwCPGMaDp2IrT0JdjpzeXcGPTWucKBJb6
 Z0kfA33wZIF05nCfiTNz0uZcSGjdvNk57tfB4BADAayCTmt1mVwY+/OSK1mjMFXR1y4ZpKyw
 X4egrCiZmLgrWe8FvxxmXT55NZlJ/K0d1YHvGBjcATN3HFlhuoTJ4JYczDgBkF5MWUrHo6mt
 jFpBkte+5p7WnKQ22zqRzxnyH9zTcV7WP4w1PwuwqhnSW5fkN5NyNyv/McTvLr0TtmgDi66t
 MM44utjesTMfoHplWl2zGHbWAzqqP+mwtTrQdatQ0tbWJZUs4RkWTal3klSqvp20nBmdsaOf
 grA8fG6PlMd1SGK3jfo2l02dSpGm8+BxGcXyE5y4eoOhVt7TlEJnEjtYQit2ZF8Ih4R4hP5u
 zCPKgtnLZSTtUOZaY4AOsaW8O4BmHEXBqJaQupUBnaPbBCP2iIp4/84b0z6u3vcJsUzIEqkJ
 CEVF9Dr2Y9d0/nFMXL1pxW9RLGRnm7QF3Wu4tjzok8vqe5SKvgMCWFRlxrm8y8o+8HCsmeQP
 q3MII+OY6UEYIvI/c/4+TTYegnFZBFarxmhj8SYSP6nv72
X-Talos-CUID: 9a23:Sul8H29u6tmsuGqoxZOVv3VFF+F8c1jB9VWTIFSBB2BOVZ68c0DFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AQMNBnQ0ZY2uhuh+GusilHCVIrzUj0fiEJlA9nqU?=
 =?us-ascii?q?/gNC8ciJQIQ6glwnvXdpy?=
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-08.cisco.com ([173.37.255.145])
  by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Feb 2025 16:31:09 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-08.cisco.com (Postfix) with ESMTPS id 8720B180001E8
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 16:31:09 +0000 (GMT)
X-CSE-ConnectionGUID: juUpxZ8bSWO5R5T8Yx6DzQ==
X-CSE-MsgGUID: wsiPVDgDQ4apEhFZxmANeA==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,262,1732579200"; 
   d="scan'208";a="42950953"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Feb 2025 16:31:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y15cGjyaOjF1nxHtCDHhJVQtB+36U81/ml7eUkbkilefkEs6Y1Qv9eff5w+M9RWqvN8PWHo7SNTsoquESzNtI1FupcKLcuSmkBKkqB3fTJjWN332GZZ+4e5txS7dDZXQQPfzZpOX3G4BUBO9q8i92lNi2jiJ0Z0jZ9N81VgDq7C/XH+Wm1e8X8PL4DB9AgtAo8/mZ00ESr20Bklzgm4f862v65E7rpCyqf92drlaSUMT686LZUcvQXqqToZCqtxQREeXnjg2FgU3OU2W8BJzgl16I03hiCZ4AU/bs6pD8hfq5ERlZV62BHAnojxh1Nb5GRjC1N06IKT3HZY3uObMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Be27FuyJ1/NoGXMFOBKcs5p+qz+BJ0du9UBYLA4C86w=;
 b=nZVEPvE5p3un5SRMdICuIPQMCmwYLPgqpJ3g0Ca29zTDIFdfSiZcVXBZE0wINs6ITLvaIZuJ7Wa3kjtU1s6tPRJV7cajhNyJ2WfUYGtLdvZEeAZbkDh242OkOMZfjARHkzRodNE0m0vSyYLI6mB6NkC85KrdX+KLDhoi59Tbwsk9XECc5cBH557paKriD6+AW187AzZKK1iGBUQ8qemOK5ol9wMpblDa/iSv/kVGPy3KsWwR5K4abolYaZpxAL4zMnrmMaj7ICNLwR7Lni2qzF0Vfu4Hdo7vPZ1JDWgNqEA/IJ9Ygg1hpKF9HXpsiAAgo4QolEiHmC5NF0CmJpd7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15)
 by CY5PR11MB6486.namprd11.prod.outlook.com (2603:10b6:930:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 16:31:07 +0000
Received: from SA1PR11MB6687.namprd11.prod.outlook.com
 ([fe80::ce10:662e:d436:61fc]) by SA1PR11MB6687.namprd11.prod.outlook.com
 ([fe80::ce10:662e:d436:61fc%7]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 16:31:07 +0000
From: "Adrian Mardare (amardare)" <amardare@cisco.com>
To: Christoph Hellwig <hch@infradead.org>, Baolu Lu <baolu.lu@linux.intel.com>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: Make intel iommu disable swiotlb
Thread-Topic: Make intel iommu disable swiotlb
Thread-Index: AQHbd7mt/d5VB4z0XEeOy3KGvtqiFrM4278AgAAK/9A=
Date: Wed, 5 Feb 2025 16:31:07 +0000
Message-ID:
 <SA1PR11MB6687B19EE36FF0659D1E6669CDF72@SA1PR11MB6687.namprd11.prod.outlook.com>
References:
 <SA1PR11MB6687F4E752138AAED3FC980DCDED2@SA1PR11MB6687.namprd11.prod.outlook.com>
 <8b2e868e-2b0d-49dc-b703-4e33138a03b4@linux.intel.com>
 <Z6OIon1w6AgwlYyt@infradead.org>
In-Reply-To: <Z6OIon1w6AgwlYyt@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6687:EE_|CY5PR11MB6486:EE_
x-ms-office365-filtering-correlation-id: 81c2f425-02cf-4a3a-39a6-08dd46027e3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hwG9AUWucADdmsBeyCCtX05xXp7ZgGu2t9IFYzdCH9ozg8y2DZyruFDnlPN5?=
 =?us-ascii?Q?1f/wdlvgZATbCXud3a38x54ZpWjup7qtvOZRxb4hyP4rg69XnTS7kMQ4WhSt?=
 =?us-ascii?Q?2rVTW6Kap4N9J2P5BogMYW/Dl4ogiFprajPVkAfpKyxC4pk2y2Isp0MI+fEE?=
 =?us-ascii?Q?yeNnQkASxpqixBhCLWDitA8oE2Am4jCvNF8fpGjtF6pdv+EgbPNudShfWiQT?=
 =?us-ascii?Q?C4swJbWc015e/zD/vZDI7twXLYV8aI6dODp7ERSd9Y05TqufTWLbWGO3b+Ps?=
 =?us-ascii?Q?/0N6Wzq5QRMSRYmjDMy+s4whH3SegjOm2+9FSt6EnwQhZspW0wYG5UsjTosW?=
 =?us-ascii?Q?Evx0D0T9UpqNYTs+BCqldlqlKjCc8mtVdpQag3rIVPi/JNOBsP1qlJhyaRE6?=
 =?us-ascii?Q?eEYoOL5F8N4ud11QgWBeuJQkiI9iHWjJdpSMWpQpMi2PvBAynRH+wo8V0IpN?=
 =?us-ascii?Q?U1MQoQEGHcakHYko5OD/b1ZeroEK08jjNWBJs9xW817SOJayLQZ8Bb5JwVGS?=
 =?us-ascii?Q?DMgxB6eBSb2G+RZlAfhh9CSG2n0k6Gi4dtjTeGjBvD5+OdzmtB5/QnD9O9qi?=
 =?us-ascii?Q?LwVoib5/F7L/Jw7SWIkqhHjsVafiNJc5THvVyx+6ak5X2BMr4kJab8qVzYnU?=
 =?us-ascii?Q?lWT5f2p02Nxf1bj529uMF/rG9uNf5lFKrHyRzqiiHqcfZ0QFBjfdH4F8kYYl?=
 =?us-ascii?Q?DR759s9sXjCOT5yOdjmcxG62O3TxyPaFyl93DcfU3XE0BCXRcbPFevMtKplP?=
 =?us-ascii?Q?4rzV45heDvDbTY8D6UFZWl4ZEU1hRTJ0x6dWFZd7RTLyyqBNXpIK4hXPAs9C?=
 =?us-ascii?Q?jP/5f83mosf65ovaGhnlkuqdwW8Hrvi23p3uyF4OzPpMDdZrDdGmQ/4fg3mJ?=
 =?us-ascii?Q?ca4FfXWsSEwCDNWeSvzgWaII9EwUkuBtXPrzLUkZscwmqv1b9GW3NyGEBPh6?=
 =?us-ascii?Q?e/AUcE22WRv2qq+bdbnjqW/94HXYphMZ2kQI04kwl9AWPL+CxvtY5ewesWea?=
 =?us-ascii?Q?bkaZ7+HnvgCTii9W2MRSSRTQgNoHKKi/9IBI7XiISW46NT41ROAd15B56ubi?=
 =?us-ascii?Q?gImlG+6Bqx9SSg0yyq/+5goaZq2brDFvozQT5OPjpr3C4qau8MXXQGl1dlwX?=
 =?us-ascii?Q?hKdkFenHMQ20cuALTgkzMy0DcI3qTDqFbjrh/bE7NLsjC2mCwBCGHcmS+Djc?=
 =?us-ascii?Q?BXYCIPpmtJrghq0ELzLVVS8cF/z8bDxDilifWrHh8dCDl3o/djqv69QrAgmO?=
 =?us-ascii?Q?yVdvoGoBSVQpZGKpP+3qi2ZR9I/+8Ko2Ff7SWyVgK56urM1h956wHisCSwev?=
 =?us-ascii?Q?coPeex5pPAVtsAplz3AhojF09YvuBb3HO8BRZ+xJh8mjrKI4gI4SyoCfuQMn?=
 =?us-ascii?Q?7rqYIHSwMet/uZ0gX+OQQ3Wb1Q7GNUQuHCXeV1F12qacaNF/VwXI85xFjeaK?=
 =?us-ascii?Q?wRlLEumqrbQHc6+AB5rN7FTatMVE3UWo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JOOyYaIAY/LvK/FuGpfihSx+75PXw+R4Djw1cNWgDazcjy9e5wilep1mmJuP?=
 =?us-ascii?Q?VWuVTJuTYSsOlzXIEcm+H5q3dgAuZwciMFBxY5rm3l9T7Xrg10JUOi/Om4Ro?=
 =?us-ascii?Q?3DUQ25lg0UJcN+xitcMry2bG+fpvjTHhzJGh4X8NZZvhFdN43TG0EAnE7CUq?=
 =?us-ascii?Q?YdK4jxKtaHkn/9vEdbd1JeftFR6E6663LwOyoOigFcwEL0OzI1CUr823WkaB?=
 =?us-ascii?Q?1HrNO2fJLrSPc0+1PtnvDLFNe+NU79DJN0nAbc9dOGTw8ZBUfV8mLm/VfL/0?=
 =?us-ascii?Q?zmtc/IQ1u5+RH8JQooVxVW2CbVZPKe4LEfvDBpAl4ReUJvFV111jXB0F6tTb?=
 =?us-ascii?Q?Hl8PI3KZ74ejpGl3DOvyVOY/kOIyq9TxlIZ3HxhtAmntIc7TE3+1VU2i4pqZ?=
 =?us-ascii?Q?tqguMoNshaCIqXY9uoScx/8IWGVn2kHPnZz/N66m/hFGbKlh4fgdmJnDI7fb?=
 =?us-ascii?Q?vJLF97gMN8t11IVybrqAgb291mXKvh83Nd2HdSJNclxnyC9YZjK+/SUULWqm?=
 =?us-ascii?Q?fM/YsJOjerfZVvt5PiOpyfaryv1IbfB+0liOQt8DZJvZtU2Ahjzf+Jgd9ztc?=
 =?us-ascii?Q?8FtyMXfK6pGjht9F7dpXmzmFAE6Y+ONfDylprIjG9c3P0cDB9iTypfiJSbVb?=
 =?us-ascii?Q?8/+YXJDNhgicJacR3UAhXo2CzuZCZawcxt6t1U0BXqNoaooCOGoBKDKi/ymT?=
 =?us-ascii?Q?CjzpCRUBLwlliJrNf8Rb/+DTqC5tzb+J1WYesozL1TBcMnhiosVnmx0HOwzx?=
 =?us-ascii?Q?mzWX4n6dHhFMpdTEkaMiNKpa1hxPW/XCS/6mFdKhAVI/t5LQeX+gaHPj9gri?=
 =?us-ascii?Q?JFrzBhpFITUVk3GJ5uFai02l8hZ/AGTcqmuecfidhXTa4dyN55kBUGjEssHz?=
 =?us-ascii?Q?Ca0sVwS/xwRxPDA68/7dTglvqHXynjX6NI4Ev3HOCEgVVm+Z3aoW7dJUBRiQ?=
 =?us-ascii?Q?hMJJst8ao01VS3qZmwXwh1Sn4PPBSEj58Pq6TRDwZL0Gxob8SSrxFCiNUC6n?=
 =?us-ascii?Q?yQtlU7fVG0MLXBWd1kYFu5xNFfXHe4LdJIYDSG6gpgMQ3kW8FIJBi3D66sol?=
 =?us-ascii?Q?Zg4H7sSb/m4TWtkBndCIdBLoJv+by8ciyyfpX7Z0yQjyOdrsdeM8TSQEVahr?=
 =?us-ascii?Q?s28Bmzg1/F+BuL7Bd/4VgytEOUWUboSV6boPCwAK2ykAZQEvM86pTnlvbVB6?=
 =?us-ascii?Q?eLxTiOzvS/gEGxJfi2FzTm7Aec1qs8kuRGHEetyEYv3MaKvOf4eP90JpoSO9?=
 =?us-ascii?Q?w00ZPdI/xAH9IdFjoDpwkfm+DRxZD+t63JghGvqANhzI24WtdbK/UnxM6o1J?=
 =?us-ascii?Q?IJlNxzvz4FoVHqIyur7Br2iK8WdgPl9tzR072ukHrdm9i90Cg0O9ig52my+Z?=
 =?us-ascii?Q?4DBnmRtEwyyC+/EtbA/SLHrUkjf/G9VqtdY2UbQxo2nwI6ezWt/2yto9vtHH?=
 =?us-ascii?Q?PSqaJ6KmIkygqhPC2hfSJUrxeTXsGJ2A24plVsh9TDtM/MUp8OCJMtKXfw8V?=
 =?us-ascii?Q?FarswFGZRusXqXU67ZXIUn9/ON5rmYLHSrvgZhs+DfQ8CBqNP/DA+H9OFxJ3?=
 =?us-ascii?Q?9tITMmhgrhtUqKydkPYBCKUTHYK9nCPcDhSRoiX8?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c2f425-02cf-4a3a-39a6-08dd46027e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 16:31:07.8250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rlNot3SheNJYu4Apt68Xv7CS4EeQe6UVj5Zqhpc4lNegGgrPURomAVxVIQrgx4/lp3flXroy3NapTl1cZu/udQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6486
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: rcdn-l-core-08.cisco.com

Yes I agree  that swiotlb is still needed and I'm withdrawing the patch.
Thanks,
Adrian

-----Original Message-----
From: Christoph Hellwig <hch@infradead.org>=20
Sent: Wednesday, February 5, 2025 10:50 AM
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Adrian Mardare (amardare) <amardare@cisco.com>; dwmw2@infradead.org; io=
mmu@lists.linux.dev
Subject: Re: Make intel iommu disable swiotlb

On Wed, Feb 05, 2025 at 06:35:20PM +0800, Baolu Lu wrote:
> Why does an iommu driver need to care about swiotlb? The extra memory=20
> consumption might be a problem, but I don't think it should be fixed=20
> in the iommu driver.

Not only should the iommu driver not care - the patch is broken.
We need swiotlb to bounce buffer partial pages for untrusted devices.

