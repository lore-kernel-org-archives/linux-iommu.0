Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17B21B9D5
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742511005; cv=fail; b=NOxErNxZ/TcHXvcqIR2ORRopuUGpjdD1J1DzmvwWSoqztBLemGX+8i/lXoho+bB0is1XUs2Y0cZ/wNb6Mv/TRqNGye2KsZSDBPKyj+Qxp44OehNv+ycmEHnhLGMVfvG8uAk848HDkYgUrtPsBUL8Ylp2lv7jjaMcoJO2arMu7aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742511005; c=relaxed/simple;
	bh=E4cNkS4t0eDGC7Z8+BFCrCzPfXkrMdk1PsGX9lmpL3w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcEmF90SzAPm6pSJGQnggDKAJ239Ab3rDjeKc71g/8TUd0HEg5yEoBCFtQWiOxu0SZk5LFGgGZuNtPWHClvzn3VpqIJ1plrietOLJo3AqHHJTn+B4tux30F53vSGNqWy1wrBjwcYM5LM15AxvBvU0/FC14E+B8rfv/CknSQhD+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/wW8OqX; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/wW8OqX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E09e+vFG6TCfPg8tBIsK7RrsmReqQeZFuX0FScCVgOdb4MNXcBhCZuFfyrGxF7i3vOvwiE6akzUBTrYcdjkLk5T9koJySbpBkj6s59PwD6LTAXepAaoEsFMOwrC7x/qTjNYYYj+sjNKQ1dj9dBEN9VmrKjxytUoIcE21h8fRpm8/45N1HCMVc8KarBIUYwAhFwCaYcRj/0nJ0oiUPeATW7yLOFYpYix7QaTnPwEvmXS/H0WnGb4DTj1pe6TCun5DvC4nWDlKaaRpDQOhiWEOj5Lny4cwbAY9NdaXysPpfk7RFJpzbFPVLywg6s+nTf61vE35lOTdWpkn6RIT8nknLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xK/QbqyGu8yAq73cv1V1hWKidtMbTl81I9n1Kdds3I=;
 b=yzkUm0Tar72342nYLWZskU/UJT7TIEhPjEbBBgJzK7gVNf37RXSZrPnnYQzD09wN/4DSxGL6Tk9IelM2pWX8O1oNMaY0xqK+lejl2ZfUaLTGLTF/ZeWiNClT3ElPRWWA4dX4DOxM/dyvIP1v2PrA8F+EReN0J9sNKit8A+MMjsvvwsW62+IGj3QvrIZUjzNhYKYcXhkRJqA46+TPia80t1D88oBnaubWnF+GDQip/HUUcym2NWB64bP620SFKXrb33m3ft6AVfQDSdxo5MmaX4dchP58hz6PZtVOJmjm8ckJqSNWYWbP58NDaZ3Fay/aeIFzKEkgzwIF/9pGOwqFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xK/QbqyGu8yAq73cv1V1hWKidtMbTl81I9n1Kdds3I=;
 b=K/wW8OqXM6ShiXdDLBOfZSSfR/OldeNc1nIb4/nG+fQ+DG92tGEjlz3IrKJeG7324ZR1hgZdqgV6LBu8hY7qAZPn0nZs6fMS5CTmqYOO0Icg6TXEvl7P4cGVbnH7iR9Oho6OwLsfex8Gm/xQc03iPTA6XPshTGk3/MqJFsA8zlqHlk5OuVSN5SEybNOTU+uByxAjWeMWFXXP3OnJjkYU1v5kB80BSvoZ5TPJdp1JVuAy5fJT2cnRD0Z9XTK5phgxn17uTllbfCA8/lojsIQz5w4yW3jrB3w3tVTNZtTwx+c494hx9dLVkSVeh9raC7STQ89bOBbhRyl+27Qtd7nq3w==
Received: from BN1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:408:e2::32)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 22:49:59 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:408:e2:cafe::56) by BN1PR13CA0027.outlook.office365.com
 (2603:10b6:408:e2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 22:49:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 22:49:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 15:48:47 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 15:48:47 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 15:48:46 -0700
Date: Thu, 20 Mar 2025 15:48:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 15/18] iommufd/selftest: Add set_dev_pasid in mock
 iommu
