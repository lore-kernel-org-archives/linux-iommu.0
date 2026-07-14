Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE537F00F
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028993; cv=fail; b=o/i93DweTfhBp+0D0/c9a7Wu5aDjV2E5zUxqIL+1M8Fvhcgwry58l59N15I/DohLqpHBaQcuOJ6m7r0Q/40rjZmWE2XskNzAdc6WxAV2Ogm+KyIFbC9w+mzBFPNy96xrD1lQQn77LQztA9ySm9RVH6Bk0CxTVHTtMoX7AESwBos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028993; c=relaxed/simple;
	bh=joDEgmfYazp9mve34xq//sJWn+glWNtEjeg+HMWUrMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ht6b8NBcRqLZ8183dZ8L3uKsjzd6CYM6wNXN3anAFsdfyGkx0H/zKOb0vnqpDwXe8jyntXfoke0uHllyJPcj6/KtlNK/ByvsxDUyp1YT3bdTiL5/wJ0C9bwZeHIAJ9JpXezxClStyI5q7LptuBiMVqNfuiHBzPYC4XOZxUEmmWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YF/NB1qC; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YF/NB1qC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=treIDgjC+SDYwwHAceK3OG2PgHGbM5oJlt18jV70DuhSUCuqd9CLiAc/CmteC7VDg886WWkt2RtFukcgeqBn669MhiQhqh1MHHSIOGQwpawWlKUWUN/k0nmoZuxXLuJeaj8ApwKPMt8yklYLGU3GlTEley20NpPqlhvGvxhBvCJxVG35+uGuAAhjvW5m8Pw6CGbzMvZBPmgsRLMM4oHelcEdRBLCmwY/nJX+kzGi2qhfN6qnflrbLTVb1QAv8L1Z33GSoM1IMmrv69CBgtg+8QuyQEsl0U2hAeQIbJYLcTMkhlNEwP2xpHQNus58foXj8IL9nPw6CGLFSWVrPEVaFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m22qjluLrkGiMUtthf964LzeC4fRYx+aEc3D2bvp7GI=;
 b=pWW/vZ/mzm8BQbNKHg13c/jLVPB+gRh1R+wvyoUHgwZS4noqphFCPHh4mnPNJIYuAk3J4pMwpEeDc9lrK5qnzkyI0/PqQId57veHmVSMDCy14aID591F9j6JNQj/E6wrnW+O5EEIcZkmnqg/5fbvI3T0JD4NgzrXfrFO6sEO4u/uy7CCt/kIJyaPqBvLEtk1YGBLCtC6jbUXzkxOK102omnn1Ix9LpIZcL61cArGKrX5JPiqFABrFPkqVIPDxBTnlXj+SlXB7e3vM74t09eYANl71h1NNAPk1KuoZbaPhmluMhp+W1VFcpH23zS6OFwfq917LY5tC8AZjJs5eRCl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m22qjluLrkGiMUtthf964LzeC4fRYx+aEc3D2bvp7GI=;
 b=YF/NB1qCW7gI+4jrT2lQ2aQMcxK8YVkI+RNtTXn5cLyIFK+rUKw1ioWJhliRsPrYQliO77k8F/qHt23DIuzT1lfFTJr0klfWS3C+wKFO0LnLuu867NXxP2ltl4njCS4bSbLBqhOuEtPuLVny0FJ1cnYFaAGdAPL/eYKkKEajmU48yRfNID8vEB+cSJN6qAGeGWpxOnQzY00y26a+2F+GpaCJH2+j/3HQfu/3jtN8N+3XeTIYxViawyc1en1AjQZ+G2dfLiptM4UeXI+X60TILOIlMhTDeyhRSbDWviD04gtSlTokaSREGHHY8IBaTlx36WVe8lgdRWtS3k9ebTAo/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7703.namprd12.prod.outlook.com (2603:10b6:8:130::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 11:36:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0202.014; Tue, 14 Jul 2026
 11:36:27 +0000
Date: Tue, 14 Jul 2026 08:36:26 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: weimin xiong <15927021679@163.com>
Cc: iommu@lists.linux.dev, baolu.lu@linux.intel.com,
	jean-philippe@linaro.org, xiongweimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH v2] iommu/virtio: Report faults via report_iommu_fault()
