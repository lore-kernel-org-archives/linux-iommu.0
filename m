Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47B168CA
	for <iommu@lists.linux.dev>; Tue, 20 Jun 2023 15:02:15 +0000 (UTC)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KBPbun008553;
	Tue, 20 Jun 2023 15:02:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=hnAopEaUbVqMd8cWRz+/janMLInXPDn1HHteTAjpUrE=;
 b=zI5k/46SQmBE1sq1Mi9GbkRpJUE2kZlkbD9BeAxvCvEe+62gvovGKPd+OFqXqLJxBowL
 EwPwVK4NNXtdb0SzyKw0X3gpyfkRQL9dbBMfN5FFJJfyPa8NbgOlWCtR8b6MN5WgsfsU
 X3Nm/0M21+QtzhYWbUmsFQCfXipulhSMJOt65VV+nkt6+hK46bhHz6s3BYcGJadYcVK1
 PZMDH84o1pmGFWxmNHfQolOQGJ23DdpNDhGcnpP1/ydI5tnis+YO7Le8/uqJYEL3aAXs
 70Z5YRz6rZgnbvS/cceqQ2IHote2cgcHiQay7c2Dce2sBmqbzw5hIs6VgBuZgVBQYfB7 Ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3n1u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 15:02:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KEIVWo033612;
	Tue, 20 Jun 2023 15:02:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r9395puaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 15:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbEAbl8ePOROgOhW2T+388qWXwi/G5Du1xA5d3FmgOIAlQSybyZhLCHIMHqfhW9GhhUNBaejHxiOvtfTuAvX4VCaCLUUbzRwDD3MVYkvYOOZI243oUV8lxwRovBpLcxMe023LAM7au4pFPQQCyArNgI3Lg44eZ7hYVCCtaP/f5zdYdC2BHErx0RWFk/7n7ZG9yw3p55U3z4AdUX1wnvHQZ0XUC1S05OXE2qzwWXFRIIaQqFrHRDMxrtO7oJiKhaUjjbL+3J6o2bzO9fqcBndp57gQNXgtv/AtBTRyeQ2b/PWzAWxqhGdValFe2iPfcQLwK35vMCeiOHFWJzrQHMCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnAopEaUbVqMd8cWRz+/janMLInXPDn1HHteTAjpUrE=;
 b=iDZ0d/tLD67pImz33wm7Zkjg4QN+hIx9OvWuz1dvhyV1hst07XbcDDIlfXfjFIyKGwrlvt4Vd7rkA+BA2aP0R0Eo9XmlcGutRGFFKCbjDTMGI6hAj0Sj3tM02eH7mgcEFx6bB1UR8bWoGD7bomdouVR+gjAcSS+vhVhP8p8f8scVwpblPGWkrCX+RzDg49OcvsFI2qgqlqv5yRPgGBEJ2fAhn8pb3PdregbtZ8VjR3CS0bit3cJqXeAomFokcLEK4VDx9IQTnYjn4eiVGfoW4pyitdD+JkIlXZmUYwojuZNQkWDm85e7UQmyVh7itEODU/kK922oB01VqXTIF1i2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnAopEaUbVqMd8cWRz+/janMLInXPDn1HHteTAjpUrE=;
 b=uV4rhWL1IAXHQUQB3Pqi5nU1tXcHLnbbltUo4zcZn79LQI6GqEfARf3FDf4ufPlHmmHMYGPZfJ5ppUOq3vp573XSoIJ32KOkVjIvTsCL5aeoOQniDRKx8hE44JHT6J5ExMmPSyx1IjAaC3B2V0g7N5XAuCrMyMTGyimfNQzMatI=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DS7PR10MB4909.namprd10.prod.outlook.com (2603:10b6:5:3b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 15:02:07 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 15:02:07 +0000
Message-ID: <5532b0f2-3e9d-c4f9-07bc-7c07db8bb1ca@oracle.com>
Date: Tue, 20 Jun 2023 16:01:57 +0100
Subject: Re: [PATCH 1/2] iommu/amd: Add separate interrupt handler for PPR and
 GA log
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, joro@8bytes.org
References: <20230609102025.6498-1-vasant.hegde@amd.com>
 <20230609102025.6498-2-vasant.hegde@amd.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230609102025.6498-2-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0035.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::14) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DS7PR10MB4909:EE_
