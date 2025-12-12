Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D3225779
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 12:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765543286; cv=fail; b=o7XjkuK59op8x1zbOjihb950XzYnVSMhNhCpNujHvb3nTUUh617bhD8T5wLwJfFQVJJXepk3hytJpxYqjhuYKkPTzkcke8eazIW+B4INs6MAkQ29YNCQy2BBUhMLrsq/pRop5xZE2yDRVZc1F0eYcDZj0PzWytQE+2nCLt8PZNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765543286; c=relaxed/simple;
	bh=hchuaQsqyosZTZ0n7hiPEx3U/ZIsJpUyUtZ02d4ztrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C/IJw/UwbTJvjYmiS3Gumz/hsR+RAkpBu6zz2IL5Ytzb2PptYf9pJ5WNa8S2WeLh1Py3v/AV/wdNr5gcWYbP5kCuC1Sb7OPgzTaTR0LNB/5zUmdRkuC81EJIAQev+3Jxr1OtNXEwloFo92oNL3Rf0RQDzw0pnWOaHJ6TrpaOHCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UyeigaL/; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UyeigaL/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XH+SlqkLSDJsrmaN7s93M2jpCF+O3v4J3NbrDDwAmzoCIvweMkCMyWvNo+5rCxega/BAxTkCkqYBaoGzezbN+KUzq4mDq3JPvNahCjv1mtNA9mw/0F2v7N8q2/cqJctnCWJ1vjr+1wJi66OfBkhv2fFMlpbyPhAiELZ8M3aYEACkFY1TGmP+uF5SwagclIzvaJx+dXqoS1Ll/VHyYAJKldo18ztI2VOEW8ZNUR0NSSm9TOP8WoNyOjMEHn0p6PgEygbadcQv9Su8HMHWVBdzWsAv/uWqWlOP7PTIIHzmYh/aMxJImVkwo/Bx6cfNVGGatTpotryCrItIg1zhVEhGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uH48VwI1KXSK3qTsMKxc7CT7tRYWVTK+xfzErUO0yQ=;
 b=WpfUZAAxa4gs1+TU9olG5jNDHQdQBzSHla3CDiXFC28vzsqUVsEyy3JwNqUGjQTp+AId9EWOMHTxj/SOfz/otDV3AY4OqR2kaMZNlhHBB6cfOShgdR2xe7mMN8vnmS/mriD38VcIPw5a0ISNLg3uDM0i3xtGDJwyTaqbh7GTpnSr03Ed+8/AQFq7H39BLXT1gY7VOWmQYM93JBdkRpuqD6K7wRFYyNo4nnbBOGe2TMVsiOZBaW6q7gEMRNDKOQzzQVBuUgGkXSJOa3hsylMeK/SoLK35HSRNQubFrBOZz1Uf++T7n+rasTWHz6AM6GiLwNEfLhh/lm84Q1CZzsnWfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uH48VwI1KXSK3qTsMKxc7CT7tRYWVTK+xfzErUO0yQ=;
 b=UyeigaL//F4LmCFtSlPujPCl5lezdhda3p+xAaYCqAqM/xvzGMXeu5d8pPN1W2x7CJ/nCE3x3Ud4KpK5trXYdJZ93xJSO1I3sU70SOeFE7eLp/UJT8pjrW3gvDa6oD6e59nt9VQoqKAkZuYMbuzxJ53FwNi/KSoke8VhaLr8VgzHHPJ3qAnw2ighNgdBIgpUbaYp17CxBrpQ2YZhX8qPXSf6TspvXT+QsKHu58kioKd8e6wjLW/IudEpB0UnN/0rJyGS1Z0/C+TNyxmF5jEsTaYuz92MNXDhOmgcWOTJTK/ZvN190prRZXbDjwd0jspAmo9yzbiUrh/7icYt7Gmfcg==
Received: from BL6PEPF00013DF9.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:c) by CH3PR12MB8259.namprd12.prod.outlook.com
 (2603:10b6:610:124::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 12:41:20 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2a01:111:f403:f901::7) by BL6PEPF00013DF9.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Fri,
 12 Dec 2025 12:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 12:41:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 04:41:03 -0800
Received: from [10.221.129.214] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 04:41:01 -0800
Message-ID: <716d6455-0c0f-4005-ba47-f4222d935465@nvidia.com>
Date: Fri, 12 Dec 2025 13:40:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow stream ID sharing for
 devices behind PCIe-to-PCI bridges
