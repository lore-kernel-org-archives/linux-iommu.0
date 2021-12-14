Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83670C433F5
	for <iommu@archiver.kernel.org>; Tue, 14 Dec 2021 15:14:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3C51B81437;
	Tue, 14 Dec 2021 15:14:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KskGYq0w9nIZ; Tue, 14 Dec 2021 15:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0B1CD81406;
	Tue, 14 Dec 2021 15:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C43BEC002F;
	Tue, 14 Dec 2021 15:14:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F0723C0012
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 09:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD6EE405AA
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 09:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1aaUWF8BijEW for <iommu@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 09:04:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B559A4055E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 09:04:12 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 w33-20020a17090a6ba400b001a722a06212so14272927pjj.0
 for <iommu@lists.linux-foundation.org>; Tue, 14 Dec 2021 01:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BLtNJBPTKfFgEngscPwkP+dSPVASO8XmAtvek6gJJYY=;
 b=oWW67fTzZWSJL5R4BckddJiSCZc1V0b1qLTqxm9SooUgBeSwc6S6hcJOYY+CDpL6T6
 hWGAhpWOZ7WiRSXsF9XqqnNMyCLfuP3ky5z1O5ksg5D19rk/YN7Svh1QfVdQewvc9uve
 yOquUnCG6sk222o6CRpLOmlOfmdmO541bZnZD1RK2J1tZEinaIeL0/IdvGExfsmvX1RF
 TT7M6ONGo1hPzOntMTRRuEGyN0jxgFhmYoCx7PF7TgA3GkNXP+mQ48XAHRa7LEij/dEW
 6xaY627nOo4wnyAvUNRwGx0D4C9ISFYe9H//Ya5dZdg23yM6b0lfeCFOKixHiUdsfd3s
 Drvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BLtNJBPTKfFgEngscPwkP+dSPVASO8XmAtvek6gJJYY=;
 b=SGAP5lTcD/20L6q0FGb++vChpHuhJw4LvZelvlSXFnSFatxeWJws2L455wzlgeAHK/
 fT6RESTjBWC57aBi4v+Do7SvOG052RN3rvtXskVJoE3wpLwnJfJpU8LFKxnjDvk7fqks
 KjRv4EPqT9W+ESJtxITtUL/m5qHryUz9YbtuIN+tWbrWshrc+rldq+sx3If1kzGxNVq7
 beVitLr5rBFLoLRhQS32xWifVK/u81bZWSVkjaGUHJFewg5Ruc3qb54KebEZZTQN6fK2
 QVBi3UatuMAn7L39QpEzCWLNHyB6JUX0CyLNtv+lmNsENQz4ArEtKvrPouf6tfV1nrnS
 6YeA==
X-Gm-Message-State: AOAM533sATPTaaux4NosMJn7M7f5GiXbdhqgCXUA+XPLxDQOxy4VAoDw
 lICYF0IhVCbaA8a6inRwfnWB6w==
X-Google-Smtp-Source: ABdhPJx1RHm9shDo9AZkjS+O+13ZegDk2AOGlHxMzBO6fB4uLVCwKlFaa183sh0fIZEMuEgAOlS+1w==
X-Received: by 2002:a17:90a:ac0b:: with SMTP id
 o11mr4099843pjq.143.1639472651731; 
 Tue, 14 Dec 2021 01:04:11 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:16cc:acbf:e9c5:6393])
 by smtp.gmail.com with ESMTPSA id p2sm1782960pja.55.2021.12.14.01.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Dec 2021 01:04:11 -0800 (PST)
Date: Tue, 14 Dec 2021 17:04:08 +0800
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [SPAM][PATCH] iommu/mediatek: Validate number of phandles
 associated with "mediatek,larbs"
Message-ID: <YbheCEbOS48Owcht@google.com>
References: <20211210205704.1664928-1-linux@roeck-us.net>
 <ebf58066a131f92c68e83a1ef56b88f435fa0d08.camel@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ebf58066a131f92c68e83a1ef56b88f435fa0d08.camel@mediatek.com>
X-Mailman-Approved-At: Tue, 14 Dec 2021 15:14:01 +0000
Cc: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Will Deacon <will@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>
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
From: Tzung-Bi Shih via iommu <iommu@lists.linux-foundation.org>
Reply-To: Tzung-Bi Shih <tzungbi@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Dec 14, 2021 at 03:31:25PM +0800, Yong Wu wrote:
> On Fri, 2021-12-10 at 12:57 -0800, Guenter Roeck wrote:
> > Since commit baf94e6ebff9 ("iommu/mediatek: Add device link for smi-
> > common
> > and m4u"), the driver assumes that at least one phandle associated
> > with
> > "mediatek,larbs" exists. If that is not the case, for example if
> > reason
> > "mediatek,larbs" is provided as boolean property, the code will use
> > an
> > uninitialized pointer and may crash. To fix the problem, ensure that
> > the
> > number of phandles associated with "mediatek,larbs" is at least 1 and
> > bail out immediately if that is not the case.
> 
> From the dt-binding, "mediatek,larbs" always is a phandle-array. I 
> assumed the dts should conform to the dt-binding before. Then the
> problem is that if we should cover the case that someone abuses/attacks
> the dts. Could you help add more comment in the commit message?
> something like: this is for avoid abuse the dt-binding.

How could you make sure dts conform to dt-bindings in runtime?  Code shouldn't rely on the assumptions but try the best to prevent any abuse/misconfigured/malicious cases especially if the assumptions are controllable by other parties.

Taking this case as an example, of_count_phandle_with_args() could return 3 types of values.
1. Negative: an error, it is already handled in the original code.
2. Positive: normal case, it falls down to the rest of code.
3. Zero: it still falls down to the rest of code, however, some variables won't be filled.

The code should handle all of the above types.

> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 25b834104790..0bbe32d0a2a6 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -828,6 +828,8 @@ static int mtk_iommu_probe(struct platform_device
> > *pdev)
> >  					     "mediatek,larbs", NULL);
> >  	if (larb_nr < 0)
> >  		return larb_nr;
> > +	if (larb_nr == 0)
> > +		return -EINVAL;
> 
> Just assigning the larbnode to NULL may be simpler. In this case, it
> won't enter the loop below, and return 0 in the
> of_parse_phandle(larbnode, "mediatek,smi", 0).
> 
> -       struct device_node      *larbnode, *smicomm_node;
> +       struct device_node      *larbnode = NULL, *smicomm_node;

Setting larbnode to NULL doesn't make sense to me.  It wastes some more instructions.  If the code can exit earlier, why does it need to call another of_parse_phandle()?

Also, it adds another dependency between the code blocks.  What if someone move the code blocks without awareness of the dependency?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
