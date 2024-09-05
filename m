Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581C14F125
	for <iommu@lists.linux.dev>; Thu,  5 Sep 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560472; cv=fail; b=l9gZ40FywFMC6xnhrrZ6tPYU87QqfCTNfpzEHpqS/5qUxgft5A41vB+jzxf018Vb9OvwCzXPEpK5kEjQahr7iPq2uWzAuRvbItIHWzsUV/UD1Ez8t83VECrt6cez8UKZPA+krC42eV3+/mKnKa4J0cSEH6bBsPmRbMtEm747HqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560472; c=relaxed/simple;
	bh=Dj+bBSAARxwRivqr2v/ZV8wrBUZaiwHzxCaVYtLSNrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z25Mg/0cFDXwXnsNE0gKDQgT856z+SSYNMc1SzXP/Li/jOkqAm9ux/Hb480JD6ZiO0suwXp8cVAkKeV5o5yMLCV5qfBBNnIK5IxI1pZZkQgtVPFg6xUQ2uCQipIVa6l7oFdR73lxhyRfxJ2STA+1tndXqCZYHR9EE+CFNKVNtYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qOZZ6xHP; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qOZZ6xHP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkVCGDt0EhMEQREtAMmoEgjd0oyhO6wCViwpTtXuMhEUB37kCuUl4DDkWu3grfL++41QC/Ln//6nVbA118zNiDja9EJCvIyVyJEFAavPJ9zuVMVgtIC+Bg8Meynb3b4vhSEI2pMjMKst/+KNjsOXUV5blY74W9XtR9xGvBFRQqLoU2CWComVQ7c0w8sR/MAwy00w/DY3BPTMnwP4B/di/slnt6bsM+XOBMv5CHv8vp9O67WCcVBCv4KeyGJsl2eWA6vUUjrML5xyEG+XKMvg/4XOeO2FO+xyDb4nnjTCCt6ZH+EcJP6j/7nQyll23govqLFXH0iZHIpkcRBSlDUDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMGScpK+VyHqlvMe/cYBNTIFL+O34jwLIoZ+Zxuo1Ow=;
 b=rwh7DkiEfZrg+mdcR8VzsSVgVRCZrOlY0TBQT1A4O5c0J5lPcM+Q+tct39DFNMgpB8Fq+jGqIiRZwIiPiW13Q+jMI2mzUYTbveqzUso3U0i1OWwKkRUJJSgQXAh9hvTk6ntsMFtxsqJ5TtbIsZIrR0qZxBkbs/AtDDK5dZlU6KU2+k1hkd8LSwp8y5Jdpx1e3VY+KJb/LFxDdxCdt+R1Iz6PzDNw8K6SKp7V3OWEZpH2qNrduG96u/ryqY2R/ketB0MPg7rHW1N9VUBIa27UUjRHG/fCcJ61wCD5oe4w1nIZ6kWKpDd8P0jp6SRWwGZD+v6D4Fj1hKk9IdDr69wrjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMGScpK+VyHqlvMe/cYBNTIFL+O34jwLIoZ+Zxuo1Ow=;
 b=qOZZ6xHPb2khyjeiwE3b9/njQSfsBS58oHJN8flE8hH2dIZWJgi1z3Xy2aSIeAh9wi3tEI1P58YUT+eQlo2OBTbQJ7gM73Fw3/59h0+wT5UfcP4pUOd5iEh8YGhuvjDcgNobPdafw0279mZ0su7Ts3oioTgUO8LzjGkFFMGM4slnPBeEVWcCHyd8gorChqd9EwSwdOb9ITFPFByWZWrJKaV7rYHFcVLxQFRHjfap30V2VSXHbkK5q3HioQa2vB6nB6is5jxdWSyQ0qSWzn42HhzKe93zSEIEE7/Es1qYme8BnMRKe86+WLFO4M61kV72wKIjJ/LZdnZfwzIg/cbkBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 18:21:07 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 18:21:07 +0000
Date: Thu, 5 Sep 2024 15:21:05 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v2 3/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Message-ID: <20240905182105.GZ1358970@nvidia.com>
References: <20240829180726.5022-1-suravee.suthikulpanit@amd.com>
 <20240829180726.5022-4-suravee.suthikulpanit@amd.com>
 <20240829192804.GJ3773488@nvidia.com>
 <4c72db01-448a-4bda-89e0-9c92a2f89154@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c72db01-448a-4bda-89e0-9c92a2f89154@amd.com>
