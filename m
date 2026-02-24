Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E452749E6
	for <iommu@lists.linux.dev>; Tue, 24 Feb 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921565; cv=fail; b=FoC1lCfawCUp7hNhlIVMUxoqbPhV65vTv0W3TrwcV26TZe0Ga60U7NENha79fLlWPaUAd9hspMUrU42cJPeFHAbDu13pSHjHDausI1Ba2j8H8DfC+hzHEMr3LX60MTtdJQb4H8XuMUzVNyKZFW/YOxzJGxWPsnCwqoY56YAxAbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921565; c=relaxed/simple;
	bh=pzoPpdjljNyZzBBjZ60vXgwqnBTVgQDWJ+4Hkc9FjWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IwXEvlOH5FqyZpxfOlqpJpBK4QpU1LFN9Et3SIQKaQlX3w7Iq2dUKlArislRYe8fdw3Z5TceUE79AZ99BYdSIKS02mi4TZlCoNRZhXSgKF2EXuevG+ozSZVgDQhZU8p92rYfhOqBOPbFwpSrYgRdp7sqIvTtg9wfzgMYGMJB4l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iCJzyfin; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iCJzyfin"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCElkGk4283+4asdwcvIxL7tJZX3xs01hnk8oit1+djFW+oSKXiSjhfjO3/Ma033YfEnGluplaz9dH00iM99rewN9V7OFk0ZfnXnts0zvCPVoeqrtgX3F99F+u9GY9d5FPd06Sbt1WZ9pPsLojBNOPz/uORqtsHhYGNo2cPA2OdEbPjMv/bsUzc2bNjjWyMD06tiVekROMT0M1ZBB9CJ1ksKFjYBfuabYQaZWrjmXcUhSIvKA6kcTS19dPRFQfwMH9Wg+3+t2MtS/C+2AHfB9CEH8Xl4fmQkAfs3SdzCXJthrHBBub7hfXd1KWKo80PjfqxYGDUqvRuFdWTGicpgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4+ut9WKWJqjRiitmtTa5OA8S7BJC/M5z2dDxv97CRY=;
 b=lS2C4waz9I1B9dTqKLcf9X1vyGHP3izCvoWoxoO3tlTBiOt3JU34IfMKxVNiedXOp3rjGKJpidYn89XEoPLQPrICzXN37pOd88ioSJ25VYPngxgPXNSidc+0WxdXRDBPzDF1t5RQGviEyDio60XgDrKZvJntN9ArEtt3W8dJSdIp75oHxPmuhfh54PlKcFE9X2XA9qmP4XHVJ6tfOoA42ZuIC83BBMdFMklei513ifVBZmeLrTe2/iK8VdnhCad2UJXGaMP3xL8y8ye5lGXQA2zz6P+N9TPSLesbLsoSQa6+1NtXyKhPfRh8X8na7PFdftbWx+dYg05P+odKAWgqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4+ut9WKWJqjRiitmtTa5OA8S7BJC/M5z2dDxv97CRY=;
 b=iCJzyfinteAu03e1MkzZTYZK5LcOHPz+/RJJYbLcwKOy1aFuNvF+wwE2Gd0RQJ36bAAzUYEt+nfo9mFsfP3NztyesYrZ+acK+dYzn6gZPn2RnL+Z55NNOxtySl7ygqT/lFyBUrmd4rog11WTUz6ToVN9Zzd+mJt7nxRO5CixQHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 08:26:01 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 08:26:01 +0000
Message-ID: <131bfe2b-51b1-4235-87a2-ac00a464064a@amd.com>
Date: Tue, 24 Feb 2026 13:55:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
 Mario.Limonciello@amd.com
