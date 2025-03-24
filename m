Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1141581F8
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742856349; cv=fail; b=Us4VHbgcK5sajvxQTXkl84N/IPZ0kIusREipiqMNVlHa3odvcghloM2DnFw99FZJHfcUZrF0YSZPtINwT0JA1A3jOOhKtPlocSYPRUIL5R3aXqr3UUUWJa07BO+9HbKwMICayUvorSqeIQ1Oq9GdT0YSMrl75l1PVzP6IcDeiJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742856349; c=relaxed/simple;
	bh=MyzcF8Rui2W2EtK3E2KCjXx+cMEqZYNcw1h4Tuw6ceQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=expbiJH8feuJu1LZjkoqDiAZnUfl62+1bLvFVAPWXShWgvrmxvw3LGSFHn4NaDz5UPO2Pzuz26ISvcs6C9iHyqfVBVN8JWT/6PmyPDH3pox2LzIKQ9EV18uR3e9DHza4Dt2B7Ynmxp5yqUON30omVtA/s8YCYsHHem+PSqsFYK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rI5fRidr; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rI5fRidr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lW9YbfBJycfI48vBi9YnmXqYCu4qWgduT/oIechbVRBv7+s3Jhu2cTkgxlZSJ6iYjo+EugjU+S7cF2srlNv2ZVROaZMyDrElI9scSHdEDOfBQzBZd5QYThMEOb/S0FjtMmwIV1sgDQYBead2pq9TS3bzcd0d1zUHkECISCPamS76r1DGC3fPbO+ouJ0H6lpV7oE85wGf23gRBQeunq4n78UmTABroEXGMe9bFDO6jRLa2HvEWDPtqprvVv0tjaY+tqGi/mdquxlyeZTTJ849xUm9TBB3KZfqbbAn6mpIPtdYKWZUYqa1Ud4o9cwFZQeQuCQHt3QxQrU1xdd4dlOojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/2pTzBGICT5gnV+nR7pjjVFmtCGcatk05RR0Ja1JyU=;
 b=Y/sYdbnFxv62N5JJLt+2MdW7/FJSOBFqifkR3rG/c3EudB4ogdKB3ABWXY7cBSVvXk6MA/Fei0HQyuk9ohJHIXA6gcfWWP1vFips8gy4ZM8urZ/OONzy5OFl8VIJtC1JBuKxYnvV7NolPvpdURABS6g6rMSxC0lRtNZs5dlpYszQ0yuAEZDk40HdatjawIUFfAMgSA7dDg8tzxz3/qG7fK7XjZa9PHTru4yW0LABAKLgyEwO52XInEknEVnzqrPW8yP43w0Y/HMtYyzvzZ4xiXL4D8QDwBZW9vsQJxV7k8YCkjWx0MakoSz62NSqgFt3ebuBR6omxsJlgoCiGsLzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/2pTzBGICT5gnV+nR7pjjVFmtCGcatk05RR0Ja1JyU=;
 b=rI5fRidrdOvaHrdoQVkJ2BRJed17jJ9ZdUGaQU8eWKDGx3Gk3Z5ZNz5PjqErVX2VBm2MRDJAJ7NcGQapPi9b0/dqbqFIQhnqpbSBeBGRh3m3ryXxv4Eza48sQ7W//ySI/99Ux+CMYBKlaQH2xTFc5pbppNxfrc9RBFyg8D6IGDY/2H47cUPVCva3oth3jPv2U+WfcK/P4GXE8Pby5iNnzks7czOXzriX8LXW7AqH5K3qT8TcI19zQ90Z+2sveaGVaXZ6ck41ZR12wbA6uPWgHI9iGwljeFRWpqD04B0xr6Ek3Z+ATAcs94BWizEqCNcC2h6RcoXF6Lz7KuMNjWoLXQ==
