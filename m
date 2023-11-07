Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDF93212
	for <iommu@lists.linux.dev>; Tue,  7 Nov 2023 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GPDnW4Qv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZ4fxp6I06kZH4p9FjJ7OM+d2Md0zUG3DIqrOZcRmP947hXWUBxw1IP+U4n9pktRFo5enjpB8cJlhQkWgD5LqPp9TxsdQmZFBuXzai8M2Y3cMpmSRqSBZRRq5q8WA4amWV3hoaN8wYl0J+24hLnEpL3IYV60GOsx+R5GQoC3izZPZsZ77d90OibTRmrxT2RyleBXJQSu60Wwc5hCXvJWfyJ98DqgGgZ7Hp/2ETmJibfMfht+G9gF/sxAhE9cY9a0ByJ/dSFDAxniFDNlSwlYZYjKgGJjg6N4T2Rb909+AclF19cZLnWhZbNeGIt4fUh0l9h8ptNvGaVtBkyxl4slIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WPaVyTBY+XVTy+mS9z1DTHPPesrFag92G2WKOnml5k=;
 b=VWR6LqReDjrUaSn2+xUaQ/lejDCLTA0oih6heoi+m4MpL6lgV4ywQht4kYVPyCOEgn9iq+KLa3cRB2FtOBpZXtz6ilKeZ0kkQU34ibKEGe8qZP4pLryvHJk3zJEHEtbOeXmnJVUpGWG42WpMd6D91C7uhZJR+1lSGwTSX/6fJRiS/aCq7X4FrI1xLfJ6e7afud7e6HMnHEXaQ2lf/c98b1F1xgh8AnfXf2j7KO609AEMFMhIKNJgwUFcYSLImkec0cXwrQGI4/PQzaS7HiIEvd2PLTMOqrljZPBXT7S/c0T9lQ4Zu7bUOKK2y7Em/IKQJTwyicni59EnxIj952u5oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WPaVyTBY+XVTy+mS9z1DTHPPesrFag92G2WKOnml5k=;
 b=GPDnW4QvMrGAjiXonMYVrr76Rrr2tY1lbI9wr9Kky0Hm+0JzTawhHOqLkxBaXBMcz0eZN/IbHWjtQIjZfr5n03J1hncy5Skgpe7CgCJoCN7y+CXpbD+7af/23sI2ldSM/Mr6J666WJqsDgzhtAVpfSmZlZHw6M6DpDmBBwnU208z9/fphjuve8IXoT70qEBOlslH8NkV8yXU/SB2qGb3UPi1ZAqKaOiKccW5ZapNAW14LyvuIeMfjdoU+BfKCKsUNtb0GTILdJAVFcpiz4/0diPQq/7u69fC66i/xHo/HTQgF32QWDq/BzOSA/6ubZUBDtgAVf1Tb8R9iRPjPaHozg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Tue, 7 Nov
 2023 14:00:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 14:00:31 +0000
Date: Tue, 7 Nov 2023 10:00:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v2 21/27] iommu/arm-smmu-v3: Put the SVA mmu notifier in
 the smmu_domain
Message-ID: <20231107140030.GN4488@nvidia.com>
References: <0-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <21-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com>
 <CAKHBV24XKTgea2g6Q+k-K9Yv-Tca4uff2gRLszvQouSS58FwsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV24XKTgea2g6Q+k-K9Yv-Tca4uff2gRLszvQouSS58FwsQ@mail.gmail.com>
