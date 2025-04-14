Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB62836BA
	for <iommu@lists.linux.dev>; Mon, 14 Apr 2025 11:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628823; cv=fail; b=X/eUsVGgsBxLqiayIzbAvpma9xxum0YKsJ5mOd+lZBP1onvHrDf1mvw9mtDOXC7YHJ5Xb5XdGMAocQznXVEGBlq+WiT0CBy9KoQwJRaKhpYcVsYlYHuM08tsX6d9girnsXytlP6MgEuQYneysmKcXfcYGFi4phz4wogfbrQhCik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628823; c=relaxed/simple;
	bh=U9fkisTtrrjmdZfA5ysML+AzkGIws/bd5Rr+irTv8Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uyUSTlyelHfIsqXZ7CqoWFdeoNzMxGz1YPDm2FM2ZOjLZBnoxULQuV+eemgjU2bdk6yMdw+19EiH0SLUGxnxo0SSnKCgmi8j+AdZXcR84WsGl5ONOnrTyG3wI/zeo3v8jrbH5gmxx5UElkYyGGV4qf1+R366NbhnlcucwwpL+lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=txj1Re4v; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="txj1Re4v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1BRUS0UMBGCM6ZKa+hdIYN0B00kwwuhFH4gGG3HFs0XUWoNn9k1O6OW2TAyrnWvOau/kKerTG6rbrUAdbb+Wlrl2DY1dngHs6/D9HxPRR49sXZJXCaiHBpWHDMF3B/oYDvZWQOZB6CBZ+egrLJ35jogup9GgrG0QVKQXmIjOxVP1ehTXdgWBOJtlXpWU7x9sEn+DH2PWU0RNgp5QbrJzS2oi0bVqVAlav3xXrjt0vQeJRf6k9+tvkcvdjfiO+jMaLN8VZym6UftT1n6N11rzSH3TlZ3F4U+/hMUPKTOm/5GP5CoGnge8aGkVA4LhLFa1jgqhN7heHEBIdHpDJ4FGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zgxiHs9xR5vvhSqx8e6oxDnFQByaO025APBcIKCYic=;
 b=aEcFTiOkbtWCNaULXi8EPsL2nsNroxcVdHGFF/9Hll4j9rW4QILxSqkNg42cMtFMoKL78tcwIxXcWJtzZOnQ/xCPZO9WfOgACgawyfcCniFWMWPsXTjv/U8URDyjs9LsnfIAJTt8xkjnTlMiQJ+gV49O/t3M4qcm4naWP6mWS4NGwLVX7HZd2G7xsSjDaHh2gYDnkpMHLo9yFo40IGXa8J98R0uHT1mrVwsjlA6lfS0ZQIDg6s6dBazTN721IwhinRx6J0Snj9SS1FdFP54EVZCV+cWkbDydAjzac/n8Za1vifJVHx90UhubOT7q8t2pu/Jyan6HhcweZ2HCHMsl+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zgxiHs9xR5vvhSqx8e6oxDnFQByaO025APBcIKCYic=;
 b=txj1Re4vnWy0tLjTiFD5tZ2zPwml+jeGA0U6dplLg1Q6pvn6IWT6LfEAV1XcGS9O8+MqbUVxXAfIRFajwC4tp+oxxLCZEkytd1CL4fzgbulSAN65OGioaiXMJu3JvIKJcUnrSyqSt3kOrsGWTJS3auhqppWY6FXl13nfFg7XZCfHsfkWQ5QNFac5g5KohCbAKT7W6bD6+m8SOFRQ47OIcx+KbW6x1r3hG2FwCyOEf8aIIDoFDe9KQuesPr06kn5FBbi+E6gOrS8Lx1KBx7RJdIVQBQYN961zUVvo6VRxN8JtnQt0xttlMt38GokgckR98c5x/PJ0j1vab4Ac5dgdIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 14 Apr
 2025 11:06:56 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%6]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 11:06:56 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bert Karwatzki <spasswolf@web.de>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] dma/mapping.c: dev_dbg support for dma_addressing_limited
