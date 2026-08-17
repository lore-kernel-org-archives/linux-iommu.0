Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801D3C73EC
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957964; cv=fail; b=kyH+9LbLddf72D45AsknbfFJ/Ro6FBLJShAg1hYUDzB7bpwc8zt3gFy0I2vdwwhqBqjSwNvjsyU4XULkSn8eJT3pqLq7MWShhV4k0pGr2OLxrIdL7+3zFKtCRmiBJowqbRIe+DWr/l9NpAmdBJpSq5RxSMF6Dx8qmG+2KD8lytU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957964; c=relaxed/simple;
	bh=mZGFD0hufriAi4MzDY7rIrYGGuZY7RXJhquyDGZ5Ip0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YbflNtf55Ys4bxW/YMao05xwp3A07IHbZhUzy2at7jqS1Zln8fjXp1BLSx0DWqUxGe7HMmyxnOdrUxRZCsIdXo7lvuACZPyTCh7fJZ2WJZcr3yGi7NfAC/7wO9PPfvT67C3OrHfrw7eSL+nYYuYWc3AXF3DouJ9GIustkf1N5+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CcP7MCrG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FuzXYtUr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CcP7MCrG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FuzXYtUr"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67H0dSdU3739824;
	Mon, 17 Aug 2026 09:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wI+U0jpHQTcCov2eZs1smDLXaQPerCFFsub5EonBJxg=; b=
	CcP7MCrGfvReN04HTRgXLUO1FeIlUInvQKiJ41pCGTn1ABD+xA9eWbIQCekHXBcu
	IC/E6iwkX9kRa7dS98weZvfF05fbhgyyzsc+tq4xuJwEmHIOcUFELkmnIAup6f/Y
	ayKiLf50FeqGrVf8Pa6smUlv3t0/UVdJogiQrqce/ky4wrvGnFQ/n5+mJPI8YGAI
	JvJBYFbaNB7quNpnD2PJ6PhWvYvk6LoN6QOqNp+v92wYXKZxY2EaByTXd7fpe+1w
	MZlQiF2hvLa8o7c5EjTLS+40Vv9sI0J13v1O6kcJrCk3DhvZl1sQw6YOFeCroAQS
	5R/V3NAo3mtzJsJ8UwEV5Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2g07hxfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 09:12:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67H95K3J021896;
	Mon, 17 Aug 2026 09:12:30 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejb1h98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 09:12:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNwVew8eWbl2V7DXqkIFFUtjuZAnDncg0/dpmuu5DC4UR4FzZHW9yE4Bx9DIJTSy4VjbWMhJhnQDY325Pzv2Ri8+Z9S7ZWxZ7pgBAQSa522AorHY8j9SH8PjwBV2fmFNIl4b54x0baNw0lXasL8L+U7FXgehAFDN9e969v8VcSnVC33W6mLTcgOMM4M7K1nzV7CPQzpHCFwiBtZ585OlIwxniQL5vsQ1oBIoI/MTSKs9NJcJxB9aYDr3IqY5nFa87wsXAdZdLdZ/Bj8HUoW+ns7DGOTdobT/3QO6HBK1M3JAOkNkt9Ms+ormsHf86HABWoaJ5v70G+ul8lvIzrLVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI+U0jpHQTcCov2eZs1smDLXaQPerCFFsub5EonBJxg=;
 b=CU1ftgbl6wxYjIHtrTrY994yEZ3RX/7/x0HuBEd2JgnE/t0BxZNcu38iEQH2YCsqWhwqr7lI5e557BBlSCMJ+CEn/YUxJZTyHAIEPHz/y5hRx0rn5b99S2WsnFT6aUVrSjLpy6nE/dGgosVFZWFyk8rgU3oJHiI4q/IoTtsuWeMPD+BlwEaxj6Alk0t4EoX4NHnyeIgLZSRenb+ELkIGdskKEB1wwjEwYsBCnnxFmQ0tIrk70DsHQqLhFv775/7eFxZt1MxoUDaeYfeEZ2sHPUfezX7wrD1dsO32yJYFZFjlaaTXX1tsfeoSsmu5Yq6Z83zwGIsUH9cHYyd1sF1PBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI+U0jpHQTcCov2eZs1smDLXaQPerCFFsub5EonBJxg=;
 b=FuzXYtUrQTyscUHl6burDs+LePybA8ni7VbwJ6Ro+Puu0+avqrTlFWLfDCAbEMlFTFWw2+Ko+rJYkOXrnGpWNnqXUFdfAAk+tiNYUgLa3znq8gxhqlSK54f7sEOjqhQT3p7dBzmjTkuS78i9tBJFHWwsj6ctc1CJL3fH7EH5P34=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 LV0PR10MB997686.namprd10.prod.outlook.com (2603:10b6:408:340::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:12:28 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:12:28 +0000
Message-ID: <86f7fbdc-3c7f-4d84-871e-52ed3cfe8d58@oracle.com>
Date: Mon, 17 Aug 2026 10:12:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: dma_opt_mapping_size returns way too low sizes when using IOMMU
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
        linux-nvme@lists.infradead.org
References: <20260817083654.GA23414@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260817083654.GA23414@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0527.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::11) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|LV0PR10MB997686:EE_
X-MS-Office365-Filtering-Correlation-Id: 271e47b5-0de1-4e6f-3503-08defc3fa936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BuRb/qu9lUJb0VpUM68dIgQp6Rdyhfnvm6EqmywWF7RSu+oBQC45UG9khYQr+2a0aEU8X1pZS7Kvj2MHOSomh3UHEJFeaSC/PQ5VTKAp43j1/QvllblfWIFqqOdxpjHd2a7HyDMFFg3vBe/IDLSbaEPbmjGj0+/x1XAFmSqxa1EdT5MBGBC5L0pTGhOkAQMpiIZep0CCyI9kO6whAaNjiAeAd3g9efcdkYXdyjUMOTx18wIxmPGoaFbHnt9mNox86fJrrxT3993JxvCeSEEDmMfdHHkE3NzXkeMNtKYGHBEqUQKm4Zia5x0Bvuitzy4jNng9pm9CwID7a4oVJZSR+20XtEAKeK6ACvkx2zQCAmUJgC6WK294CmczDBjzJlSKeydoO9DG50gCvci153rMJ6IHwgFVtGs/lNvH/JwKJxgQLcMAeMQbNXzqrjembRKQSjurN9nA42NlO2WyMlhkUsAB766yTpP2UxpOyByeKQfoB+RJZ8N1E9ajJvG6DQLSswn9FEZrIoaSKSlfsK2MZ4I/ykJVvSNlqeBzyZNvLYziCaOMz5Rp3QjQIjYhcXYDGkOPKMMO9MGmzn2Xe8fUjf3Szkdm9yii0DYhIJfPE0fBExss2664vcG/jnizrh1W8GrBQkJqSflyepeYs9ltMWDsSEWmlZfwuQG+bpSPxmI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFAvVHhZRmxMY2pDOXVYTVZ6ZkJXRXJVdmVRQzc4Ris1VmZ3aHRPMmx2cUw5?=
 =?utf-8?B?MXJWV083YTRqRUxLWThuQWhsY1NueWNPRlQ0Z25CWEZQRFpReHBQRG9rRGty?=
 =?utf-8?B?bGgrd2QwM093bzJsb29qeGNwOVZsbGZxVXVGeHpEVS8ybWJjVjAvWE0xMTBQ?=
 =?utf-8?B?UFBPQjRlVytVRjBKYTV1OWFzSHpnaDh1T2VxeG9zNnM1QUhnVkIzWGdmVlE4?=
 =?utf-8?B?T3N0cGQvNEplN1dJUHhiemd3elpFekV5NWNucWpTZDY5c3BJN05vRzBzUlEv?=
 =?utf-8?B?WllJQ05DVGppY1FIaFhRNE16d2wyaFh3SGUyREhkWGZUd1k3bkRZU1VibERR?=
 =?utf-8?B?Z3pkNmZVZ21JL1ZoNWFSZlRFNktDT2dPVmg5NFdYQjlpQTI1SkJRN3BPby9O?=
 =?utf-8?B?am9ZMjdLUVZFYjk0bTRrRUwvYWRmOS9ReEZtZi9jWkUyYUIxOUtSdVM3dWdE?=
 =?utf-8?B?S3dnNzFBcHNvRTk2aThROFlFU2FQb1h1b28rRmpvVkhNUzlsejBkeWlnZGwy?=
 =?utf-8?B?eGNFKzQ5eit3QWx6czF2bnYycW9FcWFPZk1GM2wyb2xjV3R1NVhXeEhhQ3h3?=
 =?utf-8?B?Zllhc05IUzhqUjJ6SGNxaUFMbUhQZ09VZjRoMWphb2tJU09HRXM4T3JraU51?=
 =?utf-8?B?TEpuU1BITzh0aXVhaytjay9YSFdFOFdZWmhNbjFxek5xZ2lqZDJhb1VVRU1q?=
 =?utf-8?B?SmNWWHZWRzZ3RGR5N2thcU81SU5aaHRXZTdhZDR2bEdySzdNVGFiWlhuQjdQ?=
 =?utf-8?B?YVFnVEY0REdJMnNpSzJhVVdNMldtSzlieWNucEUvQXZTR3pYVXZIZlRYQ2lF?=
 =?utf-8?B?T3VOS0hUYTRIamxQNTRXTHFYeTlGVFlsNTBSYlFHUmtoSmVvSGhXZkhBWlJa?=
 =?utf-8?B?M2hINWg4VUM4RC9qNzhwR2ZoV2xyS1kzcGpwTzh6S0xUNTRnSTdzWGFJUWhV?=
 =?utf-8?B?U1ZpVXRPQmJKOVN2R0dtc1V5N3lpenZIUFFwZjIwQk4wcmJGVms2Nm4vTU5p?=
 =?utf-8?B?ZTRrclBpNkhvK2M1S2t1Qy9USk9ndkdEWDF6N01YUDJWdkxWQ2tzRnFkaXdu?=
 =?utf-8?B?OEhQSWh5Z1ZNRWgzK0hIY1hGbEw0bldjVXYzdVpXb1pCY1BhOFZNcjRac3ls?=
 =?utf-8?B?dmh4eklMMmpOSVpxeHNxUFA4U043THhxZTlCNnh6Y0phWFBBaU1DRHNweU9r?=
 =?utf-8?B?T0ZZZnk4UUhHenVENmZBY3BKQ2ppclZ0bjBsdlA2Z0U2ZVVjaHBmS1FKV0tO?=
 =?utf-8?B?VzYyMC9SSjF2R0srcGxEbGJTdzZzNFBtUDNtbDh5WW1iU3cxNzRSbUZCdlcw?=
 =?utf-8?B?S05hNVpZUnprM3dGcXQ3ZnJndXZSVXlFc3ZnanlqWDFhYUMwMXY5SDRaWG9B?=
 =?utf-8?B?VmFSRHFVcEFSZ1NSV3VISDU2V0p5R3pteXlNdFBxZWdoUklCSEZHbzJidld3?=
 =?utf-8?B?OGVMUkJqdkdjTExMM1NWdDFXa3VrZXl1Y2tyTGNsWUJZRFNhTEYwaVBPeTBX?=
 =?utf-8?B?OUZ4Mi9XdWN1NE1JMDVEcUtieU0xT2FsbGRQZ25YVUtxeHdKeVRSSEpnNjVn?=
 =?utf-8?B?UVpJc0hYU2JtdE4wS1RrVURjekRiQzNOLzdza0lmN2pkM2s2YmN0Rm1xQXh4?=
 =?utf-8?B?U0JIM0NHd05nQlpDUjdvQ3A1dS9xWFR4NU14VHd3aUxzMEZOb29LSCtMM3dm?=
 =?utf-8?B?UlVjdVU4NmtEcEF4TExpVDU0ZHZUZUkxa0tyS2Joak1zaE4xQ3pEV2tnU3dn?=
 =?utf-8?B?cDBsKzVVZjAzNVBBUmVicVozOTRHV3Z3Sm1Sb2dTRFQ4U0N2SFducGVuUCs3?=
 =?utf-8?B?Mlp3UWdoVkpQYlEweE1KZ0VXek1lVHd0L0QrMzRHWG1tVWVmc3Z1YjlRSVBK?=
 =?utf-8?B?ZDMvcERrTmY0YTZLU3NDckNiZWtERVVWeXZ6N1EvY2l0bVppTWxwbk5TbGFG?=
 =?utf-8?B?YldpQ1pYZDdvWTR5UXI3NHpQL0x6RWhBbGNqangwbUpzQm95S1FHMTJudU9r?=
 =?utf-8?B?ZDczMElvL3FoRVdNM1BjZmJOZUhYaXpWL1dBd2N4SDdlZlp1M1BPRS9IZzBJ?=
 =?utf-8?B?MWZydStja3ZHUkpVMzRyb0lTM1d3cUxvQm8yUFErUnRKeFMxcUx3RStRVnlU?=
 =?utf-8?B?Y0YycnRCNGlWZC9DMzdZMmMzTm9GZVBCdTFnMUtBaEMwQzJRVzRtbzZlc0xi?=
 =?utf-8?B?TGsxZ0tLVFhaUkZOUzlvcUhEazlaUjY3VWovZFJSbEV1OVlxekNSTzJhV0FC?=
 =?utf-8?B?TjVja2lDZFdxTm5wRjBGMUgrQ1QySFY3ejFHN3V6aXBTeWp0RytDc3NMSS91?=
 =?utf-8?B?NkxlajFDYzF6L2tPdDR2ZWpWcVoyTWVnVHBORHYwN3VxcmpTZmNvcjVSdEVX?=
 =?utf-8?Q?wUTB0AdJX3yYXm6c=3D?=
