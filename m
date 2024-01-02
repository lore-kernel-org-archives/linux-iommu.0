Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72536125D2
	for <iommu@lists.linux.dev>; Tue,  2 Jan 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i5PCoDqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL7m/BNK3KSNE20jROMOZw6Cw75GTXWRT+bXPNIQbTKVMzSNAXkrzGCnwbO1s7GhWMCsPjirPNGdawbtWOfO4mLcJcCH4hA1ZQVh12+EGrId0Cn4PI+233qNSk7Uw+RZyPJY3eV4lCRdQ4vXY+O3T6/scr0DaN+aKymyMHl00DCC3x49TMj0wzy/jt01eJPNt07034mBGONi7lB1KxIuGpm+0ccNeWeUFNjLPdMnJmPi2WjmVs7ABi9/oAXZLY9WSIeMFzMoc5xvi2LdKI86IlwLW9bo52BsBGrza32D/BZDUAP88VPsdWdweVNkOzYqSpeMqJRjHshLUY/47sKYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmlFFhdqVTN5w3Q7u0ayR6ykW44X5ROoXv9UIRzehRQ=;
 b=Z07dw62Qfu+jywuDXv/qEhXEk1GARbK2sZkCTBpP5/Kx1OhhhkcIZv4iDRsE6QK9lq3uzp3YDWaFVlDVG0TQDGlxlvd8nTF+3n0z3jhR/fpB+B9pSxeDqbZSDCOhj68BQFueR9MGko7Se//Z5MOdEancsdh6MpfmeXla/74HHSfeqwPB542K3Rlj1skepPf/qTE0REoZdDk87IgIJ5+QG6VUfmGGAiIJ17MrP6YFSuH5pBOXX5mpNfjVK7L2NeaKRnHul/EZ8WTqJw0bwfD6nAcTL54jU0i8uMiTxNly3dBkOkCilmdYrjs9u1/mXsk/LNv4hIs8QKShQhv7AAtQKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmlFFhdqVTN5w3Q7u0ayR6ykW44X5ROoXv9UIRzehRQ=;
 b=i5PCoDqOU5Eq8RyFsvcjEyCw2X90VSfnkaNh83PK4LhGDrL2CiASCs+/H3I6Xr4FD+buUyITAAFldL7NnKPW8X4hqqSVJiqOLTVTV4cSklPVi+qumhQ7UGKYz2Yk4u/Smdwbmhh2CXJ0+VPOAUzrYKqzMC/zsi0dx2BKMOrIxFEaqM5pgqxepwjUBA+aivhN2Z5oiPAj9b7HxT6ddvZCRrh6OF7ybjBJQbK/ChyNfgPs+2llC8lmfOU8Liz4JKVwIrvLm5BwoGk5CHuAlRyJcsHj3g6CFKZ/UCA/QyjzZ/79gWvoEMpCX7U1NLssERRks+gIKY/AlbezsNrEQVJX+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 14:48:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 14:48:46 +0000
Date: Tue, 2 Jan 2024 10:48:45 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Michael Shavit <mshavit@google.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 04/19] iommu/arm-smmu-v3: Make STE programming
 independent of the callers
Message-ID: <20240102144845.GD50406@nvidia.com>
References: <CAKHBV27G1PLZ5gkYkOOCZdD9waZOZypkWqk4_HSR4XXGFT-+LA@mail.gmail.com>
 <20231018130455.GU3952@nvidia.com>
 <CAKHBV270uJjdj4zeK-NNt+j3TiqoGDdLUQ5uRrLw9PN0ysCDbw@mail.gmail.com>
 <20231020113918.GD3952@nvidia.com>
 <CAKHBV274M-DDD+vJgO-k9s4MF=FLhKajPdphfBVofjyOS3vHbA@mail.gmail.com>
 <CAKHBV24nfdq1q76T+DRQGNYeA-kP7ONnSjDsRFGsQCJVSrSm0w@mail.gmail.com>
 <ZX7xu8jN/rBZ4A/d@nvidia.com>
 <CAKHBV26CRC8eWMuOk6EZYMHOZoR2FauP=NBazzOiWCmQYEa1vg@mail.gmail.com>
 <CAKHBV27qsgjgwPfn8OpSq30z1w203NDqBZ0s66bPgjp1XDnLOg@mail.gmail.com>
 <CAKHBV275ELiNtZqdmqzWTJ7AHOuCigzPFAXAcG5xPwonhgYXvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV275ELiNtZqdmqzWTJ7AHOuCigzPFAXAcG5xPwonhgYXvA@mail.gmail.com>
