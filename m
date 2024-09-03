Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF7D1C7674;
	Tue,  3 Sep 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725353817; cv=fail; b=ha5DVckIqKOevxY3LruOg7fXhwt4iK+Bm2FkGEPGCV+9G1slWdIQAV9zeJJN8RSOHBlVIO9nk0ySaNZhi13ibFOxzmSZ7w+9dsGvbgSa30vAiBLhon3p9s0BTNR4r+gqYq7z9KxMNfLqyv6gKMfdurnHeok3zJsjWhEFEm+Saws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725353817; c=relaxed/simple;
	bh=bpXT6o6pA7H6ir4OZ4ET9I6X7ijKF6KM/j2CdccCTwU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qZV1aMM32fBJntXsqxRti1v0v9ibGEvF/GW8NELEXZE+QBAWAdtAXH98fA61apkcEK3iHjYUQcEXrLAJ9NgRlmZJzsY4lx/dKSVLxWEUqUa7IU5DwwxU3gj6/jW/u9WsuujtVQqWGOY2J/ODOeBk3mVdru/uINkZYA8/sFIF9gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JxoUFoIq; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JxoUFoIq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEcsTisE11NhpJAEXii1nFRFvwkLF0mY/K46eupHpbIFxkUtiPHIXQwDs+wzI/j8qTGcJjMJacVfZddr9YyX+ug/OaN6pTS6suFUCQV6d8CYe6/SrN2lja/Jb/DpnpE7x0hUWNZCpkWpoJ3IxMZcdEQfLN/0EsOp710pXHNDMaBtb9KDFZ1ljAkUwPhJBAVT7SluW1warNXggks2HGEGCURxDSySdRv7+W7BXmTFlNp5Hsbdmt+yF/CFI6rP7dEglDgU8F4dQ80NXxQi7vUGC8WWKfJuSUWICxhuyzHIB48+832rJwJPC/r/BZm1cu/u+8/jhlTlffdsf/ry2KWXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpXT6o6pA7H6ir4OZ4ET9I6X7ijKF6KM/j2CdccCTwU=;
 b=qzNscL20Mm4fL4Rh+O/jhOPDcTHT6weumoJqlL3LlMQ9D1Yf+X+fz4AnkjBTDBnDCD6Yp7mh4/fAn6pujd4cj18fqPj+1/L1bV0XJfLM0klnvLzbXOU5Hn54s4g9JLDHa8fzPMda3NXJE3npw8OsG5BkOm5l3zOsfOu3hYAwfEdfhJIRXzee3p8Xw81ByWzL5x03dF3cvWXJtUqxs1CiTABrepVVZoxJEdACdzpRESXhIpK0pFOpKGwgZ1ixqFwXUT7GgdTF/9awV4U1iII3WDii4egBhWt5DxRSmFwNJmKrL/c8NdeARu1Vtck667d82/0SJvCudpje3CaaCxghSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpXT6o6pA7H6ir4OZ4ET9I6X7ijKF6KM/j2CdccCTwU=;
 b=JxoUFoIqsVUkdo7Y+e2fIP7EcCy8Kcwq2wB8Av9mKU0eOVXEtepAftKJpOyVUDhOzDR82E1t17ZFjEnCOffsAhzkFseC1Nm18QCH+E80sF+DNTPQJ7UHSBkt117oaxYx7kB36zXdlZYOdpX2zjHvyTXaYMgJa7ntEaROYeQtuWgGZJ6GGUfgc7F6W4rrNV/tMSRE9xD/OhiLbsw/Fa9Hd727r5htR+xNJ4U6U8n7EWNhQL+EaJmkRqstQcoumZTMNP80+OXmHdI8CncSBzUXpPzWsS9prOPZgcs0PhJGxppe4JSwHBwUF2jtB44hEpmAkD/gjE/SWLnik+Ccq8RIZg==
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by AS8PR04MB8417.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 08:56:51 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427%7]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:56:49 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, "robh@kernel.org"
	<robh@kernel.org>
CC: "andy@black.fi.intel.com" <andy@black.fi.intel.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "hch@lst.de"
	<hch@lst.de>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"kernel@quicinc.com" <kernel@quicinc.com>, "klarasmodin@gmail.com"
	<klarasmodin@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"saravanak@google.com" <saravanak@google.com>, "will@kernel.org"
	<will@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, Jacky Bai
	<ping.bai@nxp.com>, Pengfei Li <pengfei.li_1@nxp.com>
