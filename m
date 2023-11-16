Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F443C46E
	for <iommu@lists.linux.dev>; Thu, 16 Nov 2023 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V/FP7jLB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+S3yP/JQx4ytCYBgtYDHJNSJEB3GhSH9I3TjBXsF3pMB2bBkVG/MD9nqhaqaV9l2qNXdfmHRm9IJd+x+n/KXN4754hgsLlU11OFY+vYNOJCn0bkOR6XSWoHbXHRqilW6E7VvZaVKIMgAr6Q/8O0P38YpdtjY+exVg/woRW/gKgmt73/qn33uiuJJNzg9goDLopdENr/tBOpdSLPVxufMt4TaHfkA2h0nvMWvhLg+tjjp0LtNPfuFJrG/qN74KKU23KFhLnrIcWHEpPiz7Scp09+l0XYUUn5yRTrobBDiJVE7syUGVyYMw9ivpbZycthDGpiDL0dN4JaBAfeBv4oRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f6fE7yjN4xO+VRX6JvQlb6tNVXWfos1ddwKZyf6BEM=;
 b=grHwFkHqc44JTK3BLHbV/msQTp7QUOue6vTUGDphQo/vcHJtiBx4iEVqePnxzclDPsKRnKoKaTq2L1dIZjd2kR1yQX8Otqc3NKXyPXxBUvMM1BoR9M29Ip4Z78rQXJtsUDcw8ahlu2P14ivPt5le/VbyQfhy5S/WmfF0M1eObljtyfz7m9LDibswHZIZ62zDwr2JKWoVoa+Z5cCU4zLZtWssdfGxdPLS84cHIx9D6hIGT/I+out5ZmlJtfInpj/WaYIHiCAm9r7xSQReqFLS1oR1AM96TJbWtud04YHfGXOwRU2zfxgi1v2GAf0Qqie8Smrs0bcLtL569BAOgHoJwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f6fE7yjN4xO+VRX6JvQlb6tNVXWfos1ddwKZyf6BEM=;
 b=V/FP7jLBYVdhmNZzD6VW4orsckjmu5RdFrR8fwujiZ1Nz6qr/irDBDDwi9qZpvIedWtxAORt/5dsIvbmP17V7zOk/EBkefLu+t/z6LxIQ0n09xP8Jsqr4s59eKe4Ol/HCUxOO5zLAfDXkU7u3HDzc9x2SfIDWb+W5pXyLFJbRNQ24V9CBE8mA2OqaO8JKsHFBALvPiLySYBdDAkUU+hLlS0VOk7hxsEiQ/seHal1k1t63UlQIDCleRryXa6q/RZhEYGmc0L/K7teXKqoU7QkV6m/pziWV2dzobkBo5DfFFewIgaOtrEH8qZWhPd6BpaJbcpb+FNdxCjDYlhmzNmIlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 16:28:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 16:28:10 +0000
Date: Thu, 16 Nov 2023 12:28:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 11/19] iommu/arm-smmu-v3: Do not change the STE twice
 during arm_smmu_attach_dev()
Message-ID: <ZVZDGRd6m/FoLmNi@nvidia.com>
References: <0-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <11-v2-de8b10590bf5+400-smmuv3_newapi_p1_jgg@nvidia.com>
 <CAKHBV24X4-Mf3R8OqwBdAJf9P7UD9fep2fOmJVrcx_rkfABxBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV24X4-Mf3R8OqwBdAJf9P7UD9fep2fOmJVrcx_rkfABxBA@mail.gmail.com>
