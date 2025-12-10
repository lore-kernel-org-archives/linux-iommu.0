Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010063.outbound.protection.outlook.com [52.101.193.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49520FAAB;
	Wed, 10 Dec 2025 05:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765343970; cv=fail; b=a2//6QCm6mgG49a8qUEC8h6zw4gocplKy4fwfrSoMsit3ia7DJ04RjbUBoYy7NrJ6MGLfKVlzJkWEkRXI67zgOU/VVsr5dRPilEDqIP244r4Bgkgg3zrOP5j5afaoNs3bU3G8kUJIOTViBQVUS+zgBLsavXnQBeLc5xXScXQjDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765343970; c=relaxed/simple;
	bh=m0dkwpiBaFE4McCmvDo3gbji2H8XIBcaKKHh3zCjWeo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U6aK4AvNXiWQ1i0ErH0R3zpzGcTm9pR6lY6iHyiOvt0jOnI7iDacm59XFQ2Lciq2Fkg51SBHWJEpznJtB8otoaHu6WfDgHhD3H/D8v/H+aCsZIqowhaiHhOIghBU/+/md7ShfaWEy5NRIikszGs7hAwHUwysrTkjc/4hKtqBWN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WsNewyF4; arc=fail smtp.client-ip=52.101.193.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WsNewyF4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMEhSvfcDSmszFTBD6o62Tm77dYUoqJzWwEgVL7tnKYBwHiQT8t7IV8Q2W1ODMWz/M37pOYkhWBPFfg7C+KrX1FHSqAeskX5k+1UnGMV6PgBWZUa26xzxlauS/LOGdUcElWvjHegCk0O08tPaasSp+BEJDBXQYoLDvtCLYG+iBYDgkMhiD9bw+9f6G8pI/PHIgAe/lsNKrUw5YPlMRzTj1C/P5HTj3dn+lXsvYFDPnKayfQeWY3bohBHb7A8p8rwzoPsbAHfHEPzd7Wujxl2lHtvn9U/jw0BVC61I2DXDu8VAsEgnf6w6Cv1F5oaHi7H90kyVTN8Br2V3fyWewpANw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+b10X6Er4div30ysnZd4JuCWXNc3CC8naMD83NeP8M=;
 b=hvQ/hFMb1w/h5p9tWwAe8+3eyq+gk+SC0rhQ4pX1XqaIl8CppHt/+4fGzxX8sffT748sqyb1UzXoZKNltWI6b4Ikt7/cKiNmC39OXV5ydiVzsrLAgoOHYdVHOvyEZnHKeFwIPB2xlV5MKYNqII0Y7hw3xiq8SqIKLrI4oWAWkMBKy2HHUZhp3pRol2FyA/Sv4HQN6XWApkSZ5Ypu9iSWQrWKyqGd6gkCoLiLdR52k2YsXRaylnAu367x6hipjbqatyB/GFcDOVwu2ZxWSdxImESwh9qM9wymztuNy9kGL+Xyhv5Um35yBfpDg5JKP8Ntu3uVq4MDJK23bTizHcv9Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+b10X6Er4div30ysnZd4JuCWXNc3CC8naMD83NeP8M=;
 b=WsNewyF4yxKYC1QU5bpUha8D2A7UFgGt4I8Ng2UnWQgs9Ho+wAv6l5256pHPdVlHqfii7FRH6fed2z0JzWhE0KXmE/aLMNPOhjAyN7889HqLN9kodWipd/4PzvcIBLkV3hOQrBmMmV/AwcDvHho0c+uEk9Opd0KeeGXabpRXE/kHDro0c2utWMW33HOQWGr3ouME5bd8uREAyy3FN9WGfVDO/ja2Gwl77Nz9sA70rvuEVfLV+BtFpiZJ+A2g2hG/+GJzcEPVH9nMEwtJzzN3iQa/SuJSNrwHo2PJ98QALXSuFsqXFmpyhgh1Yzbg5Pu0uPlhhR97BsqvtD6S9vgDnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 05:19:24 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 05:19:22 +0000
Message-ID: <2bf7bb25-9a6b-42d5-b095-978f7bb81f35@nvidia.com>
Date: Wed, 10 Dec 2025 10:49:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/3] iommu/arm-smmu-v3: Add device-tree support for
 CMDQV driver
