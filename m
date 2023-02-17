Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2064.outbound.protection.outlook.com [40.92.90.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01233746A
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 15:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/JRRlAtFHH2cViiqAzbG/M068Quz+4HdXrRkUR97gvySOf2gMJLI5wo91EsGLNSNgGqdrUlyU4rYfd6z3Ci8PNJpzh/hEb1gNG9m1ir9amkyI0r9y6vD70VZI+p7yzftuf1/A1+HeJEiAMKu4qOHlDpFYzWNbhWaD3rRH116AfEdu1K+PBoUJ2IpQU0d10BzfgAzflSCRmp3Bx4TwONnkuSnJirL0J5Hl/Nu1erN3zont+yHrJJwYnhiUKExh7L89eZ4duMOo8meCSTTSZTKs4KVT3EMAG0LUPzZTAWE3zLDqx1CHw9KwoBYKtBOpWMZLSsdZeev8EXODNelP17Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZsd6ytTH2WI7cOE6VQspA7+8gSkudD3t7NRWOZcdj8=;
 b=m2BdrBTwZIln2lQHx6FIyTyBa2OqnvEcjGeeqMELXBt3BeMLFGQjtj5SnkW5WzABHXC2CI2Dqmc6cx4dEErlLhxh9IcQ2i97p1DekPxsiVoaxmV6EIOasvMr+nGiVFGY7gNlU98i3Dbx+CFTzBnuMWI3mT8YEH0ppi01NiI6HRL8iO3v2e8OQ3uAqbDncl4I3QmI1Jp/b8SrCJEHFABDbLMwX5FiHKzD77lDlbOiSJN0NcOduyQZxm8z2jbuwQJW7LYG1+NhNl7uvSCaPog18F6oNus6GjXaBaCgUHPWHcHyGRvK6dO8vIMg3hqEAG87UxW4spHVrkemOTnzbrgRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZsd6ytTH2WI7cOE6VQspA7+8gSkudD3t7NRWOZcdj8=;
 b=YVt2lFKyEcz1WXYs+KEBisZmZMRNYRhouEWZkH2jllY1pQ9jKQyJikvk6qgTCWLIqxfTfsE7dlVSR3Dn9NjN98wxIqRIqxMP72bu8DKna8XuH+S5p3z2kO2GmiGwLZhYwSc+tJBy7SvvDAeXz7IB6SPRmyzEUh4lHgEGImC/lWi0JESl8wSEUx1BXz62JlgJXBva+ulSlROHKzAikm4O0BYrVWBu0K6TBa6KVTLbPsCbdJfk3F8uG/NNfoFrG44rcyVnbfHyplJAaYP9iO+HVlm/CUBa0G0EPvLqEiGqS7xecjpt8pjOp4VRGGjwl3m+SzpILYfZy2841TU/mMtCbQ==
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40e::16)
 by AM8P193MB0948.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1c8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 15:42:15 +0000
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::3d5a:43b6:acd8:3be8]) by AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::3d5a:43b6:acd8:3be8%8]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 15:42:15 +0000
Message-ID:
 <AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Date: Fri, 17 Feb 2023 16:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
