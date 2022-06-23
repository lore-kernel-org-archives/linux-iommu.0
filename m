Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D123FCCA47C
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 10:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 599F1613D1;
	Thu, 23 Jun 2022 10:08:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 599F1613D1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EJtEL5AybRi4; Thu, 23 Jun 2022 10:08:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 10384613C9;
	Thu, 23 Jun 2022 10:08:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10384613C9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C28C5C0032;
	Thu, 23 Jun 2022 10:08:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04430C002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8E8584722
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:08:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C8E8584722
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ld8_H1eCG757 for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 10:08:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8803A84720
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8803A84720
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 10:08:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF97712FC;
 Thu, 23 Jun 2022 03:08:42 -0700 (PDT)
Received: from [10.57.85.4] (unknown [10.57.85.4])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291B53F534;
 Thu, 23 Jun 2022 03:08:40 -0700 (PDT)
Message-ID: <2f66f488-687c-033c-a5a2-9d54633838cd@arm.com>
Date: Thu, 23 Jun 2022 11:08:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of
 mm_dts_parse
Content-Language: en-GB
To: Yong Wu <yong.wu@mediatek.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
 <20220616054203.11365-3-yong.wu@mediatek.com>
 <e2091397-b6e2-7296-1378-dc10b24c6ef4@arm.com>
 <b2ea919315d0084adb465378e6970dbfa4f0829e.camel@mediatek.com>
 <521ed82e-f213-f635-6f5e-3e35ff8cc020@arm.com>
 <a53c4a4d9922c9a3fc774976494dea6da1bd8daa.camel@mediatek.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a53c4a4d9922c9a3fc774976494dea6da1bd8daa.camel@mediatek.com>
Cc: anan.sun@mediatek.com, chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com, yf.wang@mediatek.com,
 Guenter Roeck <groeck@chromium.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Dan Carpenter <dan.carpenter@oracle.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 mingyuan.ma@mediatek.com, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On 2022-06-23 02:54, Yong Wu wrote:
> On Thu, 2022-06-16 at 11:31 +0100, Robin Murphy wrote:
>> On 2022-06-16 11:08, Yong Wu wrote:
>>> On Thu, 2022-06-16 at 09:59 +0100, Robin Murphy wrote:
>>>> On 2022-06-16 06:42, Yong Wu wrote:
>>>>> The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if
>>>>> the
>>>>> i+1
>>>>> larb is parsed fail(return -EINVAL), we should of_node_put for
>>>>> the
>>>>> 0..i
>>>>> larbs. In the fail path, one of_node_put matches with
>>>>> of_parse_phandle in
>>>>> it.
>>>>>
>>>>> Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow
>>>>> with
>>>>> the MM TYPE")
>>>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>>>> ---
>>>>>     drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
>>>>>     1 file changed, 16 insertions(+), 5 deletions(-)
> 
> [snip..]
> 
>>>>> +err_larbnode_put:
>>>>> +	while (i--) {
>>>>> +		larbnode = of_parse_phandle(dev->of_node,
>>>>> "mediatek,larbs", i);
>>>>> +		if (larbnode &&
>>>>> of_device_is_available(larbnode)) {
>>>>> +			of_node_put(larbnode);
>>>>> +			of_node_put(larbnode);
>>>>> +		}
>>>>
>>>> This looks a bit awkward - could we not just iterate through
>>>> data->larb_imu and put dev->of_node for each valid dev?
>>>
>>> It should work. Thanks very much.
>>>
>>>>
>>>> Also, of_find_device_by_node() takes a reference on the struct
>>>> device
>>>> itself, so strictly we should be doing put_device() on those as
>>>> well
>>>> if we're bailing out.
>>>
>>> Thanks for this hint. A new reference for me. I will add it.
>>
>> In fact, thinking about it some more we may as well do the
>> of_node_put()
>> unconditionally immediately after the of_find_device_by_node() call,
> 
> of_node_put is called in component_release_of in the normal case, thus
> we shouldn't call of_node_put unconditionally. Right?

As it stands, yes. However I'm also figuring that we could just use 
component_match_add() there, and probably also switch to 
component_compare_dev as the the comparison, since we've already 
resolved the larb device, and it is the device itself that we're 
interested in here, rather than just its of_node.

I *think* this idea could end up with simpler code overall, but as 
always, feel free to ignore the suggestion if you think it wouldn't make 
enough difference to be worth the bother.

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
