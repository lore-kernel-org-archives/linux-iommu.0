Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF77EC8
	for <iommu@lists.linux.dev>; Mon, 28 Aug 2023 06:10:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVfvwrqwQlkiV6hGxtxR6/TVjcyqRLWLYqiQFw8OycpSwT3lmqdAzdpS+kyfZUtYRdylzQMe1zXojDrH9DtbunqtARTvFkh6WzrXmwZ3iiwtQWNIcixI0+2EEBvt7rPq8LyC0s9tvRvkRT2WKRLbMh5esaHItuOB4bhMqj53XE0sfeHKU2QpMmOzQGsy1dt7T1BKo/dpeSPYt1FX5nRvLj8BoUpFXB12bCEViz9BQGJ1nauwDhdGPdMh8+O0yLvTeJ4lIwO4zD7wouIlwwzN/v2NI8ZkhemPqeoDA+7DjqyyFpfoGvxbvIIl6X9SA0hn/bijdJ631k3hnBRvi1hEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfNgUNDgy9US9KkNTxw8GPtZbm4lp3HBX8JJ9oDfJVg=;
 b=nCmqjVrZ3vR1O8TXQBc+5ihMPcW2jkrUcS9qlRFnVIvdeka5JCxgcApNNq3eECecHEVxFVN1xqsOcnO+TqE7btmwIdpbZ1Kz+3TM2GfTL3WjrxfrT4dHSiJ7ppdEyebSst97/l6cdXYusNsKnniyrDA5du8xLpNfLIbEmvjmj8v2zEoPJrYDDJbpUVemi3I6r5TsUpcX/+ImrvMlG5ilKCQ+Kap7Vc1/ITLbVQlTGKHsSNhTeL10KK51MdkLiqvo/sKJI/jWb//qrtNrsc2PMWnIaT0dAUyZz1m4NGTUFMDEIPYGxt4HXBAwOaHXUuVPyaSYB+T7MDqcNESbrduy0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfNgUNDgy9US9KkNTxw8GPtZbm4lp3HBX8JJ9oDfJVg=;
 b=CMNO6dc3xi6AjWzxsdXov/cg2KSCiVLBaunK1lPYiL9aSZhGFCxnVNO7YPIDczEmzOIe/toRQ2cJaDk6FRBqN6jfHPwzvyVfkgJHuZQJCIsjDF2By4ZFkTbr41OSk8t/sxLr9axhVMRI7ZqC7O1PA52H0DTdNwYCXW52/DzZLMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 06:10:33 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 06:10:33 +0000
