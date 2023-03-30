Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9803C6FB1;
	Thu, 30 Mar 2023 14:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KI402RmkptXefs0dY2SRB6XeiwLA2p0AKCKv+hyAhKNUHXqzSWu8yR0XQSJfkBim2RqP8/K9fEv4NATlnDVPQIDr6m6tpOBeK67b91R2tadm5yhQLPKphzht9dWYVlMGd1E1wKSsOu5IHAh4PmHFwPVpNOA7tbuR2ZsT3gyuDgk35d/miwo/X9h7YuiOfIyenNA6K1fYWPm+rNxn0SQhIF/usVah/IH58YTg44MJpc5Yph54aMV4jiq/NmefW53sgKahRKg78N1DvA0fF2VWXG5E2pwt9e3auYBGnemW/U4w4Rh+707RPM2U3fhzxbJHwKIcNuwwdFYQfQAuZC+4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QO/p58D+xG6x3KlHqZGHDt8Kvkg5Em8lBxRMMk96joc=;
 b=is84j2GTGxjGVvp1d5Crx5Aw9WETFaxgq+4XmaidYZHvzEQRbCYBioyeGnW/JviVdUmXg8TiP/bCSbJZmvhomYeHPinUdgyyBlcNDrf9wmhG7csuVkDfXdwFKYCK5dFUO7AFBBTMAEUs40Hyw9QDmzdlrO0q9xzQzwz67gLtgWhWzmynp+HuQrUBj+v82OlIesEae0wfNhajh+CxyPxsblkbUziYnm9oPOJH237/puL4zFjEHRlYXj0lciyQSJDwkbNBO5LI2ovrpIE09TKqKx1dg+qajyVm7ES5ZFFO5CpS3866IfOD3HBaicmIxJks+/14Ic1W3SEuDVcR2tXRAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QO/p58D+xG6x3KlHqZGHDt8Kvkg5Em8lBxRMMk96joc=;
 b=jXhgshAUYgCI2hfpC9GyDwHtTmZDdYRXK9fEDpMvPXuTADUc+aw9LgwRziP9qejLxcfJcK7pVklGcwk6S2URAVsrDagBkGb8P8Ow8T5im0uD+NX1prpesq2LC5VkNLCpjs78zZxVJ2fNq50NnkLokKRnviQPY5WyIFJnyTZQYCBeP1lynJ63Avoy76A23vAkuu1jzs9uXknNM+C3ILfh0tmcMP3eOd8mRVADq92dsgxOxYxZXfw6CwaYHQbWw5DtY12h+PWZ0+Dtg7BF7ccBdUAepSbHweDkc4Idd38NIs97ojv7JyFL8uQ1YovhPyezKow7HeDWozMsrIqCimOd4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 14:45:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Thu, 30 Mar 2023
 14:45:11 +0000
Date: Thu, 30 Mar 2023 11:45:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, llvm@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Tom Rix <trix@redhat.com>,
	Will Deacon <will@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 12/14] iommu: Consolidate the default_domain setup to
 one function
Message-ID: <ZCWgdiT12RixU7wU@nvidia.com>
References: <12-v2-cd32667d2ba6+70bd1-iommu_err_unwind_jgg@nvidia.com>
 <19197c52-139e-c3c5-2771-42323d38c045@linux.intel.com>
 <559f8b71-6636-b4b8-27c4-bd0764baa741@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <559f8b71-6636-b4b8-27c4-bd0764baa741@arm.com>
