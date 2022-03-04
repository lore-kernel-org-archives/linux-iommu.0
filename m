Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB616C433EF
	for <iommu@archiver.kernel.org>; Fri,  4 Mar 2022 10:07:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A03660ADE;
	Fri,  4 Mar 2022 10:07:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Zdhc0vT4Njqg; Fri,  4 Mar 2022 10:07:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 210F060804;
	Fri,  4 Mar 2022 10:07:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C88A0C0012;
	Fri,  4 Mar 2022 10:07:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 264F2C000B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12694403A7
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:07:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KTotmYU-llKL for <iommu@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 10:07:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F4BD4035D
 for <iommu@lists.linux-foundation.org>; Fri,  4 Mar 2022 10:07:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 3D2CF1F464FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1646388469;
 bh=FZsV9ba/xuMDKrYCeoG5kKb+WB3TEznV+q7TAKpo3JE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z/+HfKH6m2gMYR33+DYiAue+iFGOvhah5GOHFpNlKFJqMG4MOd1VbxxrERk9rfAtu
 8/Qd1FnQpl8UrU1lpchE1zxVjdxc8M46oXrPWgg9e07c8pGsGSItv44kp+mT8vkxiC
 GqKMLEbT6u0aMosmlCZK3J02q13Vcqt7xl1S3bzZ9gL6QZxwDFnYoCzJHth9SqmKt/
 zdAo07VBT2F1Sy2xWlemRsHGnyl3/3GjNVh2dW1sF+CDd8leaItHUb94UDOyyT6Uvd
 3vidqdgIrB5sogWh7aqmnt7IJTQxNQiO/aLZ9ww7dxnQLDl/Z50tobHcx3MmMwzheE
 MK7tpc8yctI2Q==
Message-ID: <6b1bd27c-d371-51eb-d166-575312d8506f@collabora.com>
Date: Fri, 4 Mar 2022 11:07:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 00/34] MT8195 IOMMU SUPPORT
Content-Language: en-US
To: Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <YhzBSsn/zUlGg5JE@8bytes.org>
 <7ba0ee87-c193-9834-d0b4-ff3e06ced82b@collabora.com>
 <5ed9278fa0b72b993512cff2316218ab88cafe50.camel@mediatek.com>
 <YiHZ4lq2QClkdyxS@8bytes.org>
 <123cb154ca0e87504c2b663ebdca2ccad967776f.camel@mediatek.com>
 <YiHkhERbAY8oYRYw@8bytes.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YiHkhERbAY8oYRYw@8bytes.org>
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, xueqi.zhang@mediatek.com,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, yf.wang@mediatek.com,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 mingyuan.ma@mediatek.com, linux-arm-kernel@lists.infradead.org
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

Il 04/03/22 11:05, Joerg Roedel ha scritto:
> On Fri, Mar 04, 2022 at 05:57:19PM +0800, Yong Wu wrote:
>> Thanks for this info. I will re-send this patchset after the next -rc1.
>>
>> Could you help apply Dafna's patchset at this time? This patchset
>> depends on it and it won't conflict with the others.
> 
> Alright, picked up Dafna's patch-set.
> 
> Regards,
> 
> 	Joerg

Thanks for picking Dafna's series right now, this was very appreciated.

Regards,
Angelo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
