Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008A1A682E
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 03:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775447493; cv=fail; b=SxSZlR55xdsbRaaMse4yhIyYvx0MdLOKD/lN185OsfQckpjBZyPRxey0LzgRhzOVo0ye+3w+AujKnlvn1kHjFjF5xoxK/cjGf+grLmD2xpP38xK0W4AlyoRNYVglDoEOCDH276bTEi+oq7voPNJUFo92U+cWwb8dCtMNUxMB+nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775447493; c=relaxed/simple;
	bh=XydXYNjVV4u8P7Cak4ruYPj8ptKMB7QvkdHwmE5kfng=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCBNhYlzbPfkZqvfeVxwuf6+PfHENqMoSG9D4ziA9btD9HakW6Ei0kEbXADuOgW8hFUuSFHs/NzoscxtHYtDAvDuaA+w9eXPeYvhl3MNQegQ44oKtCvd1EZguVIJQzO1X+ZTsuEj2QrUd0TgSajMAvANMtMLW5dZfK8y/fLq8OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4o/C1dNe; arc=fail smtp.client-ip=40.93.195.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4o/C1dNe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njPzhwkqj3gQHut4t/XABfO8spzlktypfQm7v84hcyBkxirBL/NyzAyV+nkoCcj2/FXFp8nGLdUIn8BFYbSvQwEybVTrjj5v0X17AO2rmL/y67aEYcemxxcOrcxxDMptVNNSrWcS2ekqOgLG9vsq2d5uWVdqVtKwx/OyGXZeYnclrSMoXDvtQZRAiNc32pEJqimgCWlgAGXwfebHIltUgSjLYvQXmuF7cGQZTahco0W4yNdiaRimZq+FUg/FpcJ0OYWpwXGP8Wh7bX3jfuvccjhRnp+8CV8MXnCsBnvUStY7yCQfVY1P3551saKooAm4jg8+Ah+3qhAritisYq59qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhw0UxKF40PJhrl/hPHYPWsigHsb4ZLeIFUODs/CS74=;
 b=dMLgH1oZRg9XrUIO+r89zoCcR/vM6IwK2adDXNM4/f/VerCF0qQ4eK7BrP9vla9UTtuD2Cplhy+rLAEpMDQ6jPYSdiUuDK34Nein2yXnhkifHnDrp/koCkB2YQhwr2DKo7vkmBzn//AVUi/tMLN50zwtBjC5ADa7USf1exwwAWzxDKmwf4cBAAd6KN88fHluCaqaTx+VUgOEGnbRiMptLjcMgER980uieVgXGBmZfda6q3PGExIZ85u/vcqsEz7jyoef8zyd+uJCdn0JqXKaCFGHFTZRr++WftHAefNN1Gd5bShfobvxXinI17kuhPlrYgHXh72fbCZHYJGvC5uN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhw0UxKF40PJhrl/hPHYPWsigHsb4ZLeIFUODs/CS74=;
 b=4o/C1dNe0Ef85TTLLkYd5hoU9raZwHQd4KAYFapAK/EoP39i/MJACjIGFCZyK4yk/ktIA4zfazRywft3z/Zuzjt1SmrdcalC1w8S0SNo91SgvVEK44iG0H5jG87AsQOsjXaGcZ2m2SXbgB7WqKqOtRBD2wIqx2GCkT8fKAFk4kY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 LV3PR12MB9213.namprd12.prod.outlook.com (2603:10b6:408:1a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 03:51:29 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 03:51:29 +0000
Message-ID: <3d3ad6f2-abf7-42e8-967b-2f4623f559df@amd.com>
Date: Mon, 6 Apr 2026 10:51:19 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/22] iommu/amd: Introduce logic to check and enable
 vIOMMU feature
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
 <20260330084206.9251-23-suravee.suthikulpanit@amd.com>
 <20260330121548.GE310919@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260330121548.GE310919@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|LV3PR12MB9213:EE_