X-ClientProxiedBy: BL0PR0102CA0046.prod.exchangelabs.com
 (2603:10b6:208:25::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: ed87caee-3723-4b06-7f40-08db312d5d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6uzYj+qRhii2XKJCTpkFf/eRNN0CzJh+/PqFsK57LlW+HfpAh32IQxQj26b5URcVtG0+Ov0pi9CqLvlbzMqrYZibMadC+w9blBzYFZEMMsEIgFNpYIr3KD66qVjlS/XT7djilWwG1/VQ3EyO36ithaIT4JhZAIVwJcMjjnMEsBzNQ7HCINp2CPz4u675grPPokeRx7YUNyh78cR33FeSykw8iGYW8u8jqWrRbNJ0a8ooYhsHeYGL9Hm4k4XWn7MJqCwpOp+eegKDmAy/KoYG1pdkedc53Ad+2RzogChmGf0tJj9cMa0wqhcqLWzvixovhX/+npsgXJh8b6pvjPC2hxLG8/4G2iltmJ9D1K+l4lmfrPVwndpddJu4MOwZoN7qbTqsvnc/7tywI8d+qBPXBhnyk+NlmfEKI8ZGX7AZ9D32WEkpI76UBQoXBo56aiX2sHdKYVUhrq0Pb2J5rG2PXxGWd21tRvZAl/PUklrXGDfslvcSx3kh+c6U0QIuL4Y1akl1vJyBydtJCo6CNr3IgbcKEBt4nNNKTmc3Ctg8ynueShIlJWoNrKIIBFVBVBUD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199021)(66946007)(5660300002)(186003)(8676002)(8936002)(41300700001)(2616005)(66476007)(66556008)(4326008)(6916009)(26005)(6486002)(86362001)(38100700002)(316002)(107886003)(6506007)(83380400001)(6512007)(478600001)(2906002)(36756003)(54906003)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFdWdGhCVVhuNXJIQ1VRMjV2NTNHSUlLOHM2NEFYbDJSV2lwUWtSM1RsRjZy?=
 =?utf-8?B?aFB4NWlndEY3b3YwVWd3Y1U2MHJlbEJwNDVnWTFkb1Z4L0t4blYwSWd1RDY4?=
 =?utf-8?B?WS8rSHg0WGVKa3lNR0NMUkY1MlpNRTlyajJwZWxKdjlHRmhkczR5eDRhNk9S?=
 =?utf-8?B?a2tjQnM1WXp3NlE1MWJ0NnplZWVYZDIybVJYRDRLZVplam8vRE1iS2dtNzZL?=
 =?utf-8?B?eG1YakkxZVJya3I4eDlYOW43Um9ENmVZdnoyM2I3d3haaHE1RjI0bHJ4eVFs?=
 =?utf-8?B?S1dqYnBvM3ZoMmpVaWxybUFaYkVwMXpsYjJyRkRFdkdGR0FBS1drUk96Q3FS?=
 =?utf-8?B?MEdtMjZQQ053UW91U2xVandGVmVJT05lOW9uZzBDRUh4Z0ZVdFBTYWFmYjdp?=
 =?utf-8?B?SlFQaSswVXFPSlQ1aUZlMGI4M3dEMnZmbWN1MlVGR3dUYTZML1NZU015ek1F?=
 =?utf-8?B?SDVPUGY3SXdpUTQwNCtGM2cybzB3K2NObGNsT0xVN21kVGlkT1M2UCtvN3Fu?=
 =?utf-8?B?YjJmOCtLVFE4YWtVNWtSd0E3eHFZa0wwVWd1WUl2TWE2SW4wbTVpanBhdlBu?=
 =?utf-8?B?SUlqeWZMVnBMaUdtek9FMWR1ZWdZUVF4YkR2cVo0UGY5TGdWLzZrNFdQNHY5?=
 =?utf-8?B?MkdYdzU2QkR0Unc3U2tMOWFYdDZaYlhLZnZscWxOcnJOOGZ3bm94aWFuM2xi?=
 =?utf-8?B?aEFTTjByL1NXWWptMmQ1RmEyalhKQ0RsRjc1VE1JNSs2ak1haFN1RllPOUJ4?=
 =?utf-8?B?OVBKQUJLYnVydmMwNnIzdmhMWklMdFUyTVd4V25xMGp0eWJMRXN3M2ZMc28w?=
 =?utf-8?B?UEU3TVJLVDlZNzBKWTdCcWhYVlFQeGxiY3Y0Z1JTSGxFSnNsRUljUHlCR0cz?=
 =?utf-8?B?cjA4UU1yZXlkYWVzVlcxRGgwK0ZoTnZpb2JnaGVPUTUvSTZ6TVo0dVhRdE8v?=
 =?utf-8?B?Y09hTGxOVFcxT2tUWWJ5MDVKcWM5c2VpQjM3Ynk5RExqQ1c4eFM1eTBNWXpO?=
 =?utf-8?B?YVduOVJzczRya2ZGTmlZQ3FyZmVudHF2RXRDTXU2M3EyRVFvdE0xSW1VVDBM?=
 =?utf-8?B?akp3VUNhUzVRUHJNWjJ5WjEzdVRuNENXS3lseXZIM1Q1Z0Rvd1VOV1RPM3Rn?=
 =?utf-8?B?aUV2OEZSaFYyQ1hNakNGTG1OY0VMNmdFWDJHREdHZ2YyQ0dzK1g3ckozNUVM?=
 =?utf-8?B?RGtMVzN0amZoNWMvWXE0cVR6bEM2VHNxT0swWWl4YUtYakRWOWt6elZydWJW?=
 =?utf-8?B?RW5DWC9lU01lNjVZWldVQjN6Q3dtZjF1dkg5dXl6V3k2OWZVdFpRbDVUMlo0?=
 =?utf-8?B?a25lMkk4cW5YVEQvQUpZS1NKSzBzeFYycE9PL3ZVQmFlaXovZVNSRXFWem1Z?=
 =?utf-8?B?ZHRQTWFEbFVCNDVsSWRGVCtIVUJnTEMzTHlBdmVhVzBYOFVUOHd0VGZXQlhT?=
 =?utf-8?B?MmVSK1JDWmM3Tmp2b01HcVhrSWtoeFJQS1p1K2JGWHJSWTJzczQwSmVEY1lr?=
 =?utf-8?B?cTVxRlc2N3Jla0dMbkE5UTF6aXdzdW0wVndrUWllTjBDTVlSWitHQlhUc3Mv?=
 =?utf-8?B?V1ZBendYV3pOQkRhVmJLOU9kNmZkeTg4VzBlZ00rNmtGYWk5RzVKL2UxMXdF?=
 =?utf-8?B?bk1TcEpTNWlQNTA5a0ZETnd1dnE4dmU5YmFMUjY0WlBOSlgwTnA4bmV6S3dW?=
 =?utf-8?B?NTdUQVczdGpHNFc5a3VXMkpNM0E5RENrK3NFMzZqdkgwM043V08zNUFoT2RI?=
 =?utf-8?B?Q1hiWnFUaGovdlNrV3lQNmNuZ1hLSlNCWHUwT1NETGdIa0V0ODQ2bXROWFJj?=
 =?utf-8?B?azcwaHZUYTROUGhwczlVRzNuVjBFNVg1cUh3U2h4Snl2aEdvVDBzbEttc1Vz?=
 =?utf-8?B?Vk1BYWJ6Yk1MTFdtK1JycE5pSlpQOG1oUXR0V0pYQVhMRmRPYWwvNlJTeS9n?=
 =?utf-8?B?UXNXWXZsMmNrVGJmVnhyYnpGZ3dwSTdicUd3VDV2Smx6ZFc2Nzcva0RwNWxF?=
 =?utf-8?B?NVBDaUNqMGVxQ3AzbVdLYVNqOHQxNE8xMGkyVkxBakRtcm1ISXcrbE9yNTBq?=
 =?utf-8?B?M0IrWVdVSzdBNTNtK2tpUzljOUZmR2ljSEhSbU12TTFWZGVYa0oycFFTdi9r?=
 =?utf-8?Q?nl3JJ9i7ctXzeecCb2vSQJy8z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed87caee-3723-4b06-7f40-08db312d5d66
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 14:45:11.4594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O1yzrgQAGWnPRDmsIJk5/aJEGC547+C1uR22vMZKeW3Zk5O9yaTBwmLt6Aynnqg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263

On Thu, Mar 30, 2023 at 03:29:00PM +0100, Robin Murphy wrote:

> > > +    /* The domain must be attached before we can establish any
> > > mappings */
> > > +    for_each_group_device(group, gdev)
> > > +        iommu_create_device_direct_mappings(dom, gdev->dev);
> > 
> > It's better to move creating direct mappings before setting the domain
> > to the group devices.
> > 
> > The VT-d platforms allow the firmware to access the memory regions
> > defined in RMRR ACPI table. If we set an empty domain to the device
> > while the firmware DMA accesses the RMRR memory, it might result in
> > spurious DMA faults.
> 
> Yes, logically IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions
> *must* be mapped before their device is attached, in order to guarantee
> continuity. Yes, this means the RMR stuff for Arm SMMU still isn't truly
> working properly - it still needs domain_alloc fixing to get rid of the
> whole horrible "finalise on first attach" idiom, which sadly I haven't had
> time to get back to yet :(

Yes, this is the only reason I put it in this order is because otherwise it
doesn't work at all on ARM and just quiely NOPs itself without any
error reporting. That seemed bad..

IIRC the existing code had both orderings :( I'll add a note about
this justification

Thanks,
Jason