X-ClientProxiedBy: MN2PR11CA0027.namprd11.prod.outlook.com
 (2603:10b6:208:23b::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: e60a12af-021c-49ae-d9b6-08dc0ba1ec1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cokdmONXmr07sW8G6FcU8AYWWO1G/YepqZhLdzbrjQgig8tULZXjCalkYgtKEgQrmwRFIqanoztYuVnlOXI9XiFvDqV7mld+K4vK2ReULpYSM0Vijcv3Ry8k/QGZW5L+OkVgCOOjUYDVp0HUcYTJhANfIy6b6WRtXtNhqrnDCK34m7wu1v2eH7Tbf6FEipFnpd9MLQURpUVU4PTBvapD8pUF1HeiHnjx6HRT+BQGU0FPKqacSnGxIWsReeP9BFjF3LlggyWenYHgPejWarFuyu/46BNlJ2aX0Pk2UotrFM83tyrk4CpEGf+co7dfMCXYLRVlgciGJ+wLSAW9nZLl0s/s1DZAzFZqhxHFaGAbW7++0sVLX6g+NBromjVAbMzvtlqzC88gDiSdwd6wfR0cQBPlcetbG8f3qhHg/JHj6pZT8LO+TihKuZ+Gwgjb1n2Y0N30QOL+otu74AztztHOCf8BZVtq2OHzrshM/1Dv1GDT+wTNgl3M6KLPdyDnBaEiz7M0XLRUz+xbv7/zpx5h2zm8zCEiLOXavZ5CUP4aM2nKKOF+Ps0MHcdMyD9IWjq3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(36756003)(2906002)(83380400001)(41300700001)(5660300002)(86362001)(478600001)(33656002)(6486002)(6506007)(53546011)(6512007)(4326008)(6916009)(66476007)(26005)(8936002)(8676002)(66946007)(66556008)(1076003)(54906003)(316002)(2616005)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVVWdHQ0YU8vdjd4aFA0YS9VSHljcTc5bm8wOExJOVQxTjVwYW54MkhzTmJR?=
 =?utf-8?B?bllaNHdXTldiQVRLNENkaDQ0RDRNSCtIZnVybXRTTFVUUU4zQy92aVpCM1I1?=
 =?utf-8?B?YnV4Vk04bklRdkFSb2tybytCd1RuQ3dEK003YXJRMkYvbytFTHF4Q3JIZ1By?=
 =?utf-8?B?MGxhdE5OeGhjY0RXRlFEeHVxd0RheElJTjRyQi9ucFRYeDVqaVU0dDNxenlI?=
 =?utf-8?B?a1gxSUNzVkZvZWgxT0NiTStURFVrRjhiQzdYSTJqYk1SWTZTRmJCdlRRRE1V?=
 =?utf-8?B?Nlp2QXRyMW9WelZldW93R0ZRU0Zya1VXd1BnbWUrdmg5ck5maGhaTVNuNUh4?=
 =?utf-8?B?aGhQclYwZTZiaXVTT2hVcWp5S1ErOGhRb1BkWmhlSXl4WTI3MS8zZTZISCtO?=
 =?utf-8?B?QmxaemZXRFMxSWtUbGx3eDRONHJxaVdYeTlEUlhjKzJiR2U1a2NWQ0ltdnBx?=
 =?utf-8?B?MHJZUzVLOWovdTRtVW1xQ3RCQjBrY2hBNGZsS2xBQXVhSG9FQmJPaHNmVldv?=
 =?utf-8?B?Q3JWdWxvV2hYSFN6Mm5Mek1QdzNjVW9nVG5ickdsVHFESjU5MW5NeDg1WXdr?=
 =?utf-8?B?WWpoazJZdkg0QkRWQ0ErenNmM0gvQXE0MzVxRTRnQnpIc3g0a1VzbFY4THFU?=
 =?utf-8?B?dlp5TzBDMXE0VkZqd001SlFPVk53M0NMTDJyb1dVQmFFRXNwdEF2dWRCVG4z?=
 =?utf-8?B?NWRncDhWK0JCbnd2RVVFVmRLbzhsZ1VIWWpwYUNueWszL2lITGgrZW5CNDhF?=
 =?utf-8?B?TnRCeXBXc1JBL0FCK0ZCK0pLQTBTQVBKWDdCN0gxdGwvUzhlZ3pBWmlmSVRI?=
 =?utf-8?B?SXFLWVlLN3phelN4eUZKMVkvKy8rK3ZtWWluYlN2SWdXU2UrNXBRbmdmL0JW?=
 =?utf-8?B?MGYyVGN4T2NIeUM2SUFuSEh3eHFocnY3Vm1DM3kzblRBRDE2L3VRREt4ajdB?=
 =?utf-8?B?RUNmUWVvZE5PemxSVjM3aGpkMmJyQWhDN1F2T01McUNDak1xQ29jWUQwaWJE?=
 =?utf-8?B?OXlpWlJoY2hOVUpDa3M4NW5xdWVGRk5wYkhhREZSWlJFVFVoeFJ0ZXBRaTh1?=
 =?utf-8?B?dFhKZ2FsWVlTMVB0dlB4Y1pqMVJJTWpQbEVQbjlkWjZDellGUFRCR25JMDJL?=
 =?utf-8?B?WlJIT1krekFSNlZELzRnZDVwbExvWExGdFdhNVpUbGdCL0w2bXBsQWF0ZTNj?=
 =?utf-8?B?dmJhYXUzNWRZdWV3VFlTa3JHUW5iLzFhVE9OOUUrUmMrV0REcWRTLy9VaWxY?=
 =?utf-8?B?WEhkSkNHU0ZNT0V2SzBRM3RXWXpyTFl6d3FQNmNKWkUwOURubmVXaUFoS0J4?=
 =?utf-8?B?bFpwakF0eVplSlIrb3FUaHJLZG5jblJNWGVmTVFUUkJobzJkNEw5WUJLbkRB?=
 =?utf-8?B?UE9ieDY1OGNFd0d5REIyY2FxMXhoaWdKSDZGN1AzaGdKYm9GT3N3Y1hXUEF6?=
 =?utf-8?B?N1JWQzZRRmhCWTgvRFZOMWZXdFdxYlBkVklZblBHVkVWNW5YVzMwR2RVVTZv?=
 =?utf-8?B?T0VvVzZZb2FXM3RYcHpwOTYxQUk2YlZlVi9OY05KZm14OHRIQXRjS2dHUVl5?=
 =?utf-8?B?Z29xSWJBaVJEMktldENXemoyQTcyY01aVHJIVGtTbWowVzhhT0Y4ZFNEVDNS?=
 =?utf-8?B?TFcvRE9BWDJpYmltYTFncFV3b2FDZUo5L2Y2Q3hOamRFdThDb3RkbTVoMHdK?=
 =?utf-8?B?V09XRHlKbjdKMnhsaERMeEFQWmZSS0EwUGZ3SFhFK0dQMlRQcklHZG4reXo2?=
 =?utf-8?B?QmFWaGZjTTVnZFdXZWJKK0xRMm5uMUEwWXNUcCsxQTFoMFNkVzMxcHNjNExJ?=
 =?utf-8?B?dTZ4c1lYcmJYU2hpa2RuYVNZWXpDUzNCNDBIVHNTWU1XbW9Xc3RxOEt0d1Yv?=
 =?utf-8?B?Ti9HVWEzS0E3aVVjcWhHMkthSDBWVkNiZHYzVkZLbVN3VlhEMVh2VWdwT0Jr?=
 =?utf-8?B?Mk5LTUdJMW5mQy9UOXBPQlFPUkdYRWV6YWR5bHVNUGYvVTJQYUs4MmNtY01Q?=
 =?utf-8?B?R2JJbnhJMW5jcmd0Z1JJUmdrenJsOVRtZWM0ZlhUZ29GRDFpYU92TUVSL3o1?=
 =?utf-8?B?TVpaSjZRdllna2g1Z1JkNzFneE96RHJ5MTQ1b0J2MU1qRS9qbDZVTFlmeW16?=
 =?utf-8?Q?qiVw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60a12af-021c-49ae-d9b6-08dc0ba1ec1d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 14:48:45.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz5vienD4ItMBvP++SPswCiWJqcdITEaeoFcYgsTCcxfn/5ZUCSR+TjyvqKPOomt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

On Tue, Jan 02, 2024 at 04:13:28PM +0800, Michael Shavit wrote:
> On Tue, Dec 19, 2023 at 9:42 PM Michael Shavit <mshavit@google.com> wrote:
> ...
> > +       if (hweight8(entry_qwords_used_diff) > 1) {
> > +               /*
> > +                * If transitioning to the target entry with a single qword
> > +                * write isn't possible, then we must first transition to an
> > +                * intermediate entry. The intermediate entry may either be an
> > +                * entry that melds bits of the target entry into the current
> > +                * entry without disrupting the hardware, or a breaking entry if
> > +                * a hitless transition to the target is impossible.
> > +                */
> > +
> > +               /*
> > +                * Compute a staging entry that has all the bits currently
> > +                * unused by HW set to their target values, such that comitting
> > +                * it to the entry table woudn't disrupt the hardware.
> > +                */
> > +               memcpy(staging_entry, cur, writer->entry_length);
> > +               writer->ops.set_unused_bits(staging_entry, target);
> > +
> > +               entry_qwords_used_diff =
> > +                       writer->ops.get_used_qword_diff_indexes(staging_entry,
> > +                                                               target);
> > +               if (hweight8(entry_qwords_used_diff) > 1) {
> > +                       /*
> > +                        * More than 1 qword is mismatched between the staging
> > +                        * and target entry. A hitless transition to the target
> > +                        * entry is not possible. Set the staging entry to be
> > +                        * equal to the target entry, apart from the V bit's
> > +                        * qword. As long as the V bit is cleared first then
> > +                        * writes to the subsequent qwords will not further
> > +                        * disrupt the hardware.
> > +                        */
> > +                       memcpy(staging_entry, target, writer->entry_length);
> > +                       staging_entry[0] &= ~writer->v_bit;
> > +                       /*
> > +                        * After comitting the staging entry, only the 0th qword
> > +                        * will differ from the target.
> > +                        */
> > +                       entry_qwords_used_diff = 1;
> > +               }
> > +
> > +               /*
> > +                * Commit the staging entry. Note that the iteration order
> > +                * matters, as we may be comitting a breaking entry in the
> > +                * non-hitless case. The 0th qword which holds the valid bit
> > +                * must be written first in that case.
> > +                */
> > +               for (i = 0; i != writer->entry_length; i++)
> > +                       WRITE_ONCE(cur[i], staging_entry[i]);
> > +               writer->ops.sync_entry(writer);
> 
> Realized while replying to your latest email that this is wrong (and
> the unit-test as well!). It's not enough to just write the 0th qword
> first if it's a breaking entry, it must also sync after that 0th qword
> write.

Right.

Jason
