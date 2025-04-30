Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1152B9A9;
	Wed, 30 Apr 2025 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746013294; cv=fail; b=CJsmTP8MpTnVL9m+om2eSfPlJxOWZSWPP33Ijw7yYkyoFem1kjvtaQ6AxeR3HhpsREbT7EgagVMvuoS4TOSJZuZO2460irbAsz0qs0aR2kvcXDNaKqSCdfdGewIuVP9QnQhVWX7SUUIXAmoEpzWGmtgBCo5aXdehR1YBvK9EeNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746013294; c=relaxed/simple;
	bh=QB/9XtNMj4rRO9rK6mKhm9x6MGhujQuUabmSgvjyW1Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a0vKzgVxeENYDX6M7ApC5s/FGpYFF0dIvyBiQbY8oG3gJsEQS2uHhiZTCw2ij/nO0RmBHAicPvLJU+b/0nJcxkW3JV10iSeAzqxwacJU4StpPhRgdwbg6TengNqb6t9Lc+DK3jSEzH+2uwM0cfwD3rwgYdW3DU0M2EsmnU6Y38U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HPD9sZ4q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IsSXX0dD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HPD9sZ4q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IsSXX0dD"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53U6Qm1c015951;
	Wed, 30 Apr 2025 11:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+x8Sn2U+/HCYLZz+5AIQof+TAGoBkkF9Drw0JMSw66A=; b=
	HPD9sZ4qYHP4Fo4usjeNiHOynxMKMF9x+Z7iSj7G7oW2Wd/RDtMZF6eZmvlYBBKO
	U9dI9S5gpk/SlOs4WP2SUsYlpAGGNI0D9SCsL8IBwwWG/pt/w33NNxLP0K1mAc4D
	n4LIj+Hd6FYzdUqoaOMRsIIXJAqLF6JB4wxNhrsfBzYOo0n6r2mrV3BeC9gcve6O
	ndub8oIW8h3Sjlk0TAdspX+d3iNCNuqJ1qA9c3gM+Wm/ZXWSSgKyxm65Cvj1PVXP
	2ex2XHyPVEN93onFmjjF351CM//rVqLDRWTgRMnC/TX6hd8Q41vhst1Xrtj+f8lk
	wYQQfynjHNO7QpgpTOdI4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ucgyte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 11:41:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UB2t3M011323;
	Wed, 30 Apr 2025 11:41:15 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbpy6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 11:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=St7PTaqfiVtdKiYSfMDlw2liw/HpuDY0jvVzUn/93D8cHeAVE5kXhAkfFtyGFa9I6FohhDsfav4yY1t2ce8LhmoxrlFe4YhvebaAYv5kWdi4o1x8HbawcVMKHVWkImRPcgT2azP0vJRCqhPlzw2toBnbqfuzfZLHY+WKvocP4LUOFuQouXNOqCxD67djiHoyOFTULRFTvrdKc8toMdEg9qeY4/VtdJ44vXqvAKeIoJfRib4TYjXM38RuC7XFr5Fmq4qw0dAURfrGTK6FOi1Ibd+rCR/szO60QRyCkkp40Zo9rFSLvyye9lv2zNwBjLlcJU/ipvEX5TNO8dWsgH73Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+x8Sn2U+/HCYLZz+5AIQof+TAGoBkkF9Drw0JMSw66A=;
 b=um9irj6Wl4Dn8quc5Mn/9N7aOE4wXWVF/b2nYX1lfWPUtKe5TZkpAJWSr38QijEuDaiEzsdj6dvy9lsWdByPq9uBMM3zEcDw5gWUUQ1HGvSPUgoteCNlUCxrJlsWnNqfFbDhAG0ZKe03fJpMcthswlqo+ugMb5zDlrq0nrj+bMmx1yQr90IiTSYLkcfIiiBxdmFphwDZK6knHpY741pX9seZglibvZSE/zHUpJH5YUAb8YwUaC+k5zFfr8OpchkpD72Y9eicAyxQgMnXUYVZsKEDD3amBUi/pIdA6Xo+YriikE81N2CrPn+XxTFC7l4aYg6NeTJ9bh5Zcv31lW/coA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+x8Sn2U+/HCYLZz+5AIQof+TAGoBkkF9Drw0JMSw66A=;
 b=IsSXX0dD+8q7xgKQHC3PqlT2cCCTidjI6Mt7PywBFZgNfzo/hACbC1L3j/Vtprdpr/83S6b1ZhH/a42JyyEKihCnEGMxRn1yUSMlR4SZ9mKki1RxEjd0Fmn1t+9YTpz/qpBMF71MS3WbJmbA3Uopz0D6GsXtuGixTPpZ5F0/DZw=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by DS7PR10MB7250.namprd10.prod.outlook.com
 (2603:10b6:8:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 11:41:12 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3%2]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 11:41:12 +0000