X-ClientProxiedBy: BN0PR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:408:e5::23) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 84464b7e-2e8f-4f78-b02a-08dccdd7827c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/SRc34CvPQ1j6jq4TvXpFqGNWedIzMo2I2w2IyF/CyhSLXBmduJYBerRNOm8?=
 =?us-ascii?Q?cMeshGeyHeCI84klUUwylQOwL9OaKCBkQSPMavUIbE3C2oMgC1rrArLXe0aA?=
 =?us-ascii?Q?G2fA6hhQxZjI105xlMI/GFJ701osPtcrniSq7V0j57Jvujk64F5v2l3Z0+R6?=
 =?us-ascii?Q?f0+7sANBPX2HH5VsGVOYd3uO7RsUV574OSeynzRVSvzK7DD3OMm/0Jg682k3?=
 =?us-ascii?Q?PLPC4KOSAOzMdQTTW+DitkAAoxHOQgLic7ro3x45QnHD/ORR9v0vjbnJpztA?=
 =?us-ascii?Q?OP5/8uGQ52g8PseJn0DqomyUCn/4rpvytzEMQODKnQ264Z5VQSlRnfID/B7w?=
 =?us-ascii?Q?mJ5pO1ijYRoDL5r7Pv8pphK3vIvNhiFrnO/ljrk0NTJOV8mNYIO0OzzmplPY?=
 =?us-ascii?Q?JUrgVh254hHRiiflabNtSAj8s1MoBc+4WR4rHVkT+74Aa/w3/1h4wejOEeSB?=
 =?us-ascii?Q?M4fl4c5rYIuYWtKMybueLMQWP6FEyiTaEMGxoPjAkwt//X0BbZ1T/xjKA4W7?=
 =?us-ascii?Q?Vyx7xAuRznFWJKdWumEXl7AZdqECY4vQwjX/t5sv1h5xIcUMJMu53KOzt3j9?=
 =?us-ascii?Q?wwjpSwlTrGHBecimtvFRGp+UCRHdCBLwpiC3Xw0vlq+xRi+CzljsMcclZkhv?=
 =?us-ascii?Q?UAf7rd4DA44M+MLwBv2pfhABmoyr6Py9J1iQbeciZgiCHo2dQD5KB8g/aDpx?=
 =?us-ascii?Q?zV0ITv5qZYUzk9a+iDqJ3idJ/b6Zluz0BeuJtdzzKlJYtUlJpYW/dl4peaRt?=
 =?us-ascii?Q?s+sj4yNn8DNmJKRvdlzMQk/KqEjITQCDg+dFJ30XrMOBarpb3BH/lHHMpYNf?=
 =?us-ascii?Q?iwxi9duuzTkIzzFYz61Y6ZODAXBgBd3gkR37bMPqXLNODi0QPNQ5w6WpjqK6?=
 =?us-ascii?Q?0BO+tT+dN/0YMObAknkoGOuBURVAVgruQeO8OHddS4ah4tx3h6vHkwJRTJuw?=
 =?us-ascii?Q?cH8ns9yeaAEaxlOazkKPAbdYVTk6ldfoE6RJ+q9ZA8OlYiq+mPhdAdf9W+my?=
 =?us-ascii?Q?ExzviUDRNdJp5kjA3Frf6yEvL2V4RSfsUb6MwGSc4RpdlhwwnqVyLJ+zu5zS?=
 =?us-ascii?Q?i/1cgEbqOMRgocO85cGieyWVAzzEtrUaotYRvWthGPnbewiifj3SQeE4uyuU?=
 =?us-ascii?Q?MiClEbqVik9+QnI6EF1rqRinilsODJD6xdEW+pGpOPu1rGURLxrMiZy4vdSh?=
 =?us-ascii?Q?F3ZJKcKXZD/xj65R+6lFfsJI5IkL8HSiGgJrvS/RU6z2qdfBB62LuPtowoSR?=
 =?us-ascii?Q?PUeZIwKIzIxp4GE5Sns/UIsSwjoMeT07NWWniM78NtJAeehW14nYLJ8YiTE8?=
 =?us-ascii?Q?fLKXwvg5ijScUrNptKtCA21o9tTVGcYb2hbyxEt/h1xWeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLmWQ7JidZm4ZApJwj337gfTym0WarWeidCz/7hksWVTQSXENUoEf6q9Pr7R?=
 =?us-ascii?Q?K15bAPoTeFX3r67C1UHKk1r+lcQ335SFofXBJqxXhrqHzEZnDaFPOFadWOn5?=
 =?us-ascii?Q?KLMqW+5d+8qVLZtA6Aqha0N5KjCguQYfuLlykaDEsDpu/5hblHZNZ3Obav3n?=
 =?us-ascii?Q?O9yjJnRZwZLXXdJ4H7+dEf1T+w+NOpkfX2kGjsbwIESu9pbNTTFWtoyS8u44?=
 =?us-ascii?Q?MYOD3U452jDZLk9QCRrvUlcXebcSRDGLV8Lkup1tWIjjtw4l06pf394jZnEg?=
 =?us-ascii?Q?YN4H9MSnvYyv51h7mGpKzw2TThbWkC8EGRdYgJWdoBF5/SNnSlVUSILnhC3b?=
 =?us-ascii?Q?qxwcjhWE6AAKglAYAg/z91QYbe2zx4E4SZKNecBzN3+wfDCwc1PPTFHuZwnp?=
 =?us-ascii?Q?MKwMZ7XUSYCgIeIbfAoPTLAW6JlIDKpdUxT6OVVHAw3/8rTZwgubXMq4uU4r?=
 =?us-ascii?Q?zKAfOB6dSERfSnLxxOurLIz3mkIN6CqfxT8RMHVP9kfTq/nXtu0mc1TkjER6?=
 =?us-ascii?Q?dKbjvCx3jX9LdUkvOGZbbpyEScr1dOPLOX/0sSCe47LA5hy3fv08lDzn27cK?=
 =?us-ascii?Q?rEps+TeKMiXXq4RDiWN/RPhHeY1jsQURDNBVZBv67O7/8x0QdPcN6cwKx3oM?=
 =?us-ascii?Q?B2nEaaYnB5omEDAjL7weZ+wNB9NUAwEA6R8/JhfGM+yEKP80nabTpUsg15SE?=
 =?us-ascii?Q?Lii0zRK3CbgleWecRcAE+NbHwMu/JhnDAuaWwk04z4xCvvrcsUNqrbh8QS5z?=
 =?us-ascii?Q?TdjVmRCMcWWtCA7/o8DnRW4+Qt3Ix5IPMwNXxQP6F6WRw3slkYDWI5UgWZPN?=
 =?us-ascii?Q?NHuRJRVpgogZ4TxikQ/SggfYmfingialPEDEFZNBDz8Vw8OrS+m0Ay613/KE?=
 =?us-ascii?Q?vKs0+Sn3MJiETP7ASyVNNn2vksq5BJnGvHDOcb6bmBV6TfWwoZ5QzkLZS2lk?=
 =?us-ascii?Q?keIujUwEzM+ndlp+LKNlPtjhzbwy8FIXBkj2s+8AsNcVr/Tu37RT2Lara5az?=
 =?us-ascii?Q?hJtAj/uMzsUcVu3ZQAaKpuBXbILBBUuOn/hgGau90TfBNoXUV9OApVefgUFp?=
 =?us-ascii?Q?ewkTGydRk0mAFTVajk4gpwrb3XPj4EPBAvLa8KuKOlQVzSzILGACvOMxZrhg?=
 =?us-ascii?Q?uxhQyoQ6A80QFYgPWVQ9iMp3ERG/y5WEKZ6bUOvXhvw0uiP2Bq+qY9GImeAG?=
 =?us-ascii?Q?AmI8yFzs/+oQINIZvMNAVrvdQxY5RwlIBtYq2vGJ4IBi46XFoMSQm+CiZKFs?=
 =?us-ascii?Q?sT90YKhCl9qnCqF9GY6Ya2JQFzyC47LJkcOvwG45Sh8oX6BluPj+1L1wynNQ?=
 =?us-ascii?Q?BApaY84QaaPE+WO7RfBnxLXNga3cUjgpzKqXF2nVTMoDZs/hIBJLzoJmB9hI?=
 =?us-ascii?Q?GNPmUBVqVMy3lXXKcuHS5kqhE9GF6lPyKgzk4pRB1Bwi3v+9rpOPVpIoz0rb?=
 =?us-ascii?Q?IhiRzldTV/ZuO0VqcS0EwMcbBBlWJ4B7oEk7B48pU6uUnxV02S0rva/vvCWA?=
 =?us-ascii?Q?LacX7Qp/IZgEEjsQdnLUkHeSw9CL/6NDibYT7rS1oSPdlGWoChICsHoc0esw?=
 =?us-ascii?Q?iHO9nVugyOKJXWmD13W0WGdmIH15bV7qMEe38nXs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84464b7e-2e8f-4f78-b02a-08dccdd7827c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:21:07.1812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: umygAxx67G6+Y50ZRQhqN8GRZYdZur+SGc+WqUMsDfLhKvAsHHTg8+ctpxUE7oqW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450

