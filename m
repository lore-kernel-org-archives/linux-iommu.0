Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFC749D
	for <iommu@lists.linux.dev>; Tue, 24 Oct 2023 23:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WeLwOZCo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsTCD1ujL7+YJ7edmfZSCy+h5TJjMtw9LGanAIUvmcTaiNSqYwGfy49GpMNwrIul1dKRl+nhVJoLYB2AgshHBEwq6rjdG+WYbRWfdKdGTHTjXhyiHCJQLCydtHVkiCBolfda0JphPhVc+tdjNm54q6H4iGjVUuiIM1C0+Za+8lRfM9ZlMhncY6lr3ZinNWkK7vTFGAyRhg4G7uA1E2NWE9/m9Ny3EGAHAC+P5vfHUt3/+WZwV/u0q8Hhm8Jto15gNe0KtAb6f3fXI88AcYDIq38Ni0g1+e8VMSuN/Ox4qKt+9sgPmMZ5E483ctQg4QU+lE3LzkQ8ZhFaU3UI7Bshig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5st7XljbCITAz793XqrjxQFZw5YV9Y8XKq2r4eCidw=;
 b=cESS/TlRzlY4aRRmndfQfk1tmb6Skwlgmzb/GH04ELO3hRV9T3juzqxh8vFB/MS6gRp60tbVpn81XjUvqvHqfXN1s/gM+6iuSYhjNZUnHLco3+j88aAGHL3koPhChKTOoU1jVE4ogdGijMMBiJ09qj17GnKuXNXtcvy14vZc6GDGYx5T+6NTyHjujGJMou0KsNqydSKovtNx6tBxScsdnvufXkiBHyqh7Ij4Wl7xnoUgIQ1b4jEliP/PLXvBqSG4O1CqDofh6xF4Ui743AS1eg19H+GLeNY6UCaecMTPyRk8JxFxr4iA3nb1OBLpElO7NlKaiQd9c2FpCYefEOSc8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5st7XljbCITAz793XqrjxQFZw5YV9Y8XKq2r4eCidw=;
 b=WeLwOZCoL62s/mZD6zrJ5LfWLwHYxDJOs9VafUw2cRK8KxWS/9ZzvrKfNVWwhjAXJR1Q3hRtcLT5geqq6jP/KueIOOjgBh1EUDINEbAkeAuE9YaglnlUqCG0wLujb1eKx3VyLLkOm48bvYckuBXtJRHWvwdwLgRu6w7p75EFfNSg9auzWVGQ/GQODWUxbVXaaXLDMp9l208BkTxQU6GKNFpnUdeDpsM6iJQKkL+HAgBsDoiJNVbDjGy5oNOPNGEwhynxT+h1q/A65YyCFU/AAD0Hjp+eerIznnENshGgjRcGcxxxyL5rSJ6rZbuI81NfFt4VBbUy4c/XMpxORdUKOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 23:46:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 23:46:10 +0000
Date: Tue, 24 Oct 2023 20:46:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 11/27] iommu/arm-smmu-v3: Lift CD programming out of the
 SVA notifier code
Message-ID: <20231024234608.GD911568@nvidia.com>
References: <0-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <11-v1-afbb86647bbd+5-smmuv3_newapi_p2_jgg@nvidia.com>
 <CAKHBV24f3yh_6GsY5jLzUVOdJksRPuHx+w6ynhYrBAt1zyHO6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV24f3yh_6GsY5jLzUVOdJksRPuHx+w6ynhYrBAt1zyHO6A@mail.gmail.com>
