Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190D011C85
	for <iommu@lists.linux.dev>; Tue,  2 Jan 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bQmv9M5o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wq+o3X4TUbdVkA1iTcoR28puaBwo4Bk7bYOr26P8mcrI9/bypyl4I7vwhI+anO/VyquaWNiRnxtcj7kIIG/3s0/SwqcHsUHXKFgoMOFnsY5/Sj7cNB9dqniNXjoRrBfyYM3b7ZzrDz+deDyutdKfIQU4oI149ZTKMRb09em9Xko/gXpLlcBGiLwD9ILvUhihOVkx+/IfY0jJN7m0Zr9FsvCs+syqLnA55EV3f8rWRcjAJ7F/+zjFGpC2iBFwyGQ6m6HeTxXKquydbiOyTWziHgVqgGRPcyAeBnez14ujv5c3zwNDrJ+ZaXx5AG1OpClBbdDUt/uAX83GyBW3OfVqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1HO1byqGi7KihvWKIMCPkFQ7xcwDC8vmpzJtZ//p90=;
 b=DWWgOeQ2ndDM5Dj2rHpybATPIM6y1gaMkqaWfsBMhyLyhNRYlMO/tQ4gNHwX8eqk0rl+Xe7lzajD8tU3bWf0fdeLM3JxXfQOkZaob5PbZXja//1zrgJu39un4+Jxv27CVRdtVaTsTdDYjM6oUZh9+qeCiZKJp235mHlQuyYKosLWk3Hc7sZy5DisKnUUnPCCaVOGszyG+xXQY3OF20W2Q5+i6c0YIb9vf3MFXTLgcs1B+fJ7dyw9TGsInRflKUeopIE53BaPYxcb9Qob8aoi0OAOQXhp/d+IuxqitsxXQ4mzeKUlyqI8Pw5+Oimy/Qoth18HVEkEMUlFxDNaSyNOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1HO1byqGi7KihvWKIMCPkFQ7xcwDC8vmpzJtZ//p90=;
 b=bQmv9M5oQZ7S1F1C59q4aWS2SgkZxAyfv7X9/9birue7aNjufPHMIyyBYKAJi5YsxSpGio0QFWKiekrQpMe8O/9/yov00/lYRcKu/pQt71mcYvUt+9O2k+SoO24z9q2HgnE3DaMJznGkQ1l1nG2g3C8B1eyOPPtyQyyh2PNU/svX19zCM64LA6iaA7QrxLdtZX855SvHH+SzYUJLZ9FytT+LgjnoEZdVuWL+PjfD6T3h/6a/Ain1ycEdb848phRhGO+6xHuZ2NKxHwU/H+MHGzTwyrZxCvSWyMDnmn1cZ0ZWUHSE1oFYsmQBm2roD96OFjbBKYDFaaluMmHUlNsc5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:48:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 14:48:15 +0000
