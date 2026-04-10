Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011003.outbound.protection.outlook.com [52.101.62.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4F32FA18
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854037; cv=fail; b=pxemuEqnq7RkU3Ydj1t+cYobz2EEyxHNypvbcMi6h35OHHcazkyBr++409PnEVkLUwYZGrj5Oroiuw4g1qpjjpI2cZA0zGbeFtHCqF0EWkh+Ocvo+cn6gHCkmDR4/oeTDpu29pSBTx2MIYoYAIvAz3yaqmx+HX7mQDTLj6kwc68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854037; c=relaxed/simple;
	bh=IbUa/71pXZ9XVzS63TbTU6XvmekBYwfH2vd4W5tMRtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dPSUagW1GA1EU80ooZ4PXs77UbyB6xWZDZGixtEG4NobD53nG+JM1zuanXbnC/Xs4jSfvrqcI2HuySXUKdLwZXd4RvPpeM1NuPQZcv5siTlKIpNUslzmICS7OG3O/MBrygnL80I8eoPIxXf3r1IH2BVrhMd878vmUj2BtgLxRU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c+HISVjC; arc=fail smtp.client-ip=52.101.62.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c+HISVjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fow8uCVlSFd9ZBpKeGEEhUCCeu5h2HyUfe1F1Hq27vGSKAKyrmiAZZKwc9l9QzbGbFXpxfzkNbNS+1jAuT8PpfiPJDvyKBBtPx45ssjB/rIouqoNDy0+ACCDslQio2luwL3gnxz7NBLY9j3vH21AgFKS/h5cEaY3W69Lr/Ml2yPAKMvBSgNohz1db5LZAGsbm+vjyMABVCZY5g8u8ey5AdYxkgb7mKp8xg4exMd9IvzFg3cCriix+jRNRaj0pnHpwMsOYphX6XtEv57j8Ck6w4lvOtiztrpmT7kWQxaMRqCOGajz9ahU/aJGFreKM6QLG7Jsts5xU8T+ax2WoFqYXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rEQQyigO/wTt+/tUDbybbgXIm1ePzhWpR1zTorTkXS4=;
 b=JJK4IP/l5Y7/spD927497fTKMB7BZvVRbNDo9shIR6FGymXd0qJsEdifPdi1/KEHWq5qxzuaBrDL4FsZWHUgsphKsNOVugd176bp1FUtedrqVWwSoFvehuOltdcCDfituYK1hMhKi2ZrqJmq+FZ3mSqW3uEHUjjzvRiHTgproCNhS2Bt8yGg2LfknGhmOCFtB/e/eaWyunZCZLJybkDtveJPosCjzMFiUK42aaFAzPuNfFq5D/xz5eNlqceqkguu2BHrL6cHmGjpQYjDlFH5fYdbQJiM81PlKG/v48S1Vm9/8YDu2YHqrv1PSriqVkspuMkBY0H9Svs0hFtmCW8N0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEQQyigO/wTt+/tUDbybbgXIm1ePzhWpR1zTorTkXS4=;
 b=c+HISVjC6Xq3HEnpnsSi2/4SK3KbLLjq2JzZaUCJZqJ+qYuEgbutaN7rzXh5VKT+p7J2uD76TQyMZn6DVTZAyiChWvWsQor4FrpX+lWquCohgH6UQ0pbDI2hE5UXJ2PmBof9Relfp0GR0koIpGf9i/IiJzvtnj4Twis5fKgsyxTmFjFaI4VgP7802ns3B9O9pvg6pRwQd8nY5uLuk7sMV0KTw5T9bxuI8MDE2HjtpQh1kvWv35PKS700tFn935yoxT+WmwgBha77drrIanuj3wYFCNSoJvsHH5JYIxFG462nU2Zt7YBnwu5aGA8OqTkJrM4qFX1ZXphDRFLJYvaX4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 20:47:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 20:47:11 +0000
Date: Fri, 10 Apr 2026 17:47:09 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 03/10] iommu/arm-smmu-v3: Store IOTLB cache tags in
 struct arm_smmu_attach_state
