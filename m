Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7715C148
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507196; cv=fail; b=gEM67fan7Oa+SnG9AtqKPfWy8dqn5HxzygX95JBM80CaZ5aCCwJ7h7qhNX9Rcyr8uGdiGcF2/5nlb6VRMgd4WYO5vufMXLfVx8SwZQyKPLAbWZXn0AKIIh5/H1+/ujYkkr8CSOkdnRwJMgnFM6QXFJTvWihXWpmGufptzGYMX1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507196; c=relaxed/simple;
	bh=p5Xn6GTMlt948KLVxqs71DXSceiULpCiyDI7/NrUtn4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WVsPDg2iiDKWJYqfKTx3H1QqfM5GCXF08vwxioUcq+1/7HChY6KnGA7UOVl8jedZ182dORIYfTicKySeOhQ+YVLePbIB1QHOXQ5mRrScpgi2xVibNIccAMWyvZx9r2LujerI5yb2pfGmkKp1aXsj+V4xF2v7KvEFyNGd4z6qsew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5LI7bwtq; arc=fail smtp.client-ip=40.107.93.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5LI7bwtq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTKfrGJifoqSjagMKUcTbaJ02Ue3HwpJobuRbsLrhA46ExsM6Y3icw7bBhTnhVsLis5BO5bh2UI/AK1m0ejUUi1cJ8RRVtykq3tPUAlCvGPq+slO0sPOuL/4GLMT7fH9UYpJ7wXs59Qf+lhizEohV6xegjPw8nhq6UlhYqOTpWPKbKn0QLGnILdsxSyRi/v8L39ibvODuXaqxH3jtToxz9fT91sUJ4StEArnrhRoBiZRdNaGBt1iVnuZkwGj/H+z6JNfAouHjB9H2N+O/zOpx+RsR2AUDX4a7gAnmCBpYRiWMHiZLc/n4AxtQyfrDO4uDXTctH9NNRVOXZGI4q7o8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYjYOlNA3kf39eUBW97p0r+8uyho72eF3aa8/A9ibVw=;
 b=oTke8Tjoqib5JXDRpj2QxkojEL4u9uJyWBczSBuv5p5rbLHzEn/X4+MfS1PF4mEQf/WU41eXl6vfYMDBegCafL4vQ1+GJ8MakbxI6t5gYaGZ8Xy4lyxpgfccUl1vjWwt6YKjHWw5hJ2axcI/GRFK1gXuza8ng0mgcxuX6CQCbZyF+uCfkMFadfxYCyMVNKeYSu3CohkR+V/5sR1s8nML1TV3F5lFC8vdFJY77rNxjI2NPZJai7qZ3I9V23njRQ4c3dYdF/6h9UyRTBy0WK9E7FhWGhtDYU2zZWk/IdRtvpf33zjn4OPfbDr6rP+K/y3i/uWYU8AKqUJ/mUpcyRZWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYjYOlNA3kf39eUBW97p0r+8uyho72eF3aa8/A9ibVw=;
 b=5LI7bwtqKPiXFZTW06qF/cDZszVOVYR3GmHIUdzm1ZaituxJt+U6mdD+dfZAmPXHGHQgO+b0xDNvzmUfqnhP3XXP32BjFJKMfRk6koR3Ft+lewd5Qje/JDfyVSmHzM+rfIrtxD2XP20T2JKqYcGOXhtsZKjFo1MDdusXki+Zo20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB6556.namprd12.prod.outlook.com (2603:10b6:208:3a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Mon, 16 Sep
 2024 17:19:52 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%5]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 17:19:52 +0000
Message-ID: <6fc21210-53ba-4b76-82b1-833a4eaf6614@amd.com>
Date: Tue, 17 Sep 2024 00:19:43 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] iommu/amd: Disable AMD IOMMU if CMPXCHG16B feature
 is not supported
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
 <20240906121308.5013-2-suravee.suthikulpanit@amd.com>
 <20240906163818.GK1358970@nvidia.com> <20240909151641.GC105117@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240909151641.GC105117@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA1PR12MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: ace6adf7-6921-4b16-c36c-08dcd673c66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkVpeTFXaHVpQ0V2S1lWU3BaaXpMV1l4elZrQWF3c3ZWTnJBTXNzMEZkRm1S?=
 =?utf-8?B?N002QnhLcnRJNHJ3Y0FmbDJkSFcrMS9OMVJNaXF5RENXV0poME1YOG5VU2pO?=
 =?utf-8?B?a0YvOE1oNFpnYzJjWGdSZy92RTlwQ1lwT1JDaXl3Vm1YV1pBWWFad0xkN3VQ?=
 =?utf-8?B?WllQRGV0SHZPYVB3UE1nY0p4Q3VNNU8vc2ZBTVNReWk3bHA5cWttU3BKU2pz?=
 =?utf-8?B?ZXN6L0VRQmg3eXdqWHJIYVdGL1BDdFJCWlBNNkdSMW9kQ2lNNjBkMjBJQit1?=
 =?utf-8?B?WmhlYnh3am9nVVcvVmFkNkNjUzJaYTZvTEdIOHptMFlDdnpKRU1hYXo0WVNw?=
 =?utf-8?B?aVh3QWNhT1Q1RWRUc2N0cmFXQ1RzNDVpRUtnTm00K0xPai96bWNFcWN0Q01o?=
 =?utf-8?B?RHJiTVJoMG8wNVlvT3dPYVN4UDB6bHRNMEFEWHZad1BsdlJQdEZyYmt2SE9y?=
 =?utf-8?B?RHRGdXZvZ3V4SkxtUzV6OWhJMGRwUXZvT29KRzh4eUo5dXRRSmU5MDJRakhT?=
 =?utf-8?B?d2VQTk40bzJjaUNiRUtUL25iR3hiLzhjZDlrbWYvV0JVS1g2YWpSNUx2QkJv?=
 =?utf-8?B?aHNMaWl6akhSNzhTODd4OXdsVFA5UUdyQ3NmbDEwVGwvdktiR3JLeXhOTkxO?=
 =?utf-8?B?d0NMYmZlY2ZrNWJ0a0U5dHJpOU5XeWkvbmRKVU1pNEdXcVZ6SHpTSXBGN2NN?=
 =?utf-8?B?bzh1QWFjcko1YnEzN1Y1SG1iVm9qODVhMVJrV1ZuL3Jpd0RqRXI4aTkyMGZO?=
 =?utf-8?B?dEhmKzE3RHVNeUJPMGxKQU1xWmluN1BzU3cveXZsR2hCeWc2SEtyL1lNMDhq?=
 =?utf-8?B?cTFQVHdvZDJBYW5CUmRCNlhqcDE1dHUxMTdhT0xsRy9iNHNMa2dmNTRzZmhk?=
 =?utf-8?B?NmtDem1oVkNhb0VwRFJreCtqR1NqaW1Mc3hTbmpxMC9JcGRLM0FpbDdEMmJG?=
 =?utf-8?B?MG9XajR0QXNPemt2N3R0eXlpRzdJam1IU2UrTGVYUktsclUwbnNXN0E5aFZj?=
 =?utf-8?B?MG8zejBUS3kxa1dpYnhYTmFvN1hjMHBEaEtTa0hCYmtMZnpWNisyOWNzcDBS?=
 =?utf-8?B?dEIwNDlMb2c1RWJjaTJzMHptb2FsZFhLeUVrMFE2YWlUQVhSZy9RODNJNkNx?=
 =?utf-8?B?SEhONVVpVE52ejRMaGRHWFdPa3U1U0RWN3dnMVN6aUdJN05iU1pQQUYxUFJN?=
 =?utf-8?B?UEF0a1BMYVp6QUE4M01mekNDN01aOEEzb1ZvY0xjTWRqTDdnTWVGa0ZDSElk?=
 =?utf-8?B?Rk1MVVkvcHNWRGVMSlcvN25sbkhKZlQrZGNQWWpDU25LUkVrcFVqSzlXMUl2?=
 =?utf-8?B?blJ6RERheWVyNStnUGFLUHNJU2pteG1YTlFKY1c1bkxpT0FKVkt5M1R2WXNF?=
 =?utf-8?B?WkxDZGZKbE5DTGJVMnMwWVRmNkkzUkF1ODZuQ3VCaktTSFU0YU4yTUVBUnN4?=
 =?utf-8?B?Nk9rYkQxb3dVVjdNeUFrYUJyS0VoRTFLRE16K1o1M1puaHBLVkZDN1UvNk9m?=
 =?utf-8?B?VkxTRXMxbk90ZE51dFBOSjdJMjFjOEpJa0crWEdVYmtGSFhEVWM0Tnd6djMw?=
 =?utf-8?B?Q0trUEZ2MmVxWENCd3VUSS9yYUtnY3pjMzlLWVZpYmlSS2VIcFhnSWJmak14?=
 =?utf-8?B?SXZOWnNOUG90OVNoSWoyemdvMk1Rc3BldmNpSS8xZkRJdnRDSEx2L05COHFx?=
 =?utf-8?B?RW56eEhveFVETFV6NXBtNWpHVTh2WFlCck9FbDVUZk1XTnNUdDZMOGFLSGs1?=
 =?utf-8?B?VW0xRGJsQmhldG52blpuZnFqVGdUYnJwRkhrYXhaVGdtWFlGV25tM3plKzB6?=
 =?utf-8?B?SEp3cG9ybWtUSHU3M296QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czYwcGFhSWJPNmxRYUVlVFVXcUhUTXFmckFZQjZ4RWZ5RGh6YXhIeUJPTUxN?=
 =?utf-8?B?eER2Zk1QRWxqbTlTc3RhK3FpTHJ1T0dzaE9nUkNuNW02OTJrRjdBRTdtQW5K?=
 =?utf-8?B?TGRDektCL3hxVlZTazF4QldYYkRNUjlMd1lSSE1HcU0xVjVHNDd4NlNTeHE3?=
 =?utf-8?B?MkVIY3FzdmdtUDhBYVVKcm5NUE12eFM2TFRXQ21BQlYwM3puOTJ2Mk5xb3dy?=
 =?utf-8?B?NytVeVFLam9PU2c2VGw3VDVxY1lxUGNYSmVsd0Z5UncrRXdORWdaZWkzQ0NI?=
 =?utf-8?B?Tk1tMnp6RmsrV3FvS2duTHhicEJtL2FCb2tVeFVkVy9CNUJpUXEzS2dNdjZi?=
 =?utf-8?B?dFhlc2ZVVWlHeVVqUWRIdlNrK0I1dDVNT3kzTFVLL1pTNVJaSEsrc2M0Z1di?=
 =?utf-8?B?bFNHRGhRZHpicEd6OXMxSmVpeCtSWjJRME9JOXkvZHJtaWw0d2x0Mk5vRXBi?=
 =?utf-8?B?d2FKemR2Z2hOT0o5ckFFVHllMDVvdTc4UEh6Qjg0SlBpb3c0ZGxrWHJVamln?=
 =?utf-8?B?SHVzSUMzeEJMOURGSnlIc2ExVWNueGl2djg3V2RFbmw2M1M5dGRpYnQrZGFl?=
 =?utf-8?B?ejllZGdSRVpFa0JzVDBnSkJ3WTVJQ3JRYlhjMXpZQk15czBJMkZ1MWNEcXUy?=
 =?utf-8?B?RUhxS1Z4dTdNZDFTbldOV0hZNFdvQzJETnZDQ0JZSHc5VTNzZGs4QjF0QzZn?=
 =?utf-8?B?Uk5IbFVhYk9VWnNSZDZTei92Y05GWS9zeWpKQjZZTUNyUjBrUDd6TGNoeGNZ?=
 =?utf-8?B?QWlTbm9yV3dzZFcrODlYNFN1Y21rM1NXVHNWbkhUNkNxT0crN21ac1piUnh5?=
 =?utf-8?B?aFpNNHpraXJLZ1RvS2lhWEl4eWhMZGFYbnZYaHM0RzdiMkNQRnoxdG02NlUy?=
 =?utf-8?B?VTN4YXpOT0V3SjUyNjJZdUNHQjgvZW1VZVQwL3grdWVzMjFlL1NDeXVUUzVY?=
 =?utf-8?B?YTFDTDlPd3huNHNSdHU5RFdsdTZoTEpsMkdWUURrZnNUd09nTm5jVWlZQ0tn?=
 =?utf-8?B?ZjN0NnhPOXR0ZnlOUmJzVnROd3BYQ1JIV3YxdVViZEZkeEFSZCtOY1VYdDMr?=
 =?utf-8?B?VHlQVncyY3pTNkdUWXlaTmNHMHhTbTNrSzFXTmFsWTF2WTlLVXI4NXVacG1M?=
 =?utf-8?B?ZVh3M1NyNHVxemNKUHZNY2pkNTlpREx5R3RpUDRzMkVuc2lIU2ZsbWRpNE9G?=
 =?utf-8?B?a2hYcUwvVk15VFdCNUs3NzFlNHpXeVpraklLS0xTQjZCYVZ6MGNyMmM2SHF0?=
 =?utf-8?B?ZXV3QWNac0pEZ0pjNWJlcisvTFFFa1I2MnMvYlgzc3Z5RWU1eG5jSy82T1Rs?=
 =?utf-8?B?RUdWUjY3ZVBHWXVyTGIvbWl3aTN1YWJ2ODFEeWt5MnRBTnhXRkUwaHZWbW9m?=
 =?utf-8?B?NTRSMlNnakh5QmlNa3VNMDRZMzAxbklOdEFmWXVFMjEyRnV6NTY3MkZadHN3?=
 =?utf-8?B?VEVuR2pScFJYVGhyb1FxM2RQekxZdHN1QnRzL3lNeHBDZjVWNjBXdFBUMExT?=
 =?utf-8?B?ZXRlZ3kySTVEQ2ZtMGR0elNZdGJUakNWeTVyVUtLTlpXNDgrWlVLWjJJNSti?=
 =?utf-8?B?YjZnSXRINFQxRUtVcHdlemxrR3g0a1AvSGRVenF2TjJkanNUcGQrRzcrSFVa?=
 =?utf-8?B?REpMYVB2bEtpVVFHdGFMOWRiMUg4OFpXRzBSeWhTLzJRbWUzb2RvTmJPVGFJ?=
 =?utf-8?B?RXlIV1RMbXAwMXhvODJ0VWpscmh6d0xVR0U1QklLcFpBRENuZWZIUTFIQlZs?=
 =?utf-8?B?SExwcGxPR1ZGZ3ZnN3FaZGdKeFZGbUw5SXY4MEV2angyWXNKcEozOExocldR?=
 =?utf-8?B?a0dqdy9MNnEwS0hpdTJ0dmo1Y0pCWXRWMlhZUEZ6Q0kxbnVlSWMvTE5Xd0tX?=
 =?utf-8?B?U050Sm50djBwQ2JMSFB0WVVGaVFtWk5hVmt1SG1PTjlkN3BVRnZrWjMxc3dx?=
 =?utf-8?B?QW9VQjYwZUJsbll5b2VQRittYXZZSE9zWXMrWnVRbXhxeWQ2WStKdkQwamIx?=
 =?utf-8?B?ellNNkI0TlFPZnNGK1I2Q3lCazJPR1dxZXNxNFBuQ1JOOWNaeXlLVW9RdjhD?=
 =?utf-8?B?OWdwa2N4UVU1aUlvK0ltMk5rUE1aQlljVzlibVRQdlQ4d1FWaGhwZU92Qkhx?=
 =?utf-8?Q?WNyGuxL9PMXk/w6bBYseVvtfG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace6adf7-6921-4b16-c36c-08dcd673c66e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 17:19:52.1764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JBjjFWVgkyLqDNU7F6Gox1zKyDNsMOTkEwV4RlpnIw1oGBUD9hiKFAUNh/JwJ50PeriZ3VPEba+ZXyDj5LJElA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6556



On 9/9/2024 10:16 PM, Jason Gunthorpe wrote:
> On Fri, Sep 06, 2024 at 01:38:18PM -0300, Jason Gunthorpe wrote:
>> On Fri, Sep 06, 2024 at 12:13:04PM +0000, Suravee Suthikulpanit wrote:
>>> According to the AMD IOMMU spec, the IOMMU reads the entire DTE either
>>> in two 128-bit transactions or a single 256-bit transaction.
>>
>> .. if two 128-bit transaction on the read side is possible then you
>> need flushing! :(
>>
>> For instance this:
>>
>>    IOMMU         CPU
>> Read [0]
>>                Write [0]
>>                Write [1]
>> Read [1]
>>
>> Will result in the iommu seeing torn incorrect data - the Guest paging
>> mode may not match the page table pointer, or the VIOMMU data may
>> become mismatched to the host translation.
>>
>> Avoiding flushing is only possible if the full 256 bits are read
>> atomically.
> 
> Also, please think about what qemu does when paravirtualizing
> this. qemu will read the DTE entry using the CPU.
> 
> For your above remark it should be reading using two 128 bit loads.
> 
> However, it doesn't seem to be doing that:
> 
> static bool amdvi_get_dte(AMDVIState *s, int devid, uint64_t *entry)
> {
>      uint32_t offset = devid * AMDVI_DEVTAB_ENTRY_SIZE;
> 
>      if (dma_memory_read(&address_space_memory, s->devtab + offset, entry,
>                          AMDVI_DEVTAB_ENTRY_SIZE, MEMTXATTRS_UNSPECIFIED)) {
> 
> 
> The dma_memory_read eventually boils down to memcpy()
> 
> So qemu looks wrong to me.
> 
> Jason

Thanks for pointing out. Let me check QEMU and see how to update the code.

Thanks,
Suravee