Date: Mon, 14 Apr 2025 21:06:46 +1000
Message-ID: <20250414110647.3294017-1-balbirs@nvidia.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 46337563-9c90-4f21-502d-08dd7b447833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHJwY3NDOWthZTM5VUlXNWIyYTNhRVlWNWRLaW9lQjBLMTBEUDlIWU1MV1Rq?=
 =?utf-8?B?emx1TGU2N0ViNEpNUjZ0NDhldXR0UmV3N2pEYy9YTG40ZUN5QmsrODNJT0Jn?=
 =?utf-8?B?bUFUdE5mZXZlSUtJNUhOQm84K2Fuc1BOblNINUpSNFpVNFIwcHhacTdJZmdW?=
 =?utf-8?B?MmFsV2NOejU4aTdFZXRuTGNkUEZWQUZka1RScDVLN2ZnVXplUE1mdVdObXdG?=
 =?utf-8?B?TldVVGE0SW9OTERNeWYzRUlXZTlKbnRzV3VGT2RPUzdQcjk4YWpmbTBHcTNs?=
 =?utf-8?B?UUhqZ1hYeVpPL0JmSi9kaVN1bnB3N2NrNlN5bWNsaytXalpWYlJhSVI4aXN0?=
 =?utf-8?B?amJxQ0trdnh3RVd6SVZIa1FzZ09kR201RmVZMlpMZjNsVldLRG4zRU1FbXlG?=
 =?utf-8?B?M2MvVFRJbWxLdWp6R1Fqa0w5Q0Fqd0Jhdmxnem9RYkt2M2EyU0kvbU5wa09j?=
 =?utf-8?B?SUN2Q3ppZmxCSEttbWpaeU5nQndENVAxTStoQmEramVCM1NUL2pwWnFBbHdr?=
 =?utf-8?B?Nm9rY1Y2Y0NIOHE0c2ZkTGJ4UGZiNi9idUFabUVDTGFYRWcvMUZQcGcvYjRI?=
 =?utf-8?B?ZU15enRveXhBWGRnUTVvd0hEVlVYR3NJT3FYbjBxZVVwUjNlYXExKzYrMjlP?=
 =?utf-8?B?Q0gvNFlnbVNDaWJsbHdFR2ExcG5QbUpEeTNaZ3ZNaWwvdXM4RGFjZEJDeFcy?=
 =?utf-8?B?SUhjcVl2WVJJd3lucjV6U2c2UjNLa1BBTVMwTlhnajFDcHFBZ2FzQUJSenpK?=
 =?utf-8?B?YXZSQktoVnBEaHdiRHhES2o4OTVycVM4c2ZLY3hJZGpmNk5lZ214L3o3Q0kv?=
 =?utf-8?B?Z012cTBQL1lVd3VNYzFxODN6c0EzdEdmMVhGbjE3NjJoa2x0LzBpZVA5dmpX?=
 =?utf-8?B?cmJvUE81ZW84OWVaamhoSGlDWGwwUWQwRENYTkdwa0hmTEJvQ1BMSUJwckt3?=
 =?utf-8?B?b2crZEFLVndsTXRBd3YxaXk1aFlCN0FINXB2ZGovRmlpR3QwQnRSYkxTMUhn?=
 =?utf-8?B?UlJIK0grWmwvZStWWW1UMXlOdlJpY0s4c2JDb0ZES25jam01WWU4eDU3dnha?=
 =?utf-8?B?UXIrVEFhY0w1ejc3dnVWWVZWSjlJSkdEL3puWmNrTFZxbUVVSk4zNzlyWTdp?=
 =?utf-8?B?cWxWdVFRcGN0dDE0TGZCYlUrc01BRGUwRUVrcHFJNzl6U01wVW9nWnlKS2lG?=
 =?utf-8?B?MVJTVzBYcXowV3VvWXcrYUFTNXpVcjFLWDdHanl4R2JyazIzeHhQcXk1QWND?=
 =?utf-8?B?MHJnb3pjK0puT0RHZGNTc1dDYytRaFVUWW5oUm1kMjZueHNNUVNZY0VpNHk2?=
 =?utf-8?B?V2hvUSt3OGgvTSt3KzZyL2tPdnkxb1FiVW9ZUHMyUTFTYXNrQlBsVHVvaFJK?=
 =?utf-8?B?cFlPMEM1Nm8zY0VsNEMzQ0hsSERDekh2QXZHYTE0Yitqa2U1WXNCeCtoUnlw?=
 =?utf-8?B?S1JlVVBxZUVYcW9LUnU2eEtZMkRlSUVpSTFBTzJtTlp0UFNrM2tnL3NJUDJH?=
 =?utf-8?B?QlRkVEJEdUN2cEZab1FQdnQ3SUhBRVZpY2l1aTRRMzlqUzh4dTRweDFzV2ZY?=
 =?utf-8?B?emNDSE9oTFBFc0txelB1MkVuaW5jckpXNVNuSFdVRmFsOGkrUFo0L29wYlNI?=
 =?utf-8?B?QkQwNE5lWFRoZ2FBa0lBMERsWXVybmhGRVpwTWRoYjdTUWhVN1BPRzJUeUJK?=
 =?utf-8?B?a1JaUHFjbFRxUk1BZzFLNzRNZlZ0aGY4UDdrNk03ZG1ZU0Q2L2s1aTNKMjVE?=
 =?utf-8?B?SEp0TjNYMlNPSHdkcHVmeDZVT1VoOUNmSVc0cDREYjRiNmhRcXorc1hRQ3U4?=
 =?utf-8?B?a2FrNWVkQS9LQTVNeDVqN2UvUHNXRW54aXdVUlM5QzBMVnErY3pIWTgwR21F?=
 =?utf-8?B?R1BYMWtUV05FcGEwOXZkZ0VXaGFDRjZkZTlaZnFQZmJaZ1ZLRk4yendGL1k2?=
 =?utf-8?Q?EEISPcjCSME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUxSK1Zxa3pWbDJ6U3J6cHNtaXlia0laTVNvTDhrSmtkZDZMenJrb0RqNzZN?=
 =?utf-8?B?QXJJdUlhYzBNS3JyMlZ2ZzgwOGdjZ2NGNzZYakgwYWZGbHg4RGw2bFJWQldL?=
 =?utf-8?B?OG5tQjBLaW5ubjVQT0Vlb2ZpU2dnMzN0M05QU1NXdVhSL1VMTzVZaldSQTJj?=
 =?utf-8?B?OEdHWG9rMXpsYWpHejU0Uy9iSitES1VvWDJEdGV5akx5V2ZlQ25CVlNPU21y?=
 =?utf-8?B?U1NOMlM0TnhCbjdENkk3NzRtY01mUlp5eGRXV3NZOVBSbDNkM1BqUmtwdVRM?=
 =?utf-8?B?REdxL0FkbHl2QkpYSVluU1dzZUJ5T1V2ZStwUFlSSmVJMG9TeitjdjNJK2J2?=
 =?utf-8?B?OTNUS2k3WFZwWEsvS2VTSzloRklYUDBhbW1zKzBPdjB6OGNkZElkMzkyMThl?=
 =?utf-8?B?K2hhVDhuNWNUNkI4R1M2cVo4OGQySUxmRitsbHNweU9HbUQxanFTZk82QnFY?=
 =?utf-8?B?S3VpNFJERFJpc2loZWNhOURIUVAwazczNTRqNENyTk5CVXBYNWtPNC8rSWFC?=
 =?utf-8?B?VmZ4Z3JXQjRwTmhYQ2VVRGczdzRxTTc4eWFhSTBWcTU0dDg5blRxcWdmdlA3?=
 =?utf-8?B?OTVIbFFPeXJCL0ZoS3FZWkJYSWhYOTZ4bjY2U3Y4SEtzNXVmWEFCd2J3UzZi?=
 =?utf-8?B?cGhrVUZaWlhxaG5Da0tHeFVTcjRLbktaM28vOWJUSlFRVXRiMFhCbWdmYmZh?=
 =?utf-8?B?dGQyR3VWSzJEY2ZYVkFVWDZxOFhxbEZKTlkrM09HZmg5RW9aVmZGR0VYcmkv?=
 =?utf-8?B?a1p6bmtWbnNYdkpBNTJUUWZzZUMwZWRCZzdoMXhqdlp1K1F6QzRlR1hKYXow?=
 =?utf-8?B?U0lOSm9TQnlhalRoc25jd0hwWWhudjRkOGdqUmZkZFliZkZBUldEY01hdFJ5?=
 =?utf-8?B?NXdvckp2bW80bnIrVnMrN2E0a3BFeS8rd1hQVHJqS1V4TlMvR280TlNzQTRy?=
 =?utf-8?B?dFBwampNWEE0NC9hL2RwTVdNdnlaZ3pYU3pjWFVWcWorY0x0dXYzQ3FDTExU?=
 =?utf-8?B?Z1dBT0pla2JnTTBDMFgza3hwa05jb0E2V0RPaEp0eHJwY0NIVFhXNUptbVZY?=
 =?utf-8?B?QWtnMEhuUWcxR3JiczZVQUpLOWtRK1dpOFkzZXVDMzBzOW1lTDhxZmc5WGJD?=
 =?utf-8?B?Z0dtNGVINUdvcEFqejBGZ1Fwa1UwYWI3STNub253d1NzdHBRd3BqZGJnUFM0?=
 =?utf-8?B?V3o2d0w0TEtVQlYwYzNxYUk3MklkcVJnYXExYmdSTnQxMENTbDI0T3E4UkJ6?=
 =?utf-8?B?ZWhlTWtNNnB3cHpmc21MVzZ6Z2tNRU92cUZiOUROZGNUOGhxemo3aGJqTFow?=
 =?utf-8?B?OUZsaTI4ZlFkaHNDVWNZd1Q3TFVWWWIyTzN2eFN5RVhmU2U0NC9OYklEZVZQ?=
 =?utf-8?B?clpGSG9ZVmtud280Tmd3QXMyUHcybThZVmNkcVBGM3NWRyt5R1dsMWJyZHpx?=
 =?utf-8?B?aVdXKzVHU1NTMExuSE1XOWtDR29iem5IY1QwWjl1MmN5eDlkR2crZGsvZ1pD?=
 =?utf-8?B?V3NaREV3MktNK1VGTS8xdGZPdEhIR1B5ekpqa09GTVNwWERGZ3l1aElQOWNy?=
 =?utf-8?B?bjJJb3I2ZEJaMzF3TEFST2FrN1NBeklnUlYwU3dMc0lIWkdFMnlzRllnbmp6?=
 =?utf-8?B?aHpwNHdtYzRsNUlRYmF4d2pibkNsNThWVkRkWVp6TGZZbkpPN2oyU0NLUEFQ?=
 =?utf-8?B?NHJxLzFIdWFkTnFLQi9RVVRLUEgzMk9NN2xIVzl4MEF2NksvRlk5R09DWjV6?=
 =?utf-8?B?SG5qaXUrYVJCKzk5ODRDTm5zMlBJQmtwMW94TkE5RnVlOTBHbG1hY3dPQW9v?=
 =?utf-8?B?UWIrK1Vmc2FHano1SWR5YnpMTm9XdXo4alRFenV1b1cxUlVZSk5zM0NjUXJw?=
 =?utf-8?B?TUF5QXpRRTlKWlVxdU9Bc0VpbjlUcnFIVE9SVXFOcGZUUVloR3UxTDRsOWxa?=
 =?utf-8?B?U1pkdmh4TWJJdFNPWVJUMURnSk4xNnZDZklrSEVGcHlORm1NdEJtU3RRZVB2?=
 =?utf-8?B?TWxiTEVEK25LWmczTHFENHBJV0NvdWIrQnFxNFc0Sm9oSmJ2Q1dFcUV6bkwr?=
 =?utf-8?B?MjNvS3dFK1QxT2hETFFPOW8yc1FhRGxRdGhWZGpScnZ5TXlaLzg5eGpkT1Ji?=
 =?utf-8?Q?cX3y3Sw75UxyR1OQ9ueEZ8tTb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46337563-9c90-4f21-502d-08dd7b447833
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 11:06:56.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgoyADx32fAyQaSosgb2EJellwXUXlpdq0Hfj9hsMdzcwRz02y6y2Y9xFRB+eI1Dwc34Z2V4zV3umOGmCB5ixQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413

