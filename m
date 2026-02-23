Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012001.outbound.protection.outlook.com [40.107.209.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84CA34D903
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 08:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836603; cv=fail; b=o+L1hSNbQ1yjIjzBcEUt0ipgyUHCb8t+2938h8ck4gH7P9tBiWuk3eoQqoum5dPA+PO+Yueqqy249xfauzZGsUnFdNxOWNVYDsFuaF+puUrPf5ZXdxnCDq5z4mrG6tM7UeZHPUQIafgk8CT/4aaAuLQu9lspkDjHmZcL97vh0sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836603; c=relaxed/simple;
	bh=d4Edvw5iqBDu5TbGUUX4Gdo2Lua1qWQYQk1prSgeiww=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YN2pz+QGVoBNCgKM1AgvND7tffJwzgMleFN8+cgCDGDFqHTyky72kNNGOBC8z7IosQpfrFRtgGnQNQJ6XmFFfq07VgGo6fSoKwsXHT39DU5BYjxT9mffpllTDKbyxcwXZj+yzr3t/rLR4asDibFMt1OSvUYGthd3DZnjqfNZLio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kClClzuW; arc=fail smtp.client-ip=40.107.209.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kClClzuW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryH+nTPpEzDNrV8YuyNM35NE14xpsNZto6ED5d/3EfXT2m8p7dAScpIlQ0T3eWJmNlqxBg7SJ58nVvRuhWs5vMO7EHs/cstjcaLOA2gXBKUle8Rl3FR1FgaEZbadiPFdjzMPx3YDpyWYoo6x+aR/TsTYWz8ZNs8Hre7P0EpN9f2M9eo+MtD0fFLoylTkGPqMk5US8SaT5NZSfkafwN9nUZrtkidQVhCu0lcXdcjWby2QJQo2H4PpUB9R7obmvDCaMUUoECbR0/jOdNvYIGhnmPilMDvxJbiPMFHqwj5wRYqoJ4p6rkJA40lbTMPaSeKdE98RDiaC0WLYU5aZQ+/grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yucUo440QK3mXnSMuE1RpL52JkUp2A59xoMD4DssE0g=;
 b=YB0nOZ8Zg0LERoBJKGtKOnSUTquFHyN1tYICBq4P8gwYOkJPkoQouliMzaK735q9lhuphaoOgVrXzI8kJsknWyrT8hyoanAiQQWkV1fiybFyzGeRWkE6HqIRyJZSiNSCUKaDovlMFBAzaBrXHsjkVB+wglhz6suBe+UQ/OFFbfypfqjuXZlVlwmmqCMLaZSYMftGEn+GBKl1z37q6YrEFdM7chnyr0KK1TlIIbhJjXRxG2nCeTgecSx061m+DA+EJFE99ELU+HkQBmw7VkPalF6CkOiRIDVwt2J2oEnPOErL0te4t8AMSCR1pGjkLsSOBtqh1jZuua62JgAqr2YnjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yucUo440QK3mXnSMuE1RpL52JkUp2A59xoMD4DssE0g=;
 b=kClClzuWtZa9coOHG5LpzSJ+wcDYVAaV7fHdnFnvkeGfbzLmOD8Qqfb8sZcpjjZMzGQGrSsK0kumWqPIb9kyXoS4UDeLHnySa4CUBICtRH7GKKq6MwmLQtSj0wpGklAczFFJj2Q/MAGF1EjwBywiI3+kGT/08PUcmEOk0Bh4i7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 08:49:59 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 08:49:58 +0000
Message-ID: <cf136d02-986f-402c-81d9-8971229abe9e@amd.com>
Date: Mon, 23 Feb 2026 14:19:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
To: Johannes Stezenbach <js@sig21.net>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <aXeAOtGQUdlNZF6V@sig21.net> <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com> <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net> <aYSjoRjnR3N3D8lD@sig21.net>
 <49856fda-3f65-4fc9-a75d-84b29526f3fc@amd.com> <aZoVhnX77mGUsV3y@sig21.net>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aZoVhnX77mGUsV3y@sig21.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0203.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::13) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DM4PR12MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: 4752f9ff-a552-4996-149d-08de72b88654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bVVXaUxjUDlDTW1sZUtSaFhhRnhtUWdpSDJWbnhJMHVTRk40dHJPcEFvVDB3?=
 =?utf-8?B?Rm0vQ1FZK2RRUEFJc0ZXMWUrWUdVamVEVkVOS3p4L1ozditlUkdGY2FQVldV?=
 =?utf-8?B?bUVtaG1pREp5Yld0elNUOGtDZTNEYmlJKzJBRTI5YXJZbjVLV01EeGtpSGdR?=
 =?utf-8?B?S2QyM1NiZjRFUlF2N2t1L1ZmV1dsZExFYUREZDczd0VPOWVpU1V3dmtxTnJi?=
 =?utf-8?B?MWxzQkppbTl2SHFlYWJYWko0YlhNRzFKR0IyNmQrKzk4NVhwaGNibzFMY0FK?=
 =?utf-8?B?eU1LcWhma2ttWEFCZmtBc1ZrbzdaMnkvOUVmZnFmMk01bGdDa3dwMG15ZWdT?=
 =?utf-8?B?Y0xsY3lhWXlBSE83eG82MDF6KzVHUEd6alV5RktuZGR3THBRZ09NTXU4b0ZU?=
 =?utf-8?B?VzJoNktidzBxa1ZQMENrV1g4KzVMSm00OGlaVk5LUG9pN0RiU1FwNUVkS1JY?=
 =?utf-8?B?THZWb2o1VnV2L2Zja3NCa09FK0loa0p3RTRzdkZwTVBGVDNmZ05ETzR3cUN5?=
 =?utf-8?B?V3ZFNGRaQXVORW5yTnUxOURJL1pIMm4zYURQcDA0NDVYOGxDYTBpbUtNN0ZZ?=
 =?utf-8?B?d0t6eUhSQ3JxL3ppZUtNbytrRXRZRmVzMWV2aWJWV1lPakczQlVCa3hYbUZY?=
 =?utf-8?B?NUw4c2ZadEF1ZjRFRmJ3YW1CY1RLYmwzN3JPRnlHMnJ6blNtWCtnOXlaUXJC?=
 =?utf-8?B?Z0lCVTZRMXRoR2MrUWwrYjM5SEg2QjVRSHdsblVIeGxhN1hZTXpHc2pOVjh6?=
 =?utf-8?B?YktiRTE5WWhkdDJtVmpCbGRWZU8ydGdJenVXbXgydGNBbTMwNXY2MzluUER4?=
 =?utf-8?B?Y05sMk9SaFFwN2FUWlA2T0VBU3FMTG8rYmZKWWRUdWhxMjFRclFPMlFWcGhB?=
 =?utf-8?B?d0lnM1Q2ZTF5QTR3dXcvTUhpZ3hzWlh5U0l3YWEzVDFrOGxjWEdsUElBVldn?=
 =?utf-8?B?UlRBb25lTjZQaDdkU1lPeUtqMVErUDUwMkFoRy9WcGN4MXN0Z05lV290eldr?=
 =?utf-8?B?dnlXMVJqUkJwbmRhWGY3ejlZMEJJdTFPR1owT0JWWnQrZzk0a3ROL3B0S3Va?=
 =?utf-8?B?MUZuTkxEa3RxeGtXeXZYUTNKdnMvVHk2eWFiZk9EVkJHdGloR09lR1JuMGJo?=
 =?utf-8?B?cnJwSUJsNWtmbllFSm5mSUdqeXAvRkFwUlU0VTlINFFsNnFvbWZJcHIyMzhv?=
 =?utf-8?B?NXpMZ2xVRzB1WW1na004VVYxK3JCUXFzUzZSa083aWVzNERlSU9VTjNXekFn?=
 =?utf-8?B?UTAxaUgvZzlhRW9OMmJZbDV0WWdSNHlHVDdudHVlK00xa0pocEtwUmJYdzQv?=
 =?utf-8?B?UjZ6NWV1TldVeldydGpIenJWVEFUOHR3NkpseUY2WE5MQm0zSFFTbWpKWnAv?=
 =?utf-8?B?cVpRZHVWcVVlOXlDMFp1Rit5OGplZDg4cnFEanR5NUJNbmhmVkVJMFpqb3RC?=
 =?utf-8?B?a2dqbGVWaWgvd0Z4RU85Z2Jjb3VXRXR6UWo1SlBIWCtyOGF4NldVN2FwY2dC?=
 =?utf-8?B?TnRja1B4MVI1bnA2WXl3Tm9jRFViWTVibS90VU5oOHFYRHpFS0E3ekVmYXhk?=
 =?utf-8?B?R0pucTZSdGdNRFVPeVdMaDdUdHpUOGI3L1lxdlBEYlpjRkQ3NkxlQ3I2WHFI?=
 =?utf-8?B?T0ttNzY0eWN5UjRaZy9LNGV1T0FySXcxTDVBdVJucnhHWGFzOTg4amY5T2ZI?=
 =?utf-8?B?cituaWI4dkNTMjlpV1VZNnEzZ0VjT2lSSTV0bWtKZDdYb1Rpc01RMjNiMHVF?=
 =?utf-8?B?cGQyVU1tSjFhM2FGaGxacExIMGlSa1RidENqblBTV3FUQm10aWZSbzR6bDZH?=
 =?utf-8?B?YjRzSTlKbHJJaFJzNTVKQXBCb25IU2xnVURycTg1b0R1aXZHYlVYdjFjT0Fy?=
 =?utf-8?B?QTc2NGZmSTVhVi9aQngrZmE2RUdlVWI2NXlLS1I4U1JJSkJ2QkorWnF2YXlF?=
 =?utf-8?B?NGl0SSsrRlcvR0k0NG44OStmSTduZUtXTE0yb21HRDZ4a2greW9Jc21HbVFU?=
 =?utf-8?B?bi8rbHdVK2I3czl1d295dXc1dGp0MWNlWmpnOVlwUGx4Y1o3NXFQRGZ4aFNS?=
 =?utf-8?Q?gSKDMV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anVzdlhQTVJ3QzZseS8xWFlxbmVxSVpXRi82dnUzTXE3RTFHVVpBbmM0dkUy?=
 =?utf-8?B?Z2JLaWNBN2R5WDZ6dVkwdnN5K1VyZ09LTG9QVzY5RmVpOERzN3lvc3R6RFcw?=
 =?utf-8?B?clI0bldJMUNGc0p5Yk1UWmxjZkxsK0tkVlEwWEVSN2M0L1NIdmhrKzQrZk4z?=
 =?utf-8?B?bTVCV0p6Y2pUN2lvZTA4ZDFqNjR2RTJnUUJUY2NWUkZLdVJsaURwRmJOdFk0?=
 =?utf-8?B?ZFZhc1FwRkEvVmVBVUxFZGlOdlgvMnpXOGpxMTErMkNkMHRzUjhIbnExR05C?=
 =?utf-8?B?WFI3cVlkT1djNCtaU3BKSXhFUzVyMnpEd3BxQm1qUTJRZUJKeGVBUjhNL0pR?=
 =?utf-8?B?OTJXQk9CQ2FmOG1zSnZCWk9kSy9CQXR1SFE0U1o4ZUpZTkU3Mk42YzlWRjBM?=
 =?utf-8?B?cS9nVGEraWxKckVMYlZYckV5L2lqZFFkSDBxQ2M1RmtFWGw5YXZQT3VMUlJu?=
 =?utf-8?B?TTFHZThDeTI3cElUUGV5bnZxTmZTeXo3V21BUVdwRTZKNlFGYkNhaXF5bGN2?=
 =?utf-8?B?Y3NFdFNxMzhadEJlUnNYdWYwcEhtKy9MbWZsQzRRQ2xSaTNDcUJ6Z0pPQmVC?=
 =?utf-8?B?NHVuTno2ZWFCWmxOWjl5N2hYT2o5NThWeVdjT1FJOUNCWW1lcEtDUzR6UjFN?=
 =?utf-8?B?dS83YjBuOUpQcFdzZVE0T3Q5VlUvenFzWHBrRFp2UFJ1cjBJNWVIb2p3WVBM?=
 =?utf-8?B?Y3k2YUhuV3lwWDdrcDhubHI0SUs4VXZxeGZBVmlkRXBBV0htV3JhTVZ6aVpK?=
 =?utf-8?B?TlF1L0FyRklLVjNsUDJSQlNKdFpqTExGRzd6MXZzMlc1YmZjN0R6KzdTSHVa?=
 =?utf-8?B?bFh2bWFybzNWMFdqdDlPb2ZjTE1nWHg2cTRmczZ0cFlZdzcwY04vemM4VXk2?=
 =?utf-8?B?QmlrbXJWZmFwT051U0V6bS93aVFGaWJtT3BHcG5CYzQzUUJQUHJ6cCtqYW1x?=
 =?utf-8?B?L25GemNKNkhrVlFPYnVrVHZQRGQyaWNIWFJ3S3F5QXljMkh6VnF3TzJLc01E?=
 =?utf-8?B?WHlRV05ibTVPRXEyNmU5bjdJQU1tN2h2dUpkVkZyK3NHS0xZcXB6OWpRSkVz?=
 =?utf-8?B?cEpXbW92SGplWlV6dUJkSnhiUVRjZ3IvNHk4bEpoM1N0cmp2ZHR1MzBCWHRB?=
 =?utf-8?B?U2xWSEd5M1h1RVBPRFZnR2pMeFJEbDB0SDRtdzBJTTNEUHlzbjI3dWpqMDEr?=
 =?utf-8?B?OU11NVJRVklkNXJyYkhUMDd4WFlIcmtrQ1pMalBLQ0oyU3NuMWczaUxsclI1?=
 =?utf-8?B?SW5XR1owNXh2SVRqOGdxdjRKaVBPUk9aSkY2ZGlBVHM0NE02SldpNHBNVlc3?=
 =?utf-8?B?WUI1a3VON3dFdG5VSkJpSWlFb1J5S282MkFGWk5kbHU3U0FiUmFvdGVBZE53?=
 =?utf-8?B?VEMrT0VrS3EzbXNWeVowYVQreVdHVXBNNWJZOVdhSGhuRmdOV1JrQ3NLWktU?=
 =?utf-8?B?bVMrQVJPdmQ5ZEtsYkJmaGRMZHZwaDg1Zk8yY1UvMWhma0JHVDY3TENURnBZ?=
 =?utf-8?B?cEh0Q3JhY2Z5YndScGpRRWZxdHR1aW9WRS80MDFsREc2cU5RUHhEUmk2WnUv?=
 =?utf-8?B?cjV0YmxGWGJnOHYrY2s1eFJKT0FtMHdVUkZZSFhEYlB6QkZoVmlOTERVbTRr?=
 =?utf-8?B?QXM0WFdGdGZsbVRsMUFMdFYvcVNXTXhPUE5QOWQrRzRXYnlldkZCeHd5T1BQ?=
 =?utf-8?B?WVlIZHdqSXJIMkhiNzIxZnpBSnpLTC9mekh1KzE0QTlaWU9xUDNKTGZHRjln?=
 =?utf-8?B?VDEwTWVBbExYRmlIbzZhWSs4dG9ENkU0Z3pNY2IrcGE4Sm5QcHp4ZDV6TEx6?=
 =?utf-8?B?SWZPdFF6TFdWS1BUUWk5YjFDVFI2V2JLcmVsaUtyT3Uydko5MGxaemRJK21k?=
 =?utf-8?B?YXkyVkdyNDdZcUs4ZHZqdENtajVnQnMxZkdrb2RzMm0zQWJTTm5PUitrZzd6?=
 =?utf-8?B?NE5nMDAwcC9maTNUem9LSStPUnMxYkc0VkU4L25wOW9SN3p5b3N4WEdkUTZi?=
 =?utf-8?B?NU0rV2RhZEkrMHdEemdUbHUrc0ZQQ3R1QXQ3K3BhdjNXYTdrKzZzUHFYYWtV?=
 =?utf-8?B?eHhncVRsYXgwNlpONmJZZ3kxTmNQcDU2dEFjV1lLcG1mVitSWkJJS0c1Z09n?=
 =?utf-8?B?MXRzVitrZlhHNUZ6UWZNa3VHZEd1U1gyMTZvbUF1MTRwaVgxc2hhcE5xSUFG?=
 =?utf-8?B?MCtlQ0t6bVljcTBKdWhSR0dqMHNNSFdXWWNTM05yL1lJbFlWaENCM3I3aFdI?=
 =?utf-8?B?ZU8zT1dMSjkwRHk4MzlLeW5DVFQ5TzdYamdBa1VMNGY1RVYrY0RjcGdjTVdn?=
 =?utf-8?B?VkEraDd0RnhuQ0VmdUFFUHZ4aTc3K0d2RHZZSW94TXZvaDdXS1RSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4752f9ff-a552-4996-149d-08de72b88654
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 08:49:58.7804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pRvtMzhYg+qyEyb1b585VIWDxgoGKzcDbZlkLwo0Pxs86nRq5X+vIbx4SZ7om1AvVoEDUr0KH7txig1Vbe8oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6109

