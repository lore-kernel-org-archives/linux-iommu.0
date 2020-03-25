Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D97FC54FD3
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 16:49:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BF2E2073E
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 16:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QMPErqiP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BF2E2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 01C8F85D7D;
	Wed, 25 Mar 2020 16:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7N3j46BfIvCy; Wed, 25 Mar 2020 16:49:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 428E68598A;
	Wed, 25 Mar 2020 16:49:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2964AC1D74;
	Wed, 25 Mar 2020 16:49:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 288F8C0177
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 16:49:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1607A85A92
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 16:49:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H8BRIdlA9Pd5 for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 16:49:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 253E48598A
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 16:49:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMSM4ElQ507kS1+TrQvUSNIvvOuLQvwkffU5OmWuaL/gELs1DwC/e3tqkva3kiDsuh6K6DIjmqgCz86Ax0K0UX2zHtJWCrdgf4UjwfyFZBwd0GWaa7BzYyM98Ck6h1wivx8lGe8Z8gAccfUKrSvbJhqRh+CMHiSAnCQ/0IAJRl8Rb3sToraYOmZqRQ7g7Tl5/fFpuDSC+GXVaF1qFPrYnq8jF+JFgeR6+DBu9I5p5yaaoVYGRt0f9weV+hx4BGf2l3O5JDree5dEBDMzn45o+/+yhaMQsof2a8QjxzuuHqNGuotPJYOwmWTNnmWh/qVlOyLeOpkphYuy+mWNIc3boQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrDObxhj/nExL7H9r8WDtfxzJ7/haD3omc8Vb/3ajdo=;
 b=Eu64c5u3tuJJB9eXUMelj1UwyX6P+a2dnl+y7BAgk4peXtzUK85878aPlh9wMygFhvUlg05hSEupb5c3bE7lSnzjy9Z3QarhfqrjgZpSVeOpI72S6YiJBm+HdzajP93hYFbZvnEVjWoVT4AaxKhukJenhlpWrrHY8NFm5WehwKG3515Sk0IZJvU/GO5apElootTiOMcG0Zo+xS6TzHrUSNq2IttHSpLziDCtxVgolTEnKecyl8PiYh8rQZ61C8nileJTaA2tM+hcaBhxObz8Gi7LsnvnnoSmMh0EAIImWFhnVhQco1fgXffKsGca3OE4854b5MGgIgUIp8w+DwGrUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrDObxhj/nExL7H9r8WDtfxzJ7/haD3omc8Vb/3ajdo=;
 b=QMPErqiPouATkQUIv7QeFwt8Zyc0Ii2Rg0WoKvM8sYl70exaR+LHx1mQTCuyo/AcI42hQdG8nW1k38n3b14XO5YvToixR9zTrVFwWx8kKb3Wa4bZlhHimPWsMqtHK4ffZNZJAgDSIo9JpAF4iOO69+j3sEeSdUD+EKIobu2xeAs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (20.179.2.147) by
 AM6PR04MB5080.eurprd04.prod.outlook.com (20.177.32.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.18; Wed, 25 Mar 2020 16:48:58 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::dd71:5f33:1b21:cd9e%5]) with mapi id 15.20.2835.023; Wed, 25 Mar 2020
 16:48:58 +0000
Subject: Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
Date: Wed, 25 Mar 2020 18:48:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200325125109.GA5430@red-moon.cambridge.arm.com>
Content-Language: en-US
X-ClientProxiedBy: PR3P189CA0017.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:52::22) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (86.121.54.4) by
 PR3P189CA0017.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.19 via Frontend Transport; Wed, 25 Mar 2020 16:48:57 +0000
