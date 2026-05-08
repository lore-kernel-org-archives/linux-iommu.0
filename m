Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38A3A5E87;
	Fri,  8 May 2026 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.148.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232383; cv=fail; b=Encea8OM6liVNLyMeJ85xq7ji9CUTAronMcHgWU3eX2sX9qpumnKCdVZXifL2Ld7hO8RtN6NOV1EpauSPfUJC8yghmKb0UDmh81nqXTVaNN3vp1HgQyjKk19HVVmaSi/PyUY/ODdieAOxuG47rbJ+oM9tJvbRdS3UMFD+kELqrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232383; c=relaxed/simple;
	bh=omGzLbVK4S78aw1fzFlnWyMn+orOB4FBLVgZVWkOr1Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MCcMgE67v4QQONP+oWKebtYIdnrdFOwv27eqGZ8I/jrJ0DNUuiMRdlzVQ7bQJ57qh8B/cA5eBgLOQpcXZnK4F/kbvBxfRmQ7aLXsizcGxHN2CbJnc2u2FlDUiPLg+p/Bry9NoGGlbXUJ5yP1M0THQh5SqOPpzmFguh3+Fg7TgVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com; spf=pass smtp.mailfrom=lenovo.com; dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b=umajmser; arc=fail smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lenovo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lenovo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lenovo.com header.i=@lenovo.com header.b="umajmser"
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6486KEsH1092554;
	Fri, 8 May 2026 07:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenovo.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=LdsVpMfACDL1uD5CruOgHP5tVHFAU+Hwx34qp9uCF34=; b=umajmserkMF4
	aH5uP1owlVP+o0+nGpf7Foije2HFIrvXs0qHzcmzfWRFGFgj4BitA6o98chpwApj
	KtNtXOKpn4LGFNnK9CI4fqKJAONYeo7iBAUEUZbg/9PkYboBKoa85vODtGXiKWlo
	u+K59v0XZKMxcJXDkU96/wTxxqOdSBD11QrVFZXHeGtUIDwAo+e+ipKBEdsh8n5M
	VaelHRxbGCmdmw3PBw9eArf21XnSkBkC69vwE3CDi5aAFiQzBJXJBzjOryLfI8yj
	jk4F9bYiGZvVM1gzokBJJw9hKHoHyZBbJ8yibZqgS74tWcmfXJOogKtpzp8bmNbu
	+G/1cX6wkQ==
Received: from tpzp295cu002.outbound.protection.outlook.com (mail-taiwannorthazon11011036.outbound.protection.outlook.com [52.101.110.36])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 4dwy1j19p1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:30:48 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbjj9Gdvwn3AmIDtZtwiSVBVyvG7KRbmHWaDNC1QI1unZ1cqFJiiqWyLzY52ETQdjOtEW9lLpx1KHc8fT8qxKx8r9NQ+2Cv52onD06rn4/Sc9swWvvlIwv7V/NUxHHWQq/gJd74+e9Xxv2Eue3b5VZEIPNoGxvtKINadcBcMG2Zi3COiFDbjVFSPiDtHnLCm5+8oHUSgUwSMvnqyq1eZLPuULMeY69xCGy+Bq+O1unPzPF4qcpPlag4lFsSPREORZSEPDnD09l4t1Hnso6BH1MVlexRE/bP8yxmqYt0MUgbqj6QM98HhAwD0KuZoHNvwMspJwOg+MZ5nxmGlPKvZ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdsVpMfACDL1uD5CruOgHP5tVHFAU+Hwx34qp9uCF34=;
 b=EyzRqaAgZ8+8cMqqNRw1ViY0WmZYWqagR0Jau+fHrf4wUhv9evE6sBy7s2JcsJq75cetIPjnLg6sKEtopGe/2LttDIJjnfEvEN1uH5TNdaY2Oqi7hAyOdsGgc6uI+cmVaIyjZNRA9XwGeZET7YVrpXU6kP3asfZUeF584a5LxphVcL/yQDoVgC0jvBomVN4TmmQ3XODESdCGhbu0/eClzPek4nu36Qk17imXr1ViWGbWkp2z7oIT+vQhGT8mHrI3oOvs69diKvm0ScVMN+pwwDiJzgO941PLmW1b0Ixx+nkbs/1setzuDaTI5Y2lAQJgGMmy1q3Wvh7lu4w8EMQ+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
Received: from TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:b::13) by
 TPYP295MB0415.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:10::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.19; Fri, 8 May 2026 07:30:45 +0000
