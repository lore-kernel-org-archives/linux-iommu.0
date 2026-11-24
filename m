Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546151;
	b=InCcS1pSYbq0VqDpKWikEkoKvFfUrZ9uGijt8fWtIJT3iB1GuFabZ1W5QWFBmSp8eoUa
	 oJZ4y/5Qx8/ttd0S6ULz2nnH9gmD8IM08j+rNezVU/x6jFZMQHPD5x+535gt57mp54R/P
	 6Hwpuxtl8q7JkXbSwXyZgRDLPQyTa0WiXvowlLpOwA+2Yw7qIZ4Xys31cAkn3+V0duxX6
	 mlLyycSFxps8cNH0sEEhaI/CrqcIK6X2Lhh6xhxFXDbZSoObEO5V36mbplrrWTF9CAmK0
	 xtiqYokPlwJzVN2jAnI2h3ImOyPF5GMCWCEcl0rXNwl/Y9Q88uVxrhqczXpLVUvg3dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=4yLPI/bzfD8pEXes+IoGrcyl3dKDKR1GnvriWiKOLpo=;
	b=uPYB212wcaGa42vZ1P0VC887IyeRpA71qyVb2aH4bd14aokYVRnpZioZ9kQEIZc+SHQI
	 TcgJ1kD/Emit5wHgbDqB1NkG8gYbgJYQO+748D7NMSPRt2+YdOhHr0btwlzTH+Ufo2GrX
	 qu1WOv5KijoEAJM8nsCIN30bey6SZi7QpeyBUYahkUo26GP5lV/UfPwoISjmETbM0NKec
	 HASH38PlJa9YDmK+2Qk4iwVQzZcIE33IgJHCALv0BDwvAQtoYnMz+gFSuz02aCYg82WjQ
	 Jn0/E3YBmZ5fRCBehkJgWq5ny0if8lM5TePo4gfyJkPZ9fIH539VXzcpGg4b4yQWvRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a02s+X5I;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4A606A323
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 18:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D4A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a02s+X5I
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so31522965e9.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 10:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795546149; x=1796150949; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4yLPI/bzfD8pEXes+IoGrcyl3dKDKR1GnvriWiKOLpo=;
        b=a02s+X5IQDc2LtTdc5mlpmDsDRIGayQsHx7e628j72QWO0XmqlmrnYlhRv/wV64wOO
         mnLWxGop44+Rq2+YqTs82CuvDjKbGuHTcYngU+SMonG/xOSJwF26kSo1j2IpXwMyByBJ
         AdIRNUDRj0Kp+ZyKGxLrn2pvRDTEWN1KtXpy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546149; x=1796150949;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4yLPI/bzfD8pEXes+IoGrcyl3dKDKR1GnvriWiKOLpo=;
        b=XVT7TpRM10zTz8UEzn4fjX+K3pAYMhnMtqzuT/WQXlEA6GW2ZLoiTq/1wvtw4GU/05
         StN/3mCUzJKZVkwUmQv9UtgHPUAzo7LNsXe/23PNW3gPk1Ir4IxsN5ikkFOLZaKEs2cY
         sPi4xukU9IAv7vQr104UPrQabKbzyBiGDFTpxOkd81flz2Qf8KLPWIilW6JxXyVKMtKM
         9MIfAtaD68rZU1bMLD7UoFkCcKmmp/A88W/9DXlMKLhU8A5mXAhgavM21b5zfU54Pl+e
         lIqDlOZHoy6aRip9Mu8h/qrMGJ4LeV3lW/TJhhtTBsi/Hud/4U6ry83p8aMyAPMBJXD4
         o1oQ==
X-Forwarded-Encrypted: i=1; AL+hErFxfQZCVdIqd+/efNy4B8zeYZtWK8nr82rB19j2tNigzTsOic6pglG3dBEDvRxT7Mcz6//N1g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8/XcAINalgLHh8SX40awwtYv7rHXE19y3uQMiXXaPObJBa4fvP
	b9HCQU7H5ilbzXL6UFlcPlLbRm6MQOtHBBlaIxm7vP1cy57QuZG2fuE3dUEz952W7w==
