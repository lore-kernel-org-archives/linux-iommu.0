Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A851DE4FF
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728071063; cv=fail; b=tNW6mINSFVl+4hYSGutwyCOhvx2sUFrW83EsKpewEMZlmYEnXgdTCmSxHqUQgmUthHkqhbaZaoeVbxUU7gJ101VKyiId0wojFJUrBgZZKRL7gmhFo+l0uIgzKvE8iNFu3CRPjKC71ZSnCiwIolbH0vVZ/MZHH0CiA0y4L/mrgYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728071063; c=relaxed/simple;
	bh=gUkUpV8/WWSKWoXmjWIcqkG6o4tFehGv6wop40JBPKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKzPT4nv36R/c5JBgGFac0b+V4Dg8v2Y6yb9nLgk9UR+valXaogcVMDrHSe2ghFA74lowMXNyj0KkKQ9lM+TwtDIbiCsQNaNjzufL02BSWP0eQksUuWBxq7ymQsKYohZq/u3PO+/c6rtbVZsTICnhWoLAPKzGvUCZxh+UR/vreM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PPFuKOAZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ip4ftv3q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PPFuKOAZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ip4ftv3q"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfbWR008368;
	Fri, 4 Oct 2024 19:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xvhgNhtTSiz6sedkqVxt8fPy6O1WbKo12u5Tw2RAcSw=; b=
	PPFuKOAZTDokEAes25ub8QxSt1Kiegv3XscE7fUdBwO4b2e957dn8zBmAuHv4EEp
	FIt6OP7G45Uv1knwdV73aaoEqGysUbKjVnB1rCTxCv1aHD6QXSFMzZZC0MG7Dfqx
	udSsbPH46Ca+5RWVeO4Omcwam96tPZGCcgFhSkmR3bsNPUqvO5gpDC/F1/tB9eKp
	UEMxAQyQV6Fn40X8PK9QhVY8Rv15g/jcqjGWQCH+mEw4Ch57vzFiAkG3pLR9w859
	ASI9WV2JSqO1LJGj9P5aG5ze6kU5zY89oQR0UhOMm5aspgo6Hs+BTZMkrlOQPe34
	lcKfgkDimQFh5wkMArXurw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42206m2abv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 19:44:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494J0nQp037929;
	Fri, 4 Oct 2024 19:44:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057qtsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 19:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIgiCOIFQkVrHOzjlYZWNTBS9nyWnew+rCJFqJRXpQhcPWfosMc3KiEC2xHbxKnJ90kdO1/odkgTSjZyzfvUjI05nAoUsMKTV8wiuiGKeKPeItVlWBNwX7Wq6ivQM6NQueDBuMmWB4hEv7bgp5pbKKJ7+wPR5KpMJUSeEGzAKEULv1xmkyR69sTOKqgRYV6AYDfr8Bqxgh7bo/gTTCe0oZ0/6A8gI6Geswld9Sprfu76Mil98KgSsGO90n6cg09z11U1m0SBTpOK0AYk1du4txDWScc6Zg7USOh63i8QTP0B9CQM0OEcQjNDE65GpNSRVcTc2wuL0cA5MRm3ygJ6iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xvhgNhtTSiz6sedkqVxt8fPy6O1WbKo12u5Tw2RAcSw=;
 b=FVlXPju8F9FjQwu8o0hWGK7cCZRlD+ErPmWQ8yHVlu+4p2QVR/7BS3Ahf+bedjXoEWuRDldYxZgZ2ubNY1JAah6HIqHJcInA2KMY3ZNKPzUsSasqtdR2yLb5HT9FD5oynVL+w3QmT0xQ3vd2B9PlvsYMKrouY1D1EXw9xfjVN6We1SngK7tP8ipUvN5YL2POQE1D/rElCpzOUeNOUYAqYn6fnF41k0TWnaFPJYz29ADZ8w0RMsp2pakXsFukCKzPYwJ6Aa5iKCvLTvDa5BQldeTEUJFIdIEyRaU2sFFCUb8OHDtCQWcfDD06BxuqQ6+NXnvZNtjQ2BVenrbef4L4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvhgNhtTSiz6sedkqVxt8fPy6O1WbKo12u5Tw2RAcSw=;
 b=Ip4ftv3qAd3B4FgWog+4E195y2cY2yNpF5HaoCT/MJ6XNvRC0AGGwWB3JgIzhihbyzWtBAgSGmt/bvOeWAup1szW/UWCumIUFkKcG832fT/PdSts8AcE9iv64i9jqRXZI4EZ5FPfclBpry5IqnsZyCi2+gEegU9cmHZtRcAG2hM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CYYPR10MB7628.namprd10.prod.outlook.com (2603:10b6:930:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 19:43:36 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 19:43:36 +0000
Message-ID: <c5d6690f-e743-4a69-9b83-20d5515feb2e@oracle.com>
Date: Fri, 4 Oct 2024 15:43:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
 <1727358828-97791-4-git-send-email-steven.sistare@oracle.com>
 <20241002175109.GW1365916@nvidia.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241002175109.GW1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:208:23a::29) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CYYPR10MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5784d1-66f1-4d73-29a0-08dce4acd6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3MvdnpnY3A0WWR5c2NVMjcrWGtOZHcrU1gzWXB4UFhXcUxkMU9GcDJuWFA0?=
 =?utf-8?B?K3FpRWhWYXBrU3YvZXVTQVVZRFhhRHpvd2p5eFN1bkJpbXVBa2NIWFN6bUNr?=
 =?utf-8?B?bnBPQUpFVmc1d1N3S2pGa29PSjh2SFo3ckxiZUtnSVV5SWpXUkUxNEc0cFhj?=
 =?utf-8?B?dm9KWVYraEVRM2MvMEdYSDRCdHpoZXZmbjdBWFk5RlAxeUh6UGJKOUdtRXBM?=
 =?utf-8?B?Y3g2amJkUFNHc2VrT2Rndy80cFhTa3NId0JzMC9xaHB4MkwzMktEeFU0Snd3?=
 =?utf-8?B?OHVOVzFUNXVrRHhpZUtFV0Uwa3U4YXMzU0xvVU9zVlNvUEJHUjJaNzUvRlR6?=
 =?utf-8?B?VTdLNWFmZlpZM2JROHQ5R2puQVZMZVZiWTMzSjhObmxiRHcrOTlXcmJLb0FH?=
 =?utf-8?B?N3BzZWc2QjNDSXhlUXdleTVNYkNJdFhNd3Y5eUFER2xlMmRZeVRHdFNEZE94?=
 =?utf-8?B?TjdnT1ZNQi92YmZsdkd1ZzZ0T1ZzSlhNbk02bndUb3gyWEdMOFpDZDh3eldN?=
 =?utf-8?B?cVY2SFladlZJVTFmRGRrUmRJdDlqcThXQnh0dGtDck4zTkQzQ1JxUmlydk5C?=
 =?utf-8?B?a01tdVpSMEpocUdXYi8wQjF3SXVrYkhlVEwwemdwR1Q1T2syd3M5Zm1zYzdX?=
 =?utf-8?B?dTArV3JOcEEyb2JvVFJRcjEza0UvK2Y2WVNMYTgxMDJLdWFyb1FPZ3Z1RG8w?=
 =?utf-8?B?YWgyMHd3VHF3eGU5YkVlRTJtaFVsY0ZnbFRYQTNRWWNmNmpWQWZZTWpnRkZC?=
 =?utf-8?B?Mld2UVhTOHVVZTFlc2ZaQ1FJeEhMMk5LNGo0WXhQZ29SeFlyWS9zalNHSTdp?=
 =?utf-8?B?NFBmekVEdEtaa2pEYzN6SGlaV1Q4SnFybkJJcXNNbS9nenJOTWFHd0ZlVmxm?=
 =?utf-8?B?cDF5amN3RXhVRnZpbmRYdXBXdWxjaDMxazhRVTNTalgxM09pZDRlenNiOFVL?=
 =?utf-8?B?Y3JJcjdBQjJYcVFiQU1MUkZldEpObCtaRVl5emx1SDFVb0kvV21WTDNFS0xi?=
 =?utf-8?B?RDNWbFUwOVNqQmM5YXIwMFBBcDg3b0paTTM4TTdwZ1J1bHJpWWRNNlo5RWIx?=
 =?utf-8?B?MURIcFNVZjd2Mkx3Y2ZqL2hPazlCdGdtUkJRTllnLzdTRlNXWDlpWDk1OFF5?=
 =?utf-8?B?SGY5cUhWdm5QanBER29QSzU5Y2pickphU0VRb3BnN0FqeFJJVEtYQ2NqUmgy?=
 =?utf-8?B?dm83RFNSY0lna2Yyd1o2T3g3SnZMNkF2Sm1EbGJzMGxUamJqMERWT0JHbm1t?=
 =?utf-8?B?aUdvakkrR2ZjdVhlT3I5Z2w2dWJUOU9MOTgrY1FLSTNKZUMwMndqdkZXS1dU?=
 =?utf-8?B?ekU5ZXVLMFNkU2VwRWlvS1Q4d3pabWFzTnRNbmJVY1VrQjh2aE43TjE2cFdQ?=
 =?utf-8?B?WC8rUlJnTU1CT1NwcnBMWjR4K0ZTMTQwNTVHZFdmMTRVMTZsRTN5U2c2MkJU?=
 =?utf-8?B?R0lwNkdna3J1ell4ZEhZQU5SSFJZclhRWkwxV21saHIzNnBQQ3Z4clBGdG5C?=
 =?utf-8?B?a0ZJRXQySmpkelQ4d1dtMko3cDNvNDhsamVPbVNPY2ZsY1ZYaDRQc3dnRjFu?=
 =?utf-8?B?RkJqaWxjdXJ2dURxTWpQanJwWkFaS0gxMkxBU0kxTUE3VHJSK0dveHRwMGRZ?=
 =?utf-8?B?bVFRcndobnBsRkkzdWdldzF1bFE4OENQMi90ZStKZ0JkTGhybGlGWHNVUE1E?=
 =?utf-8?B?UmYzRXlINW5JQXJrUHBYcHB4M0liRkZPQzlHQWtzOUJ0Z2RaRUtWM2l3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dExuRGlUdFdTUnZORlhWZ1Rma3Bwa1h2OFNBSTBGZWlMUGxHMHZnazdyVklz?=
 =?utf-8?B?ZjZGMXFzSkY4UXUzNUt1eU1FMXdaeGlSVzRRd3FJVklFSGdlNTIzMWpPQ1NJ?=
 =?utf-8?B?cDI4am1majkxc1JuRW9zU09rbFg0VlBaMmxzMEN0ZEhpcG9BL1Z3QnNXUndM?=
 =?utf-8?B?cnNkVUVaUlhwcmxyYjd4eFJSbnNyYlNzUzc4Zml0YkNIVndKL2M3cWY0aFJq?=
 =?utf-8?B?S1d0bGY5M1hXbzNnVDFRV0paU3dxRVp3VmtxWmVQb3JDcW9IbzQ4STBZRmdY?=
 =?utf-8?B?aVFXKzdRMGJlUnk2MUZoN0llOStaMlZUOHQ4bjEramtJSW9zOHFIVnl3cjUr?=
 =?utf-8?B?YkFxN2dmaGpvcFdkb3c1eFlqRWlnNHV1ZXREVFFrWERZdmoyMHhaSzY3TjNi?=
 =?utf-8?B?cFAxeXEyZThUNnhXZmNqZDdYdHkzOURKYUpJNm5ZL1VGVllpcU8rMHVCU2x0?=
 =?utf-8?B?ZmxncVF3ZktpQ2k3WlczRVI4bmt0SWphUkt2SDRobUhRNUNEWnJkakZDaTF2?=
 =?utf-8?B?VVZvc1FCa0JTaXVBM3NvdENmT3c2eHVIbEZ5bkpqQkRZQXRseGtWSmN4UVVl?=
 =?utf-8?B?RmxZcnpVa0FhZEZYdnBKa09yeXFFckNJeFF1SXRkeEtVSXNCTldlTDd4Yjdz?=
 =?utf-8?B?aXVjcWlZSFMrZ0RRN2tNYkxpSzBLdjNJd0J3VWc2QUE4amhLZzR4NlJIOXgx?=
 =?utf-8?B?bWkrUVdsak0zVjlLdnlPMnJGdktNZmxVNmo2ZFJFSGFncno3eWxQbUprRy85?=
 =?utf-8?B?U2cybENMK3VmRTMvakJJTUZWc0ZWZDhoK3NYQnRiMkRweWgxcjlOb1FMaXRM?=
 =?utf-8?B?N3hNWFArK0xWeXZJbzd2QzBlRFpYUExCdlpBYnFBUnRSbHNWQXBTT043WnRC?=
 =?utf-8?B?REpGSmgyV1RNaUpNaytqeS9VdVVOcGVhSnhaMW8wVVlmYm9WMk1XYzZpbzBy?=
 =?utf-8?B?Sm50OXJWcndxSGp0SkF3WEJnWXpkMXRhQ2MvRVQrOEsva0tTQmkxY05ETDhJ?=
 =?utf-8?B?aVFjRVlNMTNteTk4ZmhVd0ZWKzh0YjdKdnUzTFI4V0FnQVNhTlpZbm9KWGdx?=
 =?utf-8?B?dU9uUWVZV01nRWozY2prd0V5L1ExMjBUSElVeHdxOHk4ZlpJVUl5ZHY2bFhk?=
 =?utf-8?B?eng4TzJvcFlabGJlbUh0R0ZrVjc0T1ZOVzd1TkR1d21VS3h0ZWEyU01NWmJJ?=
 =?utf-8?B?Y0ZXUWNBOWthNzdkUko2YlRsaWg5cUlGU250TGI0WUpnMU9VT3hOSTA1NlhW?=
 =?utf-8?B?UmhOMktWa0lWY01Rb3RpMm1jWjFFWlBHVlhVTHRCWU5OcVQ5NjRyZ0xiaGpF?=
 =?utf-8?B?OFRpSFpEN0pWSjFIUkdZWVJiV3NSdk8wT3FzOWc4Wi9JSVBrTlU5Nkd1b0R0?=
 =?utf-8?B?cHZCS3hrRWwwZ2R0K1ZhclJtOUl1NWdzeGhjOW9rUGF6WlhybTBtbWErREVF?=
 =?utf-8?B?NklHRUxsYVQ1clREbjNoOVpqeFNpK1VRekFyeUVsMm1OYmlPRW5vMWtLeHZ3?=
 =?utf-8?B?WkM1emliS0NydmFQZ1B2TkhaUysxR2xCYkpDV3ZzVHpjM0RlcmtGejVPT2NY?=
 =?utf-8?B?RldjaVluS2RXMkF3VWllUWIyZ2E0KzZLNDN2NzJHeEpMdHNWSnk5RldHbVJE?=
 =?utf-8?B?ZVVoVWVtTEhKRUd2NDJTai9qUnpGa3ZvZVU2aXg4ZUI5aU9WNE14czF5c3oz?=
 =?utf-8?B?cGpKQS9ienV0cm9SRS9kdWYwL2J2NUJ1YTlzTytLNlorYis4MWZSdk5vcExB?=
 =?utf-8?B?eCtSbWdqclRUeXpwWlNTVlZkcGgzQzNFL0RVREdzMmdoUDlXbkNGSTU5a2Uy?=
 =?utf-8?B?dGt2eXJIV1FWOTEwMGRsT2hBdEk3M2FJZjhVTzhBV2hWWkRjeGRaUWZ5R25C?=
 =?utf-8?B?ZXBKc2ZtZCtoUXpma3FZSkJNcU9tOTJwQXA1RU85V0swMjFzc0Z3bHpDelFC?=
 =?utf-8?B?RzJEZzJWeFU0enZmdmx1UUFOaUJsdW5TNERXcDdnNnpHZko1emlTb255OEVn?=
 =?utf-8?B?WEdsVldqM2gwQkFFczFVYklYMzdnUU1kaGdYTGYwTk9MK1hhRG1Wc3RnK1RG?=
 =?utf-8?B?d1Z1R0hoT25nWDkyOHBqc3UzdThLclk5Z3crZ0dLOWdCb2I1cVFhQlRjVDRM?=
 =?utf-8?B?MDArU0NRNWhLRndXWnBJODNsdkRXV2V1cHdnczZKMzdNSnFvN2Z0WEhpbkVv?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8lYxE5DDVS0Vpono7wDwNE5TihuQxraLWufEUcqDkty7RNooTAfV7vkZHyLH2DgWl4CH+t4zs1L87t1BNjBIM8rUcweO9VYYeO4sU8+Giyqs/nsS6e2j+VpeoVieD+bU+NHZgQNnhy/VuNumX6z8d0FMiq4Db2I8J6ft1SrqmjEH+ODrIwYl2E5KHj6UMrYtlsCrXg+wEmldhJGINbe+K79FEJ/GUsWCCcjFN9UX1X0v9VgyC1MuzoOXB2CByRsrIWCvUYr4z02Zjf3qBnfRU+ikxXKPpr6Er3SUYuwgykPbFTi9yWppZn7vBBY/41cmeKXnoDGEl0DsAM+TnWTW36naBB2ucuDv7taBxF4ixGQ6AWFdy1D3L6R3nCxSxRgFYAU4kwXCVwjA5oZ0TLasxUkLJWHzkyx987oknEH6jey/N8VJNNDAW8sUjyE5I3GBYolMoJei8owy81H4OeGP8zTUtWdmFvDkD9+fAhAKUpznbZAACPug1BYmzWlzEXkb8Nodg23ieyTZafLrbu4aRgI6NXSObO/3WZjwTSGdmemuQFuXztCu2iSOsaMjyA/Q88a4AucSFZq4ZlTWcuRtXFUBPUb+WjIDtlVBKRiInTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5784d1-66f1-4d73-29a0-08dce4acd6a2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:43:36.7520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7m9TOIW8KfIBc/RiYONAraGKB733dG3wE5SdEOF/ATfir+ej77cNatsrTL1Eru5mKgArxw47FIE6lXh7p/vfqHegYkkigUbIKsg4LlODew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040136
