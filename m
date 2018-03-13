From: Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH v9 1/5] driver core: Find an existing link between two devices
Date: Tue, 13 Mar 2018 20:23:34 +0900
Message-ID: <CAAFQd5A5Rj1KAZjUc5ZUKuKnbkA5Q6aLw9z0H3_kfyBQOOF-gw@mail.gmail.com>
References: <20180313085534.11650-1-vivek.gautam@codeaurora.org>
 <20180313085534.11650-2-vivek.gautam@codeaurora.org> <CAAFQd5DXvnjaFw4Ct1Xn90nQZ4F4dLtov0ymG-tycQt5oLNpiQ@mail.gmail.com>
 <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFp+6iH3R2j0_vboSV6-0k7vQFaZ66iNiTcV3_qSbBGXdM=S_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lukas Wunner <lukas@wunner.de>
Cc: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Clark <robdclark@gmail.com>, Sricharan R <sricharan@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Archit Taneja <architt@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 13, 2018 at 7:34 PM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Hi Tomasz,
>
> On Tue, Mar 13, 2018 at 3:45 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> Hi Vivek,
>>
>> Thanks for the patch.
>>
>> On Tue, Mar 13, 2018 at 5:55 PM, Vivek Gautam
>> <vivek.gautam@codeaurora.org> wrote:
>>> The lists managing the device-links can be traversed to
>>> find the link between two devices. The device_link_add() APIs
>>> does traverse these lists to check if there's already a link
>>> setup between the two devices.
>>> So, add a new APIs, device_link_find(), to find an existing
>>> device link between two devices - suppliers and consumers.
>>
>> I'm wondering if this API would be useful for anything else that the
>> problem we're trying to solve with deleting links without storing them
>> anywhere. Perhaps a device_link_del_dev(consumer, supplier) would be a
>> better alternative?
>
> Yea, that sounds simpler i think. Will add this API instead of
> find_link(). Thanks.

Perhaps let's wait for a moment to see if there are other opinions. :)

Rafael, Lucas, any thoughts?

Best regards,
Tomasz
