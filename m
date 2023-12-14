Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84D5F1E8
	for <iommu@lists.linux.dev>; Thu, 14 Dec 2023 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+RaVc9o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j7E7k6X/"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE9xFdI001158;
	Thu, 14 Dec 2023 16:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QZz7gOSpcE4Dqmk7BkB3acixvhIXSSjICDSVYjYjZ44=;
 b=T+RaVc9oQuu/gqrswTAe9wYVchSTlqiPv8UxGE1+lAMfVRdMzwA9u8zf24mi6DoANdHA
 kj8N+ZwfLsKTpXKIICOL0YDfFcKilagqgOG8ZWSzMRmxK4zsTk+6lqUA+t7KzRVg6m4K
 qse4XFJfx60aMv8jN6F8u/5FGUuwD9czbbYiViH7mUlAJMU7Kw5MvNAWY/uO/xsTst1q
 j6TUQ12Ai0nAOUiUvs5hNUIY6oVUzh4Kfdq9s/ZR633OmCCKVlGweF6q/c0zlKMhODnI
 EKePgJ3h8G0uSe/MMXLjIXT4uvXOZsafwl/Sl2AdT9rnCDAh2tW0rvcpGe3e1HRCxFjN gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvf5cbbka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 16:23:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEFOMKY009865;
	Thu, 14 Dec 2023 16:23:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepacf8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 16:23:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6ody9tyVukVU9keV3KXKqJ2nJZM+/Q3OAj3u4xQY3O2BwUX/twAjDsnjptptO7YY7mIumvO+7kU3VfNDxZuMCwPnBZJD0o+Y7zcSqoS102q1F278qLyZV9MEuVCSNfH8A1IDbUkxrkSTUKkE1EjBo+lV/e000aEMKrHF1pC7QV8MyGdW/3cgHvnZiv1hnEv4EHp1zzHv1EGhGqdENMLpk0Txu/e63qZyVV5WqG8bQdSEZ82ejEZbU3sLUnQFpp/BZNZxleyLloZzzEjM/akBkfu1h3HqM7GvH+5Gvs+HJonPejnKZFCWZa8WJtGTJ0T3jKPIe3LbEdxfRd4lXv5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZz7gOSpcE4Dqmk7BkB3acixvhIXSSjICDSVYjYjZ44=;
 b=jeI6zgFCg74rCLVMMcvUVMglNAH8Pxhi9NAEZH9BMEGRJoxtbmPhbD20BtOdY6AJMiWLPUGEFuhb/tgWX3B7dtW7hHHUIpknmBED4WjjLhqsnSRFgHQtzDX1kpiOOstEqUs/S4eZSajYzHlWCmX3n3u7txOE3HdmLfenXm7lIx99WXQV3stu5iB64YHz4qMO5etl/dtIihJdngxFHL4XB3mepUfKGJ/KSUev+R55NAGZn4oRO7A1n3jvWpE8ABXduR5wUTMtfwnzSetGvVobsTOknd15MdTxS+jLNx9cgXpkvCLt2eAFZybIvw/G20yw4hwikru07BdBWlF3rIKM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZz7gOSpcE4Dqmk7BkB3acixvhIXSSjICDSVYjYjZ44=;
 b=j7E7k6X/gnce8GlxtePkAXAUr7Dq4HBYNVBCMHSZVg1UPbvDKpPfHTLl0r5aHxDKp2MaWkXxlxyz2ps2dQvv2TcvlfafDpAgu9SYi0jMUPwBZwQO5m7SKKO1VRs2k/yKWUIVv+Ovkkdg5jFFSe94c1Bbl4CrOfDsLsfj/2a+hN0=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by MW4PR10MB5837.namprd10.prod.outlook.com (2603:10b6:303:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:23:40 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::cd3c:99d7:861d:dd19]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::cd3c:99d7:861d:dd19%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:23:40 +0000
Message-ID: <c9354a08-6aa5-42db-b8b5-44496eefb76f@oracle.com>
Date: Thu, 14 Dec 2023 16:23:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] iommu/arm-smmu-v3: Add set_dirty_tracking() support
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "mshavit@google.com" <mshavit@google.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        jiangkunkun <jiangkunkun@huawei.com>,
        zhukeqian <zhukeqian1@huawei.com>, Linuxarm <linuxarm@huawei.com>
