From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCHv5 2/9] driver/core: populate devices in order for IOMMUs
Date: Tue, 19 Nov 2013 13:03:51 +0100
Message-ID: <20131119.140351.1342214267287135109.hdoyu@nvidia.com>
References: <1384853593-32202-1-git-send-email-hdoyu@nvidia.com><1384853593-32202-3-git-send-email-hdoyu@nvidia.com><20131119102506.GG31504@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20131119102506.GG31504-AwZRO8vwLAwmlAP/+Wk3EA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote @ Tue, 19 Nov 2013 11:25:07 +0100:

> From earlier discussions I thought the goal was to actually defer this
> until all nodes referred to by the iommus property were actually
> registered. The above only checks that the phandles can be resolved to
> valid struct device_node:s. That doesn't mean that an actual IOMMU has
> been registered for it, only that the devices have been created.

Currently "bus->iommu_ops" is set at the end of tegra_smmu_probe(). So
if "bus->iommu_ops" is set, it means that an iommu instance is
populated at that time.

> If you really only rely on dev->bus->iommu_ops to be present, then there
> is no need to go through the loop in the first place, since you have
> access to it immediately through the struct device that's passed into
> the function.

As mentioned in the above, "bus->iommu_ops" is set when an iommu
instance is populated. "iommus=" is used only to defer a device probe
until an iommu instance shows up although multiple IOMMUs are not
supported yet correctly as you pointed out.

> Furthermore, relying on dev->bus->iommu_ops will prevent multiple IOMMUs
> from being used at all, since only one IOMMU can register iommu_ops with
> the bus, right? So I think what we really need here is a way to resolve
> the IOMMU using a phandle and return the associated struct
> iommu_ops.

Multiple IOMMU support doesn't work right now. It needs to be
discussed a bit more.

> I also have some trouble understanding how the current IOMMU framework
> is supposed to work together with multiple IOMMUs for one device. The
> .add_device() callback seems to be missing crucial information to help
> decide whether the device to be added is actually one that it covers.
> Also with an of_iommu_attach() function, doesn't that become more or
> less redundant?

I understand what you meant. In the current tegra SMMU implementation,
iommu_ops is set when an iommu is populated so that we cannot use
iommu_ops before that time. That's why of_iommu_attach() was
introduced here. I couldn't set iommu_ops at drvier init yet because
we support SMMU and GART with a single image and the current IOMMU
framework assume that there's one IOMMU on the bus. If we set
iommu_ops at driver init, the latter one would overwrite it.
