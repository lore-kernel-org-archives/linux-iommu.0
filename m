Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87963C3815B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 15:44:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8AA208FE
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 15:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lUSUCKU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8AA208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1FAD687860;
	Wed, 15 Apr 2020 15:44:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cz1g9WN39AcB; Wed, 15 Apr 2020 15:44:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7828F87820;
	Wed, 15 Apr 2020 15:44:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57308C089E;
	Wed, 15 Apr 2020 15:44:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00BEFC0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 15:44:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EFB4B87824
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 15:44:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WV8OZU2X+dPH for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 15:44:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60072.outbound.protection.outlook.com [40.107.6.72])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A6F3B87774
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 15:44:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DobL3y49WFZmiN+Kk7uJuLc98yJODv7kHvgxrREdfystqsd+edzbm6oxGBqpynaGRXuE1T4aePOVQz+SObDVYq0AMbRkoViAsaL8ozMzFs9RtxqlCw+7RGsuab13JxKjDyZU/39JQclpzUudyruPBvr+S0YP2iF8rhOKUVgmKjf67LiN67GoPTmPH/G+CuQWMmjs3GRmcgVTDS5G3+H6m4qzVS+FKiSIz7YWKUo6WpWVSabn1Z9q05BmFEa9YRhoF6iFBTyPrXX1w0FERomN0bD1104qitjJopoxzxgMoAxKZ9B4QHjUnSEoEY2AuVj5vL7jvilY+H8fMSnYf9xaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG7u7oInyd7r5/WGiMmjcVsWtHWJxpPcpFGoaVCr2S0=;
 b=AiuKV/nd5jR4OZCCMjnZLEOx5PZrcx0S17HEFioKbhnTqHM310G0SfbeoKaPIRBDE5bmXUGv3GXDfYx90I0SimaHPFOH8EHBP5VzOKcduIf5maQYvZEXJikKbiAcJtvmcp302rcNnglwqcNormCUp5lZnA/AJVSiQA1eiGsKrUJxnVD/QHDSXenwYVIXCeBKSBNrOLlj6OxvnFvey3rBj39nz68kwESDYAXUBLGMCNzo0/lfUQU8HwzIT0m6Qy/GBmRjYaw0CMhKvwtmGqjn7hWAh519LfR2FAKR7C4yXtsYetdZovro4q63k/4tn081wSN+JFJj7wy/YqOQ8ZubIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NG7u7oInyd7r5/WGiMmjcVsWtHWJxpPcpFGoaVCr2S0=;
 b=lUSUCKU9fkmQk6XUcP5zmuZaAFI7iI7MfHIsEv6WF2aym4Law05O17rgpXzOYRxUo9Neu5ufeiG3oxmr0c1af5DqNg8vgVgcSn9MZno1KPxNZE7asVWlFMHLgAyCLXvtA0/VPDm+eWPePp20+8+zzYD2GXzk6V5pSkQOnULUbG0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM6PR04MB6181.eurprd04.prod.outlook.com (2603:10a6:20b:b6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 15 Apr
 2020 15:44:39 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e%5]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 15:44:39 +0000
Subject: Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
 <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
 <20200414143211.GA14905@red-moon.cambridge.arm.com>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <d37ca4e3-58cb-9d6f-3a98-5e4a21ca948b@nxp.com>
