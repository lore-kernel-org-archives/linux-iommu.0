Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B8135A47
	for <iommu@lists.linux.dev>; Wed,  6 Mar 2024 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742260; cv=fail; b=dspxs9hgd0Pra/oSKi63f0ai/xR1VRQ+Gz3zXkXQyf6B/pOXNDEadp5iznv5wzsvIiQ/EJLMegtBxctcnsTw0bG/2L46CbcHasHCsaoemX6WHrlPziZZIqddRn6n78YAJS4GVBpiauFkMucYpdFvPm0Brh2gOVxfvX041b5ONjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742260; c=relaxed/simple;
	bh=KmB0fObh0SGhmCVu48uqx7L5bV9rWs1SFyP25RFlY8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rE1Sn/z+m/pPIQ7d5IXO3VcbUButkbjLQp3pE4LT2YMpBHZ7OyXeKbWEau5VRl1e5PlI9kyUXDCkTejJMEIb4UDQmW95Sv5RsRyPcolU+aBGBWdLSwIFcW51tmavPOiAmYukgFE8g/mWyK13rohccdn0+UIGomsAFWI1FlMxkL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PspIswRq; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PspIswRq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqCMxcttohemaQBGrK8Vjp+lh5DfEZI8EqxcYSLW+YDbZ1EAiCPXxWMdeIh9XcoLg+vbwoVAF1Ns0prr3uy/84AlGRIvcCpbes9DugPA3CTcNCz8ammx+kG40bLOXJ8wNHuK30ci4ExcgE/KarUBAvcrJAVgN1VBEg9qtLEzNVFK6WliqgcWS4T9SZ0CC1iPOq9mTZgH5kyr7bsEqD+MNer+wMWPWovAs/cZEYJ0NHJnUvJbV7hYUDN3QSOrCZ0fW12jDrx22fDkp76lforLclSBsacr5F58WmB9AGqOMeVZmsiupllJ3AImdRS6mW7vVtcaS2cAU33racwaStBS5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAn1C4jfzCm4u2CtyVWDnWwmPPmW1+nqu/+eu24/01s=;
 b=ODD3EXjpedGmiTOxtC5ymChNYUVc5YlYe3DWU+kDVi9p79q0proViw5oL0WgAkDNw2FtqxEmG+NoGiemdvkctQGWZSqkVbT571R4Y01W9/+m3THDSDSchIT3yAgsArHTsKDCE1yc/Qw9EzmmyHX+Cwtz9/qfA4v422eQ7eTRI46GbRVUlWdRjLGAReiQ03Wa6l8uCcJJnmwM4MfHVxe/sP6hvNDlllWrswy25PKKu6YEE3NAebaBt1659nDby1ad6RImOHhwswxTj46o45e8lI5AzHQWfBtsprzM1iZHMf1bqUYhI1/Hgi40eQaqEMY/b/R+SWU6oO4U0X1Sw7x47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAn1C4jfzCm4u2CtyVWDnWwmPPmW1+nqu/+eu24/01s=;
 b=PspIswRqjfqrVqgt87pqvjYD00mre6336Zb5EvFyn2P79tkJhyw6gOVCX+BloaJ79zBLz7pJmKMLiEwIH0JB7+imvC/MEJrdSw16xn6JEfgHyVwrASbZ3mV6+0Cow+VI63/7EO1U6dPDzPuv5OAhKekUSl9qDgtzU0TuBhXFec8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA3PR12MB8809.namprd12.prod.outlook.com (2603:10b6:806:31f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 16:24:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 16:24:14 +0000
Message-ID: <1c56ecac-496e-2b0a-a3b4-d9223a9924f0@amd.com>
Date: Wed, 6 Mar 2024 21:54:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: iommu ivhd0: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST
 device=0000:00:00.0 pasid=0x00000 address=0xfffffffdf8000000 flags=0x0a00]
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>
Cc: iommu@lists.linux.dev, it+linux-iommu@molgen.mpg.de
References: <f35330f7-ab03-4b27-b112-7a49eca3cd1e@molgen.mpg.de>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <f35330f7-ab03-4b27-b112-7a49eca3cd1e@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA3PR12MB8809:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ffc10c-7d47-4630-7e90-08dc3df9dc94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Cbehu6iBX4ypeSEw27X9FXgUOJj7rXBmvfoss5VD6R3jHnUA01j6d4Scxq5vUwoomBtSCOq6xdOjUoF0h4Nr+hmNQPvP8wqtsL1lCk2PYCyiU8RWbMMhhLme4mBTVn6Rs36kZ+76VTF3g4Nr/0FqvD4+f0luXXxVvmsTbuIcS+7LTwL2Wd12Ge5gCXMAKBiEcew2CTekqNAwW1pEi0+tdSfD0dYdz6fe5bHKKAV7g0GWfs59t71MxN8J6L6Fonx61tHkbodDdrXUTtscYGYbWNgIEtL1/qlmFKKdp7qJJhO4dp+WO17lBoWzM7YQoDsCt+TSdsK9LurInAt08ynSLdXZYGeq7kanVrPieipRgT69ta771/yhevRG84sh7qNlsNWuJ1fWxqzE4fYy2GifsL+zeJZgZMyx9Ajtb99cLA25k2A8hKpXDfXbTUG8xbDThPJFPPrQtQU/WuOLtFbHe247v5DsAhRJGMvVgVgv6iGTedjDeD5sjTH4egZDrssedgc7p2QpwAr0bG1Xn3hXkq1lqBKlrAKWTy/Efg/0b+iE1MjOIXOc8HN0i/RMVV+MvyUu0FNlaHG2kJa0xGLdSqGgQvEK3vUshNeDE+HSq9+RDFb2HX2zHjAC4KnoZihtP6tsFDGzY650hl5DEdsRkRyCTpgLquGqe1qgnoK1gw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3Q1MjlhTnE4WHVFSm9MK0UxL3g3ZEhiZEl4M1RKTW5yWVhtVDBXV0pRWm4w?=
 =?utf-8?B?TjJyVnBqUGtTTzdqcHEveVA5d2tBUTUzS21WRTZxbkEyQXpJZzBUTXBtRWds?=
 =?utf-8?B?Nk5vclo0ekJRT3pkdVdtOFN4NVlRWUtpMzN3by9qTkhKRmRTcEZCeDJuYSt6?=
 =?utf-8?B?dE90N281U2x3QVUweGYxa0xveENvQTVYKzlwei9tWVJMOUt3NWNGY2V6NkZY?=
 =?utf-8?B?UjFydUVWQWRzMTl5NEZaZWJ2YVk4cFBHbjdyYVNQT2R5RGRzSmdxNEh6cTUw?=
 =?utf-8?B?SC9ZWHBNamJ5dXBLVWxVd2JxTEQ3VzZJVHhrOUd3YTJneG9IdUl6R2NOK2tl?=
 =?utf-8?B?eXQ1dGg2YTRwcUJ4NVNseFNXb3p4NDVOSzlRRG5NZEFMRE4xTWsrME4xQkY3?=
 =?utf-8?B?aVp1a0syc0FqZjNPUFUwcHJnS3YrMEFDRHhmRDhydFhWOUdwbGdaZ09VdjF3?=
 =?utf-8?B?emFrOFY4amZRRmQvdzhCZm80ei8yU1hnblFCZXh4ckF0S2F1V2VjRFhGZFla?=
 =?utf-8?B?WXRkT0hsL0drZWlEK1pUbEdxekFXa0ppY3dxdnUrcmNXZ0JLMnlHQVYrRThB?=
 =?utf-8?B?ZERvek5NY2YxRVZ6TitDQU1OTlc1citBS1lOUXV2VUVwOTcxNnVqOE5BZzMr?=
 =?utf-8?B?RXRLUlRFNlNqQVk4WmdOT3dydTdCT2tCVTBnTklNUGlvQUs4bDZZb0Y5d1R5?=
 =?utf-8?B?ZkNqSGx5N0RiK0laelFmVFdvODN4OW5zbEcraDBoKzR6bkRiTVRzK2FzNStj?=
 =?utf-8?B?VnNGR01pMTU0OWgzMjByVG9qT3o5VC95UUh5enRjTEpUcXc1N1ZDVHJhNzlN?=
 =?utf-8?B?elZzdmxiVDhpaHFNUUhJMnJQVm1wMG5DVWo4YUdHM2g2RThuaFJCM3Bla0NT?=
 =?utf-8?B?RjFBQURCbjFNTk40dDBZYXp4WFhVVGNDM3h2RCthRzZsb3ArbGs4aUlxVkZi?=
 =?utf-8?B?UUR0RTdzbjc5d3p5d1pheFZVOXRhaDVzczZvcGxRZDI1bHZjWUVnRTkrRXpE?=
 =?utf-8?B?enF1cEZNNjlYTXlWNXNpdjgxaTExbXV2UTJVdkpmcG5QVDc2Wm1KLzgxc1FF?=
 =?utf-8?B?UE8veDZRSzNlNWk1QXRSWWoyV3ZHaXQyRXRGWStCVzByUHV0b3E2aGZuQWQv?=
 =?utf-8?B?UXpab0xJWi96bEREUGxnSElMaG1ON3d0ejZSNllBeWtGUDNyZDM0TCtxNUdE?=
 =?utf-8?B?R0FCSG9FMVlVRWZXbTkvbFFQS0VmNUp6M1lpQzN1TFJoOFNwMGkwRlFBcFNB?=
 =?utf-8?B?VkNoVWFEVkZqdVV0ekV2enJRMjl1clFnYnFwb2EzUXZLWlUxTnp1cUdvRytO?=
 =?utf-8?B?bU54YXdwNVFia2dtMXFURVFBTkFORUJmcStja3Z1K0FkVFpNQzBiZ1JwZFFq?=
 =?utf-8?B?b0F0cUM4UW85bnBPYWVaV2lFYUM5L3BZaU9jUHcydm5iWklWeHRaS1hOckNk?=
 =?utf-8?B?eGp6RE50NFB0d3plUnNZeThUNDBlNEJmTmtkc0FrV0FYYTVFWS9NbmVVQmJt?=
 =?utf-8?B?dEJPdGd4NWVTZkx4Ymo5V0lBdFg1aWZHOVVPcFRta3VNVkkvak9SOFZZNHVT?=
 =?utf-8?B?Qmw1dDZiSGEzZTdwbmlabzVPdjRxYURuNVBJWVFNNzdxMHNjc00wQVMxY1JQ?=
 =?utf-8?B?ZnBxOWVLQVVXRnVseStHdmxPeTZ4cGtCNWlPMkZENHRPOHorYzZXUlV0YVZw?=
 =?utf-8?B?UnY5V3BmSUpKSFZpYXJzNno2MjFYallRUWFhUWJ3bWF6SkRsSTZsdWdhd1lJ?=
 =?utf-8?B?ZEVVOXppd2YrTGFhU0NIN0tVaXB1L2Zmc2FxMzdUc2F2Y1pSaGo1RFVWVmxK?=
 =?utf-8?B?MVBiMkVmSmkyaXhBWE9GeFJ3czNSRTJCb0RLdUc3S0gzSXd6U1lWTlRXM0FY?=
 =?utf-8?B?U0FKRFdRVjFzb1pKYnM4V2VaM2I4MjlaR2FHL3FTUEllUEFHVEpneWJnY3h1?=
 =?utf-8?B?amlYc3YreENJS2owNU5rblhIbE8zaHhEVVRtazB5UTQwOXp6K2t2aldlbGNK?=
 =?utf-8?B?dko2WmNVWjJaWm5McFdJT3ZWNUM0cklKZXljZDNKTDdjVm1KMHNIV2VnU0w1?=
 =?utf-8?B?VzFGaUYrOUV3aHhIK0VEaVBYaVNOT3JMQ21MaDJUSngrdkc0cmNwS210TGNn?=
 =?utf-8?Q?zv5ItAREDEiiSZ+E3Pm7+X6qv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ffc10c-7d47-4630-7e90-08dc3df9dc94
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 16:24:14.0802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOmjdbOsL8/bmdkfYR/X1yGQkjcSF4rwr8Yf87kfGe9D2tllb5jHQEnn1mmoj75D/64fZI//N1Odecp0riVzYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8809