X-Originating-IP: [86.121.54.4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19d9522b-fc92-45dd-3b5b-08d7d0dc69be
X-MS-TrafficTypeDiagnostic: AM6PR04MB5080:|AM6PR04MB5080:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB508055372D58BBF8940FD443ECCE0@AM6PR04MB5080.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0353563E2B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(966005)(498600001)(81156014)(81166006)(6486002)(8936002)(8676002)(53546011)(36756003)(2906002)(52116002)(6916009)(44832011)(16526019)(31696002)(956004)(2616005)(26005)(31686004)(66476007)(4326008)(66946007)(16576012)(5660300002)(66556008)(7416002)(86362001)(186003)(142923001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR04MB5080;
 H:AM6PR04MB5925.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p63m+6B6e3x8jAo+3lZXr8jB8Wdr1LC8W/iFSqhfL1echA+/c6yljGg5Bkug6QdPl/TS9Fu4UFcaSczjXPVJAjsR0po8u625cZp7O98ycQaZOyn+31UljgXFd8+NUvIOweHZf9S6qT/mVOMH8FnJ2H7M0c+0fO6egN0i3lwJxGH6iapn1d1ltURuGA7JBI7Hh4NOiBQK8P0zKNjf39ZVQuRaiPNL+sc0rhatD6zdzc0o64BLitt0LZ4/a/3g8rzu6CR9/p6JCM9HLERKm78asNipq7rCX02s1cHWu51+PtZ6sUM6URvIpjKcNVhboFgX1NvxccwmAJIz9IepgijjE7s2cKkrihLzd6OrpirJQkMWDTBIz2QJwf1ne5plAW+LQ5osYyBfWn8HdJbHhEHyQACicuM3/94hTePms5/ic1BxjDo8/5tT6W2EbQOTUDO5od5gQgTAeytL6aWolyc06lo9Wi0s+WeDzwArVfS7U4OO/qHJBgrfFEcwd1hdv1+fs2P22LdgotalfNX17ZMmg1XaCHDM+oVzG3rZu1IhiKRCS2WT3lWnSbYYvTOhtHXs
X-MS-Exchange-AntiSpam-MessageData: QWLQJADBFWzVEb2lHpXi/dFbTcDHv426ysSiW3WjXzTvNSF4HazpXa35brb89zrJIQX2AqY7os23DH4ko3iqMF2z2q3c41B8mAQrFij/cwMEhQvmTz1X4pp619whWL7WYxlkJHy3YQXRcZameXoFFw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d9522b-fc92-45dd-3b5b-08d7d0dc69be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 16:48:58.3900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfLjupmheU4znlVLeYv/i5SnnaPRyK4lkZGqMkLTm+L3O1swOthNszXP2Z/qbx2zmb+7kr9pzZEJEPEr/bUk+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5080
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

Hi Lorenzo,

On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
> On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wrote:
>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>
>> The devices on this bus are not discovered by way of device tree
>> but by queries to the firmware. It makes little sense to trick the
>> generic of layer into thinking that these devices are of related so
>> that we can get our dma configuration. Instead of doing that, add
>> our custom dma configuration implementation.
>>
>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>> ---
>>  drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> index 36eb25f82c8e..eafaa0e0b906 100644
>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
>> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
>>  static int fsl_mc_dma_configure(struct device *dev)
>>  {
>>  	struct device *dma_dev = dev;
>> +	struct iommu_fwspec *fwspec;
>> +	const struct iommu_ops *iommu_ops;
>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
>> +	int ret;
>> +	u32 icid;
>>  
>>  	while (dev_is_fsl_mc(dma_dev))
>>  		dma_dev = dma_dev->parent;
>>  
>> -	return of_dma_configure(dev, dma_dev->of_node, 0);
>> +	fwspec = dev_iommu_fwspec_get(dma_dev);
>> +	if (!fwspec)
>> +		return -ENODEV;
>> +	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
>> +	if (!iommu_ops)
>> +		return -ENODEV;
>> +
>> +	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
>> +	if (ret)
>> +		return ret;
>> +
>> +	icid = mc_dev->icid;
>> +	ret = iommu_fwspec_add_ids(dev, &icid, 1);
> 
> I see. So with this patch we would use the MC named component only to
> retrieve the iommu_ops

Right. I'd also add that the implementation tries to follow the existing
standard .dma_configure implementations, e.g. of_dma_configure +
of_iommu_configure. I'd also note that similarly to the ACPI case, this
MC FW device is probed as a platform device in the DT scenario, binding
here [1].
A similar approach is used for the retrieval of the msi irq domain, see
following patch.

> - the streamid are injected directly here bypassing OF/IORT bindings translations altogether. 

Actually I've submitted a v2 [2] that calls into .of_xlate() to allow
the smmu driver to do some processing on the raw streamid coming from
the firmware. I have not yet tested this with ACPI but expect it to
work, however, it's debatable how valid is this approach in the context
of ACPI.

> Am I reading this code correctly ?

Yes. Thanks for taking the time.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
[2] https://www.spinics.net/lists/arm-kernel/msg794757.html

---
Best Regards, Laurentiu

> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!device_iommu_mapped(dev)) {
>> +		ret = iommu_probe_device(dev);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	arch_setup_dma_ops(dev, 0, *dma_dev->dma_mask + 1, iommu_ops, true);
>> +
>> +	return 0;
>>  }
>>  
>>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>> -- 
>> 2.17.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
