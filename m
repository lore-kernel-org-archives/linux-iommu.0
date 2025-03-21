Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECC22D7B1
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577082; cv=fail; b=NonQ6+wXwDeVr5mqj510/PMnB49lLYQemVtAmwHlENz4SziRAGbArKIrMuWOKEapcTKWjqO4Gekcs/d9I4RRnSBeyIaMoD6QtS7gKEAh1kLDBZ8ApUXn2BsgHg2kufaFeaTD4WddRG9p/pa5GY0MzYqfm/1jEfdZ/wCq6afuW4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577082; c=relaxed/simple;
	bh=6ApzO1glMLBNe13h9TrZQu+3sWcF0s9fIWgoXHpF6nc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjFKz4RnUH0z0aQjt2qsvAiE1fjtFi0AU9/ntjDUJc22Ces42Y7QachMph7K1Wy0GxzUM8noTzY9a6EfOFnkp4O5gXd8JnZRMYv3dBDDj771YggkdbwGtXL9/NvWy3+QL66NGL+bVvlK4gHOI1fni15S7GSmIeiN4wBky0GOlp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sli03+k2; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sli03+k2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnlRxd5+B9LOFF1omti8RxjCTbFKTE6oU/GHYwrPNqztnfBNCZ00IH76f7NnnEpKbYjtOAlvSo43HG7c8JPRFAXgTnPIF/tW6NhN/jZn5Z4cZuw2AEvYBZl+ETZtsC9NEEZuVvQghvPT21BlLmijBldjVBejBlw9iu4hK3CxraPPuJ5GaMB/A87kwWMG9nOGqgK40wd8/8ah467ggdplgfMxOWIMnukq9qDtM/yi94YV/WMNBDczJMAuctlKw41bigb4iTyrrMqSfxfyEI7LeRDCwgpTR2TWzYdKf5jmjECtUZGMCA7IxwZXLh0EK3mSLlrQ2q8WsoBJtOAt6f4foQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSXnFwb1qaycKYAxIZiWMe7s9WpN27XD9v6xT2VRfGQ=;
 b=VAczefDLF3dmOp200/zOWTMK3U6Iz3wocaNxIOtDzNv85V4ItzP7DKabpqN4dOT+Qd2KJ1zSX+ckPMKx3RnQmVrdR+rBNVBkyW9iOlJ0+0rKejLYt1XsMJONpORFJwmXu+SntQT/j215FEs4c/YdyiTRWEv+DAlTzZtGDed9bbDvCTr2AHl4SFhDiRhAUerSaWCbE6E4Wf6FHzkP+BR7EHHrYCgGMQM/MG1H7HjkfdKGmPo0DZVhrpui26beRJ+2+LZGGfBjAqpIr87MKp3xwmyNI94auY1ELxBbfHkhAbwKlV1rurN+GbqLZlCVLIXEqu6WSIuGl5TsfLKwIl/ZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSXnFwb1qaycKYAxIZiWMe7s9WpN27XD9v6xT2VRfGQ=;
 b=Sli03+k2EaTJp6uOsDh4GRxka3ulV0HK9HBh8ctfZnJxxNVPO4bGzJXhcsLAma/izyngo16CjPHboknAgIa6OGHehNnruATURn+9RcdDeXEbIg20PrDXPghjYQQ5+WobP69DtdPrSoijDYAxeeIuEcBYV4MVUeoWksxwga4ptJS5mb9TutCPfps9A+5aDtAQr4e0Xp2QImErHFqnX0IbiWNIkU7SizJ1gdNE3tTF7EcfMvdByL8R5wHGfsll7XBxZAR3VM5YQguicOFvlmBxgYWagMQG/EaBlUYoahCX/OOdH2qGk9pH3G/aQtEhpUSpMmWODYIL2lLF+GbDajsS/A==
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by SA1PR12MB7152.namprd12.prod.outlook.com (2603:10b6:806:2b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 17:11:13 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:5:3b6:cafe::4e) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Fri,
 21 Mar 2025 17:11:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 17:11:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 21 Mar
 2025 10:10:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 21 Mar
 2025 10:10:59 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 21 Mar 2025 10:10:58 -0700
Date: Fri, 21 Mar 2025 10:10:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 18/18] iommufd/selftest: Add coverage for iommufd
 pasid attach/detach
