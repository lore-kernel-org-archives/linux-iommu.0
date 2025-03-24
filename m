Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9B817E0
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855347; cv=fail; b=UeRJcpbRsEZdWuXzbQcs650oAByBZIiO6kBMK9MeQEOgX+rdUwvYMYlK0If1UeZCGaoCFygJ3XSD/AxB/fODOv2fKZE4K6+Rb11Kz/CkPm283uppVhSyEa+330+aTJ199i5OTD71B8cSfmPQcGRcCK6PN7VHk9CiC+YiG/Xudzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855347; c=relaxed/simple;
	bh=MzSyc2kPSc3kcxc86uINe/apJHqa6qELIUrHRvc++ws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HzwVap0rflVwGe0lQ0f3TOxKWkpNFFGydfh304bTbpD38hBcmMm0zxPS5YPjYaZ4MxXMI1+Z5SMTDWOHS4Ao2NVYxSBIZymBvnCgmZ70BdjpwtdVf65UuS+CMTqa1Cl2FBd1IMjbCUEijcbyFIYBZJ96q5KbaY6Xw5OkWFWNDnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qrDJ9oj9; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qrDJ9oj9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hrSO3t1jfqX5KwR6WUR5qwyqCSj81jCDPgmcoZOKto+MEmY11FHF5wz1d6cTD0tGjeHYqRKop2YNNw1yPohIsuueq/1edQYlnyAXYx83za4tOXYFxr0RIrCMpbYMEKgctP1oG8knf4UmNNpTu3j0v/CK7tzQiJq1lsxMYoNs25egL1W3h5bCW/0/Hj/Yg0LbAfIJQz2x/huFAeWTDPpHTFxR5ifC6NhPGN+iv5A9HgVXe5KNebJHVXU1NrJvUzq+Ymg/SOtnsTF9QeZ0grias6t/T2Hu2kevUntaK7JFQqmXKeeFM2+ZI64MNtiKRmgYP1kJPBitUfiSCLxa2rlwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MzSyc2kPSc3kcxc86uINe/apJHqa6qELIUrHRvc++ws=;
 b=xn2vScrcgjF6cK5B6t/U8zLb1ISo2EnhE814ng5eTbuP+WWzFCTWpgUi0qmFz5kPLg9+4IEHE8eQLQrBvfxeUJToNJ7pEqmWcGN4Vhz7KJn5sboOXXIFxSjcPzXtR7wEf1psEM8NSCtxhW6BRZiv0h7JrkfHsnS/rndX4qXSmF7icSDBO7zXfIjpZY2XpIo1fBNtoxZmtLzO3da4MyR7+7olIR6rHis9pRLCzLAOT9FEKSKd0zYyIx6+wzqsMZvWT4Rw5UW1hoBua9YT5/BxE12sFMa6L0P/LM543U6EL77SzYsGcaIlQnOL+Dn91YdSplOg7Ovz4ZQVU0bDn/z45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MzSyc2kPSc3kcxc86uINe/apJHqa6qELIUrHRvc++ws=;
 b=qrDJ9oj9VNnkUU8nQNZSzrWAwLFNZWxLGCQAQnWdykEXt47csrVk1ZJVdk7+PIuWsAqu6/O/5zD/KleKNdSCEADwnePIOvpJ5g8iEximdn/4ft16KpgWhksbhaE8Y6gkDjbMmfgkrv380/iTkfh9m0S33Y+KNbQQ+NuQEecCBHBbQ4d11xmUrWBF/tLtj3oLK9cEoire1Fk27Hh5TYpoIYbdvUWN9VubOjmqkomU8AwNfuRi8YGA97lhhWDRud+RYipc4P2bwbPnm+ltrQXNO7HCoSmhXveWYSHJXXXC8UaZtKE6rgcDIaBt3k5M4OCtA21pcJsldStsJe7YBLI8QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 22:29:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 22:29:02 +0000