Date: Tue, 2 Jan 2024 10:48:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20240102144814.GC50406@nvidia.com>
References: <20231018130455.GU3952@nvidia.com>
 <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com>
 <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com>
 <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <20231227154648.GB50406@nvidia.com>
 <CAKHBV26yjLu-EUoBJT8EL_EbLE5oqLUL-_hwh2YDp2JH1EyAMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV26yjLu-EUoBJT8EL_EbLE5oqLUL-_hwh2YDp2JH1EyAMw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0193.namprd13.prod.outlook.com
 (2603:10b6:208:2be::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4161:EE_
X-MS-Office365-Filtering-Correlation-Id: 450b6ec9-9099-44dd-97f9-08dc0ba1d9a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vb2Lcn3ogEXQ7D085virDPZKn6XNH2m8PxAfSsZnyya3K0dWyWqFN01id2afKAvI5QKZBwBj89etGgUqZfDd9VH2I71UCIRMPe7khVuv697rJLnfiMZYPJqSN6oqhSceh0TQmIeLX2iRIY9p2+lu9TVGIF5Byy38SwJ9d8/Yz/NA6oE0TMIYwUklvG7B0ZIvt6T2c5D9gIHBzfHagBxBGmSnNLOleTMnplxo/u0atpO+loZdW/vOxRB2cpyOKAwVEvZfKQYlbHPwVsXQTsZB0RKDLOZ9wJg7zbg44f2YxSE562PBQDvwE9gYN4d7hy6TvZB3w3RhpLyBGIVt/ktuZ1LDhjZGVn3f2i3yqGbFU3hbxY/1zf81PR5XgOeAVblpKCo9sqimZ9SAPUPu/IUBdCa0fBr0VVDiGXr20Bb2yA2rKTAu2gQ3PnT0uL0LoHKPnMmf4kZyZfnBsZiyNpi5bEzESNjWmMkltHruf9WAfTsYCbtIigp/bfZ8aMFaQlXwugVXbl7cSks/QRQmf7ugC5x5dyMs1SJHUo8n+uuXpw7DBOuajdzVCLklqT2U6TFT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(39850400004)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(33656002)(478600001)(66556008)(66946007)(6512007)(6506007)(6486002)(86362001)(66476007)(53546011)(83380400001)(38100700002)(2616005)(1076003)(26005)(107886003)(2906002)(4326008)(6916009)(41300700001)(316002)(54906003)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTVjYmJ5Qk1GMDhPMTJrOGM4R2hBeWY5TTNTMHVZR2dWNWFIK29yQWFJK2VW?=
 =?utf-8?B?eEJiRmhQUzc4b3dOMkY2YjdMTDZnTEtzcUJTSk9DVyt5ZW1OWGNPeEVCbzlK?=
 =?utf-8?B?elVWNi9Kd1NYWjFhbTRkVVlJUlhCYjRXMlF0clR1dzY3aDFUY01YWVNvSk1N?=
 =?utf-8?B?bXloMHVnSlo5VnR3aHhvSlNtaG9PKzN1Y2xjL3VaUzlMUlFkY29VSmhOc0F0?=
 =?utf-8?B?ZEhiVHpiOG1zZHgvZmJzTkVJc08wekxSV3BBd2Q1T0V5ejU2UkZZalJGdzdD?=
 =?utf-8?B?QTlkRnJjaGl0eE9Jb2NLQnBIK1NNei8wdjhQZEZlZDFjRjRpQnI1NVhPQUpx?=
 =?utf-8?B?cVBiaEFQbE44NzFFZTJWSitkNFlueHBudExmNmE2NXRrbDN4aG9nTHpPWVFU?=
 =?utf-8?B?WTU1NEo3aWt3V0dNWTNkQVdpQlNERTlwNG9reGYzSFluUWExUnBGSlNNSW5q?=
 =?utf-8?B?VTBVZkUvaFJYN0NhQnk1L283R0VsYmlERDdBUWZ2YW5TaTRON0N1QWk2bXBX?=
 =?utf-8?B?UWpsRWxWMVZmcjFXT2lFckJHNGsybkxBc2VYeTllSExqNFlIYkRyN0Zjd0Ny?=
 =?utf-8?B?ak53MHpOYTN0Y2twZGFTRUo1QkI3anVkYVBPQ29tUHFNNm5ScS92STVyS01X?=
 =?utf-8?B?OGUzamFRY3pOUURFWmFDdC9reVRIaWNGbU80b0lUUHM4L1p2bEVDWWtVRWJo?=
 =?utf-8?B?NHFoZlNHTXVzS0xYcGtBbEJVeGRza1ZTYUpCL09LVzQ4RmYwL29lK0FQNk8w?=
 =?utf-8?B?Q1FCN0ZNeWJSaGtYVjhmK3JnQUhXVkVRUkRXcFFvdTUzclgwbjBxaWMrRWdz?=
 =?utf-8?B?UnZJTGJyM0lGTjBUNFRzQkp4aVNBQ0VoSER4bmJ3Mjl1TFlCSjZhTEVFZi9k?=
 =?utf-8?B?Q01PWlpaVzFhckVSUVEvbnl5TlUwdW9rcWtxcjhRK3FPNVBhY3hydzVyTVJv?=
 =?utf-8?B?SUUyVVd0SGIyTDdybE9tKzBnLzVkQmhldklEMEc3bC9vOEEyNExQYSswMnFW?=
 =?utf-8?B?d2RUWXUvTHk1ekE5WS9vNGpjNnlQUUR2THpGYnVJMUJHVlpVNllpT01KSGdY?=
 =?utf-8?B?a1R4RDA0NXFPRFYrcDFaNmhNYlFMUWx3VHBRamp1Wml6aFRLVURDS2NEVTJS?=
 =?utf-8?B?ZHVSay96VlgyN2dMcitneXgxRy8xQXc1WkVjWTFUT2JUSFFvMnBDTFkxcXM5?=
 =?utf-8?B?b2NISXRzU08ydUNtQnZCakhqeTJPdzhQd243ZUFXdk9jNVk2Zk5SaWR4bFZK?=
 =?utf-8?B?R1E3MFRxbkVTdWVMc1ltRkxwUk5na0pWbXRpSXBBSmRxUVVoZmZVQWVpVDFW?=
 =?utf-8?B?YVdwTVp2UzRHaWF5eG5mUnd5RVhkTkkrdUdBa09oYjlhdUIxU09hVEt2TS9V?=
 =?utf-8?B?SUltbGU4S01TQWs4T2t4eTFBUVRLZGVub1RMNzBmQTREMlNyczBuVGNUc0FR?=
 =?utf-8?B?c1RsQ2pWbCt3c3Y1V3lxL29ka2VvVTJVZmJSY3ZmMnBjRjBoRXJqMjZtcHFn?=
 =?utf-8?B?MmVmOXZ3ZjRjTE8vN2NRWHc2ckhIazQ3VldPcGkrZUN6cm1Va3Z5SjkvTERE?=
 =?utf-8?B?TW5Od20wNllpTlJpTkd3VDYrSEVBeUlZd21kL1dMb081V0F6Z3V2Z3dxS2R5?=
 =?utf-8?B?ejduNlpYbEdsUWovM3BvaVExNGdtL2FybzN6YU53ZVVLRFdJS3hzSVl3dmFv?=
 =?utf-8?B?QWhZYzNrSlorQ1psVlNXSHhsczFiTTdUdlFlUWNjcUJGUXpRMUJBR21iWlpY?=
 =?utf-8?B?eUtmcVdMVCs3dmljbUg4eG03VW96YmcxRmZkRDlROEw5VE9scnByMVdKcmZk?=
 =?utf-8?B?ZG10REVlNGNhQTA3RGh6NE5GQkNSRWJpeUNmRkxhdTBJcDRWWWdyajRaUStK?=
 =?utf-8?B?d1cwUkRUSDZDdmhvb2VFTlc0RUxWZ2wrUXdNSUJxU2FIM09GaElWWlozZU5k?=
 =?utf-8?B?Tk00cVhacVpSZWlDVVFnRXpqdjFhMCtBZUtGQ0ZmWjhibUlydkZQTWJrOFlG?=
 =?utf-8?B?bDVxUVlwK0c0TGkwcHpWVng3VDFrVUlGbXhDWDVRUzhKcEw2STY1d21FNldm?=
 =?utf-8?B?S21qSFlQaDI4TDlvNDI4MmxYSXczaXhhYk1BYUpHUFRHaVArUVFFaFk2K2tJ?=
 =?utf-8?Q?qC+s=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450b6ec9-9099-44dd-97f9-08dc0ba1d9a3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:48:15.0419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaNZHP5fOAs52HY4bm58UjHQoDjZ7D9Vh1pYy5XBHsUZp1BraiFMdIonxl4g9Cwr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161

On Tue, Jan 02, 2024 at 04:08:41PM +0800, Michael Shavit wrote:
> On Wed, Dec 27, 2023 at 11:46 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Dec 19, 2023 at 09:42:27PM +0800, Michael Shavit wrote:
> >
> > > +static void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer,
> > > +                                __le64 *cur, const __le64 *target,
> > > +                                __le64 *staging_entry)
> > > +{
> > > +       bool cleanup_sync_required = false;
> > > +       u8 entry_qwords_used_diff = 0;
> > > +       int i = 0;
> > > +
> > > +       entry_qwords_used_diff =
> > > +               writer->ops.get_used_qword_diff_indexes(cur, target);
> > > +       if (WARN_ON_ONCE(entry_qwords_used_diff == 0))
> > > +               return;
> >
> > A no change update is actually API legal, eg we can set the same
> > domain twice in a row. It should just do nothing.
> >
> > If the goal is to improve readability I'd split this into smaller
> > functions and have the main function look like this:
> >
> >        compute_used(..)
> >        if (hweight8(entry_qwords_used_diff) > 1) {
> >              set_v_0(..);
> >              set(qword_start=1,qword_end=N);
> >              set(qword_start=0,qword_end=1); // V=1
> 
> This branch is probably a bit more complicated than that. It's a bit more like:
>        if (hweight8(entry_qwords_used_diff) > 1) {
>              compute_staging_entry(...);
>              compute_used_diffs(...staging_entry...)
>              if (hweight(entry_qwords_used_diff) > 1) {
>                  set_v_0();
>                  set(qword_start=1,qword_end=N);
>                  set(qword_start=0,qword_end=1); // V=1
>              } else {
>                  set(qword_start=0, qword_end=N, staging_entry, entry)
>                  critical = ffs(..);
>                  set(qword_start=critical,qword_end=critical+1);
>                  set(qword_start=0,qword_end=N);
>              }
>       }
> 
> >        } else if (hweight8(entry_qwords_used_diff) == 1) {
> >              set_unused(..);
> >              critical = ffs(..);
> >              set(qword_start=critical,qword_end=critical+1);
> >              set(qword_start=0,qword_end=N);
> 
> And then this branch is the case where you can directly switch to the
> entry without first setting unused bits.

Don't make that a special case, just always set the unused bits. All
the setting functions should skip the sync if they didn't change the
entry, so we don't need to care if we call them needlessly.

There are only three programming sequences.

entry_qwords_used_diff should reflect required changes after setting
the unused bits.

> > > +       if (hweight8(entry_qwords_used_diff) > 1) {
> > > +               /*
> > > +                * If transitioning to the target entry with a single qword
> > > +                * write isn't possible, then we must first transition to an
> > > +                * intermediate entry. The intermediate entry may either be an
> > > +                * entry that melds bits of the target entry into the current
> > > +                * entry without disrupting the hardware, or a breaking entry if
> > > +                * a hitless transition to the target is impossible.
> > > +                */
> > > +
> > > +               /*
> > > +                * Compute a staging entry that has all the bits currently
> > > +                * unused by HW set to their target values, such that comitting
> > > +                * it to the entry table woudn't disrupt the hardware.
> > > +                */
> > > +               memcpy(staging_entry, cur, writer->entry_length);
> > > +               writer->ops.set_unused_bits(staging_entry, target);
> > > +
> > > +               entry_qwords_used_diff =
> > > +                       writer->ops.get_used_qword_diff_indexes(staging_entry,
> > > +                                                               target);
> >
> > Put the number qwords directly in the ops struct and don't make this
> > an op.  Above will need N=number of qwords as well.
> 
> The reason I made get_used_qword_diff_indexes an op is because the
> algorithm needs to compute the used_bits for entries (for the current
> entry, the target entry as well as the melded-staging entry).

Make getting the used bits the op..

Jason
