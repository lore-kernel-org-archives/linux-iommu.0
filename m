Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC5195FEC
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 17:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727890212; cv=fail; b=O1telyi2eNhM3KKa1fAGns2Z+jB0aP1XNAvgT9g4ya4FsLqoE3lYfNfXUks7eeW6YgFWuW5BdB7dd4mMjzSZqTlZmdmsyYLOz9qG/ej6nnYKfRfXqrnBvCwR3MjY2b9rvI9fc10dKvfaCA3K3wISWQPzh1gKLTVwcCMf8KVkZHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727890212; c=relaxed/simple;
	bh=xEFjcoS6zbt/aHWEJbO63cyEX62t4YCxYoyMybKGQOU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MBZw3Wc3JdB08ClVz+9zC5BYmoeYEmBSzboLknkf6uikKKq19t5amF/4s6XJPkB1Tb2qBNz/PtNJo/e5JoGv1osub7pMZW0X7rSvtRrVgv8E5Web5/Ybwie6LeGh9w9dLFORu+FMqq3k9T0Yrx176g1pEjd5wTvYDqY53/5550Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nnr9WlSB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Nk9rmsDU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nnr9WlSB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Nk9rmsDU"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492GMWUS022894;
	Wed, 2 Oct 2024 17:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+LhhiE8EAmGUaAtdWpH2Z+LkzZCsNYi8/VfYy8IQGGI=; b=
	nnr9WlSBHFwUWteTrWGEE/t5K4apsJAllezlvzQYCqAgywXmAreIoSBzMWRrKbwl
	jrhbllCSYBpG7B9nOr7q4zlv6LVWMndp6kYqoNyIDgt73fWcR74SuAosl8p0Q6as
	/dB5P4HOOoVJEuaAJ0rXk8PPJ12J4qpRq0u0CWyJWCUutk/EUFdPFrePq9uCWVIg
	wsO7kIDVZunl2b/akwdhpANfOdaE2wYpMBO1c9cS8VHnH811l724H9TwU/zybrJ+
	771tpqAOCbfWQcaZxHAP3BaVNwF+93k7B5gjjJ1PAkfLuHw4RHpl0R7gR/LnWSqS
	QV38U3BbcFp6Km9pa8a09Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9dt2bnv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:30:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492HLkFR038687;
	Wed, 2 Oct 2024 17:30:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x8896tfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 17:30:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHjoVGRfb/kvTM2VWCbSO98kINZf0Oo9Xv7GBlq8QwZP9gH38Oj5wkLsDILwlivIo8XtyVir3goaT3MIjuD5cStdxAb9zLe33ICjy8dMU5S6tAodQa3AjCBvsHLC9eP8x/X4R167WXeD5GDokoXZodglZyfyZsHnG4v+iidT2ghcMAtHXqEYr6dmaWndcPUKyJwsVQduNuO7IjG+coAsVGBbgIoZ453AzY2JRZTgqUBRbsnPtBLPmajyxEMUwK60PELhkQJrr+Hv1QEqezA3yxCMaZ2TUFV9pMGv62DEAa9q45Tyy/0MVgH0iFq5c+DhnAzlhmkfrrwC7bBP5d4uUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LhhiE8EAmGUaAtdWpH2Z+LkzZCsNYi8/VfYy8IQGGI=;
 b=nC+8Di2sB/OGGRXhvXWdei5qDm9lYyptzkpPYSivMlaRP5zRMriSpWZVoqHzITNQXrkqs7GNtKfGGgIGNBWNQBnbx1+g88FolR4K/msMPW28tkMYLgrpoAojnBWlK2FhPKS3LWvrlefWE5RJlISQ4eV3NhrQrY4rkwZScGRJv+k0yJ3DtfV2jU2XusGY22KL6xD2guyu6JEs3q6ubehoY+RYF8Q7zwtSIXDaHwEVLleJlCDdoHlJiOESH2F93pvl7Q+ZIxcSAJQ2PsUV9PzyJPAVw3YMWSyAcmYJhufjpCoFZDSKROqrNZg8QxkKsU0Ou8cgWwFQMWhoESqXejswQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LhhiE8EAmGUaAtdWpH2Z+LkzZCsNYi8/VfYy8IQGGI=;
 b=Nk9rmsDUFfKVEmE8hLytZnwJWIpZAVPTjwFaDI3IKxAlEPE/2igBSdaO12YfVEusTnX98dKkfjuz/uw+OG9Wi/Orrftb9xMZhNnu+q4p6s5yvda3HGQB505k6MF7UP4C06X6xCYpmMOMzhjEOr4t3oxAaefByvfZbAJC6fcL3vs=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by MW4PR10MB5775.namprd10.prod.outlook.com (2603:10b6:303:18f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 17:30:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 17:30:02 +0000
Message-ID: <77ca78a0-fc84-434f-be8d-d3e9ed53a434@oracle.com>
Date: Wed, 2 Oct 2024 13:29:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/9] iommufd: pfn reader local variables
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-8-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1727190338-385692-8-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:208:23d::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|MW4PR10MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: d71fbd8c-01a1-4fb1-e5b5-08dce307cc91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVllNW03VzllVTdWVFZnb2U0VTI0Rk1MbVR4T2RRai9ZOU9IS0pMb29QYitH?=
 =?utf-8?B?MncrTWd3cXRqaVNqTmFxYTdxSmJRYkVKYlhGVHRjTVpsRFQ5VnhKd1lJWm12?=
 =?utf-8?B?L1RmcmhLVCtqdWsyelFiU2JZV0t3RUxuRUNPQkptRVJkd1BRNVNEM2p0c2ht?=
 =?utf-8?B?VFd3SmpjbDY5Uk4yWVdZQlRSWVFSM1BKdU5IZzVuT0tVQkNnMzlXYVloL0NZ?=
 =?utf-8?B?emNac1A1U29xK2QyZ054TTZwcDRKVUJUMjRvaFRhRXpONmVvVHArVURwQWtN?=
 =?utf-8?B?TWNJeGVqRTI0UEFwOWxPNURCcVV4bFlMb014VjlNU3piN01hSG1reFZDTXdF?=
 =?utf-8?B?eVBtZm10VlNHdWlwbUV1QXdKeW0vcnI0VlQ4d2xlbUhxckFtVldJb2JJYzN1?=
 =?utf-8?B?aXgyMVlkTW03THhWSERxdmF6L1VsWUxsbzRNaWJQSXpPRW9ndG55TUV4Titv?=
 =?utf-8?B?TkQvTm91STJINTlqbHAwUmRGZnMvZGkwT0FIeGh2NnR2a0dTQUNQdVpscllX?=
 =?utf-8?B?RTQyWGROam91b09ackpnMXFPNFdTeWhud210ajZyTDFScFlzSWxNMDN3d3Ni?=
 =?utf-8?B?cUc1RmhFUk1GdHdzVHZuUzZlRERaUUtBR3B2aEh1TnhFM2tGbmg5dE9LNjNR?=
 =?utf-8?B?bU9lcHV0blF3V2VsTFUrYkpsWnBXeng0a3hKT2daV1hwY2xvTVlPL3hjb2ZF?=
 =?utf-8?B?a0VJRFFDWXorV0lYb2dqSGxWSTh2TmhRSXFUeHN0Qmx2djJWMnVxUHdoN0Rn?=
 =?utf-8?B?c0djUGo0bUFrTVliREpjUGgrUDNGZnc4REVWaUV6NWd4TnNwU1VSRG4zUktS?=
 =?utf-8?B?d0RuQXFSdm5iVURKNjJ1aXN1bzBtQ0dHVWVwOWxlSE0yakhIcS9LWEpkNEVI?=
 =?utf-8?B?clUzK1lLMmZJL01SMXZlS3B4S1NkYWlxVEE1TjUxeEgvTUEzZUZ3ekdCNnhw?=
 =?utf-8?B?YjdFa3E5TkwxTWdhdGZ1ZXFVbHRFLytKc0Rzd2VlVDIwTnhVQ0xzdnE0UWFK?=
 =?utf-8?B?OWtXdGZzaFpRR3VvTHhTaFJ6clpJSkhoOCs0TnFRQVFFRDdvRlYvWTJPM29K?=
 =?utf-8?B?aFdCcmtEWVhVZjZUSHlzZWExejcwbmpqSHpRSUtES0psdzcvMVVTZStSNkla?=
 =?utf-8?B?MGlvV25SOEJ4Vld6N2F0c0N5OGhuMzNVeGNzUDRITHY0OWM3VzJYWXljR3M0?=
 =?utf-8?B?Y29BdGJyYUtMaVBsRVRrQ1pNU09zZHhESWk1aTVTQ1VaRE1ZY3lOU2Jub0dn?=
 =?utf-8?B?WlhmWlg4VmxzRFB2WHJLYmVlSVlGS0ozdjlhSTg4ck9zRjJmVXNUeXlMeFVw?=
 =?utf-8?B?OSs1eldUeDJTMnB0cXpXbHJtRUhoazNqazlvbGRJQU94ZWJ2OTBLVGo3V0xX?=
 =?utf-8?B?eWpraXgyZ3JrVGIveXVtT25HZ01sSEhyKzRncGZuSEx3VHpNRG0zS1VxUzEx?=
 =?utf-8?B?VUVJZitRNTRQdVRhM0NMMkpocEhpeEhsekxWSko3M1JIQm9YWGtmNGxEOWpI?=
 =?utf-8?B?cDJ5Uk85TWJBdCtTY0psdFVOZFRZcnBPeVdOTUlNWVVNUXJURDdOM00zdDdT?=
 =?utf-8?B?YXJoSGppall0bEI1TzQ1T29KeEtRK3krRnlVY1lLNWl3ZU5IQnJkYjR2MjlZ?=
 =?utf-8?B?OVoweU1NSFQ2d1JVUjZMWDljVksxS3FsVzQyQVdjMks0VmZjYWVrS050bDY4?=
 =?utf-8?B?TENVaVFWR0ZDM2svUnl3UnN5Zk5uQUpVbHFEcFhZb1I0T3hkSnhlSUdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7447.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlZDZHd4bm84NzNNT3l6Z3BmVFdnVFRCditQSFRpTW5yaDJpZTlaa0h4NFVO?=
 =?utf-8?B?bVEzYUxpbi9UKzNLTUxDb0Z2V2hjUDlBM3lkTm4zeWdLTkFMejdJNWZlY1ZL?=
 =?utf-8?B?eERkbTVIZXJoYTVBYjArb1NGVkRZVVRKTXRGU3huU1VaVUdXeWJJWUJpUFlC?=
 =?utf-8?B?N2gyMk96MkY2ZjRLaDUxL29xUENvZ2NST3lTckR2MkwxL1RQQmd6dGNtL1c1?=
 =?utf-8?B?V2ZSb2RremJHbkJUZnZvU3huVHpvaFVQcW9RS1FmL1RCQ3J6dlRkV05RSWpa?=
 =?utf-8?B?QzluSFdPMWdDSVphL0N0QytqWW5NVHVzdEk4cm1sTkZsWUdBK1plRTJpbENV?=
 =?utf-8?B?TXkzWFZnY1hDWHIxdmZmaGQrcE9nSC9lZk9ac21xTmtSMThsSTE5TXdNY1NQ?=
 =?utf-8?B?WE1CTlJ1V0lESERXVlF6OExPcEtHSEcyeXB2MTBPZ1Rlelc1b0hxTUQ3MEVt?=
 =?utf-8?B?aXlRaldESnFjcEwxRkNoSnRWNHRYVHRETm5HMENVajkxYVBlVDJ4cTAxWVNi?=
 =?utf-8?B?S3EzYStVa3JlRFo4SnVld3UxaEhMUWtQbWlzb25LMFNQSjQ0QTBDLzY3VEto?=
 =?utf-8?B?alRnU2lvV1FwM0E0OThSTVNYODZrOXhGQWJaRlJGWDRVZTFqUmduWUxFQXl3?=
 =?utf-8?B?R0x0V3ExT1RQUTYxVmlqeHNqSXRGTjdZWjEzZXU5cHgxVEs3UHdiT3o0OTNQ?=
 =?utf-8?B?WGJ5SzczTXdkSTNtT2Y2SDVqbjJMaHNTMUtCY1h0Z2hYVGZ6Q1Rtc2dZQnRH?=
 =?utf-8?B?RDhVdGdxZ2ZVNHV5ak8yczRTTVpsSWdXRlhLTVNGekRjOGxPNTlpVUYrNXpG?=
 =?utf-8?B?blVVazdCQVJvOWFELzNLV0JNTkswNld1dlNPWDhiR3VsNlMzVFlZUGRJNEda?=
 =?utf-8?B?M1FCa09FSEdrbVZRMWlzV0RUVnB1MVhyU0p2YVRhSEZDYUk2S01hZkFpL09o?=
 =?utf-8?B?Qnp1Wm1wUnVsaEV0RDhyT0o3TUFSMzdXOG9DMzJHSDZ6ekFOZE9XbTVtRFgw?=
 =?utf-8?B?RFEzNndhQ1hsRXpjYVdMa3RFTTEzd1J4dXphSXVHQStpZDhVdHFPSlhMcnpS?=
 =?utf-8?B?SjJuVnh4elpvNmNmQy9kM1ZTVm45TnJjeUZudmlJUkJ0K1IxZEx2MHJvM01P?=
 =?utf-8?B?STZuTEFIbm1YMjZKS09IczFiSk5PMHhGZEFlQ0h2Z0Jobk94WlpIcEplakxi?=
 =?utf-8?B?aGZqRUx3MGFEM3AvVlArMndQVDUyN05EQzE4TFBvV0NjYlcxelpMWGo5SUxW?=
 =?utf-8?B?cGR5dE8zSk1QMmk5aFV6a2lRMEl6L1Q2cnozTm5kV21yNDIxTnVIbW0wMEN2?=
 =?utf-8?B?bWZBMjUrSlo3K0hnd1UzRGVLZWI1MHpYaEVzVk5LblJLNnlLUU92VGMybSt0?=
 =?utf-8?B?NUUybi9wdk9POG40K3lIMnB4L1JRdytneFZYa0ExTklUREZNSERmcUo3Y0FY?=
 =?utf-8?B?b1hleXF6ZktianFYQ3VWREpEMXAxY28yZ3JIQVFMTXJDTkoxSFBzYzdnQysr?=
 =?utf-8?B?M1M3UmQ4TnlpU2hhY3Z1bGRmb2djQ2pzMDFpbFN2WDkvTFF6MGFKbUtrN25Q?=
 =?utf-8?B?czd5cElPdTVQdEYxNklGQ2FoWmt0THJuaU9scVE4Y002VE9OWkZmNS9SU1Q0?=
 =?utf-8?B?V1grM2tIMDVZSHIxa3RQMUxDNytsb2YzZ2VyY2xXMWE4S29ZQVFKM0ltb05J?=
 =?utf-8?B?aHhlU1V1NXY0RTlyUGZ3bmZsRU56UjJUdzVHKzEwT0wycDdUMVhJNEVkT3JZ?=
 =?utf-8?B?YU10bE5yeThtY3NYUWZEQUN0RzlkUzFsaGdPNmVzdUNYWm1Ia09WcjBoNkUv?=
 =?utf-8?B?Rk9zclFwbFRpbU9mdE5Gdi9vbk9mcTI5MDJuRDNIMkplT3p6bjMwSGFCTDdx?=
 =?utf-8?B?dzVPT1FtMDdpdUQ5akR6bU5PV1ZoTnhobDkwUjBweENGcE5Gb3MzM3d6VXVo?=
 =?utf-8?B?MjNIcVE2eUUxM3dEckgwcVFqNWErZkhMV2VPdkxJTTdjYTFtcEgyZDJScnBi?=
 =?utf-8?B?WC9hNTZzbWpVckFzdHlWbnc5MXZlVElDVGxjblNNR1BYWnZVK1AzaE1XdTZ0?=
 =?utf-8?B?dC81MmRCMng5cHFNUHFaYVI3a2h0R01zalVGQWozUi9vVGRZRmpSS1piSHZK?=
 =?utf-8?B?ekExS1VXb25aekRzUXNDUHFvOUYxRWR0UW9TMlJhQmdhK2tsY3ljVWF3a21y?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yjzmyPILpdGYw83aXacZEJHsLsZCodeMTGC8BcOVyr0SkVLy4ah/zj/Pw+K1XiUg94wt9hIgu1lzpxdyVzg/Xo8gsQG0umMkPZFUvHKVdqZO6L+1clCY7xwSC//b6lsU3nuY/kfeOCyesmHxSngmQ8pEIjpwcpvUIVGrgR5dZ2APylFnm/Er545t500NTtJ9MiiVcKHBj9tIUNlg2aTi0/eyKOcFJKwoC64va64mJRHsDtk4Ad3v0gV2T4RUp2Q04rtati5JxBxev+nd2F9HPwXj6pLhZ31Z4loKuKg2sU2H+09UapJP2RbrJDmU2DTktBe9l5ku8AnSzFWtoVJnaJpMeCVFX8XoQH2OHhEetz6iIw10HWxPSG04Vwa3Kil3AsL/kogo3MNhMJqnLNRb+UdifRhF6tyQEombY1SjWwqDmh8TepcU1ohyEbXe2WAmDy70pSCjDwEL+iW/nwyaUsS9duUhjJu+4gZsCohMHHPrBS3AvwZuLSq/agckmVZlmUW+6d1NsKB7J69uHWREGAHHm/NbkcWSvnB3VLJvL/I3J27C13EkLhVhndcIWJTWOWrjYxBvu+jBFG/WcuYmjZWIRsC9IJheZzE2vfQOJOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71fbd8c-01a1-4fb1-e5b5-08dce307cc91
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 17:29:41.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sLzHTgJIiDvAwACZKHHABJUB9MUlHTqNhmCGWELjH1XZI+2L43KobrZq/IpjhpQrmg3N34jtUVdIrbEO5T+6LiAUzDu6cJ+N4VqfxamW20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_17,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020126
X-Proofpoint-GUID: xdAU34bc7egabDY-oNWnqyvDoT-xbWFk
X-Proofpoint-ORIG-GUID: xdAU34bc7egabDY-oNWnqyvDoT-xbWFk

