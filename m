Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03379C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9304D40335;
	Tue, 14 Dec 2021 15:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 735R4HhtlEta; Tue, 14 Dec 2021 15:02:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 54903402B5;
	Tue, 14 Dec 2021 15:02:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2D965C001E;
	Tue, 14 Dec 2021 15:02:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F6E7C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5F8CF402B5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DPRbaWZOGEG6 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 15:02:20 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 629DA402B8
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 15:02:20 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id o4so27485553oia.10
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 07:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:to:cc:references:from:subject:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8r4jIs3l3D4eNr5ioKcyFBrXfLWslgp3sGsOXmwr0gM=;
 b=BiTbLU9uWpVoRh8INajbUvV0ayCz/0B2e/qrZPY6O2weJdQ1vBJInlP1cZllu1nygh
 UvSz3YHtMbD3b6Z3MawB3iM+dbjOlCkWqmbvwW0X2yPGk+spOwRp/tRe12UgQMJUQlKO
 vcQBRg3V28ijAEy81JLPHBmD1o6HOxeyt3dhBPmh/rMh7WUXbJKmk2hJjMmbk0O6vaCv
 QEBWKwfQPUq3cLH2ygRmYjO03hdk+suKqgrsHNRuh90Zx6Okr2o/ApIHs9RS549Exbll
 Cf7q8/0WNmOuef98QLeB5hecWbDAPz7So+1pqP8WpeLJ0g4RM0s/4L/zZaLk5jeBNJgW
 lueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8r4jIs3l3D4eNr5ioKcyFBrXfLWslgp3sGsOXmwr0gM=;
 b=bDml+eQJbF43D8Z8ovFiGwIfkgSQsZZD49re6YSQWl0mUFKNMfWBa5/RZzmQtxF1OH
 sCF+y966LZnTb64JWSSi3pb/TLUxMgjecK4IxnpVDqAnCYgTzVUoJ47czk7yVSaYEcKJ
 xuutqARxS15vISRPAkdpxpTIK2r8SG9UGVkEQFHYddPjRxNRkbhp+9hG03EHlXXRpz6d
 N7MYjoYA9vBMLfUEvuXFxseIx7qG3tf8+MHzzGyJNN+JcKJYeRq7l8NkSdnycoVUwuVV
 OMbVmEohCRvaRFrslrFCV+q+agnnGN2MFXTyuz8jjrpuoirifp3+Jvew+wQnYNUkjJyI
 6TyQ==
X-Gm-Message-State: AOAM533bdxBJ3GyfsF4Fg6++cDJyxv5/my/Upxwl+j/uJDHaTi+GscVJ
 CW5LZFx5OrG4KqVo+Uhoflw=
X-Google-Smtp-Source: ABdhPJwmIlYuaRbk3q2YpKEasBz7asrj7ak2wqmHgfkJRg3b4wwVc87W3XBqswlbK03+IWRo7+qnYQ==
X-Received: by 2002:a05:6808:2cc:: with SMTP id
 a12mr4824714oid.126.1639494139306; 
 Tue, 14 Dec 2021 07:02:19 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id bb8sm25178oib.9.2021.12.14.07.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Dec 2021 07:02:18 -0800 (PST)
To: Yong Wu <yong.wu@mediatek.com>
References: <20211210205704.1664928-1-linux@roeck-us.net>
 <ebf58066a131f92c68e83a1ef56b88f435fa0d08.camel@mediatek.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [SPAM][PATCH] iommu/mediatek: Validate number of phandles
 associated with "mediatek,larbs"
Message-ID: <ade9292c-38ee-14b3-a8c4-49cfc7a350e6@roeck-us.net>
Date: Tue, 14 Dec 2021 07:02:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ebf58066a131f92c68e83a1ef56b88f435fa0d08.camel@mediatek.com>
Content-Language: en-US
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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

