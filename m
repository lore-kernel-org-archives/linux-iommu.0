Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23864292A
	for <iommu@lists.linux.dev>; Thu, 19 Oct 2023 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UEJDIxjs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQvO3prf+MusE0xjandLI8/Vrx1+2GD7pEgaBrhPJUExGfZLsFiW9wRr6mDTGUf3joSyd3Iqnca3votdiifZrpfGKTFGQeUKlD5JCTCGIEdpQ2bmhkRbDRaoXyw+1H9iASkkJhkRMQ8OZLlGymyE7qtpkD5N8/RWpBZmiigTA36e6KXQW66q920ceKHRbPBMt3brW156YZBcQ6egawkekogzphryQ50L3hY1lJYjtvjYIiMWsc3D2+Tel0A0HALKWsrOURbcZvz1zgqqudtmzeRDszw0Sae9jSyeNlEa2N5MkBYCX3MxNVuYUMsauMi2IKucmcn71n1Fynh0/bTiKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vr9Db2vF6WENWbbDVaLZxBZimfY2gfnshi9pDZIT0IU=;
 b=IqoOE5gZi0+q75dtSHS5d48Il/XW1OyLMA59RcMlw25w8X1qNGoZWQIryD26UMDk16eR7r4Y1JEMMiOnF8O6yFAXOgMHigxedZGhmuEXReEO8UOjlf0Y29IwbFYAmP600kQPI+8JuS3V+ojqXIY4SFatjd77NuyKVSq+Rh0wkEx9dQ4p7iJ6qG9IdmWN7LVzKRgGh4GsmdRxT1h+a9H+sHkcz1up7/UU06UqyXGLFKZ4wZ2ql4n06x7CGmnhjMhH9EnAlQcvw1vNC5FKv5T513ZcDV1tMfC9qswiBt5JfM+jDuenSTgesvaL7AaeMvcGlg+joq0NYBGVVuTBPL14xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr9Db2vF6WENWbbDVaLZxBZimfY2gfnshi9pDZIT0IU=;
 b=UEJDIxjsmyQyuzg09+Glsp2h0OydVLpvE15F5wJ8dE1AuVSqARL/K7yxTSkNVqp2uBljDGIecaW1LVamWpfxcI1EeuL5d1QQcUrcnQW+wVdvyLmAW3I/XNr7Vu7WthT8N6rSz2wJ5ML7mXS9sIZds6SOdiuaWcQmoJfCS9b27A7otKP2dIBdb3DrcDebxfXZqIsCV+dbUNt06qp2TJEHr1vR+o5dTKHCTV3bzFQH1bkpeba0tZ16WgdxGjyCD8CcWRGVgUQ+qjKj5aq+JEX3si9wMNFMPd3jVg3PKfHd54TBQq5Ft+Le40mVvaJXTBE3olqvbrwIBBSs2nVcNdC8Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 23:03:05 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 23:03:05 +0000
Date: Thu, 19 Oct 2023 20:03:02 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20231019230302.GW3952@nvidia.com>
References: <0-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <4-v1-e289ca9121be+2be-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV24gTmBTEVGx__mSs9bQ93DLTZ-VDbpE24S87kgXS+nHhw@mail.gmail.com>
 <20231018122435.GS3952@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122435.GS3952@nvidia.com>
