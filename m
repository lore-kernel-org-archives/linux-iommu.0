From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v8 3/5] memory: mediatek: Add SMI driver
Date: Tue, 16 Feb 2016 15:32:11 +0000
Message-ID: <56C340FB.1050607@arm.com>
References: <1453781562-23556-1-git-send-email-yong.wu@mediatek.com>
 <1453781562-23556-4-git-send-email-yong.wu@mediatek.com>
 <56ADE959.2050309@gmail.com> <20160216141059.GT18805@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160216141059.GT18805@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, youhua.li@mediatek.com, Thierry Reding <treding@nvidia.com>, devicetree@vger.kernel.org, kendrick.hsu@mediatek.com, Sasha Hauer <kernel@pengutronix.de>, arnd@arndb.de, Tomasz Figa <tfiga@google.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, pebolle@tiscali.nl, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Daniel Kurtz <djkurtz@google.com>, p.zabel@pengutronix.de, Lucas Stach <l.stach@pengutronix.de>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On 16/02/16 14:11, Joerg Roedel wrote:
> On Sun, Jan 31, 2016 at 12:00:41PM +0100, Matthias Brugger wrote:
>>
>>
>> On 26/01/16 05:12, Yong Wu wrote:
>>> This patch add SMI(Smart Multimedia Interface) driver. This driver
>>> is responsible to enable/disable iommu and control the power domain
>>> and clocks of each local arbiter.
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
>>> ---
>>
>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Joerg would you mind to take this through your branch?
>
> Hmm, I somehow missed the patch-set, at least I can't find the v8
> patches in my inbox.
>
> Yong, can you please re-send with all Acks and other tags added?

Just to note patch 4 of this series also depends on the v3 io-pgtable 
short-descriptor series posted separately[1] - is that on your radar 
already or would you like that resent as well?

Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/12007

>
>
> Thanks,
>
> 	Joerg
>
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>