Message-ID: <4f04d596-685e-4e48-9038-8aee6c927ebc@oracle.com>
Date: Wed, 30 Apr 2025 12:41:04 +0100
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
 <g3xrnjfs6zekogfohud2s7kdvphx43e6mdh3vfpllynrwokxwf@vvetz2j2nrai>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <g3xrnjfs6zekogfohud2s7kdvphx43e6mdh3vfpllynrwokxwf@vvetz2j2nrai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0107.apcprd02.prod.outlook.com
 (2603:1096:4:92::23) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c773fe5-124c-44aa-c6f9-08dd87dbe865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WldjeGpNSnQ2ZjA2Q3lhN3VUd3FVK0lvbVNIeG12eno2QWxzUUQ1Vk5ta3B2?=
 =?utf-8?B?UDRHT21ITzd1V2x3U2hvRmJkWE5GWElBSGJIamI5eFRnN0RMb29aWDFWVkdK?=
 =?utf-8?B?aTFNaVBkVDYvc0JCZTVXQ0RWRkw4MGpyOEorM1RidW5wTmRjM0ZMQy96bC9D?=
 =?utf-8?B?VzY5MHFvS0FlZ0dDeXhCK1g3N25QMndyV2RlVFRGYU5zR1BqWUpEbmxjVVAy?=
 =?utf-8?B?QzV2YmZqT0E0T1d1czluRmU5bkUvSHJ3VS96NDB5cklHRVVqYzBUU2cwWFI4?=
 =?utf-8?B?R3V2cFJINkdocEVOYk1FNDU3L1pvT0RsOGhsNHJwd0VDVkpZMjBnbDc2VGlV?=
 =?utf-8?B?M3JuQ3hJOVg5V0FJNTJXK0h2c2ZFSDN2RGhyVGd1MlpvODlub0dBaDRIdnRZ?=
 =?utf-8?B?K3VTK1pTcjYzWDZkcTVVU0k3TjNXMjBGR0RVV0JRaGdBb2hzaEZPbS8rbzJj?=
 =?utf-8?B?aldZZ1ZRbFZUaUpiUkFucUdkblhLem4vVUthekYyaTJ3SStqVnRNbjNQektz?=
 =?utf-8?B?VlBEOFowY0lEa1VScGJxaEZVUk9LbGRuM29ZZU9OTlNmY2ZybjZQUlppR2x0?=
 =?utf-8?B?Mlp2RFQ4b1V5R1B2QjYxYm9uWUI5KzJEalFNVFF0bUxvanhxTXVuNlM0eXlD?=
 =?utf-8?B?M1VndW9DRHM1blpPZWJoSUVkamlRdEV1YUxDdnB6UGxJWThTWHJERkYvNjUr?=
 =?utf-8?B?akUzNy9SOVBWdEdYeFRHem1IOTRVdzVoUFJkeGp5c1lUZGhrZ01CYkdaZWkv?=
 =?utf-8?B?ZFpwbk5DdUxhNHNNMGUzc2JmWUt6ekpYMWI0ajUvL3A1YkMyeS9qaFdxVVZP?=
 =?utf-8?B?Tkd4M01kSE5PV1U1Y1hIR0JDRWRFbDkyblhCZ1pMNXpEcDdvUVBKUFhJUExl?=
 =?utf-8?B?a1k0cnllSnRRUlRDMktaSTYxSEJCejlaVkpsWlptUEN0WUFUOXdiaWdsS2JY?=
 =?utf-8?B?c3k3QkZGUU45ZjFoWXFBeW02T2pidUtLU3Y2UkU0NmFiWnlpaHF4NWdlWTcx?=
 =?utf-8?B?azc4aDBLRDllYU9hU2syU2lKY2RJOEsyckpLbzBScWdkc2dJWGxaYlBiN01O?=
 =?utf-8?B?eE9Qd0xjN3YyWC9LdHhZVlNmRzFsOUNFTUZKZjExQlVKZXUwbkdPa3VIWEpk?=
 =?utf-8?B?R2YyUWJ4UXlDUXJNVG1jSGw5Z0Frc29QZ0pyOGxUN2UveHZINkg3V0lKbEV3?=
 =?utf-8?B?bStnUmRWR0pEVGphK0JUamt4WWxPdEVYTVc3V2N6cDBUaHBNZFd4LzNMM3JX?=
 =?utf-8?B?S3V3WmdKcEUrYlVnQmx1Yllnc096RXlhclVIOWR3eTlOOHhtUnQ5RUlYQVRq?=
 =?utf-8?B?OGp1dk1uVE1ZNUxJSmh2UlBHVzVqc1BQeDFDemJZcE42OEpQeFJsSTI5NFVj?=
 =?utf-8?B?MnowZXErL0RmVzg1K2dFLzNLNjM2RXhoQ2dKbHk4ZERTM0NEeU5WcFRSY0sv?=
 =?utf-8?B?UkhaMm5WeGExTGx5TTVUNWNmQkNnbG1OejBMQ0JZSjhNM2QzTDdpK2FjejI4?=
 =?utf-8?B?VnFLd1BibnNGNnBDN2pzKzI1eWJEVG83azRKZkJaMHVXMlk1UFVQNEZ4cmNo?=
 =?utf-8?B?aHdtM1pCaEZlYjRRWVJmZm5qV0tLZWM1U20rMkJ6MExUUE9yRDNzSFoycjVC?=
 =?utf-8?B?Y2pXTEQ2dUxEM0xxTFpsV2hGaHFzQjJYT3JkS3h0bjVsNTUwUTZjTjhONXJY?=
 =?utf-8?B?QmppcWN6OWp0N0gveGtodWlpTmtpZTdnNkkxSUZSWGtQc0RyS1phc2xvRjlz?=
 =?utf-8?B?UG9qNkZaeVhoZlNQQk83RW05Qmw0L0swNVpSZXpuUXlGSkwreWdLSjVNSm5q?=
 =?utf-8?B?QW9ZeGhERUpXWUFuMVBZQmt0YllSajdyRmp6MUxQeGxkcW9NSXFVOGFKQ1BH?=
 =?utf-8?B?THhWRC8xWGVidHpLdmF1T09ueTFwYXE2UFc0M3VwOHlKWXhIbUJucHY5TTIw?=
 =?utf-8?Q?htm2ohKirzk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUdYTmJuNVBQWTZGbTJtdUdhRHlDVTBKMDFPandEV3J3QTUvUXorSTRldjlq?=
 =?utf-8?B?RHB4cmdlYm1vbUlIZDI5MWtJTWxpMDJYc2lKU2VrMENZTXAvbDQwZm1LZlpV?=
 =?utf-8?B?MGpkOVZkaWNJZXo3L0M5bVZrcy9NSDdxZXN6Um9KTTN4UlZPdmtXWG5QcHAy?=
 =?utf-8?B?TEl4TFhJbERpS0ZjamljWUhyV2F2VXArV09lYW1MUGZwTlZGTUljc05BWjhL?=
 =?utf-8?B?WTBaVzA5QXFseWo0clcvWEwvWjBrZHYxOExCazNaeTJVbGFKYVR5YU1KQUZ4?=
 =?utf-8?B?NGRORCt4RjJ2NXNmMDkra1BzNTQvTXpzdHpIZVNUbWhiZnA3STlHSlR4aWty?=
 =?utf-8?B?SFRLVGNZemhsS09paE1VTFF3MVJJajhranppdEhKRVdrUm0wUjBMT2p3NVE0?=
 =?utf-8?B?UnZ2TThMZU8zY2htUm5uUVNreUNheGovbSt2ZmNrSTdWK2tUeGRWaURRajdr?=
 =?utf-8?B?RW5wRFBwVlZ5SitHZEZJV2hVd0xNa2JRSlhVaktOL2t6b29xdzFyejFZOGtr?=
 =?utf-8?B?alltQUVXU3JYSEowMUNIMTZmMWVBd2pjZnhucDdwa21TeXJ0STNMUGdaaUxE?=
 =?utf-8?B?bnRYbGVORXZLYlJNWU9neU1pb05MN2NGUjRHbEsvcWdOWFhWRkkxVm5oZ09m?=
 =?utf-8?B?SUo3MFBvSHdwa0JLZ20yMjQ2ZmNlR1F1YW4zdkJNUE5UcllBM09XYWxzdkRX?=
 =?utf-8?B?aDljNVdJTURZR1JKSGZpdXNPY1VnVTJvSVBRK2pMeWdqSVdWeFNkSzZ5ckVK?=
 =?utf-8?B?MGdBWEdPN2VaVHFXZC85d01zWStPdnRBUlcwTlMwSHV4d1orS0FyaHBPYWkv?=
 =?utf-8?B?REk3cGZkeU5nc0lpbWNldDk5SGsrL0pqWUNQbCtZNy9SUlBad0ltcE5iWndF?=
 =?utf-8?B?dGZvNzFvbzVoS21SUUVTbVUvczRmRVBGRHdFS3FUOWFjNEdwVXhyaXA4Y1g3?=
 =?utf-8?B?Q0pUS3hZQXN6UEtYYU53cXVKNGk0VEM4TVJTelhsN3g0VjgrNEhacVVYNjZw?=
 =?utf-8?B?bWIySDFXbzcvclhWQ1RjU0dDSHNvakd6OHFORjRHZDRnMjNob3R2bktSeWhM?=
 =?utf-8?B?cWxkTXhKamorZVBTaml3ZlpqR3lwQUYyWUtzK3E4cHE3ZUp2YWlVQ0ZqeTJT?=
 =?utf-8?B?Uy82Z09IaE9nSGJyem83bGUzd0pxdUdXdjFPdVVWSU5WMHgrZWwzR0t3RU45?=
 =?utf-8?B?WGxDMTlqOWJDVm9hVHl6UzhvUVJsSEpzQVBqZkRWODdLUGJKUDIyNG4ybzJB?=
 =?utf-8?B?S3l3SkN2aEcwcllBU1Y5bTlDLzZVTUFUQXpmQnF1dFNJdEk1VXhMTGgzc1Y0?=
 =?utf-8?B?UHllK3REbEJqRDE2WFhjTENjZnA4ZHMwVHFQeEluRzQ4QURWZnh6ZFBGWUlZ?=
 =?utf-8?B?YUFmRmcrZnpyTkVQNTY1R2dEeW9HS2ZDWGh5RytDaDBNcWhjUkF4WVRUS2Ur?=
 =?utf-8?B?czQ1WXV3d0hOcHFQcXAvd1h5aGtYRkVpbXU1TjN0WlJqTEZ4bFlsSjhUZTRm?=
 =?utf-8?B?amVuVUN4QnZCc1ZoQUs2VENxdml4azBEWFRDbmh1TG1WQisyUXZPK2d0WlI2?=
 =?utf-8?B?TlhDVDlGaHBDdVBEMThzRmdUYUsxSEZQSEt4cExnNVc3YzRXclRFWGNjUW5p?=
 =?utf-8?B?cndZUGtQeXFGQ0NyU1VFL0hGcUZaWTZzWm9kWXRRRkZpMi9TL3F4SkRJTUQw?=
 =?utf-8?B?Ymc4Y00za3BTVjZMdWFlT0FWMWZ2ak5Cam9vSFNaeFQ2MXpoM3VGSnlENXJ4?=
 =?utf-8?B?OTFacTg1N1dKWnFSR3hTb2xCQnc4OUZrVVN5MFVzcDZIek8rclYrZ3l6eFVN?=
 =?utf-8?B?d1ZxNjhzL2JsR013eTh2aVZSMC9xdjhuRzRzN1JQOFZtSFdaZ1FpNG5GV09m?=
 =?utf-8?B?N0liNExYM0pad1hqMXUxcSs3OGJjZTJxMXM5RngwWDI5TUtjaUQvektaRitJ?=
 =?utf-8?B?cS9HR013SXM3K05vZXFycWpJcUtKRUg5TllzNUhYL25IUTRuV0M5S3JzVTRw?=
 =?utf-8?B?V1NtWnl0OHFtQktBbW5IMFRsZzlTa2Y4cTIxT1EzeVVCQ2htN1dZVVdwYVky?=
 =?utf-8?B?VHJiZ1p5SVozcGliVTA3ZVNyZHVvcmNjT0haTWd2WGlpQitkbDN1bSt2WWIx?=
 =?utf-8?B?UVJZd1pRdGJtT3BUVE80YzZQNXg1SHVob1RpR08xYkVBU1pSYndhQlIzeXpR?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y+iS8sSLiUzoOlWaBJGNXLrPuVf1GqFDiavgh4CTMCQW3VGrQcoLB7XiAM4hla9VFJ71E9XcJWN/sU+rHheodja2v73V/eLzEREdnAl6t3Uu01U/odPN3uu8t1Hn1XA5DlQDF1JQ1O3jH6TOmtH8N1wJf5aidhbHRsdyjLGxM/NtlxKHOjK5PM0k7BlEHPZrram+RQpqVHu0cBtXdHp9vSfXoI6YQc53xVw63i4jTTqdJ9NAl27VXZJZqrPuga1Y3WglgOJAKjbtWA2tlRWXZRgk3Cyw0GR7Oeswb/uO0ZzXlSXE3v9v9viLZf/A05A2iL6s1JS6Eo0Og5pUQ8ercGFY6huAgij7CcMK+MkgD0goGsJ+YTGngnXHpN9XUWeS1JYS3NhC+fe/3RscE2ol8E59+2kcawt7KKC7ByNMxW8Z3m+MJrySNHhF9IJubPc65PoTO7giDmn3HhpSkGlBSNeyvUM5v7ftc0Biucr/qsNZBYBlNAOIDbEXV/IDTEQHLW6nHeib0jRtizq7hqndkHj7DJ+yqbHFJ9wV47DtWoM/9DG5mcfqKBYC5Qf9kFqOrJ9/43GRBZhMMowQF3whnXDyWXJX7FMLQjWWVHd27L8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c773fe5-124c-44aa-c6f9-08dd87dbe865
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 11:41:12.6636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOORPPrQ4NxU+Yf87Kys+NUZaPtj0S3RjJ0dueoLtmWX9mYJn5SifWTICeFoGBCbUV5GvtMzxpI1jhs9e8u2YMTE3ecgOuixGCFKzoMt56M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300083
X-Authority-Analysis: v=2.4 cv=ZsHtK87G c=1 sm=1 tr=0 ts=68120c5c cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=abbK91v7AkQeax3eyPAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YRmJu4QKxR7tTjM5q4DPhN9KeFU78PSj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDA4MiBTYWx0ZWRfXx3RQCmqmmmZV STbZWI6kp2F7+M4HrxxAilMpHl+eeSaK7m2V8xLM2cmkirJ8OcN0Ah88ddY9fd0ynpAdT2ACPZs HtNRoAOAlP+TEdIaYJgX+Y7qDv4oAlIu+Vkg49tWYj+hgpstxS0Nn6j+HIxMgivDjwI34SlpHbi
 i/v6Xbcv3UkvfdVILXL5cHaXb0sHt6uV2/68aRw10frVNlfY3OSfDWZVgdNOpfop2vGJrN+RFjr 49J/2RJmq/OY09vPk6S5b2jTNcnhcXtw7wtcixzhcFZso2w+z7oilyQNDnzNd42X7enIDgeS/LO 5niL6lFbOHPPrOb4AiOzJo1PM7rr5//iv8w4952K2k68YIVaSBXsNNmvnJFHHTtY0YUe+YdxKTo
 c1V/7BsGV1Dg6fYVFzcZcKtUkwROvD/vSrXbIXN2KnGPzMU0VRrmOSKcedNnSA09zL5C1CvM