X-ClientProxiedBy: MN2PR01CA0005.prod.exchangelabs.com (2603:10b6:208:10c::18)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b6776a-3bae-41d5-129d-08dbe6c10585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xSG1fw+X+zBMH8rFHpoYGzF256kmNzn36YU9Y8yzw03vj0xWG4L9S4IrIeAlRi0n3bIiOade8h41lWtCBJMP67r3L+6efj0fFudviFeOJpmalDS5nqQRD6kEyf1J17TuFuBEKu+E0ISFqRlWeDg0h6K1eoADZZnJulZGNr+rMEpV1VaqagVE29znF/bRUrsde1S2HKkI2KWb6/qpk1j0WAdwFa4mAKHfWPiI+LMOCAMdEbgXATOYZVUTKp868AU0fA7rq6nhwr7RC8sMELp0tr8mNwtE0QAWF4PA/wzm4ahpvcxacW7PDNdcnd/WpuGy4YYd12IQU2pIB3Sht8RXiFv9Ygbss49dbnfNpk9tpCeo2KuYJA7lHGuKcsW7ozCSUMMayQlMpiqv3umrrVXN/zKsj+j5K47SWWGgjF0RJIut1BA64l346NWfyPWJ0PTfrsLx4BTpCG4A5ZIqtDBqXHyZhxER/v+yG5jER7k9BvSiHeGWmVzzU1iJlZONg/sD063/UP35eaLf4DbGcrEwuzSJl0Nu91QRt/CwCicyh15pLe62/O6eNDn2KY1TjEdv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(366004)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(2906002)(36756003)(86362001)(83380400001)(2616005)(5660300002)(26005)(53546011)(55236004)(6512007)(6506007)(41300700001)(8936002)(478600001)(4326008)(8676002)(6486002)(6916009)(54906003)(66556008)(66476007)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dS9XRGxRSW5xSjZxVUYveUgxaEorWVlXa1EzY1VlSVNISEtnUDYxMDZ3dmJv?=
 =?utf-8?B?NmhaRURibTc0V1hMYWVzTGh1YjVIWkJUZFZqUzZicjJLR3Z6L2R5NUd1Nmxr?=
 =?utf-8?B?YUYvME5UZUNOb3psK2Zra083YUpWb3JVZTFPVTh5dFhkVTJ2M3VhOXJidzQr?=
 =?utf-8?B?Zll1OU0zOWNTSUZ2MklsRXU2WW90YlVqUUNDSHNDT3pOMTA4L050VDlieFNv?=
 =?utf-8?B?Wis0L2Y2bG5sUE9UUG9KQ2NTN0V3ZU9zLzNkZFovM204QXhCTmhPYm1wQ09w?=
 =?utf-8?B?RDZIRGg2T2FjRGNxL0xaTVRMNzdLUWRBWVFjUU0wRWpUWThBK0pXdVBkUEdX?=
 =?utf-8?B?clpIeGlZV0l6NXhpU1lKdEo1TlB4MUNGa3dzL08xaVcxUWMrRDZQMER4MURC?=
 =?utf-8?B?UStJT3V1OEYrcUovem83WW41TnhwOGtsT0ExZ1QyUEcvb0dEMWJrQThkWHBE?=
 =?utf-8?B?K3BhMlJpL0VUSTZ4WDk5a001emtuQjlnU0hLK0o4alg3SjZtUHJYTVVOYWxJ?=
 =?utf-8?B?b3pvRTJrMVg5V2xXdlRwSWtJYlRPaWpUOEMxWitRSTR1RmVCRmJ1ZUJuSzBM?=
 =?utf-8?B?Nkl5eE5NT2J1MjQzbHFBNitGOHlCNjdRN3BsZGEydTJ0eGJ3WUZBaStoWnJO?=
 =?utf-8?B?MEVYcS8yUFM2TDZoYWdGZjB3OXFscFZoUHYrNXV0K2FuTURNTTEvM2M0MFJV?=
 =?utf-8?B?RmVtVk13NXdIdTRSNnRjTk1XNU4ySm9tTVpOR3NLaER1Qjd2cVUvOXJWRWUy?=
 =?utf-8?B?N1RHTVVKTjZTbHhlc2pvTnQrTXl1ZTdOZnYvZDlyaFJCUDh6Z0Q1S0lTS2NO?=
 =?utf-8?B?T3ZSSjBOQmpJdmF2Ry9SR1RGSitjYWtYMWZCdHdKSFBTZnptdHZwSGUzUU5S?=
 =?utf-8?B?QzAxdlJqR0NGRVJoVzFsQ2FoTDdCU3RuZE1yc2lIZVFSVFBvRXhhUUtuU3Ix?=
 =?utf-8?B?QXFYVmdCV29NSnhNVDEvS1AxQ2VrdG1NNEM3aGRFV2dyWHhEV0xmSmdRcFpN?=
 =?utf-8?B?MEE0bzVMZUkwMytWNjQrbkNscVdWZVdReE9xell0NFpXSkJPZm4rMHVzMldr?=
 =?utf-8?B?N2paVmxpUlRXR2JuK3J5YkplU2lZbHdYVjNCOFU0eDJqOWdVVlpDSXo3SE1D?=
 =?utf-8?B?TTUzU2xKdkZjb2pLdk4yWC9zQTVHeXhnOGMwbXhydjI3a2dkbEdIT0pEK0Rk?=
 =?utf-8?B?UDh1THFyVng2STVqcndSYjNHTklaWFlMTWg3QmU0ZU9PemZ4bXFyQUVvQ3hh?=
 =?utf-8?B?R1loS2VUd0R3Y0dWY0JCa0ZsRlhvQUtOVkdQSWRPQURUTk5OOFl6a0NobXRx?=
 =?utf-8?B?OFNtRm9oZThCV3hucGdLMytPVVpkUzZ1aGt2akVrbWFKYkxib3FIU28xWGFL?=
 =?utf-8?B?dDBTQWlBbHFLMXpXNTVneWJHcG1uTDhNV2VNRU93TTcycytqRVN2L3NTQVZQ?=
 =?utf-8?B?REZ6NFV6OW9xODkzdllhV2YzWm8zQ2pmN0xHQmI3WGZLR0VoNHoxMGY1cFpF?=
 =?utf-8?B?WHArWDE5Mks1cmNYMjYwbGxpSi8xWWFDcysyQmdjN090K2wzV2VVTzIva0Ix?=
 =?utf-8?B?NWtwTTJJejRkVW9QSVJOSmlHbURwZ0RuRHNkVCtmYStVZlNMcUFIcUd6a25L?=
 =?utf-8?B?MTJLbnNVN01PNTMrUG1ZckJrdTFab3FXdVNJZWRvK2dOUDY3SFdyQ0h4ZnJk?=
 =?utf-8?B?eFlRVzdnS25kN2NCMnZHeEFMMVVOVkNpaGNBRzlOeE1aNEh5VXY1Z0NWVS9P?=
 =?utf-8?B?VzNyeHo2Z3lGTWlyc25ra3hvQW51enBrRTlVOXFjd3REaVoxRWRmcmxtd2cw?=
 =?utf-8?B?Zk44VFpRaktvVlZrajhFeXFzaDV0ZmNYSHZYZlZXcFlVemNmNk5yeUhZcElB?=
 =?utf-8?B?dkRJZ3JndUVDamJNYkN1TDBSMitlL1B3eUU4T3JQTHdoUkNjaGpUaFgva3Rp?=
 =?utf-8?B?ZTV5WDZ5SnZPUytSQjhRRE9pbzlRT00zQndaVUIxWnlWVjdkRVZBc3BGbkxy?=
 =?utf-8?B?aEgvYndMaGRvZXFnTC90cndBQ2RmK3FHTFU2ditVbHNwSGQ5V0xwd2FYUkxC?=
 =?utf-8?B?SVhSNTFoLzFEaXBuQkM0c2U5Z1lXSXRZbEZCd21vVWxIVEdYb2cwU0FSOUVK?=
 =?utf-8?Q?8YS96pfYJ278yeI2WyJ/LmPf2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b6776a-3bae-41d5-129d-08dbe6c10585
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 16:28:09.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDIf2AekaoQQYqC4mXhVWX9ikSfZrSgt7sZF1m8mNbQaLU//h6p2zoIgcSAAic1R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