Received: from SN7PR04CA0188.namprd04.prod.outlook.com (2603:10b6:806:126::13)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 22:45:44 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::17) by SN7PR04CA0188.outlook.office365.com
 (2603:10b6:806:126::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 22:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 22:45:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 15:45:30 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 15:45:30 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 15:45:22 -0700
Date: Mon, 24 Mar 2025 15:45:14 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nathan Chancellor <nathan@kernel.org>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <Z+HgevJ+YChH83gn@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
 <Z+GK98/VSvYl518j@nvidia.com>
 <Z+GOkl21ZLtE3B/e@nvidia.com>
 <20250324170743.GA1339275@ax162>
 <Z+G67avxHQt5L+62@nvidia.com>
 <20250324204352.GA2734321@ax162>
 <Z+HQ2QkitMPVAtmc@nvidia.com>
 <Z+HcrI/rEoU9vNT6@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z+HcrI/rEoU9vNT6@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b71906-9a88-4540-2aef-08dd6b259c75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mAMbNnHhvNdYC8uVlnYpT+uUKkZHrxfGAv+ovTPO85x0npaflUxi9I4iQ00w?=
 =?us-ascii?Q?bpSvKeS5k7SpiN8LS6z01V5tcr9bIURHdUzAu75evPmfzsfnIQdLZohiVWbH?=
 =?us-ascii?Q?MgxpJ2soMmNjrMQ/nbBMkBZG90BhNc6F7p9RuDlpXOxiRC1oqhkyxFNLiKJG?=
 =?us-ascii?Q?n1yB+Vy9NvnfRk9x8XymjA9yhARGS64R7yKU02bCZyq4oZqKJYoRcaMg+ETm?=
 =?us-ascii?Q?uqO0l0M3NNmkLuqqIF6yiP4s9Bys0aGnjAECWUkM9r4EGswyFQLrY0PCO+sd?=
 =?us-ascii?Q?99sNVu7IHutMHFZot1K93w7cIRWV7E60uaJJej86OYUZNaASGTwnLhMsNTbX?=
 =?us-ascii?Q?Uui8gLAEQehKELNCwmUGMDMVxU2BTOO+kEjzhFkriLigU5lrWvkNg2R+90u4?=
 =?us-ascii?Q?y5rXnT94sRRAQYk7J8T3FefH+PjeBvbh2KwXuCwfQcVPZVPgZrJg9N+FAG4s?=
 =?us-ascii?Q?+w8q+WP3Rt5b2Vl5zpQY30bNSaF8cSKEc00jTEnKsXD1Cn6eKLQ849AyyX/G?=
 =?us-ascii?Q?od5YWjIHfmFncpoN1AYwBtXj4UPYMewAWKz2LlTc5akox2K3uwtatgJ5zirE?=
 =?us-ascii?Q?lQ8oi7gFJmWyja36zaU5p5emXeahmiYEJFquLyUeTGPqptkAsc0OPGCw8I+5?=
 =?us-ascii?Q?QiSPxPYZ3hisrcrdvP4ZKiVWPnpV3PBHZNoTsDYEjTuPKJb9dE9zbPYaVU7o?=
 =?us-ascii?Q?sLp0mldhFWGsSCW2WBPC/uAFEx8cv0b7cyGAPhP8ckwfbySFxQoSgE+p2XQD?=
 =?us-ascii?Q?kzXLDvMuWRSIWRAE0zjsr0zgGBITzfd9D4nMnkKIXnKQHP9IcHe541edJoOo?=
 =?us-ascii?Q?1ai8JaotEamlwNhyecv9c4mzll5Wl/5UHpJ4SZSk/YXVsFpD8MIwgwmvWjM9?=
 =?us-ascii?Q?iksiagNCWww93MHtzPZBHmNcrdmI2yDH8Qxc+nhqjyE9Hy87zQO4ihKGGKkc?=
 =?us-ascii?Q?A86Q5MJ3zxUv1uylzAd2WGbJXglrZ7E1yXbYseVNFo3aObOiQ/UE+gJb5JMQ?=
 =?us-ascii?Q?a4biUkFCTAlO96U3SROyx5EtF9WPeXSfugFygbtIrETarjJRQqYwk7uW9Jry?=
 =?us-ascii?Q?YLQxGF4F3qz8qTKQMwuiCn2MRSEdZ1I9ZyiTeizzMkqMFJQ+I+3yNuf/7D/p?=
 =?us-ascii?Q?2OoDhl+9VMlDrcEcG6j40Sxu2u4U72HODK95o3tiYIazwfCyK8qkKiVBQ1G8?=
 =?us-ascii?Q?1y0n6deQWX9aY9b8Jqsmko0stGKFCOEPx4taaGB2DcT0JwbfTHP7azRym6dg?=
 =?us-ascii?Q?MdC4+Dq/BvfP4dzsgIWKyQdupV5phFg/xLRapr76e0iGECse73KNki3BTFWf?=
 =?us-ascii?Q?9Hw0D1cuzW+x/9UqsvXCsbIyoB+0z4XJyteAxek1fJ6NDrfZnBAUCX8KNRbK?=
 =?us-ascii?Q?7gMUGeOUmdVSEfVne9DAdJndN3eKenqXwF5Lsbrv8NuAFD3Pn/HKvpjAgE2i?=
 =?us-ascii?Q?rqpw/ZDRbZEp1KFk8DwjxnqwYPm8QzwGtHYH+OEbS52DE8wgnDbCRJ5HDQck?=
 =?us-ascii?Q?n8lwnJFQMdXB+e0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 22:45:43.8114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b71906-9a88-4540-2aef-08dd6b259c75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720

On Mon, Mar 24, 2025 at 07:29:00PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 24, 2025 at 02:38:33PM -0700, Nicolin Chen wrote:
> 
> > My feeling is that we should just let all other cases return 0
> > like the previous function did, as this seems to be commonly on
> > the IRQ allocation path that shouldn't fail like this. E.g. if
> > we fail a blocked domain, would it retry switching domains?
> 
> I don't know, I think if the interrupt driver is calling this function
> it knows the MSI is translated by the iommu and if the iommu is set to
> something like blocked then it really should fail rather than silently
> not work. Same for a paging domain without any kind of sw_msi route.

OK. That sounds correct to me.

I will give the default blocked domain case a try. If later the
irqchip driver can still allocate IRQ after it switches to some
normal working domain, then we will be safe to do so.

> So, I'm feeling like we should check for identity and still fail the
> other cases?
> 
> Can you send another version of the series with this and Arnd's two
> fixes integrated?

Yes, I will do that. And I assume they will be still rebased on:
da0c56520e88 iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations

Will take some time run some tests with different combinations
this time. Sorry for the trouble. Should have been more careful.

Nicolin