Received: from TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
 ([fe80::788e:e9ec:6aac:5820]) by TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
 ([fe80::788e:e9ec:6aac:5820%5]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 07:30:45 +0000
From: Adrian Huang12 <ahuang12@lenovo.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "joro@8bytes.org" <joro@8bytes.org>,
        "jon.grimm@amd.com"
	<jon.grimm@amd.com>,
        "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
        "frank.gorishek@amd.com" <frank.gorishek@amd.com>,
        "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>,
        "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
        Baoquan He <bhe@redhat.com>, Jerry Snitselaar <jsnitsel@redhat.com>
Subject: RE: [PATCH v2 2/4] iommu/amd: Do not convert IVMD exclusion range to
 unity range
Thread-Topic: [PATCH v2 2/4] iommu/amd: Do not convert IVMD exclusion range to
 unity range
Thread-Index: AQHc3ryUKW1dqCZrIEKj68UhxTmPow==
Date: Fri, 8 May 2026 07:30:44 +0000
Message-ID:
 <TPZP295MB0013F9F7E3C18EE0D7F1D1CBB33D2@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
References: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
 <20260424092213.16976-3-suravee.suthikulpanit@amd.com>
In-Reply-To: <20260424092213.16976-3-suravee.suthikulpanit@amd.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TPZP295MB0013:EE_|TPYP295MB0415:EE_
x-ms-office365-filtering-correlation-id: cdf8968a-8a7f-4821-cbc3-08deacd3b777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 69r8HiBIRs3UJ4Ok1Q/PrSkQUJmeCK8gC5SvhWwr6vZo0xGqWJZInio49UXQkJoojWjLhCPjXuFdfJ0LxaGvdtTCgcwx4ZHUTe/Aoa1uydAv4o9Q9He34YhP+Va6eaWNdI1ipBFHZtErtbzzUNthtj4W3sv+J/IGyzU4Z1GaYLhbzRSzQv2c/9EtjmVsaswcwnTHlFMhKGMMKFl61tN1vrKDXv2lbJNi5fbv68QEfHSq9EvnxOOdNztmHN4kv5rb9blzxnLMpm8qdJoek8o4gnQ/5cM8U4jhOaihQXm7S7BhdkhCJbo+uR0yiQ0mw4w8Cgf0ydqFNTyTcxSVokBctkfXT5O5d8A5RbT1UwjJugFIXMHiAD1M08jlFB+JECiLcAlgTjuNKgqsrRoMQ/SFmAI5oC85jBiK5Ti+cr5FUd81fImGV67JWWYZb8QcHO9diZxqo8s9wiXvrKg0U9TXnH7qN9KB0v6db0FseDn3L4hCuhn54KPs7hg7OMHbduoSB4LL2UvORWObWWNyczp3A1UiQ14w388OQENxVNk5D3R2NnZR0nsU64HEqj77ovqwH+We7l3+AP1JRaz9Unx+rv4VhZTKK3YQOvGTgClC8kB8g2NTG2y37iHtIYN81pHpZNMmvYC/Gj18us1t6Bg9n1AWVGQIqfx1LW5yGCbmNXcGac/WhM446TV4uHxKBHoSltW3mLkCWusyxiYuLJFDitStE2XNd+NKX9XanfCwafRSc5KGy8z5zeReT0u4xeql
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PLhxSWyMab0+zwwkscuR0coflONYQppRDVkUjAP/3bRuw1HqV7P3pc77xCJY?=
 =?us-ascii?Q?k4fLnIBi9IBlTb2QKf8SiXS2LmrUJaa4VTfLxZISbJpiHe2Ba5y4xn5+XKsN?=
 =?us-ascii?Q?EvAo666yW1jr6z8ncI5NP4AUGdghrG0u1uSYjD5KJCGhLdcy48p+ZG2puywz?=
 =?us-ascii?Q?K7hyx5US4xGi/6gBn8W2xNo4ycE4+CyzTjr7SJRWaCk5YEwQLJP2HzPIUz5v?=
 =?us-ascii?Q?Ynv4vDFbsK2x4Xs2XzSToobNWb32bPjMo0uIGy2KjiZXhXb4QE3psahlN+MK?=
 =?us-ascii?Q?8qe+w8WuCDFs522PXSYXFkHW8GzCQxVCXlxX6UP7lZK6V+uAjQh70h8/HhJi?=
 =?us-ascii?Q?z6hXL28DmUbHXRmKbSMXicEeGyQPRUgfk7k70kTDl4q3whHGuK3FXr5Za2YH?=
 =?us-ascii?Q?yeqwjF0voA8ror/JdVLsOEqGKOZhgi0kXXzntFQZwYQV+/u4gpq39xqMwhpl?=
 =?us-ascii?Q?s3LlKwmGHox7R+Jo1Ro78br2sjIeWZlALaTRz+1fbtY5gN3ePyorNlAAm64T?=
 =?us-ascii?Q?m93xO6/wZNVzNRlG97y19nSRM/YzBGnZVIR6V/+5sVvpUnjYJ4vUxcFYzmBs?=
 =?us-ascii?Q?sP+CHExJuN20jQ92RXgTodv9xkQuNk8iCLL5EnskQINYYluBEslyXN2H771K?=
 =?us-ascii?Q?rHFDRO2iq0QTIdhdJFxbijmP3M8QmaRUJigAx2aWrcISwdpmggxR2iV2WFnc?=
 =?us-ascii?Q?OPTSySjNFKbUK4JfRxLCPR/3rI4kL7U64DySnPl2S20oEf3ECKCo6mksm7iZ?=
 =?us-ascii?Q?SVo4DILKNNxysWEZx00yiBVHW0bCeBhOUXLMncPi95dfGN0ZHgjEWqBTVS2e?=
 =?us-ascii?Q?lLmE5NhuuNTHsd4wY2BBq5mtlK3ITxAqFtyDqPdlw9qeeXd2llxmq0T8NlER?=
 =?us-ascii?Q?goA8Ic9SjITMTTr2N18eGeablLMMrll24wWRRQzdxrjaZvbu5Gq7bqCR2qmn?=
 =?us-ascii?Q?7vReiqkWXhTbdmVQdDnm+rzjl4Q+y2P+TF01Xd7yBpjfVH6XIiQBZ9vH+3Mt?=
 =?us-ascii?Q?R1UyVfHvZQx7/SdxSfg45kezknpA1s/0rW4N1HAit/Ymf7C1CIBfsf7Q63VL?=
 =?us-ascii?Q?CLnn3yNClNN/2Ao6qerpm34XO5Lq7U2+yQvxy4wRewqYORI8+CMB9JkRy9Jr?=
 =?us-ascii?Q?pqGtkj7GbJftkI9lQEMBODQ9Yr9XAIlENrstWwniAOLW6C459K687Aj4j4uI?=
 =?us-ascii?Q?WkSUM51C0Rpf+hQMTrZWHdK+H9FBrfpz/x2zj8mI82BUl2ZY3oMe4ElBP30b?=
 =?us-ascii?Q?TCoZsGN6giiDlHEg6WEju2l+hJOl+mi6tphQ1NbXlYxk2840hp60x2r5Dy9I?=
 =?us-ascii?Q?SGo0LdnIX4NYmsCdq3XDrSWYcLX3EntHQhuMwheMxDf4vnTFCL2Z67eD9tMF?=
 =?us-ascii?Q?26m26CpX8Rq/HVDyiDwuIJ7s1dCnI1Q+OOqKJ57T0XB7rrLKR0hfutOPvZGk?=
 =?us-ascii?Q?vi+B5IdBUsi7pbFtWx4L2m86W+UoTSiV2IslbWs1RwFsBbBrKa6M+eA/n9X4?=
 =?us-ascii?Q?MKSYk9curIIjgNVTO3zPoTtECxJ1zHu59NqVeP1b23DmdcofzEEcys6KqklR?=
 =?us-ascii?Q?hTQMHjyrrpPlIkEh6RGZ3XUSe5DfdpYHW5lTZbpKxsYWHu2nI0wnIfG9A3/+?=
 =?us-ascii?Q?rUjP7CQUopePAInQUvSD/Vj3K1mbSxCioiy7nLj7M+Pp4dRPPR8VXf0WlfVw?=
 =?us-ascii?Q?ozAg4CEZmNCjaieFQ8fAA5OQL1eqxI+aXEj6l2LdXPXe8Zl6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	N91CHckqFNXfvZNIesbI+xVdaiuFkbHqnrXoxuI7zhzb95AO9BsvIed0aeI6MHk4s04wbpzw0aHrxU0fvXzroguXQtj4P2RzOjyt4GntMnJBdeYwP/jJByrb3GCvqx/U3BgZ1/7/4gpLKV33XI+OMRMGUB/K5fif0EhtfYQXxFMZN8mScMo1n9s9pzYIShW5LjxqiXJrOrSUGysTDycgebBSI4f4Lw+xFEgUEYp8U+eGRHbh4F3teToOLjNpULriR6MZfWtdO/ECX/h27M3GxjnAqVw8VcwVQHKrXR534GLiAg7f72VVS5BYXqO7/QdAZ2SCDJ3IecSrbbDnuG20kg==
X-OriginatorOrg: lenovo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf8968a-8a7f-4821-cbc3-08deacd3b777
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 07:30:44.8732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sGK9fZGH6T7EyHe0WZblsQjEIgdLPwyhrAWumwt6xzxubkHvFRt6uNu8puQvH5fKVaA20gEq++ZLaDUK7bWQbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TPYP295MB0415
X-Authority-Analysis: v=2.4 cv=BaXoFLt2 c=1 sm=1 tr=0 ts=69fd9128 cx=c_pps
 a=pE+xdQEANsgjRWX7k+lJOQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=2RTuljz969oO5usasWGy:22
 a=hJVLCblJc-VYA0_z04R5:22 a=zd2uoN0lAAAA:8 a=VwQbUJbxAAAA:8 a=tA7aZXjiAAAA:8
 a=20KFwNOVAAAA:8 a=8k6WQxmsAAAA:8 a=EH15OORTsnxmja2qi3EA:9 a=CjuIK1q_8ugA:10
 a=kIIFJ0VLUOy1gFZzwZHL:22
X-Proofpoint-GUID: e3AOu0NIbyrNqDWSlZQ0Ohyz1mflJeQe
X-Proofpoint-ORIG-GUID: e3AOu0NIbyrNqDWSlZQ0Ohyz1mflJeQe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA3MiBTYWx0ZWRfX8kJyEuptXMnF
 uyDnxuTh8bKdaUpANNr+DLBNagG5gm/VeHa6Bp6bY6EzXMJiCsU7iCZR/0w9EVxr/OolM327BnF
 TrKqTFumt62wDqwV4odPRCq7M+lzSlxYq8+71/KDCy7gPyW9A5XBUrkkad+ntjZ/WOxP0Anog9L
 8X/J3mwSY7rz+2oHOMapCci0/75silBemKIf66QM1Uw6l8wdfQy3bEBQt3tdyTUot0WVaAzHaAq
 rb6JhQ0xkQC0F9BU+2hrliMWF8SNt8GPZmPyP+sdfwzuttlQhrbv40vE5H7MXWTvK8RNEV5mW2S
 JgQCfG8tjacBpLJXUSpwC6b/sNhySmZxL/aHOofTOgVMZAmBhXkiukjw/bBV1ysJDYY8poLlc8t
 IgmR8h9kVCE2J6JhuKsB8SJd8J0KLcUrNi5G9YLq256pcBPZIUSlZYSgFEqvG3EcE4+BrOS4edI
 BBrszt8jJiwosNSNcLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=-20
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080072

> -----Original Message-----
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Sent: Friday, April 24, 2026 5:22 PM
> To: linux-kernel@vger.kernel.org; iommu@lists.linux.dev
> Cc: joro@8bytes.org; jon.grimm@amd.com; vasant.hegde@amd.com;
> frank.gorishek@amd.com; thomas.lendacky@amd.com;
> santosh.shukla@amd.com; Suravee Suthikulpanit
> <suravee.suthikulpanit@amd.com>; Baoquan He <bhe@redhat.com>; Adrian
> Huang12 <ahuang12@lenovo.com>; Jerry Snitselaar <jsnitsel@redhat.com>
> Subject: [External] [PATCH v2 2/4] iommu/amd: Do not convert IVMD exclusi=
on
> range to unity range
>=20
> Original problem was there could be multiple IVMD exclusion entries
> conflicting over a single exclusion range supported in older Linux kernel=
. The
> fix was first introduced in commit 387caf0b759a ("iommu/amd:
> Treat per-device exclusion ranges as r/w unity-mapped regions") and in
> commit 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD
> header") , where IVMD exclusions are converted to separate unity_map_entr=
y
> objects in pci_seg->unity_map so amd_iommu_get_resv_regions() treated
> every such entry as IOMMU_RESV_DIRECT with R/W.
>=20
> Since the AMD IOMMU driver no longer support the Exclusion Range
> base/limit registers and rely on Linux kernel to exclude the specified IO=
VA
> ranges from being mapped this logic is no longer needed.
>=20
> Remove the special case that forced e->prot to RW-UNITY mapping (i.e.
> IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY) whenever
> IVMD_FLAG_EXCL_RANGE was set.
>=20
> Fixes: 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD
> header")
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Adrian Huang <ahuang12@lenovo.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/init.c | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c index
> 866249d3673e..2e854f4639a7 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2644,16 +2644,6 @@ static int __init init_unity_map_range(struct
> ivmd_header *m,
>  	e->address_end =3D e->address_start + PAGE_ALIGN(m->range_length);
>  	e->prot =3D m->flags >> 1;
>=20
> -	/*
> -	 * Treat per-device exclusion ranges as r/w unity-mapped regions
> -	 * since some buggy BIOSes might lead to the overwritten exclusion
> -	 * range (exclusion_start and exclusion_length members). This
> -	 * happens when there are multiple exclusion ranges (IVMD entries)
> -	 * defined in ACPI table.
> -	 */
> -	if (m->flags & IVMD_FLAG_EXCL_RANGE)
> -		e->prot =3D (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
> -
>  	DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
>  		    "%04x:%02x:%02x.%x range_start: %016llx range_end:
> %016llx"
>  		    " flags: %x\n", s, m->pci_seg,

Looks good to me.
Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