Message-ID: <Z92doF3OoYEKoNCb@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-19-yi.l.liu@intel.com>
 <Z9yz/pVlPy6sOxP0@Asurada-Nvidia>
 <c90acae0-98f7-4317-b279-2e94f6627307@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c90acae0-98f7-4317-b279-2e94f6627307@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|SA1PR12MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f53548f-98a8-49d1-3374-08dd689b6222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RI19GEuBG8nFIXZT2QgNyc6h6E3dvIpqVlBX2fj3y9SfUaq9ikk6Ds6Eaw+H?=
 =?us-ascii?Q?bRUNYs+KhhuNSKM19SRTWEq90hzZ5rx2RvhXIwmx8FSX4vSQTr35chg4NkBs?=
 =?us-ascii?Q?FTtNSMKbxK1rL7/PXn7QLHjM9ZjFWPN6aVzOaLb6xyf8e2Mg9KgTykrHqx0h?=
 =?us-ascii?Q?SPOzxq7I8fsdHRnBz848D3Llts6rmltID9ShQo1c8yM+zZW3kx8pbLlL2wb3?=
 =?us-ascii?Q?OWuWwWMPmlmnR4+DGTlFS7xKaiRhLLSGohp8AuOs180DE8RB2A81jzD9dY2K?=
 =?us-ascii?Q?sPOmPpkyr1lV/DNq/7LANhfnxHe36XQr4c5paY4+vk4QZn2GXeVWgp4ivaIZ?=
 =?us-ascii?Q?i/yskJx2Qb2Dg01AYtyu4ULtlKT+bfKitnwzPXYqkKftuHMy5+2HqcmQxxM2?=
 =?us-ascii?Q?pubz3NW7JdoYZWCaJbFrnvH3YjSanITw9NLXHHZAsiPdQpS30aqGQxhGrtEb?=
 =?us-ascii?Q?3IgvU/rrntkeh/JqbP9aQC0g/S6rOKKAEHS2FGtLZgVDSNjPhqcXir/0taAV?=
 =?us-ascii?Q?JGsn+HCFxqZ0ZtL+WBA1WPn9mm4NLKXCykLsAJso9Lib+8PNlnyMTq8E2ycD?=
 =?us-ascii?Q?FYxrWdzrj8a5uUYUbLe4a+/QjHxxsdQ26CASks4MaaAKT5nhHDkNnGPWAr6q?=
 =?us-ascii?Q?R3aD1mO+X8ns9DXlcrraAqoIaHPJ+bDKm98nIFTPehbdAAVGlyGpiuvDrIvI?=
 =?us-ascii?Q?iOfokXd3yz//iEYSWM3/izl8YspjrU9DoK7g8UAMuJL4RS/NrBh+mIwd0nVW?=
 =?us-ascii?Q?vMflxGSHjaaBhRjPj+0qcoVYwpbngIQHxPxY++jJlk2N2t0jCofxWx6r7gYN?=
 =?us-ascii?Q?kKrpINvfM0axfaOv6LF35tsyua9vOEaO6zO1YHwmilCu6mkziBtHSEuDuY1k?=
 =?us-ascii?Q?e9uJ5W3kNr19jVUlVCuLPTVXu2hIgCFrHVndC3x8c6u50nyTQpV4J/Qm+1k7?=
 =?us-ascii?Q?mom2QmNbXiCUBoL3cP65OhWLRmV+I99zrcyNyHP48IIx61a5zC918NdGyuJv?=
 =?us-ascii?Q?sQdQjbTPizlKvNnHD/XT0JgdFAQ0iR3ierDN8CV/+9rusKOwjtxkUtu6/Bn5?=
 =?us-ascii?Q?fO8ChccLJU7Xh1SZthmrMT9S1QwimZaGzwtgXjhtmjkfZ2w1+kAQSu2vc8+U?=
 =?us-ascii?Q?z/GXKXLXw6aRX664BQtGOLvfmXaJ7e/NvLJChnAgvMtf8/4sm25iXR2lCGw0?=
 =?us-ascii?Q?NKOI2qVzdQxhgDCoW9HpTZLneXJAYGp08Mjby3ozWSyjqDxLTtdk8FmzEK+W?=
 =?us-ascii?Q?APrRCNHsdkCkR74FFuFmh1sbTgYuUOW0YgQvCMRKuvupoVR2r+g+P6hy3w/q?=
 =?us-ascii?Q?+3jqOr+wnos6eR8q+7ouA9oo+1WuCWO/u+o1gWVwdjhZhy8o3T6v3S1nki6u?=
 =?us-ascii?Q?EeSo8pJ1U65+6SQWPGK3EZVkspxWDVRvBoI9HKklakQayoNzWE2VGmDP+Ud6?=
 =?us-ascii?Q?jo58OnMc4qtKfNdGQebnFgNkSnvMpYUqfoiTPAYrUgTUmzfdanQvds82zQUe?=
 =?us-ascii?Q?fFuxfa8/V1JBn3c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 17:11:13.1012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f53548f-98a8-49d1-3374-08dd689b6222
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152