Message-ID: <20260714113626.GI674038@nvidia.com>
References: <20260713010442.331096-1-15927021679@163.com>
 <20260714020251.175824-1-15927021679@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714020251.175824-1-15927021679@163.com>
X-ClientProxiedBy: MN2PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:208:236::16) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7703:EE_
X-MS-Office365-Filtering-Correlation-Id: fd7dca0c-7251-4dd2-fe83-08dee19c2469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	3icoJT/Dl69auliKDZ0cXn3V5+XGg+Fo7XH6z/8esDxxOT0Gr/W4HKzT+0B/IgNz18yHeCPvZ3vBOBL55ylKhtxBStCEagYJQke5W+DMWXeQT+c/MV1sO6vYTIPekeKWJwRPTG8zIwRqPF4l5pgrhQVk1lr56dBv72lfQ3PESKf2zIdeBV4k2Ja/OxSQbGk3PtKPOCD43ZeqER5c9/Tp2cjrM0QRIYSjqJQkCGgvjFxeQ+TmWyb9Mz511EUegrWaRNmS2VBlKGa41+sLbZtz92ZRlQA1AGiyXZMpfBzy18m0qTHcd1hI2hdtuexJfdB7+c2MupLQzX+yDcO38sXTsNmrSAqiNb8i8Jwkzau+1rIu3yEYCuhVk98z1aE7Mox4srXC9sTDRMZ1RcwRAkzWONEABZvKBWE5P/i+/Q9/cb+khLFPUBt7ylFedJ8YvTdrOTp/cSzkVKj0kV7bGaOhKghAsPshHrhKYhEVOkSEeXYSuUYwqgjxoaSgNIhIVDWHNGW8b5r0uw0G5KiKNoDPwMmxmt1M3FGlgTISNV1vnAQBmmP7ZlOIN+fpTblnPZCJyx6ifE3waVg5ajqx6Hvby2iT8EwBiWqMExCElY5/EbDg0irrYjwy6WSbEs0iePOZilfIqk29BpwYQZydaelvPjNHiDOkZtssdaOTC/qbnAM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XMUnMgiolCZLBgmBB5zRzbjHZeJDqqtUvDOC1Bf6V8jYeScu/L1TPdc9YKPp?=
 =?us-ascii?Q?jPmRMVH0W/dCiOYkvTRTjhzEaGRZV+ALOZN5sU0WQX6v/M1cUWPDdoREGw3A?=
 =?us-ascii?Q?qso+zQqRwevrW7Dcef1YTgJTN4dBI78bIXnoA1jZhVX/i+Z3iLsjrK4pKFNs?=
 =?us-ascii?Q?Otgk8N5WD+b+dWMt3NZjclFqAnJeS1AmerSD55SGEn36X/qrXgVwDxk1G96Y?=
 =?us-ascii?Q?VbWc1yRFAyKJcqASVtTLu2AoklVaisN6rw2DcrdAZ+yNkF65yzlIUceCSLLZ?=
 =?us-ascii?Q?I3SirTSV0RGnInKD1g+fWYtAAKiqMillwG5SdhclWIRMhyNuUwcAUHpsU5od?=
 =?us-ascii?Q?/ECfbetv2pRCwNmdqg8V4ZOSibY4km9VD0UpOcjHnIGwkf5yzp06dnRU/+T6?=
 =?us-ascii?Q?3L2tFoP20k5bomBeS9PO9z7vptT01yjiRwCqN3cRdC7FNPaA03y3jQJPuWM6?=
 =?us-ascii?Q?7L5W3bFxZj1lb5WUQNLPtPSlrDdalIZeYSVprxxbLpEEckX3PAL7eaAzxqRQ?=
 =?us-ascii?Q?BHhVGvDxlAKk1T1DKTu3O8/xBEN2E3y9Bd7Rx+t/fSdIm4QQOtDaNQ3Cj2j+?=
 =?us-ascii?Q?PF0dM3W3yuveg5YpdSkLcAtP2a9JmrE1YmKsSUKPToahB6LaEWXakBt5CkuR?=
 =?us-ascii?Q?hWYSJsTXRj/tpvBR0S2Lddr9ubc7TtANuONEpzvKmNcvbOo83+JB0AU6i7sb?=
 =?us-ascii?Q?e3aY8ttITofjuZhyr4JE3QkGob3YeoFbH5o83RfHot5bUh9Aq9cPJds3sYes?=
 =?us-ascii?Q?Mj6TVMlG1GOb26SwAgudHELXLna8un7eV42BBFpV0ygfK5wsAKDhjmLhAlvv?=
 =?us-ascii?Q?RqBb0A2NIozdikPVuw3ZyPmHqRkWx2NkyV5pV4licWh+i975oWGHVKD5BQkC?=
 =?us-ascii?Q?kA1NPuQDTNKNtdNtjZKHUIERpd7D0ParadS95U0nAi8IkA7AzyQjmGnkFBxE?=
 =?us-ascii?Q?VSaQwYilgFp6Ie/lEOGqBqd8gHmPCiMkJt0Zio8mPKvW1U3Q2NnTl0t4j441?=
 =?us-ascii?Q?BxBG/gxfqce5nnu2RD+XhDre7NqS9qJ1sJDfAOBaJgfhGQKx4FOph70Qj9Ql?=
 =?us-ascii?Q?7VHsW8N02ypGbk82lRFGF94jGgPsG3zslLboO/3WDR0L00XYuDXvSW+BSTLJ?=
 =?us-ascii?Q?DDUsWHNXkvejsuheEYgtZeuYqveH2lRWXOmg3CCcd5yDnnx6GVExuNXELGSS?=
 =?us-ascii?Q?q8UaD37Sw9d99mLdDiiJVd0gXwZGRCfpqExDOFFmCtzDy3StP1Ir0/Si9Jq8?=
 =?us-ascii?Q?dlKl9xGd2k8MbWQk2TPEjhfmmxZPhvhSr68vp1jjYhyWpAj92psgZ1+5alNc?=
 =?us-ascii?Q?VlAamVoHJOy+CG8pTNbI9ekJKPSLDZiCTwzMWeYo9VG7yfTLx2VKHnZOhhkr?=
 =?us-ascii?Q?DiVKurakWnQxDYyxc8Q1BnDT1MLYz+fO+ixwcB2/xSCeFr9R2xmeky+NlT0r?=
 =?us-ascii?Q?4q88Qu/ho4DvTZIThkeHcNjazkNkCpxL48hILZ8AjV8MqK+E+94ZgVDxf+uY?=
 =?us-ascii?Q?h0KJDe77U84TWXICDt+RG19om3i/KSgpEpu70vHY8Ojrf0xsdXCvasFlwsEL?=
 =?us-ascii?Q?ukjyEKDx1MwsjzKr0GKOxCUbDkoSOeUJlaq72SpbWSPLYbYxCCVzT65MiRWw?=
 =?us-ascii?Q?tORGuzdXMd+sHj1mnPIBuhlqg+789m/T2EE536rAhAhrsa2meSi8QsvnnwJk?=
 =?us-ascii?Q?0U4c/eAddOgmqYZ8arCvffd2Ffc31LYQV6mkWEV4uLOTtLJy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7dca0c-7251-4dd2-fe83-08dee19c2469
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:36:27.7289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zONdhwvyfNXkaf97Gfb4RxJ0jkXL2MNnT5RIZO0H69hG12ypsraRNk4MMEGxeovb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7703

On Tue, Jul 14, 2026 at 10:02:51AM +0800, weimin xiong wrote:
> From: xiongweimin <xiongweimin@kylinos.cn>
> 
> Fault events currently only print a ratelimited error with the endpoint
> ID. Drivers that registered a domain fault handler with
> iommu_set_fault_handler() cannot react.

IDK get it, you said you were going to drop this and you resent it?

Still no.

Jason