Subject: RE: [PATCH v8 0/2] Dynamic Allocation of the reserved_mem array
Thread-Topic: [PATCH v8 0/2] Dynamic Allocation of the reserved_mem array
Thread-Index: AQHa+vnYJOMiVokLS0WrCafHYOFHZbJFwKmw
Date: Tue, 3 Sep 2024 08:56:49 +0000
Message-ID:
 <DU0PR04MB92999E9EEE959DBC3B1EAB6E80932@DU0PR04MB9299.eurprd04.prod.outlook.com>
References: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
In-Reply-To: <20240830162857.2821502-1-quic_obabatun@quicinc.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|AS8PR04MB8417:EE_
x-ms-office365-filtering-correlation-id: 2f4eb773-64c5-4e3c-936e-08dccbf658f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?TS9mMzREaEQ0dVZLY3lhaHJJajZUTzN2bGtQZENMZC9ldHhxTUE0cWoxUzRE?=
 =?gb2312?B?SWV1Wit5YnZFaVVSR0Vield5YlNLZE45MS9KZWN5cTlqZW13djRVUHo4SVRI?=
 =?gb2312?B?Y1cvVDZvNEFvYzZsWFhwYktQeG5yUWhxZEdtMDBOU1BYalk2Rno4Y2tldktT?=
 =?gb2312?B?bkcvV1l2VFI0RjVJOHBvaUdGdjhuOWJ2L1orQWxKYmJzazlQeko1SU81TGR2?=
 =?gb2312?B?bWVnWDBnd1RJekRDWm5GSEdzWVIybEVMV2RxazNySzI0STArZFlqUkdJcSs1?=
 =?gb2312?B?NnZtTmVGOW04Q0hkc0JrWkZSUEpTOFF2S2ZsL1J0dHEyQ0Y5UWdRYzFPT0dY?=
 =?gb2312?B?cnVCOVBMY1ozWEk3RUExYkpUTHpIL29xUER0Y2UvSmVhTmtqaUtJVGMvL0Jn?=
 =?gb2312?B?QjhCdytZMU5wU1ZzdDJZT2RWU0ZIdVVHTFl6WGU3MEVBSzBPWjRPcWhrNjZO?=
 =?gb2312?B?Zm1VeVNKaXVDZk10THZSNmVCN1BWM3ZQVmtNUHV1NDFNTHVUeEVHdThlMzJ3?=
 =?gb2312?B?U2RsUzFOUzM2c1lOZzJ5TnRUbWpXTUp0eWNvRi9jUndSR3V5bDEvNlI2STVj?=
 =?gb2312?B?RVNCbDBKblR6TE1iNHJrZTB5QmM3N2MrUFU3NEFvbUs0eVA3bCs0VTZsT0dM?=
 =?gb2312?B?algwSTl5UURPV0R6K0NoSjU5ZnB2N2hhdlFHd3R4WG5wb25RNlY5TVFxTnJu?=
 =?gb2312?B?ajVMMlNXdFV0RWNIZi85bzJWWUFhWTZGeG9wSkErLzNDa2UxaWdCMEdCR0li?=
 =?gb2312?B?VmdtazI3VTdkWE9YSW4yRzJCU2tRcHlaTUk4bGpyUDFENTFrZzhsT2x0MEg4?=
 =?gb2312?B?bjYrWDZxUTdDNFcydEphS2l6Ky85ZmNYdEFzdHRRREFwUkw2Qnc2Z0I0RDRm?=
 =?gb2312?B?V05VU09reWNZeDVlNHdHb1BIQzNjTnBJb1FIRW9iQ1loZkJLQUtCU3ROVnBr?=
 =?gb2312?B?ZDBzZ052UHlLbmVSeDNKclF1aDlhdjczM29vc00xSk41eFZMdUpIN2o3djlG?=
 =?gb2312?B?d1ExZE94cHY3SlNPYmc1NmVndlVqSDY5d0NNL1JrbVNZVW1zUlBxbzdUNUVa?=
 =?gb2312?B?L2orMFBWbEVJSTZLMVdUL0VCT3VERE5mUjJTbDdqR0dSOVNxN21DY3lIZFJV?=
 =?gb2312?B?aHBwVzQ1U3lZd3NINzBwaTljVXdHRFREandyN1VydHYyU25scVZMYzljdUhI?=
 =?gb2312?B?eGVBRktVcjU1T1pKUlBVWlF4TEpiMXY2RFhzMEJDRzZBWUxBYUNDZ1dVdTlY?=
 =?gb2312?B?azU5SlFYN3B5QnFYUlRuRHFSdGk3ZnV2eVU4N1JiOVVNZEIwaE1KMGdBeGg3?=
 =?gb2312?B?L2Z6cUMvbWd1ZmhqREM0eUZhdXZrRmh3UmxmYUdLWFdBdkVvdTVnbzJXdWVv?=
 =?gb2312?B?QnBDUGJiQU9XSm1xdzh3MU13Q1pTekkwZ1R5TUdqTXloVFc4M0xhS2NlS1hZ?=
 =?gb2312?B?SnpWN0orRWlMckk2K2JMdEZGUGJyeXFNSU5JVk5obWg2VWJsbDU1L2pDeVZV?=
 =?gb2312?B?WW8vNFIvR3NXbU1XajNSelk0eGxvcVJEWjlWNmNmaUlvZS80Sk5UWjFMUnJn?=
 =?gb2312?B?K2IxcytwZUV4dGs5a05Lb2J1c2ZkYkVNSUxlVGJLOVI0VGZudW5Gd2txL0tZ?=
 =?gb2312?B?REI2SjVsckQrSE5PZnJXckhlNERaODNrcWlJQlpkUWgxd2RUV0s1UmFBQWFC?=
 =?gb2312?B?SEJIYnc5K1dDaE1TTnI1ZGNabkxhdDN4UHc5REhhSmprRG14TGRFMW1XQVZO?=
 =?gb2312?B?Z1pWQ25RazlZRkpRWDc3OUJqSFloVkp3OEsxRENla2IxNERKejJoTGRRQisx?=
 =?gb2312?B?bGMxU3hFOTFDM3pON0RhREVRWFQzTUJ4ZXBJRlFpR2VsZU1WSGxuWkVjYXBE?=
 =?gb2312?B?Y1FnM2gvcVJUL3FFS3lpdUlpcGtxT2RNZmFEalZvNXREWGc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MEFhVUJ6b3RZcFN5ekNtQkxIM3pZQXdtaTgzRHZNNXVJclgwU2RVWDM3WXFt?=
 =?gb2312?B?Wmc1WXMvaU5qWGU1NC85WU04Wm9ZbzBjQlQvNnZZNkJjSEovQzMvZ0l0UGxs?=
 =?gb2312?B?eUJ4bWYzVVZSYjU3cnhhalZOVUttMXQvY0FxbjRxRkVneHBTV2NDVGpKLysz?=
 =?gb2312?B?K0ZYaEdCTndaZW5qN2lxNElndHJvdHk4b3poSzRnb0pXUktpejZLK0lRK0to?=
 =?gb2312?B?QVBYN2JVdDY5MkVETnZxODlqN3FYRnpQd2trTm1yM3VjTEFyRWVSK2w3OTFk?=
 =?gb2312?B?MVd3ZWJobTRRYTdLUlRnLzBObjhMeUpJUlBRSXJydjR2UHYvWERjNWpiM1JV?=
 =?gb2312?B?VG9xdzdQaHpwTXVBa2hxOXVGWmpDU0QrN2tESXZXZzJNSmFrOTk0Q0pDMi9D?=
 =?gb2312?B?SzcrbG9veGU5cjByc0JFY1NFWmN4MDEvQVphWkxqekhhWnpKQzRXNFAzYy94?=
 =?gb2312?B?RWttTUlzTmRYbG5VMEwrRVRic001eGdXbTJDTWYrWnN6TkY4ZEdFQ3p2enBR?=
 =?gb2312?B?TXZHeVdFaWc1OWRQc1Focjk1QTZyWmRCK2tiT1NuRkNWVFpCaEJ5UWRaZHF4?=
 =?gb2312?B?aTBEdk1jQVBSSkxvcTVBWUVqVWE3MFY1QUNhMUJFUHBISENaeEQzSDdNb1Zj?=
 =?gb2312?B?bmZGaG1OQWNaSVFYUlhFNE80aW9rWUk1YjBQQmpucC9JbHU3cnBFTURRdTNV?=
 =?gb2312?B?bTU0cll4MmY3Qm1jQTBQSXVHQXpNVnhabXpRQ3Zwam0waTBtaGY0L05hRXc0?=
 =?gb2312?B?d2ZSRXE5QUcvSVdHcUdWYVBmSEM2d2grQjdMd0VRQU5UcHVMRXZNajhoNTk4?=
 =?gb2312?B?clNVSHM1OVJ1SGVFODBOcmtjYklFVVMxRGkwYXRERjA2d0t1VUZHM0tTRlM0?=
 =?gb2312?B?bnl5RVF4MHJlbkZwcFRMTjJZVGlsaGJQTUp0cXNWK3NNWlM2VXlCcjJYWXVR?=
 =?gb2312?B?RndpelM0anBLL2pRaFI4OFovdmtQVGk1bnhab3doTTE4eVBLTURSRW55WmFK?=
 =?gb2312?B?UDhoZFQzWlU3MnF1TTZFcDFKKzVGMERYa3JEYThWSmFKQmNlSHN2emtDQ1Jo?=
 =?gb2312?B?dGg2UVRsZ3JITFBzZ3ZXTWlZdHJJNzVQMndpSVN1OUR0SDFURWdSRC8xS25Y?=
 =?gb2312?B?c0NLdlNXWGVMeVlDdHZqcklGV2Q4WVFybk94NVNIdmE1UTBHa2I2a3ROa3Y2?=
 =?gb2312?B?Y3ZmYXJtV2lBaTRwSUsyaklsaDNlYWV3WSsvMXpJczNvUlcrbW1LMFNKeTYr?=
 =?gb2312?B?dFY2ZjFwZm5RYVUwZFhFSVh0WmZBSnhaQ3dIbVlGdENET2k2cEVMS2hqc1Va?=
 =?gb2312?B?dUhZVjhYLzVyNStwWjNIeXpWMmExQU05aGJSZUY3aFBMbWFueFZST05nVy9K?=
 =?gb2312?B?bHR4UXFvTVowYnY0a09NSXJSOTlwWGJSMy8yNnJiU2tHcFFzcWdMWE1NMk9G?=
 =?gb2312?B?dzBkcEE3ZUxFK0tybEFEVUdGZWdlblRLNjZwTVZvU1V2WFVwUW9JV3krdlQ1?=
 =?gb2312?B?bW9RRlRhK3RxNU42UXVSNWpsSFhyTXJhMUR4S2xSa0hZQTE0TzVxd2dCaDFK?=
 =?gb2312?B?TjIxV2x5NmNFWnpIMkNJNDdjUTZjeGNheU85U01rM1V0NHJDVXMyZkJYMmI4?=
 =?gb2312?B?L3FJTCs0dVJobWFiME1YWFJ5NXZpUFdPNVVCRWlPUkZpdzYxdGNsQ0RtbFQw?=
 =?gb2312?B?ZXpSZ1VDUmxNSFQ0SFlPZ2d0TXh5Z0NsRG1EQ1NidUxrcUNYc210L2hMbVFi?=
 =?gb2312?B?ZVQ5QXpyaFlqY2NtV24vbUJ4d3c3a2EzRG5PT0tLaHV3ellPbXZYTVFoVFdD?=
 =?gb2312?B?WVpZMjAyUzRxaWJKTUFrSWpmZTIvWnJTSHJWeUhDVkdwaEY5WVpVbGZtM1ht?=
 =?gb2312?B?OERlWlEyaFo1QTdSZStDTzJXSUZZUFpPNmw2ZWhxVms1WnRTQloyWUhIbW4w?=
 =?gb2312?B?UFJDcnovcmxLVkVOS013QWZwY2F0alMwMndzOTF4cFU5SFNpQ2dlNjZkSStn?=
 =?gb2312?B?ZDZDTGszNUtuQmN3STBGek5wQzhMVzN5UTZ1a3BXcjllbzJTeStXUHF5aDZX?=
 =?gb2312?B?MEd6ekUvay95eUtuNjI4bnJ5bkk1RkdUUmhldXdLejFKS3pzZ1lUbUg1c29l?=
 =?gb2312?Q?ZX02fRobXA6ip9+VkDy/8oYWR?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4eb773-64c5-4e3c-936e-08dccbf658f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 08:56:49.4198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iHJhs+dq7HzKb6aGRFDNcgitr3cFWaE7alcO1yPb+YkpQ5mCO4tJN+fWOYAhaCRWDzX9EbHq66cd5FfgYp7dJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8417

