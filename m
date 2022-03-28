Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E755C4332F
	for <iommu@archiver.kernel.org>; Mon, 28 Mar 2022 14:27:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17D5581429;
	Mon, 28 Mar 2022 14:27:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0UP6_bjK3V0B; Mon, 28 Mar 2022 14:27:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BAEBC8145A;
	Mon, 28 Mar 2022 14:27:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D858C002C;
	Mon, 28 Mar 2022 14:27:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4F0CDC0012
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 14:27:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2C3DA40123
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 14:27:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=nvidia.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7-HTCbua1lg6 for <iommu@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 14:27:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::606])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56D2B400D0
 for <iommu@lists.linux-foundation.org>; Mon, 28 Mar 2022 14:27:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKpAP/Y9Elr45lcockaRWQ1rrbtuNGuqZoYmQxU2PFlbyEbiwoT6sJ2FM7rog9xBscG+7dhZQfE7SyJL3Gk1pypnnSrlljYJgGTUgZRhLdSWkVdItawBYPNozqks4SeMVlvDVqZgmdsGPVx3XPe8riWm/6/1TLO1HCTQD5+wCI1n+xJMBzCJnhrlk9siAL9c3E7CHZmfHLH8DLSZDnSALoyj9Z09+Pyi1MHeEIz8YolbxOQQk3A6mDLJ7bHPcdGIvbTgjHGsMwPKInNcxBa/1wfLK6mzkYb/4ksrG1Keq/PxwWYbj3+6GOj/kINai8gHYE5DvJN1cxiQ9E1KQEDbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCqcNI7Gsn8EueQsIgCp0TvGpSQmPdJNlHppZuDqTz8=;
 b=LAm1OO6N7SKNtj4W2RKgBpm9FULEQ1t74IyEXofk0cVg91x8KTPgnLYnNEdoML+ydOJfoR+DBrMpehuDsNdbMicCPvOiX0TXQzpWjdV0r/ZMUarwvBaU6ZuJqCZjL/C/d/Pt2aLCCP5S0qPX4cK7nejIs0d5sqwKuLX96Vw4LrvCtQd0up55YWD4fm31VnwOi+j0s3W6+9cVArshJZRs23wdwd2z7ao0a4JbX+OZLE4+N5Xst3x5UyvFkki6cHxzg0jtwhHrhu02JP7cFFSrQP2pd2yrPVfu8cEQCuJwNIRthRcsjDlTKJv3tGyFDzCS90vrhjBIiBGtW/gqYTy0tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCqcNI7Gsn8EueQsIgCp0TvGpSQmPdJNlHppZuDqTz8=;
 b=hPKrt6v/H1pqtIMo0FvWyaLLw1FzVvu61E1zJtgWmI2M3VeRhlEtB6ftpbeLrh03eJqL9je3gYaUiuhtZ3FRlpb7urcoNlFKvgdRz9MwnRmsDqt4bKi8nMOtQ6SahY8iG0njFed/fEMJcSCLY1KZNHsrur1wQBJc4awF4ibg7muydA47YKfGzyPEteLbI5HcqKSjOHhE9SGEaY3VoVGKgOIWa6XteaAWqWyl9wzUgji/OGj4iFyUKfvKUWsERCheg9vDyW7zvbIj0oJs7Tq5TLulvZ6Zs2qJuUyO8bI57tPfC889MkMU/Qd/O7wgavae+GqgiddpNP9ohX/pqXrrIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 14:27:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 14:27:31 +0000
Date: Mon, 28 Mar 2022 11:27:29 -0300
To: Sean Mooney <smooney@redhat.com>
Subject: Re: [PATCH RFC 04/12] kernel/user: Allow user::locked_vm to be
 usable for iommufd
