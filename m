Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794609413;
	b=286Gas9YPwuvykb3spRAl/Fz6gcg3OrVylycJsd/03z2mrayZoGtSSHyi5j+rIi/TQ3y
	 aHVKi3Gfoo7uxX1pKkwnd38pMXzpzf8vOXuouvn3vF6WFaWepz58Qmq+MgreocAnmdI8x
	 MJbQ3hF1iTwWteIWguMiesy2Pfr31kLWCjZJ1UG5xS4EsnIZ5AyFS4a0f6DkwTnBZHZN3
	 bkv4yutZXVbHz3fZK4UY73mysfpYjeO6hypBIupkq8IKQ2bUapnqzyKXwzC/UcsSDbpId
	 nDVY0lUZitfwTokQGdhdKOZUVGxpbHB7ZxusoczWet+Nq1zyd/QBnk9rtFm8mN3yJuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=ctb2wJ/yXpcdJ3rik1SgHnI4UAQ1RQpon6YHh268F0I=;
	b=4Trl7lmBgvx6Dlt0k4awnW6ckxjO1Dzw5TbAoPRzics/b7YmYwRV7UIjwZ5BSbZWhvUX
	 NDCE4QNmIqAOGKlOCXoPWuXEXvGKocQsn4yI1KMUZ+8sshV0Jztd51UdljJgp+1sLmvDm
	 Ai0qci5trPIxlKXmJolXhGq5f0Yr9e4Bkx+UwH6/dAzpkPXFIzDbwVWJlUXg+meG0+df9
	 PaJBCMbGDVvqdqcsEmQd03O754fgw5zmzK2qeMb6z6Z6zDDosmXsVYO14RkRFapZDMLVu
	 cIkE6hRYzHoyg1MjdSurqwaVLYzeC3vSyPFABlyQemnc2Hh7WcX1/r35htm2a/V7pew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=maNjsj6N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.4
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011004.outbound.protection.outlook.com [40.93.194.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D197606A33A
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 22:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D197606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=maNjsj6N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5lg77jXnVnwYnezfkae7h9m4KIYOAnN+dhYmj4JSv9ou6qFbXqgsiwk71qkaYp4Lqw5sn8w3YI21/ra7clDNsxGu2a5lWGPAoqqpy1mr9rhbKkm183X13Q7CkriSjbRPL1/g2+z9f5G4Am+OGQdD0av/8Zeg+PqeLj71cD2w2B9FiUp0MtNAE7HU0FqBz5dI2Rh2XkTVQk5qLE2+jAi7EDOF2zp486iECHXSstDvN/O17sjnxtGAwSEWuCcrxH5oOlwRErUru/hkQsUpscKOTFNCxii5rL/AlsLJrA8gE8UqJWr+Bw3B1jIKduXizWydQF8St7CMCE9wfvPykMhsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ctb2wJ/yXpcdJ3rik1SgHnI4UAQ1RQpon6YHh268F0I=;
 b=d742ALEBfU1n+BUUqwfUIP/3yc0GBtVaUV5mnIgw779nn9ZXnzp+jJZ35GLp/gVm541sErEXb1kvMtkm8kQQTF3gFsIC0bHONtD9RRjTTZCZbOcRosAdEaKy3EHu3j1djPaq7XSuJrmSrwmGAqPdjK6Fpk+GDklb7is2oj0iufb6f1qCZEZe3+lvJTTFetD3Oalhl6zzZMjKSZqrTUNEATOZoDoLrJYRFoVmFdZegD929mTk19g7SnaAb0myvXdzGACA0g0WNUJpx79cZmgKd5lHxGkR3QRu5hCWoOjWoD19yFWtXj3VhMlr3UwdNgDAa4680E7E2iKnqtkjbRChIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctb2wJ/yXpcdJ3rik1SgHnI4UAQ1RQpon6YHh268F0I=;
 b=maNjsj6NqnSPdRR9Ql2QpEvgwoVq+971xC2J4mtWAU4yXcBNfuXYBSdEi/SzvVqOm5yFWZ4nZ2J4OJ2AlaSZJmekLEwIQI82pElGuzgkL85kWofMcs24zvcBtfaC1fx2Q64OE4F6/2LZpj+MDMVyOE+EPd7J3YMeYrVKrr+t+j6DAACCv1gHdC4tXYP49yK+OfRKWKOtApjP4Q2AN+kRB9y1jb1E+7Z5TuywWQ2Qa5QSAU/QZKKTHNaRTbRJIEGQW3I2FJAC45BaTITzzBN4JUhfD/5Z/Gbns/AYIpAFtzKSHIrYtQ5E8ORHaSCtvOfQ19E4JiEp4l47XyxMOZKl0A==
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.10; Fri, 13 Nov 2026 22:36:41 +0000
Received: from BN7PEPF000000A4.namprd05.prod.outlook.com
 (2603:10b6:408:10a:cafe::60) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri,
 13 Nov 2026 22:36:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN7PEPF000000A4.mail.protection.outlook.com (10.167.245.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 22:36:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 09:54:48 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 09:54:48 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Fri, 13 Nov 2026 09:54:47 -0800
Date: Fri, 13 Nov 2026 09:54:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel
	<joro@8bytes.org>, Peter Shier <pshier@google.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v2] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <avdO5cBwc/2ysstZ@nvidia.com>
References: <20261112151039.2083705-1-praan@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261112151039.2083705-1-praan@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A4:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: f75d57d6-ff89-4f8d-b2be-08df41d6966f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|5023799004|56012099006|261026121527099003|261021121427099003|261021135927099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 THoTXEoua7zGTZq8to/qihBQm0DBbm6MmZxZ7bM2W3ilwid3s5w+JpuctrcneffcjvKVqFKJaP5vNf4bUgej+4OdnR+YlD6roi5iNKTuE0ekcaDAqMzy36pKodqm4DxlG1ye+dc/gvedRg5TyG5JPMiQoIOFLsfElSNKqiPGxwk1Kxw75tia9pLdshP1hPDQfck7bFhk1i6QL81Ach3mI72dq9VUvwl71fCSiHcRIDcLOCR24zQnU7Xd9X+XI9OvS9zPDTGUiTbJ90PZt+3WUIBKzfLUi9vQYLuCvnkMDleEhPJmecLsj1CMBNE+ZlpnuQCwZvTHzMx2Wsr9gpJeHXovM/sB++oIIr9ROMeh7Y+yNgYzk1zYnBnbGvA6JzzuVIBTIlm1mzYx5Lv1IDJjI8OZ9H6q2yFaDQmfiSz2nRtUB1s28bzX60uxwtT2KlcZuUx2U0Zl09MT2WtQveJzilsu8nej76A+iGtb3LYcF8Nz0TWXexfSQmaEVFqJVjf72/ZZ831fcQBiNZO9i2Tkn6B+hpR0WzmAnolouhg7yw0a+YxUj71KTSUeGd6YQ/Jwp0TZKXGoV1h4Hf4/k+F+wEA/18ZhnqszNqfggwIgMCyUj2hQhOln4rNFIEh/mnvc3DNPC2Ru+TiI4J3oAc1ipvoHH9AdjJiG1Uo8tQe9AK0uSIPK6lA4TmC/rumEbq06brFeoLgqr2volPK3PaLDTQ==
X-Forefront-Antispam-Report:
 CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261021121427099003)(261021135927099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 NS0w9vgqrwAUttU6ahyYlHcyRg8/5ixm3Cp/QFx5gwFnFur+F653vM4CEvkjfn9WYFcHFKcZXFan4rhiPyz2LcBJxE9l/33aYWRmfVxg8KzmqPCJ1h4N0Dx2dB8kyomluVKj5Ug4/sYjY+9L4idJztoPcnMl60sFX6WW0mQ6BLYCb5Wp7OkGuUg043OX91eYXTIAGzrdtyBvk7SeGhmVitxTplrW2HVxm/hAcC4sFspANwwS7rR5sePVjvh3FPbh/lqmHpSzJq06+fa09WI5fwJNMxCe04rF9F5Udf4cAD0Um/1j4aaKwBgmPoq2WjNOW9tClS7GbfBXY5anEP5I4lbNzRpUiOraMl/AGDAhpEbOJz30Z7b3pNRCSbsTfX+lJempx9jw7k5f05x+JNnxRKQmiN8FAFOf3cAQUy9+ITQp4U9xDAB3vWJngIXsnjLc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 22:36:41.0633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f75d57d6-ff89-4f8d-b2be-08df41d6966f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
 BN7PEPF000000A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
X-OriginatorOrg: Nvidia.com

On Thu, Nov 12, 2026 at 03:10:39PM +0000, Pranjal Shrivastava wrote:
> @@ -556,7 +556,8 @@ static inline int __iommu_copy_struct_from_user_array(
>   * @data_type: The data type of the @kdst. Must match with @user_array->type
>   *
>   * Copy the entire user array. kdst must have room for kdst_entry_size *
> - * user_array->entry_num bytes. Return 0 for success, otherwise -error.
> + * user_array->entry_num bytes. An empty array copies nothing, though its
> + * @data_type is still validated. Return 0 for success, otherwise -error.
>   */
>  static inline int
>  iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> @@ -569,7 +570,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
>  	if (user_array->type != data_type)
>  		return -EINVAL;
>  	if (!user_array->entry_num)
> -		return -EINVAL;
> +		return 0;

TBH, this doesn't seem very necessary..

Though I don't have a problem so long as Jason is okay with it..

Yet, this alone would make things inconsistent:
 * The other caller in iommufd selftest isn't updated.
 * __iommu_copy_struct_from_user_array still rejects !entry_num,
   and its callers (intel and selftest) aren't updated either.

Also, please don't omit "linux-kernel@vger.kernel.org" when sending
a patch, as linux-iommu doesn't trigger Sashiko scan.

Nicolin
