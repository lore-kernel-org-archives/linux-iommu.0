Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B01B6C433EF
	for <iommu@archiver.kernel.org>; Sun, 12 Dec 2021 09:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C13A8597E;
	Sun, 12 Dec 2021 09:41:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qMZOVyfpEvNO; Sun, 12 Dec 2021 09:41:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ACF6685918;
	Sun, 12 Dec 2021 09:41:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B511C0012;
	Sun, 12 Dec 2021 09:41:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEE19C001E
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 06:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B906084F80
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 06:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AEPU7BaTdsty for <iommu@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 06:44:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60059.outbound.protection.outlook.com [40.107.6.59])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6CB0484F7C
 for <iommu@lists.linux-foundation.org>; Sun, 12 Dec 2021 06:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNuyxlEWZpftbwbbz3VAjS+eVoqPk7vS0bN2oojghWs/SkVPr1Wy/5KfjN/r/YXQFKin6V3YzXZVeX0M0vANcpVkgNcdTOH7to/bsu6Uhf0g5fOO+dPQ/sYvd/h7f0uUJ90xTJchA4cB8vgHVZKzLqMNECO48ulobOSASIJX2940xAnJS3m6Wk4bxiA8fBGRmuyjAcmgMC+tKx8CstVJ5y4FxGjw7RrN4PedqfJgacRTQIhXlfG+UfTaoVqzsvhAhIVpxM93oG6qCuHCLbLL9ESsdnaMGiBqcEEMKNW8VooHdFR+aHWIqGvFc++T0L7yVOCAybCscFQ7o4jaF2qpIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/kI292VVGwC9YHzx6achs/pLHP4Kp+eYk2JuzwHU+M=;
 b=hjFNg63ab6WBSFoWaks17uFs0qIjbZW8t7jGOAA2V4aUsLgmT2g7CdX9XDBiicszeeom988pAWnnsLdX8jlBw21R6Idyp5Q2micgF9XNIhog3giIDxVUDNN40jdnhCQraFUJ8epqg1WYtKQRaHjMhUykeIHaaofHG9a/NiEXabGkqHBzHFc5cDUAb9NCJ7KjhBYMqH9Nbhbd47TRgJYGv9SPo0S54xLvr2kweDHa4uqRIbBUs1+mDQDoa1g7bCfdY8f11wkz2QG1eSRuwYNKPG2b9n7Q9MMsSHtTwKTbMFZSZpT4CK48yW7IazBzFGKYPtux4792UvwFXY7GAiQX+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/kI292VVGwC9YHzx6achs/pLHP4Kp+eYk2JuzwHU+M=;
 b=MAhySbBjq42Lr8+2BnaIoW1xCc/4LNjf+1zm5r87Jme+6RzTbK0E7UIE5pah2hGlE+mvZ6lbuhtT2j+c9M8KY/V1Kn7r7UP5ow8WWYRhBAswJ6mU2NbH5qlsVftD4EdRN4CDSWFXqXRR4sZhaxz1BiBosgGzSCEEMPnE7xGMBhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DB6PR03MB2855.eurprd03.prod.outlook.com (2603:10a6:6:33::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Sun, 12 Dec
 2021 06:44:51 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::39ec:706d:cbfb:8a26]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::39ec:706d:cbfb:8a26%6]) with mapi id 15.20.4755.025; Sun, 12 Dec 2021
 06:44:50 +0000
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Thomas Gleixner <tglx@linutronix.de>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <3f6d4bd7-8b60-1976-73a4-f5ef7f3dbf27@nextfour.com>
Date: Sun, 12 Dec 2021 08:44:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <BN9PR11MB5276599F467AD5EAC935A79E8C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
X-ClientProxiedBy: HE1PR0901CA0052.eurprd09.prod.outlook.com
 (2603:10a6:3:45::20) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
