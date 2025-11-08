Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010025.outbound.protection.outlook.com [40.93.198.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BF1F3FED
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563720; cv=fail; b=qsPmebcBadcX2LVM0v4mk8ej0oUb2EdnVfCB6b0OKU5uzgA2tXF4k5fVYuETigZXZIRA9jBmZel/LuYng4ybgsJ+0gaqJ2az8hmbP9tLPXtd3mh9PfwIaiR99/JPCZF9+myjWZwvjnPOr4sM/+vtZ2Pi89Ux9KAw5JfJ6zwBTzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563720; c=relaxed/simple;
	bh=Esy6lpybtlH58uwAuyCVgMd7f4sejFpXJ4KLTC9r0GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VBzYKZEnfXoYdigexwVMEjlM34wCxmjO6Ug1Gbli6YT1AfpETq/QpzRqhe+WxMwuKf+QLbzBVh7u51uuJBYAvN9gdp6hj/eq5wpaJtmuyqdQB9OFlS9Z/uda/lZc3lHzaklw56uBaF4wclD1THO2nvK/eeM8lS/F63o+srTINgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TH6OOS9U; arc=fail smtp.client-ip=40.93.198.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TH6OOS9U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNpoqfj0Zq9ns1qQIk10cGBpqFpypWTingPF0kVySEkn4wmcmWc6++URQM4mRRbXHHtItSIwN3twG0wR+IqkwndIRM6j5ywy+iESY9PcAqUHS0+RDxlvJjd/RxS8T74CUoW5G8L+TJ26o8FIdsAbTN8iilQ0Gea3SR/qKmycEIw3F2Y9gpgxl+01KZdnkL669b6+615PBiemCVdr+5jIAAdCKpiX51VRZ4FjcxjrST3sk38pqhUyJz0S25bqs4tqsmAZMdzRTd6sW1DwqUWIGfRrUOK6alFFyRx19OtvEu/oIRmmvXaBX+WRgowcJzo1PGOnAwdbaPrnJrFWKEa36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFuq5H7eoak6goMMev8VoXsBX95F65p4Quz9tOqVRuI=;
 b=KDHG9Tbv+WU+N7UZ1Sw8ADzWBtyE34B+H8nzIEvcxZXfktXNdDbJDYBhRcpucn/bHDAqX7eqL688zQ8umGOWfUpwstn+HJQjlF/BPfrPjuGcvXqGk1QEwF4WjrSP/1GcWSYhCiD0RhZGvKC/77d5mqtrWHjZOzwfQRck7i4hvcboH5k/5vq1slJBAphsAsFdHd75+M7SzE10tRcD5VHFYV/vupy1a+SZq9NTOVJhEZWsOHUoA6Q4gNpkZ7dK0+0T23Xvbfbp6KejqG5gP1rZ3R7ndnpSkKELj6irSzKwEKofPyPebthk4O61eBjWKWxpb92VCyIXe7NrqwKjsmCYfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFuq5H7eoak6goMMev8VoXsBX95F65p4Quz9tOqVRuI=;
 b=TH6OOS9UOVN2AHsn1uVQ4A2TDnJc67CAKbTvO+Y343lOSe5S6B8zWeTFQJYlDCOjZXigT/gYbqjLfrN7xVQH+Nda485VCEmtUV0VWN9X3LJUt9p+ib2HqOKe010/GHWKiGtAgyTjWcL90ADIcMUsXI72MG2s3TU4S05xircSM69ASy1kiP3MwiDcEvXPi62tnRpJtVmI34kaSCr1hvwH4VzmkALyZI8fMvOROjkE3/erMO4zx4IP3TRT1E/oxvJYILG2/YSargWH4ldNxx5ldn+8ZvZ22Zv75zY654upmFhp1z+/o71aQ3oJGM88T2jUhWa2B+IrmNSp+peF7RYSyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 01:01:55 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 01:01:54 +0000
Date: Fri, 7 Nov 2025 21:01:53 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iommu/arm-smmu-v3: Introduce a per-domain
 arm_smmu_invs array
Message-ID: <20251108010153.GF1932966@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
 <b7560a95f474bd642e037d5a43cfe5be76ea3fe7.1761590851.git.nicolinc@nvidia.com>
 <20251107194158.GB1932966@nvidia.com>
 <aQ5VXORy6nQ9yfwF@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ5VXORy6nQ9yfwF@Asurada-Nvidia>
X-ClientProxiedBy: BL1P221CA0032.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::11) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 716944f7-e4f1-413a-15ba-08de1e62689d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RiePhuNmdiZNFsF+P5Z0m7Yj2pK51E9M6vBxIPZwwz4GipV8qPr9Ht5J+Z/Z?=
 =?us-ascii?Q?SplFgNYYITZHmu+F/Q+CzllgDkzcK+IkpQnsPoY/7yHBwmYFrT5mMQXPY/li?=
 =?us-ascii?Q?YYc2D4bME+xWbPHWoc8pj6dMTlUjLsuVwPvhNwBSxdK/sykidqxVGJvHFkm9?=
 =?us-ascii?Q?kccifFm8FFM5hYg773Ear/aqqmcr5CTwL2iQOD0OaoeR54WKNwUsh6mG4kmd?=
 =?us-ascii?Q?3cm+Pn2pIYa3ts9/BagCKTnmG83QG5jIKtEFFTMIkfcfI7zX4i7SZJNRsV6E?=
 =?us-ascii?Q?9hUCsuwODnB4oazW1E4TFLhgmRv4Lp0Jx5Ku9yYFgmpKhEL3BSr3rf6wKAZ3?=
 =?us-ascii?Q?BBUeSeFyu1So1ifMqJFMnALUM/pg1gx1sFVs/msjDXp1VAGwCi+nZhRa7agn?=
 =?us-ascii?Q?hcqTCx5z7sR1Uw775NQXi904pvIK49dGQpxCNfc2z8jWa4HgKL6GaEZ+P7Jf?=
 =?us-ascii?Q?Tm14+mNmfoteTYB0jfxNDRJqo6WbOUGefBPBCaAnguSFCdgGI7agSNjS29tc?=
 =?us-ascii?Q?NSLIdKRwTiCXE2WBRKm+QoxYzVhi8WQLhIpussWJTTd4RCaHHOP4BPPhUO07?=
 =?us-ascii?Q?1DMb9PgX+VsFO05T+xOvw0SzRAlEbCQBuNboNnk61gC2nIBuurv4dsw45fri?=
 =?us-ascii?Q?ePx8+ZUGohoyuZfcftpPvl0MDoJ70OCBh9NV6hfnztfKIHwSFOP68gBjmjpY?=
 =?us-ascii?Q?4WQRVh+uddaKanTLSrLYylGPp3A+iIiksnMv2BWYJbZ0TWXU7RBNJIfD/iLt?=
 =?us-ascii?Q?3o3iLjVvg3IUzrMkQ0nTiX9VqFYVL9KM7431AnQBWZ4cdiXDrVAtFBhJGtya?=
 =?us-ascii?Q?Aju2TfOnx2Z9RsQA+8N7Kay8DjKENlfazo3eq7DC5p4ieThJUlvF4DE3ezQ9?=
 =?us-ascii?Q?6D9C4edTYIzBoRu0H1woXKIH3NpmD+Ua0KnGEason2lF0aYK6m8G5DVuzATa?=
 =?us-ascii?Q?pimliQUh6JLDZ0tHU14rYriZzlyWmMf956MdgRpvTs9VlLPaSBEXj4a8JnAo?=
 =?us-ascii?Q?/+Y194LgVUSgMACFDmlLFimx2Aw0swb/E95TqQQnb3tRJKN+NF2LcnGe2m0I?=
 =?us-ascii?Q?vjAZNehBxu7KVzmDGwDt4lIod2SyspesuszuGGjD/e4jJpz2AEXnoF5bB3U+?=
 =?us-ascii?Q?yCybcGabO6I2ibNXmEpj/rjaLaGbp07bNORB1ZRVvcUNFlRDfyYqAh5hWPLq?=
 =?us-ascii?Q?NtVTuxuwFLqOseZ4EQ1HV8nNkAC8ZL6HtC+I6lxjAh/sn4SndiivK0UFfMNa?=
 =?us-ascii?Q?Yun+ZwzuTUxpMVdr9hzsXGYjCdLS7psEC13EU0z/zBccjL7Hq2obMrePlY6a?=
 =?us-ascii?Q?HmF+oI/U7OnAssq6CewpSoW1qo9DraIIRVXcNmxw9q+O41fIGtx1dY8Zy0fO?=
 =?us-ascii?Q?ctWpEKtmEujyhGv5thMc0mu1JzBsA09S2HLBTuP3UhNKZMshdxDi7z/6JJqp?=
 =?us-ascii?Q?EDf9b9E8v2jqDlV6IdyqaaKqtGftFinG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2lXQ5zMBH3OE0dsl1mF8M6jhmR7Cv8KUvjrO1/oETA2SEJcH1wn4Q6kl/+zL?=
 =?us-ascii?Q?n/1zL71OBEgFEjJBhPf0wpEuW/qsYXbNMaeZoIa8QQPuNiRAxPJZ6Licmuf9?=
 =?us-ascii?Q?9fdqRY+sWPNJIK++Wwx53SX6xb1Fxzfhktq2oFImLDh+wGw31ZiWczpVhlQt?=
 =?us-ascii?Q?SiSqTth/Lj6cYMwp3v6iBY92jrQpiY6PmSZRduYEJ7ypdCSdFgCsiVr2GV01?=
 =?us-ascii?Q?Df6qAfozASfNCIJslSQi7yHHVBtsvO+4ExfsqnAwY/jx7anTDFExy7T/9220?=
 =?us-ascii?Q?OfmPVNje748G0JIs29d3U1z+QZU+d0R8/UgU1nkxebNmZ2tQGkrP8V/Jqw1W?=
 =?us-ascii?Q?mUwRmAbgztPi9wN/8dz1xEqWmTMZj6vGnAfYg5HywMjbfoFbx5P0pyYpt+tV?=
 =?us-ascii?Q?B4bZxEWMQlBjop5ecYHAYeVq3XTRX6o3f56Wp8KpAjYAMPW5GxS0BbOZW05T?=
 =?us-ascii?Q?VGFU6vUnzzfiF+tLKRRckMsTtzQ3/MXi16f56ibVXFp0GrUip4NTMaXXSNqO?=
 =?us-ascii?Q?i5fpXW7N38xMqMtNkvMO9l5Qo/QNGfpWiJwKafBturo2wMJqY7vVAK/i7bqe?=
 =?us-ascii?Q?DN8XulPLUzdvhpF1bNciipboU9fibUvxtcLklA0CZPE+Y2bz5eheWtoz6cLz?=
 =?us-ascii?Q?lISo7we1rTjSCwAM9hzdoCmpjdiVnqDyx4u+GYFu1AnOzR2QbZ766xF3GWRI?=
 =?us-ascii?Q?h9By6sHiFj6k3zljMlLO8NRqfZUPxryn9e4uvzAs3IuUXn8gt3KJ689UOjTS?=
 =?us-ascii?Q?edGPS+zA99JEqrRwuXtRQRDJpDIJyQ+tZ7GEZQkyPKhsGw64MZLsMT0zGV7Y?=
 =?us-ascii?Q?2oFRRBTqRXS6wgAbNkgnoX+C1hTSC8PbKgRmF1wJS35Ec+tESu/jVBvYvviE?=
 =?us-ascii?Q?t1kAuFdYldfonDZPSUCFjjUy7920j/gG9rmmFOZ8oVwsX2aoglkTWOnQJkg0?=
 =?us-ascii?Q?X5ey+jRgC3KSsXwLpBgjVXNZ5mBHiR0pLBpEpz1Weq1B3nZlN0r0l5bZUJSA?=
 =?us-ascii?Q?kiCVRda798wLpEMF4JTBfqIw6/pFL3rniOO6Hih4leoy0FBcaHXiq9se/UtZ?=
 =?us-ascii?Q?ky/AWLMwJ+QsQSwIyhKJdi1rG88xqYim74960C3+z9VWqueVe7ic3GdN0ayO?=
 =?us-ascii?Q?AJRGOmk8IKGz/4gvF1vWNWcw2zCFkZLR45mxNktrfBi7/xp3sj0wdZ8gAzuF?=
 =?us-ascii?Q?E2Bmlro7mP5r8OSeQzTpV4zgqWsXOkvWxs5gdDggkuE5OIOIZVvbHkoGSSPC?=
 =?us-ascii?Q?zXxL9eYNVbz7JvUMe2D5eTEJJyK90CeLHe73OKPU2/IWTzamFcBXzegKvIcl?=
 =?us-ascii?Q?SB7r0SMCIuyxRAY7ByJHSoDiFKPhrtKrcT/1LKbM2p9+EC2F1g9DVSzSte7c?=
 =?us-ascii?Q?NBtmOTiLgNgC2r3jLyjLfcod4Hkujb9w3f9vESs7JUAJtGzZsZAeJO9lnxOz?=
 =?us-ascii?Q?fbfct3zwH51P6+jQ0iEwv/3UESWfX2bH1GvJvhR7+wGB5kl9M0T2C+E6ltO5?=
 =?us-ascii?Q?UlTAjfjeLVxVEUpkqr/ipyQL2s97Uf7qAuDQkd3U5r26CJEazBPtm83ZyDM1?=
 =?us-ascii?Q?1KxucYLkEG7xnjItqwQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 716944f7-e4f1-413a-15ba-08de1e62689d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 01:01:54.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQnt9dqJ99xO9l265LmBwsUs0jWYsj9u2CBcmXnGnQ7TkljDQ4mXd3oQ19FMMO4S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167