On Wed, Nov 15, 2023 at 11:15:23PM +0800, Michael Shavit wrote:
> On Tue, Nov 14, 2023 at 1:53 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > This was needed because the STE code required the STE to be in
> > ABORT/BYPASS inorder to program a cdtable or S2 STE. Now that the STE code
> > can automatically handle all transitions we can remove this step
> > from the attach_dev flow.
> >
> > A few small bugs exist because of this:
> >
> > 1) If the core code does BLOCKED -> UNMANAGED with disable_bypass=false
> >    then there will be a moment where the STE points at BYPASS. Since
> >    this can be done by VFIO/IOMMUFD it is a small security race.
> >
> > 2) If the core code does IDENTITY -> DMA then any IOMMU_RESV_DIRECT
> >    regions will temporarily become BLOCKED. We'd like drivers to
> >    work in a way that allows IOMMU_RESV_DIRECT to be continuously
> >    functional during these transitions.
> >
> > Make arm_smmu_release_device() put the STE back to the correct
> > ABORT/BYPASS setting. Fix a bug where a IOMMU_RESV_DIRECT was ignored on
> > this path.
> >
> > Notice this subtly depends on the prior arm_smmu_asid_lock change as the
> > STE must be put to non-paging before removing the device for the linked
> > list to avoid races with arm_smmu_share_asid().
> 
> I'm a little confused by this comment. Is this suggesting that
> arm_smmu_detach_dev had a race condition before the arm_smmu_asid_lock
> changes, since it deletes the list entry before deactivating the STE
> that uses the domain and without grabbing the asid_lock, thus allowing
> a gap where the ASID might be re-acquired by an SVA domain while an
> STE with that ASID is still live on this device? Wouldn't that belong
> on the asid_lock patch instead if so?

