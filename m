Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27B64F5EA
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184702; cv=fail; b=OqEiw5KDT2oprnF2r0A/6pGOiyU6TV0wWvk9DslODSj/oXCeENUEswOVeElkOtuKRYx5Ou15d4WbkgB+W+6fNm35K8xtQsNndUflpZgfuOb1is0VEBlhDd+hVaeofr5XTmV4ryhpMinsL4BsohXMILO7G9KcotslAojFC4mVG00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184702; c=relaxed/simple;
	bh=fxFqk8w68MQjZ5+lGOLKWNJaQai5Q0WYuCVjRgGA2IA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wa8Dd3YTbMHxnqnozAnU/eVidkJaSjdGodGJZc92FuFQ0eg5xKd1vCi9LZnfguexFKpgwSso45qdVSZ3sCbLyvZ1y+T8o39QHo0DfkVgjeImlzCCX9/IVRa9mcjx7Ns+EWEJme3Yr4IT3p8ybeHX3TyqFCVJBDWrtGJhdIYau/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TgjBgahC; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TgjBgahC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S54i5KuboCj9fBJpGv4pbl41+vQMzhBPRt6/l5bOCAfBcSKxOi4k/Ux6wt17mBo8Yt8fRfkzFpjSFGS8miQay60zKI8ulZRsgHB1zD5Jcr7LiOSvl5/iCwvmiqSC1WlFBukOnpMirkGxPpyfA/r9wV8S49Q03N1oCjdEaeUkw3tXsBHWyZUYs/vZwshlY07vTMyLMH3A2l8tKZ83xspuuSo0duKgeBkdrILNN6jGTTWinrLzbaBOPDk5rjl2ulrWLfcmm6Vp7/sOk2tAmqXaP1M1OxSeWSjVxFEHmeWNBZKAv1FlQetHBBGZtKghkPBF1vNoHDCmJZ1DIRzQe3MFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvBioIgGC6UqPsv2Z7vuzPF81m+zCbq5btYFxhlAvOM=;
 b=k6Phou7oLiQlL4XRBpHFaJW1C2zjp0uOkrV/ritKd/XALTbCCmWz75j6hsXt1VO9bttbDE70BLTDg+0sSLIRcklG18OVUABoAGlDagmfrOmYjMWAfkIYkGvXEt31tikWk9Yz+on2cVGKEjBSZf5DYFtSBSdt8ni8TrsExzvKu53J1eMm7GAvyB3ifE0XPyXirbOIbZyXFPXLVDr1cSn1ciQzB7ZDq8ng00g/HtnDYGFXTSPZ3XnVfH0rX2hospbId+nWCHcB0z/D+z9pd8f+G3IdfrcPgE51boJxtFuOdhfNp9ECHC501GpqpfCoUnCRTwoLpw5H1Ftpkq0Cdu8unA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvBioIgGC6UqPsv2Z7vuzPF81m+zCbq5btYFxhlAvOM=;
 b=TgjBgahC/vZHDKw41eo+eASfTfEcgK1BpZloS0Sa29gl/SGAWM83R5GvjVRqcVplMlRIyyVJpMI6zE7XdrdC+pB4kRx9WyUJoJRMArIIrPA8ZyLh7FAUTBbXN8mwI/ji0KaoWtLA85wqIqcwbeK4o8PGlwS/xB0GJeT9jK8tmME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 12:11:37 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 12:11:37 +0000
