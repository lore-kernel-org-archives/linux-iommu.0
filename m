Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EF51AA782
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306231; cv=fail; b=ZL1w0tqqMooy+tOkMSbfV9WpN7hsE4VfWZHTPRhbseN/MYq+cWLiBZyFY9v4MiaLQ96S3JddTJXE5H3NQ7fTUwMcSPGW8Bj0MFdvdm6P8Fzz8N1arc4Tbqy1LXqR4/JCw/gcg6otoQSxeByX+N4d6SwRe4M1Y38fNxk1AXYBrTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306231; c=relaxed/simple;
	bh=k5hEU/her1CV6eRIIR+PwHfTBJ3++sXg+P8UgktfL2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IoBTNdjZiz5l79zw8ZUfAizFl6RcYUGlVDx5t1LIwmb5t+0Stfa2IIWj9i2v8OqiGj9p++I8XROjIh0u5v/vowaLUS7Yd89W9GQxvtCsaFde1Ksd1tRu2wg8lUb3xLKP7MIBzSFUuNcS34AWi3XCrliRhsjxTnS8D2dmLzOR3p4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUW99AoX; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUW99AoX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVD8wnkiE7zdw0f5dQQEFpbfM7OO74tuPgqSpqzljKWq6j5rRrrF7DT0HHNa6wqa0hihAsmejqJ1qKs8lPlogqqPMF0/fi6ppJ2q/4Wq448oB2Ycj/St3zdnvaVhtpnUQ7cVm2O56xoqdax0bxEtG4d5uKIbgX0bGaECn9ccWkzd7zhgK2YdSDQYVaQM/WCHhgjK5deR2XsS9vaebzRxGKuY9uRrn2CaThUo3mgU9OIt/yZQ91SaeeDyT0cAfzC/JjCgbGVK1DTdM93EdmZeA1xLKzbfA6TLauW2Hmg1c+3r+EiiX0dOewOp4DJZBEhocuG98BMa1jQiSgcuYwyhLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFcZqxmzaYcYPxIzA55cN24PeUi7MOl+4hj/G0Wg7ps=;
 b=uHK4T+i44hI/tfV3bKKFB0q28zZBl7FZzM3mBoN/HqnX1AX6s+aVyhXDhcjIh5SpQCm92MXnxEXBbXLvzWsnqzKTkNbkWNFZZZL9PuXGjddZCmeta/sOmGVaC5qfP08MxFeuQGv4hmOIrI/H746xz+b7dbFdFCYSRudnxrNyvHecw34uhILPH44waDf4JTgk/SCqiTFpOl1FQ5cdq2L8am3DZPs/+DoiYu4l4RNlDhWDgTBHOKT/9cktt1IAG7AGWj3D+/S5I7yw5skBtAv4PeP61ibMt6uwpGQ9tfb4DX14a1HC4w24u6nFMQKEifHJLQTwsXj6ekIPkRCpDxOtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFcZqxmzaYcYPxIzA55cN24PeUi7MOl+4hj/G0Wg7ps=;
 b=YUW99AoXdhxuNZ9EAQG5BG16rhYDwN9iQ8Gc+ZuO3mg8VpbRomr9TmzqhbaH353Iiud6JRJ+9TgAc4eaJGXyQYGRn9l8Gm2k4m6US2bpmjwQolqNor+ajFa2o35QaBQq5kBt0dbONHtbuHzdCLNSi+xoHM+SyqBs8zdS1YOh13HWanxa2rTRhPkR+Jvh3uLFGERZeoIG8Fe+PhxbzA9bLc5TfxFU9ExZ/NXcBLK14FZ9H+A2Wi1WeRBBWZX1J4+tehNo/J93YvEwdgRjv5Iz2Noq7tmdUNr84+GFpOBWwcRIpomFotDdHjgkMgKJ1YPtOC2zcd9lkRV+GHg7cIdUaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 13:57:07 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 13:57:07 +0000
Date: Tue, 18 Mar 2025 10:57:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, joro@8bytes.org,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 03/21] iommu: Introduce a replace API for device pasid
Message-ID: <20250318135706.GV9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-4-yi.l.liu@intel.com>
 <20250318121941.GF9311@nvidia.com>
 <4cadf709-cd24-46f1-a0d7-029dfdc1842c@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cadf709-cd24-46f1-a0d7-029dfdc1842c@linux.intel.com>