X-MS-Office365-Filtering-Correlation-Id: 40526098-5cc3-41d1-fa74-08db719f4e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FKdnd1ey/jLsTFb9oQpnlEmnZNm5MqlU0G3OiUwe34uhfP07R5giLaRnpifPZYHcrCUuhe3NuwRGISm0RzpiOUxuY0dCe//vyl8ohwFMK/iHC2b2jrsDQf0qIMDRNb7oqKs+CySzIXsDnf0U+wfCNCSaAYVdB1mE5AOD82DRPeFlXcuTtHhsl5MDEcGU2eA8azYqa8chmo9VZHKJclf+aMmW2HUgzva52Y2JsNGuptDAA8qmTznDzp78s8VcE729GywakgJ6dBKquBePs4totvSApyjALUUQIOMbOmvqt65/jhGoItE15EwS+VP707a3gXB//dJ3/WXSu2KIBwxTSAvJhnpWd+h4+nckgWNrB8NMdk4KhneG0Ts8+PmwwwUVU9mZonrFZCSANx/i92T/6pIWAkRDolpFlB1f4wq+lcwNKAoVpdwcSNlSI/wgZ2Mx+AaZr/A0f9iFUSqp4Nc1mZrz2XnQgtVcjB1IzuBEMttlyWrPaEoaktYBynUZObQR1NX/ltyyZeiAhEX4DMp7OqzcECKf8PoAQ0m/lHK2nVwF5chA9nOktRm1vBjtUfSGCYeQif/f34SvN9zAuZSAYWHFwUvbsAo6Gpen1e3+xJMHLGMo9BqGOne4XKiQ6MV2
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(478600001)(66946007)(66556008)(6916009)(31686004)(8676002)(36756003)(41300700001)(66476007)(4326008)(2616005)(83380400001)(38100700002)(31696002)(86362001)(6486002)(5660300002)(2906002)(6666004)(316002)(8936002)(53546011)(6512007)(26005)(186003)(6506007)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U3ZjNG1HSi9NdHErbXVIekc2NjN3VjFlR09HKy9rME4xWTRuMUN6QmphN2lR?=
 =?utf-8?B?MSt2VU9ORTNwKzZBTlRZN2Y5bDlaYmV5RVZHamNiNFBJM3Q1dHdMZUlRbEcy?=
 =?utf-8?B?L2xYV1BPVVZnbmVZdU0zS2Z5NFh6bkhYK0t1WVVpQzZ3WUZOUVZtajBVa0c5?=
 =?utf-8?B?YzNYdFlud2twek1vdzJsSFFqSkx3RlBBRjhOa2hEbXdaY0o1YUJuZkhMSHYv?=
 =?utf-8?B?dVFMc0VYRm9CWDFXZWs0bGhpSXY0RDI1dTA5d1B4TnhCOHIzdC9XdUNrTzBU?=
 =?utf-8?B?QVRCZXZySzFkVXk2bG56TkhXQU9NYlhSdGVDMGxUZW5RbndSZWhMcUFDMW8w?=
 =?utf-8?B?d1NZL2JaREc2YzhPYW5wNFNWcXYvYWlzcDBLaDFNdTVMb1JPTXZPcjNUN1Iy?=
 =?utf-8?B?RElTV2VtWllEVjR6bnU2dVhlZG5wTDZXM1paOGs3U04vRG5FS0FCM1JtYVlB?=
 =?utf-8?B?bFNid0JCS0xXdCtoUGpFLzVaMUZOSTFVTW43V25yeTZ2QVpHUURwZ0R4YW9v?=
 =?utf-8?B?cC9GMVBvUS9uSlZkcFBEeEtQbm9QSXJrTEJWV3RITEpycm9BV1ArbjIxQjFv?=
 =?utf-8?B?MHc3L0FRRWJDNFdCYlN0cWh5SUUwK1dNUWpSZTEvK2RyeVhvTEFYM3hqOTN5?=
 =?utf-8?B?ZS9UckxCaFE0TUpwMjlza0hJWnhkOHppN2N0eS9aeVV1THg4c0RNdjhlTTVY?=
 =?utf-8?B?Zk9IQ1JweFl2L1RlNUFuTStFM1hvRC9UMkFPdWJUM2NKS29JNkJBdFJaRVNZ?=
 =?utf-8?B?Mzh0ZjllR0RBZzJqaXpoOGxmWERHOVhUbGNHMkUwelJ2UWhVK0NiblQxOWdp?=
 =?utf-8?B?U3YwQmZsdThEM1NiQ1JpMnRrZ3JhODdLVzNHTW9BZEl6UC9HcG1EcHEwVm5k?=
 =?utf-8?B?S3NwWUJoRFpTK2VaS0FXZmFuMzFHODgzRm50WVF4ODdQVHIxTldTUHhyRUo0?=
 =?utf-8?B?YmNjM2pKUittNDN6WFNNRXlZQldKeEcwVzhGWW1DNmhjTGNoTGRDb0tuNkpp?=
 =?utf-8?B?aTl6cUhiMHZ2N1ZpL0RDZ2tCWFVEQ1JxeVowb1g1Y2Vzdm5TMWt6R2hzSFpv?=
 =?utf-8?B?UUUvMFRSNUFzRUgzTldaNFlLUDNkQU1DT3U0UG5UMGpPQWlaeUt4ODJIMC8x?=
 =?utf-8?B?KzlrNWVaeW16elJQVVFBZXpWS2xDUFFRMVQ3OG90ck13bDdmYmIwU3h2RTdr?=
 =?utf-8?B?bS8vdjVDczFUNmRWYWYvTW5Jd09TczJjcDFOd3Bvckk5YjVYUzZtT1lETUEw?=
 =?utf-8?B?YkhYQW5raGx3UGxwQXgwc0MwblJlS2s5aWtma0lGZ2dlWlVJZDJXOGxUNFRO?=
 =?utf-8?B?SWRodGRWck9YQkFsMlVzc2Fzb0xScGt6OHpCZW5WajVkMHBPZFNsMFAzV2pa?=
 =?utf-8?B?OVhWUTJ0bW5KUUlXTVZOR294RklyUHJHdWg3eEdrcndvdnRPM0FhR2U0L1dE?=
 =?utf-8?B?R2MxQlpocVYrS1c1aUhZZGg1YmFPMGdTa203NTNkdURrWnZZQ0MxWVIyNTJo?=
 =?utf-8?B?dU83WHQ0SU92VjUrNEFaTUlteFBWTXZoZDNGNGlwRzNFb04yMDRMZGpCbm5B?=
 =?utf-8?B?V29XRVNUWHIyd0hZVk8rdW9BM0tuMjdQTlhWWmlvTUkxWks4T0pkbGhoa3Mz?=
 =?utf-8?B?RUpDbDJKZHhlRVdvTDQzUDZJWjdXZ1pyZ1lkczUvQnVqZGN4QVRoOTJFTktX?=
 =?utf-8?B?V3NyRktheUZzMEFPZkp3ZnVOdWUyNEdRM1hSekk3enNOTy8yUzdTN0dYSlRQ?=
 =?utf-8?B?NGVYUEdndFVOU21GaWF2aFJoSGpaYXlhM0FMb3lDMFBXeHgwMllSOHlobEY3?=
 =?utf-8?B?VVVVc0JLVTZCYjVZZFNWYlBHMUc0TGxRd2ppOHRxVUthMGMyeEtDQnprOEY4?=
 =?utf-8?B?cnAwNlkwbks0U29iODl6UUZnejJmSEJ0M2QyZ0NWcStlY2s1S0d6cmh5Y1Y2?=
 =?utf-8?B?RkFMdkp0djROWDU3aWE2VXZncU5iMTRFZzM5b1RRL2VqL0ovZFpLRCtaRmV2?=
 =?utf-8?B?VTFWTnV4dW1pajlRa1d1MzMvTDZsbE5rSmJjd09QRjdBZEYzNlVvSWx1Ukpq?=
 =?utf-8?B?UFBMUWFXdU9xeURPMjlXQUUwdmY1UXV3bFdFUmFRTWh1c3ZxUG9KaXlFYWlk?=
 =?utf-8?B?K0xJWHBLQmp2eUdvcTZOY3VoamlaU1dKWGZ4czFXOTZ6Q3M5S2lzTVl6WExt?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+WxMox4KQAUouXfyK8wuZW6HH9KX2rWkvbgz0UhfwWyvQXAFdrRI23TKoC5dL/88qaOe22z2jGzrBy/V0ZzvKxv13W6vqCGLUaeWgINk46zl02AfMC97esjucX2XuCZ2XsK5hzCWeehMOnipEEmrBJ6kAkcDZggCg0qof0kPUXuHbcMLtEQ6eZf5z4pL9wMtyP3u9FuusQ5+3YI30tQUwIe8IzFLpZXw0FldU5dbAwVHA5xG6FRdmX8KaqprDmrke1ELSgDlf53PP9k8ArJQ8ihs5GarKj0pFb/R4qaY4fXhc4vvfgGqnAeC2jDBPtZPNps5rjvUs7Ct56zCQGLc9VJ4eWobVOteU/fBg4nGZUPLNgCMqUUwP9sjgjFU5iVSDpT/glMpg5iWMVWMuDtYn4zYvKpKiRmyqcWHqeuRyTJpd93fIYIJloTC64q4H4h0IWlCbfG/BB8pWuZe0r979PENqpFPZm0pFJ7cVZC3jJkXoiQDkwqCoqTK3fCm/V5evpxEZapILfzInrqMwSVucfwpeMjGEM5rzCDNybmvytsqSM2phh2NFTAgAnIfn2mY+S9XquTXmAC7KwqE+fKw/UWgwN/uw4hs/bOnOypcQaAXXmk3InpAiPG5Mo1OpNHg8C072Y6is89ZOPu+4KkJq9XVy+s9hWQyiQQiOyAuI4LVM2yOMg6MNt+JIPXSywmwhlLep1fTP4bAQyc8JknLaxBG/+uXKMHTs6DYiGGVZIC2jQq+nhniOhY6Wj7C1JSMBsmsVNx2F4Mv32wl5xX3KAfdyb+RxSD1a8Jo8mFumd4K6Rdlf2LFJxxFJt87DBcP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40526098-5cc3-41d1-fa74-08db719f4e0a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:02:07.0669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyQdlqXTvmh3WV/Hk4UcHJWjKC6rhca5NGqdiMvu7WMZsU5vYqr5p0Fk7pINA73lEwGmIETjzlChvOjs0b/+fXXUTZiE7H1SawF1RM/7gOg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200135