In the debug and resolution of an issue involving forced use of bounce
buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
private pages in add_pages(), to not increase max_pfn and trigger
dma_addressing_limited() bounce buffers"). It would have been easier
to debug the issue if dma_addressing_limited() had debug information
about the device not being able to address all of memory and thus forcing
all accesses through a bounce buffer. Please see[2]

Implement dev_dbg to debug the potential use of bounce buffers
when we hit the condition. When swiotlb is used,
dma_addressing_limited() is used to determine the size of maximum dma
buffer size in dma_direct_max_mapping_size(). The debug prints could be
triggered in that check as well (when enabled).

Link: https://lore.kernel.org/lkml/20250401000752.249348-1-balbirs@nvidia.com/ [1]
Link: https://lore.kernel.org/lkml/20250310112206.4168-1-spasswolf@web.de/ [2]

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>
Cc: Christoph Hellwig <hch@infradead.org>

Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---
Changelog v2:
- Convert WARN_ONCE to dev_dbg

Testing:
- Limited testing on a VM, could not trigger the debug message on the machine

 kernel/dma/mapping.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index cda127027e48..eea14302fa20 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -918,7 +918,7 @@ EXPORT_SYMBOL(dma_set_coherent_mask);
  * the system, else %false.  Lack of addressing bits is the prime reason for
  * bounce buffering, but might not be the only one.
  */
-bool dma_addressing_limited(struct device *dev)
+static bool __dma_addressing_limited(struct device *dev)
 {
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
@@ -930,6 +930,15 @@ bool dma_addressing_limited(struct device *dev)
 		return false;
 	return !dma_direct_all_ram_mapped(dev);
 }
+
+bool dma_addressing_limited(struct device *dev)
+{
+	if (!__dma_addressing_limited(dev))
+		return false;
+
+	dev_dbg(dev, "might have lower perf due to bounce buffering\n");
+	return true;
+}
 EXPORT_SYMBOL_GPL(dma_addressing_limited);
 
 size_t dma_max_mapping_size(struct device *dev)
-- 
2.49.0

