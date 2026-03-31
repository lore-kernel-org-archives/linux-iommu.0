Received: from OS6P279CU014.outbound.protection.outlook.com (mail-norwayeastazon11020111.outbound.protection.outlook.com [52.101.178.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3C73E3DB6
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.178.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961326; cv=fail; b=mF9Iw9HrsxNoIKGhBJMqrx+pwM9QYjrTfkzAkOtAMKXTlZXNdTmFuTn9SZ15Qj4GbdpitNlMY/so2+Js6IYDsKU3X0QJGDDfMIiqBtGekw84pJdaqItLUBLFyFwhEK7gFXuq6LwOWIZtWkYszugW8dRhZnre4v3ZWpjgubGM8xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961326; c=relaxed/simple;
	bh=6WPKWSLcXsuGF2Liy6MWagotezQ8YtOM4xU+KYJ3r9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UIMUtudDJsAc7h5anHi2Syyhm8Pa2Ccaxh7S3jHlz9jTDQRSWMI0a7T9nXDfkf6+87VA01KIxmwjkhiEYUKN9j5w2diqWCO38AqX9bZKlvmUfOxZxTSBGfy524P1RRfCaeYO8JrlWQRFg8G1+3bsiyT07IZqzwH9ePMLQwFwg4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com; spf=pass smtp.mailfrom=dolphinics.com; dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b=osa/40GK; arc=fail smtp.client-ip=52.101.178.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolphinics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolphinics.com header.i=@dolphinics.com header.b="osa/40GK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf+Y1WaWn7UBd2JFWkgsJlD85xGvt4gqbe+N6poiWkJjXeUAphljgoTT7xpoo6lTyJRuPnmQr+haYdNlt4fn3sq6gRJqcDVYb6uo8Q61szFhHhHy+iTAxBjX3MHC3ucbYyV1GVqdstjbQQdhkftqZqD92YjJV1Gt32taXdSgAcfMN4yPpBq/o/nf4OSuodFjFpeDNyI9C/ElmvMyNXMKfrJFaEtXvafKMLnTwiILY7Dgxx1jQz11juEnksYamb+/oP2KUd/+K4CDvSA0FA5+Ho8o/l69U9HtSNkaO7Gwt0xKtQ2w0qIlmcWWM7E+uTALfovPCl+Gge+R5RSnmPSMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwV+lUFBLxFuQA1quFxKXVlS7xnLgqzI+ZFtSBhAe0w=;
 b=JtpHmKo3wPm9AoTuJ/siZhi7I2dIExkSvsZ36AE3g1V21xM7vQbh8hDI9NfvC6Nq2S0hV1SQ1Chmx4a9vJAwJy4nyjumqQOktqjs51X9fg6k7OJMD78yWIQ/iHVgqL5Up8J9r73r9R6BfH0z+X5/iHOSO7unZUOkeK5lvffyX9o+L7zWZVEdVT9xng/VTQSN1g91zqQFjVPagyS9oDXnPEfiQqYk4diDPwTDMTHHVYOvu3SkKVsimSxbUcnz0raVzUmTvGEfdX3yi3+OCdnnfo03YMRV5du2nYi7FWF7QVOmKBu1f9ZFMVSyYIJonRvHNuWTME5Wa2/Z6SPKDA9+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dolphinics.com; dmarc=pass action=none
 header.from=dolphinics.com; dkim=pass header.d=dolphinics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolphinics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwV+lUFBLxFuQA1quFxKXVlS7xnLgqzI+ZFtSBhAe0w=;
 b=osa/40GKYZfn9ao+TsRc4OH7czlPC0KFE7RwCrzJ79KN0JQS8U0/1dHqhlO+X48Yy11QwQ2huHwdzSPHeePn9ohFWfDEC0Pqre+7YU9AURlC+Wg/17yhgxXpJdeZ4b1TUACc+/QAc8D6lyeb8A3Cl95CG6O9KukfyLtmtm2ia0R+cf8uOb9pUnLcQopw1QyQBK2zi65LJQOD2wtncmuHuGCof23R9n/eq3bTYnfdb3Gft3i9lv6cKxNTPfxa+C+wviGMUwWM+QfpO6otSIQxRwswpREeSQOCcJXeLjNOG2zQlkcDmgOyyEjXlMyi15/n3o715VLAXH16iaEjrjUzZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dolphinics.com;
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:2::7) by
 OS6P279MB0787.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:45::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.28; Tue, 31 Mar 2026 12:48:38 +0000
Received: from OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875]) by OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 ([fe80::c82b:8ba6:653a:2875%3]) with mapi id 15.20.9745.028; Tue, 31 Mar 2026
 12:48:38 +0000
From: Magnus Kalland <magnus@dolphinics.com>
To: vasant.hegde@amd.com
Cc: dhsrivas@amd.com,
	iommu@lists.linux.dev,
	jonas@dolphinics.com,
	joro@8bytes.org,
	larsk@dolphinics.com,
	linux-kernel@vger.kernel.org,
	magnus@dolphinics.com,
	suravee.suthikulpanit@amd.com,
	torel@simula.no
