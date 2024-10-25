Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAEA800
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729879150; cv=fail; b=oZnRwV/S0tRADrxJ7UGm8uvXeHcnRtXQVo0y0SOSjHNQdDyGSUt2NZC/G+N6h1XKMuCiHC4czNkP+IY4f+CLgyQW/o2S2C3HE4DVhw7PBWlwo9DQ7CfHCFRznyQoiG5XKMLl1VkQ8c+LYRwqkfoCCFUrmMKcdVkVM+axpEw2KFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729879150; c=relaxed/simple;
	bh=nbYustYsBXuUnIjRDwb9X1mnnPMW7hMo4l8TTZK9um0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UkOqIUUtd0hZDfmyrCowoiYzreOk+K58c5wcqK2zDIyVIU6XzHPvbALoskhg79U/paONhDRbRAq+SBx88ZU1FB/hwwoiu+5MNxGuzu7xF5Y2Qp7Pnef9Lt2z84vxdxwpgMd4VRDyDiLjnVy4YVRLxA1Qkm9OvHRFjrqZ1RpJE+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QUGoRQ0X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fOHBD7bN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QUGoRQ0X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fOHBD7bN"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PG0Wkl028157;
	Fri, 25 Oct 2024 17:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=XyEHmyw4FdMMSKVM74shg3tjsQvFdklPvDrN4sHc5C0=; b=
	QUGoRQ0XH5WKJXCPN/p+Twlxei8iZ0K+lHQJpuQlz1wVkoyxISWYULvMBKcRNSvC
	gt0wwwwTMIvQg8WDz9+ytYkpc+fBzGMTCjMqRDBtyOGi1mz6wevaErHjrJEzSyOF
	NSxnQ4fZBLgO9y7G1lVxdoKU/eZb8p2Gbg6/LO0Oq5oWjoalk7HPjh1BewHfEWZ4
	dUZZTeSCXo2GWgaSlR779gnN+xpVkH+3yD0hUr3XQidzhmKfdPMaVSiCwZ1E82/n
	W+yuHMLKTnhjP0v8b0p08Rrdn/D3JyhLo3rZlcPYfxLWF3jGWYJcIvJm6+zOqk2i
	k7d3YfC9tSull1ND5ynbkw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkr4sfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:59:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PHUktL039313;
	Fri, 25 Oct 2024 17:59:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh626t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 17:59:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYbBCrUF84K9KYled3f7/63XHHKD4GlVmzpiIkRQv9umMGIuyXy3mS4g/p1rbGzwp3bIYmup9zuvQZ4vt9Da4sLvHyE1e+uYir447suOKy8bN4ddSfMLDvt4YXfRoHCNvcDn/EYafqZtqS5K7eRVEb85ruklJT78bYH2vo26sqhLPhu04YUtOmeg7R85Zp7j/36ZSXxfksifvfJTvLXRFrmYexUU2HUOei+46nDhCuGpdv9xNppHwrZU8zzQ65UXJPRw9z59Js/wbzMpcicLcdLq8hLWFH4K7Gyc2zaosJDyFfHnb89sc7MrZmwvyO8hjTtCmSG71AGvpDz73BfVPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyEHmyw4FdMMSKVM74shg3tjsQvFdklPvDrN4sHc5C0=;
 b=MEGDsxDPB6x8kHbLNusBOGEMINtm+5Od8mdtzEjzWfYSQqjuJ6UcVfLofkC5yrESOzPJJNDOTaTSE4o2aaZTbS779DQCqYiToxs4u14SJC3y1w+Rsz3L5RGH+rKBjUPw0FJiWZmucUWxDMbC5/RhMqY/YB2unlKUbZr00QhKi9znd7XEc63VldFtA83md8FJJlJXOLMRJhjjpGhLu+zfo2SL6Zji7zF8f67K9FC3sR0vN2dUVS8WoV/g/ys7rfydF4la8qG+DpCah9rVGcsj3gQp2J4xn8vsjxBUe8SBKWCXXIIPUtCi/BfasGGb+R1vF7Bd/uHQqPEa9W39Z4TAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyEHmyw4FdMMSKVM74shg3tjsQvFdklPvDrN4sHc5C0=;
 b=fOHBD7bN83O27xS/lm7a+H+DYeRlmCZYucuLNrZ2L6gDUm1jOV5xGYC0q79Zvfi/OmMGeT+JNbU+9JjO6/CwcyfTuI3aV6+sC3iTHdrvahu6AOmKnXG/eWEwLRQ07zfo0uMFK8zBlSp7QjJWZUWEpjeOJ1wAaxGIA2CXAI3XBQw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB8105.namprd10.prod.outlook.com (2603:10b6:408:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 17:59:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 17:59:02 +0000
Message-ID: <2c7edd3b-61c7-4012-b825-4972c0efcec5@oracle.com>
Date: Fri, 25 Oct 2024 13:58:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 9/9] iommufd: map file selftest
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-10-git-send-email-steven.sistare@oracle.com>
 <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxvPhQZOBR7g56eh@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae6541e-0efb-4440-a7ed-08dcf51eb525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDlEa0Fhd1p0YzdqN3Vra3oya3dUMHQ1MUdhUy9sMjRUbENMODJHaDZkOXhj?=
 =?utf-8?B?eVBOd0hRek0zOTUwSUY1dFN1MEc3K3hWWTVJdVRVeEJmOXA4UkpSVm1Jb0Y4?=
 =?utf-8?B?b3R2THpjaXBkOTc4RlJET3BQZkhXYXRYb09QSDhXdU1nL1RodVpFRXpzdS9T?=
 =?utf-8?B?K3R2aDlMNk9XZE40eTR2OHRGMEpmQVQzek51L0NzQVNXMlVpZGV4eUVpY2Vs?=
 =?utf-8?B?aHdsQzM1M1B4YWl3SzJiYU5rci8yWWIrTmg1aTA3d3N4THBUSmdBSU9Fc3RE?=
 =?utf-8?B?SVZzZGlpRWgzSDJtM0VhenFqNFhaKy8wT1dMbHJjL2E1S0dWd3Z2andtQi9N?=
 =?utf-8?B?ZDFxTmNyYnF1QlYzWGhxM3BMZGxzRWxZOHpZeDNmSGhxT3l5amNBSm5kUk11?=
 =?utf-8?B?UzdKWGpIUklaZnJQT3dHTDdXdUQyWEdaMUs4c2tqRmcra1BEZ0VZYWxGTzZ3?=
 =?utf-8?B?a2ppcXRnQVkvYjY1WTFLR0pteUxKRDFYZmpSYUVJTUdTbEF5SWhjVHZJSkdZ?=
 =?utf-8?B?cmVDVTNzWlBKZG5oOUJhRGV4OUdKa1BuaFpKZ2M3UUtmYmJaSktRWEhGd0Rv?=
 =?utf-8?B?T0svWENjT29sdk5MOGd1VytiNzJZc25PWTNLVVpTeFBwMU9tMFBVRFhKVHFt?=
 =?utf-8?B?cGhRUEhrRzdtcUtZbVF4S1lsMFRiWTZlbkEwTjBiNHRCc3R3TklhbU1aWnR2?=
 =?utf-8?B?QmdpelphTTJ5MGtqeXp6cnc4VXRLbHpkZE1tRUJCWGRGUnpYaW8xaitzOFB6?=
 =?utf-8?B?eG92c0JUNWRlUTJ0SGJsRjVkbWd2aWpnVGFhVEp5MjgvaGtzZUpkSXZuVytm?=
 =?utf-8?B?cklyb21iVEpDNmMvamJ5ZHYvQkswWFZCN1JseFNYaW40SWdTbXhManNXamgy?=
 =?utf-8?B?WklJK2JsRXY2cHJVTlRidlNKZlg4MDZUTXdPM3pjbkJSVElYRVMwdDJBQUs5?=
 =?utf-8?B?M1JYSTRrNldYOWI5Q2VKSEhyeW8xcnhnQmIwVFhPUXNvcUN5Q1lqVko2QXJ1?=
 =?utf-8?B?eCtaYmFmL1JSZGFSb2I1L3ZmMFlPMEZhdFFzQWhCRTNnRnU4WDJvRWlMd29L?=
 =?utf-8?B?dXUzdmU2ODN2cDZlanN1cHM1YU1CZkNBODZUVXBRY3JTVjY5dzF5ZW5jWVJy?=
 =?utf-8?B?cS9Jd0ZJMWsvTkF6K09TUWRRS09oSk4wdm0xQkVyd0RoRU9YbEdMaEIzUERN?=
 =?utf-8?B?NGxzV2JhZjFzRGE4cEVRaVZ6MUNDRC91WjQxK3RwM2NPYnEvMWE4TS9GVnd2?=
 =?utf-8?B?dUpxRGJHZjFhR2JtdGs1dGRtVGhZbnQyQmZNSm1vOUcybHhPSnlNMWt5d3Ja?=
 =?utf-8?B?RFM4cmpMMk81Uzg2cVhzdVRBblozNm83T3BzcXk0VzkwSzhIejlrME1aTUtK?=
 =?utf-8?B?MEtIVnBkdmpybStwdzZpN3pRL1dScWhBYldMd1I0R083UjRTVTdTRHE3VE1t?=
 =?utf-8?B?OWd4VlRaa1oyUmZNV21Vb1lEdk5BVWJHeks3REJnTldueC92UlY3MWFyU2ZV?=
 =?utf-8?B?UDdFR2ZIWTVDOXc0WUZVSS9paGREVW9OdXBIOUxKQ2tLU0Y5T2JWcXlVUzZq?=
 =?utf-8?B?eVBnTmQyN2RjaVBaV1pJb1YxMlZIM3ErNUhLT3J3L1I0dFV3bHVWSDVhUjVt?=
 =?utf-8?B?d0FPYVdLSURkYmtaOW1sSDNFeGg4c25VdENkaWJxRXV3K2h1NlVDb3J5a2Fz?=
 =?utf-8?Q?gkOq/a/BHgibCpJvX4H9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjdiSmN2S1Z0QllpQnpzeWUweFRvMG5XYTEvWlg0ZndSeEgxZW9DZlRpUXRI?=
 =?utf-8?B?WXpGa1BWdXdUcUw5blV2VnlYNk9tL3cvZHJUaTFFNElRbk5jZUxmdnUybnla?=
 =?utf-8?B?UTRkdXUvbjNOWHV3aWRpZmhyMVJtNlFyMGlQLzl0NzJ1dlZuSkVrSkNMZHVu?=
 =?utf-8?B?WDkyUFEzcHcyaWs3YTZaQVcrOU5vVmtraWpnak9qb1g3ZHBFeThSRDdLRjVY?=
 =?utf-8?B?VDZraFlROU0zTHpQeVZsZWpqZ3U1UjdTTlU3dXRBTHJ6Y0F5Z2psSDNMTXJW?=
 =?utf-8?B?UVFlZGFnQ3A1UHFCRnI5Qkw5MjhQMllnQ2lUNDJxVjgyVlVzM29iT2c1MU5T?=
 =?utf-8?B?aDZnOHhzaFZHS3NXN2N0S3JwNE93dStKclJZbEs1L0U2SVBQcFZNbWZCZmsv?=
 =?utf-8?B?alYwT0NLV3p2NW1nUkNqUXJBeThUMFpIdDZNcEdlZVNLN2xuT2pSUGx6Y3BX?=
 =?utf-8?B?eXg1QkVPcFVwVHFtM3pDM294MFFoYXBxQWhYQ24zcmJiQ0RlWHNNNHNCY2d2?=
 =?utf-8?B?NlFFQjRsMFNWeVNIeFBkZmVZTVJwZ0VtK0h6ekgwdkNHL0k2VWRjcU9wMW9T?=
 =?utf-8?B?YUxmdHhnMllnU1o5RTV6UEh0ZkQ2YUZDc1RMODZOZHFMa2ZFYWp4d1hqQWh4?=
 =?utf-8?B?cGNrYlhlc2VMZGRXY3dGeXZwenlNdGo4YUFLempMaktkelRmUC9LbFU3K3R1?=
 =?utf-8?B?V2dENm5LRm9hVVpLT29jOGpMRXROMWxpZUtaRVFvc3ZJbSs3TVd6ekdRbWI3?=
 =?utf-8?B?bVV6YXRlRC8yMEVuY0l2dDVQODc3Tm1ZK2Z0NjQwSXg5QjNhdVgwQ2MvRElC?=
 =?utf-8?B?eWtjak00TDRveDFHZHQycE5GSFVrNGJjZGgvemdZRjF5VVI4cXY4NFc2RU5Z?=
 =?utf-8?B?WnRhSXhtU09aSmRPYXNJTjd5cjlQWU1URjdpbHB6NjFxU0dMQ3pMUlY1Rm5w?=
 =?utf-8?B?S1p6RjVIQjAwWUtYWkZiTnQ0Y0p2RWFaOWQwUVgwb3VUZm91T1FqZTNiL0kr?=
 =?utf-8?B?V1JPeE8vV3VKS1RPTSt6Vy8ybVc2OWxSVVJrSXFVRXIxaEFJV0VzWkxmVVRE?=
 =?utf-8?B?b1Y1LzV0dVQva0J4Qy9yNVNCcUpaMnlIbUNTSHpDYzZmU1Jla2lPREpYWGtv?=
 =?utf-8?B?ZWF1ZFdMMGJZRTQ3ZTZ2Z1p5cWhleVNVRG1mT3ZCaW1IN3p1VTJmSHh6dVFL?=
 =?utf-8?B?QWUzaUVwNHloWk1wU0lMUUFyd1Y2N21pSzh0YnpORDZoL3J2amFoSWd2QndO?=
 =?utf-8?B?TWFrbGpLZzduNFRvSjFaSkhFTlRzL0VGTW12eHYxdnBtdmFrVUlmRDNyRGZS?=
 =?utf-8?B?RnpQaXVidkFoTUQ2akNQTmRmRllrMnp5RE1HU3J4OERxdFRUd1RvYW5mc3BX?=
 =?utf-8?B?YlFlNmFWbzQ1d2ZYL3V1eFM2cGZ2L0tBd0gyejhiUWQwS2JPRXVFWXZFb2wr?=
 =?utf-8?B?Vkc2MlBKQXZCb2FseWlnTmg3TkY5MnBGOEtCRmZDanJLeCsyZytzdW9FY1lq?=
 =?utf-8?B?encwT1k3WFJHVTRsVDFEcHJob3JXbVRndERkNHlLb0NySW1ZWWpzRlRBWnVL?=
 =?utf-8?B?cTB2WmxXZU02TnFzN0dHYUtZcnNGaUhUNVl1ZHRzdy8xMHFaZWlMWHJFNEQz?=
 =?utf-8?B?Q2ZYblpZWjlqOVJrOGEzK1pvTHgrZnN4WHVnTmVsUTN3RERleDR1RXJpU3Nl?=
 =?utf-8?B?TmdNVkZOb2tBNStGMlZENEZ0N1dUU05kcFFMaUV6TDZCbkZLU0JDYTRER0JT?=
 =?utf-8?B?a2p2dHowOUJHYmlEbjNiUjlnQkVnQ2VUY3ozajRDdGduZ0Y2ZlNMd3ZldnVn?=
 =?utf-8?B?UEtTaVJXY2c5V3lRSnh5d1dyNmRnaWE1Y3RLM09JcjMySnVrWS9jdUN0VFFD?=
 =?utf-8?B?QkdGdnRQcEJPSzFXUXZrY3ZZWW8rNE84MGdVVGNHdVk1U1JpUU9QcXIrdXo5?=
 =?utf-8?B?TkZTTjdDVEVrVWZQQXcyRkVlcUpVZ0xkalFRQlB6OGNXTnlNVk5iZGw3VURZ?=
 =?utf-8?B?M0ZuN0szdnlZNWhFeWpCSnFtb2xLRGhlcEFwdEhvV1JVS2xOemExWXBydHFt?=
 =?utf-8?B?YXlQNFhCeC9yVlpaaW5FYXA4d3hzOCtXYmxiU2Qvcy9TQzZEWDJQbXF5SWkw?=
 =?utf-8?B?Y3ZsWTRqcnlWVE04dDA2VGtRN0tzN1BqcDdGaUR1ZGwzeXRoU3N5UUN6TGJX?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BvYve4ECto7tlUCnzrYf67O9fypnpIOp3Hit7DrQfLwKgCWSJK1F5k318SimRhgHh6CMZ56Y3mvaOeX6e41ifQcitYtDAukWN5vhqmIn5L/jnOMXnS6ieasAUnC5d7BIrUFcxwqtgRbODs4fXQD++gL1/pDGc1PxB6REFJ4z6IITWdXzD70FZYb1S1LRnFIO4gahnjC6JZNkL9mPqJfpFAiDYrS4DtWr+i0S6FzKHzoeRge41rKYy6WM+fPp289v3UgV/xoUEFafE2IrOWW1I30uGCy1syFIpO2cKpWbi+FYrI/568TJVLhCh6I/iuS3ECOPZ5gR1yGKt5UNGA9TXctlL0NDk2rXM8QE+7/THLtPWkd04k0koS2DUsPhmrp4K/lflDnP7A/QQDzp0LBk5v5TTDejTLp726ZrnU+sDIiZSz5fOIIt14zJbsTHUozAMkLghjWMqirDUoLAx0jus1x86X0wJDwLmBYzgsCSjVsp2FFWul+m7JDwUJf0h6JnMk9RDyUVg4tVe2fURvJnWeqliQiXdBVXUMea/RbOAZckq8mKJq7zjm7bspmX/SShN39HgVttiPEEGQW9Hm5Cq8VzTD2nIt9h0dUSYaIWVPM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae6541e-0efb-4440-a7ed-08dcf51eb525
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 17:59:01.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlpeC9+d7fJtwOS0tqcAsvS51zb8hC8m+sb4eIV+ZIpkEu2RmeXm1xs4E3SZe6/31Kpl2xv2RClyZ8c6yN+9DQQgD3J01PelzqrVqKb5a6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410250137
X-Proofpoint-GUID: xEl-g9VhgLjlTtU0XpX4AlOGhb_xk7r1
X-Proofpoint-ORIG-GUID: xEl-g9VhgLjlTtU0XpX4AlOGhb_xk7r1