X-ClientProxiedBy: SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c4::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: e5428047-d444-4714-9f90-08dbd4eb6625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	23fJM9OXcNycWM9/rHtUQI/7f6a8jVMYz0zkyW/X+qTdvCTlyg1T9mBuj0bKx8lPEZ1xLA4cRY2G9uV1hQb333yLXdORmUWJB9m63t401+b25qQcskkLKgpED+D0w0pBXqs5CbnzGOORVKkUiKJxJ174bDME0JdzoDIGOKsCSC88wjUzvMMVkywoVzIpC5OkZqlYgHPF+PuAEpMpjY9+sH171T7IiasFkmq/d3TkgcWiLW19Zy8CNiS0JS7xRF1CkmXv8o2EkgWHzQ4476B2fQXXerS432mASUC4Q8jx23fYTOaw2hw4t6hwApwaNA3GDUBQckc1wIA7jnjscERnmXQghiwq7PnBgyJn/tVvRJ5OESC4P3j+wL3mYnps5sU/axHGWI5je0DS9PFC5MTwXen0ARqfmlok67GwSoDX5wVE53pAy3DgFihnV8NRQtHJSE2oJTIjHl47vgqrgrTA7/WVCMC2Cpv+AigJxTL7w2TYncGncO8zoCVo+CGzkAmfXuHdJz8Ym/i+WCQnytXZuAgMysYG4eEAnsqz9taWPuvl2Ncb6Mdmcc7zEQSRe8VqoGmZFeSZOnLAlLhLCXTLt8ywe7LlhzGkS+uKQzgSs05BznTIJbgEzpoDXbT10PQV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(107886003)(26005)(53546011)(1076003)(6512007)(86362001)(33656002)(36756003)(38100700002)(6506007)(2906002)(478600001)(2616005)(6486002)(8936002)(6916009)(316002)(4326008)(8676002)(83380400001)(66476007)(66946007)(5660300002)(66556008)(54906003)(41300700001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFRUOU0yS090R291Mm0yQ2xiSUVkc0Y3eXZ2K21LM1dtMEJQbU1kc0phN0Js?=
 =?utf-8?B?R1dmNEVNVVpNclVFRE9SRDMwc1Job0p0aDJMMDlDU24yVVVOcnVZbzJDNWsr?=
 =?utf-8?B?Y0huZmNLbGVZdi90RThwL2hXVk1XWmVZTm1QV3hkaGVNU3NvWmh4dnRsT3hZ?=
 =?utf-8?B?S1BDeDFndDVXU1U4ZTFiVTZHeDdBUEdhb2hxRDZaVjlKOFhyTU5IODNTYk10?=
 =?utf-8?B?RHVZV01Mdm9vbUJXSEt2L1Q3VmQ0Tk5NS2hHclJ6OFNDNjRjbTRaSGhrNjU4?=
 =?utf-8?B?aWNvd1RCbW1TMVYwdmR1aE9mSEdQb0svSHY0cWJwWVN3dVBDdW5xbmVkZDFP?=
 =?utf-8?B?U242RmQ3Y0Z1U0VLWC9SeUFKUys3bi9Md0w1YWRhSkd5d1BqU0h2Sys5SDFq?=
 =?utf-8?B?UGRsTG54VEhJb0VpMWtTT3pZMEtqREI0MXhZelMveGlNQjNBSlU5WE1KUlJh?=
 =?utf-8?B?MTJST3RaeUx2Vy9YM3FYQng0NW5BMFdHY0RCclEyZk5TemN1OHFjZmI5OTJo?=
 =?utf-8?B?Mi9QanZKYys5MzdVOE01cTAyUnBHM0RSMXNWTFo1SVFDcWc0MHcxcFIxQVMx?=
 =?utf-8?B?M25oY3haTlJVNG9XYzkwMU10ZjFlVTAweVlVSTlaRWVDbTV5NTNvRk9SYVdj?=
 =?utf-8?B?UzI4R01RUjFiWk5jQ2xuZVpVaTBKNzBWTlROVG1sTDdUMWpXNytaSGVubkZH?=
 =?utf-8?B?OTEwWHhFM1ZpcVFXUHV4TzUybWZEclVaMWFEMGYzbm1sa2laMEZhbEd1bWZi?=
 =?utf-8?B?L244VUtVN1pURWdXZTc5cGVRdnNsek1uNEkwMkZ5WEUyaS8wbEI5R3ZUZGk4?=
 =?utf-8?B?N0xNbHhuT3ZRYmlkMnQ5ZXk1d3NCOVQwWVNCUXFEUDY2OTVmNm1hVGJLRGdG?=
 =?utf-8?B?eFF5dEZJWkIya3BMV0s5RExyTCs4ZmNDZi9EblROQjBHdnF6TXdGWVdya3dX?=
 =?utf-8?B?U0xGR2Y5dnZkdjdSRHBITlgxWEp1QlpyelVGUEZweWtiYW1mNTBHVkdKcXFs?=
 =?utf-8?B?U1Awa2ViblFkMFJjWE80NEQzZVUvZXRjQmRGV09KVkVHT3lmd09rZ0czMlRk?=
 =?utf-8?B?M2ZrUDJpczRNdXAwNURZTVdYbzdWWHNkb0RqK2ZTdkNGd0g0TzBkOE5lSHE4?=
 =?utf-8?B?MnBTODRCNVh1aHlDRzhIb3lUMXFoK28zTzIxS2RXc0FhQldBMGdTVW4wclh4?=
 =?utf-8?B?NzkxR0FOZXk1Z3ZBSnA1TjFRVHRaR3RNeVAwM1lDRGllNm9vV081UlFWWXho?=
 =?utf-8?B?YmpySmp1YllTa2NTSzIxSHNjN1hoSTVzV0UyMTdzVld3SmZyVkhnNFV5S21K?=
 =?utf-8?B?ZW04VFdKVE1SWU9LdTFtczNtTHlRcGM4Q3YwUkZLRWVGczF2T1N0ck9KVXVr?=
 =?utf-8?B?MzRoN0JoL2t1YzRYWDAvdmpwd29ROCtNNXJuaFY2TXlMdUJtOVJObVpRWHI1?=
 =?utf-8?B?U0NKZTN1SGkyU1ByWjh4NHhvMTZad2tLc0F4MUdaOHY1ME51bm9BVElPV2l0?=
 =?utf-8?B?cXl3R2FCa0VVQ0tJWTdrYkZHUjJoRTg1Z3FUb2ZnZG05RzJsTm9nOXRaVnk5?=
 =?utf-8?B?OCsvOU1aaGM5NDNXQVo0UmdMazhKSDQzMEE3ajNQd05jWllnUHFFKzBDMWho?=
 =?utf-8?B?QzhzODQ0bEI1Z2FoY0tyaERxeDVnQnl1QUIwRVhiS0xWR0RSMmtLaTkzdDdE?=
 =?utf-8?B?eWtkMEMvN1hvd3htVE5kY3ZaOCt6ODZkYm8wK0NLRzlVR1I0U3QvbGJreE5w?=
 =?utf-8?B?dEovMkY2NXBWR3c4bE5uSExwVVkwQmVPRkRUSnZtY0pmSkxpMU9rSGVZcStk?=
 =?utf-8?B?K2dabkdrSURhM0xwcnRaYUM4VVA5cWtzWTVmMmpMZVhYcnNNTVhyQ2VIUkc0?=
 =?utf-8?B?ZFE1d0puSXJEZ3I5enE4MklUeUtNOUhVU01pSndma20wSDFwVEdScGFtTmVV?=
 =?utf-8?B?ZmswT3RzdTB4c1VvYkxBSzFWYUVCbmFFSCtrNE8wblNmV0NKT0VuZmMxOXFi?=
 =?utf-8?B?MGNPaDZCOXY2cHd6N2UwR1psYmJLeDkyOUhuNEV1Qy9vMFRic2FkTUxQMGZv?=
 =?utf-8?B?dFViaEc2cmcxWXVlMjFiZzJmOFFKVGpJSUpqNDA3cmQ0dmo0ZkFIcXVUazBP?=
 =?utf-8?Q?YmRYanMbkp1K5JADeAsrS8VuL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5428047-d444-4714-9f90-08dbd4eb6625
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 23:46:10.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWCIF9QCdYD8oUsI37a1WQMdlvwkOWc2oaGXvCcedbGMQBOhZj9vZkr6tqDhboAk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771

On Tue, Oct 24, 2023 at 02:34:28PM +0800, Michael Shavit wrote:
> On Thu, Oct 12, 2023 at 7:26 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > [...]
> > -static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
> > +static struct arm_smmu_ctx_desc *
> > +arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
> >  {
> >         struct mm_struct *mm = smmu_mn->mn.mm;
> >         struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
> >         struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
> > -       struct arm_smmu_master *master;
> > -       unsigned long flags;
> >
> >         if (!refcount_dec_and_test(&smmu_mn->refs))
> > -               return;
> > +               return cd;
> >
> >         list_del(&smmu_mn->list);
> >
> > -       spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> > -       list_for_each_entry(master, &smmu_domain->devices, domain_head)
> > -               arm_smmu_clear_cd(master, mm->pasid);
> > -       spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
> > -
> >         /*
> >          * If we went through clear(), we've already invalidated, and no
> >          * new TLB entry can have been formed.
> 
> This re-orders the TLB invalidation before the CD entry is cleared.
> Couldn't a misbehaving device form TLB entries in this time interval
> that we'd want to avoid?

Hum.. No for the 'inv_asid', but yes for the 'atc_inv_domain'

This actually looks like something I was not fully careful with even
in the end. The SID and PASID attach paths do have an ATC flush when
changing the translation. The SID detach paths indirectly do because
they turn off ATS, which flushes.

It is missing for the PASID detach and SID detach when ATS is left on.
Those need fixes in other patches

This specific code gets deleted pretty soon, but we can make it
better.

> >         if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
> > +               struct arm_smmu_ctx_desc *cd;
> > +
> >                 list_del(&bond->list);
> > -               arm_smmu_mmu_notifier_put(bond->smmu_mn);
> > +               cd = arm_smmu_mmu_notifier_put(bond->smmu_mn);
> > +               arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
> > +               arm_smmu_free_shared_cd(cd);
> >                 kfree(bond);
> 
> arm_smmu_mmu_notifier_put was previously only calling
> free_shared_cd(cd) when smmu_mn's refcount reached 0. IIRC, the
> arm_smmu_mmu_notifier refcount can be greater than 1 if an MM/SVA
> domain is attached to devices with distinct SMMU instances.

I can no longer remember why this hunk moving
arm_smmu_free_shared_cd() is here. I think it may have been a left
over from a discarded direction.

So, like this:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index d643c8634467c5..29469073fc53fe 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -378,15 +378,14 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 	return ERR_PTR(ret);
 }
 
-static struct arm_smmu_ctx_desc *
-arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
+static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 {
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
-		return cd;
+		return;
 
 	list_del(&smmu_mn->list);
 
@@ -401,11 +400,11 @@ arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 
 	/* Frees smmu_mn */
 	mmu_notifier_put(&smmu_mn->mn);
-	return cd;
+	arm_smmu_free_shared_cd(cd);
 }
 
 static int __arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
-					     struct arm_smmu_cd *target)
+			       struct arm_smmu_cd *target)
 {
 	int ret;
 	struct arm_smmu_bond *bond;
@@ -595,6 +594,8 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 	struct arm_smmu_bond *bond = NULL, *t;
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 
+	arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
+
 	mutex_lock(&sva_lock);
 	list_for_each_entry(t, &master->bonds, list) {
 		if (t->mm == mm) {
@@ -604,15 +605,9 @@ void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
 	}
 
 	if (!WARN_ON(!bond)) {
-		struct arm_smmu_ctx_desc *cd;
-
 		list_del(&bond->list);
-		cd = arm_smmu_mmu_notifier_put(bond->smmu_mn);
-		arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
-		arm_smmu_free_shared_cd(cd);
+		arm_smmu_mmu_notifier_put(bond->smmu_mn);
 		kfree(bond);
-	} else {
-		arm_smmu_remove_pasid(master, to_smmu_domain(domain), id);
 	}
 	mutex_unlock(&sva_lock);
 }

> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2576,6 +2576,30 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> >         return 0;
> >  }
> >
> > +int arm_smmu_set_pasid(struct arm_smmu_master *master,
> > +                      struct arm_smmu_domain *smmu_domain, ioasid_t id,
> > +                      const struct arm_smmu_cd *cd)
> > +{
> > +       struct arm_smmu_domain *old_smmu_domain =
> > +               to_smmu_domain_safe(iommu_get_domain_for_dev(master->dev));
> 
> nit: The name old_smmu_domain sounds to me like it's being replaced
> with a newer domain.

Sure, a later patch eventually changes this to be 'sid_domain'
(without the arm_smmu_domain type) so lets just call this
sid_smmu_domain here.

Thanks,
Jason
