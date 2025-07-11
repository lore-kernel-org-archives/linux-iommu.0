Received: from smarthost1.eviden.com (smarthost1.eviden.com [80.78.11.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6B2E542E
	for <iommu@lists.linux.dev>; Fri, 11 Jul 2025 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752239042; cv=fail; b=JTT0UpylD4XzLQppzTLAZgkXP1E58fbHiDmhkjrfKyhVq9ai704uw24L2xci+6yBUY6KHDKlaQKibNTA0dDxb6j8/DvOnP0RzJWchAsHtSmJhFEDAjHkoAUDkVZuXRhhTh0RxpyspEEbwH4bm5ry2b9JkMaUa4hUQ4J7xitFu8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752239042; c=relaxed/simple;
	bh=xhnpx22OvmhvRHwE6+I6RGIYI7++9wtlpPWwRyi5Xpw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OMjk3BpLg2DxyH72e7QdFhUG9jL7KhXbiJrumemNkn25JOm2zRaMrBokFDxTM6ofXXbhW9uq13wYB5gRlws3Y8XEbOmrifPov3KhoAxoH1Qr0qW7GZ74ZFrekqeidu2Ym9wCgX8U3GXIW+pSl2oDCdjNWZR3WyM3O+FapSLHlCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com; spf=pass smtp.mailfrom=eviden.com; dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b=jn/YP9gX; dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b=sayEmz/E; arc=fail smtp.client-ip=80.78.11.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eviden.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b="jn/YP9gX";
	dkim=pass (2048-bit key) header.d=Eviden.com header.i=@Eviden.com header.b="sayEmz/E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1752239038; x=1783775038;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=xhnpx22OvmhvRHwE6+I6RGIYI7++9wtlpPWwRyi5Xpw=;
  b=jn/YP9gXHYu/5R6rIxKR5y9iWA7HWngrtfiAUuCsG6B3AYFpZxzkJtmE
   bQ0hcsmFkvBaKRyQEih4VsB63WhNNFY22dkfC24x2y0f2EYvW+ATd1qN1
   Yd4ev6dvgXcdqElknmQaEmCpJXcNRRzLwP68X8H6rw+A0u4HUwXxjEiiG
   aE4LicKAbElK6UULuQoqEZOQfXl+RwV+4fdM8Xpp1xWDwV6A9TEraxIEJ
   C7U0jkjUyWUcFNnYPyhfr+30S9eoO36q2KUjteHkn/CO9+d9Hf5UurKSO
   OHjS1s04aWJoq/Zi9nva41FNcE0F26GeRx1B/tl6/HGCphJQoI+Oz5wPI
   Q==;
X-CSE-ConnectionGUID: M7Jh2ClWT5GQK52diTxqLQ==
X-CSE-MsgGUID: XwljzvtMTGm/Ng/BLylRLA==
X-IronPort-AV: E=Sophos;i="6.16,303,1744063200"; 
   d="scan'208";a="40192972"
X-MGA-submission: =?us-ascii?q?MDG/R8zyNgilDs/nzgZGjImz8E8a8pTZah1KxR?=
 =?us-ascii?q?JXPEKI3LTrZSl6VSrfKRQkfidZP1e0JagvTTTYUM6cenTlJJPrq3G3Mn?=
 =?us-ascii?q?CjuQmEcdGg8ZFb4107IKNN70DvBwkBrALw74WmuJwcpU9h19cXacDpzt?=
 =?us-ascii?q?jaI2b7fDSMyhfzIWccBQNT8A=3D=3D?=
Received: from mail-francecentralazon11013013.outbound.protection.outlook.com (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.13])
  by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Jul 2025 15:03:49 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3KMJnU2JlJegoH6e1UHKrX9vnXKn7nPQVkzCJUdQ1l+K5i7mz1zhdUICdwVLmYOQwdiZsJJQhjqzMCx4WmV7a3iUAPgliiElhb9FGHkeonEO0QKBvLfdHA/fdVKAEA46hVwAfEo4HDKK7TQTm1BYlA5UwUsR5gpzZmXOzTOJFCR7x1pKL+DXMXh45PKb2MHORBcqeAEmjPpa7PAq2Oeiua7s7krvhJ4wBLp5D/nC03fEq6iS9fcwvDf2eCM8sNxTQC1PldrjjVz/c2wyhPHOJfcA4/wwL1cF6bVpcbGZFszD6HfdyT+1WPlpffy6kz6ZJFEriKJWZHRy3Mm3wVt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhnpx22OvmhvRHwE6+I6RGIYI7++9wtlpPWwRyi5Xpw=;
 b=Bc6B8Wpajey4vXnwPtSabgkMCSx4LaRcLmOZ6/hmEf7UHE5/iX/wq6eXKi6fg1wpJ0jYV5UapLbc63qi4isc8tZ0WLhbCeawWoNeLY6tF385DxQoDidgm+oHPwaep9NrGlBf3K/pnhq98WkXM+o1wXv/TEvtVu/mOObUjldzmjbFj1jehH5oUd4pQorEEXt0Lhsoqc/IndvWomRywnk7ZBPOZqLKg5blZogpysxy4hkVaJ9rHCNHpvSJnVBIKjslFaGuBLnLAOAihxreEN9bLKJhL/phxSGmBzFVuA1RnHsTyo1Qx5u5H91RjKWvWB3MCwOhjUHPd61iFGTDBE4qhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhnpx22OvmhvRHwE6+I6RGIYI7++9wtlpPWwRyi5Xpw=;
 b=sayEmz/EsFRrKmW5JBXHss9iaBZuAjeEVZj7+4RNoEo/cRe7siTQsrJ2WWWTCdRllM3xDLRl+ngUdpm4zZr3kjy0b8Joe23U8TmKLgM97R5+6zr9JMzMFKYhtAOKaWC9/wnASujqIQjZUcffK6bqNmVWW6r2xKSdVp8p0YTNSNaHwYvrF2DLwu4SSruCYXrNvobClW3ULPIyhx2JmqDJJukxY7YKFvL5e3Y7ddBOKK22Fkx3Z6bNvnI5+jOlzPdCiiC/eK4gpQbO1aBmKYb+72kvI9w+KeaOn4x2uRqtOAUYBjYw0cAwJ6NsoBQ91J6t7xnFQaNKP6p2yu10jTqgYA==
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 (2603:10a6:800:2b4::11) by AS8PR07MB8217.eurprd07.prod.outlook.com
 (2603:10a6:20b:374::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 13:03:48 +0000
Received: from VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5]) by VI0PR07MB10776.eurprd07.prod.outlook.com
 ([fe80::9c6d:5ed3:42c0:6e5%4]) with mapi id 15.20.8901.030; Fri, 11 Jul 2025
 13:03:47 +0000