Message-ID: <20260410204709.GB2588311@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <ceb8150f229ee7bd355ec42d23e422ae2185492e.1773949042.git.nicolinc@nvidia.com>
 <20260409234223.GX3357077@nvidia.com>
 <adlG0QTAzdh9vA4M@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adlG0QTAzdh9vA4M@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8964:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4ce79b-bf44-4329-6c91-08de974256c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	e1jpgIr2075jXxIuSU4tKa6BL1+s2uJnCMMSvEpYh2GR0enxNB1NQguwKiZhc7s5ewLufaScXwKi9wTR2ZV1a2Km3OR3+656OMa1rXsdQXoWRi6kv6P6HKnwoDzLbDIFNNpdUMkDKKlgOz9yVIeaMA6rmNvYae505TH47lO6su6yaCGpcKdJjZ+q+/TLlJRpzcTMWFgBdRKBJ3DbV27aTBVGCWQj9pQIzP+m46HYuZ7ilyZaPv0lLggw0H7fQyJ/qCoXLnMFcGniN9NoE8V3KBRdHJPuudwp0DYKYX0os+jvPeLC84tiwqkH3wo4hPs4pjYAHkJJuJlgKvktRRvnOSfRl3q9dzzt76+yjXXVHT0Qm+jAyxOEKFcVWfHFr11xE3BRtUbQpIivgZaVm4nxHExJ5FNx2K0OZAIa6pPPtIfjSQ/CbuF+r5xIeGpLUTLJ0sL//74WsPLfrFotl4TjEE2prIf6A/Jkf6zfovFFq0EyZ3wJoxDYqeLVelDG2V2JYHB1mWgu2yXSgb25H8qLe+idiWM99FjTUDi2nJ8F0blPU1IELEh2yPLeqVgfBnWWz86u1Ow1PLAiEdhCws08u4d8ZbzGBF6cYyHvQClIqTmYHofEky2iQVdSqSImSDmevk2pD0vqbkSfI4yRE575+88P0qcwI04JpIQBnT8gJvt+OOB2Qq87CZccjSIhVml+9ubSMWDjf+pfMpF0sQ4joeJAITM4OlKgLGsv6EmSTio=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T1LJ9Cqgmkw8dUpCJJvmXCEj99G7kwD7cprbXfASPhGqo0uTXYdJXBh35JGs?=
 =?us-ascii?Q?IXotCmZmacgcubm6/fzwTfN3kTKqTn7OGGcV4+sQVDf/sWVRotsFHxjdR0O4?=
 =?us-ascii?Q?Mqg6eXIJEpce+fG80SS0pOedNzJFvXXh0oMA77IOtkc4hkh2eotXPR0+/We0?=
 =?us-ascii?Q?kW1zsgUCJtXOvbr1MymBtLrz5C1BrQpudG7zdcIe5FlnYbb8ONUBnzQIOs+/?=
 =?us-ascii?Q?fD6zjgGe27QVZQYb+gw3/Mh6O85R+w+APavweOG14zF9CtvTpx5y3HTUwzJj?=
 =?us-ascii?Q?v4I6xG0Vvk4buazZtBDJtknFx5bkysa8SuNsEFTQxnWyfw5cPPrUI/bmX3Hd?=
 =?us-ascii?Q?Pelb7t2xMRX718NtPqHTk5PA2dSxiVkzXsDrGTMjyqtMXOoA60jsLXfUE4T6?=
 =?us-ascii?Q?uETGccXU0MWSbMglLxahca3706Q7JvK4BQtt0YflisLxpCJkahOPzIC/nNVg?=
 =?us-ascii?Q?xaCMiyW+yFb+c84czNuuXwSBRGvHf8BlkRt1Grue4eYKJTmAbQO17EQyU5vU?=
 =?us-ascii?Q?F+hhEdJr0mWweBUIkoEKWluIt5oc8uobX8w+H+yo1xW6bxYtrkqz13M8PHBh?=
 =?us-ascii?Q?FIgnZCpo8NpaprYXjdpYY9YJJW3is64iCpJAmXQ3oqi5LAe9LdcKxjXcoKaf?=
 =?us-ascii?Q?g75fg5FWCsTlcoZeZvMZO6jqE06amP4NIuF0QPZdfMOYiKsAL0hJynGzYVtz?=
 =?us-ascii?Q?9lKyPskKzqrFDIvH26vAJjurV1SiPcUk9WI5xNqFSyV9TVeUNc2ng6/4qhTU?=
 =?us-ascii?Q?rZe30W2flcHaecQvopHE9zzgvTkPXj4NV4yOwA6GwdsfjoJeNRU+Ndm0uZmz?=
 =?us-ascii?Q?WRh0kgn/9wZ5LQ16P3tvo5n+eg8kLkMjKvNhY0LWs8FKyJvNZX389uXSUaWB?=
 =?us-ascii?Q?qvhCdCvf1yzHxyFRr83PS8a0Jenj9W/9g+jHHVhxXMdFvP+CezJZ1+RdUXQQ?=
 =?us-ascii?Q?z3fDfV2h64EGOXKCsMPt6hmktdP6Q1sOx1LBmruTfWGE6rLviyJYwdu065Z8?=
 =?us-ascii?Q?M+kpyaXjk1w3dx+ALy5LgfTI3zU39xm8c5WfycgZpLJKPmowzfrJkm06SKnO?=
 =?us-ascii?Q?NDzSR2JJu0LXiCQ1fKLoFKX8aW1+bOl+AdHv3ZF3+rlvbcifjuR16ANGOqWV?=
 =?us-ascii?Q?lmeDxUrdQLbYbK3utGt2AaCWpTzTTN1QVYhMz9UewqyN9cDW/eCj0QRlc8NA?=
 =?us-ascii?Q?hwCWumxMSG7JuZQnWQcWQ+OyFzQ8ASOWxzagFDB1knpBVEBiyxM6D33YMKo+?=
 =?us-ascii?Q?NEAUoUbTlrz/oqEsW6OcyXxh52TB4k75X4j88t/rWCEUCByYhXpTCz1dc4nS?=
 =?us-ascii?Q?EnFhxtKGcuZ3Z0LJG7fBx6ZcPK9VsnW/no4SO+/8PwvZgM+BPp3NWo2u4UdT?=
 =?us-ascii?Q?lyMfktaKeVv+T5Wes2ghPg/v/Jr6LuKUClgTh6unFZoeMEQ6n7XXjfyJUkWE?=
 =?us-ascii?Q?4T0YAKs7hmW4yxq386lp7lI5yZD97BkN2m3WBt5T55eozHKLWd58fyRVxquE?=
 =?us-ascii?Q?Rk0luKR5XM1PFAvjbq+pj3EnBIXctneLywSxfjiX1OPTQMHXm4r0gO0lxu25?=
 =?us-ascii?Q?BaJPJqWerknv/UtxD7ZHqdbbo1i8d6yfedsIF+u+UZvn3k757hHpwQ+xOvYC?=
 =?us-ascii?Q?wwfnQFeV0U2HhBHWOyhysgRvrNCWwSbWTwA6JV7L7BBQ4rP3onwus3K6NBh3?=
 =?us-ascii?Q?6JytFvhXyYtOCm+I43svJKPQ1ZWKL1CMAMfSj5UW9Qobicmk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4ce79b-bf44-4329-6c91-08de974256c8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 20:47:11.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D5rGd2aQhYAuGEX2b4Mb3NMkVE0iG2ZWTyavDl6eXhm13GJxQCCTzj1DKLnHMErS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

On Fri, Apr 10, 2026 at 11:52:01AM -0700, Nicolin Chen wrote:
> > Only readers *with the possibility of concurrent access* should be
> > marked with READ_ONCE. IIRC this is just the invalidation walker.
> 
> I added a cleanup patch to the beginning of the series and corrected
> all the new reads/writes too.
> 
> > Places like this have to be protected by a lock or the whole thing is
> > wrong, so it should have a lockdep annoation.
> 
> Hmm, is the lockdep_is_held() in rcu_dereference_protected() enough?

Yes.. but I didn't notice it there, not where I usually look for
lockdeps :)

But also that should have failed in your testing in the SVA case, so
make sure you test with lockdep on, and segfault some app using SVA to
trigger the error clean up flow.

> > But why does arm_smmu_mm_release() need a tag in the first place? ASID
> > isn't going to be used when EPD0|EPD1 is set, so the tag can just be
> > 0. Probably make a patch with that change early on..
> 
> I see. I added a cleanup patch.

Also double check it still generates a hitless update, I think it
should but worth confirming.

Also is ASID 0 used at all?

Jason