X-MS-Office365-Filtering-Correlation-Id: 674021e9-1589-44d5-a9b3-08de938fc86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	EdblqBNj8OE2HH3svEXLRJMHmzyd1Dji0V7GmmkhHxPcRHhrc8fVqxqABsa6DOkbzfw22tGIgOtNbZ/Gh4CChM9buoLE052XQ84LWkvQlsd6HMIQ/XVbeyen5b1ZZIp0EwHGOm6Ux9a9ARagl3j053nkIWtBPTTXqzxs6XrhFFbJZEIlDTIRsC8smiEruMD7t108LHVYqtiyBvLsnTkOl9K+5aI6gij/3FUgUYoSh+GCK0yn9NIX3rWBSUA8ILiXtgmquUhdmlinc/NT4Xswg6tgSjgELCCzG0R/8AJuSWOD/cOC3weWdpZl2s7Zkb2ESbr2cpouWoDBbueYjn3PjZrHR7mR0U76RPwV5kHpVquV9QPv+Ql3myW73Hf3zGHsq2O1E4PSb2SlxApgj3IwSlYI08rL2I9Fq+1oIKp8j1615OexHHOq3/9AV0/LwHYwe0Lyt76FwfFDGA/6OYPLsb90+E9DgLj5lkU39MIqpqQRcJPT+7Wbs/YgiXHNwjCiu9pqsrG/Yj6sFLnKcOQo1cPOA9RDiEVJoEiOmGTLkIkKzaYpdnQ+F2I8XhpA0SSai3CiA8tCQup6InQEYEvSCN2tdVR++KZxmrGniJKT7Au7PKp+nPzdNoTOR5UHQ5fO6gTNIp6DArkoWL06owo+hOPJw3k3jjW/cbu92UZ0KgCZ+AUYE0A++yx04f3xrgBamGPhD+vpU/rs1yAOJTW/WmwvlVvBvHVHivCbhw6VVuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXZpMVNJckYwTUl1ZTBHdS9jdHVta1ZiZGo1akJUK0ZuZWRTY01uT0l6SmFV?=
 =?utf-8?B?Zm9wMVRmOVZOSWVCTWU5aTIraUNLOUltYnlWdU9tczQwTzU3d2VhV1dwOXBQ?=
 =?utf-8?B?M3diTzVBQjBHT1hYVWE4clB6WTFKVldFaTRDTVgyWWErQjh6MUVpQkdxWG5B?=
 =?utf-8?B?a0laNVJ4azR0d3hsM3V3ZHNOQ0RyazJFVWIwY09ubjJaZ3FXdlVjN2xmSDUz?=
 =?utf-8?B?Nk95SENBdWlxdDl6akNyVWJNcjNJMjh6dVFWdTgzMmJBZlM1dy8yM1VncnA5?=
 =?utf-8?B?OXNlRlowWldRMThoMTJya1JEN2hkdkd2SXFzYWZFMDg4KytpVzFTU25Rc0U4?=
 =?utf-8?B?eUpuMm84M20rUU1scXNWWUM2RWxnWXJEZnBCNGMzOXBaOHJhY0NzOHJqcjNN?=
 =?utf-8?B?azlUUTNLeHE5WllsQlRObDVLaStNemk2SjU0bU11cUZEa2kxa1FiYnYwWldF?=
 =?utf-8?B?T0IvRGxyTFQ5VFRKRDY3aXJaMjRwZWN5ZFdhM1hQUW9WdG9zWGZLbW4wVkxY?=
 =?utf-8?B?MnNZa3d5aUFyaG43UW1qS1FCb25EaUVENE1aU2hJUjRWNDdRb2w0eFl1M2pu?=
 =?utf-8?B?RkRzM1Y0WFM0RUdwQWVwK2hFWlRQbmUrL1hrTTFsckY5NUtWcjlod21rSnNE?=
 =?utf-8?B?Slp1R3Fad1ZQSFFQRzZuUGVlbGlORmVGMitITzh6OGU0YkZyUzJXSUMwVlll?=
 =?utf-8?B?L1djdzhhL3lHUmg3SHRjSkpQSGQxU2ladHFmMzJIWDRwSEJqcXRhcmN6RDEx?=
 =?utf-8?B?dC8zNTlBZGtwa2x6YlUxay81Vm0wUkRoa3VXZng4VHp0Nm5vWXlYemI4RHBO?=
 =?utf-8?B?SVlqallWdnlVaFBuYTRRdFJDdUdvbmVhTTFZZHdldjdDV3djNmg3cXk3UG9K?=
 =?utf-8?B?RlR4bzJDVUFSaEoyeGlTdG90V3RUUkxONEw5N3NqMy8wMjVnT3Q1UFNUakdZ?=
 =?utf-8?B?SlpjeGI3WndvSnlwMWdVWW1PYUdSVHI2YkRZTUJyRnhHSmI1U0MyRFI4NVdn?=
 =?utf-8?B?MTk5OVBzMk9MZ1hjclRhTWtJNzdnTU9oeGVTNFJXbjdYVmN4NUcwR2VCMmg4?=
 =?utf-8?B?UElKMXZVM2JDYTVTWlovWGtpK015bU8rRzJ1ZDc2OVp3Q2FhbEJnbTlVQUc0?=
 =?utf-8?B?cENVN1Q3Z1h6RjJKY010TFVJSklSVG44ZmppcXNHcS9aVWdhWUdEcnJkeFFm?=
 =?utf-8?B?c3FOM3U5S2YvOFNGRUhKTkRIVjM3RTZuaThvQmFkSVpqVElHRGI1bExwbTZU?=
 =?utf-8?B?SUJmUk4rVlhaRnEraDBTd2dZa3ByRlRVQjV0ZlB1WVZublJnZVBveXRzUVNy?=
 =?utf-8?B?SHJBYmhaTnJaOHZWcmdNOURaUlFvcmJqeUxXL3ZKNDlTU1JOUmJaSzlreEZR?=
 =?utf-8?B?U08rRUt3UVhpTEFBakpRMVdpVEtmSmEzeDYzLzVMTmswcTNyd3pPTTFRSEZ0?=
 =?utf-8?B?SzR4SngrZmhpa3hMT0NVL1JneE9rZ012MUFsTnI2YURSN0xnS29mN3lJNng5?=
 =?utf-8?B?WnFZOEVKbWV6OWNESmRSM2lxY1NZLzlnUkxmbWt3WkxKei9SL3h2cXZhaUpY?=
 =?utf-8?B?UXRpUHlDMUIzK0xvY0ZoZWx0dnUzaFRPMkp4RHB4WmNKQlNNWU16V0hxcnRM?=
 =?utf-8?B?THN0eHRCOHhudHhqZnRIUkhvaG9FdkV2a21KdXlSWFpUNHdyeVozdlB4ZGtO?=
 =?utf-8?B?QndPWU5vRVJ4cjVTaE13cGFwTmZJWEpzNnF3eUp1U2tQeGdTSHAyNnRBUUR0?=
 =?utf-8?B?dGp0cnhacHcrSmhITWJyQmY2ZVlaSHYwTDZjbUN0dFFHdjVTNnZNOVZrOUNk?=
 =?utf-8?B?QzhlOXluRjJscFI5VnBaNUJGajdYVVNqY3oyazNsVnF3MmhBZnFudVI5SlpT?=
 =?utf-8?B?OWdFL3ZBYjFFeFFNSlZRMmloM20xeHVkNmxVeEx4NVpUb1VNVFpTa3dyRXVt?=
 =?utf-8?B?RmdaR3VDWENkTkh2Q1pTdFhFeE9NK3FrN2FwSXBObW5qcmhtN2NtNnM2czlZ?=
 =?utf-8?B?WWRmQ0xtaTJISlBRUXNKMTVOTi9IMUxxZ29BMjh6NEpyTUcyNFhhYWdnWnph?=
 =?utf-8?B?MXJURk5FTmQ1eFpSTXE3V2lqL1lXc3BSN3BMS2ZNcnVJMTlWQm56ZlN3SzlD?=
 =?utf-8?B?SHRuYVVaNFluMEJiREFvZWh3VGlVWXhPa1NGSWtWaEZQbmFqNlhsd0ZYVHJM?=
 =?utf-8?B?MnFaRkhFZk9MczBiVGVWSzZrWlZjZUppWWVQS083Vm93NUFaTm1WR2VWNVNj?=
 =?utf-8?B?T05GclJ0MTdhZ3BEK0JiRnRBZi9uZUNQZTA3V0ZGZnc4WWNLTVg3OXQzV3Fj?=
 =?utf-8?B?YUlQZFVERThUZjN3bC9QNVMramlsc3ExMERtWHZzMVZNbzBkL2Z5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674021e9-1589-44d5-a9b3-08de938fc86e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 03:51:28.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPE1TR62wc8VMsxwmZkz+G4/iS4+r7BQDnZgKJUVpzC1JwVKG656YlhHZ3WCdLk+xDX93yxmAwqxGJ/pagLmyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9213



On 3/30/2026 7:15 PM, Jason Gunthorpe wrote:
> On Mon, Mar 30, 2026 at 08:42:06AM +0000, Suravee Suthikulpanit wrote:
>> Also switch to enable vIOMMU by default, and provide kernel boot option to
>> disable the feature.
> 
> Why? userspace is free to not use it, lets not pollute the kernel
> command line.
> 
> Jason

I just wanted an option to disable this feature in case it is ever 
needed. I can remove this.

Thanks,
Suravee
