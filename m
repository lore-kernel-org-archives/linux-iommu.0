Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1822C11CF
	for <iommu@lists.linux.dev>; Wed, 14 Jan 2026 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404234; cv=fail; b=lvNPr65yvb2MSfhyQid2VfOsLptaNE2QFmpfbA3eKm0i0guKMwAk/wyBce7AhJT2m1ydyzN3vEejpy49qjeRByhT2/VdKLOW44NZHKGIielOToDsypl4vjeL1B15sIPk26+4bxUZy6imppCtiyU0+d+AlcPs3DiPgiSUlbZJ6nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404234; c=relaxed/simple;
	bh=HnZqH/KlAQgeKGpOaKmkIoz45S9um98lB0VF4Qx5hII=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JS/Ld2Qe/nZDhTxh+RyV13IEHxgr1a/FnqOflkOIyDnkwGx2jad7KGLgAc3NzbB9ahuL9SnlJdaPvExGD1tvHEgaeshlDaQiqS/iQykJq+e/XBJD0xVuXkQRnOSgmPu8vYuTVAMn9RHyfEWWhKleIkIM0YWWGTzg8xTGYSPRFfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GmyQQ2L4; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GmyQQ2L4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7gG1e7QfqSi4JK5meDlyFJDzZQxNvcHrDTBDdj5SOlXEFqDu5nsTXe8EA58O6IEgVU+PzOnvSCdXk4GlkcKNsAPl4N0jdkid+2EbCx7MySfzVREKSWpruwilo7qs0EHGStU6Ys/gVvhCXrtUEXtZE3aPVsHp04MIVYi6hYZ6+drZoUm9+FSkboJrKuTVED9wn3DlS8gYiC9zeev5TRsiee9ZuM9zIeb2mcMYREjmIgoLk7PKJ8B0Vz8fcmSaINbYLdIAnVgfcfPoaB5mGAEPrpUyeFWvfVYGp928lLmgw+/miC142RRrUvf9nfnwA0wx0LmABvAFsUDRjpZKf4EJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRqCVDbW4Fc9YggA4xftrxd+ZGXrkwNIgYqDMkB77O8=;
 b=MV7AUBfc9R4swNkZfB9WxlkqphFIk7vA4a9uA3Z1NbYjQb7ZMENtHUTo8wR2QsIklYbMQ09lET7D7qVehlK7FtnmZdttg+evYPBqNEDgqVTcrRlQOLniXO48FRe3QZwu218wLu/Y0CDgFPf+k63vF7QAsAlsXyLYq2ppumxAszgm2BG/pbb/00k5uGeABDBmpq63FBvtobBOk8CDsxFbuyEdxAHPApV1K67gv1LWPH9mUW8ApYLQbiIIB8Bzq4X/+SW1rapLImnhf9qQL8yAS6+K2FSfObUiKFZOtWtqLcbSC5bZfmuiiAC97yk1OWqgyrGz+6OJGcM/XnBrKuHp2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRqCVDbW4Fc9YggA4xftrxd+ZGXrkwNIgYqDMkB77O8=;
 b=GmyQQ2L4JDom78zu6x0V+5o58Vgcn8KLmf0k4/krBpadnYTJztWXPEixDG3HYAn4Dvfj12H+w1mRHa8ZDNaayf6BEP6z17aQCS4CUc5JMzV7bg8lhzumyodM+xZFqeEtwNxuNH6J0t8klmObmp53xGVjtikz1mDJs6mp4+8IId1wfTRkMeXY7vrPRrfDgkLRGPqZK2KbKMemihKVoxjllHx99RjqpUY/jiWsswgT9hoPQnTxV4i4T9xVq1XsCZtuE5ZVSbqFFDUrTHiFGe2ECB+nWwm7lIhNoS24KVspGb237cVWQ6n1b2ipog1oZJHVFWbWRUeqWvSjVK5ou3EfsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 15:23:47 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:23:45 +0000
