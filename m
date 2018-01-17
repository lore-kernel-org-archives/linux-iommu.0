From: JeffyChen <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2 12/13] iommu/rockchip: Add runtime PM support
Date: Wed, 17 Jan 2018 15:52:49 +0800
Message-ID: <5A5F00D1.5010506@rock-chips.com>
References: <20180116132540.18939-1-jeffy.chen@rock-chips.com> <20180116132540.18939-13-jeffy.chen@rock-chips.com> <CAAFQd5DCxgsL52+5XetV9MRDecL7dN6_QdHysKUOWaEqSf=ijw@mail.gmail.com> <5A5EFAB2.7040001@rock-chips.com> <CAAFQd5ATRh5hdJhVxDoXjFz72cBmv-yNaW7v-eUxkVRYA3=uJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAFQd5ATRh5hdJhVxDoXjFz72cBmv-yNaW7v-eUxkVRYA3=uJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Figa <tfiga@chromium.org>
Cc: linux-kernel@vger.kernel.org, Ricky Liang <jcliang@chromium.org>, Robin Murphy <robin.murphy@arm.com>, simon xue <xxm@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Hi Tomasz,

On 01/17/2018 03:38 PM, Tomasz Figa wrote:
>>> >>Don't we need to check here (and in _shutdown() too) if we have a
>>> >>domain attached?
>> >
>> >hmmm, right, the startup might been called by resume, so should check
>> >iommu->domain here.
>> >
>> >but the shutdown would be called at the end of detach or suspend, it could
>> >be not attached or attached.
> If startup might be called by resume, without domain attached, what
> prevents shutdown from being called by suspend after that resume,
> still without domain attached? Is it guaranteed that if resume is
> called, someone will attach a domain before suspend is called?
>
no, the shutdown would be called by:
1/ end of detach_dev
so it would be not attached at that time

2/ suspend
so it could be attached, and also could be not attached


anyway, i think the shutdown would work without domain attached(just 
disable paging and clear the iommu bases) ;)

> Best regards,
> Tomasz
>
>
>