X-Proofpoint-GUID: 3v5aO8i5y37D0-g5Jjtmw6N0DIvQZIq6
X-Proofpoint-ORIG-GUID: 3v5aO8i5y37D0-g5Jjtmw6N0DIvQZIq6



On 09/06/2023 11:20, Vasant Hegde wrote:
> The AMD IOMMU has three different logs (Event, PPR and GA) and it can be
> configured to send separate interrupt for each log type.
>   - Event log is used whenever IOMMU reports events like IO_PAGE_FAULT,
>     TLB_INV_TIMEOUT, etc,. During normal system operation this log is not
>     used actively.
> 
>   - GA log is used to record device interrupt requests that could not be
>     immediately delivered to the target virtual processor due the fact the
>     target was not running. This is actively used when we do device
>     passthrough to AVIC enabled guest.
> 
>   - PPR log is used to service the page fault request from device in Shared
>     Virtual Addressing (SVA) mode where page table is shared by CPU and
>     device. In this mode it will generate PPR interrupt frequently.
> 
> Currently we have single interrupt to handle all three logs. GA log and
> PPR log usage is increasing. Hence, split interrupt handler thread
> into three separate interrupt handler function. Following patch enables
> separate interrupt for PPR and GA Log.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  3 ++
>  drivers/iommu/amd/iommu.c     | 98 +++++++++++++++++++----------------
>  2 files changed, 57 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 156f57b4f78c..e2857109e966 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -12,6 +12,9 @@
>  #include "amd_iommu_types.h"
>  
>  irqreturn_t amd_iommu_int_thread(int irq, void *data);
> +irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
> +irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
> +irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
>  irqreturn_t amd_iommu_int_handler(int irq, void *data);
>  void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
>  void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 3c179d548ecd..d427f7e3b869 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -841,57 +841,23 @@ static inline void
>  amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
>  #endif /* !CONFIG_IRQ_REMAP */
>  
> -#define AMD_IOMMU_INT_MASK	\
> -	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
> -	 MMIO_STATUS_EVT_INT_MASK | \
> -	 MMIO_STATUS_PPR_OVERFLOW_MASK | \
> -	 MMIO_STATUS_PPR_INT_MASK | \
> -	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
> -	 MMIO_STATUS_GALOG_INT_MASK)
> -
> -irqreturn_t amd_iommu_int_thread(int irq, void *data)
> +static void amd_iommu_handle_irq(void *data, u32 int_mask, u32 overflow_mask,
> +				 void (*int_handler)(struct amd_iommu *),
> +				 void (*overflow_handler)(struct amd_iommu *))
>  {
>  	struct amd_iommu *iommu = (struct amd_iommu *) data;
>  	u32 status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
> +	u32 mask = int_mask | overflow_mask;
>  
> -	while (status & AMD_IOMMU_INT_MASK) {
> +	while (status & mask) {
>  		/* Enable interrupt sources again */
> -		writel(AMD_IOMMU_INT_MASK,
> -			iommu->mmio_base + MMIO_STATUS_OFFSET);
> -
> -		if (status & MMIO_STATUS_EVT_INT_MASK) {
> -			pr_devel("Processing IOMMU Event Log\n");
> -			iommu_poll_events(iommu);
> -		}
> -
> -		if (status & (MMIO_STATUS_PPR_INT_MASK |
> -			      MMIO_STATUS_PPR_OVERFLOW_MASK)) {
> -			pr_devel("Processing IOMMU PPR Log\n");
> -			iommu_poll_ppr_log(iommu);
> -		}
> +		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
>  
> -		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU PPR log overflow\n");
> -			amd_iommu_restart_ppr_log(iommu);
> -		}
> +		if (int_handler)
> +			int_handler(iommu);
>  
> -#ifdef CONFIG_IRQ_REMAP
> -		if (status & (MMIO_STATUS_GALOG_INT_MASK |
> -			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
> -			pr_devel("Processing IOMMU GA Log\n");
> -			iommu_poll_ga_log(iommu);
> -		}
> -
> -		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU GA Log overflow\n");
> -			amd_iommu_restart_ga_log(iommu);
> -		}
> -#endif
> -
> -		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
> -			pr_info_ratelimited("IOMMU event log overflow\n");
> -			amd_iommu_restart_event_logging(iommu);
> -		}
> +		if ((status & overflow_mask) && overflow_handler)
> +			overflow_handler(iommu);
>  
>  		/*
>  		 * Hardware bug: ERBT1312
> @@ -908,6 +874,50 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
>  		 */
>  		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
>  	}
> +}
> +
> +irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data)
> +{
> +	pr_devel("Processing IOMMU Event Log\n");

Similar to the overflow series you could probably move this pr_devel inside
amd_iommu_handle_irq with a const string as an added argument (...)

> +	amd_iommu_handle_irq(data, MMIO_STATUS_EVT_INT_MASK,
> +			     MMIO_STATUS_EVT_OVERFLOW_MASK,
> +			     iommu_poll_events, amd_iommu_restart_event_logging);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
> +{
> +	pr_devel("Processing IOMMU PPR Log\n");

here (...)

> +	amd_iommu_handle_irq(data, MMIO_STATUS_PPR_INT_MASK,
> +			     MMIO_STATUS_PPR_OVERFLOW_MASK,
> +			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t amd_iommu_int_thread_galog(int irq, void *data)
> +{
> +
> +	pr_devel("Processing IOMMU GA Log\n");

here (...)

> +#ifdef CONFIG_IRQ_REMAP
> +	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK,
> +			     iommu_poll_ga_log, amd_iommu_restart_ga_log);
> +#else
> +	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
> +			     MMIO_STATUS_GALOG_OVERFLOW_MASK, NULL, NULL);
> +#endif
> +

As you and Jerry was discussing the else is probably not needed. Although it's
probably easier to just move the ifdef into the function below (...)

> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t amd_iommu_int_thread(int irq, void *data)
> +{
> +	amd_iommu_int_thread_evtlog(irq, data);
> +	amd_iommu_int_thread_pprlog(irq, data);
> +	amd_iommu_int_thread_galog(irq, data);
> +

... here. Provided the code was before was behaving similarly and in theory you
wouldn't even setup the galog IRQ .

>  	return IRQ_HANDLED;
>  }
>  