To: robin.murphy@arm.com, Nicolin Chen <nicolinc@nvidia.com>
Cc: oe-kbuild-all@lists.linux.dev, thierry.reding@gmail.com,
 jonathanh@nvidia.com, vdumpa@nvidia.com, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, joro@8bytes.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, kernel test robot <lkp@intel.com>,
 will@kernel.org
References: <20251205065850.3841834-2-amhetre@nvidia.com>
 <202512090331.QAFgb6vQ-lkp@intel.com>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <202512090331.QAFgb6vQ-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0003.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26a::13) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 475bcb4f-ef14-4758-8c01-08de37abad27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnNXa3BmaWF3WGNpUllFYTZkcXRWMDFqVjR3cys5MjVhVFAvYU5VL3VreFVG?=
 =?utf-8?B?ZmpwM01lK1ZNY2NzVVlIWW14ZENGbFk4Q3dUajhqR0ZKQVRaZTJHR2ZHcHY3?=
 =?utf-8?B?N01rRVpudVdrRGhRRmp4UEIwQnoybmlPaFhFc3hhSUJSR080aDZDQ0hwdld1?=
 =?utf-8?B?TkJRSkN5Tm5LN0o1N2RNY3JSTkVqZ1lMdkdiQ0gwTGxYVDFYRnBLWmc2ejc4?=
 =?utf-8?B?bEd2RysraVp0OEN3dTV0YXZYdm9QM3JVTFFTM09LN1dKTk52dnlmUXVsaHFM?=
 =?utf-8?B?ZkFzR2lucEJlWmNVYWoxNHdCYkVPOXNtc1lUYzNEa2pIaU5QS1F1YTlmRkhO?=
 =?utf-8?B?bFpkVjBIanJwN2E0Yi9NQ0JFbXEyaW1oek90QTJDMEZMT1VlVkRPcEk1MCs3?=
 =?utf-8?B?SFAwQUhXQXNXV2tVVUNHOXl4dXh4RTFQdWJpRW5iMG5hOFJvd04rSExLOXNZ?=
 =?utf-8?B?bmRZVTlaTnFRYTVyR3ZLeHNiRnZzclIzanU0dXl2dFRMRWIxU0hyZ3Q3LzY5?=
 =?utf-8?B?ajN0cXkyVlBvTi9HckFNTDZ0N0dCUFBydE5LSWtTNENDem95ODRQS2YxNGdK?=
 =?utf-8?B?Nm9wM1ZTODIxVG1VUExVWWVPcE0vTktpaFdRREpDQ3dtcGxkckp2R2NYMWhH?=
 =?utf-8?B?MkN1eGNXTG5sN1BNZFk1aUYzc1ZBYklxQ2FxMlVJNCtzMmdKNWYyQmhpUUFi?=
 =?utf-8?B?U0k3QnRCMkg5VjVBMDVEUSsxYkQ1ODJoZlMxaDRjbGg0cTdxbkJrd3lYeU5l?=
 =?utf-8?B?Y0tqL2JxVHBKMmVpUURYQldjdmJxeW15b0hLSmFYbUVjekViQ3I0L3JQei9M?=
 =?utf-8?B?OFJRT3N4VXBRaThtUElaSzErcXFRY2dOS3ZXSWhHZ05peWJEckQxRmVDZ2RL?=
 =?utf-8?B?VjN6WUhjM2tuVWUweGhxMVdmK0lYMUY2blMzYW5UVzJSMVZMeVRqMGlTSThW?=
 =?utf-8?B?N0tNb0JjU0VtZTFlMk11MEdBMmtwT0h6ditEQzVsNTNxNDB2bjVRTTRsSFVX?=
 =?utf-8?B?OWRyd1BlcGdzdEh2LzZVWUNCUG5kajRlTGFTSXBSMHdzN3NRY3g2amFtajk4?=
 =?utf-8?B?SEQwb2hNS2dRS21pZklNN1FTaVFHbGcxc2liRmVUbm9QeWR1aUJoUmNGTXRv?=
 =?utf-8?B?RXUzdnd2WVFvdk9OV0tzZENTRDFSOTUvWmNLTWZ5b25OdE5zdzhXS2NnNUN6?=
 =?utf-8?B?K3l0bEZMYTg1UkFiZEc3RVpIeU1wbnpFT0VZc0xoSGRPbVUxcnFPZWJyRUQv?=
 =?utf-8?B?WUU3QXl2WnNkWVNTSUlYV2NFek0yTTBuTW1LbmlnRTN0K2d4M0lCY1MzeXM0?=
 =?utf-8?B?UUhpYUtiMFZTT2d2bWI4L2RRbThjVXdWam1HZDVMTEo3ejFNMGgvUjhabUwy?=
 =?utf-8?B?N0lJdVRmYzFYSEk4RVlBVys4ZmpXN1FpMTNtRDFhQXc0a3JSMHNvRURvVWRH?=
 =?utf-8?B?ems4NmdoSng4YkdRTDdTRndiV3BhVUNIekExVENWN1Z5a0VEMnN0QTMyYmdU?=
 =?utf-8?B?bVpVY0hvcXZodm5nb3ZaWjVIQThLelFWS24weHJYVGpsMTFVZk5TYUlGSHhX?=
 =?utf-8?B?VS9wcittMS9xa2U2ZDBHRW1DSUZ4WDR0N3B0b1poRm1PM1JrdDNRM1BOd3Bp?=
 =?utf-8?B?K1dsZ2ozelVHNjl0MnRUTE9OU2dodGRNaXNnSlpqWURZaUkwZTI4SFZPN2tW?=
 =?utf-8?B?MHQ1bnE4WjRXRW50eHFyczROQzdmcFFaaGpNOXpzaFNBYjlvZWdQdlZ1b014?=
 =?utf-8?B?N1VwdDNReXBhK2RFYWlqTUc4MG5Sb0s4dndOU1Y4eUZzU1RLclRxTWcyRzls?=
 =?utf-8?B?UzBycjFxZTc4aFByUDU1ckgyTm9SendVRUxjdVVJUFdmSGNnYk40RW1kTkFO?=
 =?utf-8?B?OWZmWGR3RFRDbTRyaEw0UnZiaEMySy9VamRpdDdBYTlxKzdyR1dqeENackdk?=
 =?utf-8?B?c0FnR3JCakRGQ21EUXJiYVJSSDdHdDBvRlFyc0hOZ000TmIxNHJUYkYzd3hE?=
 =?utf-8?B?VmE0RjNvcW5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UG1xVWdyYzBad1Z3Y3k4bGdoN1pRMUNJQ2lLcGNFZ0JyRnZ2Z1JhRkVER21s?=
 =?utf-8?B?K3NiblozUjZ2YTEvbURtS1g0ekdnMHNBbmxVNGYzbU4wakdOa3VLRjNLdHNq?=
 =?utf-8?B?VXhETW1hdm9DbS9yUWNWRlhTd0w2NzdvemVoQUZXUW9qYllSRUlPL0NOTFhT?=
 =?utf-8?B?R0pzb2pLODNubmcyeGhyOWJ6UkNhM212NGV6SWJVdUxWY0pOaENENDVrNEJD?=
 =?utf-8?B?ZWlIT0NXU2lCTHdOMlYrV3hzTURHemRWY01pRE5EQVA5SitzaUQ1bCtDeFlz?=
 =?utf-8?B?YWtVbjZnMVJMQ1lzaXJMazQ1V1c3T3lPVEFIOVk0MGxiTTdSSWlSZHZROTdv?=
 =?utf-8?B?NC90VnlpN05mSTJYVWVwcHVPeVBCUGdJUVNTZEJCSE9IMFpyTHlvVDFhc1NZ?=
 =?utf-8?B?UTlWeVZOaHRQblpYNENMRVQveVpsbVg5R1VvaWxvcXA1YldEL09xajlML0NO?=
 =?utf-8?B?Mlo0THVSa3U5a01sUHFvbjVBSkFDQ01UTitVUnNFbWcyZWgxT3Q5ME1WZEpw?=
 =?utf-8?B?ZXcrVTN0UFFZajU4R0NuQ2g0SGxKYklRVGF6Q3NCSkRmcXBGYnpnUGNnYXNu?=
 =?utf-8?B?dTNNbG1rRXE2VjJrb1pBSkc2RTNVRk1MYlgvT0JNNmJPRi9iYTRpdXpsQ3ZB?=
 =?utf-8?B?Rmh1MzEwZnNESllKNitTc2dXMFp1Z0oxL242eVlLaE1DemJiclNjZE9PT2xJ?=
 =?utf-8?B?OG5YUlMrVFhzbE5qOFZMVGZLb01zdlRJWTFTM2tXRVRFOVd4Rnh4YnR0Q2ZE?=
 =?utf-8?B?VHVnUytqZmlUSlkvL1lvT2JoemV5ZlhSd3E1RElTMVJOS1hnZ0Z5bVR0MElN?=
 =?utf-8?B?bWQzeitjcnZobDl5U1FUb2xWRVkvb3YvQTdNejdxVzdaVmtPcUhqQTA5SStR?=
 =?utf-8?B?a0NiSGRYaEN3TytzbGtUcWpDQVpzYUcyWGpTMUM3b09iZXFENVhBVW44MEli?=
 =?utf-8?B?WG1FZjZVdk5CYmxMYTR6TEFWRTgvQ2djRy9DenNIYlVqdks5cEtpSVcyWVB0?=
 =?utf-8?B?RnZybkI4ZjNEUzNvWURpUGJYaEdNOGVwN1lxeERYVjhtR1BVdXFQMFo1VDZ5?=
 =?utf-8?B?bUpYdmdvbUMyeHlOV3R1SmJPOU9GZkNJQ25IeUtmblFDOTNjZ0NvK3UySzZn?=
 =?utf-8?B?dlZiSDdFU3BBSE1OUGZ6enlTM0tTdnhLTFhwckhqNktVampyUFRodlMwVEta?=
 =?utf-8?B?VnljZW52bUNNWThuWmxRTFpmVU92b24rUHZDNVhLUGxick9RclB2THR5REVC?=
 =?utf-8?B?RGZtdStQUStyNjlaQzdOSHJua1M3U1dRR1ZEUjVnaTdzZmVMRDhhNnZ3K0s0?=
 =?utf-8?B?d3BYYUl6cjdCWW81SzJsVDJFb04vQ0c0WmpkZGNjRzJwcFVuVFA4bE9VVGFs?=
 =?utf-8?B?M3NOZFlrbjdRRTllQkxMSFlxWVVrZ3NkS1RiSW9hZjdRUzN0NDJBM3RjYmh6?=
 =?utf-8?B?cmRMMHFHN01tVEs3MGMvL0tzYmRZYWxpNTB1bTJNWXd6eGdrM2pZTy9qSlRn?=
 =?utf-8?B?VWNlaHlra3ExbXdWeCtRajJHYWl0Vm1JSDZKSVJLeXFtOGFLbU9jQll5ZUtO?=
 =?utf-8?B?Mm95bXVscjQzdU9jN0RTM242dnEwRWZWYUc0UHJGUmpvWjY4WDE5am1EOTd1?=
 =?utf-8?B?ZTM3b3o4Wnd5K1NyN1ZJb3dBQVdDaHI1ZHJZZXBrM3pFRTJSTnQ0R3Uybk42?=
 =?utf-8?B?aXB2WGx2ZW91b1M4cHZISitybWpoa0xaaVZaRjNVbE4wTGpJem5yREdqdE5w?=
 =?utf-8?B?QVZOV2hXcFNnVUpnVytIN0JtN3R3Qnk2bEhaNEtrMTY0WHp0Z3NkcjdjbUNR?=
 =?utf-8?B?UkxPUCtKNHpLRzVoVXdGU2t3MVNjOWRlSjdRTDNKRmVkOHZoYWM5R2trUGkz?=
 =?utf-8?B?QXZwbUU0a00zZ3JtNHVvS3krTU5ta3hvYlB3Y05rY3hLSzYwRnFHVEsrT3RI?=
 =?utf-8?B?aktFWDlGcWlmVDFFelhDRjEwSHdmVmM3SUx0aFlNdlB6UHB0RGYvSzNJOGZs?=
 =?utf-8?B?L0xOM00zendIS0ZCQVZYWWxweXdNQ0czeGo0QzFYQ0d2ODhJbTdKYWVwQWh2?=
 =?utf-8?B?Z1MvU2J1VEc0d1lkQ0ZkWGtTOTEzZk5KWG54U3UzeHhINXhKSmRhdUVudlFY?=
 =?utf-8?Q?iy4wjQek6slwCJ/W5Nhymoj9/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 475bcb4f-ef14-4758-8c01-08de37abad27
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 05:19:22.0300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcutXMCjSiHNmZOR2J0ENdwR8divXUscz/ljCy/p7/yfGi+LhDMz7aEAk+KKlXebD0YF4eqBrLeB3G++OHkPCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102