Message-ID: <Z9ybTVi+2zXtAi2p@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-16-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-16-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e37a66-ec8f-4348-4b59-08dd68018ad5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NGNKqzHHFXr/CNHnqNYkMtFQ9jqHpF6HOSmZkewSjJ1GicqCH4n8BQD1le3d?=
 =?us-ascii?Q?JL3yV0F91GpELTt5hoTeJsuCHB66IKkgRrnDXyv5XennNz1wK4up4u0Uo7Wu?=
 =?us-ascii?Q?sCLxITh0AiIiHrELazpcT86/hrXQkjQCcwC8Ag2aXhVX3b6jcEkse/lVVqN7?=
 =?us-ascii?Q?RxFnOK40pOg2uOfnFdc5JvruAklA322e0G8iDj9vFgRqCliEmmysEvvp/Mwj?=
 =?us-ascii?Q?sTFIDAujZA+vgDs0YzZY+H6HsDZVF2s0FfyLvGDt9iMfWxZHm72VG+nfezUi?=
 =?us-ascii?Q?Wsw1ExTpwscIkze4XozAH4VlUvHKBKi9c8vF7K7LDr3fLfuge0Db71ZAu64h?=
 =?us-ascii?Q?QzjWbZIFMUtDRhd29M8rb2dqTPu6+FC32PzzbVWG4B5G66jddCjjIQTECxCM?=
 =?us-ascii?Q?jrvNp44REDUbM9AHSpAUfjkU5Ay1SJf27Mj16I/Cv+u44HCdsiUjJWlcd6IC?=
 =?us-ascii?Q?jTmzOUweYoBBjtcxLpaAjibeEZs3jtrVq64c8ipLYic9zQoaJoSuuE0Pfukq?=
 =?us-ascii?Q?M5aqSh8xOqWewHbyE7kTgB8eT1ogiICWmMG6URjIIQ8CGC1DrqlXzBxfU41y?=
 =?us-ascii?Q?R6KzNF2cj08NQl3kt/x+tNsQaJSS3VFWLhRvkPm4FSjHGTfv1+YdVub2SECR?=
 =?us-ascii?Q?mhSIhJvowfgk6K6pibFlalxMELTivesVIHJLO8+yrbmqzReJEBdUbadokZIv?=
 =?us-ascii?Q?uWtRJn3JtXzbRu3r9fnsrR+A0DXvYfuIzmNLeToiLkitxVmPKoSC8a5cT+X4?=
 =?us-ascii?Q?KlEPKkNZRgAudkcIMdUPJDiP5H2pc3mjUlTyS3n7WIHb4gG0o5VrRswZWrmr?=
 =?us-ascii?Q?1/+DQceR2nyG45v71IlPaZCXrxtc8D1rT2pUegVTCBNcF51gzGVQamLIFrfe?=
 =?us-ascii?Q?PwqpjdHtWFiweIzMur3yw90HSoPT3hgHQpLKJuoXHe2tMBGqxmfQMgUhhHj8?=
 =?us-ascii?Q?1UiSz0PQiSG5qdkiPJViM1pbZKIZlRHJQcUnQ99bb4f911kjxmFfho7bxNKY?=
 =?us-ascii?Q?K+rWWXoHyVzJm8qo2cegf5HdaKDR8rfjHmEYH2+8MMzBRDRLgo/5vr+2NxWl?=
 =?us-ascii?Q?4x8SAjVFfZI+q4PIEUU9ATfz2msSDGoWEOtCYzawFLthNaFfdp8oagnsUi2Q?=
 =?us-ascii?Q?GveEtcaTQnPDbu6opGhcMgoDOXPSkq+k78bmv+RtHI4sIXzu9Q3Y4Wy4MLgl?=
 =?us-ascii?Q?53bW7cWS2T3H2ot9hnsQrK3WABYWZ+WZxV/F97ZjS630lFbez5x3xwrnJ90U?=
 =?us-ascii?Q?b5YtWP2VAPc9Gd35Ce/GxW1MXhaiGQJUaPiFEX1QYWLKkCLZgIaBKIWUwxEL?=
 =?us-ascii?Q?lstGwARFd4RCXf3NfLuwEpz7N9og+F6VOUZTGf9l9YbyMdUfofFV9rHoLrWt?=
 =?us-ascii?Q?r0bEXYdagHYkblecwMrlLlbiyhUJheeE5DeUMXYrvh6I1pbcQrKDWAV0mf7H?=
 =?us-ascii?Q?XeixNY9jWzDUwNJeSssbEXc+okCJ7W2HXwBTeLVD7K6Bg8ZadVWEjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 22:49:58.8562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e37a66-ec8f-4348-4b59-08dd68018ad5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

On Thu, Mar 20, 2025 at 06:47:41AM -0700, Yi Liu wrote:
> The callback is needed to make pasid_attach/detach path complete for mock
> device. A nop is enough for set_dev_pasid.
> 
> A MOCK_FLAGS_DEVICE_PASID is added to indicate a pasid-capable mock device
> for the pasid test cases. Other test cases will still create a non-pasid
> mock device. While the mock iommu always pretends to be pasid-capable.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Two nits:

>  static struct mock_dev *mock_dev_create(unsigned long dev_flags)
>  {
> +	struct property_entry prop[] = {
> +		PROPERTY_ENTRY_U32("pasid-num-bits", MOCK_PASID_WIDTH),
> +		{},
> +	};
>  	struct mock_dev *mdev;
>  	int rc, i;
>  
>  	if (dev_flags &
> -	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY | MOCK_FLAGS_DEVICE_HUGE_IOVA))
> +	    ~(MOCK_FLAGS_DEVICE_NO_DIRTY |
> +		    MOCK_FLAGS_DEVICE_HUGE_IOVA | MOCK_FLAGS_DEVICE_PASID))

Let's have a "const u32 valid_flags" at the top of the function.

>  		return ERR_PTR(-EINVAL);
>  
>  	mdev = kzalloc(sizeof(*mdev), GFP_KERNEL);
> @@ -890,6 +906,14 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
>  	if (rc)
>  		goto err_put;
>  
> +	if (dev_flags & MOCK_FLAGS_DEVICE_PASID) {
> +		rc = device_create_managed_software_node(&mdev->dev, prop, NULL);
> +		if (rc) {
> +			dev_err(&mdev->dev, "add pasid-num-bits property failed, rc: %d", rc);
> +			goto err_put;
> +		}
> +	}

Since max_pasids == 0 means the device doesn't support PASID, I
think we could create the node for !MOCK_FLAGS_DEVICE_PASID too
with a "pasid-num-bits"=0?