On Fri, Nov 07, 2025 at 12:23:56PM -0800, Nicolin Chen wrote:
> On Fri, Nov 07, 2025 at 03:41:58PM -0400, Jason Gunthorpe wrote:
> > On Mon, Oct 27, 2025 at 11:54:17AM -0700, Nicolin Chen wrote:
> > > +struct arm_smmu_invs *arm_smmu_invs_merge(struct arm_smmu_invs *invs,
> > > +					  struct arm_smmu_invs *to_merge)
> > > +{
> > > +	struct arm_smmu_invs *new_invs;
> > > +	struct arm_smmu_inv *new;
> > > +	size_t num_trashes = 0;
> > > +	size_t num_adds = 0;
> > > +	size_t i, j;
> > > +
> > > +	for (i = j = 0; i != invs->num_invs || j != to_merge->num_invs;) {
> > > +		int cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
> > > +
> > > +		/* Skip any unwanted trash entry */
> > > +		if (cmp < 0 && !refcount_read(&invs->inv[i].users)) {
> > 
> > Do we need cmp < 0 here and in all these other similar ifs? Can't we
> > just fully ignore trash entries no matter how they cmopare to the
> > other list?
>  
> The index "i" might overflow in case of cmp > 1. So, if we don't
> check cmp, we'd need to check "i != invs->num_invs" instead.
> 
> > If cmp ==0 and we do num_trash++ then the next iteration will see j
> > ass cmp > 1 so it will do num_adds++ and the two will cancel out.
> 
> Yea, cmp == 0 should work with an additional iteration.
> 
> Perhaps we can do this:
> 
> +		int cmp;
> +
> +		/* Skip any trash entry */
> +		if (i != invs->num_invs && !refcount_read(&invs->inv[i].users)) {
> +			num_trashes++;
> +			i++;
> +			continue;
> +		}
> +
> +		cmp = arm_smmu_invs_cmp(invs, i, to_merge, j);
> 
> And I will fix the other two places too.

Mm, now I see why you did it OK, I do think the above is clearer..

Jason
