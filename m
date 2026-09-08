Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF851D5CFB;
	Tue,  8 Sep 2026 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896454; cv=none; b=s2VBCrWg9o4Hd07ycU0HsN5lceZ3NvjMoLtlP34wXK3tl4Bej24RPw91UmAO0fmztC6wRE9GXo7KjY3JED/IOj/62umO9TXMLj+1REQBTWjMssk743sfXMqqwOf4bITuqdBN7z3Wv3iZxhyBFb3gsTb1+kinpFnKPAt4Crd0yMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896454; c=relaxed/simple;
	bh=4VYHrutiMEH1I6r/JQfYGA3zdT7OLpPQnZhFeeRaj68=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=de5TCXDvU9l1PJv4Jp2VKhc+ifYmeQJr9vo3ssOQy0EAPg+0FU7qjiGpBwTyX76WSQGnHTIp7YqtATOgBZfrNaDhPkBGikMVcHj5sD5uXSDZhYh7XJZxltFZD1VmsFTC2woTP0VNxIW2Pmcl9/ckB4IqIjq/WEs8veSs3R15UmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHJuzKov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHJuzKov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68671F00A3A;
	Tue,  8 Sep 2026 19:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788896452;
	bh=3SmaP2tfLo8P8qtLQeaRMf/6n6ZlUEcUp+fVq7MKCr4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GHJuzKoviIlcBoSUX8/bjnpkTnczaGSKZszt3GgXggayzktfr5jLR+6enahj4Qj0E
	 OmkXcUFPCucE58VGivtjTT5/8Tt/AaOaZQKCqcdP+1fhOwWIJldZBop7m4K31RjZEv
	 DHDF/SxfqXSriM0jif5tAUVI2qjnTlO7HY8oABbJapcFmLxtossJ9Hgl/7qMiexSC3
	 gEjK8bqDeb8PQ86l6yTSh7wBLcBFaYIBVLhyYfxuHouMLBr4LKYn0C0+99+uhMK3CC
	 UAdYCfZ3PFCHOSH2Vke/Ggp0YEWwuCGLcIPkhcYbSyQhh47/zCkClrA6hB9OfMpP/e
	 mamdEEcu26zHA==
From: Thomas Gleixner <tglx@kernel.org>
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa
 Saleh <smostafa@google.com>, Nicolin Chen <nicolinc@nvidia.com>, Daniel
 Mentz <danielmentz@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, rafael@kernel.org, Danilo Krummrich
 <dakr@kernel.org>, driver-core@lists.linux.dev, Pranjal Shrivastava
 <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>, Marc Zyngier
 <maz@kernel.org>
Subject: Re: [PATCH v10 07/15] platform-msi: Introduce
 platform_device_msi_rewrite()
In-Reply-To: <20260908171712.356645-8-praan@google.com>
References: <20260908171712.356645-1-praan@google.com>
 <20260908171712.356645-8-praan@google.com>
Date: Tue, 08 Sep 2026 21:40:49 +0200
Message-ID: <87se3j1qgu.ffs@fw13>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Sep 08 2026 at 17:17, Pranjal Shrivastava wrote:

...
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>

Jason. You really should know better by now :(

> +/**
> + * platform_device_msi_rewrite - Rewrite the MSI config for a platform device
> + * @dev:		The device for which to rewrite interrupt
> + * @irq:		The interrupt number to be rewritten.
> + * @write_msi_msg:	Callback to write the interrupt message for @dev
> + *
> + * Rewrites the cached MSI message for a platform device.
> + *
> + * Note: Platform MSI does not automatically cache composed messages. The caller's
> + * @write_msi_msg callback is expected to cache the message (e.g. into desc->msg)
> + * during initial configuration so it can be rewritten on resume.
> + */
> +void platform_device_msi_rewrite(struct device *dev, unsigned int irq,
> +				 irq_write_msi_msg_t write_msi_msg)

Why is this a platform device specific function and why does this need to
hand in the write_msi_msg() callback, which is already known through the
interrupt descriptor and the top level interrupt chip?

I spent an awful lot of time and effort to get rid of these platform MSI
layering violations and now you start adding the same mess again.

Not going to happen.

> +{
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	if (!irq || !write_msi_msg)
> +		return;

Oh well.

> +	desc = irq_get_msi_desc(irq);
> +	if (!desc) {
> +		dev_err(dev, "Failed to get MSI descriptor for irq %u\n", irq);
> +		return;
> +	}

Doing this without having the underlying interrupt descriptor locked is
a recipe for an undebuggable disaster waiting to happen. It might be
"safe" in the context you are calling it but it's absolutely not safe in
general.

> +	__get_cached_msi_msg(desc, &msg);
> +	if (!msg.address_hi && !msg.address_lo) {
> +		dev_warn(dev, "No cached MSI message found for irq %u\n", irq);

That's just wrong. A message with a zero address is valid, e.g. when an
interrupt is shut down. So if there is random crap after resume in the
message store and the interrupt is valid, but not requested, then the
cached message still has to be written even if it is zero.

So this want's to be a function in the MSI core code. Also this is not a
per interrupt problem it is obviously a per device domain problem.
Simply because the device provides the message store for all MSI interrupts
which originate from that same device and therefore _all_ MSI interrupts
are affected by that, no?

So this all can be solved at the device domain level without sprinkling
per interrupt invocations including conditionals all over the place.

Something like the completely untested below should just work.

Thanks,

        tglx
---
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -669,6 +669,8 @@ void msi_domain_free_irqs_all(struct dev
 
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
+void msi_device_domain_restore_msi_msgs(struct device *dev, unsigned int domid);
+
 /* Per device platform MSI */
 int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
 					    irq_write_msi_msg_t write_msi_msg);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1775,3 +1775,34 @@ bool msi_device_has_isolated_msi(struct
 	return arch_is_isolated_msi();
 }
 EXPORT_SYMBOL_GPL(msi_device_has_isolated_msi);
+
+void msi_device_domain_restore_msi_msgs(struct device *dev, unsigned int domid)
+{
+	if (!dev->msi.data)
+		return;
+
+	guard(msi_descs_lock)(dev);
+	struct irq_domain *domain = msi_get_device_domain(dev, domid);
+
+	if (!domain || !irq_domain_is_msi_device(domain))
+		return;
+
+	struct xarray *xa = &dev->msi.data->__domains[domid].store;
+	struct msi_domain_info *info = domain->host_data;
+	struct msi_desc *msi_desc;
+	unsigned long idx;
+
+	xa_for_each_range(xa, idx, msi_desc, 0, info->hwsize) {
+		/* Only handle MSI entries which have an interrupt associated */
+		if (!msi_desc_match(msi_desc, MSI_DESC_ASSOCIATED))
+			continue;
+
+		scoped_irqdesc_get_and_lock(msi_desc->irq, 0) {
+			struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
+			struct msi_msg msg = msi_desc->msg;
+
+			if (data->chip)
+				irq_chip_write_msi_msg(data, &msg);
+		}
+	}
+}