From: Ethan MILON <ethan.milon@eviden.com>
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: Baolu Lu <baolu.lu@linux.intel.com>, CLEMENT MATHIEU--DRIF
	<clement.mathieu--drif@eviden.com>, Zhenzhong Duan
	<zhenzhong.duan@intel.com>, Kevin Tian <kevin.tian@intel.com>, Yi Liu
	<yi.l.liu@intel.com>
Subject: iommu/vt-d: Use-after-free on sva unbind device with pending IOPFs
Thread-Topic: iommu/vt-d: Use-after-free on sva unbind device with pending
 IOPFs
Thread-Index: AQHb8mQ9gK8mQyi5B0e3dxD8mdOlrA==
Date: Fri, 11 Jul 2025 13:03:47 +0000
Message-ID: <e8b37f3e-8539-40d4-8993-43a1f3ffe5aa@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB10776:EE_|AS8PR07MB8217:EE_
x-ms-office365-filtering-correlation-id: 98b73dd9-2586-405d-5a06-08ddc07b5f8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUJoNDJOZi9oMmVmdFozR01zT0ExOStmR29mRmZwRXBUOWZNNHZZY0llV1M3?=
 =?utf-8?B?WmVxZ2FxZlFrMFk0eUtwRVNtb3VDM3podlVjalpiZEd1SHgrekpZRjBPVnJo?=
 =?utf-8?B?ekRwWFJjOWxaRFhyRlpnbjYyUDRwVFpnOFllNDlweFVCN0ZPRXl2ejBjUWll?=
 =?utf-8?B?VlBkSjV6cmFwNXFka3dWclBpRnVnVGwrcVg3SEJyMmwralUwanJBem5MSHpY?=
 =?utf-8?B?aFExeUQ2eHNKVnRxdnBzaFh3Z2VCSE4zZGx6dFJZTlFEWDdYS1JMVm1JYnlB?=
 =?utf-8?B?dVBLVDZrL09IdnpqV0RRRkthc0JnT0R0ZHZrMk5lY3lJUHVoREJSUmtyUEt4?=
 =?utf-8?B?d0pYQTlBK3c3anM4aWpMaDMvZzhoRVhxYmRYb1dxdHQrNXQ4SFhZOW80Uk5r?=
 =?utf-8?B?aDZqcUlZajV2YWpGbkN6K0UxejdSM0NyUi9nYklKalcyemQxYlZ5Y2NObFVX?=
 =?utf-8?B?UkZjS1lMWlV4ZGxjZ3k1bGtGYzRIYS9vT1FyTHcrV3lrY1BNTmhXNlFWSFo2?=
 =?utf-8?B?VVhzeUwvVUJBdWFiTVdwMHgyNDU0WEM1ZXE3NVY0YmRWaFNpV3JuZklnZFlh?=
 =?utf-8?B?WS9rR1dhb2hhczkxYllJcjJrbE5wR2VieEJsQUtKd1Z3RWdNOHVoUWpMSTBF?=
 =?utf-8?B?T3owK0d6aGRIK0JUelVXTExMSEpCLzl1TlRsSzd6REZ6R2JlNXQ5MTEzWWFa?=
 =?utf-8?B?REljT2x4c2QrWHlZcEUwM3F4VG0xQlVkNzF4a1dTQnhFSEhSUWgzWWNscjRP?=
 =?utf-8?B?NE5TQzBjZzF3ZEFJcTlHWjNQSXUvTUpzTGhRYkxvUi9XMzluR0FkVy8zcjNG?=
 =?utf-8?B?UVNOaTA2SlI0QTRUUnV5RmgxdXJwRThIaCtCalM5QXNWMElIOGtGTzl5aGNs?=
 =?utf-8?B?S2V3aEFUTFdvU25KYmtqcjRtckJValJXTHU5NXdtenlUVDZudzhrcm1qMXJN?=
 =?utf-8?B?c3RRTEdlN0Y3MHdIbU5lbmFlVmNpYVB4bCtsckd3L29qZktXbVYrc3RJcFZi?=
 =?utf-8?B?T3hLNm11cUxkSkc1bUZ1Vkx6eUNwTWREeE9zTG9GT2JReTZ3UkZTK1h2MFhS?=
 =?utf-8?B?b1hxL0FrM1ZObmF2TlBFTDZGRVNGcklHNzIzQVFFKzV5b3NpRnBQK3pMYmZS?=
 =?utf-8?B?YTBiaW95Ymh4c04yR3FPWklwWGd0WmNBMlcwd3JlTTBWRFlHaFI0cG5KdWI4?=
 =?utf-8?B?bDRBZjVOcFR6N3hyT0ZyeTJGUVllMEJrK05wSVFraHlKTXVNZ0VvVXJlRW9x?=
 =?utf-8?B?Vm1NZkRnWHNzNnlJMGVETFZ1aXh3SG10Uk01TGRKVnoyMTcyNnhqZUFVcEtt?=
 =?utf-8?B?RXRvR2lCM1MvWXpldGhPTHNrTGZNYzgrcmliY2dMWHYrUzBOYkxZd1dzUm9R?=
 =?utf-8?B?d1Z4UnpGZFNKRXd4cEZCNWRMODBhbk9ZTlRlOVVFMDJLcy9xMk5tVk54ZWdW?=
 =?utf-8?B?TlRrZmNlWE1WU0pZRkRCVW80elFpaXpOUy80ZUNDbDUzSDhvZ0tUQTFjcWhy?=
 =?utf-8?B?ZDZqWGNDZDdXNm1HbzNsZEVUVjZobmthK3UzWTlBd1d5aE8yTUYydVFUa2pj?=
 =?utf-8?B?ZWJHVU5pSWhmTURCT3AwdWlCZFBmZG1INnNCb3V6UmRCTGc2c1phdkVDYWFP?=
 =?utf-8?B?cmsyYTlzLzFiL0pNelFETDNMZ1Q4ajNFdVNUUnlVazIzM3NRR3IrdVZmcnRs?=
 =?utf-8?B?b1BSbkM2ZDRneWgxSzdpU0QyUXAwN2pDZHR6cWRNOVhOUUVxWVhhRXhQaklm?=
 =?utf-8?B?cTVlQ1FIRDhrWCsyTE1yeVcxNFpwYk12M2QrNEt3R0hFWlNhNTU1a0pkQXJV?=
 =?utf-8?B?bFBSRXNRTlNNRm5TY2MzbmJ6OEszSkwwUFRETDNobXN0ak8wb3V1c3ZhVGF0?=
 =?utf-8?B?U3JtM0hNODhWUzUzelorK1RTdytQeDBWZTJ5bTVrQmEzSEd5YU84RDdCTXRm?=
 =?utf-8?B?UWRtM0U5Mkh0RTlRTU9ZejVmZ244aEhZS1c2cktISUUxcnc1cEtLeDdMbnVI?=
 =?utf-8?B?bmdvMFo2UEZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR07MB10776.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUZNSldQRVU0WTIvYnVYRkdWYkV5b0p5bExJdzRzOFkrd3EyQzRYbGRIWnAw?=
 =?utf-8?B?REZlY0xQU2hyYUJpMlZZNFRPVXY0MzdKendMUk1Uam5mS2wwb05BZW9jTTZJ?=
 =?utf-8?B?emU1QS9mYjlWVXFxakloRlEwTCtVZlRoRklPYUU3a3R6MXVUQi92VUR6Tnk3?=
 =?utf-8?B?TkN6VFgxazZlcktJUmtCd0Nib3pCNnR5Y3BiQTdwenVHOE0yeU04cG0xZUVt?=
 =?utf-8?B?UjRnMFU4aGhyb2RBSGpkTWJMRnBXdEw2aWJIOGUzSXVpaThCeG81SmZyZlVZ?=
 =?utf-8?B?K1lxYSthSGJVREs1UU1wOXNKVlNTakVDSWkzMTNWTXJOU01oTUl4UHUyR3p6?=
 =?utf-8?B?bldzb1JhVUR1eDM0Tkl2WVpKeVRWWUFtUEZKSUtZNEFuZ3NHWTY4NXoyVHFo?=
 =?utf-8?B?VmlUNWlFZVR5K1dDU2ZCTXQ5U1ZMY29WcnVLWHgyQk1tenFGaXNiZ0R2TVJM?=
 =?utf-8?B?NXhmMjlSbmpOalc3WHNmVzhYcWdmYnEwYjEydU45TmFlZjl5VElYV3ViWndm?=
 =?utf-8?B?Z21xdnZtUHdDT1A5SHBveEpkMUhZZjd6WkdyOTgvZ3RxU2NzbmcvT093ZXZ0?=
 =?utf-8?B?K3M3MHBheWFhSVRNejFVWFVHVXRnekdTMlVKOG53RGwvc3QzSnFqK2pwa2lW?=
 =?utf-8?B?VEx1Y2xOeHNlV0VreTkvcXNaUWdKUUpGRFNyVVcxZGhFVGwxSHprRHRWWHkx?=
 =?utf-8?B?a2RXcGJ0M0pMMGpUa3BMeHROa0V1V2lKN1V1YkpHUjhSRUtCbVZiT2ticDRP?=
 =?utf-8?B?VExxVmtkWm9rM0czd2NmMXV0QWp1N01WS3YrSXRReUplb21RLzhKTldaNUxS?=
 =?utf-8?B?SXlWb0VKeEdwYTN5YXRzNXZwMktiR04rWlpBMkZ3cVI5WXVNMXBVVTQ3aUFJ?=
 =?utf-8?B?Z0NCNmN3QzdSVmJkYnBVSjJsOU9rNjN5N215LytKck5WV1lpeWlRb3BtUmpX?=
 =?utf-8?B?c21yUXByTm9ZYTltQlNUWmdsOUJPS3poeFhOV29ESTQ4RDhkWGZ1UitVem9C?=
 =?utf-8?B?RDBLbjBWdGpoOVRxZ2J0Ynljb0hRSzBnSW5lS1ZxMEllcklXMmxsWHpjYUFt?=
 =?utf-8?B?dVkvNjRpQ0xrWm9uRVhGcTJ3RzNWbmMvcUlpVGhMa1FZMlQwVHY3ZXFDc3lZ?=
 =?utf-8?B?TFlOdDJ4RG1WWmdpQUdYS3lBUXVRQmx0MktKKzkwY2dvdGxvT3RpVkliTTZr?=
 =?utf-8?B?ZGZvbUpNZzdpNm9HdDcrOWJWbG5oQWZGWWV5cThXZ2xKeFRmcDgyVmRZNm93?=
 =?utf-8?B?V0JLY1BiVmFEK1R3UWtKMGYvenl0WTlOUW5YYUg2TTJFYW4rN2RyU3dNTUFD?=
 =?utf-8?B?MDA2K1RQbXh4aHRYbTNrTGgzRFlLS0ZoNVNyKzNTek92cGkrOHBMbmNOQ0pM?=
 =?utf-8?B?U3FBK2t6cVJTWmQ2Sk1RYmJoaWw1Vk9peGVnMjBtbC9EaGxieWVkenpLd1Fw?=
 =?utf-8?B?Y3NDa0dSRkZZVnU2dmpabkxVTThZdTNkQnk4M0N3YVB5eEF4ZWhXa1pwUFBJ?=
 =?utf-8?B?aHhicCtRVEc2eTlSS20vdXQvT01RYURiTVA4V3Z5NmxqekpqVlJoYVhNcG94?=
 =?utf-8?B?NU4wVlFMeHI1WmIzaThlL0VFRzRiMEhySFFuNWtlT2Y0QnhUWmFlY0ZiU3Rw?=
 =?utf-8?B?d0M4WnZCNUYyazNVcVdvbU1QT2JqdzRrZkt3UytoeGUxT1ZIWGs0KysxQUxm?=
 =?utf-8?B?Zk5zM0djSURFOTNmZFZUMVl2ekxSUnRkZlB5cUptTEVYemYwaEl3bjdCS2Jx?=
 =?utf-8?B?VnoyMVNraHhaKzdKM1BBanJZUEd3RmxvWDRoTTIyQ3ZpMSt1K0NUOVJQMGFx?=
 =?utf-8?B?M2pJU1AwUjlJUlFqalJYV1F0eFVpTUZENGxlZ2xSWmxCTWNudVBrTG9HQ3c3?=
 =?utf-8?B?U1UyVDRzWmh6TndIVzFDRncrL0JxclpnZGhuWFQxUkpXVFh4Z2ZySGhSTStE?=
 =?utf-8?B?VDBVd3JnR3lVS3c2SDkrQjJ6TUkzditiV20za3hyekV6S0ovLzJoZ0Z0TVdD?=
 =?utf-8?B?c2huZUlqQnVwODRZYWRWaHJ5WXN0alF1dDVOang4Sko0RjU2NmVaSGYzU2tn?=
 =?utf-8?B?TXlwRFp5SWYrNjBBYmQwcHdJd25JdnJaS1BpQ1ZzWHdMZUticWVPRGhkMmJT?=
 =?utf-8?B?NWhFanhsWm9OWFc2Vno4RGFWV2w2QnBUUVpJcGQrb0VMZmwxR2JhQWcxbkNI?=
 =?utf-8?B?cUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D27830A5C22D2D4E94DB00F117232C02@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b73dd9-2586-405d-5a06-08ddc07b5f8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 13:03:47.2417
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGBy7/CJb+xwS6G3WyfAV0v8FY5gbRSCI/sXUimRGqpM7AEbx1aNrqEPrzBneWKgTr1+lapy+oN1Ee11FOd1Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8217

