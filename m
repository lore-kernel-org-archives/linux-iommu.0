Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C283595D
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 05:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768280988; cv=fail; b=sR1MVxcUmSN7yhi7CedzLVThNP79FE7LQ/4VLLZY+ntImNtlBu0kGkd6Vwy0BzSLWZnZbm1TgF3qoaT1jDtBWFG3VR2X8zmTQ4yU8WYAyjwYHnZL49cNn8QOhvQr3RFPEClJ2g4OXCNHt6xlecn7GIOt3c9Tav6ia+yhqMxdR7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768280988; c=relaxed/simple;
	bh=m0oZm/eUvF1iZrj+s2Iry+Sl17YH5Sq2TE3UMI2qkWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W9SdfTbkNkMWqaHHoS5JEm9klnfa9bJjy2J8q51LlCe0HPxuf9FrQi8m9GYcqNM4JB5gUgX8bZuyEmhF/GRUDDs+cSBR6zwVYNfRQbUH6cLJnk0KdvQz00pg+CrZfNGufxQqfrsg94Ud3dTfFB/KrjcXqXBp6EKgQAl8VFTkQ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dT5RO92+; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dT5RO92+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsw6zLL30AQ4W4tUF0kRDkYX3IN9kn/nFVyW/RfXVfdWYFpSIgQaDO3Kep5N5g3gu3qa8t5byIhwX/X4N6ReGcuhZnXmDlnBpIDtvNKOCakuudcrEotF3XejSzvp4ixIr6iUAYZ3QuOVQstv5NXAznBZarfopTSywmZwxuzIJnCR7tlqMezO6L70DTChPgqxR1+X8OkWK5xo6bH7cgFbu0dRhwZfcn7ri0UBA6DFFAA5SX/m0IMqOCA+SKFW0zaeYmTQszqO/U3CA2vwu/I1Bk/1EseO8LlTt6Fqtm6VidF63n6dp9nzNni58kNSHBq3tFXcehzF7uNkLbsumw5VNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOh8SX5QAM5e8fotGJqcoUphPyKDR0HCUfoxIyjSo+k=;
 b=q+TnwFrcOoOZBsa6/TJbV0EB4M0HKFom2XQXe0qaJzNcFxd+hVfgdw1z80m0CCkFkFUB9Tkr8vPFyACjGEKbHn3zGMd+pJbMCrxOn0esfSZT3fmgtUoeKuuggb7NulHLdzsRA42MUQI/RnXXggNt51UmylI7GN8wid3BN41L7oBF/sT4k+xRIUCU/zpnDAVvM6lxSkRHqtnVjEHHSru0O4P9B3tZ/AylV1olItu+JIm6jYIpH3oPmBT0IIE5fKJJ4KTXCZ3oC2ysHAMicd+ruItlJHCszHxJI3Aqwmeqe28gdNHhVTq9izRy1gzJHok0gLg6UIYWtmGtxk1Ap0Q+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HOh8SX5QAM5e8fotGJqcoUphPyKDR0HCUfoxIyjSo+k=;
 b=dT5RO92+QyYNUcKOFBZtKuAucyN8Uzkt4dYJTAUrMo3AnPOsY0QnhoITAm4Y5r0LFYD4lbGGnseRuXhPp6cvQVl2tANA7vfW4ZTmYoEYH0Lb2tQTZBUbuXhmIJuuvCX6EFFf+Z7x2kpNqr+QZ3hDK/7PnnmfpyAJzfbjCm59t5jDAw6TQA5yYJldoQWwi92/U1V0lTNz7UBGtvKtwaWAizJwf5xsRNXwhPvAJ4KE8iCZ+uIyN3DYN5wnlk8XGlj2y42DFLJFnJoqnlYSmHZNkjmkMZNZYQK7v8myU/lXqetoOHstRbDTZtsurn3XN2+xwP9MRdtr+GUkVwdWiKuRjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 05:09:42 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 05:09:38 +0000