Message-ID: <ada10028-ed0e-fc6d-be9b-e649de16abcf@amd.com>
Date: Thu, 25 Jan 2024 17:41:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 14/17] iommu/amd: Refactor GCR3 table helper functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240116165335.6043-1-vasant.hegde@amd.com>
 <20240116165335.6043-15-vasant.hegde@amd.com>
 <20240119195907.GN50608@ziepe.ca>
 <e8f2c380-acb9-bafa-c2b5-5445c0f06a4e@amd.com>
 <20240122182607.GP50608@ziepe.ca>
 <c60ed34e-063a-b9fb-9255-365d3662f076@amd.com>
 <20240125014605.GV50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240125014605.GV50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0179.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::6) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b873c52-566a-4702-1aae-08dc1d9ec756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b8m0T84C1/JyU18m69xbSKCxMhdMIcDHZrskzifh6swfw+iMaDCBnYHnt+SglS94nIEJEsVpYMkF5xPt9ChLNFdj8i7dvZB1TCFzgXGpnZoZbCaROkDuslR2sLTNX388bUaozSbYtum1nc3I4TNdc3N2CKTsHTatZkQzdBPQSAibc+mQp2ZJKcOM5dkJkjZO/yhX7EFcIOD4GF2i4HrstkVDBxisWf4I1SQIUqY5vGPmJqLO55fcYdZW3gEd6gBBDy0X3uzyRD7Y/p7upBERGNrsyDBxcWJpLFlawNpx86HrFYStPllH0ZnR0SQaXtAju6FmgBGS06hnQzF5jucJc9/Z4wHrUo0pOY0bS0atP4gazt9g8iQKdPAG3oiVGW0DrxhE0/kdggXlxUaZV2dI57Bx89+sCkiEsX3/01dDpTU2MIKxm1aN73WdM33gaLN+7Pov39rulOvleRBw+Zd6lq7tV51tXNw1CABbMC3d/LY6h2KED92JHLQQr4W64K3yKWZHYDxq0z3WIQVWYweyoqNUC41cNInU1ZjOPnE8javBI3lEUvtKukRt6vCcE4ur51IyId7oosTGcuueIhSdgxsOs9I5zQ/TLuZBcim70621JBya+i36DCjqlj6YK0co3MoD0rcc3WA8rW7Q+G+cRw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6486002)(478600001)(38100700002)(31686004)(26005)(83380400001)(316002)(6512007)(6506007)(53546011)(2906002)(44832011)(8936002)(8676002)(4326008)(36756003)(66476007)(31696002)(5660300002)(66946007)(86362001)(66556008)(2616005)(6666004)(6916009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFJrWFB6ZWt0cVc2K3BNSHVTaW5ZcTByeU4zNDV3ekN3dlZFMW5ucTkyQjNW?=
 =?utf-8?B?SXcvQisxb2lvZU5LeHFHWWFRR2tkRnV6SHJSQmQ3L3B1bUE3cEt6QWZxL1dX?=
 =?utf-8?B?L0VsVGlOZElibXdSMkhjYzZ6YWhOZGRQdy80aUcza3ZwcmppQk9QTENTdEZz?=
 =?utf-8?B?WkpDSHpsVUEvWlVPd21TNEpyYm12UEVxaDl4V3Y5YVlUZmNQSEVBemlRWVF2?=
 =?utf-8?B?czQvZHVPczhidUFpVFE0Tko3MXdXS2NFOTdCN1h0N0RCUGVocnhBLzltM3oy?=
 =?utf-8?B?SVloTTZ3SHRSWjBSUitpTjdtNFZ2WE03dlZlcUdFQ3d2dEJYdDlRaWZZU3E5?=
 =?utf-8?B?T1ViY1Q3ODMrVTFFekNjSVV4V0xYK2FnMHIxcVRJaUhMK0RWK29QaUpCaUI2?=
 =?utf-8?B?TmNPUWd6UTdEc0tqZjZYMFFxYXlRbjhnZkErMkdvM0VpVzUwZEI5aU56YmpL?=
 =?utf-8?B?aytGZU5VVFQwL0drSy9EM2JEOFdaWHpydGx6clVXTU9BeUpWU29SNVNuc3RK?=
 =?utf-8?B?WHprRzM2dXUyNzdPcnNiTmIreStaZGRNT29JZEd2TWhOQWlPVU1XYmNQeElw?=
 =?utf-8?B?Y3lmdTZFV3UxaDNZSExMQTViUTRyd1E5RnJmZXROeTg0UmFvaHBNN2huNDhJ?=
 =?utf-8?B?N1VpNzNHdytNdFVlK2pxTmlUaEN6RWxPNEZ6bkNpT3hKTmFiVTd3bHZrRnN2?=
 =?utf-8?B?Z2JvZEl6ZC9RclUrbU1QQXdsRnd3eXJoaG15NWpHaDBSbVFhOTJuTFBrV1Fj?=
 =?utf-8?B?SlpiUk5QdVhNMUQ0SHlYTjgwTFpnVitOdmpwR2ZUdWNLNmZuVHVoUmdnRUo4?=
 =?utf-8?B?TEx6WHhodTJDWnFyK2pBNm1kWjhnamZpMWt3SHR4K1MwT3kweEhkNk5ZOWdp?=
 =?utf-8?B?dkJIMUw5YVVSZUV1S2djK2xPUUE4bVpQRmZmME9FaTV0OU1ZbTN5VkJIQmFi?=
 =?utf-8?B?ek9wRmcydDJ6U1hudXNBZWVUTWFFMm9lKzlRaTZWMHZhSHE2VkJvVGtkZjRa?=
 =?utf-8?B?OGxUbXhIVzZKOUNqV1pScXU4NnRQSjdRdVJaU1pDYVU5Y1pKUTNaU1dkM010?=
 =?utf-8?B?QWkrejJvSHRIWUVkaklVa29ldHhvWnFUeCtRMitPampCMjdYYk5JaGtxR3Y4?=
 =?utf-8?B?aG9iR0d2NEFFT0VPYnZYbGhEMDNwZFUrbmhic3RYb3hURTRvbUlTMzNmN1gz?=
 =?utf-8?B?WjQwS0lpZG0za2pQTE5oNGpCbVJMeFRxaFZVRVVqQTJ0SHhCVHltZHRTRFZH?=
 =?utf-8?B?V3Q0VWhsdXY1V1BXU3ZHcmV5OUxoNVhMQXYwUUxWMjhuM2JTTjlnYlZWWXU5?=
 =?utf-8?B?U3RNUi9KQ2RESXFlTVdEVTcrMC90KzVLM1RGR3FkWjVIbGR0RkpFekhrRGpF?=
 =?utf-8?B?eG51V2hBck0ya3gwT0xLcndRZ3JEbGxsZXJ4N0JJVWpsUkVaUXZmTFdnTWE0?=
 =?utf-8?B?Si92NU1XL1IwSTlDNzVpMVQrdlBrOTI2cmdmcEFUZ2lQZ0JUQzRIbnphRlhV?=
 =?utf-8?B?RGJVb0xmNFhlNXROcUlQN1Z5NTRhcHBGSm9mdjRpaCttMHh1UHB6SDBUb1p6?=
 =?utf-8?B?T3JlTi83SW16YmwvT0ZTQU9sVXZycDNIK1U3U3VXUThOMVJscTNxeDJJV3Av?=
 =?utf-8?B?SitJU2FOelpBWGE4S3FER05GVEZSVSswQkJEczRsUGlwTTRSdFpsTVhQSFVy?=
 =?utf-8?B?bkk4Y1ovWitvZ1l2UDQ0QkdYNUNBU0RzTlg5OFlGbjdSR3pGT1UrTkgvTEV0?=
 =?utf-8?B?THBNeDVNVFFXT0lmeHcvL0lCd1Z0dGo1QkY1SEFGSTkxSFhaTnZGYVQ1dUxK?=
 =?utf-8?B?dlNKOUY1aitoMW4yQmw0bW9jekxQSHBoMDFuV3pSeXdHZWM4QXBwNUt2YzhT?=
 =?utf-8?B?T1c0VzFSdEpjbTFLa3UvNFlWUkRaUmtBbHYzcHRDUm5Zb2VMSWhvM3Z6RUZr?=
 =?utf-8?B?akNQU2NGcXJzWEFWVERVVkZSQ2FaczRBYWlxVkphT2IwbXY3QStKeHQvQXN0?=
 =?utf-8?B?ZGRtbjZPK1YweEhTM3M5MHk5QVVMMVRlVURTYWdEM05zLzZyeTJKSHp3SXZT?=
 =?utf-8?B?NUxnZWdXV2c4S3pPMFgzS1pzRTViTEloS0xEa0lSQVFMNHg2VXlYdS9VOTZu?=
 =?utf-8?Q?iyom9aF0isDuL0EIWGAO1IVyM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b873c52-566a-4702-1aae-08dc1d9ec756
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:11:36.9717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvqhB7ZBnJFkwpge6qbmcY8Wrj80pYPYz9/PZye/Fa7pS/QRp15fmrVpvntlW6s2aJthL+QZZ/7ZcPLloSk0jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738



On 1/25/2024 7:16 AM, Jason Gunthorpe wrote:
> On Tue, Jan 23, 2024 at 02:24:51PM +0530, Vasant Hegde wrote:
> 
>> domain_id_is_per_dev() decides how to allocate domain ID. Right now for V2 and
>> pass through mode we allocate per-device-domain-ID as they can switch to SVA.
> 
> That makes no sense. You don't need a domain id for passthrough mode
> unless you are also installing a gcr3 table. You don't need to install
> a gcr3 table unless there is a PASID being attached too.
> 
> Pre-setting the domain ID to avoid setting it when the GCR3 is later
> loaded is spaghetti logic.
> 
>>> All this logic should be shared between the pasid and rid attach
>>> paths.>
>>> The passthrough thing is only an issue of DTE construction.
>>>
>>> If you build a DTE with a GCR3 table and RID=IDENTITY then you set
>>> some bits, and that is it. Detect that case directly when you build
>>> the DTE. It should have no effect on what domain ID is used to tag
>>> translations retrived from a GCR3 table.
>>
>> We build DTE as soon as we attach device to domain.
>>
>> Now moving domain ID allocation to setup_gcr3_table complicates things.
>>   - In attach_device() path we want to allocate domain ID but not GCR3 table
>>     We can allocate GCR3 table, but if we don't use it its waste of memory.
> 
> It is a waste to allocate the domain id for identity too.
> 
>>   - In SVA enablement path we want to allocate GCR3 table
>>     But by then domain ID should have been allocated. We don't want to allocate
>> another domain_ID and change ID in SVA enablement path as our domain ID is not
>> specific to GCR3.
> 
> Again, this seems to be a complication that is being created by the
> DTE construction. You shouldn't need the caller to carefully sequence
> what it is doing. The DTE programming should just install the correct
> DTE for the *current state*.
> 
> A RID only identity/passthrough DTE does not have a GCR3 table and
> does not need a unique domain ID.
> 
>>>> We need to handle passthrough as well. It doesn't make sense to allocate and
>>>> keep GCR3 table when we are not going to use it.
>>>
>>> Then don't, and my diff didn't - but check for the passthrough case
>>> directly against the attached domain as identity.
>>
>> We don't want to add condition check that depends on code path:
>>   like attach_device : allocate domain ID but not GCR3
>>   SVA path : Allocate GCR3 but not domain ID.
> 
> I'm not saying you should do that, I'm actively saying you should not
> do that! All paths should be symmetric.

I still think its not a good thing to do domain allocation inside
setup_gcr3_table(). Anyway I have changed it in v6.


-Vasant