Hi Jason, perhaps you missed this patch, since you commented on all
the others.

- Steve

On 9/24/2024 11:05 AM, Steve Sistare wrote:
> Add local variables for common sub-expressions needed by a subsequent
> patch.  No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   drivers/iommu/iommufd/pages.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 9d31df4..6e11189 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -1043,6 +1043,8 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
>   {
>   	struct interval_tree_double_span_iter *span = &pfns->span;
>   	unsigned long start_index = pfns->batch_end_index;
> +	struct pfn_reader_user *user = &pfns->user;
> +	unsigned long npages;
>   	struct iopt_area *area;
>   	int rc;
>   
> @@ -1080,10 +1082,9 @@ static int pfn_reader_fill_span(struct pfn_reader *pfns)
>   			return rc;
>   	}
>   
> -	batch_from_pages(&pfns->batch,
> -			 pfns->user.upages +
> -				 (start_index - pfns->user.upages_start),
> -			 pfns->user.upages_end - start_index);
> +	npages = user->upages_end - start_index;
> +	start_index -= user->upages_start;
> +	batch_from_pages(&pfns->batch, user->upages + start_index, npages);
>   	return 0;
>   }
>   
> @@ -1157,16 +1158,17 @@ static int pfn_reader_init(struct pfn_reader *pfns, struct iopt_pages *pages,
>   static void pfn_reader_release_pins(struct pfn_reader *pfns)
>   {
>   	struct iopt_pages *pages = pfns->pages;
> +	struct pfn_reader_user *user = &pfns->user;
> +	unsigned long npages, start_index;
>   
> -	if (pfns->user.upages_end > pfns->batch_end_index) {
> -		size_t npages = pfns->user.upages_end - pfns->batch_end_index;
> -
> +	if (user->upages_end > pfns->batch_end_index) {
>   		/* Any pages not transferred to the batch are just unpinned */
> -		unpin_user_pages(pfns->user.upages + (pfns->batch_end_index -
> -						      pfns->user.upages_start),
> -				 npages);
> +
> +		npages = user->upages_end - pfns->batch_end_index;
> +		start_index = pfns->batch_end_index - user->upages_start;
> +		unpin_user_pages(user->upages + start_index, npages);
>   		iopt_pages_sub_npinned(pages, npages);
> -		pfns->user.upages_end = pfns->batch_end_index;
> +		user->upages_end = pfns->batch_end_index;
>   	}
>   	if (pfns->batch_start_index != pfns->batch_end_index) {
>   		pfn_reader_unpin(pfns);