Hi Paul,

On 3/5/2024 8:18 PM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Dell OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 1.1.20 05/31/2019, Linux
> 5.15.112, 5.15.131, 6.1.53, 6.6.12, 6.6.20, 6.8-rc6+ and 6.8-rc7+ log the error
> below:
> 
>     iommu ivhd0: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST
> device=0000:00:00.0 pasid=0x00000 address=0xfffffffdf8000000 flags=0x0a00]

I did look inti attached dmesg. I see there is a mismatch in IOMMU Feature bits.
This is usually a BIOS bug.  Can you check with FW folks? Specially I am not
sure why they have enabled bit 62.


[    3.527391] AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
(0xf77ef22294ada : 0x400f77ef22294ada), EFR2 (0x0 : 0x0).

You are hitting fault with device ID 00:00.0... I am not sure whether this
device is managed by IOMMU or not. Can you add `amd_iommu_dump=1` to kernel
command line and boot the system. It should tell us which devices are managed by
the IOMMU.

-Vasant



> 
> Linux 6.8-rc6 and 6.8-rc7 have two other (unrelated) patches on top:
> 
>     e95b1c6891ad0 tpm,tpm_tis: Avoid warning splat at shutdown
>     3c71556daa75b usb: port: Don't try to peer unused USB ports based on location
>     90d35da658da8 Linux 6.8-rc7
> 
> Please find the output of `dmesg` attached.
> 
> The error/event is *not* logged, when rebooting the system (with `systemctl
> reboot`.
> 
> For 5.15.112 and 5.15.131, although reproducible *now*, I do not see this
> behavior in the logs from over a year ago. Very funky.
> 
> Can you see, what the logged event means?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> PS:
> 
> ```
> $ lspci -ttvnn
> -[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Root Complex [1022:1450]
>            +-00.2  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) I/O Memory Management Unit [1022:1451]
>            +-01.0  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
>            +-01.1-[01]----00.0  Intel Corporation SSD DC P4101/Pro 7600p/760p/E
> 6100p Series [8086:f1a6]
>            +-01.3-[02-05]--+-00.0  Advanced Micro Devices, Inc. [AMD] 300 Series
> Chipset USB 3.1 xHCI Controller [1022:43bb]
>            |               +-00.1  Advanced Micro Devices, Inc. [AMD] 300 Series
> Chipset SATA Controller [1022:43b7]
>            |               \-00.2-[03-05]--+-00.0-[04]----00.0 Broadcom Inc. and
> subsidiaries NetXtreme BCM5762 Gigabit Ethernet PCIe [14e4:1687]
>            |                               \-01.0-[05]--
>            +-02.0  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
>            +-03.0  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
>            +-03.1-[06]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Cape
> Verde PRO / Venus LE / Tropo PRO-L [Radeon HD 8830M / R7 250 / R7 M465X]
> [1002:682b]
>            |            \-00.1  Advanced Micro Devices, Inc. [AMD/ATI]
> Oland/Hainan/Cape Verde/Pitcairn HDMI Audio [Radeon HD 7000 Series] [1002:aab0]
>            +-04.0  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
>            +-07.0  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
>            +-07.1-[07]--+-00.0  Advanced Micro Devices, Inc. [AMD]
> Zeppelin/Raven/Raven2 PCIe Dummy Function [1022:145a]
>            |            +-00.2  Advanced Micro Devices, Inc. [AMD] Family 17h
> (Models 00h-0fh) Platform Security Processor (PSP) 3.0 Device [1022:1456]
>            |            \-00.3  Advanced Micro Devices, Inc. [AMD] Family 17h
> (Models 00h-0fh) USB 3.0 Host Controller [1022:145c]
>            +-08.0  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-1fh) PCIe Dummy Host Bridge [1022:1452]
>            +-08.1-[08]--+-00.0  Advanced Micro Devices, Inc. [AMD]
> Zeppelin/Renoir PCIe Dummy Function [1022:1455]
>            |            +-00.2  Advanced Micro Devices, Inc. [AMD] FCH SATA
> Controller [AHCI mode] [1022:7901]
>            |            \-00.3  Advanced Micro Devices, Inc. [AMD] Family 17h
> (Models 00h-0fh) HD Audio Controller [1022:1457]
>            +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
> [1022:790b]
>            +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e]
>            +-18.0  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
>            +-18.1  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
>            +-18.2  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
>            +-18.3  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
>            +-18.4  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
>            +-18.5  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
>            +-18.6  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Data Fabric: Device 18h; Function 6 [1022:1466]
>            \-18.7  Advanced Micro Devices, Inc. [AMD] Family 17h (Models
> 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
> ```