X-Exchange-RoutingPolicyChecked:
	A45rsbLujNwFc1IEag03I48Lqv+uQwPbhIL2CZremoVF8dZZI9jc6611v5chAH4unLE0Iu5XWKsif00rWzNRSocW91THIhxra3Pixs6xcCBg70RjvAqe9hXg56Tu4TFXWJffwBKqZfhtam14yDG5wBXDRHJ+BS0gbAOCfeu/xJO7VdlXGkZoxdxngJDuWd+54S7kINIDzQcV4hXrj/uhRpvWIFt0ydxwC2af3X+qd3AeqOziJhoTqlsWHFhtX34y2av55nZBs/hrPZajLgtTCTgp8xIbGLVgVQqIRFmoLGVM3GoQWXjXe4phWlo9Sbljc+CPON4sK7rJSO04S+lbDg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wU0LCsfKrLZSUJNBvzQNG7C4cn5Uq6pWxRNXmrHgy9xSE+PrNbmO3vmYSkN39I60CcTIYRUMpvmcnrktWkx8vh2soehFL9jdf+efISl4IGhuQy9RhHv4fPsXb1X1AXzn8rbGKOAH8JOLA3GbWLId2f4qE+dkZAqMUL8yVuPJqc9GJwmbmDs7uJM/Er0+0XtmLcGotAGv/TQHUGTImiTqSzYmbvEnyK75rw4nbdugPBRUi3QV6YZzc+OR4BwYu9L9iNpzkzrBSeI6Rz2TA5nbII46g/SZu+y69viIhdVgEtK/BcAwMcl7F7xU1XtTY314BNQrGxzrRU+366RfSz9mR8kpIzdAb64XoVv4ELse2AIXH7tBZtdi6F/GxRJBu53H8rxivMDD3RMVUiSSHt11CUL9cxvEg6GFhtaMSSw7sLQwtnGLWVMMmDdkAo7QweLWWGhZP88yK59eTb4BOm+j9MlZ8O5nqfxfcZSuMZvegpj3e+oFN7CA5c4dfl71yK63zXS9PV1k4skUyugLUp+1XwCLOOv14Zw0WM7lpPO9H9PtRcmaaoxnB/d+fQZMkDhSAclY3KwoniEZDRA3bCt7Ru1RkWaEySkQ36gHiNflImk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271e47b5-0de1-4e6f-3503-08defc3fa936
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 09:12:28.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL+GgNuvH3z1V7tv3cCjHq6DI2/+vBfXJkN6Sj9yI6XpKm/Dk71GjGG5ZVji+lQx9YP2020nUny2TCdiifnIaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608170068
X-Proofpoint-GUID: l-o5_H2avffMqqmXQtjfGXESR-rTH69Z
X-Authority-Analysis: v=2.4 cv=Hu9G3UTS c=1 sm=1 tr=0 ts=6a82d07f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=pwC1oX9ZnPkc-pDwvFkA:9
 a=QEXdDO2ut3YA:10 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2OSBTYWx0ZWRfX5G9NytDMJ80b
 1RFrCM/OxEtnOT76gDDrcnqAuuBHov1I9ybSFqXciKC27z4K5/bwNd1OB7bAbOquPPxM81Fi4++
 2cHAsZJ/rcPaJb3hx/0z/Hh/T/U25Q07T6dJSuG6C1M+GLMX04T+
