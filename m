Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012033.outbound.protection.outlook.com [40.93.195.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C792F12A5;
	Thu, 26 Feb 2026 06:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772088538; cv=fail; b=a25X46hwBypJQkbnO6WNSWZIaQvWsHk4HiTr5IC4H768MZRxpGrn1JotxtKMcDlFYTrkAAUf9AtaCVvDcxDSToBj/JeATlG90JbPG27ft4FDbWDBe0hHGJ4CFHObCas5DbCYdtpvq/mDmI/wfIFU8Se4pvZqpkcZ22sNX1bl5rg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772088538; c=relaxed/simple;
	bh=Ru4N6B0ozp+eLmCLLP/MpNKtXbffDHBX69/3HbVTXas=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVCdC43fHBeK0iuHPSsbaoSI7UG+W9ni9vIG3F2K5GWh0OvNCQvzwoXQbKbWNc7GWevXSwpFdoi0B/feJa6chMw4uMfEnvYokgvC/vRjPqFtwc4yySZVyITjJVwFN066XBS6PE49LPqiN5AnKsyZGCu8+CZ6JrYLBK2f7TcPGyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eGL18J7t; arc=fail smtp.client-ip=40.93.195.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eGL18J7t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hD/hOHuSEDzlFuzDYu68DlMHTY6MM8ufh+Kso2y2hxgxFfFaVBIzL4hyqwacdDLFXetktO6BCXGdlYUnWpL3nF4DV5tGIA8y5qtSdl/ZP9TUoeDk9uG+wSLS6cRuKEwF51JWTYKcMGbBWb3Y9rnVQpO+jlvu7YT/0G6fTVmgrLbeCpKP2jNV6Re3pLXYQiUX82WEAlq0B3tUB/iwfB4M913OZzrpyybVDlyKez/nGBYD201+c9dd7KXv8CMLSTSxwndUg7Jy1lp9LKLD8rUCUB3yQqC9lR+fdVksmWyZGez7RJNKES/rdITEqOh2+UPWHiQWWgXCTAPrrejibaPfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV7p48PZC3GxaqRhb54RUPh5Rf1SymrxJfuqwOm0e2Y=;
 b=ioJsFEzLzJy3ncEgvEVFYjAFMPEm7bkgNuWs48O6rAOVFOZo9Zb20Jj57jpKtURN4mfgvqclX7H99knXzt19HPGQImisbVbx/19bUCn/z526hkKWA0pZqOAuSyeVRP7gAP35Ngln+oET8uVAmmU4GQlmLksdQrpvngjrYWFjCmktmTsGK/BuPXX4OtzNDCi8S8e0cwZ1XyHIpXE16BovWgkAijk3CBtfskCfRcnjfva6TwTnRvLB92knu9oiJihtx2WcVx6DFAKkP4iMnccOSJZrA3YvjKQPmMZU/TCa2z4Ixahj2JyICgDQGs7IPYN1NmiePj87JS6iicJk/rnRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TV7p48PZC3GxaqRhb54RUPh5Rf1SymrxJfuqwOm0e2Y=;
 b=eGL18J7tLexjJOKkZSqqg56vkGXW481HIjYBt+egJ1zrvgcsVsAjgvpIYI1D2P/UoNW22chAKJ9G4il/mUkgNxPVnv06pyDRw+YKzZL1p8h+GsD/n0ejGK9YK2utFhrHHGBGkQm8tVs5cxMjgR9XDfClOYXpQPRP0zY05AsjuDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 06:48:54 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::1e6b:ca8b:7715:6fee%4]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 06:48:54 +0000