On 12/13/21 11:31 PM, Yong Wu wrote:
> On Fri, 2021-12-10 at 12:57 -0800, Guenter Roeck wrote:
>> Since commit baf94e6ebff9 ("iommu/mediatek: Add device link for smi-
>> common
>> and m4u"), the driver assumes that at least one phandle associated
>> with
>> "mediatek,larbs" exists. If that is not the case, for example if
>> reason
>> "mediatek,larbs" is provided as boolean property, the code will use
>> an
>> uninitialized pointer and may crash. To fix the problem, ensure that
>> the
>> number of phandles associated with "mediatek,larbs" is at least 1 and
>> bail out immediately if that is not the case.
> 
>  From the dt-binding, "mediatek,larbs" always is a phandle-array. I
> assumed the dts should conform to the dt-binding before. Then the
> problem is that if we should cover the case that someone abuses/attacks
> the dts. Could you help add more comment in the commit message?
> something like: this is for avoid abuse the dt-binding.
> 

This doesn't have to be an abuse or attack. It can simply be an error
by the person who wrote the devicetree file. Sure, bugs or lack of
error checking can often be used for attacks, but that doesn't mean
that all bad data is an exploit or attack.

>>
>> Cc: Yong Wu <yong.wu@mediatek.com>
>> Cc: Tomasz Figa <tfiga@chromium.org>
>> Fixes: baf94e6ebff9 ("iommu/mediatek: Add device link for smi-common
>> and m4u")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/iommu/mtk_iommu.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>> index 25b834104790..0bbe32d0a2a6 100644
>> --- a/drivers/iommu/mtk_iommu.c
>> +++ b/drivers/iommu/mtk_iommu.c
>> @@ -828,6 +828,8 @@ static int mtk_iommu_probe(struct platform_device
>> *pdev)
>>   					     "mediatek,larbs", NULL);
>>   	if (larb_nr < 0)
>>   		return larb_nr;
>> +	if (larb_nr == 0)
>> +		return -EINVAL;
> 
> Just assigning the larbnode to NULL may be simpler. In this case, it
> won't enter the loop below, and return 0 in the
> of_parse_phandle(larbnode, "mediatek,smi", 0).
> 
> -       struct device_node      *larbnode, *smicomm_node;
> +       struct device_node      *larbnode = NULL, *smicomm_node;
> 

It is an option, but it would need to be explained and would not be
as simple as it looks. And, yes, it would result in unnecessary code
execution.

Why does it need to be explained ? I spent quite some additional
time with the code trying to understand _why_ it works, and we should
make sure that others don't have to spend that time.

Anyway, that additional time made me find additional problems with
the code.

The for loop below assigns larbnode to the last node it finds.
However, that node can be disabled.

		if (!of_device_is_available(larbnode)) {
                         of_node_put(larbnode);
                         continue;
                 }

Is such a disabled larbnode, if it is the last one, the node to use
when looking for "mediatek,smi" ?

Also, there is

	ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
         if (ret)/* The id is consecutive if there is no this property */
                 id = i;

There are two problems with this code. First, neither i nor id are range
checked, but used later in

	data->larb_imu[id].dev = &plarbdev->dev;

That means a devicetree with a bad value for "mediatek,larb-id"
or more than MTK_LARB_NR_MAX larb nodes will result in writes after
the end of struct mtk_iommu_data.

On top of that, the comment states that the nodes are consecutive if there
is no "mediatek,larb-id". However, that isn't really the case if there
are disabled nodes. If there are disabled nodes, there will be a gap in
larb_imu[]. I don't know if that matters; if it doesn't, there should be
a comment about it in the code.

Last but not least, it would probably make sense to explain what the "last"
larb node is expected to be in more detail. It is the last larb node in
the devicetree file, but not the one with the highest id, and not
(necessarily) an enabled one. For example, in
arch/arm64/boot/dts/mediatek/mt2712e.dtsi, the code would pick
<&smi_common0> even though <&smi_common1> is associated with a higher
larb id.

One could of course argue that this all doesn't matter because it would
suggest that the devicetree data is bad, but it is common practice to validate
devicetree data and not just blindly accept it. One could also argue
that such bad data would be an "attack", but, again, we don't know that.

In summary,

- The check I introduced should probably be something like

	if (larb_nr == 0 || larb_nr > MTK_LARB_NR_MAX)
		return -EINVAL;

- It needs to be clarified if larbnode to use for finding "mediatek,smi"
   is indeed always the last one, even if it is disabled. If so, we should
   probably also handle the situation that of_node_put(larbnode); was called
   on that larbnode. Alternatively, if the last larb node to use is the last
   _active_ larb node, we'll probably need a separate variable to save that
   larb node pointer for later use.

- It needs to be clarified if larb_imu[] may have gaps if there are disabled
   larb nodes and "mediatek,larb-id" is not specified. If so, there is still the
   problem that 'i' and a previous value of "mediatek,larb-id" may be identical
   [ eg the first node provides mediatek,larb-id = <1> and the second node
     doesn't provide "mediatek,larb-id" ]

- "id" should be range checked.

- The meaning of "last" larb node to use when looking for mediatek,smi should
   be explained in more detail.

Once we have determined the correct handling of all those situations, I'll
be happy to send another revision of this patch (or possibly multiple patches).

Thanks,
Guenter

>>   
>>   	for (i = 0; i < larb_nr; i++) {
>>   		u32 id;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
