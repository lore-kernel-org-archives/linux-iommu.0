Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9DFC433F5
	for <iommu@archiver.kernel.org>; Fri, 18 Feb 2022 21:50:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D2D783F6C;
	Fri, 18 Feb 2022 21:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id exQvSjuoWqrb; Fri, 18 Feb 2022 21:50:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A80EA83F9E;
	Fri, 18 Feb 2022 21:50:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57250C0011;
	Fri, 18 Feb 2022 21:50:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9BABC000B
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 21:50:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A056C60B93
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 21:50:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6X5wXm2ZdJZ for <iommu@lists.linux-foundation.org>;
 Fri, 18 Feb 2022 21:50:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A7B460BAC
 for <iommu@lists.linux-foundation.org>; Fri, 18 Feb 2022 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645221009; x=1676757009;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=/XtsGwEmKHw+W8WJg58JU9gudmH3ezawyXJCFTR4yqQ=;
 b=YwKOeTr7A6JUGx2Qz8UlV8PfyEoMQLnaZWYsktqvg9YPy7D520jCdPRF
 ANe4JsB8sZOa/T6Qe60iXTsj2W3g1gmS7OqB7XIMVKtoxf/Lz0HFbgYEA
 PN9b0r3uFSDUFcGsLf/o2y0uvh1NvK6z1kAKyk7DowXbV/skvPh4st5Y6
 ZOMRdLlMqD/TLUkwWQ+iBSRgfTZzsfrSVp1nT1OHq/uffAobWGJV1ktxc
 uOFgUoQiUb9BXnh/Dpc3Kuj7taTc8vnVOhTgXYlM70hrlkrrHkeoVriI6
 CHUXfN7vJ3zP7afBECTGO4d5f69MiKtKU9pnCSwcyzi47cOX4SXE++trZ Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="248814854"
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; d="scan'208";a="248814854"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2022 13:50:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; d="scan'208";a="572465747"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga001.jf.intel.com with ESMTP; 18 Feb 2022 13:50:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 13:50:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 13:50:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 13:50:07 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 13:50:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ECffHRY4TmuGOR6TBVGoLh3EWuDWgCJE1eimznuZg4dadQSYjyjOX0hROgOhZFnG6x/hJYIt8eIatJ3MdoZX0lZwZJLhR4yfhoLEFbZ22fA5SZAenYhpsRO9Ky6Q/igOjNfXCfuTiQXzbMLDHTy2y2wTSwQ3OcsM9wpHsW5xrCpII1uEv17CfK+mfgQh6VcLCtv+LOaGZjmuF6qEpWhxE/MECXxfmR/fre7oaECqyzsrcMLoituCu+NgnEY7tm2it5WH5x1k4ESclaaECLMRVdhx9zmRK6xPlG6l+/KZ9R2w8MUY+RFV8svmdhDzS1RGEUSqsUzZPydb3ml4UqRbWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pKIYZT4lHf+B58msdeF8XnWRuXGDtNDwDp6jxtTFlM=;
 b=MFK+GEd2QW0bkWDpjsG0ZvldfUnJxndvs+nUbrK8sKnLH8dalaWLIqrjP3+3BbgDU5w7jVlIztnILT9htkPKrfqsY1zse3NsWYpw3RjxReUNNgRjyu9Mocp7ZHg0agEiAs4vZVmuX3aGGqmGApcPB62Q0HPW/O9GB8IemydIinqpz/DM5BcKmzzpPvg6D4rXfNQsovpXw6Mlx+GEsxYO8e626jB3hOUsoiKbeV/vrjw2y9+agxpSSltHHa0Yxnn7v6QDHgm31JqwaFn1csIu61bM4pkb2mh2VuI1CcsSEqsdv3qtaTQgxqzJneQ6/dIpcbM3cBkpyo/GaoQsPAwe2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5262.namprd11.prod.outlook.com (2603:10b6:5:389::10)
 by BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.18; Fri, 18 Feb
 2022 21:50:04 +0000
Received: from DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::7084:8ccc:ac8b:1fe3]) by DM4PR11MB5262.namprd11.prod.outlook.com
 ([fe80::7084:8ccc:ac8b:1fe3%5]) with mapi id 15.20.4975.019; Fri, 18 Feb 2022
 21:50:04 +0000