I wasn't intending to say there is an existing bug, this was more to
point out why it was organized like this, and why it is OK to remove
the detach manipulation of the STE considering races with share_asid.

However, I agree that the code in rc1 is troubled and fixed in the
prior patch:

	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
	list_del(&master->domain_head);
	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

^^^^ Prevents arm_smmu_update_ctx_desc_devices() from storing to the STE
     However the STE is still pointing at the ASID

	master->domain = NULL;
	master->ats_enabled = false;
	arm_smmu_install_ste_for_dev(master);

^^^^ Now the STE is gone, so the CD becomes unreferenced

	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 && master->cd_table.cdtab)
		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);

^^^^ Now the CD is non-valid

I was primarily concerned with corrupting the CD, ie that share_asid
would race and un-clear the write_ctx_desc(). That is prevented by the
ordering above.

However, I agree the above is still problematic because there is a
short time window where the ASID can be installed in two CDs with two
different translations. I suppose there is a security issue where this
could corrupt the IOTLB.

This is all fixed in this series too by having more robust locking. So
this does deserve a note in the commit message for the earlier patch
about this issue.

> > @@ -2852,9 +2846,18 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >  static void arm_smmu_release_device(struct device *dev)
> >  {
> >         struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> > +       struct arm_smmu_ste target;
> >
> >         if (WARN_ON(arm_smmu_master_sva_enabled(master)))
> >                 iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> > +
> > +       /* Put the STE back to what arm_smmu_init_strtab() sets */
> 
> Hmmmm, it seems like checking iommu->require_direct may put STEs in
> bypass in scenarios where arm_smmu_init_strtab() wouldn't have.
> arm_smmu_init_strtab is calling iort_get_rmr_sids to pick streams to
> put into bypass, but IIUC iommu->require_direct also applies to
> dts-based reserved-memory regions, not just iort.

Indeed, that actually looks like a little bug as the DT should
technicaly be the same behavior as the iort.. I'm going to ignore it
:)

> I'm not very familiar with the history behind disable_bypass; why is
> putting an entire stream into bypass the correct behavior if a
> reserved-memory (which may be for a small finite region) exists?

This specific reserved memory region is requesting a 1:1 translation
for a chunk of IOVA. This translation is being used by some agent
outside Linux's knowledge and the desire is for the translation to
always be in effect.

So, if we put the STE to ABORT then the translation will stop working
with unknown side effects.

This is also why we install the translation in the DMA domain and
block use of VIFO if these are set - to ensure the 1:1 translation is
always there.

Thanks,
Jason