References: <20260221235050.2558321-1-lkml@antheas.dev>
 <a847533d-2488-46a6-9f32-79309d7525ce@amd.com>
 <CAGwozwEe_B6uQPoyz=xXzsi_oYAtyFcLNSOQZ6=kNm3gz8QowQ@mail.gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <CAGwozwEe_B6uQPoyz=xXzsi_oYAtyFcLNSOQZ6=kNm3gz8QowQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::8) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 017c1198-b1b6-4fc1-cc74-08de737e57e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkt4VjN0MzZXV2g0Tkl4RUpFQW1UczV1YnIrbU9iZXVabFhLTHB0TVBjTnV3?=
 =?utf-8?B?TGo0Y2pPa0x0bnVRVnB3dTVWV1VnclZiQjVYVmFuRWtHRFVwbVdjY3RHcGVq?=
 =?utf-8?B?Qzh5TDVJYms4NnpZMldOTkQ5RGRZcTFGUENoRzFNeUxWRmpVRUJsWmVnWnpy?=
 =?utf-8?B?K2UyR2dYMEdJUWFhZEYzaldRSzVCa05EWnJ6aThBQ1VnZmpoSUptbWtqYVd4?=
 =?utf-8?B?RS9selJaalZjWE94Q3Zhd2FrSzJDOEI4aGs0eVJPVEpYZlZDZStlU1d5bjF5?=
 =?utf-8?B?Q2x4ZXJIVG9TWG8wWmZTV0F6amdmVXlSMHovVWtqMVJYMFdBSWZJRDZBcnVH?=
 =?utf-8?B?VGJmZkJmLzA4OWJIY3plWmlCMWY2YU04TnpnOXBSSzNPM0RMSDU1NlR6MjU2?=
 =?utf-8?B?VE5hbDc5R3phWlkvU0J6b3dLeDQreThMMHhDTXNvT1JDeGFEVzA5aDdhQzJv?=
 =?utf-8?B?Z21PNHl1ZlBmVkdvWlVjZGwzRnp3SU40aGYwSTFnMzl3V1AzTXdTWWJNZnk2?=
 =?utf-8?B?NVAyZDlsSVFCc1duN0lMQktPODZ4TmxFUUpVZ2lpT0YzMG5QWEhXbEN1Mmlt?=
 =?utf-8?B?N1ZkZDJzTVlHeHJhYURrYzVESHRtNExQVEN6Wlh1dUMwM25xcDZ2OVkrclo5?=
 =?utf-8?B?VmdaNFVDVDFFRldpdGdyWHhzK1UrYWVMdHZMOE16MlQ2NXprVzhGWXpkWXBW?=
 =?utf-8?B?cGlYZE84N1BXeDFyZGNLWktrRTlOa1BlQ0hiSFRqN3lEd2pOa3EzVXg4bjNr?=
 =?utf-8?B?TzlFQUxrZnFUa2Yxc1RPWVpLNGtnemwvVVo1M1p0QlgwNVZiYUZMU3dqVURv?=
 =?utf-8?B?THBuaFd3V0toK0xIR3dwZG8rbHdmVUY3WEhpNy9uV0RjeDZoMnNBTEZYRGt2?=
 =?utf-8?B?VXhkNjNVYzdoSGZBVTNCWTNtWkhYNzJOOUFUQ21aSEZnT1U1blFrWVZJT09a?=
 =?utf-8?B?akE5dGI1ZjI5SGJ3cmhyZ3ZrYUlPQnJmUGkzbmZ3YkduUTdidkd5MFVSNnRu?=
 =?utf-8?B?NXhjc3kxQlZ5dFU1Uzc4VUNBWVlodGpLSE9WbHhYK3JhMGZlSlVlNGIxb2FQ?=
 =?utf-8?B?cU93bWdiZWFLdXVhR3VsVUE5N21laThSU3JYek01dDh5L2ZEanU5TVYwTWhw?=
 =?utf-8?B?d1kyZ0Y2N0M2YVRWaXBwamJ2bmRHRTE2MHg4RHB1aittY3JBclNNTVFLd1FZ?=
 =?utf-8?B?K0dhVGx6TGNwa05GMXlyakxNTXZNVWw3b3ZFakVoS3dQc3BNS3dtU2UwVDh6?=
 =?utf-8?B?TU1SUHl4UzJpS3JhaFdFaHFVNXJnUUx3Qm8zeER6YjUyYXdyaXhpQ3YxdmRE?=
 =?utf-8?B?SFpTQTBHeFNHblVKMFF3YUZkai9ib2krc3VBQzhBUzJIRWszbDUzMHM5RTNr?=
 =?utf-8?B?VTIwdGQxYytqOWZ2T0hveWJtVWxURXVla0VyajZpT2RSK3IwN2FySnFITUxa?=
 =?utf-8?B?SG1ZaSt1dFhHWkNQbjJLUEVGckhzWU5GNUJvTzBuZndHdVpJc0hLMUgxektx?=
 =?utf-8?B?WlU5SXNYY0kvZTN0ZnYrRU00OE5pNERnRWlOZzJ5NFRxQnZmUFdxSFhsdHFV?=
 =?utf-8?B?WFZrUG1zS2JFK2ZHTXhTRTBHZkxOdm5CZC90ekNMdFZjRHBKR0tnWEpoSlc5?=
 =?utf-8?B?em5FWFQ1UDkvSlpxdldGbXQ0aHh4clVtaUNlUFJVdysyQlc4WlRhd1VoNFFk?=
 =?utf-8?B?MEtrVHNvZkRMWnJWQkgrZ1B1Ukh6b0F6dG1kVDZiME9uYTdBTGVmdEtnUjRk?=
 =?utf-8?B?SklseTlPN2NUUjV5eUVzTk40a01iZ1lHbXBhQXl6U1UwN3JTQVVERFJKTnNJ?=
 =?utf-8?B?Z3hNRVNOLzJHN003U3JGd3hlRDJJVjAzZEo0a2dtWWQvVmZydEptZFRBVnQy?=
 =?utf-8?B?L3JGemFJc2NreUtQbUlGeGZsT1F5YTloaVQvanloRXE2dlJ0YUovMGdIRUpm?=
 =?utf-8?B?UUlHMWdXdy9BNkJSK1hLWGhidTMraE9IR1I4VmIzWEV1QUYyV1lNL091emFh?=
 =?utf-8?B?Rlhpc0o4WnJNSzZnYUQwZzVkYmZXaE5KSXZJVnlxUEhmeXdzd3czVUhHYzhP?=
 =?utf-8?B?Y3BLUmFtU1JVNzYzUUxYUXRqZmVOTWMvQ0ZGNEJaWWc5ZnVVUXF1eWl2dStt?=
 =?utf-8?Q?BqE0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUJNbjBlbk5VZzVubm9DT0I4YWRjYndBbWo4NUx2d0xRM01qdjFYY0JIYlNR?=
 =?utf-8?B?K1hOR3JrTGdBUDNpNkNPYlRucWRmN1pSMkkxWldaSkpNbmNETHltZXNtVFpB?=
 =?utf-8?B?anNPL3NaSDhRVXZ4M3lJdkt2VEUxYTh2OS93THpCaDQ1VWwxQzhHR0JZVUZa?=
 =?utf-8?B?bGZpWmJ6dzFudmlEdmgrYUM5eHpHTTBFNTNlVVdVdGlzVVVWbGhCTDJqS0tN?=
 =?utf-8?B?U1g3RVdyaUpRT2Fxb2IrNGk1K3FQaHlBazBrWnBNSzJBN2wxQmVCN2pFSjM4?=
 =?utf-8?B?eThPbS9PenpkSisrNU1Xbi9WWVZqbitYaWN3VmdBTU1VZjFLcVJkS0Jzakl4?=
 =?utf-8?B?UHQ4SmpndTlKcGYwNnMrMlhOdmZjWXNOamFocUpBSXM5ckxQRkJvenVmZGxu?=
 =?utf-8?B?SEpaYUZvMWZnSEFISUhtUmJUUkZqeFVXTnRxWVNLbXgySk11SnFVWEwzQW1K?=
 =?utf-8?B?YlFJRmEvaDMvbXJScVd4dnk5Umt6QmZ2Ky94bHR1Z29nOW5vZzVxMDk4dG5t?=
 =?utf-8?B?ZDFDZTJHUWhTTVg4Z0tYVVNHT1lLUDgybS9weitDTitCUndlN3NiakQ4anhp?=
 =?utf-8?B?SmI2Z09TY29PNURkVlRVWEFNeGg0TGZGd2o2Z1VGODlwYWwrcmU1aStYWmNP?=
 =?utf-8?B?eXVmQitPdHRubzlFby9DNk5ianUyTmN4Sm9XZUVhSmhDSnlwNXBsUytNbGI2?=
 =?utf-8?B?MVRmNkx3eFFPNU9LR3Rna3hzUWJ2U3VoNFBQZ05OQmhNNDFNOFFUQWVWS29q?=
 =?utf-8?B?K2VTa0RTOWlFdjZzVTNmbnlLWVdvTmRNYTNNR0MwN09DcHlqL3Q3Tms3VlRn?=
 =?utf-8?B?UjJWUWZlWHRLSyt3NEx0OFFzenpqdzZ0aXRleGx4Nmp4eWJ1Uzh2ajZlRWRj?=
 =?utf-8?B?Rzd5R2hxZHgyY2VSOHZvTzBidWx3Y1NMM01wNDJLb1pwcWZkUUlVQ3QxajNT?=
 =?utf-8?B?RDZRMDYxWHplanUveHRDNGdJYnBVNlRkbEt2WVJVdXkrNTAvd2k5eGxHTGJ1?=
 =?utf-8?B?UkFPYVVpSUthT29adXowVTlaaTczRE9XUWwvZVVtUkE3V2RuNlRlWjFrekxW?=
 =?utf-8?B?RVFHRDhGUjNxZjQ5Qmg3djMrTjNCWjBVQVBUSVQxdFVLUE1RRGx5a2dSZWp3?=
 =?utf-8?B?Rkw3dzMrdCtYRnRIWXloMUdraEQ3YXVoTEdIaHJiRlA5OG90SnQ4a01BMDk3?=
 =?utf-8?B?d21IbUM2MGNLQ0lEOGtaTWpyOFo4Vlp2Wi9MemNieXlsU3VFdDIvaE5rYXNG?=
 =?utf-8?B?ODlvWGE5VlI1L0k1ejQ0MXdLSkFRQkkwdk1KNGh2NGp5b2dWb21VTkhJekRS?=
 =?utf-8?B?SUhYQTJISHNJU04zZmc5Q1lZaG5nME1oY1ZQRU9DREhQOFR3ejZNbEVOU1B0?=
 =?utf-8?B?MDBZbGhydk1WcTRSeTVreG1reTdLbGR1Yk9HSC9KREMzcnY5aklMVDBXTWxL?=
 =?utf-8?B?aVdJQndqWlVtMC83eDdYaDZHVnJMM1RkaFBPdXB2aVlMN2hyaUZaMGFNdGpR?=
 =?utf-8?B?TlhSM2NJVkR4Ny9TbzJQcjcreGp4MmludU4xV2c1ZkVscG9XZ3dXdm0zYXBT?=
 =?utf-8?B?Qy9MNC9RaW5RQ2d1VitiVEN6MkVqbENBbzVxVDRzSC9Xb2N6aUtxSWJxMXph?=
 =?utf-8?B?RHF1N0xlaWk2Mm1LcVVXUkk2cE5IR2pWaVRCT1hwaVJMZVB0eHl2WW1LREN2?=
 =?utf-8?B?ZjVzK0IwcEdORFJ4V2krY3hMOFhTT28vdVZZSHprYzdUTDlwVHBrYktGU3Vx?=
 =?utf-8?B?WEFqWW1qcWhUdXgrWEwvMEFjT1ZveGpjMXBPNklnbG9XZzJVNjN3MEg2blZY?=
 =?utf-8?B?dG40Nm43d3dyZVZyWS93RkJpNDNUMjFybEFaVE5YbmE1TERoQmFlSS8zekhv?=
 =?utf-8?B?eVptQm92V0h1RlZEUDlYR1Z3T21KNU1aRlRzWDlUMGYxUHRxMW0zWGwyb0lI?=
 =?utf-8?B?OUFTTVVISklIc05rRG82SkhCKzBRVGVPN3AxSThhYTlnSFFYUmxQNklkZUZH?=
 =?utf-8?B?SCtQRkFXQnF1K1FlbnFSa3R3NDdBN2lraG5nTWZNdWlDUjV5OTgvZkFud3Zx?=
 =?utf-8?B?WHRrbFo2TEg5QVNtTUxlN281YUw1ZWpvMTNtMEtZL2VJbGtwUHlBWGQ5S01N?=
 =?utf-8?B?cmxHSHAyVzdTZmtld2tCZ1dvNEIvd3lCVXhJMnR5WndRV0NRSWJHb05PeFhX?=
 =?utf-8?B?WFRLakFqWk9rbWYwalpVc1d5UVhHUGcxdDdiMk1tVVp5TUpGSWZXY0ZobDdX?=
 =?utf-8?B?cjdSMXhvWXA1d2ZDaVdrT24vcTlFY0MxOWFGQnNRNEE5ZmpJSERENldGVzhT?=
 =?utf-8?B?cVZzSFdJa1ZBKzZ2eWFiNHluOWx1Nk5kQnAxMEw0THZValFLWGFOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017c1198-b1b6-4fc1-cc74-08de737e57e6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 08:26:01.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /VPAc2/PN3/6nwsBUrlBzeacPyNci3LB1UOkxWEd/sxLP7hIcpGf65nuu93Qgo8RRnHGbPIR/u+k+CnP1QKTYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Hi Antheas,