Message-ID: <7652fd30-30a5-12eb-d47b-13ed8f3d6d6f@intel.com>
Date: Fri, 18 Feb 2022 13:50:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.6.0
Subject: Re: [PATCH] iommu/vt-d: Enable ATS for the devices in SATC table
Content-Language: en-US
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse
 <dwmw2@infradead.org>, Ashok Raj <ashok.raj@intel.com>, Sohil Mehta
 <sohil.mehta@intel.com>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
References: <20220216193609.686107-1-yian.chen@intel.com>
 <60d395f4-6103-94fe-9b05-daeaf0b00adb@linux.intel.com>
From: "Chen, Yian" <yian.chen@intel.com>
In-Reply-To: <60d395f4-6103-94fe-9b05-daeaf0b00adb@linux.intel.com>
X-ClientProxiedBy: MW4PR04CA0251.namprd04.prod.outlook.com
 (2603:10b6:303:88::16) To DM4PR11MB5262.namprd11.prod.outlook.com
 (2603:10b6:5:389::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 414e7813-d7d5-4a85-afb7-08d9f3289edd
X-MS-TrafficTypeDiagnostic: BYAPR11MB2647:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB264724C738000A7E87D44972FE379@BYAPR11MB2647.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jep2GDoWmxM4BhNMTGmTkXUwAvfJOKXg8mc2DT4cvAJY3quMMFUh5IRAuZDprmSZxy2HxPe0iRcuhKPNQXVoiNoy3aOSvhAQTRJBugdZO2o7cxpjLtnnscifxtZBhpU7dX9gVBtZ8RqhBUE/319J6nFhwmH3ljXjeQctlttH/jK+EWjCQRI3gqKrFV/sSU1Z05LpREOijnTs1Ev3AsH0t7m23qk57tBIKi94x+ayOjKm56BRJaOFCCH3b17RQcK5NabNQb67eADHN+FL5dTsDFw+8aCMVMDlBXYJ3qaJsHHXCPPslqnTTgcX0SNoPPSLPlA8YBR+/faK59Q1c7zGYU3hp9tm7y12QrerG5ETNP8WRxmbqAAtR01kLAfdsLzAkczbNTW8Nja6aUqy+HbxUczLRnFUMFvWI9bscPJI5Jss3/IhGHliM+stIEgXTTpHpQn7Cz/ropM+6UzMH3sAcP+ija6+yct9j5ult/v/j++jwjHK1N1gi26+LMFwWiRvgpyoXoBatVCwRNRuziY2FLus+Pn9wPPp85b+K/87NtclKnklr3WUDBIjMlc4Iqs18W/jPX6725NSFB8ZZ5CI8f2IwB8cnEKt2SjSHhsjniFma8+okfnb4RvhMG74WoptbEJ3on29UtI4V60qEKDP1OjpYZkF5ekNiC8vpFf9Hwi1T3yZyPDq+s39OY0D6uEehgEjiMYfp+37Sm/2PUNKeR/s5T/w7S66vRjRQInOxY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5262.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(6666004)(31696002)(6486002)(2616005)(508600001)(2906002)(8676002)(66556008)(66946007)(83380400001)(66476007)(6506007)(82960400001)(110136005)(26005)(186003)(38100700002)(5660300002)(53546011)(31686004)(8936002)(86362001)(6512007)(316002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2s5VnVGK3hhclRmSVJ1dlpodURORjBYU1ZBenUzR3drb1ZwUkhVbjZ2MXJo?=
 =?utf-8?B?VFk4RVMrZWhTSXUxM3ovVGkyQXpWZ2RhMzArQStqKzJ6KzZqRkRDL2hZZ2V2?=
 =?utf-8?B?MEpBOXF5NUdFbExQTnpreUFONkJEL2kxTVlLRjFpSnJUYVByU2E2ZzFaU3d2?=
 =?utf-8?B?WldiZEFISzllS3dHcVRUOHhJeGFzdmxVODhVTWUzamM4UFM4Z25WQjkrRTBi?=
 =?utf-8?B?MWxKNlpEbzRxdVlnRldya0NtYzUzQThYVkJ3RXJpUFBuTHZQUEg1eVVVZjdw?=
 =?utf-8?B?NndKdlFHK29DRy9Sa2lLVVVDU2Nnb2VWNXlkbFdGUUJDSlp5Y053Vk51T0VE?=
 =?utf-8?B?MFFFMGRNdzRsSVNubWh0Vm9LbEJXQ1NaR3BqVFdKN29uK2ZNamRnVHFROVlo?=
 =?utf-8?B?czMyazVmaER4MWlnK1dyc3VRSTgvUGRCU3JjcU1QZ28rampZWXpIeUpHUTl1?=
 =?utf-8?B?NkUzL1Rsd3RqK091bGVJcHhCMjlXWTRsZCtaa090RUZGaU42aHhway9nMDJY?=
 =?utf-8?B?WThiMERyOEx0Nzd3eC9NY3FzYjJLY0M4SXB5RENWWDZUN1V3MkVzcmdCVDVq?=
 =?utf-8?B?WEtFTHY1dzd4N2h2NGZsM2p1Njg0UnRKV2xpOFlOMTZLYlhLUDNuWHdpUEVX?=
 =?utf-8?B?blNaeVBROFhpYXJ0SlJGU2NUYUkrVjRObjY1Y0NEU3ZaMWVzbEFBWkYrTjNS?=
 =?utf-8?B?cHhVNnNvZllrRnJwUGFmYUV0aTllTm5QVW10MlUzcGp4MllOZWlyY0FURGNJ?=
 =?utf-8?B?SmRIamZPVGhHUEw1UTJabEVQZm9SRCt6RGxSUUxZRnpmVVFhVURidUJGY0RD?=
 =?utf-8?B?ZWh5Vi9LWTNFNEhMa051V292dUw4a0hOMjJIVWNGMTZFVm9HcTdRUEl0Y0Y5?=
 =?utf-8?B?OUZxeHlPS1RTcVJQVHRqRHBhSHN5c0VJUTR5VC9PaG5ZTmlWdUl1RUhlSFQ2?=
 =?utf-8?B?ek1SQmZaU0xmdVZtMlh4TElhVGlDKzVhS2UxS0MwRnNYME5qNnJ2bzV4MlJG?=
 =?utf-8?B?TCtyakcrcmY3K1p4TWJvSkpLbExuNGt5bkQyaldpTXE1YTV1Z2hQUmRBcXd1?=
 =?utf-8?B?NTBJZ1JCMUsxajh3a3A1OTk4aWJ2eWIwTSsyWjRaQUo1ZDRFc0pzR09abFpI?=
 =?utf-8?B?M1U3L0UyZ3kzYmVnTWQ2YUY4OEE2eUlrdXJGREhibTdsekNBUFhvckwxN0tZ?=
 =?utf-8?B?UlQ5dUxPbXM4eDlQYStkM1p3R1hidnl1WlUzR0JaUlcvWXkrdEhmOHhoRUFD?=
 =?utf-8?B?Y295SjNjY093dWRJOTd5NGRpV3FnUFhZVU5rWHFoSzAyVW9MUWJiQmh3MWs3?=
 =?utf-8?B?TkJVK09lanVGcnZEOWoza3d6bVk2MGorNG5RZ0x6VDNtRnNHR3k2VDlEQ0N4?=
 =?utf-8?B?RFo0bEZ0RGszMVJOOGxVbnE4NTVHMDh4eWRTblZ0VTdYRXpiVitVOUdJazdm?=
 =?utf-8?B?WFdJWnFiQ2ZnNE1HWlcvNkJyTjBBdlVOVWxuYzBxcE1qdDlZZDV1ZkZUMThF?=
 =?utf-8?B?bG1NdHR2UnlwbXovZmIzbzA3WGNxZ0Z2cmlNcThBZElJQVV4QnNjdXRUNk5S?=
 =?utf-8?B?aTJWaDFmRHduUGoyeDVwcmhYT2VnZjVmcWk1U1lRUTQ4aHRvbW96eDJGV3VB?=
 =?utf-8?B?QlNTYnZvWlRyT2J2c3duNC93QXRHbE9tQndrZlZkbEVNSGd6NnhsdUhPQ0pG?=
 =?utf-8?B?WG9JNG1HSS9JOUFUbjNuYlQvVWxSQWFGeERlRFpxWjFmZGZwditOb1ROdVh3?=
 =?utf-8?B?eTQrTExsYmQ5MzRsWDlZM1FPY293UnNYMjhJM3N4TldqeU9ac0sxSG1lMzJl?=
 =?utf-8?B?VkY5RmxZcldwd1AyOWhYS3Rqa2NEaHBPQTdERjRqUktCYnJQbEZhM1ljWEF3?=
 =?utf-8?B?OHIxQzYreEl4Y2NjdjhGZUNJQWFqa0VDa29rTWVtWVd5Vnc4RytUenJMQXdV?=
 =?utf-8?B?S3ptb2l3U1JrYUJSb2VCMm5yU0MzdmUzR1NGY3dqUmg3dUhSSjh2MCtZTFdS?=
 =?utf-8?B?dU83cWxST3lpSUpZbFNoM25BZTcwNmdRSTcvNnBDaWNHTklqWlFjU0ZBZWZi?=
 =?utf-8?B?MTdLTmFpQzdnZmliakhDMkpFVGVTS1REazRlRXJmckhDcEhNeks0TVdGdzhV?=
 =?utf-8?B?bFlNbjY5OFpaRE8rNituWkRXVWRsODdUYUt0RXhHR2cxN3Q4aVgxN2gxNGsr?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 414e7813-d7d5-4a85-afb7-08d9f3289edd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5262.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 21:50:04.1080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocqDJ32jfAqQSxMlwq64PpSWj1qTQqqBFlzzi5rVJgxiIFbdrm6FMUwcVMCtCVQ/UGJTjamIh8M0b/IvJ6fr7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2647
X-OriginatorOrg: intel.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

CgpPbiAyLzE3LzIwMjIgNjo1MyBQTSwgTHUgQmFvbHUgd3JvdGU6Cj4gSGkgWWlhbiwKPiAKPiBP
biAyLzE3LzIyIDM6MzYgQU0sIFlpYW4gQ2hlbiB3cm90ZToKPj4gU3RhcnRpbmcgZnJvbSBJbnRl
bCBWVC1kIHYzLjIsIEludGVsIHBsYXRmb3JtIEJJT1MgY2FuIHByb3ZpZGUKPj4gYWRkaXRpb25h
bCBTQVRDIHRhYmxlIHN0cnVjdHVyZS4gU0FUQyB0YWJsZSBpbmNsdWRlcyBhIGxpc3Qgb2YKPj4g
U29DIGludGVncmF0ZWQgZGV2aWNlcyB0aGF0IHN1cHBvcnQgQVRDIChBZGRyZXNzIHRyYW5zbGF0
aW9uCj4+IGNhY2hlKS4KPj4KPj4gRW5hYmxpbmcgQVRDICh2aWEgQVRTIGNhcGFiaWxpdHkpIGNh
biBiZSBhIGZ1bmN0aW9uYWwgcmVxdWlyZW1lbnQKPj4gZm9yIFNBVEMgZGV2aWNlIG9wZXJhdGlv
biBvciBhbiBvcHRpb25hbCB0byBlbmhhbmNlIGRldmljZQo+PiBwZXJmb3JtYW5jZS9mdW5jdGlv
bmFsaXR5LiBUaGlzIGlzIGRldGVybWluZWQgYnkgdGhlIGJpdCBvZgo+PiBBVENfUkVRVUlSRUQg
aW4gU0FUQyB0YWJsZS4gV2hlbiBJT01NVSBpcyB3b3JraW5nIGluIHNjYWxhYmxlCj4+IG1vZGUs
IHNvZnR3YXJlIGNob29zZXMgdG8gYWx3YXlzIGVuYWJsZSBBVFMgZm9yIGV2ZXJ5IGRldmljZSBp
bgo+PiBTQVRDIHRhYmxlIGJlY2F1c2UgSW50ZWwgU29DIGRldmljZXMgaW4gU0FUQyB0YWJsZSBh
cmUgdHJ1c3RlZAo+PiB0byB1c2UgQVRTLgo+Pgo+PiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgSU9N
TVUgaXMgaW4gbGVnYWN5IG1vZGUsIEFUUyBvZiBTQVRDCj4+IGNhcGFibGUgZGV2aWNlcyBjYW4g
d29yayB0cmFuc3BhcmVudGx5IHRvIHNvZnR3YXJlIGFuZCBiZQo+PiBhdXRvbWF0aWNhbGx5IGVu
YWJsZWQgYnkgSU9NTVUgaGFyZHdhcmUuIEFzIHRoZSByZXN1bHQsCj4+IHRoZXJlIGlzIG5vIG5l
ZWQgZm9yIHNvZnR3YXJlIHRvIGVuYWJsZSBBVFMgb24gdGhlc2UgZGV2aWNlcy4KPj4KPj4gU2ln
bmVkLW9mZi1ieTogWWlhbiBDaGVuIDx5aWFuLmNoZW5AaW50ZWwuY29tPgo+PiAtLS0KPj4gwqAg
ZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgNTMgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLQo+PiDCoCBpbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmggfMKgIDIgKy0K
Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA1MSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5jCj4+IGluZGV4IDkyZmVhM2ZiYmIxMS4uNThhODBjZWM1MGJiIDEw
MDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMKPj4gKysrIGIvZHJpdmVy
cy9pb21tdS9pbnRlbC9pb21tdS5jCj4+IEBAIC04NzIsNyArODcyLDYgQEAgc3RhdGljIGJvb2wg
aW9tbXVfaXNfZHVtbXkoc3RydWN0IGludGVsX2lvbW11IAo+PiAqaW9tbXUsIHN0cnVjdCBkZXZp
Y2UgKmRldikKPj4gwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+IMKgIH0KPj4gLQo+IAo+IFVu
bmVjZXNzYXJ5LgpzdXJlLCB0byByZW1vdmUgdGhpcy4KPiAKPj4gwqAgc3RydWN0IGludGVsX2lv
bW11ICpkZXZpY2VfdG9faW9tbXUoc3RydWN0IGRldmljZSAqZGV2LCB1OCAqYnVzLCB1OCAKPj4g
KmRldmZuKQo+PiDCoCB7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGRtYXJfZHJoZF91bml0ICpkcmhk
ID0gTlVMTDsKPj4gQEAgLTI2ODQsNyArMjY4Myw3IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hcl9kb21h
aW4gCj4+ICpkbWFyX2luc2VydF9vbmVfZGV2X2luZm8oc3RydWN0IGludGVsX2lvbW11ICppb21t
dSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlY2FwX2Rldl9pb3RsYl9zdXBwb3J0KGlvbW11
LT5lY2FwKSAmJgo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwY2lfYXRzX3N1cHBvcnRl
ZChwZGV2KSAmJgo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkbWFyX2ZpbmRfbWF0Y2hlZF9h
dHNyX3VuaXQocGRldikpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRtYXJfYXRzX3N1cHBv
cnRlZChwZGV2LCBpb21tdSkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGluZm8tPmF0
c19zdXBwb3J0ZWQgPSAxOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNtX3N1cHBvcnRlZChp
b21tdSkpIHsKPj4gQEAgLTQwMjAsNyArNDAxOSw0MiBAQCBzdGF0aWMgdm9pZCBpbnRlbF9pb21t
dV9mcmVlX2RtYXJzKHZvaWQpCj4+IMKgwqDCoMKgwqAgfQo+PiDCoCB9Cj4+IC1pbnQgZG1hcl9m
aW5kX21hdGNoZWRfYXRzcl91bml0KHN0cnVjdCBwY2lfZGV2ICpkZXYpCj4+ICsvKiBkZXZfc2F0
Y19zdGF0ZSAtIEZpbmQgaWYgZGV2IGlzIGluIGEgRE1BUiBTQVRDIHRhYmxlCj4+ICsgKgo+PiAr
ICogcmV0dXJuIHZhbHVlOgo+PiArICrCoMKgwqAgMTogZGV2IGlzIGluIFNUQUMgdGFibGUgYW5k
IEFUUyBpcyByZXF1aXJlZAo+PiArICrCoMKgwqAgMDogZGV2IGlzIGluIFNBVEMgdGFibGUgYW5k
IEFUUyBpcyBvcHRpb25hbAo+PiArICrCoMKgwqAgLTE6IGRldiBpc24ndCBpbiBTQVRDIHRhYmxl
Cj4+ICsgKi8KPiAKPiBKdWRnaW5nIHRoZSBzdGF0dXMgb2YgdGhlIGRldmljZSBpbiB0YWJsZSBh
Y2NvcmRpbmcgdG8gdGhlIGhhcmQgY29kZWQKPiByZXR1cm4gdmFsdWUgd2lsbCBtYWtlIHRoZSBj
b2RlIGhhcmQgdG8gcmVhZC4gSG93IGFib3V0IHVzaW5nIHR3bwo+IGhlbHBlcnMgd2l0aCBtZWFu
aW5nZnVsIG5hbWVzLCBmb3IgZXhhbXBsZSwKPiAKPiBib29sIGRtYXJfZmluZF9tYXRjaGVkX3Nh
dGNfdW5pdCgpCj4gYm9vbCBkbWFyX2F0c19yZXF1aXJlZF9pbl9zYXRjKCk/Cj4gc3VyZSwgdGhp
cyBpcyBnb29kLiBob3cgYWJvdXQgSSBhZGQgb25lIGZ1bmN0aW9uLgoKLy9yZXR1cm4gYWRkcmVz
cyBvZiBmb3VuZCBzYXRjdSwgb3RoZXJ3aXNlIG51bGw6CnN0YXRpYyBzdHJ1Y3QgZG1hcl9zYXRj
X3VuaXQgKmRtYXJfZmluZF9tYXRjaGVkX3NhdGNfdW5pdChzdHJ1Y3QgcGNpX2RldiAqKQoKYW5k
IGNoZWNrIGlmIGF0cyBpcyByZXF1aXJlZCB0aHJvdWdoIHRoZSByZXR1cm5lZCBzYXRjIHVuaXQo
YXRjX3JlcXVpcmVkKQoKPj4gK3N0YXRpYyBpbnQgZGV2X3NhdGNfc3RhdGUoc3RydWN0IHBjaV9k
ZXYgKmRldikKPj4gK3sKPj4gK8KgwqDCoCBpbnQgaSwgcmV0ID0gLTE7Cj4+ICvCoMKgwqAgc3Ry
dWN0IGRldmljZSAqdG1wOwo+PiArwqDCoMKgIHN0cnVjdCBkbWFyX3NhdGNfdW5pdCAqc2F0Y3U7
Cj4+ICvCoMKgwqAgc3RydWN0IGFjcGlfZG1hcl9zYXRjICpzYXRjOwo+PiArCj4+ICvCoMKgwqAg
ZGV2ID0gcGNpX3BoeXNmbihkZXYpOwo+PiArwqDCoMKgIHJjdV9yZWFkX2xvY2soKTsKPj4gKwo+
PiArwqDCoMKgIGxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KHNhdGN1LCAmZG1hcl9zYXRjX3VuaXRz
LCBsaXN0KSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBzYXRjID0gY29udGFpbmVyX29mKHNhdGN1LT5o
ZHIsIHN0cnVjdCBhY3BpX2RtYXJfc2F0YywgaGVhZGVyKTsKPj4gK8KgwqDCoMKgwqDCoMKgIGlm
IChzYXRjLT5zZWdtZW50ICE9IHBjaV9kb21haW5fbnIoZGV2LT5idXMpKQo+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjb250aW51ZTsKPj4gK8KgwqDCoMKgwqDCoMKgIGZvcl9lYWNoX2Rldl9z
Y29wZShzYXRjdS0+ZGV2aWNlcywgc2F0Y3UtPmRldmljZXNfY250LCBpLCB0bXApCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmICh0b19wY2lfZGV2KHRtcCkgPT0gZGV2KSB7Cj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHNhdGMtPmZsYWdzKQo+IAo+IERvIHlvdSBu
ZWVkIHRvIGNoZWNrIHRoZSBBVENfUkVRVUlSRUQgYml0IGZpZWxkPwo+VGhhbmtzLCBJIGNhbiB1
cGRhdGUgdGhpcyB1cG9uIGFib3ZlIHJlc3BvbnNlLgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gMTsKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlbHNlCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQg
PSAwOwo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0Owo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqAgfQo+PiArb3V0Ogo+PiArwqDCoMKgIHJj
dV9yZWFkX3VubG9jaygpOwo+PiArwqDCoMKgIHJldHVybiByZXQ7Cj4+ICt9Cj4+ICsKPj4gK2lu
dCBkbWFyX2F0c19zdXBwb3J0ZWQoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IGludGVsX2lv
bW11ICppb21tdSkKPj4gwqAgewo+PiDCoMKgwqDCoMKgIGludCBpLCByZXQgPSAxOwo+PiDCoMKg
wqDCoMKgIHN0cnVjdCBwY2lfYnVzICpidXM7Cj4+IEBAIC00MDMwLDYgKzQwNjQsMTkgQEAgaW50
IGRtYXJfZmluZF9tYXRjaGVkX2F0c3JfdW5pdChzdHJ1Y3QgcGNpX2RldiAKPj4gKmRldikKPj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgZG1hcl9hdHNyX3VuaXQgKmF0c3J1Owo+PiDCoMKgwqDCoMKgIGRl
diA9IHBjaV9waHlzZm4oZGV2KTsKPj4gK8KgwqDCoCBpID0gZGV2X3NhdGNfc3RhdGUoZGV2KTsK
Pj4gK8KgwqDCoCBpZiAoaSA+PSAwKSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCAvKiBUaGlzIGRldiBz
dXBwb3J0cyBBVFMgYXMgaXQgaXMgaW4gU0FUQyB0YWJsZSEKPj4gK8KgwqDCoMKgwqDCoMKgwqAg
KiBXaGVuIElPTU1VIGlzIGluIGxlZ2FjeSBtb2RlLCBlbmFibGluZyBBVFMgaXMgZG9uZQo+PiAr
wqDCoMKgwqDCoMKgwqDCoCAqIGF1dG9tYXRpY2FsbHkgYnkgSFcgZm9yIHRoZSBkZXZpY2UgdGhh
dCByZXF1aXJlcwo+PiArwqDCoMKgwqDCoMKgwqDCoCAqIEFUUywgaGVuY2UgT1Mgc2hvdWxkIG5v
dCBlbmFibGUgdGhpcyBkZXZpY2UgQVRTCj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdG8gYXZvaWQg
ZHVwbGljYXRlZCBUTEIgaW52YWxpZGF0aW9uCj4+ICvCoMKgwqDCoMKgwqDCoMKgICovCj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAoaSAmJiAhc21fc3VwcG9ydGVkKGlvbW11KSkKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0ID0gMDsKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4+
ICvCoMKgwqAgfQo+PiArCj4+IMKgwqDCoMKgwqAgZm9yIChidXMgPSBkZXYtPmJ1czsgYnVzOyBi
dXMgPSBidXMtPnBhcmVudCkgewo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgYnJpZGdlID0gYnVzLT5z
ZWxmOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgLyogSWYgaXQncyBhbiBpbnRlZ3JhdGVkIGRldmlj
ZSwgYWxsb3cgQVRTICovCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11
LmggYi9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgKPj4gaW5kZXggNjkyMzBmZDY5NWVhLi5m
ZTlmZDQxN2Q2MTEgMTAwNjQ0Cj4+IC0tLSBhL2luY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaAo+
PiArKysgYi9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgKPj4gQEAgLTcxNyw3ICs3MTcsNyBA
QCBzdGF0aWMgaW5saW5lIGludCBucl9wdGVfdG9fbmV4dF9wYWdlKHN0cnVjdCAKPj4gZG1hX3B0
ZSAqcHRlKQo+PiDCoCB9Cj4+IMKgIGV4dGVybiBzdHJ1Y3QgZG1hcl9kcmhkX3VuaXQgKiBkbWFy
X2ZpbmRfbWF0Y2hlZF9kcmhkX3VuaXQoc3RydWN0IAo+PiBwY2lfZGV2ICpkZXYpOwo+PiAtZXh0
ZXJuIGludCBkbWFyX2ZpbmRfbWF0Y2hlZF9hdHNyX3VuaXQoc3RydWN0IHBjaV9kZXYgKmRldik7
Cj4+ICtleHRlcm4gaW50IGRtYXJfYXRzX3N1cHBvcnRlZChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBz
dHJ1Y3QgaW50ZWxfaW9tbXUgCj4+ICppb21tdSk7Cj4gCj4gVGhlIGRtYXJfZmluZF9tYXRjaGVk
X2F0c3JfdW5pdCgpIGlzIG5vdCB1c2VkIG91dCBvZiBpb21tdS5jLiBDYW4geW91Cj4gcGxlYXNl
IG1ha2UgYSBwYXRjaCB0byBjaGFuZ2UgaXQgdG8gYSBzdGF0aWMgb25lPwo+IApzdXJlLCBpIHdp
bGwgcmVwbGFjZSAiaW50IGRtYXJfZmluZF9tYXRjaGVkX2F0c3JfdW5pdCIgYXMgYWJvdmUgcmVz
cG9uc2UuCgo+PiDCoCBleHRlcm4gaW50IGRtYXJfZW5hYmxlX3FpKHN0cnVjdCBpbnRlbF9pb21t
dSAqaW9tbXUpOwo+PiDCoCBleHRlcm4gdm9pZCBkbWFyX2Rpc2FibGVfcWkoc3RydWN0IGludGVs
X2lvbW11ICppb21tdSk7Cj4gCj4gQmVzdCByZWdhcmRzLAo+IGJhb2x1CgpUaGFua3MsCllpYW4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFp
bGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