Message-ID: <fb10affb-40d5-4558-b64b-0ab22659ccf2@amd.com>
Date: Thu, 26 Feb 2026 17:47:50 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH kernel] iommufd: Allow mapping from KVM's guest_memfd
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>, Nicolin Chen
 <nicolinc@nvidia.com>, iommu@lists.linux.dev, linux-coco@lists.linux.dev,
 Dan Williams <dan.j.williams@intel.com>,
 Santosh Shukla <santosh.shukla@amd.com>, "Pratik R . Sampat"
 <prsampat@amd.com>, Ackerley Tng <ackerleytng@google.com>,
 Fuad Tabba <tabba@google.com>, Xu Yilun <yilun.xu@linux.intel.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20260225075211.3353194-1-aik@amd.com>
 <aZ7-tTpobKiCFT5L@google.com>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <aZ7-tTpobKiCFT5L@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:208::7) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c215c5-ccf5-4f19-97c8-08de75031b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	zobeLmWOaASO+BM9dHXDck25GKfIMOqlfZuPinhwgkYciTlVsPJrRP1KZTZVEL1Zfm/a/qeg1s/izBojZAP9pb92NowLAlpX1ZTJAz0opB054A4uLJexmZdikoBdzpZMVfePGujI4LnMFT9WySZKuncxiIdqk6bVr/cKvQvaa0pJTki8pkpU86tUzie0SCKXd/ZzeV/J8C7CuDfSh0hlADlF85G43Rh5WaCNgt0Q1D5zIYEyQL2OZXNv0yRMKsxCpEeMbgUqEFgW3eYhfkmxIm6gcMa+Hcm43fwwXVYtW4hrh+A3PJYjm6zFDrMS6Tc5L1TKFedYHNAIEFOdnnzfSHpFxO0T9F6dW8hjqEIYxEJfgE2EYRsucEvQU1Opy232px0s4e26giFq/6HWURisonBXkTZmcqh1CddD1cPzQSeZl+/4xhuovG5VRzujxFfIlYSrSOpkmkMzr8M24YziqifuNCCOi23tPwNTa0ir+g07T6DSePmHzpH+u8I/5m8w0WjhY6PCy60iSfriuqowUomrJUZpYfUQfzJHcGt5moNzrVa5UQN3x+jzGThLcH0xOc86878bFTP95c47fjdr65LkegQnFZWe62vLcFZvPLbRQYrt1f5Ml7A5H3VzUqv/SFCrlBGfQTAjCnnQ09vAJkYzkCblOakvD7qXKP0S3h9Z+mKO/JYIw1Tm2V4Gs82yY1PH0eXmWUWcyW3tzXZRL7jUxtnHCt8WwtvrZr6zZg0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1J5VG9ueTFaYmh3SW41WFZoVUxXeVR6ZWh0N0tQaytGWVRnbVNRQkY4U1Yx?=
 =?utf-8?B?SEtqSGlVNWxxYjdXNzAyV1l6TVBCTFY2MG1LS09DWlNxSU4vYUZnZWZLQWRy?=
 =?utf-8?B?Zkt5UUQrb3RzeUhYdFJralRSeXRub0ZWMGR3UHgrTWU5T2ZsQTN1MFVUMjRN?=
 =?utf-8?B?RWxHazJWa2IwT1BteFV0djlHbDVyNE9xbEpOL0Z5SVlLZ3NtOTlmdlZ5Slpq?=
 =?utf-8?B?Y28rNENGL0VOcFNkdXJ2eDJ1ODlIeTZnMDZvVnBTMHdSVis5Rzc1dDlYT0Vj?=
 =?utf-8?B?UjJKYmFrd0hVczIvclVuNXRDaGQ3MGh3K3pMSFJuaWVvbG5LVEtBbjBmay9o?=
 =?utf-8?B?U1dSMUU3RmszM1VvT2x1MnpjYmZwRjNQMTAwV1JLeGxPVDdPSEFteVRxMUVX?=
 =?utf-8?B?TjByM3M5cktIZFJ5SXZBK0d5VGlsY1crbG1nb2Izb2lWQnhzckNGSEY4MDBY?=
 =?utf-8?B?bVVCOVcvWHFycCthdVhCY3lkbEtkWVFia0h0SnQrQnBneVJQcDVRU3A5SEk3?=
 =?utf-8?B?ejNJb21Da3dxOHplNlZ4MVJQYnMzSU04djRjbUNEN2dpUkJZM2FRUzlxNGh6?=
 =?utf-8?B?aHEvMHhuSlN6VkV3WHlZSkdsK0VPMmgyNDM1bGprL3RuWkRwc1M5enZpRDNP?=
 =?utf-8?B?M25kbnpqMTNISWM3cld4N2hZS2RoNFFyb0hNejBNbE9weDlmVlRTNFRoa3pE?=
 =?utf-8?B?YlBUK2Fyck0vTHNJL3lZY3dkUzF6MkhPV0Vjb3ZocWM3U1VxVmZha3BtWGts?=
 =?utf-8?B?MHk3MDBxcU5VODlmV0I0QWEyWlNlbFNNYldNSjVkS3FjejJaeVVyYVpQVHVM?=
 =?utf-8?B?R1NqQXMvTGpnc3NzQVNRTTl3ZmllQWpWN0NqZmRuOFpCcWRiZlo0M3pjV1NT?=
 =?utf-8?B?c2oyZzBuRks0RVRIR01LQWluZ3VHaUpLTGZLVUU4dkFwV05PZTV1UWFMMlpt?=
 =?utf-8?B?aDJKMlRUR0lOeFhRVXVaSDBNbXAzY2RGR3NSUFBzL05JRlE3WlBISTh1RER1?=
 =?utf-8?B?YWJxR2ppTXVQM2JveVY0UnN1ZCs1cVpJNDR6ZUI1VWdKbmNkL2RQS2lsMnhU?=
 =?utf-8?B?aGJiYjRaV1Jqd2FqY3g2L214Z0RLQ0NScVpKbUp2RXA5ZnRsUDFMUjBwTXFO?=
 =?utf-8?B?YzlnOVVVWHFONDZNcTZuL3JpY3VDUlczQkIvVHIyc0hSQzdkMEtlMGlVajZH?=
 =?utf-8?B?NU9ISmx3WmZWakdsQzVzazZrdkNVWEtNb2xmMUlRYlNvY1hoVkNENmF3NVVl?=
 =?utf-8?B?VXBRMCtremhKNFhZL0NrUkVDSVJrQzVrVjJxeVoyTnBoZlJrVDVPMDExOHB4?=
 =?utf-8?B?a3M3SDdCNlErK3BJZ2FmVEk1TGVGNEl1M0NFRThpeC9YRHpnN3ZXd0dHTEVw?=
 =?utf-8?B?ZnRrSllZcm5Wc1hUWXlyUlJ6RHhOcGhOanAzVldaS25iSjQxK25DUXJBbjdY?=
 =?utf-8?B?ejhvT0VER1FOUmZocXc2bWsxY215VVJ6eWpUYVJibytVSjVLMUxjNjcwVTBq?=
 =?utf-8?B?N2RFdS82OTUxWlF5K1VUQnNCcnAwRjZ4WUJPVlErcytQVWZUYU5xTk5RRmdT?=
 =?utf-8?B?b1JQTGN5THV0UmxMZ0huQUI0QVEzdmdWTG1rZ2hYbms5VTlFaDEzaERlQnda?=
 =?utf-8?B?SVU0dVQ0OGJVRTVUV1V3cmpEY0VXa1grWGEwbWpZVGZmaHFjWEQrdlZoUkhP?=
 =?utf-8?B?dHVwek9mMmVyT2VVZk9FcERGYWdUV3VrQ0FmTmU2WmY5OFJzUXdHOVVCdjJH?=
 =?utf-8?B?MUdqb1o1ZzkycDZYMmEvd01DUnExNjdFOGJUUGY0TVZPN2pyTitNTVU3YjRP?=
 =?utf-8?B?UTBvME01UUIzcHhDS1lMUGpjVForTWZOZ1hhS1F3VkQyQmpRd3I5YjZYeGdN?=
 =?utf-8?B?cG80VGlJNldwdDUzSWFmRnczWGZsb3BPR0ZrR2FReCtlMUZ5QXBYdHpUT0pJ?=
 =?utf-8?B?cXdqbnlNbHFVWUdmcElJZ1p3NUIvOXJ5VUNjRG1WalVwVmpqZG9tSG1mREFk?=
 =?utf-8?B?ckY4L2lsQzUxV2VyTncwMTQxOHlRQys5VHVYVHM0b1JuMHBIcyt4Z0tONFVo?=
 =?utf-8?B?UTBxWWRVY3FUdFJYWGRxQlNpWC9DQWFNQ3BFeEdNbDVNZlFkb3hJcXF1OW1q?=
 =?utf-8?B?TU5GS2lDNm5zYkxQOHN6bUk4SjhxWnRVcU14MDNOOVRhM1VSSnFka2gvMVZQ?=
 =?utf-8?B?Nkd5TWx6VkdXRmNPMFBrT2NpZG5YdEljRzI5NzhEakFNdDQzVW1HSWpyL0NC?=
 =?utf-8?B?UU1CSUxPTVdyYmtxQ2pFUWhubmRxaU5yc3V2Ti85eHowaEdEQ0thOFNFTDNR?=
 =?utf-8?B?Q3VhVC9uMlkxWTZYc2hIN1NVN0t6RkJpc2xXc1VBVzBlSEhhRG5xUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c215c5-ccf5-4f19-97c8-08de75031b49
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 06:48:53.9538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OjlhYldE2q/phEUnvFk1E7U8hTQ23AXbrEdMCakdgms+KGLdtatVUoUnC3UW6R+b+aPOUf+F5CCOSBnC3rwL8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635



On 26/2/26 00:55, Sean Christopherson wrote:
> On Wed, Feb 25, 2026, Alexey Kardashevskiy wrote:
>> For the new guest_memfd type, no additional reference is taken as
>> pinning is guaranteed by the KVM guest_memfd library.
>>
>> There is no KVM-GMEMFD->IOMMUFD direct notification mechanism as
>> the assumption is that:
>> 1) page stage change events will be handled by VMM which is going
>> to call IOMMUFD to remap pages;
>> 2) shrinking GMEMFD equals to VM memory unplug and VMM is going to
>> handle it.
> 
> The VMM is outside of the kernel's effective TCB.  Assuming the VMM will always
> do the right thing is a non-starter.

Right.

But, say, for 1), VMM does not the right thing and skips on PSC - the AMD host will observe IOMMU fault events - noisy but harmless. I wonder if it is different for others though.

Truncating gmemfd is bad, is having gmemfd->iommufd notification going to be enough for a starter? Thanks,

-- 
Alexey