X-Gm-Gg: AZFdTZfU8HCkpnhc4wLiLKNb8McNpTQP40Qicr+w419C5BMvN1CMwiH0DxPQVlJrL1h
	sAX4uXN/ykwzpfaSe7OzaJQI7FPzHfCWb3s9RVjb7VFf307QV7X08fcNRdwD+7bFDmsLnWPuOvq
	K/4fL/yFgrNrBaPxfVdxNpOzSdk4AUv7gaIMGiVplT8zrvwb7BiVEtUjAugXy3EgqCQnXbyFUvP
	I06TI3r1hAD3VXUpGAWRySth306iZ2eKg2DZbeoDd+ECwftUXy+PmVpdpcf9ZOkXov/mUFsCfWR
	pktEQiJvF99iMsYFRKptMgod4Ki6d2nzXdn8sL678GZSP/SXt0tWvRjvkhUGxCFlKCbdqcf3App
	pjJ1zWwmgHYhJWtX0XFGHxezEMLm5oA9aM2QyrBsYLPaxMY6FfYgt7B71ehihZ2ocJjhiNeiywS
	HsXmByUt91/bS2IxxMjddIDo69FbFqJ5F84AGhmU3rKNHn0Mb44b1PMngb0DBZF2ldcv08Ni3PE
	IHsL67J1WjU2KJbbFU9vh3+rcgOVt+rtQBozGYzgiwv0PAo3kI3gZ0UDJ+2V+mmvtyvaIKZygV/
	dFfMyNR+ScpYc9AwluX/rwxxlTeGpKJF7Br6a1uZep3VGoXs5c64tH00wEjuwEzc
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr336029925e9.14.1795546148684;
        Tue, 24 Nov 2026 10:49:08 -0800 (PST)
