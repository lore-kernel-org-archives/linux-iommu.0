Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5128CC433FE
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 14:46:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FC0941C3B;
	Fri, 29 Apr 2022 14:46:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tMMP4ERz2G8l; Fri, 29 Apr 2022 14:46:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B9EFD41C8F;
	Fri, 29 Apr 2022 14:46:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 900BDC0039;
	Fri, 29 Apr 2022 14:46:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8D6BC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:46:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B705B41C8F
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:46:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m4uhOiEfkFch for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 14:46:02 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::60a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C637A41C3B
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 14:46:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwcpfvZZOAkAZq6hqTUXp+7SlUjLntST04IahXO4kHaC6BQMIwqOAO/bBTzq9otNmJtFRhHChwXxLduonGs7kNXdxIbZYnyiJ8KhWXk969/qGpqMLaxmbH6RXeaa+5YANrv0AhCmWfyH5uumAPtBEk1xP5ljDdkCibZYpTEm4fkcj/gwBwsnD2xu2raL1tiEXNG/7LsY5yIOvqM7RmOIudBOgsyEa60PwJm3w724bLr/vobDjKvtxWOagod5KWKg6B6o8TUhJtZIF51X70qJgRIsFDG4Kx2fiyENnT+ssgh+tT9FIPmZhv4ZLR5p5/ChD2AE5j52+b3p/KramtoBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/x71hZ3zmuywo2G1jBl2JY8U0k5GUTxFrMWVqLKjGo=;
 b=k7T4/ooo2ueifCgBlZUBzXA/45tYiV1V+3ARTLgmD/u+lvhMXfVA3dy2t1oIRajX853piuotVI/oeCsExx/hOUvG9f4jfC2Bs0Zz3ypzuqIl1l0wRQLHVb7P9mW/GzahCn88hQwFWmfEH9kmCvzhB2hkB7DHpvOQwOMCGVx1gywK3ADH/ajmxclFNFidUedN5jLkr73eW6t4aLD9/gnaUfBBRIMP0UGGlaQoRPhHo1jgBk4Py7Cq6XY1QnPf02gP7onZbwUuZzpusWsdOOIsOr+GW2dZuup4Yrkp4+ooAxenWogZqIYTriW9fVaRy9I6rupcR6SLGE9VT53A8SAzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/x71hZ3zmuywo2G1jBl2JY8U0k5GUTxFrMWVqLKjGo=;
 b=b63w4oO35Wxk+EkkV+IGXJJqqHbcHhbLMtTsC+spYaNgVyqixv43fUBWr60nFAV853T2hQddW2q2YlUTscertFf+F3IRKPNuCQdHjt76p+XV9k0u1Bh7CBxlOalq9l6jPVBB2e4grfsm4yje7y4X4nO55JiHb3DGyHpa04AEA8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 14:45:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::309b:a704:5e87:8ce1%4]) with mapi id 15.20.5186.026; Fri, 29 Apr 2022
 14:45:59 +0000
Message-ID: <bc60989b-9f90-697f-f2f2-bad42f27f73b@amd.com>
Date: Fri, 29 Apr 2022 20:15:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 10/37] iommu/amd: Introduce per PCI segment last_bdf
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
 <20220425113415.24087-11-vasant.hegde@amd.com> <YmpoBWi60jPh6V/o@8bytes.org>
