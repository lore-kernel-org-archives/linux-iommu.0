Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDF2E417
	for <iommu@lists.linux.dev>; Thu, 26 Oct 2023 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P5JFE/oz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NA7sX5sU/Qebr76QBYToOc9rMbgCdVh7b0O8reIajwRt+R8rrHFEszlpRzinxlPIPqb4S0ybePp+DwjyL3Kn4/y8vBOvznymZwGd5AWvMq6J2ti/B+rUYJARi6fQlGtOg/46DZWxBhfb0eNj5AqtgqL7XMnyTjkM/wduPbmHUmKJU/kci/ACdcmUgvATiCWbhb8qRz6GkLdVkuEnV+DjUr4kHxieM0kKWHDLqwsvXTeSxNHo4GkyhW7yisJNlfX31x/eCBUjBHgctPvEF+MJjPh2L7pa1mFyrA+bx2j7SN6PtRzz/6DjRd1ePgyvqVS7lG1tu3lSisXwbSr8eULgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihWbLqG/tz8dOo8xB5kn0PVmFNtLG3vbNmHxB6OaZ4c=;
 b=TJTmRW70kLbDOvISOC8Q7pkkchISuAn01O1Nj8VmkWFbXoFIiJh/tOk9reaUIUcChQf+vVtBAqKNCYQCivn4o1pqV2oKFw0XlUjOr9ZymjWr+M2lh/MvHX4N6UMozUqDIDvwL5M2qCdAqugP0qtHH4EkTTPAGFFUG88EtijRzW/WRET5ORcDDwNwku0KnPAGClJdLgx5d6Rw/vzo4KKn0jZWmXQBRKkrFdsz5Eelv+258qJyswwFTX3alABVDWEzfjEM898clYAQZhG6MB7fzNqCG8P+O8nfQU7pFLAIPpLzyp9lWLbetUkZ37vIsc9Fnkj+vftUpC6fmue/oO5hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihWbLqG/tz8dOo8xB5kn0PVmFNtLG3vbNmHxB6OaZ4c=;
 b=P5JFE/ozIXvfy3HLOQk3iJ6fxDOm9LDC0euLu5bRgd40aM0Q5AYppt1XtVuB0WcOXZ/TC20q5s9CCgbH8Sy05mMxKhzjHCgVa+DF45RiJLAejz7JU/I7qpgLCFngqwpvxn6TXj43BAuFz0/JBSHqAAaQ31gjVlfGhnY/M91b5+GLy5tNUooy9tA9lc3QWFcZUsCaXJFc8vXYmhg2QVGKk1QiO/L/gSmvdDDYg0JHWEGQF/QvNofPp8KwQ/ed6rviDCJe9P/G8Uk5XNHh2kPKAdUgLne2XrQoOpzximd87ngnLSoWX966/ZmuKVowzRZOVr+AiWIy0rlzSAk+GxmbYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Thu, 26 Oct 2023 14:11:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480%4]) with mapi id 15.20.6933.022; Thu, 26 Oct 2023
 14:11:03 +0000
Date: Thu, 26 Oct 2023 11:11:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 11/27] iommu/arm-smmu-v3: Lift CD programming out of the
 SVA notifier code
Message-ID: <20231026141101.GO3952@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <11-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <CAKHBV24f3yh_6GsY5jLzUVOdJksRPuHx+w6ynhYrBAt1zyHO6A@mail.gmail.com>
 <20231024234608.GD911568@nvidia.com>
 <CAKHBV25oYCwRW_5J+PFNhJ3Qj_JKy54J+3Lc25Wyie40xaQ_Ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25oYCwRW_5J+PFNhJ3Qj_JKy54J+3Lc25Wyie40xaQ_Ag@mail.gmail.com>