To: Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: <will@kernel.org>, <joro@8bytes.org>, <nicolinc@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20251211133933.4128100-1-nirmoyd@nvidia.com>
 <aTu4xsAApNupRGYC@ziepe.ca> <650659ac-22f0-4fc0-ad43-8d4169cf2432@arm.com>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <650659ac-22f0-4fc0-ad43-8d4169cf2432@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|CH3PR12MB8259:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d725c41-e9ac-4307-08c3-08de397bbff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2N3K3JNSk9od1BMakphYkx1TGgzQzFEZU9jNko4N0tGYlZYRGxpMmpqank5?=
 =?utf-8?B?L2NyUVFHMVMyOWZTa3RtUWc5VW5zUTFPSEdZMk4ydDQzcXJoMWVld0dXNERt?=
 =?utf-8?B?TXcwM0JRV0NFb3VGOEtWWVRCUnhnbG13TGs4YVpFTjg3TFR2c1AzYlR2OGpF?=
 =?utf-8?B?UzJMdXI5TTdMYjdBbW1WZmk5NXhrMVdFcjhTcGU2aUY0UUhLWk1jdmhKdVR1?=
 =?utf-8?B?VGJJUnI3aEZRK0xnSmZLWmY1VTdublprUGNOTWt5azdHRTlEblBjcmR1cE5V?=
 =?utf-8?B?eW4wWTJUUHMzdjFCNm1QRks3V1Z4Wnh4QzJmUmdZQmxEWDBlN3ZicWZlb1h2?=
 =?utf-8?B?MStmQVhYR2Z4Y2IzWk5RdTg2eWxZYVlXNkhreXBvemR1WDZyT0hJM3NSZDlT?=
 =?utf-8?B?S1BNMUtUYmtkTGtTOTE5RTY2THR2RXArenh3NUhwM21saDgvb3JzMFI2dXl4?=
 =?utf-8?B?bTRxVm5BZEUxOW5NdXhtdCtIVlFzWTNIMTFibHZ0b25wYTJHVDlHRUVMcEtW?=
 =?utf-8?B?cHVMTTY5S1Jzb1JEbWJZVCtvZEJRejVZWVU2dVpHWVlLaEZ6TFhBd2ZrSFBS?=
 =?utf-8?B?aDdtVXYwUS8wb3VPdFhBd0FoVXRqeW5TdzJXbWg5OEhSNjNRc1lSTkJQUys4?=
 =?utf-8?B?TTBWZjFFTDdEaEdvbmxsMm5rMU1WVzJLYVJaUHVZWWY0ZC9JdkdwVFZrOXZ2?=
 =?utf-8?B?aWFGTFpOYzIwMzRQVEJnbE1mT2hwNnQ1clJxd0FKTzNHVTlzTUFXaGZkMHNj?=
 =?utf-8?B?TFFhdWttN2tMQ0xEL1BmM2F6eXBaTDdxbFRJWHA2cEEwSW02ZnlKanpYQWd3?=
 =?utf-8?B?YmVJUG5vWUU1cjNDamZPL0Y3VnV4MVV1OTdGK3d2WllGZVNxNndxVkVVZE0r?=
 =?utf-8?B?OTYycnlGZWVFMUxia24vMGxtOVFHOTJweXVNZ0RTYTZzTGRBMVVRaE9TOTl2?=
 =?utf-8?B?Z05nbE5UVmJPdlY2QzFGUlZ6alF5SGwyT0kyZUxsVkFHem9lczFLcTJSZmdJ?=
 =?utf-8?B?OFdIeDV3blZoc0xLemNKRXVURDhuRXBqWXBJaTJYSzllbEdOU2NzbmlwdEJj?=
 =?utf-8?B?c2JBeXVvQWt2NHBMRnhicHdLTURKZlRyYVYwM3RBTUZLaTVzRVlVaDdnTnQw?=
 =?utf-8?B?VVBKbDNMb0IrZVdpRkpCTnQxcnFndmc2QVdGT29QWXlRcmJYbEhPb1pzVWVo?=
 =?utf-8?B?alo2SkRTcW5XN3JOMFJBN2JJMjRXVlE5eHhoNmNvcHBzL3lqakorcWhqV05v?=
 =?utf-8?B?VldOK1ROdzF1ai8wZlVaTm5aNU9UcndlcDgwUHo0R2J3T09zb1AyaWJwRE0r?=
 =?utf-8?B?Rk1lWXpaclJlU2FyRzRtRmpwWk5UTG1YNm16aTFWdys2ajl5VURWQUNqSDRo?=
 =?utf-8?B?WFZmekk3aS9BdGZQaXJ5UUE3czlINXd0MVhITitPVlRLMWN6NGFCcEFXbG0x?=
 =?utf-8?B?Z3gxVWV2QVQyVHArSldGc3k4SHhGWWpHc3cyVnErMXdMUXR4ZlpndXlEWGk2?=
 =?utf-8?B?R3hYSTEzRm5ZbmZzL1FIT1hPem1Ua2J4OTFsZGl6ZE85dkJaNTc1VDl2UVdz?=
 =?utf-8?B?RTdlUDFtRVlDcjBWQ21XdzNpSXB5cnE2dXFYM0ZCb2tIK3RpL3VycW90V1oz?=
 =?utf-8?B?akEvOHdCR3lYeEwxalBKUi9xVEw0dmZpZXpaTmhDUXVhcFlGN3JMYjEwd1dM?=
 =?utf-8?B?a3JPYU9GNnp2RFZwNnFTMkZyMjRmZUhyeWhMZ2FYNzFSWDZxYlQ1MCtYaGVJ?=
 =?utf-8?B?a3loMWxIaXRSUjN2M2xpUkNNdFF5VUxWQUNWYTZMV0tGYitibFhhUnBwNjRp?=
 =?utf-8?B?aU00VWhZT3J1Z08zblo4TjBNUHBGM2pEMUczeDRwK1N5RVYrN0VNVXNSSG5M?=
 =?utf-8?B?Nzd3Z1hJaitnUTFXR3c3eFM4OUZCTUdHUmVQeGN2UFB2V3F3Y282TStmWUox?=
 =?utf-8?B?eUVSMEFGM3Q3cnlLamRTbWM4K2t1RzJmbHFFdFdidWU1S0JpdDd0NWVlQmVR?=
 =?utf-8?B?STBhYlJFN0k1RnZEangvM3c3ZEN2Vm9xanRNcWpUdzV0SHM1dnZwRFY1bkox?=
 =?utf-8?B?UTZsYkhFOHNLNHVpMmEvNUV0cFlPSm1BZmUwQT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 12:41:19.5547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d725c41-e9ac-4307-08c3-08de397bbff4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259


