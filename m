From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] dts: rockchip: rk3066: add qos_hdmi and HCLK_HDMI to pmu node
Date: Mon, 17 Dec 2018 15:20:12 +0100
Message-ID: <39618907.0447OVrsHf@phil>
References: <AM6PR04MB45048F404CB1166F7CEB0101BFA20@AM6PR04MB4504.eurprd04.prod.outlook.com> <CAAFQd5DrRRQku4jDn5sC+TornQjGi0U7W8UUiv29aQtCyxf=yQ@mail.gmail.com> <AM6PR04MB4504E587B100C217B4860380BFBC0@AM6PR04MB4504.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM6PR04MB4504E587B100C217B4860380BFBC0@AM6PR04MB4504.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Jonker <jbx9999@hotmail.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Sandy Huang <hjc@rock-chips.com>, Sean Paul <seanpaul@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Joerg Roedel <joro@8bytes.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi Johan,

Am Montag, 17. Dezember 2018, 15:00:55 CET schrieb Johan Jonker:
> Thanks Tomasz for adding all the mailing lists.
> I prefer to ask first if a qos_hdmi exists before sending it in for
> public review.
> 
> All the clocks in the pmu node seem to have a "quality-of-service" (QoS)
> block.
> So I added one for hdmi too with the question if it exists and which
> address it might have.
> SoC documentation still isn't fully public, not that I'm aware off.
> 
> From Heiko's response I learned that the rk3066 manual does
> not list any hdmi-related QoS blocks.
> We now only add the HCLK_HDMI clock to pmu node in our patch.
> 
> After a small step forward people immediately ask to do a real patch serie.

Of course :-D .
Collecting reviews can take time, so posting things early is helpful,
especially now that you actually can generate output.

That is the one requirement I have ... that things actually work and
the vop-driver alone didn't look that way some weeks back ;-)
[And as we found out was also missing the changed irq].

> The rk3066_hdmi.c file also handles audio, but this is not tested yet.

You can strip the audio parts from the hdmi-encoder and just submit
it with the display parts only.

That way we can possibly pick up the working things already, reducing
the number of patches you have to carry around ;-) .

> The rk3066a-rayeager.dts file gives a idea how it's done,
> but I haven't had the time to get it working with .config and dts.
> Let me know if you can.

I think making this actually work will fall on your shoulders.
I.e. the rk3066 is really old (from 2012 or possibly even earlier), so
people like Tomasz don't have access to this (and also in most cases
not the time or interest to work on those specific socs).

While I do have a rk3066 marsboard here, it is currently not functional
in my test setup, so I also can only look at the code you provide.


Happy hacking
Heiko


> On 12/17/18 6:46 AM, Tomasz Figa wrote:
> 
> > Thanks for the patch. Unfortunately, it looks like you didn't add the
> > necessary mailing lists to the recipient list. For reference, the
> > ./scripts/get_maintainer.pl script in the kernel source tree should be
> > able to give you a reasonable recipient list. For now, I added the
> > mailing lists on CC and replied without snipping, so people should be
> > still able to review the patch.
> > 
> > Other than that, It looks reasonable to me, but we need someone with
> > access to SoC documentation to check it. Heiko, Sandy, is that
> > something you would be able to help with?
> 
> 
