From: Jon Mayo <jon.mayo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v2 5/5] drm: Add NVIDIA Tegra support
Date: Tue, 22 May 2012 00:01:46 -0700
Message-ID: <CA+X0nSCHu_p9qjD=eofF9NhFQwvtPcVnSRyqZ8LSr4kmkDDmSQ@mail.gmail.com>
References: <1335347102-14905-1-git-send-email-thierry.reding@avionic-design.de>
	<1335347102-14905-6-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1335347102-14905-6-git-send-email-thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, =?UTF-8?Q?Terje_Bergstr=C3=B6m?= <tbergstrom-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lucas Stach <dev-8ppwABl0HbeELgA04lAiVw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 25, 2012 at 2:45 AM, Thierry Reding
<thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
> currently has rudimentary GEM support and can run a console on the
> framebuffer as well as X using the xf86-video-modesetting driver. Onl=
y
> the RGB output is supported.
>
> HDMI support was taken from NVIDIA's Linux kernel tree but it doesn't
> quite work. EDID data can be retrieved but the output doesn't properl=
y
> activate the connected TV.
>
> The DSI and TVO outputs and the HOST1X driver are just stubs that set=
up
> the corresponding resources but don't do anything useful yet.
>

Nice work Thierry, I'm happy with the display programming bits. I
think the pll_p enable/disable problem with RGB is better fixed when
we have some fancier clock infrastructure. I have some ideas how it
could be fixed now, but given that I want to see pll_p or pll_d /
pll_d2 selected automatically based on final clock, I'd rather hold
off on fixing things that are not really broken that going to be
replaced anyways. You can save a little power by leaving D pll's off,
and the logic to do it isn't hard and fairly safe to hard code into
the driver instead of trying to represent it in DT. (FYI - pll_d2 is a
Tegra3 feature, this way you can do things like run DSI and HDMI with
low jitter, instead of trying to take over pll_c for HDMI, which
deprives other modules of the clock freedom)

I have more DSI devices on Tegra3 than on Tegra2, so I'm putting
Tegra3 support near the top of my TODO list, because in my mind
getting forward progress on DSI support depends on it. HDMI
programming is not too tough, it's mostly loading calibrated magic
values into some SOR registers. The values are different for T20 and
T30 series (same fields, just needed different calibration).

--
"If you give someone a program, you will frustrate them for a day; if
you teach them how to program, you will frustrate them for a
lifetime." =E2=80=94 David Leinweber