On 12.12.25 11:46, Robin Murphy wrote:
> On 2025-12-12 6:40 am, Jason Gunthorpe wrote:
>> On Thu, Dec 11, 2025 at 05:39:33AM -0800, Nirmoy Das wrote:
>>> ASPEED BMC controllers have VGA and USB functions behind a PCIe-to-PCI
>>> bridge that causes them to share the same stream ID:
>>>
>>>    \-[0005:e0]---00.0-[e1-e2]----00.0-[e2]--+-00.0  ASPEED Graphics 
>>> Family
>>>                                             \-02.0  ASPEED USB 
>>> Controller
>>>
>>> Both devices get stream ID(0x5e200) due to bridge aliasing. 
>>> Currently this
>>> USB controller gets rejected with "Aliasing StreamID unsupported", 
>>> causing
>>> USB timeout errors. Allow stream ID sharing when both devices are on
>>> the same bus behind a PCIe-to-PCI bridge to fix this issue.
>>
>> I don't think this is right, if you actually need stream ID sharing
>> then I seem to recall the driver needs more changes. We don't want
>> this in general.
>
> Yes, as I said on the last one not so long ago, we cannot simply cross 
> our fingers and hope that aliasing at the SMMU StreamID level stems 
> from something at the PCI RID level that pci_device_group() would be 
> aware of, because there is no guarantee that RID->StreamID mappings 
> are 1:1.
>
> Thanks,
> Robin.
>

Thanks, Jason and Robin for your feedback. I will reach out to ASPEED to 
find out if they are actually sharing RID as suggested by Jason.

>> IMHO ASPEED has wrong PCI config space and there isn't any actual PCI
>> bus here that would force RID aliasing to worry about. I suggest going
>> to ASPEED to find out and confirm that they don't actually share the
>> RIDs and then let's quirk the PCI devices to disable alias generation
>> in the first place.
>>
>> Also, complain to them to fix their config space to report a PCIe bridge
>> type in future devices. :)

I will do that :)


Thanks,

Nirmoy

>>
>> Jason
>