Hi Johannes,


On 2/22/2026 1:58 AM, Johannes Stezenbach wrote:
> Hi Vasant,
> 
> On Sat, Feb 21, 2026 at 08:01:16PM +0530, Vasant Hegde wrote:
>> We have managed to reproduce the issue internally.
>>
>>
>> On 2/5/2026 7:35 PM, Johannes Stezenbach wrote:
>>> On Wed, Feb 04, 2026 at 04:16:51PM +0100, Johannes Stezenbach wrote:
>>>>
>>>> Side note: I wanted to check AMD documents at https://docs.amd.com/
>>>> but the "Create Account" button doesn't work. :-(
>>>> (And why do they require an account anyway, Intel and ARM don't...)
>>>
>>> Eventually I could download the "AMD I/O Virtualization Technology
>>> (IOMMU) Specification" document (link on https://uefi.org/acpi
>>> is stale, BTW).
>>
>>
>> Latest public spec -> https://docs.amd.com/v/u/en-US/48882_3.10_PUB
> 
> Yeah, found it already. I guess I used the wrong search terms,
> trying to find docs for the 8700G. Later I also found the 
> "AMD64 Architecture Programmer’s Manual Volume 2: System Programming"
> which has info on the APIC/xAPIC/x2APIC.
> 
>> If you have cycles, Can you try below patch (untested patch we will test it
>> internally next week)?
> 
> I tried it with 6.19.3, doesn't seem to work reliably, but the
> results are mixed, sometimes seems to work, sometimes doesn't.
> (Trying a mix of suspend and hibernate, and hibernate mutiple times.)