On 2/23/2026 1:16 PM, Antheas Kapenekakis wrote:
> [You don't often get email from lkml@antheas.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Mon, 23 Feb 2026 at 07:02, Vasant Hegde <vasant.hegde@amd.com> wrote:
>>
>> Antheas,
>>
>> On 2/22/2026 5:20 AM, Antheas Kapenekakis wrote:
>>> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
>>> introduces the shared iommu page table for AMD IOMMU. Some bioses
>>> contain an identity mapping for address 0x0, which is not parsed
>>> properly (e.g., certain Strix Halo devices). This causes the DMA
>>> components of the device to fail to initialize (e.g., the NVMe SSD
>>> controller), leading to a failed post.
>>>
>>> The failure is caused by iommu_create_device_direct_mappings(), which
>>> is the new mapping implementation. In it, address aliasing is handled
>>> via the following check:
>>>
>>> ```
>>> phys_addr = iommu_iova_to_phys(domain, addr);
>>> if (!phys_addr) {
>>>         map_size += pg_size;
>>>         continue;
>>> }
>>> ````
>>
>> Thanks for debugging and fixing it . Just wondering why can't we replace replace
>> above check with pfn_valid() ?
>>
> 
> Hi Vasant,
> I can check later today
> 
> From a cursory glance though, it does not seem very suitable... Can you expand?

Looking into the details, you are right. It won't work for direct_mapping().


May be we can have this patch for now, but I think on long run we should update
iova_to_phys() ops.

-Vasant