On Fri, Sep 06, 2024 at 12:54:25AM +0700, Suthikulpanit, Suravee wrote:
> Hi,
> 
> On 8/30/2024 2:28 AM, Jason Gunthorpe wrote:
> > On Thu, Aug 29, 2024 at 06:07:24PM +0000, Suravee Suthikulpanit wrote:
> > 
> > > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > > index 994ed02842b9..93bca5c68bca 100644
> > > --- a/drivers/iommu/amd/iommu.c
> > > +++ b/drivers/iommu/amd/iommu.c
> > > @@ -85,6 +85,47 @@ static void set_dte_entry(struct amd_iommu *iommu,
> > >    *
> > >    ****************************************************************************/
> > > +static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
> > > +			  struct dev_table_entry *new)
> > > +{
> > > +	struct dev_table_entry *dev_table = get_dev_table(iommu);
> > > +	struct dev_table_entry *ptr = &dev_table[dev_data->devid];
> > > +	struct dev_table_entry old;
> > > +	u128 tmp;
> > > +
> > > +	down_write(&dev_data->dte_sem);
> > 
> > This locking is too narrow, you need the critical region to span from
> > the get_dte256() till the update_dte256() because the get is
> > retrieving the value written by set_dte_irq_entry(), and it must not
> > change while the new DTE is worked on.
> 
> Ok.
> 
> > I suggest you copy the IRQ data here in this function under the lock
> > from old to new and then store it so it is always fresh.
> > 
> > Ideally you would remove get_dte256() because the driver *really*
> > shouldn't be changing the DTE in some way that already assumes
> > something is in the DTE (for instance my remarks on the nesting work)
> > 
> > Really the only reason to read the DTE is the get the IRQ data..
> 
> I plan to use get_dte256() helper function to extract DTE for various
> purposes. Getting the IRQ data is only one use case. There are other fields,
> which are programmed early in the driver init phrase (i.e. DTE[96:106]).

Sure, a model where you have specific 'fixed' fields and you
store them in the DTE is logical. You want to target something like

 struct dte new_dte = init_dte(..)
 new_dte |= [....]
 program_dte()

Where init_dte could read out fixed bits from the existing DTE

> > I don't think you should restore, this should reflect a locking error
> > but we still need to move forward and put some kind of correct
> > data.. The code can't go backwards so it should try to move forwards..
> 
> In case of error, what if we pr_warn and put the device in blocking mode
> since we need to prevent malicious DMAs.

IMHO a WARN_ON is fine, and alerts to the possible machine corruption
 
No need to do blocking, you should have a perfectly valid target DTE
that represents the state the HW is expected to be in. Resolve the
race by making it bin that state and move forwards.

> > On ordering, I don't know, is this OK?
> > 
> > If you are leaving/entering nesting mode I think you have to write the
> > [2] value in the right sequence, you don't want to have the viommu
> > enabled unless the host page table is setup properly. So [2] is
> > written last when enabling, and first when disabling. Flushes required
> > after each write to ensure the HW doesn't see a cross-128 word bit
> > tear.
> > > GuestPagingMode also has to be sequenced correctly, the GCR3 table
> > pointer should be invalid when it is changed, meaning you have to
> > write it and flush before storing the GCR3 table, and the reverse to
> > undo it.
> > 
> > The ordering, including when DTE flushes are needed, is pretty
> > hard. This is much simpler than, say, ARM, so I think you could open
> > code it, but it should be a pretty sizable bit of logic to figure out
> > what to do.
>
> IOMMU hardware do not do partial interpret of the DTE and SW ensure DTE
> flush after updating the DTE. Therefore, ordering should not be of a concern
> here as long as the driver correctly program the entry.

Even if the IOMMU HW does a perfect 256 bit atomic read you still have
to order the CPU writes correctly. It just means you don't need to
flush.

The guidelines in "2.2.2.2 Making Device Table Entry Changes" make
this clear. The indivudal CPU writes smaller than 256 bits have to be
sequenced right.

This section looks like it was written before translation bits were
placed in the other 128 bit word - it assumes a single 128 bit write
is always sufficient which isn't true anymore.

So you still have the issue of having to decide if you write 128 bit
[0] or [1] first.

Jason