X-ClientProxiedBy: BLAPR03CA0058.namprd03.prod.outlook.com
 (2603:10b6:208:32d::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d32a2d8-3e12-4f5d-2071-08dbdf99e768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	clZxHBz5XkxLTQJCHpTHuQ4uliA58fZ+UBmel9FWsjJL6asyR0M0wyleOYkzFqx+ZPq/INimVhfLtuZDZjoRPN0AH26G2yxnHltLhhiz3dg0znAOzOhIoRByeluPKb5ljQ3AI0vlBGMJ01yKuqX8+MPCdZ/qHyzVQN2P7lq/gjkDKf0AFMoOr/QwfzHR7RDHh4Fo7ZNeKpzJvrp3viy0nJUwqpRsrODiGcRVPn3VoDH1FWq837a9+wF/Fbaj8NPIh/Smph8TSe6U2somFzpFCVZTa7Ucso4hQ/OBHBjoHKUpZwrDXvMXN+tFsBACeXfG6dTcAsMaGqONRGRw9Asmuygo6RthYU9peHuAgBRDWEDUqi/QXPgGzi52hcmfoazBPDycj0QE5z8ZLBmrdggp+lIPXVfB6gklNU0XwpppqxJ82a8SZeBoFrZkJYLMNgQMi1HJcJ3PGJRM5vPEFq1x99ucRwp53tZyZnl4BvH73i1x+MNCTZm4ACRvXGT9oy/FRVcc8upQKvOkh00G0Qpp601vN40ghs+7855GWykPoqkKbPG3PXzzrZuOPxq6Kemv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(107886003)(1076003)(2616005)(66946007)(83380400001)(26005)(6506007)(478600001)(66556008)(6486002)(53546011)(6512007)(2906002)(4326008)(8676002)(6916009)(8936002)(316002)(41300700001)(36756003)(5660300002)(38100700002)(86362001)(54906003)(66476007)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW43clRSOW5RMUN1aEw5SFFsajhhMGpqaFZEM05wNytZNmIzZFgxWUt4T1Zh?=
 =?utf-8?B?QTBHQVJIVjhka3NzR0tIbXFsLzhXT1I5N1QvRlJvMklqRzdMQUU1dGc3WlVm?=
 =?utf-8?B?c1pkL21mWDJnVEhwWUQzY3B3TFRlblFxeTZ2MlBkZzFjcm9VaS81ZnE5LzJ0?=
 =?utf-8?B?STdVMDFTa1QyaDhGVnhjdVpXUGNONkljaEtoUnFtdEpVYmU3RmpZS1pBbnpl?=
 =?utf-8?B?WXcwY0Rnc2h0aG5relZLYVVhdzcvWEpyS09XRWFCU1VVY2dHZEtVUEdMdjhu?=
 =?utf-8?B?UEtQNVNWZE55SktvTjRDdEdydnJhNVRJWlVCOHRXUmxOUTRrVXJyZjJONits?=
 =?utf-8?B?czBES0dVQUlUdy9sOTNCc25QTys0UnBwUjRkZURxbnRaQjAvTWxmL3BaM2Np?=
 =?utf-8?B?NmwwWmxOWWIvaTVpSnBXdEh4SzBHeEpoV1piY25MZlJ5WDBxVjc0YmlSZXJO?=
 =?utf-8?B?VXB3QkIvZ0QydGt1MmhTbW5DNkxzU3FRNHZVRFpBci9XdlNzNTkrWEkxRUor?=
 =?utf-8?B?Tm1zcm5jY3lSNFZ1VTl2Wm5TN09sVktHWFd0YlNoS2h6SVVCWmw5VXpVQkU4?=
 =?utf-8?B?WUhMNlV4ejMzajE4Q243SFplbjhidGhuY3lvSFZ2cWhmVHhBb1FrVlZUdkhV?=
 =?utf-8?B?SG9ybEE1QjZMYUpYWGtiRVFKVDhMRk40L25ZRndZdlZPM3B3SGFic3hvUkJX?=
 =?utf-8?B?WnZtUnZSQzdGd0ZPSHdXZWNxN243T0czcTVBWVRUdTk5YnlVc0wvVVJHeStj?=
 =?utf-8?B?dTdLZm5qakZ5MnlWRlFTVVN0RFp2dWM1cDR3b1A4NjVUcG1BQXRNVUJDMmt6?=
 =?utf-8?B?bHNQaUw4akIreDc0cmdCTUxYSDcwLzB1cVdkTFlXMzZMMkJRL0tSSlAyODNz?=
 =?utf-8?B?TlFrYTRIMXpzM2NvZ1d4OVBCRjdFc2hWbktMZnB5bVVteEwrMkYwYVExMmZu?=
 =?utf-8?B?RGFtSzNHNDQzdnprU3U0UFd5TFpyOEU4V2xLQzlwWWY4L3duUE9nc0dRS0Z5?=
 =?utf-8?B?a2txbmFLYnlZV3BobDIvellER1FGbnNmY1QyQk5vdC9yczErQXdMOGptdmk2?=
 =?utf-8?B?RGVFZGtPOWo4VDdlSGQxOTFWN2FkZWRZeDdOZldzb1VUKzBXT3FkOGhCS2pC?=
 =?utf-8?B?NkZMdWVETEhwSzJ5ejdXWTJ0cVI1K251M2lmbHdoUEdhMkNuMUxDblFyT0tJ?=
 =?utf-8?B?aHUxMVYyM1ZremlPaElSZmFyOWxOelJjQlY3c0ljNk0vK2FFZ1BOQ3VtczZS?=
 =?utf-8?B?MnBpOFcwUHVlaExDd0g4WGt4Q2M1WTNZR1VvV3YyY3ExTnhKRmJhNm9LblBY?=
 =?utf-8?B?TlVYWmZwRjdtZ2JtT3JXdTZHbnJzLzJERS9hNWZEaGtHUlVJdEdVcjBOUnlB?=
 =?utf-8?B?TUxzTVJlK0xPTHIrT2N2UmVVVjRQdGpoNmsrMXZZVmdHVEp0K05mS2lYZjIr?=
 =?utf-8?B?WUhyQXlnZlNlVEhDL2JDcThaY1FvV1BtcVZTOG9qWXUvUzM0Mjl1TC9xQjVi?=
 =?utf-8?B?WWdGdm1YR2g0MXRDdVlNNkh5V2laYmRaYU8reVBvUzdYaC9xMVJPMU5vbk4z?=
 =?utf-8?B?cWtDdFJKOTFJeUtCWGJRSWRoS1NWS3NwVjNrcFRicHppejBUbUF3bTh6ZWli?=
 =?utf-8?B?b1JoY2dTY1NEN0FUU1h1SUQrMW42M21yWDBWdkZ3dDFXN3RSK3huTnhuQWc4?=
 =?utf-8?B?NmpGYTgyVWRRNnVqRndtTnBIaXE4bFJoSmxoR0dlT1FjbHFMNFdkZTRnZEYx?=
 =?utf-8?B?b3M4dERWZXNLNUNmVTNBdUt0NFB1N0RTUHJoSmY4VGZEdVFDM284VndJUmx3?=
 =?utf-8?B?eXVJQVpLOHE2WUlZUHNYSVdlM09Kd2FTcTFINFBOYTlnaWYyQ2p2bWJONCtL?=
 =?utf-8?B?YVRnTVl5TFJaMHgyVThPejlYUmJCb0FtNXU4VnJPSXFLNkt0U2xlcnFpRGFR?=
 =?utf-8?B?MVoyWDZtNUIyUDdGcmVqVHdqN05WcjdVRXhZYVVUZTVKSVlBM0gvZlJLeDZ2?=
 =?utf-8?B?UThtamsyWEwreU16MTJHNnI0cjV2VEtPeHRlNFk4YmdYWDhZRmkyVTc0OGpo?=
 =?utf-8?B?MGZlN2hnUWZPc0V5aGNRVFR0R0JHOUtxdy82bS9zTHJpbUF2Mnc5YWxLT1JO?=
 =?utf-8?Q?MB4UnJ+uNBJ3aQpqriOn9BIOJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d32a2d8-3e12-4f5d-2071-08dbdf99e768
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 14:00:30.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ISCKcCzFTaUJYj7LFrkeMHUYvaaHaHJ35MvVCdFE9pL3OycL8Tkh1AU+zngJ03se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

On Tue, Nov 07, 2023 at 09:28:08PM +0800, Michael Shavit wrote:
> On Thu, Nov 2, 2023 at 7:37 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > [...]
> > @@ -309,24 +169,26 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> >                 struct arm_smmu_cd target;
> >                 struct arm_smmu_cd *cdptr;
> >
> > -               cdptr = arm_smmu_get_cd_ptr(master, mm->pasid);
> > +               cdptr = arm_smmu_get_cd_ptr(master, master_domain->ssid);
> >                 if (WARN_ON(!cdptr))
> >                         continue;
> > -               arm_smmu_make_sva_cd(&target, master, NULL, smmu_mn->cd->asid);
> > -               arm_smmu_write_cd_entry(master, mm->pasid, cdptr, &target);
> > +               arm_smmu_make_sva_cd(&target, master, NULL,
> > +                                    smmu_domain->cd.asid,
> > +                                    smmu_domain->btm_invalidation);
> > +               arm_smmu_write_cd_entry(master, master_domain->ssid, cdptr,
> > +                                       &target);
> >         }
> >         spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> >
> > -       arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
> > -       arm_smmu_atc_inv_domain_sva(smmu_domain, mm->pasid, 0, 0);
> > -
> > -       smmu_mn->cleared = true;
> > -       mutex_unlock(&sva_lock);
> > +       arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
> 
> Similar questions to patch 11 from the v1, but why is it ok to remove
> the ATC invalidation here? 

It isn't, it is a mistake as well!

> Did you perhaps mean to remove the TLB invalidation instead (for which
> it's IIUC ok to delay the invalidation to when the domain/asid is
> freed, since those cache entries won't give a hit while the CD is
> cleared)?

Hmm. I found this:

* When EPDx == 1, a translation table walk through TTBx causes F_TRANSLATION.

- Note: The Armv8-A VMSA allows a TLB hit to occur for an input
  address associated with an EPD bit set to 1, but the translation
  table walk is disabled upon miss.

So we need to flush the ASID too when using EPD to disable it.

Like this:

        arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->asid);
+       arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }

Jason