X-Proofpoint-ORIG-GUID: l-o5_H2avffMqqmXQtjfGXESR-rTH69Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2OSBTYWx0ZWRfX9SroC0M510Gt
 2ChovpwAzTkXHtqQI6Zy1gjBfwKCJRIz83VTqpDHmzWgnpVYwAjHl26WGVYG5obU1cXmmD8m1UU
 0NnrKU/iWEZU0yyS7PEJJbCQyO7ynGRWso1AFDWoQQVLe/nhON96TbJko8vxZk8DP6QUIl8jzj+
 Pdy/TlDW1cz55Qxy+PAy8o5AoX3AWBnNhPUllW7VAlK3xBzbJC+Q3wjmieBzSdmnuRHARjBuSqv
 q/wh3CfB91RLSEJCPVkI/7U2NqOxLBjVWMzuDjx17dKpsYYm0Pt+OX04cxAraEpWQUK30Ygodcz
 7Kryi8DFUrhiPCSv2IEAD0uYjMTIrlDIwjHqDGfozTeaJW5QIU9nM6WIHsZ/qBIO/PuVmQ8cTeW
 n8asRFTqmBcaXesgvSKE/+71eVBPdK4Hzcy3e3Cea6N47SE9ZrEYDSdQBxFSBbp3BcuUmC3W/pg
 9q5TC1n9mFVw44rtWWQ==