Message-ID: <aae40f1d-8518-4eab-aacb-335d9b44c9ee@nvidia.com>
Date: Wed, 14 Jan 2026 15:23:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 2/4] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: Ashish Mhetre <amhetre@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20260113054935.1945785-1-amhetre@nvidia.com>
 <20260113054935.1945785-3-amhetre@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260113054935.1945785-3-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::19) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: d962451a-f2ac-4c6a-99c2-08de5380e87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azY0M0Q1S2RUa01kNEozTnBscHNUT1FuNUc2RnVRbEpQY242eUVqS2c2L09Q?=
 =?utf-8?B?L1FTTGsweXlWSWgrT3hLc1RIM0J1VTQ5WXRhQ2NYamF4eER1UWNVZm1Ccjc3?=
 =?utf-8?B?WFBDYzkvTVI4SnBCRHVWL2pXOTQ2enlncG9xUEh0UVpwL3VsU3ppbG15ejhE?=
 =?utf-8?B?T1hIeTQvRG0wKzRXYkw5Vkc1bnVGd3N6bmNFc1RKckVzeWFSRXlleVN6cUoz?=
 =?utf-8?B?WVBpbk41OXFLRElMN3NsMHBEUW44TzBtU3d4RDBzVEtvZEwyb3B5ZWJFN2hu?=
 =?utf-8?B?d3pVRVRER2lmWEF6enFjdXBTcXpGTkZxOXdNZXM1VHQyR1hTL3NaSXBiYjRK?=
 =?utf-8?B?WmFIcUJ4azhzYjVOdllUZ2tTMFNGdVUzSyt6RHJaV2lkcnAyejhBRzAxdmpy?=
 =?utf-8?B?S3pLODl4dm9jUlQ1SDNtc1QvK1g3NE9mVFlUT3Q4Y21CKzFIVmVtWElQY2Fv?=
 =?utf-8?B?cWJOb2pyeG1ZOW5lQ21ScnFJY1d4ZVRuMHBoODljZHEreU1rN0hhb2RubmNQ?=
 =?utf-8?B?Wm9ua0oyNmg4czBiQlY3UE9ULy9Rekl0K1MwbmFVZWxYNmM0YTVqRzlXVlV3?=
 =?utf-8?B?ZmVobHhPQk9ROWowQzA4a1dXQzN1akQwdWlLeWVIU3B1NUs1VldydENFeDcy?=
 =?utf-8?B?U2hlTHBvRG9rc1BxcGJraGtrK0FSSzBCdllQQjlid1BxLzFmY1F3bCtlNGFS?=
 =?utf-8?B?WFI4QVk2YTB4ZWppTEpPUlhLcmNhdklsT3NKdi9jRS83K1NZcmlRTTh3MUxn?=
 =?utf-8?B?VzJBRW1UZW1Nb051OVlIQnBsQytBQ3phTHRZTmIwOCtpVE1PcHdSbnFkZEJ5?=
 =?utf-8?B?QU1uVm1QR04rMlYwOFlpd2dYWVlqb1ppY08xa1oyZllhRC9kMjZZSGRubkRz?=
 =?utf-8?B?S2Q4bzM0WlU3bWdxTTdsMHlDL3ZORDA4MStxazBHVzMvZHVCNGIweVpwMjlY?=
 =?utf-8?B?a3Z0WTJmR2NCenJIT3ZrUXJrTW42MFVtR1ZPMVpWeWFVRUJQZTJDV1hDa1p4?=
 =?utf-8?B?amhTVElRVzdnTzdGMlJRZ1RPN29QOG9JVEFJMURLblN0K1VTNWpraTNHZFpD?=
 =?utf-8?B?S0s0K2tKdENnVVNselY2blN5K1BKdUc0bENQZlgwRzlTbWF1S3ZRdi9rNlFz?=
 =?utf-8?B?ZnF2czZpbitIUHZnbEtBRGVMMVdBZitleUE2UU5sSVA1UjUycnA2Snh1b0ZK?=
 =?utf-8?B?TzFocFE2NjdiYXJFWWdPbTRNUmhPTGs5YVZicmxWU1hEK3g5SzhzdXZNc3Bo?=
 =?utf-8?B?dUUwZ3pZS2JtWU9yMjUxbXNvOHMzSmFaSjZOTmxWZnByVlRsSHBlVExPc2xT?=
 =?utf-8?B?NHJyOXJpaC9BYnE3ajNsQUtXMy9kVm00bWgvVlAxZExMTld3YU02blhFOG9K?=
 =?utf-8?B?NG80RlRNbEhmcWJFNHY0SytmR2xnTWl3V1lxMktqTWY0OE94cFZ2ZHVOOEZi?=
 =?utf-8?B?R1pjaUFZNUZFcXhuSXk0cFhiL2ljTU05SGFGa3ZQZEZhTWFuNlcwUjNrU3l0?=
 =?utf-8?B?YmtseXZzYUdjelZDbWJVNnBsanoxdytvbURtSDhyUWgwVTl0QnFiaSthUDBW?=
 =?utf-8?B?YjF1UStsU3dCR25qenJvZkJBK3ZqVUxYRHl6UmVqUW14VlFJYjEvQTV0Smgr?=
 =?utf-8?B?ZllUTm84Z3JMNG4rTUZGOHN5aHlpNnd3RTNGTUMzamRoS2VKN05VejYwM0ZY?=
 =?utf-8?B?Vk9Zek0rZTQ3MmZ1Y0NRSGpLRDJCSmxYZnNSWmcrNDhMbVd2NWI4eHNTSDJN?=
 =?utf-8?B?VlVpOGVzRXZFQnMwMzJYYVc1Q1diZTQxTnEvNFU5N1lFUU9mTkg4Si9sYmhD?=
 =?utf-8?B?NzY1SjVrQzZqR1BpdEp0dEFLNHVvUUVpR0dobjh1M0x5eDg3clVwdFI3TDZi?=
 =?utf-8?B?OUI0ZUViY1lGRzNEcnZhRmdWcW02eUN5ZUxjanNkSVFHdUVPckdtZGl0d1Z6?=
 =?utf-8?B?QVIxNis2N0RGN2h1UzBkd2ZiQTVHRkw3b3dVd2JiMXhFOXV0ZVdtcE9HVEZx?=
 =?utf-8?B?elVkU0FpWXBzZGJCY3J1QmR4dXFDL2lyYlpSdVRlMVFIRHJhR3lSWEVvMkV0?=
 =?utf-8?B?NDd4NFlzT2RINTloWGZNbkZQa2g0ZXBwZXZFNmNuTS9tUFAyMjJKN0xwY1BG?=
 =?utf-8?Q?WgrI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDBZaUp3Wi93MFJaS2RPa1dHTExCQjNKTmQvSHp0UHlZM3hSL1NST0lvTklN?=
 =?utf-8?B?d0RMTit3VXhJVXFweVB4WnpHaG95MGhpWjlUa0VaaXpZd1I1OFdXbFpvM3NH?=
 =?utf-8?B?a2hwM1ByWTJ1ZlkzK2NxbUphV2traWdCdlh5SmtZMHhoTU5HR281Ty9CZ055?=
 =?utf-8?B?SHdxT1laeFZ3VkE3NjJKUk4wOVI1RFZteDlyS0F6S1dya3FDVE5rbkJ5cHVj?=
 =?utf-8?B?VnBEUldnL0FqVEtzajVOTDRkU25xTDN3VS95SXRiSVpzaXZ5TDVlNEpWb1JX?=
 =?utf-8?B?bVh4NTFHZ0xVR2VRVmF5TmZLc0xPekt4WVg0Vm5WYXhoYzcvL1JuNzNzL3N6?=
 =?utf-8?B?cnk1VnduMERBUlZCYjQybElQTy81bnBQYTIyMlA1RnB4ak5adlpGamJraExh?=
 =?utf-8?B?S09rMFYrVHozWGRsOTQxVm0vczlIT3RtbFdJM1FaTmxSZGlYYlo2TS9wSkpr?=
 =?utf-8?B?TWU1aUU4K1RTQVUwYUlIMHNXeEp2VmdHb0NkMzUwdDgwVkZmeDYzUUl3aUV2?=
 =?utf-8?B?UHJyZmFzMG1wQzFtWlZ4WUxqdjVPcWlHcXBJTGY0YWMyTk8rRFI0OVZoNEJo?=
 =?utf-8?B?T2Nxc1NMOFZYZVRYbzRlb09JNFZ5NkNkSU92TUZ1VWZNNDQvTDUwdllXRnNQ?=
 =?utf-8?B?QThDSEh4TVdWSjIwclc1UTQzTTgyWjNIYkR6NFlEQW1waEkySzdKYVdWWmtR?=
 =?utf-8?B?WUpJTEtsSktrN1RCSWIrcXF5dTRUVE93cEpXNnhKazdtRDlkUFQ3UG5ubHhN?=
 =?utf-8?B?dVJKamhrY1RMMzE5dnRIRE1SU2VJTFZhWEtyVUR1OGc3alhRK1VYbmt5Tmp2?=
 =?utf-8?B?YzBxMnp1R2JWTVk4b2wzOVJ4YTZDS2xHVWRmVXJpL01FMExoVFlTaGk0dU5v?=
 =?utf-8?B?L3NyZ0VpdXlkZllLRE9vVGdndkxrTEFzNTlDdzZLZ1NnL2JId0F3bU4xMTVX?=
 =?utf-8?B?emRCTE1TdThVY1RhcjRuK2F4TGxIVGt6U3h5ZjdjeEl3ZCtnV0x2V01jTjR1?=
 =?utf-8?B?c3pVOVoyaEFQTlkvZnhlakVZS3ptMkNnRGpGWUV1UUsxNG1uYTNaMStkTnAr?=
 =?utf-8?B?VUFBTHQzMDhoU0ZRN2s1ZHBGN0V0OEE5c3NkR3JSaEdMbUJtQUFmZUtXYjZY?=
 =?utf-8?B?b2pBM3dMdGk2WFZxTytZQmN1RUJkMUpldlJRcWlxT3EyZG1PRndNNjlqRHJ5?=
 =?utf-8?B?cE4rY01YVWR0N203Y25MSlFaNy9JcE85bGJmZ3RacFo5c01SK2lSa1RvTEJE?=
 =?utf-8?B?a0RnanNZOW1pL1ZuUG93dVQxV2UwR0NXTVZENkx1cnF4c3hXa3gvQW5FU0Nq?=
 =?utf-8?B?TFVJUlZ6U2lYbTdrZUdQVmtUb3ZrWE1xejlDdGFaTGlDZFhHZnQrcUMzNXda?=
 =?utf-8?B?WmxscndHbi9IckVHajJpVGJoYnNCODNmQUd5TDMyN1lzOWRIY2RndVdIQVA2?=
 =?utf-8?B?QWg0dWNQcGNscGIvaDREWnMxd0FPVXpLVHFRNmFqaXYwQlEwdWY5LzNKcmpq?=
 =?utf-8?B?TXNCckVRSVdWQzBNVEkyb1ExWGZPdkZxK1c1RG8wckg2VjQ3NzNpTjU1VzB6?=
 =?utf-8?B?S2wwSlJxZ00xV29JOUExSkZjSFhhOVlENTJ3bVp2WDdaZWc4ZEhyZ2QvMEI0?=
 =?utf-8?B?eCs1aDdxK1plSVo0SEZaNFJHZWNQVWYzaitBNjNPdlZXemlUd2NlUUxvV0kz?=
 =?utf-8?B?MERSK2xkZVFUeFFjQWVCbVpoekVxTXFqN2dmcWlwZ3R3eUhzSVNCQjN4OUxv?=
 =?utf-8?B?SEpINzM0YnNuZ0Z4RjhXZXhYWllTNWF1L0FNMDVBQ08rZk92d1RLUW9NWEhT?=
 =?utf-8?B?dDR3VWN3aE8zNWNScEZGd0VmUkpxaDFzeE80NEpXOWVldzV6MTFsOG93MFhZ?=
 =?utf-8?B?eXU4NEduVUpxcTI4KzNPTWdoNDg4V2gxeVFFd1RRR0o2b0U0MEdVRFh4ZGlS?=
 =?utf-8?B?d1RkVis1UDN2WVMyMjdqVmxFQVlCZG9kRWFrakdpanFiOFhQWnlBQXRwbHpJ?=
 =?utf-8?B?R2RGUGN6emxRRWxwNjFzcnhQejhObEIzam9MaUE1MjdOL2ZaM3ZlRUhadkQ0?=
 =?utf-8?B?THUxeWMwVVhUUFM0SUtHNFJhT3ZWUUhlVFo0RXIvanJjVGlzdHRSdHdvMXIv?=
 =?utf-8?B?RGJjbDJzdWVRQ01xUXU1cGorY1V3dEpUTERnY1BqYXluWFdrYmRnRTBzOGxL?=
 =?utf-8?B?RW1lbk9PeE5KN1VlZEZqYmVpOU4yUmRSN1NLMnM5YUVpZ3ZJci9UY1h3b250?=
 =?utf-8?B?SW5xSEJnVUVrUXFCWnhXMVFhMjBYZG1FOEU3MjZFM2FwQnFtaWgyaFJ6UlZo?=
 =?utf-8?B?cU1JTmpyYkg5UW0wS3Z4UWVXT3cvcUFkMzZSbUhkcStUMitpeFMveGJGSWVY?=
 =?utf-8?Q?1iYiiTwLW9bzEU1dZdlcYeNu48LSRqShYWRgC++TtyfsI?=