X-Proofpoint-GUID: YRmJu4QKxR7tTjM5q4DPhN9KeFU78PSj

On 25/04/2025 17:25, Ankit Soni wrote:
> Hi Joao,
> Thank you for review this patch.
> 
> On Thu, Apr 24, 2025 at 01:19:43PM +0100, Joao Martins wrote:
>>>  {
>>> +	if (amd_iommu_hatdis)
>>> +		return false;
>>> +
>>>  	return iommu && (iommu->features & FEATURE_HDSUP);
>>>  }
>>>  
>>
>> It's strange we seem to somehow have host translation disabled, while it
>> advertises other translation-related features like the normal case.
> 
> If HATDis bit is enabled driver will ignore host(v1) page table related field,
> this includes nested page table.
> 

OK, I thought it was both actually

>>
>> In any case we should probably follow Intel's example (which does similar thing
>> to HATSDis) where we only call invoke IOMMU groups
>> iommu_device_register()/iommu_device_sysfs_add() with DMA translation enabled?
>> That should simplify most of the patch as those codepaths are not reachable via
>> kernel/userspace? Unless I am missing something ofc
>>
>> See also commit c40aaaac10 ("iommu/vt-d: Gracefully handle DMAR units with no
>> supported address widths"). I am not sure what else is the closest example here
>> besides intel-iommu equivalent.
> 
> With intel patch you mentioned above, it seems that it is mostly handling 
> "second stage translation support" disable, which will eventually disable dma 
> translation. And in AMD case, HATDis bit indicates host(v1) translation is not
> available, then attempt to use guest(v2) translation, and if both page
> table modes are not available then disable dma tranlation.

OK, I guess it makes sense if HATDis is v1 only.

My other call out was that when we disable dma-translation all together (aka
both modes), then we shouldn't advertise the IOMMU groups (internally and to
userspace) by not calling iommu_device_register()/iommu_device_sysfs_add().

	Joao