Message-ID: <17aa80a5-08ce-4aee-b7bb-7310b97ea9db@nvidia.com>
Date: Tue, 13 Jan 2026 10:39:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
To: Jon Hunter <jonathanh@nvidia.com>, will@kernel.org, robin.murphy@arm.com,
 joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nicolinc@nvidia.com
Cc: thierry.reding@gmail.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251215064819.3345361-1-amhetre@nvidia.com>
 <20251215064819.3345361-4-amhetre@nvidia.com>
 <fbde672b-611a-4d81-ac05-44e434bf70ae@nvidia.com>
 <38364cfe-8fc9-4ed7-9034-4e67584ee965@nvidia.com>
 <9c13e838-6fe5-433c-b361-7d19d1b2ce1e@nvidia.com>
 <4488ab67-8d41-4095-a1b3-a109e6392890@nvidia.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <4488ab67-8d41-4095-a1b3-a109e6392890@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::22) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 939a3b7b-447b-4b3e-f7f0-08de5261f375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2FLL1RocU04WWV4QStLbHRqc3d0VmxnY0NaVWIyOEVIV3Z5cGE0WVRvcElr?=
 =?utf-8?B?WlVlU0tvWE5pNFRZVDE4NEhSTHdBSWw4YmltMzBnVjBIN0JEU25tV29JL1U3?=
 =?utf-8?B?anFBSXdqR0ZVaHh5cThZNkt1MFltbGUyMGE2ZHVPMzJIQXNxelVMaDkzOGRL?=
 =?utf-8?B?MUJyQTZ5N2g1TzNFeTNBRFRxNW1xRjNKMmtyT1J5UE9GbzN3RkVmTnNRUWhu?=
 =?utf-8?B?bmxvcjlEcVFpNXFrcmFqUXdoVjZhUVBSaEFMV01KWTFVb0ZlY1RRcnRVdGgv?=
 =?utf-8?B?OGcveHhncnVqVU1nNm9tcU9JUHFWbDRaViswZ0NQdFJnZ2Rnc1lUL0F0TCtE?=
 =?utf-8?B?WGhDeDVyS0FqTXIvaTVwWHpGVm9VQWtUWDhReVQzbWw3N1pFalNxKzRFZ3Vp?=
 =?utf-8?B?V1pSa2hDd0tGZXZzZFRsSjUxR1ZVdkJpR21seUpOSVdSQ09lNWlZZG1UZFVn?=
 =?utf-8?B?VzFCemo2NXJManhDUWoxbTh5ZC9IeHlMWmdLVU1Eb0VhN0gzSHlVOGxib1dt?=
 =?utf-8?B?ODEza0VpL1R6bFNXaGhhelhUMmN4SnQ5Z1FaY0JSOWp2ZVNURFRtc1o4aXpy?=
 =?utf-8?B?djA1ekhjZHZ2b2hocGZHbm83cTEyeE9EUnkvN2YreHJPZFFVKzh0Rld5MmNu?=
 =?utf-8?B?WjFOeDk1UkY4MUlHaTE4Skk4WHduNHkzSjRVazlUckdjZ3A2VWtOaTg3WTQr?=
 =?utf-8?B?U2JiRElsZ29SaWpjZXlITUNSUjBVT0c3LzRvZjdBMTFhSjNydGd6U25CUmtQ?=
 =?utf-8?B?d0NpMlFWRXRZdEVmYk1GRlUzY0JrNGJTemRmaXEwK2pWYTBROVkzbW9BRnha?=
 =?utf-8?B?NnVwWHdzQjRGUmE3WXQrZTZ3TGtQMllkOFpqTGhXa25BTWh0ZEtFNEdsT3pX?=
 =?utf-8?B?YzlBUVplWkpMb3BYVlZJUjkwVlB5Z3ZCOFZiVUx2RUg2aytTaVZETlBEc3or?=
 =?utf-8?B?SUtTbm9zUzIzaXRneFo5VGczd05TUEJ4Q1dhSWlDR1VUc004Y1N5VUM3UVp1?=
 =?utf-8?B?WFcrUmlIU2hNZUhnaXRFZnlycFR3Vk9CMFREQ0pzMFhwOWwxbW5Tc2w5L2FT?=
 =?utf-8?B?SnhWS2ppaFlPNlNvTHEzdjJpNEl3NUpyWmZKcTk1UjF2cll1RFNNMzJ2ZkVD?=
 =?utf-8?B?dFRGblhsd2h2bzRqeHU0MHNzemdBdHNYZzVEQnpBbUNPQVUwMy9Fd3YxWDVY?=
 =?utf-8?B?aTliME5lcjdneCtWVFBybFloYkNOQ1cwNmJLZ2QxeVZla2lST3ZLakhKeDl2?=
 =?utf-8?B?TnorbXNMejhRYnVNYlNUNmxEOHhXZ0NqeE1vNXcyL01TWkRLSXJhM0c1L2Mw?=
 =?utf-8?B?ZlU1alRRSWVUVzV5VGNIYzhER2U2VWdLS05hZkhXVW5yNTBLMWFQREJsNXNP?=
 =?utf-8?B?OVhQbzlKV0owODVlalpCRlladVNuR0pEQjgzNUdJamkzcUFBYWhqaHlTRWcz?=
 =?utf-8?B?cC9Pc2xMeHhXM3RkZGs5cnJGQXNJdHM1bjZGRC9VSXhkNi9uUER4NFdRbE85?=
 =?utf-8?B?SGVlLzl6OHpsN2ZNbk1QeDlFVWg3MXNJUURGa3NsbXN2QWl5MmR6RkNHdFVp?=
 =?utf-8?B?NjE4VTZ0TXR2NHVvaE5HSkFRLyttUVJUSUJ5OTVuNkF2TlVYU01ZdmprRUda?=
 =?utf-8?B?UjdvNnZHSkRXcnd0LzB4dlB3RXdtbFZidjdBbW02ZnFxUktYMVVBenplTWNZ?=
 =?utf-8?B?bHZqRjJNakhWSjBqdDRsS3lIbUNMNUU2U05EcTQ0cHh5WW5ZdlRCSEw2eWJo?=
 =?utf-8?B?aDdyUi9uQUFHeldIaUxNZ09jKzJ0Mk90M1FlSzcxNkZlV2g3ZHkySWh3MWFz?=
 =?utf-8?B?WkZLaGdzUG5NT0J5TmJjdE11Qlc4SjByRU1EV3VFOXFEVmh1OUZQV2R3Ui9F?=
 =?utf-8?B?WGd3aTRLaE91MXl4K1JFWFNsSlpGbUhCZXdZTnJPb3VRWHdlUmZYcm9rVzNw?=
 =?utf-8?Q?NUN1kk5G2lXcjiWWMfpmu1MvOzW4x2S/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFFMSXBQZzhjLzl3M2tDczJJVlJKL2tiN0QrUW9qdUVFZUtwR3dmd2JiZkw0?=
 =?utf-8?B?Y1JVWUxkenR4RDhxL0pCYm5jL1RDa0tnK3pTVUowZnlqV0JMeERmYTN5Z0pQ?=
 =?utf-8?B?dUlBMTJ0czIyaXVlekVuODRidFN6NGhRdTFwYlg2N2hNVFNTdkF3WStNbmNu?=
 =?utf-8?B?SFJNZ3VwZFdRbW50bHhmNEJTSDFIQmh4Y2kzcnhwKzNnOWlxZkhnQVB2cFpm?=
 =?utf-8?B?ZXhRU1hFMkJYazhlOXdqQWI5YVB4aGJ2RHp5aGhUZlZaNWlZSVNJUjVETGlS?=
 =?utf-8?B?TU02UDg3akRIcEJvbk1HUmZQSUFVSjJpMExnUDRsUFlFNlQwYWZUbzJSZXg2?=
 =?utf-8?B?aTdJMG9pK21LM0VTbkRzOEtqRlo1RHp2MmxRenZIU09QOTdHK2U3QUZvNlk0?=
 =?utf-8?B?UmdKUHRxMEJ2RG5rK2xpSysxRlVEeHlQbGJKY0V6a3BKbHZhOEZvT294VUk5?=
 =?utf-8?B?TEJ0OE8yYWloNmhCdWkzMGNTelcvREFkSWUvWW5BbjlYVmVSRmY2T0EyNExv?=
 =?utf-8?B?akRQYTZWUUREeVhyVUJwdm84Vm9tOUNWMVk4YTFsM2ltU2FKMlVWakNxQ0hj?=
 =?utf-8?B?aVdiSW03OHRkQ1lScVBCMmlaeDNPaFp6UmJPOHU5QkIrRS9QSHZONUllY1Bt?=
 =?utf-8?B?YjRsUlZuaER0T2d2aW1MYkhULyt3MUR6TkdibU54YktLUWpBT1o2V25Qc3Z6?=
 =?utf-8?B?T1R0K1RHdHEwZk1UOUVtQnU5Y2dWd3I3VWIvQklzRjlzRDZTTWRMOU1JMkdo?=
 =?utf-8?B?WFpMOVZKNDZiOERtMW5JZ2R3MDRndXBHYzd5YVg3QTBRVkwzZGlDSjVPRW9U?=
 =?utf-8?B?T1NPc1hpTmhBS1hVbHkyekRzOWV0S1RIeFc5WHBBQlNPcWV2R3VCSUVPM0pl?=
 =?utf-8?B?U2Y4TTN4WUYyaGFKNmNRQlF2L2J2bTBLK2c2MkZoWi9EanJOZ0JJSEpaZXIz?=
 =?utf-8?B?c3p1Y3J2Nm1PcTRSSXlITGk2eVNDd0xRb0dTclhEVmRMWmU2UEVZbzZlbktF?=
 =?utf-8?B?TlYzT3ZTL1dNd1d6RzhuY0RlMTJ0Ymc0V0I0Skl1c1hEdEd6VE9OV1BMcmRB?=
 =?utf-8?B?ZmgzNXhLSlJEVEQwNWpjY0toUVNpeFV2NHl2dThRQmg1YmcweWwvT2JaRldn?=
 =?utf-8?B?bjBNdUZwaUMvVFVtcmpkTzcxRzlybFJzREN2TFJDdkpGT2RQVzl0ODNBOVlH?=
 =?utf-8?B?U0k2T29pU1UyckkzTXV6dWV6RUw5TE1YOUFMY0dIZHlBbnBkVVdWRmFQaFU5?=
 =?utf-8?B?TzRhSnlPV041aGxsTWU1c21lV1pRY3VUL0c2QkhHNDJCbG45Zm5qWlpFWTRE?=
 =?utf-8?B?dWVxSkgvMGNXUnRta0U2RktOOE8vY0xVUVBDN3ZOa1dPd2RYYnhPYXMwUTRM?=
 =?utf-8?B?Qkl3dTZ2M0pPSWVha3FJQjNEbjVGVVljZG5xdFlkUXVFdGVpSlV6RklnMVRB?=
 =?utf-8?B?WFArckl1cEdQallJdkFkNmtBUnV1aU9xdys4Ynpua0VyQi92bjB6RlhWcGhu?=
 =?utf-8?B?NzVCUk04VjhGWUg2Ym1HOUtYdjFTUTYzSDM5eGs3NXpLWEEwc0hBQWxhNmkx?=
 =?utf-8?B?M0t2ZStrMy85Q3pDZWhWYkpBdWVKMFlEa1U5TVlMZW9BTWJRL3ozWGFEZlYr?=
 =?utf-8?B?cnhqb0JTSXNCYXpXSEtqSEt6RFNOWXNXLzhVQmUrNUtkdTJveXczN2VxTGJR?=
 =?utf-8?B?bjc5RlJGYnlzUW1mY1dYbDhpSm5iMjFJeWdzaFhVLzhuMFBDYXpmVHRuSjh5?=
 =?utf-8?B?NXc3SnFGeEJGQXNRUVNQWFB5TnRrKzA4Z2ExRjlRSlVGN1B1SzNmNnlOeWp1?=
 =?utf-8?B?OFB5dmxxYUY2elVRa2VISUliOUkrYndWZUZiMUFqYTJ3WGtvNTMzc1lLY0R3?=
 =?utf-8?B?N0V4V05qeXVHUVlLZERIVkdqNVRpbElyc2R3TGtzZlpUbEg3OGhQYVJwcnpR?=
 =?utf-8?B?bkFXTW16aGpZdVgxQ01CS1FpbkVwbUxWTDE3VWs4UGJEZk92TzhleDJ6UTFX?=
 =?utf-8?B?cDA1NXJhYlUzNWZ4Tk82cVl6ZHV5T3luRWNob2Qycmp4d3BtS1BPeEpEVUdV?=
 =?utf-8?B?cVcrYThsYlFSbDBIUGF5YnR4TGtTSDZsRmlhcU1KcWxJRkxaclRyMTFleVhR?=
 =?utf-8?B?dk83bDlPSFNwSUg0NmhKWXVma3JROU9NUU8xWDh5UzRpZ3FYWEQyb2FmQ2NB?=
 =?utf-8?B?T2hKOHZrNTNBV1ZYQkRZcDZ3MXBFc0lpSkhmeEFIclV4bThBRUVpbjlnRWFo?=
 =?utf-8?B?U0pDZHB2a3N0RU9FbWNyeGNJbEx1TkYvVGNzc1hFT1BDcFgvcS81dnA3Mll3?=
 =?utf-8?B?bEpVRVpWK09RWHN5aWFLM3dhaGVMY3JCWHUrNGNGRlhLdjZ5S3pFdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939a3b7b-447b-4b3e-f7f0-08de5261f375
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:09:38.6769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C/w6BymWrzdgFMAX0vlDk/SeQUPQ2NLPlVFZsYqNh2qEv9XHJvWI95gWKDH22HQArpoJp+XRgpzKRXKAtsytDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168