X-MS-Exchange-AntiSpam-MessageData-1: 9EzleD6vApWhtw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d962451a-f2ac-4c6a-99c2-08de5380e87b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:23:45.5616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbXuJlI8sQS22QygKURO5GJGgYrvt9WreDW/dcjCVxZAIT1F/OeED+Ag0+NnclyYnsWPfkot3xt31sWrKnHeKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769


On 13/01/2026 05:49, Ashish Mhetre wrote:
> Add device tree support to the CMDQV driver to enable usage on Tegra264
> SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
> device tree node to associate each SMMU with its corresponding CMDQV
> instance based on compatible string.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
>   1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index dad3c0cb800b..8653c52977d7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4530,6 +4530,35 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_TEGRA241_CMDQV
> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
> +				 struct arm_smmu_device *smmu)
> +{
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +
> +	np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
> +	if (!np)
> +		return;
> +
> +	/* Tegra241 CMDQV driver is responsible for put_device() */
> +	pdev = of_find_device_by_node(np);
> +	of_node_put(np);
> +	if (!pdev)
> +		return;
> +
> +	smmu->impl_dev = &pdev->dev;
> +	smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
> +	dev_dbg(smmu->dev, "found companion CMDQV device: %s\n",
> +		dev_name(smmu->impl_dev));
> +}
> +#else
> +static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
> +				 struct arm_smmu_device *smmu)
> +{
> +}
> +#endif
> +
>   #ifdef CONFIG_ACPI
>   #ifdef CONFIG_TEGRA241_CMDQV
>   static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
> @@ -4635,6 +4664,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>   	if (of_dma_is_coherent(dev->of_node))
>   		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>   
> +	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
> +		tegra_cmdqv_dt_probe(dev->of_node, smmu);
> +
>   	return ret;
>   }
>   

Looks good to me!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic

