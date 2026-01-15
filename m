Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7DC18DB01
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768483700; cv=fail; b=rrMh8zBOHc9BnMztbR1VaJJQcoZ3HRwemyV0XHeTiFYbJy5DrTpiuD071mTlzYjxP69PQPIRae9ohFWBQV+Bh1EK3A0YSbdjpbZNSl93i5Vx/kgdh2oPdYc0T1d7jI8K61Yp2yuR/8uoIhw3qQxBg5QxIIieecSTcqLIxRTfQ4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768483700; c=relaxed/simple;
	bh=y9gynCJQYCyrz+EGeC3aSSLALKqvZHvZ4DYPN4+VqM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pujrazl/loUMfqhxHkgg8VFoCF1opmYGqsCge0wx2HD9I0yueF2TTGAPm6XAVTysa1hdsVtx4zgRTM2wWT4xKcVd0+5YvQHLDt7yWEszhYWA05163NqK0UvizrSJoiyOOfZAG8kZdlyTn+PNpxaPzPChg517ESrXuZbNwm04gKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p7lXnU5z; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p7lXnU5z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZQXsv6v3YUNHdwNfbEicSZO7m71anaXAL0QDRzR9gWPScsusDcxh4VE4e0q4WHUBsQKVDZ8naFhBvcOp9RSgsdJwauOki5nj9Q1c11q0tOLUQxH5F7/iR20YDR1ShJ7oZWn7ohGUHkx4IFE2KghEwuDJxGhHdwLJ0aLrXR/Lk1nHJobQ9lOIcuiKoLTpo29R7DlrM3moi996ew7h3RHRq7f6MoGWfUFxhTL82cXdhhpVSR4+Sm1AsMqBk+COyOQLHLIdZ6Zc21O+ye/A5lIHdnxWekQSErstS4hYK3Q+qJWFlIUkTHa5AqP7k+OKy/ASfw8TUgOZw56vgZhves3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9gynCJQYCyrz+EGeC3aSSLALKqvZHvZ4DYPN4+VqM8=;
 b=FhMzfXs2XsoU9rIVKOSZEW50pvm0CiutmwluqavcqQe1phVUQPBaSGkVxLquOncoxSXtNe7ndkKowRCC3BtUcnFbeIm4KrmgzQX3K3n/93+TbP2EN0kUKC2VfGSIY5UQfFGswQfUhWGCQGUHxedEzSIXlK3ljCWtQC37VHok4oqcvLkzGnpZlkx0ovkiU/uwRLAB27XLVEuhtjTdyNhqiawb45tRgkpLdvRPOColUVhUlDDMxoFNRMRWNxyMShKNffhhjZxL15s9wD/x51nbTnlW2JoeKbALNXXXzVuOT9YTnXaVdxdhyCjoN2RRugGkcmWMUtc6tM51Xg7+nfRy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9gynCJQYCyrz+EGeC3aSSLALKqvZHvZ4DYPN4+VqM8=;
 b=p7lXnU5zsaw6KHAcU/OJr/tZHW+IBQPIZRnkE6k/TlEt9N8Nsg8IgO0Y8Uf0TaE/PyAsMZ8w5NrCWOzvdGlytWHUoZVIb8ysEWq3drVTVkn5QoLGXEckbxUxcfbiAhIrED8OFx28JCN63RgQOimAt2gL3LRnI6oMvhBejWhgKDogeMYwd2kDWM9e+N/cpu+bkBOcENUTe/uP5PYBSPeGc7ZPWdBqjWAeypbKyChM/WVkLGyUQZGxT/Q9hZH5pEjvD5mSSL++vcCHBFC8oiY5OtSBo9CcODmtHBmWnm5+VXSrXg3IKHlLFRP+87gcsV7aNp5yqNLbdg7/NIbfvdg0xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 13:28:15 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%6]) with mapi id 15.20.9499.005; Thu, 15 Jan 2026
 13:28:15 +0000
Date: Thu, 15 Jan 2026 09:28:14 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Dmytro Maluka <dmaluka@chromium.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu/vt-d: Rework hitless PASID entry replacement
Message-ID: <20260115132814.GF961588@nvidia.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-4-baolu.lu@linux.intel.com>
 <CAAywjhSv56Y9rJLVdqV9N54c7S30ZUjyNh05xc-EW2+dS74GFQ@mail.gmail.com>
 <ef58cd8a-504d-457b-b731-f7dfdba0e43c@linux.intel.com>
 <BN9PR11MB52760881132AD4513E32373C8C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20260114131715.GA961588@nvidia.com>
 <BN9PR11MB5276C98AADBE65795DAC5CB28C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276C98AADBE65795DAC5CB28C8CA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BLAPR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:208:329::23) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: feb4753e-3ddc-4163-1c01-08de5439f02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2E3MWY1NXZpSjRoVDFyWGJFWFE4VVlVNE1sd0NuMkgraWNoNHRUblQzbUVP?=
 =?utf-8?B?VzJaelpXcTZRQzhpQkx2Wlh2UW9MYlhJSDdXZUxHTVJxRTRtVUZGYlcyTTd0?=
 =?utf-8?B?ZzY1aUtuOHIrR2l1K0hVdEc4NVBZK2pWeG1tb3FmbW1Zd3prZXFYVHJLcGZn?=
 =?utf-8?B?OGVpTWxrVTg4OXcrQjhsZlh5eTd0ZVVUUzJMalVUZXhPMlZRUEc3aXkydHRm?=
 =?utf-8?B?SUdYRUNydnU1ajhCZGlOMDlDWXJsUnlINEQrN1NBSVo3cEVHdDIxcE1kbG0z?=
 =?utf-8?B?cG9STnJIL1ladjBiWW5GaUVJcUVMZUtwS1Nrc1JFbXRnaGdXZ0RSR2hPcTVw?=
 =?utf-8?B?a3FyZU1aOEM0V2ljNjdzd1ZyRm1yekx2ZmZ6b0JzWWNLOVByUjBtcnorV0ZH?=
 =?utf-8?B?bFlNT1IrQ3pqY3lnVDh6T1hlTDlwVkxMMEJrenZFbEgrN0tuU0RpbEhJR2Yr?=
 =?utf-8?B?SXowWGNjVmdhakFqU0FnbnQzS254Z28xK3BMN2JpRUhQM0hPL2VndmlLd1Fy?=
 =?utf-8?B?YitaQTNIQ29HdkNwOTIzWWNxY2k0VVpRQVBRZ0tSNWVmQ0QwY1hTdTJUVytx?=
 =?utf-8?B?R1VvMnRqOXF5bytseU5vMDVZY1c0cy9ZYU9RbDV3Rk9ZdDVQenpmSis1akpE?=
 =?utf-8?B?VXhGZmNKZlBkUytoSW9pYnN3Z0tYQktGdDNtdm1EWU1DdDVLaHB5dXJDcFI0?=
 =?utf-8?B?c3FXTUlndThrNStXeVRZZWZpa1hHa3JhWjBXZmZtTVhJSG1jajEycHJhdm42?=
 =?utf-8?B?Ynd5d0Qrb3Z0LzRqSXRuR0VtTEFPTnMvUm9GV0NaTk9RRXQ1azBRK1kwL056?=
 =?utf-8?B?WGZhYno0Y1VOWmhxQWRLZytxQ2lMVnVGTGdnT1NuWkVyQ0p4VUk3SnRoYzlr?=
 =?utf-8?B?aFJZRDJXT1JYd2M4VGJYd2lxblc1SjR6aHN3c0tkby95bzdOamJMM1ZuOUZj?=
 =?utf-8?B?Q2JxVnpjaVNDRUhJZXRCQmxQa3RVUEc4dnc0eG1qRm41RUJpQ2xqMDU0ZWdS?=
 =?utf-8?B?bmRPbW1NYXhKSzVpM0tuUGtldk83bHFGaHFyMHVWZ0cwMFF0a00wSVMwSytE?=
 =?utf-8?B?a0VpYUJMYnAxVEhOLzhiVHRRMXkxNVJ0NFFMVWJWaHJzeVBvUkFkTTFYbVdF?=
 =?utf-8?B?L1N2djJuZjA5T3haM1YwNTl5YU1URFhNMTNxbHEyNXd2WldnU0FTWFY3M1RE?=
 =?utf-8?B?bmRzWjJQWXVtcWs1dURCSlk2ZWt3SXArUFd4YzczNDV3TlJremszdVUzWXpL?=
 =?utf-8?B?K2dEenhnSU5HMkJaWGtUMzdIcE9yV0szL1lwc2wrZzNUbURWdG01Z1Fwd1BK?=
 =?utf-8?B?YUcwWTlEbHMyT0x5OUlxay84QjlxMmpvTFFzdjE1UTl0UW8wS28xR1duT0M0?=
 =?utf-8?B?YThZM3VjSnJvbCtXVWgrUmNxeGVhSnFyNkZwVUN4bkw4WXh4S2svQXVPRTVO?=
 =?utf-8?B?NU10SE50ODNtbDBOS0pyM0lIMXVFVTVpb3lrcHRQSUV4czY0cFJDL0w5RnRY?=
 =?utf-8?B?Wlg4eUtnN3JMUjJNRVBZdUZxVFl4Mjg2a1BmWk5ZSzR0cmlKQy9BZkMycEhI?=
 =?utf-8?B?T0g3WjJQd0U2TnNMT3ZxbFl4aUtxS25rLzI4V3ZMYWRQTCtKTEpoSHVPR2pF?=
 =?utf-8?B?RTMwSUlyTDFlcGxzeXZRSnpkNk55dTlDcjhsb2xZSnhHYkQwNnRQYTlhbUI2?=
 =?utf-8?B?UW1RNlVrRzVDWmNDcFU3cTkrRXltVldJaml4SExscDUxRjZOM1FpbjJpQmth?=
 =?utf-8?B?bUNUUXNwSk9ScnpYRDNGUkRGdTVSbnhuaXFsZ2lKRE55MUFnZ0l5NUk4MEJv?=
 =?utf-8?B?Z3lsbi8xdDJvV0laT3lxQW5lNUJOdmJPVmp4M0E2eVRseHZkMmkvVE85MDhQ?=
 =?utf-8?B?YWozd0dEWHRRYkZROXpGUTA5T2xXUVo2eG95SUlEbElVUU1WMTJZMHI1Zk5G?=
 =?utf-8?B?eUZDaXZkTitlNHdDYWxsbFpPSUlLWDg0YlF4SzBNMmpFVVFKcFNwUTRneTlN?=
 =?utf-8?B?Z2xCUEM0Z0tvMkh6R0p6cnNlSDlZTGdTbFN2eENpV2htUHhVNURsUWdqZFpC?=
 =?utf-8?B?bktzcVdjZXNtakpFVWhrejNHcFRsY3JVVHM2cFZsdTdKM0JyV3FaUjF4Yjln?=
 =?utf-8?Q?21KE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDRSOTltMWRFSkp1OE42RDBvT1lUdyt4RlNLTTZoWkJNcHNyeUVSVWRKM21O?=
 =?utf-8?B?ejczVjFoZ0lGdUdIbjFsWkVwYXYyMVZ6OFZxK25BUWNKeW42c1djWStuRStK?=
 =?utf-8?B?elU4L3pKcHZ3eWNhNjVDdldEbW4ySlRmWWdYcU5rVmswenppRjVoTWdPZDY4?=
 =?utf-8?B?K1R4ZHFFOGdUVkFTRmN2eCtFS3VyMThwb1VZdUkyWXI0aXdwd0FRa3lQZmMy?=
 =?utf-8?B?RFdQZFB4SUpIWExVcEorK2Ftd0llbS92b1VZdW5jeTdNMXMzSWl0dCsrbEJp?=
 =?utf-8?B?UlZGcE5lYjhwb2tDNDZkakxwUDlaT0oxYXBtVGRjdzlNY0prb3dLUExXc2l4?=
 =?utf-8?B?ZkdONis5ek1rTUkrWTBLenk2bzByYXIxUjQ4R3ZQU3d3aHlWbVYvdVdkLzVE?=
 =?utf-8?B?NlcxcVFsb2xiQXg4OEdLZE1NRzJkQW03UzZlVGJhK2RoRlBIcGFUOC9oYVNY?=
 =?utf-8?B?dkdPL3FmdXl3T1paLzVGd3pXM0U1aDY1VzRMWEtPOVpVbE5vQzlRNHdobVg3?=
 =?utf-8?B?Y3o3ZjJ1ekkvTjh3bC9zVWs2clRQamRuM2tRem81eFlMK3VrcjNWekVON3VP?=
 =?utf-8?B?SWJ5TEx3bmwrSFJsT0VVbGFRRHhHNEV5UEk3elRvcTcrWEVsSGdQakcrbVJW?=
 =?utf-8?B?QnIwWU9ENitMZ2VURTNiM2ovUE13WUlneHpWUjJnbnc4Z1NEaG52bG5YUkI5?=
 =?utf-8?B?SytBZWE4VmZYZnM1RENxYWVQODRoVElxekZlUWxlY05XMVBDZzdkbjAvWEZT?=
 =?utf-8?B?Q2pROExNajNlK1VrREpNVUFoVW1OUTJEWW5pMWtmVEZwY3V5ZkZMM2liNUxv?=
 =?utf-8?B?MXV5a0tFcTZPN0VyaFNqVkJDUDUva3E5QlNvTlpJS1RSVVN2N1VhdEhnZ2lD?=
 =?utf-8?B?UlhpUVUxU2J2UDhyaXFhdnl4emRYSW9OZWE4MEp2OGs2TkEyZEUydmtQa25L?=
 =?utf-8?B?WEtORnRYc2NNTlZ4b3FVTXZEc1JkVWdvNHd4dC9tdmRPVEQxN1U3bHpIak5p?=
 =?utf-8?B?OXlhbzh6cXBXem1tMkpnbTJ0dTdQYWZEaStxcHY0VERhWTZ5OGxDYWVCekR0?=
 =?utf-8?B?OGNjUTFrTHNvb0luaHArL0dRanIxK2Z6VXZTNk9qQmdDQzF2OHBLUmlsSmlP?=
 =?utf-8?B?Q1dmY3BIZVpKbm45U245NFhaeG55aHVHOVN4WWEzVUpQcVcxTmhYRXlBZ3Zs?=
 =?utf-8?B?NGVHMTNuOGVtclVXYUJjMnJ2QmdzdUtEUklIRzJIMjBTVmR3ZlJ2VTVaM2Zw?=
 =?utf-8?B?anZzTDRHVjVuaG5kd3dPd0FSMnNQOGtUTmtCU29vdFdLWnJoWVU5Z1hiQkRs?=
 =?utf-8?B?OGFtd1NXK0VoeG1ReVVWZHU1dkhJdVNRUXNUbENUb1BkUFVWclBRaCttZ3RJ?=
 =?utf-8?B?RnFJcXJZU3ovellLb2paQ3ZxSjFlb1lqbFE0a3FNNC9vNmtnU1AwTDJlZHhQ?=
 =?utf-8?B?Y1JTeTVGcDBRRHNGcDZPdTAxb3NzbFRIQmcwZDJnNUlMWlhjVTV2U09OZDdl?=
 =?utf-8?B?UGo0L2xLNkUrRzMyVnRtaFZTVGgyUERyTVh6TnVITUtlYzQ1YlJyY1VZekJy?=
 =?utf-8?B?elJpMTJEdG5tNHlSamRuU2w5SXRkKzhyOWYvUkpCQ0pDbjg1M0Y2THExTnRv?=
 =?utf-8?B?aXEwMXYrQ0hQeEhlUXBZQ3huNktybFZkbWQ4Q3psL2JReGZmYVk1b2pxVUZz?=
 =?utf-8?B?ZDkvTXF2R08wYWIvVHJDUVVhVFJJZzZ2K1ppd1RseTV2Q1M5TEU1ZDBQa0I5?=
 =?utf-8?B?dUExU3N0ODNBY214VDU1UDhCaEVWbTdYZjBsWnpXVkp2VnUrL1NKNnhFMGI1?=
 =?utf-8?B?SytBRnU5UHhobzZnY0Rid0Y4WDluRTlHdStaclZpdm9BaWVYN2I5eUZYS3dR?=
 =?utf-8?B?Y29jSndwVE9IVHVSNHJTMjczM1lGQmE3WW0wQ0dDL3RFaUcwcEdSb1IwZ3pE?=
 =?utf-8?B?TWVBQitxVklUMjF6YjJSOUIwQ1U0UmlUWWpvSVZJV01qTFlwVElnUUtDSis4?=
 =?utf-8?B?amhFb1JMV0dRT2s5a000VEIrT2tETk5ubkh0OHNhc2hXUjNwVStnYXdOOExS?=
 =?utf-8?B?NzYrYnVXa1gyTDViK2tSZUpsVlR1RmlMREdhenNqalZoZm5HdWFoNE1qcHVO?=
 =?utf-8?B?cUwwQUova0tEV1Fkb09rYVRxZ0h2N2hWMVpYbjA0N2d6YVkzV3FqQnhSdjZz?=
 =?utf-8?B?bFVGT3VsQjZPbHB2eEliOG5YRmlKaXZQUW90Zlhmb3pJQlBZd0RKQSt2STUy?=
 =?utf-8?B?eVdyQ0tSL0ZCNDZucnJQZDV0cFBhTDg3aWVOSHNacENKR2V2V0xJSE1ycSts?=
 =?utf-8?B?eDJSREVSb2Fpa29RV0FOZXhVOG55c25aSUpMeHVTdndJcWVORVdFdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb4753e-3ddc-4163-1c01-08de5439f02e
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 13:28:15.4155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdzRaSIbgalpGZrELO+HkDw+R4i5u7WGVCiRwQMUKPZRYZK2kNGO2V376G+rl0Nv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

On Thu, Jan 15, 2026 at 05:44:08AM +0000, Tian, Kevin wrote:

> or in Samiullah's case the old/new domains always contains the
> same mappings, so no corruption would ever occur, but that'd be
> a very KHO specific assumption. 😊

The thing witih KHO is we don't actually know this is true. We hope it
is true, but ultimately userspace is responsible to do it, and the
kernel doesn't check it.

This is why the hitless update in an appealing solution because it
means we don't need to deal with trying to adopt an entire page table
prepared by another kernel and ensuring this kernel has IOAS areas
that fully cover and exactly match what is in the table.

Unfortunately to do the extra DID will require a complex invalidation
sequence to hook multiple DIDs into the same domain
simultaneously.. Nicolin is working on this for ARM and I think
Intel's linked list scheme could be tasked to do it too..

Jason