Received: from google.com ([2a00:79e0:285b:8:af0c:c5f1:ee8a:b81f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm367300855e9.0.2026.11.24.10.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:49:08 -0800 (PST)
Date: Tue, 24 Nov 2026 19:49:04 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <awXXSfrhLHK7TNbp@google.com>
References: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910-trust-tbt-fix-v5-1-7a7a42a5f496@chromium.org>

On Tue, Sep 10, 2024 at 05:57:45PM +0000, Esther Shimanovich wrote:
> Some computers with CPUs that lack Thunderbolt features use discrete
> Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> chips are located within the chassis; between the root port labeled
> ExternalFacingPort and the USB-C port.
> 
> These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> as they are built into the computer. Otherwise, security policies that
> rely on those flags may have unintended results, such as preventing
> USB-C ports from enumerating.
> 
> Detect the above scenario through the process of elimination.
> 
> 1) Integrated Thunderbolt host controllers already have Thunderbolt
>    implemented, so anything outside their external facing root port is
>    removable and untrusted.
> 
>    Detect them using the following properties:
> 
>      - Most integrated host controllers have the usb4-host-interface
>        ACPI property, as described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> 
>      - Integrated Thunderbolt PCIe root ports before Alder Lake do not
>        have the usb4-host-interface ACPI property. Identify those with
>        their PCI IDs instead.
> 
> 2) If a root port does not have integrated Thunderbolt capabilities, but
>    has the ExternalFacingPort ACPI property, that means the manufacturer
>    has opted to use a discrete Thunderbolt host controller that is
>    built into the computer.
> 
>    This host controller can be identified by virtue of being located
>    directly below an external-facing root port that lacks integrated
>    Thunderbolt. Label it as trusted and fixed.
> 
>    Everything downstream from it is untrusted and removable.
> 
> The ExternalFacingPort ACPI property is described here:
> Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports
> 
> Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> While working with devices that have discrete Thunderbolt chips, I
> noticed that their internal TBT chips are inaccurately labeled as
> untrusted and removable.
> 
> I've observed that this issue impacts all computers with internal,
> discrete Intel JHL Thunderbolt chips, such as JHL6240, JHL6340, JHL6540,
> and JHL7540, across multiple device manufacturers such as Lenovo, Dell,
> and HP.
> 
> This affects the execution of any downstream security policy that
> relies on the "untrusted" or "removable" flags.
> 
> I initially submitted a quirk to resolve this, which was too small in
> scope, and after some discussion, Mika proposed a more thorough fix:
> https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com
> I refactored it and am submitting as a new patch.
> ---
> Changes in v5:
> - Applied the following edits suggested by Lukas Wunner:
>   - Applied ifdefs edits to ensure code is only compiled on x86 systems
>   with ACPI
>   - Added returns to avoid unecessary checks
>   - Renamed pcie_is_tunneled to arch_pci_dev_is_removable
> - Link to v4: https://lore.kernel.org/r/20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org
> 
> Changes in v4:
> - Applied edits on logic-flow clarity and formatting suggested by Ilpo
>   Järvinen
> - Mario Limonciello tested patch and confirmed works as intended.
> - Link to v3: https://lore.kernel.org/r/20240815-trust-tbt-fix-v3-1-6ba01865d54c@chromium.org
> 
> Changes in v3:
> - Incorporated minor edits suggested by Mika Westerberg.
> - Mika Westerberg tested patch (more details in v2 link)
> - Added "reviewed-by" and "tested-by" lines
> - Link to v2: https://lore.kernel.org/r/20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org
> 
> Changes in v2:
> - I clarified some comments, and made minor fixins
> - I also added a more detailed description of implementation into the
>   commit message
> - Added Cc recipients Mike recommended
> - Link to v1: https://lore.kernel.org/r/20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org
> ---
>  arch/x86/pci/acpi.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c |  30 +++++++++----
>  include/linux/pci.h |   6 +++
>  3 files changed, 148 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 55c4b07ec1f6..62271668c3b1 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -250,6 +250,125 @@ void __init pci_acpi_crs_quirks(void)
>  		pr_info("Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
>  }
>  
> +/*
> + * Checks if pdev is part of a PCIe switch that is directly below the
> + * specified bridge.
> + */
> +static bool pcie_switch_directly_under(struct pci_dev *bridge,
> +				       struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent = pci_upstream_bridge(pdev);
> +
> +	/* If the device doesn't have a parent, it's not under anything. */
> +	if (!parent)
> +		return false;
> +
> +	/*
> +	 * If the device has a PCIe type, check if it is below the
> +	 * corresponding PCIe switch components (if applicable). Then check
> +	 * if its upstream port is directly beneath the specified bridge.
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_UPSTREAM:
> +		return parent == bridge;
> +
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		if (pci_pcie_type(parent) != PCI_EXP_TYPE_UPSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		return parent == bridge;
> +
> +	case PCI_EXP_TYPE_ENDPOINT:
> +		if (pci_pcie_type(parent) != PCI_EXP_TYPE_DOWNSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		if (!parent || pci_pcie_type(parent) != PCI_EXP_TYPE_UPSTREAM)
> +			return false;
> +		parent = pci_upstream_bridge(parent);
> +		return parent == bridge;
> +	}
> +
> +	return false;
> +}
> +
> +static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
> +{
> +	struct fwnode_handle *fwnode;
> +
> +	/*
> +	 * For USB4, the tunneled PCIe root or downstream ports are marked
> +	 * with the "usb4-host-interface" ACPI property, so we look for
> +	 * that first. This should cover most cases.
> +	 */
> +	fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
> +				       "usb4-host-interface", 0);
> +	if (!IS_ERR(fwnode)) {
> +		fwnode_handle_put(fwnode);
> +		return true;
> +	}
> +
> +	/*
> +	 * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
> +	 * before Alder Lake do not have the "usb4-host-interface"
> +	 * property so we use their PCI IDs instead. All these are
> +	 * tunneled. This list is not expected to grow.
> +	 */
> +	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> +		switch (pdev->device) {
> +		/* Ice Lake Thunderbolt 3 PCIe Root Ports */
> +		case 0x8a1d:
> +		case 0x8a1f:
> +		case 0x8a21:
> +		case 0x8a23:
> +		/* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
> +		case 0x9a23:
> +		case 0x9a25:
> +		case 0x9a27:
> +		case 0x9a29:
> +		/* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
> +		case 0x9a2b:
> +		case 0x9a2d:
> +		case 0x9a2f:
> +		case 0x9a31:
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +bool arch_pci_dev_is_removable(struct pci_dev *pdev)
> +{
> +	struct pci_dev *parent, *root;
> +
> +	/* pdev without a parent or Root Port is never tunneled. */
> +	parent = pci_upstream_bridge(pdev);
> +	if (!parent)
> +		return false;
> +	root = pcie_find_root_port(pdev);
> +	if (!root)
> +		return false;
> +
> +	/* Internal PCIe devices are not tunneled. */
> +	if (!root->external_facing)
> +		return false;
> +
> +	/* Anything directly behind a "usb4-host-interface" is tunneled. */
> +	if (pcie_has_usb4_host_interface(parent))
> +		return true;
> +
> +	/*
> +	 * Check if this is a discrete Thunderbolt/USB4 controller that is
> +	 * directly behind the non-USB4 PCIe Root Port marked as
> +	 * "ExternalFacingPort". Those are not behind a PCIe tunnel.
> +	 */
> +	if (pcie_switch_directly_under(root, pdev))
> +		return false;
> +
> +	/* PCIe devices after the discrete chip are tunneled. */
> +	return true;
> +}
> +
>  #ifdef	CONFIG_PCI_MMCONFIG
>  static int check_segment(u16 seg, struct device *dev, char *estr)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b14b9876c030..7e0d6a1e151b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1631,23 +1631,33 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
> -	struct pci_dev *parent;
> +	struct pci_dev *parent = pci_upstream_bridge(dev);
>  
> +	if (!parent)
> +		return;
>  	/*
> -	 * If the upstream bridge is untrusted we treat this device
> +	 * If the upstream bridge is untrusted we treat this device as
>  	 * untrusted as well.
>  	 */
> -	parent = pci_upstream_bridge(dev);
> -	if (parent && (parent->untrusted || parent->external_facing))
> +	if (parent->untrusted) {
> +		dev->untrusted = true;
> +		return;
> +	}
> +
> +	if (arch_pci_dev_is_removable(dev)) {

Looks like this caused a regression: on non-x86, dev->untrusted is never
set to true for any device (so we *never* enforce DMA protection from
externally plugged devices), since set_pcie_untrusted() solely relies on
arch_pci_dev_is_removable() which is implemented on x86 only (on other
archs it is a stub returning false), without checking
parent->external_facing on other archs like it did before this patch.

(I found this by looking at the code, not by testing.)

> +		pci_dbg(dev, "marking as untrusted\n");
>  		dev->untrusted = true;
> +	}
>  }
>  
>  static void pci_set_removable(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
>  
> +	if (!parent)
> +		return;
>  	/*
> -	 * We (only) consider everything downstream from an external_facing
> +	 * We (only) consider everything tunneled below an external_facing
>  	 * device to be removable by the user. We're mainly concerned with
>  	 * consumer platforms with user accessible thunderbolt ports that are
>  	 * vulnerable to DMA attacks, and we expect those ports to be marked by
> @@ -1657,9 +1667,15 @@ static void pci_set_removable(struct pci_dev *dev)
>  	 * accessible to user / may not be removed by end user, and thus not
>  	 * exposed as "removable" to userspace.
>  	 */
> -	if (parent &&
> -	    (parent->external_facing || dev_is_removable(&parent->dev)))
> +	if (dev_is_removable(&parent->dev)) {
> +		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +		return;
> +	}
> +
> +	if (arch_pci_dev_is_removable(dev)) {
> +		pci_dbg(dev, "marking as removable\n");
>  		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
> +	}
>  }
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e36b6c1810e..dca19203bc7c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2604,6 +2604,12 @@ pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
>  static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
>  #endif
>  
> +#if defined(CONFIG_X86) && defined(CONFIG_ACPI)
> +bool arch_pci_dev_is_removable(struct pci_dev *pdev);
> +#else
> +static inline bool arch_pci_dev_is_removable(struct pci_dev *pdev) { return false; }
> +#endif
> +
>  #ifdef CONFIG_EEH
>  static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  {
> 
> ---
> base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
> change-id: 20240806-trust-tbt-fix-5f337fd9ec8a
> 
> Best regards,
> -- 
> Esther Shimanovich <eshimanovich@chromium.org>
> 
