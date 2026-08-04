Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153546C848
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 16:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860366; cv=fail; b=ZFcCGo+1w+snZLYbxqrrQnT9enKMWkyNdNjcBvd/FYEyBafOD9NVlyF27+4/ZQPTuDUnXPqeMZiViToSb49TTk5rYfcqQAyGDtTB3kBZAN1sp6fc3S4BVzg6pTYcAp5CZIVTgawZN4G8uY1DH4vsn3jxBzP7JkK3d7hT03NU/zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860366; c=relaxed/simple;
	bh=PBo6e4XSwAp2f5KYf3J5r0VIHjVb9vpf0Ijg/0PpKh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FnAK4gJ6TKgqqapOU0nQ/4u19oFXqVgjzhIsYtqS6EN0m/N2HnoGWOzUEumf/PnMgayfv0YhpvNAIRS6fNawsV23JfEkQOhpBzgZyrQpHx3gLe4bVI0T2UFOcXTADyk7s/BjNxe86lttvA1xGyIfxxzwAzDcPOFs95z0Txxwm7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OV+cyEuZ; arc=fail smtp.client-ip=52.101.57.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OV+cyEuZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPWjXwzLjWXCD5kYUYbTe7dvutfR7f/LMTmvHdk+7o6m2axIeDdMdPtu0H4TiSffoyl1+3o7PX4z1NeQhYx2iPgdwlW0MtpTui4z3bbS7I+cBGvRRAUxphzgup1nJDgRV8w2i8kSeWEbY8vM/o/TG9B8Wlns2OvpCv1ZKZ5FKoX2+UTH/t9QcNQQ+4Gr8mOevQTwRO4NLeuUi8/Zei2+s965NrrzYMehzfL9Ev1frupnheJqCe+aeqwY6M17aO0H8BF3VInJdvhzOqED/NejQgAlpoF9JMOKj3e6LA5Ezl10Rb1qQxMH0OESFgtX47bIJdLw8y7/7TD8cAlDBw5DBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QT+k7pp+Wz2QAJGVnLyVEomFbV5EW+H7sDIR5+cNg8E=;
 b=JKPCYt1peANf66/jMBaIzX5WUC3WShAk0CUvR8uizk1rF5adMTr1qxqhFSRQLVjNimqOMtd8NqdgwmPxzZ9vc+ibkh/ukYYxL92x9/fvyH7GJjkOkvnuJMl1l9/KM38sP9gXcplCu3Xo+J/GKW5nFW55/TvGarS0Vit/CxUT1+tylXzWH+luNe8QdpUkblPhCOXWMe+AyT+YsmLCbhamzj8GrPDvt9Uq39kIS4yOffoBIkMk8yFdEbVaBJEBa4fh4kYJV02eZ7EZPakenrBzqRJqKzMLMKy1MnvKpckfy8mCTA1fN3fEAVXAUjWPP/lxJ/oNf3iDvH13YJS4JCYvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QT+k7pp+Wz2QAJGVnLyVEomFbV5EW+H7sDIR5+cNg8E=;
 b=OV+cyEuZpWUQTkgPtKsA79k5l9hidTh4I0D62nsLrj5KJ84eKCja5arppJ3XtLtdISKlY+r7oV2ui8qNq6es3ytYjjlYSzSLhPtyuQpKB+Y13DBOZGXX0dOdpcHOjoKGIkMTC6mt1uiQWlzJKiqG9Y8iL87KPBnCmhC9cmD8weSQUKmX+PhpVlE1rn2cteFTuAbeLFFvF3iFUFDC3HzG7KRllVCLfBKHnroxBP4B8hk8aFzAysno+dSZmqQSi3tAbNEkrLcGO1+4PJTRBjAtTBbgp4f4ZKBBzK4T212Evrvqvwio+5CY0mjY5h0a20hZa/rr+/vO/tzVp7IIf41Bvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA5PPFB9BA66B77.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 16:19:19 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0292.015; Tue, 4 Aug 2026
 16:19:19 +0000
Date: Tue, 4 Aug 2026 13:19:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Will Deacon <will@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Pranjal Shrivastava <praan@google.com>,
	Breno Leitao <leitao@debian.org>, Kyle McMartin <jkkm@meta.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/arm-smmu-v3: Shrink command/event/PRI queues in
 kdump kernel