Subject: Re: [PATCH v3 3/3] iommu/amd: Invalidate IRT cache for DMA aliases
Date: Tue, 31 Mar 2026 14:48:03 +0200
Message-ID: <20260331124830.53189-1-magnus@dolphinics.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2f486ae6-d22b-4a30-b93c-f019feb8043c@amd.com>
References: <2f486ae6-d22b-4a30-b93c-f019feb8043c@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OS6P279CA0083.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3e::12) To OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:2::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OLAP279MB0055:EE_|OS6P279MB0787:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f3052b-5a74-422b-86f1-08de8f23d47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fjGoNA8hgucWMurQjMCN09bIOl7/A4DRneoMD8qNSXdkId6o0RdohCHbFFk0AkxONMn2M6d5/Pftf3OZ8QqBaoS9Ex14bXAz9hwF3NQE5p9SPqUpx/TD+W3Ux6wQJyHPz2KqmaMFy9otToVzTWFSlXeQaSM/FEEh6dr79ztLlRcyjBP89a5awbOi5b/NkWAjDtZ16VRhWt0hbID330kTk7Ofg7z7EW5T2wdGPewOpicMSsgrhEr1hxgrbSgu0TYzypyDq887fbP838BWU9HONs0bAxw5Lp440L06zeLhciLQj5m7rat1J2qoPVBu20156CyHO8loXgXrjBAce2vx3LTYsFGlBdKUAQQXKY0zvQw2+313lDNQhIxzY+MqPkzWppBqc7aP63PE4FAsd+xsyK9zDnG0IOI9ph6CXAJcEh7Q40HUQxG6kVA15VtViNTV1XO/V+vY4CLNUABkal1cgNdhJiaEk+3Q+wuUY2syvdEYbxP20zmL7z2tC1kWzztsNKPfE8j6Q9tvmNk3oa2eTFsGQCKV/GL/YL9/wV2hE0MMn+963+hox6U+TtwXGW2h98PD+GKWtbrsMefJ9+gq7CyxJsiiwEMsg1iyaVDKJhokn8/qIVwjiPo/37sqDBUgnAlBcrn8Twr0/IbqMbpxUAuXaodhav38UyipszrSnwef0iflBh/2QOwwH1KFgQ2S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OLAP279MB0055.NORP279.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IoD/AeCk9NQUlVU7Avj8RhjMoEdIln/EpbC6wLInA9yiFf/0qC3LEfn/Wtue?=
 =?us-ascii?Q?/pXTQLqfOPuQHNoCKGA1TSK1bIjU9BGK0NWVXVKIjWdpu+sCzjvH54kkwCM7?=
 =?us-ascii?Q?FukJChFBjlWhBimDtbURX30B6PvIoIljKPpvAS9Piw3SIQmTt/5Wx6zyo9Pf?=
 =?us-ascii?Q?Ufm4ovGhuUoaAHDP97uaEGD7fmTNpbBNkklQ8uGLeS2xl+44DC3p4irp+K4h?=
 =?us-ascii?Q?GPj7SypmjsJHQ7EVDVddqV9ibVGzPFDeCy/NKXK4bEP5Q+mGsresBfZNBkG3?=
 =?us-ascii?Q?cP6/PbmNKhkZ0vQUuPllVDImAkelv9bC1EBUNvhEhlqap5BiJC0pwX8okqUC?=
 =?us-ascii?Q?5Azo9v5Pb7LlqqcWhoDLHwSYxCPzF6rhry1flxH8k/hNYJmn2rnX4Xi805RC?=
 =?us-ascii?Q?raCdd3py0WmKu0LsFxzSyq7FntvggdcXTQmWkTqzFD/1ZIc+3ectMcwoiNG3?=
 =?us-ascii?Q?w8yDM3YP6bAtkkBfR8hTPGVu/yF3eTu3YNbpmGcKOXZgm1gSrWK3DhZwi1YH?=
 =?us-ascii?Q?OWOUb5fqMeN7wzge6p5msl2F9qMoWPR1w4UL8wY9qUaQmxRMR+iStdhxFdz2?=
 =?us-ascii?Q?RFKJQ/XQ561QzHo+vyp5ShfzYKyjBx3aVxScMM0vj1DezefLX8pxY8VSdg2J?=
 =?us-ascii?Q?a9QY69me0+eZI1ZPcYKEAph+S0iIMv3ozOgdIouGbCXO7b/SoOEC5bRy+MY5?=
 =?us-ascii?Q?BCG1QX35QUfrI75kKBwRAoBCfvborFSdwt1ajXhmTxhSAY0D6ba0CrUxCwWn?=
 =?us-ascii?Q?6d4Vhh0v74XN09ijAUqqUCKEOIHDI9IGw1KW6GxXhvhfT+ZkL5rP5AI826o/?=
 =?us-ascii?Q?6nW7g3Tr7jYtHM567NEEY3K4fos+CJ7VYRtbZHrZQZB7yrBq6JepXd2zlyry?=
 =?us-ascii?Q?yF0/58rjxnA3jR410giDPSj4Mm5lXBpQFcObyUepzhlJg868DMGaGVevrf4M?=
 =?us-ascii?Q?8Zu/LIDIZeIoyQtuXuxSGnr+8vKw6kVTILGUNkWDQ89eWFOhjxvnGNd1GVNF?=
 =?us-ascii?Q?OE0taqPwjy3tm7KK9SO1D+tke3wyqx8C7/fTNyiCwlMgX4GJ8oQFmatZghAi?=
 =?us-ascii?Q?bN2JM0r5Jaa08ijU063juFO7iwtbANRCNSWSa3C/ArgfavgHthub4rE3tQq7?=
 =?us-ascii?Q?EWJ+T1zWycFjfD58P8/DeiL2R965KPE4/U676FWgz/pwPID0pS/e7ueh2X7C?=
 =?us-ascii?Q?g1shktMwcnsZ2ukYWjaaK6MSJMuSGpxmH1+II0ivwWNvH+pvX+sST7aBxRtZ?=
 =?us-ascii?Q?Dboq1vhPE7QVC6OhBjRPEt3N6HQFkjyoUbviYgjuReIh0QF9mK5qoeJyIcjG?=
 =?us-ascii?Q?VF9k4ddnLnNic0rtIBZKwuYCyblBbl4Nhsvmgvj2VUqJptBgF3vZxgx4sN06?=
 =?us-ascii?Q?1nlzW9bQ6Vh+rOH1yRuzxUvc3Jb/g4LEaLbiLwm1E38oDEQPFo9H6pJ2DsSx?=
 =?us-ascii?Q?xC4rYQdnUkP+HGBFxDP5ONvmakqkA/5dK9urAUDySqVxV4Z889m47h8nUnz6?=
 =?us-ascii?Q?j+P8/TkQWC3bIgrDhjVLjYG9hsb89/HJpyeE98NDOaLRRVxHSWBCaF19HXLN?=
 =?us-ascii?Q?0vku3xrsDuhzOo1hUfcFkuPuR5g03YixyD74d28jIOWlUGMVSyk1UmAyHO92?=
 =?us-ascii?Q?ISUVXRm0KwRVjR7mje9ci21uWP0cTVEo0RDOnB1Jw02RvfmCgIhiOWTnip9X?=
 =?us-ascii?Q?ECQaNyy2WSYkas7Yk/bd+aN0/CqgDiwuQpHsIAWkrqSOGWd5eluDEl+0GRdt?=
 =?us-ascii?Q?4QZ3++95pw=3D=3D?=
