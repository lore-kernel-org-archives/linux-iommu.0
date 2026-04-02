Received: from SVZP279CU002.outbound.protection.outlook.com (mail-norwaywestazon11020109.outbound.protection.outlook.com [52.101.180.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E68D3890F0
	for <iommu@lists.linux.dev>; Thu,  2 Apr 2026 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.180.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116373; cv=fail; b=qhG6a90uh9QO94gz+jUlJaSEiZndVfsjUu1S2Ot48VKvuQk2Py1V+fnHdN1PmxyFOU7ZolUZBU0kREXtFcdS/X/Rl3/wH5PDRCIc9kHU8c55i4i8UYSAbQ3GkkquQrwUo7e6dgY7Rgyzupfx5ge1ZiDBrWxc0z7gtUdIzzjPBe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116373; c=relaxed/simple;
	bh=ZDyk97Nw3giDQdk/LFcm6pVrVzeHEhXYnUfbWSJg2uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TopH3siM2s9eDKnkSFdYI5JWnyS1R6w+gE1A589ZQYfjs7szy4kBR6nYtIn1aPMt5luMZnYvfPzDILR2BIeEWAekvTm5rB0Ht+zGvf70b2QYl/F9kHVdSR0rw2Ns9C7GXr6xx0wySvzHAheJ3OPgqxeLTNv7/hHuAQHuECZOg5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=vXH2LWY+; arc=fail smtp.client-ip=52.101.180.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="vXH2LWY+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n44hFxWweFfi9t3UDkF4CXse8P2IMt9DpryahEeA391B4pwBEp4MNN33obNTxv8xHBzqdPWgjDJVwAFHayqXilUcOYqmrDR1S0Y3XTaslh/dzINIUr8KmEjqo7xjOZh8N7Brgz4U0GFE3EHbZbuFrZuYmZh3Vi0M6VCUmHDygiy9VhW/eycQrQUnBsdxhjoKrEzpSEVPwxNX4ZQKerCstNnuiuCNGwkKB0nBKy50BYLS3NGEOmRqLwnWExfdFlxylZFSN78TDhIQTbqPBkasHbQ8nPh3RQAGtTutl7cXK1GWrrWqmED1tIz8oypBdd/OXtfKiDgEvQsudJOWMyD/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDyk97Nw3giDQdk/LFcm6pVrVzeHEhXYnUfbWSJg2uc=;
 b=IkmLTMVlhSrBeboUfnJxSNATBJg2W05Sow/zY+QVOdX3vgEY65anNdjoLbt92viM8gUh3nxwosjs95bjMD0Hmi1x8Pa0x3Mg6TPAubMZba42sTacGtn0qDkj617wMo02N5ba1gSOLZhVk6su3SsZLZorjmF3T02tJeYDIDH7aqxQFFae5NujRHOioWexPlfXQc8LjnNG3s72zNE/Wp8WdoON48AK18GM43248PSRPpYR3eUlhpMdCv6jO9Rf8bGZALPRpRTjb43D8R0JzkyT4WVjNTIbyOSMuuUez76U8g++IpDlf3ucqgF71swBMaxB4X0+db8wpD9bfzZre/zb0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDyk97Nw3giDQdk/LFcm6pVrVzeHEhXYnUfbWSJg2uc=;
 b=vXH2LWY+9LrCbZ587ZDi+iVLznq0dfXW6YwmWKypFBijreLQB7e/Z/a0ZW0QzJ71rk0d1w38hgRzbJ+EZ4QLl6U852LGb1AMyKP62QHzgF3EzHqN83mOn8TTlMQ5WH0HEIG8JRJnM5lUYM9EXpleXftDgnR0OadXtmwp1p1+0e0beaXfDOzeQmz9ud3GtTtdPk3rQV5XWlH2c/M0wgYPxS/PQUOTkpPOULSBhmeJ4kRXZhYAHRqJN1QS3o7dRSbcxTgMjynEPN21KjydJ8c22jmBIQ44GZLpknAMNkrmbpyFkpwQ2fBpJk7fL0cI1pVSHl2gzmL7fwIIens2mMnOcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 SVZP279MB0856.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:28::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Thu, 2 Apr 2026 07:52:47 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9769.017; Thu, 2 Apr 2026
 07:52:47 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: joro@8bytes.org
Cc: dhsrivas@amd.com,
	iommu@lists.linux.dev,
	jonas@dolphinics.com,
	larsk@dolphinics.com,
	linux-kernel@vger.kernel.org,
	magnus@dolphinics.com,
	suravee.suthikulpanit@amd.com,
	torel@simula.no,
	vasant.hegde@amd.com
Subject: Re: [PATCH v4] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Thu,  2 Apr 2026 09:51:24 +0200
Message-ID: <20260402075239.19851-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <zloboj7ie2nlkchbqkq67d4zoolbn4lvp7ah2hmluznnov5tnv@a76hwaajlted>
References: <zloboj7ie2nlkchbqkq67d4zoolbn4lvp7ah2hmluznnov5tnv@a76hwaajlted>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0054.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::23) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|SVZP279MB0856:EE_
X-MS-Office365-Filtering-Correlation-Id: fd445c25-c8a3-4f45-56f1-08de908cd4a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I13+R4KzfCHSQz3VoxeGqkworln6TEc2gwJuFMBMBKRrGgQrojmcelrp3AkWNjoxMpHoIYZHzKy1AyFuDQDQ7ftH9THP5+TYWxnpH7ruCFHJ0S8uxIZ9HA9UAWa8ACLHNj1jVlWjnG444ziJxZYX0E1Q17QUvrrPUpRP/gEORZwaWu69RmsAdr0Vr9W1uCbZV18a3PpOyuynqHhE/MpTT2JF4z2ygwi6WCnDXyEatiMceOZZMJGdPSfZ2eWPpCh36TZnOFW2gglJkzArHdc3dd1BydoeDkJfxFFE9Ei2cEX6cEKUjnDcAfUZvoogS9jYXLZutieIRxuZlohtSlUsqKEO7/OCN52wdgHpoCABMVVN6kdPFhkvfv0HLniHETs12SITOlR2ytLp8oNgj/yZdNmgg0UMTAaS/oVywzCCBs81/ulDcbmkvzXRHwAI0HOxCG5+9yHLjwKfXxAYALBxOjVWWihdI5XAQtslU3MpozD8RcucOcDZNWMGhXSsZk8dHAEfwqFXzdRp00fWGVGj8PugEQQukhsYmTN/Qq9HdDDkPhjqkhb/nk02uIculG78n25ZW5tFZqHku1H6no9OoYfDsE4PUnjDSHK7I2W4Zv3FPeB0g8Wf7vsE4mdk4KXWPPrGmlt3alOoTDDkKGOd/MG988qc+d2StX1tdXZtLOkV59FQvDNSgk08XBzfaL80KXjlBMwhsYAt+VoJ1CAqqPZyFxyEPbxrQWDHQCtqs6g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b+bdZ79k+y1neMwukSuaMHLUX7w4oLriuvIKWcTnfi6pwW451unxrbT41KCw?=
 =?us-ascii?Q?7o9Hyd89Wny1iNmMK0K2+vTpUPSCXL9hPdFMPiMNsSpYzO2ApyTzgnn+CtIY?=
 =?us-ascii?Q?olFvbaXbYMoNWZaqZ6Z540lOGEGbdLbs1jlGmYuCpfgDJ2O5BecGmeEgBOek?=
 =?us-ascii?Q?azYmpjIotfjXFM4xlzDDwkv2I+0HxguDOtI7///XVnoGH2wmrHXDw1iPPvFD?=
 =?us-ascii?Q?hZP6vQ7DSydbzUg0i+QEXM55L/1gi/cdqdW12qU5JojaOr/D+ckD5LRUG2Y9?=
 =?us-ascii?Q?Qe6vfE/McqCWaynYxu+qL/GM97DshYubowKtZCv6pZpp1ZWkFYZu5fPZcd65?=
 =?us-ascii?Q?FIDAlzArNLme4br7lUJj0NrVAPwmf7ZJ/16kxCT0jVRlQrZyttFqpNmbmGzw?=
 =?us-ascii?Q?g1H5/PnPgGnld2S+X2+LQ5Z+9Lxv1fJQf2R6V4b0lZSGyVRTKqxpA5RDDZGK?=
 =?us-ascii?Q?bVcLZKnQ25Apu8PtyDGjkJKgINxjfty+QNR4c5yB2AaU+yd/bjor2WPZmmui?=
 =?us-ascii?Q?KShddRen8aExZfj409hwS9uDUzExEKTAMtkLKL8jIDhK2GxgR4iCjXtiIuMZ?=
 =?us-ascii?Q?r+JGRvY3piftD65YcK4cF9TUjo7wxy6/Qoewjx0x8YFq19G/PZdxk94kBgDm?=
 =?us-ascii?Q?FQbw9FNTdAT03pGmjMoJ6M8saQuE1sMIq0RQ7kiuPECg+76jDfibyibjWM+w?=
 =?us-ascii?Q?4XXc7SlPJeDj1ltojVx8IcjIhluJRsbMJqfjQB6N0WaSk6quNAbmfceFDqBi?=
 =?us-ascii?Q?4aBtrXGFfk6eP+7MEBEPAN/UqC0gnUQr8KKvYDfDTdegmv/w2bCygfVRHxzW?=
 =?us-ascii?Q?5mAjOhLe6dgG6UPMSsj6IKJVFe/pvkPuxJCi3+tHydDa8rC412keADKUMR1t?=
 =?us-ascii?Q?vxf1y5nILvSMUmQHdXLTCHECSnIsOaMeSciOXwL1/6C7VSntUbZI0b/IyJsZ?=
 =?us-ascii?Q?3fHXKVSJS6iY+/Qqn2QkFfOZbvwQTsNoeMEYHMtvnc0dpbCyuLwnjFH3EznZ?=
 =?us-ascii?Q?TuHQHuq44h0i5TTdXIXZ76tvB4B2T0D2YreIYrroN+ymIBheCh5NwNom3szA?=
 =?us-ascii?Q?RBiYgXA6AsAG9Gf4WUHfMg7vsNOCu8+3JyMGGVWSnQMHx4odMnMs3AWE3veJ?=
 =?us-ascii?Q?GHf/qKti7X1TVy5NVfN1AlD4/KGLA07FeIx2Ncxy+vZuah1p6UVYv7XCZ7hX?=
 =?us-ascii?Q?cLm/rLaGlaQzvwfT7KDFuGHEFwpt7D3FDfmG1nSD9WbAg8HUS5RdxeSGjNJ/?=
 =?us-ascii?Q?40o/sEuB7OLQFmCX/pTCeyGhSqO2C/cb0Do+XHWV/FEFy9j81CZuZVniANjU?=
 =?us-ascii?Q?uM+X3FU4xllH82OI26HEhkosI0GmCzy1hFT/QTeE6UJG0N0VKQhhg+pRhCnu?=
 =?us-ascii?Q?sKIyilchD3u4MCqXFqEyJ4v0SlSuet2SNRaxGSsV7NoRZFigO1Y6eKW75Tqt?=
 =?us-ascii?Q?M1WKdosprjgMO5z8r7IpKOLalASLp7x2YSJqEv2kiJZ10Drpn/E1SqE+rI15?=
 =?us-ascii?Q?F1v31P187E5H57Oq7+wrIHvxuKXrkjLJstD+njDwlgraFPwABIAuRl8jp9aD?=
 =?us-ascii?Q?EM64KcWmI/t6NrqeEyNm4MR1BzHvpSnuQbmIO8xu23vT4Dfvi8liOIL2NuMO?=
 =?us-ascii?Q?Wyr+QBa3mfSFsXDPtRd4vwp5FwEgRrmekmMq/TVyAbmJaa8Lh5sxu3Xu6+lm?=
 =?us-ascii?Q?pmjP86Dgdb0jmFukoWy4V6vTz2xQEBvfIUNobZDceCAstM4sWzvju6EJySis?=
 =?us-ascii?Q?oayyp1qH8LLkGAS0S7R/xud32Eh0fPRxSeIuV8d59gpuL0SIu7KNyCCTyDUi?=
X-MS-Exchange-AntiSpam-MessageData-1: Q4zN2vX4R9lSVw==
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd445c25-c8a3-4f45-56f1-08de908cd4a8
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:52:47.2996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gqgtAu41YRFQbzyKPdX3irZn+ideNqeqfBN75LSlvSHFhr6TVPVSjRfVjx0jjAklifu8FdeuBfCQFj5b3QDNTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SVZP279MB0856

Hi Joerg,

> > drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++-------
> > 1 file changed, 23 insertions(+), 7 deletions(-)

> Applied, thanks.

I just sent a v5 addressing the requested changes from v4 from Vasant.

Please apply v5 instead.

v5: https://lore.kernel.org/linux-iommu/20260402074255.18415-1-magnus@dolphinics.com/

Magnus