X-Proofpoint-GUID: PkpJFKd4cvyQe0WCmOcPn4up5--n8xjj
X-Proofpoint-ORIG-GUID: PkpJFKd4cvyQe0WCmOcPn4up5--n8xjj

On 10/2/2024 1:51 PM, Jason Gunthorpe wrote:
> On Thu, Sep 26, 2024 at 06:53:47AM -0700, Steve Sistare wrote:
> 
>> +static int charge_current(unsigned long *npinned)
>> +{
>> +	struct iopt_pages tmp = {
>> +		.source_mm = current->mm,
>> +		.source_task = current->group_leader,
>> +		.source_user = current_user(),
>> +	};
>> +	unsigned int account_mode;
>> +	int rc;
> 
> This seems like it needs a bit more protection, we shouldn't be
> touching pages that are not set to current otherwise it will corrupt
> the counts during the uncharge?
> 
> Maybe the whole operation should fail if any areas are not owned by
> this process?

I don't follow.  In a typical scenario, none of the areas are owned by the
current process when IOMMU_IOAS_CHANGE_PROCESS is called.  We charge current
in one lump sum here using a fake iopt_pages, so no side effect on the real
areas.  Then we uncharge the previous owners area-by-area at the comment
"Uncharge the old one".

Also, need_charge_update() excludes areas that are already owned by the
current process, so we don't mess up current charges.

But perhaps I missed your point.

>> +	for (account_mode = 0; account_mode != IOPT_PAGES_ACCOUNT_MODE_NUM;
>> +	     account_mode++) {
>> +		if (!npinned[account_mode])
>> +			continue;
>> +
>> +		tmp.account_mode = account_mode;
>> +		rc = iopt_update_pinned(&tmp, npinned[account_mode], true,
>> +					NULL);
>> +		if (rc)
>> +			goto err_undo;
>> +	}
>> +	return 0;
>> +
>> +err_undo:
>> +	while (account_mode != 0) {
>> +		account_mode--;
> 
> Do we need to check:
> 
> 		if (!npinned[account_mode])
> 			continue;
> 
> To match the charging side?

No need functionally, as passing npages=0 to iopt_update_pinned is harmless,
but it does perform unnecessary locking and atomics.  Adding a check would
be more efficient, albeit in a less traveled error path.  I'll add it for
symmetry.

- Steve

>> +int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
>> +{
>> +	struct iommu_ioas_change_process *cmd = ucmd->cmd;
>> +	struct iommufd_ctx *ictx = ucmd->ictx;
>> +	unsigned long all_npinned[IOPT_PAGES_ACCOUNT_MODE_NUM] = {0, 0, 0};
> 
> Just use  "= {}"
> 
>> +	struct iommufd_ioas *ioas;
>> +	struct iopt_area *area;
>> +	struct iopt_pages *pages;
>> +	struct xarray ioas_list;
>> +	unsigned long index;
>> +	int rc;
>> +
>> +	if (cmd->__reserved)
>> +		return -EOPNOTSUPP;
>> +
>> +	xa_init(&ioas_list);
>> +	rc = iommufd_take_all_iova_rwsem(ictx, &ioas_list);
>> +	if (rc)
>> +		goto out_no_release;
>> +
>> +	for_each_ioas_area(&ioas_list, index, ioas, area)  {
>> +		if (area->pages->type != IOPT_ADDRESS_FILE) {
>> +			rc = -EINVAL;
>> +			goto out;
>> +		}
>> +	}
>> +
>> +	/*
>> +	 * Count last_pinned pages, then clear it to avoid double counting
>> +	 * if the same iopt_pages is visited multiple times in this loop.
>> +	 * Since we are under all the locks, npinned == last_npinned, so we
>> +	 * can easily restore last_npinned before we return.
>> +	 */
>> +	for_each_ioas_area(&ioas_list, index, ioas, area)  {
>> +		pages = area->pages;
>> +
>> +		if (need_charge_update(pages)) {
>> +			all_npinned[pages->account_mode] += pages->last_npinned;
>> +			pages->last_npinned = 0;
>> +		}
>> +	}
>> +
>> +	rc = charge_current(all_npinned);
>> +
>> +	if (rc) {
>> +		/* Charge failed.  Fix last_npinned and bail. */
>> +		for_each_ioas_area(&ioas_list, index, ioas, area)
>> +			area->pages->last_npinned = area->pages->npinned;
>> +		goto out;
>> +	}
>> +
>> +	for_each_ioas_area(&ioas_list, index, ioas, area) {
>> +		pages = area->pages;
>> +
>> +		/* Uncharge the old one (which also restores last_npinned) */
>> +		if (need_charge_update(pages))
>> +			iopt_update_pinned(pages, pages->npinned, false, NULL);
>> +
>> +		change_mm(pages);
>> +	}
>> +
>> +out:
>> +	iommufd_release_all_iova_rwsem(ictx, &ioas_list);
>> +
>> +out_no_release:
>> +	return rc;
> 
> Don't need this label
> 
> Jason