X-ClientProxiedBy: SA9PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:806:23::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: a031b77a-73b8-457a-e55d-08dbd62d6342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IDpS4higXByi1FS0CU7+ouIyzvyKkV5eulaD6000DPChBleYd+qutV96eJg4WVcwb8JL36xWwNwfHxAGv6EhX5i5DWILppZjZT1v6/HR3BhzlkAWijkZIcBqBsnKU1jTiI3qHxLYhEOg1l5SuCYDb9Sz8rQJp+7nYOWVOh60IDTED2t72u4bc+hHqBD/hWFSBclniS1gbtCWruzjuu6sJL23PveQ/Ti2LnQ85h8tc+w6zIyPsOhpRCOWj1+UdO/XRZRQ9JJERCBjxWfR9HLp1qk54e7wJYJ3zRRE5baErGHwJk7TCngckXEha4ABD1I19s8MQwLYNiyBn6MFQziVqdLUHcDN2vj6NUmWpJhvvKhA57SHu5PiQot6y9YNLtm6r5BhWkGLccJmM14mSr/T2krp/VmKPUOqG2SY5Z+DvliP07OGPlkFQF9vNtD62YVMAGtkEi1jHrLHPGId80jO5KjSK5VRCswmSNdH4IggLnSQ3dvMegbF1qaxQRIVKVzA7rrIlZYOpVjJH0IQlazqPj3OpRUj7fMee1x0yKdB5HssUeRpBXy+oSsA8rFRPYtW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66946007)(5660300002)(2906002)(41300700001)(316002)(6916009)(4326008)(54906003)(66476007)(66556008)(53546011)(478600001)(6486002)(8936002)(8676002)(6506007)(107886003)(66899024)(2616005)(1076003)(26005)(6512007)(83380400001)(86362001)(38100700002)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2VuSmg1ejFaVm5aMmRlSVFIRVpxcUpFLzdKUTU2UnhtditCVmk4eHdWWkNt?=
 =?utf-8?B?L0p6WXEvUy9yek5NZzlJSlk0bHA2VmRrRDNGRkV6cDcrNHRKejFDcURCTWJx?=
 =?utf-8?B?NU1zaEJ1ZnpyNldadmQ0RjNlcEtBUWhwY2w4TC9zQWZ4czYzdWhVUWRRTUdj?=
 =?utf-8?B?d0NZbFFmN2pmYVhKSyswdFgyVVd1SldaQ01va3B5cnA2Mko3WEIxRldPa0JD?=
 =?utf-8?B?VlByUHFvY1hxM1I5c0dHbjRQTnk4NkgxOFNCN1JRcEJ6cStuUEZOZkxYNTJR?=
 =?utf-8?B?emx3MTVYeFEwTkRGYnRKd0xEZTBERDAwUlhiMGJzUXpmdlBEZE5VNXJSM0Zp?=
 =?utf-8?B?NndvdmtZWEZaSEFLQ0wvQkd1N2Q4cG9FTzZmTFk1blFqK3c1NU5oRmZ0Q1li?=
 =?utf-8?B?WC9EcG5HR3NWS1NQNlhubm9GNmxaU3lIK2NLVWhxTmQ5QVNvTWlqU0FXTWlV?=
 =?utf-8?B?eVd1Z3p4WkhicUtxeVNLNHZlQUNOdUpUTU94Y05rYzQvbDlMZkhFWWd5bkZL?=
 =?utf-8?B?c29rblc2a29DcEVaQTF6YXluT2tBQ3IzU0Qya0VldndpbXlxL1Y3b09CSktL?=
 =?utf-8?B?U0FSK2YrdU9ZM3dra1hBRmVkaVBvL2NJMTNBWmh1cDF0Z09UbHpHemZidzQy?=
 =?utf-8?B?dGlYbzhDeEZBbWcyT2pISlM3bmUrTC9MNkNKaXU0NmlGaURXTytJU2piaXpY?=
 =?utf-8?B?YzhvOFNxdVB3UlNyMVpPQjVLZVNEUVJWWkFEOXFxVnpZcEtyL3pEaGlwZjVz?=
 =?utf-8?B?ZjBVNWh1RlNhMmFYQWl5TmtnTkRlNFRCNnpMQzJvYWt1OElrZzh1S0xPQW5k?=
 =?utf-8?B?ODhPUlNtWEVuU1VCMUxqTEM5S0kwTkFPV0M4RjlZOUFxVWdSZzdocmZMVUdL?=
 =?utf-8?B?bjl3UXVxL2UxWDFoU2NtTUwrWEFjMFZpWkJNaGcxVmE5UHBFQVQ1d3pkdzFX?=
 =?utf-8?B?RWNjejMxUDFRN21SUmI1bHoxcjFKUUNPM3llQzU3aTc0eFYrNk9wTEFuMFlY?=
 =?utf-8?B?UnhmYVdqVUxyWUtCc3NBMVlsU0lTZlZQVXpXZFVQMCtZRnZOblNFcWk3RmZM?=
 =?utf-8?B?RnhjUEdOOFZ5ZU92T3dFOXdlQUk3VFV3UnJKWXg0cGdTTlNzSWNLbTJxV3d1?=
 =?utf-8?B?YWtpdHdiVE1xbUIxZUhvQjNqSE14NWkweGhKZDhnZmR0bUtXakhka3Y2aVRh?=
 =?utf-8?B?YVZqL1o1N2xFZmFBUEdtNUdPamd2c09OOUlQUmZxQm9VWENMaUQva0VHeGZE?=
 =?utf-8?B?Z3l3YTZBY1FwUU54cmY3LzNWOHZMZDBxY0RDRmF4THNQWlVXK05kNDNBNk5h?=
 =?utf-8?B?QmNhU0JsS1U4dHhuZGlxU0IvZ2s5Rm5xcC9PMkZaK2VuMGxLcWkvZHZXTm5H?=
 =?utf-8?B?bUtSUHl3NEZwSnp0RWN1UjduckYrWVo2cGhLYWJaQ2R3RVcxRXNNRVpnQlQr?=
 =?utf-8?B?YWdTSjdiaVllMzlJWG1LcVVMSkRrS1BZRGNLOGdTUDFVYSs3Wks1STBTb1RP?=
 =?utf-8?B?dU8vekVKNFk0MkREK1BCalVCdVN2VTRJak0yQU9nb1lXQXlWOEhmVnJvYTJn?=
 =?utf-8?B?K1NJRGEvUTBHRWpnZjhYNVVBTGV1Nm5PcDkxWVJTTEFrVEZBbkMxMzAwdy9N?=
 =?utf-8?B?dEk5eER3OGtSN29wTERoYUZzaW5KNEZIYkFzNHB3dVRNSis2ZnMvWEI2RXI2?=
 =?utf-8?B?SlBHQlB2MmxkVjZOQmJJRXY0NHpMZUJkbVdiNlkvQ3M3cTRmL3F6b3NmVlI1?=
 =?utf-8?B?Yy85b21LNjJyNmc4OHUvUmxBMkRKMDAwREtSWU9uQkZRSXhac0VuK2lZTXlR?=
 =?utf-8?B?b1FOMlBlakRYa1RGaVV2VTNxcUR3N0NpWWltWE1nT0UyRkpzYjFOMHFDUWxx?=
 =?utf-8?B?YlRFUXBVTmJCQ2pZazIwbVNjL0tZVUVUQ2RlUXRlWFRJMmN1L3BnQnhkc2Ry?=
 =?utf-8?B?YWt5M0J5NWpIcEYrNnJ5YU10VlM1K1o5bjVFS2xJTnR0WDhHZHRubVlwWWtw?=
 =?utf-8?B?K0Nmd2V5OHlMSUNNZjZuOFdneGNhQXZXejNPOVVaVGZ5TUlSYUxxOEcrWm5K?=
 =?utf-8?B?TjY1TFhOZmlxS0Y0VnhrN2R1emIwSjJlSVVjNGxubXZKQ1dNREdPMXdrM2ZN?=
 =?utf-8?Q?SLhE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a031b77a-73b8-457a-e55d-08dbd62d6342
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:11:03.1625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydF8ehT3eC6RBbCwIso60wwcJFxkq22jDziCYwvSYybSFUSBSwxZHIYUUxTQTy9g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638

