Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235E4D9577
	for <iommu@lists.linux.dev>; Thu, 15 Oct 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068589; cv=fail; b=V8WPr9E7XOjIC3kDDZJI9FEttcjGQaOLwNYdeBwxtfHooXVwmZawg2EIF/AZFVUy/FV/HA7cA0u61prPUSeQziaXMqwTI4C2gw1prsAm8d9YTpZqQZ8vc3WGyAxKnLZDJQAytQ6wpLZ09XpbdcgiWSgQKSWxXfwCGx6eRUunkyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068589; c=relaxed/simple;
	bh=8Hqq8tQhQKPGZt3Ic5hkvs/NNlLGI09eHwaWB9FN+7M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jsmC3TFQk5UK58QXNMJclVzpcWr60hSjS0pKltMOB4+RNJ0ew2YmYtInG+KYjPFQBqoDd/zXf3QpefMPbXsNI4lpHO7rj0QwBBAw0yCO7662wZQt2qYad3izzoKb3ZBuGME0HmrDiBAJ+MQWIebGNfXfZm4FtJPRnJdMC0wTp3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rxxpp//4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Gn0+dFGx; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rxxpp//4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gn0+dFGx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792068587; x=1823604587;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Hqq8tQhQKPGZt3Ic5hkvs/NNlLGI09eHwaWB9FN+7M=;
  b=rxxpp//4zGVNnDYSkwAbF38jhQZEKhomq1zGHRCO4rzeH25jaRaCusWK
   Be93Kh0qh0mH/uhf87HWsbZxkMgQkTtTvRfAurHNlTUkrqF9iHKSKcAhh
   a+fXR7kK++sqAcsGXuzImq8vc3NY3iWgRcv73uIz1c324WDeL7vLNcXB8
   ZG6bK1ZDxCUGM2l0cZqtO3bB1W3yDFMJNXtmrtJsJt8TOtR0EwCE9kwjN
   mLlVsbYufXHU1nSsCJya8uLeCPHpESPvKoYV1rlvgpFl7zly50Fo87Eh6
   Sl0ERn95WZ8mS+WJLdA3Sw+aJlkLdCo5iyJjkjxWKhUdOgupWkoO0uhWA
   g==;
X-CSE-ConnectionGUID: WvjyFfYOTwmcW6vx3Bcohg==
X-CSE-MsgGUID: FivafuK7T9uL3EImr29Hqg==
X-IronPort-AV: E=Sophos;i="6.27,159,1786982400"; 
   d="scan'208";a="156565886"