X-OriginatorOrg: dolphinics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f3052b-5a74-422b-86f1-08de8f23d47d
X-MS-Exchange-CrossTenant-AuthSource: OLAP279MB0055.NORP279.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:48:38.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7fb89e52-625c-45cc-a50c-adf3af1b0a6c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJOC1u2fioS3XYqXrwQQG6GreEdkrT5Rcp7Op9q8+m1bY5zDiqkC+HjItQUyo9l6HFtmSXBoid9d4YAOaRGqqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS6P279MB0787

Hi Vasant, and thank you for the review.

On Mon, Mar 30, 2026 at 04:48:23PM +0530, Vasant Hegde wrote:
> There is a possible deadlock. Actually we can remove lock here?


> path 1) alloc_irq_table() -> holds iommu_table_lock [A] -> iommu->lock [B]
> path 2) iommu_flush_irt_and_complete -> holds iommu->lock [B] ->
> iommu_table_lock [A]

You are correct, there is a possible deadlock. We can avoid it by grabbing
iommu_table_lock, creating a local copy of the aliases, releasing it, then
flushing the aliases. This way, there is no nested locking in
iommu_flush_irt_and_complete.

We notice that the alias table is read in other paths without holding
iommu_table_lock (amd_iommu_change_top, setup_aliases). If we can do the same,
then that is of course another way to avoid the deadlock. What do you think?

> > +
> > +	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
> > +		if (pci_seg->alias_table[devid] != alias)

> This is heavy hammer. Why not use pci_for_each_dma_alias() like we do in DTE
> flush path?

Agree this is heavy.

We cannot use pci_for_each_dma_alias. See the reply to our v1:
https://lore.kernel.org/linux-iommu/26cfa307-6c33-41f9-a7a0-fbf202b38a00@amd.com/

However, we have a v4 ready doing 256 loop iterations instead, since aliases
are always on the same bus. I think that's a better approach.
What do you think?

Thanks,
Magnus

Signed-off-by: Magnus Kalland <magnus@dolphinics.com>