On 1/9/2026 3:17 PM, Jon Hunter wrote:
>
>
> On 07/01/2026 06:49, Ashish Mhetre wrote:
>>
>>
>> On 12/18/2025 12:33 PM, Ashish Mhetre wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 12/18/2025 2:01 AM, Jon Hunter wrote:
>>>>
>>>>
>>>> On 15/12/2025 06:48, Ashish Mhetre wrote:
>>>>> The Command Queue Virtualization (CMDQV) hardware is part of the
>>>>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>>>>> virtualizing the command queue for the SMMU.
>>>>>
>>>>> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>>>>>
>>>>> Also update the arm,smmu-v3 binding to include an optional 
>>>>> nvidia,cmdqv
>>>>> property. This property is a phandle to the CMDQV device node, 
>>>>> allowing
>>>>> the SMMU driver to associate with its corresponding CMDQV instance.
>>>>> Restrict this property usage to Nvidia Tegra264 only.
>>>>>
>>>>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>>> ---
>>>>>   .../bindings/iommu/arm,smmu-v3.yaml           | 30 ++++++++++++-
>>>>>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 
>>>>> +++++++++++++++ ++++
>>>>>   2 files changed, 70 insertions(+), 2 deletions(-)
>>>>>   create mode 100644
>>>>> Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>>> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>>> index 75fcf4cb52d9..1c03482e4c61 100644
>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>>> @@ -20,7 +20,12 @@ properties:
>>>>>     $nodename:
>>>>>       pattern: "^iommu@[0-9a-f]*"
>>>>>     compatible:
>>>>> -    const: arm,smmu-v3
>>>>> +    oneOf:
>>>>> +      - const: arm,smmu-v3
>>>>> +      - items:
>>>>> +          - enum:
>>>>> +              - nvidia,tegra264-smmu
>>>>> +          - const: arm,smmu-v3
>>>>>       reg:
>>>>>       maxItems: 1
>>>>> @@ -58,6 +63,15 @@ properties:
>>>>>       msi-parent: true
>>>>>   +  nvidia,cmdqv:
>>>>> +    description: |
>>>>> +      A phandle to its pairing CMDQV extension for an implementation
>>>>> on NVIDIA
>>>>> +      Tegra SoC.
>>>>> +
>>>>> +      If this property is absent, CMDQ-Virtualization won't be used
>>>>> and SMMU
>>>>> +      will only use its own CMDQ.
>>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>>> +
>>>>>     hisilicon,broken-prefetch-cmd:
>>>>>       type: boolean
>>>>>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
>>>>> @@ -69,6 +83,17 @@ properties:
>>>>>         register access with page 0 offsets. Set for Cavium ThunderX2
>>>>> silicon that
>>>>>         doesn't support SMMU page1 register space.
>>>>>   +allOf:
>>>>> +  - if:
>>>>> +      not:
>>>>> +        properties:
>>>>> +          compatible:
>>>>> +            contains:
>>>>> +              const: nvidia,tegra264-smmu
>>>>> +    then:
>>>>> +      properties:
>>>>> +        nvidia,cmdqv: false
>>>>> +
>>>>>   required:
>>>>>     - compatible
>>>>>     - reg
>>>>> @@ -82,7 +107,7 @@ examples:
>>>>>       #include <dt-bindings/interrupt-controller/irq.h>
>>>>>         iommu@2b400000 {
>>>>> -            compatible = "arm,smmu-v3";
>>>>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>>>>               reg = <0x2b400000 0x20000>;
>>>>>               interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
>>>>>                            <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
>>>>> @@ -92,4 +117,5 @@ examples:
>>>>>               dma-coherent;
>>>>>               #iommu-cells = <1>;
>>>>>               msi-parent = <&its 0xff0000>;
>>>>> +            nvidia,cmdqv = <&cmdqv>;
>>>>
>>>> So I believe that this is a generic example for arm,smmu-v3, and so I
>>>> am not sure we want to be adding all these NVIDIA specific bits here.
>>>> What would be more appropriate is to add another example under the
>>>> existing example specifically for Tegra264.
>>>>
>>>> Jon
>>>>
>>>
>>> Yeah, makes sense. However, I checked arm-smmu.yaml (v2) binding docs
>>> and we had separate Nvidia specific compatible and property
>>> (nvidia,memory-controller) there as well. But we didn't have a separate
>>> example for showing this compatible and property. So, I wonder if we
>>> even need to update the generic smmuv3 example for cmdqv property or
>>> add a new example?
>>> Can you all please share your inputs on this?
>>> If required, I'll update the patch will the change below:
>>>
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> index 1c03482e4c61..6b07ca9928a7 100644
>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>> @@ -107,7 +107,7 @@ examples:
>>>      #include <dt-bindings/interrupt-controller/irq.h>
>>>
>>>      iommu@2b400000 {
>>> -            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>> +            compatible = "arm,smmu-v3";
>>>              reg = <0x2b400000 0x20000>;
>>>              interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
>>>                           <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
>>> @@ -117,5 +117,26 @@ examples:
>>>              dma-coherent;
>>>              #iommu-cells = <1>;
>>>              msi-parent = <&its 0xff0000>;
>>> +    };
>>> +
>>> +  - |+
>>> +    /* Example for NVIDIA Tegra264 with CMDQV extension */
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    iommu@5000000 {
>>> +            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
>>> +            reg = <0x5000000 0x200000>;
>>> +            interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
>>> +                         <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
>>> +            interrupt-names = "eventq", "gerror";
>>> +            dma-coherent;
>>> +            #iommu-cells = <1>;
>>>              nvidia,cmdqv = <&cmdqv>;
>>>      };
>>> +
>>> +    cmdqv: cmdqv@5200000 {
>>> +            compatible = "nvidia,tegra264-cmdqv";
>>> +            reg = <0x5200000 0x830000>;
>>> +            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>>> +    };
>>>
>>> Thanks,
>>> Ashish Mhetre
>>>
>>
>> Hi All,
>>
>> Can you please share your inputs on this?
>
> I don't have any strong feelings, but we should leave the existing 
> example as is and then up to you if you want to add another example 
> for Tegra. The various DTB build checks will catch any errors in our 
> DTBs and so I don't believe another example is strictly necessary.
>
> Jon
>

Thanks Jon. I will remove the example for Nvidia in next version.

Thanks,
Ashish Mhetre