Received: from mail-eastusazon11012018.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.18])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Oct 2026 20:49:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xmvQnrpkqz9msmiRgs+HpmFJ72CkK2Xaw8EOc32Dvjz4H9JVxUDzGA/Tndtd6Xhwm0u6bAxOqaXghovmCI6XAh4zRXqbtipSrUrQhE/wiQJTSEzJwRuVudHZDszTbQsWOqDIZSfUgcw1WHDJi4e4A4Q67GCq21mwS6hlRTxnmX9luH6rsl1KZnTtXtJ7cSSuVMRyHUgj1U1sVwo1BmA5wIU5UFYlUtYlHtCmc4sEt8NlnOr1jfBGbqAOOXuH7MC71GMpnhhVdC9VNCKWNjz9NxFmEXINHiklEShdMvm8xBEh5S9ms+zpcrhDyWMP/litF0QzqkmNajfO3IuG+KIN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgSwg59Mk8dqlqCQ2BrOFH8IKDVq8y/Kbh0fZjilPDs=;
 b=fCfqUAwBccHwd4h2+0X8Sb5qct3CeyFPwsWvDRVrWVfEgY0+iN3aEIs8m8EDP2f0mKp3Ecol7lV8Am8Jp9xkCaVXhqeaGDU+cp4u+ZVxC68hvxBb2lk4NSQD7Ur6ohUXczxvcDFSODtN5MsIq+hTdpPe/auZ+sxZbtVhpyI5Uq9SyVYyfgrMyxpBdCA5WE6VXKtHtedmqnOBw+QSvpjJqOypOaq7fWOQz00RF3+s5492e25wCP96xVy0DfzWYTKwrgwSwcJGqEfjXX+L7+hh+RrXjSdxxi1dA4Uf9f8m0fbDJVvou2YRqNROFpS2I3lCoDk643e460uuVAcCpjTVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgSwg59Mk8dqlqCQ2BrOFH8IKDVq8y/Kbh0fZjilPDs=;
 b=Gn0+dFGxuc5nO0znlMaVrRGaIUSGxlXOIyb5m6wlnOSRoUldry4TvTd4BI2Ow5nMCVcex4FO7eFbLZfSnGPD6bsJrIho1u6yzP+wga+jg9XTfQEgEfaTF/B4l02jsApu/Z3195WCl6ZfSEKbpcRKBrdK1jDT5VPt5FQ2DepDkAQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from LV3PR04MB9259.namprd04.prod.outlook.com (2603:10b6:408:26d::9)
 by LV2PR04MB993760.namprd04.prod.outlook.com (2603:10b6:408:370::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 12:49:38 +0000
Received: from LV3PR04MB9259.namprd04.prod.outlook.com
 ([fe80::ad82:88c4:91dd:53b1]) by LV3PR04MB9259.namprd04.prod.outlook.com
 ([fe80::ad82:88c4:91dd:53b1%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:49:37 +0000
Message-ID: <4a67d264-107b-48bb-a1ff-00396284ca95@wdc.com>
Date: Thu, 15 Oct 2026 14:49:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation"
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, ahuang12@lenovo.com,
 sunjw10@lenovo.com, iommu@lists.linux.dev
References: <20261006120248.147654-1-hch@lst.de>
Content-Language: en-US
From: Hans Holmberg <hans.holmberg@wdc.com>
In-Reply-To: <20261006120248.147654-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PR1P264CA0190.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34d::19) To SA6PR04MB9269.namprd04.prod.outlook.com
 (2603:10b6:806:417::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR04MB9259:EE_|LV2PR04MB993760:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f1f510-ac0a-4504-1f70-08df2ababa56
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|19092799006|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Rsb3E/otBcLWqj1+E219/aQCl1Gfk+rDm7tjKebNUjsdeyuVjtgCzamMNlb003tuHF31z96/Pie8X4rwKP35DgvLxDW8d4AH/RKpAbmkpND20q/EOqXFI3SkTOJQLv8XJNVqDmATQcH6+mkr363yJNQAUuZc7RmAh+/T4k5aimZqXCS9bG6eUntciCvvTMF4VwcKFX5HmIuQxan0Ba6RLFCHEyttGNSZMbvjcGijrnuNxFkjDN+AC8KZdsM2GVUuYRUxmlpb5jXNZ/+vrr1Rwh2+7YE05hH8e4lCsrNl/N/vuAKXfRamzNgbOlwD0K3GyjNiI//rTgP0FdtrhTZgL3jqEMgG1ORa/I7l1ZeZAbQ9ZRv/uPwwM+dKuHvCd2RyXlzv53IBEEo/8l0pj3O40zuQ2FC6je7VCJqOQpCMnOn21LYTZYFXNlbZezNwVIJZt4XnoZym9bgjhmoc7DxVwAhEL5p1maRgmStf2rLR4sHpBlgNFtxAVriMlPRlSW4C1oHh9J0x2vGjnoZ9cetRd6RoslPom3m74UGTSEDCyH7tW9Va/Qu7YDVNd6gEHW6GYH9Bh5AsAiK0IIYFC/v5zQ9mIZFkQHa+ut/LqMnQJ0/ZvCzIOM9dDHi/jmrh7r6a4+se1v0vAaWOW84p4Usx4VGkIoy4EDtQN+ra3wD2WHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR04MB9259.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(19092799006)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enlHR2l1dkJ0NEFuN3dNRmwycUNobGt0eEZTUmt4eXBhRG1jcjdNTkVvTGRa?=
 =?utf-8?B?cVUvTktSVStCVVhhWm5sbGlMREY2eGVTdFBzamx1dE0vdnAxYUFHUVEvMFJW?=
 =?utf-8?B?ZWVtK0o4VEErMEFyOUJaRldidXJaelJRTUFoUVFVOUgyb0xRbS9yUUZQZS82?=
 =?utf-8?B?ZkZkbzMxL3hLK2FERjZWVjhBYTNPeDdxcCtOM2JkVG1ZRGs1TzZsemo4eUxn?=
 =?utf-8?B?YnUvUy94Tm4rVXkydVpyeXBRd2E0SXJhOW1nRzJoQjYvd0tVSHFOTUM4ZERQ?=
 =?utf-8?B?TjllVWNqRHpaTld5UTZJTm5YMUw5WkxxeXh2Um0xMEIzWklpL1BCWHJBSlZo?=
 =?utf-8?B?TUJMRFVEZ2daOTBzN3FkNkk0aVZpb1VTOG9Ncnpzd2Jyd0tsZDZDbGhPSDY3?=
 =?utf-8?B?THZKYytjeitoREdrSW5RY1hCSjhXNFBXVy9nUDJxZUsweTNCRGhNcFh6RDF6?=
 =?utf-8?B?b3RkSVFZSkRFSkZtNlJZdWdZcnFLakdkbHFvVHNDbk5tTDNGNFI4NE5DanJ1?=
 =?utf-8?B?Z3VDeU11SnhDcUpTdUp5TnlQaXhYMWtVajgzQWtNUXFFcUNSZllIcXBlMjZJ?=
 =?utf-8?B?RzhFaVQ4L2lLSitmQVVvc0drbURheDJpc255ckpQOEdONW5OeXJZN2FuL3BJ?=
 =?utf-8?B?aE9qcXRyalZWUzVwY1dhd0NsY201OHl2UW1vTmlXZWRBNGhoblVvVlloeFUy?=
 =?utf-8?B?dm9LOVhOUkFTdmQrWlJtUFNyWEFkaXF4NnRWTkN2dzUzWGNuWHlGVHBkZHox?=
 =?utf-8?B?ak9FSW55WGYxYkpxcDc5Y0FzUW81RGRjemZxdkx2YU5Pd2h2SGR6TDdQTWli?=
 =?utf-8?B?bVV2Q1FRaTBUVThUSldXK0VSaHlkVlFPRGU1a09lVXNCdlkwU3kzeGR6NUxU?=
 =?utf-8?B?YzdEMFU5VisvZkZyKzI0aGQ2cHlHckhKbEJYRWNtUk0ydllsRjFmdlIra01t?=
 =?utf-8?B?eE1oUzhiaDVERmZJdmRkYlZNL2NyWjRJVGhnTTdmQkJMWFhzSjZXRFBkb0Vv?=
 =?utf-8?B?R2dvNmZSL3REUmpXOFZZdFZPMTB3ODVnaEVtc3pGOEd5UkVUQlNvSlpPZjJB?=
 =?utf-8?B?M3RYTVZ3eUR3MmYyaWVqUFVwSFBhWTZaRHRoc09HbmhyaTl6SWdRa3U1dEVZ?=
 =?utf-8?B?MFRMejU5azAzcTZGQ2VjM2xnZjR3cHdnWVliRGE4OXlWVXdKdXVlNUFGSXRC?=
 =?utf-8?B?TUgrS1h5aFJieTdaZ01mUFE2TFE5UnQyYlRtZjNhVHloRjZGbTJGL0FGN1Zq?=
 =?utf-8?B?bmppNk0reTNPV094cHlJOGgrcW9TbEZqSVJjaU9qc2xHUWxMRlQrOGpnL0wv?=
 =?utf-8?B?R2hWK0ZIMVB2S0VMalpMNmFzYWUzTXZaS0dtenlpN3BaOER1K0E5ZWR3d1FG?=
 =?utf-8?B?UVBkRGJ5amxnYjBuOVA0WURxN3JYNC9OWUF1OWpoS2owaS91OUdCUmpqYnRi?=
 =?utf-8?B?MWwwMzVjRzN0WFZmcThnRzhQVk1JOWlrdld5TTJRWVo2eEZhUFAzK1JQY2pa?=
 =?utf-8?B?WCtTOUdCdnRpZjJDMldtSXR4enQxUDFNbHd3K3hYVEt4alZlOEdOa2xYOVF1?=
 =?utf-8?B?N05vYjgwTzdjTWU2cHhDMlRXNjJkRWhmYWxad3NyTHhGbUFrTmpxeCsycHgr?=
 =?utf-8?B?dlhHVVgwbHZ4QUhKNHR0WDhKL2loaU9ZN21XeVB5RURzWkFPdlBYUE5BYnhw?=
 =?utf-8?B?Q3JjTGFjdVNvOU5KSVB2bnU3a21vSlpFTUdyNHl5MmJsZ3J0a3YwQ1JoU1Uy?=
 =?utf-8?B?emFReEFOQXh0amluV05JUDlqTlAydlI4bDFQTm10NUJHeXdYSTdWcWhtT2xo?=
 =?utf-8?B?blhDUnhGY0NaYVZkb2tRMzBzeTZ5elBCWmE1cDUreHUrZFh6Ky9jenlQSUVj?=
 =?utf-8?B?Snk5OXhiQ2h4bHp5ejB1RG85K3RiY21iaGZreGMxVVluRmgrOWU5WUVvNlAx?=
 =?utf-8?B?NTI1OVkyNXpWcW1HUG52bTZZN3FWRTFSbGJVMEpMZEJmZVc0N2lRN2p4MkdX?=
 =?utf-8?B?ZFUvU0FTTDU1bisxSHNvNmtFWXgxdUd1ZjdoTGpyWVZTRVMvRW9WOWY2aEla?=
 =?utf-8?B?ZzhoaFNZQmpqSjVFTWpmbnpuUGVqOXl3bm5kUisraEZoMWVJaFFIZFFvSHAw?=
 =?utf-8?B?dS9tMU9KcUhrcXdiMUptODM2elZiRWRsQVpBZWdhUkVqUzYyVlUxdS9VUVRp?=
 =?utf-8?B?M3V5WTMzY09iOHNLcXJLMzYxSWg2UzM1TXdsRGw1L0RXaCtDS3pKbDM1WUVS?=
 =?utf-8?B?V2hqV3hpc3c5eW8zalVEeHpzQ1ViR0hiRGFiNnFVSkNoaGU3TDNpM0VHUC8r?=
 =?utf-8?B?WHg4djNpS2hqUnhlR285YUoxSHgzTTZXRDYxbXhXOUhJL1FVdFg2QT09?=
X-Exchange-RoutingPolicyChecked:
	EW3oFzSVkt15oJmiCj9AeNHdoDNcwpPAImpibcv555F0/kqe5I6o6M6++BINzFShynrgqmj9qZ2FK1gOUFIoWeKekrVg8mVaVCbD3CRx51Vmqspkkb4DVsxM6gs+gzzEIDUCVNIQMhb1P/ZS75qu5e+v0B8Dp5OC/NSLD8xkrfxzumxSvpfRJ0S/Gfr2FdEQyPBbLLbnNW+1nbHrDleqQSaRFCYsHdYYhXEZr0RjbMC9OLDuxnnumVfnNzWH22kcNwN3ANmyR4SGJYp/eBj/yVi7NEZgEegY7dwlYdPI8qheoDV2AQ1va7BmzshcDYGXK1VYHaxWtQb7urEItnm6IQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aRDvSYX95xLC6ezZba2gH5QYRFYa0cnvdraWw0wrGOShf+q+3/S5h8BGQCB7xqyxgrKtMKerWvYAq1XBKRAg5DaU2cI+Qckyv7CX1NYG4b5eLSCFfz63XMoJU/OWPoRTzB3l9BacurE7+hP0Et/zQKHlSBtZgJNyKiGYmcVL8hVwyPMV/WedqZQC9TOV6/UgRsY8AD+t1lfyP5NhEQxewGdBWIs63JT9ofcEoLNYSsxUEEfL3mykaHYoUSl9xsM+ocuG0hr4bzRm6cKTLUQVDO6702Pj0BzUnqZdsFRET5EcupZs0uk8Oz761TSeN4103xT6tsyIPUrRu9CW14KccSWV6tyWgKiq+MRcvQVUcDEMix7nzbkWK2l+ZTXu3gulYnab4w/cOhsWp7XoJ6OD80TvL2mFV+2ONN4VmVPgoYhL+5CoGW6xODVf0DWOIs1QG0P7SlNKziF/rGpEcxjTR/g/Ra+bIyNfSpgIY8aYJPGwUtQoE2l+rEZeM8+qyD+uAY0MIsHUcpU64tUErH2GLM8AH57GVDK6WJ/FTIoLrRcmX5MvOPqlvgIyyALzH1jPPtEzqO9VOazEZXhraLcUABTXBIrvcbutoUTUeo7N0/ZEnkUquM0exOt3surqXL5q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f1f510-ac0a-4504-1f70-08df2ababa56
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9269.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:49:37.8881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ypd5op6AWMzk+w/yz+53YQGZsnOcV5ktTabRrREPAGN5gWX5yfe3E8a6lHEM53/MGR7DPZ9MSGCDqGZU0mRMgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR04MB993760

On 06/10/2026 14:02, Christoph Hellwig wrote:
> This turns down to cause up to 15% performance regressions on standard
> large transfer workloads.  Revert it and hope the IOVA allocator can
> eventually be fixed to remove the need for the original workaround.
>=20
> This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5440cf18b55b..82e308fe4f4c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3747,7 +3747,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct p=
ci_dev *pdev,
>  	 */
>  	dev->ctrl.max_hw_sectors =3D min_t(u32,
>  			NVME_MAX_BYTES >> SECTOR_SHIFT,
> -			dma_opt_mapping_size(&pdev->dev) >> 9);
> +			dma_max_mapping_size(&pdev->dev) >> 9);
>  	dev->ctrl.max_segments =3D NVME_MAX_SEGS;
>  	dev->ctrl.max_integrity_segments =3D 1;
>  	return dev;


I saw a related problem with the limit capped to dma_opt_mapping_size - thi=
s can
cause inflated number of ios in zoned xfs as the max zone append limit is
capped by max_hw_sectors. It can also lead to more extents being generated.

In my case, the drive did not have any limits on appends (mdts: 0 ,=C2=A0 z=
asl: 0) but
dma_opt_mapping_size capped that to 128kib which is very small. It would be=
 great
to fix this.