PiBGcm9tOiBPcmVvbHV3YSBCYWJhdHVuZGUgPHF1aWNfb2JhYmF0dW5AcXVpY2luYy5jb20+DQo+
IFNlbnQ6IDIwMjTE6jjUwjMxyNUgMDoyOQ0KPiBTdWJqZWN0OiBbUEFUQ0ggdjggMC8yXSBEeW5h
bWljIEFsbG9jYXRpb24gb2YgdGhlIHJlc2VydmVkX21lbSBhcnJheQ0KPiANCj4gVGhlIHJlc2Vy
dmVkX21lbSBhcnJheSBpcyB1c2VkIHRvIHN0b3JlIGRhdGEgZm9yIHRoZSBkaWZmZXJlbnQgcmVz
ZXJ2ZWQNCj4gbWVtb3J5IHJlZ2lvbnMgZGVmaW5lZCBpbiB0aGUgRFQgb2YgYSBkZXZpY2UuICBU
aGUgYXJyYXkgc3RvcmVzIGluZm9ybWF0aW9uDQo+IHN1Y2ggYXMgcmVnaW9uIG5hbWUsIG5vZGUg
cmVmZXJlbmNlLCBzdGFydC1hZGRyZXNzLCBhbmQgc2l6ZSBvZiB0aGUgZGlmZmVyZW50DQo+IHJl
c2VydmVkIG1lbW9yeSByZWdpb25zLg0KPiANCj4gVGhlIGFycmF5IGlzIGN1cnJlbnRseSBzdGF0
aWNhbGx5IGFsbG9jYXRlZCB3aXRoIGEgc2l6ZSBvZg0KPiBNQVhfUkVTRVJWRURfUkVHSU9OUyg2
NCkuIFRoaXMgbWVhbnMgdGhhdCBhbnkgc3lzdGVtIHRoYXQgc3BlY2lmaWVzIGENCj4gbnVtYmVy
IG9mIHJlc2VydmVkIG1lbW9yeSByZWdpb25zIGdyZWF0ZXIgdGhhbg0KPiBNQVhfUkVTRVJWRURf
UkVHSU9OUyg2NCkgd2lsbCBub3QgaGF2ZSBlbm91Z2ggc3BhY2UgdG8gc3RvcmUgdGhlDQo+IGlu
Zm9ybWF0aW9uIGZvciBhbGwgdGhlIHJlZ2lvbnMuDQo+IA0KPiBUaGlzIGNhbiBiZSBmaXhlZCBi
eSBtYWtpbmcgdGhlIHJlc2VydmVkX21lbSBhcnJheSBhIGR5bmFtaWNhbGx5IHNpemVkIGFycmF5
DQo+IHdoaWNoIGlzIGFsbG9jYXRlZCB1c2luZyBtZW1ibG9ja19hbGxvYygpIGJhc2VkIG9uIHRo
ZSBleGFjdCBudW1iZXIgb2YNCj4gcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMgZGVmaW5lZCBpbiB0
aGUgRFQuDQo+IA0KPiBPbiBhcmNoaXRlY3R1cmVzIHN1Y2ggYXMgYXJtNjQsIG1lbWJsb2NrIGFs
bG9jYXRlZCBtZW1vcnkgaXMgbm90IHdyaXRhYmxlDQo+IHVudGlsIGFmdGVyIHRoZSBwYWdlIHRh
YmxlcyBoYXZlIGJlZW4gc2V0dXAuDQo+IFRoaXMgaXMgYW4gaXNzdWUgYmVjYXVzZSB0aGUgY3Vy
cmVudCBpbXBsZW1lbnRhdGlvbiBpbml0aWFsaXplcyB0aGUgcmVzZXJ2ZWQNCj4gbWVtb3J5IHJl
Z2lvbnMgYW5kIHN0b3JlcyB0aGVpciBpbmZvcm1hdGlvbiBpbiB0aGUgYXJyYXkgYmVmb3JlIHRo
ZSBwYWdlDQo+IHRhYmxlcyBhcmUgc2V0dXAuIEhlbmNlLCBkeW5hbWljYWxseSBhbGxvY2F0aW5n
IHRoZSByZXNlcnZlZF9tZW0gYXJyYXkgYW5kDQo+IGF0dGVtcHRpbmcgdG8gd3JpdGUgaW5mb3Jt
YXRpb24gdG8gaXQgYXQgdGhpcyBwb2ludCB3aWxsIGZhaWwuDQo+IA0KPiBUaGVyZWZvcmUsIHRo
ZSBhbGxvY2F0aW9uIG9mIHRoZSByZXNlcnZlZF9tZW0gYXJyYXkgd2lsbCBuZWVkIHRvIGJlIGRv
bmUgYWZ0ZXINCj4gdGhlIHBhZ2UgdGFibGVzIGhhdmUgYmVlbiBzZXR1cCwgd2hpY2ggbWVhbnMg
dGhhdCB0aGUgcmVzZXJ2ZWQgbWVtb3J5DQo+IHJlZ2lvbnMgd2lsbCBhbHNvIG5lZWQgdG8gd2Fp
dCB1bnRpbCBhZnRlciB0aGUgcGFnZSB0YWJsZXMgaGF2ZSBiZWVuIHNldHVwIHRvIGJlDQo+IHN0
b3JlZCBpbiB0aGUgYXJyYXkuDQo+IA0KPiBXaGVuIHByb2Nlc3NpbmcgdGhlIHJlc2VydmVkIG1l
bW9yeSByZWdpb25zIGRlZmluZWQgaW4gdGhlIERULCB0aGVzZSByZWdpb25zDQo+IGFyZSBtYXJr
ZWQgYXMgcmVzZXJ2ZWQgYnkgY2FsbGluZyBtZW1ibG9ja19yZXNlcnZlKGJhc2UsIHNpemUpLg0K
PiBXaGVyZTogIGJhc2UgPSBiYXNlIGFkZHJlc3Mgb2YgdGhlIHJlc2VydmVkIHJlZ2lvbi4NCj4g
CXNpemUgPSB0aGUgc2l6ZSBvZiB0aGUgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbi4NCj4gDQo+IERl
cGVuZGluZyBvbiBpZiB0aGF0IHJlZ2lvbiBpcyBkZWZpbmVkIHVzaW5nIHRoZSAibm8tbWFwIiBw
cm9wZXJ0eSwNCj4gbWVtYmxvY2tfbWFya19ub21hcChiYXNlLCBzaXplKSBpcyBhbHNvIGNhbGxl
ZC4NCj4gDQo+IFRoZSAibm8tbWFwIiBwcm9wZXJ0eSBpcyB1c2VkIHRvIGluZGljYXRlIHRvIHRo
ZSBvcGVyYXRpbmcgc3lzdGVtIHRoYXQgYQ0KPiBtYXBwaW5nIG9mIHRoZSBzcGVjaWZpZWQgcmVn
aW9uIG11c3QgTk9UIGJlIGNyZWF0ZWQuIFRoaXMgYWxzbyBtZWFucyB0aGF0IG5vDQo+IGFjY2Vz
cyAoaW5jbHVkaW5nIHNwZWN1bGF0aXZlIGFjY2Vzc2VzKSBpcyBhbGxvd2VkIG9uIHRoaXMgcmVn
aW9uIG9mIG1lbW9yeQ0KPiBleGNlcHQgd2hlbiBpdCBpcyBjb21pbmcgZnJvbSB0aGUgZGV2aWNl
IGRyaXZlciB0aGF0IHRoaXMgcmVnaW9uIG9mIG1lbW9yeSBpcw0KPiBiZWluZyByZXNlcnZlZCBm
b3IuWzFdDQo+IA0KPiBUaGVyZWZvcmUsIGl0IGlzIGltcG9ydGFudCB0byBjYWxsIG1lbWJsb2Nr
X3Jlc2VydmUoKSBhbmQNCj4gbWVtYmxvY2tfbWFya19ub21hcCgpIG9uIGFsbCB0aGUgcmVzZXJ2
ZWQgbWVtb3J5IHJlZ2lvbnMgYmVmb3JlIHRoZQ0KPiBzeXN0ZW0gc2V0cyB1cCB0aGUgcGFnZSB0
YWJsZXMgc28gdGhhdCB0aGUgc3lzdGVtIGRvZXMgbm90IHVua25vd2luZ2x5DQo+IGluY2x1ZGUg
YW55IG9mIHRoZSBuby1tYXAgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMgaW4gdGhlIG1lbW9yeSBt
YXAuDQo+IA0KPiBUaGVyZSBhcmUgdHdvIHdheXMgdG8gZGVmaW5lIGhvdy93aGVyZSBhIHJlc2Vy
dmVkIG1lbW9yeSByZWdpb24gaXMgcGxhY2VkDQo+IGluIG1lbW9yeToNCj4gaSkgU3RhdGljYWxs
eS1wbGFjZWQgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMgaS5lLiByZWdpb25zIGRlZmluZWQgd2l0
aCBhIHNldA0KPiBzdGFydCBhZGRyZXNzIGFuZCBzaXplIHVzaW5nIHRoZQ0KPiAgICAgICJyZWci
IHByb3BlcnR5IGluIHRoZSBEVC4NCj4gaWkpIER5bmFtaWNhbGx5LXBsYWNlZCByZXNlcnZlZCBt
ZW1vcnkgcmVnaW9ucy4NCj4gaS5lLiByZWdpb25zIGRlZmluZWQgYnkgc3BlY2lmeWluZyBhIHJh
bmdlIG9mIGFkZHJlc3NlcyB3aGVyZSB0aGV5IGNhbg0KPiAgICAgIGJlIHBsYWNlZCBpbiBtZW1v
cnkgdXNpbmcgdGhlICJhbGxvY19yYW5nZXMiIGFuZCAic2l6ZSIgcHJvcGVydGllcw0KPiAgICAg
IGluIHRoZSBEVC4NCj4gDQo+IFRoZSBkeW5hbWljYWxseS1wbGFjZWQgcmVzZXJ2ZWQgbWVtb3J5
IHJlZ2lvbnMgZ2V0IGFzc2lnbmVkIGEgc3RhcnQgYWRkcmVzcw0KPiBvbmx5IGF0IHJ1bnRpbWUu
IEFuZCB0aGlzIG5lZWRzIHRvICBiZSBkb25lIGJlZm9yZSB0aGUgcGFnZSB0YWJsZXMgYXJlIHNl
dHVwDQo+IHNvIHRoYXQgbWVtYmxvY2tfcmVzZXJ2ZSgpIGFuZCBtZW1ibG9ja19tYXJrX25vbWFw
KCkgY2FuIGJlIGNhbGxlZCBvbg0KPiB0aGUgYWxsb2NhdGVkIHJlZ2lvbiBhcyBleHBsYWluZWQg
YWJvdmUuDQo+IFNpbmNlIHRoZSBkeW5hbWljYWxseSBhbGxvY2F0ZWQgcmVzZXJ2ZWRfbWVtIGFy
cmF5IGNhbiBvbmx5IGJlIGF2YWlsYWJsZQ0KPiBhZnRlciB0aGUgcGFnZSB0YWJsZXMgaGF2ZSBi
ZWVuIHNldHVwLCB0aGUgaW5mb3JtYXRpb24gZm9yIHRoZQ0KPiBkeW5hbWljYWxseS1wbGFjZWQg
cmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMgbmVlZHMgdG8gYmUgc3RvcmVkIHNvbWV3aGVyZQ0KPiB0
ZW1wb3JhcmlseSB1bnRpbCB0aGUgcmVzZXJ2ZWRfbWVtIGFycmF5IGlzIGF2YWlsYWJsZS4NCj4g
DQo+IFRoZXJlZm9yZSwgdGhpcyBzZXJpZXMgbWFrZXMgdXNlIG9mIGEgdGVtcG9yYXJ5IHN0YXRp
YyBhcnJheSB0byBzdG9yZSB0aGUNCj4gaW5mb3JtYXRpb24gb2YgdGhlIGR5bmFtaWNhbGx5LXBs
YWNlZCByZXNlcnZlZCBtZW1vcnkgcmVnaW9ucyB1bnRpbCB0aGUNCj4gcmVzZXJ2ZWRfbWVtIGFy
cmF5IGlzIGFsbG9jYXRlZC4NCj4gT25jZSB0aGUgcmVzZXJ2ZWRfbWVtIGFycmF5IGlzIGF2YWls
YWJsZSwgdGhlIGluZm9ybWF0aW9uIGlzIGNvcGllZCBvdmVyIGZyb20NCj4gdGhlIHRlbXBvcmFy
eSBhcnJheSBpbnRvIHRoZSByZXNlcnZlZF9tZW0gYXJyYXksIGFuZCB0aGUgbWVtb3J5IGZvciB0
aGUNCj4gdGVtcG9yYXJ5IGFycmF5IGlzIGZyZWVkIGJhY2sgdG8gdGhlIHN5c3RlbS4NCj4gDQo+
IFRoZSBpbmZvcm1hdGlvbiBmb3IgdGhlIHN0YXRpY2FsbHktcGxhY2VkIHJlc2VydmVkIG1lbW9y
eSByZWdpb25zIGRvZXMgbm90DQo+IG5lZWQgdG8gYmUgc3RvcmVkIGluIGEgdGVtcG9yYXJ5IGFy
cmF5IGJlY2F1c2UgdGhlaXIgc3RhcnRpbmcgYWRkcmVzcyBpcw0KPiBhbHJlYWR5IHN0b3JlZCBp
biB0aGUgZGV2aWNldHJlZS4NCj4gT25jZSB0aGUgcmVzZXJ2ZWRfbWVtIGFycmF5IGlzIGFsbG9j
YXRlZCwgdGhlIGluZm9ybWF0aW9uIGZvciB0aGUNCj4gc3RhdGljYWxseS1wbGFjZWQgcmVzZXJ2
ZWQgbWVtb3J5IHJlZ2lvbnMgaXMgYWRkZWQgdG8gdGhlIGFycmF5Lg0KPiANCg0KSSB0ZXN0ZWQg
d2l0aCBNWDhVTFAgdGhhdCByZW1vdGVwcm9jIGJlY2FtZSB1bndvcmsgYWZ0ZXIgYXBwbHlpbmcg
dGhpcyBwYXRjaHNldC4NClRoZSBzYW1lIGlzc3VlIGV4aXN0IGluIGxpbnV4LW5leHQgd2l0aCB0
YWcgbmV4dC0yMDI0MDgxOS4NCg0KUm9vdCBjYXVzZSBpcyB0aGF0IHRoaXMgcGF0Y2hzZXQgYnJl
YWtzIHRoZSBBUEkgb2ZfcmVzZXJ2ZWRfbWVtX2RldmljZV9pbml0X2J5X2lkeCgpDQp1c2VkIGJ5
IGNvaGVyZW50IGRtYSAoa2VybmVsL2RtYS9jb250aWd1b3VzLmMpIGR1ZSB0byBybWVtLT5vcHMg
d2FzIG5vdA0KcHJvcGVybHkgc2F2ZWQgaW4gZmR0X2luaXRfcmVzZXJ2ZWRfbWVtX25vZGUoKSBh
ZnRlciBjYWxsaW5nIHJlc2VydmVkIG1lbW9yeQ0Kc2V0dXAgZnVuY3Rpb24uIGUuZy4gcm1lbV9k
bWFfc2V0dXAuDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiBOb3RlOg0KPiBCZWNhdXNlIG9mIHRo
ZSB1c2Ugb2YgYSB0ZW1wb3JhcnkgYXJyYXkgdG8gc3RvcmUgdGhlIGluZm9ybWF0aW9uIG9mIHRo
ZQ0KPiBkeW5hbWljYWxseS1wbGFjZWQgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMsIHRoZXJlIHN0
aWxsIGV4aXN0cyBhIGxpbWl0YXRpb24gb2YNCj4gNjQgZm9yIHRoaXMgcGFydGljdWxhciBraW5k
IG9mIHJlc2VydmVkIG1lbW9yeSByZWdpb25zLg0KPiBGcm9tIG15IG9ic2VydmF0aW9uLCB0aGVz
ZSByZWdpb25zIGFyZSB0eXBpY2FsbHkgc21hbGwgaW4gbnVtYmVyIGFuZCBoZW5jZSBJDQo+IGV4
cGVjdCB0aGlzIHRvIG5vdCBiZSBhbiBpc3N1ZSBmb3Igbm93Lg0KPiANCj4gUGF0Y2ggVmVyc2lv
bnM6DQo+IHY4Og0KPiAtIENoZWNrIHRoZSB2YWx1ZSBvZiBpbml0aWFsX2Jvb3RfcGFyYW1zIGlu
DQo+ICAgZmR0X3NjYW5fcmVzZXJ2ZWRfbWVtX3JlZ19ub2RlcygpIHRvIGF2b2lkIGJyZWFrYWdl
IG9uIGFyY2hpdGVjdHVyZXMNCj4gICB3aGVyZSB0aGlzIGlzIG5vdCBiZWluZyB1c2VkIGFzIHdh
cyBmb3VuZCB0byBiZSB0aGUgY2FzZSBmb3IgeDg2IGluDQo+ICAgdGhlIGlzc3VlcyByZXBvcnRl
ZCBiZWxvdzoNCg0K