X-ClientProxiedBy: BY5PR20CA0006.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a965ba0-bac0-4825-18fa-08dbd0f78d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gnOgRODEbzl4l+zeVHBRZYwq/ClG9B75UHXJc04Vrnn3l7XfK4VF8WfDy3vWqJANiJFS2earJN83vk2lxXJC/KMD/inBHePMRsosr2hpF0xJi2JYxtHtvtVZZB1lHZOUMPsrD2sFHMPYcfpY2ry2zXxVLVWah/15yXzZr3IjpKLFaM37EWb0+mYrT/TS4aIQJILN2jiRi4dEic75u5dK8sNfznjis87eBXdvl8tR3J/yKmz2IjLE6tfOasamYLKpqxM5onM8Ksf64HWXpdCHHWU6RL8r5te4fHl00s1K+tFV4n7C9Iwz2YmHv+5RzRWdp3Svw9/GYPQdoAHa7Vs1JXgxNObTPjn/ItrmtfgpHEQluYrmDVmJLp3fPvae/fHfjqw6zDizn9vnfpUZrr4N3+l3/P0DaYsqG56DT3q7DH6UYpPJphXg6S/pyytLBCrL+F+BjbEjnF6wibcg0L+YK7WCT2feSkZUUjJVbimmYo9OVx22JfaVRN581pRj+32vo89NHAdNvZQbdUhr20Ea7W69Dzj2ncWDTLy5fMdRyfs9Sm/DsClTkuim1lY3Z7Lt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38100700002)(4326008)(86362001)(36756003)(33656002)(26005)(1076003)(107886003)(2616005)(54906003)(6916009)(5660300002)(6486002)(66476007)(6512007)(478600001)(8676002)(2906002)(316002)(6506007)(66556008)(66946007)(8936002)(41300700001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vIky0QelOMjtZ7jm50VMS/IBYAv//VJ4IMMNiRg0tdlrt6PxdwmUfNiIKtyJ?=
 =?us-ascii?Q?nInhTarCUgCTuLJgSWDpjVnwzFsml6ltAqRc834VDar5Ojc2oPMSKjV0ToFN?=
 =?us-ascii?Q?nYmjNZMmLM/Ag+ieahYuobe07Kgx3RMSUfJy1QtkPwOc8klC0HTlOiDVQicE?=
 =?us-ascii?Q?T7CWZb6sfju/PAqJJ1CPG3xY/YXvJKh97UxXrWiuOnsP1Z5Yfego3XSradsR?=
 =?us-ascii?Q?0+gSzaUDFuPuKGiVD3lABTYFzzXCUGatjOSLY95oBU8xkGL1GHYDlcVHuJMT?=
 =?us-ascii?Q?3TzmcY+Epuy0YKNX/S8eMP5hMhyHHWunTW0unVHe6dLIy/Mt2ZToM0SCLptp?=
 =?us-ascii?Q?ggOunP0SO+MUpr/FkgOAW23tKx8qYZ48YECg28Yz4kAJ+72Y8PfyUKvWlYXl?=
 =?us-ascii?Q?5I+C4/OCPjcoW6r+ibqMB+wQlHPYb36f0Hgcv90yBuNww1iFGTjtNZdOuXvD?=
 =?us-ascii?Q?EkCuRu+fHbXiPMFvo2tjWJh+/Vw2zO8SZBvLRCvXm+DGuZqLGEwCH8QfExgR?=
 =?us-ascii?Q?OncATPBN3x8Y0uh+zUwmGEauQV7RbHRgjRE1+T7zzjV7rFzU9kHCdCEOA9Zp?=
 =?us-ascii?Q?50rcYuiuSd3xtKL7qrrm6EX1WmxlmL9GyzP5nX/INiiKoZBzv7MeOHyXl5BF?=
 =?us-ascii?Q?vb9T9SuSODq84eDPdRufW7lxaq0PUwxsHDt4WY8FgkfYRnwZpsxcTZBtnvnA?=
 =?us-ascii?Q?K16yffsl70tRX4aoWAv92/IrDYZRCFyXLUOL8zcT9Ln3Vs8XtV1OaR2fZ1lT?=
 =?us-ascii?Q?B8Q31iJRU+oBYcee8CFfOKaNQM3vJoQjhGsQVwei933X61NfWQsMlUNI+s09?=
 =?us-ascii?Q?u1PucjjkwAU0dAWWTNG1w0wFBkBWlEuiv2GcqzN1Ca2krPrCzsUh4QhoPgD6?=
 =?us-ascii?Q?N+Taz9NGZuLOu7jMy5q3D5g/tiRrJR7EZ8T3oN1DKp1B7qEAe+Dbs9HHAk9C?=
 =?us-ascii?Q?ttiHSMxu4Th35NHm369vd+dFmUtbUTOU8+PtJ9TbpHmeduCHWYFT1WrIeCLr?=
 =?us-ascii?Q?BgGsGuzrjLnZRkvXn0UmyDSOedHL/LL5G3YskdSytTU4jjcpQ3i4QzTBS8VT?=
 =?us-ascii?Q?JAtmz4+P/qZ6FtBBv2cciW22Vgo+xBIXt9ze8kgnj/fwzxtIoI45dN4Lm3ut?=
 =?us-ascii?Q?BQ7iYIxTAwcSYLizjcqjpnLq2cC3FQp+oyysVl/YdCmfTEiVeyRwQ7ebnHme?=
 =?us-ascii?Q?hicUqD8gb2u9XVTitOmfxVVGiIbK/ulUWrjGkHryeH35791AO4ZPnYrReTOP?=
 =?us-ascii?Q?mbwrH2bi/oJGYe3tZLhRA0KwHSsC2KzEfmjW4WJ9303AF3uwPmYM0IMERRVG?=
 =?us-ascii?Q?cvMKJ0Q34cRqexy3iMf/hGaYBv2SBBrMFmNKCLGWJFw/XhRrS+0Jiu3ODCZ3?=
 =?us-ascii?Q?4CNeti2XgYgHWHvRxKk0nQ22QPF7EnzV8YvIBw47dwPRGshBU/5B5WSNlaqF?=
 =?us-ascii?Q?Eu8OHFDvfEmmrF/EY7PVki6g4GFyrGhIvi+AAMXDXtSNfB5jX3IF7dnFGR8w?=
 =?us-ascii?Q?JuZpP2mSHE0/+z50zw0RcK/DksiuKY3hxk2Jat8W+5/2hDOHNrQhZOlzTSpg?=
 =?us-ascii?Q?j6zjkbYAqCX0OJdDMfADgY9eY2tO2wqRKbBT/VdO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a965ba0-bac0-4825-18fa-08dbd0f78d5c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 23:03:05.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McFsvcO3DhsenNwvydihDixMI+6aJ3wCMQO/w5u++TG9NsZKyDxXu1i7PTjNkB9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699

On Wed, Oct 18, 2023 at 09:24:35AM -0300, Jason Gunthorpe wrote:

> Let me see if we can get a deeper understanding here, it is a good
> point.

Nicolin found in the specification "13.5 Summary of
attribute/permission configuration fields" which the row for STE.SHCFG
says it is only read for "Bypass" or "Stage 2 Only"

In Stage 2 mode is combined with the IOPTE (TTD?) and since the kernel
sets it to 0 (weakest) it basically looks like it means the IOPTE
overrides? In Stage 1 only mode (eg the PASID case I worried about) it
only comes from the IOPTE.

So like this:

@@ -1393,12 +1393,14 @@ static void arm_smmu_get_ste_used(const struct arm_smmu_ste *ent,
                                    STRTAB_STE_1_S1STALLD | STRTAB_STE_1_STRW);
                used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
 
+               /* See 13.5 Summary of attribute/permission configuration fields */
                if (FIELD_GET(STRTAB_STE_1_S1DSS, le64_to_cpu(ent->data[1])) ==
                    STRTAB_STE_1_S1DSS_BYPASS)
                        used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_SHCFG);
                break;
        case STRTAB_STE_0_CFG_S2_TRANS:
-               used_bits->data[1] |= cpu_to_le64(STRTAB_STE_1_EATS);
+               used_bits->data[1] |=
+                       cpu_to_le64(STRTAB_STE_1_EATS | STRTAB_STE_1_SHCFG);
                used_bits->data[2] |=
                        cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
                                    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |

Thanks,
Jason