On 17/08/2026 09:36, Christoph Hellwig wrote:
> Hi all,
> 
> I got reports that NVMe devices were arbitrarily limited to 128kiB
> transfers in recent kernel. 

How recent a kernel? This NVMe and DMA mapping code has not changed in 
years as far as I know.

> It turns out that this only happens when
> using an IOMMU and is caused by iommu_dma_opt_mapping_size returning
> iova_rcache_range(), which is defined as follows:
> 
> unsigned long iova_rcache_range(void)
> {
> 	return PAGE_SIZE << (IOVA_RANGE_CACHE_MAX_SIZE - 1);
> }
> 
> and thus indeed hardcodes a 128kiB return on 4k page size architectures.
> 
> Both the NVMe performance numbers and common sense suggest that this
> is NOT the optimal DMA mapping granularity.  Can we pick a saner value
> for iommu_dma_opt_mapping_size that does not restrict common I/O sizes?

Note that SCSI does not use iommu_dma_opt_mapping_size() for clamping 
max HW sectors, but instead sets opt size / max sectors from this value 
(so it is not a hard limit there). Could we consider similar for NVMe?

The reason for which we have iommu_dma_opt_mapping_size() is that 
performance can go through the floor we can't use the rcache for getting 
the IOVA, i.e. we need to always alloc and dealloc an IOVA from the RB 
tree for each mapping, and this can greatly reduce performance when the 
IOVA space fills.

If we increase IOVA_RANGE_CACHE_MAX_SIZE, then we just get caching of 
larger IOVAs and I am not sure that is a great idea.