On Fri, Mar 21, 2025 at 11:26:02PM +0800, Yi Liu wrote:
> On 2025/3/21 08:34, Nicolin Chen wrote:
> > > +	if (!variant->pasid_capable) {
> > > +		/*
> > > +		 * PASID-compatible domain can be used by non-PASID-capable
> > > +		 * device.
> > > +		 */
> > > +		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, nested_hwpt_id[0]);
> > > +		test_cmd_mock_domain_replace(self->no_pasid_stdev_id, self->ioas_id);
> > > +		/*
> > > +		 * Attach hwpt to pasid#100 of non-PASID-capable device,
> > > +		 * should fail, no matter domain is pasid-comapt or not.
> > > +		 */
> > > +		EXPECT_ERRNO(EINVAL,
> > > +			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
> > > +						    pasid, parent_hwpt_id, NULL));
> > > +		EXPECT_ERRNO(EINVAL,
> > > +			     _test_cmd_pasid_attach(self->fd, self->no_pasid_stdev_id,
> > > +						    pasid, s2_hwpt_id, NULL));
> > > +	}
> > 
> > It seems that we should test these anyway without a variant?
> 
> these are for non-pasid-capable device. without variant, we only create the
> pasid-capable device, hence the above test in the if statement are not
> necessary.

Yea, I mean, just create two devices unconditionally, one for
pasid and another for non-pasid. I think it's good to have a
non-pasid device to cover these negative pasid attach cases.

> > > +
> > > +	/*
> > > +	 * Attach non pasid compat hwpt to pasid-capable device, should
> > > +	 * fail, and have null domain.
> > > +	 */
> > > +	test_err_pasid_attach(EINVAL, pasid, parent_hwpt_id, NULL);
> > > +	ASSERT_EQ(0,
> > > +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> > > +					      pasid, 0, &result));
> > > +	EXPECT_EQ(1, result);
> > > +
> > > +	/*
> > > +	 * Attach ioas to pasid 100, should succeed, domain should
> > > +	 * be valid.
> > > +	 */
> > > +	test_cmd_pasid_attach(pasid, self->ioas_id, &auto_hwpt);
> > > +	ASSERT_EQ(0,
> > > +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> > > +					      pasid, auto_hwpt, &result));
> > > +	EXPECT_EQ(1, result);
> > 
> > Hmm, I thought that a non-RID PASID slot could only attach a PASID-
> > compatible HWPT. I think I am totally confused now... lol
> > 
> > Perhaps we need a detailed documentation somewhere, at least as a
> > reminder or so?
> 
> In this v10, attaching pasid to ioas will allocated a pasid-comapt
> hwpt. But this is really messy. So I will make the auto_hwpt always
> non-pasid-compat. Hence it's aligned between RID and PASID path.

I see. A pasid slot can only store a pasid-compat HWPT. That's
clear now :)

> > > +	/*
> > > +	 * Replace pasid 1024 with self->ioas_id, should fail,
> > > +	 * but have the old valid domain. This is a designed
> > > +	 * negative case, normally replace with self->ioas_id
> > > +	 * could succeed.
> > > +	 */
> > > +	test_err_cmd_pasid_replace(ENOMEM, pasid, self->ioas_id, NULL);
> > > +	ASSERT_EQ(0,
> > > +		  test_cmd_pasid_check_domain(self->fd, self->stdev_id,
> > > +					      pasid, s2_hwpt_id,
> > > +					      &result));
> > > +	EXPECT_EQ(1, result);
> > > +
> > > +	/*
> > > +	 * Detach hwpt from pasid 1024, and check if the pasid 1024
> > > +	 * has null domain.
> > > +	 */
> > > +	test_cmd_pasid_detach(pasid);
> > 
> > The designed "failing" replace does "pasid_1024_attached = false",
> > meaning that this detach() isn't necessary?
> > 
> > Or perhaps the designed "failing" shouldn't set "attached = false"?
> 
> hmmm. This naming is a bit tricky. It still requires the user side
> to detach 1024. That flag is more for the conveniency of faking error.

Ah, so maybe that "pasid_1024_attached" should be named just
"fake_attach_error?

Thanks
Nicolin
