From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv7 07/26] driver core: amba: add device binding path
	'driver_override'
Date: Fri, 26 Sep 2014 16:37:51 +0100
Message-ID: <20140926153751.GW5182@n2100.arm.linux.org.uk>
References: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com> <1411483586-29304-8-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411483586-29304-8-git-send-email-a.motakis@virtualopensystems.com>
Sender: kvm-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>
Cc: alex.williamson@redhat.com, kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org, tech@virtualopensystems.com, kvm@vger.kernel.org, christoffer.dall@linaro.org, will.deacon@arm.com, kim.phillips@freescale.com, eric.auger@linaro.org, marc.zyngier@arm.com, open list <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 23, 2014 at 04:46:06PM +0200, Antonios Motakis wrote:
> As already demonstrated with PCI [1] and the platform bus [2], a
> driver_override property in sysfs can be used to bypass the id matching
> of a device to a AMBA driver. This can be used by VFIO to bind to any AMBA
> device requested by the user.
> 
> [1] http://lists-archives.com/linux-kernel/28030441-pci-introduce-new-device-binding-path-using-pci_dev-driver_override.html
> [2] https://www.redhat.com/archives/libvir-list/2014-April/msg00382.html
> 
> Signed-off-by: Antonios Motakis <a.motakis@virtualopensystems.com>

I have to ask why this is even needed in the first place.  To take the
example in [2], what's wrong with:

echo fff51000.ethernet > /sys/bus/platform/devices/fff51000.ethernet/driver/unbind
echo fff51000.ethernet > /sys/bus/platform/drivers/vfio-platform/bind

and similar for AMBA.

All we would need to do is to introduce a way of having a driver accept
explicit bind requests.

In any case:

> +static ssize_t driver_override_store(struct device *_dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	struct amba_device *dev = to_amba_device(_dev);
> +	char *driver_override, *old = dev->driver_override, *cp;
> +
> +	if (count > PATH_MAX)
> +		return -EINVAL;
> +
> +	driver_override = kstrndup(buf, count, GFP_KERNEL);
> +	if (!driver_override)
> +		return -ENOMEM;
> +
> +	cp = strchr(driver_override, '\n');
> +	if (cp)
> +		*cp = '\0';

I hope that is not replicated everywhere.  This allows up to a page to be
allocated, even when the first byte may be a newline.  This is wasteful.

How about:

	if (count > PATH_MAX)
		return -EINVAL;

	cp = strnchr(buf, count, '\n');
	if (cp)
		count = cp - buf - 1;

	if (count) {
		driver_override = kstrndup(buf, count, GFP_KERNEL);
		if (!driver_override)
			return -ENOMEM;
	} else {
		driver_override = NULL;
	}

	kfree(dev->driver_override);
	dev->driver_override = driver_override;

Also:

> +static ssize_t driver_override_show(struct device *_dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	struct amba_device *dev = to_amba_device(_dev);
> +
> +	return sprintf(buf, "%s\n", dev->driver_override);
> +}

Do we really want to do a NULL pointer dereference here?

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