Message-ID: <873d777a-0c32-8613-3a4f-f91856587598@amd.com>
Date: Mon, 28 Aug 2023 11:40:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 5/5] Revert "iommu: Fix false ownership failure on AMD
 systems with PASID activated"
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jgg@ziepe.ca, Robin Murphy <robin.murphy@arm.com>,
 Takashi Iwai <tiwai@suse.de>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <jroedel@suse.de>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
 <20230821104956.707235-6-vasant.hegde@amd.com>
 <y7bcqc25x3uyl36v6jv4dtaepfzaunlzglbreg4jymgw5ntzku@sttkvft4qwcr>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <y7bcqc25x3uyl36v6jv4dtaepfzaunlzglbreg4jymgw5ntzku@sttkvft4qwcr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a5667e-84fc-4ab7-64ba-08dba78d7ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LvVTFJaMGSjznnLuuxY2CNYilUbvx9hVRzpB0rzGhl55zTZHfgZm62qDgXtQbcup6mjVPscl0h9zLFGP4lITnnvKEidMBz4S2yYtUgO7dETBQLoeVfKvCckdfhHG5ImIFNhyjVPlHqP0ufLkd529VCbtWpDHSy/5IM76AGvw7ThDSkqgQBOho3UMtBI/sEbGgBGHJKmPnz9N9XiDmVV9lhNMRUEF30hNlSe56G+fuCXGAzFw5d9eLKe3/8Q/UCi1SDxazuoIqVHw4tar4brc+tz0N/PaTSdbnULSQ0e0T8YFn/6nQ3uiKGD1976WT5i0qq8S1W6Zfw5XVpc/dIjE39+o/FhshY3wOzH+9ZAStc8Rd18EoFou0T5Mlv6d4BEQZqfgxLopWb0H1Gsi7H9liu4itnWV9vEMBi5jfyaMIL7Iyfw64CbSBcLFtsyifi6lYNYPTrVz7gHMBZTZbslMfj0ExdquTp+paRgIIQD7SS8phVUxeRlTTpkDUuzzPUgAoOLsMAa/JnNx1Ph2wzLYJ2f8ZeK/tNxdZ4wkO2bJl3YHloV70579TpLwBfxrfhBWP8dwEJPAmegtHmusqsDTrWr1i5LiU3BlrO5iadI0KWErIR8CHk5XtioKIl3CEiVK+uD7T7KOkc77MP38ZXlMCg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(6916009)(2906002)(66556008)(66476007)(54906003)(36756003)(316002)(66946007)(5660300002)(44832011)(31686004)(41300700001)(53546011)(6486002)(6506007)(2616005)(26005)(6512007)(4744005)(38100700002)(478600001)(83380400001)(86362001)(31696002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVNZWTRvUTNLQnZvY3kvNEtmb1dvR21KOC9FSlZPMCsyOXk0K2VNeDBXYTNJ?=
 =?utf-8?B?YjVhZ0tKM0YrMkh5YVRLaG56amdvZ3dVOEpNdG9lSVJoRElqV1dNYkdoRzFL?=
 =?utf-8?B?RFJyTU9nOG5SZlNpU0pLNDRaTXN1dXhYU2JZdDVaVndnOHVhOHZrbnYvSjl1?=
 =?utf-8?B?ODh0TGI1RnpXOGY3U2JNK3lTekpRdzlOV0Y5ZGhQV1l4ZGs5L0lCYmxWT1lS?=
 =?utf-8?B?N2kxK05VVlFpb1hrdWU1ZDhlT2lyUzdyZmpSS29lb2RXMDg4Z0xweVZXTjBS?=
 =?utf-8?B?c1dnbXBHOFl5RzBUY21JdnpqWEx0emgraHJ5NTl3c283Z1dpQ2xpU3VKSjR2?=
 =?utf-8?B?cUdFVzhSNmhTcDJpbXJMTGE0aXRPUVdlZkVTM1RWaytnQTJMODArWUN4Q1Fx?=
 =?utf-8?B?MW5MN3huSmJPRkNjZ0RvbnpaTExZLzA3eDdiZldyVU9zMHlWcUpYUkg1THNL?=
 =?utf-8?B?NndwSlFIMGVHcURka2x6eDVHOEREcGN3azhpN2JMMHhBazh4Uk9hWVZsSXFZ?=
 =?utf-8?B?YlJYbXB4dzVpeUJ4elIwN2YyMHpFSUhCZThFRUdyRHc1aGVCSHNURER1MDV6?=
 =?utf-8?B?ZmY2aFdkZkFKODRLZ1dUNjVPdWoyVk1QQ0srdkRVR2NYN2cwR2NqWm5nWVpa?=
 =?utf-8?B?eEJ1aUFyS3hKMG0vRlBYQS94SXhsR1FVQkoxRFFrYXI1NDcwWlRZSXdaTitw?=
 =?utf-8?B?TkkxTWw2Y0JTMHoyK0wzK1hPR3A4TUs1VGhpQkpyT0ROeVVoc2xMRmZ5ZHRN?=
 =?utf-8?B?SFZHSU0ydjF4Ry9XYWJFWlBVbHM4ZkZqaE1ycDBCMXhyaVdnTllCZ1VTelo3?=
 =?utf-8?B?VnhQQUdLK0dTNVdHQnZOTitQV1VqZ3N4Nlovam5xQ2dSQTFrTFV1dGJsZ0M4?=
 =?utf-8?B?ODRWN0l2Vndrc3FiTS90RnJ5alE0ZUtTM3pHMHJpRVdWTWphMmVlNmxwb1FK?=
 =?utf-8?B?YkpiTHVLOStXYkxZVXJmekdENTk2RldkdmE0RGQrdm9WRVNwRXdSQmJ5TitO?=
 =?utf-8?B?OVhHZWpFSDVUalFQVVpURUMwTTYyQUVnZ25EQm81bTdMY3lOVng3ZUZsUE5E?=
 =?utf-8?B?MVBXS2dFM3dlQzFFSW5BQzZLekNkNy95TFB2Mk9SSTAyZHlLeGFIVGxpeStD?=
 =?utf-8?B?QnJpVTVMbnZ3dEt2YUhaU3dZcUlSNmR5ZzhFVWsyRW12Zmg0Zm1LZUpEalBX?=
 =?utf-8?B?TFBmQVBCRml2bCtCVTZYVkVRU3BwQ0FZUTl4bGpRMGVyNHQ5NzVXSTBXSW1H?=
 =?utf-8?B?RWpIYXpFRkRranEwVC80VXFvRzF3UEcxZStsazh4YWlEamFhSGFhSFpFd0Ns?=
 =?utf-8?B?c1BkMW9La1hQd3lKdjNRNzR5QVMzU3RWcjBnZFVOOWh0SjR0NXpBL05wM1JF?=
 =?utf-8?B?SldKT1NQaTNWRkdQVEFQM3cyQ0FKd0R4WUExWVBLOW1DWWJCTlVOdHNIanRw?=
 =?utf-8?B?cllPRFZadzJlOGw3cUFwbXpRVklBTVowQnMyc2V2V3JlMUR0VkZaM3pQb2Rr?=
 =?utf-8?B?OU9XcUZSR1llZHN3YW13RldEZk9aS0xFTmtFQ1pVSUJNb2ZtVGRXVElLb3ZX?=
 =?utf-8?B?T3hZNktDZU5FNSs3dUpoY3pwV2lvYlhIcWs2RkFjc1pzVG1sQ1ZqbFhWK0dE?=
 =?utf-8?B?OHAxVW5SbEVZOE5Vd2gzMDRVUmo4Ykg4Tk5kRXMxQTZpRUtuS3BRZk5ZUjBh?=
 =?utf-8?B?K2RBajJxZTFhT0E0Q2NKT3dFTDZVdGFPT3A3MEVxUlkxZFcvY2xmWEw3UGgy?=
 =?utf-8?B?VWRMclBoUGR2cU5JVzNOZFFFeS9sWFgxOUQzc1lZbWhHUjVGZ1lvRHM2cXgw?=
 =?utf-8?B?TVgrYnNxd25rZXdUMVIzOXArRHB2MlcvdjRvMUowUXlvVEZMU25LOXZMYm9B?=
 =?utf-8?B?bmZwaE43Ykh1Qm8xb3g3TVhOenVYb3Q4MnlhYTBPUTlqRG1YdW5UUGkza1lI?=
 =?utf-8?B?VExrZVJ4VUpIdnMzTmw5b3FDbG9yWkJiS2ROVk1zR05aakZ1RmhpWGYzYmxl?=
 =?utf-8?B?UTFmL1FLaE1YaHhPUldRR1NXa3RUK0gyUjB2QjVOelVDUlkwNjA3QnJnRjVZ?=
 =?utf-8?B?U2pXOU0xRitYb2doL2htaFNCZnBoc1NiSStxM1llMXczZk9ESUhQMWdubzEy?=
 =?utf-8?Q?ZxWs79Sq3GcopKemhSDRDGMDr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a5667e-84fc-4ab7-64ba-08dba78d7ca4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:10:33.0535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lgr+DhaNAkptTx4Tsu1oExbnpQ664nKMbgw18CxNjrdJuglzQQqOa6nlhMeXW7KVD6E44UJ1BONOv6/RfKSIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928

Jerry,

On 8/25/2023 4:18 AM, Jerry Snitselaar wrote:
> On Mon, Aug 21, 2023 at 10:49:56AM +0000, Vasant Hegde wrote:
>> This reverts commit 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a.
>>
>> Previous patch deprecated AMD iommu_v2 module. Hence its safe to
>> revert this workaround.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/iommu.c | 20 +-------------------
>>  1 file changed, 1 insertion(+), 19 deletions(-)
>>
> 
> Minor thing, but is the deprecate the correct term to use here and in
> the cover letter since the series removes the iommu_v2 module
> completely?

Yeah. I will fix it in next iteration.

Thanks
-Vasant