Message-ID: <20220328142729.GQ1342626@nvidia.com>
References: <20220322161521.GJ11336@nvidia.com>
 <BN9PR11MB5276BED72D82280C0A4C6F0C8C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEutpbOc_+5n3SDuNDyHn19jSH4ukSM9i0SUgWmXDydxnA@mail.gmail.com>
 <BN9PR11MB5276E3566D633CEE245004D08C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEvTmCFqAsc4z=2OXOdr7X--0BSDpH06kCiAP5MHBjaZtg@mail.gmail.com>
 <BN9PR11MB5276ECF1F1C7D0A80DA086D18C199@BN9PR11MB5276.namprd11.prod.outlook.com>
 <CACGkMEtpWemw6tj=suxNjvSHuixyzhMJBYmqdbhQkinuWNADCQ@mail.gmail.com>
 <20220324114605.GX11336@nvidia.com>
 <CACGkMEtTVMuc-JebEbTrb3vRUVaNJ28FV_VyFRdRquVQN9VeQA@mail.gmail.com>
 <5accdd9074f20e8fef30984285a23366b7025497.camel@redhat.com>
Content-Disposition: inline
In-Reply-To: <5accdd9074f20e8fef30984285a23366b7025497.camel@redhat.com>
X-ClientProxiedBy: MN2PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::14) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3b903fc-d9b8-481c-814c-08da10c717af
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5317A3C7768FCEE62B22B8B3C21D9@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nQJ/v7aS1wIE+B7jE/8TKhGnId7ygWaWxVS1yFw+lA6xoo/Yl9BHyTGvkJq2Q62PY8OLJTFrITrUdSKVIdS+ZY6iI6kWy/o+Cb5HCP2mJEP3vvN0giA+XA16hvxPb7Zy9eaVV8S9tVDgRzn+SySOd1pKRCldKOnrNtkq6sbtHFdjubhVfjDIMTOKZWZ+e7Zo8/ZtiXbcaJvGV22ZBrlCIySG7DPbNuyFWDAyjMKDvzuxA02RbQoVZiGU9z+tz0CK/glSEzNfUOZaOhhj6uAh10IYc3S5yDv/w5+5xHYWGSiPau1VXIFoT83hlf3Ivzyp3KontODrjOibqZmkOIbr585X5XteK/P4xfRp3uPOaA2LnBQ73br65d+4dv/hkg77kQyWljIytUV+a4Sgapl+dB2CC+5kRzVIFwwlQnXeeyK7WHjTkxNAh+8EvSrm3hpgrVNoro58eukmohIRFJEM5WXiWM8LJZkl88cdCaEHkpxriNb7qcGQGdyUVylWix/7Yly48+L5DVr6WXSIGGba/NoCsj/OedSiHcZPnbyy5/BH5dGfmlTXELqDtnb3ER4o7jeXJWkiXwPApsYe2ezO4WB1XNfHyybD6vJWrB8bzHqlBt2VQu0erM+u8ZmOTsJbGruTWNgmfKeLiYqZZ5/+Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(54906003)(6916009)(2616005)(38100700002)(316002)(6486002)(86362001)(33656002)(8676002)(4326008)(66556008)(66476007)(66946007)(1076003)(508600001)(26005)(186003)(36756003)(6506007)(83380400001)(53546011)(7416002)(8936002)(6512007)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emVTbkNsc1dDZ0VJVmVjcnhNZHlBdjZXT3RxMlNwWG9jcENIS0F1blQ0S0h2?=
 =?utf-8?B?Y0hNTEp0MXpjRHFFcHNtM2ZNV1hRYzF2U2puUEEzNmg3MkJzaWl3TVg0Yjho?=
 =?utf-8?B?am9UdEhTbXlqUkZudlFNQUZZVTRPR2ZxRGlMUXg0ZlhVVVJtVlo4QnJubUM2?=
 =?utf-8?B?Q1hvTEExSk9FRE55aWhUb004NmVMdWVteUhaeUk5MUZEbkhENUk0T2ttWXJ1?=
 =?utf-8?B?MEVCSEJ2TTEwREpMcmo3c0NwdmZZOTNRRTZ0alJHalIrT3R1dFlsbHhuOWJs?=
 =?utf-8?B?OVlqZTBhcHJsRXJyK0hDL1YwcFRNbnRyOWp2RGw3R294SlpZclNMNVVsSllz?=
 =?utf-8?B?OS80TnY3ZXZrUGJQOFVaYTY3VW94cE5CYVZwV25uYW45VUF0bHo1VmQwb0da?=
 =?utf-8?B?dEEyRENaKzBmYnhyOWZkaW1QM3dYSUZaZ3loNnRzSHRtYmtJVXpkdk1NVWdy?=
 =?utf-8?B?Q2IyMHhiR05wQUdCN0JubUZCdE55enFTZVdTNHB6ZkpLalhNN0FyNFNjWWgz?=
 =?utf-8?B?dWVZdTRJbmVPa1RwdkN2Zm5KU3NYRXp4TU1Pb0NUemg0MlpNSVNuQkhzdlhw?=
 =?utf-8?B?UkVPd1RzRGIycmpxM0o4cENYK0QwREpBc2lTanp2WWRnSkxiVllQTS9RbVJF?=
 =?utf-8?B?YU5RcEUvU0J5alNBZ1lBaGRPMFkvcVNML0Iyb1VxTXNZYjJOQW9yTWY5b20r?=
 =?utf-8?B?RGkxam1BcFh2SGJOdUNKV25xZ1lKMUNGOGFSWlptNWtLNEZpVjdIRm04Y2Zz?=
 =?utf-8?B?UUkwN3BQSWQzWk1jK21QSmE2VmxTakJFUVhKVHBBamZ0YUV1bjk1YlRpdjhI?=
 =?utf-8?B?WXNVaE5FbFVTVmZ1NDBpaFd0NW90N1ZxV1Q4VjZWWXpqMFZ0ZStxZ0xYc3NN?=
 =?utf-8?B?d2dtOXdFZGxzM1Y0cGptYWxZM1Q3cWpGa1VZLzhyQTQwSFB4RkVRekh6Z2I4?=
 =?utf-8?B?N3BaYXZUTnNvSmVielV4Q0o0a01UWk53TFJqTXpKNFpkWDZWQ2JWKys5bitj?=
 =?utf-8?B?b0NxUEd3RDVpL0dOaTdodFFvdmpiM005Sko3U2IrQTF2QUwwd203dkxDU0FP?=
 =?utf-8?B?UmhmUzZseU05bmZHc2tCOGhnc2JCWitkdkd1S3p3VUx3cHZRRnIvaFdkZlM0?=
 =?utf-8?B?aUpxd29uazNucFBVTUVWNWYzL2Z2NEVwRlJvQ2ZzbVNFS3g3b3FNeXAvQWM4?=
 =?utf-8?B?OG41dzhoYVg5RStTUi9FT2F3UDNyelJDTkZTeWs3ZWs0aVpVa2duaDVhbXhy?=
 =?utf-8?B?Rm5oUVNGVWNiSGFESFgrODVpUDBUTVhSZSszbTlRYVVQcDlSNWxweThlMVp3?=
 =?utf-8?B?YXRJb0wxUi9xVFA2ajZyWHJUM1NMQyszTjdyYzFSeUlwQVhsUW5nK2hiWHlv?=
 =?utf-8?B?Z3pPUEFQZ2thZWFVQnYxd1l2OHg4VWRaaEZSVFVzVW8wVGp1UVZIR2JabGM3?=
 =?utf-8?B?RDlHVXI2QmlCaTVsY0xVTFQ2RG5LYXByM25UUTJHNG5TRnFQZkl3eGJzcFAr?=
 =?utf-8?B?Q3pJVXY0WE8zeEErOS9ja2NpRmlMN0pIRjdpMURaT0lYTWIyWHRwNjVIUExQ?=
 =?utf-8?B?TGdMT2p5eHc2UTBmT25UQlY0VVQvSytrNXZIS1diRHQ4blFmYVZRZWFyeXBx?=
 =?utf-8?B?emdLdDQwbDFGeGlJRThoeVZMclZ3ME16L2ZpdzJoVUxqV09EYzEvcUNqcW8y?=
 =?utf-8?B?bSs2MHVMRnAzRTkrekdOWWFpNzBsczd1NFkvMUw0UDlRZ0E5eVhRTXZxaXpK?=
 =?utf-8?B?bXF5MnJiVXg2V0ZrOTJWd09Gc0Vzb0ZwSDR0SHN2UnUzUlVKTnRoUUtrdzhC?=
 =?utf-8?B?QUg2QVBVVVpLc29iUG9PZmNoUHkvNmIzd3owZ2pmbnZlNGpzaVJ5VWtBSkVx?=
 =?utf-8?B?ZlpyMmpyTVZqSmxCQTNDOHZJSkkwYU1uOWJlaTZkZ3diS1VJWmRWR01oS2E3?=
 =?utf-8?B?MS9GcHRMeUMwcE9heVpMbCswNlF1NktPWkdIcnR5ODJXVmZWeDFVdlQrNytI?=
 =?utf-8?B?M2xneUN6R29wQ3N0cDJKakkyeElFbzQ1bllmVFUzZ1ZiODFHRTNtbEVkMENj?=
 =?utf-8?B?cEtzWFg0ektIM0U2L01BRGdJNm93NjhoRjl1Q3FUbmxrTTJDbE1PWWx1NlVD?=
 =?utf-8?B?eDZzQkRUNVVvbFArR3BvNE5IRUtCc1ZaVEw5bEx1MXFUdkRWa1dObkQxUk40?=
 =?utf-8?B?ZU5QdWtyY3d2OHVsQ3UrN2l0Q0VLRW5yWEw5a2JwYWhrRjhFY3B1eWhtUUZ6?=
 =?utf-8?B?K0k1anFmMnE0STNKSUlORmRpNmFOa3RXNEtTb3hlZnNBVHE4L0VrSVVYU2M1?=
 =?utf-8?B?RjdBMzJiN0o4WnZ3Tm54L05ibUtpS1JGSVNMUzBja3hmWCtETUVrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b903fc-d9b8-481c-814c-08da10c717af
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 14:27:31.2178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvO72+Wpxjr333bkqeuGN2LaU5Q3U+SIRkB2wkfKDGyljJnyr8zd5EDgIe+LKYaK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Daniel Jordan <daniel.m.jordan@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, David Gibson <david@gibson.dropbear.id.au>
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
From: Jason Gunthorpe via iommu <iommu@lists.linux-foundation.org>
Reply-To: Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gTW9uLCBNYXIgMjgsIDIwMjIgYXQgMDI6MTQ6MjZQTSArMDEwMCwgU2VhbiBNb29uZXkgd3Jv
dGU6Cj4gT24gTW9uLCAyMDIyLTAzLTI4IGF0IDA5OjUzICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+ID4gT24gVGh1LCBNYXIgMjQsIDIwMjIgYXQgNzo0NiBQTSBKYXNvbiBHdW50aG9ycGUgPGpn
Z0BudmlkaWEuY29tPiB3cm90ZToKPiA+ID4gCj4gPiA+IE9uIFRodSwgTWFyIDI0LCAyMDIyIGF0
IDExOjUwOjQ3QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+IAo+ID4gPiA+IEl0J3Mg
c2ltcGx5IGJlY2F1c2Ugd2UgZG9uJ3Qgd2FudCB0byBicmVhayBleGlzdGluZyB1c2Vyc3BhY2Uu
IFsxXQo+ID4gPiAKPiA+ID4gSSdtIHN0aWxsIHdhaXRpbmcgdG8gaGVhciB3aGF0IGV4YWN0bHkg
YnJlYWtzIGluIHJlYWwgc3lzdGVtcy4KPiA+ID4gCj4gPiA+IEFzIEkgZXhwbGFpbmVkIHRoaXMg
aXMgbm90IGEgc2lnbmlmaWNhbnQgY2hhbmdlLCBidXQgaXQgY291bGQgYnJlYWsKPiA+ID4gc29t
ZXRoaW5nIGluIGEgZmV3IHNwZWNpYWwgc2NlbmFyaW9zLgo+ID4gPiAKPiA+ID4gQWxzbyB0aGUg
b25lIHBsYWNlIHdlIGRvIGhhdmUgQUJJIGJyZWFrcyBpcyBzZWN1cml0eSwgYW5kIHVsaW1pdCBp
cyBhCj4gPiA+IHNlY3VyaXR5IG1lY2hhbmlzbSB0aGF0IGlzbid0IHdvcmtpbmcgcmlnaHQuIFNv
IHdlIGRvIGNsZWFybHkgbmVlZCB0bwo+ID4gPiB1bmRlcnN0YW5kICpleGFjdGx5KiB3aGF0IHJl
YWwgdGhpbmcgYnJlYWtzIC0gaWYgYW55dGhpbmcuCj4gPiA+IAo+ID4gPiBKYXNvbgo+ID4gPiAK
PiA+IAo+ID4gVG8gdGVsbCB0aGUgdHJ1dGgsIEkgZG9uJ3Qga25vdy4gSSByZW1lbWJlciB0aGF0
IE9wZW5zdGFjayBtYXkgZG8gc29tZQo+ID4gYWNjb3VudGluZyBzbyBhZGRpbmcgU2VhbiBmb3Ig
bW9yZSBjb21tZW50cy4gQnV0IHdlIHJlYWxseSBjYW4ndCBpbWFnZQo+ID4gb3BlbnN0YWNrIGlz
IHRoZSBvbmx5IHVzZXJzcGFjZSB0aGF0IG1heSB1c2UgdGhpcy4KPiBzb3JyeSB0aGVyZSBpcyBh
IGxvdCBvZiBjb250ZXh0IHRvIHRoaXMgZGlzY3Vzc2lvbiBpIGhhdmUgdHJpZWQgdG8gcmVhZCBi
YWNrIHRoZQo+IHRocmVhZCBidXQgaSBtYXkgaGF2ZSBtaXNzZWQgcGFydCBvZiBpdC4KClRoYW5r
cyBTZWFuLCB0aGlzIGlzIHF1aXRlIGludGVyZXN0aW5nLCB0aG91Z2ggSSdtIG5vdCBzdXJlIGl0
CmVudGlyZWx5IHJlYWNoZWQgdGhlIHF1ZXN0aW9uCgo+IHRsO2RyIG9wZW5zdGFjayBkb2VzIG5v
dCBjdXJyZW50bHkgdHJhY2sgbG9ja2VkL3Bpbm5lZCBtZW1vcnkgcGVyCj4gdXNlIG9yIHBlciB2
bSBiZWNhdXNlIHdlIGhhdmUgbm8gaWRlYSB3aGVuIGxpYnZpcnQgd2lsbCByZXF1ZXN0IGl0Cj4g
b3IgaG93IG11Y2ggaXMgbmVlZGVkIHBlciBkZXZpY2UuIHdoZW4gdWxpbWl0cyBhcmUgY29uZmln
dXJlZCB0b2RheQo+IGZvciBub3ZhL29wZW5zdGFjayBpdHMgZG9uZSBhdCB0ZWggcWVtdSB1c2Vy
IGxldmVsIG91dHNpZGUgb2YKPiBvcGVuc3RhY2sgaW4gb3VyIGluc3RhbGxlciB0b29saW5nLiAg
ZS5nLiBpbiB0cmlwbGVvIHRoZSB1bGltaXRzCj4gd291ZGwgYmUgc2V0IG9uIHRoZSBub3ZhX2xp
YnZpcnQgY29udGFpZW5yIHRvIGNvbnN0cmFpbiBhbGwgdm1zCj4gc3Bhd25lZCBub3QgcGVyIHZt
L3Byb2Nlc3MuCgpTbywgdG9kYXksIHlvdSBleHBlY3QgdGhlIHVsaW1pdCB0byBiZSBtYWNoaW5l
IHdpZGUsIGxpa2UgaWYgeW91cgptYWNoaW5lIGhhcyAxVEIgb2YgbWVtb3J5IHlvdSdkIHNldCB0
aGUgdWxpbWl0IGF0IDAuOSBUQiBhbmQgeW91J2QKbGlrZSB0aGUgc3R1ZmYgdW5kZXIgdG8gbGlt
aXQgbWVtb3J5IHBpbm5pbmcgdG8gMC45VEIgZ2xvYmFsbHkgZm9yIGFsbApxZW11cz8KClRvIGJl
IGNsZWFyIGl0IGRvZXNuJ3Qgd29yayB0aGF0IHdheSB0b2RheSBhdCBhbGwsIHlvdSBtaWdodCBh
cyB3ZWxsCmp1c3Qgbm90IGJvdGhlciBzZXR0aW5nIHVsaW1pdCB0byBhbnl0aGluZyBsZXNzIHRo
YW4gdW5saW1pdGVkIGF0IHRoZQpvcGVuc3RhY2sgbGF5ZXIuCgo+ICAgIGhhcmRfbGltaXQKPiAg
ICAKPiAgICAgICAgVGhlIG9wdGlvbmFsIGhhcmRfbGltaXQgZWxlbWVudCBpcyB0aGUgbWF4aW11
bSBtZW1vcnkgdGhlCj4gICAgZ3Vlc3QgY2FuIHVzZS4gVGhlIHVuaXRzIGZvciB0aGlzIHZhbHVl
IGFyZSBraWJpYnl0ZXMKPiAgICAoaS5lLiBibG9ja3Mgb2YgMTAyNCBieXRlcykuIFVzZXJzIG9m
IFFFTVUgYW5kIEtWTSBhcmUgc3Ryb25nbHkKPiAgICBhZHZpc2VkIG5vdCB0byBzZXQgdGhpcyBs
aW1pdCBhcyBkb21haW4gbWF5IGdldCBraWxsZWQgYnkgdGhlCj4gICAga2VybmVsIGlmIHRoZSBn
dWVzcyBpcyB0b28gbG93LCBhbmQgZGV0ZXJtaW5pbmcgdGhlIG1lbW9yeSBuZWVkZWQKPiAgICBm
b3IgYSBwcm9jZXNzIHRvIHJ1biBpcyBhbiB1bmRlY2lkYWJsZSBwcm9ibGVtOyB0aGF0IHNhaWQs
IGlmIHlvdQo+ICAgIGFscmVhZHkgc2V0IGxvY2tlZCBpbiBtZW1vcnkgYmFja2luZyBiZWNhdXNl
IHlvdXIgd29ya2xvYWQKPiAgICBkZW1hbmRzIGl0LCB5b3UnbGwgaGF2ZSB0byB0YWtlIGludG8g
YWNjb3VudCB0aGUgc3BlY2lmaWNzIG9mCj4gICAgeW91ciBkZXBsb3ltZW50IGFuZCBmaWd1cmUg
b3V0IGEgdmFsdWUgZm9yIGhhcmRfbGltaXQgdGhhdCBpcwo+ICAgIGxhcmdlIGVub3VnaCB0byBz
dXBwb3J0IHRoZSBtZW1vcnkgcmVxdWlyZW1lbnRzIG9mIHlvdXIgZ3Vlc3QsCj4gICAgYnV0IHNt
YWxsIGVub3VnaCB0byBwcm90ZWN0IHlvdXIgaG9zdCBhZ2FpbnN0IGEgbWFsaWNpb3VzIGd1ZXN0
Cj4gICAgbG9ja2luZyBhbGwgbWVtb3J5LgoKQW5kIGhhcmRfbGltaXQgaXMgdGhlIHVsaW1pdCB0
aGF0IEFsZXggd2FzIHRhbGtpbmcgYWJvdXQ/CgpTbyBub3cgd2Ugc3dpdGNoZWQgZnJvbSB0YWxr
aW5nIGFib3V0IGdsb2JhbCBwZXItdXNlciB0aGluZ3MgdG8KcGVyLXFlbXUtaW5zdGFuY2UgdGhp
bmdzPwoKPiB3ZSBjb3VkbCBub3QgZmlndXJlIG91dCBob3cgdG8gYXV0b21hdGljYWxseSBjb21w
dHVlIGEgaGFyZF9saW1pdCBpbgo+IG5vdmEgdGhhdCB3b3VsZCB3b3JrIGZvciBldmVyeW9uZSBh
bmQgd2UgZmVsdCBleHBvc2lnbiB0aGlzIHRvIG91cgo+IHVzZXJzL29wZXJhdG9ycyB3YXMgYml0
IG9mIGEgY29wIG91dCB3aGVuIHRoZXkgbGlrZWx5IGNhbnQgY2FsdWF0ZQo+IHRoYXQgcHJvcGVy
bHkgZWl0aGVyLgoKTm90IHN1cnByaXNpbmcuLgoKPiBBcyBhIHJlc3VsdCB3ZSBjYW50IGFjdHVs
bHkgYWNjb3VudCBmb3IgdGhlbQo+IHRvZGF5IHdoZW4gc2NoZHVpbGlnbiB3b3JrbG9hZHMgdG8g
YSBob3N0LiBJbSBub3Qgc3VyZSB0aGlzIHdvdWRsCj4gY2hhZ25lIGV2ZW4gaWYgeW91IGV4cG9z
ZWQgbmV3IHVzZXIgc3BhY2UgYXBpcyB1bmxlc3Mgd2XCoCBoYWQgYSB3YXkKPiB0byBpbnNwZWN0
IGVhY2ggVkYgdG8ga25vdyBob3cgbXVjaCBsb2NrZWQgbWVtb3J5IHRoYXQgVkYgd291ZGwgbmVl
ZAo+IHRvIGxvY2s/CgpXZSBhcmUgbm90IHRhbGtpbmcgYWJvdXQgYSBuZXcgdUFQSSB3ZSBhcmUg
dGFsa2luZyBhYm91dCBjaGFuZ2luZyB0aGUKbWVhbmluZyBvZiB0aGUgZXhpc3RpbmcgdWxpbWl0
LiBZb3UgY2FuIHNlZSBpdCBpbiB5b3VyIG1lc3NhZ2UgYWJvdmUsCmF0IHRoZSBvcGVuc3RhY2sg
bGV2ZWwgeW91IHdlcmUgdGFsa2luZyBhYm91dCBnbG9iYWwgbGltaXRzIGFuZCB0aGVuCmluIHRo
ZSBsaWJ2aXJ0IGxldmVsIHlvdSBhcmUgdGFsa2luZyBhYm91dCBwZXItcWVtdSBsaW1pdHMuCgpJ
biB0aGUga2VybmVsIGJvdGggb2YgdGhlc2UgYXJlIGJlaW5nIHVzZWQgYnkgdGhlIHNhbWUgY29u
dHJvbCBhbmQgb25lCm9mIHRoZSB1c2VycyBpcyB3cm9uZy4KClRoZSBrZXJuZWwgY29uc2Vuc3Vz
IGlzIHRoYXQgdGhlIHVsaW1pdCBpcyBwZXItdXNlciBhbmQgaXMgdXNlZCBieSBhbGwKa2VybmVs
IGVudGl0aWVzIGNvbnNpc3RlbnRseQoKQ3VycmVudGx5IHZmaW8gaXMgZGlmZmVyZW50IGFuZCB1
c2VzIGl0IHBlci1wcm9jZXNzIGFuZCBlZmZlY3RpdmVseQpoYXMgaXRzIG93biBwcml2YXRlIGJ1
Y2tldC4KCldoZW4geW91IHRhbGsgYWJvdXQgVkRQQSB5b3Ugc3RhcnQgdG8gc2VlIHRoZSBwcm9i
bGVtcyBoZXJlIGJlY2F1c2UKVlBEQSB1c2UgYSBkaWZmZXJlbnQgYWNjb3VudGluZyBmcm9tIFZG
SU8uIElmIHlvdSBydW4gVkZJTyBhbmQgVkRQQQp0b2dldGhlciB0aGVuIHlvdSBzaG91bGQgbmVl
ZCAyeCB0aGUgdWxpbWl0LCBidXQgdG9kYXkgeW91IG9ubHkgbmVlZAoxeCBiZWNhdXNlIHRoZXkg
ZG9uJ3Qgc2hhcmUgYWNjb3VudGluZyBidWNrZXRzLgoKVGhpcyBhbHNvIG1lYW5zIHRoZSB1bGlt
aXQgZG9lc24ndCBhY3R1YWxseSB3b3JrIHRoZSB3YXkgaXQgaXMKc3VwcG9zZWQgdG8uCgpUaGUg
cXVlc3Rpb24gaXMgaG93IHRvIGZpeCBpdCwgaWYgd2UgZG8gZml4IGl0LCBob3cgbXVjaCBjYXJl
cyB0aGF0CnRoaW5ncyB3b3JrIGRpZmZlcmVudGx5LgoKSmFzb24KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