Date: Wed, 15 Apr 2020 18:44:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200414143211.GA14905@red-moon.cambridge.arm.com>
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0007.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::17) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (86.123.59.151) by
 AM4PR0902CA0007.eurprd09.prod.outlook.com (2603:10a6:200:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Wed, 15 Apr 2020 15:44:38 +0000
X-Originating-IP: [86.123.59.151]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ecc254c3-d157-4b2f-27c9-08d7e153e877
X-MS-TrafficTypeDiagnostic: AM6PR04MB6181:|AM6PR04MB6181:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB61814DCC7253C4E31F6FD801ECDB0@AM6PR04MB6181.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5925.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(6486002)(6916009)(16526019)(186003)(5660300002)(316002)(31686004)(478600001)(52116002)(26005)(16576012)(7416002)(4326008)(8936002)(36756003)(53546011)(66946007)(81156014)(8676002)(66556008)(66476007)(2616005)(86362001)(956004)(44832011)(31696002)(2906002)(142923001);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SQAklGVwvYvyfbw/5G3gOXNUaEDK/XnXhk2NGHE1IMhfzrcaT8M4pyQxTwLMeZbNU3hF/Mikd6pi9VmP2f3GB9kPvt4iYNjwRnxPKldmnUn4v9iyjPkCHl3d3QAE17BLLdx852HCT5hYfIpRMtC9boqEtKKhq/b8vU/v83Tzrg7H6kGgTVVq5CdQwYrhLIyDF0Fx+ccjL5gs26qeFJ1fHjto2bJPT2lUEtRb9grXWe3xfYSXnF3/34aLHyCg5uUjdZEgbdLjpPQFhompq2cEAjfgdVI1xPjCcgyOd/7SOn31PY8tPXmAr0W8YvUU4q2ZJ2DGCXHS4V12NtEnJbNdGxyZznQbqEJBW9DA129knPI3r3eR+9BQHZ1Q5ROLOSaM2PqWqlZXap8oA6VWrhT64t7ITz8NX08SiSCrCfogm23VGArUVrmGBYMrTw23xsP4gc2M1qVF/nMHJkIQ1BBUbwMkc8ZyT/7wgL5O45ZmqFxWkaVt2z6YOGVvRLdkB88j
X-MS-Exchange-AntiSpam-MessageData: EHWpPtq8Q7XwM4DcNqcP/ZPtx4Nz5/llcntdxSNU4qUyn7uNFB6dEXx7MVZQRtJvj8vN698lxiQeTepvqrnYVeEtI5QPBTtEYY4pm/kT/j77ysPzPzgrAJhxUjOcj1+tknoJ9CM3WeSzXgKswDH2FA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecc254c3-d157-4b2f-27c9-08d7e153e877
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 15:44:39.7481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGlPy53PCxU6iafh52UAz2FflAVHkjtIa2VU//dVA9yPxltFFHI3nRgIR29gTKY38wV0ccJLnBE04BYNQ4qUMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6181
Cc: jason@lakedaemon.net, calvin.johnson@nxp.com, ard.biesheuvel@linaro.org,
 maz@kernel.org, pankaj.bansal@nxp.com, diana.craciun@oss.nxp.com,
 jon@solid-run.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 cristian.sovaiala@nxp.com, tglx@linutronix.de, makarand.pawagi@nxp.com,
 ioana.ciornei@nxp.com, Stuart.Yoder@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, V.Sethi@nxp.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



On 4/14/2020 5:32 PM, Lorenzo Pieralisi wrote:
> On Wed, Mar 25, 2020 at 06:48:55PM +0200, Laurentiu Tudor wrote:
>> Hi Lorenzo,
>>
>> On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
>>> On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wrote:
>>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>>
>>>> The devices on this bus are not discovered by way of device tree
>>>> but by queries to the firmware. It makes little sense to trick the
>>>> generic of layer into thinking that these devices are of related so
>>>> that we can get our dma configuration. Instead of doing that, add
>>>> our custom dma configuration implementation.
>>>>
>>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>>> ---
>>>>  drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
>>>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>> index 36eb25f82c8e..eafaa0e0b906 100644
>>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>>>> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>>>  static int fsl_mc_dma_configure(struct device *dev)
>>>>  {
>>>>  	struct device *dma_dev = dev;
>>>> +	struct iommu_fwspec *fwspec;
>>>> +	const struct iommu_ops *iommu_ops;
>>>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>>>> +	int ret;
>>>> +	u32 icid;
>>>>  
>>>>  	while (dev_is_fsl_mc(dma_dev))
>>>>  		dma_dev = dma_dev->parent;
>>>>  
>>>> -	return of_dma_configure(dev, dma_dev->of_node, 0);
>>>> +	fwspec = dev_iommu_fwspec_get(dma_dev);
>>>> +	if (!fwspec)
>>>> +		return -ENODEV;
>>>> +	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
>>>> +	if (!iommu_ops)
>>>> +		return -ENODEV;
>>>> +
>>>> +	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	icid = mc_dev->icid;
>>>> +	ret = iommu_fwspec_add_ids(dev, &icid, 1);
>>>
>>> I see. So with this patch we would use the MC named component only to
>>> retrieve the iommu_ops
>>
>> Right. I'd also add that the implementation tries to follow the existing
>> standard .dma_configure implementations, e.g. of_dma_configure +
>> of_iommu_configure. I'd also note that similarly to the ACPI case, this
>> MC FW device is probed as a platform device in the DT scenario, binding
>> here [1].
>> A similar approach is used for the retrieval of the msi irq domain, see
>> following patch.
>>
>>> - the streamid are injected directly here bypassing OF/IORT bindings translations altogether. 
>>
>> Actually I've submitted a v2 [2] that calls into .of_xlate() to allow
>> the smmu driver to do some processing on the raw streamid coming from
>> the firmware. I have not yet tested this with ACPI but expect it to
>> work, however, it's debatable how valid is this approach in the context
>> of ACPI.
> 
> Actually, what I think you need is of_map_rid() (and an IORT
> equivalent, that I am going to write - generalizing iort_msi_map_rid()).
> 
> Would that be enough to enable IORT "normal" mappings in the MC bus
> named components ?
> 

At a first glance, looks like this could very well fix the ACPI
scenario, but I have some unclarities on the approach:
 * are we going to rely in DT and ACPI generic layers even if these
devices are not published / enumerated through DT or ACPI tables?
 * the firmware manages and provides discrete streamids for the devices
it exposes so there's no translation involved. There's no
   requestor_id / input_id involved but it seems that we would still do
some kind of translation relying for this on the DT/ACPI functions.
 * MC firmware has its own stream_id (e.g. on some chips 0x4000, others
0xf00, so outside the range of stream_ids used for the mc devices)
   while for the devices on this bus, MC allocates stream_ids from a
range (e.g. 0x17 - 0x3f). Is it possible to describe this in the IORT table?
 * Regarding the of_map_rid() use you mentioned, I was planning to
decouple the mc bus from the DT layer by dropping the use of
of_map_rid(), see patch 4.
I briefly glanced over the iort code and spotted this static function:
iort_iommu_xlate(). Wouldn't it also help, of course after making it public?

---
Thanks & Best Regards, Laurentiu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