Message-ID: <20260804161918.GG27883@nvidia.com>
References: <20260706084708.8072-1-kas@kernel.org>
 <amiBagGKn-Aym1DK@willie-the-truck>
 <amiz6GQZ-XGlH706@thinkstation>
 <anHxBh-xGW9JXsa4@willie-the-truck>
 <20260804141704.GB27883@nvidia.com>
 <anINkO1l9Kz8lTVh@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anINkO1l9Kz8lTVh@nvidia.com>
X-ClientProxiedBy: BN1PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:408:e1::31) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA5PPFB9BA66B77:EE_
X-MS-Office365-Filtering-Correlation-Id: 59dd5281-6b18-4f5f-1727-08def24422ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|11063799006|4143699003|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FlTN1x9HbmhD7FRXXkvWCE5pnhvll/eGiSB+tSPnwIvGjtIj68tx2ijL8W2+caM3nkBomOP3eQ4BqCh8UxAJTLvbxIlhudf9hcLZ98zRKPLE1HgU9B/7ZFO6OluL8+yka/hma9wI3CpLfOmFDdDfLIkJ2MxgR9jBPsk+iZpCSa+cBaaVI7PdNoP2U8K0bCZGZqqOFjgGYXuCZW6efVfnyBMu5QSSZPAV/3l+wkcK34AT1dECWZllrBMIjAY9GMDtaewSR1InY5A9PQmlbwdLfSRUk/4tzryTFroln8H4LnBpIdjNwGdSp0aRzWf/FmXsEXnXAlvier6eLziueX90br0yJ9KUpEgNOHlynp0A0OTvnM7VOmHOhJA5bBUmTdQ1SnGgsnHdJLMlzu7IHhh8+WPpeags3f2iE+E3xbj8rvNCnUULX5Uvh5clvWDhHTc+pMxTBxKV8E9DA/BMYl/MBD1OHmU5yHgZUOx6qbYhCibQpqIyw+OL4tiG2DFSxqz9bhLfhGQ2Dbx4CbboY81PfHs5dQE8+YDds/u4nK+NJRRURx5tLl72YdaUSY0ofQfMlQz9CwhEpDKtaWeEXx6gVJhlByfMF6n9Q1HVUCGqcnKA6pH6Es5rOSl27fGSxOQd68VftaG8X94IVn/L+burOj7MFDRTG8mvsqcAlcMb3W4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(11063799006)(4143699003)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tw9uos8as1A3bmmEJN/hwGnVgUpuT2jDPt8ilJYQT3/PoIXDC5NcxoTO+f8R?=
 =?us-ascii?Q?avVjeBKXE1ebDdEcbmclfGLBP/tN/nv68fO33YsxlkDvQinTzsTE3RDAN9t8?=
 =?us-ascii?Q?Y7Tpm35a1gNN3Fx8F+7En/2KUSpZGPnw2CHC2iCWNu8opzapf6oBUXCjkJko?=
 =?us-ascii?Q?ARya8EkLWNjof0lmN0iWPh7i3YTkMpliiXcqI0EIspuMJ0nxQJLk9QWk7t2v?=
 =?us-ascii?Q?VoMIDXSS8wMC8Qr6qSnxXqhTpLZ0f6+y/B44WjnNIhtyC+x5SACgYRcScJ+e?=
 =?us-ascii?Q?tfwstCbjlrbz+zteuOhUXusWpDIs8L5J2W/uHLe41SqAQvh2f5H3sEOjI7S4?=
 =?us-ascii?Q?aWxD02abGjR8S7lh/JEORvp5/CUOp8/ty9fevu6vb8CkryqOYjcP2QCG/ZqT?=
 =?us-ascii?Q?4yp0+yxEz5EMWs/I794E3Y0qYqy5iWY53gz5bm5fK5JwjWkQY0EtsaYtV0CH?=
 =?us-ascii?Q?JqwvJzsxDMFGEKPvbFhLtEnp5Va1WSk411L6EefIxWejxnKkzVh/f8vmeR/I?=
 =?us-ascii?Q?sSBZ0QPcKRf5ex1/yyCjH6cjeP/KofbZt0bcRbPe4cfxcxvoM8SSTD4l49xH?=
 =?us-ascii?Q?tn5pBCo9akrtvWwadPGv2jBABTmpJNPduVcEzw/HlSBz0P8X+KXQvvhOY31C?=
 =?us-ascii?Q?miXYezY9C8oB1x50M4t9Dx4UxZf4+D1IWnjl0DE9Ws8wlWMmhMFpFwqbaxq7?=
 =?us-ascii?Q?WKZx99ShGaXCO0ERrWj2S6j0MdGqh/sG6FdCU3WFXbn12cqnCDpCtUM246Xk?=
 =?us-ascii?Q?VLB5w6Lp79qXW/cTdnwMZQon+dd7bxLOO/38UPmuX6EeAgvnhPl10c5cr8Uh?=
 =?us-ascii?Q?P3dTEjFNQzr13FHy6dV9uajZbSm+4XDDTTHc8dx4ksnBsepCb3tP+qAMB2I3?=
 =?us-ascii?Q?z4BL0M/y2mNyAhuV/o/XWWhDE9moRcj30YkDDZaxLRtKRpI6Wr6jCsO188NT?=
 =?us-ascii?Q?pZiDMv4Jd2ZmUuQUNa4L23fQYaPfzRQQgLX4dRnyWWwr5c6/IMWSW4i9H13s?=
 =?us-ascii?Q?xl9Srz/FS9kCF1T+TpuoOHnQYdkg37xCzkG4TfcQneArw4OGlx9c16VQDJkF?=
 =?us-ascii?Q?esOMV/B/gh4P8N1ak3yq7EnQh4c7jTIwUprNoIBcUGM9hsRGCVQ+2F5GENvA?=
 =?us-ascii?Q?ciiT4ZNpAs8eKY5IGc2DAKkFsQcZcjRZt1fkaMqOCGcypjk2M/mrbGHO5XxE?=
 =?us-ascii?Q?pop4RbyDxpj7H9MNEmmw2Q90iR0QYF+m6TqhPUPBK4XIg9bsObuDRFfk5wHB?=
 =?us-ascii?Q?bqVOG35kZEgYQ4dfzSdBp57BgQhqKB8QNEFZljuIm6onNUYVntcPFcw747Vw?=
 =?us-ascii?Q?qs1o2jHcaYUqZEqImDzwxlPxg6g81QtT2WsEH2XrNNTnd3/9hcNACp1dP6Su?=
 =?us-ascii?Q?qKdaWCFW54yDA5h0AKgV+YZZimXXMVBucFfS4HQNIDBeg46JLSj18j0tE1K8?=
 =?us-ascii?Q?fCJ0iUXz6csUWmlJb2+LBB+RFuhx7FFyef0DN2QgBBr5Fo/bY8TFh9vRdIms?=
 =?us-ascii?Q?dL0UkDHShUYqLnB7FWqP7s+GJP8ptelJp/pd24o75yAeEakMyOhopIAh0Lgw?=
 =?us-ascii?Q?qm9yh39DTZlNdIrcTK+lAppDcMtOteF1g9IOT9KBjxjmOcnei0ogVJ6o/+PG?=
 =?us-ascii?Q?9tfJJP+84tLdCgCAX6sAT9ZzHJMtS8PcjP+V1pAAmHKZ5WN46EoYgUwVsc7g?=
 =?us-ascii?Q?XcFyRFJgu38pNQ+t8nKMF7cTINOnsymmiasbTUV/mHD338LMlxC/XF/tf1lG?=
 =?us-ascii?Q?5KDsKyQfag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dd5281-6b18-4f5f-1727-08def24422ed
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 16:19:19.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UE0tp6272eAhCVnKGCC2St30770E+vmHzm0pLt/IDgmOiNla5gligVnWs9YEyz29
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB9BA66B77

On Tue, Aug 04, 2026 at 09:04:32AM -0700, Nicolin Chen wrote:
> On Tue, Aug 04, 2026 at 11:17:04AM -0300, Jason Gunthorpe wrote:
> > On Tue, Aug 04, 2026 at 03:02:46PM +0100, Will Deacon wrote:
> > > > Would skipping their allocation when is_kdump_kernel() be acceptable on
> > > > its own, or would you rather see it done differently?
> > > 
> > > With Nicolin's patch, we can just avoid allocating the priq and the evtq
> > > entirely in the kdump case. We can then add a cmdline option to control
> > > the maximum size of the cmdq, which is useful regardless of kdump.
> > 
> > I would still prefer kdump do this re-sizing automatically, even if we
> > do add a commandline. It makes it easire to deploy than having to know
> > secret command lines :\
> > 
> > So functionally I still think this patch is fine, though yes it points
> > out more things in Nicolin's work too.
> 
> I will send a v10 of mine, to skip the EVTQ/PRIQ allocations.

I think Robin's point is to structure the v10 so you introduce a bunch
of tunables, including something like 0 size to disable a feature.

Then have kdump default those tunables to the right thing

Jason