hmmm. Is there any pattern (like hibernate -> suspend failure) ?
Also do we have any other interesting message in dmesg?

I went through complete init code today. I don't see any other suspicious thing.
(disable -> enable sequence is proper).

-Vasant


> 
> I met the familiar
> 
> [  301.963784][ T5153] i >= MMIO_STATUS_TIMEOUT
> [  301.963786][ T5153] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hiber
> nate/5153
> ...
> [  302.304252][ T5153] Call Trace:                                                                                      [  302.312118][ T5153]  <TASK>
> [  302.319113][ T5153]  amd_iommu_reenable+0x10/0x20
> [  302.330910][ T5153]  lapic_resume+0x176/0x260
> 
> on hibernation entry (doesn't show up in dmesg, needs serial
> console) and also on hibernation resume after image loading
> (this shows up in dmesg).
> 
> 
> Thanks,
> Johannes
> 
> 
>> <--
>> commit fd6196203c8637951e56bf144015c020f57d5a34
>> Author: Vasant Hegde <vasant.hegde@amd.com>
>> Date:   Sat Feb 21 19:48:59 2026 +0530
>>
>>     iommu/amd: Skip IOMMU re-initialization if already enabled during resume
>>
>>     Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 384c90b4f90a..eb5bff024f95 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -3058,15 +3058,23 @@ static void disable_iommus(void)
>>  static void amd_iommu_resume(void *data)
>>  {
>>  	struct amd_iommu *iommu;
>> +	u64 ctrl;
>> +	bool enable_intr = false;
>>
>> -	for_each_iommu(iommu)
>> +	for_each_iommu(iommu) {
>> +		ctrl = readq(iommu->mmio_base + MMIO_CONTROL_OFFSET);
>> +		if (ctrl & BIT_ULL(CONTROL_IOMMU_EN))
>> +			continue;
>> +
>> +		enable_intr = true;
>>  		iommu_apply_resume_quirks(iommu);
>>
>> -	/* re-load the hardware */
>> -	for_each_iommu(iommu)
>> +		/* re-load the hardware */
>>  		early_enable_iommu(iommu);
>> +	}
>>
>> -	amd_iommu_enable_interrupts();
>> +	if (enable_intr)
>> +		amd_iommu_enable_interrupts();
>>  }
>>
>>  static int amd_iommu_suspend(void *data)
>>
>>