SGksDQoNCldoaWxlIHRlc3RpbmcgU1ZBIGluIFFFTVUgd2l0aCBJbnRlbCBJT01NVSwgSSBlbmNv
dW50ZXJlZCBhIGRvdWJsZSBmcmVlIGluDQp0aGUga2VybmVsIHdoZW4gdW5iaW5kaW5nIGEgZGV2
aWNlIHdpdGggcGFnZSByZXF1ZXN0cyBzdGlsbCBpbiBmbGlnaHQuIFRoaXMNCnJlc3VsdHMgaW4g
YSB1c2UtYWZ0ZXItZnJlZSBlcnJvciBhbmQgZXZlbnR1YWxseSBhIGtlcm5lbCBwYW5pYzoNCg0K
WyAgIDQ4LjIyNzU5Nl0gcmVmY291bnRfdDogdW5kZXJmbG93OyB1c2UtYWZ0ZXItZnJlZS4NClsg
ICA0OC4yMjc5NDldIFdBUk5JTkc6IENQVTogMyBQSUQ6IDMxMyBhdCBsaWIvcmVmY291bnQuYzoy
OCByZWZjb3VudF93YXJuX3NhdHVyYXRlKzB4ZDgvMHhlMA0KWyAgIDQ4LjIyODUzMV0gTW9kdWxl
cyBsaW5rZWQgaW46IHN2YShPRSkgeGZzKEUpIHNyX21vZChFKSBzZF9tb2QoRSkgY2Ryb20oRSkg
c2coRSkgYWhjaShFKSBsaWJhaGNpKEUpIGxpYmF0YShFKSBlMTAwMChFKSBkbV9tb2QoRSkNClsg
ICA0OC4yMjk0NjBdIENQVTogMyBVSUQ6IDAgUElEOiAzMTMgQ29tbToga3dvcmtlci91MTY6NCBL
ZHVtcDogbG9hZGVkIFRhaW50ZWQ6IEcgICAgICAgICAgIE9FICAgICAgIDYuMTYuMC1yYzUrICM1
OSBQUkVFTVBUKHZvbHVudGFyeSkNClsgICA0OC4yMzAyMzFdIFRhaW50ZWQ6IFtPXT1PT1RfTU9E
VUxFLCBbRV09VU5TSUdORURfTU9EVUxFDQpbICAgNDguMjMwNTY4XSBIYXJkd2FyZSBuYW1lOiBR
RU1VIFN0YW5kYXJkIFBDIChRMzUgKyBJQ0g5LCAyMDA5KSwgQklPUyByZWwtMS4xNi4zLTAtZ2E2
ZWQ2YjcwMWYwYS1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQpbICAgNDguMjMxMjc4XSBX
b3JrcXVldWU6IGlvcGZfcXVldWUvZG1hcjAtaW9wZnEgaW9tbXVfc3ZhX2hhbmRsZV9pb3BmDQpb
ICAgNDguMjMxNjk3XSBSSVA6IDAwMTA6cmVmY291bnRfd2Fybl9zYXR1cmF0ZSsweGQ4LzB4ZTAN
ClsgICA0OC4yMzIwMjhdIENvZGU6IGZmIDQ4IGM3IGM3IDU4IGViIDJlIDgyIGM2IDA1IDQwIDJm
IDM1IDAxIDAxIGU4IGFlIGU4IGFiIGZmIDBmIDBiIGMzIDQ4IGM3IGM3IDAwIGViIDJlIDgyIGM2
IDA1IDJjIDJmIDM1IDAxIDAxIGU4IDk4IGU4IGFiIGZmIDwwZj4gMGIgYzMgMGYgMWYgNDQgMDAg
MDAzDQpbICAgNDguMjMzMjAyXSBSU1A6IDAwMTg6ZmZmZmM5MDAwMDhhZmU1MCBFRkxBR1M6IDAw
MDEwMjg2DQpbICAgNDguMjMzNTQxXSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmODg4
MTEzZGNjYjQwIFJDWDogMDAwMDAwMDAwMDAwMDAwMA0KWyAgIDQ4LjIzNDAwN10gUkRYOiBmZmZm
ODg4ODYxZGFhNDgwIFJTSTogMDAwMDAwMDAwMDAwMDAwMSBSREk6IGZmZmY4ODg4NjFkOWMxNDAN
ClsgICA0OC4yMzQ0NjFdIFJCUDogZmZmZjg4ODExMThlMDAwMCBSMDg6IDAwMDAwMDAwMDAwMDAw
MDAgUjA5OiBmZmZmYzkwMDAwOGFmY2Y4DQpbICAgNDguMjM0OTQyXSBSMTA6IGZmZmZjOTAwMDA4
YWZjZjAgUjExOiBmZmZmZmZmZjgyOWRmZGU4IFIxMjogZmZmZjg4ODEwMGY1YzAwMA0KWyAgIDQ4
LjIzNTM5Nl0gUjEzOiBmZmZmODg4MTAwMDUxYzAwIFIxNDogZmZmZjg4ODEwMGY1YzAwNSBSMTU6
IGZmZmY4ODgxMGM0ODAwMDANClsgICA0OC4yMzU4NjBdIEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgw
MDAwKSBHUzpmZmZmODg4OGRlYTRmMDAwKDAwMDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDANClsg
ICA0OC4yMzYzODFdIENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAw
NTAwMzMNClsgICA0OC4yMzY3NjNdIENSMjogMDAwMDU1ODMyOGFhNjQ2OCBDUjM6IDAwMDAwMDAx
MTEzMzIwMDIgQ1I0OiAwMDAwMDAwMDAwNzcwZWYwDQpbICAgNDguMjM3MjIyXSBQS1JVOiA1NTU1
NTU1NA0KWyAgIDQ4LjIzNzM5N10gQ2FsbCBUcmFjZToNClsgICA0OC4yMzc1NjFdICA8VEFTSz4N
ClsgICA0OC4yMzc3MjddICBpb3BmX2ZyZWVfZ3JvdXArMHhlLzB4MjANClsgICA0OC4yMzc5Nzhd
ICBwcm9jZXNzX29uZV93b3JrKzB4MTk3LzB4M2QwDQpbICAgNDguMjM4MjM5XSAgd29ya2VyX3Ro
cmVhZCsweDIzYS8weDM1MA0KWyAgIDQ4LjIzODQ4N10gID8gcmVzY3Vlcl90aHJlYWQrMHg0YTAv
MHg0YTANClsgICA0OC4yMzg3NjBdICBrdGhyZWFkKzB4ZjgvMHgyMzANClsgICA0OC4yMzg5NzJd
ICA/IGZpbmlzaF90YXNrX3N3aXRjaC5pc3JhLjArMHg4MS8weDI2MA0KWyAgIDQ4LjIzOTI5MF0g
ID8ga3RocmVhZHNfb25saW5lX2NwdSsweDExMC8weDExMA0KWyAgIDQ4LjIzOTU5OF0gID8ga3Ro
cmVhZHNfb25saW5lX2NwdSsweDExMC8weDExMA0KWyAgIDQ4LjIzOTg5OV0gIHJldF9mcm9tX2Zv
cmsrMHgxM2IvMHgxNzANClsgICA0OC4yNDAxNTVdICA/IGt0aHJlYWRzX29ubGluZV9jcHUrMHgx
MTAvMHgxMTANClsgICA0OC4yNDA0MzRdICByZXRfZnJvbV9mb3JrX2FzbSsweDExLzB4MjANClsg
ICA0OC4yNDA3MTFdICA8L1RBU0s+DQpbICAgNDguMjQwODY0XSAtLS1bIGVuZCB0cmFjZSAwMDAw
MDAwMDAwMDAwMDAwIF0tLS0NCg0KVGhlIHRyYWNlIHNob3cgdGhhdCBpdCdzIGNhdXNlZCBieSBh
IGRvdWJsZSBmcmVlIG9mIHRoZSBzYW1lIGlvcGYgZ3JvdXAgOg0KDQppcnEvMjQtZC02NiAgICAg
ICAgMi4uLi4uIDogaW9tbXVfcmVwb3J0X2RldmljZV9mYXVsdCA8LXBycV9ldmVudF90aHJlYWQN
CmlycS8yNC1kLTY2ICAgICAgICAyLi4uLi4gOiBpb3BmX2dldF9kZXZfZmF1bHRfcGFyYW0uaXNy
YS4wIDwtaW9tbXVfcmVwb3J0X2RldmljZV9mYXVsdA0KaXJxLzI0LWQtNjYgICAgICAgIDIuLi4u
LiA6IGlvcGZfZ3JvdXBfYWxsb2MgPC1pb21tdV9yZXBvcnRfZGV2aWNlX2ZhdWx0DQppcnEvMjQt
ZC02NiAgICAgICAgMi4uLi4uIDogaW9tbXVfc3ZhX2lvcGZfaGFuZGxlciA8LWlvbW11X3JlcG9y
dF9kZXZpY2VfZmF1bHQNCiAgICB0ZXN0LTE2MzMgICAgICAwLi4uLi4gOiBpb21tdV9zdmFfdW5i
aW5kX2RldmljZSA8LXRlc3RfaGFuZGxlLmlzcmEuMA0KICAgIHRlc3QtMTYzMyAgICAgIDAuLi4u
LiA6IGlvbW11X2RldGFjaF9kZXZpY2VfcGFzaWQgPC1pb21tdV9zdmFfdW5iaW5kX2RldmljZQ0K
ICAgIHRlc3QtMTYzMyAgICAgIDAuLi4uLiA6IGlvcGZfcXVldWVfcmVtb3ZlX2RldmljZSA8LWJs
b2NraW5nX2RvbWFpbl9zZXRfZGV2X3Bhc2lkDQogICAgdGVzdC0xNjMzICAgICAgMC4uLi4uIDog
aW9wZl9mcmVlX2dyb3VwIDwtaW9wZl9xdWV1ZV9yZW1vdmVfZGV2aWNlDQogICAgdGVzdC0xNjMz
ICAgICAgMC4uLi4uIDogaW9wZl9wdXRfZGV2X2ZhdWx0X3BhcmFtIDwtaW9wZl9mcmVlX2dyb3Vw
DQogICAgdGVzdC0xNjMzICAgICAgMC4uLi4uIDogaW9wZl9wdXRfZGV2X2ZhdWx0X3BhcmFtIDwt
aW9wZl9xdWV1ZV9yZW1vdmVfZGV2aWNlDQogICAgdGVzdC0xNjMzICAgICAgMC4uLi4uIDogaW9t
bXVfZG9tYWluX2ZyZWUgPC1pb21tdV9zdmFfdW5iaW5kX2RldmljZQ0Ka3dvcmtlci8tMzEzICAg
ICAgIDMuLi4uLiA6IGlvbW11X3N2YV9oYW5kbGVfaW9wZiA8LXByb2Nlc3Nfb25lX3dvcmsNCmt3
b3JrZXIvLTMxMyAgICAgICAzLi4uLi4gOiBpb3BmX2dyb3VwX3Jlc3BvbnNlIDwtaW9tbXVfc3Zh
X2hhbmRsZV9pb3BmDQprd29ya2VyLy0zMTMgICAgICAgMy4uLi4uIDogaW9wZl9mcmVlX2dyb3Vw
IDwtcHJvY2Vzc19vbmVfd29yaw0Ka3dvcmtlci8tMzEzICAgICAgIDMuLi4uLiA6IGlvcGZfcHV0
X2Rldl9mYXVsdF9wYXJhbSA8LWlvcGZfZnJlZV9ncm91cA0KDQpVbmJpbmRpbmcgYSBkZXZpY2Ug
d2hpbGUgcGFnZSByZXF1ZXN0cyBhcmUgc3RpbGwgaW4gZmxpZ2h0IGlzIGxpa2VseSBhbiBlZGdl
IA0KY2FzZSB0aGF0IHNob3VsZG4ndCBvY2N1ciwgYnV0IGludmVzdGlnYXRpbmcgaXQgaGFzIGxl
ZCBtZSB0byB0d28gcXVlc3Rpb25zOg0KDQoxLiBUaGUgaXNzdWUgYXBwZWFyIGF0IHRoZSBjb21t
aXQgMTdmY2U5ZDIzMzZkICgiaW9tbXUvdnQtZDogUHV0IGlvcGYNCmVuYWJsZW1lbnQgaW4gZG9t
YWluIGF0dGFjaCBwYXRoIiksIHdoZXJlIGRldmljZSBhcmUgbm93IGR5bmFtaWNhbGx5IGFkZGVk
IGFuZA0KcmVtb3ZlZCBmcm9tIHRoZSBpb3BmIHF1ZXVlLiBUaGlzIGNvbW1pdCBhZGQgYSBjYWxs
IHRvIHRoZSBuZXcNCmlvcGZfZm9yX2RvbWFpbl9yZW1vdmUoKSBmdW5jdGlvbiB3aGVuIHJlbW92
aW5nIHBhc2lkIDoNCg0KPiBAQCAtNDA0MSw2ICs0MDUzLDcgQEAgc3RhdGljIGludCBibG9ja2lu
Z19kb21haW5fc2V0X2Rldl9wYXNpZChzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQo+ICB7
DQo+ICAgICAgICAgc3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGRldl9pb21tdV9w
cml2X2dldChkZXYpOw0KPiANCj4gKyAgICAgICBpb3BmX2Zvcl9kb21haW5fcmVtb3ZlKG9sZCwg
ZGV2KTsNCj4gICAgICAgICBpbnRlbF9wYXNpZF90ZWFyX2Rvd25fZW50cnkoaW5mby0+aW9tbXUs
IGRldiwgcGFzaWQsIGZhbHNlKTsNCj4gICAgICAgICBkb21haW5fcmVtb3ZlX2Rldl9wYXNpZChv
bGQsIGRldiwgcGFzaWQpOw0KPg0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KDQpNb3Zpbmcg
aW9wZl9mb3JfZG9tYWluX3JlbW92ZSgpIGFmdGVyIGRvbWFpbl9yZW1vdmVfZGV2X3Bhc2lkKCkg
Zml4IHRoZSBpc3N1ZQ0KYWJvdmUuDQoNClNob3VsZG4ndCBpb3BmX2Zvcl9kb21haW5fcmVtb3Zl
KCkgYmUgY2FsbGVkIGFmdGVyDQppbnRlbF9wYXNpZF90ZWFyX2Rvd25fZW50cnkoKSBvciBkb21h
aW5fcmVtb3ZlX2Rldl9wYXNpZCgpIHRvIGVuc3VyZSB0aGUgZGV2aWNlDQpjYW4gbm8gbG9uZ2Vy
IHNlbmQgcGFnZSByZXF1ZXN0cyBhbmQgdGhlIHF1ZXVlIGhhcyBiZWVuIGZsdXNoZWQ/IElzIHRo
ZSBjdXJyZW50DQpvcmRlcmluZyBpbnRlbnRpb25hbD8NCg0KMi4gUmVnYXJkaW5nIGNvbW1pdCA5
NzU5YWUyY2VlN2MgKCJpb21tdTogRml4IHBvdGVudGlhbCBtZW1vcnkgbGVhayBpbg0KaW9wZl9x
dWV1ZV9yZW1vdmVfZGV2aWNlKCkiKTogdGhlIGNvbW1pdCBmcmVlcyB0aGUgcGVuZGluZyBJT1BG
IGdyb3VwcywgYnV0IGluDQp0aGUgc2NlbmFyaW8gYWJvdmUsIGRpcmVjdCByZWZlcmVuY2VzIHRv
IHRoZSBncm91cHMgc3RpbGwgZXhpc3RzIGVpdGhlciBpbiB0aGUNCmhhbmRsZXIgb3IgaW4gdGhl
IHdvcmtxdWV1ZSBhd2FpdGluZyBwcm9jZXNzaW5nLCBsZWFkaW5nIHRvIGEgZG91YmxlIGZyZWUu
DQpSZXZlcnRpbmcgdGhpcyBjb21taXQgZml4IHRoZSBpc3N1ZSBhYm92ZS4NCg0KSSBhbSBub3Qg
c3VyZSB0byBzZWUgd2hlcmUgaXMgdGhlIHBvdGVudGlhbCBtZW1vcnkgbGVhaywgaXMgdGhlcmUg
YSBjYXNlIHdoZXJlDQphIHJlZmVyZW5jZSB0byBhIGdyb3VwIGV4aXN0cyBvbmx5IGluIHRoZSBp
b21tdV9mYXVsdF9wYXJhbTo6ZmF1bHRzIHRoYXQgSSdtDQptaXNzaW5nPw0KDQpUaGFua3MsDQpF
dGhhbg==