X-ClientProxiedBy: BN9PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:408:f4::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: aec429cd-2965-4eb1-27bf-08dd6624c555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bC80Q3n2BRj/u7Ns/WsqpXH3TxczdPPt1B+szAm4FKHuVwC0dCiCJFnNkAc0?=
 =?us-ascii?Q?wwCkYYGWeyQkBI5VLu7wkyLQ1tl3CzG5xiPw+WfvcJuewSgBmt8r5bSfHcHi?=
 =?us-ascii?Q?PYEbqN/AC95QCPhfMIn7y0w0Qt92WOUhKneKEmttsHD5MzDCqSEWtEtHbVEg?=
 =?us-ascii?Q?c6DFHmLPQy/Rg5L4azQUmaqJn0mLfHMevX4Ksm34+g3jMhDgusDSNspp3Ec7?=
 =?us-ascii?Q?i6twnFVNwKUYgjp9iG0LmLmPSfKqS07S2842cnAtr0pkm4cjMjgXKfQ5wglB?=
 =?us-ascii?Q?R7mII1lJIwDCkIeBroH38DyYqmhN39f2vFAz1qzjlN6f7vXci+DrguQmfKPB?=
 =?us-ascii?Q?LfhlF8Zjciz+kiOzlX+lxbzvYKjXBwVbBkHyLyHYNE9uYoO21Cm5lHim33Vj?=
 =?us-ascii?Q?lyiM2PVGoPUvpJYbZUbc1fo8ivj8TyLWCRnSLGp5MfgHrlWtPTutqsZueHS1?=
 =?us-ascii?Q?RmZh9+jVneal2HDan7oUhdxYV1sOKC1k7x0GqyOk1yjUIiNnFsukovh/+KOP?=
 =?us-ascii?Q?QZvdQ5ID7cBLCQBPD0i8h0W8S0oNDpf03e74NVeBCGKIHSlBmkCRsHtRrL6X?=
 =?us-ascii?Q?/uplicg6rUnJzpIIZg1Pcf60MWO4gE7tzQXlsikfyH+ziaEQXYr6s+oDuO4V?=
 =?us-ascii?Q?rvCLE787c642oB4qGgzJVkqwOLN06LD4t0R/0CkehAr+bjaWzq3z5qvQ04xB?=
 =?us-ascii?Q?oXpZ+lMgKE05OScPiwUxQ+upkOIwxX9KKjzGqk05xxiGNZeWs9Zu3ISuztIi?=
 =?us-ascii?Q?PoTXS/Bv4wzBlUj2Dsz/QtXHAr2al50tLBOwueaAzTwct94jv5m1grutoSuW?=
 =?us-ascii?Q?odtama998kh+gqnRSRzthciO1V1NaAaq2hB8bZAyUHnUdHy681EVxE2lHCsr?=
 =?us-ascii?Q?RjQDMSfcn5CmyOOTI9mMIszuR5wv+lwWsFfMpnjXMIEs/cSC9xDxMk7x7tf7?=
 =?us-ascii?Q?a8W2HAisEfmH2Cb3Tj87+CctOodLL5kQAez6Kw2WdAocUq8e2zC15FkALMBi?=
 =?us-ascii?Q?7QIvwrh1x9ProZimf3a0rLWZ22fmaTO/gVWRMn7uUoFuc2vuETlnOVJruhTw?=
 =?us-ascii?Q?Rxh/MSbHriJcxcgWGiRGq3VUh9JvgNfYi0vNB3gS+lH5uasn8g5Nl9RwfGNk?=
 =?us-ascii?Q?O3SZwYmEEmInbBArqr4qlzB6f+bj4SxClAnsNFGzPrDT3vdc3cTtKUp9GhTX?=
 =?us-ascii?Q?1AANJipXqhVCpUoPm9aYlgmgT4FAoLoGZa6bpcnU2wKD0kKIwwMBQ9ripwd5?=
 =?us-ascii?Q?9FUBhmYieBEhbtTyHiQ4iMNdfV+pl4SQgOugiSROBLUuSSVrjMPd3H3wO1Jn?=
 =?us-ascii?Q?dMBRoIulKTeg3bzi1/vBpIV429X7mHcZA60Hex/JPVNxovbPaHVdTgBm6Ovt?=
 =?us-ascii?Q?P/mTicsLc6ObErPCOy0qXIgXKBjM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+SGi3+/lW8SFAPgYJzheCodvituIMN2BbSGym+RbVtTuLy/y+iT2QxvR3Od2?=
 =?us-ascii?Q?FP1Wr3BRghMdYtoXpcVPrzTrkOZAETIlf120QFq/+K4DxhQtgAQn1NgknlTT?=
 =?us-ascii?Q?SIJPNsdHaJ2WnswrbxX+OrfkIK1F2cqH0bJM7C9fAdG+i/qO8iGfS9HTKGNX?=
 =?us-ascii?Q?tHJjUoy9kc4+lr2CyMNt1BK+B4UXF1RvyxhHRBFq+nHuZwyGySUZ++xUYuRq?=
 =?us-ascii?Q?MeptEg8RzJaBvGL8Mh3ZmeMSukSqY6St0K5ceiYvrFDcIEp6NElul03Q3/he?=
 =?us-ascii?Q?VBpVFalMfSaRLhK6XBao6+a2O8gJkMDpgc6Gs+XAtuDub9gKEj2TWHzE6DPW?=
 =?us-ascii?Q?CWKt28zhXriwDx3YfSh4aG7IFY0EPIRUE8Dq6eQigjgo9ZQ29rQvwH976ZrL?=
 =?us-ascii?Q?5rKXWDmAIz3uK4oC8IiR7ehN9HRGr1j5fLPT5RHFish+wcKr9Gm2UpaTAMkr?=
 =?us-ascii?Q?8n3d21oRA2Td3bMBCYJ4rUL1ONW7mEOUc51UG7tErF25bLvJxpzKjQAceiG8?=
 =?us-ascii?Q?Dehl3DvYk9jrl0zoqUWQQ/V0gAX4dRxX2KTdb5CF1gSlUSo5W1McfQdGMFsx?=
 =?us-ascii?Q?N3KyGh4KttpB4rYVmLU+jzOekAuz3HBeZBd+Vn6hf3ovi3+uQ9JZiIKf1bNP?=
 =?us-ascii?Q?FR3J+pLBuwM6b4wSDG2Ke5sg2jNorelyMJTddvzVcBFZecBy2uZ76zOlIqOO?=
 =?us-ascii?Q?a3ZVF2ogYNGpNyycXA4943HsBan4Xs9191wh5CP9bhh7K7AVRbBFbXYmu0Mu?=
 =?us-ascii?Q?HsytWlUbQ8s7EyLLQM0i5EKH1p4JdwNSlS49fDxIuDv14OMYmz1EVsQWyumD?=
 =?us-ascii?Q?XHLSR3SCVwr/8XDudn7K6S1y2RGTzgPD8IeoTR6uVh96SdntK6A/rkgOXjYI?=
 =?us-ascii?Q?MsH5OpYxdnFgWa/WYQx5qLRASBo7rLRXIte8XK6qCv5aygf3rNK4+FGxgIje?=
 =?us-ascii?Q?w0R2YExBkGfnhG3r3TnAV9hG+PPCq4bFzMqwVneyJZQ83+nYjZdF/7z6eF5w?=
 =?us-ascii?Q?XDQVPMmD7ckBbWDHB5HtfdeS2kNkRQe7A5Cg9miR+kUCBB58E3lJr6wZm5b9?=
 =?us-ascii?Q?WKKKlDOKS4Z90ogCbMN4H686tpnVS+u6VGnih8NLaL9B5uZ9o/OeZBCKqGtu?=
 =?us-ascii?Q?nEpMKH5WjokqXq/ibskQ2sf/SSmhCGFkpG94S4cRoSO8h6oAqvpIfQnak8YP?=
 =?us-ascii?Q?tGti33/57ax8kuBMnrVY46n1bof9Kb6I1BhIELRrpYjLxwJx8eWE57LH9xD8?=
 =?us-ascii?Q?VDfqNz9Z0Re0bRgISj3FoAMEPKkTCSolOqIbEtAKcb2CYoks/lZsDhpxAPXn?=
 =?us-ascii?Q?8G4VWI0giTM/NfmRAq9qpCsBQ5Z8kiOi5azDD7o58RHNZaXc2caTfrtAYS6l?=
 =?us-ascii?Q?iU8ddbjTnOeLQErQyMqenGhhcmkjSlZOLPwUrCpgIeO0zHC5q3T8cAGn8AWk?=
 =?us-ascii?Q?MBU4IKGVxKdHe5q89q8Q8K5QNfg9jNqBLe2ckdXJbTr7ydLl45u0YZWVhLCD?=
 =?us-ascii?Q?NXpkPCrmX7Ud9xRctXJ5tKn7UoTYjbg0eY2nutetprgoUj5s/gtIHMLMO6aT?=
 =?us-ascii?Q?FIxP8tmWb1rP0GTH+0EfA5OLN2vQrVJxiHG+CSQ5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec429cd-2965-4eb1-27bf-08dd6624c555
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:57:07.3588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/ck/stsIicQGfd47vsMC+JyeZ2Q31rW9EbB18V3ZmiCVwGYlwHaBHVk3A14JUBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164

On Tue, Mar 18, 2025 at 09:50:20PM +0800, Baolu Lu wrote:
> > Maybe we need to give up on having the driver fence the PRI hidden
> > inside attach calls and directly add a new fault fencing op. Then the
> > core code can sequence the fencing as required to make all the error
> > cases work and the driver doesn't see the complexity?
> 
> Good suggestion. A new fault fencing op will make the code much simpler.
> Basically, iommu_replace_device_pasid() could be implemented like this:
> 
> - Replace the new domain on the hardware.
> - Store the new handle in the xarray.
> - Fence the PRI.
> 
> Before PRI fencing, the outstanding IOPFs might be routed through the
> new or old handle, but that doesn't matter, as we discussed before.
> After the PRI fencing, all IOPFs will use the new handle, and there will
> not be any UAF issues anymore.
> 
> Do I understand it right?

Yes

Jason