On 12/9/2025 1:13 AM, kernel test robot wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Ashish,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on next-20251204]
> [also build test WARNING on v6.18]
> [cannot apply to robh/for-next linus/master v6.18 v6.18-rc7 v6.18-rc6]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ashish-Mhetre/iommu-arm-smmu-v3-Add-device-tree-support-for-CMDQV-driver/20251205-151258
> base:   next-20251204
> patch link:    https://lore.kernel.org/r/20251205065850.3841834-2-amhetre%40nvidia.com
> patch subject: [PATCH V4 1/3] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
> config: arm64-randconfig-004-20251209 (https://download.01.org/0day-ci/archive/20251209/202512090331.QAFgb6vQ-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251209/202512090331.QAFgb6vQ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202512090331.QAFgb6vQ-lkp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c: In function 'tegra241_cmdqv_acpi_is_memory':
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:863:17: error: implicit declaration of function 'acpi_dev_resource_address_space' [-Werror=implicit-function-declaration]
>       863 |         return !acpi_dev_resource_address_space(res, &win);
>           |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c: In function 'tegra241_cmdqv_acpi_get_irqs':
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:871:26: error: implicit declaration of function 'acpi_dev_resource_interrupt' [-Werror=implicit-function-declaration]
>       871 |         if (*irq <= 0 && acpi_dev_resource_interrupt(ares, 0, &r))
>           |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c: In function 'tegra241_cmdqv_find_acpi_resource':
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:879:36: error: implicit declaration of function 'to_acpi_device'; did you mean 'to_acpi_device_node'? [-Werror=implicit-function-declaration]
>       879 |         struct acpi_device *adev = to_acpi_device(dev);
>           |                                    ^~~~~~~~~~~~~~
>           |                                    to_acpi_device_node
>>> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:879:36: warning: initialization of 'struct acpi_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:886:15: error: implicit declaration of function 'acpi_dev_get_resources'; did you mean 'acpi_get_event_resources'? [-Werror=implicit-function-declaration]
>       886 |         ret = acpi_dev_get_resources(adev, &resource_list,
>           |               ^~~~~~~~~~~~~~~~~~~~~~
>           |               acpi_get_event_resources
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:907:9: error: implicit declaration of function 'acpi_dev_free_resource_list' [-Werror=implicit-function-declaration]
>       907 |         acpi_dev_free_resource_list(&resource_list);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors

Hi Robin, Nic,
We removed ACPI dependency in Kconfig but driver still depends
on ACPI for these functions. I will be protecting ACPIspecific
tegra241-cmdqv code under CONFIG_ACPI similar to what is done
in arm-smmu-v3 driver. Is this the correct thing to do or do you
have any other suggestions?

> vim +879 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
>
> 918eb5c856f6ce Nate Watterson 2024-08-29  875
> 918eb5c856f6ce Nate Watterson 2024-08-29  876  static struct resource *
> 918eb5c856f6ce Nate Watterson 2024-08-29  877  tegra241_cmdqv_find_acpi_resource(struct device *dev, int *irq)
> 918eb5c856f6ce Nate Watterson 2024-08-29  878  {
> 918eb5c856f6ce Nate Watterson 2024-08-29 @879   struct acpi_device *adev = to_acpi_device(dev);
> 918eb5c856f6ce Nate Watterson 2024-08-29  880   struct list_head resource_list;
> 918eb5c856f6ce Nate Watterson 2024-08-29  881   struct resource_entry *rentry;
> 918eb5c856f6ce Nate Watterson 2024-08-29  882   struct resource *res = NULL;
> 918eb5c856f6ce Nate Watterson 2024-08-29  883   int ret;
> 918eb5c856f6ce Nate Watterson 2024-08-29  884
> 918eb5c856f6ce Nate Watterson 2024-08-29  885   INIT_LIST_HEAD(&resource_list);
> 918eb5c856f6ce Nate Watterson 2024-08-29  886   ret = acpi_dev_get_resources(adev, &resource_list,
> 918eb5c856f6ce Nate Watterson 2024-08-29  887                                tegra241_cmdqv_acpi_is_memory, NULL);
> 918eb5c856f6ce Nate Watterson 2024-08-29  888   if (ret < 0) {
> 918eb5c856f6ce Nate Watterson 2024-08-29  889           dev_err(dev, "failed to get memory resource: %d\n", ret);
> 918eb5c856f6ce Nate Watterson 2024-08-29  890           return NULL;
> 918eb5c856f6ce Nate Watterson 2024-08-29  891   }
> 918eb5c856f6ce Nate Watterson 2024-08-29  892
> 918eb5c856f6ce Nate Watterson 2024-08-29  893   rentry = list_first_entry_or_null(&resource_list,
> 918eb5c856f6ce Nate Watterson 2024-08-29  894                                     struct resource_entry, node);
> 918eb5c856f6ce Nate Watterson 2024-08-29  895   if (!rentry) {
> 918eb5c856f6ce Nate Watterson 2024-08-29  896           dev_err(dev, "failed to get memory resource entry\n");
> 918eb5c856f6ce Nate Watterson 2024-08-29  897           goto free_list;
> 918eb5c856f6ce Nate Watterson 2024-08-29  898   }
> 918eb5c856f6ce Nate Watterson 2024-08-29  899
> 918eb5c856f6ce Nate Watterson 2024-08-29  900   /* Caller must free the res */
> 918eb5c856f6ce Nate Watterson 2024-08-29  901   res = kzalloc(sizeof(*res), GFP_KERNEL);
> 918eb5c856f6ce Nate Watterson 2024-08-29  902   if (!res)
> 918eb5c856f6ce Nate Watterson 2024-08-29  903           goto free_list;
> 918eb5c856f6ce Nate Watterson 2024-08-29  904
> 918eb5c856f6ce Nate Watterson 2024-08-29  905   *res = *rentry->res;
> 918eb5c856f6ce Nate Watterson 2024-08-29  906
> 918eb5c856f6ce Nate Watterson 2024-08-29  907   acpi_dev_free_resource_list(&resource_list);
> 918eb5c856f6ce Nate Watterson 2024-08-29  908
> 918eb5c856f6ce Nate Watterson 2024-08-29  909   INIT_LIST_HEAD(&resource_list);
> 918eb5c856f6ce Nate Watterson 2024-08-29  910
> 918eb5c856f6ce Nate Watterson 2024-08-29  911   if (irq)
> 918eb5c856f6ce Nate Watterson 2024-08-29  912           ret = acpi_dev_get_resources(adev, &resource_list,
> 918eb5c856f6ce Nate Watterson 2024-08-29  913                                        tegra241_cmdqv_acpi_get_irqs, irq);
> 918eb5c856f6ce Nate Watterson 2024-08-29  914   if (ret < 0 || !irq || *irq <= 0)
> 918eb5c856f6ce Nate Watterson 2024-08-29  915           dev_warn(dev, "no interrupt. errors will not be reported\n");
> 918eb5c856f6ce Nate Watterson 2024-08-29  916
> 918eb5c856f6ce Nate Watterson 2024-08-29  917  free_list:
> 918eb5c856f6ce Nate Watterson 2024-08-29  918   acpi_dev_free_resource_list(&resource_list);
> 918eb5c856f6ce Nate Watterson 2024-08-29  919   return res;
> 918eb5c856f6ce Nate Watterson 2024-08-29  920  }
> 918eb5c856f6ce Nate Watterson 2024-08-29  921
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
