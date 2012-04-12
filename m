From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 4/4] drm: Add NVIDIA Tegra support
Date: Thu, 12 Apr 2012 09:49:16 -0600
Message-ID: <4F86F97C.8010508@wwwdotorg.org>
References: <1334146230-1795-1-git-send-email-thierry.reding@avionic-design.de> <1334146230-1795-5-git-send-email-thierry.reding@avionic-design.de> <4F85C97E.50203@wwwdotorg.org> <20120412065038.GB4162@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120412065038.GB4162-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Jon Mayo <jmayo-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/12/2012 12:50 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 04/11/2012 06:10 AM, Thierry Reding wrote:
>>> This commit adds a very basic DRM driver for NVIDIA Tegra SoCs. It
>>> currently has rudimentary GEM support and can run a console on the
>>> framebuffer as well as X using the xf86-video-modesetting driver.
>>> Only the RGB output is supported. Quite a lot of things still need
>>> to be worked out and there is a lot of room for cleanup.
...
>>> diff --git a/Documentation/devicetree/bindings/gpu/drm/tegra.txt b/Documentation/devicetree/bindings/gpu/drm/tegra.txt
...
>> This doesn't seem right, and couples back to my assertion above that the
>> two display controller modules probably deserve separate device objects,
>> named e.g. tegradc.*.
> 
> I think I understand where you're going with this. Does the following look
> more correct?
> 
> 	disp1 : dc@54200000 {
> 		compatible = "nvidia,tegra20-dc";
> 		reg = <0x54200000, 0x00040000>;
> 		interrupts = <0 73 0x04>;
> 	};
> 
> 	disp2 : dc@54240000 {
> 		compatible = "nvidia,tegra20-dc";
> 		reg = <0x54240000, 0x00040000>;
> 		interrupts = <0 74 0x04>;
> 	};

Those look good.

> 	drm {
> 		compatible = "nvidia,tegra20-drm";

I'm don't think having an explicit "drm" node is the right approach; drm
is after all a SW term and the DT should be describing HW. Having some
kind of top-level node almost certainly makes sense, but naming it
something related to "tegra display" than "drm" would be appropriate.

> 		lvds {
> 			compatible = "...";
> 			dc = <&disp1>;
> 		};

Aren't the outputs separate HW blocks too, such that they would have
their own compatible/reg properties and their own drivers, and be
outside the top-level drm/display node?

I believe the mapping between the output this node represents and the
display controller ("dc" above) that it uses is not static; the
connectivity should be set up at runtime, and possibly dynamically
alterable via xrandr or equivalent.

> 		hdmi {
> 			compatible = "...";
> 			dc = <&disp2>;
> 		};
> 	};

>>> +static int tegra_drm_parse_dt(struct platform_device *pdev)
>>> +{
>> ...
>>> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>>> +	if (!pdata)
>>> +		return -ENOMEM;
>> ...
>>> +	dev->platform_data = pdata;
>>
>> I don't think you should assign to dev->platform_data. If you do, then I
>> think the following could happen:
>>
>> * During first probe, the assignment above happens
>> * Module is removed, hence device removed, hence dev->platform_data
>> freed, but not zero'd out
>> * Module is re-inserted, finds that dev->platform_data!=NULL and
>> proceeds to use it.
> 
> Actually the code does zero out platform_data in tegra_drm_remove(). In fact
> I did test module unloading and reloading and it works properly. But it
> should probably be zeroed in case drm_platform_init() fails as well.
>
>> Instead, the active platform data should probably be stored in a
>> tegra_drm struct that's stored in the dev's private data.
>> tegra_drm_probe() might then look more like:
>>
>> struct tegra_drm *tdev;
>>
>> tdev = devm_kzalloc();
>> tdev->pdata = pdev->dev.platform_data;
>> if (!tdev->pdata)
>>     tdev->pdata = tegra_drm_parse_dt();
>> if (!tdev->pdata)
>>     return -EINVAL;
>>
>> dev_set_drvdata(dev, tdev);
>>
>> This is safe, since probe() will never assume that dev_get_drvdata()
>> might contain something valid before probe() sets it.
> 
> I prefer my approach over storing the data in an extra field because the
> device platform_data field is where everybody would expect it. Furthermore
> this wouldn't be relevant if we decided not to support non-DT setups.

Drivers are expected to use pre-existing platform data, if provided.
This might happen in order to work around bugs in device tree content.