Received: from [192.168.1.121] (91.145.109.188) by
 HE1PR0901CA0052.eurprd09.prod.outlook.com (2603:10a6:3:45::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Sun, 12 Dec 2021 06:44:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a9841ff-3283-4278-9698-08d9bd3ae56b
X-MS-TrafficTypeDiagnostic: DB6PR03MB2855:EE_
X-Microsoft-Antispam-PRVS: <DB6PR03MB2855EECF64352E555D35954D83739@DB6PR03MB2855.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pwa39zJxitZSCq9F7V7guW9o9JoRNqZqqDVFgA34AxkeI21bEos+5QFp8tWWhlNZfoUTHGYrP8RmPFqlJ9JA6RWzOtYHqqlJGNXnorXp08Nw1hCXFKlftdldIFVAdOGV2TEX+B7dF7ENcOY3DYlKhHgovA9IQLvFUTByQDIu77FAIXdRStnOL0cVAs+BmoLbXHtT0I6DC6gcpxAWE6vxqJ11VxbhP73bQ1xod6scfqd2qXCs0vZ3IzEwXAtbB+RwqNFa9rfHfIUd/xwDmN3d75/yrA3e5uYg3t9vOjuOZ1VfatnjiWqZxyPXbBsdBoqaXyCkNPeVvQZ0NH9BS0v1Nxe+Y4Bnqi3ci9uAjM6KJhdhutAbzekS1eyLPGaVjknGpyYnBMWw/TCWlqlunQhW+6lSeqpm/rycb5ZKBvyjEDUKUlx1LZ3tTwWC7UQTlZKeitLzupKVYRE7dZok0upQO7OMW+AIxcn1AMvwMMh7jv7U0xKU5hGKp/pX8jikuIw7iZ4ik/T8XFqmdFuTl7UufxvDUFaLNfxmVlD4krqfwaYq/DRJlGNoaE1fpUtWkXLeUHeDq8kaFVPKe093iiYvpUZwebDD2BfPOTi6XxwVyF52V2CNevnlrUZ7Kb2rI+zcYvRMHGyClnS6I5f96l6gIw34kIs8FuklJQZe+MVnsNWKDrXOyODTSw8qAodqjsfI6zUIaEcg0cn5rdCQU2FtJpkuxUe1e27EJUlqDZJgbRBEiVJkYRmSwhluD35XUk0acvRrpQJoLO4M0/EIkIPimA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBAPR03MB6630.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(39830400003)(376002)(346002)(396003)(31686004)(52116002)(54906003)(38100700002)(36756003)(956004)(8936002)(31696002)(2906002)(186003)(5660300002)(83380400001)(6666004)(16576012)(110136005)(316002)(66946007)(38350700002)(7416002)(86362001)(26005)(8676002)(6486002)(508600001)(66476007)(2616005)(4326008)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFBGWW9PM2thWjcwdjNMOFNwR3lNeUtVRmlLaCtrMWhyZDNBRmpWQ3U2RURo?=
 =?utf-8?B?OHBISG5leFlsK0JWYlNiczQ2ZzMxaHFUeWQveFRQdGxidUN3WnVWNUZGTHF6?=
 =?utf-8?B?NVFCYy9DNC9ZeTR5MzNnNXZUeXVMckZuSkh1NDVVejl5UjJ1WHBic1NWYlhZ?=
 =?utf-8?B?VWRFR090NnA2ejNJSE1xRjB6VUNQSnBNNHNmKzVhajN4N1JDbzArays2QXBo?=
 =?utf-8?B?YmxYT1VnWnBwcVdlbXBsNG9hMWs1T0ZkTUZHVFlnYVpvREN5aVJpRWV0N0JN?=
 =?utf-8?B?ZUsyaU0vTnI2M2kyYkRUM0dXTXBMWnZDUitTZTR5c05LUTdiR0dVMEczSTNZ?=
 =?utf-8?B?SHE5VkNodURzVVNNeHpTV3lSanJEWWlYN0pWKzNaSmVaanRTcFpHcytzR01X?=
 =?utf-8?B?WHZEQ3NmYVhUMFFnSkkyaFJ0c1l5VWdOZE5oL0N6a3JLQ2p2YWJ1alBaUXpa?=
 =?utf-8?B?aFFWaU82ZjB3ZmxUQnU1eEVYTXpMMUY2Zmd3K1Zyb0pOVGZQME9OMjJKeWh2?=
 =?utf-8?B?NEZnZ2wxU1VvQ21nZHp4dDZiTXEycDlRaHY2RCtmVG91Nk1PYnlxTk1KRW0r?=
 =?utf-8?B?Vk00YjlmTHNZYjNRUGIxei9CNzlvK3ZjdGF4bncxTkdIbTIrTUdMN3dxaVNR?=
 =?utf-8?B?SzlnOE5TQjZRVjQ5eHdWdkZZcS92ckk4QTVDa2tYOGJqVXZXdmNYblBYOFFI?=
 =?utf-8?B?Y3UrTStIWXNYUFJiQXVNN2k2UjNXUjQ4dklBbEc2WkpscThwSTZkUGtlZkUy?=
 =?utf-8?B?b0wzdzVCa3QwV1hDb090cXlUQk9USEJNcDZpeGU5MnN0V09zN3lRbmF4ckZB?=
 =?utf-8?B?cG9uaEZ4T1E4V0JxcVJXNVdNaU1sZTViSFJiUVd4U1hjMEdHTUcrakJkSnQ1?=
 =?utf-8?B?VEhkY08ram14KzlNUXdFWEtKekdCa1RoY3ZHdlBEY2NnN1pSRjZFTkoyUzBt?=
 =?utf-8?B?ZnVoNUswemhhRjc4R1gxeGhIUE1ZUDBnZndOQ2JCMWQwY1pNZXM5K3M4Rzho?=
 =?utf-8?B?QzZWY1A4QkthcVVwSG5ieS9VUFhMZE95TlIzNk9PZjQxK1hJUktpRU5Fdk9R?=
 =?utf-8?B?L043QU5qSW5tdGhkTUdQVUxqOVVsTk1Qc1AwRjZoeXZFWHRBamtLSmpHczEy?=
 =?utf-8?B?c2F1dlZwL3E4WHp4ZjZvN2VjLy9MdWVYcmdueE9HQVNaOVdYeUFEQ2NscU1t?=
 =?utf-8?B?eElVK2RIZm1PU1pIU09IZ3hLdTlsdTIvNjhNRlhOQlVUaENVbEo5YndhcG1z?=
 =?utf-8?B?bWIvQnRHcVkrQzMvdC9DdWVRNGQ5enhsYWh6UVJ1cERUMjNqMndHVVdBVk03?=
 =?utf-8?B?MXRwUlZ3b2RhRFJCeDRGNG1TQ3h0Z05yY1lUZ3h2N3owNURwbHZTeklueFdn?=
 =?utf-8?B?c3JTTmFoOGJMR0ovZndYeHVhV25RMzZZUE4xUUdyeHg3R0RBRk5mcXZmeHdt?=
 =?utf-8?B?UGVvNE9uSXlRVU9pTmh4aXpFS3U4SnB4aXhPQmhiOGxpSm4yYWNVQk9TVXlw?=
 =?utf-8?B?SEdEWGsrUm80elk4YmZYV0t2RllvUWFMdEJ5M2JoNFphRHRvM1ZudTNNdlVR?=
 =?utf-8?B?eFlSOVFmekd4TUVyMlljN0tMWXpJTUQ2NjBHSTYwQ0FFUCtvQzh3K2M4bnRw?=
 =?utf-8?B?c2FrYVdzMWRHL1NZaW1BelFCYlZnWTIzMEJWNUVTL1lqMGlFcTVoaFRRVmtG?=
 =?utf-8?B?SHovRVdzai9KWHh6ZkN6N0ZRTXh5T2hrSVZKcVlzcHUrdTcxTGtmRU9BdGlR?=
 =?utf-8?B?MVltKzh3elJ1cmdkNWF3aXptTGZFb3l6aWNkd0NKN2xSRzlGZGFzT21FTVg2?=
 =?utf-8?B?T1lTWlBzQVJ3eno2bVdDaWFSUDRFR0IreThGYXFnZmNnS3hlZzlqV0FBVEQz?=
 =?utf-8?B?WWVraCsvNGp6Q3VoVmZmNDA2eUJPbG0vUFZTbnUrYmVUVVVPcTY2OFc2b1Vk?=
 =?utf-8?B?eFdmL2swdDFYMHhMVHcrNGNMaGRqUjZaYXFxMWdTRWV2dU52c1NkMUZNWTFI?=
 =?utf-8?B?dWFvMy9wL2ZhbmVVbHdXeGJZR0JQdE1vY1V5b09mQnFPcEtrYjRNMDFTZExH?=
 =?utf-8?B?Q3AvMmpTMnBJN0E3dmlNTXlRNEh2dXNOYkVpNmRFeFhtMkI3UDZmSEhNWmhO?=
 =?utf-8?B?WElZWUliUG9udXE5Q2lZd0VBdDZJM0Ywckk0M0ZZdy9BbnJLZmQ5WEZiUUxq?=
 =?utf-8?B?YUx5OVdwcTFsMlQvcUszbXlLYkUzVkxzQTAxczRmRnhVQlNrWFB5d0tNeGRj?=
 =?utf-8?B?dWdrSk90U2VvV1c2cXV5Z1BkQUJnPT0=?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9841ff-3283-4278-9698-08d9bd3ae56b
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 06:44:50.6373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M0bGH/jO+ZCoS+pZk1NmA+/GX8GOPnc+9gNhOydkEVkXpJts8x+qkpHL748R4gSg22+uoRHl7X3Rq05clhcBjYa6Etzd39X7lVRgUmB/OeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR03MB2855
X-Mailman-Approved-At: Sun, 12 Dec 2021 09:41:03 +0000
Cc: Allen Hubbe <allenbh@gmail.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Marc Zygnier <maz@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Bjorn Helgaas <helgaas@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 Logan Gunthorpe <logang@deltatee.com>, "Dey, Megha" <megha.dey@intel.com>
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

CgpPbiAxMC4xMi4yMDIxIDkuMzYsIFRpYW4sIEtldmluIHdyb3RlOgo+PiBGcm9tOiBKYXNvbiBH
dW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPgo+PiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDEwLCAy
MDIxIDQ6NTkgQU0KPj4KPj4gT24gVGh1LCBEZWMgMDksIDIwMjEgYXQgMDk6MzI6NDJQTSArMDEw
MCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOgo+Pj4gT24gVGh1LCBEZWMgMDkgMjAyMSBhdCAxMjoy
MSwgSmFzb24gR3VudGhvcnBlIHdyb3RlOgo+Pj4+IE9uIFRodSwgRGVjIDA5LCAyMDIxIGF0IDA5
OjM3OjA2QU0gKzAxMDAsIFRob21hcyBHbGVpeG5lciB3cm90ZToKPj4+PiBJZiB3ZSBrZWVwIHRo
ZSBNU0kgZW11bGF0aW9uIGluIHRoZSBoeXBlcnZpc29yIHRoZW4gTVNJICE9IElNUy4gIFRoZQo+
Pj4+IE1TSSBjb2RlIG5lZWRzIHRvIHdyaXRlIGEgYWRkci9kYXRhIHBhaXIgY29tcGF0aWJsZSB3
aXRoIHRoZSBlbXVsYXRpb24KPj4+PiBhbmQgdGhlIElNUyBjb2RlIG5lZWRzIHRvIHdyaXRlIGFu
IGFkZHIvZGF0YSBwYWlyIGZyb20gdGhlCj4+Pj4gaHlwZXJjYWxsLiBTZWVtcyBsaWtlIHRoaXMg
c2NlbmFyaW8gaXMgYmVzdCBhdm9pZGVkIQo+Pj4+Cj4+Pj4gIEZyb20gdGhpcyBwZXJzcGVjdGl2
ZSBJIGhhdmVuJ3QgY29ubmVjdGVkIGhvdyB2aXJ0dWFsIGludGVycnVwdAo+Pj4+IHJlbWFwcGlu
ZyBoZWxwcyBpbiB0aGUgZ3Vlc3Q/IElzIHRoaXMgYSB3YXkgdG8gcHJvdmlkZSB0aGUgaHlwZXJj
YWxsCj4+Pj4gSSdtIGltYWdpbmluZyBhYm92ZT8KPj4+IFRoYXQgd2FzIG15IHRob3VnaHQgdG8g
YXZvaWQgaGF2aW5nIGRpZmZlcmVudCBtZWNoYW5pc21zLgo+Pj4KPj4+IFRoZSBhZGRyZXNzL2Rh
dGEgcGFpciBpcyBjb21wdXRlZCBpbiB0d28gcGxhY2VzOgo+Pj4KPj4+ICAgIDEpIEFjdGl2YXRp
b24gb2YgYW4gaW50ZXJydXB0Cj4+PiAgICAyKSBBZmZpbml0eSBzZXR0aW5nIG9uIGFuIGludGVy
cnVwdAo+Pj4KPj4+IEJvdGggY29uZmlndXJlIHRoZSBJUlRFIHdoZW4gaW50ZXJydXB0IHJlbWFw
cGluZyBpcyBpbiBwbGFjZS4KPj4+Cj4+PiBJbiBib3RoIGNhc2VzIGEgdmVjdG9yIGlzIGFsbG9j
YXRlZCBpbiB0aGUgdmVjdG9yIGRvbWFpbiBhbmQgYmFzZWQgb24KPj4+IHRoZSByZXN1bHRpbmcg
dGFyZ2V0IEFQSUMgLyB2ZWN0b3IgbnVtYmVyIHBhaXIgdGhlIElSVEUgaXMKPj4+IChyZSljb25m
aWd1cmVkLgo+Pj4KPj4+IFNvIHB1dHRpbmcgdGhlIGh5cGVyY2FsbCBpbnRvIHRoZSB2SVJURSB1
cGRhdGUgaXMgdGhlIG9idmlvdXMKPj4+IHBsYWNlLiBCb3RoIGFjdGl2YXRpb24gYW5kIGFmZmlu
aXR5IHNldHRpbmcgY2FuIGZhaWwgYW5kIHByb3BhZ2F0ZSBhbgo+Pj4gZXJyb3IgY29kZSBkb3du
IHRvIHRoZSBvcmlnaW5hdGluZyBjYWxsZXIuCj4+Pgo+Pj4gSG1tPwo+PiBPa2F5LCBJIHRoaW5r
IEkgZ2V0IGl0LiBXb3VsZCBiZSBuaWNlIHRvIGhhdmUgc29tZW9uZSBmcm9tIGludGVsCj4+IGZh
bWlsaWFyIHdpdGggdGhlIHZJT01NVSBwcm90b2NvbHMgYW5kIHFlbXUgY29kZSByZW1hcmsgd2hh
dCB0aGUKPj4gaHlwZXJ2aXNvciBzaWRlIGNhbiBsb29rIGxpa2UuCj4+Cj4+IFRoZXJlIGlzIGEg
Yml0IG1vcmUgd29yayBoZXJlLCB3ZSdkIGhhdmUgdG8gY2hhbmdlIFZGSU8gdG8gc29tZWhvdwo+
PiBlbnRpcmVseSBkaXNjb25uZWN0IHRoZSBrZXJuZWwgSVJRIGxvZ2ljIGZyb20gdGhlIE1TSSB0
YWJsZSBhbmQKPj4gZGlyZWN0bHkgcGFzcyBjb250cm9sIG9mIGl0IHRvIHRoZSBndWVzdCBhZnRl
ciB0aGUgaHlwZXJ2aXNvciBJT01NVSBJUgo+PiBzZWN1cmVzIGl0LiBpZSBkaXJlY3RseSBtbWFw
IHRoZSBtc2kteCB0YWJsZSBpbnRvIHRoZSBndWVzdAo+Pgo+IEl0J3Mgc3VwcG9ydGVkIGFscmVh
ZHk6Cj4KPiAvKgo+ICAgKiBUaGUgTVNJWCBtYXBwYWJsZSBjYXBhYmlsaXR5IGluZm9ybXMgdGhh
dCBNU0lYIGRhdGEgb2YgYSBCQVIgY2FuIGJlIG1tYXBwZWQKPiAgICogd2hpY2ggYWxsb3dzIGRp
cmVjdCBhY2Nlc3MgdG8gbm9uLU1TSVggcmVnaXN0ZXJzIHdoaWNoIGhhcHBlbmVkIHRvIGJlIHdp
dGhpbgo+ICAgKiB0aGUgc2FtZSBzeXN0ZW0gcGFnZS4KPiAgICoKPiAgICogRXZlbiB0aG91Z2gg
dGhlIHVzZXJzcGFjZSBnZXRzIGRpcmVjdCBhY2Nlc3MgdG8gdGhlIE1TSVggZGF0YSwgdGhlIGV4
aXN0aW5nCj4gICAqIFZGSU9fREVWSUNFX1NFVF9JUlFTIGludGVyZmFjZSBtdXN0IHN0aWxsIGJl
IHVzZWQgZm9yIE1TSVggY29uZmlndXJhdGlvbi4KPiAgICovCj4gI2RlZmluZSBWRklPX1JFR0lP
Tl9JTkZPX0NBUF9NU0lYX01BUFBBQkxFICAgICAgMwo+Cj4gSUlSQyB0aGlzIHdhcyBpbnRyb2R1
Y2VkIGZvciBQUEMgd2hlbiBhIGRldmljZSBoYXMgTVNJLVggaW4gdGhlIHNhbWUgQkFSIGFzCj4g
b3RoZXIgTU1JTyByZWdpc3RlcnMuIFRyYXBwaW5nIE1TSS1YIGxlYWRzIHRvIHBlcmZvcm1hbmNl
IGRvd25ncmFkZSBvbgo+IGFjY2Vzc2VzIHRvIGFkamFjZW50IHJlZ2lzdGVycy4gTVNJLVggY2Fu
IGJlIG1hcHBlZCBieSB1c2Vyc3BhY2UgYmVjYXVzZQo+IFBQQyBhbHJlYWR5IHVzZXMgYSBoeXBl
cmNhbGwgbWVjaGFuaXNtIGZvciBpbnRlcnJ1cHQuIFRob3VnaCB1bmNsZWFyIGFib3V0Cj4gdGhl
IGRldGFpbCBpdCBzb3VuZHMgYSBzaW1pbGFyIHVzYWdlIGFzIHByb3Bvc2VkIGhlcmUuCj4KPiBU
aGFua3MKPiBLZXZpbgoKSSBzZWXCoCBWRklPX1JFR0lPTl9JTkZPX0NBUF9NU0lYX01BUFBBQkxF
IGlzIGFsd2F5cyBzZXQgc28gaWYgbXNpeCB0YWJsZSAKaXMgaW4gaXRzIG93biBiYXIsIHFlbXUg
bmV2ZXIgdHJhcHMvZW11bGF0ZXMgdGhlIGFjY2Vzcy4gT24gdGhlIG90aGVyIApoYW5kLCBxZW11
IGlzIHNhaWQgdG8gZGVwZW5kIG9uIGVtdWxhdGluZyBtYXNraW5nLiBTbyBob3cgaXMgdGhpcyAK
c3VwcG9zZWQgdG8gd29yaywgaW4gY2FzZSB0aGUgdGFibGUgaXMgbm90IGluIHRoZSBjb25maWcg
YmFyPwoKVGhhbmtzLApNaWthCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2lvbW11