References: <20231128094940.1344-1-shameerali.kolothum.thodi@huawei.com>
 <20231128094940.1344-5-shameerali.kolothum.thodi@huawei.com>
 <20231129194235.GC436702@nvidia.com>
 <d80cd067b57345609a198aac5780e6af@huawei.com>
 <20231130125412.GH1389974@nvidia.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20231130125412.GH1389974@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0031.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|MW4PR10MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 94fc6e55-1084-402a-69fa-08dbfcc10837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ODN2A9gghszmo1SFHV0j1FCyKYRQAjXECMc3yMT4Bik33Y/OA4jv5as2+VllLxNt4J7f+GSqBMEZJnBkRr+CHVbYbfmRAbGbbrH//F27tH27oF4VDbTnhF491wvS19Agx4AgfTPKcI6Sj22NZhzf1Z9xmEolLwNEkZXbinzHLAnUpH/htCJhBwzwQR6XuHLO49Yl01CYou4soDdoFDyLBPK3ug2JI+8FtCB1orQvHHwp6iEuP21pPag7o21jcfu7nWql6PRVs0idf+GcedDoNJR6W+8Vti+4ooNYYFCrva/hA8Hi8vxf/bwu+SbCE6Rw+ELETRVzFdE19GhAhPEky03NZ4bpZ4KoESym3R5tHWfqKhmhV7f5tbVR0wvMdwRsXZZ7mEl+bMVSfJzMTYAK0knO6v9gWFlXhWGr8XLLVLVC2JSsmcQzHxUNrvWNYy+efZlTy2Kg5PD3PD0M8hRgpvuK4XuBFvBdIAzjOGc0M/wyz6IWO2ICXlfNIB5jxLt1b7GWlm2FNBNTNulL5La0eBxTGyfpqS+KBmV0qs0Ui12mouPszy0RTWx7ZcTiqizUk/hd8HR+Lyuj9vnE3c4dzUbsdx8J7zp+U3s0lOuNu4XxNt0FBb1j12v8/2cf/baygs6I4/B/PJ+R5vAEhZTA07nI08M73ijkwXo26ut7p4ucDgQhok3+NHIeg3Swx//6
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5893.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(478600001)(6512007)(36756003)(966005)(6486002)(26005)(66476007)(54906003)(66556008)(66946007)(110136005)(38100700002)(6666004)(2616005)(83380400001)(6506007)(53546011)(31696002)(316002)(86362001)(4326008)(8936002)(8676002)(2906002)(7416002)(41300700001)(5660300002)(478994003)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTVpcFJVdHZ1cjRUYnZSaWZGbk1uVGVMa3BETHI1aVJkM05NMEtmTHZBcitS?=
 =?utf-8?B?bEU5VC9SKzcxVjdZRW82NS9IdUJYMk9Ha0F0bU9DK3NxOW80MnF0SXBTblN2?=
 =?utf-8?B?Nko1SjdpMFk2Wi84L0ZFOTlycm9hYXJWdzA1LzhLTVowb1pwYzB5dWhBOS93?=
 =?utf-8?B?YUd1MXBwc0FlWGJLUkhZVUhmVUpGajdoeEQ1bTEyeE9vNTVWQW5FSHRHbnBN?=
 =?utf-8?B?K0RMblVOUEVTdHU1STJaeWxMcjdMU2FnTWdIMGpjQVVhRGhNdk5oSjl1dUt1?=
 =?utf-8?B?Y1NiVUpTZmFwYUhtUVpaRWdVSHJ2TW9GTjEvcmFPZkQxTUJxRHVUUWNMeHBn?=
 =?utf-8?B?czdGcEVXR1Y3aGtzU29KY0ZCcFI2NGlIVVJSQlpLVmJibDNNT3ExRmUzYVo3?=
 =?utf-8?B?UVlDS2crQU1BU3J4Szh1bzhzUFRxeDhKWEQrWEZsZGh3THFTdzFRSXlmTk0v?=
 =?utf-8?B?YXpaVkxmOSs4WllaZXNwakZjcXpyRG5XdDJmd2lTcjI0cUExOEQwYXdNLyth?=
 =?utf-8?B?N3FDN2p4YndJRjhuaHYzeCt3OWFBRURPbkUxRnZKbmZWM09DQzkrOTlhTU8x?=
 =?utf-8?B?SUZKaXFwc01MUGM3ejJjNUhqMndqSlZQbytHWHhGTi82OFZVb2VxQjdQeS9l?=
 =?utf-8?B?dDNDTUx2NllWZzNSVG5zR3oyYms0RnlWTnhMbFhuT0xTNlV1Y2NGQkJlZGdS?=
 =?utf-8?B?OUU4a1hLaGRLU04vRDJVY0hjNW42cTRuY0tkT2pqS2ZwSGE4YzZTOWZCdGFw?=
 =?utf-8?B?Y2J4b25SMURyQ2YxTHpxSnVheGpmMzdhdHVNSjZTR3hqQllQMk1qZzdsV1dC?=
 =?utf-8?B?dFEyN2U3aXhrMW5RV2Y3TlNBZjNoRGdmakFvMFFEbTBlOURaUGdSN1oxenVi?=
 =?utf-8?B?OHZuUHFTVjRsV09TQ1RPTDlmZmJLbVNHRVpXOUFvMEdvMUpLVk5aeFZWODgr?=
 =?utf-8?B?OWYwZ1hxTll2aHYvVWFHc3Vnc20xYWpaMVphcEZnNFZnV3liekhpRDN0NGZz?=
 =?utf-8?B?cDhTbVV4WnZKTkQzeU53Zld0Y3FlekxmWCs2WUlYZENDaWE2UWExSnJkb0xy?=
 =?utf-8?B?WU13Y3pTSXpsS3VMTjg5WWMzbzhqTVRiT2M4bTZUSllIUWZPa1hlSXhreE1F?=
 =?utf-8?B?YTAvYW83eDRldk02eXFndE9wLzJTK3paWVk1dTVWZmZ1Z0t3UUVOOVZSTWVB?=
 =?utf-8?B?QmdUQm1BT3FLVkZtS3Vlc1BZVXhGNGlNcUxJL1gxVHBLZUc3TzNoVFpXM0Vk?=
 =?utf-8?B?ejA4QXM2ZllBMkh6aWJNdkNFMUV6UDRRL2xLalZ1c3hzcldGNWV2RGVuOFFz?=
 =?utf-8?B?N0NCM01GZEk2dC9oU3lCcGY3QVlFbXNFRmNVMEIwVmtkMDhJNFB2S3VPQm43?=
 =?utf-8?B?YVQvM0V6QzJ6N05UYkVaUTZKWklvZHp6ZVB1R1d2N1hPbk5TM3lYZkRQQzdS?=
 =?utf-8?B?clk5eHJHS2pUYlA1RUdnc2FuZ3lsUWJmYWZBaHRTMFZpWSswcGdmdEM5YlRr?=
 =?utf-8?B?VkxaRHJ4bGUrWHU1SklNSFhwMHRMZlZaWXJRN01QeHhKV0d0TFFueDZwOCt5?=
 =?utf-8?B?STNOVWt2dHRSK05aSUJrUlJsckpoN3kyUXJseS8xWkhEeFZweHhKOFB6c0ZC?=
 =?utf-8?B?RGVXNndTUmFrcStPcVJFeWtLR3ZjZWpLeTdDSCszM1N4djhPUjV0UktEQ0gr?=
 =?utf-8?B?cGl0YWlmYS9YOC9OSms1bnhhUFFNc0kvb2pkYkxLUUk1OG9QbEs0N01yRUlO?=
 =?utf-8?B?cHJhR2NOOVA3RnZ1RlJOSDJjcHBOUUdTTkZSQVM0WUxmbDA2Z0JZVWVoOXd6?=
 =?utf-8?B?ZEtXN0FXWlNDaWpBWHJxaENyTGx1YzNFS09KbDN1dzU1NGRONG9WZGk1MlQ0?=
 =?utf-8?B?d3NPS1BzVEgyTkRDTHV2Nzk0VGJyT1JaVENRZmJIYTg0UXhDbXFaalViVXgy?=
 =?utf-8?B?Y0lvYllCNmVsZ2RrTkdJTVNkU3NMdDNMcEg0WmhqeWQ5NHpyYURDM2tBTVRK?=
 =?utf-8?B?NEFTeFczZ203NWVQVUZRT1V2WUw1YlNPMVZlN3A5OHF0V2xDQndwT1R0VVU0?=
 =?utf-8?B?OGZmSkQzMVMrcWJ1T3JnWkFBbXVmY0tSdjB6ak1vY2xjSmtlMmZaTkhxWjNz?=
 =?utf-8?B?VTdWMnJmSlBNV2ZKYWVhQStSQXhwV3htQm42UWRmU1FYdENZUGo3MXJPQ3hN?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WSOlyF6g90WeYpfSs7vEPYfd/0gGnMpbWRgWfv5utZEI+D8koXjhtkespTD5Jkz/5Rl4kYK7SbfdiWwGyt1Ceq38bwki6yA8KZvGuoAmiAKGtofQG357wxlP5gtgyGfvsgdpAmn7WPIJKXhPi1fea/YDSSJCeEti9eD3y630XjeL3cqzeWjMo7xC46MewUgE8JzzItE92Q/fb3vUmQ3njPdnRw0PPrHvlnGaF00+h85wRfOZP+UubrBex7uYCVCX0v4oOVp3FbT/AET82/y/cmAl8d6881tqfagvIgZf+62dieiI5GrXiH/qC0lu/RyiZ3TFgEU4dSHoMpJBf/WZgOPOAjLxHaCvyy2FORe1C0cVlhc2oG0LUn87whFsARPInOXdy2MbTMmuWUMz7Zuss3XYlzfkoN4C58u5sZzrnuyRAl/2UwLTrBA90gU3jfqhw2PPr+w/e0tKRn+ybaa1kJAw/bDXfq9gjbMh1uO9e0JrXeaVlV0GT7VLodJvpNeLwjI+PJNIhhkm1bVVf/0CSwqZL6H/rKmxhpH4l3Q6ms11R+TYRurZHBgsMMpRZTzaVIoSi/yUgiNgPZUBMLQ59sBZx1810ASNzDkjb3H1D4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94fc6e55-1084-402a-69fa-08dbfcc10837
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:23:40.2633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEzcy5ehCWOBMkk63QND/aYVI43kp7w4Y2x8TuyqKKD/+/nkCU9uTP75CyfCBo5kHrp7mx68dMeUDU4MAaa5GxU5oZ6qit5cPxoRpaT3QXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5837
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_11,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140116
X-Proofpoint-ORIG-GUID: Ysr9Qz5mfBQzgE8kiR4n25_eUYBYahKU
X-Proofpoint-GUID: Ysr9Qz5mfBQzgE8kiR4n25_eUYBYahKU