Date: Mon, 24 Mar 2025 19:29:00 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Nathan Chancellor <nathan@kernel.org>, kevin.tian@intel.com,
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <Z+HcrI/rEoU9vNT6@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
 <Z+GK98/VSvYl518j@nvidia.com>
 <Z+GOkl21ZLtE3B/e@nvidia.com>
 <20250324170743.GA1339275@ax162>
 <Z+G67avxHQt5L+62@nvidia.com>
 <20250324204352.GA2734321@ax162>
 <Z+HQ2QkitMPVAtmc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z+HQ2QkitMPVAtmc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:208:32e::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe69ce5-bd46-4046-a53d-08dd6b234778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SRLvaerjgONaads2VbtctgqXnuMIOUZ/P2qMu3FlmtWijzzNDV9P82JVgwgr?=
 =?us-ascii?Q?PyPw/5PRHYsIV1tYhAmLizA7rcxzHT98lQAnUro+xCt57RBsNyIMnB/PM/yI?=
 =?us-ascii?Q?esan/8Ny+mU5BDv4pmZFG02EB3SfG835Y039sT/whETK9gLWGfcw1J/p/utC?=
 =?us-ascii?Q?ihg/4fBrQmM9D4sSEo7BJEyGMOVq/kita5bOC2Oyn3lps5aDuxGiJoeXk5rB?=
 =?us-ascii?Q?6uHWcYWZ6BtofQm2uKP1WjG1t3170kwkdl8vnjSF20mLmJw12cVe1kEzLqWh?=
 =?us-ascii?Q?yEhc9z4rUJjiC3F0fYmIDaZPuxv31jZIHysGOvuRQFKLL7iib4dWlHy3SBQl?=
 =?us-ascii?Q?7mOWLK58bN8KLk9kfhYE2yYv5ft5GxWNqfR7yc0NMZwY/HuCNEX+ZisULEw2?=
 =?us-ascii?Q?PUZxGkQ6THbboStfKw4HXisAwa9uIfO20M/099qSB1GiaiP3IQ+iMj53ydeO?=
 =?us-ascii?Q?LT0KANi775P2gEAo91JXVFxrYmJp8rX+ZFOK1g3mLkdj4cJK3scn8Jkku0r2?=
 =?us-ascii?Q?j4iez7LVavsf8vMXQkihUbf/lxjiQ7g7RILmi0DwKaFb7mZBhXaLoLdFvRl/?=
 =?us-ascii?Q?s4SKQlx6wqCyVd1+km/j0iNVYNu1gq1NkdCUz7QBSz9x/9/aTJ4DuSaHbSd4?=
 =?us-ascii?Q?8K3xQXGvYzZQ4rcxXJH5bsjD2iq+/Op7sWUT+vucg9xr3n7vfuE63zejUCtP?=
 =?us-ascii?Q?AqIgqbF4aizROWaMCVH+YyDoo49jDC231m/yadG+q7Jh4l7pjvGuk244wzoq?=
 =?us-ascii?Q?12BSCodSpYdj0KF6mP1323J64oUbP3XBJwIAiD1Q6aX6DXCzK/nYXS6/5cy4?=
 =?us-ascii?Q?8kv6bgAsh4BNhIFbMwa+Rnf9wfQiLPFaUlQngux0yrbTWHOGbgkggg3dhTZ/?=
 =?us-ascii?Q?s1xaIl/6fljNRYlxhA8enuDcBSgY+kioiPdWvrP1AgBQNerGRlI98Vz9qtFY?=
 =?us-ascii?Q?4+zwVV4kWgrk8BODqJX7CbI4O4BVAYZZtccGDuXnZ2TSHa4AC9Tz+KKwtviP?=
 =?us-ascii?Q?ki/bQ9YeJnhvMIMESwJysG+Z3K30DN5TriOo2Hyi5XKTGUefXuz4WasbbHaI?=
 =?us-ascii?Q?iAtl5RuiP0uXHCids8Gdy5PvwNppdtyGiUwsMTC5et1XnzqkJvvsG/F5gv4g?=
 =?us-ascii?Q?4VEl4CtkxjBORSYJW1o8D/+pEwvgFDkz/p3LOzC71WsqtnLV0rsWoK2MITW8?=
 =?us-ascii?Q?M3Z7mZKp30N7BJ1wa4oGN9QTFbI2cWzj7WE9dxetd+31Q1N921D32aNwvV/d?=
 =?us-ascii?Q?TPNKnecgOfGd0Y5fm2eOpwpwd35dOUAVeInLAZgc1gKOi+r75yc1lPUyLnwk?=
 =?us-ascii?Q?HQw3oDdFlBdHjtDt9Og/TSKramIU+qe+wIzhaydIoeoYR1kb0u/8T+1wo/me?=
 =?us-ascii?Q?ry9xQzScrrvSaCxVp8A7avXLn5UNHbv9eRmj1Kn7Qlt9U4q+Al7cI6Y2HeKs?=
 =?us-ascii?Q?jyzmvI7im0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?etqoMrpSkxXlG+UhHg+IKIvSKt3Lt3fGvvW2gE3SDtuDHlxgYdH3eyeyzGVd?=
 =?us-ascii?Q?p2myNKViOKe18f4XIlRQiTLVnHXT6bxIddGbt/x6VocTQGFPJFEIlrHqkd1b?=
 =?us-ascii?Q?gnd4WvoF4r1HZ8CJJBSoyyr3gQKOmE+UEQ1Gox88/eUM0+XMW3yGwb3Y5w3e?=
 =?us-ascii?Q?j6aTG+rzTuveFF1lNAASq2LnQVhCEXcZr2o5wOZxtelhYEtwDM19/fSAy1F8?=
 =?us-ascii?Q?Wzwn8boC6A25TYUTkJkvozUzJzB3M3gjC7dhcqE8SVFZKMzg9LPE/ZbrZkQp?=
 =?us-ascii?Q?KFAMngBvuuTVKofA4qP2u2oDyr+iiw9s266nKvw77WDS5bucIQOHuB/6ZgY4?=
 =?us-ascii?Q?4wAdHhlN2db9yNqlOsdgKodYPo0+pRt0xFZYqESZDQQdu5e/VRpQZpjXXYjY?=
 =?us-ascii?Q?GgWy7USCyUr6+J30hywYzTDTXFaIPlFuWqe+cK5Zf3vXemTgnbqJ5XZDCErW?=
 =?us-ascii?Q?xOADodHdHwUi8BsoWZFRmbVdHXCAd7R5/LTp5KleHwSJCEb45izqKas9V3i8?=
 =?us-ascii?Q?8JmlNLdYhYfkhyhgjmj+jlrQml1iMS3oJazymzrWnYkGEqoorOuaRsM0dcxm?=
 =?us-ascii?Q?v8/TE/RAWP5XhKaHXgJMYLlsWDRB9f6npMlM/xanCeeZAnDf267mUJ7giQcl?=
 =?us-ascii?Q?NfETe/ay4Jv5jBfxBwd37LQ4ilEyjr4dWv4b/PtsyeCFW60B9wEHSdiT3awH?=
 =?us-ascii?Q?nvO3ITugOXvUac3mMcW4UO2Ds6iYUg9sE8MysHXD5uVRhmui2V2R9qG/26ln?=
 =?us-ascii?Q?fMUireOjdyov9SPOAoiN9Xb7/ecjjSdDW366j1sWWfyyqGPmQLTvOQmyTiHh?=
 =?us-ascii?Q?Mz1+i0WrWk6lf4ndt+TtataeuHY4orVyF9K3kLBq3mP7uGkFWKxGaY41LvC0?=
 =?us-ascii?Q?u+KJnAtWuz5nMSG1e/LLCGA2spicplKPZGg9J02XmXsnkMPksg2IfkSaD4s3?=
 =?us-ascii?Q?Jx8HYpmh+kuJR1LDl1zwODa4e6N95lzLsXIm2044izaX1Zhx76WLQPV+x4mo?=
 =?us-ascii?Q?5t9IXuXTIRDTyOz42e+LPNY+jrTNICGQtNNcp52BIJf23q7KGqe6cIpvlF7t?=
 =?us-ascii?Q?bbdm5OCez6NxNmPh2ApGkNVrOUkPWSzVYopCf8+LdX1lIy6WfRi8KKL33bsB?=
 =?us-ascii?Q?84PFs3v9KGY6zRcJsNu8FkvWDLBFUUeFr0F9RBJFexHqxC0aeADlRrup3v+b?=
 =?us-ascii?Q?pkAFOFKbk7GRwOMPinnm1fd5iAUGu/PRgjUjNhaTcvEfG4JJGWc0OA2eglK0?=
 =?us-ascii?Q?O1rWQkxVFxa4jESQGGUF5w7kufLtJkEW64tWfA2OMNbs/Xhl/Ct/9ncLq+Et?=
 =?us-ascii?Q?Djg8a7Dx3Zcve6wk64hK3vl1h6MmAqI8uDuQqSyZ/NalFflXjS9ICe6oW0Ku?=
 =?us-ascii?Q?t9uUPrYmJ9HDnbP5tqjkUI8NBYTHg1vyzGSayD4Zho1CkLHvQX7xgGyW5nzS?=
 =?us-ascii?Q?+1/P8nUsAOPQ8I7iSCFrzaV37TGGqcHJ/w37zhS43mHNR0WSigTl1GRlK13p?=
 =?us-ascii?Q?zYm9TSgiMp9hy6K59YaHMME8YqPMqdwMhD/iYkJQCybsy7msfb4MkSQQJdTW?=
 =?us-ascii?Q?0+DdPunt+zQqw1HNn1A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe69ce5-bd46-4046-a53d-08dd6b234778
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 22:29:02.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98YRtgwXpyd1nk0taJBl4/fm9uYxJJ0gLuRFmd2vb6cIi+7jEAjKn0W84XEfL1cR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

On Mon, Mar 24, 2025 at 02:38:33PM -0700, Nicolin Chen wrote:

> My feeling is that we should just let all other cases return 0
> like the previous function did, as this seems to be commonly on
> the IRQ allocation path that shouldn't fail like this. E.g. if
> we fail a blocked domain, would it retry switching domains?

I don't know, I think if the interrupt driver is calling this function
it knows the MSI is translated by the iommu and if the iommu is set to
something like blocked then it really should fail rather than silently
not work. Same for a paging domain without any kind of sw_msi route.

So, I'm feeling like we should check for identity and still fail the
other cases?

Can you send another version of the series with this and Arnd's two
fixes integrated?

Thanks,
Jason