On Thu, Oct 26, 2023 at 03:31:41PM +0800, Michael Shavit wrote:
> On Wed, Oct 25, 2023 at 7:46 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Oct 24, 2023 at 02:34:28PM +0800, Michael Shavit wrote:
> > > On Thu, Oct 12, 2023 at 7:26 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > > [...]
> > > > -static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
> > > > +static struct arm_smmu_ctx_desc *
> > > > +arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
> > > >  {
> > > >         struct mm_struct *mm = smmu_mn->mn.mm;
> > > >         struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
> > > >         struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> > > > -       struct arm_smmu_master *master;
> > > > -       unsigned long flags;
> > > >
> > > >         if (!refcount_dec_and_test(&smmu_mn->refs))
> > > > -               return;
> > > > +               return cd;
> > > >
> > > >         list_del(&smmu_mn->list);
> > > >
> > > > -       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > > > -       list_for_each_entry(master, &smmu_domain->devices, domain_head)
> > > > -               arm_smmu_clear_cd(master, mm->pasid);
> > > > -       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > > > -
> > > >         /*
> > > >          * If we went through clear(), we've already invalidated, and no
> > > >          * new TLB entry can have been formed.
> > >
> > > This re-orders the TLB invalidation before the CD entry is cleared.
> > > Couldn't a misbehaving device form TLB entries in this time interval
> > > that we'd want to avoid?
> >
> > Hum.. No for the 'inv_asid', but yes for the 'atc_inv_domain'
> 
> Just to confirm, why "No for the 'inv_asid'"? My best guess:
> 1. Transactions don't hit the TLB entries unless there's a valid CD
> configured with that ASID
> 2. You're relying on those TLB entries being cleared elsewhere in the
> code, when freeing/reclaiming the ASID from the domain.

Ahhh I was too thoughtless to say that!

Yes, we need to have the CD removed before doing the IOTLB
invalidation too because we are trying to clear the IOTLB of that ASID
so the ASID is clean before going back to the allocator.

I got a bit confused because later on in the series that specific
invalidation is moved into arm_smmu_domain_free_id() and moved over to
domain deallocation, but at this point we don't have that yet so it is
still doing something important. Regardless it is fixed!

> But this also makes me curious why we bother with an ASID invalidation
> in the first place if it's not required for correctness.

ASIDs put back into the xarray for allocation must be clean in the
IOTLB as we don't do an invalidation when we allocate an unused ASID
from the xarray. An ASID that is not clean could have stale
translations that are not valid. See patch 22

Jason
