Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4EE2AE8B
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 11:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744371944; cv=fail; b=aD7p1DRUqQlTtfSYF5fl8SqQAGcHFoqj3ECsQqm3vwfuzWs2rL1XNhMp7q3iPkfYMSOWQ0cFPJQus1rgEEa42bVPAQSyP1Y16RdmU0ytIKDa3Ujuk7qUQIp907TnhxN/RjapTU4ZznX0h7n9xqNGkhN/wxN0AS2w387v47p/ZbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744371944; c=relaxed/simple;
	bh=LxvEDhYZoynaoVV4DjBPQYC2w0xrrdNpZUi/4WQNRpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dHkG4wqPFdBsXSe45mlM0MJtEnDzqxsJGq6qQEmuJJIfQ8lhfVJpqup4F8PYIIL0W4lfkB70Py9gaHPeyreB/H4FmcbTqFaCN0th7eptwTVx0nXfulLImet4UWQMeaMju+lMAgHAfUANiD4IfgnEyBB5p2cqziBNoALYMGPZWdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N5xEVh/R; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N5xEVh/R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=etDkUdsC9Lyeixgk1Y9plxYIuyEUKlYPEfMmoret+HJaSOGO3UkQlBkXiVHS6y3vHRwSQqz5Wo28Hte4a7MlKDiYaZAr+yzrt6aLhd2xNPdxZJo8CPrJ0cCtxPR5WIYbgmgeXIkl4w1ilpK60REG0nls9gzFQxOX8djhbpTq8g5mqCD4t1hlPdxMQqolwF5EGlxNpcKqFdRM4Os1eZciJFcyQjkX+nJayL2ZKhu1OTJdRehLDJwFa2S/tIdkK73QNZyiToXoMofvkOPkgErJSzGuMNz1bTnu0RqbthYiwCCkimTzxe2EJ8JJW84jeRPY6XeUoiZoDysAnn52ShWV+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88+e+F2LrVwnCt32PRioIVYqKmMCQdJ/3CH7dz6hOxg=;
 b=KXsCtRPauTHE2UN4dBAncV6hRI/5EZN7uHAV9dtD4utSLkihbfHIjNhXq4vXtqEubebbYCB6ZZAURakaXH7YE8HQpHx4czCcJtK+BhUpm83vtybMAPorNDm3qqY3i88fdQNoAsYf+Pca4taivN1/ZxGOTVin/BPjrflN1tyureQlm5puv01kXYNh4Q9NpZQ1tdKtok+3o0BFXO2mK2T9uu9sapd505da3E3DUmaIIZqS3w8RklFfAhAbTTD5gCOm4m+XGuvzrptlM3QKuoKe5Ln6/Mjc7b3CX+g/4+tASfUK1kQ2xUCya033S6VDpMDenDU9LXpJOfE4obC22QFd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88+e+F2LrVwnCt32PRioIVYqKmMCQdJ/3CH7dz6hOxg=;
 b=N5xEVh/ReENaHNL1S4H1d9kOrvl/gAHwRXqE7TZnrQeYCVH49aC1g60gysbCvxUJXuQZqBFrWTavZeqjTfxOKQJd943hTNMXMG2HFF4m8YZG9QJvzyJCWS9ofJAGmiG9zgZnFrnFY6qNj0PuwVgRRfsU6bdGS1XLwtMLIjug/MbMc3jEKmwGpgjfAa+kAxTPLfOv56TYf7HrpJMcwFoLsL21eiErcNfmYheWn2IoLBD99gAGU/s7Ao0HeDPgF3Qgc7r1CVGOTTBq32QzYasJSluWLWC7Pk/5izYFZJ5aj4W6CPi8md7hnQeMu+78WFo6eDEKxnaQk/DQryzysX+VsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY8PR12MB9035.namprd12.prod.outlook.com (2603:10b6:930:77::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 11:45:37 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Fri, 11 Apr 2025
 11:45:37 +0000
Date: Fri, 11 Apr 2025 08:45:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	jsnitsel@redhat.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow stream table to have nodes with
 the same ID
Message-ID: <20250411114536.GB8423@nvidia.com>
References: <20250411044706.356395-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411044706.356395-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0763.namprd03.prod.outlook.com
 (2603:10b6:408:13a::18) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY8PR12MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c70fc2-daaa-4b42-e63d-08dd78ee6078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FHCrzMQVHEqa4WQdzqYZ+xPTh2V0wHTRBvlOKc3D+UP0csA+1uMBufsE+JyU?=
 =?us-ascii?Q?12UrvzurKz8VzsJ+SYpGHev4rR57TQkFxNkvH0+InxMXsBpWofVuwd52Lyyl?=
 =?us-ascii?Q?VasrqMe00xGVhJcAf/pBPm5ZuOliSv8fVDD89qesrMCwOHQDkYqAHJpbs/ga?=
 =?us-ascii?Q?eTA7uMtI57eJlpn4hU8kXwtyIbUQcA2F6kEME551gB7r7i9mFZxTKCAzZu/8?=
 =?us-ascii?Q?zxTsmIZ3V/YVtRHyHdIKq7CDOFvl0JwVMnELEggH2OJt7A72kC5qDPN5uMO3?=
 =?us-ascii?Q?yhUIuVJdnhcpCMZ3ZKNv5fOeVB9zZdBxSelpMePkPpz+rJeh42Wdm/NnzBto?=
 =?us-ascii?Q?uGOe96C1iAIKmI7JLPc0UyGBDHTkhlXQaVMmhbPBHaL06/0/ALr6A8ywo421?=
 =?us-ascii?Q?LEUu6UaHQXNwIEOZZoTSElo6r/SkbUEe1M/1nxnavumDwxEgrUS81I5HzGtt?=
 =?us-ascii?Q?e5fr6XBgQv1TRLXDbk/wUAj4H0eY5dl28SQCGpyxeBLFZY8dn5fxK6M0+DRO?=
 =?us-ascii?Q?EHwGCmCJuZWi9IA6R9XRsmmGy2WII6ompBS2Sh0wJgm6G2w5r3uJlLA0mKm2?=
 =?us-ascii?Q?k5/9pFeSo7YUh2vl+6RTxNxBsVUXWSLQwKPIIAM1XOffNdmZlMVBfEjnAEIu?=
 =?us-ascii?Q?i3CU/m+Bx9Cs/vXhvzO3pXTGqPhmdkP/g/bgVFbiMvZCVpmnwGcw6xPZorsL?=
 =?us-ascii?Q?StUOleilNAGqreD+nmi9DFkQlScpeyJA3biqEailBjSjmUthwecjvuNext6z?=
 =?us-ascii?Q?545WLxK7klGUQWNqywSTFDpM+DOL3V6UvFOjjsFAUV5lb1mCG7UwFGRvsVZs?=
 =?us-ascii?Q?5AmY+M9SK5/mdX3XqMVCNhFY6COHrfrsCEFBVpVKXbaQVFWi44vRDcnFohnd?=
 =?us-ascii?Q?II3+QSkLIqiwUWH9eyN3rieIIvXBCBsWY8TiVRfbYMLJ3qfH/CrPCxV3K7Ai?=
 =?us-ascii?Q?FCDbbwmuFN4MF5iS/jAACmk1mo4VgtQX40uMInYUt3TErklkgI+Tb6uYXeJy?=
 =?us-ascii?Q?lz0o5HKgqpJrynA1OtlaZ4vNakDta3/9/pQUcgPP6FTu1l3a67ecsgeScZ1X?=
 =?us-ascii?Q?6O5MY2mV1H5KgA83OeHBqbjAFh8aFhKl+BUtCHCfSPcZHsvTEX/j9B1QnGof?=
 =?us-ascii?Q?gw4z3Ai23tko4/1dKVbXsCD/naP86Of2gjmQgpPMqvi4SKU6mMt0bh7wHzb4?=
 =?us-ascii?Q?k8uaem7uZA/TQyCEHV1PNWZyJ3phllj68vsj9BihLK5g93abQSLn45d2QvDE?=
 =?us-ascii?Q?cRi3kmyMt7R+H6db/SF1kBviluWu4J5adTUP8QFv7QcWF857t6/in/BICjBe?=
 =?us-ascii?Q?Gzr2UxcozsuLblBQWOWyT+ZMTloqjJQuSRgwgQuvLgO/ipkZ+9l3AiZcEIW/?=
 =?us-ascii?Q?Tg7pKyxQd+QqG/Kq4tgQdcNI4aIH26I2KcG/FCE6XycG6U16I7Yg6GG22k3Z?=
 =?us-ascii?Q?x0VxlqXhBlA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aS/ETBv+16/GmhCPNHEqc+op3hxbEtpVE5mZbz6XFWc9Rd4oLfQSjtfh+aWv?=
 =?us-ascii?Q?Z6DFAPUFpQgqSR3NsFn46eRKT8R08x//8fd9j0trIl+42+NlpjyxCUF7vdEh?=
 =?us-ascii?Q?8VLWu46EZIlhqcfsnzt0oYH24yaVHfmVWGGFBTukZr9JjYBR4f4gNmrnAT3W?=
 =?us-ascii?Q?piT+grEigSCk+KtoccPf6YnqE2mDe1nWFpl8dcbDpylHEVEnZuXP8faYz8SR?=
 =?us-ascii?Q?KtERXhqtbtUUw1rnHKTuHVeu9d4U6YclULilVkZDX0I4ld4YaDT5xPoyt/m6?=
 =?us-ascii?Q?TP2OWq0feTB5RTQvwz90yLutpcryCu8CL6IPiwm4yUmH0BwGef7H0rrlfNPC?=
 =?us-ascii?Q?KHtH138SkjxAInIkPVuOXwCMcnU41d1fCczNffCUlrqDpXFox5o9fNp4LkRG?=
 =?us-ascii?Q?sCIeTTWdwIZ9ZvEPZVOvZP+LBoI90KpAaCX6qC9hEwr4iNleGnHYcAKSHTga?=
 =?us-ascii?Q?Iat6sUt+qlEVanBYqN8MBlY7Y9ukC9SCusOi49VA+IlmEhIocXbp6WjAyu7P?=
 =?us-ascii?Q?yYP2Yhr8u4X35ZiGGPOpZo3IWsbaOqAMNX4r4BBXvTaXmXGSowba/BKJ4xtN?=
 =?us-ascii?Q?yPGsHiJK6GQBCkAanjcW550cwjxQQrt8GEYIoVtb0sjD8DTvuXoB2O7TBsAb?=
 =?us-ascii?Q?GaQbBCxgaju10+xtXuMeUA017FOopE0u+BogP9IhYU9IBX7qGGomOlqld+7j?=
 =?us-ascii?Q?2bmHm2IoURHV4eat/g3QhoVaqRAYurv2JaG63u22WTklPWiixgl5QYTPM8lN?=
 =?us-ascii?Q?fuDC9SFNwpZxjupYIYnLy9dB/8JWBGnknJdnU/HxB+msvkLQLL4mz9/A5TIU?=
 =?us-ascii?Q?YZoDaTHoUrfA/OXVbb23cP5R3KsQ+72w3XX5WLog5btIg9VDBf0duoUfRBFq?=
 =?us-ascii?Q?cbFCduucDdJL9dr2NmO6BSVJ7i+q+kc8shMPbfygFN2VCyvqxa1INUKN5fUO?=
 =?us-ascii?Q?6TDo+ju1Toue+HdRJ8nS4cHlpcaOKjhB9LgG7YHx32AwiyWTj3g4ffo0BBll?=
 =?us-ascii?Q?M88aRCRszSPpgN2PX2Q810aUAIJKFTRYIQ7NySHuDK/ITW6f3+T6Psgc2WR0?=
 =?us-ascii?Q?l+KhLts7rFXFb+yT9DK41qtcWZXmIsayXCbYA5qhVOP0aqKqKU1Se8GJex1q?=
 =?us-ascii?Q?hv2ay0kg7RbClkpsyFfIqpOGiYD8x5eSHRUNP4Zis2VUuI/mA325lM8zkXHn?=
 =?us-ascii?Q?3MZ+VC/A8U0SsNvDDqgJ4W63XeGEuezgGlsT0jXIb1can9xUbQZJsWObPEQu?=
 =?us-ascii?Q?uGwGfCbBJVeEJu8ySQoeXapOg91iqilsIKt2NmHbkc6/pkTqZqzCfi1bXN8b?=
 =?us-ascii?Q?V2MbNItuHE+8yDyevRris66sPcgNsYeHBZALUTgC+DCqH/kUAD4r0CgWhBQD?=
 =?us-ascii?Q?MAQ3vUz9Y+SaMDmDArtz0Ie9xkahHjxBHZKK3CSWoVYmiqrT4xvfDZm5mVym?=
 =?us-ascii?Q?dFS1ckY9/gQs4A0v93vb7n64puGTjafbyfDXy99X7AdioXcIlKAAwF+3UzPQ?=
 =?us-ascii?Q?edLyHDDbEghm4nocijW3jg0dmvJjIdOndyJa/OPjJ3huWjCt6P3oDJEPk2wP?=
 =?us-ascii?Q?QIa+y5BtrZXmszH6gRYFHYt3LB645pu99UXcSlFw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c70fc2-daaa-4b42-e63d-08dd78ee6078
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 11:45:37.5185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXgM6jtFmqq2waQBOZjQp3p0EZgGJHOSRgwqkN7Rjc3oOLC+j7k/+aRY9lw6oLsZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9035

On Thu, Apr 10, 2025 at 09:47:06PM -0700, Nicolin Chen wrote:
> Change the arm_smmu_streams_cmp_node() to allow the stream table to hold
> multiple nodes with the same Stream ID. Meanwhile, the reverse lookup from
> the Stream ID to a device pointer will have to be broken, i.e. the eventq
> handler will no longer find the device with a Stream ID in such cases.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 31 +++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)

This should go to rc, also a fixes line is probably something like:

Fixes: cdf315f907d4 ("iommu/arm-smmu-v3: Maintain a SID->device structure")

Since it has been broken for a while, it just didn't become critical
until probe started failing in v6.15-rc1

Jason
