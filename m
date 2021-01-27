Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E08AC433E0
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 13:52:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA15207B7
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 13:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA15207B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 720F6866A7;
	Wed, 27 Jan 2021 13:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cvXDJUirNIT2; Wed, 27 Jan 2021 13:52:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6871860F1;
	Wed, 27 Jan 2021 13:52:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 993EDC08A1;
	Wed, 27 Jan 2021 13:52:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59E6FC013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 30C8A21FA9
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pYHQx3FDlU9F for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 13:52:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
 by silver.osuosl.org (Postfix) with ESMTPS id 9224B20018
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 13:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCyGsBeLfFK44QpXSPk9TdX2iPH3fZVo0bdpTJHv6Lc+UdwJkMvqejv8rJLVl/5RuLaFe+Yy6IIEHaTU+jutghNFFHTr462cG1jWLnbBk9qVk2StKQhufGaFaj+GxilpC2ESp1hgiASk5/6pPxqzqofKN8w0DeaS9D1F0PZSBca7i0DQPT950PamRTImcVjB5tT5v0wENAMHYBGXWCbKBD+j8HCTJ0ZhkUKTj7Ye7l3ktiBcp1mk1tl3jDM54n3D3CRcH2gwp304bDEbCBMbHf331Rcn7PxVWSvSfR1f3cilE3FuiY1G88VqqeBo7xJDMpeBxTqN4p1IVVDhLLD0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kDitbwABC6VYJvIc8+eKTMRQHvPBkd0HzwVZcN3FV8=;
 b=EqvGzsxCRfSp2oM7podo/+X79Rlk+dYwUIjdTdjF+RoMziKhlVItvtFk0y/LWVwfkTavu+8q8L3ORYGqPEWXRlNUY5T0Gnh0UqnO9ktrM4OcYAJ4ZeJV4XfntFCfxW0ApneDfLUuWR8FAjRSrY3gDzTFMrkCI6O1LfR5giTQG8GidPUFH6OaiAZrrXXGj9v+Hp/rO6CpWnbzU2SjDk8Fc/tBUSrHzpDOzSPN4TWfs5ooeo8/IzJNRByxBCx7am6gE81FJ7afc9F/9xV5NcjuxHSOe9e2tjdbi/h/SSNCOxInJ85mottor0tUE7jIzFMrrGNg+oTVOf5ZyeJ8+rG9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kDitbwABC6VYJvIc8+eKTMRQHvPBkd0HzwVZcN3FV8=;
 b=ZFMoTkkjxTbt4HK8FM4IaaFkn8haaZhw7gnPDmeOqc9/2wIooCzrWml/ftoZeXkqvGYORPhkGG/jUJD6CQ1biDn66Hy8tgUCYDPWzqZkTVxWqVIIXUXhKMKo1WbwrHXLfX5q/xS/PFTWhZudrSB0FH3PWl0xZ2Z8sFseM+GVwj8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB2838.namprd12.prod.outlook.com (2603:10b6:a03:6f::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 13:37:34 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 13:37:34 +0000
Subject: Re: [PATCH v4 00/13] iommu/amd: Add Generic IO Page Table Framework
 Support
To: Joerg Roedel <joro@8bytes.org>
References: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
 <20210127120640.GF32671@8bytes.org>
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <c64e7967-e28c-255e-e610-da53d6e99d2a@amd.com>
Date: Wed, 27 Jan 2021 20:37:08 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
In-Reply-To: <20210127120640.GF32671@8bytes.org>
Content-Language: en-US
X-Originating-IP: [171.96.75.85]
X-ClientProxiedBy: SG2PR03CA0163.apcprd03.prod.outlook.com
 (2603:1096:4:c9::18) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (171.96.75.85) by
 SG2PR03CA0163.apcprd03.prod.outlook.com (2603:1096:4:c9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.7 via Frontend Transport; Wed, 27 Jan 2021 13:37:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c258dd54-379a-4c72-d5f8-08d8c2c8b3fc
X-MS-TrafficTypeDiagnostic: BYAPR12MB2838:
X-Microsoft-Antispam-PRVS: <BYAPR12MB283888E56C8E77EC2C1C9097F3BB9@BYAPR12MB2838.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yozllaJ7HXqIoR8t5+Kzmzv0GJlZcufxfHTL5xApShDM0h8wQD0aH117y+M5oLGyHJ7KhAAsEb2ajzKb9IQ7M6r/Ny4jvjaOT+H1xicEqmwO0Bwr3ONOuMXwQWvVIvZ14cXxIR7DFxVBpXkRTupEM3ThFVHuLoI3PRRmgduQ5DOcvhBdpuBvBiEj40wrk5HdhAJkjLJqeXEQ2eoIW7uE4SV/0Hhkzlp1x42e5psyl3+sLNVUuFAEJGw3jWPsPo+CQEy0umxHME0ozvi0Jdsyc14HiX6c5TddTc8W2qmDFGBt0MxY4bIt0+4mLKTXLxaGZ5JnXYMrhKCYeOcmKfzVYdER0Z3cv+P+tb0M3Hcbw9NlDRMzOZ/H3SDCssfw7DUbF0fK7crwZUPlRAvami1Hluy1zAAZezP5ARRnYhEkjCXGm5UPusM5mfc4tLDvUFo8L8jYLtzy7Ask+5BpxYcRRodcxyfxBKkGiupHBub9n6hin4JsmQfJVHfBHfw7g+TY/ASr1ltoBpr7aT4iBXRkVQ+UUIMsXSlWyLqGrSB7kRdt9T8b5YqSZFEf5h3XDlcOZTDLq7BAh2gzGwqLkA8DUQTw4AsJ71S1kk3sbJM+gT7wJKL/CyOW5uuzcieVhRPa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(31696002)(6666004)(53546011)(8936002)(86362001)(316002)(5660300002)(478600001)(6506007)(36756003)(8676002)(6916009)(52116002)(31686004)(66946007)(66476007)(956004)(6486002)(2906002)(44832011)(66556008)(2616005)(4326008)(6512007)(26005)(186003)(16526019)(41533002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c1ZpNVZ0S3RaTVNMVXNHclBoN1pVeVRxcEZqRWQxVklmeVk4NERBUEJod284?=
 =?utf-8?B?UXhubjRza0lIN3J6b0k0MUtTWHpybGdYdXo0S3FOcUpKWUFjNTB4Smw4QUpu?=
 =?utf-8?B?SDMxaUNpMmhUa2pxLzR6WmVPbmVieTNjYmFqNloxZTExV042cU82a1F1YjN0?=
 =?utf-8?B?eE5aUUU5a21PQWpxWmhmblVsTWF0dzUwNEhha2dmRVlkMmU1ZGxmSlRwWm9O?=
 =?utf-8?B?MjdBTXF2WFlLVEJySTlFdVZpTXNmSXJFL292QjI2UVNIU2xJL1MyK1lxSzhm?=
 =?utf-8?B?aTJRaklTWVVDZTNTeXNjbHZtNDJValRsVGFCdkRXaEV4WTF2VnZCazdNUEVX?=
 =?utf-8?B?WW91YnFxZzlxaXA3UWQ1TVhnMmtqZkhuL0JjUjJXbFh0U293S1B0NG04TjJ1?=
 =?utf-8?B?UVpMM1hHMDdBMWdTbWx4NWYyNVVoaGg3ZUg4NWErcFgwSlpDc0xucDNSTnJ1?=
 =?utf-8?B?RENmR1grTElxdTk0ZVZMR3BYYyswRmhraDAwTU5JRkxqU2FuMmxNNXl6enZD?=
 =?utf-8?B?ZWhUZE5QOS9taGdIRjRpOTJ3Q3FtdGx6S2hSVGQ0MlY4SWRqYjVod1A5SW9a?=
 =?utf-8?B?U2pqMi9yME41U0tSMFprZmN5K2dkNHR5MVpIc3MyNnF0NGNDQ0xjWHhMSlkx?=
 =?utf-8?B?QmVQZnUyWlo3cit6ZTdSbnV6ZHI3czJndUtCUnFMbCtOWURlNGl0MGY1WVZu?=
 =?utf-8?B?SnR3K3FBdXlkWG5jR3JPM05jeWNJMS96TW9JMFNoVWtibXFiUjZLZ1B4STNZ?=
 =?utf-8?B?bjhmblRlRkxpeEJNOHlvUXNIYmZhamdUWjFrOFVzWk9TSzZNK0ZBZXMzdGtu?=
 =?utf-8?B?MndJbTB3YXNQWmRUdjJXMDVoMlY4RVNQU295MlMrb1c2SkcyY3ZhaUx0T1hy?=
 =?utf-8?B?UE5VeVNIR0ZhUVZYSFpETFpDeFdXTmJNU3M5Y1hHWTNZclFDR0xyT0duTnZt?=
 =?utf-8?B?RmdHMXZaV3Z2RzdzRDBXSHpERHhsVFpyM01HZlNSSTZPT3YvN2VCK3plZHd6?=
 =?utf-8?B?eE01OXpBdC9BTW15NXJKSjI3b0dNZlZ0clNrSGppblMwK0FkUW5DclBLamVZ?=
 =?utf-8?B?dHdoY2I5OG9pbTNybWRWK2toNENHMWlQQkVzaGhEcnhDdkVrNGFTdWw0bUxO?=
 =?utf-8?B?YUNoRStaTHAvYUZ3ZnFZaHdadzhPWUNYVmNsRCtCRG1aMGhSZ01xT2xWN04r?=
 =?utf-8?B?djg0TVBaY2NFbGlGVE9jZ0c4SHZJbjlxd0M3UnVxWERaZ2liNkx6MUlJQmtR?=
 =?utf-8?B?TER4Z21GeVBxd044NWZQNEthdVh5bHVaSG4zYk9hS2ZuckZWNkdTb2RzY2lO?=
 =?utf-8?B?T29nd21ERk50SmYyVjJBQUhpOCt3MHdlNXBIcUp1WU00N1Q0WlhJN2ZwLzdh?=
 =?utf-8?B?czYxOFhPMERQUmFjS01zNWszWlEyM2lYcHFTY2JDbXZoVHpWbm1PclNRMFFp?=
 =?utf-8?Q?OHWnC+EU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c258dd54-379a-4c72-d5f8-08d8c2c8b3fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 13:37:34.5092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peoax03BfYsJYywlvMnibgzBI0v7tXc1fl2dC12c9brqqU/OQOhIx06QG0mYAke56YN3Ub25wBmToS1OVMhoTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2838
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-kernel@vger.kernel.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 1/27/21 7:06 PM, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Tue, Dec 15, 2020 at 01:36:52AM -0600, Suravee Suthikulpanit wrote:
>   
>> Suravee Suthikulpanit (13):
>>    iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
>>    iommu/amd: Prepare for generic IO page table framework
>>    iommu/amd: Move pt_root to struct amd_io_pgtable
>>    iommu/amd: Convert to using amd_io_pgtable
>>    iommu/amd: Declare functions as extern
>>    iommu/amd: Move IO page table related functions
>>    iommu/amd: Restructure code for freeing page table
>>    iommu/amd: Remove amd_iommu_domain_get_pgtable
>>    iommu/amd: Rename variables to be consistent with struct
>>      io_pgtable_ops
>>    iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
>>    iommu/amd: Introduce iommu_v1_iova_to_phys
>>    iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
>>    iommu/amd: Adopt IO page table framework for AMD IOMMU v1 page table
> 
> Applied this series, thanks for the work! Given testing goes well you
> can consider this queued for 5.12.
> 
> Thanks,
> 
> 	Joerg
> 

Thanks Joerg and Will, and welcome back!!!

Suravee
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