On 10/25/2024 1:04 PM, Nicolin Chen wrote:
> On Fri, Oct 25, 2024 at 06:11:59AM -0700, Steve Sistare wrote:
>>
>> Add test cases to exercise IOMMU_IOAS_MAP_FILE.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> The build passes, but I now see a few failing tests. Any idea?

Strange.  All tests pass for me, with patches applied to base commit
e2d8fe9148b79ed1cbf0663edc988db7769173dc

   # modprobe iomufd
   # iommufd
   ...
   Totals: pass:204 fail:0 xfail:0 xpass:0 skip:0 error:0

However, I also needed this patch from Yi Liu to make it work:
[2] https://github.com/yiliu1765/iommufd/commit/ff0772d155c1ae2841e7b7ff0d7ca889271b81b2

Without that, most tests fail, even before my series.

I will try to reproduce your failures.
What is your base commit?
What is your value of /sys/kernel/mm/transparent_hugepage/shmem_enabled ?
   (both always and never pass for me)

- Steve

> #  RUN           iommufd_mock_domain.one_domain_file.basic ...
> # iommufd.c:1521:basic:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, self->ioas_id, mfd, 0, PAGE_SIZE, &iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
> # basic: Test terminated by assertion
> #          FAIL  iommufd_mock_domain.one_domain_file.basic
> not ok 136 iommufd_mock_domain.one_domain_file.basic
> #  RUN           iommufd_mock_domain.one_domain_file.ro_unshare ...
> #            OK  iommufd_mock_domain.one_domain_file.ro_unshare
> ok 137 iommufd_mock_domain.one_domain_file.ro_unshare
> #  RUN           iommufd_mock_domain.one_domain_file.all_aligns ...
> # iommufd.c:1602:all_aligns:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, self->ioas_id, mfd, start, length, &iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
> # all_aligns: Test terminated by assertion
> #          FAIL  iommufd_mock_domain.one_domain_file.all_aligns
> not ok 138 iommufd_mock_domain.one_domain_file.all_aligns
> #  RUN           iommufd_mock_domain.one_domain_file.all_aligns_copy ...
> # iommufd.c:1656:all_aligns_copy:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, self->ioas_id, mfd, start, length, &iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
> # all_aligns_copy: Test terminated by assertion
> #          FAIL  iommufd_mock_domain.one_domain_file.all_aligns_copy
> not ok 139 iommufd_mock_domain.one_domain_file.all_aligns_copy
> #  RUN           iommufd_mock_domain.one_domain_file.user_copy ...
> # iommufd.c:1712:user_copy:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, ioas_id, mfd, 0, BUFFER_SIZE, &copy_cmd.src_iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
> # user_copy: Test terminated by assertion
> #          FAIL  iommufd_mock_domain.one_domain_file.user_copy
> not ok 140 iommufd_mock_domain.one_domain_file.user_copy
> #  RUN           iommufd_mock_domain.one_domain_file.replace ...
> #            OK  iommufd_mock_domain.one_domain_file.replace
> ok 141 iommufd_mock_domain.one_domain_file.replace
> #  RUN           iommufd_mock_domain.one_domain_file.alloc_hwpt ...
> #            OK  iommufd_mock_domain.one_domain_file.alloc_hwpt
> ok 142 iommufd_mock_domain.one_domain_file.alloc_hwpt
> #  RUN           iommufd_mock_domain.one_domain_file_hugepage.basic ...
> # iommufd.c:1521:basic:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, self->ioas_id, mfd, 0, PAGE_SIZE, &iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
> # basic: Test terminated by assertion
> #          FAIL  iommufd_mock_domain.one_domain_file_hugepage.basic
> not ok 143 iommufd_mock_domain.one_domain_file_hugepage.basic
> #  RUN           iommufd_mock_domain.one_domain_file_hugepage.ro_unshare ...
> #            OK  iommufd_mock_domain.one_domain_file_hugepage.ro_unshare
> ok 144 iommufd_mock_domain.one_domain_file_hugepage.ro_unshare
> #  RUN           iommufd_mock_domain.one_domain_file_hugepage.all_aligns ...
> #            OK  iommufd_mock_domain.one_domain_file_hugepage.all_aligns
> ok 145 iommufd_mock_domain.one_domain_file_hugepage.all_aligns
> #  RUN           iommufd_mock_domain.one_domain_file_hugepage.all_aligns_copy ...
> #            OK  iommufd_mock_domain.one_domain_file_hugepage.all_aligns_copy
> ok 146 iommufd_mock_domain.one_domain_file_hugepage.all_aligns_copy
> #  RUN           iommufd_mock_domain.one_domain_file_hugepage.user_copy ...
> # iommufd.c:1712:user_copy:Expected 0 (0) == _test_ioctl_ioas_map_file( self->fd, ioas_id, mfd, 0, BUFFER_SIZE, &copy_cmd.src_iova, IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE) (-1)
> # user_copy: Test terminated by assertion
> #          FAIL  iommufd_mock_domain.one_domain_file_hugepage.user_copy
> ...
> ok 2 basic_fail_nth.map_domain
> #  RUN           basic_fail_nth.map_file_domain ...
> # iommufd_fail_nth.c:338:map_file_domain:Expected 0 (0) == test_nth_map_file_domain(_metadata, self, variant, &nth_state) (-1)
> # map_file_domain: Test terminated by assertion
> #          FAIL  basic_fail_nth.map_file_domain
> not ok 3 basic_fail_nth.map_file_domain
> 