From: Martin Bayern <martinbayern@outlook.com>
Subject: SR-IOV on ARM64 system with SMMU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [HEQyI8WxSYaZE1JxqiGVd9BaQZcKdPrZ]
X-ClientProxiedBy: MR1P264CA0080.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::26) To AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40e::16)
X-Microsoft-Original-Message-ID:
 <a1555357-75e0-96cf-ab31-904b81a07cb8@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2095:EE_|AM8P193MB0948:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a73952-57b4-439d-79ed-08db10fd8b3c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ufcmdFZU+VD3j6HNRU2LYL6ut76H7mnS8k6Vvtga7RhfvHD0zAlunBEQLw0K/4DB/d5QNLaZhJDC9Jnf2Jaes2510pI/9crvUuwD83AM/pN4q2zso+vAoOpOCTeAHTgsetHszQQqEYbFAUsBzdqekVr46B573engxk5x3JnAu/jlpz+mBhurRiYat1zprdHJLcdCDDsa6oP0qPQarDjMyIHrp3KeZffISXg149/ItgZ8vJatmSpVOrYA8flbqo3NIip99CUr8hyRt96tR+vkpa0+aDyW9E3reHXMo2BKzORdS5WnYo+Z0IYmYm5BTouPaSyUBnM6K5hRDCSbDTRKRrRlyzckma9Xd0az+HOpWSiBFnnsH/TAMXrEdqREzlF09oBU3LI4bbU5X43JWLMablKIN5p1Y7oh9geNCshDEO/VH2nyJZJBuXh8JDZHLNL2Ss/euub5T0vEulAMnDzBihJGvR2tGMuX+Z2u9cqD509K+KujBaRiaCgeWjd3zCPoM14CdG/dXOJCDw+J9jsZoX1ycy9uTmV/+mrpgCLKC+ueeSbQGH8OvQTPjTAKGT9PmbEKunKgakeO9/LV10Md85Nr/l8YAxhly3F477wUJnI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnRWRXM5bUU3OXozZlFaU3F2MjRtRjB2bm84TjY1SFFmUzFHYXQ0dkVsc0V2?=
 =?utf-8?B?UVBXRE9XNDdPeGk2aXJsWnNQQjN4SXhVNGZlT2dRTFBsOFZuTjVTUzFlZHA5?=
 =?utf-8?B?WVlaZXpDQ1Q1ZGswbXdSdlJsb01lZEYzUlNxU3dtS2pMYkZxRG4yYml4U1lu?=
 =?utf-8?B?dWcyYlI4RnExazJVS3lmRWU3QzJMbXlTcFFtdXRPek5DSE5PWkRETU1zdUwz?=
 =?utf-8?B?S2JYV1FDTVkzL25ib0FOZjJwUTFvaVd4UlRTSHRNY0VnbG1PSjRVeTIxL2ZD?=
 =?utf-8?B?bUJFUlE3RmpLSDdMT3pZc0ROV3RWUis3VFAvV0hrK1NoeWFVWjkzVW85VDM3?=
 =?utf-8?B?SVVKc3NTQzRST21RL0lxYnF4bFVkL29GNlkyRGpsSU5pWm9IcStkL2MwMTBQ?=
 =?utf-8?B?aTlMTWRnQ3dtQTNTLzltd3lZUVljSU9vVmJNS2VXVi94UVRqMmZNMUNWSXJu?=
 =?utf-8?B?emxRZGlQUG95VXdSbjdNUzIwR3pVRFhqcHl6a2tHKzc4cnp0MVdNN3FxZHpG?=
 =?utf-8?B?TWJkaUJGUXNLMjhXRVZ4NVd1VEM0RmlwdzJzK1E2b1RKNEh1dkhkOFp3eTNH?=
 =?utf-8?B?ZGEzUHFXTFFjS2lqU210ZDM2eEVMeS9tdkVGV21UK3JKUGNEVkZlcEVlWS8x?=
 =?utf-8?B?Vy9PNUY4QVBqNVFmNCtWNmxZaldPYUtNQWYrVUwxZmJEUkkzVkg3Y1lidVdH?=
 =?utf-8?B?T2s5NmsyYzJNRlFSZGxpVW5kNFZ4SnhOWDcyYVBUaEFxd29VTXc2NzBGbTRI?=
 =?utf-8?B?WW1hbDBMQmNPMi9zM1dpR1RoZE5hOFhhNTBTdEhYZHVWV05sUTBsbWN4MUto?=
 =?utf-8?B?TmFtcHUrSDZTbnpnTjB6b1Q4VCs4b2ZOamZFQzNZZjd1b3o0WVA1L0NJTGQ1?=
 =?utf-8?B?Tk0vQ0FaZXNNVkdxck9SbWJlcHR2R1NSQnI4UmM4aUh5emdKem1XLzdTeVNV?=
 =?utf-8?B?YTg0bjhOTmpKN0VIQXRWMVhHV1FRYkpSMmI0Ky9yT2RUbGVQdTc0WGhLbEdT?=
 =?utf-8?B?dU5QMlpCN1VmTEI5MXZjMEx3R212OWxubzVLaVpZSFlZU05WbnczSnJxa1lq?=
 =?utf-8?B?V3NQMThqc1g5RHYvNW43eG9vV2MyQXFzSnhGQ1hsU3BuYVNybE9JL1h5dUJn?=
 =?utf-8?B?ODZ6dHNydUhiOVU0bGRYY1VWZXVHQzNwSzQ4TnV1dVZtb2hHUy9ZZm9EeEJ0?=
 =?utf-8?B?V1djTHBiTlNZdzR1TTVMcFdrZDBWUk1aRlFlT3pDeTFQVG9CUkJmSlIzeklG?=
 =?utf-8?B?bDRtZWM2dThaSFVQSVVUMjVDYlRmWUI2dFJYTmZXSFR5RDhXdDBqazhpT2Jl?=
 =?utf-8?B?YmRiaUY4N2dRVTN5dDM2ZHFFM2t0WXowakRDdmJzcC9qSTYvcnltR25iRU84?=
 =?utf-8?B?Y202Ny9UeWhkU0JGQXd4M0VVclBPWGEvTWd3MkNtblJwWmRjaFp2TmpFT2Mv?=
 =?utf-8?B?cXEyMU9oQmJNMlhpU1NjbnVhSG5UY1J6Q1B3a05jZkZkb2R1Wmh5SXkvQTcy?=
 =?utf-8?B?VUJzRHRwUVMybnBydk83cGpoYkMzQmZHd29oQjZtRjNoL0ZkdHR3dG9kZ0ln?=
 =?utf-8?B?OVlVS0sxT2ZqY2kxc3VpeVk2MHp3aTgzeE5GQ2QrRHVKQ0RBNU5vSHlmN0FG?=
 =?utf-8?B?WndMbTBRcEVwaVpPMzhRWnU4blh6UFJGWUlDR09zVm56TUdib2N5NFkvUkhH?=
 =?utf-8?B?S3o2aWdlMlRJcnkyRzUyUFJnZXVrR0lPYVBQOTFMMjZObGUxRWt3TGgyZk50?=
 =?utf-8?Q?IS1CMr5GVDliWLG994=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a73952-57b4-439d-79ed-08db10fd8b3c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:42:15.4792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB0948

Hello,

Recently I faced the challenge of enabling SR-IOV on an ARM based 
system, PCIe devices have SR-IOV capability, I enabled it and created 
its VF, "lspci -nn" can also list these PF and VF PCIe nodes, but the 
command  'virsh nodedev-list' lists no PCIe node devices, and the 
hypervisor cannot detach the VF from the host, attaches to the virtual 
machine. I checked many blogs and papers, it seems that for ARM-based 
systems, we should use VFIO-PCI or pci-stub module,I tried these commands:


sudo modprobe -v vfio-pci
sudo modprobe -r vfio_iommu_type1
sudo modprobe -v vfio_iommu_type1 allow_unsafe_interrupts=1

After that, the problem persists, do you know what else I should check and enable? Does this require ARM64 chipset support SR-IOV? If yes, how can I check if the CPU supports it?

thanks,
Martin