On 30/11/2023 12:54, Jason Gunthorpe wrote:
> On Thu, Nov 30, 2023 at 08:56:32AM +0000, Shameerali Kolothum Thodi wrote:
>>> On Tue, Nov 28, 2023 at 09:49:39AM +0000, Shameer Kolothum wrote:
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>
>>>> Dirty tracking will always be enabled with DBM=1 modifier enabled
>>>> by default when HD is supported.
>>>
>>> Is this trying to say that ARM doesn't have a per-table global enable
>>> for dirty tracking but instead pre-sets the DBM bit to avoid the cost?
>>>
>>
>> Yes. SMMUv3 has per-PTE DBM control and I think the initial RFC had
>> it walking the PTEs and setting the DBM on set_dirty_tracking().
> 
> set_dirty_tracking doesn't have access to the necessary locking to
> touch the PTEs.
> 
This is done for free by iopt_clear_dirty_data().

set_dirty_tracking() is mostly a nop, under the assumption that dirty
tracking is always enabled.

>>> So on smmuv3 to enable we have to clear everything and disable
>>> continues to pay a penalty since we don't go and mark all things as
>>> dirty again?
>>
>> Yes we clear everything on enable. Sorry I didn't get the second part.
>> We don't mark dirty on disable. How is that different from Intel/AMD?
> 
> Intel/AMD have a global switch so they just turn off the tracking and
> stop paying the cost.
> 
> This approach on ARM means once the tracking is logically turned off
> the HW will continue to generate memory traffic to set dirty bits on
> DMAs. There is no way to back to the at-start state where their is 0
> memory traffic on DMAs. Not sure that it totally matters, but it is
> worth noting someplace.
> 
> If we do want to solve this then ARM would need iommufd to make a pass
> over the page table to set for disable similar to how we have to clear
> for enable.

The firsts attempt at this had to be dynamic[0].

Like set_dirty_tracking_range would pass over the io pagetable and set the DBM
bit to enable dirty tracking. It was suggested that we switch to an always-on
mode to simplify initial bringup of the feature, and if the always-on was
somehow affecting DMA performance, we would re-attempt at this dynamic mode
post-mortem.

With the current code structure, perhaps having set_dirty_tracking() do the
DBM-enable pass we would need to move iorw_sem section to include the call to
set_dirty_tracking() and smmu op set_dirty_tracking() op would walk the whole
pt, without relying on iopt areas. Or we go back to iterating areas similar to
[0] with a new op.

[0] https://lore.kernel.org/kvm/20220428210933.3583-16-joao.m.martins@oracle.com/