In-Reply-To: <YmpoBWi60jPh6V/o@8bytes.org>
X-ClientProxiedBy: PN2PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70e67066-6f6e-4510-27a9-08da29eef962
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:EE_
X-Microsoft-Antispam-PRVS: <SN6PR12MB267253EF0F9F0BF6CC179D7187FC9@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQ/ChPLdgdW3qTUE6yZsHMeKqNIL49L+m31GbbWtQGBLH8KzkfDIv/7yb802Z1t/iyt7gk97Ct1rRSoUsgO2B1vtkYYkBOuansQ04Cln0s7KIRqDqc5rSM28XkIAN20YWliIPlQUZtX4Pg3dO/Hbmje0rw1nEosFoK/P5h3fVzkrM4Rum0nbFupexTI9KuCFUvmNTKZEf8rTj/bv9kuv7p299auXd4yV6LD92S1rNUWYmSW0Gxq7jTlzzdXtM68itL53DVigCQFjwsNsPhyhiNaqHQM6Pa7c/qrP1KMj1x49LKoU5KWKGKwF1vsnEJigNm9bYmEVA3Q3dMgCvsX1+9nbrWK6NjF1tYN8Xlziw9b2aoFo81KRcjWSnZouEctZVcekYtkakoHhtZQ5JrFcxf9Qq/3zfNzgTYus/l6E962+e+rqwqUG7VMtk47I+87wfQP8M53r+fIEEuZH7UMPY5CNLYTJO+uXoW3IZNNhP+/c1W6yXbyKE7D+9vPXQQrfdi7i3KVFI4/E5IAvdB+t/gPSOzoXUh5XpbEcke4/N2wpt6VXyJRC3x1D403BlE164nC9IvO80QD6zjx1SqjrFjIptXgkeh3oi90tlO50EcGj6xDRXGzYZYryLvlsZtK+wsnE56WAYcbdHEf5etb1IWEOPfs8CraCqmk6b9MCPtFO7qdVCYWDC62MBsPrglT/LIDllbxTvhKaBXSmdL3u0/l6uNIA93ImkmiOoILpngs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(8936002)(31696002)(2906002)(6486002)(508600001)(36756003)(38100700002)(316002)(44832011)(83380400001)(6916009)(66556008)(4744005)(66476007)(4326008)(66946007)(8676002)(2616005)(6666004)(186003)(86362001)(31686004)(53546011)(6512007)(26005)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzhhR0I1cmsvUlJFUk1HamNaTEd5TEtaWnhoQklSSzFTb1NCdVgrb1pNY2JS?=
 =?utf-8?B?blRzc1pYVUoxdnhCSlM5Rk5UUEtjMjBtR2dUYkVlQ1U3cGxaS3FHMG9NcXNO?=
 =?utf-8?B?ZTd0bkszb1ViOFZhK1BqQm5QYllEK1JLVlBncVRFUlEvZmRJMXpNbUtjT1J5?=
 =?utf-8?B?ZjJ4RmhsMnlSYmhJVFhhODV5NUJnWHFpc0wxNVJrdkU0SWt5ak8xdEhPWkJj?=
 =?utf-8?B?ak1YT1ZMRUVPMm1uSzY3bjh1N2JlNy90cWx1em9NOGorT3ZvaTQ1MmoxSWo1?=
 =?utf-8?B?eGlEZjJrdXpZNGd6bWUxelB4MzFNOWUydkxoYzNPYUx6QkNRNkxBNFdreHhn?=
 =?utf-8?B?WXQ1eDFqazQxRWZVbFI0azQybGY4VVJCUmRnUUg3L2NXbzVhMEtnalBpMGlv?=
 =?utf-8?B?T1pSR3I3WGE0N2ltc2lYMjMvTmlsWkUvV1F0ak1MN1hHZUZHb28wV2s3c2dZ?=
 =?utf-8?B?WGovNUZLN2JzKzdtS2dBZUpaa1hOM0ZhcWhnL3dFVGhLT0V6eXhxMTkrT2t1?=
 =?utf-8?B?ZnA1dTE3WmRJUkVyYm8xd2J2VUlwM0FpYUE0V2JlWmtaR2dEZGw3aWJYcHVh?=
 =?utf-8?B?VWFlY2NTVFFiOTlidjFuYjJQR1pMbllreXk4MTFtbjlpTVJpMHZ1c29qL2xG?=
 =?utf-8?B?NHhPb1ptZWpUdCt5N2dPREVWOWdnRWlETmkrOGE2d0RWZStLTkw3VnpxcWx1?=
 =?utf-8?B?TnM1UGZCRElpVWREUUpXM2JjZDJRTzNmTlgwT2s2T2hKc1JCSlhmaTdxbTli?=
 =?utf-8?B?WjZPdkk1dFFTQy9WcDZLREhFWXp2UndKZEZtcEZvSVhlTk9GcHlhMEZxdzRB?=
 =?utf-8?B?ZFVVRE1MUFdhSm9RK2Jrdyt1RlVQcWptT0pVRzVJenRINmlENGNWY0ROc3ho?=
 =?utf-8?B?VnM4bm1QN0REZkg3aW9RcWs3L0N1NDYzZkUzaTZUUHQ4UDhEMW8rNTU3RGwr?=
 =?utf-8?B?elpLMUtMNjNSbkhLS3VvQWhKamIrMnloeGx0ODhsbTBpaFEwb3BsNFZWamNC?=
 =?utf-8?B?cDUrSXpmWCt6K0NVYm9SSXVUQXBIakRURDNOQjZqMHh5SEJrdVp3b3VhTEY5?=
 =?utf-8?B?T3ZKK0VmRFVJeVJvQzI5QjMxbU0xaVFockFQL2dSZEhoSkFWbmNzYmZTOFFZ?=
 =?utf-8?B?VFlUYk9oempVVHN2TTdjVnY2a0hLT0xSTnFRSU9Rdkw0WGVFbmhJWVA0YUdu?=
 =?utf-8?B?VE5FMlI5WXZsdmRPbStNMDhhOHRlUy9hUnYrcEZad3ZmZmlwUC9FZW5ONHov?=
 =?utf-8?B?bzdMZXZRZDI1RWVnVCtWQzdhMDNIT3E0WStjU3pjOWdsVTI2M3JRb091RWNO?=
 =?utf-8?B?dEpRY2VjTW1pcXhhb1VOTGJZczRLZFVMVU9TSUQ1V2ZtamhPUlNyczlUMy85?=
 =?utf-8?B?dldhSVBzRUZvb3V2RzdZdEo2aVF6WDJHYUlla1NVK3dDdUVyK2pvYUxWWDFK?=
 =?utf-8?B?TkV2UGtGNk10aVY1d2dybTZuYzJ2Y3gyVlVMTWgvVklMMUl2cVNoSFg0ZFdv?=
 =?utf-8?B?alFtM2ZkRW9NSGdRWUEwQzU5TDRabkszZEZ4cTlwS1VUc2hOa0xOYkhXWFZ2?=
 =?utf-8?B?eXQvNThTcVRVRW5uak4xVGpTb2dBczlMTTJVRXVlZnM0TzJmUlF5bWxmNGE0?=
 =?utf-8?B?MHdYbVZtZHRTMytndDVudkw0L0hXd0RmM3RCc2hOUlNOVFJEN1BMdkY1Zk14?=
 =?utf-8?B?L25tNDdVaUNvbDFmNTNORlVMYS9rM0ZUdmtEN3BpME5VTHVBWENrYXFLWVpH?=
 =?utf-8?B?Y2hkQ0xTUjVGME5MZm5QTjJBazI4Q2dKWU44bDFkeTFHQlB6NU9LdWI4TWUy?=
 =?utf-8?B?YkR3OWdwbmhEbjFBTEZ1ZlJaWS9SWTB2VXhSejdZdjBuYk1JNkxmQ24veC9z?=
 =?utf-8?B?TURRbDNMRWhaSHUyNU1IdHJsTGtORmpCcTkxaEFkc2hUL1ZyWFlJaXJZWUU4?=
 =?utf-8?B?bFBPN2xQS29hS1Jlb2ZORXZBbkR1a3orMWNONjlGdERDc1BWekloM2xZRFhz?=
 =?utf-8?B?dmE3MXJrb01DTXZ0MVh2blNhOHZ3RCtCOXY1OUpRVEdaeG1ieDM5R0FCNkdY?=
 =?utf-8?B?ZDNOc1Z0NjJBNVZpY1hranc3dEtmTThPdWZvR3NrdThPVEV2QmQ3NjUyYyt3?=
 =?utf-8?B?UExRVFNhaGZpQkRad2dxa0d2VDdVcHNpK3hHd2c4a0VOTXIwRjZDbm1OZ3hP?=
 =?utf-8?B?bnBzN3dZbzgxKzZyVzlETGlncVN5SzY1UU5kVjN1ZXo5Q3VNWGh5dEVURVJz?=
 =?utf-8?B?OW16T1JCL1EyelhsbzZxR2ltRE1nV2RkeGNBcWVEeVNnaDFkandwUzR2cGZW?=
 =?utf-8?B?V0pURWV6OVZDRnBQYzN5Vml0QkxQL2xuMTZtN3hEY2gwazlsRDdPQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e67066-6f6e-4510-27a9-08da29eef962
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 14:45:59.3010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyhRSDCYO/bxp4vG4oaxSSCqYfA9nkrAsNa8QaiXT4sH2kIaTA4mkr/p74ncQ+IBGUJ/fh3C0PJ7Tp4UOIOR7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
Cc: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Joerg,


On 4/28/2022 3:40 PM, Joerg Roedel wrote:
> On Mon, Apr 25, 2022 at 05:03:48PM +0530, Vasant Hegde wrote:
>> +	/* Largest PCI device id we expect translation requests for */
>> +	u16 last_bdf;
> 
> How does the IVRS table look like on these systems? Do they still
> enumerate the whole PCI Bus/Dev/Fn space? If so I am fine with getting
> rid of last_bdf alltogether and just allocate the data structures with
> their maximum size.
> 

We still need to parse IVHD to find max devices supported by each PCI segment
(same as the way its doing it today). Hence we need all these variables.


-Vasant
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
